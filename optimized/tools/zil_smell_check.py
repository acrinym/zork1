#!/usr/bin/env python3
"""Conservative structural and maintainability checks for historical ZIL."""

from __future__ import annotations

import argparse
import json
import re
import sys
from collections import defaultdict
from pathlib import Path
from typing import Any


DEFINITION_RE = re.compile(
    r"<(ROUTINE|OBJECT|GLOBAL|CONSTANT|DEFINE)\s+([^\s()<>]+)", re.IGNORECASE
)
INCLUDE_RE = re.compile(r'<INSERT-FILE\s+"([^"]+)"', re.IGNORECASE)
MARKER_RE = re.compile(r"\b(TODO|FIXME|XXX|HACK)\b", re.IGNORECASE)
ALLOW_DUPLICATE_DEFINITIONS = {"PERFORM"}


def strip_strings_and_comments(text: str) -> str:
    out: list[str] = []
    in_string = False
    escaped = False
    in_comment = False
    for char in text:
        if in_comment:
            if char == "\n":
                in_comment = False
                out.append(char)
            else:
                out.append(" ")
            continue
        if in_string:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == '"':
                in_string = False
            out.append(" ")
            continue
        if char == ";":
            in_comment = True
            out.append(" ")
        elif char == '"':
            in_string = True
            out.append(" ")
        else:
            out.append(char)
    return "".join(out)


def structural_balance(path: Path, text: str) -> list[str]:
    cleaned = strip_strings_and_comments(text)
    depth = 0
    errors: list[str] = []
    line = 1
    for char in cleaned:
        if char == "\n":
            line += 1
        elif char == "<":
            depth += 1
        elif char == ">":
            depth -= 1
            if depth < 0:
                errors.append(f"{path.name}:{line}: unmatched closing >")
                depth = 0
    if depth:
        errors.append(f"{path.name}: {depth} unterminated ZIL form(s)")
    return errors


def resolve_include(source: Path, include: str) -> Path | None:
    candidates = [source / include, source / f"{include}.zil"]
    for candidate in candidates:
        if candidate.is_file():
            return candidate
    return None


def clock_metadata(files: dict[Path, str]) -> dict[str, Any] | None:
    for path, text in files.items():
        if path.name.lower() != "gclock.zil":
            continue
        table = re.search(r"<CONSTANT\s+C-TABLELEN\s+(\d+)>", text, re.IGNORECASE)
        entry = re.search(r"<CONSTANT\s+C-INTLEN\s+(\d+)>", text, re.IGNORECASE)
        if not table or not entry:
            return None
        table_len = int(table.group(1))
        entry_len = int(entry.group(1))
        return {
            "table_words": table_len,
            "entry_words": entry_len,
            "maximum_interrupt_slots": table_len // entry_len,
            "evenly_divisible": table_len % entry_len == 0,
        }
    return None


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", type=Path, required=True)
    parser.add_argument("--json", type=Path)
    parser.add_argument("--strict", action="store_true")
    args = parser.parse_args()

    source = args.source.resolve()
    paths = sorted(source.glob("*.zil"))
    if not paths:
        print(f"No .zil files found in {source}", file=sys.stderr)
        return 2

    files: dict[Path, str] = {}
    errors: list[str] = []
    warnings: list[str] = []
    definitions: dict[str, list[str]] = defaultdict(list)
    includes: list[dict[str, str]] = []
    metrics = {
        "zil_files": len(paths),
        "lines": 0,
        "tabs": 0,
        "trailing_whitespace_lines": 0,
        "unfinished_markers": 0,
    }

    for path in paths:
        text = path.read_text(encoding="utf-8")
        files[path] = text
        lines = text.splitlines()
        metrics["lines"] += len(lines)
        metrics["tabs"] += text.count("\t")
        metrics["trailing_whitespace_lines"] += sum(
            1 for line in lines if line.rstrip() != line
        )
        markers = list(MARKER_RE.finditer(strip_strings_and_comments(text)))
        metrics["unfinished_markers"] += len(markers)
        for marker in markers:
            warnings.append(f"{path.name}: unfinished marker {marker.group(1)}")
        errors.extend(structural_balance(path, text))
        cleaned = strip_strings_and_comments(text)
        for kind, name in DEFINITION_RE.findall(cleaned):
            definitions[name.upper()].append(f"{path.name}:{kind.upper()}")
        for include in INCLUDE_RE.findall(cleaned):
            resolved = resolve_include(source, include)
            record = {"from": path.name, "include": include}
            if resolved is None:
                errors.append(
                    f'{path.name}: include "{include}" does not resolve case-sensitively'
                )
                record["resolved"] = ""
            else:
                record["resolved"] = resolved.name
            includes.append(record)

    duplicates = {
        name: locations
        for name, locations in definitions.items()
        if len(locations) > 1 and name not in ALLOW_DUPLICATE_DEFINITIONS
    }
    for name, locations in sorted(duplicates.items()):
        warnings.append(f"duplicate definition {name}: {', '.join(locations)}")

    clock = clock_metadata(files)
    if clock and not clock["evenly_divisible"]:
        errors.append("gclock.zil: C-TABLELEN is not divisible by C-INTLEN")

    if args.strict:
        errors.extend(warnings)
        warnings = []

    report = {
        "source": str(source),
        "metrics": metrics,
        "clock": clock,
        "includes": includes,
        "duplicate_definitions": duplicates,
        "errors": errors,
        "warnings": warnings,
    }

    if args.json:
        args.json.parent.mkdir(parents=True, exist_ok=True)
        args.json.write_text(
            json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8"
        )

    print(
        f"Checked {metrics['zil_files']} ZIL files / {metrics['lines']} lines: "
        f"{len(errors)} error(s), {len(warnings)} warning(s)."
    )
    if clock:
        print(
            "Clock table: "
            f"{clock['maximum_interrupt_slots']} slots "
            f"({clock['table_words']} words / {clock['entry_words']} words each)."
        )
    for item in errors:
        print(f"ERROR: {item}")
    for item in warnings:
        print(f"WARN: {item}")
    return 1 if errors else 0


if __name__ == "__main__":
    raise SystemExit(main())
