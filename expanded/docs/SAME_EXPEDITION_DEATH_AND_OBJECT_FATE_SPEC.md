# Same-Expedition Death and Exact-Object Fate Specification

**Status:** implementation-shaping specification; pre-BEADS  
**Branch:** `agent/same-expedition-death-object-fate-spec`  
**Base:** exact live head `2452bb6c35cae26753922072bbfe478d9e01f4ad` of `agent/glulx-material-consequences` / PR #11  
**Applies above:** qualified Glulx Release `1218`  
**Related program:** `expanded/docs/HOUSE_OF_RECORDS_PROGRAM.md`  
**Related planning boards on `master`:**

- `docs/planning/LIVING_ZORK_FUTURE_IDEAS_KANBAN.md`
- `docs/planning/HOUSE_EXPEDITION_STASH_AND_ZORK_PLUS_KANBAN.md`

## Decision

Define same-expedition death and exact-object fate before implementing the physical house stash, death-site recovery, armor consequences, or Zork Plus loadouts.

The controlling rule is:

> An authored death may claim, move, damage, transform, lodge, scatter, or destroy specific real objects when the fatal event physically justifies it. Every unclaimed carried root object must continue through Zork's canonical reincarnation disposition unless a later qualified release explicitly changes that default.

This preserves the original reincarnation machinery while allowing selected deaths to leave coherent physical aftermath.

No BEADS are created by this specification. Promotion happens only after the rules, pilot scope, changed-path contract, and deterministic qualification routes are accepted.

## Why this comes before the stash

A secure house container is only meaningful after the project can distinguish:

- an object safely left at home;
- an object carried into danger;
- an object dropped at the fatal location;
- an object retained by an actor;
- an object carried by water;
- an object lodged in machinery;
- an object damaged, transformed, or destroyed;
- and an object that remains recoverable but is not currently accessible.

Without those distinctions, a stash would either be cosmetic or become a magical recovery service that vacuums every possession home after death.

## Four persistence layers remain separate

### 1. Ordinary `SAVE` and `RESTORE`

A native save preserves the exact current world:

- player location and phase;
- object locations and nested containment;
- secured house contents;
- carried and worn equipment;
- actor inventories;
- environment-held and lodged objects;
- damage, wetness, fuel, water, armor, rope, sack, and other condition state;
- timers and interrupts;
- death count, score, house state, and archive receipts.

`RESTORE` reconstructs that snapshot exactly. It does not rerun death disposition, repair the world, or reclassify object fate.

### 2. Same-expedition death continuity

When canonical death handling grants another chance, the current expedition continues with a physically altered object tree.

This layer determines the fate of possessions and aftermath caused by that death. It does not start a new expedition and does not read completed-run progression.

### 3. Completed-expedition archive

Victory or terminal completion records a separate historical box for that run. The archive observes final object and incident state; it does not own or repair live objects.

### 4. Zork Plus / Veteran Expedition

A later explicitly selected post-victory mode may relocate unlocked exact objects into a new expedition loadout. It must not reuse same-expedition death continuity, restore a prior world, or merge contradictory expedition histories.

## Canonical baseline that remains authoritative

The current `JIGS-UP` path is not replaced wholesale.

Canonical behavior includes:

1. reset the winner to the adventurer;
2. reject being killed while already dead;
3. print the supplied death description and bad-luck line where applicable;
4. deduct ten points;
5. permit at most two returns before terminal death;
6. retain the existing South Temple / Land of the Living Dead branch;
7. otherwise return the player to `FOREST-1`;
8. clear the trap-door touch state and parser continuation;
9. run `RANDOMIZE-OBJECTS`;
10. stop the canonical death-reset interrupt set;
11. return a fatal action result to the main loop.

Canonical object disposition currently:

- returns the carried lamp to the Living Room;
- returns the carried coffin to the Egyptian Room;
- resets the sword's threat value;
- moves carried root treasures into eligible dark underground rooms;
- moves other carried root objects into random above-ground rooms;
- preserves the nested contents of a moved root container because the real container itself moves;
- and leaves objects already elsewhere in the world where they are.

The new architecture must prove this baseline still occurs for every death and object not covered by an authored fate rule.

## Same-expedition boundary

A death produces same-expedition continuity only when canonical `JIGS-UP` would grant another chance.

It does not override:

- final death after the existing return allowance is exhausted;
- death while already in the canonical dead phase;
- `RESTART`, `QUIT`, or ordinary `RESTORE`;
- victory and completed-expedition archiving;
- canonical score deduction;
- canonical death count;
- or canonical phase transitions.

Terminal death may still produce an archive record, but it does not create a recoverable live-world aftermath unless a future explicit continuation mode exists.

## Stable semantic identities

Implementation must establish compact stable IDs before broad death aftermath is added.

### Required identities

- **expedition ID** — identifies the current run;
- **incident ID** — identifies the causal event or encounter;
- **death ID** — identifies this death within the expedition;
- **death-family ID** — identifies the authored family and qualification contract;
- **object ID** — the existing exact ZIL object, never a copied inventory record;
- **actor ID** — the existing exact actor;
- **place ID** — the existing room, container, actor, mechanism, route, or authored transit state;
- **warning ID** — optional semantic warning or evidence reference;
- **recovery-gate ID** — optional condition required to regain an object.

### Storage discipline

Do not serialize a verbose database row for every object on every death.

The implementation should store:

- compact death context;
- authored exceptions to canonical disposition;
- recovery gates that cannot be derived from live object location;
- and curated archive receipts.

Unchanged location, containment, actor ownership, and condition should remain authoritative in the real object tree.

## Object-fate vocabulary

Each affected exact object receives one primary fate and optional condition deltas.

| Fate | Meaning |
|---|---|
| `SECURED` | Remains inside an accepted secure house container; death does not move it. |
| `CANONICAL-DISPOSITION` | Falls through to the existing `RANDOMIZE-OBJECTS` behavior. |
| `DEATH-SITE` | Remains at the real fatal location or an authored adjacent location. |
| `SCATTERED` | Moves to one of a bounded authored set of nearby real locations. |
| `ACTOR-HELD` | Moves into the exact responsible actor's inventory. |
| `ENVIRONMENT-TRANSIT` | Is being carried by an authored route such as current, chute, conveyor, or collapse. |
| `LODGED` | Remains inside or against a real mechanism, obstruction, crevice, or debris state. |
| `DAMAGED` | Retains identity and location while gaining an authored condition change. |
| `TRANSFORMED` | Uses an existing canonical replacement or explicit one-to-one transformation. |
| `DESTROYED` | Is removed only when destruction is authored, physically justified, and completion-safe. |
| `OFFSTAGE-CANONICAL` | Remains in an existing canonical offstage state used by the original puzzle. |
| `TERMINAL-UNRESOLVED` | Final-run record only; no live recovery is promised because the expedition ended. |

Do not use `LOST` as an implementation state. It is a player-facing summary derived from a real location, owner, transit state, or destruction record.

## Root-object and nested-containment rule

Disposition begins from each root object directly carried or worn by the adventurer at death.

Default behavior:

1. classify the root;
2. move or retain the root once;
3. preserve its complete nested subtree;
4. preserve open/closed state, rope commitment, water, food, damage, fuel, and other condition state;
5. never separately randomize nested children after their root has been assigned.

A death family may split a container subtree only through an explicit authored event such as:

- sack rupture;
- bottle breakage;
- open-container spill;
- fire consumption;
- crushing;
- current washing individual contents away;
- or actor rummaging.

Every split must enumerate the affected real children and prove no containment cycle, duplicate, or orphan object is created.

## Secure-house rule

Objects inside the accepted secure house stash are outside the adventurer's carried tree and remain physically where deposited.

The death system must not:

- copy them into a recovery list;
- relocate them during reincarnation;
- consume them as substitutes for carried equipment;
- or infer that an object was secured merely because it had previously visited the house.

Security is positional and current: the exact object must actually be inside the accepted secured container at the moment of death.

The first stash may be fully secure against ordinary death handling while remaining subject to later explicitly authored house intrusion, water, smoke, theft, or supernatural events.

## Authored-exception pipeline

The death pipeline should be narrow and deterministic.

### Step 1 — freeze context

Before reincarnation mutates player location or inventory, capture:

- current expedition and death ordinal;
- fatal room and enclosing vehicle/container;
- immediate cause and responsible actor/mechanism;
- active death family;
- player knowledge and decisive warnings where already available;
- carried root objects and their nested trees;
- worn, held, tied, anchored, lit, wet, open, closed, damaged, and transformed states;
- active world mechanism state relevant to the death.

### Step 2 — build an exception plan

The selected death family may assign authored fates to specific exact objects or semantic object classes.

An exception plan must be finite and ordered. It may not scan the entire world and improvise universal physics.

### Step 3 — resolve ownership priority

Apply claims in this order unless a death family explicitly documents another order:

1. pre-existing canonical commitment or transformation;
2. fatal mechanism containment or environmental transit;
3. responsible actor claim;
4. death-site or nearby scatter;
5. damage or destruction;
6. canonical residual disposition.

An object may have one final parent/location. Condition deltas do not create a second owner.

### Step 4 — run completion-safety gate

Before committing destruction, inaccessible lodging, or actor retention, verify that each affected unique completion-critical object has at least one of:

- a deterministic recovery route;
- a canonical alternative solution already present;
- an explicit one-to-one transformation preserving puzzle identity;
- or a deliberately documented irreversible outcome accepted for that mode.

The gate must fail closed during qualification. It must not silently teleport the object home.

### Step 5 — commit exact-object movement

Move each claimed root object once. Preserve nested contents unless the plan explicitly splits them.

### Step 6 — invoke canonical residual behavior

Run the existing reincarnation logic for every unclaimed carried root object, including existing lamp, coffin, treasure, ordinary-object, sword-value, death-count, score, and phase behavior.

Implementation may wrap or parameterize `RANDOMIZE-OBJECTS`, but it must not fork a second competing inventory system.

### Step 7 — process aftermath queues

Only authored families may queue later movement, actor behavior, smoke, current, machinery, collapse, or recovery events.

The existing canonical death-reset interrupt list remains the default. Any interrupt intentionally surviving death must be allowlisted, explained, and qualified.

### Step 8 — write one curated receipt

Write a compact incident/death receipt containing meaningful exceptions and summary outcomes. Do not log every unchanged object shuffle.

## Actor claims

An actor may retain an exact object only when the encounter makes the claim physically and motivationally credible.

### Troll

Possible authored claims include:

- retaining a weapon knocked from the player;
- taking the player's sword after a fatal close combat exchange;
- holding a carried sack or tool as a trophy only when the scene explicitly supports it.

The troll does not automatically inherit the entire inventory. Claimed objects remain visibly and recoverably in his real inventory unless later moved by authored behavior.

### Thief

The thief may:

- finish a theft already in progress;
- selectively take treasure or a symbolically important object;
- retain the real brown sack and its nested contents;
- move an object through his existing roaming/deposit behavior.

The thief does not receive omniscient access to secured house storage or every object at every death.

### Other actors

Cyclops, grues, ghosts, and later creatures require separate authored claim rules. No generic `killer takes all` rule is allowed.

## Environmental movement

### Water and current

Water aftermath must use bounded authored routes derived from real gate, reservoir, river, leak, and room state.

An object may:

- remain at the bank or edge;
- float to a named downstream room;
- sink to an authored recoverable location;
- lodge at the dam or in machinery;
- spill from an open container;
- remain inside a sealed suitable container;
- or be destroyed only when the object and event explicitly justify it.

Do not add a universal buoyancy or fluid simulation.

### Machinery

Machinery may retain, crush, transform, eject, or lodge selected objects only through an authored mechanism contract.

The exact machine container, switch state, gate state, leak state, and existing transformation routines remain authoritative.

### Fire and heat

Fire may damage or destroy supported material families, consume contents of an open or ruptured container, or transform an object through an existing canonical replacement.

Fire does not become room-wide universal propagation merely because a death occurred.

### Falls, collapse, and burial

Impact may scatter, damage, bury, or lodge selected objects within a bounded set of real nearby locations. The death family must define which exits, ledges, lower rooms, debris states, or retrieval actions make sense.

## Death-site representation

Do not begin with a universal corpse, ghost inventory, or magical death chest.

Preferred representation:

- leave surviving real objects in real rooms, actors, containers, or mechanisms;
- use authored environment transit where the fatal location is not stable;
- add a remains/debris container only for a specific death family whose fiction and parser behavior require it.

A death-site container, when used, is local and physical. It is not linked to the house and does not appear everywhere.

## Death-family contracts

Each promoted family must define warnings, fatal trigger, object-fate rules, recovery, canonical fallthrough, and qualification.

| Family | Default object policy | Authored possibilities |
|---|---|---|
| Actor combat | Canonical residual disposition | Killer retains one or more physically claimed objects; dropped weapon remains; actor inventory persists. |
| Fall / impact | Canonical residual disposition | Nearby scatter, lower-room placement, breakage, armor survival, lodged rope, crushed container. |
| Drowning / current | Canonical residual disposition | Downstream transit, sinking, sealed-container survival, spill, dam lodging, water damage. |
| Fire / smoke / heat | Canonical residual disposition | Burned expendable, damaged equipment, transformed object, retained heat, open-container consumption. |
| Machinery / crushing | Canonical residual disposition | Lodged tools, crushed container, canonical transformation, ejection, recoverable maintenance route. |
| Collapse / burial | Canonical residual disposition | Debris containment, adjacent scatter, blocked recovery route, later excavation. |
| Grue / creature | Canonical residual disposition | Selective consumption, carried-off object, extinguished light, nest/lair recovery only when authored. |
| Magical / ritual | Canonical residual disposition | Existing transformation, offstage canonical state, curse/condition, location-bound object. |
| Self-inflicted folly | Canonical residual disposition | Exact object responsible remains, breaks, sticks, burns, or becomes evidence when physically supported. |
| Unforeseeable surprise | Canonical residual disposition | Minimal exceptions; archive marks limited culpability and reveals useful evidence. |

A family table guides authored code; it is not a procedural prose generator.

## Recovery semantics

An object is recoverable when its real state provides a route back to player possession.

Recovery may require:

- revisiting the fatal room;
- defeating, restraining, bargaining with, or stealing from an actor;
- changing dam gates or current;
- draining, opening, repairing, or stopping machinery;
- retrieving a container downstream;
- clearing debris;
- using rope, light, tools, armor, or another prepared route;
- waiting for an authored delivery or movement event.

The game should expose evidence proportional to what the player could reasonably know:

- visible object at the site;
- actor carrying or mentioning it;
- tracks, drag marks, disturbed storage, water route, sound, or machinery clue;
- a house/Attic record after the evidence has actually been discovered.

The archive must not reveal an unseen exact recovery solution.

## Unique-object safety

`Unique` and `completion-critical` are related but not identical.

- A named treasure may be unique but not required for a particular remaining route.
- A mundane tool may be completion-critical in one world state.
- A transformed object may remain the same puzzle lineage while changing ZIL identity through an existing canonical exchange.

The first implementation should use a reviewed, edition-specific safety table rather than infer criticality from treasure value alone.

For every destructive or inaccessible fate, the table records:

- exact object;
- applicable world/mode conditions;
- canonical alternatives;
- recovery route or transformation lineage;
- whether irreversible loss is intentional;
- qualification route.

No runtime auto-rescue may move a failing object home merely to satisfy the safety gate.

## House and archive receipts

A same-expedition death receipt should be concise and causal.

Suggested semantic fields:

- expedition ID;
- death ordinal and death-family ID;
- incident, actor, place, and mechanism IDs;
- immediate cause and enabling condition;
- decisive warning references;
- objects secured at home only as an aggregate or referenced set;
- meaningful object exceptions: claimed, scattered, in transit, lodged, damaged, transformed, destroyed;
- recovery status known to the player;
- canonical residual-disposition count;
- score/death consequence;
- terminal versus continued expedition.

Example later Attic summary:

> Expedition Three, Incident 17: The adventurer drowned below Flood Control Dam #3 while heavily burdened. The sealed bottle reached River 3. The open brown sack lost its food and lodged at the grating. The sword remains unaccounted for. Equipment secured in the Cellar locker was unaffected.

This prose is derived from structured evidence after discovery. It is not printed as omniscient debugging output at death.

## Parser and player-facing boundaries

The parser remains authoritative.

This architecture does not require a new production command. Recovery uses existing or narrowly justified verbs against real objects and locations.

Possible later observational commands may include:

- `RECAP`;
- `DEATHS` / `MORTAL FOLLIES`;
- `EXAMINE` the relevant actor, debris, machine, water route, or stash;
- Attic incident and expedition records after their own archive trains exist.

Test-only setup, mutation, report, and positioning verbs remain excluded from production.

## Ordinary save/restore contract

Qualification must create real native saves at multiple phases:

1. before the fatal action;
2. immediately after continued-expedition reincarnation and object disposition;
3. during at least one environment-transit or actor-held recovery state;
4. after recovery.

For each phase:

- deliberately corrupt object parents, nested containment, condition flags, death receipt, and relevant queues;
- restore through the native prompt;
- prove exact state returns without repair;
- prove no object appears in two locations;
- prove no archived receipt mutates live state.

## Deterministic qualification matrix

A promoted implementation train must include at least these routes.

### Q1 — canonical compatibility death

Carry:

- lamp;
- coffin;
- one treasure;
- one ordinary object;
- one nested container with contents.

Trigger an unmodified canonical death and prove:

- canonical score/death behavior;
- lamp and coffin special placement;
- treasure and ordinary residual disposition;
- root-container movement with intact nested tree;
- sword threat reset where applicable;
- canonical interrupt reset;
- no new aftermath receipt claiming authored exceptions.

### Q2 — secured versus carried

Place one real object inside the accepted secure house stash and carry another comparable object.

After death:

- secured object remains in the stash;
- carried object follows its death-family or canonical residual rule;
- neither is copied or substituted for the other.

This route is blocked until the physical stash exists, but its contract is defined now.

### Q3 — actor-held recovery

Use one authored actor death where the actor physically claims an exact object.

Prove:

- object moves into the real actor;
- original map location remains empty;
- player reincarnates without it;
- actor observation exposes possession appropriately;
- deterministic recovery returns the same object;
- save/restore preserves every phase.

### Q4 — environmental transit

Use one authored water or machinery death.

Prove:

- selected exact object enters a bounded route or lodged state;
- unrelated carried objects retain canonical residual behavior;
- route progression is deterministic under fixed state;
- recovery returns the same object;
- no generic physics affects unsupported objects.

### Q5 — nested split

Use an explicitly ruptured or open container.

Prove:

- only authored children split;
- unsplit nested structure remains intact;
- every child has exactly one parent or canonical offstage state;
- recovery and save/restore preserve the resulting tree.

### Q6 — destruction safety

Destroy one explicitly expendable supported object and attempt the same fate against one protected completion-critical object.

Prove:

- expendable object is genuinely removed or transformed;
- protected object's unsupported deletion fails closed during qualification;
- no automatic home teleport masks the failure.

### Q7 — canonical dead-phase branch

Trigger death after South Temple state makes the existing Land of the Living Dead path applicable.

Prove:

- canonical phase, player action function, lighting, troll flag, and location remain authoritative;
- object exceptions and residual disposition occur exactly once;
- another death while already dead remains terminal.

### Q8 — terminal death

Exhaust canonical returns and prove:

- final death does not reincarnate the player;
- no live recovery queue is started after termination;
- the terminal archive receipt, when later implemented, is observational only.

### Q9 — duplicate and orphan audit

After every route, inventory the complete protected object set and prove:

- each exact object has one authoritative parent/location or canonical offstage state;
- no containment cycle;
- no duplicate treasure, tool, actor, container, transformation, or archive record;
- no object is absent without an explicit destruction/transformation record.

## Recommended first implementation boundary

After this specification is accepted, the smallest coherent production train should:

1. introduce compact death context and exception-plan hooks around existing `JIGS-UP` / `RANDOMIZE-OBJECTS` behavior;
2. preserve canonical behavior for all unclassified deaths;
3. establish stable expedition, incident, death-family, and recovery IDs;
4. add one actor-held pilot and one environmental-transit pilot;
5. add no house stash, armor, Zork Plus loadout, broad archive UI, universal physics, or generic corpse container;
6. qualify native save/restore and full-object anti-duplication;
7. keep all test-only controls out of production.

The actor pilot should preferably use a real existing weapon and actor state. The environmental pilot should preferably use an existing water or machinery route whose canonical state is already qualified.

The exact pilots remain a promotion decision, not a commitment made by this document.

## Relationship to the existing House of Records beads

The current twelve-train, ninety-six-bead House of Records roadmap remains authoritative and unchanged.

This specification does not silently add death aftermath to those beads.

Before a physical stash or Zork Plus card is promoted:

- the house state foundation must provide stable expedition and incident identity;
- this death/object-fate contract must be accepted;
- any overlap with Kitchen, Cellar, vulnerability, and expedition archive trains must be reconciled explicitly;
- new beads, if approved, must be additive and dependency-linked rather than rewriting closed or unrelated work.

## Explicit non-goals

- no automatic return of all carried objects to the house;
- no globally shared magical chests;
- no universal corpse container;
- no universal physics, fluid, fire, damage, or durability engine;
- no random permanent deletion of unique puzzle objects;
- no replacement of canonical score, death count, reincarnation limit, or dead-phase rules;
- no flattening of nested containers;
- no duplicate canonical objects;
- no cross-run inventory transfer;
- no archive-driven repair of live state;
- no solution leaks from unseen recovery routes;
- no mandatory hunger, thirst, armor, injury, or housekeeping loop;
- no BEADS until the pilot and qualification boundary are accepted.

## Promotion gates

This specification is ready to become implementation beads only when all are true:

1. canonical baseline and residual-fallthrough policy are accepted;
2. exact stable ID representation fits the Glulx memory and save model;
3. unique-object safety table format is agreed;
4. one actor pilot and one environmental pilot are selected;
5. recovery routes are complete and do not auto-solve canonical puzzles;
6. changed production paths are known and narrow;
7. deterministic save/restore, dead-phase, terminal-death, nested-tree, and anti-duplication routes are specified;
8. overlap with House of Records, stash, warning, actor-memory, dam, and archive work is documented;
9. test-only verbs and fixtures are isolated;
10. PR remains open and unmerged until Justin gives the merge whistle.

## Decision after this specification

Once death and exact-object fate are accepted, shape the first physical home stash against this contract:

- one secure real container in the house or Cellar;
- canonical ZIL containment;
- exact nested objects;
- reasonable parser grammar;
- no magical shared network;
- and explicit proof that secured objects remain untouched while carried objects follow real death consequences.

The house then becomes useful for the correct reason: it protects only what the adventurer deliberately left there.
