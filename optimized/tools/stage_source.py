#!/usr/bin/env python3
"""Verify, copy, and overlay the historical Zork I source without mutating it."""

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
DEFAULT_BUILD_ROOT = OPTIMIZED_ROOT / "build"


def git_blob_sha(data: bytes) -> str:
    header = f"blob {len(data)}\0".encode("ascii")
    return hashlib.sha1(header + data).hexdigest()


def load_manifest(path: Path) -> dict[str, Any]:
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        raise RuntimeError(f"Cannot read manifest {path}: {exc}") from exc
    if not isinstance(value.get("files"), list):
        raise RuntimeError(f"Manifest {path} has no files list")
    return value


def ensure_safe_destination(destination: Path) -> None:
    build_root = DEFAULT_BUILD_ROOT.resolve()
    resolved = destination.resolve()
    if resolved == build_root or build_root not in resolved.parents:
        raise RuntimeError(
            f"Refusing to stage outside {build_root}; requested {resolved}"
        )


def copy_verified_sources(repo_root: Path, destination: Path, manifest: dict[str, Any]) -> list[dict[str, str]]:
    staged: list[dict[str, str]] = []
    for entry in manifest["files"]:
        relative = Path(entry["path"])
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


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-root", type=Path, required=True)
    parser.add_argument("--destination", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    parser.add_argument("--overrides", type=Path, default=DEFAULT_OVERRIDES)
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
        applied = apply_overrides(args.overrides.resolve(), destination)
    except Exception:
        shutil.rmtree(destination, ignore_errors=True)
        raise

    receipt = {
        "source_commit": manifest.get("source_commit"),
        "source_release": manifest.get("source_release"),
        "source_serial": manifest.get("source_serial"),
        "verified_files": staged,
        "overrides": applied,
    }
    (destination / "STAGING-RECEIPT.json").write_text(
        json.dumps(receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(
        f"Staged {len(staged)} verified historical files and "
        f"applied {len(applied)} override(s) to {destination}"
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except RuntimeError as exc:
        print(f"stage_source: {exc}", file=sys.stderr)
        raise SystemExit(2)
