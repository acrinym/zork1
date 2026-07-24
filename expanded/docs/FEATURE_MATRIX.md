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

## Release 1219 — House State Foundation

Exact Release `1218` plus:

- `1actions.zil`;
- `1dungeon.zil`;
- `assistance.zil`;
- new `house_state_foundation.zil`;
- `zork1.zil`.

Qualified behavior:

- compact versioned condition, collection, knowledge, security, and atmosphere state;
- bounded house-use, Attic, Cellar, return, collection, and disturbance receipts;
- Living Room, Kitchen, Attic, and Cellar projection;
- real trophy-case collection authority;
- conservative migration;
- deliberate corruption and native restore;
- no parallel score, duplicate object, chore loop, Bedroom placeholder, or topology change.

## Release 1220 — Living Room Museum

Exact Release `1219` plus:

- `1actions.zil`;
- `assistance.zil`;
- new `living_room_museum.zil`;
- `zork1.zil`.

Qualified behavior:

1. bounded real-object registry and provenance;
2. fixed gallery frame, weapon wall, record shelf, and relic stand;
3. ordinary parser placement, inspection, removal, and replacement;
4. active-object warning without retiring puzzle equipment;
5. canonical trophy-case scoring through `OTVAL-FROB`;
6. score-neutral open museum surfaces;
7. house, completed-ritual, repaired-dam, troll-conflict, and canary synthesis;
8. historical museum receipts in `RECAP`;
9. Release `1219` exposure/security integration;
10. one exact unsecured treasure moved into the canonical thief;
11. nonportable physical theft evidence;
12. canonical thief booty recovery into the Treasure Room;
13. intact nested egg/canary object identity;
14. deliberate surface/global/custody/case corruption and native restore;
15. strict production/test isolation.

Train 2's capstone candidate passed all 27 workflows. One inherited Release 122 route initially lost the player to random troll combat before the scripted actions; retrying only that unchanged job passed. This was not a Release `1220` regression.

## House of Records status

- 12 trains;
- 96 beads;
- Train 1 complete: 8 closed;
- Train 2 complete: 8 closed;
- Trains 3–12 planned: 80 open;
- total: 16 closed / 80 open;
- no sub-beads.

## Validation coverage

| Coverage | Proof |
|---|---|
| Base identity | Exact manifest and artifact SHA checks before staging |
| Production delta | Fail-closed changed-path sets for every production release |
| Artifact identity | Exact size, Glulx checksum, validity, and SHA-256 |
| Parser behavior | Native interpreter routes using ordinary player commands |
| Canonical authority | Existing objects, score, actors, timers, puzzle state, and carrying rules retained |
| Persistence | Deliberate corruption followed by ordinary native `SAVE` / `RESTORE` |
| Object trees | No duplicate roots, flattened containers, or replacement display tokens |
| Test isolation | Setup, mutation, recovery, and report verbs excluded from production |
| Roadmap integrity | 12 trains / 96 unique beads / 16 closed / 80 open |

## Next dedicated work

House of Records Train 3:

`onyx_zork_house_kitchen_laboratory`

It must use real water, containers, food, tools, residues, timers, cupboards, and surfaces while preserving puzzle water and avoiding hunger, thirst, chores, universal chemistry, and crafting trees.

Later dedicated work remains:

- Cellar expedition threshold;
- correspondence and visitors;
- Attic archive core;
- NPC dossiers;
- area case files;
- playback;
- rest and dreams;
- house vulnerability;
- completed expedition boxes;
- focused actor memory and long routes;
- evidence-driven parser improvements;
- optional geography only after core house and actor systems are strong.
