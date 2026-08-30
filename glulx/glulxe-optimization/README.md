# Release 1279 — Glulxe Optimization

Release 1279 does not change the locked Release 1278 story. It ships a faster native Glulxe for Highly Extended Zork, built from the same pinned interpreter source HOE already uses.

The `.ulx` stays ordinary Glulx. VERIFY_MEMORY_ACCESS stays on. There is no story-specific opcode cheat and no requirement that this interpreter be the only way to play the file.

## What it ships

- a **reference** Glulxe matching the current HOE `-O2` recipe;
- an **optimized** Glulxe using `-O3`, LTO, and profile-guided optimization trained on the HOE workload corpus in `workloads/`;
- a **profile** Glulxe (`VM_PROFILING`) used only to record hot paths, never as the product binary;
- transcript identity, save/restore/undo round-trips, and a measured aggregate speedup gate.

## Predecessor

Locked Release 1278 story:

- `zork1-glulx-honest-playthrough-perilous-house.ulx`
- SHA-256 `d1d5e7487a792079135e014dcdcfa0af73219307c12fbab2ef41d6af2b5f53f1`

Interpreter pins match the 1278 workflow: Glulxe `56ab8743bab565de307bd892c555d8d8897ed517`, CheapGlk `14d8aaf6e4150669762bd4646a5368e75c1eeee6`.

Qualify copies Glulxe out of `.tooling/glulxe` into isolated build trees. Those copies have no sibling `../cheapglk`, so `build-glulxe.sh` must pass `GLKINCLUDEDIR` on **every** `make` invocation, including `clean`. Do not `make -C` a copied Glulxe tree without that directory.

Merges go to `acrinym/zork1` `master` only.

See `docs/planning/RELEASE_1278_GLULXE_OPTIMIZATION.md`.
