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

## Release 1228 — House Rest and Dreams

Qualified behavior:

1. one reachable upper-floor Bedroom connected to the canonical Living Room;
2. original `WAIT` / `Z` retained through canonical `V-WAIT`;
3. parser-valid `SLEEP`, `REST`, `NAP`, `DOZE`, `LIE DOWN`, and no-object `WAKE`;
4. unsafe sleep refused for active clothing fire, tied legs, or a hostile Bedroom actor;
5. canonical clock advancement one step at a time with immediate interruption;
6. one-step temporary-strength recovery plus bounded transient-state clearing;
7. unchanged evidence produces a one-turn shallow doze rather than recovery farming;
8. deterministic dreams derived only from already-earned evidence;
9. exact physical `REST-DREAM-01` and `REST-OVERNIGHT-02` records;
10. deterministic reuse of existing mail, visitor, theft, water, smoke, custody, and archive state;
11. production proof that unearned Hades, actor, folly, museum, and other dream content remains absent;
12. parser-valid Attic review and filing with non-turning integrity checks;
13. native save/corrupt/restore of cycles, signatures, dream bits, wake evidence, recovery, filing, notices, and custody;
14. no mandatory sleep cycle, timer skip, repeated-healing exploit, predictive dream, object resurrection, or Train 11 controller.

GitHub Actions run `30547861041` passed the complete Release `1228` qualification.

## House of Records status

- 12 trains;
- 96 beads;
- Trains 1–10 complete: 80 closed;
- Trains 11–12 planned: 16 open;
- no sub-beads.

## Validation coverage

| Coverage | Proof |
|---|---|
| Base identity | Exact Release 1227 artifact SHA before staging |
| Production delta | Fail-closed eight-path changed set |
| Artifact identity | 316,160 bytes / `0x3505b8ad` / exact SHA-256 |
| Parser behavior | Original waiting plus ordinary Bedroom rest, record review, and filing routes |
| Clock truth | Canonical `CLOCKER` steps and interruption, not a parallel time controller |
| Recovery boundary | One negative strength step and bounded transient clearing only when evidence changes |
| Dream truth | Finite deterministic earned-evidence dreams; unearned content absent |
| Persistence | Deliberate state, record, notice, recovery, and custody corruption followed by native restore |
| Test isolation | Setup, discovery, mutation, and report verbs excluded from production |
| Roadmap integrity | 12 trains / 96 unique beads / 80 closed / 16 open |

## Next dedicated work

`onyx_zork_house_vulnerability`

Train 11 builds bounded house conditions, smoke/damp propagation, canonical thief burglary, selected creature intrusion, supernatural effects, meaningful repair, archive evidence, and native persistence without survival-game maintenance.
