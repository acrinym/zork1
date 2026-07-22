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

Release `1216` persistence is a qualification-only layer over the exact locked artifact, not another production edition or identity.

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

Release 122 distinguishes harmless folly from ridiculous actions that can alter the world.

### Troll restraint

- Alert `TIE UP TROLL WITH ROPE` fails.
- `TRICK TROLL` creates a one-use immediate opportunity.
- Immediate rope restraint leaves the troll alive, drops the real axe, consumes the real rope into the restraint, and opens the passages through `TROLL-FLAG`.
- `UNTIE TROLL` restores the rope and troll danger.
- Leaving instead of tying him wastes the opportunity; returning proves he attacks and rejects the rope as alert and armed.

### Burning the nest

- `PUT SACK UNDER TREE` spreads the real brown sack beneath the branch.
- `BURN NEST WITH TORCH` requires the held, lit ivory torch and the nest still in the tree.
- With preparation, the real jewel-encrusted egg lands intact in the real sack.
- Without preparation, the real egg invokes canonical `BAD-EGG`, producing the existing broken egg and broken canary values.
- Ordinary burning with another valid flame continues through canonical `V-BURN`.
- No treasure or puzzle object is duplicated.

### Explicit boundary

- The Wizard of Frobozz is not imported into Zork I; Wizard gifts, restraint, and beard ignition belong to a future Zork II train.
- Release 122 adds no room, treasure, universal actor trick, or automatic puzzle completion.
- Release 121 remains independently reproducible.

## Glulx parity and mechanism layers

### Release 1211

Ports and proves the state-neutral action hook, goals, exits, three hint levels, canonical-state recap, contextual failure explanations, and object affordance guidance.

### Release 1212

Adds and proves:

- adjacent white-house and front-door reactions;
- rejection of remote house knocking, listening, and climbing;
- board and window responses;
- persistent board scarring and painted splinter;
- mailbox and maintenance-slip behavior;
- ordinary forest, tree, and songbird reactions;
- canonical `FOLLOW SONGBIRD` refusal and Hidden Glade exclusion.

### Release 1213

Adds and proves native `USE <object> ON/WITH <object>`, direct `ME` targeting, recoverable self-restraint, telegraphed clothing fire, physically validated bottled-water rescue, material responses, qualitative `LIGHTS`, learned `MELZAR`, mirror shadow diagnostics, mortal-folly reporting, and persistent Shadow Logic recap state.

### Release 1214

Ports only the earned Release 122 outcomes above qualified Release 1213:

- alert troll restraint failure;
- one-use timed troll distraction;
- real-rope living restraint and conditional real axe drop;
- east/west passage opening;
- `UNTIE TROLL` threat restoration;
- bound-troll reactions;
- deliberate real-sack preparation;
- intact prepared egg catch with sandwich-aware and empty-sack narration;
- unprepared canonical `BAD-EGG`;
- canonical non-torch burning;
- persistent parity state.

Release 1214 rebuilds Release 122 and compares named semantic outcomes across `dfrotz` and pinned native Glulxe. Every shared category passed. Byte parity and identical transcript wrapping are not required.

Locked Release 1214 artifact:

- `202,240` bytes;
- checksum `0x53f5066d`;
- SHA-256 `10ea136e389aef8bf9e629ea854ea97ba69f1e5df3b9024540abc91cc61f0628`.

### Release 1215

Deepens the existing Flood Control Dam #3 machinery above qualified Release 1214:

- physical `EXAMINE`, `DIAGNOSE`, `LISTEN`, `TOUCH`, and `KNOCK` responses for the panel, bolt, and green bubble;
- readable yellow/brown turning-interlock state;
- readable sluice, reservoir trend, and maintenance-leak state;
- possession-validated wrench, screwdriver, guidebook, bottled-water, and repair-material interactions;
- real `USE WRENCH ON BOLT` routing into canonical `BOLT-F`;
- canonical gate opening and closing through the real interlock, wrench, and bolt;
- untouched `I-RFILL` and `I-REMPTY` reservoir timers;
- canonical red-button room lighting, including shutdown and restoration;
- canonical blue-button leak and rising-water threat;
- wrong-tool repair rejection;
- `PUTTY` as a reasonable synonym for the real all-purpose gunk;
- canonical leak repair through `FIX-MAINT-LEAK`;
- complete dam state through learned `MELZAR`;
- persistent mechanism discoveries in `RECAP`.

Locked Release 1215 artifact:

- `207,360` bytes;
- checksum `0x3d135bb8`;
- SHA-256 `ea23c8ff739348162f32c798ff0ad6f5e8e6a4d310ad3daf5c2da58b86505eed`.

Release 1215 does not replace the canonical dam routines, invent magical controls, automatically solve the puzzle, or broaden room flooding.

### Release 1216

Deepens the existing bell, candle, black-book, mirror, and Hades ceremony above qualified Release 1215:

- observation of the cool bell and red-hot bell;
- temple, mirror, dam-machinery, and ordinary-room resonance;
- damaged-page study revealing `resonance → paired light → prayer` without naming solution objects;
- paired-candle observation while preserving canonical flame lifetime and misuse;
- read-only `CEREMONY`, `RITE`, and `RITUAL` reporting;
- possession- and flame-validated bell/candle mirror interactions;
- lit candle/book ordering feedback;
- real bottled-water cooling of the real hot bell through canonical `POUR-ON`;
- wrong-order prayer memory without state advancement;
- persistent ceremony discoveries and actual completion state in `RECAP`;
- observation only of canonical `XB`, `XC`, `LLD-FLAG`, `BELL`/`HOT-BELL`, `I-XBH`, and `GHOSTS` transitions.

Locked Release 1216 artifact:

- `211,968` bytes;
- checksum `0x3d27d123`;
- SHA-256 `4f406e656b892feb5224e4e52afb98768417e1e761918334dfa94595e6091db2`.

Release 1216 does not add spells, a second exorcism solution, automatic ceremony completion, new treasure, or supernatural room propagation.

### Release 1216 persistence qualification

A prompt-aware native Glulxe harness now proves ordinary save files preserve the highest-risk state introduced through Releases `1213`–`1216`:

- living bound troll, committed rope, dropped axe, and open passages;
- prepared intact egg in the real sack;
- canonical broken egg with broken canary and the original egg removed;
- dam interlock, open sluices, and the queued eight-turn reservoir interrupt;
- active rising leak and independently repaired `WATER-LEVEL = -1` snapshot;
- completed canonical exorcism, learned and wrong-order memory, mirror resonance, ghost removal, transformed bell, and queued 20-turn hot-bell cooldown;
- `MELZAR`, `CEREMONY`, and `RECAP` agreement immediately after restore;
- repeated deterministic restore without duplicate treasure, canaries, rope, axe, bells, ghosts, or containers.

Production Release `1216` is rebuilt and verified byte-for-byte before a separate test-only story is created. No persistence probe enters the production artifact and no state is repaired after `RESTORE`.

## Validation coverage

| Coverage | Method |
|---|---|
| Historical source identity | Git-blob manifest verification before staging |
| Release 121 | Exact staging, pinned ZILF/ZAPF build, story verification, and deterministic Frotz routes |
| Release 122 staging | Complete Release 121 stage followed by an exact five-path changed-set gate |
| Release 122 artifact | Fail-closed 107,992-byte `.z3`, checksum `0x3ab5`, and SHA-256 `58153ea7f2b59dfc94ca2367ae2e4507e3eef02d14c60023790953a8415498db` |
| Release 1214 staging | Complete qualified Release 1213 stage followed by an exact five-path changed-set gate |
| Release 1214 artifact | Fail-closed 202,240-byte `.ulx`, checksum `0x53f5066d`, and SHA-256 `10ea136e389aef8bf9e629ea854ea97ba69f1e5df3b9024540abc91cc61f0628` |
| Release 1215 staging | Complete qualified Release 1214 stage followed by an exact five-path changed-set gate |
| Release 1215 artifact | Fail-closed 207,360-byte `.ulx`, checksum `0x3d135bb8`, and SHA-256 `ea23c8ff739348162f32c798ff0ad6f5e8e6a4d310ad3daf5c2da58b86505eed` |
| Release 1216 staging | Complete qualified Release 1215 stage followed by an exact five-path changed-set gate |
| Release 1216 artifact | Fail-closed 211,968-byte `.ulx`, checksum `0x3d27d123`, and SHA-256 `4f406e656b892feb5224e4e52afb98768417e1e761918334dfa94595e6091db2` |
| Troll alternate | Real-map rope acquisition, alert failure, trick, restraint, conditional axe drop, passage travel, description, untie restoration, and recap |
| Prepared nest alternate | Test-only setup story exercises production mechanics and proves intact accessible egg, both cushioning narrations, and corrected prose |
| Destructive nest alternate | Canonical `BAD-EGG` produces the existing ruined egg and broken canary |
| Dam mechanism route | Test-only positioning story exercises production panel diagnostics, possession checks, both gate directions, bottled-water validation, red lighting, blue leak, wrong tools, repair, and recap |
| Canonical dam preservation | Production wrappers delegate `BUTTON-F`, `BOLT-F`, and `PLUG`; reservoir and flooding interrupts remain untouched |
| Ritual resonance route | Test-only positioning story proves page discovery, temple and mirror resonance, wrong-order preservation, canonical exorcism, hot-bell cooling, ceremony state, and recap |
| Canonical exorcism preservation | Production wrapper delegates `LLD-ROOM`; only original `XB`, `XC`, `LLD-FLAG`, timers, object exchange, and ghost removal advance the puzzle |
| Native save-file driver | PTY-backed JSON scenarios answer real Glulxe filename prompts, capture transcripts, enforce timeouts and exit status, and preserve regex syntax |
| Troll and egg persistence | Deliberate corruption followed by repeated restore proves bound troll, rope, axe, passages, intact catch, broken egg/canary, and object uniqueness |
| Dam persistence | Restored interlock, gates, active reservoir timer, active leak, repaired sentinel, and game-facing `MELZAR` state |
| Ritual persistence | Restored completion, knowledge, wrong-order and mirror memory, ghosts, transformed bell, cooldown timer, `CEREMONY`, and `RECAP` |
| Production/test isolation | Production source and artifacts contain no qualification setup verbs or setup modules |
| Cross-VM parity | Rebuild both locked Release 122 and 1214 artifacts, run their native interpreters, and compare shared outcome categories |
| Beadtrain integrity | Completed and active trains validate against canonical and sharded issue ledgers |

## Still requiring dedicated work

- deeper non-dam rope, water, shovel, axe, wrench, container, and scenery interactions;
- dedicated cyclops-lullaby and thief-bargain long routes;
- additional earned alternate solutions that use real objects, preparation, risk, and canonical consequences;
- room-density and parser-kindness passes for visible nouns and reasonable physical intent;
- optional geography and broader character-layer Glulx ports kept separate from Releases 1214–1216.
