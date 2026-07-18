#!/usr/bin/env python3
"""Build Zork I with either modern direct-output ZILF or legacy ZILF+ZAPF."""

from __future__ import annotations

import argparse
import shlex
import shutil
import subprocess
import sys
from pathlib import Path


def run(command: list[str], cwd: Path) -> None:
    print(f"+ {shlex.join(command)}")
    completed = subprocess.run(command, cwd=cwd, check=False)
    if completed.returncode != 0:
        raise RuntimeError(
            f"command exited with {completed.returncode}: {shlex.join(command)}"
        )


def remove_generated(source: Path) -> None:
    for name in ("zork1.z3", "zork1.zap"):
        candidate = source / name
        if candidate.exists():
            candidate.unlink()


def copy_story(candidate: Path, output: Path) -> None:
    if not candidate.is_file():
        raise RuntimeError(f"compiler did not produce expected story file: {candidate}")
    output.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(candidate, output)
    print(f"Wrote {output} ({output.stat().st_size} bytes)")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--zilf", default="zilf")
    parser.add_argument("--zapf", default="zapf")
    args = parser.parse_args()

    source = args.source.resolve()
    output = args.output.resolve()
    entrypoint = source / "zork1.zil"
    if not entrypoint.is_file():
        print(f"build_story: missing entrypoint {entrypoint}", file=sys.stderr)
        return 2

    remove_generated(source)
    try:
        run(shlex.split(args.zilf) + [entrypoint.name], cwd=source)
        direct_story = source / "zork1.z3"
        if direct_story.is_file():
            copy_story(direct_story, output)
            return 0

        assembly = source / "zork1.zap"
        if not assembly.is_file():
            raise RuntimeError(
                "ZILF produced neither zork1.z3 nor zork1.zap; "
                "check the compiler output above"
            )

        output.parent.mkdir(parents=True, exist_ok=True)
        if output.exists():
            output.unlink()
        run(shlex.split(args.zapf) + [str(assembly), str(output)], cwd=source)
        if output.is_file():
            print(f"Wrote {output} ({output.stat().st_size} bytes)")
            return 0

        legacy_story = source / "zork1.z3"
        copy_story(legacy_story, output)
        return 0
    except (OSError, RuntimeError) as exc:
        print(f"build_story: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
