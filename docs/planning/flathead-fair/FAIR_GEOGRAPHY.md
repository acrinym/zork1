# Flathead Fair geography

**Status:** STABLE FOR PLANNING  
**Attachment point:** LOCKED — new northeast spur from canonical `CLEARING`  
**Initial fairground graph:** LOCKED FOR PLANNING — 16 major locations

## Geography law

The fair attaches to real Highly Extended Zork geography without stealing or rerouting canonical exits. The player can ignore it completely.

The fair is compact and dense rather than enormous and hollow. The initial geography is **16 major fair locations**, with attraction interiors added only where the activity genuinely benefits from them.

## Canonical seam

Canonical `CLEARING` already connects east to `CANYON-VIEW`, north to `FOREST-2`, south to `FOREST-3`, and west to `EAST-OF-HOUSE`. Northeast is unused.

The fair therefore adds an **NE** road spur without replacing any existing movement or barrier:

```text
EAST-OF-HOUSE -- CLEARING -- CANYON-VIEW
                    |
                   NE
                    |
                FAIR-ROAD
                    |
              FAIR-ENTRANCE
```

`FAIR_SITE_SELECTION.md` owns the source-grounded site comparison.

## Locked 16-location graph

The fairground is deliberately a **mesh rather than a single hub with dead-end spokes**. Central Midway provides orientation, but a player can make long loops through food, market, pavilions, pond, rides, prizes, and games without constantly returning to the same room.

```text
                                POND-PATH ----- FISHING-POND ----- OBSERVATION-WHEEL
                                   |                |                    |
                              EXHIBITION-YARD ---- GRAND-PAVILION ---- DANCE-PAVILION
                                   |                |                    |
                                BACK-LANE ------ MARKET-ROW          PRIZE-RECORDS-HALL ---- RIDE-COURT
                                   |                |                    |                     |
                                   +------------ FOOD-ROW -- CENTRAL-MIDWAY -- GAMES-ROW -----+
                                                                  |
                                                             FAIR-ENTRANCE
                                                                  |
                                                               FAIR-ROAD
                                                                  |
                                                         SW to canonical CLEARING

HOUSE-OF-MIRRORS sits northeast of RIDE-COURT and connects back toward
DANCE-PAVILION / OBSERVATION-WHEEL, creating an eastern attraction loop.
```

The diagram expresses topology, not exact physical scale.

## Directional connection contract

### 1. `FAIR-ROAD`
- SW -> canonical `CLEARING`
- N -> `FAIR-ENTRANCE`

Purpose: approach, carts/wagons, signs, first music/smell/light cues, traffic changes by fair phase.

### 2. `FAIR-ENTRANCE`
- S -> `FAIR-ROAD`
- N -> `CENTRAL-MIDWAY`
- NW -> `FOOD-ROW`
- NE -> `GAMES-ROW`

Purpose: free-entry policy, handbills, meeting point, rules and directional help. The entrance is not a toll gate.

### 3. `CENTRAL-MIDWAY`
- S -> `FAIR-ENTRANCE`
- W -> `FOOD-ROW`
- E -> `GAMES-ROW`
- N -> `GRAND-PAVILION`
- NW -> `MARKET-ROW`
- NE -> `PRIZE-RECORDS-HALL`

Purpose: orientation, crowd density, incidental encounters, visible signs toward every major district.

### 4. `FOOD-ROW`
- E -> `CENTRAL-MIDWAY`
- N -> `MARKET-ROW`
- SE -> `FAIR-ENTRANCE`
- W/NW -> `BACK-LANE` service seam where public access is allowed

Purpose: Mabel Rusk, Tomas Quince, other food stalls, eating/sharing, smell as navigation, food-related errands.

### 5. `GAMES-ROW`
- W -> `CENTRAL-MIDWAY`
- N -> `PRIZE-RECORDS-HALL`
- NE -> `RIDE-COURT`
- SW -> `FAIR-ENTRANCE`

Purpose: Jonas Pell, midway skill/chance games, scoreboards, tickets, spectators and competition hooks.

### 6. `MARKET-ROW`
- S -> `FOOD-ROW`
- E -> `GRAND-PAVILION`
- W -> `BACK-LANE`
- NE -> `EXHIBITION-YARD`

Purpose: Vera Tallow, artisans, books, clothing, crafts, temporary merchants and commerce questions.

### 7. `GRAND-PAVILION`
- S -> `CENTRAL-MIDWAY`
- W -> `MARKET-ROW`
- E -> `PRIZE-RECORDS-HALL`
- NW -> `EXHIBITION-YARD`
- NE -> `DANCE-PAVILION`
- N -> `FISHING-POND`

Purpose: performances, judging, civic announcements, indoor/covered weather fallback and major scheduled events.

### 8. `DANCE-PAVILION`
- SW -> `GRAND-PAVILION`
- S -> `PRIZE-RECORDS-HALL`
- N -> `OBSERVATION-WHEEL`
- E -> `HOUSE-OF-MIRRORS`

Purpose: daytime seating/social use, Orin Bell, evening music/dancing, adult social life, covered bad-weather activity.

### 9. `RIDE-COURT`
- W -> `PRIZE-RECORDS-HALL`
- SW -> `GAMES-ROW`
- N -> `HOUSE-OF-MIRRORS`

Purpose: Tilda Fen, carousel, flying chairs/swings and later smaller rides.

### 10. `OBSERVATION-WHEEL`
- W -> `FISHING-POND`
- S -> `DANCE-PAVILION`
- E/SE -> `HOUSE-OF-MIRRORS`

Purpose: Emery Wicks, wheel boarding, carriage context, scenic landmark views, evening/private social experience.

The wheel carriage itself may be a temporary actor/location context without multiplying the ground map unnecessarily.

### 11. `HOUSE-OF-MIRRORS`
- S -> `RIDE-COURT`
- W/SW -> `DANCE-PAVILION`
- NW -> `OBSERVATION-WHEEL`

Purpose: parser-dense mirror attraction and eastern loop terminus. The internal mirror maze may earn a small sub-map later; the ground entrance remains this one major location.

### 12. `FISHING-POND`
- S -> `GRAND-PAVILION`
- W -> `POND-PATH`
- E -> `OBSERVATION-WHEEL`

Purpose: Silas Dace, fishing, derby, rental/gear interactions, weigh-in staging and spectators.

### 13. `POND-PATH`
- E -> `FISHING-POND`
- S -> `EXHIBITION-YARD`
- SE -> `GRAND-PAVILION`

Purpose: quieter walk, alternate pond positions, lower crowd density, conversation/privacy gradient and evening atmosphere.

This is a public path, not a romance flag.

### 14. `EXHIBITION-YARD`
- E/SE -> `GRAND-PAVILION`
- N -> `POND-PATH`
- W/SW -> `BACK-LANE`
- S -> `MARKET-ROW`

Purpose: craft/agricultural/mechanical exhibits, judging overflow, temporary demonstrations and fair-history texture.

### 15. `PRIZE-RECORDS-HALL`
- S -> `GAMES-ROW`
- W -> `GRAND-PAVILION`
- E -> `RIDE-COURT`
- N -> `DANCE-PAVILION`
- SW -> `CENTRAL-MIDWAY`

Purpose: Nell Harrow prize counter, Ada Vellum records/office work, ribbons, old programs, lost-and-found and persistent records.

### 16. `BACK-LANE`
- E -> `MARKET-ROW`
- NE -> `EXHIBITION-YARD`
- SE -> `FOOD-ROW`

Purpose: deliveries, staff movement, repairs, storage, refuse, temporary closures and after-hours texture.

Public access is contextual. During active service periods the visitor-facing portion can be entered, but doors, storage cages and work areas retain ordinary boundaries. After closing it becomes one of the places where legitimate staff activity continues after most visitors leave.

## Movement laws

1. No major fair district is reachable through only one fragile paid attraction.
2. Closing an attraction does not cut the pedestrian graph.
3. Weather may close a ride or stall, never the only safe route out of the fair.
4. The player can reach `FAIR-ENTRANCE` and return to canonical `CLEARING` without paying anything.
5. Staff can plausibly reach Food Row, Market Row, Exhibition Yard and the pavilions through Back Lane without teleporting.
6. Pond Path provides a quieter alternate northern route rather than making privacy a magic room property.
7. House of Mirrors internals may confuse the player locally, but exiting the attraction returns to the stable eastern fairground graph.

## Density assignments

Every major location carries several interaction families:

| Location | Minimum authored density |
|---|---|
| Fair Road | traffic, signs, weather, arriving/departing NPCs |
| Fair Entrance | directions, handbills, staff, lost-person meeting point |
| Central Midway | crowd, incidents, orientation, Mara/NPC initiative |
| Food Row | products, questions, eating/sharing, vendors, errands |
| Games Row | games, tickets, records, spectators, operator dialogue |
| Market Row | buying, identification, bargaining-specific merchants, lore |
| Grand Pavilion | performances, judging, ceremonies, weather shelter |
| Dance Pavilion | music, dancing, seating, adult social life, evening change |
| Ride Court | multiple rides, operators, queues, weather state |
| Observation Wheel | boarding, views, carriage social context, weather |
| House of Mirrors | navigation, mirrors, object/reflection verbs, anomalies |
| Fishing Pond | fishing, derby, gear, fish/junk objects, NPC anglers |
| Pond Path | walking, alternate fishing positions, quiet talk, night texture |
| Exhibition Yard | exhibits, judging, animals/machinery/crafts, incidents |
| Prize & Records Hall | prizes, records, old fair history, lost/found |
| Back Lane | deliveries, repair, staff knowledge, after-hours activity |

## Privacy gradient

The graph deliberately supports:

- **high public density:** Central Midway, Food Row, Games Row;
- **public but seated/structured:** Grand Pavilion, Ride Court, Prize Hall;
- **adult/social:** Dance Pavilion;
- **semi-private:** observation-wheel carriage;
- **quiet public:** Pond Path;
- **contextually restricted/low-traffic:** portions of Back Lane;
- **post-closing transformed:** nearly the entire ground as crowds drain away.

Relationship behavior must use actual context, crowd, time and broader autonomy/consent authority rather than `ROMANTIC-ROOM` flags.

## Permanent and seasonal fabric

### Permanent / semi-permanent
- Fair Road and entrance works;
- Fishing Pond and Pond Path;
- Grand Pavilion;
- Prize & Records Hall / office;
- Back Lane and storage/service infrastructure;
- Dance Pavilion shell;
- observation-wheel foundations/major structure, subject to final mechanical design.

### Seasonal
- food/game booths;
- most Market Row stalls;
- carousel and smaller Ride Court machinery;
- House of Mirrors installation;
- tents, signs, decorations, lighting and prize displays.

## Off-season

The same graph remains geographically meaningful when the fair is absent. Seasonal nodes may become empty pads, shuttered stalls, dismantled structures or maintenance areas, but the land does not disappear.

Off-season routes can be intentionally reduced only by physical seasonal facts such as a dismantled attraction entrance, not because the map ceases to exist.

## Canonical protection

- Existing `CLEARING` exits remain unchanged.
- Existing House/Canyon solutions remain available.
- Fair closure cannot strand the player on the wrong side of a canonical route.
- No required treasure is relocated into the fair.
- No canonical room permanently becomes inaccessible because a fair structure occupies it.
- Explicit canonical forest barriers remain barriers.
