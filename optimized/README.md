# Zork I — Preservation-First Optimized Edition

This directory contains an isolated, runnable modernization of the microcomputer version of **Zork I** stored at the repository root.

The historical Release 119 / serial 880429 source remains untouched. Every optimized build verifies the recorded Git blob identity of each historical input, stages those files into `optimized/build/src`, and then applies a small, receipted set of overlays and exact-match patches.

## What “optimized” means here

This is not a redesign, a parser replacement, a puzzle rebalance, or a conversion into a modern adventure engine.

The priorities are:

1. preserve original play and architecture;
2. fix demonstrated defects with the smallest reasonable source change;
3. make the game reproducibly buildable on current systems;
4. expose smells and assumptions before changing them;
5. prove the resulting Z-machine story is valid and runnable.

## Edition identity

The preserved root story remains **Release 119 / serial 880429**.

The project-local optimized build identifies itself as:

- **Release:** 120
- **Serial:** 260718
- **Z-machine version:** 3

Release 120 is an identifier for this repository’s optimized edition. It is not presented as an official Infocom release.

## Confirmed fixes

### Z1-BUG-001 — Recursive containment

Generic `PUT` previously allowed moving a container into one of its own descendants, which could create a cycle in the Z-machine object tree. The optimized edition rejects only the cycle-forming move and preserves legitimate nesting, capacity, weight, parser resolution, scoring, and the existing impossible-action response.

### Z1-BUG-002 — Extinguished candles still described as burning

The temple candles had a permanently static room description. Their room description is now state-aware: it retains the original wording while lit and no longer calls them “burning” after their light is extinguished.

### Z1-PORT-001 — Unsafe Z-machine tab characters

Two literal tab characters in printed guidebook and tube text were replaced with equivalent spaces. This removes modern ZILF’s Z-machine version 3 character warning without rewriting the prose.

### Build and audit fixes

- include names use the exact lowercase repository filenames;
- generated files are isolated under `optimized/build`;
- source drift stops the build instead of mixing revisions;
- behavioral patches use exact source anchors and fail closed;
- the ZIL audit understands Infocom reader syntax rather than treating semicolons as ordinary line comments;
- ZILF and ZAPF are invoked as an explicit, deterministic two-stage build;
- release, serial, story length, header addresses, and checksum are verified;
- a deterministic opening route is executed through Frotz in CI.

## Proven build result

The validated CI build produced:

- **File:** `zork1-optimized.z3`
- **Size:** 87,012 bytes
- **Checksum:** 41,234, valid
- **SHA-256:** `7e38f3a949a67ed0ab9e38923b89537d875fc80f3fbb9bf268c86cf0d325b107`
- **Structural audit:** 0 errors, 2 retained redefinition warnings
- **Runtime smoke:** passed in Frotz

See `docs/VALIDATION.md` for the exact evidence and remaining targeted tests.

## Requirements

- Python 3.10+
- ZILF
- ZAPF
- a Z-machine interpreter such as Frotz for runtime smoke tests

CI builds a pinned ZILF/ZAPF revision from source. Local paths remain configurable.

## Build

```sh
cd optimized
make selftest
make audit
make compile
make verify
```

Or run the complete non-interactive pipeline:

```sh
make all
```

Run the opening transcript with Frotz:

```sh
make smoke INTERPRETER=dfrotz
```

Override tool paths or edition identity when intentionally testing another build:

```sh
make all \
  ZILF=/path/to/zilf \
  ZAPF=/path/to/zapf \
  RELEASE=120 \
  SERIAL=260718
```

## Directory map

- `overrides/` — intentional complete-file replacements layered over staged historical files
- `patches/` — narrow exact-match changes labeled with defect or portability IDs
- `tools/` — staging, structural audit, build, story verification, and smoke utilities
- `tests/` — tool regressions and deterministic player command routes
- `docs/` — preservation policy, audit findings, bug ledger, and validation evidence
- `build/` — generated locally and ignored by Git

## Behavioral rule

A source change is not accepted merely because it looks cleaner. It needs a defect statement, a minimal patch, and evidence that nearby parser behavior, world state, scoring, timers, objects, and text remain unchanged except where the defect requires otherwise.
