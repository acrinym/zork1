#!/usr/bin/env python3
"""Stage creative natural-play regression repairs over qualified Release 1244."""
from __future__ import annotations
import argparse, json, shutil, subprocess, sys, uuid
from pathlib import Path
from typing import Any
TOOLS = Path(__file__).resolve().parents[1] / "tools"
sys.path.insert(0, str(TOOLS))
from stage_assistance import apply_patch, remove_destination
from stage_release120 import digest, load_json

def inventory(root: Path) -> dict[str, str]:
    return {p.relative_to(root).as_posix(): digest(p.read_bytes()) for p in sorted(root.rglob("*")) if p.is_file()}

def validate_base_manifest(manifest: dict[str, Any], manifest_path: Path) -> tuple[Path, dict[str, Any]]:
    value = manifest.get("base_manifest")
    if not isinstance(value, str) or not value:
        raise RuntimeError("creative natural-play manifest must declare base_manifest")
    base_path = (manifest_path.parent / value).resolve()
    lineage_root = Path(__file__).resolve().parents[1]
    try:
        base_path.relative_to(lineage_root)
    except ValueError as exc:
        raise RuntimeError(f"creative natural-play base manifest escaped Glulx lineage root: {base_path}") from exc
    if not base_path.is_file():
        raise RuntimeError(f"creative natural-play base manifest is missing: {base_path}")
    base = load_json(base_path)
    artifact = base.get("expected_artifact") if isinstance(base, dict) else None
    actual_sha = artifact.get("sha256") if isinstance(artifact, dict) else None
    if base.get("release") != manifest.get("base_release"):
        raise RuntimeError("creative natural-play base release drift")
    if actual_sha != manifest.get("base_artifact_sha256"):
        raise RuntimeError("creative natural-play base artifact drift")
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
        raise RuntimeError("creative natural-play patch-series must contain an object")
    base_manifest_path, base_manifest = validate_base_manifest(manifest, manifest_path)
    base_destination = destination.parent / f"base-creative-natural-play-src-{uuid.uuid4().hex}"
    for path in (base_destination, destination):
        try:
            path.relative_to(allowed_root)
        except ValueError as exc:
            raise RuntimeError(f"unsafe staging destination outside {allowed_root}: {path}") from exc
        remove_destination(path)
    stage_base = Path(__file__).resolve().parents[1] / "mara-house-company" / "stage.py"
    try:
        subprocess.run([
            sys.executable, str(stage_base), "--upstream", str(upstream),
            "--destination", str(base_destination), "--allowed-root", str(allowed_root),
            "--manifest", str(base_manifest_path),
        ], check=True)
        base_files = inventory(base_destination)
        shutil.copytree(base_destination, destination)
        applied = [apply_patch((manifest_path.parent / name).resolve(), destination) for name in manifest.get("patches") or []]
        final_files = inventory(destination)
        changed = {p for p in set(base_files) | set(final_files) if base_files.get(p) != final_files.get(p)}
        expected = set(manifest.get("expected_changed_paths") or [])
        if changed != expected:
            raise RuntimeError(f"changed-path mismatch: expected {sorted(expected)}, got {sorted(changed)}")
        base_artifact = base_manifest.get("expected_artifact") or {}
        receipt = {
            "edition": manifest.get("edition"), "release": manifest.get("release"), "serial": manifest.get("serial"),
            "base": {"release": base_manifest.get("release"), "artifact_sha256": base_artifact.get("sha256"), "manifest_sha256": digest(base_manifest_path.read_bytes())},
            "patches": applied, "changed_paths": sorted(changed),
            "base_file_hashes": base_files, "final_file_hashes": final_files, "test_only": False,
        }
        (destination / "STAGING-RECEIPT.json").write_text(json.dumps(receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    except Exception:
        remove_destination(destination)
        raise
    finally:
        remove_destination(base_destination)
    print(f"Staged Creative Natural Play Release {manifest.get('release')} over Release {base_manifest.get('release')}; changed {len(changed)} path(s).")
    return 0

if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (RuntimeError, subprocess.CalledProcessError) as exc:
        print(f"stage_creative_natural_play: {exc}", file=sys.stderr)
        raise SystemExit(2) from exc
