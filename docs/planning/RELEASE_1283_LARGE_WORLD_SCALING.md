# Release 1283 — Large-World Scaling

**Live release number (2026-08-30):** 1284  
**This filename keeps 1283 so existing links resolve.**  
**Queued after (live):** Release 1283 — Cross-Interpreter Compatibility  

**Status:** planned product train

## Purpose

Prove and improve Highly Extended Zork's operating margin as the authored world becomes much larger, so future releases do not discover hidden parser, object, memory, save, or startup cliffs after content has already grown into them.

This is not a generic scale-audit program. The release must remove concrete scaling bottlenecks and establish usable headroom for the actual game.

## Product work

- Construct controlled large-world fixtures representative of HOE structure, not meaningless random object spam.
- Exercise increasing room, object, vocabulary, persistent-state, clue/memory, and record counts.
- Measure parser scope cost, noun resolution, object/property traversal, startup/load time, save size/time, restore time, undo memory, interpreter memory use, and House of Records query behavior.
- Identify the first real scaling cliffs in the current story/runtime/compiler stack.
- Fix the highest-impact cliffs in the correct layer rather than merely publishing their existence.
- Prefer data-structure or algorithmic improvements that preserve authored semantics and remain useful at current game size too.
- Establish a documented operating margin beyond the then-current production game size.

## Candidate scale targets

Implementation may use staged targets such as:

- 1,000 authored rooms;
- several thousand movable/scenery objects;
- large parser vocabularies;
- many thousands of persistent remembered facts/records where the existing systems naturally support them.

These numbers are stress targets, not a promise to pad the production game to those sizes.

## Boundaries

- no procedural filler added to production merely to raise counts;
- no weakening parser scope correctness for speed;
- no arbitrary caps that silently discard world state;
- no fake 'infinite scale' claim;
- no benchmark-only release with no corrected bottleneck;
- no replacing authored world design with a generic world database or ECS unless a real measured need and explicit later product decision justify it.

## Success criteria

Release 1283 succeeds when:

1. the then-current production game has documented, measured headroom across its critical scale dimensions;
2. at least the first significant discovered scaling bottlenecks are concretely improved;
3. parser correctness and canonical state semantics remain intact at stress scale;
4. save/restore/undo remain practical and correct at the supported scale target;
5. the optimized story and runtime degrade predictably rather than hitting an unexplained hard cliff;
6. the release leaves future content trains with a clear safe operating envelope rather than a report-only warning.
