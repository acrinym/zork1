# Flathead Fair daily operations

**Status:** STABLE FOR PLANNING  
**Scope:** one operating fair day, expressed as authored phases rather than imported clock hours

## Purpose

This authority makes the fair operate like a place over time. It binds the 16-location graph, core named NPCs, commerce, performances, rides, fishing, crowd character, closing and weather behavior into one coherent day.

It does **not** define a global GUE clock. When broader time authority provides exact times, those may be mapped onto these phases.

## Daily phases

1. `PREOPEN` — staff setup, deliveries, inspection, limited public activity on Fair Road.
2. `OPENING` — gates/grounds open, vendors start service, rides begin staged operation.
3. `LATE-MORNING` — full family/market activity, fishing active, first performances.
4. `MIDDAY` — crowd peak, food demand high, competitions and queues grow.
5. `AFTERNOON` — judging, derby/featured contests, major pavilion events.
6. `DUSK` — lights are lit, some daytime vendors close, evening businesses prepare.
7. `EVENING` — dance/social program, lit rides, adult social life, reduced exhibitions.
8. `CLOSING` — sales/ride queues stop in sequence, people finish paid activities and leave.
9. `AFTER-HOURS` — public fair activity is over; staff cleanup/repair/storage continues in bounded places.

A phase transition changes schedules and world presentation. It does not teleport every actor simultaneously.

## Whole-fair phase character

| Phase | Crowd | Dominant activity | Sensory identity |
|---|---|---|---|
| PREOPEN | workers/vendors | setup, carts, testing, frying prep | canvas, damp grass, hammering, first hot oil |
| OPENING | light | arrival, breakfast/snacks, first rides | fresh signs, calls from stalls, machinery starting |
| LATE-MORNING | growing | shopping, games, fishing, exhibitions | music, sugar/oil, chatter |
| MIDDAY | peak | food, rides, games, crowds | loud midway, queues, competing smells |
| AFTERNOON | high | derby, judging, featured events | announcements, applause, score calls |
| DUSK | changing | lights, dinner/snacks, evening setup | lanterns/lights, cooling air, music tuning |
| EVENING | adult/social shift | dancing, wheel, food/drink, strolling | music, illuminated rides, lower family density |
| CLOSING | draining | last service, prize redemption, departures | shutters, final calls, brooms, machinery stopping |
| AFTER-HOURS | sparse staff | cleanup, repairs, records, storage | creaks, distant voices, dark booths, service lamps |

## Location operating matrix

### Fair Road
- PREOPEN: delivery wagons, workers, vendors arriving.
- OPENING through AFTERNOON: arriving/departing visitors and directional signs.
- DUSK/EVENING: lantern glow and music become visible/audible before the entrance.
- CLOSING: departure traffic dominates.
- AFTER-HOURS: mostly empty except staff/service departures.

### Fair Entrance
- PREOPEN: not yet public beyond approach/signage.
- OPENING through EVENING: handbills, directions, meeting point, free entry.
- CLOSING: no new attraction queues encouraged; exit remains open.
- AFTER-HOURS: public route back to Fair Road remains available even when fair services are closed.

### Central Midway
- OPENING: orientation and first crowd.
- MIDDAY: maximum crowd density and incidental-event opportunity.
- DUSK: lighting transition is highly visible here.
- EVENING: still active but population shifts toward rides, food and dancing.
- CLOSING: vendors make last calls; crowd drains toward entrance.

### Food Row
- PREOPEN: deliveries and preparation through Back Lane.
- OPENING through MIDDAY: full food service.
- AFTERNOON: continued service, possible batch shortages.
- DUSK/EVENING: hot drinks and evening food become more prominent; some daytime-only stalls close.
- CLOSING: limited last sales; prepared-food leftovers follow vendor-specific policy.

### Games Row
- OPENING: standard booths open.
- MIDDAY/AFTERNOON: peak competition, featured attempts and records.
- DUSK/EVENING: lit games remain active, child-focused booths may close earlier.
- CLOSING: no new long attempts after cut-off; outstanding tickets remain redeemable according to Prize Hall closing rules.

### Market Row
- OPENING through AFTERNOON: main trading period.
- DUSK: many artisans begin closing.
- EVENING: only designated evening merchants remain; Vera Tallow may keep later hours on selected days.
- CLOSING: normal retail ends before the final social venues.

### Grand Pavilion
- OPENING/LATE-MORNING: exhibitions, announcements, early performances.
- MIDDAY/AFTERNOON: judging and major scheduled events.
- Bad weather: fallback venue for specific outdoor events where authored.
- DUSK: transitions from daytime program toward evening use.
- EVENING: limited public programs, seating/rest depending schedule.

### Dance Pavilion
- OPENING through AFTERNOON: seating, lessons/rehearsals, occasional daytime music.
- DUSK: Orin Bell and musicians prepare; evening service/social use activates.
- EVENING: principal dance/adult-social venue.
- CLOSING: last piece, explicit final call, lights reduce gradually rather than instant despawn.

### Ride Court
- PREOPEN: Tilda Fen inspects/starts machinery.
- OPENING through AFTERNOON: carousel/swings/smaller rides operate.
- DUSK/EVENING: lit operation continues where weather permits.
- CLOSING: queue closes before machinery; riders already admitted finish.

### Observation Wheel
- PREOPEN: Emery Wicks inspection/test cycle.
- OPENING through AFTERNOON: normal scenic operation.
- DUSK/EVENING: strongest social/scenic period; lit fair views differ materially.
- Weather: wind can suspend boarding with refund/credit policy.
- CLOSING: final boarding announced; existing carriage cycle completes safely.

### House of Mirrors
- OPENING through EVENING: paid attraction.
- Peak crowd changes navigation/social texture but never randomizes the authored topology beyond its explicit attraction rules.
- CLOSING: stop admitting new visitors with enough lead time that nobody is author-trapped inside.
- AFTER-HOURS: closed installation; public entry is not implicitly allowed merely because the fair is dark.

### Fishing Pond
- PREOPEN: Silas Dace checks pond/gear/derby setup.
- OPENING/LATE-MORNING: strong ordinary fishing period.
- MIDDAY: fishing continues but crowd/conditions may differ.
- AFTERNOON: derby weigh-in/featured competition window where scheduled.
- DUSK: rentals/official weigh-in close before full darkness unless a specific evening event exists.
- EVENING: pond remains a visible place; ordinary public path access does not imply unattended rental fishing.

### Pond Path
- Public whenever the fairground pedestrian network is public.
- Morning: anglers and walkers.
- Midday: quieter than Midway but not private.
- DUSK/EVENING: strong strolling/conversation context.
- CLOSING/AFTER-HOURS: traffic becomes sparse; access remains governed by fairground closing policy, not romance needs.

### Exhibition Yard
- OPENING through AFTERNOON: exhibits, demonstrations and judging.
- DUSK: animals/valuable exhibits may be secured; temporary demonstrations end.
- EVENING: reduced activity or closed subsections.
- Weather: some exhibits move under Grand Pavilion when specifically supported.

### Prize & Records Hall
- PREOPEN: Ada Vellum / Nell Harrow prepare records and stock.
- OPENING through AFTERNOON: records, entries, lost/found and prize redemption.
- EVENING: prize redemption remains open later than many games so earned tickets can still be used.
- CLOSING: final redemption call is explicit; historical/office functions close separately from emergency lost-person handling.

### Back Lane
- PREOPEN: busiest phase for deliveries and staff setup.
- Public day: bounded service traffic, refuse, replacement stock, repairs.
- Weather failure: staging point for closures/repairs where appropriate.
- CLOSING/AFTER-HOURS: staff cleanup and storage activity continues after public attractions shut.

## Core NPC operating schedule

This matrix defines **where a character is expected**, not continuous pathfinding. Travel between adjacent assigned locations may be represented through authored departure/arrival state.

| NPC | PREOPEN | OPENING | LATE-MORNING | MIDDAY | AFTERNOON | DUSK | EVENING | CLOSING / AFTER-HOURS |
|---|---|---|---|---|---|---|---|---|
| Berrin Vale | Back Lane inspection | Entrance | Central Midway | roving Central/Grand | Grand/Prize Hall incidents | Ride/grounds inspection | Central/Dance oversight | Entrance then Back Lane |
| Ada Vellum | Prize & Records Hall | Prize & Records Hall | same | Grand Pavilion for official results as needed | Prize Hall / event records | Prize Hall | Prize Hall reduced desk | closes records, then office work |
| Mabel Rusk | Food Row prep via Back Lane | Food Row | Food Row | Food Row | Food Row; one authored break | Food Row | Food Row until product close | cleanup/Back Lane |
| Tomas Quince | Food Row prep | Food Row | Food Row | Food Row | Food Row | Food Row | Food Row, later than some daytime stalls | cleanup/Back Lane |
| Silas Dace | Fishing Pond | Fishing Pond | Fishing Pond | Fishing Pond | Pond / Grand or Prize Hall for weigh-in result | closes rental/weigh-in | Pond Path or departs unless event | off duty |
| Nell Harrow | Prize Hall setup | Prize Hall | Prize Hall | Prize Hall | Prize Hall | Prize Hall | Prize Hall late redemption | final count/close |
| Emery Wicks | Wheel inspection | Observation Wheel | Observation Wheel | Observation Wheel | Observation Wheel | Observation Wheel | Observation Wheel | final cycle, then Back Lane |
| Tilda Fen | Ride Court inspection | Ride Court | Ride Court | Ride Court | Ride Court | Ride Court | Ride Court where operating | shutdown / Back Lane |
| Jonas Pell | Games Row setup | Games Row | Games Row | Games Row | Games Row / featured contest | Games Row | Games Row until booth close | secures booth / leaves |
| Vera Tallow | Market setup | Market Row | Market Row | Market Row | Market Row | Market Row | selected late Market hours or Dance Pavilion as visitor | packs through Back Lane |
| Orin Bell | arrival/setup Grand/Back Lane | Grand Pavilion prep | Grand performance/rehearsal | Grand Pavilion | Grand / rest | Dance Pavilion setup | Dance Pavilion bandleader | last piece, pack-down |
| Ephraim Peake | not staff; usually absent | Entrance/Food Row | Grand/Market | Food/Grand | Pond Path/Exhibitions | Central or wheel vicinity | Dance Pavilion / strolling | leaves before or during closing, depending day |

## Break law

Named workers may take breaks. A break is an authored state, not a disappearance.

When a core stall/operator is temporarily unavailable:

- a sign, neighboring vendor or visible state explains it;
- paid attractions do not accept money without an operator;
- important office functions can have a clear return state;
- no required fair interaction relies on catching a worker during one tiny untelegraphed window.

A break may create character moments, including encountering a vendor somewhere other than behind their counter.

## Mara and daily operation

Mara is not assigned a vendor-style schedule. Her fair movement derives from accompanying/independent behavior, preferences, current relationship, crowd tolerance, hunger/tiredness and chosen activities.

She may suggest movement because of phase changes, for example:

- wanting food as Food Row becomes busy;
- preferring the wheel near dusk;
- noticing music starting at Dance Pavilion;
- wanting a quieter Pond Path after too much Midway crowd;
- deciding she is ready to leave before official closing.

She is not compelled to maximize attractions before the clock advances.

## Weather overrides

Weather modifies operation through named authority, not one global `FAIR CLOSED` switch.

Examples:

- Emery suspends wheel boarding for unsafe wind;
- Tilda pauses wind-sensitive Ride Court machinery;
- Grand Pavilion absorbs supported performances/exhibits;
- Food Row deploys awnings/covers;
- Silas changes fishing advice/derby status where weather matters;
- Berrin coordinates serious safety response.

Paid-but-unused services follow the commerce refund/credit authority.

## Closing law

Closing is a sequence:

1. long attractions stop admitting new customers;
2. games stop opening new featured attempts;
3. Market Row begins closing;
4. fishing rental/weigh-in ends;
5. food reduces to late vendors;
6. final ride cycles complete;
7. Prize Hall gives final redemption call;
8. Dance Pavilion ends the last piece;
9. visitors drain toward Entrance/Fair Road;
10. Back Lane remains active for workers.

No character vanishes at one magic tick, no paid rider is dumped off a ride, and no player is trapped because a booth's business hours changed.

## After-hours law

After-hours is a legitimate world state, not automatic horror mode.

It can contain:

- cleanup;
- repair;
- stored objects;
- exhausted vendors;
- records being closed out;
- dim ride structures;
- wind and distant mechanical sounds;
- rare authored incidents.

Closed attractions remain closed unless a specific story provides legitimate access. Darkness alone is not a universal trespassing permit.
