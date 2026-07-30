# House of Records Program — Completion and Merge Handoff

## Repository

`acrinym/zork1`

Default branch: `master`

## Program state

The House of Records program is complete:

- 12 trains complete;
- 96 beads closed;
- 0 beads open;
- Releases `1219` through `1230` qualified;
- no sub-beads or replacement planning hierarchy.

## Authorized production stack

Justin gave the explicit merge whistle for the complete House of Records production lineage on July 30, 2026.

Merge oldest-first:

1. PR #26 — `agent/glulx-attic-area-case-files` — Release `1226`;
2. PR #27 — `agent/glulx-attic-playback` — Release `1227`;
3. PR #28 — `agent/glulx-house-rest-and-dreams` — Release `1228`;
4. PR #29 — `agent/glulx-house-vulnerability` — Release `1229`;
5. PR #32 — `agent/glulx-completed-expedition-archive` — Release `1230`.

PR #31 is a separate future-ideas lane and is not part of this merge authorization.

Before any future continuation, resolve GitHub live rather than trusting frozen heads, merge refs, review state, or checks.

## Locked lineage

| Train | Release | Size | Checksum | SHA-256 |
|---:|---:|---:|---|---|
| 1 | 1219 | 230,144 | `0xbe6bc80a` | `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f` |
| 2 | 1220 | 237,312 | `0x630d724a` | `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4` |
| 3 | 1221 | 249,600 | `0x85d64142` | `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f` |
| 4 | 1222 | 262,400 | `0x54b04c7a` | `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912` |
| 5 | 1223 | 271,872 | `0x4cbcc561` | `362b5567e2ee705dc382256fe3420b9e729486acbcdf68b91a8ccdda0c893816` |
| 6 | 1224 | 280,832 | `0x4fe371b8` | `c8490c39b3ee8a17e257419aa13998529086573ddb6172132998f8353e92a356` |
| 7 | 1225 | 287,744 | `0x4b4d66a0` | `e775d0a5ab74f5115d09b380ac4397e845ef539a1260df166120e1c25594db10` |
| 8 | 1226 | 298,496 | `0xc6b449e8` | `9a257606633e5595ab5c8c2f6d2c5813028c45e08389c805ca81ca113445f9f6` |
| 9 | 1227 | 307,712 | `0xfb794f11` | `6146311cd1fab20c5fde50f12a569c3ea9b34fd0f42038448f44f3740b9936f0` |
| 10 | 1228 | 316,160 | `0x3505b8ad` | `8993684cb8cb6e613dffc6e294c4d5edd15da22ab3a340ba4dc2d572f2f084e5` |
| 11 | 1229 | 328,704 | `0xc774e968` | `94a665cb16069b31473dcf9fdf194d49c13e70aa23c32bd75888c78a074c3b4f` |
| 12 | 1230 | 337,408 | `0x7febe444` | `b446e12ebffc570c0058347583bacc768f6a51f5f5166634da91898004d68c71` |

## Train 12 closure

Train: `onyx_zork_expedition_archive`

Status: `complete`

PR: #32

Release `1230` adds:

- a master completed-history index gated solely by canonical `WON-FLAG`;
- all partial pre-victory archive layers remain usable;
- physical A and B banker boxes with separate master files, chronology rolls, and final summaries;
- bounded ordered chronology from existing consequential playback plus canonical deaths;
- final score, outcome, incident, repair, and security snapshots;
- non-merging cross-run comparison;
- explicit missing-evidence and unseen-alternative boundaries;
- deterministic schema-versioned `EXPEDITION-EXPORT-01`;
- conservative rematerialization from native state;
- native save, deliberate corruption, and exact restore.

Locked GitHub Actions run `30577224174` passed:

- exact Release `1229` ancestry;
- four-path fail-closed production staging;
- zero smell errors;
- exact locked Release `1230` identity;
- production no-unearned-master smoke;
- genuine victory gating;
- two separately sealed completed histories;
- chronology, final-state summaries, comparison, and export;
- physical custody checks;
- native `SAVE` / corruption / `RESTORE`.

Exact identity:

- Release `1230` / serial `260730`;
- 337,408 bytes;
- checksum `0x7febe444`;
- SHA-256 `b446e12ebffc570c0058347583bacc768f6a51f5f5166634da91898004d68c71`.

## Controlling records

- `expanded/docs/HOUSE_OF_RECORDS_PROGRAM.md`;
- `expanded/docs/FEATURE_MATRIX.md`;
- `expanded/docs/COMPLETED_EXPEDITION_ARCHIVE_CONTRACT.md`;
- `glulx/completed-expedition-archive/README.md`;
- `.beads/onyx_zork_expedition_archive.beadtrain`;
- `.beads/issues-zork-house-of-records-04.jsonl`.

## Future work boundary

The completed program should remain closed. New Zork product work may continue in separate lanes—museum expansion, fishing, food and cooking, Stalker-style systems, or other approved ideas—but must not reopen the House of Records through recursive audits, sub-beads, or invented unfinished work.
