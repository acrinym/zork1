# Post-1277 Runtime Foundation Queue — Releases 1278–1285

**Approved queue:** 2026-08-21  
**Refresh:** 2026-08-30 — Release **1278** is the honest-playthrough / house-jar repair required by the 1245 live playtest. The runtime foundation trains below slide by one.

## Order

1. **1278 — Honest Playthrough Records, Rest Syntax, House Jar** (in CURRENT; not a runtime-foundation train)
2. **1279 — Glulxe Optimization** (was 1278)
3. **1280 — Future-Proof Runtime Contract** (was 1279)
4. **1281 — Extended Globals / Compiler State Scaling** (was 1280)
5. **1282 — Story-Code Optimization** (was 1281)
6. **1283 — Cross-Interpreter Compatibility** (was 1282)
7. **1284 — Large-World Scaling** (was 1283)
8. **1285 — Portable Runtime Bundle** (was 1284)

These are product trains, not audit machinery. Each release must produce a concrete capability, runtime improvement, compatibility guarantee, scaling result, or distributable player-facing artifact.

## Ordering contract

Release 1275 remains the hard human-gated slim-locale expansion. Releases 1276 and 1277 remain ahead of this queue. Release 1278 (honesty/jar) is the immediate successor of 1277. No implementation branch for 1279 or later should start until 1278 has reached the normal locked/qualified frontier.

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

At the end of Release 1285, Highly Extended Zork should have a faster native runtime, a documented portability contract, scalable global/state authoring, cheaper generated story code, verified execution across materially different Glulx implementations, known large-world operating margins, and a practical player runtime bundle while retaining a standalone playable `.ulx` artifact.
