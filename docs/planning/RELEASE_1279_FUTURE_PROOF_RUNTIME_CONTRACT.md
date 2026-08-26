# Release 1279 — Future-Proof Runtime Contract

**Queued after:** Release 1278 — Glulxe Optimization  
**Status:** planned product train

## Purpose

Make Highly Extended Zork resilient to future interpreter, compiler, host-platform, and packaging changes without binding the game to one private executable.

The governing product rule is:

> The shipped `.ulx` remains an ordinary standards-compliant Glulx story. Enhanced runtimes may make it faster or easier to launch, but they must not become a hidden gameplay dependency.

## Product work

- Define and document the exact Glulx/Glk capability contract HOE relies on.
- Guard optional VM/interpreter capabilities through proper capability discovery rather than accidental assumptions.
- Exercise supported native builds across Linux, Windows, and macOS toolchains where practical.
- Remove implementation-defined or undefined-C dependencies found in the HOE runtime path when they threaten portability.
- Preserve deterministic story artifact construction and exact source/toolchain provenance.
- Define compatibility expectations for save/restore, undo, RNG seeding, text encoding, file I/O, and startup behavior.
- Establish a durable runtime/version manifest that later bundles can consume.
- Preserve the ability to reconstruct and run historical locked HOE artifacts with their documented toolchain inputs.

## Boundaries

- no Glulx64 fork;
- no proprietary story ABI;
- no mandatory HOE-only opcode set;
- no silent dependence on one Glk frontend;
- no compatibility-report bureaucracy detached from actual runtime changes;
- no rewriting canonical gameplay systems in the name of portability.

## Success criteria

Release 1279 succeeds when:

1. the runtime assumptions required by HOE are explicit and machine-checkable where appropriate;
2. supported host builds produce working interpreters from pinned source;
3. the standalone `.ulx` remains playable in conforming non-HOE Glulx environments within the declared capability contract;
4. optional capabilities fail or degrade honestly rather than corrupting state;
5. save/restore and persistent game behavior remain compatible across the supported runtime matrix;
6. the runtime/version manifest is consumable by later compatibility and packaging releases.
