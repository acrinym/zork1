# Shadowgate → Parser IF Adaptation Program

**Planned:** August 15, 2026  
**Target sequence:** Releases 1262–1272, after the current Mara stack through Release 1261 is finished and accepted.  
**Status:** planning only — no train implementation is authorized by this document.

## Purpose

Use Shadowgate as a design lens, not as content to copy. Extract high-value interaction principles from its hostile rooms, consumable protection, dangerous affordances, light pressure, learned magic, examination, clue chains, structural difficulty, informative death, and creature-as-puzzle encounters; rebuild those principles from scratch as original Zork-native parser-IF systems.

The point is not to recreate Shadowgate rooms, maps, prose, spells, exact puzzles, expressive sequencing, source code, art, or item lists. The point is to ask what those design ideas become when the player has a natural-language parser, a persistent causal world, and all of the physicality/provenance machinery already built into Highly Extended Zork.

## Program rules

- Every release must be a substantial player-facing train, not infrastructure pretending to be a feature.
- Prefer authored situations that make multiple existing systems collide over isolated mechanics demonstrations.
- Canonical Zork solutions remain valid unless a train explicitly and safely adds another route.
- No generic hit-point boss layer, durability meter, universal crafting grid, arbitrary object matrix, generic spell engine, generic physics simulator, or recursive audit machinery.
- Failure should be physically and narratively legible. The player may be allowed to make bad choices when the world has given fair evidence.
- Borrow design principles only. All Zork implementation, prose, geography, object identities, threats, spells, and solutions must be original.
- Mara may participate using capabilities and causal history she already has, but this program is specifically intended to let the rest of Zork catch up rather than adding another sequence of Mara-only organs.

---

# Release 1262 — Hostile Rooms & Reactive Threats

## Player outcome

Enter an authored dangerous location where the threat observes and reacts to what the Adventurer actually does. Actions consume opportunity because the threat is physically present, not because a generic combat initiative system has started.

## Showcase

The first showcase is the Treasure Guardian Dragon & Hoard: an original Zork-native dragon occupying a real hoard environment with visible warning signs, dangerous fire breath, territorial/possessive behavior, retreat, environmental leverage, and multiple credible approaches.

The important inherited design principle is not “a dragon exists.” It is that interacting with the room while a live threat is watching changes what happens next.

## Boundaries

- no generic DRAGON_HP boss fight;
- no universal reactive-enemy framework unless a second authored encounter proves the same abstraction is genuinely useful;
- fire breath composes with existing authored fire/smoke/material consequence authorities;
- preparation, environmental manipulation, trickery, avoidance, containment, negotiation where appropriate, theft, and direct confrontation may all be viable depending on actual state;
- retreat must remain a real physical choice when the geography permits it.

---

# Release 1263 — Ablative Protection & Equipment Consequence

## Player outcome

Protection buys survival by taking the consequence itself. Equipment can char, dent, soak, abrade, warp, crack, or otherwise carry evidence of what protected the Adventurer without exposing a numeric durability bar.

## Showcase ideas

- a shield or improvised barrier physically absorbs extreme heat and becomes progressively less trustworthy;
- wet cloth or a soaked cloak can help in one hazard while becoming burdensome elsewhere;
- a rope that saves a fall can carry abrasion or heat damage that matters on later inspection/use;
- protective gear can survive a falling object and permanently show the impact.

## Boundaries

- no generic durability percentage;
- no repair-bench economy;
- object descriptions and behavior communicate condition;
- degradation must be authored where it produces interesting play, not sprayed across every inventory item.

---

# Release 1264 — Perilous Affordances / Let the Player Be Wrong

## Player outcome

The game stops protecting the player from physically possible bad ideas merely because an object or state may be important later. Destruction, waste, misuse, premature commitment, and irreversible choices are allowed where the world has honestly supported them.

## Design doctrine

If the Adventurer can physically break, burn, throw away, consume, drop, or misuse something, the parser should not quietly refuse with meta-game knowledge such as “you may need that later.”

Instead the world supplies consequences, alternatives where appropriate, recoverable failures where physically credible, and occasionally genuine irreversible mistakes when sufficient warning existed.

## Boundaries

- no cruelty-by-parser ambiguity;
- no arbitrary softlocks caused by an interaction the prose made impossible to anticipate;
- canonical progression should gain substitutes, alternate approaches, or explicitly fair irreversible risk where necessary;
- the goal is agency, not punishment.

---

# Release 1265 — Consumable Light & Graduated Darkness

## Player outcome

Illumination becomes authored world state rather than a binary lamp flag. Light sources burn, transfer flame, weaken, get wet, create smoke/heat, expose things, affect creatures, and eventually fail.

## Showcase

- bright light, weak light, ember-light, and full darkness have meaning where authored;
- one flame can light another real object;
- wet or damaged fuel behaves differently;
- existing grue ecology reacts to meaningful illumination state;
- fire/smoke systems interact with carried light;
- dropping or losing the only live light in a dangerous region can become an emergency rather than an instant scripted death.

## Boundaries

- no universal per-room lux simulator;
- no hidden TORCH_TIMER tax with no environmental feedback;
- darkness pressure must create decisions, not repetitive busywork.

---

# Release 1266 — Learned Magic as Parser Capability

## Player outcome

Knowledge can expand what the parser meaningfully understands. The Adventurer learns original Zork-native words, rites, formulae, signs, or commands from the world and can later use that learned vocabulary against real objects and situations.

## Core idea

Before learning a term, the parser may understand the literal word but the Adventurer does not know how to use it meaningfully. After genuine discovery/translation/teaching, the same command becomes a legitimate capability because the character now possesses the knowledge.

## Boundaries

- do not copy Shadowgate spell names or exact spell effects;
- no mana bar or generic spell list pasted over Zork;
- learned capabilities remain bounded to authored physical/narrative authorities;
- knowledge acquisition must be an event in the world, not a level-up menu.

---

# Release 1267 — Semantic Examination & Hidden Structure

## Player outcome

Concrete details in prose become trustworthy parser targets. Observation can reveal hidden structure because the player paid attention to language, not because a pixel-hunt hotspot existed.

## Showcase

If a description distinguishes a pale block, damaged hinge, unusual seam, scorch direction, draft, stain, loose fitting, or mismatched material, the parser should recognize sensible references to that detail and return meaningful authored responses to plausible verbs.

## Boundaries

- targetability does not guarantee success;
- no generic noun-promoter that turns every adjective into an object;
- descriptions must stop making promises the parser cannot honor in the selected authored spaces.

---

# Release 1268 — Clue Chains & Knowledge-Gated Interpretation

## Player outcome

The Adventurer can carry learned meaning without carrying the original clue object. Earlier inscriptions, documents, symbols, museum evidence, field observations, and testimony can change what a later object or place means.

## Showcase

- reading one clue allows a later marking to be recognized;
- identifying a symbol changes later EXAMINE text because the Adventurer now knows what he is seeing;
- museum/archive knowledge can become field-useful;
- a companion may independently possess a different piece of an interpretation without becoming an automatic hint engine;
- discovering a fact can unlock a new solution without setting a generic PLAYER_FOUND_CLUE_17 flag as the design abstraction.

## Boundaries

- facts should be named and causally meaningful;
- avoid inventory-check puzzle design where knowledge would realistically suffice;
- no generic detective notebook system unless later play genuinely demands one.

---

# Release 1269 — Structural Difficulty Modes

## Player outcome

Difficulty changes puzzle/world structure rather than merely multiplying damage or shrinking numbers.

## Candidate dimensions

Lower-pressure modes may provide clearer environmental evidence, redundant resources, more recoverable failures, or earlier observations. Higher-pressure modes may use subtler clues, fewer substitutes, tighter consequence windows, and more genuinely irreversible mistakes while preserving logical fairness.

## Boundaries

- no enemy-health multiplier pretending to be puzzle difficulty;
- modes must preserve the same underlying world identity;
- no mode may require deliberately obscure parser phrasing;
- differences must be authored and testable.

---

# Release 1270 — Causal Death & Failure Feedback

## Player outcome

Death and near-death communicate what physically happened, what warning existed, and whether the attempted idea was partially sound without turning into an explicit walkthrough.

## Design doctrine

A good authored death should help the player answer:

1. What killed me?
2. What evidence did I ignore or misunderstand?
3. Was some part of my approach useful?
4. What exact action/state made this outcome different?

## Boundaries

- no “HINT: use X” death screens;
- no gratuitous death inflation;
- near-death and persistent injury may be better consequences than death where they create richer play;
- existing Zork death/restore authority remains respected.

---

# Release 1271 — Creature Encounters as Systemic Puzzles

## Player outcome

Living beings become authored situations with motives, senses, capacities, fears, possessions, territory, and memory where appropriate rather than hit-point-shaped locks.

## Possible approaches

Depending on the specific creature and actual state, the Adventurer may frighten, bribe, distract, trap, outrun, negotiate with, trick, incapacitate, kill, befriend, manipulate, avoid, or simply leave it alone.

## Composition targets

Existing troll, thief, grue, dragon, and Mara behavior provide distinct examples of how different beings should remain different instead of collapsing into one NPC/combat framework.

## Boundaries

- no generic creature AI brain;
- no universal disposition meter;
- motives and responses remain authored to the actual being;
- different solutions may leave different later consequences.

---

# Release 1272 — Shadowgate-Style Macrostructure, Original Zork Region

## Player outcome

Build a substantial original Zork region whose *design grammar* reflects the best lessons of MacVenture/Shadowgate while all content and expression remain original.

## Target shape

A roughly 20–30 room authored adventure region (final size determined by design, not quota) where:

- objects have multiple credible physical uses;
- clues cross-reference locations;
- threats react to time and action;
- consumables matter without becoming chores;
- learned magic/knowledge changes parser capability;
- hidden structures reward semantic attention;
- dead ends can become routes;
- some paths are unsafe before preparation;
- creatures are situations rather than mandatory combat;
- previous observations change later interpretation;
- multiple solution paths intersect;
- failure leaves persistent evidence where survival is plausible;
- optional secrets exist that are not required for completion.

This train is the capstone proof that the prior releases became a *gameplay language*, not eleven disconnected demonstrations.

---

# Explicit future Mara lane — Earned Romance & Partnership

Mara becoming a genuine love interest is a planned future direction, not something this roadmap is trying to erase or euphemize away.

The intended design is **earned romance and partnership through lived history**, not a dating-sim overlay:

- mutual attraction and mutual choice must be represented explicitly when the relationship reaches that point;
- affection can coexist with disagreement, fear, anger, boundaries, competence, independence, and conflicting goals;
- prior rupture and repair remain true rather than being deleted by romance;
- physical affection/intimacy and partnership should arise from authored situations and choices rather than filling a love meter;
- Mara remains capable of saying no, initiating, changing her mind, wanting closeness, wanting distance, making mistakes, and acting without the player;
- romance is intended to become a real playable path, but not a compulsory outcome imposed on every possible history.

The immediate purpose of the 1262–1272 program is therefore not “avoid Mara romance.” It is to stop adding Mara-only machinery for a while, deepen the world she inhabits, and later let the romance arc draw upon a much richer game instead of becoming the only thing the game is developing.

---

## Relationship to the broader roadmap

After the Shadowgate-derived program, strong candidates already present in the Zork roadmap include:

- Forest That Answers Back / Described World = Interactive World expansion;
- Time, Weather & Disaster Arc;
- Museum & Ecology second expansion;
- later cross-IF/RPG adaptation programs using other inspirations;
- the explicit Mara Earned Romance & Partnership arc when the wider world has caught up enough to support it properly.
