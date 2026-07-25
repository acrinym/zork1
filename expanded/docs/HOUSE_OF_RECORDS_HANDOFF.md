# House of Records Program — Continuation Handoff

## Repository

`acrinym/zork1`

## Resolve live state first

At the start of the next session:

1. resolve exact `master`;
2. inspect every open PR;
3. read PRs #11, #16, #17, and #18 metadata, comments, reviews, inline threads, bases, heads, mergeability, and checks;
4. confirm whether any stacked branch advanced;
5. read `expanded/docs/HOUSE_OF_RECORDS_PROGRAM.md`;
6. read the Release 1219, 1220, and 1221 README files;
7. validate all twelve House of Records trains against all four issue shards;
8. preserve the locked Release identities and changed-path boundaries;
9. do not merge any PR without Justin's explicit merge whistle.

Do not trust frozen SHAs or check counts without resolving GitHub live.

## Stack at this handoff

- default branch: `master`;
- PR #11: `agent/glulx-material-consequences`;
- PR #16: `agent/glulx-house-state-foundation`;
- PR #17: `agent/glulx-living-room-museum`;
- PR #18: `agent/glulx-house-kitchen-laboratory`;
- PR #18 is stacked directly on exact qualified Release 1220 head `f1213a02139a1a305f54f024cc60f98175aac3fa`;
- all production PRs remain open and unmerged absent explicit permission.

Resolve PR #18's exact live closure head. The last fully qualified capstone-candidate head was:

`f540c6b12c7b56bceedbf8bee8ddae3966416ccb`

All 29 candidate workflows passed there. Final ledger/document closure commits advanced the branch afterward, so do not treat the candidate SHA as the current branch head.

## Hierarchy rule

The House of Records program has exactly:

- 12 trains;
- 8 beads per train;
- 96 beads total.

Do not create sub-beads, sub-trains, or a parallel planning document beneath the beads. Execute the existing beads directly.

PR #15, the death/object-fate planning detour, was closed without merge.

## Current roadmap state

- Train 1 complete — 8 closed beads;
- Train 2 complete — 8 closed beads;
- Train 3 complete — 8 closed beads;
- Trains 4–12 planned;
- total: 24 closed / 72 open.

## Train 1 — Release 1219

Train:

`onyx_zork_house_state_foundation`

Locked identity:

- Release `1219` / serial `260724`;
- 230,144 bytes;
- checksum `0xbe6bc80a`;
- SHA-256 `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f`.

Exact production delta:

- `1actions.zil`;
- `1dungeon.zil`;
- `assistance.zil`;
- new `house_state_foundation.zil`;
- `zork1.zil`.

It established versioned condition, collection, knowledge, security, and atmosphere state; bounded house receipts; canonical room projection; conservative migration; and native save/restore without repair.

## Train 2 — Release 1220

Train:

`onyx_zork_house_living_museum`

Locked identity:

- Release `1220` / serial `260724`;
- 237,312 bytes;
- checksum `0x630d724a`;
- SHA-256 `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4`.

Exact production delta:

- `1actions.zil`;
- `assistance.zil`;
- new `living_room_museum.zil`;
- `zork1.zil`.

It added real-object display surfaces, canonical trophy-case scoring isolation, provenance, synthesis, physical theft evidence, canonical thief recovery, and native object-tree persistence.

## Train 3 — Release 1221

Train:

`onyx_zork_house_kitchen_laboratory`

Status:

`complete`

All eight existing Train 3 beads are closed.

Locked identity:

- edition: Unofficial House Kitchen Laboratory Glulx;
- Release `1221` / serial `260724`;
- Glulx `3.1.3` / `0x00030103`;
- 249,600 bytes;
- checksum `0x85d64142`;
- SHA-256 `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f`.

Exact base:

- Release `1220` SHA-256 `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4`.

Exact production delta:

- `1actions.zil`;
- `assistance.zil`;
- new `house_kitchen_laboratory.zil`;
- `shadow_logic.zil`;
- `zork1.zil`.

Release `1221` adds four fixed Kitchen fixtures:

- porcelain sink;
- wooden worktop;
- wooden cupboard;
- cast-iron range.

It uses the real bottle, one canonical `WATER` object, real lunch and garlic, real knives and tools, existing material-clean flags, and the existing rusty-knife consequence.

Qualified routes prove:

1. bottle refill without cloning water;
2. selected washing and drying;
3. temporary range heat from a real held flame;
4. food and water warming;
5. heat-drying without bonuses or repairs;
6. prepared real lunch and canonically cut real garlic;
7. bounded quenching and worktop rinsing;
8. ordinary fixture object-tree storage;
9. bat and cyclops offering context without replacement solutions;
10. Kitchen `RECAP` receipts;
11. native save, deliberate corruption, and exact restore;
12. strict production/test isolation.

## Important qualification corrections

Do not regress these:

- the first compile exceeded the Glulx ZIL global-variable ceiling; all Kitchen state is packed into one indexed persistent table;
- the parser requires `NASTY KNIFE` to distinguish it from the rusty knife;
- ordinary `PUT` changes real custody, so qualification uses ordinary `TAKE` before moving worktop items into the cupboard;
- `SLICE` routes to canonical `CUT`; Release 1221 intercepts only garlic with the real nasty knife and delegates every other cut unchanged;
- no test-only helper enters production.

## Capstone evidence

The exact capstone-candidate head `f540c6b12c7b56bceedbf8bee8ddae3966416ccb` passed all 29 workflows.

One inherited Release 122 real-map route initially failed because random troll combat knocked out and killed the test player before the scripted restraint route began. The unchanged Release 122 artifact had rebuilt correctly. Retry of only that failed job passed; no Train 3 production change was required.

Manual stacked-scope audit found no unresolved actionable issue. PR #18 had no submitted review or inline review thread. CodeRabbit skipped the non-default stacked base, and Gemini consumer review has ended.

## Explicit exclusions

Release `1221` adds no:

- hunger or thirst meter;
- mandatory chores;
- recipe economy or generic crafting;
- universal chemistry;
- automatic puzzle-water replenishment;
- duplicate food, water, tool, or puzzle object;
- broad fire or flood simulation;
- new score or automatic puzzle completion;
- sub-bead or parallel planning layer.

## Next existing train

Continue directly with:

`onyx_zork_house_cellar_threshold`

Its eight existing beads cover:

1. expedition staging and equipment boundary;
2. trap-door and threshold sensing;
3. light and tool readiness;
4. carried-hazard screening;
5. limited containment;
6. intrusion and upward-consequence hooks;
7. Cellar gameplay and persistence qualification;
8. Cellar threshold capstone.

Branch Train 4 directly from the exact qualified Release 1221 closure head after resolving it live. Do not create another planning layer beneath those beads.
