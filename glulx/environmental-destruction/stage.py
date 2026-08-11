#!/usr/bin/env python3
"""Apply the Release 1246 patch series to an already-staged Release 1245 tree."""
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
    return {
        p.relative_to(root).as_posix(): digest(p.read_bytes())
        for p in sorted(root.rglob("*"))
        if p.is_file()
    }


def validate_manifest(manifest: dict[str, Any], manifest_path: Path) -> dict[str, Any]:
    base_value = manifest.get("base_manifest")
    if not isinstance(base_value, str) or not base_value:
        raise RuntimeError("Release 1246 must declare its Release 1245 base manifest")
    base_path = (manifest_path.parent / base_value).resolve()
    base = load_json(base_path)
    artifact = base.get("expected_artifact") if isinstance(base, dict) else None
    if not isinstance(base, dict) or base.get("release") != manifest.get("base_release"):
        raise RuntimeError("Release 1246 base release drift")
    if not isinstance(artifact, dict) or artifact.get("locked") is not True:
        raise RuntimeError("Release 1246 requires a locked base artifact")
    if artifact.get("sha256") != manifest.get("base_artifact_sha256"):
        raise RuntimeError("Release 1246 base artifact drift")
    return base


def validate_base_source(base_source: Path) -> dict[str, Any]:
    receipt_path = base_source / "STAGING-RECEIPT.json"
    receipt = load_json(receipt_path)
    if not isinstance(receipt, dict) or receipt.get("release") != 1245:
        raise RuntimeError("base source is not a staged Release 1245 tree")
    return receipt


def enable_dev_profile(destination: Path) -> None:
    target = destination / "material_consequences.zil"
    text = target.read_text(encoding="utf-8")
    old = "<CONSTANT MATERIAL-DESTRUCTION-STATE <TABLE 0 <> <> <> <> <>>>"
    new = "<CONSTANT MATERIAL-DESTRUCTION-STATE <TABLE 0 <> <> <> <> T>>"
    if text.count(old) != 1:
        raise RuntimeError("dev profile could not find its single compact reset-mode switch")
    target.write_text(text.replace(old, new, 1), encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--base-source", type=Path, required=True)
    parser.add_argument("--destination", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--dev", action="store_true")
    args = parser.parse_args()

    base_source = args.base_source.resolve()
    destination = args.destination.resolve()
    manifest_path = args.manifest.resolve()
    if destination.exists():
        raise RuntimeError(f"destination already exists: {destination}")
    manifest = load_json(manifest_path)
    if not isinstance(manifest, dict):
        raise RuntimeError("Release 1246 patch-series must contain an object")
    base_manifest = validate_manifest(manifest, manifest_path)
    base_receipt = validate_base_source(base_source)

    base_files = inventory(base_source)
    shutil.copytree(base_source, destination)
    applied = [
        apply_patch((manifest_path.parent / name).resolve(), destination)
        for name in manifest.get("patches") or []
    ]
    if args.dev:
        enable_dev_profile(destination)
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
            "staging_receipt_sha256": digest(
                (base_source / "STAGING-RECEIPT.json").read_bytes()
            ),
            "changed_paths": base_receipt.get("changed_paths"),
        },
        "patches": applied,
        "changed_paths": sorted(changed),
        "dev_mode": args.dev,
        "test_only": args.dev,
    }
    (destination / "STAGING-RECEIPT.json").write_text(
        json.dumps(receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    profile = "dev/test" if args.dev else "production"
    print(
        f"Staged Environmental Destruction Release {manifest.get('release')} "
        f"({profile}) over Release {base_manifest.get('release')}; "
        f"changed {len(changed)} path(s)."
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except RuntimeError as exc:
        print(f"stage_environmental_destruction: {exc}", file=sys.stderr)
        raise SystemExit(2) from exc
