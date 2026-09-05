# Flathead Fair fishing

**Status:** STABLE FOR INITIAL FISHING PLANNING  
**Primary location:** `FISHING-POND` with alternate bank context from `POND-PATH`  
**Official:** Silas Dace  
**Rod rental:** 3 zm  
**Derby entry:** 5 zm

## Goal

Fishing is a real optional hobby and social activity, not `>FISH` followed by one random sentence.

The system is deliberately bounded to the Flathead Fair pond and related fishing authority. It does not create a universal ecosystem simulator for every water body in Zork.

## Core loop

A normal fishing attempt consists of understandable world actions:

1. obtain/use a rod and suitable line/tackle;
2. choose bait/lure where relevant;
3. choose a fishing position;
4. cast;
5. wait/watch/listen or otherwise let the attempt develop;
6. react to a bite or realize nothing is happening;
7. reel/land or lose the catch;
8. inspect, weigh, keep/release or otherwise handle the real result.

The parser may accept concise intent such as `FISH WITH WORMS` while still resolving the underlying authored state.

## Fishing positions

Do not multiply the fairground map just to create fishing coordinates. Positions are meaningful local contexts inside `FISHING-POND` / `POND-PATH`.

Initial positions:

- **open bank** — easiest casting, busiest during derby;
- **reed edge** — different common catch bias, more snag risk;
- **shaded bank** — quieter, changes with time of day;
- **pond-path bend** — lower crowd density, smaller casting lane, useful for social/quiet fishing.

Silas can explain the obvious differences without giving a probability table.

## Inputs that may matter

- bait/lure class;
- rod/line class;
- chosen bank position;
- fair day phase;
- authored weather state;
- whether the player is in a derby attempt;
- prior disturbance/snags at that position where tracked;
- bounded catch table for the current fair/day.

The player's relationship status does not secretly alter fish probability. 😂

## Initial bait/tackle families

- basic live/natural bait portion — 1 zm;
- bread/dough-type bait where product design supports it;
- specialty bait — 2–4 zm;
- simple hook/lure — 3–8 zm;
- rented rod — 3 zm;
- owned basic/general/fine rods per `FAIR_PRICE_BOOK.md`.

Better gear changes reliability/affordances; it does not simply add `+20 FISH`.

Examples:

- sturdier line may prevent losing a heavy fish;
- a lure may bias toward a species family;
- a cheap rod may be perfectly good for common fish;
- a fine rod cannot force the rarest catch to exist.

## Authored fish families

Names below are Highly Extended working species, not claims of original Infocom canon. Final wording can be revised during lore/prose pass.

### Common

- **reed perch** — small/common pond fish;
- **silver minnow** — often tiny, sometimes useful as bait only where rules permit;
- **pond carp** — common but size-variable;
- **mudcat** — bottom-feeding, stronger pull than its appearance suggests.

### Uncommon

- **blueback trout** — cooler/shaded-water bias;
- **redfin bream** — more sensitive to bait/position;
- **old pond carp** — larger age/weight band rather than a supernatural species.

### Record-class

Record fish are exceptional size instances of real species, not `LEGENDARY FISH` objects spawned from nowhere.

A record catch retains:

- species;
- measured weight/length where the system uses them;
- angler;
- fair/date identity when calendar authority exists;
- whether the fish was released/kept according to fair rules.

## Junk and non-fish catches

Fishing should occasionally recover real objects:

- old boot;
- bent spoon;
- damaged cup;
- lost ribbon;
- snagged bit of line;
- small purse/key/token only when tied to an authored incident;
- odd but mundane debris.

Junk is not generated filler. Each recoverable object has a concrete identity and disposition.

## Strange catch budget

Very rare catches may be weird, but remain authored.

Initial design permits a **small number** of anomalies such as:

- an old stamped fair token from an era Ada cannot immediately reconcile;
- a sealed tiny object/container whose presence in the pond has a discoverable history;
- something the player initially mistakes for an impossible creature but which has a physical explanation;
- one genuinely unresolved object if the broader Zork-weird authority supports leaving it unresolved.

No random eldritch-fish generator.

## Catch outcome structure

Fishing uncertainty is split conceptually into:

1. **eligibility** — what could plausibly be caught with current bait/position/phase/weather;
2. **selection** — controlled RNG chooses among the eligible authored results;
3. **landing** — equipment/state and player response determine whether the hooked result is actually landed;
4. **measurement/history** — size/record facts become persistent only after the real catch exists.

This prevents a single hidden roll from deciding everything.

Exact save/restore seed semantics remain owned by `FAIR_RNG_CONTRACT.md`.

## Fishing questions

Silas should support useful semantic questions such as:

- what fish are in here?
- what bait should I use?
- where should I fish?
- does weather matter?
- what's the current record?
- how do I enter the derby?
- can I rent a rod?
- what did I catch?
- does this count?
- can I weigh this?

He gives practical advice, not exact internal weights/probabilities.

Other anglers know what they have personally learned and may disagree.

## Derby

### Entry

- fee: **5 zm**;
- entry occurs before the featured afternoon weigh-in window;
- watching is free;
- entering is optional;
- Mara may enter separately and pays/qualifies through her own state when money authority supports it.

### Core contest

The initial derby measures **best eligible single fish by weight** during the derby window.

Rules:

- fish must come from the fair pond during the active derby period;
- Silas or authorized weigh-in staff must inspect the real catch;
- junk objects do not count no matter how heavy the boot is;
- ties use an authored secondary rule such as earlier verified catch rather than a secret reroll;
- a player may continue fishing after submitting a fish and replace their own best with a heavier verified catch.

### Results

Awards may include:

- ribbon;
- record entry;
- direct prize;
- modest tickets where appropriate;
- reputation/dialogue/memory.

Do not turn the derby into a mandatory ticket farm.

### Mara

Mara can fish independently, submit her own catch and **beat the Adventurer**.

Her participation should support:

- teasing/competition;
- helping only when she actually chooses to;
- comparing catches;
- separate knowledge/preferences;
- shared memory of absurd or impressive results.

No outcome is rigged to make the player win for romance reasons.

## Fish handling and physicality

A landed fish is a real object/event state.

Supported decisions may include:

- examine;
- weigh;
- show to Silas/Mara/another angler;
- keep temporarily where rules permit;
- release where alive/appropriate;
- lose/drop according to broader object authority.

The design should not require detailed cruelty/injury simulation. The pond/fair can have simple handling rules appropriate to the event.

## Records

Ada Vellum's records authority may store significant derby/pond records after Silas verifies them.

Persist:

- record holder;
- species;
- verified measurement;
- fair-year identity only when calendar authority supports it;
- later record replacement history if useful.

Do not persist every minnow ever caught.

## Social fishing

Fishing also exists when no contest is active.

The player can:

- fish beside Mara;
- ask Silas/anglers questions;
- talk while waiting;
- watch another angler;
- walk the Pond Path;
- abandon fishing without punishment;
- simply sit by the water where broader parser/social authority supports it.

This is one of the fair's intentional low-intensity activities.

## Weather/time composition

- morning/late morning can have different fish eligibility than hot/crowded midday;
- rain may improve some fishing while making the bank unpleasant;
- severe weather can suspend derby operation for visible safety reasons;
- dusk closes official rental/weigh-in before the pond itself ceases to exist as a place.

No weather state makes a required canonical object depend on catching a fish.

## Qualification targets

Future natural-play qualification should include:

1. rent or use a rod;
2. ask Silas for advice;
3. fish two different positions/baits and observe meaningful difference;
4. catch an ordinary fish;
5. catch junk in a deterministic test route;
6. weigh a derby-eligible fish;
7. verify record logic;
8. show that Mara can independently enter/compete where supported;
9. prove save/RNG behavior is intentional;
10. prove no rare catch is required for canonical progression.

## Boundaries

- No universal fish ecology engine.
- No `BEST ROD = BEST FISH` ladder.
- No rare RNG gate for romance/canonical progress.
- No generated species/prose.
- No inventory duplication when a fish is weighed/released.
