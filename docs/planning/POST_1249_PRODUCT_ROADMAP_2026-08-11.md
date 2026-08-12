# Highly Extended Zork — Post-1249 Product Roadmap

**Updated:** August 12, 2026  
**Current merged production frontier:** Release `1251` — Cross-System Utility Mesh  
**`master` head when Release 1252 began:** `147236fcc61ac98b993ff1905c6e07c6bfbb6079`  
**Latest merged product PR:** #56

## Product state

Highly Extended Zork is no longer accurately described as the old Release 121 overlay.

The active Glulx lineage has passed through the House of Records, corpus-coupled warnings, parser affordances, museum/ecology expeditions, cuisine and exertion, canyon consequences, veteran expedition play, Mara's field and House chapters, natural-play repair, destructible environments, richer narrative physicality, forest and underground consequence physicality, Player Ingenuity, and the Cross-System Utility Mesh.

The current direction is increasingly clear: the world should know enough about objects, surfaces, height, sound, containers, damage, ropes, light, custody, geography, and consequences that knowledgeable players can deliberately combine those truths for advantage.

## Design doctrine: authorized exploitation

> **Canonical puzzles describe a reliable intended solution. They do not define the only physically valid solution.**

The project deliberately supports selected cases where the player notices that established mechanics interact and uses those interactions to bypass friction, create a shortcut, survive a danger, or solve a problem differently.

This is not bug exploitation. It is **authorized exploitation of the world model**.

A workaround is good when the player can explain why it should work before trying it.

### Core laws

1. **Canonical solutions remain valid.** New workarounds add possibility; they do not erase Infocom's route.
2. **World rules are reusable.** If an object has a real physical function, that function should matter in more than one authored context when reasonable.
3. **Existing physical relationships become reusable gameplay infrastructure.** New trains should prefer composing proven authorities over inventing parallel state.
4. **Mastery stays mastered.** Once a player has permanently solved a recurring nuisance, the game should not repeatedly charge the same puzzle labor.
5. **Cleverness should reduce friction, not create fetch-grind.** An alternate solution must not become fifty trips for recipe ingredients merely because it is alternate.
6. **Soft sequence breaks are allowed.** If preparation and physical state make a shortcut credible and the resulting game state remains completable, let it work.
7. **Consequences still apply.** A workaround may trade one inconvenience for another. Ear protection weakens listening; a secured rope is committed elsewhere; an inflated boat remains physically bulky.
8. **Useful objects are not colored keys.** Earmuffs are hearing protection, rope is rope, containers retain real contents, and damage remains damage.
9. **No giant crafting layer or universal physics engine.** Promote high-value relationships when real product need earns them.
10. **No universal object-pair matrix.** The target is meaningful relationship recognition, not `IF rope+sack+room THEN solution` tables.
11. **Do not punish alternate success.** No score deduction merely because the player solved a problem in a physically valid noncanonical way.

## Completed: Release 1250 — Player Ingenuity / Systemic Workarounds

Merged through PR #55 as `cd6a918795196b6918a2a5c5600b56c1c0d6e20b`.

1250 proved the doctrine with reusable human-facing workarounds rather than a generic solver:

- industrial hearing protectors make protected Loud Room survival/traversal possible while canonical `ECHO` remains valid;
- the loose field stone can physically wedge the Living Room trap door open and can be removed again;
- the brown sack turns containment into useful chimney bundling rather than another arbitrary inventory exception.

The important lesson was that a familiar object can earn more than one meaningful use without becoming a crafting token.

## Completed: Release 1251 — Cross-System Utility Mesh

Merged through PR #56 as `79b87248d567962fff2181e4996d1cf424cdcac0`.

Final production artifact SHA-256:

`f109db13195574227d0487f732f63f16c4a2d8d48ea9823a15e63becd53791d7`

1251 generalized existing material and geography authorities instead of hard-coding object-pair recipes:

- rope + loaded brown sack + authored tree creates reversible cargo movement;
- rope + loaded sack + opened forest grate turns the grate into freight infrastructure while a closed grate physically blocks it;
- rope + sack + chimney separates cargo transport from personal chimney carry limits without inventing magical Kitchen-to-Studio rappelling;
- rope + sack + canonical Dome railing composes cargo with the existing railing anchor;
- committed rope length can constrain movement while remote cargo remains attached.

The key architectural lesson is:

> **Existing physical relationships should become reusable gameplay infrastructure.**

## Active: Release 1252 — Earned Sequence Breaks & Route Mastery

Active branch:

`agent/earned-sequence-breaks-route-mastery-20260812`

### Player outcome

A knowledgeable player can prepare real geography and reuse real equipment so selected routes become meaningfully easier, while the geography keeps its actual constraints.

### Great Canyon showcase

Release 1236 already established a real canyon rescue authority:

- `SECURE ROPE` at Canyon View physically puts the real rope on the canyon rim;
- an unprepared deliberate leap remains dangerous;
- a prepared leap can produce the existing rope-assisted rescue.

Release 1251 later established a reusable cargo end for the same real rope.

1252 joins those authorities instead of creating a third rope state:

- `SECURE ROPE` remains canonical;
- `TIE ROPE TO CANYON RIM` and `FASTEN ROPE TO RIM` reach that same physical authority;
- a rope already cinched to the brown sack may use the canyon rim as its fixed upper end;
- `LOWER SACK` stages cargo on **Rocky Ledge**, because that is the real authored intermediate geography;
- `PULL ROPE` / `RAISE ROPE` hauls the cargo back to Canyon View;
- the adventurer can follow the canonical climb to Rocky Ledge, free the cargo there, and later recover the rope from above;
- the two rope ends remain narratively and physically distinct.

This creates route mastery without teleportation and without replacing the canonical climb.

### White Cliffs geometry

The canonical White Cliffs path already understands that the inflated magic boat is physically too bulky while the folded/deflated boat can fit.

1252 closes a compositional hole: putting an inflated boat inside a carried container must not magically shrink it for geography checks.

The route check therefore follows carried containment ancestry. The boat remains bulky until it is actually deflated/folded.

Natural parser language also recognizes `FOLD BOAT` and `COLLAPSE BOAT` as the canonical deflation action; the existing physical requirement that the boat be on the ground before deflation remains intact.

### Rainbow boundary

The solid rainbow remains stateful traversal geometry and a powerful route shortcut, but it does **not** become a rope anchor merely because it is visible.

Removing the rainbow while standing on it remains lethal. Release 1252 does not soften that consequence or invent support that does not physically exist.

### Release 1252 boundaries

- no teleport menu;
- no speedrun-only debug verbs;
- no automatic puzzle completion;
- no rainbow rope anchor;
- no universal route solver;
- no generic physics engine;
- no object-pair recipe matrix;
- no rewriting Great Canyon, White Cliffs, river, or rainbow canonical routes.

## Ordered train queue after 1252

### Release 1253 — Dam Survival & Prepared Rescue

Deepen Flood Control Dam #3 as an authored physical danger using its real water and gate state.

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

Desired consequences include persistent real weapon custody, visible stolen equipment on later encounters, taunts tied to actual history, bargaining or recovery routes, and the possibility that an earlier weapon loss makes a later fight worse.

No duplicate sword, duplicate axe, generic NPC inventory framework, or combat rewrite.

### Release 1255 — Thief Retaliation & Sabotage

Give the thief more causal hostility through selective retaliatory theft, relocation or sabotage of meaningful objects, warnings before severe escalation, earned ambushes, and repair/avoidance/appeasement/counterplay.

No invisible grindable hostility number and no omniscient hunting AI.

### Release 1256 — Grue Ecology & Colony Reveal

Let selected darkness experiments teach the player something real about grues through authored lure/repel experiments, stronger light, a signature colony reveal, and retreat/barrier/decoy/catastrophic outcomes.

Do not turn every dark room into a hive or grues into ordinary combat mobs.

### Release 1257 — Fire, Smoke & Structural Consequences

Extend material physicality into a deliberately small set of authored fire, smoke, collapse, and machinery interactions with visible cause → warning → preparation → consequence.

No generalized chemistry or gas engine.

### Release 1258 — Mara Reciprocal Rescue & Shared Danger

Advance Mara through concrete shared history rather than an approval meter: reciprocal rescue, injuries/recovery, promises, exact temporary custody, separation/reunion, difficult shared route decisions, remembered disagreement, and real sacrifice or risk for the other person.

Romantic recognition, if it develops, continues to emerge from earned shared history rather than a romance economy.

## Future lanes, not the immediate queue

### Causal Death & Warning Depth

Broaden fair cause-warning-consequence chains, near-death records, delayed consequences, and exact-object provenance without building an abstract death machine.

### Museum & Ecology — second expansion

Continue the museum only when collection creates new field play, provenance decisions, or ecology rather than checklist accumulation.

### Narrative perspective experiments

The first-person, normalized second-person, third-person, and interactive-storybook editions remain valid isolated experiments built against real canonical state.

## Parked / separate

- **S.T.A.L.K.E.R. Glulx** remains a separate game lane.
- **Protected corpus acquisition** remains rights-dependent.
- Large procedural world generation, randomized loot, universal crafting, and generic physics remain outside the product direction.

## Definition of a successful future train

A future train should normally ship only when it has:

- a clear player-facing outcome;
- a natural route from real game state;
- preservation of canonical authorities;
- no duplicate journey-critical object identities;
- save/restore-safe state;
- natural-play qualification where practical;
- no production debug shortcuts;
- no recursive audit machinery;
- no TODO-only or placeholder behavior;
- a reason a human player would actually notice and enjoy it.

The point of this era is not to make Zork simulate everything.

It is to make the world coherent enough that the player can become clever **inside it**.
