# Zork I — Preservation-First Optimized Edition

This directory is an isolated modernization workspace for the microcomputer version of **Zork I** in the repository root.

The historical source at the root is never overwritten. Every build begins by verifying and staging a known source snapshot into `optimized/build/src`, then applying narrowly scoped overlays and exact-match patches.

## What “optimized” means here

The goal is not to redesign Zork, simplify its puzzles, replace its parser, rewrite its prose, or make it behave like a modern adventure game.

The goal is to:

- make the source reproducibly buildable on current systems;
- fix demonstrated defects without changing intended play;
- expose smells and risky assumptions before changing them;
- add structural, binary, and transcript-based regression checks;
- separate historical source, generated files, and experimental fixes;
- document why every behavioral change is safe.

## First-pass fixes

1. **Recursive-container corruption** — `PUT` now rejects moves that would place an object inside one of its own descendants, preventing cycles in the Z-machine object tree while preserving legitimate nesting.
2. **Case-sensitive include portability** — the optimized `zork1.zil` entrypoint uses lowercase include names that exactly match the repository filenames.
3. **Old and new ZILF compatibility** — the build accepts either a modern direct `.z3` output or the older `.zap` plus ZAPF flow.
4. **Build output isolation** — generated `.zap`, `.z3`, reports, and staged sources live under `optimized/build`; historical root artifacts are not replaced.
5. **Source-drift protection** — staging verifies each root file against its recorded Git blob SHA before copying it.
6. **Exact behavioral patching** — gameplay fixes use verified source anchors, fail when text drifts, and are listed in the staging receipt.
7. **Structural smell checks** — the checker understands ZIL’s semicolon-suppressed forms and validates balanced forms, case-correct includes, duplicate definitions, unfinished markers, and clock-table capacity metadata.
8. **Z-machine verification** — the output verifier checks the story-file header, declared length, important addresses, and checksum.

## Requirements

- Python 3.10+
- ZILF (`zilf`)
- ZAPF (`zapf`) when using a legacy ZILF version that emits `.zap`
- A Z-machine interpreter such as Frotz for smoke tests

## Build

```sh
cd optimized
make selftest
make audit
make compile
make verify
```

Or run the full non-interactive pipeline:

```sh
make all
```

To execute the smoke route with Frotz:

```sh
make smoke INTERPRETER=dfrotz
```

Tool paths are configurable:

```sh
make all ZILF=/path/to/zilf ZAPF=/path/to/zapf PYTHON=python3
```

## Directory map

- `overrides/` — intentional complete-file replacements layered over staged historical files
- `patches/` — narrowly scoped, exact-match source changes with defect IDs
- `tools/` — staging, linting, story verification, and smoke-test utilities
- `tests/` — tool regressions, command routes, and expected output fragments
- `docs/` — audit findings, behavioral bug ledger, and preservation rules
- `build/` — generated locally; ignored by Git

## Behavioral rule

A source change is not accepted merely because it looks cleaner. It must have a clear defect statement, a minimal patch, and evidence that parser behavior, world state, scoring, timers, object behavior, and player-visible text remain unchanged except where the defect requires otherwise.
