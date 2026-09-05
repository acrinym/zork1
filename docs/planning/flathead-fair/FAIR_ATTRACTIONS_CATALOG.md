# Flathead Fair attractions catalog

**Status:** STABLE FOR INITIAL ATTRACTION PLANNING  
**Prices:** owned by `FAIR_PRICE_BOOK.md`  
**Locations:** owned by `FAIR_GEOGRAPHY.md`

## Attraction law

A fair attraction must be something the player can **do**, inspect, ask about, repeat under changed conditions and remember. A name on the map plus `>RIDE` is not enough.

Attractions compose real time, weather, object, NPC and Mara authority without becoming universal simulation frameworks.

## 1. Observation Wheel

**Location:** `OBSERVATION-WHEEL`  
**Operator:** Emery Wicks  
**Fare:** 3 zm per rider  
**Primary value:** scenic observation, social/private carriage context, time/weather variation

### Experience phases

A normal ride has authored states:

1. approach/queue;
2. ask/buy fare or present valid prepaid ride strip;
3. boarding;
4. ascent;
5. upper arc / top;
6. descent;
7. unload.

These may span turns, but the player is not forced through pages of identical elevator prose.

### Parser affordances in carriage

Reasonable actions include:

- `LOOK` / `LOOK DOWN` / `LOOK EAST` / `LOOK TOWARD MOUNTAINS`;
- examine the fair, forest, distant Flathead Mountains and other visible landmarks supported by geography;
- `LISTEN` to machinery/fair/music/wind;
- talk to Mara or another rider;
- sit, stand only where safe/allowed, lean only where physical authority supports it;
- examine carriage, latch, wheel structure and lights;
- ask Mara what she sees / thinks;
- ordinary affection where broader relationship and privacy authority permits.

The wheel does not grant x-ray vision into underground Zork or omniscient map knowledge.

### Time-of-day variation

- daytime: strongest geographic visibility;
- dusk: lights ignite below while surrounding terrain remains visible;
- evening: fair lights dominate and distant landscape becomes less legible;
- closing: final ride has distinct thinning-crowd atmosphere.

### Weather

Emery may stop boarding for unsafe wind or severe conditions. If payment has been accepted for an unused ride, refund/credit policy applies.

A routine temporary stop may happen rarely for loading/balancing/mechanical reasons. It is not automatically a disaster or romance event.

### Mara

Mara may accept, refuse, suggest waiting until dusk, initiate conversation, look at landmarks, enjoy or dislike the height, or simply ride without producing a scripted relationship beat.

The wheel is good romance context because of actual carriage privacy, not because it sets `ROMANCE=TRUE`.

## 2. Carousel

**Location:** `RIDE-COURT`  
**Operator:** Tilda Fen  
**Fare:** 2 zm  
**Primary value:** choice, visual comedy, repeatable social activity

### Mount roster

Initial carved figures should be Zork-native or GUE-plausible rather than generic horses. Working set:

- grue;
- cyclops;
- dragon;
- sea serpent;
- unicorn;
- giant songbird;
- absurdly dignified pack animal / regional beast to be finalized with lore.

The figures are carvings, not living creatures and not combat encounters.

### Affordances

- examine each figure;
- ask Tilda about a figure, age, repair or popularity;
- choose a mount;
- ride alone or with companions where seating permits;
- watch someone else ride;
- inspect mechanism/paint/decorations from public space;
- notice repaired/replaced pieces across later fairs.

Mount choice may change prose, Mara preference and memory. It does not grant RPG stats.

### Running joke potential

One mount can be notoriously popular with children and another mysteriously avoided despite nothing being mechanically wrong with it. Tilda knows the social history because she operates the ride.

## 3. Flying Chairs / Swing Ride

**Location:** `RIDE-COURT`  
**Operator:** Tilda Fen  
**Fare:** 2 zm  
**Primary value:** motion, wind, loose-object/clothing reactions, contrast with carousel

### Affordances

- choose seat where authored;
- ride/watch;
- ask Tilda about wind/operation;
- feel/observe wind and fair motion;
- react to a loose hat, scarf or lightweight object only where the broader physical/clothing authority supports it.

### Weather

This is more wind-sensitive than the carousel. Tilda can close this ride while the carousel remains open, proving fair weather response is per attraction rather than one master switch.

No arbitrary item deletion: a loose object event must preserve real object identity and recoverability according to physical consequence authority.

## 4. Scenic Great Underground Empire Ride

**Location:** Ride Court attraction entrance; ride interior is contextual/temporary rather than a large new ground-map branch  
**Fare:** 3 zm  
**Primary value:** Zorkian civic propaganda, world lore, comedy through mismatch between exhibit and reality

### Concept

A slow mechanical ride presents a spectacularly cleaned-up tourist history of the Great Underground Empire and selected famous places. The Adventurer may have personally experienced versions of some subjects.

Possible scenes include sanitized/heroic representations inspired by:

- a picturesque white house;
- heroic frontier forests;
- civil-engineering triumph around Flood Control Dam #3;
- Aragain Falls / the Frigid River;
- imperial commerce and Frobozz achievement;
- the Flathead region itself.

The ride may be wrong, biased or absurd, but each false claim belongs to an in-world exhibit/author rather than silently rewriting objective lore.

### Parser affordances

- examine scenes, figures, plaques and machinery;
- ask Mara about discrepancies she knows;
- ask Tilda/another attendant who built or maintains it;
- compare exhibit claims against facts the Adventurer has actually learned;
- point out obvious inaccuracies where dialogue authority supports it.

No trivia quiz is required to finish the ride.

## 5. House of Mirrors

**Ground location:** `HOUSE-OF-MIRRORS`  
**Fare:** 3 zm  
**Primary value:** deep parser play, spatial confusion, reflection behavior, rare genuinely strange events

### Core law

Most mirrors are mundane. If every mirror is supernatural, none of them are interesting.

The attraction mixes optical distortion, deliberate maze construction, reflections of other visitors, misleading sightlines and a **small authored anomaly set**.

### Initial internal topology

The attraction earns a small five-node sub-map inside the single ground location:

1. **Mirror Foyer** — attendant/checkpoint, ordinary mirrors establish baseline.
2. **Crooked Gallery** — convex/concave distortions and misleading apparent openings.
3. **Repeating Passage** — parallel mirrors create apparent infinite corridors; navigation clues are physical, not random.
4. **Crossed Reflections** — sightlines show people/objects through mirrors at unexpected angles.
5. **Exit Gallery** — ordinary exit path plus final mirrors and re-entry boundary.

The exact ZIL room/object implementation remains future work, but the authored topology is stable enough to design interactions and qualification.

### Parser surface

Supported semantic actions should include where relevant:

- `LOOK IN MIRROR`;
- `EXAMINE REFLECTION`;
- `TOUCH MIRROR`;
- `KNOCK ON MIRROR`;
- `WAVE AT REFLECTION`;
- `SMILE AT REFLECTION`;
- `TURN AWAY`;
- `FOLLOW REFLECTION`;
- `SHOW <OBJECT> TO MIRROR`;
- `PUT/HOLD <OBJECT> BEFORE MIRROR`;
- `ASK MARA ABOUT MIRROR/REFLECTION`;
- attempts to break/damage a mirror routed through real destruction/social consequence authority rather than ignored as an attraction-specific special case.

### Mundane behaviors

- distortion changes perceived proportions;
- mirror angles reveal another visitor before the player reaches them;
- false apparent corridors terminate at glass;
- identical-looking turns can be distinguished through authored physical marks, floor, frame shape, draft/sound or remembered path.

The attraction must be solvable by observation. It is not a random maze.

### Rare anomaly budget

Initial planning permits only a few genuinely wrong reflection families, for example:

- a reflection lags one action behind once;
- an expected reflection is absent for a specific authored beat;
- Mara notices a mismatch the Adventurer may or may not have noticed;
- a reflected object appears positioned inconsistently with the real sightline;
- an anomalous mirror can expose a clue/object/history only through specific observation.

An anomaly is stateful and authored. It is **not** chosen from infinite creepy prose.

### Mara

Mara can react to ordinary distortions, tease, become curious, point out a route clue, notice an anomaly or refuse destructive/stupid behavior according to broader character authority.

Her reflection does not become a separate clone/NPC merely because the attraction exists.

### Exit fairness

- closing never traps the player inside;
- an attendant stops new entry early enough to clear the attraction;
- ordinary navigation always has a learnable route out;
- strange events do not permanently remove the exit.

## Repeatability law

Attractions earn repeat visits through changed context, not slot-machine prose:

- different time/weather;
- different companion/NPC;
- remembered mount/ride preference;
- changed fair year/repair;
- a specific rare authored incident;
- new player knowledge about a scenic exhibit or mirror clue.

## Attraction ownership still open

Exact association/independent/Frobozz ownership per ride remains open. Ownership should affect signage, maintenance attitude, refund policy and dialogue where useful, not require a corporate-management simulator.

## Hard boundaries

- No attraction gates canonical Zork completion.
- No Gato analogue or giant robot-animal fight.
- No random unavoidable mechanical catastrophe.
- No universal ride framework whose purpose is generating arbitrary rides.
- No GUI attraction selector.
- No scripted romance override.
