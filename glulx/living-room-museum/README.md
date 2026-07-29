# Zork I Glulx Living Room Museum — Release 1220

Release `1220` is House of Records Train 2:

`onyx_zork_house_living_museum`

It executes the train's eight existing beads directly. It adds no sub-beads, sub-trains, or parallel planning hierarchy.

The Living Room becomes a small physical museum made from real expedition objects while the canonical trophy case remains the only house scoring surface.

## Qualified identity

- edition: Unofficial Living Room Museum Glulx
- release: `1220`
- serial: `260724`
- output: `zork1-glulx-living-room-museum.ulx`
- Glulx version: `3.1.3` / `0x00030103`
- size: `237,312` bytes
- checksum: `0x630d724a`, valid
- SHA-256: `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4`

Release `1220` derives from exact qualified Release `1219`:

- base artifact SHA-256: `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f`

## Exact production delta

The fail-closed stager changes exactly four production paths:

- `1actions.zil`
- `assistance.zil`
- new `living_room_museum.zil`
- `zork1.zil`

Every other Release `1219` production path must remain byte-identical.

## Fixed physical surfaces

The canonical Living Room now contains four fixed, open display surfaces:

1. **gallery frame** — painting or map;
2. **weapon wall** — weapons such as the sword, troll axe, knives, and stiletto;
3. **record shelf** — maps, manuals, labels, guide, matchbook, and black book;
4. **relic stand** — treasures, ritual pieces, and selected real tools.

They are not portable furniture. The player uses ordinary parser actions:

- `PUT PAINTING ON FRAME`
- `PUT SWORD ON RACK`
- `PUT GUIDE ON SHELF`
- `PUT BELL ON STAND`
- `TAKE GUIDE`
- `EXAMINE FRAME`

Every exhibit is the original object. Moving an exhibit changes the real object tree. No museum record substitutes for or duplicates it.

## Canonical trophy case

The real trophy case and existing `OTVAL-FROB` calculation remain the only house scoring authority.

- putting treasure in the trophy case follows canonical score behavior;
- removing treasure follows canonical score behavior;
- placing treasure on the frame, weapon wall, record shelf, or relic stand awards no score;
- closing the trophy case protects its contents from the museum theft event;
- leaving the case open exposes its real valuables.

The museum has no parallel score and no automatic trophy-case credit.

## Registry and active field objects

Surface acceptance is deliberately bounded rather than universal.

An object must be real, portable, and appropriate to the chosen surface. Unsupported placement receives a concrete explanation of which surface accepts which object family.

Objects that remain necessary in the field are not retired by display. When the bell, candles, black book, egg, or canary still belong to unfinished canonical work, placement explicitly says the object remains real, removable, and still required.

The qualification route mounts the active brass bell before the Hades ceremony is marked complete, then later removes and replaces the real guide using ordinary `TAKE` and `PUT` while preserving canonical carrying limits.

## Provenance

Inspecting a surface prints authored provenance tied to stable canonical object identity, for example:

- painting from the Gallery;
- sword originally above the white-house trophy case;
- map from the canonical case;
- troll axe;
- thief's stiletto;
- Attic knife;
- maze adventurer's rusty knife;
- dam guide and maintenance tools;
- Hades ceremony pieces;
- jeweled egg and nested canary;
- Atlantis trident;
- Egypt Room coffin;
- thief-room chalice;
- Gas Room bracelet.

Generic real treasures fall back to expedition-treasure provenance, while selected tools fall back to material-evidence provenance.

This is a bounded presentation layer, not a universal lore database.

## Related-object synthesis

The museum recognizes coherent arrangements from current real object locations:

- **house history:** painting + sword + map;
- **completed ritual:** bell + candles + black book after canonical exorcism completion;
- **repaired dam:** guide + wrench + screwdriver after canonical empty-reservoir/repair state;
- **conflict:** sword + troll axe;
- **canary history:** intact or broken egg preserving its correct nested canary object.

Room prose reflects the current arrangement. Separate persistent receipts remember that a coherent arrangement once existed, so `RECAP` can preserve history without pretending removed exhibits are still mounted.

## Theft, disturbance, and recovery

The new surfaces are deliberately open. They are useful for display, not magical security.

A theft can occur only when:

- the house is physically exposed according to Release `1219` security state;
- the canonical thief remains alive and available;
- a real treasure is displayed on an open museum surface or in an open trophy case;
- no museum theft has already occurred.

The event moves one exact real treasure into the canonical thief's inventory. It then:

- recalculates trophy-case score through existing authority;
- leaves a clean empty outline, cut support, scuffed dust, and black thread;
- records the original surface;
- keeps the object recoverable through the thief's existing booty path.

The qualification route proves the real painting moves into the real thief, then reaches the Treasure Room through canonical thief-death booty handling. Nothing is cloned, deleted, or replaced by a token.

## Nested object identity

Display operates on real roots. The jeweled egg keeps the real canary nested inside it. The broken egg keeps the real broken canary nested inside it.

The museum never flattens a container, makes a second canary, or creates a display-only surrogate.

## Persistence

The permanent qualification route:

1. creates the real house, ritual, dam, and conflict arrangements;
2. scores the real trident through the closed canonical trophy case;
3. exposes the house;
4. returns to find the real painting stolen into the real thief;
5. saves the game;
6. deliberately clears surfaces, globals, thief custody, trophy-case placement, and receipts;
7. restores the native save;
8. proves exact surface placement, historical groups, theft evidence, score authority, thief custody, and egg/canary nesting;
9. invokes canonical thief booty recovery;
10. proves the painting reaches the real Treasure Room.

No post-restore repair pass is used.

## Qualification history

The route rejected several false assumptions before qualification:

- `GUIDEBOOK` was replaced with the object's canonical parser word, `GUIDE`;
- an early removal probe hit Zork's real carrying limit, so the route now removes the lighter guide after heavy exhibits have been mounted rather than overriding player physics;
- the active-bell warning is tested before ritual completion;
- an unsupported em dash was replaced with an ASCII separator after it rendered as a control glyph;
- dam synthesis wording was narrowed so it does not claim tools were cleaned when only dam completion and real tool placement are proven.

These corrections strengthened the product and the route instead of weakening canonical behavior.

## Explicit exclusions

Release `1220` adds no:

- cloned exhibit or museum proxy object;
- parallel score;
- automatic puzzle completion;
- completion-critical object retirement;
- universal furniture placement;
- base-building system;
- maintenance chore loop;
- transcript archive;
- Kitchen or Cellar expansion;
- visitor, dream, playback, expedition-box, or multi-run system;
- equipment stash;
- death-site recovery;
- armor;
- Zork Plus;
- Wizard of Frobozz.

## Downstream hooks

Release `1220` leaves stable real-object and historical-receipt boundaries for later existing House of Records trains:

- correspondence can reference a stolen or displayed object;
- Attic dossiers can reference display provenance and theft evidence;
- area files can reference completed dam and ritual groups;
- playback can reconstruct placement and theft without mutating the museum;
- house vulnerability can extend the same physical security state;
- expedition archives can preserve final arrangements as one run's real object tree.

## Files

- production module: `overrides/living_room_museum.zil`
- exact story wrapper: `overrides/zork1.zil`
- manifest: `patch-series.json`
- patches: `patches/`
- test-only story: `tests/living_room_museum_test.zil`
- deterministic route: `tests/living_room_museum_commands.txt`
- native persistence scenario: `tests/living_room_museum_persistence.json`
- stager: `../tools/stage_living_room_museum.py`
- qualification: `qualify.sh`
- workflow: `.github/workflows/glulx-living-room-museum.yml`
