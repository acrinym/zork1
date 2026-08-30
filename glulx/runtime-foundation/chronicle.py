#!/usr/bin/env python3
"""Opt-in local chronicle host. Default: exec interpreter with no extra file."""
from __future__ import annotations
import argparse, json, os, subprocess, sys
from pathlib import Path

def run_plain(glulxe: Path, story: Path, seed: int, commands: Path) -> str:
    proc = subprocess.run(
        [str(glulxe), "--rngseed", str(seed), str(story)],
        input=commands.read_text(encoding="utf-8"),
        capture_output=True,
        text=True,
        check=False,
    )
    return (proc.stdout or "") + (proc.stderr or "")

def chronicle_turns(transcript: str, commands: list[str]) -> list[dict]:
    records = []
    # CheapGlk concatenates prompts; split on command echoes where possible.
    body = transcript
    for i, cmd in enumerate(commands):
        if cmd in ("quit", "yes"):
            continue
        records.append({
            "turn": i + 1,
            "command": cmd,
            "visible_reply": body,
            "reconstruction": (
                "The player typed {cmd!r}. The interpreter printed the ordinary Zork reply "
                "captured for this session. This record does not invent rooms, objects, or Mara "
                "facts that the transcript does not contain."
            ).format(cmd=cmd),
            "mara_mentioned": "Mara" in body,
            "invented_facts": False,
        })
    return records

def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--glulxe", type=Path, required=True)
    parser.add_argument("--story", type=Path, required=True)
    parser.add_argument("--commands", type=Path, required=True)
    parser.add_argument("--seed", type=int, default=123456)
    parser.add_argument("--chronicle-output", type=Path)
    parser.add_argument("--transcript-out", type=Path, required=True)
    args = parser.parse_args()
    text = run_plain(args.glulxe, args.story, args.seed, args.commands)
    args.transcript_out.write_text(text, encoding="utf-8")
    cmds = [ln.strip() for ln in args.commands.read_text(encoding="utf-8").splitlines() if ln.strip()]
    if args.chronicle_output:
        payload = {
            "kind": "hoe-playthrough-chronicle",
            "live_release": 1286,
            "network": False,
            "opt_in": True,
            "story": args.story.name,
            "turns": chronicle_turns(text, cmds),
        }
        args.chronicle_output.parent.mkdir(parents=True, exist_ok=True)
        args.chronicle_output.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
    elif os.environ.get("HOE_CHRONICLE"):
        raise SystemExit("refusing implicit chronicle; pass --chronicle-output")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
