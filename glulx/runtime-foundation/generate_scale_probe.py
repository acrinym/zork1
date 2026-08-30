#!/usr/bin/env python3
"""Emit a test-only Glulx probe with many ordinary globals and rooms (Releases 1281/1284)."""
from __future__ import annotations
import argparse
from pathlib import Path

def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("--globals", type=int, default=320)
    p.add_argument("--rooms", type=int, default=96)
    p.add_argument("--out", type=Path, required=True)
    args = p.parse_args()
    lines = [
        '"HOE SCALE PROBE — test-only, never production"',
        "",
        "<SYNTAX SCALEPROBE = V-SCALE-PROBE>",
        "",
    ]
    for i in range(args.globals):
        lines.append(f"<GLOBAL SCALEG{i} 0>")
    lines.append("")
    for i in range(args.rooms):
        nxt = (i + 1) % args.rooms
        lines.append(f"<ROOM SCALERM{i}")
        lines.append("    (IN ROOMS)")
        lines.append(f"    (DESC \"scale hall {i}\")")
        lines.append("    (LDESC \"A numbered survey hall used only to prove compiler and parser headroom.\")")
        lines.append("    (FLAGS RLANDBIT ONBIT)")
        lines.append(f"    (EAST TO SCALERM{nxt})>")
        lines.append("")
    last = args.globals - 1
    lines.append("<ROUTINE V-SCALE-PROBE ()")
    lines.append("    <SETG SCALEG0 <+ ,SCALEG0 1>>")
    lines.append(f"    <SETG SCALEG{last} <+ ,SCALEG{last} 1>>")
    lines.append(
        f"    <TELL \"SCALE PROBE: globals {args.globals}, rooms {args.rooms}, g0=\" N ,SCALEG0 \" last=\" N ,SCALEG{last} CR>"
    )
    lines.append("    <RTRUE>>")
    lines.append("")
    args.out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"Wrote {args.out} ({args.globals} globals, {args.rooms} rooms)")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
