# Release 1240 — Museum Songbird Correspondence

Release 1240 turns one of Zork's strangest canonical forest events into a complete natural-history expedition without replacing it.

## Player route

1. Recover the real intact golden clockwork canary through Zork's existing egg and thief play.
2. Carry it into a canonical forest room.
3. `WIND CANARY`.
4. The original songbird event still drops the one real brass bauble. One real blue-black flight feather now settles beside it.
5. Recover the physical evidence.
6. Choose what happens to the feather:
   - carry it to the Living Room and `EXHIBIT FEATHER`, placing the actual feather in the Forest and Surface Life case;
   - carry it to `Up a Tree` and `PUT FEATHER IN NEST`, permanently weaving the same trace back into the branch nest.
7. `EXHIBIT BAUBLE` uses the existing museum intake and places the actual canonical treasure in the trophy case.
8. `CATALOG FOREST` or `READ SONGBIRD PLAQUE` reports where both real objects actually are.
9. Taking the feather or bauble out of museum custody immediately weakens the linked exhibit instead of leaving a false completion flag.

## The choice

The museum can possess the feather, or the forest can. It cannot possess a substitute.

Returning the feather to the nest preserves the observation and the real brass-bauble evidence while leaving the physical trace in the world. Displaying it produces a stronger specimen exhibit, but the nest remains without it.

## Canonical authority

- The existing `SING-SONG` event remains the only authority for whether the songbird exchange happened.
- The original golden canary and brass bauble are not copied or replaced.
- The feather is created once by the actual canonical event and falls at the bauble's real location.
- The trophy case retains its canonical treasure and scoring behavior.
- The Forest case, branch nest, plaque, and catalog read actual object locations.

## Boundaries

- no generic bird, nest, ecology, or specimen engine;
- no procedural wildlife or forest checklist;
- no second bauble, canary, feather, or substitute display;
- no remote donation or abstract collection registry;
- no replacement forest event;
- no audit framework or recursive development machinery.
