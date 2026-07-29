# Zork I project-edition feature matrix

## Edition status

| Edition | Format | Identity | Status |
|---|---|---:|---|
| Historical | `.z3` | Release 119 / `880429` | Preserved and verified |
| Optimized | `.z3` | Release 120 / `260718` | Qualified |
| Expanded | `.z3` | Release 121 / `260719` | Qualified |
| Absurd Alternate | `.z3` | Release 122 / `260720` | Qualified |
| Upstream Glulx | `.ulx` | Release 1 / `251203` | Exact source and artifact qualified |
| Optimized Glulx | `.ulx` | Release 1201 / `260719` | Qualified |
| Assisted Glulx | `.ulx` | Release 1211 / `260719` | Qualified |
| Reactive Surface Glulx | `.ulx` | Release 1212 / `260719` | Qualified |
| Shadow Logic Glulx | `.ulx` | Release 1213 / `260720` | Qualified |
| Absurd Alternate Glulx | `.ulx` | Release 1214 / `260720` | Qualified semantic parity |
| Dam Mechanisms Glulx | `.ulx` | Release 1215 / `260720` | Qualified |
| Ritual Resonance Glulx | `.ulx` | Release 1216 / `260720` | Qualified |
| Material Consequences Glulx | `.ulx` | Release 1217 / `260722` | Qualified |
| Room Density Glulx | `.ulx` | Release 1218 / `260723` | Qualified |
| House State Foundation Glulx | `.ulx` | Release 1219 / `260724` | Train 1 complete |
| Living Room Museum Glulx | `.ulx` | Release 1220 / `260724` | Train 2 complete |
| House Kitchen Laboratory Glulx | `.ulx` | Release 1221 / `260724` | Train 3 complete |
| House Cellar Threshold Glulx | `.ulx` | Release 1222 / `260724` | Train 4 complete |
| House Correspondence and Visitors Glulx | `.ulx` | Release 1223 / `260724` | Train 5 complete |

## Locked Glulx lineage

| Release | Purpose | Size | Checksum | SHA-256 |
|---:|---|---:|---|---|
| 1214 | Release 122 parity | 202,240 | `0x53f5066d` | `10ea136e389aef8bf9e629ea854ea97ba69f1e5df3b9024540abc91cc61f0628` |
| 1215 | Dam mechanisms | 207,360 | `0x3d135bb8` | `ea23c8ff739348162f32c798ff0ad6f5e8e6a4d310ad3daf5c2da58b86505eed` |
| 1216 | Ritual resonance | 211,968 | `0x3d27d123` | `4f406e656b892feb5224e4e52afb98768417e1e761918334dfa94595e6091db2` |
| 1217 | Material consequences | 217,344 | `0xb0028984` | `2714d63760fa890be9ece3b23fc91bab67a660c42675e0302b745173aba700da` |
| 1218 | Room density | 227,840 | `0x3b65ecaf` | `efc8bd9f264f60bb56f2daf3e4d7d6d32a272997434802ee76455781a8edf521` |
| 1219 | House state foundation | 230,144 | `0xbe6bc80a` | `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f` |
| 1220 | Living Room museum | 237,312 | `0x630d724a` | `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4` |
| 1221 | House Kitchen laboratory | 249,600 | `0x85d64142` | `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f` |
| 1222 | House Cellar threshold | 262,400 | `0x54b04c7a` | `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912` |
| 1223 | House correspondence and visitors | 271,872 | `0x4cbcc561` | `362b5567e2ee705dc382256fe3420b9e729486acbcdf68b91a8ccdda0c893816` |

## Release 1219 — House State Foundation

Compact versioned house state, bounded receipts, canonical room projection, real trophy-case collection authority, conservative migration, and exact native restore.

## Release 1220 — Living Room Museum

Real-object display surfaces, canonical score isolation, provenance, group synthesis, canonical thief custody/recovery, physical evidence, nested-object persistence, and production/test isolation.

## Release 1221 — House Kitchen Laboratory

Canonical water and container handling, selected cleaning and wetness, bounded temporary heat, food preparation, canonical garlic cutting, selected experiments, ordinary storage, packed persistence, and exact restore.

## Release 1222 — House Cellar Threshold

Canonical trap-door descent and slam/bar, observational underside without a duplicate route, real-object staging, readiness, bounded sensing, carried-hazard warnings, recoverable quarantine, causal intrusion evidence, real-water cleanup, packed persistence, and exact restore.

## Release 1223 — House Correspondence and Visitors

Exact Release `1222` plus:

- `1actions.zil`;
- `assistance.zil`;
- new `house_correspondence_visitors.zil`;
- `shadow_logic.zil`;
- `zork1.zil`.

Qualified behavior:

1. deterministic Cellar → museum → dam correspondence order;
2. three exact physical authored letters, one per real trigger;
3. sender/source, trigger, delivery, authenticity, and filing-code provenance;
4. canonical anchored mailbox and original leaflet preservation;
5. one reusable fixed-text physical stamped reply card;
6. parser-valid `RESPOND TO` and `PUT STAMPED CARD IN MAILBOX` actions;
7. surveyor and courier as bounded exterior visitors;
8. ordinary `TELL`, bounded `REFUSE`, and bounded `ADMIT` without opening the boarded door;
9. unique missed notices and one bounded return;
10. unique signed receipt and numbered survey tag;
11. no duplicate or regenerated correspondence;
12. constant-addressed packed native-save state;
13. deliberate live-trigger removal, corruption, and exact restore;
14. strict production/test isolation.

Parser and timing truth retained:

- canonical grammar claims `REPLY`, so bounded responses use `RESPOND TO`;
- `REPLY CARD` is not a valid noun phrase, so the exact object is `STAMPED CARD`;
- posting dispatches through the shared action hook before canonical `PUT` can retain a sent card;
- ordinary `TELL` engages a visitor;
- visitor object actions route `ADMIT` and `REFUSE`;
- posting/departure deferral allows a real missed notice and bounded return;
- the canonical leaflet is proved through mailbox custody rather than moved for qualification.

All 33 capstone-candidate workflows passed with no retry on exact audited head `7e9019dc3c336413ea07df400341fa6474a3cff6`.

## House of Records status

- 12 trains;
- 96 beads;
- Trains 1–5 complete: 40 closed;
- Trains 6–12 planned: 56 open;
- no sub-beads.

## Validation coverage

| Coverage | Proof |
|---|---|
| Base identity | Exact manifest and artifact SHA checks before staging |
| Production delta | Fail-closed changed-path sets |
| Artifact identity | Exact size, Glulx checksum, validity, and SHA-256 |
| Parser behavior | Native interpreter routes using ordinary player commands |
| Canonical authority | Existing routes, mailbox, leaflet, door, objects, score, actors, and world triggers retained |
| Persistence | Deliberate cause removal/corruption followed by native `SAVE` / `RESTORE` |
| Unique records | No duplicate letters, reply cards, visitors, notices, receipts, or tags |
| Test isolation | Setup, mutation, and report verbs excluded from production |
| Roadmap integrity | 12 trains / 96 unique beads / 40 closed / 56 open |

## Next dedicated work

`onyx_zork_attic_archive_core`

Resolve PR #21's exact live head, branch Train 6 from that state, execute the eight existing Attic Archive Core beads directly, and keep the stacked PR chain open and unmerged without Justin's explicit merge whistle.
