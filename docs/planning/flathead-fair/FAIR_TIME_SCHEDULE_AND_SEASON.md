# Flathead Fair time, schedule, and season

**Status:** STABLE FOR PLANNING  
**Recurrence:** LOCKED IN FICTION — annual regional fair  
**Operating-day authority:** `FAIR_DAILY_OPERATIONS.md`

## Daily lifecycle

The fair is not static scenery. One operating day uses nine authored phases:

1. `PREOPEN` — setup, delivery, inspection;
2. `OPENING` — public opening and staged startup;
3. `LATE-MORNING` — full market/family activity;
4. `MIDDAY` — crowd/food/game peak;
5. `AFTERNOON` — judging, derby and featured events;
6. `DUSK` — lighting and evening transition;
7. `EVENING` — dancing, lit rides, adult social period;
8. `CLOSING` — sequential shutdown and visitor departure;
9. `AFTER-HOURS` — bounded staff cleanup, repair, storage and current-office closeout.

These are semantic world phases, not imported modern clock hours. A broader GUE time authority may later map exact times onto them.

`FAIR_DAILY_OPERATIONS.md` owns the location-by-location operating matrix and the core NPC schedule.

## Phase-transition law

A phase transition does **not** teleport every NPC or close every business on one tick.

Changes are authored by actor/location:

- operators finish active ride cycles;
- vendors may make a last sale or close earlier/later than neighbors;
- performers move from rehearsal to performance;
- prize redemption remains open late enough to redeem newly earned tickets;
- staff move through real adjacent geography where movement matters;
- Ada closes out current Fair Office paperwork rather than transforming the fair office into the historical archive;
- closing remains legible through announcements, shutters, queues and crowd behavior.

## Event lifecycle

The Flathead Fair is an **annual** regional event in world fiction.

A complete cycle can include:

- advance preparation;
- setup days;
- several public fair days;
- a closing night;
- teardown;
- current Fair Office closeout and selection of durable archival candidates;
- an off-season period in which the physical grounds still exist;
- the next annual return.

The exact number of public days remains open until the broader calendar and event-density plan are reconciled. Do not pick a number merely because real-world fairs often last a week.

## Calendar implementation boundary

Annual recurrence is a lore/product decision, not permission to bolt on a fake `YEAR++` counter.

If the broader game does not yet support meaningful elapsed years, the first fair implementation may expose one full fair cycle only. Later annual returns activate when calendar/aging authority can support them honestly.

This prevents the fair from secretly inventing global time semantics for the rest of Highly Extended Zork.

## Seasonal character

The fair belongs near the end of the favorable regional traveling/trading season, consistent with its authored roots as a market/exhibition gathering.

Exact month names, calendar terminology, harvest labels, or holidays remain dependent on future Great Underground Empire calendar lore. Do not silently import a modern Gregorian calendar.

## Scheduling rules

- Missing a performance never breaks required progression.
- A contest may recur at a later scheduled phase/day.
- Closing is legible to the player.
- Shops close individually where appropriate rather than every actor disappearing simultaneously.
- Evening has authored content, not merely darker descriptions.
- After-hours grounds are materially quieter and staffed differently.
- Weather alters schedules only where an attraction/vendor has an authored reason to respond.
- Fair time may inconvenience optional plans; it may not silently destroy canonical Zork progress.
- A worker's break must be observable/understandable and cannot create a tiny untelegraphed mandatory window.

## Weather composition

Weather overrides specific operations rather than setting one generic `FAIR-CLOSED` flag.

Examples include wind suspending the observation wheel, Tilda Fen stopping wind-sensitive machinery, Grand Pavilion absorbing supported events, Food Row deploying covers, or Silas Dace changing derby/fishing guidance.

Paid-but-unused services follow the authored refund/credit rules.

## Closing sequence

The stable planning order is:

1. long attractions stop admitting new customers;
2. featured game attempts stop opening;
3. Market Row begins closing;
4. fishing rental/weigh-in ends;
5. daytime food stalls reduce toward late vendors;
6. final ride cycles complete;
7. **Fair Office & Prize Hall** gives a final redemption call;
8. Dance Pavilion ends the final piece;
9. visitors drain through Fair Entrance/Fair Road;
10. Back Lane remains active for workers while Ada can finish bounded current-office closeout.

No paid rider is dumped out because the phase changed, and no attraction closure can block the pedestrian route home.

## Records lifecycle boundary

Closing a fair day or fair cycle does not make all paperwork permanent history.

- current entries/results, lost-and-found and incident intake remain Fair Office state while operationally relevant;
- selected annual summaries, major records, historical changes and significant adjudicated incidents may become candidates for the existing upstairs Hall/House of Records;
- routine paperwork may expire/reset;
- personal Mara/NPC memories remain personal-memory state rather than archival paperwork.

See `FAIR_HALL_OF_RECORDS_INTEGRATION.md` and `FAIR_PERSISTENCE_AND_MEMORY.md`.

## Long-term continuity

Later annual fairs may change:

- vendors;
- prices;
- attractions;
- prize stock;
- records;
- performers;
- NPC ages/status;
- Mara and Adventurer memories;
- physical fairground condition.

Variation is authored and stateful, not procedurally generated content. Documentary continuity composes the existing Hall/House of Records rather than a fair-only history system.
