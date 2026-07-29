# House of Records Program — Continuation Handoff

## Repository

`acrinym/zork1`

Default branch: `master`

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

Do not trust frozen branch heads or workflow counts without resolving GitHub live.

## Current stack

- PR #11: `agent/glulx-material-consequences`;
- PR #16: `agent/glulx-house-state-foundation`;
- PR #17: `agent/glulx-living-room-museum`;
- PR #18: `agent/glulx-house-kitchen-laboratory`;
- PR #19: `agent/glulx-house-cellar-threshold`;
- PR #21: `agent/glulx-house-correspondence-visitors`;
- PR #21 is stacked directly on exact Release 1222 closure head `72ca166d71f055c438906794a36988f2c742d834`;
- all production PRs remain open and unmerged absent explicit permission.

Resolve PR #21's exact live head before branching Train 6. The locked production qualifier and capstone audit are followed by documentation/ledger cleanup commits, so do not use an earlier SHA as the branch head.

## Hierarchy rule

The program has exactly:

- 12 trains;
- 8 beads per train;
- 96 beads total.

Do not create sub-beads, sub-trains, or a parallel planning document. Execute existing beads directly.

## Current roadmap state

- Trains 1–5 complete;
- 40 closed beads;
- 56 open beads across Trains 6–12;
- no sub-beads, sub-trains, or planning hierarchy beneath the existing beads.

## Locked lineage

| Train | Release | Size | Checksum | SHA-256 |
|---:|---:|---:|---|---|
| 1 | 1219 | 230,144 | `0xbe6bc80a` | `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f` |
| 2 | 1220 | 237,312 | `0x630d724a` | `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4` |
| 3 | 1221 | 249,600 | `0x85d64142` | `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f` |
| 4 | 1222 | 262,400 | `0x54b04c7a` | `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912` |
| 5 | 1223 | 271,872 | `0x4cbcc561` | `362b5567e2ee705dc382256fe3420b9e729486acbcdf68b91a8ccdda0c893816` |

## Train 5 closure

Train:

`onyx_zork_house_correspondence_visitors`

Status:

`complete`

All eight existing beads are closed.

Exact capstone-candidate audit head:

`7e9019dc3c336413ea07df400341fa6474a3cff6`

All 33 candidate workflows passed with no retry. The manual stacked-scope audit found no submitted review, inline review thread, or unresolved actionable finding. PR #21 remained open, mergeable, and unmerged.

### Exact base

- Release `1222` closure head `72ca166d71f055c438906794a36988f2c742d834`;
- artifact SHA-256 `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912`.

### Exact production delta

- `1actions.zil`;
- `assistance.zil`;
- new `house_correspondence_visitors.zil`;
- `shadow_logic.zil`;
- `zork1.zil`.

### Product behavior

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

### Important corrections that must not regress

- the first compile exceeded the Glulx global limit by one; the mutable packed table is addressed through a constant symbol instead of a global pointer;
- visitor bit clearing uses known-present power-of-two subtraction rather than an unproven complement operation;
- use `RESPOND TO <LETTER>` because `REPLY` is claimed by canonical grammar;
- use `PUT STAMPED CARD IN MAILBOX` because `REPLY CARD` is not a valid noun phrase;
- parsed card posting dispatches through the shared mail action hook before canonical `PUT` can retain a sent card;
- ordinary `TELL SURVEYOR` / `TELL COURIER` engages visitors;
- visitor objects explicitly route custom `ADMIT` and `REFUSE` actions;
- arrival defers during posting and departure, so absence creates a real missed notice before one bounded return;
- `ADMIT` means an exterior exchange or inspection; the boarded door never opens;
- qualification proves leaflet preservation through canonical custody rather than moving it for the test;
- deliberate corruption removes Cellar intrusion, museum theft, and repaired-dam triggers before asserting zero, then native restore recovers exact state.

## Next existing train

Continue directly with:

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

## Train 6 boundary

Branch from the exact live PR #21 head after resolving it and confirming the current checks. Preserve the qualified Release `1223` artifact and five-path production boundary.

Train 6 may consume stable correspondence filing codes and status receipts, but it must not move, recreate, consume, or repair live mail or visitor state.

Build a complete period-authentic archive substrate in the canonical Attic. Do not build a modern filesystem, cloud drive, email inbox, universal world logger, raw transcript dump, open-ended database, duplicate record system, unseen-solution revealer, or playback engine that mutates live state.

Keep PRs open and unmerged unless Justin explicitly gives the merge whistle.
