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

## Release 1229 — House Vulnerability and Intrusion

Qualified behavior:

1. compact authored condition state for disturbance, smoke, damp, burglary, creature intrusion, supernatural disturbance, and physical damage;
2. parser-native `CHECK HOUSE`, `INSPECT HOUSE`, and `STATUS HOUSE` from the house interior;
3. real-tool `SECURE HOUSE`, `REPAIR HOUSE`, `VENT HOUSE`, `WARD HOUSE`, and `DRIVE BAT` routes;
4. smoke derived from live flame, personal fire, or existing Cellar soot evidence;
5. fresh damp derived from the canonical Cellar water-intrusion bit;
6. smoke forces waking in the Bedroom rather than allowing danger to be slept through;
7. canonical burglary moves the real painting into canonical thief custody;
8. securing the house never returns missing property;
9. canonical recovery clears outstanding loss while permanent burglary history remains;
10. later closed routes and a real hand tool may restore security after recovery;
11. the canonical bat alone enters through the open trap-door route and retreats with real garlic;
12. the real black book, skull, or hot bell may create a supernatural house pattern when loose;
13. the real Cellar quarantine niche plus garlic resolves active supernatural disturbance;
14. the real Kitchen window, putty, wrench, screwdriver, niche, and garlic perform specific repairs;
15. exact physical `HOUSE-RISK-01` and `HOUSE-REPAIR-02` Attic records;
16. parser-native non-turning review and filing with integrity checks;
17. native save, deliberate corruption, and exact restore of condition, history, repairs, security, filing, actor location, containment, and custody;
18. no maintenance meters, random disasters, replacement property, copied actors, or Train 12 controller.

GitHub Actions run `30569998028` passed the complete locked Release `1229` qualification.

## House of Records status

- 12 trains;
- 96 beads;
- Trains 1–11 complete: 88 closed;
- Train 12 remaining: 8 open;
- no sub-beads.

## Validation coverage

| Coverage | Proof |
|---|---|
| Base identity | Exact Release 1228 artifact SHA before staging |
| Production delta | Fail-closed fourteen-path changed set |
| Artifact identity | 328,704 bytes / `0xc774e968` / exact SHA-256 |
| Production isolation | Test incident verbs absent from the production source and artifact |
| Condition truth | Active state derives from canonical fire, water, actor, object, route, and custody state |
| Burglary truth | Real painting enters real thief custody; recovery and later security remain separate |
| Creature truth | Canonical bat crosses the real route and returns to its canonical room |
| Repair boundary | Specific real tools and containment only; no generic crafting or maintenance loop |
| Archive integrity | Physical records review and file without mutating score, timer, pronoun, or custody |
| Persistence | Deliberate condition, filing, actor, containment, and custody corruption followed by native restore |
| Roadmap integrity | 12 trains / 96 unique beads / 88 closed / 8 open |

## Next dedicated work

`onyx_zork_completed_expedition_archive`

Train 12 completes the victory-gated master expedition archive, chronological timeline, final world and house summary, separate run boxes, bounded comparison, unseen-alternative boundaries, versioned export, and the complete House of Records capstone.
