# Highly Extended Zork

## Status

Future Zork concept lane. The House of Records program is complete in Release `1230`; this directory remains outside that closed 12-train, 96-bead lineage and does not retroactively add sub-beads to it.

Highly Extended Zork is now a valid candidate for the next Zork product phase, but this PR remains documentation-only until Justin explicitly promotes the lane into implementation.

## Core direction

Extend Zork I into a much larger persistent interactive-fiction world while preserving the original game's places, objects, actors, puzzles, score authority, humor, and consequences.

The completed House work demonstrates that the world can remember and present far more than a traditional room-and-object parser model:

- object provenance and custody;
- event chronology;
- correspondence and visitors;
- physical records and case files;
- deterministic playback;
- dreams based on actual discoveries;
- bounded incidents, damage, and repairs;
- native save/restore continuity.

Highly Extended Zork carries those principles outward into the Great Underground Empire.

## First major direction: museum and living natural history

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

Food can connect ecology, travel, the museum, regional history, physical exertion, and object provenance without becoming a generic survival layer.

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
- our original extensions, including the museum, ecology, fishing, cooking, hunger, satiation, stamina, and House memory systems.

The research file is evidence and inspiration, not a second Kanban, bead hierarchy, or implementation claim.

## Post-House product sequence

When Justin promotes Highly Extended Zork, implementation should start from the live post-House `master`, not from this old concept branch.

The first product train should be **Museum Intake and First Gallery**: a complete playable museum beginning with a real route, curator, intake rules, several canonical-safe exhibits, provenance-aware plaques, visible gallery change, parser completeness, and native save/restore.

That avoids two bad starts:

- building abstract museum infrastructure with no enjoyable player loop;
- jumping directly into hundreds of fish, recipes, or survival variables before the museum has a reason to exist.

A sensible product order is:

1. **Museum Intake and First Gallery** — complete donation, loan, registration, custody, plaque, revisit, and save/restore loop.
2. **Living Ecology and Fishing** — real water bodies, observation, catching, release, specimen condition, varieties, and museum research.
3. **Cuisine and Expedition Nourishment** — ingredients, preparation, preservation, slow hunger, distinct satiation, exertion-based stamina, and rare-specimen decisions.
4. **Regional Expansion** — additional settlements, ecologies, cuisine traditions, expeditions, correspondence, and museum-driven mysteries.

Each item should become a complete product train only when selected. The sequence is directional, not a hidden bead backlog.

## Design principles

### Discovery before checklist

The museum should not reveal every missing object immediately. Early exhibits show broad gaps and suggestive categories. More exact research becomes available as the player learns about a region.

### Evidence before omniscience

The game may know what an object is, but the museum records only what has been observed, documented, measured, or credibly reported.

### Real provenance

A plaque may remember:

- where the object was found;
- how and when it was acquired;
- whether it was given, stolen, recovered, purchased, caught, grown, or taken from a defeated creature;
- fire, water, magic, Hades, rainbow, combat, theft, and repair exposure;
- who previously possessed it;
- whether the displayed object is original, altered, restored, a replica, or only documented.

### Canonical authority

Museum systems must not fabricate replacement treasures, duplicate unique objects, silently solve puzzles, change score without authored cause, or erase existing custody and consequence state.

### Dense authored variety

A large world can contain many specimens and variants without becoming meaningless procedural noise. Variety should come from understandable combinations of place, circumstance, time, environment, and world history.

### Optional presentation layers

The parser remains authoritative and complete. Glulx TUI and 2D presentation may provide:

- gallery maps;
- exhibit cases and aquarium layouts;
- icons, silhouettes, labels, and discovery markers;
- selectable plaques;
- collection relationships;
- water, habitat, and provenance summaries;
- museum expansion views.

The same information remains accessible through commands such as `VIEW AQUATIC GALLERY`, `READ SILVERFIN PLAQUE`, `CHECK FOREST COLLECTION`, and `ASK CURATOR ABOUT TROLL FUR`.

## Other future directions suggested by this lane

- regional ecologies that respond to player-caused changes;
- unknown-object research and evolving descriptions;
- expeditions generated by museum questions rather than generic errands;
- scholarly disputes and unreliable historical interpretation;
- creatures and plants whose behavior changes after major world events;
- objects whose histories affect later interactions;
- the House, Attic, museum, correspondence, and field records presenting different views of the same event;
- museum exhibits that become active story locations rather than static rewards.

## Promotion rule

Before implementation or public/commercial release planning, verify current copyright, trademark, IP, rights-holder permission, repository policy, and release-policy requirements.

When a concept is selected for implementation, define a complete player-facing product train with its real dependencies and qualification journey. Do not treat this folder itself as implementation progress.
