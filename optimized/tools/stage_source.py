#!/usr/bin/env python3
"""Verify, copy, overlay, and narrowly patch historical Zork I source."""

from __future__ import annotations

import argparse
import hashlib
import json
import shutil
import sys
from pathlib import Path
from typing import Any


OPTIMIZED_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_MANIFEST = OPTIMIZED_ROOT / "source-manifest.json"
DEFAULT_OVERRIDES = OPTIMIZED_ROOT / "overrides"
DEFAULT_PATCHES = OPTIMIZED_ROOT / "patches"
DEFAULT_BUILD_ROOT = OPTIMIZED_ROOT / "build"


def git_blob_sha(data: bytes) -> str:
    header = f"blob {len(data)}\0".encode("ascii")
    return hashlib.sha1(header + data).hexdigest()


def load_json(path: Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        raise RuntimeError(f"Cannot read JSON {path}: {exc}") from exc


def load_manifest(path: Path) -> dict[str, Any]:
    value = load_json(path)
    if not isinstance(value, dict) or not isinstance(value.get("files"), list):
        raise RuntimeError(f"Manifest {path} has no files list")
    return value


def ensure_safe_destination(destination: Path) -> None:
    build_root = DEFAULT_BUILD_ROOT.resolve()
    resolved = destination.resolve()
    if resolved == build_root or build_root not in resolved.parents:
        raise RuntimeError(
            f"Refusing to stage outside {build_root}; requested {resolved}"
        )


def safe_relative_path(value: str, context: Path) -> Path:
    relative = Path(value)
    if relative.is_absolute() or ".." in relative.parts:
        raise RuntimeError(f"Unsafe path {value!r} in {context}")
    return relative


def copy_verified_sources(
    repo_root: Path, destination: Path, manifest: dict[str, Any]
) -> list[dict[str, str]]:
    staged: list[dict[str, str]] = []
    for entry in manifest["files"]:
        if not isinstance(entry, dict):
            raise RuntimeError("Manifest file entry must be an object")
        relative = safe_relative_path(str(entry["path"]), Path("source-manifest.json"))
        expected = str(entry["git_blob_sha"]).lower()
        source = repo_root / relative
        if not source.is_file():
            raise RuntimeError(f"Required historical source is missing: {source}")
        data = source.read_bytes()
        actual = git_blob_sha(data)
        if actual != expected:
            raise RuntimeError(
                f"Historical source drift for {relative}: expected {expected}, got {actual}. "
                "Review the root change and intentionally refresh the manifest before proceeding."
            )
        target = destination / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(data)
        shutil.copymode(source, target)
        staged.append({"path": relative.as_posix(), "git_blob_sha": actual})
    return staged


def apply_overrides(overrides: Path, destination: Path) -> list[str]:
    applied: list[str] = []
    if not overrides.exists():
        return applied
    for source in sorted(overrides.rglob("*")):
        if not source.is_file():
            continue
        relative = source.relative_to(overrides)
        target = destination / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, target)
        applied.append(relative.as_posix())
    return applied


def apply_patch_file(spec_path: Path, destination: Path) -> dict[str, Any]:
    spec = load_json(spec_path)
    if not isinstance(spec, dict):
        raise RuntimeError(f"Patch {spec_path} must contain an object")
    relative = safe_relative_path(str(spec.get("path", "")), spec_path)
    target = destination / relative
    if not target.is_file():
        raise RuntimeError(f"Patch {spec_path.name} target is missing: {relative}")
    replacements = spec.get("replacements")
    if not isinstance(replacements, list) or not replacements:
        raise RuntimeError(f"Patch {spec_path.name} has no replacements")

    text = target.read_text(encoding="utf-8")
    applied_replacements: list[dict[str, int]] = []
    for index, replacement in enumerate(replacements, start=1):
        if not isinstance(replacement, dict):
            raise RuntimeError(
                f"Patch {spec_path.name} replacement {index} must be an object"
            )
        old = replacement.get("old")
        new = replacement.get("new")
        expected = replacement.get("expected_count", 1)
        if not isinstance(old, str) or not old:
            raise RuntimeError(
                f"Patch {spec_path.name} replacement {index} has no old text"
            )
        if not isinstance(new, str) or not isinstance(expected, int) or expected < 1:
            raise RuntimeError(
                f"Patch {spec_path.name} replacement {index} is malformed"
            )
        actual = text.count(old)
        if actual != expected:
            raise RuntimeError(
                f"Patch {spec_path.name} replacement {index} expected {expected} "
                f"exact match(es) in {relative}, found {actual}; source drift or overlap detected"
            )
        text = text.replace(old, new, expected)
        applied_replacements.append({"index": index, "matches": actual})

    target.write_text(text, encoding="utf-8")
    return {
        "patch": spec_path.name,
        "id": spec.get("id"),
        "description": spec.get("description"),
        "path": relative.as_posix(),
        "replacements": applied_replacements,
    }


def apply_patches(patches: Path, destination: Path) -> list[dict[str, Any]]:
    applied: list[dict[str, Any]] = []
    if not patches.exists():
        return applied
    for spec_path in sorted(patches.glob("*.json")):
        applied.append(apply_patch_file(spec_path, destination))
    return applied


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-root", type=Path, required=True)
    parser.add_argument("--destination", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    parser.add_argument("--overrides", type=Path, default=DEFAULT_OVERRIDES)
    parser.add_argument("--patches", type=Path, default=DEFAULT_PATCHES)
    args = parser.parse_args()

    repo_root = args.repo_root.resolve()
    destination = args.destination.resolve()
    ensure_safe_destination(destination)
    manifest = load_manifest(args.manifest.resolve())

    if destination.exists():
        shutil.rmtree(destination)
    destination.mkdir(parents=True)

    try:
        staged = copy_verified_sources(repo_root, destination, manifest)
        overrides = apply_overrides(args.overrides.resolve(), destination)
        patches = apply_patches(args.patches.resolve(), destination)
    except Exception:
        shutil.rmtree(destination, ignore_errors=True)
        raise

    receipt = {
        "source_commit": manifest.get("source_commit"),
        "source_release": manifest.get("source_release"),
        "source_serial": manifest.get("source_serial"),
        "verified_files": staged,
        "overrides": overrides,
        "patches": patches,
    }
    (destination / "STAGING-RECEIPT.json").write_text(
        json.dumps(receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(
        f"Staged {len(staged)} verified historical files, applied "
        f"{len(overrides)} override(s), and {len(patches)} exact patch(es) "
        f"to {destination}"
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except RuntimeError as exc:
        print(f"stage_source: {exc}", file=sys.stderr)
        raise SystemExit(2)
