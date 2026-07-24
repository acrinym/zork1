# Glulx Release 1221 — House Kitchen Laboratory

## Status

Qualified House of Records Train 3 implementation above exact Living Room Museum Release `1220`.

Train:

`onyx_zork_house_kitchen_laboratory`

Current capstone-candidate state is seven closed implementation/qualification beads and one open capstone bead. No sub-beads, sub-trains, or parallel planning hierarchy exist.

## Locked identity

- edition: Unofficial House Kitchen Laboratory Glulx;
- release: `1221`;
- serial: `260724`;
- output: `zork1-glulx-house-kitchen-laboratory.ulx`;
- Glulx version: `3.1.3` / `0x00030103`;
- size: `249,600` bytes;
- checksum: `0x85d64142`;
- SHA-256: `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f`.

Exact base Release `1220` SHA-256:

`f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4`

## Exact production delta

Release `1221` changes exactly:

- `1actions.zil`;
- `assistance.zil`;
- new `house_kitchen_laboratory.zil`;
- `shadow_logic.zil`;
- `zork1.zil`.

The stager rejects every other production change. Test-only setup, actor placement, mutation, and reporting verbs never enter production.

## Product boundary

The canonical Kitchen gains four fixed fixtures:

- porcelain sink;
- wooden worktop;
- wooden cupboard;
- cast-iron range.

The layer uses the real bottle, the single canonical `WATER` object, the real lunch and garlic, the real knives and tools, existing material-cleaning state, and the existing rusty-knife consequence.

Selected interactions cover:

- refilling the real bottle without cloning water;
- washing and drying selected real tools and containers;
- temporary range heat from a real held flame;
- warming ordinary food and water;
- drying wet metal without granting bonuses or repairs;
- preparing the existing lunch;
- routing canonical `CUT` for the existing garlic and nasty knife through bounded preparation;
- bounded water-on-hot-iron and worktop-cleaning reactions;
- ordinary object-tree storage on the worktop, in the sink, in the cupboard, or on the range;
- authored offering context for the bat and cyclops without replacing canonical solutions;
- concise `RECAP` receipts;
- native save, deliberate corruption, and exact restore.

All Kitchen state is packed into one indexed persistent table so Release `1221` remains within the Glulx ZIL global-variable limit without dropping behavior or persistence.

## Qualification

The permanent pinned route proves:

1. exact Release `1220` base identity;
2. exact five-path production staging;
3. exact Release `1221` size, checksum, and SHA-256;
4. one canonical portable-water object and bottle refill without cloning;
5. selected sink cleaning plus existing rusty-knife worsening;
6. bounded drying, warming, cooling, and quenching;
7. real lunch and garlic preparation;
8. canonical `CUT` integration rather than competing parser grammar;
9. ordinary object-tree storage and retrieval;
10. authored bat and cyclops offering context while canonical actor behavior remains active;
11. packed Kitchen state and fixture contents through native `SAVE` and `RESTORE` after deliberate corruption;
12. production/test isolation.

## Explicit exclusions

No hunger or thirst meter, mandatory chores, recipe economy, generic crafting, universal chemistry, automatic puzzle-water replenishment, duplicated objects, broad fire/flood simulation, parallel score, or automatic puzzle completion.
