#!/usr/bin/env python3
"""Build a deterministic optimized Zork I story with ZILF and ZAPF."""

from __future__ import annotations

import argparse
import re
import shlex
import subprocess
import sys
from pathlib import Path


SERIAL_RE = re.compile(r"^[0-9]{6}$")


def run(command: list[str], cwd: Path) -> None:
    print(f"+ {shlex.join(command)}")
    completed = subprocess.run(command, cwd=cwd, check=False)
    if completed.returncode != 0:
        raise RuntimeError(
            f"command exited with {completed.returncode}: {shlex.join(command)}"
        )


def split_command(value: str) -> list[str]:
    """Split a command string without treating Windows path separators as escapes."""
    return shlex.split(value, posix=sys.platform != "win32")


def remove_generated(source: Path, output: Path) -> None:
    for candidate in (
        source / "zork1.z3",
        source / "zork1.zap",
        source / "zork1_data.zap",
        source / "zork1_str.zap",
        output,
    ):
        if candidate.exists():
            candidate.unlink()


def validate_identity(release: int, serial: str) -> None:
    if not 1 <= release <= 65535:
        raise RuntimeError(f"release must be between 1 and 65535, got {release}")
    if not SERIAL_RE.fullmatch(serial):
        raise RuntimeError(
            f"serial must contain exactly six decimal digits, got {serial!r}"
        )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--zilf", default="zilf")
    parser.add_argument("--zapf", default="zapf")
    parser.add_argument("--release", type=int, default=120)
    parser.add_argument("--serial", default="260718")
    args = parser.parse_args()

    source = args.source.resolve()
    output = args.output.resolve()
    entrypoint = source / "zork1.zil"
    assembly = source / "zork1.zap"

    if not entrypoint.is_file():
        print(f"build_story: missing entrypoint {entrypoint}", file=sys.stderr)
        return 2

    try:
        validate_identity(args.release, args.serial)
        output.parent.mkdir(parents=True, exist_ok=True)
        remove_generated(source, output)

        # Always stop after ZIL generation, then invoke ZAPF ourselves. This
        # keeps release and serial metadata explicit and avoids whichever
        # assembler happens to sit beside a local ZILF executable.
        run(split_command(args.zilf) + ["-S", entrypoint.name], cwd=source)
        if not assembly.is_file():
            raise RuntimeError(
                f"ZILF completed without producing expected assembly: {assembly}"
            )

        run(
            split_command(args.zapf)
            + [
                "--release",
                str(args.release),
                "--serial",
                args.serial,
                str(assembly),
                str(output),
            ],
            cwd=source,
        )
        if not output.is_file():
            raise RuntimeError(f"ZAPF did not produce expected story file: {output}")

        print(
            f"Wrote {output} ({output.stat().st_size} bytes), "
            f"release {args.release}, serial {args.serial}"
        )
        return 0
    except (OSError, RuntimeError) as exc:
        print(f"build_story: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
