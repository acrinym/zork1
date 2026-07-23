# Zork I Glulx lineage

This directory defines the additive, unofficial Glulx lineage for this repository.

Ten production layers are represented. Release `1216` also has a qualification-only persistence train; Releases `1217` and `1218` add their own focused gameplay and save/restore qualifications without altering older artifacts.

| Layer | Identity | Purpose |
|---|---:|---|
| Unchanged upstream baseline | Release 1 / serial `251203` | Reproduce and qualify Tara McGrew's existing Glulx port without project changes |
| Unofficial Optimized Glulx | Release 1201 / serial `260719` | Port only the conservative corrections from project Release 120 |
| Unofficial Assisted Glulx | Release 1211 / serial `260719` | Port Release 121 action hooks and optional assistance with cross-VM semantic parity |
| Unofficial Reactive Surface Glulx | Release 1212 / serial `260719` | Port proximity-safe white-house, door, board, window, mailbox, forest, tree, and songbird reactions without optional geography |
| Unofficial Shadow Logic Glulx | Release 1213 / serial `260720` | Add native object-on-object experimentation, player consequences, material responses, light reporting, learned maintenance knowledge, and folly memory |
| Unofficial Absurd Alternate Glulx | Release 1214 / serial `260720` | Port the earned Release 122 troll-restraint and nest-fire outcomes without broader comedy or optional geography |
| Unofficial Dam Mechanisms Glulx | Release 1215 / serial `260720` | Make the real dam panel, interlock, bolt, buttons, leak, tools, reservoir state, and repair consequences readable and experimentally useful |
| Unofficial Ritual Resonance Glulx | Release 1216 / serial `260720` | Deepen the real bell, candles, black book, mirrors, hot bell, and canonical exorcism without adding a spell system or alternate solution |
| Unofficial Material Consequences Glulx | Release 1217 / serial `260722` | Add focused non-dam rope, water, tool, sack, nest, rust, and boarded-surface consequences without generalized crafting or physics |
| Unofficial Room Density Glulx | Release 1218 / serial `260723` | Make explicitly described room scenery targetable through bounded canonical actions without a universal or free-form parser |

Historical Release 119, Optimized Release 120, Expanded Release 121, and Absurd Alternate Release 122 remain supported `.z3` editions and are not replaced or relabeled.

## Unchanged upstream baseline

The baseline builds Tara McGrew's unchanged `taradinoc/zork1` `glulx` source at commit `1ada70e58ac4933446b907d67949d9cab3119c0e`.

### Locked repository artifact

- output: `zork1-glulx-upstream.ulx`
- identity: Release `1` / serial `251203`
- Glulx version: `3.1.3` / `0x00030103`
- size: `180,736` bytes
- checksum: `0xad5a809b`, valid
- SHA-256: `15dd2b654693e4f1c63e09a2308de1f366913c13be080baa33af3f76c5679ac8`

The IF Archive reference is independently verified as a different toolchain build with the same Release 1 identity. Both stories open at West of House and run through pinned Glulxe/CheapGlk.

## Unofficial Optimized Glulx

Release `1201` stages Tara's exact source and ports recursive-containment protection, printed-character portability corrections, dynamic temple-candle descriptions, lowercase include portability, and a repository-local identity.

### Locked artifact

- output: `zork1-glulx-optimized.ulx`
- identity: Release `1201` / serial `260719`
- size: `180,992` bytes
- checksum: `0xaa478295`, valid
- SHA-256: `f2f64b0696e91f325602f6d4f1a91182a940bfd28105576662bd54bdeb37d051`

See [`optimized/README.md`](optimized/README.md).

## Unofficial Assisted Glulx

Release `1211` adds the state-neutral action hook, `GOALS`, `EXITS`, three-tier `HINT`, `RECAP`, contextual `WHY`, and `USE <object>` guidance, with shared semantic routes against Expanded Release 121 `.z3`.

### Locked artifact

- output: `zork1-glulx-assisted.ulx`
- identity: Release `1211` / serial `260719`
- size: `185,600` bytes
- checksum: `0xd3e2209e`, valid
- SHA-256: `cf5e51d414bd786bdb4e911263534dcb5c9c61aaebc35b944a96e5269a864777`

See [`assistance/README.md`](assistance/README.md).

## Unofficial Reactive Surface Glulx

Release `1212` adds proximity-safe white-house and front-door reactions, board and window behavior, persistent scarring and painted splinter, mailbox maintenance slip, ordinary forest/tree/songbird reactions, and surface discoveries in `RECAP`.

### Locked artifact

- output: `zork1-glulx-reactive-surface.ulx`
- identity: Release `1212` / serial `260719`
- size: `189,440` bytes
- checksum: `0x01ea5062`, valid
- SHA-256: `78bbfd36d03c29714c4ccf0aac45f314568db1ef60aa37732167891a7329e002`

The route proves remote physical actions are rejected, ordinary forest/tree behavior works, `FOLLOW SONGBIRD` remains refused, and Hidden Glade is absent.

See [`reactive-surface/README.md`](reactive-surface/README.md).

## Unofficial Shadow Logic Glulx

Release `1213` adds:

- native `USE <object> ON/WITH <object>` routing;
- player targeting through the real `ME` object;
- recoverable self-restraint;
- telegraphed clothing fire and physically validated water rescue;
- material-specific responses;
- qualitative `LIGHTS` reporting;
- learned `MELZAR` and `WORDS`;
- mirror-shadow diagnostics;
- discovered mortal-folly reports;
- persistent state in `RECAP`.

### Locked artifact

- output: `zork1-glulx-shadow-logic.ulx`
- identity: Release `1213` / serial `260720`
- size: `197,376` bytes
- checksum: `0x2b0521e4`, valid
- SHA-256: `3b69b321537641dc9758b1a4eca9d5677f320a9eb6d41143f1a4af419d14b75e`

Qualification includes a real-map route, an isolated laboratory using production logic, and terminal consequence routes. Production contains no setup verb.

See [`shadow-logic/README.md`](shadow-logic/README.md).

## Unofficial Absurd Alternate Glulx

Release `1214` ports only the earned Release 122 outcomes:

- alert troll-restraint failure;
- one-use timed troll distraction;
- living restraint with the real rope;
- conditional drop of the real axe;
- east/west passage opening;
- `UNTIE TROLL` danger restoration;
- bound-troll reactions;
- deliberate real-sack preparation;
- intact prepared egg catch;
- unprepared canonical `BAD-EGG`;
- canonical non-torch burning;
- persistent parity state.

### Locked artifact

- output: `zork1-glulx-absurd-alternates.ulx`
- identity: Release `1214` / serial `260720`
- size: `202,240` bytes
- checksum: `0x53f5066d`, valid
- SHA-256: `10ea136e389aef8bf9e629ea854ea97ba69f1e5df3b9024540abc91cc61f0628`

Qualification rebuilds locked Release 122 `.z3` and compares shared semantic outcomes under native interpreters.

See [`absurd-alternates/README.md`](absurd-alternates/README.md).

## Unofficial Dam Mechanisms Glulx

Release `1215` deepens Flood Control Dam #3 without replacing its canonical state machine:

- readable panel, bubble, bolt, button, sluice, reservoir, and leak state;
- possession-validated wrench, screwdriver, guidebook, water, and repair interactions;
- canonical interlock and wrench/bolt gate cycle;
- untouched reservoir timing;
- canonical room lighting and leak escalation;
- wrong-tool feedback and real all-purpose-gunk repair;
- complete `MELZAR` diagnostics;
- persistent mechanism discoveries.

### Locked artifact

- output: `zork1-glulx-dam-mechanisms.ulx`
- identity: Release `1215` / serial `260720`
- size: `207,360` bytes
- checksum: `0x3d135bb8`, valid
- SHA-256: `ea23c8ff739348162f32c798ff0ad6f5e8e6a4d310ad3daf5c2da58b86505eed`

See [`dam-mechanisms/README.md`](dam-mechanisms/README.md).

## Unofficial Ritual Resonance Glulx

Release `1216` deepens the canonical exorcism materials while leaving the original state machine authoritative:

- ordinary and hot-bell observation;
- temple, mirror, dam-machinery, and ordinary-room resonance;
- damaged-page study revealing order without naming solution objects;
- paired-candle observation with original timers and misuse;
- read-only `CEREMONY`, `RITE`, and `RITUAL` reporting;
- mirror interactions;
- ordering feedback;
- real-water hot-bell cooling;
- persistent wrong-order, resonance, cooling, and completion state;
- observation only of canonical `XB`, `XC`, `LLD-FLAG`, bell exchange, timers, and ghost removal.

### Locked artifact

- output: `zork1-glulx-ritual-resonance.ulx`
- identity: Release `1216` / serial `260720`
- size: `211,968` bytes
- checksum: `0x3d27d123`, valid
- SHA-256: `4f406e656b892feb5224e4e52afb98768417e1e761918334dfa94595e6091db2`

See [`ritual-resonance/README.md`](ritual-resonance/README.md).

## Release 1216 persistence qualification

A qualification-only train over the unchanged Release `1216` artifact proves ordinary native Glulxe save files preserve:

- living bound troll, committed rope, dropped axe, and open passages;
- prepared intact egg and canonical broken egg/broken canary object trees;
- dam interlock, sluices, active reservoir timing, active leak, and repaired sentinel;
- learned `MELZAR` and restored dam reporting;
- completed exorcism, learned/wrong-order/mirror memory, ghost removal, transformed bell, and hot-bell cooldown;
- restored `CEREMONY` and `RECAP` agreement;
- deterministic repeated restore without object duplication.

No production identity or save format changes were introduced.

See [`persistence/README.md`](persistence/README.md).

## Unofficial Material Consequences Glulx

Release `1217` is the ninth production layer. It derives from exact Release `1216` and changes exactly four staged paths.

It adds:

- recoverable rope anchors at selected reachable scenery;
- real-rope cinching of the real brown sack;
- movement, tension, drop/give, opening, and `UNTIE` consequences;
- real-water cleaning state for shovel, wrench, screwdriver, and axe;
- timed worsening corrosion when the rusty knife is washed and left wet;
- temporary soaking of the real nest;
- failed torch ignition while wet and ordinary turn-based drying;
- delegation to canonical prepared or destructive egg outcomes after drying;
- distinct shovel, screwdriver, and wrench experiments at the boarded entrance;
- painted-splinter reuse while preserving the inaccessible front door;
- persistent material discoveries in `RECAP`.

### Locked artifact

- output: `zork1-glulx-material-consequences.ulx`
- identity: Release `1217` / serial `260722`
- Glulx version: `3.1.3` / `0x00030103`
- size: `217,344` bytes
- checksum: `0xb0028984`, valid
- SHA-256: `2714d63760fa890be9ece3b23fc91bab67a660c42675e0302b745173aba700da`

Qualification includes a deterministic native route and prompt-aware save/restore scenarios for anchored rope, cinched sack, board discoveries, cleaned shovel, worsened rust, and the active wet-nest timer. Test-only setup and mutation commands are rejected from production.

See [`material-consequences/README.md`](material-consequences/README.md).

## Unofficial Room Density Glulx

Release `1218` is the tenth production layer. It derives from exact Release `1217` and changes exactly four staged paths.

It adds bounded room-scoped responses for nouns explicitly advertised in:

- Troll Room;
- Gallery;
- Studio;
- East of Chasm;
- Strange Passage;
- Treasure Room;
- Forest Path;
- Stream View.

The layer uses existing parser actions such as examination, search, listening, smell, touch, knock, push, pull, and looking in/under/behind. Established openings delegate to existing map exits. No portable scenery, hidden route, treasure, score, timer, actor state, or alternate solution is added.

### Locked artifact

- output: `zork1-glulx-room-density.ulx`
- identity: Release `1218` / serial `260723`
- Glulx version: `3.1.3` / `0x00030103`
- size: `227,840` bytes
- checksum: `0x3b65ecaf`, valid
- SHA-256: `efc8bd9f264f60bb56f2daf3e4d7d6d32a272997434802ee76455781a8edf521`

Qualification includes a deterministic native room tour, canonical travel delegation, persistent `RECAP` categories, and prompt-aware save/restore after deliberate clearing of all discovery flags. Test-only positioning, actor isolation, mutation, and reporting commands are rejected from production.

See [`room-density/README.md`](room-density/README.md).

## Locked toolchain

All ten production layers and their qualification routes use:

- ZILF 1.8: `45c60f1e37651f266ac92d49ae01748bb4909fa5`
- Glazer 1.2.0: `1cc80bcdefb4b4125185e1170eb1ee178e97ff5a`
- Glazer source SHA-256: `a45edadb140111b5df44a3f49ca4e2b8ec0550d63a6cdee7c93bec93a79ed482`
- Glulxe: `56ab8743bab565de307bd892c555d8d8897ed517`
- CheapGlk: `14d8aaf6e4150669762bd4646a5368e75c1eeee6`

Release 122 semantic parity uses its separately pinned Version 3 ZILF/ZAPF and `dfrotz` pipeline.

## Deterministic serial normalization

Pinned ZILF emits Glulx metadata serial using the build date. Each production pipeline compiles to Glazer assembly, replaces exactly one generated serial with the edition's committed serial, and assembles the normalized output. Replacement count and artifact SHA are fail-closed.

## Next porting boundary

Release `1218` completes the first focused room-density and parser-kindness train. Additional parser work should begin from demonstrated failures rather than another universal sweep.

The strongest next candidates are:

1. restored troll restraint, `UNTIE`, queued recovery, weapon reacquisition, and renewed danger;
2. cyclops impatience and lullaby timing;
3. thief bargain with carried real treasure;
4. focused actor memory for gifts, threats, mercy, deception, and restraint;
5. optional geography only where story or puzzle logic justifies it.

Hidden Glade, songbird geography, broad character alternatives, generalized crafting, broad fire/flood propagation, Version 3 object-slot cleanup, and the Wizard of Frobozz remain separate scope.
