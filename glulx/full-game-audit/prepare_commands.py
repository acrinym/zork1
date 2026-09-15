#!/usr/bin/env python3
"""Normalize the pinned ZWalker 350/350 route and append the true Zork I ending."""
from __future__ import annotations

import argparse
from pathlib import Path

ENDGAME = ["east", "east", "north", "west", "southwest", "enter barrow"]


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()

    commands = [
        line.strip()
        for line in args.source.read_text(encoding="utf-8").splitlines()
        if line.strip() and not line.lstrip().startswith("#")
    ]
    if len(commands) < 400:
        raise SystemExit(f"walkthrough unexpectedly short: {len(commands)} commands")
    if commands[-1].lower() != "score":
        raise SystemExit(f"walkthrough no longer ends in SCORE: {commands[-1]!r}")

    commands.extend(ENDGAME)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text("\n".join(commands) + "\n", encoding="utf-8")
    print(f"Prepared {len(commands)} commands including Stone Barrow completion.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
