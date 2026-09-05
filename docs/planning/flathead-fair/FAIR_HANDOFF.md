# Flathead Fair planning handoff

**Purpose:** clean continuation receipt for the next GitHub-enabled planning chat  
**Scope:** Flathead Fair product planning only  
**Implementation:** NOT AUTHORIZED  
**Repository:** `acrinym/zork1`  
**Planning branch:** `planning/flathead-fair-product-bible`  
**Draft PR:** #100 — `Plan the Flathead Fair as a recurring parser-first world organ`

## FIRST RULE: RE-QUERY LIVE GITHUB

Live GitHub always wins over this handoff.

Before changing anything:

- re-read current `master`;
- re-read PR #100 and its current head;
- re-query all open Zork PRs;
- re-read `FAIR_PLANNING_INDEX.md`;
- re-read `FAIR_OPEN_QUESTIONS.md`;
- re-read any authority document that owns the next decision before editing it;
- do not assume any SHA, PR state, workflow result or branch state remains unchanged;
- do not rebuild planning already captured here;
- do not start an implementation train merely because the plan is large;
- do not merge anything without Justin's fresh explicit merge whistle.

## Live frontier when this receipt was prepared

Current `master` at handoff preparation:

`767364f6b1de5ff45278f8f0d66508524e3f9b19`

Tip message:

`Catalog post-1306 text-only organs, including a CYOA presentation over the live parser. No GUI. Ideas only. Mark 1306 complete on master after PR #97.`

PR #100 immediately before this handoff receipt commit:

- state: open;
- draft: true;
- mergeable: true;
- head branch: `planning/flathead-fair-product-bible`;
- pre-receipt head: `b13835b16c27a7ccbfde5f0917279b862e69c895`;
- base: `master`;
- base SHA: `767364f6b1de5ff45278f8f0d66508524e3f9b19`;
- 44 commits before this receipt;
- 27 changed files before this receipt.

This receipt commit itself moves the branch head. Re-query PR #100 rather than treating `b13835b...` as current.

Other open independent draft PRs at handoff preparation:

- PR #99 — `Release 1307: authored time, weather and disaster arc`
  - branch: `agent/1307-authored-weather-disaster`
  - head: `ce22b636bcb08d08a88c31bc4ccca680c6a97427`
  - independent of fair planning; do not stack fair planning on it.
- PR #98 — `Release 1309: wardrobe, property, autonomy and lived Mara boundaries`
  - branch: `agent/1309-boundary-rupture-continuity`
  - head: `8784e0b2c89eeb13c5acf23cf220aded13aa4b1b`
  - independent of fair planning; do not stack fair planning on it.

## The product idea

The Flathead Fair is a recurring, parser-first recreational world organ inspired only by the **structural lesson** of Chrono Trigger's Guardia/Millennial Fair: a fair can be a small optional game-world nested inside a larger adventure.

The actual content must be original Zork/Highly Extended material.

North star:

> A place where the Adventurer can go because they want to be there rather than because something must be solved.

The fair should support ten minutes of incidental wandering or an entire in-world day. It should reward curiosity with food, rides, games, shopping, fishing, performances, conversation, tiny stories, records, social memories, rare incidents, and repeat visits.

It is a **place**, not a menu of minigames.

## Stable product identity

- Public/common name: **The Flathead Fair**.
- Canonical naming anchor: the **Flathead Mountains** visible from `CANYON-VIEW`.
- Authored Highly Extended lore: older regional trade/craft/produce/livestock/exhibition gathering that accumulated food, music, games and mechanical amusements over time.
- Governance: older regional fair association plus later Frobozz sponsorship/concessions; not an all-Frobozz corporate monoculture.
- Recurrence in world fiction: **annual**.
- Do not fake annual recurrence with a standalone `YEAR++` counter before broader calendar/aging authority exists.
- General grounds admission: **free**.
- Ordinary commerce: **zorkmids (`zm`)**.
- Prize tickets: earned redemption currency only; not ordinary money and not convertible back to zorkmids.
- Original Zork I treasure `VALUE/TVALUE`: score/treasure semantics, **not** a zorkmid exchange rate.
- Signature food: elephant ears.
- Cinnamon-sugar elephant ear baseline: **5 zm**.
- First partial-identification product acceptance case: `large drink` = **pear-lime fizz**, **4 zm**.
- Product identity and player knowledge are separate state.

## Geography

Selected attachment is locked for planning:

**new northeast spur from canonical `CLEARING`**.

Canonical `CLEARING` already uses west/east/north/south. Northeast is additive and avoids destroying explicit forest/canyon barriers.

Conceptual seam:

```text
EAST-OF-HOUSE -- CLEARING -- CANYON-VIEW
                    |
                   NE
                    |
                FAIR-ROAD
                    |
              FAIR-ENTRANCE
                    |
              FAIRGROUNDS...
```

Existing House/Clearing/Canyon routes and barriers remain authoritative.

The fairground is real year-round meadow/field geography. It does not vanish off-season.

Initial major fairground graph is **16 dense locations** with multiple pedestrian loops rather than hub-and-dead-end spokes:

1. Fair Road
2. Fair Entrance
3. Central Midway
4. Food Row
5. Games Row
6. Market Row
7. Grand Pavilion
8. Dance Pavilion
9. Ride Court
10. Observation Wheel
11. House of Mirrors
12. Fishing Pond
13. Pond Path
14. Exhibition Yard
15. **Fair Office & Prize Hall**
16. Back Lane

House of Mirrors has a planned five-node internal sub-map but remains one major fairground destination on the exterior graph.

Every major location should support at least three meaningful interaction families. No empty transit acreage.

## Daily lifecycle

One operating fair day uses nine semantic phases:

1. `PREOPEN`
2. `OPENING`
3. `LATE-MORNING`
4. `MIDDAY`
5. `AFTERNOON`
6. `DUSK`
7. `EVENING`
8. `CLOSING`
9. `AFTER-HOURS`

These are authored world phases, not imported modern clock hours.

Closing is sequential rather than one global shutdown tick:

- long attractions stop admitting new customers;
- games stop opening featured attempts;
- Market Row closes in stages;
- fishing rental/weigh-in ends;
- daytime food reduces toward late vendors;
- active ride cycles finish safely;
- Fair Office & Prize Hall gives final redemption call;
- Dance Pavilion ends its final piece;
- visitors drain toward Fair Entrance/Fair Road;
- Back Lane and current-office closeout remain active for workers.

No paid rider is dumped out, no NPC vanishes on one magic tick, and no closure may strand the player.

## Economy and products

General fair entry is free so a broke Adventurer can still walk, talk, watch, smell food, accompany Mara and experience the grounds.

Everyday authored purchasing-power bands are defined in the price authorities.

Representative locked prices include:

- plain elephant ear: 4 zm;
- cinnamon-sugar elephant ear: 5 zm;
- apple-topped elephant ear: 6 zm;
- honey-nut elephant ear: 7 zm;
- oversized sharing elephant ear: 12 zm;
- pear-lime fizz: 4 zm;
- carousel: 2 zm;
- flying chairs: 2 zm;
- observation wheel: 3 zm;
- House of Mirrors: 3 zm;
- Scenic GUE ride: 3 zm;
- rod rental: 3 zm;
- fishing derby entry: 5 zm.

Products are parser-real objects where practical.

A generic-looking description such as `large drink` can reflect incomplete **player knowledge**, not a generic world object. Seller, Mara, stranger and Adventurer can know different facts about the same physical product.

No global shop UI should erase vendors, geography and conversation.

## Core attractions

### Observation Wheel

- real boarding/ascent/top/descent/unload sequence;
- changes by daylight, dusk, evening and weather;
- scenic observation of supported geography;
- social/private carriage context because of actual physical context, not a romance flag;
- Emery Wicks can suspend boarding for unsafe wind;
- refund/credit policy applies when the fair accepts payment and then cannot provide the unused service.

### Carousel

Initial Zork-native carved mount working set includes grue, cyclops, dragon, sea serpent, unicorn, giant songbird and another regional/absurd beast to finalize.

Mount choice can affect prose, Mara preference and memory, not RPG stats.

### Flying Chairs / Swing Ride

- motion and wind are the point;
- more wind-sensitive than carousel;
- loose-object consequences must preserve real identity/recoverability rather than deleting items.

### Scenic Great Underground Empire Ride

A deliberately sanitized/corporate/tourist version of GUE history that may contradict what the Adventurer has actually experienced.

Possible scenes include White House, forest frontier, Flood Control Dam #3, Aragain Falls/Frigid River, imperial commerce and Flathead-region material.

Falsehoods remain attributed to the exhibit/author. The ride does not silently rewrite objective lore.

### House of Mirrors

Five planned internal nodes:

1. Mirror Foyer
2. Crooked Gallery
3. Repeating Passage
4. Crossed Reflections
5. Exit Gallery

Supported semantic interactions should include looking into/examining/touching/knocking on mirrors, waving/smiling/turning away/following a reflection, showing or holding objects before mirrors, asking Mara, and routing attempted damage through real destruction/social consequence authority.

Most mirrors are mundane optical effects. Rare anomalies are a **small authored stateful set**, not generated horror prose.

Example anomaly: a reflection lags one action behind once.

The maze must remain learnable and escapable.

## Games Row

Initial eight mechanically distinct activities:

1. Jonas Pell's Ring Stand
2. Bottle Knockdown
3. Flathead Bell Striker
4. Clockwork Target Gallery
5. Horseshoes / Ringed Stakes
6. What's Missing? Memory Table
7. Shell / Cup Game
8. Clockwork Critter Race / Fair Race Board

Mechanics deliberately mix observation, learnable physical behavior, deterministic cycles, bounded chance, memory and investigation.

Do not implement one RNG roll under eight different signs.

Ticket economy rewards variety and accomplishments more than repetitive farming.

A rigged booth is legitimate only if the rigging physically exists and can be investigated. Hidden author cheating is prohibited.

No Gato fight. Still. 🤣

## Fishing

Fishing is a real optional hobby/social loop, not one `FISH` random sentence.

Core sequence:

- rod/tackle;
- bait/lure;
- choose position;
- cast;
- wait/watch/listen;
- react to bite;
- reel/land or lose;
- inspect/weigh/keep/release/handle result.

Initial positions:

- open bank;
- reed edge;
- shaded bank;
- pond-path bend.

Working authored fish families:

Common:
- reed perch;
- silver minnow;
- pond carp;
- mudcat.

Uncommon:
- blueback trout;
- redfin bream;
- old pond carp.

Record fish are exceptional size instances of real species, not randomly spawned `LEGENDARY FISH` objects.

Junk/odd catches are real authored objects. A rare old stamped fair token is already connected to the historical story web.

Derby:

- 5 zm entry;
- best eligible single fish by verified weight;
- Silas verifies real catch;
- ties use an authored secondary rule, not secret reroll;
- Mara can independently enter, submit a fish and beat the Adventurer.

Current fishing records begin at the Fair Office after Silas verification. Historically meaningful annual summaries/standing records may later graduate upstairs into the existing House of Records.

## Named NPC core roster

Initial core roster: **12 named NPCs**.

1. **Berrin Vale** — fair steward / association on-site authority.
2. **Ada Vellum** — current fair registrar / office clerk.
3. **Mabel Rusk** — elephant-ear concessioner.
4. **Tomas Quince** — cold-drink seller / pear-lime fizz.
5. **Silas Dace** — fishing master / weigh-in official.
6. **Nell Harrow** — prize counter clerk.
7. **Emery Wicks** — observation-wheel operator.
8. **Tilda Fen** — Ride Court operator.
9. **Jonas Pell** — honest midway game operator.
10. **Vera Tallow** — curiosity merchant.
11. **Orin Bell** — musician / Dance Pavilion bandleader.
12. **Ephraim Peake** — elderly recurring fairgoer / lived-history source.

Long-term target remains roughly 15–25 substantial named fair NPCs, not hundreds of shallow actors.

Every named NPC should have bounded job knowledge, witnessed knowledge, personal history, beliefs/hearsay, explicit unknowns and private topics.

The existence of the House of Records does not make anyone omniscient.

## Secondary cast still needed

Highest-priority missing roles:

- dubious/suspicious shell-game operator;
- repair/maintenance specialist;
- dedicated artisan/craft seller;
- child/family characters for mundane fair stories;
- recurring couple(s) with their own continuity;
- rival angler(s) beyond Silas's official role;
- possible safety/constable role only if genuinely useful;
- transient vendors appearing only in selected fairs/years.

This is the next recommended planning pass.

## Mara

The fair should become one of the richest places for the Adventurer and Mara to simply **live together for a while**.

There is no `DATE MODE`.

Mara may:

- suggest/refuse attractions;
- ask to return to something she likes;
- buy food/merchandise for herself;
- buy a gift;
- wander toward an attraction/vendor;
- fish or enter a contest independently;
- beat the Adventurer;
- get hungry, amused, bored, tired, annoyed, excited or curious;
- initiate dancing/affection when broader relationship/context authority supports it;
- remember prior fair experiences.

Potential shared memory anchors include first fair, first wheel ride, first dance, ridiculous game failure, fish/record, storm/rain, staying until closing, gifts and the objectively serious historical dispute over who ate most of an elephant ear. 😂

These are **personal lived memories**. They do not automatically become Fair Office or House of Records material.

A public derby result can be documented. The private feelings/conversation around it remain private.

## Adult social life

The fair is not exclusively a children's attraction.

It supports:

- dating;
- dancing;
- flirting;
- affection;
- couples;
- quiet conversations;
- proposals;
- arguments/reconciliation;
- established relationships;
- leaving together for a more private location where broader authority supports it.

Useful privacy gradient comes from actual geography/crowds/time:

- crowded Midway;
- Dance Pavilion;
- evening food/drink venue;
- observation-wheel carriage;
- Pond Path;
- edge of performances;
- nearly empty closing grounds.

No `ROMANTIC-ROOM` flag and no fair-specific intimacy minigame.

The exact evening adult food/drink service identity in/near Dance Pavilion remains open.

## First story web

Nine initial interconnected miniquests/incidents are planned:

### F-01 — The Crate That Went to the Wrong Fair
Mabel's supply crate was misdelivered. Mundane physical-object/help story; fair operations eventually resolve it if ignored.

### F-02 — Thirty-Nine Tickets
A young visitor has 39 tickets and wants a 40-ticket prize. Nell remains professionally immune to the proposition that 39 is “basically 40.”

### F-03 — Ephraim Says the Date Is Wrong
Historical/provenance investigation comparing Ephraim's lived memory, current Fair Office material, older House of Records documents, physical evidence and Frobozz claims.

### F-04 — The Shell Game Is Not Merely Difficult
Physical evidence can prove or fail to prove cheating. Current incident intake begins through the Fair Office; an adjudicated significant report may later become archive material.

### F-05 — A Reflection That Is Late
Rare authored House-of-Mirrors anomaly. A report is a claim, not automatic proof.

### F-06 — Lost Purse, Actual Owner
Real purse, real contents, plausible claimant knowledge, current lost-and-found. Routine case does not become eternal archive history.

### F-07 — Orin's Missing Sheet
Wind/weather displaces a real music sheet/set note; the band can still perform a substitute if the player does nothing.

### F-08 — Wheel Closed for Wind
Operational fairness/refund incident proving machinery is run by adults with visible safety rules.

### F-09 — The Pond Gives Back Something Old
Rare old stamped token ties fishing to provenance research. It can be shown to Silas/Ada/Ephraim/Vera and cross-referenced against older House of Records material while remaining the same physical object.

No universal quest log is required. Stories are discovered by noticing, asking, finding, entering or witnessing.

The fair continues living when the player walks away.

## Hall / House of Records integration

This was a major late planning correction and is now stable.

Highly Extended Zork already has an upstairs/Attic archive family:

- `glulx/attic-archive-core/`;
- `glulx/attic-area-case-files/`;
- `glulx/attic-npc-dossiers/`;
- `glulx/attic-playback/`;
- `glulx/completed-expedition-archive/`, explicitly the House of Records capstone.

The fair MUST compose this authority rather than creating a second historical archive.

### Three record layers

1. **Fair Office & Prize Hall** — current operational paperwork:
   - current program/schedule;
   - current permits/concession roll;
   - current contest/derby entries/results;
   - current lost-and-found;
   - current incident/complaint intake;
   - current notices/maps.

2. **Existing upstairs Hall/House of Records** — selected durable documentary history:
   - old annual programs;
   - historical grounds maps;
   - major/standing records;
   - historical concession material;
   - attraction retirement/replacement;
   - significant adjudicated incident files;
   - other provenance-bearing historical evidence.

3. **Personal memory** — Mara/Adventurer/NPC lived experience.

These layers can refer to one another but do not collapse into one omniscient history store.

Existing archive concepts such as physical records, `FILE`, `REVIEW`, `SHOW`, `CROSSREF`, provenance, confidence/verification, contradiction and redaction should be reused where applicable rather than reinvented.

### Ada Vellum

Ada is the **current fair registrar**, not the master historical archivist.

She can tell the Adventurer that an older source exists upstairs and direct them there. She does not remotely summon an old file or replace the physical archive.

### Privacy boundary

The archive is not surveillance.

Do not automatically record:

- private Mara/Adventurer conversations;
- kisses/affection;
- private arguments;
- thoughts/preferences;
- every purchase;
- every NPC movement.

A public result, permit, formal report or documentary artifact may have an institutional record. A private lived moment remains memory.

The open-questions authority explicitly says: **do not reopen the question of creating a separate Fair Historical Archive.**

## RNG contract

Controlled randomness is desirable for optional fair life.

Allowed families include:

- fishing/catch selection from authored tables;
- race/contest outcomes where chance belongs;
- raffles;
- incidental crowd encounters;
- bounded performer order;
- rare vendor attendance/stock;
- minor incidents;
- fortunes;
- noncritical prize variation.

Forbidden random families include:

- canonical puzzle solvability;
- required exits;
- whether a necessary NPC ever appears;
- whether a mandatory object exists;
- arbitrary irreversible catastrophe;
- Mara's fundamental personality/preferences;
- relationship success;
- generated dialogue/world lore.

Preferred direction: coherent **fair-day/event seeds** for outcomes that should feel as if they existed before the player looked.

Exact ZIL/interpreter save/restore semantics remain unresolved and are a high-priority next planning decision.

## Time/weather dependency

The fair should compose Release 1307's authored time/weather authority once that authority is stable/merged enough to consume.

Weather can affect:

- attendance;
- fishing;
- ride operation;
- wind-sensitive rides;
- vendor covers;
- mud/puddles;
- food demand;
- performance relocation/cancellation;
- lighting/night visibility;
- Mara/NPC reactions.

Rain must not simply mean `FAIR CANCELLED`. The fair changes shape under rain.

Severe weather uses authored safety response, never arbitrary disaster roulette.

Do not merge or stack PR #99 merely to satisfy this future dependency.

## Documentation authority map

The planning packet currently includes these focused authorities:

- `FAIR_PRODUCT_BIBLE.md` — north star/product identity/boundaries.
- `FAIR_NAME_AND_LORE.md` — public name, regional origin, governance/Frobozz relationship.
- `FAIR_SITE_SELECTION.md` — canonical map evidence and selected attachment seam.
- `FAIR_GEOGRAPHY.md` — 16-location graph and movement/privacy/service topology.
- `FAIR_DAILY_OPERATIONS.md` — phase-by-phase operation, schedules, closing/after-hours.
- `FAIR_TIME_SCHEDULE_AND_SEASON.md` — recurrence and semantic lifecycle.
- `FAIR_PRODUCTS_AND_ZORKMID_ECONOMY.md` — purchasing power/free admission/currency law.
- `FAIR_PRICE_BOOK.md` — concrete initial prices/redemption bands.
- `FAIR_PRODUCT_KNOWLEDGE_AND_QUESTIONS.md` — partial identification/contextual questions.
- `FAIR_VENDOR_AND_COMMERCE_DESIGN.md` — merchant seams/stock/payment/refund behavior.
- `FAIR_ATTRACTIONS_CATALOG.md` — rides/destination attractions.
- `FAIR_GAMES_COMPETITIONS_AND_RECORDS.md` — Games Row/tickets/current records.
- `FAIR_FISHING.md` — fishing hobby/derby/record seam.
- `FAIR_RNG_CONTRACT.md` — controlled randomness/save questions.
- `FAIR_NPC_ROSTER.md` — named cast/roles/schedules/knowledge boundaries.
- `FAIR_DIALOGUE_AND_CONTEXTUAL_KNOWLEDGE.md` — bounded meaningful NPC knowledge.
- `FAIR_MARA_EXPERIENCE.md` — Mara agency/preferences/memory/privacy boundary.
- `FAIR_ADULT_SOCIAL_ROMANCE_AND_INTIMACY.md` — adult social/relationship context.
- `FAIR_FOOD_AND_CONCESSIONS.md` — food/drink/signature products.
- `FAIR_MINIQUESTS_INCIDENTS_AND_RUMORS.md` — first nine-story web/evidence model.
- `FAIR_REWARDS_PRIZES_AND_COLLECTIBLES.md` — tickets/prizes/annual objects.
- `FAIR_PERSISTENCE_AND_MEMORY.md` — current/documentary/personal persistence layers.
- `FAIR_HALL_OF_RECORDS_INTEGRATION.md` — explicit reuse of existing archive/provenance/privacy.
- `FAIR_WEATHER_AND_ENVIRONMENT.md` — future 1307 composition.
- `FAIR_NATURAL_PLAY_ACCEPTANCE.md` — future qualification contract.
- `FAIR_OPEN_QUESTIONS.md` — intentionally unresolved decisions.
- `FAIR_PLANNING_INDEX.md` — authority map/frontier.
- `FAIR_HANDOFF.md` — this continuation receipt; not a competing design authority.

When two planning documents disagree, resolve the contradiction by editing the owning authority, then update the index/handoff. Do not treat the handoff as higher authority than the focused document.

## Important stable boundaries

Do NOT:

- start an implementation train yet;
- create a duplicate fair historical archive;
- create a generic Carnival/Fair framework intended to generate arbitrary fairs;
- add GUI attraction/shop/quest interfaces;
- generate arbitrary NPCs, quests, species, dialogue or lore;
- reproduce Chrono Trigger characters, story beats, map, exact minigames or Gato;
- require fair participation for canonical Zork completion;
- block existing House/Clearing/Canyon routes;
- gate required progress behind RNG;
- turn Mara into a romance vending machine;
- create `DATE MODE`, `ROMANTIC-ROOM` or a fair-only intimacy system;
- turn every current office note into permanent archive history;
- let the archive know private life automatically;
- make every named NPC omniscient;
- turn the fair into 200 shallow NPCs or empty acreage;
- treat ticket grinding as the product.

## Current planning frontier

The fair is now far beyond an idea list. Identity, geography, economy, products, daily operation, core cast, major attractions, games, fishing, first story web, persistence layers, House of Records integration and major natural-play constraints all exist as documents.

The next planning pass should **not** widen scope indiscriminately. Tighten the existing world.

Recommended sequence:

### 1. Secondary cast

Name and bind:

- dubious shell-game operator;
- repair/maintenance specialist;
- artisan/craft seller;
- child/family characters needed by F-02/F-06 and ordinary fair life;
- recurring couple(s) with their own continuity;
- rival angler(s).

Give each a real location, schedule, knowledge boundary, motive and relationship to existing stories/systems.

### 2. Mara experience tightening

Bind Mara's concrete preferences/initiative/refusal/memory to the actual attraction/game/fishing/food roster now that those systems exist.

Do not make her preferences random or optimize them around pleasing the player.

### 3. Adult evening venue

Lock the exact public identity/product/service of the adult evening food/drink/social seam in/near Dance Pavilion, while leaving broader intimacy/consent authority sovereign.

### 4. RNG/save semantics

Resolve fair-day/event seed behavior against actual ZIL/interpreter save/restore semantics far enough that future qualification can state intentional behavior.

### 5. Prize/record archival graduation

Tighten which current game/fishing/exhibition results are merely current Fair Office records versus which annual summaries/standing records qualify for durable House of Records filing.

Do not create another archive.

### 6. Re-evaluate implementation gate

Only after the load-bearing documents are coherent should a future chat decide whether planning is stable enough to decompose the fair into implementation trains/beads.

Justin explicitly requested **plan first, do not jump straight into train**. Preserve that instruction until he changes it.

## Implementation-gate reminder

Planning may grow; code must not outrun authority.

Before any implementation train is authorized, at minimum ensure explicit stable decisions exist for:

- Product Bible;
- Name/Lore;
- Geography;
- Products/Economy;
- Product Knowledge;
- Mara Experience;
- Adult Social;
- RNG;
- Persistence;
- Hall/House of Records integration;
- Natural-Play acceptance.

Even then, implementation requires Justin to actually authorize starting it.

## Merge rule

PR #100 is a planning PR and remained draft at handoff preparation.

**Do not merge PR #100, PR #99, PR #98 or anything else without a fresh explicit Justin merge whistle after re-querying live GitHub.**

## Suggested first action in next chat

Re-query live GitHub, confirm PR #100/head/master/open-PR state, then continue **secondary cast + character/system tightening** from the focused authority docs.

Do not begin by re-explaining the entire fair. The plan is already in the repository. Read the authorities and continue from the frontier.
