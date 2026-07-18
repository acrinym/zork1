#!/usr/bin/env python3
"""Validate core Z-machine header invariants, identity, and checksum."""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from typing import Any


def word(data: bytes, offset: int) -> int:
    return int.from_bytes(data[offset : offset + 2], "big")


def declared_length(version: int, encoded: int) -> int:
    if version <= 3:
        return encoded * 2
    if version <= 5:
        return encoded * 4
    return encoded * 8


def inspect(path: Path) -> dict[str, Any]:
    data = path.read_bytes()
    if len(data) < 64:
        raise ValueError(f"{path} is too short to be a Z-machine story file")
    version = data[0]
    encoded_length = word(data, 0x1A)
    length = declared_length(version, encoded_length)
    checksum = word(data, 0x1C)
    checksum_end = min(length or len(data), len(data))
    calculated = sum(data[64:checksum_end]) & 0xFFFF
    return {
        "path": str(path),
        "actual_bytes": len(data),
        "version": version,
        "release": word(data, 0x02),
        "high_memory_base": word(data, 0x04),
        "initial_pc": word(data, 0x06),
        "dictionary_address": word(data, 0x08),
        "object_table_address": word(data, 0x0A),
        "globals_address": word(data, 0x0C),
        "static_memory_base": word(data, 0x0E),
        "serial": data[0x12:0x18].decode("ascii", errors="replace"),
        "declared_bytes": length,
        "stored_checksum": checksum,
        "calculated_checksum": calculated,
        "checksum_valid": checksum == calculated,
    }


def validate(
    info: dict[str, Any],
    expect_version: int | None = None,
    expect_release: int | None = None,
    expect_serial: str | None = None,
) -> list[str]:
    errors: list[str] = []
    size = info["actual_bytes"]
    if expect_version is not None and info["version"] != expect_version:
        errors.append(
            f"expected Z-machine version {expect_version}, got {info['version']}"
        )
    if expect_release is not None and info["release"] != expect_release:
        errors.append(f"expected release {expect_release}, got {info['release']}")
    if expect_serial is not None and info["serial"] != expect_serial:
        errors.append(f"expected serial {expect_serial}, got {info['serial']}")
    if info["declared_bytes"] and info["declared_bytes"] != size:
        errors.append(
            f"header declares {info['declared_bytes']} bytes, file has {size}"
        )
    if not info["checksum_valid"]:
        errors.append(
            f"checksum mismatch: stored {info['stored_checksum']}, "
            f"calculated {info['calculated_checksum']}"
        )
    for key in (
        "high_memory_base",
        "initial_pc",
        "dictionary_address",
        "object_table_address",
        "globals_address",
        "static_memory_base",
    ):
        value = info[key]
        if not 0 < value < size:
            errors.append(f"{key} address {value} is outside the story file")
    if info["static_memory_base"] > info["high_memory_base"]:
        errors.append("static memory begins above high memory")
    return errors


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("story", type=Path)
    parser.add_argument("--expect-version", type=int)
    parser.add_argument("--expect-release", type=int)
    parser.add_argument("--expect-serial")
    parser.add_argument("--baseline", type=Path)
    parser.add_argument("--json", type=Path)
    args = parser.parse_args()

    try:
        story = inspect(args.story)
    except (OSError, ValueError) as exc:
        print(f"verify_story: {exc}", file=sys.stderr)
        return 2
    errors = validate(
        story,
        expect_version=args.expect_version,
        expect_release=args.expect_release,
        expect_serial=args.expect_serial,
    )
    report: dict[str, Any] = {"story": story, "errors": errors}

    if args.baseline and args.baseline.is_file():
        baseline = inspect(args.baseline)
        report["baseline"] = baseline
        report["comparison"] = {
            key: {"optimized": story[key], "baseline": baseline[key]}
            for key in ("version", "release", "serial", "actual_bytes")
        }

    if args.json:
        args.json.parent.mkdir(parents=True, exist_ok=True)
        args.json.write_text(
            json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8"
        )

    print(
        f"{args.story}: Z{story['version']} release {story['release']} "
        f"serial {story['serial']} / {story['actual_bytes']} bytes"
    )
    print(
        f"Checksum: stored={story['stored_checksum']} "
        f"calculated={story['calculated_checksum']}"
    )
    for error in errors:
        print(f"ERROR: {error}")
    return 1 if errors else 0


if __name__ == "__main__":
    raise SystemExit(main())
