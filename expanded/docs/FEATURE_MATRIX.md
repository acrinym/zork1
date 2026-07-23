# Zork I project-edition feature matrix

## Edition and format status

| Edition | Format | Identity | Status |
|---|---|---:|---|
| Historical | `.z3` | Release 119 / `880429` | Preserved and verified |
| Optimized | `.z3` | Release 120 / `260718` | Qualified |
| Expanded | `.z3` | Release 121 / `260719` | Qualified reactive world, assistance, alternate characters, and misconduct |
| Absurd Alternate | `.z3` | Release 122 / `260720` | Qualified earned troll-restraint and nest-fire outcomes |
| Unchanged upstream Glulx | `.ulx` | Release 1 / `251203` | Qualified against Tara McGrew's exact source and archived reference |
| Unofficial Optimized Glulx | `.ulx` | Release 1201 / `260719` | Qualified conservative corrections and native regressions |
| Unofficial Assisted Glulx | `.ulx` | Release 1211 / `260719` | Qualified action hooks and assistance parity |
| Unofficial Reactive Surface Glulx | `.ulx` | Release 1212 / `260719` | Qualified proximity-safe white-house surface reactions |
| Unofficial Shadow Logic Glulx | `.ulx` | Release 1213 / `260720` | Qualified native experimentation, player consequences, diagnostics, and folly ledger |
| Unofficial Absurd Alternate Glulx | `.ulx` | Release 1214 / `260720` | Qualified Release 122 semantic parity and locked artifact identity |
| Unofficial Dam Mechanisms Glulx | `.ulx` | Release 1215 / `260720` | Qualified panel, interlock, sluice, lighting, leak, repair, diagnostic, and recap mechanics |
| Unofficial Ritual Resonance Glulx | `.ulx` | Release 1216 / `260720` | Qualified bell, candle, black-book, mirror, hot-bell, ceremony-report, and canonical exorcism-preserving interactions |
| Unofficial Material Consequences Glulx | `.ulx` | Release 1217 / `260722` | Qualified rope anchors, sack cinching, water/tool/rust state, nest soaking, boarded-surface experiments, recap, and persistence |

Release `1216` persistence remains a qualification-only train over its exact locked artifact. Release `1217` is a separate production edition with its own locked artifact and focused persistence routes.

## Release 121 interaction foundation

| Area | Expanded behavior | Canonical behavior retained |
|---|---|---|
| Player orientation | `GOALS`, `EXITS`, tiered `HINT`, `RECAP`, `WHY`, and `USE <object>` | Traditional parser play remains available; assistance is optional |
| White house | Repeated knocking, listening, roof-climb explanation, structural responses | Original entry route, navigation, and proximity rules |
| Boards and windows | Tool-sensitive scarring, painted splinter, sound and visibility responses | Boards remain secured; kitchen-window traversal remains canonical |
| Mailbox | Hidden maintenance slip after leaflet removal | Original leaflet and mailbox sequence |
| Forest songbird | Followable trail, Hidden Glade, brass feather, remembered discovery | Original forest graph and egg/canary puzzle |
| Troll | Genuine-treasure bribe as a noncombat route | Original combat, disarming, gifts, and weapons |
| Cyclops | Repeated lullaby route and richer feedback | Original pepper/water and Odysseus solutions |
| Thief | One-time bargain consuming real treasure | Existing roaming, theft, combat, and treasure behavior |
| Dam and ritual | State-aware mechanism and ceremony feedback | Original dam and exorcism solutions |
| Adventurer Misconduct | Absurd physical/social actions, `FOLLY`, and one-turn troll bemusement | Canonical combat, containers, NPC roles, and scoring |

## Release 122 earned absurd outcomes

### Troll restraint

- Alert `TIE UP TROLL WITH ROPE` fails.
- `TRICK TROLL` creates one immediate opportunity.
- Immediate restraint leaves the troll alive, drops the real axe when carried, commits the real rope, and opens the passages through `TROLL-FLAG`.
- `UNTIE TROLL` restores rope and danger.
- Wasting the opening returns ordinary hostility.

### Burning the nest

- `PUT SACK UNDER TREE` spreads the real brown sack.
- `BURN NEST WITH TORCH` requires the held, lit ivory torch and the real nest in the tree.
- Preparation preserves the real egg.
- No preparation invokes canonical `BAD-EGG`, producing the existing broken egg and broken canary.
- Ordinary burning delegates to canonical `V-BURN`.
- No treasure or puzzle object is duplicated.

## Glulx production layers

### Release 1211 — assistance

Ports the state-neutral action hook, goals, exits, three hint levels, canonical-state recap, contextual failure explanations, and object affordance guidance.

### Release 1212 — reactive surface

Adds proximity-safe house/door reactions, boards, painted splinter, kitchen window, mailbox maintenance slip, ordinary forest/tree/songbird responses, and native proof that Hidden Glade remains excluded.

### Release 1213 — Shadow Logic

Adds native `USE X ON Y`, direct `ME` targeting, recoverable self-restraint, telegraphed clothing fire, physically validated bottled-water rescue, material responses, qualitative `LIGHTS`, learned `MELZAR`, mirror-shadow diagnostics, mortal-folly reporting, and persistent recap state.

### Release 1214 — earned absurd parity

Ports the Release 122 troll-restraint and nest-fire outcomes above exact Release 1213. Qualification rebuilds Release 122 `.z3` and compares shared semantic outcomes under native interpreters.

Locked artifact:

- `202,240` bytes;
- checksum `0x53f5066d`;
- SHA-256 `10ea136e389aef8bf9e629ea854ea97ba69f1e5df3b9024540abc91cc61f0628`.

### Release 1215 — dam mechanisms

Deepens Flood Control Dam #3 with physical diagnostics, possession-validated tools, canonical interlock and gate cycling, untouched reservoir timers, canonical lighting and leak escalation, wrong-tool feedback, real repair, complete `MELZAR`, and persistent discoveries.

Locked artifact:

- `207,360` bytes;
- checksum `0x3d135bb8`;
- SHA-256 `ea23c8ff739348162f32c798ff0ad6f5e8e6a4d310ad3daf5c2da58b86505eed`.

### Release 1216 — ritual resonance

Deepens the real bell, candles, black book, mirrors, hot bell, and canonical exorcism while preserving original state, timers, object exchange, ghost removal, and solution order.

Locked artifact:

- `211,968` bytes;
- checksum `0x3d27d123`;
- SHA-256 `4f406e656b892feb5224e4e52afb98768417e1e761918334dfa94595e6091db2`.

### Release 1216 persistence qualification

The prompt-aware native Glulxe driver proves ordinary saves preserve:

- bound troll, rope, axe, and open passages;
- intact and broken egg/canary object trees;
- dam interlock, gates, reservoir timer, active leak, and repaired sentinel;
- ritual knowledge, completion, ghosts, transformed bell, and hot-bell timer;
- restored `MELZAR`, `CEREMONY`, and `RECAP`;
- deterministic repeated restore without duplication.

No Release 1216 production identity or save format changed.

### Release 1217 — material consequences

Release `1217` derives from exact Release `1216` and changes exactly:

- `zork1.zil`;
- `shadow_logic.zil`;
- `assistance.zil`;
- new `material_consequences.zil`.

Implemented and qualified:

1. recoverable real-rope anchors at selected reachable scenery;
2. tension, movement, drop/give, and `UNTIE` behavior;
3. real-rope cinching and recovery of the real brown sack;
4. refusal to sabotage the prepared egg-catching sack;
5. real-water cleaning state for shovel, wrench, screwdriver, and axe;
6. timed wet and worsening-rust state for the rusty knife;
7. temporary soaking of the real nest;
8. failed ivory-torch ignition while wet;
9. ordinary turn-based drying;
10. delegation to original prepared or canonical destructive egg outcomes after drying;
11. distinct shovel, screwdriver, and wrench experiments at the boarded entrance;
12. painted-splinter reuse without creating a new front-door solution;
13. persistent material discoveries in `RECAP`;
14. save/restore of anchored rope, cinched sack, board discoveries, cleaned shovel, worsened rust, and wet-nest timer;
15. restored constraints that remain behaviorally active after `RESTORE`.

Locked artifact:

- Release `1217` / serial `260722`;
- Glulx `3.1.3` / `0x00030103`;
- `217,344` bytes;
- checksum `0xb0028984`;
- SHA-256 `2714d63760fa890be9ece3b23fc91bab67a660c42675e0302b745173aba700da`.

Release `1217` does not add generalized crafting, universal physics, a new house entrance, permanent tool destruction, broad fire/flood propagation, treasure, scoring, or automatic puzzle completion.

## Validation coverage

| Coverage | Method |
|---|---|
| Historical source identity | Git-blob manifest verification before staging |
| Release 121 | Exact staging, pinned ZILF/ZAPF build, story verification, and deterministic Frotz routes |
| Release 122 artifact | Fail-closed 107,992-byte `.z3`, checksum `0x3ab5`, SHA-256 `58153ea7f2b59dfc94ca2367ae2e4507e3eef02d14c60023790953a8415498db` |
| Release 1214 artifact | Fail-closed 202,240-byte `.ulx`, checksum `0x53f5066d`, SHA-256 `10ea136e389aef8bf9e629ea854ea97ba69f1e5df3b9024540abc91cc61f0628` |
| Release 1215 artifact | Fail-closed 207,360-byte `.ulx`, checksum `0x3d135bb8`, SHA-256 `ea23c8ff739348162f32c798ff0ad6f5e8e6a4d310ad3daf5c2da58b86505eed` |
| Release 1216 artifact | Fail-closed 211,968-byte `.ulx`, checksum `0x3d27d123`, SHA-256 `4f406e656b892feb5224e4e52afb98768417e1e761918334dfa94595e6091db2` |
| Release 1217 staging | Exact Release 1216 stage followed by an exact four-path changed-set gate |
| Release 1217 artifact | Fail-closed 217,344-byte `.ulx`, checksum `0xb0028984`, SHA-256 `2714d63760fa890be9ece3b23fc91bab67a660c42675e0302b745173aba700da` |
| Troll alternate | Real rope acquisition, timed opening, restraint, axe drop, passage travel, untie restoration, and recap |
| Egg outcomes | Prepared intact catch and canonical `BAD-EGG` broken egg/canary state |
| Dam mechanisms | Panel diagnostics, possession checks, both gate directions, lighting, leak, wrong tools, repair, and recap |
| Ritual resonance | Page discovery, resonance, wrong-order preservation, canonical exorcism, hot-bell cooling, ceremony state, and recap |
| Release 1216 persistence | Deliberate corruption and restore of troll, egg, dam, leak, ritual, timers, objects, and reports |
| Release 1217 gameplay | Native route for boards, rope, sack, water, tools, rust, wet nest, drying, canonical destructive egg, and recap |
| Release 1217 persistence | Two native saves prove composite material state, wet-timer resumption, restored movement blocking, and restored sack-opening refusal |
| Production/test isolation | Production source contains no setup, positioning, mutation, or report verbs from qualification stories |
| Cross-VM parity | Locked Release 122 and 1214 artifacts run under their native interpreters and compare shared semantic outcomes |
| Beadtrain integrity | Completed and active trains validate against canonical and sharded issue ledgers |

## Still requiring dedicated work

- room-density and parser-kindness passes for visible nouns and reasonable physical intent;
- dedicated renewed-troll-danger, cyclops-lullaby, and thief-bargain long routes;
- focused character memory for gifts, threats, mercy, deception, and restraint;
- additional earned alternate solutions only where objects, preparation, risk, and canonical consequences justify them;
- optional geography and broader character-layer Glulx ports kept separate;
- Version 3 object-slot cleanup where Glulx no longer needs the workaround.
