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
| Attic Archive Core Glulx | `.ulx` | Release 1224 / `260729` | Train 6 complete |
| Attic NPC Dossiers Glulx | `.ulx` | Release 1225 / `260729` | Train 7 complete |

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
| 1224 | Attic archive core | 280,832 | `0x4fe371b8` | `c8490c39b3ee8a17e257419aa13998529086573ddb6172132998f8353e92a356` |
| 1225 | Attic NPC dossiers | 287,744 | `0x4b4d66a0` | `e775d0a5ab74f5115d09b380ac4397e845ef539a1260df166120e1c25594db10` |

## House trains 1–5

The house foundation, Living Room museum, Kitchen laboratory, Cellar threshold, and correspondence/visitor systems remain qualified and authoritative. Canonical rooms, routes, actors, objects, mailbox, leaflet, score, water, trap door, and prior state are preserved through the stack.

## Release 1224 — Attic Archive Core

Qualified behavior:

1. a canonical archive-record schema for people, places, objects, messages, incidents, chronology, outcomes, links, source, and truth status;
2. physical late-1970s media rather than a modern filesystem;
3. an oak card catalog and bounded physical filing surfaces;
4. a terminal that locates records but stores none;
5. exact folders, cards, printouts, microfiche, and cassette records;
6. ordinary object-tree custody and capacity;
7. explicit `FILE`, `REVIEW`, `SHOW`, and `CROSSREF` routes;
8. verified, plausible, contradictory, redacted, and missing-evidence states;
9. bounded textual playback that cannot mutate live state;
10. native save/corrupt/restore of exact index state and physical custody.

GitHub Actions run `30478000111` passed the complete Release `1224` qualification.

## Release 1225 — Attic NPC Dossiers

Qualified behavior:

1. actor-event normalization from direct player actions and observable canonical state;
2. exact physical troll, cyclops, thief, and encounter-timeline records;
3. attempts separated from verified outcomes;
4. hostility, gifts, attacks, restraint, bargains, route outcomes, and property custody retained only when evidenced;
5. invisibility, absence, contradictions, and missing property represented without reconstruction;
6. curated quotations and chronology rather than raw command logs;
7. production proof that unencountered actors do not create dossiers;
8. ordinary archive filing and cross-reference behavior;
9. native save/corrupt/restore of exact dossier state and custody;
10. no actor control, combat replacement, hidden-solution leak, duplicate property, or parallel score.

GitHub Actions run `30480017488` passed the complete Release `1225` qualification.

## House of Records status

- 12 trains;
- 96 beads;
- Trains 1–7 complete: 56 closed;
- Trains 8–12 planned: 40 open;
- no sub-beads.

## Validation coverage

| Coverage | Proof |
|---|---|
| Base identity | Exact manifest and artifact SHA checks before staging |
| Production delta | Fail-closed changed-path sets |
| Artifact identity | Exact size, Glulx checksum, validity, and SHA-256 |
| Parser behavior | Native interpreter routes using ordinary player commands |
| Canonical authority | Existing routes, objects, score, actors, timers, randomness, and puzzle state retained |
| Archive truth | Physical records, provenance, contradictions, redaction, and missing evidence |
| Actor truth | Player-specific evidence without static omniscient biographies |
| Persistence | Deliberate state/object/location corruption followed by native `SAVE` / `RESTORE` |
| Test isolation | Setup, mutation, and report verbs excluded from production |
| Roadmap integrity | 12 trains / 96 unique beads / 56 closed / 40 open |

## Next dedicated work

`onyx_zork_attic_area_case_files`

Train 8 must build evolving regional case files, including Flood Control Dam #3 and Hades pilots, without becoming a checklist HUD or revealing undiscovered solutions. Branch it from PR #24's exact live qualified Release `1225` closure head and keep the stacked PR chain open and unmerged without Justin's explicit merge whistle.
