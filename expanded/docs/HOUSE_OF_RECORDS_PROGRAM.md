# House of Records — Evolving White House and Attic Archive Program

## Status

Active twelve-train, ninety-six-bead program above qualified Glulx Release `1225`.

- **Train 1 complete:** `onyx_zork_house_state_foundation` — Release `1219`.
- **Train 2 complete:** `onyx_zork_house_living_museum` — Release `1220`.
- **Train 3 complete:** `onyx_zork_house_kitchen_laboratory` — Release `1221`.
- **Train 4 complete:** `onyx_zork_house_cellar_threshold` — Release `1222`.
- **Train 5 complete:** `onyx_zork_house_correspondence_visitors` — Release `1223`.
- **Train 6 complete:** `onyx_zork_attic_archive_core` — Release `1224`.
- **Train 7 complete:** `onyx_zork_attic_npc_dossiers` — Release `1225`.
- **Next existing train:** `onyx_zork_attic_area_case_files`.

Current truth:

- 12 trains;
- 96 beads;
- 56 closed beads across Trains 1–7;
- 40 open beads across Trains 8–12;
- no sub-beads, sub-trains, or planning hierarchy beneath the existing beads.

## Product thesis

The white house evolves because of the adventure, not because the player performs chores. Meaningful changes follow from discoveries, objects, repairs, damage, returns, visitors, and consequences.

The Attic is a period-authentic archive of this player's actual run: correspondence, notes, dossiers, case files, maps, photographs, cassettes, printouts, and separate expedition boxes.

> The house has been quietly writing the history of you.

## Controlling rules

1. Adventure consequences, not upkeep.
2. Canonical object and actor identity remains authoritative.
3. The trophy case keeps canonical scoring.
4. No unseen solution leakage.
5. Playback never mutates live state.
6. Mutually exclusive runs remain separate expedition histories.
7. Every stateful train proves native `SAVE` and `RESTORE` after deliberate corruption.
8. Actor records describe this player's relationship with the actor.
9. Retrospective synthesis is not a checklist HUD.
10. Authored bounded interactions beat universal simulation.
11. Later trains reuse existing machinery rather than parallel controllers.
12. Trains contain beads; beads do not receive sub-beads.

## Qualified production lineage

| Train | Release | Size | Checksum | SHA-256 | Status |
|---:|---:|---:|---|---|---|
| 1 | 1219 | 230,144 | `0xbe6bc80a` | `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f` | Complete |
| 2 | 1220 | 237,312 | `0x630d724a` | `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4` | Complete |
| 3 | 1221 | 249,600 | `0x85d64142` | `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f` | Complete |
| 4 | 1222 | 262,400 | `0x54b04c7a` | `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912` | Complete |
| 5 | 1223 | 271,872 | `0x4cbcc561` | `362b5567e2ee705dc382256fe3420b9e729486acbcdf68b91a8ccdda0c893816` | Complete |
| 6 | 1224 | 280,832 | `0x4fe371b8` | `c8490c39b3ee8a17e257419aa13998529086573ddb6172132998f8353e92a356` | Complete |
| 7 | 1225 | 287,744 | `0x4b4d66a0` | `e775d0a5ab74f5115d09b380ac4397e845ef539a1260df166120e1c25594db10` | Complete |

## Trains 1–5 — Evolving house foundation

The first five trains establish compact native-save house state, the Living Room museum, Kitchen laboratory, Cellar threshold, and bounded correspondence and visitors. The canonical rooms, routes, objects, actors, mailbox, leaflet, water, trap door, and score remain authoritative.

Controlling records:

- `glulx/house-state-foundation/README.md`;
- `glulx/living-room-museum/README.md`;
- `glulx/house-kitchen-laboratory/README.md`;
- `glulx/house-cellar-threshold/README.md`;
- `glulx/house-correspondence-visitors/README.md`.

## Train 6 — Attic Archive Core

Status: `complete`

Release `1224` turns the real canonical Attic into a bounded physical archive.

It adds:

- a typed archive-record schema;
- late-1970s folders, cards, printouts, microfiche, cassette, cabinets, banker box, recorder, viewer, corkboard, and green-phosphor terminal;
- deterministic indexes by person, place, object, incident, chronology, and expedition;
- ordinary object-tree custody and bounded capacity;
- explicit `FILE`, `REVIEW`, `SHOW`, and `CROSSREF` commands;
- provenance, confidence, contradiction, verification, redaction, and missing-evidence states;
- bounded playback that cannot alter the present;
- versioned native-save state and conservative migration.

The archive consumes stable filing codes but never moves, recreates, consumes, or repairs live correspondence or visitors.

GitHub Actions run `30478000111` passed the canonical lantern-lit Attic route and native save/corrupt/restore.

Controlling record: `glulx/attic-archive-core/README.md`

## Train 7 — Attic NPC Dossiers

Status: `complete`

Release `1225` adds exact physical dossiers for the player's troll, cyclops, and thief evidence plus a curated encounter cassette.

The system records:

- first contact and observed hostility;
- gifts, attacks, restraint, and bargain attempts;
- verified outcomes and property custody;
- absence, invisibility, contradictions, and missing evidence;
- contextual quotations and chronology.

It does not create static encyclopedia entries. An actor elsewhere in the map creates no file. Attempts remain distinct from outcomes. Missing property remains missing. Combat, randomness, timers, score, actor choices, and routes remain canonical.

GitHub Actions run `30480017488` passed no-unearned-dossier production smoke, exact filing and cross-reference behavior, curated playback, and native save/corrupt/restore.

Controlling record: `glulx/attic-npc-dossiers/README.md`

## Period presentation

The archive uses late-1970s/early-1980s physical media:

- steel filing cabinets;
- index cards;
- banker boxes;
- continuous-feed printouts;
- cassettes and recorders;
- microfiche and film;
- Polaroids;
- maps and corkboards;
- stamped folders;
- a terminal that locates physical records.

## Next existing train — Area Case Files

Continue directly with `onyx_zork_attic_area_case_files` after resolving PR #24's exact live qualified head.

Train 8 must execute its existing eight beads directly:

1. area evidence and completion model;
2. incomplete, missing, and redacted presentation;
3. Flood Control Dam #3 case file;
4. Hades ceremony case file;
5. house, forest, and underground pilot files;
6. one-hundred-percent case synthesis;
7. case-file completion and persistence;
8. area case-file capstone.

Build evolving regional case files from evidence the player has actually earned. Do not build a checklist HUD, unseen-solution revealer, omniscient region encyclopedia, duplicate puzzle controller, automatic completion system, parallel score, or sub-bead hierarchy.
