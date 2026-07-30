# House of Records — Evolving White House and Attic Archive Program

## Status

Active twelve-train, ninety-six-bead program above qualified Glulx Release `1228`.

- **Trains 1–5 complete:** evolving white-house foundation through correspondence and visitors — Releases `1219`–`1223`.
- **Train 6 complete:** `onyx_zork_attic_archive_core` — Release `1224`.
- **Train 7 complete:** `onyx_zork_attic_npc_dossiers` — Release `1225`.
- **Train 8 complete:** `onyx_zork_attic_area_case_files` — Release `1226`.
- **Train 9 complete:** `onyx_zork_attic_playback` — Release `1227`.
- **Train 10 complete:** `onyx_zork_house_rest_and_dreams` — Release `1228`.
- **Next existing train:** `onyx_zork_house_vulnerability`.

Current truth:

- 12 trains;
- 96 beads;
- 80 closed beads across Trains 1–10;
- 16 open beads across Trains 11–12;
- no sub-beads, sub-trains, or planning hierarchy beneath the existing beads.

## Product thesis

The white house evolves because of the adventure, not because the player performs chores. Meaningful changes follow from discoveries, objects, repairs, damage, returns, visitors, rest, dreams, and consequences.

The Attic is a period-authentic archive of this player's actual run: correspondence, notes, dossiers, case files, maps, photographs, cassettes, printouts, dream notebooks, overnight reports, and separate expedition boxes.

> The house has been quietly writing the history of you.

## Controlling rules

1. Adventure consequences, not upkeep.
2. Canonical object and actor identity remains authoritative.
3. The trophy case keeps canonical scoring.
4. No unseen solution leakage.
5. Playback and record review never mutate live state.
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
| 8 | 1226 | 298,496 | `0xc6b449e8` | `9a257606633e5595ab5c8c2f6d2c5813028c45e08389c805ca81ca113445f9f6` | Complete |
| 9 | 1227 | 307,712 | `0xfb794f11` | `6146311cd1fab20c5fde50f12a569c3ea9b34fd0f42038448f44f3740b9936f0` | Complete |
| 10 | 1228 | 316,160 | `0x3505b8ad` | `8993684cb8cb6e613dffc6e294c4d5edd15da22ab3a340ba4dc2d572f2f084e5` | Complete |

## Trains 1–9

Trains 1–5 establish the evolving house. Trains 6–9 create the physical Attic archive, player-specific dossiers, regional case files, and bounded playback. Canonical rooms, routes, mechanisms, actors, objects, score, timers, randomness, and parser state remain authoritative.

## Train 10 — Bedroom Rest and Dreams

Status: `complete`

Release `1228` adds one reachable Bedroom above the Living Room while preserving original `WAIT` / `Z` behavior. The Bedroom provides optional `SLEEP`, `REST`, `NAP`, `DOZE`, and `LIE DOWN`, a physical four-poster bed, `REST-DREAM-01`, and `REST-OVERNIGHT-02`.

Full sleep advances the real canonical clock one step at a time and stops on interruption. It may apply only bounded temporary recovery when newly earned evidence changes the rest signature. Repeated sleep without new evidence becomes a one-turn shallow doze rather than a timer skip or healing farm.

Dreams are deterministic and limited to evidence already earned by this expedition. Overnight consequences reuse existing mail, visitor, theft, water, smoke, custody, and archive systems. Train 10 does not originate Train 11's wider vulnerability, intrusion, damage-propagation, or repair controllers.

GitHub Actions run `30547861041` passed locked identity, original `WAIT` smoke, Bedroom access, queued-visitor forced waking, real clock advancement, bounded recovery, anti-farming, House/forest/Dam dream progression, no-unearned-dream checks, parser-valid filing, deliberate corruption, and native restore.

Controlling records:

- `glulx/house-rest-and-dreams/README.md`;
- `expanded/docs/HOUSE_REST_AND_DREAMS_CONTRACT.md`.

## Next existing train — House Vulnerability and Intrusion

Continue directly with `onyx_zork_house_vulnerability` above exact qualified Release `1228`.

Train 11 must execute its existing eight beads directly:

1. house damage and condition transitions;
2. smoke, damp, and Cellar-water propagation;
3. thief burglary and display disturbance;
4. creature and follower intrusion;
5. mirror, shadow, ritual, and cursed-object effects;
6. meaningful repair without chores;
7. vulnerability gameplay and persistence;
8. house vulnerability capstone.

House vulnerability must remain authored and bounded. It may let earned hazards affect the home, but it must not become survival-game maintenance, a universal simulation, a duplicate actor controller, or a sub-bead hierarchy.
