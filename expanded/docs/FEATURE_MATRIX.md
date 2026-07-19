# Release 121 feature matrix

## Edition and format status

| Edition | Format | Identity | Status |
|---|---|---:|---|
| Historical | `.z3` | Release 119 / `880429` | Preserved and verified |
| Optimized | `.z3` | Release 120 / `260718` | Qualified |
| Expanded | `.z3` | Release 121 / `260719` | Qualified as a complete build with broad deterministic routes |
| Unchanged upstream Glulx | `.ulx` | Release 1 / `251203` | Qualified against Tara McGrew's exact source commit and archived reference |
| Unofficial Optimized Glulx | `.ulx` | Release 1201 / `260719` | Qualified with conservative Release 120 corrections and focused native regressions |
| Unofficial Assisted Glulx | `.ulx` | Release 1211 / `260719` | Qualified action hooks and assistance with `.z3`/`.ulx` semantic parity |
| Reactive Expanded Glulx | `.ulx` | not assigned yet | Surface-world reactivity is the controlling next layer |

## Shipped interaction foundation

| Area | New behavior | Original behavior retained |
|---|---|---|
| Edition separation | Independent Release 121 build, receipt, audit, verification, and artifact | Historical Release 119 and optimized Release 120 remain separate |
| Player orientation | `GOALS`, `EXITS`, tiered `HINT`, `RECAP`, `WHY`, and `USE <object>` | Traditional parser play remains available; assistance is optional |
| White house | Repeated knocking, listening, roof-climb explanation, structural responses | Original entry route and house navigation |
| Boards and boarded windows | Tool-sensitive scarring, persistent splinter, specific sound and visibility responses | Boards remain secured; no trivial front-door bypass |
| Kitchen window | Knocking and listening reactions | Original open, close, examine, and traversal behavior |
| Mailbox | Hidden maintenance slip discovered after the leaflet is removed | Original leaflet and mailbox sequence |
| Forest songbird | Followable optional trail, Hidden Glade, brass feather, remembered discovery | Original forest graph and egg/canary puzzle |
| Troll | Genuine-treasure bribe as a noncombat route; social responses | Original combat, disarming, gifts, and weapon interactions |
| Cyclops | Repeated lullaby route; more greetings, food reactions, and state feedback | Original pepper/water and Odysseus solutions |
| Thief | One-time bargaining command that consumes real treasure and leaves a clue | Existing roaming, theft, combat, and treasure behavior |
| Dam | State-aware listening and examination; control-panel guidance | Original bubble, wrench, gates, reservoir, and timer logic |
| Exorcism | Bell resonance, candle-state detail, optional black-book pages | Original timed bell/candles/book ceremony |
| Objects | Additional affordance guidance and reactions for rope, mirrors, water, wrench, shovel, axe, bell, and candles | Existing puzzle-specific actions remain authoritative |
| World memory | House damage, discoveries, bargains, NPC outcomes, dam, ritual, and victory surfaced through `RECAP` | Existing state flags and save model |
| Absurd physical actions | Nest cuisine and headwear, tree abuse, self ballistics, troll ballistics, troll storage, throwable voice and fit | Canonical eating, wearing, throwing, putting, and combat remain authoritative for normal uses |
| Absurd social actions | Hug, lick, ride, marry, apologize, insult, compliment, dance, juggle, headbutt, and yell at representative targets | NPC puzzle roles and combat state remain intact |
| Folly ledger | `FOLLY`, `NONSENSE`, and `MISCHIEF` report only discovered categories of misconduct | No unseen jokes or puzzle information are spoiled |
| Troll bemusement | A troll-targeted misconduct action suppresses only his immediate same-turn random counterattack while he processes the idea | The troll remains present, blocking, dangerous, and governed by normal combat on subsequent ordinary turns |

## Glulx parity reached

Release 1211 now ports and proves:

- a global state-neutral action hook;
- canonical goals;
- visible-exit orientation;
- three progressive hint levels;
- canonical persistent-state recap;
- contextual explanation after selected failures;
- object affordance guidance.

The same nine-move route passes under Expanded Release 121 `.z3` and Assisted Release 1211 `.ulx`.

Release 1211 does **not** yet include the expanded scenery, geography, NPC alternatives, or comedy rows listed above. Those remain present only in Release 121 `.z3` until their isolated Glulx layers qualify.

## Deliberate constraints

- Release 121 does not alter historical root files.
- It does not remove original solutions.
- It does not introduce a universal crafting system.
- It does not turn hints into automatic commands.
- It does not make every scenery noun portable.
- It does not claim every possible verb/object pairing has bespoke prose yet.
- It does not present new prose as recovered Infocom authorship.
- Comedy actions do not manufacture treasure, remove enemies, award points, or become required puzzle steps.
- Release 1201 contains no Release 121 code.
- Release 1211 contains assistance but no reactive scenery or expanded gameplay outcomes.

## Validation coverage

| Coverage | Method |
|---|---|
| Historical source identity | Git-blob manifest verification before staging |
| Expansion application | Exact-match patches with required match counts |
| ZIL structure | Reader-aware structural and include audit |
| Z-machine compiler compatibility | Pinned ZILF and ZAPF build in GitHub Actions |
| Release 121 story identity | Header, length, addresses, release, serial, and checksum verification |
| Opening reactivity | Deterministic Frotz transcript covering assistance, house, mailbox, songbird, optional room, collectible, and recap |
| Misconduct journey | Long deterministic Frotz route covering SELF, VOICE, FIT, house, tree, nest, sack, troll storage, troll ballistics, weaponized self, treasure bribery, and `FOLLY` |
| Optimized `.z3` regression | Release 120 continues to compile, verify, and run its original smoke route |
| Upstream Glulx provenance | Exact Tara commit/tree, complete seven-file diff, archive checksums, toolchain pins, and license receipts |
| Upstream Glulx runtime | Pinned Glulxe/CheapGlk identity and opening routes against repository and archived stories |
| Optimized Glulx staging | Exact four-path changed-set gate with patch, overlay, and before/after hashes |
| Optimized Glulx artifact | Fail-closed Glulx header, memory map, checksum, size, and SHA-256 |
| Optimized Glulx behavior | Native opening, recursive-containment, and extinguished-candle routes |
| Assisted Glulx staging | Exact six-path boundary, qualified Release 1201 base hash, and reviewed added module |
| Assisted Glulx artifact | Fail-closed 185,600-byte artifact, checksum `0xd3e2209e`, and SHA-256 |
| Assistance semantic parity | Shared `.z3`/`.ulx` route for goals, exits, three hint tiers, recap, use, and why |
| Beadtrain integrity | Every completed recorded v1.3 train is validated in CI against live bead records |

## Still requiring dedicated long-form transcripts

- three-turn cyclops lullaby under the existing impatience timer;
- thief bargain with a carried treasure;
- complete bell/candle/book ceremony timing;
- dam feedback across both water-level states;
- save and restore after expanded persistent-state changes;
- focused surface-world `.z3` versus `.ulx` routes for house, boards, windows, mailbox, and forest nouns.
