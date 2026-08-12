# Far Horizon Experiment — Multi-Agent Living Zork

**Status:** FAR HORIZON / EXPERIMENT ONLY  
**Captured:** August 12, 2026  
**Applies to:** Highly Extended Zork / this expanded Zork world  
**Production status:** explicitly not part of the normal game roadmap yet

## The experiment

Run a special playthrough in which major characters are not driven only by their normal authored routines. Instead, each important participant is represented by a separate AI agent with its own perspective, memory, goals, observations, and ability to choose actions inside the Zork world.

At minimum:

- one AI plays **the Adventurer**, who is male for this experiment;
- one independent AI plays **Mara**, who is female;
- one independent AI plays the **troll** or **thief**;
- additional overhauled NPCs may each receive their own independent AI agent as the experiment expands.

This is not intended to replace canonical Zork, canonical NPC behavior, or the normal parser game. It is a deliberately separate experiment using this expanded Zork world as the simulation substrate.

## Core idea

The world remains authoritative.

The AI agents do not invent room state, object ownership, exits, damage, time, weather, inventory, or prior events. Zork supplies each agent with the portion of authoritative world state that character can reasonably perceive or remember. The agent chooses an intention or action; Zork adjudicates whether it can actually happen and applies the resulting state changes.

In other words:

**Zork world state -> character-specific observation -> independent AI decision -> parser/world action -> authoritative consequence**

The interesting result is not an AI writing Zork fan fiction. It is multiple independently motivated participants acting inside the same persistent Zork simulation.

## Experimental unbounded routes

For this experimental mode only, character routing may be deliberately loosened far beyond normal authored NPC movement limits.

The Adventurer, Mara, thief, troll, and selected other NPC agents should eventually be able to attempt meaningful travel throughout essentially the whole expanded world rather than being confined to the narrow route sets required by the production game.

Achieving this will likely require substantial future work in areas such as:

- generalized actor traversal through the canonical room graph;
- actor-specific handling of doors, ladders, ropes, boats, vertical movement, hazards, darkness, water, and damaged routes;
- persistent per-actor inventory and object custody;
- path planning that respects what the character actually knows;
- handling of blocked, dangerous, altered, or newly opened routes;
- independent decisions to retreat, wait, hide, follow, search, rescue, steal, sabotage, bargain, or pursue;
- simultaneous or interleaved movement when several autonomous actors are active in different parts of the world.

"Unbounded" here means **unbounded by the production NPC route cages**, not magical teleportation and not permission to ignore physical world state. If a bridge is gone, the actor still needs another route. If a door is locked, the actor must solve, bypass, force, or abandon it according to the same world truth that governs everyone else.

## Character separation

Each AI agent should be genuinely separate.

It should not receive another character's hidden thoughts, private memory, off-screen observations, or plans merely because all agents are hosted by the same experiment harness.

The Adventurer should not know where the thief is unless he has evidence. Mara should not know what happened across the map unless she witnessed it, was told, found evidence, or can reasonably infer it. The troll should not become omniscient because the runtime knows the complete room graph.

Character identity data, including names and pronouns, must be supplied explicitly by the game state rather than guessed by the model.

## Why this is interesting

This experiment could expose behaviors that ordinary scripted NPC routing cannot produce naturally:

- Mara deciding on her own to search for the Adventurer after a separation;
- the thief noticing a newly valuable opportunity elsewhere in the world and physically traveling to exploit it;
- the troll retreating with a stolen weapon and later choosing where to reappear;
- two characters independently trying to reach the same object for different reasons;
- one AI misleading another through dialogue while the actual world state remains objective;
- rescue attempts that were not pre-scripted as a single scene;
- grudges, promises, alliances, avoidance, curiosity, fear, and opportunism developing from remembered events rather than hidden relationship-point grinding;
- several actors producing an emergent sequence of events that remains grounded in exact rooms, exact objects, and actual causal history.

A successful run should feel less like several chatbots sharing a transcript and more like several people inhabiting the same hostile little universe.

## Parser and action boundary

Agents should eventually act through a bounded world-action interface that maps cleanly onto the game's actual action semantics.

Natural-language reasoning may happen outside the game, but the action submitted to Zork must resolve into something the authoritative world can adjudicate: movement, taking, dropping, opening, tying, attacking, speaking, waiting, hiding, examining, using an object, and so on.

The model must never be allowed to declare its own success.

If an agent says, "I climb the wall and reach the roof," the experiment still asks Zork whether that wall is climbable, whether the actor has what is needed, and what actually happens.

## Time and concurrency

This experiment becomes substantially more interesting after Living Time, weather, broader hazards, and actor-state work exist.

A future scheduler may give each autonomous actor turns or action opportunities while preserving deterministic world ordering. Characters may be far apart and acting during the same simulated period, but all consequences must still resolve through one authoritative history.

This is intentionally a later problem. Do not build a giant real-time actor scheduler merely to begin the experiment.

## Memory

Each agent may eventually receive a character-specific memory derived from real game events:

- what that character personally witnessed;
- what another character told them;
- promises or threats exchanged;
- objects they owned, lost, stole, gave away, or saw someone else carrying;
- places they visited;
- injuries, rescues, betrayals, victories, humiliations, and warnings;
- beliefs that may be incomplete or wrong.

The world record remains factual. Character memory may be partial, mistaken, deceptive, or contradicted by later evidence.

## Deliberate experimental freedoms

Because this is an experiment, it may temporarily relax production assumptions that would be unacceptable in the shipped canonical experience, especially NPC route confinement and the amount of autonomous initiative granted to characters.

Those freedoms must remain isolated to the experiment. They are not permission to silently rewrite the normal game around LLM behavior.

The experiment should be switchable, disposable, and incapable of corrupting ordinary saves or redefining canonical behavior.

## Non-goals

Do not turn this into:

- one omniscient model role-playing every character;
- an unrestricted chatbot pasted over the parser;
- procedurally generated world state;
- arbitrary teleportation masquerading as autonomy;
- an LLM deciding whether physics or puzzle rules succeeded;
- a replacement for authored Zork prose, puzzles, or canonical NPC behavior;
- a production dependency on any one model provider;
- an excuse to build this before the underlying expanded world is mature enough to make the experiment interesting.

## Dependencies before serious implementation

This should remain far off until most of the following exist or are mature enough to reuse:

1. stable room, object, and actor identities;
2. reliable read-only world-state export;
3. exact actor inventory and custody;
4. broader NPC movement and route semantics;
5. persistent environmental consequences;
6. character-specific observation and memory boundaries;
7. richer Mara, thief, troll, and other NPC behavior;
8. time/daylight and eventually weather where appropriate;
9. a safe external-provider configuration surface if remote models are used;
10. deterministic logging sufficient to reconstruct why every submitted action produced its actual result.

## Promotion rule

Do **not** promote this into a normal product train merely because multi-agent models become easy to call.

Promote it only when the expanded Zork world itself is rich enough that giving several autonomous characters broad freedom will reveal something worth observing.

Until then, this remains exactly what it is intended to be:

> **A far-future experiment in letting several independent minds loose inside the same authoritative, highly extended Zork world — and seeing what the hell they do.**
