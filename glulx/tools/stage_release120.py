#!/usr/bin/env python3
"""Stage Tara's pinned Glulx source and apply a reviewable exact patch series."""

from __future__ import annotations

import argparse
import hashlib
import json
import shutil
import subprocess
from pathlib import Path
from typing import Any


def digest(data: bytes) -> str:
    """Return a lowercase SHA-256 digest."""
    return hashlib.sha256(data).hexdigest()


def load_json(path: Path) -> Any:
    """Load JSON while attaching the failing path to errors."""
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        raise RuntimeError(f"cannot read JSON {path}: {exc}") from exc


def safe_relative(value: str, context: Path) -> Path:
    """Reject absolute paths and parent traversal in manifests."""
    relative = Path(value)
    if relative.is_absolute() or ".." in relative.parts or not relative.parts:
        raise RuntimeError(f"unsafe path {value!r} in {context}")
    return relative


def git(upstream: Path, *args: str) -> str:
    """Run a read-only Git command against the pinned upstream checkout."""
    result = subprocess.run(
        ["git", "-C", str(upstream), *args],
        check=True,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    return result.stdout.strip()


def ensure_destination(destination: Path, allowed_root: Path) -> None:
    """Restrict destructive staging to the selected build root."""
    resolved = destination.resolve()
    allowed = allowed_root.resolve()
    if resolved == allowed or allowed not in resolved.parents:
        raise RuntimeError(f"refusing to stage outside {allowed}: {resolved}")


def copy_tracked(upstream: Path, destination: Path) -> list[dict[str, Any]]:
    """Copy every tracked upstream file and record its immutable contents."""
    output = subprocess.run(
        ["git", "-C", str(upstream), "ls-files", "-z"],
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    ).stdout
    records: list[dict[str, Any]] = []
    for raw in output.split(b"\0"):
        if not raw:
            continue
        relative = safe_relative(raw.decode("utf-8"), upstream)
        source = upstream / relative
        if not source.is_file():
            raise RuntimeError(f"tracked source is missing: {relative}")
        data = source.read_bytes()
        target = destination / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(data)
        shutil.copymode(source, target)
        records.append(
            {
                "path": relative.as_posix(),
                "size_bytes": len(data),
                "sha256": digest(data),
            }
        )
    return records


def apply_override(spec: dict[str, Any], manifest_path: Path, destination: Path) -> dict[str, Any]:
    """Replace one staged file with a repository-owned reviewed overlay."""
    relative = safe_relative(str(spec.get("path", "")), manifest_path)
    source_path = (manifest_path.parent / str(spec.get("source", ""))).resolve()
    if not source_path.is_file():
        raise RuntimeError(f"override source is missing: {source_path}")
    target = destination / relative
    if not target.is_file():
        raise RuntimeError(f"override target is missing: {relative}")
    before = target.read_bytes()
    after = source_path.read_bytes()
    target.write_bytes(after)
    return {
        "path": relative.as_posix(),
        "source": str(source_path),
        "source_sha256": digest(after),
        "before_sha256": digest(before),
        "after_sha256": digest(after),
        "description": spec.get("description"),
    }


def apply_patch(path: Path, destination: Path) -> dict[str, Any]:
    """Apply one exact-count textual patch and record target hashes."""
    spec = load_json(path)
    if not isinstance(spec, dict):
        raise RuntimeError(f"patch {path} must contain an object")
    relative = safe_relative(str(spec.get("path", "")), path)
    target = destination / relative
    if not target.is_file():
        raise RuntimeError(f"patch target is missing: {relative}")
    replacements = spec.get("replacements")
    if not isinstance(replacements, list) or not replacements:
        raise RuntimeError(f"patch {path} has no replacements")

    before_bytes = target.read_bytes()
    text = before_bytes.decode("utf-8")
    applied: list[dict[str, int]] = []
    for index, replacement in enumerate(replacements, 1):
        if not isinstance(replacement, dict):
            raise RuntimeError(f"patch {path} replacement {index} is not an object")
        old = replacement.get("old")
        new = replacement.get("new")
        expected = replacement.get("expected_count", 1)
        if not isinstance(old, str) or not old:
            raise RuntimeError(f"patch {path} replacement {index} has no old text")
        if not isinstance(new, str) or not isinstance(expected, int) or expected < 1:
            raise RuntimeError(f"patch {path} replacement {index} is malformed")
        actual = text.count(old)
        if actual != expected:
            raise RuntimeError(
                f"patch {path.name} replacement {index} expected {expected} exact "
                f"match(es) in {relative}, found {actual}"
            )
        text = text.replace(old, new, expected)
        applied.append({"index": index, "matches": actual})

    after_bytes = text.encode("utf-8")
    target.write_bytes(after_bytes)
    return {
        "patch": str(path),
        "patch_sha256": digest(path.read_bytes()),
        "id": spec.get("id"),
        "description": spec.get("description"),
        "path": relative.as_posix(),
        "before_sha256": digest(before_bytes),
        "after_sha256": digest(after_bytes),
        "replacements": applied,
    }


def main() -> int:
    """Stage, patch, verify changed paths, and write a deterministic receipt."""
    parser = argparse.ArgumentParser()
    parser.add_argument("--upstream", type=Path, required=True)
    parser.add_argument("--destination", type=Path, required=True)
    parser.add_argument("--allowed-root", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--extra-patch", type=Path, action="append", default=[])
    args = parser.parse_args()

    upstream = args.upstream.resolve()
    destination = args.destination.resolve()
    manifest_path = args.manifest.resolve()
    ensure_destination(destination, args.allowed_root.resolve())

    manifest = load_json(manifest_path)
    if not isinstance(manifest, dict):
        raise RuntimeError("patch-series manifest must contain an object")
    expected_commit = str(manifest.get("upstream_commit", ""))
    actual_commit = git(upstream, "rev-parse", "HEAD")
    if actual_commit != expected_commit:
        raise RuntimeError(
            f"upstream commit drift: expected {expected_commit}, got {actual_commit}"
        )
    tree = git(upstream, "rev-parse", "HEAD^{tree}")
    expected_tree = str(manifest.get("upstream_tree", ""))
    if expected_tree and tree != expected_tree:
        raise RuntimeError(
            f"upstream tree drift: expected {expected_tree}, got {tree}"
        )

    if destination.exists():
        shutil.rmtree(destination)
    destination.mkdir(parents=True)

    try:
        tracked = copy_tracked(upstream, destination)
        overrides = [
            apply_override(item, manifest_path, destination)
            for item in manifest.get("overrides", [])
        ]
        patch_paths = [
            (manifest_path.parent / value).resolve()
            for value in manifest.get("patches", [])
        ] + [path.resolve() for path in args.extra_patch]
        patches = [apply_patch(path, destination) for path in patch_paths]

        changed = {item["path"] for item in overrides}
        changed.update(item["path"] for item in patches)
        expected_changed = set(manifest.get("expected_changed_paths", []))
        if args.extra_patch:
            expected_changed.update(
                str(load_json(path.resolve()).get("path", "")) for path in args.extra_patch
            )
        if changed != expected_changed:
            raise RuntimeError(
                f"changed-path mismatch: expected {sorted(expected_changed)}, got {sorted(changed)}"
            )
    except Exception:
        shutil.rmtree(destination, ignore_errors=True)
        raise

    receipt = {
        "edition": manifest.get("edition"),
        "release": manifest.get("release"),
        "serial": manifest.get("serial"),
        "upstream_commit": actual_commit,
        "upstream_tree": tree,
        "upstream_tree_pin_enforced": bool(expected_tree),
        "tracked_file_count": len(tracked),
        "tracked_files": tracked,
        "overrides": overrides,
        "patches": patches,
        "changed_paths": sorted(changed),
        "test_only": bool(args.extra_patch),
    }
    (destination / "STAGING-RECEIPT.json").write_text(
        json.dumps(receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(
        f"Staged {len(tracked)} tracked files from {actual_commit}; "
        f"changed {len(changed)} reviewed path(s)."
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (RuntimeError, subprocess.CalledProcessError) as exc:
        print(f"stage_release120: {exc}")
        raise SystemExit(2)
