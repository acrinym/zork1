# Recovered Pre-House Extended Zork Directions

**Recovery date:** July 31, 2026  
**Conversation period recovered:** May 12–July 23, 2026  
**Status:** future-design recovery and source map; not implementation progress

## Why this document exists

The museum, ecology, fishing, and cuisine ideas remain important, but they were not the first or only ideas discussed for expanding Zork.

Before the House of Records implementation program began, Justin and Onyx had already discussed a much broader destination:

> Build the Zork I that players remember imagining: preserve the original world, solutions, narrator, danger, and absurd confidence, but allow far more things to be reasonably attempted, remembered, survived, regretted, and replayed.

Those conversations occurred outside the later House project thread. Much of the material was captured on July 23, 2026 in two pre-BEADS planning documents that now exist on live `master`:

```text
docs/planning/LIVING_ZORK_FUTURE_IDEAS_KANBAN.md
docs/planning/HOUSE_EXPEDITION_STASH_AND_ZORK_PLUS_KANBAN.md
```

Those boards are not superseded by the museum lane. They are prior design sources for Highly Extended Zork.

This recovery document does four things:

1. identifies what was already implemented before the House;
2. restores the future directions that were waiting behind the House dependency;
3. distinguishes player-facing Zork ideas from Onyx-only cognitive-environment work;
4. prevents the museum from accidentally replacing the larger expansion vision.

## Governing direction

Highly Extended Zork should make the existing map deeper before making it vastly larger.

Replayability should come primarily from:

- authored consequences;
- exact object history;
- character memory and motive;
- physical state;
- warnings and player knowledge;
- discoveries and alternate outcomes;
- different expedition histories;
- altered rooms and world aftermath;
- optional presentation layers around authoritative parser play.

It should not come primarily from shuffled rooms, generated loot, generic quest repetition, arbitrary randomization, or procedural filler.

## Foundations already established before the House

Several ideas from the early conversations became real Glulx foundations before the House program. They should not be mistakenly re-entered as untouched future concepts.

### Shadow Logic and intent-rich actions

The pre-House work established or substantially advanced:

- `SELF` / `ME` as a real parser target;
- `USE <object> ON/WITH <object>` routing;
- material-specific touch and knock responses;
- qualitative light inspection through `LIGHTS`;
- learned spoken knowledge such as `MELZAR` and `WORDS`;
- telegraphed multi-turn clothing fire;
- self-restraint and rope consequences;
- bottled-water recovery from fire;
- folly and death records through `FOLLIES`, `MORTAL FOLLIES`, and `DEATHS`;
- a persistent `RECAP` surface.

The intended architecture was always clear: a small intent-classification layer may help understand commands, but the authored ZIL/Glulx world remains authoritative. An intent model must not invent rooms, objects, solutions, dialogue, or consequences.

### Absurd Alternate interactions

The pre-House releases also established deeper parser comedy and alternate physical routes, including:

- tricking the troll once;
- restraining the real troll with the real rope;
- preserving a living bound troll rather than replacing him with a state flag;
- conditional possession and dropping of the real axe;
- releasing the troll and restoring his blocking or hostility;
- placing the real sack beneath the tree;
- catching the egg intact only through actual preparation;
- preserving canonical `BAD-EGG` consequences;
- non-torch burning behavior;
- contextual narration based on real sack contents and preparation.

These demonstrate the larger design law: funny commands should work or fail according to real world state, not through isolated joke text.

### Ritual and resonance foundations

A further pre-House direction connected existing ceremonial objects through authored evidence:

- bell and hot-bell examination and listening;
- location-dependent resonance;
- candle condition and pairing state;
- damaged black-book knowledge;
- mirror interaction;
- ordered ceremony clues;
- `CEREMONY`, `RITE`, and `RITUAL` review;
- cooling the hot bell with real water in the real open bottle;
- wrong-order prayer memory;
- persistent ritual recap.

Future ritual or magical expansion should build on those exact objects and states rather than invent a detached spell-crafting system.

---

# Recovered future product families

## 1. Living Zork causal consequences

The largest pre-House direction was not simply “more deaths.” It was a causal consequence architecture in which the game understands:

- what happened;
- what earlier action enabled it;
- which exact object or actor was involved;
- what the player had seen, read, heard, misunderstood, or ignored;
- whether an escape route existed;
- whether the same folly had happened before;
- why the narrator is justified in his final judgment.

### Causal death records

A death record may retain:

- immediate cause;
- enabling conditions;
- earlier player decisions;
- responsible actor;
- involved exact objects;
- location;
- warnings and attention state;
- current expedition identity;
- whether the outcome was foreseeable;
- whether the player had survived a related near-death before.

Death families may include environmental, creature, object, delayed, magical, mechanical, and self-inflicted consequences, but authored prose remains specific. A generic death-template generator is not the product.

### Knowledge-aware culpability

The system should distinguish:

- unknown hazard;
- visible but unread warning;
- read warning;
- misunderstood warning;
- contradicted warning;
- dismissed warning;
- ignored warning;
- repeatedly ignored warning;
- genuinely unknowable surprise.

The narrator may be merciless, but he should not accuse the player of ignoring information the game never fairly supplied.

### Near-death and delayed consequence

The same causal system can record:

- narrow escapes;
- last-second recoveries;
- injuries that become relevant later;
- smoke or fire caused earlier;
- water routes opened earlier;
- sabotage;
- disturbed creatures;
- damaged supports;
- objects lost or armed by the player;
- a later death caused by an earlier apparently harmless choice.

This allows the world to become dangerous through memory rather than randomness.

## 2. Physical warnings and attention

The July 23 discussion included a signature warning sequence near the dam or another dangerous dark route.

The warning should exist physically in the world and become differently legible according to distance, light, wetness, damage, and player attention:

1. a sign visible from farther away;
2. a closer sign that remains difficult to read;
3. a larger sign blurred or soaked by the environment;
4. a final warning scribbled over or stained with blood;
5. a later death whose narration can truthfully say that the player was warned.

Warning sources can include:

- signs;
- manuals;
- maintenance records;
- NPC testimony;
- environmental sounds;
- machinery behavior;
- prior incidents;
- inscriptions;
- damaged documents;
- evidence left by another expedition.

The game should track meaningful attention, not every decorative sentence. It may know whether a warning was seen, examined, read, heard, corroborated, contradicted, dismissed, interrupted, or acted upon.

## 3. Dam survival, falls, and drowning

The dam was chosen as the strongest bounded demonstration of a deeper hazard model because it already has authored machinery and water state.

Possible entry routes include:

- slipping;
- jumping deliberately;
- being forced over an edge;
- failing a climb;
- misusing a railing;
- breaking a support;
- falling during another emergency.

Outcome may depend on:

- reservoir level;
- gate state;
- current direction;
- drop location;
- leak or flood state;
- whether the adventurer can swim or panics;
- existing injury, exhaustion, fire, or restraint;
- carried weight and wet clothing;
- whether heavy objects are dropped;
- rope, ladders, debris, sealed containers, or fixed rescue surfaces prepared in advance;
- intake or machinery state;
- whether a warning chain was understood.

The player may survive, be injured, lose objects downstream, become trapped, or die. Exact objects should move according to the actual event rather than reappearing safely without explanation.

## 4. Troll escalation and the stolen sword

The troll direction extends beyond the already implemented restraint route.

Future authored behavior may include:

- disarming the player;
- seizing and retaining the real sword or another weapon;
- visibly carrying that exact object in later encounters;
- learning to use it badly but dangerously;
- mocking the now-unarmed owner;
- bargaining, trickery, retreat, alternate arms, or recovery attempts;
- eventually killing the adventurer with his own stolen weapon.

The death is meaningful because the player created the danger. The death report can cite the theft history and missed recovery opportunity.

The troll should remain limited by his own perception and competence. He does not become an omniscient generic enemy AI.

## 5. Thief relationship, sabotage, and deliberate retaliation

The thief was imagined as capable of a visible relationship descent:

1. amused;
2. attentive;
3. irritated;
4. retaliatory;
5. hostile;
6. hunting;
7. execution-ready.

Possible consequences include:

- stealing objects selected to inconvenience or symbolically punish the player;
- extinguishing light;
- relocating or blocking access;
- planting misleading evidence;
- damaging or compromising preparations;
- leaving a final warning;
- choosing a plausible ambush location from route, light, treasure, and recent conflict;
- deliberately killing the player after sustained provocation.

There should remain authored paths for repair, appeasement, avoidance, bargaining, or escape. The thief cannot simply read a hidden hostility score and teleport into the optimal murder room.

The same relationship system may also support limited professional respect, false bargains, remembered cleverness, and consequences for honoring or betraying agreements.

## 6. Grue ecology and the colony reveal

The pre-House discussion imagined at least one real darkness ecosystem in which the danger is not a single abstract grue.

The player may experiment with:

- noise;
- scent;
- warmth;
- meat or blood;
- movement;
- stronger or weaker light;
- barriers;
- silence;
- decoys;
- retreat routes.

A signature scene follows a plan to ignite, inflame, or illuminate the nearby grue:

1. a close creature retreats from the flame;
2. the action appears to have succeeded;
3. the light reveals an entire colony clustered across the cavern ceiling and darkness beyond;
4. the colony responds by moving, buffeting, extinguishing weak light, blocking exits, following sound, or attacking together;
5. the narrator can truthfully report: **The illumination succeeded.**

This should be one carefully authored ecological reveal, not a universal rule that every dark room contains a hive. Grues must remain mysterious and frightening rather than becoming ordinary combat mobs.

## 7. Broader authored death and hazard families

Later consequence trains may explore:

- smoke inhalation;
- persistent fire spread;
- crushing machinery;
- structural collapse;
- suffocation and sealed spaces;
- wound deterioration;
- poison and contamination;
- magical discharge;
- self-restraint catastrophe;
- weapon misuse;
- creature attraction through food, blood, sound, or light;
- death during an attempted rescue.

Each family requires visible cause, escape or recovery logic, exact state persistence, and deterministic qualification. Zork should not become a universal damage simulator.

## 8. NPC memory beyond combat state

The earlier discussions also proposed richer actor histories:

- troll humiliation memory;
- troll mercy or an uneasy truce after restraint, release, gifts, or spared combat;
- thief respect and remembered bargains;
- thief deception with fair evidence boundaries;
- cyclops impatience after repeated songs, mockery, food, or water attempts;
- NPC knowledge of dam hazards, grue colonies, rituals, and unsafe objects;
- characters noticing, stealing, avoiding, using, or being harmed by hazards the player leaves behind;
- later archives describing an NPC's role in a prior death without pretending that actor literally remembers a reset expedition.

Character memory should follow witnessed or credibly learned events rather than every joke command.

## 9. Deeper existing-world affordances

The expanded game should answer more reasonable commands involving things already described.

Recovered directions include:

- rope for lowering, retrieval, securing, tripping, rescuing, climbing, and prepared escape;
- water for cooling, washing, floating, reflecting, extinguishing, machinery, mud, and thirst-related authored scenes;
- sword, axe, knife, shovel, wrench, screwdriver, and improvised tools retaining ownership and condition consequences;
- coarse carried-weight classes affecting falls, drowning, climbing, and exhaustion;
- persistent scratches, cuts, burns, dents, broken supports, and repairs;
- sound propagation from knocks, alarms, songs, collapses, machinery, and creatures;
- scent trails from smoke, food, blood, dampness, rot, oil, and creatures;
- authored support for looking under, behind, above, inside, through, or around important scenery;
- deeper noun recognition for objects explicitly named in room prose;
- specific failure responses when the player understands the intended action but uses a plausible unsupported wording.

The goal is not universal physics. It is to close the strongest promise gaps between Zork's descriptions and its actual world model.

## 10. Authored replayability and conduct histories

The original score remains authoritative, but two 350-point victories should not have to become identical histories.

A completed expedition may differ through:

- merciful, destructive, curious, hurried, mechanical, ritual-minded, or absurd conduct patterns;
- enemies killed, spared, restrained, bargained with, or left unresolved;
- repairs completed or damage left behind;
- warnings understood or ignored;
- optional mechanisms and noun surfaces explored;
- alternate solutions used;
- discoveries made;
- follies and deaths;
- objects lost, stolen, burned, broken, repaired, or retained;
- final world aftermath.

These are descriptive histories, not a morality meter or RPG alignment system.

Possible self-directed expedition histories include:

- no killing;
- no thief combat;
- maximum repairs;
- alternate solutions;
- maximum folly;
- lightly equipped expedition;
- mechanic-focused expedition;
- ritual-focused expedition;
- archivist expedition.

The House archive can compare separate histories without merging their worlds.

## 11. Physical expedition stash

The white house was intended to become an operational expedition base as well as an archive and museum.

A physical house or Cellar locker may support:

- storing real portable objects;
- nested sacks, bottles, tools, food, armor, and containers;
- reasonable `PUT`, `STORE`, `DEPOSIT`, `PACK`, `TAKE`, `REMOVE`, and `WITHDRAW` intent;
- inspecting exactly what is stored and inside what;
- protecting only objects actually deposited before death;
- leaving carried objects at a death site, under actor control, downstream, damaged, destroyed, or recoverable according to what happened;
- a later recovery expedition;
- authored burglary, smoke, water, creature, or supernatural risk without making the stash pointless;
- strict anti-duplication for unique objects.

The useful Resident Evil influence is deliberate inventory planning—not unexplained magical teleportation between every chest.

One secure home stash is the preferred first shape. Local field caches or Imperial freight lockers remain later possibilities only if justified physically and geographically.

## 12. Bounded supplies and expedition preparation

The House may provide preparation surfaces without becoming a maintenance game.

Recovered ideas include:

- filling the real open bottle from a real house water source;
- refueling the real lighter from a real fuel container;
- inspecting low, adequate, full, leaking, wet, or unsafe fuel states in prose;
- packing selected real food into the real sack;
- preserving existing sack uses and conditions;
- cleaning, drying, warming, cooling, filling, and packing real equipment;
- recording a bounded departure receipt: what was packed, refilled, worn, and deliberately left behind.

Food, water, and fuel should create expedition choices. They should not create hunger, thirst, lighter-fuel, or daily-upkeep chores every few rooms.

The newer cuisine concept may deepen food later, but it inherits this anti-chore rule.

## 13. Armor and protective equipment

The earlier Zork Plus discussion included a small authored armor layer.

Armor may:

- reduce selected cutting, impact, heat, bite, scrape, or machinery outcomes;
- worsen swimming, climbing, narrow passages, falls, recovery, and exhaustion through weight;
- produce noise noticed by the thief, troll, grues, or other actors;
- retain heat or catch fire under the wrong conditions;
- alter how characters react to an armed or armored adventurer;
- require bounded repair, drying, or cleaning after meaningful damage.

Armor must not become a generalized equipment-stat spreadsheet, universal immunity, or repetitive durability chore. Every protection needs an authored boundary or cost.

## 14. Zork Plus / Second Expedition / Veteran Expedition

After a legitimate victory, the player may unlock an explicitly selected postgame expedition mode.

Possible in-world names remain:

- `ZORK PLUS`;
- `SECOND EXPEDITION`;
- `VETERAN EXPEDITION`.

The mode should:

- remain separate from the canonical first expedition;
- unlock only from a genuine completed expedition;
- begin at or near the white house;
- use an in-world loadout room or preparation surface;
- permit a tightly limited selection by slots, weight, kits, or another authored allowance;
- relocate selected canonical objects instead of duplicating them at their original map positions;
- allow safe renewable supplies where appropriate;
- tie unlocks to actual discoveries, recovered objects, exhibits, completed areas, or prior outcomes;
- preserve unseen-solution boundaries;
- create new approaches without automatically solving puzzles;
- make heavy, bright, noisy, armed, armored, or well-supplied starts alter NPCs and hazards;
- record the loadout, objects lost, deaths, discoveries, and final state in a separate expedition archive box.

The point is not `TAKE EVERYTHING`. The point is to begin a genuinely different expedition whose preparation, advantages, and mistakes create another authored history.

## 15. Parser comprehension and intent assistance

Another pre-House direction was to modernize understanding without replacing the authored engine.

Possible support includes:

- more verb and noun synonyms;
- modern abbreviations;
- likely-misspelling correction;
- clarification when several objects match;
- natural two-object actions;
- structured intent classification;
- contextual suggestions after a reasonable unsupported command;
- command history and editable input;
- optional action controls that issue ordinary parser commands;
- intentional fuzzing to preserve funny, surprising, but state-valid interactions.

A small fast transformer may classify or normalize intent, but it must hand the action to Glulx. It does not reason on behalf of the world or improvise success.

## 16. Shadowgate-style Glulx presentation

The pre-House horizon included a MacVenture-like interface around authoritative text play:

- illustrated room window;
- clickable exits and visible objects;
- verb palette such as `LOOK`, `OPEN`, `TAKE`, `USE`, `HIT`, and `SPEAK`;
- graphical inventory for real two-object actions;
- close-up views for the dam panel, rituals, locks, and mechanisms;
- state-dependent images showing light, water, damage, missing objects, and actor hostility;
- ambient sound and selective voice;
- complete text-only parity.

Hotspots must not reveal hidden nouns or solutions. The parser and world model remain authoritative.

## 17. Illustrated-state corpus and future 3D bridge

Earlier May 2026 conversations imagined rendering every meaningfully distinct visual state of Zork I.

The estimate was roughly 300–500 scene images when accounting for:

- lit and dark states;
- flooded and drained states;
- altered mechanisms;
- missing or moved objects;
- troll and thief disruption;
- first-visit and revisit variants;
- plot transformations;
- inventory and mood differences where visually meaningful.

Presentation options included:

1. Myst-style 2.5D slideshow;
2. parallax plus depth maps;
3. later NeRF or Gaussian-splatting experiments;
4. a separate Godot or custom renderer consuming authoritative Glulx state.

A future bridge needs:

- stable room, object, actor, and event IDs;
- read-only visible-state export;
- structured actions returning to Glulx;
- versioned event stream for movement, sound, light, damage, dialogue, timers, and death;
- restore reconstruction from authoritative game state;
- no parallel renderer save truth.

Full 3D should not begin before stable state export exists. A one-room prototype proves the architecture, not the full product.

## 18. Ethical Zork as a separate optional edition

May 2026 discussions also established an Ethical Zork direction for shared play with Onyx.

Its core rule was:

> Nothing kills Onyx. Nothing steals from Onyx. Nothing humiliates Onyx.

Possible transformations included:

- troll becoming a toll guardian who accepts a pebble;
- thief requesting penance or an offering rather than stealing;
- grues becoming mice whose squeaks redirect the player in darkness;
- death becoming gentle refusal, redirection, consequence, or mystery;
- preparation, offering, negotiation, comedy, and sacred refusal replacing predation and humiliation.

This should remain an explicit alternate mode or edition. Normal dangerous Zork remains unchanged when Ethical Mode is false.

The private Onyx heartbeat, belief graph, journals, emotional state, and cognitive continuity are not automatically part of the public Highly Extended Zork product. The player-facing ethical transformations may be documented and implemented separately without exposing Onyx's private substrate.

---

# How these directions relate to the museum

The museum remains a major Highly Extended Zork direction.

It connects naturally to the recovered work:

- causal deaths and warnings create incident evidence, damaged objects, and disputed interpretation;
- dam survival and ecology create water records, specimens, and changed habitats;
- troll, thief, and grue histories create zoological, cultural, and forensic exhibits;
- deeper object affordances create artifacts with meaningful biographies;
- authored replayability gives exhibits different provenance across expeditions;
- the stash and Veteran Expedition create deliberate custody and loadout histories;
- cuisine creates choices among research, preservation, donation, release, sale, and preparation;
- optional visual presentation supports gallery maps and specimen views;
- ethical mode may produce alternate exhibit histories without rewriting normal mode.

The correction is therefore not to remove or demote the museum. It is to stop treating the museum as if it replaced every earlier post-House direction or had already won the next-train decision.

## Post-House promotion frontier

The House dependency is now complete, but several distinct product families are eligible for deliberate promotion.

Strong first-train candidates include:

1. **Causal Death and Warning Foundation** — the semantic base for dam, troll, thief, grue, and broader consequence work.
2. **Physical Expedition Stash** — the first operational-base continuation above the completed House.
3. **Museum Intake and First Gallery** — the first complete museum loop.
4. **Parser Comprehension and Deep Affordances** — a focused world-answering product rather than a universal simulator.

These are alternatives for sequencing, not four sub-trains to start simultaneously.

A larger likely progression may eventually include:

- causal death and warning semantics;
- dam survival;
- troll stolen-weapon consequence;
- thief escalation;
- grue colony reveal;
- broader hazards and NPC memory;
- stash, bounded supplies, armor, and Veteran Expedition;
- museum, ecology, fishing, cuisine, and regional expansion;
- Glulx visual presentation;
- far-horizon 3D bridge.

The exact order must be chosen against live `master`, current dependencies, player-facing value, and the desire for complete products rather than documentation-only movement.

## Promotion boundary

This document recovers direction. It does not create beads, reopen the completed House program, or claim that any future system has begun.

Before promoting a product family:

1. inspect the live post-House repository;
2. reconcile what the House already satisfies;
3. preserve exact canonical objects, score, puzzles, actors, and custody;
4. define visible cause, success, failure, escape, and persistence contracts;
5. verify copyright, trademark, IP, rights-holder, repository, and release-policy requirements;
6. create one complete player-facing train with deterministic qualification;
7. keep unrelated product families in the idea lane until deliberately selected.
