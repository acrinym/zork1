# Release 121 feature matrix

## Shipped interaction foundation

| Area | New behavior | Original behavior retained |
|---|---|---|
| Edition separation | Independent Release 121 build, receipt, audit, verification, and artifact | Historical Release 119 and optimized Release 120 remain separate |
| Player orientation | `GOALS`, `EXITS`, tiered `HINT`, `RECAP`, `WHY`, and `USE <object>` | Traditional parser play remains available; assistance is optional |
| White house | Repeated knocking, listening, roof-climb explanation, structural responses | Original entry route and house navigation |
| Boards and boarded windows | Tool-sensitive scarring, persistent splinter, specific sound and visibility responses | Boards remain secured; no trivial front-door bypass |
| Kitchen window | Knocking and listening reactions | Original open, close, examine, and traversal behavior |
| Mailbox | Hidden maintenance slip discovered after the leaflet is removed | Original leaflet and mailbox sequence |
| Forest songbird | Followable optional trail, hidden glade, brass feather, remembered discovery | Original forest graph and egg/canary puzzle |
| Troll | Genuine-treasure bribe as a noncombat route; social responses | Original combat, disarming, gifts, and weapon interactions |
| Cyclops | Repeated lullaby route; more greetings, food reactions, and state feedback | Original pepper/water and Odysseus solutions |
| Thief | One-time bargaining command that consumes real treasure and leaves a clue | Existing roaming, theft, combat, and treasure behavior |
| Dam | State-aware listening and examination; control-panel guidance | Original bubble, wrench, gates, reservoir, and timer logic |
| Exorcism | Bell resonance, candle-state detail, optional black-book pages | Original timed bell/candles/book ceremony |
| Objects | Additional affordance guidance and reactions for rope, mirrors, water, wrench, shovel, axe, bell, and candles | Existing puzzle-specific actions remain authoritative |
| World memory | House damage, discoveries, bargains, NPC outcomes, dam, ritual, and victory surfaced through `RECAP` | Existing state flags and save model |

## Deliberate constraints

- Release 121 does not alter historical root files.
- It does not remove original solutions.
- It does not introduce a universal crafting system.
- It does not turn hints into automatic commands.
- It does not make every scenery noun portable.
- It does not claim every possible verb/object pairing has bespoke prose yet.
- It does not present new prose as recovered Infocom authorship.

## Validation coverage

| Coverage | Method |
|---|---|
| Historical source identity | Git-blob manifest verification before staging |
| Expansion application | Exact-match patches with required match counts |
| ZIL structure | Reader-aware structural and include audit |
| Compiler compatibility | Pinned ZILF and ZAPF build in GitHub Actions |
| Story identity | Header, length, addresses, Release 121, serial, and checksum verification |
| Opening reactivity | Deterministic Frotz transcript covering assistance, house, mailbox, songbird, optional room, collectible, and recap |
| Optimized regression | Release 120 continues to compile, verify, and run its original smoke route |

## Still requiring dedicated long-form transcripts

The implementation is compiled as a whole, but these routes deserve dedicated scripted journeys rather than relying only on structural and opening-route validation:

- treasure bribery of the troll;
- three-turn cyclops lullaby under the existing impatience timer;
- thief bargain with a carried treasure;
- bell/candle/book ritual before and after altered object descriptions;
- dam feedback across both water-level states;
- save and restore after expanded persistent-state changes;
- recursive-container rejection and extinguished-candle regression from Release 120.

Those routes are the next verification train, not hidden claims of already-complete coverage.
