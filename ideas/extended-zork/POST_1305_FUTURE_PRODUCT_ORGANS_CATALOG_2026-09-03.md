# Highly Extended Zork — Post-1305 Future Product Organs Catalog

**Captured:** September 3, 2026  
**Status:** concept catalog, deliberately unsequenced  
**Live writable repository at capture:** `acrinym/zork1`  
**Observed merged frontier at capture:** `master` `f3583c0025893c4bd3f34a00c5465a0976b96f39` — Release 1303 Empire Noun Honesty / PR #93  
**Observed open product train at capture:** PR #94 — Release 1305 HE Absurd Alternates, head `e5ee071a7a2ba59fc886169291df0467fb5060b3`

This file exists because the active numbered train queue is no longer a safe place to keep every good future idea.

These are **product organs, not release assignments**. Nothing here is CURRENT, NEXT, implementation progress, a bead hierarchy, or merge authorization. A later planning pass may combine, split, reject, research, or promote entries into complete player-facing trains.

The governing rule is:

> Preserve the idea now. Sequence it later.

Several entries came from direct comparison against Zork II, Zork III, and later Infocom design lineage. Others emerged while extending Mara, physical identity, clothing, reputation, and House life. They are intentionally kept distinct where their design authority differs.

---

# A. Embodiment, appearance, clothing, and House life

## A1. The Adventurer has a physically inspectable body

Highly Extended Zork currently gives the world far more physical continuity than it gives the unnamed Adventurer. Future play should allow the Adventurer to become physically legible without turning Zork into a character-creator menu.

Potential surfaces include:

- `EXAMINE ME`;
- `EXAMINE FACE`;
- `EXAMINE HAIR`;
- `EXAMINE HANDS`;
- `EXAMINE CLOTHES`;
- `LOOK IN MIRROR`;
- persistent descriptive facts such as approximate height, build, hair, eyes, facial hair, scars, tattoos, visible injuries, and later possibly age.

The Adventurer remains unnamed unless a later explicit product decision changes that. Body facts should be learned through ordinary parser play and physical surfaces, not through a detached GUI.

### Boundary

No mandatory character-creation wizard. No RPG stat-sheet substitution for prose. No requirement that appearance customization be completed to solve canonical Zork.

---

## A2. Real wardrobe, dresser, drawers, mirror, and changing space in the House

The House should eventually contain real storage and dressing furniture rather than an abstract appearance command.

Candidate physical objects:

- wardrobe / armoire;
- dresser;
- individual drawers;
- standing or wall mirror;
- clothes hooks or pegs;
- laundry basket;
- cedar chest or equivalent storage;
- a private or semi-private place to change.

Natural commands may include:

- `OPEN WARDROBE`;
- `OPEN TOP DRAWER`;
- `TAKE GREEN SHIRT`;
- `REMOVE COAT`;
- `WEAR GREEN SHIRT`;
- `PUT COAT IN WARDROBE`;
- `CHANGE CLOTHES` as a convenience surface that still resolves to real garments rather than conjuring an outfit menu.

Clothing must remain actual world objects with exact custody and location.

---

## A3. Clothing is physical, persistent, and environmentally alterable

A garment is not an appearance token. If removed, dropped, lent, damaged, washed, or lost, it exists somewhere in the world.

Candidate qualitative conditions include:

- muddy;
- dusty;
- wet;
- soaked;
- bloodstained;
- smoke-stained;
- sooty;
- resin- or sap-marked;
- torn;
- scorched;
- patched;
- clean;
- damp;
- soapy;
- rinsed.

Existing HE systems should compose with clothing rather than creating a parallel cosmetic simulation. Fire can scorch. Water can soak. Wilderness can muddy. Damage can tear. Repair may mend without erasing provenance.

Cleaning must not magically repair structural damage. A shirt can be **clean and torn**. A coat can be **washed but permanently scorched**.

### Boundary

No numerical cleanliness percentage. No equipment grind. No clothing requirement for ordinary canonical completion unless a future authored circumstance has a physically obvious reason.

---

## A4. GUE-native laundering and drying

If environment can change clothes, the world needs a period-appropriate way to cleanse them. Do not drop a modern washing machine or commercial detergent into the House.

Possible House wash area:

- deep stone or copper basin;
- hand pump, cistern, or setting-appropriate water source;
- scrubbing board;
- laundry paddle / clothes beater;
- drying rack;
- outdoor clothesline;
- dirty-clothes basket;
- shelf of cleaning materials.

Potential interaction chain:

`PUT SHIRT IN BASIN` → `FILL BASIN` → `ADD CLEANSER` → `SCRUB SHIRT` → `RINSE SHIRT` → `WRING SHIRT` → `HANG SHIRT ON LINE`

A setting-native cleanser could be botanical or mineral. One working concept is **washroot**: a pale fibrous root that produces a soap-like foam when bruised in warm water. This should be treated as a worldbuilding placeholder until period/GUE research gives us a stronger name and mechanism.

Different contamination can support different authored treatment:

- mud: water and agitation;
- ordinary grime: soap/washroot and scrubbing;
- blood: cold washing first, with poor treatment potentially setting a stain;
- grease: stronger alkaline treatment;
- smoke/soot: washing plus airing;
- resin/sap: scraping or a different solvent-like material;
- anomalous/magical contamination: authored nonordinary treatment if warranted.

Drying is also physical. Clean clothing may remain wet or damp. Placing clothes too close to a fire can damage them.

### Design principle

Laundry is optional continuity, not mandatory chores.

---

## A5. Mara has her own wardrobe, clothing, custody, and dressing autonomy

Mara should obey the same physical ontology without becoming a player-controlled doll.

She may:

- own multiple garments;
- change because of weather, damage, work, sleep, washing, comfort, or preference;
- have soaked, muddy, torn, patched, or repaired clothes;
- wash or dry her own belongings;
- store her own possessions;
- retain privacy and custody boundaries around drawers, clothing, and personal items.

The player does not configure Mara's outfit through a character screen. Mara dresses Mara.

Her appearance can evolve through actual play and should be reflected in `LOOK`, `EXAMINE MARA`, photographs, and authored reactions when materially meaningful.

---

## A6. Privacy-aware changing clothes

Changing clothes should be possible anywhere physically plausible, but social context matters.

If Mara is present before any earned intimacy, she may:

- leave the room;
- turn away;
- explicitly offer privacy;
- react to socially strange repeated behavior.

Her movement should be real when possible rather than flavor text claiming she left while her actor remains present.

If a later mutual partnership or romance exists, responses may change because of specific shared history. That future must not be assumed by the wardrobe system, because Mara Earned Romance & Partnership is not currently shipped.

---

## A7. Tattoos, scars, visible history, and concealment

Tattoos and scars can become persistent physical facts with location, design, visibility, provenance, and social meaning.

Examples:

- a forearm mark hidden by sleeves;
- a scar created by an actual prior injury;
- a GUE seal recognized by someone with relevant knowledge;
- a tattoo acquired through an authored in-world event.

Commands such as `ROLL UP SLEEVE`, `REMOVE COAT`, or `EXAMINE LEFT ARM` can change visibility without turning the system into equipment-slot UI.

Age is a possible later extension, especially if long chronology or actual time travel becomes player-relevant, but it should remain deferred until the world has a reason to care.

---

## A8. Physical photographs preserve appearance state

Release 1277 already introduced finite physical `SNAPSHOT` photographs backed by frozen scene state. Future embodiment should let a photograph preserve relevant visible appearance at that moment:

- clothing worn;
- visible damage and stains;
- injuries/scars visible;
- tattoos visible or concealed;
- carried distinctive objects;
- who stood where;
- later, possibly age or historical presentation if chronology becomes deep enough.

This would make photographs part of autobiographical identity continuity rather than only scene evidence.

---

# B. Mutual attention, social boundaries, and relationship-aware perception

## B1. Repeated `EXAMINE MARA` becomes a social action when it stops being ordinary observation

The live game already proves adjacent principles:

- `EXAMINE MARA` can change after a recent event;
- repeated hostile or boundary-crossing actions can be remembered rather than replaying generic prose;
- kissing is already history-sensitive;
- Mara can request space and later decisions can depend on whether that boundary was actually respected.

What is missing is ordinary **repeated scrutiny**.

A future layer should distinguish:

- normal first observation;
- ordinary re-examination after meaningful time has passed;
- repeated looking in a short attention episode;
- targeted scrutiny of clothing or an injury for a relevant reason;
- repeated invasive body scrutiny without a reason;
- relationship/context changes in interpretation.

Possible early escalation:

1. normal description;
2. abbreviated description or neutral acknowledgment;
3. Mara notices the repeated attention;
4. Mara asks what the Adventurer needs;
5. continued staring becomes a named boundary event.

Do **not** implement this as `EXAMINE_COUNT >= 3 = angry`.

Immediate scrutiny should decay after meaningful intervening play, separation, or time. Only an actual crossed boundary may deserve durable history.

---

## B2. Body-part examination has context

Future embodiment introduces a difference between:

- `EXAMINE MARA'S COAT` after she says it is torn;
- `EXAMINE MARA'S HAND` after an injury;
- repeatedly inspecting intimate areas without an authored reason.

The parser should understand that social meaning depends on what is being examined, why, the current relationship, prior boundaries, and circumstances.

This is not a universal prudishness system. It is authored social causality.

---

## B3. Mara can notice the Adventurer without being asked

Perception must be reciprocal.

Mara may notice meaningful changes such as:

- a new outfit;
- a repaired or retained damaged garment;
- fresh mud, soot, blood, or water;
- an injury or new scar;
- a newly visible tattoo;
- the Adventurer repeatedly wearing an object associated with a shared event;
- a sudden attempt at disguise or concealment.

This should arise from her actual presence and knowledge, not omniscient narration.

---

## B4. Relationship changes interpretation, not permission as a numeric unlock

Deep friendship or future mutual romance may make some kinds of attention playful, familiar, welcome, or intimate. That must come from named shared history, not from a hidden `RELATIONSHIP_LEVEL` threshold that grants blanket access.

Even partners retain boundaries.

The useful principle is:

> The same physical action may mean something different because two people have become different people to one another.

---

# C. Renown, recognition, and identity propagation

## C1. Fable-like renown without a global omniscient renown meter

The useful part of Fable's renown is that the world knows the person you have become. HE should implement that through evidence and witnesses rather than a universal numeric score.

Separate these truths:

1. **what the Adventurer actually did**;
2. **what the Adventurer currently looks like**;
3. **what a particular person witnessed, was told, inferred, or misheard**.

Reputation may propagate through:

- direct witnesses;
- Mara's testimony;
- travelers;
- correspondence;
- House or museum records;
- rumors;
- physical evidence;
- distinctive carried equipment;
- clothing descriptions.

Second-hand stories may be incomplete or wrong without making the engine itself confused.

---

## C2. Appearance-based recognition is not personal recognition

Someone who only heard about “the traveler in the battered green coat” may recognize the coat rather than the person.

Changing clothes can therefore affect recognition without becoming a generic disguise stat.

Possible recognition evidence:

- face;
- voice;
- distinctive clothing;
- scar or tattoo;
- well-known carried object;
- mannerism or behavior;
- second-hand description.

Mara may recognize the Adventurer immediately because she knows him personally, while a stranger may fail because only the famous coat is absent.

This makes clothing part of social identity continuity rather than cosmetic equipment.

---

## C3. Zork III-style “potential” / demonstrated capability

Zork III reframed some progress as the Adventurer's **potential**, not merely treasure collection. HE already has knowledge, learned capabilities, geography, relationship history, physical preparation, and consequence history.

A future organ could represent what the playthrough has demonstrated the Adventurer can actually do without exposing RPG XP or levels.

This may eventually affect how certain people or institutions respond to the Adventurer, but should not become a generic stat gate.

Renown and potential are related but distinct:

- **potential/capability**: what the Adventurer has demonstrated;
- **renown/reputation**: what the world believes about the Adventurer.

---

# D. Sequel-derived world and parser organs not yet fully absorbed

## D1. Autonomous world actor with an independent agenda

Zork II's Wizard demonstrates a roaming clock-driven antagonist who may intersect the player while pursuing his own behavior.

HE has sophisticated local actors and Mara has initiative, but a future actor could:

- physically travel ordinary geography;
- use or move real objects;
- act elsewhere while the Adventurer is absent;
- pursue goals unrelated to current player command;
- remember encounters;
- create consequences the player later discovers.

This should remain one or a few deeply authored actors, not a generic NPC brain for every creature.

---

## D2. Temporary world-affecting conditions and transformations

Zork II's Wizard demonstrates temporary conditions such as clumsiness, fear, floating, fireproofing, freezing, and other world-changing effects.

HE learned magic is intentionally narrow today. A later system could let temporary authored conditions modify ordinary world interactions without becoming mana, spell slots, or stat buffs.

Examples:

- object temporarily floats;
- room temporarily resists fire;
- Adventurer becomes clumsy;
- carried items become difficult to retain;
- movement temporarily changes;
- an actor becomes afraid of a specific thing;
- an object becomes temporarily too heavy/light/hot/cold for ordinary handling.

The value is recombination of existing world state rather than merely adding more rooms.

---

## D3. Parser-native secondary actor control

Zork II's robot demonstrates another actor receiving ordinary parser actions under a different acting subject.

HE has bounded `ASK MARA TO ...` cooperation, but not a general architecture where another embodied actor can receive a wider ordinary verb surface.

Possible future uses:

- robot;
- remote mechanical manipulator;
- summoned or temporary helper;
- familiar;
- two-position puzzle actor;
- alternate playable body in a bounded authored sequence.

This must not erase actor autonomy or turn Mara into a commandable unit.

---

## D4. Persistent simulated multi-room vehicle

Zork II's balloon demonstrates a vehicle with persistent movement, tethering, landing, fuel/heat behavior, and occupancy across multiple locations.

Potential HE-native vehicles:

- mine cart;
- rail handcar;
- river craft;
- sailboat;
- cable tram;
- maintenance crawler;
- dirigible or GUE equivalent.

State may include occupants, carried objects, damage, fuel, tethering, loading, and route position.

No instant destination menu.

---

## D5. Mutable or rotating topology

Zork II's Carousel Room demonstrates topology whose directional meaning changes under state.

Future authored possibilities:

- rotating structures;
- shifting machinery;
- flooded routes changing connectivity;
- moving railway junctions;
- mirrored architecture;
- collapsing tunnels;
- rotating towers;
- physically reoriented rooms.

This is stateful topology, not procedural world generation.

---

## D6. Timed world-phase catastrophe / epochal state change

Zork III's earthquake changes usable geography and creates “before event” versus “after event” play.

HE already has a FUTURE **Time, Weather & Disaster Arc**, but the wider missing organ is a major authored event that changes several distant systems at once.

Possible consequences:

- bridges fall;
- passages open or collapse;
- water relocates;
- creatures move;
- NPC locations change;
- evidence becomes buried or exposed;
- previously useless routes become important;
- objects are stranded or destroyed if left in vulnerable places.

The event should be materially different on both sides, not just changed room prose.

---

## D7. Temporary alternate-world or historical excursions

Zork III's Scenic Vista demonstrates temporary transport into another scene followed by forced return.

HE could use this for:

- a historical version of a place;
- pre-collapse GUE architecture;
- another season;
- a recorded/magically reconstructed event;
- a bounded alternate state;
- a House of Records evidence excursion.

Object continuity across the boundary must be deliberately authored. This is not generic multiverse generation.

---

## D8. Real time travel / date-dependent geography

Zork III's time machine points toward a stronger future organ: the **same physical location existing at several historical states**.

Potential sequence:

`GUE-active → abandoned → Zork-I-era → HE-present`

This could eventually unify history, archaeology, House records, chronology, object provenance, and environmental change.

If this is ever built, age may become more than character flavor because chronology would have actual gameplay consequences.

---

## D9. Compositional learned magic / spellbook

The Enchanter lineage expanded Zork's magic into learned words that become parser capabilities and compose with ordinary world objects.

HE Release 1266 intentionally shipped only a narrow learned stilling ward. A future expansion could support:

- finding or reconstructing spells;
- deliberate learning;
- memorization or preparation if period-authentic research supports it;
- spell words becoming parser-native actions;
- authored spell/object interactions;
- multiple physically credible solutions.

No mana bar, spell-slot RPG, generic enchantment registry, or universal target matrix by default.

---

## D10. Parser frustration detection and contextual coaching

Later Infocom parser work, especially Zork Zero, explored recognizing when the player appears to be struggling with parser phrasing and offering examples.

HE already insists that described nouns be parser-real. A complementary future organ is recognizing repeated attempts that likely express the same intent.

Example cluster:

- `MOVE LOOSE BRICK`;
- `PUSH MASONRY`;
- `MOVE WALL BRICK`;
- `PULL BRICK`.

Rather than four unrelated generic failures, the parser may eventually infer that the player is trying to manipulate the same visible thing and offer a supported phrasing when appropriate.

This should be deterministic, bounded, and parser-native. No external AI is required.

---

# E. Cross-organ compositions worth preserving

The most valuable ideas are not isolated features. Several become much stronger when composed.

## E1. Embodiment → clothing → condition → laundering → appearance → recognition → renown

A garment can carry environmental history, be cleaned or repaired, remain visually distinctive, and become part of how strangers identify or misidentify the Adventurer.

## E2. Mara memory → mutual attention → privacy → relationship history

Mara already remembers specific events and boundaries. Repeated scrutiny, changing clothes, personal storage, and reciprocal observation can become ordinary social history without inventing an approval meter.

## E3. Appearance → photographs → autobiography

Physical photographs can preserve what both people actually looked like during a specific expedition, including damaged clothing and visible marks.

## E4. Catastrophe → clothing/environment → House recovery

A world event should not end at the room boundary. Characters may return soaked, muddy, injured, missing equipment, or wearing damaged clothes, turning the House into a real recovery place.

## E5. Time-state geography → provenance → museum / House of Records

If places can be visited in multiple historical states, object provenance and documentary contradictions become gameplay rather than backstory.

## E6. Autonomous actors → renown propagation

An independently traveling actor can carry stories, objects, misinformation, or firsthand testimony across regions, making reputation physically propagate through the same world rather than through a hidden global flag.

## E7. Temporary conditions → vehicles / topology / alternate solutions

Temporary magic or environmental state can change how an existing vehicle, passage, or mechanism behaves, increasing recombination before map expansion.

---

# F. Explicit non-goals

Unless later research overturns a boundary deliberately, this catalog does **not** request:

- mandatory dressing or laundry chores;
- a character-creator GUI;
- player control over Mara's clothing choices;
- exposed romance, affection, trust, cleanliness, renown, or approval meters;
- generic NPC AI;
- generic pathfinding;
- generic physics simulation;
- procedural world generation;
- randomized loot;
- arbitrary clothing stat buffs;
- RPG levels masquerading as identity;
- universal spell/object matrices;
- omniscient reputation propagation;
- automatic romance from appearance or clothing;
- intimacy treated as a numeric permission unlock;
- modern-Earth household appliances dropped into GUE without worldbuilding justification.

---

# G. Research questions before promotion

Before any of these becomes a numbered train, research should answer the appropriate subset of questions:

1. What did Zork II/III and later Infocom actually implement versus what players merely remember?
2. Which parser and actor architectures can be reused without importing later-game assumptions wholesale?
3. What clothing, laundering, domestic, textile, soap, dye, and repair practices best fit the implied GUE material culture?
4. What existing Zork/Infocom prose establishes clothing, body, privacy, bathing, laundry, uniforms, status dress, scars, age, tattoos, or personal recognition?
5. Which non-Infocom interactive-fiction games solved embodiment, reputation, autonomous NPCs, time-state worlds, vehicles, mutable topology, or parser coaching particularly well?
6. Which immersive-sim ideas translate into a parser world without turning HE into a generic simulation engine?
7. What should remain qualitative and authored rather than numerical?
8. Which ideas are one complete organ versus several separate trains?
9. Which systems naturally compose with already-shipped Mara biography, snapshots, House custody, cuisine, fire, water, destruction, ecology, learned magic, and chronicle state?
10. What would make each promoted train visibly useful to an ordinary player who never reads the implementation notes?

---

# H. Promotion rule

Do not assign release numbers from this file merely because an entry is exciting.

A concept leaves this catalog only when a later planning pass can state:

- the exact player-facing experience;
- the existing authorities it composes with;
- what it explicitly does not generalize;
- the natural-command qualification journey;
- why it belongs now rather than later;
- whether it is one train, several trains, or part of a larger product organ.

Until then, this file is the parking place for the ideas we refuse to lose.
