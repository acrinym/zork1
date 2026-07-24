# House of Records — Evolving White House and Attic Archive Program

## Status

Active twelve-train, ninety-six-bead program above qualified Glulx Release `1221`.

- **Train 1 complete:** `onyx_zork_house_state_foundation` — Release `1219`.
- **Train 2 complete:** `onyx_zork_house_living_museum` — Release `1220`.
- **Train 3 in capstone:** `onyx_zork_house_kitchen_laboratory` — qualified Release `1221`.
- **Next existing train after closure:** `onyx_zork_house_cellar_threshold`.

Current capstone-candidate truth:

- 12 trains;
- 96 beads;
- 23 closed beads across Trains 1–3;
- Train 3 bead 008 remains open;
- 73 open beads total;
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

Train:

`onyx_zork_house_state_foundation`

Status:

`complete`

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

Controlling record:

`glulx/house-state-foundation/README.md`

## Train 2 — Living Room Museum

Train:

`onyx_zork_house_living_museum`

Status:

`complete`

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

Controlling record:

`glulx/living-room-museum/README.md`

## Train 3 — House Kitchen Laboratory

Train:

`onyx_zork_house_kitchen_laboratory`

Status:

`in_progress` — qualified implementation and persistence complete; capstone bead open.

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

The canonical Kitchen gains four fixed fixtures:

- porcelain sink;
- wooden worktop;
- wooden cupboard;
- cast-iron range.

Release `1221` uses the real bottle, the single canonical `WATER` object, the real lunch and garlic, the real knives and tools, existing material-cleaning state, and the existing rusty-knife consequence.

Qualified behavior includes:

1. bottle refill without water cloning;
2. selected sink washing and ordinary drying;
3. temporary range heat from a real held flame;
4. warming food and water;
5. heat-drying wet metal without bonuses or repairs;
6. prepared real lunch and canonically cut real garlic;
7. bounded hot-iron quenching and worktop rinsing;
8. ordinary object-tree storage and retrieval;
9. bat and cyclops offering context without replacement solutions;
10. concise Kitchen `RECAP` receipts;
11. native save, deliberate corruption, and exact restore.

The first production compile exposed the Glulx ZIL global-variable ceiling. The correct repair packed the entire Kitchen schema into one indexed persistent table instead of deleting behavior or weakening persistence.

The route also retained parser truth:

- `NASTY KNIFE` disambiguates the real food knife from the rusty knife;
- ordinary `TAKE` is required before moving an exhibit from the worktop into the cupboard;
- existing canonical `CUT` handles `SLICE`, so the Kitchen intercepts only garlic with the real nasty knife and delegates every other cut unchanged.

No hunger/thirst meter, mandatory chores, recipe economy, generic crafting, universal chemistry, automatic puzzle-water replenishment, duplicate object, broad fire/flood simulation, parallel score, or automatic puzzle completion exists.

Controlling record:

`glulx/house-kitchen-laboratory/README.md`

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

### Train 4 — Cellar Threshold

Make the Cellar the expedition boundary: tool and light staging, trap-door observation, sounds and drafts, hazard warnings, limited containment, and physical intrusion hooks.

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
| 3 | `onyx_zork_house_kitchen_laboratory` | Capstone candidate — Release 1221 |
| 4 | `onyx_zork_house_cellar_threshold` | Planned / next |
| 5 | `onyx_zork_house_correspondence_visitors` | Planned |
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
