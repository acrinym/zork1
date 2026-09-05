# Flathead Fair product bible

**Status:** DESIGNING  
**Product:** recurring parser-first Flathead Fair world organ  
**Implementation:** NOT AUTHORIZED by this planning packet

## North star

Build a fair the Adventurer and Mara can visit because it is enjoyable to be there, not because the main adventure requires it.

The fair should support ten minutes of incidental wandering or an entire in-world day. It should reward curiosity with food, rides, games, shopping, fishing, performances, conversation, tiny objectives, social memories, rare incidents, and repeat visits.

The fair is a **place**, not a menu of minigames.

## Locked product identity

- Public/common name: **The Flathead Fair**.
- Canonical anchor: the Flathead Mountains visible from `CANYON-VIEW`.
- Event fiction: annual regional fair near the favorable-season trade/market period.
- Grounds: real year-round meadow/field geography beyond the forest, attached by a new northeast spur from canonical `CLEARING`.
- General admission: **free**.
- Ordinary commerce: **zorkmids**.
- Prize tickets: earned midway redemption only, never a replacement for ordinary money.
- Initial footprint: about **16 dense functional locations**.
- Fairground records/service room: **Fair Office & Prize Hall**, not a second historical archive.
- Durable documentary fair history: the existing upstairs/Attic **Hall/House of Records** authority.
- Initial core population: **12 working named NPCs**, plus authored crowd population.
- Signature food: elephant ears; cinnamon-sugar baseline **5 zm**.
- First partial-identification acceptance object: `large drink` = **pear-lime fizz, 4 zm**.

## Product promises

1. **Optionality.** Canonical Zork remains solvable without attending.
2. **Density.** Fair rooms exist because several meaningful things happen there. Avoid corridor rooms whose only purpose is traversal.
3. **Parser reality.** Food, prizes, drinks, tickets, merchandise, fish, gifts, records, and fair objects are real objects where practical.
4. **Contextual knowledge.** `ASK`, `EXAMINE`, `SMELL`, `TASTE`, `LISTEN`, `BUY`, `GIVE`, and related verbs reveal authored information rather than collapsing into generic replies.
5. **Adult social life.** Couples, dates, dancing, private conversations, affection, evening venues, and established relationships belong naturally in the fair.
6. **Mara agency.** Mara is a participant, not a romance vending machine.
7. **Recurring life.** The fair opens, changes through the day, closes, tears down, and later returns with continuity and variation.
8. **Controlled chance.** Fishing, races, raffles, incidental encounters, stock, and similar activities may vary, but required content must remain fair and recoverable.
9. **Persistent history with provenance.** Current Fair Office paperwork, durable House of Records evidence, physical objects, and personal memories remain distinct while still composing a coherent history.
10. **Zork voice.** Bureaucratic absurdity, physical comedy, confident narration, odd products, real consequences, and exact object identity matter more than carnival cliché.

## Why this organ exists

Highly Extended Zork already contains danger, treasure, consequence, survival, relationship, property, environmental, memory, and archival work. The fair adds a different kind of density: **recreational life**.

It should create reasons to:

- spend money without solving a canonical puzzle;
- keep a silly object because it means something;
- learn a vendor's name;
- ask what food or drink actually is;
- compete with Mara and lose;
- catch a fish;
- dance;
- ride something twice;
- stay until closing;
- return another year and discover that the world remembers;
- compare what people remember with what old records actually say.

## Structural inspiration boundary

The useful lesson from Guardia Fair is structural: a fair can be a small optional game-world nested inside a larger adventure.

Do **not** reproduce Chrono Trigger's:

- character-collision introduction;
- princess/incognito plot;
- pendant beat;
- Gato or any legally distinct giant robot animal;
- exact minigames;
- court/trial consequence structure;
- names, dialogue, map, or story incidents.

The Flathead Fair must be recognizably Zork.

## Core pillars

### Dense place, not acreage

Every major fair location combines multiple interaction families. Avoid filler rooms whose only function is walking to another room.

### Parser-real products

Food, drinks, prizes, toys, clothing, books, curiosities, and fishing goods are real objects with real identities.

A player-facing label may be incomplete knowledge (`large drink`) without the object itself being generic.

### Contextual people

Named NPCs know what their jobs, observations, memories, and relationships justify. They can also be wrong, uncertain, private, or unwilling.

No generic response is acceptable when the world has plainly invited a specific question the character should be able to answer.

### Mara is a participant

Mara can initiate, refuse, buy, eat, fish, wander, dance, compete, remember, tease, get tired, get excited, and have opinions independent of the Adventurer.

There is no `DATE MODE` and no romance-point vending machine.

### Adult social life

The fair supports adult dating, dancing, affection, privacy gradients, evening social venues, couples, proposals, arguments, reconciliation, and relationship-appropriate intimacy through broader autonomy/consent authority.

It is not exclusively a children's attraction and does not become a fair-specific sex minigame.

### Controlled chance

RNG belongs in optional play such as fishing, races, raffles, stock variation, and incidents. Required canonical progress does not depend on arbitrary rolls.

### Persistence and records

The fair uses **three distinct persistence authorities**:

1. **Fair Office & Prize Hall** for current-event administration: schedules, current permits, entries/results, lost-and-found, current incident/complaint intake and current notices.
2. **Existing upstairs Hall/House of Records** for selected durable documentary history: old programs, historical maps, major results, historically meaningful concession records, attraction changes and significant adjudicated incidents.
3. **Personal/world memory** for lived continuity: Mara memories, Adventurer memories, vendor recognition, NPC opinions and relationship history.

These layers may cross-reference each other, but they do not collapse into one database.

The archive preserves provenance, confidence/verification, contradiction and redaction where existing archive authority supports them. A current pamphlet, an old program, Ephraim's memory and a Frobozz claim may disagree without the game inventing a magic `TRUE VERSION` flag.

Private Mara/Adventurer experiences are not automatically institutional records.

See `FAIR_HALL_OF_RECORDS_INTEGRATION.md` and `FAIR_PERSISTENCE_AND_MEMORY.md`.

### Real time and weather

The fair changes from morning through closing and responds to weather through authored operating rules rather than a generic climate simulation.

### Canonical Zork remains authoritative

The fair is additive. It does not steal House/Canyon exits, relocate required treasure, block canonical solutions, or make fair participation mandatory for completing Zork.

## What the fair is not

- not Guardia Fair with renamed nouns;
- not a Gato substitute or robot-animal gag;
- not a mandatory quest hub;
- not a generic `CarnivalEngine` intended to manufacture arbitrary fairs;
- not a procedural-content generator;
- not a romance meter arcade;
- not a GUI attraction selector;
- not an economy simulator that forces bookkeeping;
- not a second historical archive beside the existing House of Records;
- not an excuse to rewrite canonical routes.

## Interaction-density rule

Each major fair location should support at least three interaction families. Example: Food Row may support buying, eating/sharing, vendor conversation, Mara preferences, crowd incidents, and one discovered errand. The House of Mirrors may support navigation, reflection interactions, Mara reactions, secrets, and rare anomalies.

## Completion philosophy

The fair may have records, prizes, ribbons, fish, rare objects, and discoverable stories, but it should not conceptually become `FAIR 100% COMPLETE`. The design target is a place players revisit, not a checklist to exhaust.

## Relationship to existing Highly Extended Zork

The fair should compose existing authorities instead of duplicating them: time/weather, world-state persistence, material/object identity, Mara relationship and autonomy, clothing/property, NPC memory, darkness/light, Hall/House of Records archival authority, and natural-play qualification.

Where a needed authority does not yet exist, the fair plan must name the dependency rather than silently inventing a parallel system.

## Implementation gate

Planning remains ahead of code.

No implementation train should begin until the load-bearing authorities called out in `FAIR_PLANNING_INDEX.md` are stable enough to answer what the fair is, where it is, how money/products/people work, how Mara/autonomy behaves, what randomness may do, what persists, how current records graduate into durable archival history, and how canonical play will be protected.
