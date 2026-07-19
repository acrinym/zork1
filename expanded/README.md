# Zork I Expanded — Project Release 121

This directory builds a deliberately expanded edition of **Zork I: The Great Underground Empire**.

It does not replace either preserved historical source or the conservative optimized edition:

| Edition | Identity | Purpose |
|---|---:|---|
| Historical | Release 119 / `880429` | Original repository-root source and compiled story, untouched |
| Optimized | Release 120 / `260718` | Narrow bug and portability fixes without deliberate gameplay expansion |
| Expanded | Release 121 / `260719` | More responsive scenery, optional discoveries, alternate reasoning, world memory, contextual assistance, and deeper character behavior |

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

Every original route remains valid. New solutions must still obey the physical, social, comic, and supernatural logic of Zork.

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
3. applying the expanded entrypoint and `expansions.zil` overlay;
4. applying exact-match bug, portability, and action-hook patches;
5. compiling the staged copy.

The historical root files are never rewritten by this process.

## Coupled trains

The implementation is tracked by two v1.3 beadtrains:

- `.beads/onyx_zork_reactive_world.beadtrain`
- `.beads/onyx_zork_living_underground.beadtrain`

The second train is coupled after the first train's capstone because character and alternate-solution behavior must build on a validated interaction foundation.

See:

- [`docs/DESIGN_CHARTER.md`](docs/DESIGN_CHARTER.md)
- [`docs/FEATURE_MATRIX.md`](docs/FEATURE_MATRIX.md)
- [`docs/VALIDATION.md`](docs/VALIDATION.md)
- [`docs/NEXT_TRAINS.md`](docs/NEXT_TRAINS.md)
