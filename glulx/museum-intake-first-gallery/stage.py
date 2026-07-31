#!/usr/bin/env python3
"""Stage Museum Intake and First Gallery over qualified Release 1232."""

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

from stage_assistance import apply_added_file, remove_destination
from stage_release120 import apply_override, digest, load_json


def inventory(root: Path) -> dict[str, str]:
    """Return deterministic file hashes for a staged source tree."""
    return {
        path.relative_to(root).as_posix(): digest(path.read_bytes())
        for path in sorted(root.rglob("*"))
        if path.is_file()
    }


def validate_base_manifest(
    manifest: dict[str, Any], manifest_path: Path
) -> tuple[Path, dict[str, Any]]:
    """Resolve and validate the exact Release 1232 base contract."""
    value = manifest.get("base_manifest")
    if not isinstance(value, str) or not value:
        raise RuntimeError("museum intake manifest must declare base_manifest")
    base_path = (manifest_path.parent / value).resolve()
    base = load_json(base_path)
    if not isinstance(base, dict):
        raise RuntimeError(f"base manifest {base_path} must contain an object")
    artifact = base.get("expected_artifact")
    actual_sha = artifact.get("sha256") if isinstance(artifact, dict) else None
    if base.get("release") != manifest.get("base_release"):
        raise RuntimeError("museum intake base release drift")
    if actual_sha != manifest.get("base_artifact_sha256"):
        raise RuntimeError("museum intake base artifact drift")
    return base_path, base


def main() -> int:
    """Stage the exact two-path museum delta and write a receipt."""
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
        raise RuntimeError("museum intake patch-series must contain an object")
    base_manifest_path, base_manifest = validate_base_manifest(manifest, manifest_path)

    base_destination = (
        destination.parent / f"base-parser-affordances-src-{uuid.uuid4().hex}"
    )
    for path in (base_destination, destination):
        try:
            path.relative_to(allowed_root)
        except ValueError as exc:
            raise RuntimeError(
                f"unsafe staging destination outside {allowed_root}: {path}"
            ) from exc
        remove_destination(path)

    stage_base = (
        Path(__file__).resolve().parents[1] / "parser-deep-affordances" / "stage.py"
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
        f"Staged Museum Intake Release {manifest.get('release')} over "
        f"Release {base_manifest.get('release')}; changed {len(changed)} path(s)."
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (RuntimeError, subprocess.CalledProcessError) as exc:
        print(f"stage_museum_intake: {exc}", file=sys.stderr)
        raise SystemExit(2) from exc
