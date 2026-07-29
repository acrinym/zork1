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

## Release 1227 — Attic Playback

Qualified behavior:

1. seven exact physical playback records in the canonical Attic archive;
2. twelve unique consequential event slots with duplicate suppression;
3. normalized printer labels rather than claimed verbatim player commands;
4. contextual cassette narration with labels, pauses, hiss, and environmental cues;
5. scene navigation by incident, actor, place, and first-capture chronology;
6. bounded forensic event tokens rather than an unlimited raw parser log;
7. production proof that unearned Dam, Hades, actor, synthesis, and forensic playback remains absent;
8. non-turning playback with exact location, score, active timer, actor, parser-pronoun, and custody checks;
9. ordinary parser-valid `TAKE`, `READ`, `PLAY`, `REVIEW`, and `FILE` routes;
10. native save/corrupt/restore of event masks, order, indexes, records, and custody;
11. no time travel, actor simulation, object repair, route change, score mutation, timer advancement, or merged expedition history.

GitHub Actions run `30493076701` passed the complete Release `1227` qualification.

## House of Records status

- 12 trains;
- 96 beads;
- Trains 1–9 complete: 72 closed;
- Trains 10–12 planned: 24 open;
- no sub-beads.

## Validation coverage

| Coverage | Proof |
|---|---|
| Base identity | Exact Release 1226 artifact SHA before staging |
| Production delta | Fail-closed five-path changed set |
| Artifact identity | 307,712 bytes / `0xfb794f11` / exact SHA-256 |
| Parser behavior | Native interpreter routes for all seven physical records |
| Capture truth | Twelve unique consequential events; routine and unearned traffic excluded |
| Playback integrity | Location, score, timer, actors, pronoun, and custody remain unchanged |
| No premature reveal | Early-house smoke rejects unearned playback content |
| Persistence | Deliberate state/media corruption followed by native `SAVE` / `RESTORE` |
| Test isolation | Setup, mutation, and report verbs excluded from production |
| Roadmap integrity | 12 trains / 96 unique beads / 72 closed / 24 open |

## Next dedicated work

`onyx_zork_house_rest_and_dreams`

Train 10 builds optional Bedroom rest, bounded recovery, discovery-driven dreams, deterministic overnight consequences, authored interruptions, and native persistence without timer exploits or mandatory sleep cycles.
