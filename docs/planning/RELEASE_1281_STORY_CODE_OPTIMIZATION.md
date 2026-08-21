# Release 1281 — Story-Code Optimization

**Queued after:** Release 1280 — Extended Globals / Compiler State Scaling  
**Status:** planned product train

## Purpose

Reduce the amount of work the compiled HOE story asks any conforming Glulx interpreter to perform.

Release 1278 makes one native interpreter faster. Release 1281 makes the story itself cheaper to execute so the gain carries across Glulxe, Git, Quixe, and future interpreters.

## Product work

- Use representative full-game workloads to identify expensive generated story-code paths.
- Optimize parser and scope work where repeated scans or redundant reconstruction are measurable hot spots.
- Reduce avoidable object/property traversal without changing scope or parser semantics.
- Remove redundant state queries and repeated derived calculations where cached/structured representation is semantically safe.
- Improve hot routine structure, call patterns, branch shape, and temporary-stack traffic where ZILF output demonstrates measurable cost.
- Reduce unnecessary string/formatting work in high-frequency paths without flattening authored prose.
- Exploit existing Glulx acceleration facilities only where standards-compliant and semantically exact.
- Consider ZILF code-generation improvements when a recurring inefficiency is compiler-generated rather than story-authored.

## Product rule

Every optimization must either reduce executed VM work, reduce memory/allocation pressure, reduce startup/load work, or measurably improve player-facing latency on representative play.

A report that a routine is slow is not a release outcome. The slow path must actually be improved or deliberately rejected with no release claim attached to it.

## Boundaries

- no parser-semantic shortcuts that reject commands previously accepted;
- no pruning authored world state merely to improve benchmarks;
- no precomputed walkthrough or route assumptions;
- no story behavior dependent on one interpreter's undocumented optimization;
- no giant generic caching framework introduced without multiple proven hot users;
- no benchmark harness becoming the primary product.

## Success criteria

Release 1281 succeeds when:

1. representative command workloads execute materially fewer VM operations or materially less wall time on more than one interpreter;
2. parser acceptance, room/object scope, world state, RNG behavior, and transcripts remain semantically equivalent;
3. at least the dominant measured story-code hot paths receive concrete improvements;
4. save/restore/undo behavior is unchanged;
5. improvements remain visible when running outside the custom optimized Glulxe from Release 1278.
