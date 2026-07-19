#!/usr/bin/env python3
"""Verify a Glulx story header and emit a deterministic JSON receipt."""

from __future__ import annotations

import argparse
import hashlib
import json
import struct
from pathlib import Path


def u32(data: bytes, offset: int) -> int:
    return struct.unpack_from(">I", data, offset)[0]


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("story", type=Path)
    parser.add_argument("--json", dest="json_path", type=Path, required=True)
    parser.add_argument("--expect-sha256")
    args = parser.parse_args()

    data = args.story.read_bytes()
    if len(data) < 36:
        raise SystemExit("story is too short to contain a Glulx header")
    if data[:4] != b"Glul":
        raise SystemExit("invalid Glulx magic; expected ASCII 'Glul'")
    if len(data) % 4:
        raise SystemExit("Glulx file length must be divisible by four")

    version = u32(data, 4)
    ram_start = u32(data, 8)
    ext_start = u32(data, 12)
    end_mem = u32(data, 16)
    stack_size = u32(data, 20)
    start_func = u32(data, 24)
    decoding_table = u32(data, 28)
    stored_checksum = u32(data, 32)

    checksum_input = bytearray(data)
    checksum_input[32:36] = b"\0\0\0\0"
    computed_checksum = sum(
        struct.unpack_from(">I", checksum_input, offset)[0]
        for offset in range(0, len(checksum_input), 4)
    ) & 0xFFFFFFFF

    if stored_checksum != computed_checksum:
        raise SystemExit(
            f"checksum mismatch: stored 0x{stored_checksum:08x}, "
            f"computed 0x{computed_checksum:08x}"
        )
    if not (36 <= ram_start <= ext_start <= end_mem):
        raise SystemExit("invalid Glulx memory-map ordering")
    if ext_start > len(data):
        raise SystemExit("extended-memory start exceeds file length")
    if start_func >= end_mem:
        raise SystemExit("start function lies outside declared memory")

    sha256 = hashlib.sha256(data).hexdigest()
    if args.expect_sha256 and sha256 != args.expect_sha256.lower():
        raise SystemExit(
            f"SHA-256 mismatch: expected {args.expect_sha256.lower()}, got {sha256}"
        )

    report = {
        "file": args.story.name,
        "format": "Glulx",
        "magic": "Glul",
        "version_hex": f"0x{version:08x}",
        "size_bytes": len(data),
        "ram_start": ram_start,
        "ext_start": ext_start,
        "end_mem": end_mem,
        "stack_size": stack_size,
        "start_function": start_func,
        "decoding_table": decoding_table,
        "checksum": stored_checksum,
        "checksum_hex": f"0x{stored_checksum:08x}",
        "checksum_valid": True,
        "sha256": sha256,
    }
    args.json_path.parent.mkdir(parents=True, exist_ok=True)
    args.json_path.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(report, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
