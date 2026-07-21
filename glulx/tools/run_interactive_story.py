#!/usr/bin/env python3
"""Drive an interactive text-adventure interpreter through prompt-aware scenarios.

The existing line-oriented smoke routes are ideal until an interpreter asks for a
filename. SAVE and RESTORE do exactly that, so persistence qualification needs a
small PTY driver rather than a shell pipe. Scenarios remain declarative JSON and
may assert output after each command.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import sys
from pathlib import Path
from typing import Any

try:
    import pexpect
except ImportError as exc:  # pragma: no cover - exercised by the CLI guard
    raise SystemExit("run_interactive_story.py requires pexpect") from exc


def load_scenario(path: Path) -> dict[str, Any]:
    data = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(data, dict) or not isinstance(data.get("steps"), list):
        raise ValueError("scenario must be an object containing a steps list")
    return data


def expand(value: str, variables: dict[str, str]) -> str:
    return os.path.expandvars(value.format_map(variables))


def run_scenario(
    command: list[str],
    scenario: dict[str, Any],
    transcript_path: Path,
    variables: dict[str, str],
) -> None:
    timeout = float(scenario.get("timeout_seconds", 20))
    encoding = str(scenario.get("encoding", "utf-8"))
    child = pexpect.spawn(command[0], command[1:], encoding=encoding, timeout=timeout)
    transcript_path.parent.mkdir(parents=True, exist_ok=True)

    with transcript_path.open("w", encoding="utf-8", newline="\n") as transcript:
        child.logfile_read = transcript
        try:
            for index, raw_step in enumerate(scenario["steps"], start=1):
                if not isinstance(raw_step, dict):
                    raise ValueError(f"step {index} must be an object")

                if "expect" in raw_step:
                    pattern = expand(str(raw_step["expect"]), variables)
                    child.expect(re.compile(pattern, re.MULTILINE))

                if "send" in raw_step:
                    child.send(expand(str(raw_step["send"]), variables))

                if "sendline" in raw_step:
                    child.sendline(expand(str(raw_step["sendline"]), variables))

                if raw_step.get("expect_eof"):
                    child.expect(pexpect.EOF)

            if scenario.get("close_stdin", True) and child.isalive():
                child.sendeof()
                child.expect(pexpect.EOF)
        except Exception as exc:
            before = child.before or ""
            after = child.after if isinstance(child.after, str) else repr(child.after)
            raise RuntimeError(
                f"scenario failed at step {index}: {exc}\n"
                f"last before={before[-1000:]!r}\nlast after={after!r}"
            ) from exc
        finally:
            child.close(force=True)

    allowed = {int(code) for code in scenario.get("allowed_exit_codes", [0])}
    if child.exitstatus not in allowed:
        raise RuntimeError(
            f"interpreter exit status {child.exitstatus!r} not in {sorted(allowed)}; "
            f"signal={child.signalstatus!r}"
        )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--scenario", type=Path, required=True)
    parser.add_argument("--transcript", type=Path, required=True)
    parser.add_argument(
        "--var",
        action="append",
        default=[],
        metavar="NAME=VALUE",
        help="scenario substitution available as {NAME}",
    )
    parser.add_argument("command", nargs=argparse.REMAINDER)
    args = parser.parse_args()
    if args.command and args.command[0] == "--":
        args.command = args.command[1:]
    if not args.command:
        parser.error("an interpreter command is required after --")
    return args


def main() -> int:
    args = parse_args()
    variables: dict[str, str] = {}
    for item in args.var:
        if "=" not in item:
            raise SystemExit(f"invalid --var {item!r}; expected NAME=VALUE")
        name, value = item.split("=", 1)
        variables[name] = value

    scenario = load_scenario(args.scenario)
    run_scenario(args.command, scenario, args.transcript, variables)
    print(f"interactive scenario passed: {args.scenario}")
    print(f"transcript: {args.transcript}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
