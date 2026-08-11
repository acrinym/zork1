#!/usr/bin/env python3
"""Apply the Release 1247 Narrative Physicality patch series to its declared base."""
from __future__ import annotations

import argparse
import json
import shutil
import sys
from pathlib import Path
from typing import Any

TOOLS = Path(__file__).resolve().parents[1] / "tools"
sys.path.insert(0, str(TOOLS))
from stage_assistance import apply_patch
from stage_release120 import digest, load_json


def inventory(root: Path) -> dict[str, str]:
    """Return content digests for every file below *root*."""
    return {
        p.relative_to(root).as_posix(): digest(p.read_bytes())
        for p in sorted(root.rglob("*"))
        if p.is_file()
    }


def validate_manifest(manifest: dict[str, Any], manifest_path: Path) -> dict[str, Any]:
    """Validate the declared locked base manifest and return it."""
    base_value = manifest.get("base_manifest")
    if not isinstance(base_value, str) or not base_value:
        raise RuntimeError("Release 1247 must declare its Release 1246 base manifest")
    base_path = (manifest_path.parent / base_value).resolve()
    base = load_json(base_path)
    artifact = base.get("expected_artifact") if isinstance(base, dict) else None
    if not isinstance(base, dict) or base.get("release") != manifest.get("base_release"):
        raise RuntimeError("Release 1247 base release drift")
    if not isinstance(artifact, dict) or artifact.get("locked") is not True:
        raise RuntimeError("Release 1247 requires a locked Release 1246 artifact")
    if artifact.get("sha256") != manifest.get("base_artifact_sha256"):
        raise RuntimeError("Release 1247 base artifact drift")
    return base


def validate_base_source(base_source: Path, base_release: Any) -> dict[str, Any]:
    """Validate that *base_source* is a staged tree for the declared base release."""
    receipt = load_json(base_source / "STAGING-RECEIPT.json")
    if not isinstance(receipt, dict) or receipt.get("release") != base_release:
        raise RuntimeError(f"base source is not a staged Release {base_release} tree")
    return receipt


def main() -> int:
    """Stage Release 1247 into a new destination and write its receipt."""
    parser = argparse.ArgumentParser()
    parser.add_argument("--base-source", type=Path, required=True)
    parser.add_argument("--destination", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    args = parser.parse_args()

    base_source = args.base_source.resolve()
    destination = args.destination.resolve()
    manifest_path = args.manifest.resolve()
    if destination.exists():
        raise RuntimeError(f"destination already exists: {destination}")

    manifest = load_json(manifest_path)
    if not isinstance(manifest, dict):
        raise RuntimeError("Release 1247 patch-series must contain an object")
    base_manifest = validate_manifest(manifest, manifest_path)
    base_receipt = validate_base_source(base_source, manifest.get("base_release"))

    base_files = inventory(base_source)
    shutil.copytree(base_source, destination)
    applied = [
        apply_patch((manifest_path.parent / name).resolve(), destination)
        for name in manifest.get("patches") or []
    ]
    final_files = inventory(destination)
    changed = {
        path
        for path in set(base_files) | set(final_files)
        if base_files.get(path) != final_files.get(path)
    }
    expected = set(manifest.get("expected_changed_paths") or [])
    if changed != expected:
        raise RuntimeError(
            f"changed-path mismatch: expected {sorted(expected)}, got {sorted(changed)}"
        )

    receipt = {
        "edition": manifest.get("edition"),
        "release": manifest.get("release"),
        "serial": manifest.get("serial"),
        "base": {
            "release": base_manifest.get("release"),
            "artifact_sha256": (base_manifest.get("expected_artifact") or {}).get("sha256"),
            "staging_receipt_sha256": digest((base_source / "STAGING-RECEIPT.json").read_bytes()),
            "changed_paths": base_receipt.get("changed_paths"),
        },
        "patches": applied,
        "changed_paths": sorted(changed),
        "dev_mode": bool(base_receipt.get("dev_mode")),
        "test_only": bool(base_receipt.get("test_only")),
    }
    (destination / "STAGING-RECEIPT.json").write_text(
        json.dumps(receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    profile = "dev/test" if receipt["dev_mode"] else "production"
    print(
        f"Staged Narrative Physicality Release {manifest.get('release')} ({profile}) "
        f"over Release {base_manifest.get('release')}; changed {len(changed)} path(s)."
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except RuntimeError as exc:
        print(f"stage_narrative_physicality: {exc}", file=sys.stderr)
        raise SystemExit(2) from exc
