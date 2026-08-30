# Release 1279 — Glulxe Optimization

**Numbering slide (2026-08-30):** this train was planned as Release 1278. Release 1278 is now Honest Playthrough Records / House Jar. Keep this filename so existing links resolve.

**Queued after:** Release 1278 — Honest Playthrough Records, Rest Syntax, House Jar  
**Status:** planned product train

## Purpose

Make the native Glulxe execution path materially faster for Highly Extended Zork while preserving exact Glulx semantics and player-visible behavior.

This is not a profiler report release. The release must ship measured runtime improvements.

## Product work

1. Establish representative HOE workloads covering parser-heavy play, large-map traversal, object/inventory manipulation, Mara interaction, House of Records usage, save/restore/undo, large text output, late-game state, and deliberately difficult parser input.
2. Record a locked baseline on the currently pinned Glulxe lineage.
3. Use Glulxe's existing profiler plus host profilers to identify actual hot paths.
4. Evaluate compiler/build improvements such as optimized release flags, LTO, and profile-guided optimization on the actual workload corpus.
5. Optimize interpreter hot paths only where measurement justifies the change. Candidate areas include opcode dispatch, operand decoding, memory access, call/return handling, string execution, search operations, and allocation behavior.
6. Compare relevant implementation techniques from other performant Glulx interpreters where they can be adopted without semantic drift.
7. Produce an exact pinned optimized interpreter build used by HOE qualification and suitable for later runtime bundling.

## Non-goals

- no Glulx semantic fork;
- no story-specific opcode cheats;
- no benchmark-only fast path that changes real play behavior;
- no disabling correctness checks merely to improve a number;
- no generalized performance-audit framework whose only output is reports;
- no requirement that the optimized interpreter become necessary to run the `.ulx`.

## Success criteria

A successful Release 1278 must:

1. demonstrate a reproducible aggregate speed improvement over the locked baseline on representative HOE workloads;
2. show no player-visible transcript or state divergence on those workloads;
3. preserve save/restore/undo and RNG behavior expected by the story;
4. document the exact compiler, flags, PGO corpus if used, and runtime source identity;
5. retain at least one unoptimized/reference configuration for differential debugging;
6. ship the optimized Glulxe binary/source changes as a concrete runtime product artifact, not merely recommendations.
