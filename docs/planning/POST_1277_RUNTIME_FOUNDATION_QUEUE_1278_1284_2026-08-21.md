# Post-1277 Runtime Foundation Queue — Releases 1278–1284

**Approved queue:** 2026-08-21  
**Status:** planned product sequence; implementation must not jump release order

## Order

1. **1278 — Glulxe Optimization**
2. **1279 — Future-Proof Runtime Contract**
3. **1280 — Extended Globals / Compiler State Scaling**
4. **1281 — Story-Code Optimization**
5. **1282 — Cross-Interpreter Compatibility**
6. **1283 — Large-World Scaling**
7. **1284 — Portable Runtime Bundle**

These are product trains, not audit machinery. Each release must produce a concrete capability, runtime improvement, compatibility guarantee, scaling result, or distributable player-facing artifact.

## Ordering contract

Release 1275 remains the hard human-gated slim-locale expansion. Releases 1276 and 1277 remain ahead of this queue. No implementation branch for 1278 or later should start until its predecessor product release has reached the normal locked/qualified frontier.

Planning these trains does not authorize a merge. Every merge still requires a fresh explicit Justin merge whistle.

## Shared engineering rules

- Keep the shipped `.ulx` standards-compliant Glulx unless a later explicit product decision changes that contract.
- Prefer improving ZILF lowering, story code, and the interpreter without coupling the story file to one private runtime.
- Measure performance on real HOE gameplay workloads, not synthetic microbenchmarks alone.
- Preserve canonical game-state authorities and save/restore semantics.
- No generic recursive audit machinery, audit-of-audit reports, or tooling whose only product is more tooling reports.
- Validation exists to qualify a product change; validation is not itself the release.
- External interpreters may be used as product compatibility targets, not as an excuse to build a compatibility-audit bureaucracy.
- `historicalsource/zork1` remains read-only upstream reference.

## Program outcome

At the end of Release 1284, Highly Extended Zork should have a faster native runtime, a documented portability contract, scalable global/state authoring, cheaper generated story code, verified execution across materially different Glulx implementations, known large-world operating margins, and a practical player runtime bundle while retaining a standalone playable `.ulx` artifact.
