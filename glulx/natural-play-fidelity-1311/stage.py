#!/usr/bin/env python3
"""Apply Release 1311 over an exact staged Release 1310 source tree."""
from __future__ import annotations
import argparse, json, shutil, sys
from pathlib import Path
from typing import Any
TOOLS = Path(__file__).resolve().parents[1] / "tools"
sys.path.insert(0, str(TOOLS))
from stage_assistance import apply_patch
from stage_release120 import digest, load_json

def inventory(root: Path) -> dict[str, str]:
    return {p.relative_to(root).as_posix(): digest(p.read_bytes()) for p in sorted(root.rglob("*")) if p.is_file()}

def source_identity(root: Path) -> str:
    files = inventory(root)
    files.pop("STAGING-RECEIPT.json", None)
    return digest(json.dumps(files, sort_keys=True, separators=(",", ":")).encode())

def validate_manifest(manifest: dict[str, Any], manifest_path: Path) -> dict[str, Any]:
    rel = manifest.get("base_manifest")
    if not isinstance(rel, str) or not rel:
        raise RuntimeError("Release 1311 must declare Release 1310 base manifest")
    base = load_json((manifest_path.parent / rel).resolve())
    art = base.get("expected_artifact") if isinstance(base, dict) else None
    if not isinstance(base, dict) or base.get("release") != 1310 or manifest.get("base_release") != 1310:
        raise RuntimeError("Release 1311 base release drift")
    if not isinstance(art, dict) or art.get("locked") is not True:
        raise RuntimeError("Release 1311 requires locked Release 1310 artifact")
    if art.get("sha256") != manifest.get("base_artifact_sha256"):
        raise RuntimeError("Release 1311 base artifact drift")
    return base

def validate_base_source(src: Path, manifest: dict[str, Any]) -> dict[str, Any]:
    receipt = load_json(src / "STAGING-RECEIPT.json")
    if not isinstance(receipt, dict) or receipt.get("release") != 1310:
        raise RuntimeError("base source is not staged Release 1310")
    profile = "dev" if bool(receipt.get("dev_mode")) else "production"
    actual = source_identity(src)
    expected_hashes = manifest.get("base_source_sha256")
    if not isinstance(expected_hashes, dict):
        raise RuntimeError("Release 1311 must declare base source identities")
    expected = expected_hashes.get(profile)
    if not isinstance(expected, str) or not expected:
        raise RuntimeError(f"Release 1311 must declare a {profile} base source identity")
    if actual != expected:
        raise RuntimeError(f"Release 1310 {profile} source identity drift: expected {expected}, got {actual}")
    return receipt

def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--base-source", type=Path, required=True)
    parser.add_argument("--destination", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    args = parser.parse_args()
    base_src = args.base_source.resolve()
    destination = args.destination.resolve()
    manifest_path = args.manifest.resolve()
    if destination.exists():
        raise RuntimeError(f"destination already exists: {destination}")
    manifest = load_json(manifest_path)
    base = validate_manifest(manifest, manifest_path)
    base_receipt = validate_base_source(base_src, manifest)
    base_id = source_identity(base_src)
    before = inventory(base_src)
    try:
        shutil.copytree(base_src, destination)
        applied = [apply_patch((manifest_path.parent / name).resolve(), destination) for name in manifest.get("patches") or []]
        for name in manifest.get("added_files") or []:
            rel = Path(name)
            if rel.is_absolute() or ".." in rel.parts:
                raise RuntimeError(f"invalid Release 1311 added file: {name}")
            source = (manifest_path.parent / rel).resolve()
            target = (destination / rel).resolve()
            try:
                target.relative_to(destination)
            except ValueError as exc:
                raise RuntimeError(f"invalid Release 1311 added file: {name}") from exc
            if target.exists() or not source.is_file():
                raise RuntimeError(f"invalid Release 1311 added file: {name}")
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source, target)
        after = inventory(destination)
        changed = {path for path in set(before) | set(after) if before.get(path) != after.get(path)}
        expected = set(manifest.get("expected_changed_paths") or [])
        if changed != expected:
            raise RuntimeError(f"changed-path mismatch: expected {sorted(expected)}, got {sorted(changed)}")
    except Exception:
        if destination.exists():
            shutil.rmtree(destination)
        raise
    receipt = {
        "edition": manifest.get("edition"),
        "release": 1311,
        "serial": manifest.get("serial"),
        "base": {
            "release": 1310,
            "artifact_sha256": (base.get("expected_artifact") or {}).get("sha256"),
            "source_sha256": base_id,
            "staging_receipt_sha256": digest((base_src / "STAGING-RECEIPT.json").read_bytes()),
            "changed_paths": base_receipt.get("changed_paths"),
        },
        "patches": applied,
        "changed_paths": sorted(changed),
        "dev_mode": bool(base_receipt.get("dev_mode")),
        "test_only": bool(base_receipt.get("test_only")),
    }
    (destination / "STAGING-RECEIPT.json").write_text(json.dumps(receipt, indent=2, sort_keys=True) + "\n")
    print(f"Staged Release 1311 over locked Release 1310; changed {len(changed)} path(s).")
    return 0

if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except RuntimeError as exc:
        print(f"stage_release1311: {exc}", file=sys.stderr)
        raise SystemExit(2) from exc
