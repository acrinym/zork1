#!/usr/bin/env python3
"""Stage museum troll provenance over qualified Release 1240."""

from __future__ import annotations

import argparse
import json
import shutil
import subprocess
import sys
import uuid
from pathlib import Path
from typing import Any

TOOLS = Path(__file__).resolve().parents[1] / "tools"
sys.path.insert(0, str(TOOLS))

from stage_assistance import apply_added_file, apply_patch, remove_destination
from stage_release120 import apply_override, digest, load_json


def inventory(root: Path) -> dict[str, str]:
    """Return deterministic hashes for every staged file."""
    return {
        path.relative_to(root).as_posix(): digest(path.read_bytes())
        for path in sorted(root.rglob("*"))
        if path.is_file()
    }


def validate_base_manifest(
    manifest: dict[str, Any], manifest_path: Path
) -> tuple[Path, dict[str, Any]]:
    """Resolve and verify the locked Release 1240 base."""
    value = manifest.get("base_manifest")
    if not isinstance(value, str) or not value:
        raise RuntimeError("troll provenance manifest must declare base_manifest")
    base_path = (manifest_path.parent / value).resolve()
    lineage_root = Path(__file__).resolve().parents[1]
    try:
        base_path.relative_to(lineage_root)
    except ValueError as exc:
        raise RuntimeError(
            f"troll provenance base manifest escaped Glulx lineage root: {base_path}"
        ) from exc
    if not base_path.is_file():
        raise RuntimeError(f"troll provenance base manifest is missing: {base_path}")
    base = load_json(base_path)
    if not isinstance(base, dict):
        raise RuntimeError(f"base manifest {base_path} must contain an object")
    artifact = base.get("expected_artifact")
    actual_sha = artifact.get("sha256") if isinstance(artifact, dict) else None
    if base.get("release") != manifest.get("base_release"):
        raise RuntimeError("troll provenance base release drift")
    if actual_sha != manifest.get("base_artifact_sha256"):
        raise RuntimeError("troll provenance base artifact drift")
    return base_path, base


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--upstream", type=Path, required=True)
    parser.add_argument("--destination", type=Path, required=True)
    parser.add_argument("--allowed-root", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    args = parser.parse_args()

    upstream = args.upstream.resolve()
    destination = args.destination.resolve()
    allowed_root = args.allowed_root.resolve()
    manifest_path = args.manifest.resolve()
    manifest = load_json(manifest_path)
    if not isinstance(manifest, dict):
        raise RuntimeError("troll provenance patch-series must contain an object")
    base_manifest_path, base_manifest = validate_base_manifest(manifest, manifest_path)

    base_destination = destination.parent / f"base-museum-songbird-src-{uuid.uuid4().hex}"
    for path in (base_destination, destination):
        try:
            path.relative_to(allowed_root)
        except ValueError as exc:
            raise RuntimeError(
                f"unsafe staging destination outside {allowed_root}: {path}"
            ) from exc
        remove_destination(path)

    stage_base = (
        Path(__file__).resolve().parents[1]
        / "museum-songbird-correspondence"
        / "stage.py"
    )
    try:
        subprocess.run(
            [
                sys.executable,
                str(stage_base),
                "--upstream",
                str(upstream),
                "--destination",
                str(base_destination),
                "--allowed-root",
                str(allowed_root),
                "--manifest",
                str(base_manifest_path),
            ],
            check=True,
        )
        base_files = inventory(base_destination)
        shutil.copytree(base_destination, destination)

        overrides: list[dict[str, Any]] = []
        for item in manifest.get("overrides") or []:
            if item.get("allow_new") is True:
                overrides.append(apply_added_file(item, manifest_path, destination))
            else:
                overrides.append(apply_override(item, manifest_path, destination))

        patches: list[dict[str, Any]] = []
        for patch_name in manifest.get("patches") or []:
            patch_path = (manifest_path.parent / patch_name).resolve()
            patches.append(apply_patch(patch_path, destination))

        final_files = inventory(destination)
        changed = {
            path
            for path in set(base_files) | set(final_files)
            if base_files.get(path) != final_files.get(path)
        }
        expected_changed = set(manifest.get("expected_changed_paths") or [])
        if changed != expected_changed:
            raise RuntimeError(
                f"changed-path mismatch: expected {sorted(expected_changed)}, got {sorted(changed)}"
            )

        base_artifact = base_manifest.get("expected_artifact") or {}
        receipt = {
            "edition": manifest.get("edition"),
            "release": manifest.get("release"),
            "serial": manifest.get("serial"),
            "base": {
                "release": base_manifest.get("release"),
                "artifact_sha256": base_artifact.get("sha256"),
                "manifest_sha256": digest(base_manifest_path.read_bytes()),
            },
            "overrides": overrides,
            "patches": patches,
            "changed_paths": sorted(changed),
            "base_file_hashes": base_files,
            "final_file_hashes": final_files,
            "test_only": False,
        }
        (destination / "STAGING-RECEIPT.json").write_text(
            json.dumps(receipt, indent=2, sort_keys=True) + "\n",
            encoding="utf-8",
        )
    except Exception:
        remove_destination(destination)
        raise
    finally:
        remove_destination(base_destination)

    print(
        f"Staged Museum Troll Provenance Release {manifest.get('release')} over "
        f"Release {base_manifest.get('release')}; changed {len(changed)} path(s)."
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (RuntimeError, subprocess.CalledProcessError) as exc:
        print(f"stage_museum_troll_provenance: {exc}", file=sys.stderr)
        raise SystemExit(2) from exc
