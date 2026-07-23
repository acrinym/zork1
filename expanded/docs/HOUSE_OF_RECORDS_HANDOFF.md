# House of Records Program — Continuation Handoff

## Repository

`acrinym/zork1`

## Roadmap branch

`agent/house-of-records-program`

This branch was created from exact qualified Release 1218 closure head:

`8d7182a48c5654dc2f6eec1101f7753a1a9c981f`

It intentionally does not modify or merge PR #12. Resolve the live PR associated with this branch at the start of the next session and keep it open and unmerged unless Justin explicitly gives the merge whistle.

## Resolve live state first

Do not blindly trust frozen SHAs, PR state, workflow counts, or branch relationships in this handoff.

At the beginning of the next session:

1. resolve exact `master`;
2. inspect PR #11 and PR #12 live state, review threads, checks, and mergeability;
3. resolve the exact head and base of `agent/house-of-records-program`;
4. find the roadmap PR for this branch;
5. read repository guidance and the current Glulx frontier;
6. validate all twelve planned beadtrains against all `issues*.jsonl` ledgers;
7. do not merge any stacked PR without explicit permission.

## What was added

The branch documents the **House of Records** program: an evolving white house plus a period-authentic Attic archive of the player's own adventure.

Canonical program document:

`expanded/docs/HOUSE_OF_RECORDS_PROGRAM.md`

Roadmap validator:

`.github/workflows/house-of-records-roadmap.yml`

Planned scope:

- 12 separate trains;
- 8 beads per train;
- 96 open implementation beads total;
- four additive issue shards;
- no production ZIL changes in this roadmap branch.

## Program thesis

The house evolves through adventure consequences, not chores.

The Attic records the player's actual run through late-1970s physical media: filing cabinets, index cards, banker boxes, line-printer transcripts, cassettes, microfiche, Polaroids, maps, folders, annotations, and a terse terminal.

The archive preserves notes, correspondence, meaningful NPC statements, actor relationships, area evidence, commands, outcomes, final state, and later separate completed expedition boxes.

## Planned trains

1. `onyx_zork_house_state_foundation`
2. `onyx_zork_house_living_museum`
3. `onyx_zork_house_kitchen_laboratory`
4. `onyx_zork_house_cellar_threshold`
5. `onyx_zork_house_correspondence_visitors`
6. `onyx_zork_attic_archive_core`
7. `onyx_zork_attic_npc_dossiers`
8. `onyx_zork_attic_area_case_files`
9. `onyx_zork_attic_playback`
10. `onyx_zork_house_rest_and_dreams`
11. `onyx_zork_house_vulnerability`
12. `onyx_zork_expedition_archive`

Every train is `planned`. No implementation bead is closed.

## Recommended implementation order

Start with **Train 1: evolving house state foundation**.

Suggested branch after resolving the live stack:

`agent/glulx-house-state-foundation`

The first production train should establish only:

- compact house condition, collection, knowledge, security, and atmosphere state;
- deterministic adventure-to-house event receipts;
- room-description projection for Living Room, Kitchen, Attic, Bedroom, and Cellar;
- explicit score, treasure, puzzle, and chore isolation;
- native save/restore and migration behavior;
- a narrow changed-path contract and test-only isolation.

Do not begin with displays, cassette playback, visitors, dreams, or multi-run comparison. They all need the foundation's stable event and persistence contract.

## Important architecture boundary

The archive should store structured evidence, not duplicate prose for every event.

A future archive record should be able to link:

- expedition;
- person;
- place;
- object;
- incident;
- quote;
- outcome;
- provenance;
- truth status;
- redaction state;
- annotation;
- physical medium;
- and related record IDs.

Playback must be observational and must never repair or mutate live game state.

## Canonical boundaries

Preserve:

- trophy-case scoring;
- real treasure and object identity;
- actor state and canonical behavior;
- existing house topology and entry routes;
- existing timers and puzzle solutions;
- ordinary native save files;
- Zork's parser identity.

Reject:

- base-building grind;
- crafting trees;
- survival meters;
- housekeeping chores;
- universal physics or chemistry;
- open-ended chatbot NPCs;
- modern cloud-storage metaphors;
- solution leaks from incomplete files;
- merged contradictory playthroughs;
- post-restore repair.

## Validation expectations

Each implementation train must use pinned toolchains, deterministic gameplay routes, deliberate state corruption, native `SAVE` / `RESTORE`, duplicate checks, truthful docs, and exact-head CI before closing beads.

The roadmap-only PR should validate exactly:

- 12 beadtrain files;
- 96 unique bead IDs;
- all trains structurally valid;
- program and handoff files present.

## Final product target

The house should become a museum, laboratory, archive, refuge, threshold, and possible target.

After completing the game, the player should be able to return to the Attic and replay the expedition through the evidence it left behind—then keep another completed run in a separate box and compare the two without pretending both histories happened at once.
