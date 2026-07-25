# Zork I project-edition feature matrix

## Edition status

| Edition | Format | Identity | Status |
|---|---|---:|---|
| Historical | `.z3` | Release 119 / `880429` | Preserved and verified |
| Optimized | `.z3` | Release 120 / `260718` | Qualified |
| Expanded | `.z3` | Release 121 / `260719` | Qualified reactive world, assistance, characters, and misconduct |
| Absurd Alternate | `.z3` | Release 122 / `260720` | Qualified troll-restraint and nest-fire outcomes |
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
| House State Foundation Glulx | `.ulx` | Release 1219 / `260724` | Qualified; Train 1 complete |
| Living Room Museum Glulx | `.ulx` | Release 1220 / `260724` | Qualified; Train 2 complete |
| House Kitchen Laboratory Glulx | `.ulx` | Release 1221 / `260724` | Qualified; Train 3 complete |
| House Cellar Threshold Glulx | `.ulx` | Release 1222 / `260724` | Qualified; Train 4 capstone candidate |

## Locked Glulx lineage

| Release | Purpose | Size | Checksum | SHA-256 |
|---:|---|---:|---|---|
| 1214 | Release 122 Glulx parity | 202,240 | `0x53f5066d` | `10ea136e389aef8bf9e629ea854ea97ba69f1e5df3b9024540abc91cc61f0628` |
| 1215 | Dam mechanisms | 207,360 | `0x3d135bb8` | `ea23c8ff739348162f32c798ff0ad6f5e8e6a4d310ad3daf5c2da58b86505eed` |
| 1216 | Ritual resonance | 211,968 | `0x3d27d123` | `4f406e656b892feb5224e4e52afb98768417e1e761918334dfa94595e6091db2` |
| 1217 | Material consequences | 217,344 | `0xb0028984` | `2714d63760fa890be9ece3b23fc91bab67a660c42675e0302b745173aba700da` |
| 1218 | Room density | 227,840 | `0x3b65ecaf` | `efc8bd9f264f60bb56f2daf3e4d7d6d32a272997434802ee76455781a8edf521` |
| 1219 | House state foundation | 230,144 | `0xbe6bc80a` | `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f` |
| 1220 | Living Room museum | 237,312 | `0x630d724a` | `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4` |
| 1221 | House Kitchen laboratory | 249,600 | `0x85d64142` | `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f` |
| 1222 | House Cellar threshold | 262,400 | `0x54b04c7a` | `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912` |

## Release 1219 — House State Foundation

Exact Release `1218` plus `1actions.zil`, `1dungeon.zil`, `assistance.zil`, new `house_state_foundation.zil`, and `zork1.zil`.

Qualified behavior:

- compact versioned condition, collection, knowledge, security, and atmosphere state;
- bounded house-use, Attic, Cellar, return, collection, and disturbance receipts;
- Living Room, Kitchen, Attic, and Cellar projection;
- real trophy-case collection authority;
- conservative migration and native restore;
- no parallel score, duplicate object, chore loop, Bedroom placeholder, or topology change.

## Release 1220 — Living Room Museum

Exact Release `1219` plus `1actions.zil`, `assistance.zil`, new `living_room_museum.zil`, and `zork1.zil`.

Qualified behavior:

- bounded real-object display registry and provenance;
- fixed gallery frame, weapon wall, record shelf, and relic stand;
- ordinary placement, inspection, removal, and replacement;
- active-object warning without retirement;
- canonical trophy-case score authority and score-neutral open surfaces;
- house, ritual, dam, conflict, and canary synthesis;
- canonical thief custody, physical theft evidence, and booty recovery;
- exact nested-object persistence and production/test isolation.

## Release 1221 — House Kitchen Laboratory

Exact Release `1220` plus `1actions.zil`, `assistance.zil`, new `house_kitchen_laboratory.zil`, `shadow_logic.zil`, and `zork1.zil`.

Qualified behavior:

- fixed porcelain sink, wooden worktop, wooden cupboard, and cast-iron range;
- one canonical portable `WATER` object and repeat refill only after real consumption;
- selected washing, drying, warming, cooling, quenching, and worktop rinsing;
- existing material-clean flags and rusty-knife worsening;
- prepared real lunch and canonically cut real garlic;
- ordinary object-tree storage and retrieval;
- bounded bat and cyclops context;
- packed indexed persistent Kitchen state;
- native save/corrupt/restore and production/test isolation.

Parser truth retained:

- `NASTY KNIFE` disambiguates the real food knife;
- ordinary `TAKE` precedes moving real objects between fixtures;
- `SLICE` remains canonical `CUT`;
- only garlic with the real nasty knife is intercepted.

## Release 1222 — House Cellar Threshold

Exact Release `1221` plus `1actions.zil`, `assistance.zil`, new `house_cellar_threshold.zil`, `shadow_logic.zil`, and `zork1.zil`.

Qualified behavior:

1. fixed stone staging bench, iron gear hooks, and closable quarantine niche;
2. canonical trap-door descent, original first-entry slam/bar, and unchanged upward route;
3. an observational Cellar underside that reports the real trap-door flags without a duplicate route or lock;
4. actual carried/staged `READINESS` without loadout automation;
5. bounded sounds, drafts, dampness, and threshold sensing;
6. warnings for darkness, live flame, exposed canonical water, Kitchen wetness, material rust, fragile/living cargo, supernatural cargo, and unstable objects;
7. ordinary real-object staging and retrieval;
8. recoverable physical quarantine with live-flame refusal;
9. deterministic thief, creature, loose-water, smoke, and supernatural evidence;
10. real-water evidence cleanup only after live causes are removed;
11. packed indexed persistent Cellar state;
12. deliberate state/object-tree/actor-cause corruption and exact native restore;
13. strict production/test isolation.

Parser and causal truth retained:

- tactile inspection uses canonical `RUB`, not nonexistent `TOUCH`;
- the original trap-door object remains canonically in the Living Room;
- `UNDERSIDE` is observation only;
- staged rope and wrench no longer count as carried;
- intrusion evidence returns while a real cause remains present;
- cleanup consumes the one real portable water quantity.

## House of Records status

- 12 trains;
- 96 beads;
- Trains 1–3 complete: 24 closed;
- Train 4 capstone candidate: 7 closed / 1 open;
- Trains 5–12 planned;
- total: 31 closed / 65 open;
- no sub-beads.

## Validation coverage

| Coverage | Proof |
|---|---|
| Base identity | Exact manifest and artifact SHA checks before staging |
| Production delta | Fail-closed changed-path sets for every production release |
| Artifact identity | Exact size, Glulx checksum, validity, and SHA-256 |
| Parser behavior | Native interpreter routes using ordinary player commands |
| Canonical authority | Existing routes, objects, score, actors, timers, puzzle state, and carrying rules retained |
| Persistence | Deliberate corruption followed by ordinary native `SAVE` / `RESTORE` |
| Causal evidence | Physical evidence returns while live causes remain and clears only after cause removal |
| Object trees | No duplicate roots, flattened containers, equipment tokens, or replacement objects |
| Test isolation | Setup, intrusion, mutation, cleanup, and report verbs excluded from production |
| Roadmap integrity | 12 trains / 96 unique beads / 31 closed / 65 open |

## Next dedicated work

After Train 4 capstone closure, continue House of Records Train 5:

`onyx_zork_house_correspondence_visitors`

It must preserve the canonical mailbox and leaflet while adding deterministic authored correspondence, provenance, ordered delivery, bounded replies, visitors, missed-delivery behavior, and native persistence through its eight existing beads.
