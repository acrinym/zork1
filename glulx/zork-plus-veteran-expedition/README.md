# Release 1237 — Zork Plus: Veteran Survey Expedition

Release 1237 turns a genuinely archived victory into one complete, explicitly selected postgame expedition. It does not silently alter the canonical opening, restart the first expedition with bonuses, or create a generic New Game Plus menu.

## Player loop

1. win the canonical first expedition and seal it in Expedition Box A;
2. read the physical veteran dispatch that appears inside that sealed box;
3. carry either the canonical brass lantern or the canonical rope to the Attic;
4. `CHOOSE LANTERN` or `CHOOSE ROPE` as the one field loadout;
5. `BEGIN VETERAN`;
6. leave every other directly carried object in the physical Attic veteran hold trunk;
7. arrive at the survey trailhead near the white house carrying only the chosen canonical item and the mission field card;
8. cross the abandoned survey cut through the chosen item’s authored method;
9. `RECORD MARKER` at the veteran overlook;
10. cross back and `COMPLETE VETERAN` at the trailhead;
11. return to the illuminated Attic archive and seal the veteran history separately in Expedition Box B.

The lantern route requires the real lantern to be lit and uses a narrow illuminated shelf. The rope route physically secures the canonical rope at the near side of the cut for both crossings. A fixed, nonportable archive work light keeps the expedition boxes usable when the brass lantern was not selected. The selected field item may be retained or left behind, and the final field card records that physical outcome.

## Separation and custody

- Expedition A must already be genuinely sealed; `WON-FLAG` alone is not enough.
- The first expedition remains unchanged until the player explicitly selects and begins Veteran Expedition.
- Exactly one supported canonical field item is selected.
- No selected object is duplicated at its original map location.
- All other directly carried objects move into one real Attic hold trunk.
- The fixed archive work light is bolted to the rafters and cannot become a second portable lantern.
- The veteran field card becomes a physical record in Expedition Box B.
- The existing completed-expedition archive remains the authority for separate histories.

## Boundaries

This train adds no:

- generic New Game Plus framework;
- restart-time menu or automatic mode switch;
- `TAKE EVERYTHING` loadout;
- duplicate portable lantern, rope, treasure, or puzzle object;
- automatic puzzle completion;
- merged Expedition A and B histories;
- universal equipment-slot system;
- House hierarchy reopening;
- S.T.A.L.K.E.R. coupling.

## Qualification direction

Public hosted CI stages exactly over locked Release 1236, qualifies only the new prose against the rights-safe corpus, compiles with ZILF, assembles with Glazer, and runs complete lantern and rope Glulxe routes. Qualification proves the sealed-victory gate, one-item loadout, physical hold trunk, both authored crossings, marker recording, retained-versus-left-behind custody, usable illuminated archive return, separate Expedition Box B materialization, and exact artifact reproduction before squash merge.
