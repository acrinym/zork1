# House of Records — Evolving White House and Attic Archive Program

## Status

Active twelve-train, ninety-six-bead program above qualified Glulx Release `1220`.

- **Train 1 complete:** `onyx_zork_house_state_foundation` — Release `1219`.
- **Train 2 complete:** `onyx_zork_house_living_museum` — Release `1220`.
- **Next train:** `onyx_zork_house_kitchen_laboratory`.

Current roadmap truth:

- 12 trains;
- 96 beads;
- 16 closed beads across Trains 1–2;
- 80 open beads across Trains 3–12;
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
11. Later trains reuse existing house and museum machinery rather than creating parallel controllers.
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

The foundation provides compact versioned state for:

- condition;
- collection;
- knowledge;
- security;
- atmosphere.

It records bounded receipts for house use, Attic entry, Cellar crossing, return, real trophy-case collection, and physical disturbance. State derives from real canonical rooms and objects: the trophy case and `OTVAL-FROB`, rug, trap door, kitchen window, room visits, and Cellar return cycle.

Release `1218` contains no canonical Bedroom, so Train 1 added no unreachable Bedroom placeholder or topology change.

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

The canonical Living Room now contains four fixed open display surfaces:

- gallery frame;
- weapon wall;
- record shelf;
- relic stand.

Players place, inspect, remove, and replace the original objects through ordinary parser actions. The surfaces award no score. The canonical trophy case and `OTVAL-FROB` remain the only house scoring authority.

Bounded provenance and real-object synthesis cover:

- painting + sword + map;
- completed bell + candles + black-book ceremony;
- repaired dam guide + wrench + screwdriver;
- sword + troll axe;
- intact or broken egg with its correctly nested canary.

When Release `1219` marks the house exposed and the canonical thief remains available, one exact unsecured treasure can move into the real thief's inventory. The room retains physical evidence, and recovery follows canonical thief booty handling. Qualification proves the real painting moves from the frame to the thief and then to the Treasure Room without cloning, deletion, or a substitute token.

Native persistence proves exact display placement, trophy-case score authority, group history, theft evidence, thief custody, and egg/canary nesting after deliberate corruption and ordinary restore.

The capstone candidate passed all 27 workflows. One inherited Release 122 real-map route initially failed because random troll combat killed the player before the restraint commands; retrying only that unchanged job passed. No Train 2 production change was needed.

Controlling record:

`glulx/living-room-museum/README.md`

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

## Remaining house rooms and systems

### Train 3 — Kitchen Laboratory

Use real containers, water, food, tools, residues, timers, cupboards, and work surfaces. Support bounded cleaning, drying, warming, cooling, preparation, offerings, and authored experiments without hunger, thirst, housekeeping, universal chemistry, or a crafting tree.

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
| 3 | `onyx_zork_house_kitchen_laboratory` | Planned / next |
| 4 | `onyx_zork_house_cellar_threshold` | Planned |
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
9. update the program, handoff, frontier, matrix, README, train, and issue ledger;
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
