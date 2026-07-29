# House of Records Program — Continuation Handoff

## Repository

`acrinym/zork1`

## Resolve live state first

At the start of the next session:

1. resolve exact `master`;
2. enumerate every open PR;
3. inspect PRs #11, #16, #17, #18, #19, and #21 metadata, comments, reviews, inline threads, bases, heads, mergeability, and checks;
4. confirm whether any stacked branch advanced;
5. read `expanded/docs/HOUSE_OF_RECORDS_PROGRAM.md`;
6. read the Release 1219–1223 README files and Train 3–5 contracts/matrices;
7. validate all twelve House of Records trains against all four issue shards;
8. preserve every locked artifact identity and changed-path boundary;
9. do not merge any PR without Justin's explicit merge whistle.

Do not trust frozen SHAs or workflow counts without resolving GitHub live.

## Stack at this handoff

- default branch: `master`;
- PR #11: `agent/glulx-material-consequences`;
- PR #16: `agent/glulx-house-state-foundation`;
- PR #17: `agent/glulx-living-room-museum`;
- PR #18: `agent/glulx-house-kitchen-laboratory`;
- PR #19: `agent/glulx-house-cellar-threshold`;
- PR #21: `agent/glulx-house-correspondence-visitors`;
- PR #21 is stacked directly on exact Release 1222 closure head `72ca166d71f055c438906794a36988f2c742d834`;
- all production PRs remain open and unmerged absent explicit permission.

Resolve PR #21's exact live head. The locked production qualifier is followed by candidate documentation and ledger commits, so do not use an earlier SHA as the current branch head.

## Hierarchy rule

The program has exactly:

- 12 trains;
- 8 beads per train;
- 96 beads total.

Do not create sub-beads, sub-trains, or a parallel planning document. Execute existing beads directly.

## Current roadmap state

Capstone-candidate truth:

- Trains 1–4 complete — 32 closed beads;
- Train 5 has beads 001–007 closed and bead 008 open;
- Trains 6–12 planned;
- total: 39 closed / 57 open.

Final Train 5 closure must produce 40 closed / 56 open.

## Locked lineage

| Train | Release | Size | Checksum | SHA-256 |
|---:|---:|---:|---|---|
| 1 | 1219 | 230,144 | `0xbe6bc80a` | `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f` |
| 2 | 1220 | 237,312 | `0x630d724a` | `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4` |
| 3 | 1221 | 249,600 | `0x85d64142` | `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f` |
| 4 | 1222 | 262,400 | `0x54b04c7a` | `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912` |
| 5 | 1223 | 271,872 | `0x4cbcc561` | `362b5567e2ee705dc382256fe3420b9e729486acbcdf68b91a8ccdda0c893816` |

## Train 4 closure

Train: `onyx_zork_house_cellar_threshold`

Status: `complete`

Exact closure head:

`72ca166d71f055c438906794a36988f2c742d834`

All 31 workflows passed. PR #19 remained open, mergeable, and unmerged with no submitted review or inline thread.

## Train 5 — Release 1223

Train: `onyx_zork_house_correspondence_visitors`

Status: `in_progress` — beads 001–007 closed; capstone bead 008 open.

Exact base:

- Release `1222` closure head `72ca166d71f055c438906794a36988f2c742d834`;
- artifact SHA-256 `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912`.

Exact production delta:

- `1actions.zil`;
- `assistance.zil`;
- new `house_correspondence_visitors.zil`;
- `shadow_logic.zil`;
- `zork1.zil`.

Release `1223` preserves the canonical West of House, anchored mailbox, original leaflet, boarded front door, exits, and score.

It adds:

- three unique physical letters triggered by real Cellar intrusion, museum theft, and repaired-dam state;
- deterministic Cellar → museum → dam delivery order;
- sender/source, trigger, delivery, authenticity, and filing-code provenance;
- one reusable fixed-text stamped reply card;
- a threshold surveyor and uniformed courier as exterior visitors;
- unique missed notices and one bounded return;
- a signed courier receipt and numbered survey tag;
- packed native-save state and `RECAP` receipts.

## Important Train 5 corrections

Do not regress these:

- the first compile exceeded the Glulx global limit by one; the mutable packed table is addressed through a constant symbol instead of a global pointer;
- visitor bit clearing uses known-present power-of-two subtraction rather than an unproven complement operation;
- use `RESPOND TO <LETTER>` because `REPLY` is claimed by canonical grammar;
- use `PUT STAMPED CARD IN MAILBOX` because `REPLY CARD` is not a valid noun phrase;
- parsed card posting dispatches through the shared mail action hook before canonical `PUT` can move a sent card back into the mailbox;
- ordinary `TELL SURVEYOR` / `TELL COURIER` engages visitors;
- visitor objects explicitly route custom `ADMIT` and `REFUSE` actions;
- arrival defers during posting and departure, so absence creates a real missed notice before one bounded return;
- `ADMIT` means an exterior exchange or inspection; the boarded door never opens;
- qualification proves leaflet preservation through canonical custody rather than reading/moving it for the test;
- deliberate corruption removes Cellar intrusion, museum theft, and repaired-dam triggers before asserting zero, then native restore recovers exact state.

## Qualified Train 5 route

The permanent pinned route proves:

1. exact Release 1222 base and five-path staging;
2. exact Release 1223 artifact identity;
3. ordered one-time letter delivery;
4. complete provenance;
5. canonical mailbox and leaflet preservation;
6. one exact fixed-text stamped reply card;
7. physical missed notices and bounded revisits;
8. ordinary visitor conversation, refusal, and exterior acceptance;
9. unique receipt and survey tag;
10. no duplicate or regenerated correspondence;
11. native save, deliberate trigger removal/corruption, and exact restore;
12. strict production/test isolation.

## Train 5 capstone closure checklist

Before closing `zork1-house-mail-008`:

1. resolve PR #21 exact candidate head;
2. confirm the permanent Release 1223 qualifier passes there;
3. confirm the Train 5 bead validator passes;
4. confirm the House roadmap validates 39 closed / 57 open;
5. inspect all inherited workflows;
6. inspect PR comments, reviews, and inline threads;
7. post a manual stacked-scope audit;
8. close bead 008 only after the exact candidate is green;
9. set Train 5 to `complete` and publish 40 closed / 56 open;
10. run the exact final closure matrix;
11. keep PR #21 open and unmerged.

## Next existing train

After Train 5 closure, continue directly with:

`onyx_zork_attic_archive_core`

Its eight existing beads are:

1. canonical archive-record schema;
2. late-1970s physical media taxonomy;
3. card catalog and deterministic indexing;
4. Attic filing surfaces and capacity model;
5. explicit archive query and retrieval commands;
6. provenance, truth status, and annotations;
7. archive save/restore and migration;
8. Attic archive-core capstone.

Train 6 should branch from the exact qualified Release 1223 closure head after resolving it live. It may consume stable correspondence filing codes and statuses, but must not move, recreate, or repair live mail state.
