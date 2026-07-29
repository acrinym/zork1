# House of Records — Evolving White House and Attic Archive Program

## Status

Active twelve-train, ninety-six-bead program above qualified Glulx Release `1222`.

- **Train 1 complete:** `onyx_zork_house_state_foundation` — Release `1219`.
- **Train 2 complete:** `onyx_zork_house_living_museum` — Release `1220`.
- **Train 3 complete:** `onyx_zork_house_kitchen_laboratory` — Release `1221`.
- **Train 4 in capstone:** `onyx_zork_house_cellar_threshold` — qualified Release `1222`.
- **Next existing train after closure:** `onyx_zork_house_correspondence_visitors`.

Current capstone-candidate truth:

- 12 trains;
- 96 beads;
- 31 closed beads across Trains 1–4;
- Train 4 bead 008 remains open;
- 65 open beads total;
- no sub-beads, sub-trains, or planning hierarchy beneath the existing beads.

## Product thesis

The white house should evolve because of the adventure, not because the player performs chores. A meaningful change must follow from something the player discovered, recovered, displayed, repaired, damaged, carried home, released, received, survived, or foolishly experimented with.

The Attic should become a period-authentic archive of this player's actual run: notes, correspondence, NPC statements, area case files, curated transcripts, maps, photographs, cassette-style playback, completed expedition boxes, and comparisons between separate histories.

> The house has been quietly writing the history of you.

## Controlling rules

1. Adventure consequences, not upkeep.
2. Canonical object and actor identity remains authoritative.
3. The trophy case keeps canonical scoring.
4. No unseen solution leakage.
5. Playback never mutates live state.
6. Mutually exclusive runs remain separate expedition histories.
7. Every stateful train proves native `SAVE` and `RESTORE` after deliberate corruption.
8. Actor records describe this player's relationship with the actor, not a generic biography.
9. Area completion unlocks retrospective synthesis, not a checklist HUD.
10. Authored bounded interactions beat universal simulation.
11. Later trains reuse existing house machinery rather than creating parallel controllers.
12. Trains contain beads; beads do not receive sub-beads.

## Train 1 — House State Foundation

Train: `onyx_zork_house_state_foundation`

Status: `complete`

Qualified Release `1219` identity:

- serial `260724`;
- 230,144 bytes;
- checksum `0xbe6bc80a`;
- SHA-256 `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f`.

Exact production delta:

- `1actions.zil`;
- `1dungeon.zil`;
- `assistance.zil`;
- new `house_state_foundation.zil`;
- `zork1.zil`.

The foundation provides compact versioned condition, collection, knowledge, security, and atmosphere state. It records bounded receipts for house use, Attic entry, Cellar crossing, return, real trophy-case collection, and physical disturbance. State derives from real canonical rooms and objects.

Release `1218` contains no canonical Bedroom, so Train 1 added no unreachable placeholder or topology change.

Controlling record: `glulx/house-state-foundation/README.md`

## Train 2 — Living Room Museum

Train: `onyx_zork_house_living_museum`

Status: `complete`

Qualified Release `1220` identity:

- serial `260724`;
- 237,312 bytes;
- checksum `0x630d724a`;
- SHA-256 `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4`.

Exact production delta above Release `1219`:

- `1actions.zil`;
- `assistance.zil`;
- new `living_room_museum.zil`;
- `zork1.zil`.

The canonical Living Room contains a gallery frame, weapon wall, record shelf, and relic stand. Players place, inspect, remove, and replace the original objects through ordinary parser actions. These surfaces award no score; the canonical trophy case remains authoritative.

Bounded provenance and real-object synthesis cover house history, the Hades ceremony, the repaired dam, troll conflict, and intact or broken egg/canary nesting. Exposed valuables can move into the real thief's inventory and later follow canonical booty recovery.

Controlling record: `glulx/living-room-museum/README.md`

## Train 3 — House Kitchen Laboratory

Train: `onyx_zork_house_kitchen_laboratory`

Status: `complete`

Qualified Release `1221` identity:

- serial `260724`;
- Glulx `3.1.3` / `0x00030103`;
- 249,600 bytes;
- checksum `0x85d64142`;
- SHA-256 `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f`.

Exact base:

- Release `1220` SHA-256 `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4`.

Exact production delta above Release `1220`:

- `1actions.zil`;
- `assistance.zil`;
- new `house_kitchen_laboratory.zil`;
- `shadow_logic.zil`;
- `zork1.zil`.

The canonical Kitchen gains a porcelain sink, wooden worktop, wooden cupboard, and cast-iron range. Release `1221` uses the real bottle, canonical `WATER`, lunch, garlic, knives, tools, existing material-cleaning state, and rusty-knife consequence.

Qualified behavior includes bottle refill without cloning, selected washing/drying, bounded range heat, warming, food preparation, canonical garlic cutting, selected quenching/rinsing, ordinary storage, authored creature context, `RECAP`, and exact native restore.

The first production compile exposed the Glulx ZIL global-variable ceiling. The complete Kitchen schema was packed into one indexed persistent table instead of deleting behavior.

Controlling records:

- `glulx/house-kitchen-laboratory/README.md`
- `expanded/docs/HOUSE_KITCHEN_LABORATORY_MATRIX.md`

## Train 4 — House Cellar Threshold

Train: `onyx_zork_house_cellar_threshold`

Status: `in_progress` — qualified implementation and persistence complete; capstone bead open.

Qualified Release `1222` identity:

- serial `260724`;
- Glulx `3.1.3` / `0x00030103`;
- 262,400 bytes;
- checksum `0x54b04c7a`;
- SHA-256 `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912`.

Exact base:

- Release `1221` SHA-256 `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f`.

Exact production delta above Release `1221`:

- `1actions.zil`;
- `assistance.zil`;
- new `house_cellar_threshold.zil`;
- `shadow_logic.zil`;
- `zork1.zil`.

The canonical Cellar gains:

- a stone staging bench;
- iron gear hooks;
- a closable stone quarantine niche;
- a targetable threshold;
- targetable sounds, drafts, and dampness;
- persistent physical intrusion evidence;
- an observational underside of the real trap door.

Qualified behavior includes:

1. actual carried and staged readiness without inventory automation;
2. canonical descent through the real trap door, including the original slam and bar;
3. Cellar-side observation without a duplicate route or lock;
4. bounded sounds, drafts, dampness, and route evidence;
5. warnings for darkness, flame, exposed water, wet metal, fragile/living, supernatural, and unstable cargo;
6. ordinary object-tree staging and retrieval;
7. recoverable physical quarantine with live-flame refusal;
8. thief, creature, loose-water, smoke, and supernatural evidence;
9. causal real-water evidence cleanup;
10. concise Cellar `RECAP` receipts;
11. native save, deliberate corruption, and exact restore.

All Cellar state is packed into one indexed persistent table.

Important qualification corrections:

- the first loader draft had an escaped-quote defect, an unclosed form, and bit/routine collisions; it was replaced with a balanced module;
- tactile inspection uses canonical `RUB`, not nonexistent `TOUCH`;
- the original trap-door object remains canonically in the Living Room, so the Cellar underside exposes state without creating another route;
- staged objects stop counting as carried readiness;
- physical evidence correctly returns while its live cause remains present;
- deliberate corruption removes live causes before asserting zero state, then native restore recovers exact object custody and evidence.

No inventory automation, equipment classes, unlimited storage, remote retrieval, generic hazard simulation, broad propagation, duplicate object or actor, parallel score, automatic route unlock, safe passage, or auto-solve exists.

Controlling records:

- `glulx/house-cellar-threshold/README.md`
- `expanded/docs/HOUSE_CELLAR_THRESHOLD_MATRIX.md`

## Period presentation

The later archive should use the material culture of the original game's era rather than a phone, cloud drive, or modern dashboard:

- steel filing cabinets;
- index-card catalogs;
- banker boxes;
- continuous-feed printer paper;
- cassette tapes and recorders;
- microfiche and film reels;
- Polaroids;
- maps and corkboards;
- stamped and annotated folders;
- a late-1970s terminal whose commands locate physical records.

## Remaining trains

### Train 5 — Correspondence and Visitors

Preserve the canonical mailbox and leaflet while adding deterministic mail provenance, replies, warnings, deliveries, visitors, and missed-event persistence.

### Train 6 — Attic Archive Core

Create the period media, record schema, card catalog, archive commands, provenance, migration, and integrity substrate.

### Train 7 — NPC Dossiers

Record player-specific troll, cyclops, thief, quotation, gift, threat, mercy, deception, restraint, combat, and outcome histories.

### Train 8 — Area Case Files

Build partial, redacted, and completed evidence files for the dam, Hades ceremony, house, forest, and representative underground areas.

### Train 9 — Playback

Provide curated command/response transcripts, cassette-style scenes, line-printer output, and observational playback that cannot mutate live state.

### Train 10 — Rest and Dreams

Add optional rest, timer-safe recovery, discovery-driven dreams, overnight consequences, and waking without mandatory sleep cycles or event farming.

### Train 11 — House Vulnerability

Extend smoke, damp, water, burglary, followers, creatures, and supernatural effects into recoverable physical house consequences.

### Train 12 — Expedition Archive

After victory, preserve the route, deaths, treasures, actor outcomes, area outcomes, altered objects, correspondence, house condition, display arrangement, unresolved evidence, and final mechanism states as a separate expedition box.

## Train ledger

| # | Beadtrain | Status |
|---:|---|---|
| 1 | `onyx_zork_house_state_foundation` | Complete — Release 1219 |
| 2 | `onyx_zork_house_living_museum` | Complete — Release 1220 |
| 3 | `onyx_zork_house_kitchen_laboratory` | Complete — Release 1221 |
| 4 | `onyx_zork_house_cellar_threshold` | Capstone candidate — Release 1222 |
| 5 | `onyx_zork_house_correspondence_visitors` | Planned / next |
| 6 | `onyx_zork_attic_archive_core` | Planned |
| 7 | `onyx_zork_attic_npc_dossiers` | Planned |
| 8 | `onyx_zork_attic_area_case_files` | Planned |
| 9 | `onyx_zork_attic_playback` | Planned |
| 10 | `onyx_zork_house_rest_and_dreams` | Planned |
| 11 | `onyx_zork_house_vulnerability` | Planned |
| 12 | `onyx_zork_expedition_archive` | Planned |

Canonical issue shards:

- `.beads/issues-zork-house-of-records-01.jsonl`
- `.beads/issues-zork-house-of-records-02.jsonl`
- `.beads/issues-zork-house-of-records-03.jsonl`
- `.beads/issues-zork-house-of-records-04.jsonl`

## Qualification standard

Every train must:

1. resolve the exact live base;
2. publish a narrow production delta and exclusions;
3. use real canonical objects and actors;
4. keep test-only commands out of production;
5. build with pinned toolchains;
6. run deterministic player-facing routes;
7. deliberately corrupt state and prove native restore;
8. prove no duplicate object, actor, score, or record;
9. update the program, handoff, README, train, and issue ledger;
10. close beads only after exact-head evidence;
11. keep PRs open and unmerged absent Justin's explicit merge whistle.

## Explicit non-goals

- generic base building;
- crafting trees;
- survival meters;
- housekeeping chores;
- universal physics or chemistry;
- open-ended AI dialogue;
- modern cloud-drive metaphors;
- raw transcript dumping as the primary interface;
- revealing unseen solutions;
- merging contradictory playthroughs;
- using archive records to repair live state;
- replacing Zork's parser identity;
- sub-beads beneath the established trains.

## Definition of success

The house should feel like the player's place in the Great Underground Empire, and the Attic should eventually explain why it became that way.
