# House of Records Program — Continuation Handoff

## Repository

`acrinym/zork1`

## Resolve live state first

Do not trust frozen SHAs, check counts, mergeability, PR state, or bead counts without resolving GitHub live.

At the beginning of the next session:

1. resolve exact `master`;
2. inspect every open pull request;
3. read PRs #11, #16, and #17 metadata, comments, reviews, inline threads, checks, bases, and current heads;
4. confirm whether any stacked branch advanced;
5. read `expanded/docs/HOUSE_OF_RECORDS_PROGRAM.md`;
6. read `glulx/house-state-foundation/README.md` and `glulx/living-room-museum/README.md`;
7. validate all twelve House of Records beadtrains against all four issue shards;
8. preserve the locked Release `1219` and `1220` identities and changed-path boundaries;
9. do not merge any PR without Justin's explicit merge whistle.

## Live stack at this handoff

- default branch: `master`;
- production base PR: #11 — `agent/glulx-material-consequences`;
- Train 1 PR: #16 — `agent/glulx-house-state-foundation`;
- Train 2 PR: #17 — `agent/glulx-living-room-museum`;
- PR #17 is stacked on exact qualified PR #16 head `0635c40ab0e4099a9f517865206f194d1d5d86c7`;
- PRs remain open and unmerged absent explicit permission.

Resolve PR #17's current head live. The implementation head advanced during qualification and capstone work.

## Hierarchy rule

The House of Records program has exactly:

- twelve trains;
- eight beads per train;
- ninety-six beads total.

Do not create sub-beads, sub-trains, or parallel planning documents beneath those beads. Execute the existing beads directly.

PR #15, the separate death/object-fate detour, was closed without merge for violating this sequencing.

## Train 1 complete — Release 1219

Train:

`onyx_zork_house_state_foundation`

Status:

`complete`

Locked identity:

- release `1219` / serial `260724`;
- 230,144 bytes;
- checksum `0xbe6bc80a`;
- SHA-256 `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f`.

Exact production delta:

- `1actions.zil`;
- `1dungeon.zil`;
- `assistance.zil`;
- new `house_state_foundation.zil`;
- `zork1.zil`.

It established compact condition, collection, knowledge, security, and atmosphere state; bounded house receipts; room projection; conservative migration; and native save/restore without repair.

## Train 2 capstone candidate — Release 1220

Train:

`onyx_zork_house_living_museum`

Current status:

`in_progress`

Bead state:

- museum beads 001–007 closed with exact production and qualification evidence;
- museum bead 008 remains open until capstone-candidate and exact closure-head validation pass;
- current roadmap expectation: 15 closed / 81 open;
- final Train 2 expectation: 16 closed / 80 open.

### Locked Release 1220 identity

- edition: Unofficial Living Room Museum Glulx;
- release: `1220`;
- serial: `260724`;
- output: `zork1-glulx-living-room-museum.ulx`;
- Glulx version: `3.1.3` / `0x00030103`;
- size: `237,312` bytes;
- checksum: `0x630d724a`;
- SHA-256: `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4`.

Exact base artifact:

- Release `1219` SHA-256: `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f`.

### Exact production delta

Release `1220` changes exactly:

- `1actions.zil`;
- `assistance.zil`;
- new `living_room_museum.zil`;
- `zork1.zil`.

The fail-closed stager rejects every other production change.

## What Train 2 adds

The canonical Living Room gains four fixed open surfaces:

- gallery frame;
- weapon wall;
- record shelf;
- relic stand.

Every displayed item is the original canonical object. Players use ordinary `PUT`, `TAKE`, and `EXAMINE`. The surfaces do not create copies, retire puzzle objects, override carrying limits, or add score.

The canonical trophy case and `OTVAL-FROB` remain the sole house scoring authority. A closed case protects its contents; an open case is exposed like the fixed surfaces.

Bounded provenance covers real objects such as the Gallery painting, house sword and map, troll axe, thief stiletto, Attic knife, rusty knife, dam records/tools, Hades ceremony pieces, egg/canary, trident, coffin, chalice, and bracelet.

Current real arrangements synthesize optional observations for:

- house history: painting + sword + map;
- completed ritual: bell + candles + black book;
- repaired dam: guide + wrench + screwdriver;
- troll conflict: sword + axe;
- intact or broken egg with its correctly nested canary.

## Theft and recovery

When Release `1219` marks the house exposed, the canonical thief remains alive/available, and a real valuable is unsecured:

1. one exact treasure moves into the real thief's inventory;
2. the room retains an empty outline, cut support, scuffed dust, and black thread;
3. score is recalculated through the real trophy-case authority;
4. recovery follows canonical thief booty handling.

Qualification proves the real painting moves from the frame into the real thief and later into the real Treasure Room. No copy, token, deletion, or parallel recovery system exists.

## Qualification completed

The permanent fail-closed route proves:

1. exact Release `1219` base identity;
2. exact four-path production staging;
3. exact Release `1220` size, checksum, and SHA;
4. bounded object/surface acceptance;
5. active-object warning before ritual completion;
6. ordinary removal and replacement under canonical carrying rules;
7. canonical trophy-case scoring and score-neutral museum surfaces;
8. provenance inspection;
9. house, ritual, dam, conflict, and nested-canary synthesis;
10. exposed-display theft into the real thief;
11. physical theft evidence;
12. canonical thief booty recovery;
13. deliberate corruption of surfaces, globals, custody, and case contents;
14. native `SAVE` and `RESTORE` without repair;
15. production/test isolation.

The qualification process rejected false assumptions instead of weakening the game:

- the object answers to `GUIDE`, not `GUIDEBOOK`;
- canonical carrying limits remain active;
- the bell warning is tested before ritual completion;
- unsupported em-dash rendering was removed;
- dam wording does not claim unproven cleaning state.

The permanent Release `1220` qualification passed before capstone documentation and bead updates began.

## Roadmap validator

The updated roadmap validator accepts only these Train 2 states:

- `in_progress`: Train 1's eight beads and Train 2 beads 001–007 closed — 15 closed / 81 open;
- `complete`: Train 1 and all eight Train 2 beads closed — 16 closed / 80 open.

All later trains must remain `planned`, and all later beads must remain `open`.

A dedicated `living-room-museum-beadtrain.yml` validates Train 2 against the sharded canonical issue ledger.

## Review state

At capstone-candidate preparation time:

- no submitted PR review existed;
- no inline review thread existed;
- CodeRabbit skipped because PR #17 targets a non-default stacked branch;
- Gemini Code Assist reported that its consumer review service has ended.

Perform a manual stacked-diff audit and post it to PR #17. Recheck live review state before closing bead 008.

## Canonical boundaries preserved

Release `1220` adds no:

- duplicate exhibit or treasure;
- display-token surrogate;
- parallel museum score;
- automatic trophy-case credit;
- trapped completion-critical object;
- generalized furniture or base building;
- maintenance chore loop;
- archive playback;
- Kitchen or Cellar expansion;
- equipment stash;
- death-site recovery;
- armor;
- Zork Plus;
- Wizard of Frobozz;
- production test commands.

## Next existing train after closure

Continue with Train 3:

`onyx_zork_house_kitchen_laboratory`

Its eight existing beads cover:

1. house water and container handling;
2. cleaning and residue consequences;
3. drying, warming, and cooling;
4. food preparation and creature offerings;
5. bounded heat, water, and utensil experiments;
6. cupboard and work-surface storage;
7. Kitchen gameplay and persistence qualification;
8. Kitchen laboratory capstone.

Do not create another planning document beneath those beads. Branch above exact qualified Release `1220` and implement them directly.

## Final product target

The house should become a museum, laboratory, archive, refuge, threshold, and possible target.

After completing the game, the player should be able to return to the Attic and replay the expedition through the evidence it left behind—then keep another completed run in a separate box and compare the two without pretending both histories happened at once.
