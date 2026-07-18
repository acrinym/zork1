# Zork I — Preservation-First Optimized Edition

This directory is an isolated modernization workspace for the microcomputer version of **Zork I** in the repository root.

The historical source at the root is never overwritten. Every build begins by verifying and staging a known source snapshot into `optimized/build/src`, then applying narrowly scoped overlays from `optimized/overrides`.

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

1. **Case-sensitive include portability** — the optimized `zork1.zil` entrypoint uses lowercase include names that exactly match the repository filenames. This avoids a build failure class on case-sensitive filesystems while preserving game logic.
2. **Build output isolation** — generated `.zap`, `.z3`, reports, and staged sources live under `optimized/build`; historical root artifacts are not replaced.
3. **Source-drift protection** — staging verifies each root file against its recorded Git blob SHA before copying it.
4. **Structural smell checks** — the checker validates balanced ZIL forms, case-correct includes, duplicate definitions, unfinished markers, and clock-table capacity metadata.
5. **Z-machine verification** — the output verifier checks the story-file header, declared length, important addresses, and checksum.

## Requirements

- Python 3.9+
- ZILF (`zilf`)
- ZAPF (`zapf`)
- A Z-machine interpreter such as Frotz for smoke tests

## Build

```sh
cd optimized
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

- `overrides/` — intentional replacements layered over staged historical files
- `tools/` — staging, linting, story verification, and smoke-test utilities
- `tests/` — command routes and expected output fragments
- `docs/` — audit findings and preservation rules
- `build/` — generated locally; ignored by Git

## Behavioral rule

A source change is not accepted merely because it looks cleaner. It must have a clear defect statement, a minimal patch, and evidence that parser behavior, world state, scoring, timers, object behavior, and player-visible text remain unchanged except where the defect requires otherwise.
