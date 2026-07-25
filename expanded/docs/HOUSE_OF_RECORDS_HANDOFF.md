# House of Records Program — Continuation Handoff

## Repository

`acrinym/zork1`

## Resolve live state first

At the start of the next session:

1. resolve exact `master`;
2. inspect every open PR;
3. read PRs #11, #16, #17, #18, and #19 metadata, comments, reviews, inline threads, bases, heads, mergeability, and checks;
4. confirm whether any stacked branch advanced;
5. read `expanded/docs/HOUSE_OF_RECORDS_PROGRAM.md`;
6. read the Release 1219–1222 README files and Train 3–4 matrices;
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
- PR #19: `agent/glulx-house-cellar-threshold`;
- PR #19 is stacked directly on exact qualified Release 1221 closure head `abe598b45ed3aa7ffcbd843b7a652e33bc9e0c16`;
- all production PRs remain open and unmerged absent explicit permission.

Resolve PR #19's exact live head. The qualified implementation head was followed by documentation and ledger commits, so do not rely on a frozen branch SHA.

## Hierarchy rule

The House of Records program has exactly:

- 12 trains;
- 8 beads per train;
- 96 beads total.

Do not create sub-beads, sub-trains, or a parallel planning document beneath the beads. Execute the existing beads directly.

PR #15, the death/object-fate planning detour, was closed without merge.

## Current roadmap state

Capstone-candidate truth:

- Train 1 complete — 8 closed beads;
- Train 2 complete — 8 closed beads;
- Train 3 complete — 8 closed beads;
- Train 4 in progress — 7 closed beads and capstone bead 008 open;
- Trains 5–12 planned;
- total: 31 closed / 65 open.

Final Train 4 closure must produce 32 closed / 64 open.

## Train 1 — Release 1219

Locked identity:

- Release `1219` / serial `260724`;
- 230,144 bytes;
- checksum `0xbe6bc80a`;
- SHA-256 `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f`.

It established compact house condition, collection, knowledge, security, and atmosphere state; bounded receipts; canonical room projection; migration; and native restore.

## Train 2 — Release 1220

Locked identity:

- Release `1220` / serial `260724`;
- 237,312 bytes;
- checksum `0x630d724a`;
- SHA-256 `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4`.

It added real-object Living Room displays, canonical score isolation, provenance, synthesis, physical theft evidence, canonical thief recovery, and object-tree persistence.

## Train 3 — Release 1221

Train: `onyx_zork_house_kitchen_laboratory`

Status: `complete`

Locked identity:

- Release `1221` / serial `260724`;
- 249,600 bytes;
- checksum `0x85d64142`;
- SHA-256 `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f`.

It added bounded real-water handling, cleaning, drying, temporary heat, food preparation, selected experiments, ordinary Kitchen storage, packed persistence, and exact restore.

## Train 4 — Release 1222

Train: `onyx_zork_house_cellar_threshold`

Status: `in_progress` — beads 001–007 closed; bead 008 open pending exact capstone validation.

Locked identity:

- edition: Unofficial House Cellar Threshold Glulx;
- Release `1222` / serial `260724`;
- Glulx `3.1.3` / `0x00030103`;
- 262,400 bytes;
- checksum `0x54b04c7a`;
- SHA-256 `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912`.

Exact base:

- Release `1221` SHA-256 `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f`.

Exact production delta:

- `1actions.zil`;
- `assistance.zil`;
- new `house_cellar_threshold.zil`;
- `shadow_logic.zil`;
- `zork1.zil`.

Release `1222` adds:

- stone staging bench;
- iron gear hooks;
- closable stone quarantine niche;
- targetable threshold, sounds, drafts, dampness, and physical evidence;
- an observational Cellar underside of the real trap door;
- packed threshold state and receipts.

Qualified routes prove:

1. canonical trap-door descent and original slam/bar;
2. Cellar-side state observation without duplicate door, lock, or exit;
3. actual carried/staged readiness without loadout automation;
4. ordinary real-object staging and retrieval;
5. bounded sounds, drafts, dampness, and threshold sensing;
6. darkness, flame, water, wet-metal, fragile/living, supernatural, and unstable warnings;
7. recoverable quarantine and live-flame refusal;
8. thief, creature, loose-water, smoke, and supernatural evidence;
9. causal real-water evidence cleanup;
10. Cellar `RECAP` receipts;
11. native save, deliberate corruption, and exact restore;
12. strict production/test isolation.

## Important qualification corrections

Do not regress these:

- the first loader draft had an escaped-quote defect, an unclosed ZIL form, and bit/routine collisions; it was replaced with a balanced module;
- this parser has no `TOUCH` action symbol, so tactile threshold inspection uses canonical `RUB`;
- the original trap-door object canonically lives in the Living Room and is not parser-visible from below; `UNDERSIDE` exposes observation only;
- staged rope and wrench correctly stop counting as carried readiness;
- evidence returns while its real actor/object/flame/water/supernatural cause remains present;
- cleanup is qualified after live causes are gone;
- deliberate corruption removes all live causes before asserting zero, then native restore recovers exact state and custody;
- no test-only helper enters production.

## Explicit exclusions

Release `1222` adds no:

- inventory automation or equipment classes;
- unlimited storage or remote retrieval;
- generic hazard simulation;
- broad smoke, water, fire, creature, or supernatural propagation;
- automatic puzzle preparation, safe passage, or route unlocking;
- duplicate door, object, actor, light, tool, hazard, or puzzle object;
- new score or automatic puzzle completion;
- sub-bead or parallel planning layer.

## Train 4 capstone closure checklist

Before closing `zork1-house-cellar-008`:

1. resolve PR #19 exact head;
2. confirm the permanent Release 1222 qualifier passes;
3. confirm the Train 4 bead validator passes;
4. confirm the House roadmap validates 31 closed / 65 open;
5. inspect every inherited workflow;
6. inspect PR comments, reviews, and inline threads;
7. post a manual stacked-scope audit;
8. close bead 008 only after the exact capstone candidate is green;
9. set Train 4 to `complete` and publish 32 closed / 64 open;
10. keep PR #19 open and unmerged.

## Next existing train

After Train 4 closure, continue directly with:

`onyx_zork_house_correspondence_visitors`

Its eight existing beads cover:

1. deterministic correspondence queue;
2. letter and note provenance;
3. canonical mailbox delivery and retrieval;
4. bounded replies and outgoing mail;
5. knocks, visitors, and optional entry;
6. missed delivery and revisit behavior;
7. correspondence gameplay and persistence;
8. correspondence and visitors capstone.

Do not create another planning layer beneath those beads.
