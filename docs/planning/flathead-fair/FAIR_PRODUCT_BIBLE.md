# Flathead Fair product bible

**Status:** STABLE FOR PLANNING  
**Product:** recurring parser-first Flathead Fair world organ  
**Implementation:** NOT AUTHORIZED by this planning packet

## North star

Build a fair the Adventurer and Mara can visit because it is enjoyable to be there, not because the main adventure requires it.

The fair should support ten minutes of incidental wandering or an entire in-world day. It should reward curiosity with food, rides, games, shopping, fishing, performances, conversation, tiny objectives, social memories, rare incidents and repeat visits.

The fair is a **place**, not a menu of minigames.

## Locked product identity

- Public/common name: **The Flathead Fair**.
- Canonical anchor: the Flathead Mountains visible from `CANYON-VIEW`.
- Event fiction: annual regional fair near the favorable-season trade/market period.
- Grounds: real year-round meadow/field geography beyond the forest, attached by a new northeast spur from canonical `CLEARING`.
- General admission: **free**.
- Ordinary commerce: **zorkmids**.
- Prize tickets: earned midway redemption only, never a replacement for ordinary money.
- Initial footprint: **16 dense functional locations**.
- Fairground records/service room: **Fair Office & Prize Hall**, not a second historical archive.
- Durable documentary fair history: the existing upstairs/Attic **Hall/House of Records** authority.
- Named planning population: **20 substantial NPCs** — 12 core workers/regulars plus 8 secondary people — with authored crowd population around them.
- Signature food: elephant ears; cinnamon-sugar baseline **5 zm**.
- First partial-identification acceptance object: `large drink` = **pear-lime fizz, 4 zm**.
- Adult-evening social service: **The Lantern Table**, inside the existing Dance Pavilion rather than a seventeenth room.

## Product promises

1. **Optionality.** Canonical Zork remains solvable without attending.
2. **Density.** Fair rooms exist because several meaningful things happen there. Avoid corridor rooms whose only purpose is traversal.
3. **Parser reality.** Food, prizes, drinks, tickets, merchandise, fish, gifts, records and fair objects are real objects/state where practical.
4. **Contextual knowledge.** `ASK`, `EXAMINE`, `SMELL`, `TASTE`, `LISTEN`, `BUY`, `GIVE` and related verbs reveal authored information rather than collapsing into generic replies.
5. **Adult social life.** Couples, dates, dancing, conversation, affection, evening food/drink and relationship-appropriate privacy belong naturally in the fair without a romance room or date mode.
6. **Mara agency.** Mara is a participant with concrete authored preferences, initiative, refusals, competition and memory, not a romance vending machine.
7. **Recurring life.** The fair opens, changes through the day, closes, tears down and later returns when broader calendar authority can honestly support that recurrence.
8. **Controlled chance.** Fishing, races, raffles, incidental encounters, stock and similar optional activity may vary; once a result becomes world fact it is committed into saveable story state.
9. **Persistent history with provenance.** Current Fair Office paperwork, durable House of Records evidence, physical objects and personal memories remain distinct while composing coherent history.
10. **Zork voice.** Bureaucratic absurdity, physical comedy, confident narration, odd products, real consequences and exact object identity matter more than carnival cliché.

## Why this organ exists

Highly Extended Zork already contains danger, treasure, consequence, survival, relationship, property, environmental, memory and archival work. The fair adds a different kind of density: **recreational life**.

It should create reasons to:

- spend money without solving a canonical puzzle;
- keep a silly object because it means something;
- learn a vendor's name;
- ask what food or drink actually is;
- compete with Mara and lose;
- catch a fish;
- dance;
- ride something twice because the context changed rather than because repetition is mandatory;
- stay until closing;
- return when the broader world can honestly support another fair;
- compare what people remember with what physical records actually claim.

## Structural inspiration boundary

The useful lesson from Guardia Fair is structural: a fair can be a small optional game-world nested inside a larger adventure.

Do **not** reproduce Chrono Trigger's:

- character-collision introduction;
- princess/incognito plot;
- pendant beat;
- Gato or a legally distinct giant robot-animal substitute;
- exact minigames;
- court/trial consequence structure;
- names, dialogue, map or story incidents.

The Flathead Fair must be recognizably Zork.

## Core pillars

### Dense place, not acreage

Every major fair location combines multiple interaction families. Avoid filler rooms whose only function is walking to another room.

### Parser-real products

Food, drinks, prizes, toys, clothing, books, curiosities and fishing goods have concrete identities.

A player-facing label may represent incomplete knowledge (`large drink`) without the object itself being generic.

### Contextual people

Named NPCs know what their jobs, observations, memories and relationships justify. They can also be wrong, uncertain, private, deceptive or simply ignorant.

No generic response is acceptable when the world has plainly invited a specific question the character should be able to answer.

The 20 named people are enough to establish durable fair life without turning the design into a census. New named characters require a real role, knowledge boundary, continuity need or story function.

### Mara is a participant

`FAIR_MARA_EXPERIENCE.md` owns her fair-specific character authority.

Stable examples include:

- strong preference for the Observation Wheel near dusk/evening;
- baseline dragon choice on the carousel;
- genuine low-intensity fishing interest;
- concrete game preferences and willingness to beat the Adventurer;
- apple-topped elephant-ear preference;
- pear-lime fizz by day after she knows its identity and hot spiced cider in cooler evening conditions;
- phase-sensitive initiative;
- contextual refusal and annoyance when repetition ignores a clear boundary;
- semantic memory of prior fair experiences.

There is no `DATE MODE`, romance-point vending machine or player-ego protection roll.

### Adult social life

The Lantern Table gives Dance Pavilion a concrete evening supper/drink/social service without adding a room or nightlife subsystem.

Tomas Quince transitions there at DUSK. Ordinary social access is free and has no drink minimum. Alcohol/intoxication is not required to make the space adult.

Privacy comes from actual context: service/crowd density, communal versus edge tables, Observation Wheel carriage, Pond Path, thinning closing grounds and broader legitimate private geography.

No `ROMANTIC-ROOM` flag and no fair-specific intimacy minigame.

### Controlled chance

`FAIR_RNG_CONTRACT.md` is stable for planning and grounded in the active Glulx runtime.

Product law:

- Glulx player SAVE/RESTORE does **not** save interpreter RNG internal state;
- the fair does not globally reseed production RNG;
- once a random result becomes a fact of the world, that fact is stored in ordinary saveable story state;
- repeated observation/re-entry does not reroll committed reality;
- a chance event not yet committed before a player save may resolve differently after restore;
- the fair does not punish SAVE use or maintain hidden anti-save state;
- deterministic qualification may use pinned Glulxe process-level `--rngseed`;
- RNG never controls canonical solvability, Mara's personality, relationship success, generated dialogue or generated lore.

### Persistence and records

The fair uses **three distinct persistence authorities**:

1. **Fair Office & Prize Hall** for current-event administration.
2. **Existing upstairs Hall/House of Records** for selected durable documentary history.
3. **Personal/world memory** for lived continuity.

The archive preserves **historical signal, not administrative exhaust**.

Strong durable classes include:

- official annual/cycle program;
- meaningful historical grounds maps;
- annual public-results summary;
- standing-record changes;
- major attraction/concession changes;
- formally adjudicated historically significant incidents;
- provenance-bearing historical material.

Routine booth attempts, ordinary fish, everyday weigh-in sheets, stock sheets, queue paperwork, routine permits, ordinary lost-and-found and private purchases do not automatically graduate.

A corrected/disqualified result retains the original claim and adds the correcting evidence/authority. History is not silently rewritten.

Private Mara/Adventurer experiences are not automatically institutional records.

See `FAIR_HALL_OF_RECORDS_INTEGRATION.md` and `FAIR_PERSISTENCE_AND_MEMORY.md`.

### Real time and weather

The fair's nine authored phases define operating behavior without inventing a global clock.

Release 1307's authored time/weather authority is a dependency for final weather/time composition. The fair does not create a second weather engine.

Rain changes operations rather than simply producing `FAIR CANCELLED`. Wind can suspend appropriate rides. Covered venues can become more important. Severe weather response must remain authored and visible.

### Canonical Zork remains authoritative

The fair is additive. It does not steal House/Canyon exits, relocate required treasure, block canonical solutions or make fair participation mandatory for completing Zork.

## What the fair is not

- not Guardia Fair with renamed nouns;
- not a Gato substitute;
- not a mandatory quest hub;
- not a generic `CarnivalEngine`;
- not a procedural-content generator;
- not a romance meter arcade;
- not a GUI attraction selector;
- not an economy simulator that forces bookkeeping;
- not a second historical archive;
- not an anti-save system;
- not an excuse to rewrite canonical routes.

## Interaction-density rule

Each major fair location should support at least three meaningful interaction families. Food Row can support buying, eating/sharing, vendor conversation, Mara preferences, crowd behavior and an authored incident. House of Mirrors can support navigation, reflection interactions, Mara reactions, mundane optical explanation and a small authored anomaly set.

## Completion philosophy

The fair may have records, prizes, ribbons, fish, rare objects and discoverable stories, but it should not conceptually become `FAIR 100% COMPLETE`. The design target is a place players revisit, not a checklist to exhaust.

## Relationship to existing Highly Extended Zork

The fair composes existing authorities instead of duplicating them: time/weather, material/object identity, Mara relationship/autonomy, clothing/property, money/custody, NPC memory, darkness/light, House of Records archival authority and natural-play qualification.

Where a needed authority has not landed on `master`, the fair records it as a dependency rather than silently inventing a parallel system.

## Planning maturity

The product bible is now stable enough to define the product boundary. Remaining open questions are tracked in `FAIR_OPEN_QUESTIONS.md` and classified in `FAIR_IMPLEMENTATION_GATE_REVIEW.md` as:

- external dependency blockers;
- local pre-code product decisions;
- implementation details;
- future expansion.

`STABLE FOR PLANNING` does **not** mean implementation is authorized.

## Implementation gate

Planning remains ahead of code.

No implementation train begins from this document alone. The current gate state and exact blockers live in `FAIR_IMPLEMENTATION_GATE_REVIEW.md`.

Even if the product packet becomes coherent enough for future implementation decomposition, Justin's planning-first instruction remains authoritative until he explicitly changes it.
