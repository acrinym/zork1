#!/usr/bin/env python3
"""Run a small player-facing transcript test through a Z-machine interpreter."""

from __future__ import annotations

import argparse
import shlex
import subprocess
import sys
from pathlib import Path


def useful_lines(path: Path) -> list[str]:
    return [
        line.strip()
        for line in path.read_text(encoding="utf-8").splitlines()
        if line.strip() and not line.lstrip().startswith("#")
    ]


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("story", type=Path)
    parser.add_argument("--interpreter", required=True)
    parser.add_argument("--commands", type=Path, required=True)
    parser.add_argument("--expect", type=Path, required=True)
    parser.add_argument("--timeout", type=int, default=20)
    args = parser.parse_args()

    command = shlex.split(args.interpreter) + [str(args.story)]
    input_text = "\n".join(useful_lines(args.commands)) + "\n"
    try:
        completed = subprocess.run(
            command,
            input=input_text,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            timeout=args.timeout,
            check=False,
        )
    except (OSError, subprocess.TimeoutExpired) as exc:
        print(f"run_smoke: {exc}", file=sys.stderr)
        return 2

    output = completed.stdout
    normalized = output.casefold()
    missing = [item for item in useful_lines(args.expect) if item.casefold() not in normalized]
    print(output)
    if completed.returncode not in (0, 1):
        print(f"ERROR: interpreter exited with {completed.returncode}")
    for item in missing:
        print(f"ERROR: expected output fragment not found: {item}")
    return 1 if missing or completed.returncode not in (0, 1) else 0


if __name__ == "__main__":
    raise SystemExit(main())
