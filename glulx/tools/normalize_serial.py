#!/usr/bin/env python3
"""Normalize exactly one generated Glazer metadata serial and write a receipt."""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path


def main() -> int:
    """Replace one six-digit generated serial without touching ZIL source."""
    parser = argparse.ArgumentParser()
    parser.add_argument("assembly", type=Path)
    parser.add_argument("--serial", required=True)
    parser.add_argument(
        "--receipt",
        type=Path,
        help=(
            "receipt path; defaults deterministically beside the assembly as "
            "<assembly>.serial-normalization.json"
        ),
    )
    args = parser.parse_args()

    if not re.fullmatch(r"[0-9]{6}", args.serial):
        raise SystemExit("serial must contain exactly six digits")
    text = args.assembly.read_text(encoding="utf-8")
    pattern = re.compile(r'(metadata_serial:\s*\n\s*db\s+")([0-9]{6})(")')
    match = pattern.search(text)
    if match is None:
        raise SystemExit("generated Glulx metadata serial was not found")
    before = match.group(2)
    text, count = pattern.subn(rf"\g<1>{args.serial}\g<3>", text)
    if count != 1:
        raise SystemExit(f"expected one metadata serial replacement, got {count}")
    args.assembly.write_text(text, encoding="utf-8")
    receipt = {
        "generated_serial_before": before,
        "generated_serial_after": args.serial,
        "replacement_count": count,
        "source_modified": False,
        "generated_assembly_modified": True,
    }
    receipt_path = args.receipt or args.assembly.with_name(
        args.assembly.name + ".serial-normalization.json"
    )
    receipt_path.parent.mkdir(parents=True, exist_ok=True)
    receipt_path.write_text(json.dumps(receipt, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(receipt, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
