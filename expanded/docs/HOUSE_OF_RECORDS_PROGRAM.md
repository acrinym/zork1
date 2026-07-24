# House of Records — Evolving White House and Attic Archive Program

## Status

Active twelve-train, ninety-six-bead program above qualified Glulx Release `1220`.

- **Train 1 complete:** `onyx_zork_house_state_foundation` — Release `1219`.
- **Train 2 in capstone:** `onyx_zork_house_living_museum` — qualified Release `1220`.

Current capstone-candidate state:

- 12 trains total;
- 96 beads total;
- 8 closed Train 1 beads;
- 7 closed Train 2 implementation/qualification beads;
- Train 2 capstone bead open;
- 81 open beads total;
- no sub-beads or planning hierarchy beneath the existing train beads.

This program has two connected product directions:

1. make the white house an evolving home base, museum, workshop, archive, refuge, and possible target rather than only a treasure deposit;
2. make the Attic a period-authentic archive of the player's actual adventure, including notes, NPC statements, area case files, curated transcripts, postgame playback, and separate records for multiple completed expeditions.

The program is intentionally split into **twelve trains and ninety-six beads**. The beads are the implementation units. They do not need another hierarchy beneath them.

## Product thesis

The house should evolve because of the adventure, not because the player performs chores.

A meaningful house change must come from something the player discovered, recovered, displayed, repaired, damaged, carried home, released, promised, received, survived, or foolishly experimented with.

The Attic must not be a generic encyclopedia. It should preserve evidence from this player's run:

- notes and letters;
- important NPC statements;
- gifts, threats, mercy, deception, restraint, bargains, and combat;
- puzzle and mechanism discoveries;
- altered object states;
- major commands and responses;
- area-completion records;
- final world and house state;
- and later, comparisons between separate completed expeditions.

> The house has been quietly writing the history of you.

## Qualified Train 1 — Release 1219 house-state foundation

Train 1 established the shared substrate that every later House of Records train must reuse rather than replace.

Qualified identity:

- edition: Unofficial House State Foundation Glulx;
- release: `1219`;
- serial: `260724`;
- output: `zork1-glulx-house-state-foundation.ulx`;
- Glulx version: `3.1.3` / `0x00030103`;
- size: `230,144` bytes;
- checksum: `0xbe6bc80a`;
- SHA-256: `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f`.

Release `1219` derives from exact qualified Release `1218` and changes exactly:

- `1actions.zil`;
- `1dungeon.zil`;
- `assistance.zil`;
- new `house_state_foundation.zil`;
- `zork1.zil`.

It adds five compact state axes:

- condition;
- collection;
- knowledge;
- security;
- atmosphere.

It records bounded receipts for meaningful house use, Attic entry, Cellar crossing, return, real trophy-case collection, and physical disturbance. State derives from real canonical rooms and objects: the trophy case and `OTVAL-FROB`, rug, trap door, kitchen window, room visits, and Cellar return cycle.

Release `1218` contains no canonical Bedroom room. Train 1 therefore added no unreachable Bedroom placeholder or topology change.

Controlling record:

`glulx/house-state-foundation/README.md`

## Qualified Train 2 — Release 1220 Living Room museum

Train 2 turns the canonical Living Room into an optional physical autobiography while preserving Release `1219` house state and canonical Zork scoring, objects, puzzles, parser behavior, and carrying limits.

Qualified identity:

- edition: Unofficial Living Room Museum Glulx;
- release: `1220`;
- serial: `260724`;
- output: `zork1-glulx-living-room-museum.ulx`;
- Glulx version: `3.1.3` / `0x00030103`;
- size: `237,312` bytes;
- checksum: `0x630d724a`;
- SHA-256: `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4`.

Release `1220` derives from exact qualified Release `1219` and changes exactly:

- `1actions.zil`;
- `assistance.zil`;
- new `living_room_museum.zil`;
- `zork1.zil`.

The Living Room gains four fixed physical surfaces:

- gallery frame;
- weapon wall;
- record shelf;
- relic stand.

Players place and recover the original objects with ordinary parser actions. The canonical trophy case remains the only house scoring authority. New surfaces are score-neutral. Active field objects remain real, removable, and explicitly described as non-retired.

Current real arrangements can synthesize optional observations for:

- painting + sword + map;
- completed bell + candles + black-book ceremony;
- repaired dam guide + wrench + screwdriver;
- sword + troll axe;
- intact or broken egg with its correctly nested canary.

When Release `1219` marks the house exposed and the canonical thief remains available, one exact unsecured treasure can move into the real thief's inventory. The Living Room retains physical evidence. Recovery proceeds through canonical thief booty handling. The qualification route proves the real painting moves to the real thief and then to the real Treasure Room without cloning or deletion.

The native persistence route deliberately clears display surfaces, historical globals, thief custody, trophy-case placement, and score state, then restores exact placement, group history, evidence, score authority, thief custody, and egg/canary nesting without a repair pass.

The route also corrected false assumptions rather than weakening the game:

- it uses the object's real parser word `GUIDE`, not `GUIDEBOOK`;
- it preserves canonical carrying limits;
- it tests the active bell before ritual completion;
- it uses ASCII-safe provenance punctuation;
- it does not overclaim that dam tools were cleaned.

Controlling record:

`glulx/living-room-museum/README.md`

## Period presentation

The archive should use the material culture of the period when the original game was made, not an in-world Zork calendar and not a modern phone or cloud-drive metaphor.

Preferred surfaces:

- steel filing cabinets;
- index-card catalogs;
- banker boxes;
- continuous-feed line-printer paper;
- cassette tapes and a tape recorder;
- microfiche and film reels;
- Polaroids;
- maps, diagrams, and corkboards;
- paper folders with stamps, annotations, redactions, and cross-references;
- and a late-1970s terminal with terse archive commands.

The terminal may be efficient, but the fiction remains physical. A query locates a drawer, card, tape, folder, box, photograph, reel, or printout.

## Core design rules

1. **Adventure consequences, not upkeep.** No sweeping, hunger meters, lumber economies, daily repair chores, or furniture grind.
2. **Canonical identity remains authoritative.** Do not duplicate treasure, actors, notes, tools, or puzzle objects for display or archive purposes.
3. **The trophy case keeps canonical scoring.** Optional displays deepen history and atmosphere but do not create parallel scoring.
4. **The archive never reveals unseen solutions.** Partial files may show missing or redacted evidence without leaking commands or outcomes.
5. **Playback is observational.** Reviewing a tape or transcript cannot mutate live objects, actors, timers, score, pronouns, or room state.
6. **Mutually exclusive histories remain separate.** Different completed playthroughs become different expedition boxes rather than one contradictory timeline.
7. **Save and restore are first-class.** Every stateful train includes deliberate corruption and ordinary native restore proof.
8. **Actor records are player-specific.** A troll dossier records what happened between this player and this troll, not merely a static biography.
9. **Area completion unlocks synthesis, not a checklist HUD.** The archive summarizes a case only after the player genuinely assembled its evidence.
10. **Authored scope beats universal simulation.** Kitchen experiments, house damage, mail, visitors, dreams, and intrusions use selected coherent interactions.
11. **One substrate.** Later house trains consume Releases `1219` and `1220` instead of creating parallel house-memory or museum controllers.
12. **No hierarchy inflation.** Trains contain beads; beads do not receive sub-beads.

## The house as a real place

### Living Room — museum and visible autobiography

Release `1220` now makes this real. The canonical trophy case retains score authority, while fixed score-neutral surfaces accept bounded families of real objects. Objects remain removable and puzzle-active. Coherent arrangements produce historical observations, and poor security can result in exact-object theft with physical evidence and canonical recovery.

### Kitchen — preparation and grounded experimentation

The Kitchen may support real container filling, cleaning, drying, warming, cooling, food preparation, storage, and a bounded set of authored object reactions. It must not become a crafting tree, universal chemistry system, recipe economy, or hunger simulator.

### Cellar — expedition threshold

The Cellar becomes the boundary between home and the underground. It may support tool and light staging, trap-door observation, sounds and drafts from below, carried-hazard warnings, limited containment, and deterministic hooks for smoke, water, thieves, creatures, or supernatural effects crossing into the house.

### Bedroom — recovery, dreams, and delayed consequences

A Bedroom is future authored topology, not part of Releases `1219` or `1220`. When deliberately added, rest remains optional. It may advance ordinary queues, recover selected temporary states, generate authored dreams from discoveries, and process overnight mail, theft, damp, smoke, visitors, or archive updates.

### Mailbox and front of house — correspondence and visitors

The canonical leaflet and mailbox remain intact. A deterministic queue may add warnings, threats, replies, deliveries, maintenance notices, bureaucratic absurdities, and evidence. Records retain sender, trigger, authenticity, delivery order, later annotations, and Attic cross-references.

### Attic — the living archive

The Attic stores correspondence, NPC dossiers, area case files, curated transcripts, cassette-style playback, maps, diagrams, photographs, and completed expedition boxes. It is a museum of evidence, a record of what happened, and a way to replay the completed adventure through the player's own commands and the world's responses.

## Archive record model

A record should be structured around evidence rather than prewritten codex prose.

Minimum fields:

- stable record ID;
- record kind;
- expedition ID;
- discovery or delivery order;
- source and provenance;
- linked person, place, object, and incident IDs;
- exact or normalized quote where applicable;
- state transition or outcome;
- truth status and confidence;
- redaction or missing-evidence state;
- later annotations;
- related record IDs;
- physical-media presentation;
- and whether the record is curated, raw, partial, complete, or postgame-only.

## NPC dossiers

Dossiers are histories of relationships, not static biographies.

A troll file may record first contact, hostility, axe state, deception, restraint, opened passages, untie, recovery, renewed danger, gifts, threats, mercy, and exact statements. Cyclops and thief files follow the same principle while preserving canonical timing, theft, combat, bargains, and alternate outcomes.

Partial files may be redacted, contradictory, or visibly incomplete. They must never expose unseen dialogue or solutions.

## Area case files and completion

Before an area is complete, its folder may contain missing documents, empty card slots, redacted diagrams, unresolved mechanism entries, contradictory records, or explicit notices that evidence is absent.

At genuine completion, the archive may add a synthesis page explaining how discovered evidence fits together. This remains retrospective and cannot replace discovery while the player is solving the area.

Pilot files include:

- Flood Control Dam #3;
- the Hades ceremony;
- the house, forest, and representative underground areas.

Release `1220` already provides real-object group receipts that these case files can later consume.

## Playback

Playback reconstructs the player's actual run through text.

- A cassette record may print tape hiss, pauses, speaker labels, and environmental sounds.
- A line-printer transcript shows the player's command and the game's response.
- An incident file groups meaningful commands, statements, failures, discoveries, and state changes from one encounter.
- Raw logs remain optional and bounded.
- Curated files prioritize unique statements and consequential events rather than dumping every parser turn.

Playback is never time travel. It cannot modify live game state.

## Multiple expeditions

After victory, each completed run receives a separate archival box containing route chronology, deaths, treasures, actor outcomes, area outcomes, altered objects, correspondence, house condition, display arrangement, unresolved evidence, and final mechanism states.

Comparison commands may show differences between runs, but they cannot reveal unseen solution text merely because another outcome exists.

## Program sequencing

- Train 1 is complete and authoritative as Release `1219`.
- Train 2 is qualified as Release `1220` and awaits capstone closure.
- Trains 3–5 and 10 may build above the qualified house foundation; later work should consume museum events where relevant.
- Train 6 establishes the archive substrate.
- Trains 7–9 build dossiers, case files, and playback above the archive substrate.
- Train 11 depends on the Cellar threshold and integrates with museum, rest, and archive state.
- Train 12 closes the program after the archive and house systems are mature.

## Trains

| # | Beadtrain | Status | Purpose |
|---:|---|---|---|
| 1 | `onyx_zork_house_state_foundation` | **Complete — Release 1219** | Persistent house condition, event receipts, description projection, isolation, migration, and restore |
| 2 | `onyx_zork_house_living_museum` | **Capstone — qualified Release 1220** | Trophy-case-safe displays, provenance, group synthesis, theft, and object-tree persistence |
| 3 | `onyx_zork_house_kitchen_laboratory` | Planned | Water, cleaning, drying, food, storage, and bounded experiments without crafting grind |
| 4 | `onyx_zork_house_cellar_threshold` | Planned | Expedition staging, sensing, hazard screening, containment, and intrusion hooks |
| 5 | `onyx_zork_house_correspondence_visitors` | Planned | Mail queue, provenance, replies, deliveries, visitors, and missed-event persistence |
| 6 | `onyx_zork_attic_archive_core` | Planned | Period media, record schema, card catalog, archive commands, provenance, and migration |
| 7 | `onyx_zork_attic_npc_dossiers` | Planned | Player-specific troll, cyclops, thief, quotation, and encounter histories |
| 8 | `onyx_zork_attic_area_case_files` | Planned | Partial/redacted area records, completion synthesis, and representative case files |
| 9 | `onyx_zork_attic_playback` | Planned | Curated capture, line-printer transcripts, cassette playback, scenes, and integrity |
| 10 | `onyx_zork_house_rest_and_dreams` | Planned | Optional rest, canonical timer safety, recovery, dreams, overnight changes, and waking |
| 11 | `onyx_zork_house_vulnerability` | Planned | Smoke, damp, water, burglary, followers, supernatural effects, and meaningful repair |
| 12 | `onyx_zork_expedition_archive` | Planned | Victory record, timeline, final state, separate run boxes, comparison, migration, and program capstone |

Each train contains eight beads. The canonical issue records are sharded across:

- `.beads/issues-zork-house-of-records-01.jsonl`
- `.beads/issues-zork-house-of-records-02.jsonl`
- `.beads/issues-zork-house-of-records-03.jsonl`
- `.beads/issues-zork-house-of-records-04.jsonl`

Current capstone-candidate state is fifteen closed beads and eighty-one open beads. Train 2 becomes sixteen closed / eighty open only after exact-head capstone evidence passes.

## Qualification standard

Every implementation train must:

1. resolve the exact live base before editing;
2. publish a narrow production delta and explicit exclusions;
3. use real canonical objects and actors;
4. reject test-only setup, mutation, report, and positioning verbs from production;
5. build with pinned toolchains;
6. run deterministic player-facing routes;
7. deliberately corrupt state and prove ordinary native `SAVE` / `RESTORE`;
8. verify no duplicate object, score, actor, note, or archive record;
9. update this program, the frontier, feature matrix, and relevant README;
10. close beads only after exact-head evidence passes;
11. leave PRs open and unmerged unless Justin explicitly gives the merge whistle.

## Explicit non-goals

- generic base building;
- crafting trees;
- survival meters;
- housekeeping chores;
- universal physics or chemistry;
- open-ended AI dialogue;
- modern phone or cloud-drive metaphors;
- full transcript dumping as the primary interface;
- revealing unseen solutions;
- merging contradictory playthroughs;
- using the archive to repair live state;
- replacing Zork's parser identity with free-form natural language;
- sub-beads or sub-trains beneath the established House of Records beads.

## Definition of success

The program succeeds when the house feels like the player's place in the Great Underground Empire and the Attic can reconstruct why it became that way.

The player should be able to return home and understand what they recovered, what they changed, what followed them home, what the world sent them, what important characters said and did, how each area was resolved, what remains unknown, and how this expedition differed from another.
