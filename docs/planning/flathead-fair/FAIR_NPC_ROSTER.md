# Flathead Fair NPC roster

**Status:** DESIGNING  
**Initial core roster:** 12 named characters  
**Names:** working but intentionally concrete enough to design dialogue, schedules, and knowledge

## Population model

Use two layers:

1. **authored crowd population** for scale, motion, sound, incidental reactions, families, couples, children, and background activity;
2. **named NPCs** for persistent schedules, knowledge, inventory, motives, dialogue, quests, relationships, and repeat visits.

Long-term target remains roughly **15–25 substantial named fair NPCs**, but the first implementation should not require all of them.

## Core roster

### 1. Berrin Vale — fair steward

**Role:** senior on-site representative of the Flathead Fair Association; practical grounds manager rather than monarch of the fair.

Knows:

- grounds layout;
- concession assignments;
- daily schedule;
- opening/closing decisions;
- ride shutdowns reported to the office;
- association rules;
- complaints and incidents;
- broad fair history.

Does not automatically know:

- secret vendor recipes;
- exact fish behavior;
- every customer's personal history;
- hidden mechanical faults that have not been reported.

Useful interactions: directions, complaints, lost-property escalation, weather closures, vendor disputes, historical questions, larger incidents.

### 2. Ada Vellum — records and fair-office clerk

**Role:** keeper of records, old programs, contest entries, permits, ribbons, lost-and-found paperwork, and the kind of documents nobody else wants to organize.

Knows:

- past winners and records available to the office;
- fair schedules/programs;
- concession paperwork;
- lost-and-found intake;
- official histories and their wording;
- prize/contest procedures.

Personality direction: dry, precise, capable of identifying when Frobozz promotional language has quietly rewritten something in the archive.

Potential long-term value: one of the strongest anchors for annual continuity.

### 3. Mabel Rusk — elephant-ear concessioner

**Role:** independent recurring food vendor and owner/operator of the fair's signature elephant-ear stall.

Primary products:

- plain elephant ear — 4 zm;
- cinnamon-sugar — 5 zm;
- apple-topped — 6 zm;
- honey-nut — 7 zm;
- oversized sharing version — 12 zm;
- possible Frobozz-branded deluxe product only if commercial arrangement makes sense.

Knows:

- ingredients;
- preparation;
- oil/frying condition;
- price;
- serving sizes;
- ingredient warnings;
- what's selling well;
- regular-customer preferences she has actually learned.

Mabel should be able to answer an unreasonable number of reasonable elephant-ear questions without sounding like a database.

### 4. Tomas Quince — cold-drink seller

**Role:** proprietor/operator of the drink stand used for the first product-identification acceptance case.

Primary known product:

- initially describable as `large drink`;
- actual identity: **pear-lime fizz**;
- price: **4 zm**;
- ordinary flavor answer: **"Pear and lime. Mostly pear."**

Also sells simple drinks and souvenir fair mugs/refills.

Knows his recipes, ingredients, stock, prices, cup sizes, freshness, and which products customers keep asking for.

He does not know whether Mara likes a drink until she has actually expressed or demonstrated a preference he could know about.

### 5. Silas Dace — fishing master and weigh-in official

**Role:** pond authority, derby official, experienced angler, and keeper/judge of catches during competition.

Knows:

- pond rules;
- common fish;
- bait/lure advice;
- weigh-in procedure;
- current derby records;
- weather/time conditions relevant to fishing;
- which anglers habitually exaggerate.

Does not reveal every rare catch table as a walkthrough.

Silas can become a friendly rival/mentor figure without becoming a fishing-stat dispenser.

### 6. Nell Harrow — prize counter clerk

**Role:** runs the main prize counter and understands the fair's ticket redemption system.

Knows:

- current prize stock;
- exact ticket costs;
- sold-out items;
- annual prize variants;
- which booths issue valid tickets;
- obvious counterfeit/invalid tickets;
- when a child has been staring at the same stuffed grue for twenty minutes.

Potential comedy: professionally immune to people trying to argue that 39 tickets are "basically 40."

### 7. Emery Wicks — observation-wheel operator

**Role:** runs the wheel, boards riders, watches weather, and is responsible for deciding whether operation remains safe under authored conditions.

Knows:

- ride price and boarding rules;
- carriage state;
- operating schedule;
- ordinary mechanical noises;
- wind/weather limits relevant to the wheel;
- whether a temporary stop is routine or actually unusual.

Does not know intimate details of conversations inside closed carriages merely because he operates the ride.

### 8. Tilda Fen — Ride Court operator

**Role:** experienced amusement operator responsible for the carousel and/or smaller Ride Court machinery.

Knows:

- carousel figures;
- ride rules;
- operating state;
- basic maintenance symptoms;
- which mount children constantly fight over;
- which machinery is genuinely old versus merely painted to look old.

Tilda should have actual opinions about Frobozz-made replacement parts.

### 9. Jonas Pell — honest midway game operator

**Role:** runs one of the fair's genuinely skill-based games and explains the rules plainly.

Design purpose:

- establish that not every midway booth is a con;
- provide a baseline against which suspicious games can later be compared;
- give the player a place where improved performance follows understandable mechanics.

Knows his game's rules, equipment, records, common mistakes, and prize schedule.

### 10. Vera Tallow — curiosity merchant

**Role:** temporary/returning dealer in old mechanisms, odd tools, lenses, puzzle boxes, dubious antiquities, strange keys, and objects that may be more or less interesting than advertised.

Knowledge rule:

Vera knows what she knows, suspects what she suspects, and repeats provenance claims she has been told. Those are three different categories.

She may be wrong. She should not be a supernatural item-identification oracle.

Potential signature stock includes the crooked brass object/compass concept and other physically real curiosities.

### 11. Orin Bell — musician and dance-pavilion bandleader

**Role:** recurring performer who helps make the fair's evening social life an actual scheduled place rather than scenery.

Knows:

- performance schedule;
- songs/repertoire;
- other musicians;
- dance customs he has actually observed;
- recurring attendees he recognizes;
- practical gossip from being in the pavilion night after night.

He can take song requests where repertoire supports it and may remember a couple's recurring song without turning that into a global romance database.

### 12. Ephraim Peake — elderly recurring fairgoer

**Role:** long-time attendee who exists primarily as a visitor, not an employee.

Knows:

- his own memories of earlier fairs;
- old prices;
- former vendors/attractions he actually remembers;
- local stories and arguments about fair history;
- what he personally likes/dislikes now.

He is deliberately **not always objectively correct**. His value is lived continuity.

Expected lines of thought include things like:

- elephant ears used to cost two zorkmids;
- a ride was better before somebody "improved" it;
- an old concession stood somewhere else;
- the official pamphlet has the date wrong, according to him.

## Knowledge-boundary law

Every named NPC should eventually get a small authority table covering:

- what they know by job;
- what they know by observation;
- what they know from personal history;
- what they merely believe;
- what they do not know;
- what they will refuse to discuss even if they know it.

This is how the fair avoids generic responses without pretending every NPC is an LLM.

## Schedule law

Named NPCs do not stand at one coordinate forever.

At minimum, core staff/vendors need authored states for:

- before opening;
- working period;
- break/meal if relevant;
- evening or departure;
- closing;
- exceptional closure/weather state.

Not every NPC needs to wander every turn. Schedules are authored world behavior, not background pathfinding for its own sake.

## Mara relation

Mara may independently know, like, dislike, remember, or form opinions about these people. A vendor can remember Mara separately from remembering the Adventurer where events justify it.

The fair should not model every NPC primarily as a conduit for the Adventurer/Mara relationship.

## Still-missing long-term roles

Likely later additions include:

- dubious/possibly rigged game operator;
- dedicated repair/maintenance worker;
- performer beyond Orin's group;
- artisan/craft seller;
- child/family characters for mundane discovered stories;
- recurring couple(s) whose own relationship changes over fairs;
- fair safety/constable role if genuinely needed;
- rival anglers beyond Silas's official role;
- transient vendors who appear only certain years.

## Roster law

Do not create dozens of interchangeable named people. Named NPCs exist because they have knowledge, behavior, continuity, or a useful story role.
