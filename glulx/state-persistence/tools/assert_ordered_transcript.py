#!/usr/bin/env python3
"""Assert ordered markers in a save/restore transcript."""

from __future__ import annotations

import argparse
from pathlib import Path


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("transcript", type=Path)
    parser.add_argument("expectations", type=Path)
    args = parser.parse_args()

    text = args.transcript.read_text(encoding="utf-8", errors="replace")
    if "Failed." in text:
        raise SystemExit(f"save/restore failure reported in {args.transcript}")

    markers = [
        line.strip()
        for line in args.expectations.read_text(encoding="utf-8").splitlines()
        if line.strip() and not line.lstrip().startswith("#")
    ]
    cursor = 0
    for marker in markers:
        found = text.find(marker, cursor)
        if found < 0:
            raise SystemExit(
                f"missing ordered marker after byte {cursor}: {marker!r}\n"
                f"transcript: {args.transcript}"
            )
        cursor = found + len(marker)

    print(f"{args.transcript}: {len(markers)} ordered markers passed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
