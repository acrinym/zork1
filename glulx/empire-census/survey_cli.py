#!/usr/bin/env python3
"""Qualify-only CLI for --no-killing and --no-reset-on-death. Never baked into production .ulx."""
from __future__ import annotations
import argparse
from pathlib import Path

def verbs_for(no_killing: bool, no_reset: bool) -> list[str]:
    out: list[str] = []
    if no_killing:
        out.append("surveykill")
    if no_reset:
        out.append("surveyrewind")
    return out

def main() -> int:
    p = argparse.ArgumentParser(description="Emit test-story verbs that implement survey flags.")
    p.add_argument("--no-killing", action="store_true")
    p.add_argument("--no-reset-on-death", action="store_true")
    p.add_argument("--write", type=Path)
    args = p.parse_args()
    lines = verbs_for(args.no_killing, args.no_reset_on_death)
    text = "\n".join(lines) + ("\n" if lines else "")
    if args.write:
        args.write.write_text(text, encoding="utf-8")
    else:
        print(text, end="")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
