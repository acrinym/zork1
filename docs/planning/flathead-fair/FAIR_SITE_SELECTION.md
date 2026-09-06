# Flathead Fair site selection

**Status:** LOCKED FOR PLANNING  
**Decision:** attach the fair through a new **northeast spur from `CLEARING`**, leading through a short fair road to new fairground geography.

## Source evidence

The placement decision is grounded in the canonical surface rooms in `1dungeon.zil` rather than in an invented map.

Relevant facts:

- `CLEARING` is already an outdoor junction immediately east of `EAST-OF-HOUSE` and west of `CANYON-VIEW`.
- Its canonical exits are east to `CANYON-VIEW`, north to `FOREST-2`, south to `FOREST-3`, and west to `EAST-OF-HOUSE`.
- **Northeast is unused.**
- `FOREST-2` explicitly says the forest becomes impenetrable to the north.
- `FOREST-1` explicitly says further west would require a machete.
- `FOREST-3` and `CANYON-VIEW` explicitly preserve storm-tossed-tree barriers to the south.
- `CANYON-VIEW` already names the **Flathead Mountains** to the east and describes the immense forest west and south.

The fair should not erase any of those authored barriers merely to make room for itself.

## Candidate comparison

| Candidate | Benefit | Problem | Decision |
|---|---|---|---|
| NE spur from `CLEARING` | Close to House, additive direction, near existing path, easy to ignore | Requires one new visible lane in the Clearing | **SELECTED** |
| North from `FOREST-2` | Large implied wilderness | Replaces explicit `forest becomes impenetrable` authority | Reject |
| West from `FOREST-1` | Large implied wilderness | Replaces explicit machete barrier | Reject |
| South from `FOREST-3` | Space beyond forest | Replaces explicit storm-tossed-tree barrier | Reject |
| South from `CANYON-VIEW` | Scenic | Replaces explicit barrier and puts crowds too close to canyon hazard | Reject |
| Non-geographic carriage/teleport | Easy isolation | Weakens the parser-real contiguous-world goal | Reject as primary access |

## Locked attachment seam

Conceptual route:

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

The diagram is conceptual; it does not authorize implementation yet.

## Why the Clearing works

The existing Clearing already sits on a well-marked surface route and is only one canonical step east of Behind House. A new northeast lane can therefore feel like an ordinary regional road branching away from the adventure route rather than a portal pasted onto a random room.

The forest should screen most of the fair from the canonical path. During operation the player may hear music, smell food, see lantern glow, or notice traffic before reaching the gate, but the fair should not visually swallow the House/Canyon corridor.

## Ground model

The fair occupies **new authored meadow/field geography beyond the existing forest**, not an existing canonical room temporarily renamed as a fairground.

The land exists year-round. The event changes what occupies it.

### Permanent or semi-permanent anchors

Candidates suitable to remain when the fair is closed:

- fair road and gate/entrance works;
- natural fishing pond;
- grand/exhibition pavilion;
- records/fair office building;
- dance/social pavilion or its shell;
- observation-wheel structure or at minimum its heavy permanent foundations;
- service lane and utility/storage structures.

### Seasonal structures

Likely seasonal:

- food concessions;
- game booths;
- most market stalls;
- prize counters outside the permanent office;
- House of Mirrors interior/temporary maze structure;
- carousel and smaller rides where final mechanical design supports seasonal assembly;
- tents and temporary performance spaces.

## Off-season law

The fairground must not vanish when the fair closes. The player may visit quiet or partially dismantled grounds if calendar state makes that meaningful.

Off-season geography can expose:

- shuttered buildings;
- stored ride parts;
- empty foundations;
- maintenance workers;
- pond/fishing restrictions or alternate access;
- windblown litter and forgotten objects after teardown;
- different NPCs and much greater quiet.

This is authored world state, not spooky content by default.

## Canonical protection contract

Implementation must preserve every existing `CLEARING` exit and every existing surface solution. The new northeast route is additive only. Fair opening/closing may change signage, traffic, sound, and access deeper into fair structures, but it may not strand the player or block the House-to-Canyon route.
