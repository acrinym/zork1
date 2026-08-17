#!/usr/bin/env python3
"""Apply Release 1265 Consumable Light to locked Release 1264."""
from __future__ import annotations

import argparse
import json
import shutil
import sys
from pathlib import Path
from typing import Any

TOOLS = Path(__file__).resolve().parents[1] / "tools"
sys.path.insert(0, str(TOOLS))

from stage_assistance import apply_patch  # noqa: E402
from stage_release120 import digest, load_json  # noqa: E402


def inventory(root: Path) -> dict[str, str]:
    return {
        p.relative_to(root).as_posix(): digest(p.read_bytes())
        for p in sorted(root.rglob("*"))
        if p.is_file()
    }


def source_identity(root: Path) -> str:
    files = inventory(root)
    files.pop("STAGING-RECEIPT.json", None)
    return digest(
        json.dumps(files, sort_keys=True, separators=(",", ":")).encode("utf-8")
    )


def validate_manifest(
    manifest: dict[str, Any], manifest_path: Path
) -> dict[str, Any]:
    base_value = manifest.get("base_manifest")
    if not isinstance(base_value, str) or not base_value:
        raise RuntimeError(
            "Release 1265 must declare its Release 1264 base manifest"
        )

    base = load_json((manifest_path.parent / base_value).resolve())
    artifact = base.get("expected_artifact") if isinstance(base, dict) else None

    if not isinstance(base, dict) or base.get("release") != manifest.get("base_release"):
        raise RuntimeError("Release 1265 base release drift")
    if not isinstance(artifact, dict) or artifact.get("locked") is not True:
        raise RuntimeError("Release 1265 requires a locked Release 1264 artifact")
    if artifact.get("sha256") != manifest.get("base_artifact_sha256"):
        raise RuntimeError("Release 1265 base artifact drift")

    return base


def validate_base_source(
    base_source: Path, base_release: Any, manifest: dict[str, Any]
) -> dict[str, Any]:
    receipt = load_json(base_source / "STAGING-RECEIPT.json")
    if not isinstance(receipt, dict) or receipt.get("release") != base_release:
        raise RuntimeError(
            f"base source is not a staged Release {base_release} tree"
        )

    profile = "dev" if bool(receipt.get("dev_mode")) else "production"
    pins = manifest.get("base_source_sha256") or {}
    expected = pins.get(profile)
    actual = source_identity(base_source)
    if expected != actual:
        raise RuntimeError(
            f"Release 1264 {profile} source identity drift: "
            f"expected {expected}, got {actual}"
        )

    return receipt


def main() -> int:
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
        raise RuntimeError("Release 1265 patch-series must contain an object")

    base_manifest = validate_manifest(manifest, manifest_path)
    base_receipt = validate_base_source(
        base_source, manifest.get("base_release"), manifest
    )
    base_id = source_identity(base_source)
    base_files = inventory(base_source)
    shutil.copytree(base_source, destination)

    applied = [
        apply_patch((manifest_path.parent / name).resolve(), destination)
        for name in manifest.get("patches") or []
    ]

    for name in manifest.get("added_files") or []:
        rel = Path(name)
        source = (manifest_path.parent / rel).resolve()
        target = (destination / rel).resolve()
        if (
            rel.is_absolute()
            or ".." in rel.parts
            or target.exists()
            or not source.is_file()
        ):
            raise RuntimeError(f"invalid Release 1265 added file: {name}")
        shutil.copy2(source, target)

    final = inventory(destination)
    changed = {
        path
        for path in set(base_files) | set(final)
        if base_files.get(path) != final.get(path)
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
            "artifact_sha256": (base_manifest.get("expected_artifact") or {}).get(
                "sha256"
            ),
            "source_sha256": base_id,
            "staging_receipt_sha256": digest(
                (base_source / "STAGING-RECEIPT.json").read_bytes()
            ),
            "changed_paths": base_receipt.get("changed_paths"),
        },
        "patches": applied,
        "changed_paths": sorted(changed),
        "dev_mode": bool(base_receipt.get("dev_mode")),
        "test_only": bool(base_receipt.get("test_only")),
    }
    (destination / "STAGING-RECEIPT.json").write_text(
        json.dumps(receipt, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )
    print(
        f"Staged Consumable Light Release {manifest.get('release')} over "
        f"Release {base_manifest.get('release')}; changed {len(changed)} path(s)."
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except RuntimeError as exc:
        print(f"stage_consumable_light: {exc}", file=sys.stderr)
        raise SystemExit(2) from exc
