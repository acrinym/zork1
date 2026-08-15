#!/usr/bin/env python3
"""Apply Release 1261 Mara Anticipation, Worry & Protective Initiative to locked Release 1260."""
from __future__ import annotations

import argparse
import json
import re
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


def source_identity(root: Path) -> str:
    files = inventory(root)
    files.pop("STAGING-RECEIPT.json", None)
    return digest(json.dumps(files, sort_keys=True, separators=(",", ":")).encode("utf-8"))


def validate_manifest(manifest: dict[str, Any], manifest_path: Path) -> dict[str, Any]:
    base_value = manifest.get("base_manifest")
    if not isinstance(base_value, str) or not base_value:
        raise RuntimeError("Release 1261 must declare its Release 1260 base manifest")
    base = load_json((manifest_path.parent / base_value).resolve())
    artifact = base.get("expected_artifact") if isinstance(base, dict) else None
    if not isinstance(base, dict) or base.get("release") != manifest.get("base_release"):
        raise RuntimeError("Release 1261 base release drift")
    if not isinstance(artifact, dict) or artifact.get("locked") is not True:
        raise RuntimeError("Release 1261 requires a locked Release 1260 artifact")
    if artifact.get("sha256") != manifest.get("base_artifact_sha256"):
        raise RuntimeError("Release 1261 base artifact drift")
    return base


def validate_base_source(base_source: Path, base_release: Any, manifest: dict[str, Any]) -> dict[str, Any]:
    receipt = load_json(base_source / "STAGING-RECEIPT.json")
    if not isinstance(receipt, dict) or receipt.get("release") != base_release:
        raise RuntimeError(f"base source is not a staged Release {base_release} tree")
    profile = "dev" if bool(receipt.get("dev_mode")) else "production"
    pins = manifest.get("base_source_sha256")
    if isinstance(pins, dict) and pins:
        expected = pins.get(profile)
        actual = source_identity(base_source)
        if not isinstance(expected, str) or not expected:
            raise RuntimeError(f"Release 1261 has no pinned Release 1260 {profile} source identity")
        if actual != expected:
            raise RuntimeError(
                f"Release 1260 {profile} source identity drift: expected {expected}, got {actual}"
            )
    return receipt


def validate_state_capacity(destination: Path) -> None:
    """Prove every declared Release 1261 Mara state slot is addressable."""
    companion = (destination / "mara_companion.zil").read_text(encoding="utf-8")
    slot_match = re.search(r"<CONSTANT MARA-SLOT-PROTECTIVE-PREPARATION\s+(\d+)>", companion)
    table_match = re.search(r"<CONSTANT MARA-STATE\s+<TABLE\s+([^>]+)>>", companion)
    if slot_match is None or table_match is None:
        raise RuntimeError("Release 1261 could not prove Mara state table capacity")
    highest_slot = int(slot_match.group(1))
    entries = table_match.group(1).split()
    if len(entries) <= highest_slot:
        raise RuntimeError(
            "Release 1261 Mara state table is undersized: "
            f"highest slot is {highest_slot}, but table has only {len(entries)} entries"
        )
    print(
        f"Validated Mara state capacity: {len(entries)} entries cover slots 0..{highest_slot}."
    )


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
        raise RuntimeError("Release 1261 patch-series must contain an object")

    base_manifest = validate_manifest(manifest, manifest_path)
    base_receipt = validate_base_source(base_source, manifest.get("base_release"), manifest)
    base_source_sha256 = source_identity(base_source)
    base_files = inventory(base_source)
    shutil.copytree(base_source, destination)

    applied = [
        apply_patch((manifest_path.parent / name).resolve(), destination)
        for name in manifest.get("patches") or []
    ]

    for name in manifest.get("added_files") or []:
        relative = Path(name)
        if relative.is_absolute() or ".." in relative.parts:
            raise RuntimeError(f"invalid Release 1261 added file path: {name}")
        source_file = (manifest_path.parent / relative).resolve()
        target = (destination / relative).resolve()
        try:
            source_file.relative_to(manifest_path.parent)
            target.relative_to(destination)
        except ValueError as exc:
            raise RuntimeError(f"Release 1261 added file escaped staging roots: {name}") from exc
        if target.exists():
            raise RuntimeError(f"Release 1261 added file already exists in base: {name}")
        if not source_file.is_file():
            raise RuntimeError(f"Release 1261 added file missing: {source_file}")
        shutil.copy2(source_file, target)

    validate_state_capacity(destination)

    final_files = inventory(destination)
    changed = {
        path
        for path in set(base_files) | set(final_files)
        if base_files.get(path) != final_files.get(path)
    }
    expected = set(manifest.get("expected_changed_paths") or [])
    if changed != expected:
        raise RuntimeError(f"changed-path mismatch: expected {sorted(expected)}, got {sorted(changed)}")

    receipt = {
        "edition": manifest.get("edition"),
        "release": manifest.get("release"),
        "serial": manifest.get("serial"),
        "base": {
            "release": base_manifest.get("release"),
            "artifact_sha256": (base_manifest.get("expected_artifact") or {}).get("sha256"),
            "source_sha256": base_source_sha256,
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
        f"Staged Mara Anticipation Release {manifest.get('release')} ({profile}) "
        f"over Release {base_manifest.get('release')}; changed {len(changed)} path(s)."
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except RuntimeError as exc:
        print(f"stage_mara_anticipation: {exc}", file=sys.stderr)
        raise SystemExit(2) from exc
