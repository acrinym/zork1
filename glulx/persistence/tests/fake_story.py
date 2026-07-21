#!/usr/bin/env python3
from __future__ import annotations

import sys
from pathlib import Path

state = "before"
print("FAKE STORY READY", flush=True)
for raw in sys.stdin:
    command = raw.strip()
    if command == "mutate":
        state = "after"
        print("STATE AFTER", flush=True)
    elif command == "save":
        print("SAVE FILE?", flush=True)
        filename = sys.stdin.readline().strip()
        Path(filename).write_text(state, encoding="utf-8")
        print("SAVED", flush=True)
    elif command == "reset":
        state = "before"
        print("STATE BEFORE", flush=True)
    elif command == "restore":
        print("RESTORE FILE?", flush=True)
        filename = sys.stdin.readline().strip()
        state = Path(filename).read_text(encoding="utf-8")
        print(f"RESTORED {state.upper()}", flush=True)
    elif command == "quit":
        print("GOODBYE", flush=True)
        raise SystemExit(0)
    else:
        print(f"UNKNOWN {command}", flush=True)
