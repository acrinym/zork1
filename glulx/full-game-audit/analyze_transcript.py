#!/usr/bin/env python3
"""Audit a complete Zork I playthrough transcript for regressions and oddities.

The auditor is deliberately conservative: only hard runtime failures or failure to
reach the known 350-point ending are blocking. Parser/state anomalies are recorded
as findings so the GitHub runner can keep playing and leave evidence instead of
stopping at the first suspicious line.
"""
from __future__ import annotations

import argparse
import json
import re
from pathlib import Path

HARD_PATTERNS = {
    "runtime_fatal": re.compile(r"(?:fatal error|runtime error|segmentation fault|assertion failed|traceback)", re.I),
    "interpreter_abort": re.compile(r"(?:glulx.*fatal|glulxe.*error|stack overflow|memory access violation)", re.I),
}

PARSER_PATTERNS = {
    "no_verb": re.compile(r"There was no verb in that sentence!", re.I),
    "unknown_word": re.compile(r"I don't know the word", re.I),
    "beg_pardon": re.compile(r"I beg your pardon", re.I),
    "cant_parse": re.compile(r"(?:I don't understand|I couldn't understand|What do you want to)", re.I),
}

STATE_PATTERNS = {
    "not_visible": re.compile(r"(?:You can't see any|You can't see the|You don't see any)", re.I),
    "not_holding": re.compile(r"(?:You aren't carrying|You don't have|You are not carrying)", re.I),
    "blocked_route": re.compile(r"(?:You can't go that way|You can't go in that direction)", re.I),
    "already_state": re.compile(r"(?:already open|already closed|already have|already holding)", re.I),
}

END_MARKERS = [
    re.compile(r"Your score is\s+350\s*\(total of 350 points\)", re.I),
    re.compile(r"Master Adventurer", re.I),
    re.compile(r"Inside the Barrow", re.I),
    re.compile(r"You have mastered", re.I),
]


def nearby(lines: list[str], index: int, radius: int = 2) -> str:
    lo = max(0, index - radius)
    hi = min(len(lines), index + radius + 1)
    return "\n".join(f"{n + 1}: {lines[n]}" for n in range(lo, hi))


def collect(lines: list[str], patterns: dict[str, re.Pattern[str]], severity: str) -> list[dict[str, object]]:
    findings: list[dict[str, object]] = []
    for idx, line in enumerate(lines):
        for code, pattern in patterns.items():
            if pattern.search(line):
                findings.append(
                    {
                        "severity": severity,
                        "code": code,
                        "line": idx + 1,
                        "text": line,
                        "context": nearby(lines, idx),
                    }
                )
    return findings


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--transcript", type=Path, required=True)
    parser.add_argument("--commands", type=Path, required=True)
    parser.add_argument("--seed", type=int, required=True)
    parser.add_argument("--interpreter-exit", type=int, default=0)
    parser.add_argument("--json", type=Path, required=True)
    parser.add_argument("--markdown", type=Path, required=True)
    parser.add_argument("--golden-seed", type=int, default=3)
    args = parser.parse_args()

    text = args.transcript.read_text(encoding="utf-8", errors="replace")
    lines = text.splitlines()
    commands = [
        line.strip()
        for line in args.commands.read_text(encoding="utf-8").splitlines()
        if line.strip() and not line.lstrip().startswith("#")
    ]

    findings: list[dict[str, object]] = []
    findings.extend(collect(lines, HARD_PATTERNS, "critical"))
    findings.extend(collect(lines, PARSER_PATTERNS, "warning"))
    findings.extend(collect(lines, STATE_PATTERNS, "notice"))

    marker_status = {pattern.pattern: bool(pattern.search(text)) for pattern in END_MARKERS}
    ending_complete = all(marker_status.values())
    runtime_clean = not any(item["severity"] == "critical" for item in findings)
    interpreter_clean = args.interpreter_exit == 0

    blocking = []
    if not runtime_clean:
        blocking.append("runtime/interpreter fatal text detected")
    if not interpreter_clean:
        blocking.append(f"Glulxe exited with status {args.interpreter_exit}")
    if args.seed == args.golden_seed and not ending_complete:
        blocking.append("golden deterministic route did not reach the 350-point Barrow ending")

    counts = {
        "critical": sum(item["severity"] == "critical" for item in findings),
        "warning": sum(item["severity"] == "warning" for item in findings),
        "notice": sum(item["severity"] == "notice" for item in findings),
    }
    report = {
        "seed": args.seed,
        "golden_seed": args.golden_seed,
        "command_count": len(commands),
        "transcript_lines": len(lines),
        "interpreter_exit": args.interpreter_exit,
        "ending_complete": ending_complete,
        "end_markers": marker_status,
        "blocking": blocking,
        "counts": counts,
        "findings": findings,
    }
    args.json.parent.mkdir(parents=True, exist_ok=True)
    args.json.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8")

    md = [
        f"## Full-game adversarial audit, RNG seed {args.seed}",
        "",
        f"- Commands executed: **{len(commands)}**",
        f"- Transcript lines: **{len(lines)}**",
        f"- Glulxe exit: **{args.interpreter_exit}**",
        f"- 350-point Barrow ending observed: **{'yes' if ending_complete else 'NO'}**",
        f"- Critical findings: **{counts['critical']}**",
        f"- Parser warnings: **{counts['warning']}**",
        f"- State/continuity notices: **{counts['notice']}**",
    ]
    if blocking:
        md.extend(["", "### Blocking findings", ""])
        md.extend(f"- {item}" for item in blocking)
    if findings:
        md.extend(["", "### Suspicious transcript events", ""])
        for item in findings[:80]:
            md.append(
                f"- `{item['severity']}` `{item['code']}` at transcript line {item['line']}: "
                f"{str(item['text']).strip()}"
            )
        if len(findings) > 80:
            md.append(f"- ... {len(findings) - 80} additional finding(s) are in the JSON artifact.")
    args.markdown.write_text("\n".join(md) + "\n", encoding="utf-8")

    print(json.dumps({"seed": args.seed, "ending_complete": ending_complete, "blocking": blocking, "counts": counts}, sort_keys=True))
    return 1 if blocking else 0


if __name__ == "__main__":
    raise SystemExit(main())
