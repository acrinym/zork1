# Highly Extended Zork

## Status

Future Zork concept lane. The House of Records program is complete in Release `1230`; this directory remains outside that closed 12-train, 96-bead lineage and does not retroactively add sub-beads to it.

Highly Extended Zork is now a valid candidate for the next Zork product phase, but this PR remains documentation-only until Justin explicitly promotes one product family into implementation.

## Core direction

Extend Zork I into a much larger persistent interactive-fiction world while preserving the original game's places, objects, actors, puzzles, score authority, humor, danger, and consequences.

The completed House work demonstrates that the world can remember and present far more than a traditional room-and-object parser model:

- object provenance and custody;
- event chronology;
- correspondence and visitors;
- physical records and case files;
- deterministic playback;
- dreams based on actual discoveries;
- bounded incidents, damage, and repairs;
- separate completed-expedition histories;
- native save/restore continuity.

Highly Extended Zork carries those principles outward into the Great Underground Empire.

## Recovered pre-House direction

The museum was not the only expansion concept discussed before the House program.

Two substantial pre-BEADS boards were captured on July 23, 2026 and now exist on live `master`:

```text
docs/planning/LIVING_ZORK_FUTURE_IDEAS_KANBAN.md
docs/planning/HOUSE_EXPEDITION_STASH_AND_ZORK_PLUS_KANBAN.md
```

They preserve prior discussion of:

- causal death architecture;
- physical warnings and player-attention state;
- dam falls, swimming, drowning, encumbrance, and rescue preparation;
- the troll stealing and later using the real sword;
- thief relationship escalation, sabotage, warnings, ambush, and deliberate retaliation;
- grue ecology and a signature colony reveal;
- broader smoke, fire, machinery, collapse, suffocation, poison, magical, and self-inflicted consequences;
- richer NPC memory;
- deeper rope, water, tool, sound, scent, damage, and scenery affordances;
- authored replayability and conduct histories;
- a physical house expedition stash;
- bounded water, food, fuel, packing, and preparation surfaces;
- authored armor with weight, noise, heat, mobility, and social costs;
- `ZORK PLUS`, `SECOND EXPEDITION`, or `VETERAN EXPEDITION` postgame play;
- parser comprehension and a limited intent-classification layer;
- Shadowgate-style Glulx presentation;
- illustrated state coverage and a far-horizon 3D renderer bridge;
- Ethical Zork as an explicit alternate edition rather than a rewrite of normal mode.

See [Recovered Pre-House Extended Zork Directions](recovered-pre-house-directions.md) for the consolidated recovery and separation rules.

These directions are not superseded by the museum. They form the broader post-House frontier.

## Museum and living natural history

The museum remains a major Highly Extended Zork direction.

The player should be able to discover, register, donate, loan, and revisit specimens and artifacts from across the world.

Examples include:

- leaves, seeds, fungi, flowers, wood, and unusual forest growth;
- fish and other aquatic creatures from distinct waters and conditions;
- troll fur, teeth, scales, feathers, tracks, castings, and shed material;
- stones, ores, ash, residue, fragments, and anomalous substances;
- ordinary objects with exceptional provenance;
- replicas, sketches, rubbings, testimony, and measurements for unique items that cannot be surrendered.

The museum is not merely a completion screen. It is a persistent place with rooms, exhibits, plaques, curators, research, visitors, correspondence, disagreements, theft risk, upgrades, and new mysteries.

See [Museum Ecology and Fishing](museum-ecology-and-fishing.md).

## Cuisine, hunger, satiation, and stamina

Food can connect ecology, travel, the museum, regional history, physical exertion, expedition preparation, and object provenance without becoming a generic survival layer.

The future system distinguishes:

- slow hunger from immediate exertion;
- satiation from nutrition and stamina;
- meaningful preparation from repetitive kitchen busywork;
- authored contextual effects from interchangeable buff packages;
- rare specimens as choices between releasing, donating, registering, preserving, selling, researching, or cooking;
- recipe discovery through experimentation, NPCs, books, museum research, correspondence, and actual preparation;
- regional cuisine and memorable failures from generic crafting output.

Its governing rule is simple: food must create decisions, discoveries, humor, and stories—not repetitive eating chores or generic survival meters.

See [Cuisine, Hunger, Satiation, and Stamina](cuisine-hunger-satiation-and-stamina.md).

## Community wish archaeology

[Zork Community Wishes and Lost-Idea Archaeology](community-wishes-and-lost-ideas.md) records direct fan wishes, recurring preferences, historical gaps, abandoned fan-project directions, and modern-player pain points.

It explicitly separates:

- things people actually requested;
- complaints that imply a design problem;
- historical Dungeon/Zork material that needs source verification;
- our original extensions, including the Living Zork consequence work, Zork Plus, the museum, ecology, fishing, cooking, hunger, satiation, stamina, and House memory systems.

The research file is evidence and inspiration, not a second Kanban, bead hierarchy, or implementation claim.

## Post-House promotion frontier

Implementation must start from live post-House `master`, not from this old concept branch.

The House dependency is complete, but that does not automatically make the museum the next train. Strong first-train candidates now include:

1. **Causal Death and Warning Foundation** — semantic cause, knowledge, warning attention, near-death, exact-object involvement, and narrator culpability.
2. **Physical Expedition Stash** — one real House or Cellar locker with exact containment, death fate, recovery, and anti-duplication.
3. **Museum Intake and First Gallery** — a complete donation, loan, registration, custody, plaque, revisit, and save/restore loop.
4. **Parser Comprehension and Deep Affordances** — focused noun, verb, two-object, scenery, material, and intent improvements without a universal simulator.

These are alternatives for sequencing, not four trains to launch simultaneously.

The museum remains fully retained. The correction is that it is one major product family among several earlier recovered directions, and its position must be deliberately chosen rather than assumed.

## Design principles

### Deeper before merely larger

A larger map is valuable only when rooms, objects, actors, warnings, and consequences answer the player more deeply. Existing locations should accumulate additional behavior, evidence, danger, history, and alternate outcomes before the world becomes a mass of shallow new rooms.

### Discovery before checklist

The museum, archive, warnings, recipes, and postgame modes should not reveal every missing object, hidden outcome, or solution immediately. Knowledge must be earned through credible play.

### Evidence before omniscience

The game may know hidden rules, but player-facing records retain only what was observed, documented, measured, inferred, or credibly reported.

### Real provenance

An object, specimen, meal, warning, weapon, or archive record may remember:

- where it was found;
- how and when it was acquired;
- whether it was given, stolen, recovered, purchased, caught, grown, prepared, damaged, repaired, or taken from another actor;
- fire, water, magic, Hades, rainbow, combat, theft, ritual, and environmental exposure;
- who previously possessed it;
- whether it is original, altered, restored, a replica, or only documented.

### Canonical authority

Future systems must not fabricate replacement treasures, duplicate unique objects, silently solve puzzles, change score without authored cause, erase custody, merge contradictory expeditions, or replace actor motives with omniscient generic AI.

### Authored causality

New outcomes should follow from visible information, physical state, preparation, timing, motive, position, or risk. Failure should produce comedy, information, a clue, a remembered consequence, or several of these.

### Dense authored variety

Variety should come from understandable combinations of place, circumstance, time, environment, history, and player action—not arbitrary procedural naming or generated filler.

### Optional presentation layers

The parser remains authoritative and complete. Glulx TUI, 2D illustrations, action controls, maps, sound, and later renderer experiments may support play without becoming the sole source of required evidence.

## Other future directions

- regional ecologies that respond to player-caused changes;
- unknown-object research and evolving descriptions;
- expeditions generated by evidence or museum questions rather than generic errands;
- scholarly disputes and unreliable historical interpretation;
- creatures and plants whose behavior changes after major world events;
- objects whose histories affect later interactions;
- same-score expeditions with substantially different histories;
- physical caches, death-site recovery, and Veteran Expedition preparation;
- playable off-screen stories and alternate actor perspectives;
- the House, Attic, museum, correspondence, field records, warnings, and NPC testimony presenting different views of the same event;
- museum exhibits and archive records becoming active story locations rather than static rewards.

## Promotion rule

Before implementation or public/commercial release planning, verify current copyright, trademark, IP, rights-holder permission, repository policy, and release-policy requirements.

When a concept is selected for implementation, define one complete player-facing product train with its real dependencies and qualification journey. Do not treat this folder itself as implementation progress, reopen the completed House bead hierarchy, or silently start unrelated product families together.
