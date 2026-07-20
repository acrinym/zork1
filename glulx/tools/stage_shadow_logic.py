#!/usr/bin/env python3
"""Stage the Release 1213 Shadow Logic layer over Tara's pinned Glulx tree."""

from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path
from typing import Any

from stage_assistance import apply_added_file, remove_destination
from stage_release120 import (
    apply_override,
    apply_patch,
    copy_tracked,
    digest,
    ensure_destination,
    git,
    load_json,
)


def validate_base_manifest(manifest: dict[str, Any], manifest_path: Path) -> dict[str, Any]:
    """Verify exact derivation from the qualified Release 1212 manifest."""
    value = manifest.get("base_manifest")
    if not isinstance(value, str) or not value:
        raise RuntimeError("Shadow Logic manifest must declare base_manifest")
    base_path = (manifest_path.parent / value).resolve()
    base = load_json(base_path)
    if not isinstance(base, dict):
        raise RuntimeError(f"base manifest {base_path} must contain an object")

    expected_release = manifest.get("base_release")
    expected_sha = manifest.get("base_artifact_sha256")
    actual_release = base.get("release")
    artifact = base.get("expected_artifact")
    actual_sha = artifact.get("sha256") if isinstance(artifact, dict) else None
    if actual_release != expected_release:
        raise RuntimeError(
            f"base release drift: expected {expected_release}, got {actual_release}"
        )
    if actual_sha != expected_sha:
        raise RuntimeError(
            f"base artifact drift: expected {expected_sha}, got {actual_sha}"
        )
    return {
        "path": str(base_path),
        "sha256": digest(base_path.read_bytes()),
        "edition": base.get("edition"),
        "release": actual_release,
        "artifact_sha256": actual_sha,
    }


def main() -> int:
    """Stage, patch, verify the layer boundary, and emit a deterministic receipt."""
    parser = argparse.ArgumentParser()
    parser.add_argument("--upstream", type=Path, required=True)
    parser.add_argument("--destination", type=Path, required=True)
    parser.add_argument("--allowed-root", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    args = parser.parse_args()

    upstream = args.upstream.resolve()
    destination = args.destination.resolve()
    manifest_path = args.manifest.resolve()
    ensure_destination(destination, args.allowed_root.resolve())

    manifest = load_json(manifest_path)
    if not isinstance(manifest, dict):
        raise RuntimeError("Shadow Logic patch-series manifest must contain an object")
    base = validate_base_manifest(manifest, manifest_path)

    expected_commit = str(manifest.get("upstream_commit", ""))
    actual_commit = git(upstream, "rev-parse", "HEAD")
    if actual_commit != expected_commit:
        raise RuntimeError(
            f"upstream commit drift: expected {expected_commit}, got {actual_commit}"
        )
    actual_tree = git(upstream, "rev-parse", "HEAD^{tree}")
    expected_tree = str(manifest.get("upstream_tree", ""))
    if not expected_tree or actual_tree != expected_tree:
        raise RuntimeError(
            f"upstream tree drift: expected {expected_tree}, got {actual_tree}"
        )

    remove_destination(destination)
    destination.mkdir(parents=True)

    try:
        tracked = copy_tracked(upstream, destination)
        overrides: list[dict[str, Any]] = []
        for item in manifest.get("overrides") or []:
            if not isinstance(item, dict):
                raise RuntimeError("each Shadow Logic override must be an object")
            if item.get("allow_new") is True:
                overrides.append(apply_added_file(item, manifest_path, destination))
            else:
                overrides.append(apply_override(item, manifest_path, destination))

        patch_paths = [
            (manifest_path.parent / value).resolve()
            for value in manifest.get("patches") or []
        ]
        patches = [apply_patch(path, destination) for path in patch_paths]

        changed = {item["path"] for item in overrides}
        changed.update(item["path"] for item in patches)
        expected_changed = set(manifest.get("expected_changed_paths") or [])
        if changed != expected_changed:
            raise RuntimeError(
                f"changed-path mismatch: expected {sorted(expected_changed)}, got {sorted(changed)}"
            )
    except Exception:
        remove_destination(destination)
        raise

    receipt = {
        "edition": manifest.get("edition"),
        "release": manifest.get("release"),
        "serial": manifest.get("serial"),
        "base": base,
        "upstream_commit": actual_commit,
        "upstream_tree": actual_tree,
        "upstream_tree_pin_enforced": True,
        "tracked_file_count": len(tracked),
        "tracked_files": tracked,
        "overrides": overrides,
        "patches": patches,
        "changed_paths": sorted(changed),
        "test_only": False,
    }
    (destination / "STAGING-RECEIPT.json").write_text(
        json.dumps(receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(
        f"Staged Shadow Logic Release {manifest.get('release')} from base "
        f"Release {base['release']}; changed {len(changed)} reviewed path(s)."
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (RuntimeError, subprocess.CalledProcessError) as exc:
        print(f"stage_shadow_logic: {exc}", file=sys.stderr)
        raise SystemExit(2)
