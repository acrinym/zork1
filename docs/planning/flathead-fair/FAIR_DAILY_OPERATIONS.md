# Flathead Fair daily operations

**Status:** STABLE FOR PLANNING  
**Scope:** one operating fair day, expressed as authored phases rather than imported clock hours

## Purpose

This authority makes the fair operate like a place over time. It binds the 16-location graph, core named NPCs, commerce, performances, rides, fishing, crowd character, closing and weather behavior into one coherent day.

It does **not** define a global GUE clock. When broader time authority provides exact times, those may be mapped onto these phases.

## Daily phases

1. `PREOPEN` — staff setup, deliveries, inspection, limited public activity on Fair Road.
2. `OPENING` — grounds open, vendors start service, rides begin staged operation.
3. `LATE-MORNING` — full family/market activity, fishing active, first performances.
4. `MIDDAY` — crowd peak, food demand high, competitions and queues grow.
5. `AFTERNOON` — judging, derby/featured contests, major pavilion events.
6. `DUSK` — lights are lit, some daytime vendors close, evening businesses prepare.
7. `EVENING` — dance/social program, lit rides, adult social life, reduced exhibitions.
8. `CLOSING` — sales/ride queues stop in sequence, people finish paid activities and leave.
9. `AFTER-HOURS` — public fair activity is over; staff cleanup/repair/storage and current-office closeout continue in bounded places.

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
| AFTER-HOURS | sparse staff | cleanup, repairs, current-office closeout, storage | creaks, distant voices, dark booths, service lamps |

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
- AFTER-HOURS: public route back to Fair Road remains available even when services are closed.

### Central Midway
- OPENING: orientation and first crowd.
- MIDDAY: maximum crowd density and incidental-event opportunity.
- DUSK: lighting transition is highly visible here.
- EVENING: active but population shifts toward rides, food and dancing.
- CLOSING: vendors make last calls; crowd drains toward entrance.

### Food Row
- PREOPEN: deliveries and preparation through Back Lane.
- OPENING through MIDDAY: full food service.
- AFTERNOON: continued service, possible batch shortages.
- DUSK: hot drinks/evening food become more prominent; some daytime stalls close; Tomas Quince closes his ordinary cold-drink stand and transitions selected stock/equipment toward Dance Pavilion.
- EVENING: remaining designated food vendors continue according to their own hours; Tomas operates The Lantern Table in Dance Pavilion rather than his daytime Food Row stand.
- CLOSING: limited last sales; leftovers follow vendor-specific policy.

### Games Row
- OPENING: standard booths open.
- MIDDAY/AFTERNOON: peak competition, featured attempts and records.
- DUSK/EVENING: lit games remain active; child-focused booths may close earlier.
- CLOSING: no new long attempts after cut-off; outstanding tickets remain redeemable according to Fair Office & Prize Hall closing rules.

### Market Row
- OPENING through AFTERNOON: main trading period.
- DUSK: many artisans begin closing.
- EVENING: only designated evening merchants remain; Vera Tallow may keep later hours on selected days.
- CLOSING: normal retail ends before final social venues.

### Grand Pavilion
- OPENING/LATE-MORNING: exhibitions, announcements, early performances.
- MIDDAY/AFTERNOON: judging and major scheduled events.
- Bad weather: fallback venue for specific outdoor events where authored.
- DUSK: transitions from daytime program toward evening use.
- EVENING: limited public programs, seating/rest depending schedule.

### Dance Pavilion
- OPENING through AFTERNOON: seating, lessons/rehearsals, occasional daytime music; The Lantern Table is not yet operating as evening service.
- DUSK: Orin Bell and musicians prepare while Tomas Quince transitions from Food Row and opens The Lantern Table in stages; lamps, hot/evening drinks and supper/social seating become active.
- EVENING: principal dance/adult-social venue with full Lantern Table service. Free ordinary pavilion access does not require a purchase or drink minimum.
- CLOSING: Tomas makes the service last call before/around Orin's final program beat; existing food/drink may be finished; Orin ends the last piece; service and lights reduce gradually rather than instant despawn.
- AFTER-HOURS: Lantern Table is closed; legitimate staff cleanup may continue, but the pavilion does not become an automatic private after-hours venue.

See `FAIR_ADULT_SOCIAL_ROMANCE_AND_INTIMACY.md` for the focused Lantern Table menu, privacy gradient and adult-social authority.

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
- Peak crowd changes navigation/social texture but does not replace authored topology with arbitrary randomness.
- CLOSING: stop admitting new visitors with enough lead time that nobody is trapped inside.
- AFTER-HOURS: closed installation; darkness is not an automatic invitation to trespass.

### Fishing Pond
- PREOPEN: Silas Dace checks pond/gear/derby setup.
- OPENING/LATE-MORNING: strong ordinary fishing period.
- MIDDAY: fishing continues but crowd/conditions may differ.
- AFTERNOON: derby weigh-in/featured competition window where scheduled.
- DUSK: rentals/official weigh-in close before full darkness unless a specific evening event exists.
- EVENING: pond remains visible; public path access does not imply unattended rental fishing.

### Pond Path
- Public whenever the fairground pedestrian network is public.
- Morning: anglers and walkers.
- Midday: quieter than Midway but not private.
- DUSK/EVENING: strong strolling/conversation context.
- CLOSING/AFTER-HOURS: traffic becomes sparse; access follows fairground policy, not romance needs.

### Exhibition Yard
- OPENING through AFTERNOON: exhibits, demonstrations and judging.
- DUSK: animals/valuable exhibits may be secured; temporary demonstrations end.
- EVENING: reduced activity or closed subsections.
- Weather: some exhibits move under Grand Pavilion when specifically supported.

### Fair Office & Prize Hall
- PREOPEN: Ada Vellum prepares **current-fair** office materials; Nell Harrow prepares current prize stock.
- OPENING through AFTERNOON: current entries/results, permits/notices, lost-and-found, incident intake and prize redemption.
- EVENING: prize redemption remains open later than many games; office service reduces to defined current-fair needs.
- CLOSING: final redemption call is explicit; ordinary current-office functions close separately from emergency lost-person handling.
- AFTER-HOURS: Ada closes current paperwork and prepares only qualified archival candidates for a later House of Records closeout/filing path. This does not turn the room into the historical archive.

Older programs, historical maps and durable case files live in the existing upstairs Hall/House of Records and require that archive's physical retrieval/review authority. Graduation follows `FAIR_HALL_OF_RECORDS_INTEGRATION.md`.

### Back Lane
- PREOPEN: busiest for deliveries and staff setup.
- Public day: bounded service traffic, refuse, replacement stock, repairs.
- Weather failure: staging point for closures/repairs where appropriate.
- CLOSING/AFTER-HOURS: staff cleanup and storage activity continues after public attractions shut.

## Core NPC operating schedule

This matrix defines **where a character is expected**, not continuous pathfinding. Travel between adjacent assigned locations may be represented through authored departure/arrival state.

| NPC | PREOPEN | OPENING | LATE-MORNING | MIDDAY | AFTERNOON | DUSK | EVENING | CLOSING / AFTER-HOURS |
|---|---|---|---|---|---|---|---|---|
| Berrin Vale | Back Lane inspection | Entrance | Central Midway | roving Central/Grand | Grand/Fair Office incidents | Ride/grounds inspection | Central/Dance oversight | Entrance then Back Lane |
| Ada Vellum | Fair Office & Prize Hall | Fair Office & Prize Hall | same | Grand Pavilion for current official results as needed | Fair Office / event records | Fair Office | reduced current-office desk | closes current records, prepares qualified archival candidates |
| Mabel Rusk | Food Row prep via Back Lane | Food Row | Food Row | Food Row | Food Row; one authored break | Food Row | Food Row until product close | cleanup/Back Lane |
| Tomas Quince | Food Row prep | Food Row | Food Row | Food Row | Food Row | closes cold-drink stand; transitions to Dance Pavilion / Lantern Table setup | Dance Pavilion — Lantern Table | last service, counter clear, cleanup/Back Lane |
| Silas Dace | Fishing Pond | Fishing Pond | Fishing Pond | Fishing Pond | Pond / Grand or Fair Office for weigh-in result | closes rental/weigh-in | Pond Path or departs unless event | off duty |
| Nell Harrow | Prize Hall setup | Fair Office & Prize Hall | same | same | same | same | late redemption | final count/close |
| Emery Wicks | Wheel inspection | Observation Wheel | Observation Wheel | Observation Wheel | Observation Wheel | Observation Wheel | Observation Wheel | final cycle, then Back Lane |
| Tilda Fen | Ride Court inspection | Ride Court | Ride Court | Ride Court | Ride Court | Ride Court | Ride Court where operating | shutdown / Back Lane |
| Jonas Pell | Games Row setup | Games Row | Games Row | Games Row | Games Row / featured contest | Games Row | Games Row until booth close | secures booth / leaves |
| Vera Tallow | Market setup | Market Row | Market Row | Market Row | Market Row | Market Row | selected late Market hours or Dance Pavilion as visitor | packs through Back Lane |
| Orin Bell | arrival/setup Grand/Back Lane | Grand Pavilion prep | Grand performance/rehearsal | Grand Pavilion | Grand / rest | Dance Pavilion setup | Dance Pavilion bandleader | last piece, pack-down |
| Ephraim Peake | usually absent | Entrance/Food Row | Grand/Market | Food/Grand | Pond Path/Exhibitions | Central or wheel vicinity | Dance Pavilion / strolling | leaves before/during closing depending day |

Secondary-cast expected phase locations remain in `FAIR_SECONDARY_CAST.md` unless later consolidated here. They must obey the same no-teleport, visible-transition and closing rules.

## Break law

Named workers may take breaks. A break is an authored state, not a disappearance.

When a core stall/operator is temporarily unavailable:

- a sign, neighboring vendor or visible state explains it;
- paid attractions do not accept money without an operator;
- important office functions have a clear return state;
- no required fair interaction relies on one tiny untelegraphed window.

A break may create character moments, including encountering a vendor somewhere other than behind their counter.

## Mara and daily operation

Mara is not assigned a vendor-style schedule. Her movement derives from accompanying/independent behavior, preferences, relationship, crowd tolerance, hunger/tiredness and chosen activities.

Her focused fair authority now supplies concrete phase-sensitive behavior. Examples include:

- quieter fishing/Market wandering early;
- food or crowd recovery around MIDDAY;
- derby/competition interest in AFTERNOON;
- strong Observation Wheel / lights / hot-cider / music interest at DUSK;
- Dance Pavilion, wheel or Pond Path possibilities in EVENING;
- willingness to leave before official close rather than optimize every remaining attraction.

She is not compelled to maximize attractions before the phase changes, and a refusal remains a refusal under broader autonomy authority.

Her private fair experiences are personal-memory state, not automatic Fair Office paperwork or House of Records entries.

## Weather overrides

Weather modifies operation through named authority, not one global `FAIR CLOSED` switch.

Examples:

- Emery suspends wheel boarding for unsafe wind;
- Tilda pauses wind-sensitive Ride Court machinery;
- Grand Pavilion absorbs supported performances/exhibits;
- Dance Pavilion may become denser under ordinary rain rather than closing by default;
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
5. Food Row reduces to remaining late vendors while Tomas is already operating The Lantern Table;
6. final ride cycles complete;
7. Fair Office & Prize Hall gives final redemption call;
8. Tomas gives Lantern Table's last paid-order call and Orin ends the last Dance Pavilion piece;
9. visitors with existing food/drink finish naturally and drain toward Entrance/Fair Road;
10. Back Lane, pavilion cleanup and current-office closeout remain active for workers.

No character vanishes at one magic tick, no paid rider is dumped off a ride, no active customer is forced to discard a legitimate purchase because the register closed, and no player is trapped because business hours changed.

## After-hours law

After-hours is a legitimate world state, not automatic horror mode.

It can contain:

- cleanup;
- repair;
- stored objects;
- exhausted vendors;
- current records being closed out;
- qualified archival candidates being marked/prepared for later transfer;
- dim ride structures;
- wind and distant mechanical sounds;
- rare authored incidents.

Closed attractions and The Lantern Table remain closed unless a specific story provides legitimate access. The House of Records does not teleport into the fairgrounds after closing.
