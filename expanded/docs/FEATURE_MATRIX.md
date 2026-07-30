# Zork I project-edition feature matrix

## Edition status

| Edition | Format | Identity | Status |
|---|---|---:|---|
| Historical | `.z3` | Release 119 / `880429` | Preserved and verified |
| Optimized | `.z3` | Release 120 / `260718` | Qualified |
| Expanded | `.z3` | Release 121 / `260719` | Qualified |
| Absurd Alternate | `.z3` | Release 122 / `260720` | Qualified |
| Upstream Glulx | `.ulx` | Release 1 / `251203` | Exact source and artifact qualified |
| Optimized through Room Density Glulx | `.ulx` | Releases 1201–1218 | Qualified lineage |
| House State Foundation Glulx | `.ulx` | Release 1219 / `260724` | Train 1 complete |
| Living Room Museum Glulx | `.ulx` | Release 1220 / `260724` | Train 2 complete |
| House Kitchen Laboratory Glulx | `.ulx` | Release 1221 / `260724` | Train 3 complete |
| House Cellar Threshold Glulx | `.ulx` | Release 1222 / `260724` | Train 4 complete |
| House Correspondence and Visitors Glulx | `.ulx` | Release 1223 / `260724` | Train 5 complete |
| Attic Archive Core Glulx | `.ulx` | Release 1224 / `260729` | Train 6 complete |
| Attic NPC Dossiers Glulx | `.ulx` | Release 1225 / `260729` | Train 7 complete |
| Attic Area Case Files Glulx | `.ulx` | Release 1226 / `260729` | Train 8 complete |
| Attic Playback Glulx | `.ulx` | Release 1227 / `260729` | Train 9 complete |
| House Rest and Dreams Glulx | `.ulx` | Release 1228 / `260730` | Train 10 complete |
| House Vulnerability Glulx | `.ulx` | Release 1229 / `260730` | Train 11 complete |
| Completed Expedition Archive Glulx | `.ulx` | Release 1230 / `260730` | Train 12 and program complete |

## Locked House of Records lineage

| Release | Purpose | Size | Checksum | SHA-256 |
|---:|---|---:|---|---|
| 1219 | House state foundation | 230,144 | `0xbe6bc80a` | `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f` |
| 1220 | Living Room museum | 237,312 | `0x630d724a` | `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4` |
| 1221 | House Kitchen laboratory | 249,600 | `0x85d64142` | `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f` |
| 1222 | House Cellar threshold | 262,400 | `0x54b04c7a` | `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912` |
| 1223 | House correspondence and visitors | 271,872 | `0x4cbcc561` | `362b5567e2ee705dc382256fe3420b9e729486acbcdf68b91a8ccdda0c893816` |
| 1224 | Attic archive core | 280,832 | `0x4fe371b8` | `c8490c39b3ee8a17e257419aa13998529086573ddb6172132998f8353e92a356` |
| 1225 | Attic NPC dossiers | 287,744 | `0x4b4d66a0` | `e775d0a5ab74f5115d09b380ac4397e845ef539a1260df166120e1c25594db10` |
| 1226 | Attic area case files | 298,496 | `0xc6b449e8` | `9a257606633e5595ab5c8c2f6d2c5813028c45e08389c805ca81ca113445f9f6` |
| 1227 | Attic playback | 307,712 | `0xfb794f11` | `6146311cd1fab20c5fde50f12a569c3ea9b34fd0f42038448f44f3740b9936f0` |
| 1228 | House rest and dreams | 316,160 | `0x3505b8ad` | `8993684cb8cb6e613dffc6e294c4d5edd15da22ab3a340ba4dc2d572f2f084e5` |
| 1229 | House vulnerability | 328,704 | `0xc774e968` | `94a665cb16069b31473dcf9fdf194d49c13e70aa23c32bd75888c78a074c3b4f` |
| 1230 | Completed expedition archive | 337,408 | `0x7febe444` | `b446e12ebffc570c0058347583bacc768f6a51f5f5166634da91898004d68c71` |

## Release 1230 — Completed Expedition Archive

Qualified behavior:

1. canonical `WON-FLAG` is the only master-archive completion gate;
2. pre-victory correspondence, dossiers, case files, playback, dreams, overnight reports, vulnerability files, and repair logs remain available;
3. `ARCHIVE EXPEDITION`, `SEAL EXPEDITION`, `REVIEW EXPEDITION`, `STATUS EXPEDITION`, `COMPARE EXPEDITIONS`, and `EXPORT EXPEDITION` are parser-native Attic routes;
4. each completed history gets its own physical banker box, master file, chronology roll, and final summary;
5. chronology copies only the bounded consequential playback sequence and records canonical death count separately;
6. final summaries retain score, deaths, observed outcomes, house incident history, repairs, and security;
7. box B never overwrites, corrects, or merges box A;
8. cross-run comparison reports only evidence present in the two sealed receipts;
9. missing evidence remains missing and no unseen commands, routes, ceremony order, solution text, or outcomes are revealed;
10. `EXPEDITION-EXPORT-01` is deterministic, human-readable, and schema-versioned;
11. conservative migration rematerializes physical records without synthesizing unavailable history;
12. native save, deliberate corruption, and exact restore preserve both histories and their physical custody;
13. no raw command log, cloud state, modern database, universal telemetry, or sub-beads.

GitHub Actions run `30577224174` passed the complete locked Release `1230` qualification.

## House of Records status

- 12 trains complete;
- 96 beads closed;
- 0 beads open;
- no sub-beads;
- program complete.

## Validation coverage

| Coverage | Proof |
|---|---|
| Base identity | Exact locked Release 1229 artifact SHA before staging |
| Production delta | Fail-closed four-path changed set |
| Artifact identity | 337,408 bytes / `0x7febe444` / exact SHA-256 |
| Production isolation | Train 12 setup and mutation verbs absent from production source and artifact |
| Completion truth | No master, comparison, or export before canonical victory |
| Chronology truth | Ordered bounded playback evidence plus canonical deaths; no raw command log |
| Separate-history truth | A and B master files remain in distinct physical banker boxes |
| Comparison boundary | Only sealed evidence is compared; missing and unseen alternatives are not disclosed |
| Export compatibility | Deterministic schema-1 human-readable receipt and conservative rematerialization |
| Persistence | Deliberate state and physical-record corruption followed by exact native restore |
| Roadmap integrity | 12 trains / 96 unique beads / 96 closed / 0 open |

## Program result

The House of Records is no longer a roadmap promise. Releases `1219` through `1230` form one locked, qualified Glulx lineage from lived-in house state through a completed-playthrough archive.
