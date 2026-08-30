#!/usr/bin/env python3
"""Machine-checkable Release 1280 runtime contract."""
from __future__ import annotations
import json, sys
from pathlib import Path

REQUIRED = ("save_restore", "undo", "rng_seed", "utf8_or_latin1_text", "file_io_via_glk", "startup_prints_release_banner")

def main() -> int:
    path = Path(sys.argv[1])
    c = json.loads(path.read_text(encoding="utf-8"))
    if c.get("live_release") != 1280:
        raise SystemExit("contract live_release must be 1280")
    if c.get("ulx_is_ordinary_glulx") is not True:
        raise SystemExit("contract must keep ordinary Glulx")
    if c.get("glulx_version_hex") != "0x00030103":
        raise SystemExit("HOE ships Glulx 3.1.3")
    caps = c.get("required_capabilities") or {}
    for key in REQUIRED:
        if caps.get(key) is not True:
            raise SystemExit(f"required capability missing: {key}")
    for bad in c.get("forbidden") or []:
        if not isinstance(bad, str) or not bad:
            raise SystemExit("forbidden entries must be names")
    pins = c.get("interpreter_pins") or {}
    if len((pins.get("glulxe") or "")) != 40 or len((pins.get("cheapglk") or "")) != 40:
        raise SystemExit("interpreter pins must be full git SHAs")
    story = c.get("base_story") or {}
    if story.get("release") != 1295 or not story.get("sha256"):
        raise SystemExit("contract must pin the locked 1295 story identity")
    print("RELEASE_1280_CONTRACT_OK=" + path.as_posix())
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
