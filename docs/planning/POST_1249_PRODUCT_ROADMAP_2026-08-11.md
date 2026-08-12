# Highly Extended Zork — Post-1249 Product Roadmap

**Updated:** August 11, 2026  
**Current production frontier:** Release `1249` — Underground Sensory Physicality  
**`master` head when this roadmap was written:** `bacb1a358f0ee126ee6ae629b589c3d3a0269ee9`  
**Latest merged PR:** #53

## Product state

Highly Extended Zork is no longer accurately described as the old Release 121 overlay.

The active Glulx lineage has now passed through the House of Records, corpus-coupled warnings, parser affordances, museum/ecology expeditions, cuisine and exertion, canyon consequences, veteran expedition play, Mara's field and House chapters, natural-play repair, destructible environments, richer narrative physicality, forest consequence physicality, and an authored early-underground sensory/physicality pass.

Release 1249 leaves the project at an important transition point: the world increasingly knows what objects, surfaces, height, sound, containers, damage, ropes, light, custody, and consequences *are*. The next product arc should let players deliberately combine that knowledge for advantage.

## New design doctrine: authorized exploitation

> **Canonical puzzles describe a reliable intended solution. They do not define the only physically valid solution.**

The project should deliberately support selected cases where the player notices that established mechanics interact and uses those interactions to bypass friction, create a shortcut, survive a danger, or solve a problem differently.

This is not bug exploitation. It is **authorized exploitation of the world model**.

A workaround is good when the player can explain why it should work before trying it.

### Core laws

1. **Canonical solutions remain valid.** New workarounds add possibility; they do not erase Infocom's route.
2. **World rules are reusable.** If an object has a real physical function, that function should matter in more than one authored context when reasonable.
3. **Mastery stays mastered.** Once a player has permanently solved a recurring nuisance, the game should not repeatedly charge the same puzzle labor.
4. **Cleverness should reduce friction, not create fetch-grind.** An alternate solution must not become fifty trips for recipe ingredients merely because it is alternate.
5. **Soft sequence breaks are allowed.** If preparation and physical state make a shortcut credible and the resulting game state remains completable, let it work.
6. **Consequences still apply.** A workaround may trade one inconvenience for another. Ear protection helps with noise but makes listening worse; a secured rope may be unavailable elsewhere; breaking something may alter later use.
7. **Useful objects are not colored keys.** Earmuffs are hearing protection, not a one-room token. Rope is rope. Containers retain contents. Damage remains damage.
8. **No giant crafting layer.** The parser may recognize a small set of obvious improvised preparations, but Highly Extended Zork is not becoming a survival-crafting game.
9. **No universal object-pair matrix.** Support high-value intersections explicitly and let the authored mesh grow.
10. **Do not punish alternate success.** No score deduction merely because the player solved a problem in a physically valid noncanonical way.

## Release 1250 — Player Ingenuity / Systemic Workarounds

This is the next train.

### Player outcome

The player can intentionally exploit already-established world mechanics to defeat selected inconveniences or obstacles without the game treating ingenuity as cheating.

### Loud Room showcase

The Loud Room is the first obvious demonstration.

The canonical `ECHO` solution remains completely intact.

In addition, the player should be able to obtain real hearing protection—most naturally a battered pair of industrial earmuffs in a physically plausible location—and use it as hearing protection.

A small authored improvised-earplug route may also exist if the player already possesses a physically suitable material. This should be direct parser reasoning, not a recipe tree.

Required behavior:

- `WEAR EARMUFFS` or the equivalent established clothing/wear path protects the adventurer from the Loud Room's worst acoustic interference.
- The Loud Room remains loud. The protection changes what reaches the adventurer rather than rewriting the room.
- The player can traverse the room without repeatedly re-solving its nuisance once protection is established.
- `ECHO` still works exactly as a canonical solution.
- Wearing hearing protection should sensibly weaken `LISTEN` interactions elsewhere.
- The item remains useful in later authored loud contexts.
- The item must not be locked behind pure RNG. Variable placement may be explored later only if availability is guaranteed.
- The workaround should not require an absurd cross-map material grind.

### Additional Release 1250 workarounds

Release 1250 should prove this is a product philosophy rather than a one-room patch by selecting at least two more existing obstacles where an already-established physical rule yields a credible advantage.

Good candidates should reuse current authorities such as:

- rope anchoring and movement restraint;
- containers carrying their real children;
- breakable surfaces and persistent damage;
- light/darkness state;
- height and falling-object consequences;
- sound and hearing;
- real object custody.

The train should choose concrete, high-value cases during implementation rather than inventing a generic solver.

### Release 1250 boundaries

- no universal crafting UI;
- no recipes, crafting levels, or resource economy;
- no all-object reaction table;
- no teleportation disguised as convenience;
- no automatic puzzle completion;
- no deletion of canonical `ECHO`;
- no score penalty for a valid workaround;
- no one-use destruction of a reusable mastery item merely to restore grind;
- no TODO/stub/no-op scaffolding.

## Ordered train queue

The release numbers below are the current intended order. Reordering is allowed when implementation evidence shows a dependency, but the player-facing direction should remain intact.

### Release 1251 — Cross-System Utility Mesh

Make selected established objects behave like genuine reusable tools across multiple authored contexts.

Primary families:

- rope;
- containers;
- light;
- hearing protection and sound;
- weight and carried burden;
- breakable surfaces;
- selected water interactions.

The objective is not breadth for its own sake. The objective is to create enough overlap that players begin asking, *"Does this thing work here too?"* and are sometimes rewarded for asking.

### Release 1252 — Earned Sequence Breaks & Route Mastery

Permit selected physically earned shortcuts and soft sequence breaks.

Examples of the desired shape:

- a route becomes easier because the player previously altered or prepared it;
- a recurring environmental nuisance stays solved;
- a reusable tool allows a route earlier than the canonical order;
- the player trades object custody, preparation, or risk for traversal.

Every promoted shortcut must be checked for:

- canonical completion safety;
- object custody;
- death/restore behavior;
- downstream puzzle state;
- sensible narration when the player arrives "early."

No debug teleport verbs or speedrunner-only menus.

### Release 1253 — Dam Survival & Prepared Rescue

Deepen Flood Control Dam #3 as a physical danger using its real water and gate state.

Candidate interactions:

- falls and slips with different entry causes;
- current direction and water level;
- encumbrance;
- prepared rope or maintenance-ladder rescue;
- plausible buoyant objects or debris;
- object loss and recovery.

This remains authored Dam gameplay, not a fluid simulator.

### Release 1254 — Troll Disarm & Stolen Weapons

Let the canonical troll knock away, seize, retain, or badly use real weapons under authored combat conditions.

Desired consequences include:

- persistent real weapon custody;
- visible stolen equipment on later encounters;
- taunts tied to actual history;
- bargaining or recovery routes;
- the possibility that the player's earlier weapon loss makes a later fight worse.

No duplicate sword, duplicate axe, generic NPC inventory framework, or combat rewrite.

### Release 1255 — Thief Retaliation & Sabotage

Give the thief more causal hostility.

Potential behavior:

- selective retaliatory theft;
- relocation or sabotage of meaningful objects;
- warnings before severe escalation;
- earned ambushes based on route and recent conflict;
- repair, avoidance, appeasement, or clever counterplay.

No invisible grindable hostility number and no omniscient hunting AI.

### Release 1256 — Grue Ecology & Colony Reveal

Let selected darkness experiments teach the player something real about grues.

Candidate arc:

- attempts to lure or repel a grue with sound, scent, warmth, movement, or stronger light;
- a moment where increased illumination appears to work;
- a signature reveal that the local danger is larger than one creature;
- authored retreat, barrier, silence, decoy, or catastrophic outcomes.

Do not turn every dark room into a hive or grues into standard combat mobs.

### Release 1257 — Fire, Smoke & Structural Consequences

Extend the current material-consequence philosophy into a deliberately small set of fire, smoke, collapse, and machinery interactions.

The goal is visible cause → warning → preparation → consequence, not a generalized chemistry or gas engine.

### Release 1258 — Mara Reciprocal Rescue & Shared Danger

Advance Mara through concrete shared history rather than an approval meter.

Candidate chapters:

- reciprocal rescue;
- injuries and recovery;
- promises;
- exact temporary custody;
- separation and reunion;
- difficult shared route decisions;
- remembered disagreement;
- real sacrifice or risk for the other person.

Romantic recognition, if it ever develops, must continue to emerge from earned shared history rather than a romance economy.

## Future lanes, not the immediate queue

### Causal Death & Warning Depth

Broaden the existing causal-warning work into selected new deaths, near-deaths, delayed consequences, and exact-object provenance. Keep each episode authored; do not build an abstract death machine merely because the categories exist.

### Museum & Ecology — second expansion

Continue the museum only when the collection produces new field play, provenance decisions, or ecology. Avoid checklist expansion for its own sake.

### Narrative perspective experiments

The first-person, normalized second-person, third-person, and interactive-storybook editions remain valid experiments. They should stay isolated editions built against real canonical state rather than becoming a universal narration framework.

## Parked / separate

- **S.T.A.L.K.E.R. Glulx** remains a separate game lane.
- **Protected corpus acquisition** remains rights-dependent.
- Large procedural world generation, randomized loot, and universal crafting remain outside the product direction.

## Definition of a successful future train

A future train should normally ship only when it has:

- a clear player-facing outcome;
- a natural route from real game state;
- preservation of canonical authorities;
- no duplicate journey-critical object identities;
- save/restore-safe state;
- natural-play qualification;
- no production debug shortcuts;
- no recursive audit machinery;
- no TODO-only or placeholder behavior;
- a reason a human player would actually notice and enjoy it.

The point of the next era is not to make Zork simulate everything.

It is to make the world coherent enough that the player can become clever *inside it*.
