# Flathead Fair NPC roster

**Status:** STABLE FOR INITIAL CORE PLANNING  
**Initial core roster:** 12 named characters  
**Daily schedule authority:** `FAIR_DAILY_OPERATIONS.md`

## Population model

Use two layers:

1. **authored crowd population** for scale, motion, sound, incidental reactions, families, couples, children and background activity;
2. **named NPCs** for persistent schedules, knowledge, inventory, motives, dialogue, quests, relationships and repeat visits.

Long-term target remains roughly **15–25 substantial named fair NPCs**, but the first implementation should not require all of them.

Named people are not permanently nailed behind counters. Their day-phase locations are now defined in `FAIR_DAILY_OPERATIONS.md`.

## Core roster

### 1. Berrin Vale — fair steward

**Primary spaces:** Fair Entrance, Central Midway, Grand Pavilion, Prize & Records Hall, Back Lane.

**Role:** senior on-site representative of the Flathead Fair Association; practical grounds manager rather than monarch of the fair.

Knows grounds layout, concession assignments, daily schedule, reported ride shutdowns, association rules, complaints/incidents and broad fair history.

Does not automatically know secret recipes, exact fish behavior, every visitor's personal history, or faults nobody has reported.

Useful interactions: directions, complaints, lost-property escalation, weather closures, vendor disputes, historical questions and larger incidents.

### 2. Ada Vellum — records and fair-office clerk

**Primary spaces:** Prize & Records Hall; Grand Pavilion when an official result/event requires her.

**Role:** keeper of records, old programs, contest entries, permits, ribbons, lost-and-found paperwork and the documents nobody else wants to organize.

Knows past winners/records held by the office, schedules/programs, concession paperwork, lost-and-found intake, official history wording and prize/contest procedure.

Personality direction: dry, precise and capable of noticing when Frobozz promotional language has quietly rewritten the archive.

Long-term value: one of the strongest anchors for annual continuity.

### 3. Mabel Rusk — elephant-ear concessioner

**Primary spaces:** Food Row; Back Lane during setup/cleanup and one authored break.

**Role:** independent recurring owner/operator of the fair's signature elephant-ear stall.

Primary products:

- plain elephant ear — 4 zm;
- cinnamon-sugar — 5 zm;
- apple-topped — 6 zm;
- honey-nut — 7 zm;
- oversized sharing version — 12 zm;
- Frobozz-deluxe product only if the commercial arrangement makes sense.

Knows ingredients, preparation, frying condition, prices, serving sizes, ingredient warnings, sales patterns and preferences she has actually learned.

Mabel should answer an unreasonable number of reasonable elephant-ear questions without sounding like a database.

### 4. Tomas Quince — cold-drink seller

**Primary spaces:** Food Row; Back Lane during setup/cleanup.

**Role:** proprietor/operator of the drink stand used for the first product-identification acceptance case.

Primary known product:

- initial presentation: `large drink`;
- actual identity: **pear-lime fizz**;
- price: **4 zm**;
- ordinary flavor answer: **“Pear and lime. Mostly pear.”**

Also sells simple drinks and souvenir fair mugs/refills.

Knows his recipes, ingredients, stock, prices, cup sizes and freshness. He does not know whether Mara likes something until she has actually expressed/demonstrated a preference he could know about.

### 5. Silas Dace — fishing master and weigh-in official

**Primary spaces:** Fishing Pond; Grand Pavilion / Prize & Records Hall only when derby judging/results require it; Pond Path when off duty and still present.

Knows pond rules, common fish, bait/lure advice, weigh-in procedure, current derby records, relevant weather/time conditions and which anglers habitually exaggerate.

Does not reveal rare-catch tables as a walkthrough.

Silas can be a friendly rival/mentor without becoming a fishing-stat dispenser.

### 6. Nell Harrow — prize counter clerk

**Primary space:** Prize & Records Hall.

Knows current prize stock, exact ticket costs, sold-out items, annual variants, valid ticket sources and obvious counterfeits.

Potential comedy: professionally immune to arguments that 39 tickets are “basically 40.”

Her counter stays open later than most game booths during closing so recently earned tickets are not stranded by schedule design.

### 7. Emery Wicks — observation-wheel operator

**Primary spaces:** Observation Wheel; Back Lane after shutdown or during substantial repair.

Knows fare/boarding rules, carriage state, operating schedule, ordinary mechanical noises, wind/weather limits and whether a temporary stop is routine or unusual.

Does **not** know private conversations inside closed carriages merely because he operates the wheel.

### 8. Tilda Fen — Ride Court operator

**Primary spaces:** Ride Court; Back Lane during setup/repair/shutdown.

Responsible for carousel and smaller Ride Court machinery.

Knows carousel figures, ride rules, operating state, basic maintenance symptoms, which mount children fight over and which machinery is genuinely old versus merely painted old.

Tilda has actual opinions about Frobozz-made replacement parts.

### 9. Jonas Pell — honest midway game operator

**Primary space:** Games Row.

Runs a genuinely skill-based game and explains its rules plainly.

Design purposes:

- prove not every booth is a con;
- give a baseline against which suspicious games can later be compared;
- let improved performance follow understandable mechanics.

Knows his rules, equipment, records, common mistakes and prize/ticket schedule.

### 10. Vera Tallow — curiosity merchant

**Primary spaces:** Market Row; Back Lane during setup/packing; occasionally Dance Pavilion as an off-duty visitor on selected evenings.

Deals in old mechanisms, odd tools, lenses, puzzle boxes, dubious antiquities, strange keys and objects that may be more or less interesting than advertised.

Knowledge rule: Vera distinguishes what she **knows**, what she **suspects**, and what someone **claimed to her**. She may be wrong. She is not a supernatural identification oracle.

Potential signature stock includes the crooked brass compass concept and other physically real curiosities.

### 11. Orin Bell — musician and dance-pavilion bandleader

**Primary spaces:** Grand Pavilion during daytime program/rehearsal; Dance Pavilion at dusk/evening; Back Lane while arriving/packing.

Knows performance schedule, repertoire, musicians, dance customs he has observed, recurring attendees he recognizes and practical pavilion gossip.

He can take song requests where repertoire supports it and may remember a couple's recurring song without becoming a global romance database.

### 12. Ephraim Peake — elderly recurring fairgoer

**Primary route:** Entrance/Food Row -> Grand/Market -> Exhibition/Pond Path -> Central/wheel vicinity -> Dance Pavilion/stroll, varying by day and events.

He is a visitor, not staff.

Knows his own memories of earlier fairs, old prices, former vendors/attractions he remembers, local stories and his present likes/dislikes.

He is deliberately **not always objectively correct**. His value is lived continuity.

Expected opinions include:

- elephant ears used to cost two zorkmids;
- a ride was better before somebody “improved” it;
- an old concession stood somewhere else;
- an official pamphlet has the date wrong, according to him.

## Knowledge-boundary law

Every named NPC ultimately has a compact authority table covering:

- job knowledge;
- witnessed/observed knowledge;
- personal-history knowledge;
- beliefs/hearsay;
- explicit unknowns;
- things they will not discuss even when known.

This prevents generic responses without pretending every NPC is an infinite conversational model.

## Schedule law

The core schedule is now locked for planning in `FAIR_DAILY_OPERATIONS.md` across:

- PREOPEN;
- OPENING;
- LATE-MORNING;
- MIDDAY;
- AFTERNOON;
- DUSK;
- EVENING;
- CLOSING;
- AFTER-HOURS.

Not every NPC wanders every turn. A schedule changes the character's authored location/state at meaningful phase boundaries and may include visible movement through adjacent fair geography.

### Breaks

A worker may take an authored break. The world explains it with a sign, neighboring NPC, visible movement or a stated return condition. Paid interactions do not accept money while the responsible service is unavailable.

Breaks are valuable because they let the player meet a vendor as a person somewhere other than behind a counter.

## Weather schedule override

Named operators respond according to expertise:

- Emery controls wheel suspension for wind;
- Tilda controls Ride Court machinery;
- Silas controls fishing/derby guidance;
- Berrin coordinates serious grounds response;
- vendors protect/close their own stock according to conditions.

No omniscient global weather puppeteer replaces character decisions.

## Mara relation

Mara may independently know, like, dislike, remember or form opinions about these people. A vendor can remember Mara separately from remembering the Adventurer where events justify it.

Mara is not given a fixed fair-worker schedule. Her movement comes from current companionship, independent choices, preferences, crowd tolerance, hunger/tiredness, activities and relationship state.

The fair should not model every NPC primarily as a conduit for the Adventurer/Mara relationship.

## Still-missing long-term roles

Later additions remain valuable:

- dubious/possibly rigged game operator;
- repair/maintenance specialist;
- dedicated artisan/craft seller;
- child/family characters for mundane stories;
- recurring couple(s) whose own relationship changes;
- fair safety/constable role only if genuinely needed;
- rival anglers beyond Silas's official role;
- transient vendors appearing only in selected years.

## Roster law

Do not create dozens of interchangeable names. A named NPC exists because they have knowledge, behavior, continuity or a useful story role.
