# Zork I Expanded — Project Release 121

This directory builds a deliberately expanded edition of **Zork I: The Great Underground Empire**.

It does not replace either preserved historical source or the conservative optimized edition:

| Edition | Identity | Purpose |
|---|---:|---|
| Historical | Release 119 / `880429` | Original repository-root source and compiled story, untouched |
| Optimized | Release 120 / `260718` | Narrow bug and portability fixes without deliberate gameplay expansion |
| Expanded | Release 121 / `260719` | More responsive scenery, optional discoveries, alternate reasoning, world memory, contextual assistance, deeper character behavior, and extensive comedy reactivity |

Release 121 is a repository-local identity. It is not presented as an official Infocom release.

## What changes for the player

The expanded edition makes the existing world denser before making it larger.

- The white house, boards, doors, windows, mailbox, forest, and songbird recognize more reasonable experiments.
- Following the songbird can reveal an optional hidden glade.
- The troll has a treasure-bribery route alongside the original confrontation.
- The cyclops can be lulled to sleep through a risky repeated action alongside the original solutions.
- The thief can bargain once for a genuine treasure.
- The dam, control panel, bell, candles, black book, rope, and mirrors provide more state-aware feedback.
- `GOALS`, `EXITS`, `HINT`, `RECAP`, `WHY`, and `USE <object>` provide optional assistance without playing the game automatically.
- The **Office of Adventurer Misconduct** rewards gloriously foolish experiments such as `EAT NEST`, `THROW SELF AT TROLL`, `THROW VOICE`, `SACK TROLL`, `KILL TROLL WITH SELF`, `MARRY TREE`, and `CUT DOWN TREE WITH AXE`.
- `FOLLY` reports only the ridiculous actions the player has actually discovered.

Every original route remains valid. New solutions and jokes must still obey the physical, social, comic, and supernatural logic of Zork.

## Build

The expanded edition reuses the verified staging, structural audit, compiler wrapper, story verifier, and transcript harness under `optimized/tools/`.

```bash
make -C expanded compile ZILF="zilf" ZAPF="zapf"
make -C expanded verify ZILF="zilf" ZAPF="zapf"
make -C expanded smoke ZILF="zilf" ZAPF="zapf" INTERPRETER="dfrotz"
```

Generated files remain under `expanded/build/` and are ignored by Git.

## Source boundary

Release 121 is assembled by:

1. verifying the exact historical Git blobs listed by the optimized manifest;
2. copying them into `expanded/build/src/`;
3. applying the expanded entrypoint and additive ZIL overlays;
4. applying exact-match bug, portability, action-hook, and comedy-reactivity patches;
5. compiling the staged copy.

The historical root files are never rewritten by this process.

## Upstream migration direction

The long-term expanded lineage will reconcile with Tara McGrew's existing Zork I Glulx port and a modern pinned ZILF/Glazer toolchain. The current `.z3` editions remain supported and immutable in identity; Glulx will be introduced as an additional repository-local artifact after an unchanged upstream baseline and parity harness exist.

No new virtual-machine implementation or ZIL-to-Glulx backend should be invented unless a specific upstream defect proves unavoidable.

## Beadtrains

The implementation is tracked by three completed v1.3 beadtrains:

- `.beads/onyx_zork_reactive_world.beadtrain`
- `.beads/onyx_zork_living_underground.beadtrain`
- `.beads/onyx_zork_adventurer_misconduct.beadtrain`

The first two form the coupled world-expansion foundation. The misconduct train builds on that validated world and adds broad comic parser reactivity without changing canonical puzzle solutions.

See:

- [`docs/DESIGN_CHARTER.md`](docs/DESIGN_CHARTER.md)
- [`docs/FEATURE_MATRIX.md`](docs/FEATURE_MATRIX.md)
- [`docs/ADVENTURER_MISCONDUCT.md`](docs/ADVENTURER_MISCONDUCT.md)
- [`docs/VALIDATION.md`](docs/VALIDATION.md)
- [`docs/NEXT_TRAINS.md`](docs/NEXT_TRAINS.md)
- [`docs/GLULX_UPSTREAM_MIGRATION.md`](docs/GLULX_UPSTREAM_MIGRATION.md)
- [`docs/GLULX_LICENSING.md`](docs/GLULX_LICENSING.md)
- [`../docs/planning/ZORK_GLULX_UPSTREAM_CONTINUATION_HANDOFF_2026_07_19.md`](../docs/planning/ZORK_GLULX_UPSTREAM_CONTINUATION_HANDOFF_2026_07_19.md)
