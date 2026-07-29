# House of Records — Evolving White House and Attic Archive Program

## Status

Active twelve-train, ninety-six-bead program above qualified Glulx Release `1223`.

- **Train 1 complete:** `onyx_zork_house_state_foundation` — Release `1219`.
- **Train 2 complete:** `onyx_zork_house_living_museum` — Release `1220`.
- **Train 3 complete:** `onyx_zork_house_kitchen_laboratory` — Release `1221`.
- **Train 4 complete:** `onyx_zork_house_cellar_threshold` — Release `1222`.
- **Train 5 complete:** `onyx_zork_house_correspondence_visitors` — Release `1223`.
- **Next existing train:** `onyx_zork_attic_archive_core`.

Current truth:

- 12 trains;
- 96 beads;
- 40 closed beads across Trains 1–5;
- 56 open beads across Trains 6–12;
- no sub-beads, sub-trains, or planning hierarchy beneath the existing beads.

## Product thesis

The white house evolves because of the adventure, not because the player performs chores. Meaningful changes follow from discoveries, objects, repairs, damage, returns, visitors, and consequences.

The Attic becomes a period-authentic archive of this player's actual run: correspondence, notes, dossiers, case files, maps, photographs, cassettes, printouts, and separate expedition boxes.

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

## Train 1 — House State Foundation

Compact versioned condition, collection, knowledge, security, and atmosphere state; bounded house receipts; canonical room projection; conservative migration; native restore; no parallel score, chore loop, or fabricated Bedroom.

Controlling record: `glulx/house-state-foundation/README.md`

## Train 2 — Living Room Museum

Real-object frame, weapon wall, record shelf, and relic stand; canonical trophy-case score authority; provenance and group synthesis; canonical thief theft/recovery; physical evidence; nested object-tree persistence.

Controlling record: `glulx/living-room-museum/README.md`

## Train 3 — House Kitchen Laboratory

Canonical water, bottle, food, knives, tools, sink, worktop, cupboard, and range; bounded cleaning, wetness, warmth, preparation, quenching, storage, creature context, and restore. Kitchen state is packed to remain below the Glulx global limit.

Controlling records:

- `glulx/house-kitchen-laboratory/README.md`
- `expanded/docs/HOUSE_KITCHEN_LABORATORY_MATRIX.md`

## Train 4 — House Cellar Threshold

Status: `complete`

Qualified Release `1222` adds real-object expedition staging, trap-door observation without a duplicate route, bounded sounds/drafts/dampness, carried-hazard warnings, recoverable quarantine, causal intrusion evidence, real-water cleanup, and exact restore.

Exact production delta above Release `1221`:

- `1actions.zil`;
- `assistance.zil`;
- new `house_cellar_threshold.zil`;
- `shadow_logic.zil`;
- `zork1.zil`.

All 31 workflows passed on exact closure head `72ca166d71f055c438906794a36988f2c742d834`.

Controlling records:

- `glulx/house-cellar-threshold/README.md`
- `expanded/docs/HOUSE_CELLAR_THRESHOLD_MATRIX.md`

## Train 5 — House Correspondence and Visitors

Train: `onyx_zork_house_correspondence_visitors`

Status: `complete`

Qualified Release `1223` identity:

- serial `260724`;
- Glulx `3.1.3` / `0x00030103`;
- 271,872 bytes;
- checksum `0x4cbcc561`;
- SHA-256 `362b5567e2ee705dc382256fe3420b9e729486acbcdf68b91a8ccdda0c893816`.

Exact base:

- Release `1222` SHA-256 `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912`.

Exact production delta:

- `1actions.zil`;
- `assistance.zil`;
- new `house_correspondence_visitors.zil`;
- `shadow_logic.zil`;
- `zork1.zil`.

Qualified behavior includes:

1. a deterministic three-message queue derived from Cellar intrusion, museum theft, and repaired-dam state;
2. one exact physical letter per trigger;
3. sender/source, trigger, delivery, authenticity, and filing-code provenance;
4. the canonical mailbox and original leaflet remaining authoritative;
5. one reusable physical stamped reply card with fixed authored responses;
6. parser-valid `RESPOND TO` and `PUT STAMPED CARD IN MAILBOX` commands;
7. a surveyor and courier as bounded exterior visitors;
8. ordinary `TELL`, bounded `REFUSE`, and bounded `ADMIT` without opening the boarded door;
9. unique missed notices and one bounded return;
10. unique accepted-visit receipt and survey tag;
11. compact correspondence `RECAP` receipts;
12. native save, deliberate trigger removal/corruption, and exact restore.

The first compile exceeded the Glulx global limit by one. The mutable packed state table became constant-addressed instead of dropping behavior. Parser and action-order corrections preserved ordinary play rather than adding test-only shortcuts.

All 33 capstone-candidate workflows passed with no retry on exact audited head `7e9019dc3c336413ea07df400341fa6474a3cff6`. All eight Train 5 beads are closed.

Controlling records:

- `glulx/house-correspondence-visitors/README.md`
- `expanded/docs/HOUSE_CORRESPONDENCE_VISITORS_CONTRACT.md`
- `expanded/docs/HOUSE_OF_RECORDS_HANDOFF.md`

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

## Next existing train — Attic Archive Core

Continue directly with `onyx_zork_attic_archive_core` after resolving PR #21's exact live head.

Train 6 must execute its existing eight beads directly and build the canonical archive-record schema, physical media taxonomy, card catalog, filing surfaces, explicit retrieval commands, truth/provenance state, migration, native persistence, and capstone without creating a modern filesystem, universal logger, duplicate archive, unseen-solution leak, or sub-bead hierarchy.
