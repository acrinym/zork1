# S.T.A.L.K.E.R. as Glulx Interactive Fiction

## Status

Independent future-game concept. This is not part of Zork's fiction or active implementation lineage.

## Core idea

Rebuild the experience of **S.T.A.L.K.E.R.: Shadow of Chernobyl** as a large Glulx interactive-fiction world where the player learns to read the Zone through descriptions, sound, detector behavior, rumors, physical evidence, field notes, and dangerous experimentation.

The goal is not to turn a shooter into a sequence of `SHOOT BANDIT` commands. The goal is to preserve and deepen the parts that made the world compelling:

- artifact lore and uncertain effects;
- anomalies with learnable but unstable rules;
- emissions and environmental danger;
- faction travel, conflict, and territory changes;
- campfire stories and contradictory testimony;
- abandoned places with layered histories;
- persistent NPCs, corpses, equipment, messages, and consequences;
- tactical movement, cover, observation, and retreat;
- laboratories, psi effects, dreams, hallucinations, and unreliable perception.

## Why Glulx fits

Glulx can support a large parser world plus optional Glk windows for:

- PDA map and territory status;
- tasks and messages;
- artifact field records;
- faction standing;
- known stalkers and death notices;
- inventory, ammunition, condition, radiation, bleeding, and protection summaries;
- location art, detector visualization, and ambient audio where interpreters support them.

The game must remain fully playable through text. Multimedia should deepen the experience rather than become required information.

## The Zone as a simulation

The world should continue moving beyond the player's immediate room:

- stalkers choose destinations and jobs;
- patrols travel and investigate;
- factions gain or lose positions;
- mutants migrate, hunt, feed, and avoid threats;
- traders receive stock through actual routes;
- missions may change or resolve without waiting forever for the player;
- emissions alter routes, populations, and anomaly fields;
- dropped gear and bodies remain until recovered, looted, scavenged, or lost.

Distant activity can be abstracted. Detailed simulation becomes active near the player or when an event materially affects known state.

## Artifact knowledge must be earned

The game may internally know an artifact's rules while the player initially knows only what has actually been observed.

A field record can progress through stages:

1. **Unknown formation** — appearance, location, detector response, and recovery circumstances.
2. **Observed behavior** — effects witnessed while carrying, testing, or approaching it.
3. **Rumored behavior** — claims from stalkers, traders, factions, and campfire stories.
4. **Measured behavior** — laboratory analysis and repeatable tests.
5. **Personal consequence** — injuries, protection, dreams, equipment interactions, or reputation caused by the artifact.

Sources may disagree. The player's own evidence does not automatically reveal every hidden rule.

## Anomaly interaction

Anomalies should be navigated through deliberate observation and tools:

- listen;
- watch dust, grass, water, loose metal, insects, and light;
- throw bolts or other test objects;
- use detectors with different capabilities;
- mark a route;
- crawl, leap, retreat, anchor, discard weight, or rescue another person;
- revisit after an emission and discover that the field has shifted.

Being seized, lifted, compressed, burned, displaced, or thrown should produce playable moments rather than a single damage message whenever possible.

## Combat direction

Combat is tactical and intention-driven rather than a health-bar exchange.

Relevant state includes:

- distance and line of sight;
- cover and concealment;
- stance and movement;
- weapon readiness and condition;
- ammunition type and remaining rounds;
- suppression, morale, panic, surrender, retreat, and pursuit;
- bleeding, armor penetration, radiation, exhaustion, and impaired perception;
- sound propagation and enemy uncertainty about the player's location.

Natural commands may express a complete intention, such as taking cover, watching a doorway, firing a controlled burst, changing ammunition, suppressing a window, or retreating while covering an ally.

## Horror opportunities unique to IF

Text can make perception itself unreliable:

- room descriptions change subtly;
- exits appear inconsistent;
- an inventory listing contains something never collected;
- a PDA timestamp runs backward;
- commands are understood in disturbing ways;
- familiar people are described incorrectly;
- memories, field notes, and physical evidence disagree;
- psi exposure changes prose before the player understands why.

The rules must remain authored and interpretable beneath the distortion. Horror should not become arbitrary parser sabotage.

## Product paths

Two legal and creative directions remain distinct:

### Direct fan adaptation

Reconstruct the original places, characters, factions, artifacts, quests, and story as a noncommercial fan project, subject to rights-holder permission and takedown risk.

### Original Zone-like game

Build a new exclusion territory, mythology, factions, anomalies, creatures, artifacts, characters, and campaign using the same design strengths. This may offer a potential path to an original releasable or commercial work, but originality alone does not establish clearance. Similarities in naming, branding, protected fictional elements, or trade dress still require legal/IP review before public or commercial release planning.

A future decision must choose the product path before public release planning.

## Relationship to the Zork work

The current Zork expansion work has already developed relevant design muscles:

- evidence-aware records;
- object provenance and custody;
- canonical consequences;
- persistent timed events;
- location memory;
- discovery-driven dreams;
- physical archives;
- save/restore qualification.

Those lessons may inform this project. The source, fiction, roadmap, and release lineage remain separate.