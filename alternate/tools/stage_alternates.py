#!/usr/bin/env python3
"""Stage Release 122 over the complete, independently reproducible Release 121 source."""

from __future__ import annotations

import argparse
import hashlib
import json
import shutil
import sys
from pathlib import Path
from typing import Any

REPO_ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO_ROOT / "optimized" / "tools"))

from stage_source import (  # noqa: E402
    apply_overrides,
    apply_patches,
    copy_verified_sources,
    ensure_safe_destination,
    load_json,
    load_manifest,
)


def remove_path(path: Path) -> None:
    """Remove a file, symlink, or directory tree when it exists."""
    if not path.exists() and not path.is_symlink():
        return
    if path.is_dir() and not path.is_symlink():
        shutil.rmtree(path)
    else:
        path.unlink()


def sha256(path: Path) -> str:
    """Return the hexadecimal SHA-256 digest of one file."""
    return hashlib.sha256(path.read_bytes()).hexdigest()


def inventory(root: Path) -> dict[str, str]:
    """Map every staged file path to its SHA-256 digest."""
    return {
        path.relative_to(root).as_posix(): sha256(path)
        for path in sorted(root.rglob("*"))
        if path.is_file()
    }


def main() -> int:
    """Stage and verify the exact Release 122 source boundary."""
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-root", type=Path, required=True)
    parser.add_argument("--destination", type=Path, required=True)
    parser.add_argument("--allowed-root", type=Path, required=True)
    parser.add_argument("--layer", type=Path, required=True)
    args = parser.parse_args()

    repo_root = args.repo_root.resolve()
    destination = args.destination.resolve()
    allowed_root = args.allowed_root.resolve()
    base_destination = destination.parent / "base-release121-src"
    ensure_safe_destination(destination, allowed_root)
    ensure_safe_destination(base_destination, allowed_root)

    layer = load_json(args.layer.resolve())
    if not isinstance(layer, dict):
        raise RuntimeError("Release 122 layer manifest must contain an object")
    expected_changed = set(layer.get("expected_changed_paths") or [])
    if not expected_changed:
        raise RuntimeError("Release 122 layer manifest has no expected_changed_paths")

    manifest = load_manifest(repo_root / "optimized" / "source-manifest.json")
    remove_path(base_destination)
    remove_path(destination)
    base_destination.mkdir(parents=True)

    try:
        verified = copy_verified_sources(repo_root, base_destination, manifest)
        base_overrides = apply_overrides(repo_root / "expanded" / "overrides", base_destination)
        base_patches = apply_patches(repo_root / "expanded" / "patches", base_destination)
        base_files = inventory(base_destination)

        shutil.copytree(base_destination, destination)
        layer_overrides = apply_overrides(repo_root / "alternate" / "overrides", destination)
        layer_patches = apply_patches(repo_root / "alternate" / "patches", destination)
        final_files = inventory(destination)

        changed = {
            path
            for path in set(base_files) | set(final_files)
            if base_files.get(path) != final_files.get(path)
        }
        if changed != expected_changed:
            raise RuntimeError(
                f"Release 122 changed-path mismatch: expected {sorted(expected_changed)}, "
                f"got {sorted(changed)}"
            )
    except Exception:
        remove_path(base_destination)
        remove_path(destination)
        raise

    receipt: dict[str, Any] = {
        "edition": layer.get("edition"),
        "release": layer.get("release"),
        "serial": layer.get("serial"),
        "base_edition": layer.get("base_edition"),
        "base_release": layer.get("base_release"),
        "base_serial": layer.get("base_serial"),
        "verified_historical_files": verified,
        "base_overrides": base_overrides,
        "base_patches": base_patches,
        "base_file_hashes": base_files,
        "layer_overrides": layer_overrides,
        "layer_patches": layer_patches,
        "changed_paths": sorted(changed),
        "final_file_hashes": final_files,
        "excluded_scope": layer.get("excluded_scope") or [],
    }
    (destination / "STAGING-RECEIPT.json").write_text(
        json.dumps(receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(
        f"Staged Release {layer.get('release')} over Release {layer.get('base_release')}; "
        f"changed exactly {len(changed)} reviewed path(s)."
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except RuntimeError as exc:
        print(f"stage_alternates: {exc}", file=sys.stderr)
        raise SystemExit(2) from exc
