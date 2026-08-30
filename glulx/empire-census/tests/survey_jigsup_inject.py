#!/usr/bin/env python3
"""Insert test-only --no-reset-on-death handling into JIGS-UP. Never used on production staging."""
from __future__ import annotations
import sys
from pathlib import Path

NEEDLE = '<ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))'
INSERT = """<ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))
	 <COND (<FSET? ,PLAYER ,TRYTAKEBIT>
		<TELL "SURVEY REWIND: you remain " D ,HERE " with the same inventory. Try a different command." CR>
		<RFATAL>)>
"""

def main() -> int:
    path = Path(sys.argv[1])
    text = path.read_text(encoding="utf-8")
    if "SURVEY REWIND:" in text:
        return 0
    if text.count(NEEDLE) != 1:
        print(f"survey_jigsup_inject: expected one JIGS-UP routine, found {text.count(NEEDLE)}", file=sys.stderr)
        return 2
    path.write_text(text.replace(NEEDLE, INSERT.rstrip("\n"), 1), encoding="utf-8")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
