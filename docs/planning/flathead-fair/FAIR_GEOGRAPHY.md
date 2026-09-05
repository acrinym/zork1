# Flathead Fair geography

**Status:** DESIGNING  
**Attachment point:** LOCKED — new northeast spur from canonical `CLEARING`

## Geography law

The fair attaches to real Highly Extended Zork geography without stealing or rerouting canonical exits. The player can ignore it completely.

The fair is compact and dense rather than enormous and hollow. Initial target: roughly **16 major fair locations**, with attraction interiors only where the activity genuinely benefits from them.

## Canonical seam

Canonical `CLEARING` already connects:

- east to `CANYON-VIEW`;
- north to `FOREST-2`;
- south to `FOREST-3`;
- west to `EAST-OF-HOUSE`.

Northeast is unused. The fair therefore adds an **NE** road spur without replacing any existing movement or barrier.

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
                FAIRGROUNDS
```

`FAIR_SITE_SELECTION.md` owns the source-grounded site comparison and rejection of competing attachment points.

## Fairground setting

The grounds occupy a new meadow/field pocket beyond the existing forest screen. The fair is near enough to the canonical surface route to be convenient, but the forest prevents it from visually swallowing the House/Canyon corridor.

During fair operation the Clearing may acquire contextual cues such as distant music, food smells, lantern glow, wagon traffic, or signs. Those cues must not replace its canonical description or exits.

## Initial district plan

The exact room names may change, but the first full geography should account for these sixteen functional locations:

1. **Fair Road** — approach, traffic, signage, first distant sensory cues.
2. **Fair Entrance** — information, rules, handbills, admission policy if any, meeting point.
3. **Central Midway** — orientation hub, crowds, cross-fair incidents.
4. **Food Row** — elephant ears, sweets, savory concessions, drinks.
5. **Games Row** — midway games, scoreboards, operators.
6. **Market Row** — artisans, books, curios, clothing, temporary merchants.
7. **Grand Pavilion** — exhibitions, scheduled performances, judging, civic ceremonies.
8. **Evening / Dance Pavilion** — daytime social use, evening dancing and adult social life.
9. **Ride Court** — carousel, swings, smaller mechanical amusements.
10. **Observation Wheel** — scenic/social attraction with its own carriage context.
11. **House of Mirrors** — parser-dense attraction; interior may contain sublocations if justified.
12. **Fishing Pond** — fishing system, derby, anglers, weigh-in proximity.
13. **Pond Path / Quiet Edge** — lower-density walking, conversation, privacy gradient.
14. **Exhibition Yard** — agricultural/craft/livestock or mechanical exhibits depending final roster.
15. **Prize & Records Hall** — prize redemption, ribbons, persistent records, fair office functions.
16. **Back Lane / Service Edge** — operators, deliveries, repairs, storage, after-hours world texture.

This is a product geography, not authorization to code sixteen rooms immediately.

## Density standard

Every major room supports multiple interaction families. Avoid transit-only filler.

A room should usually combine at least three of:

- objects/products;
- NPCs;
- commerce;
- attraction/game verbs;
- scheduled events;
- Mara behavior;
- environmental response;
- discovered objectives/incidents;
- social/quiet use.

## Privacy gradient

The geography creates real social contexts rather than arbitrary `ROMANTIC-ROOM` flags:

- crowded public Midway / Food Row;
- semi-public pavilion seating;
- observation-wheel carriage privacy;
- pond-path quiet;
- quieter service/edge spaces when legitimately accessible;
- nearly empty grounds after closing.

## Permanent and seasonal fabric

### Permanent / semi-permanent

- fair road;
- entrance works/gate;
- fishing pond;
- Grand Pavilion;
- fair office / records hall;
- service lane and storage infrastructure;
- dance/social pavilion shell;
- observation-wheel structure or substantial foundations, depending later mechanical design.

### Seasonal

- food and game booths;
- most market stalls;
- tents;
- seasonal ride components;
- carousel and smaller amusement equipment where appropriate;
- House of Mirrors interior/maze installation;
- temporary signs, decorations, lighting, prize displays, and crowd furniture.

## Off-season

The geography continues to exist when the event is absent. The grounds may be shuttered, dismantled, maintained, muddy, quiet, or partially occupied. They do not teleport out of the world.

Off-season exploration must be intentionally authored rather than treated as an accidental empty copy of fair-day rooms.

## Canonical protection

- Existing `CLEARING` exits remain unchanged.
- Existing House/Canyon solutions remain available.
- Fair closure cannot strand the player on the wrong side of a canonical route.
- No required treasure is relocated into the fair.
- No canonical room permanently becomes inaccessible because a fair structure occupies it.
- Explicit canonical forest barriers remain barriers; the fair does not clear them merely for convenience.
