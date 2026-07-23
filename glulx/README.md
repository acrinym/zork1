# Zork I Glulx lineage

This directory defines the additive, unofficial Glulx lineage for this repository.

Eight production layers are represented, followed by a qualification-only persistence train over exact Release `1216`:

| Layer | Identity | Purpose |
|---|---:|---|
| Unchanged upstream baseline | Release 1 / serial `251203` | Reproduce and qualify Tara McGrew's existing Glulx port without project changes |
| Unofficial Optimized Glulx | Release 1201 / serial `260719` | Port only the conservative corrections from project Release 120 |
| Unofficial Assisted Glulx | Release 1211 / serial `260719` | Port Release 121 action hooks and optional assistance with cross-VM semantic parity |
| Unofficial Reactive Surface Glulx | Release 1212 / serial `260719` | Port proximity-safe white-house, door, board, window, mailbox, forest, tree, and songbird reactions without optional geography |
| Unofficial Shadow Logic Glulx | Release 1213 / serial `260720` | Add native object-on-object experimentation, player-state consequences, material responses, light reporting, learned maintenance knowledge, and a discovered-folly ledger |
| Unofficial Absurd Alternate Glulx | Release 1214 / serial `260720` | Port the earned Release 122 troll-restraint and prepared nest-fire outcomes without importing broader comedy or optional geography |
| Unofficial Dam Mechanisms Glulx | Release 1215 / serial `260720` | Make the real dam panel, interlock, bolt, buttons, leak, tools, reservoir state, and repair consequences readable and experimentally useful |
| Unofficial Ritual Resonance Glulx | Release 1216 / serial `260720` | Deepen the real bell, candles, black book, mirrors, hot bell, and canonical exorcism without adding a spell system or alternate solution |

Historical Release 119, Optimized Release 120, Expanded Release 121, and Absurd Alternate Release 122 remain supported `.z3` editions and are not replaced or relabeled.

## Unchanged upstream baseline

The baseline builds Tara McGrew's unchanged `taradinoc/zork1` `glulx` source at commit `1ada70e58ac4933446b907d67949d9cab3119c0e`.

### Locked repository artifact

- output: `zork1-glulx-upstream.ulx`
- Glulx version: `3.1.3` / `0x00030103`
- size: `180,736` bytes
- checksum: `0xad5a809b`, valid
- SHA-256: `15dd2b654693e4f1c63e09a2308de1f366913c13be080baa33af3f76c5679ac8`

The repository artifact is not expected to be byte-identical to Tara's archived December 2025 binary because it is rebuilt with the current pinned ZILF 1.8 toolchain. Both artifacts are independently verified and run through the same pinned native interpreter.

### Archived reference

The IF Archive `zork1-glulx.zip` is inspected as an external reference:

- ZIP size: `83,407` bytes
- ZIP SHA-256: `6e9879f36d7d15ddebee1333244be016a9f3a40756718292264815e8881c51ad`
- story member: `zork1.ulx`
- story size: `167,424` bytes
- story checksum: `0xde2ebee4`, valid
- story SHA-256: `42b74ce1ce32e9f483418409642b1be425e66e93c7741961e90917e2bb30b129`

Both stories identify themselves as Release 1 / serial `251203`, open at West of House, and run successfully with pinned Glulxe and CheapGlk.

## Unofficial Optimized Glulx

The second layer stages Tara's exact source tree and ports recursive-containment protection, printed-character portability corrections, dynamic temple-candle descriptions, lowercase include portability, and a separate repository-local identity.

### Locked optimized artifact

- output: `zork1-glulx-optimized.ulx`
- identity: Release `1201` / serial `260719`
- Glulx version: `3.1.3` / `0x00030103`
- size: `180,992` bytes
- checksum: `0xaa478295`, valid
- SHA-256: `f2f64b0696e91f325602f6d4f1a91182a940bfd28105576662bd54bdeb37d051`

The staging gate permits changes to exactly four paths. Native qualification proves opening identity, recursive-containment rejection, and extinguished-candle behavior.

See [`optimized/README.md`](optimized/README.md).

## Unofficial Assisted Glulx

The third layer derives explicitly from the Release 1201 manifest and artifact hash. It adds a state-neutral action hook, `GOALS`, `EXITS`, three-tier `HINT`, `RECAP`, contextual `WHY`, `USE <object>` guidance, and equivalent semantic routes against Expanded Release 121 `.z3`.

### Locked assisted artifact

- output: `zork1-glulx-assisted.ulx`
- identity: Release `1211` / serial `260719`
- Glulx version: `3.1.3` / `0x00030103`
- size: `185,600` bytes
- checksum: `0xd3e2209e`, valid
- SHA-256: `cf5e51d414bd786bdb4e911263534dcb5c9c61aaebc35b944a96e5269a864777`

The shared route proves every assistance command under `dfrotz` and pinned Glulxe/CheapGlk.

See [`assistance/README.md`](assistance/README.md).

## Unofficial Reactive Surface Glulx

The fourth layer derives explicitly from the Release 1211 manifest and artifact hash. It adds only:

- repeated white-house and front-door reactions;
- proximity checks preventing remote physical or auditory house actions;
- board and boarded-window behavior;
- persistent damage and a painted splinter;
- kitchen-window reactions while preserving traversal;
- mailbox reactions and the maintenance slip;
- ordinary forest and tree reactions;
- songbird listening and greeting without following;
- surface-state entries in `RECAP`.

### Locked reactive-surface artifact

- output: `zork1-glulx-reactive-surface.ulx`
- identity: Release `1212` / serial `260719`
- Glulx version: `3.1.3` / `0x00030103`
- size: `189,440` bytes
- checksum: `0x01ea5062`, valid
- SHA-256: `78bbfd36d03c29714c4ccf0aac45f314568db1ef60aa37732167891a7329e002`

A real-map route passes in Expanded Release 121 `.z3` and Release 1212 `.ulx`. A separate native route proves distant house actions are rejected, forest/tree behavior works, `FOLLOW SONGBIRD` remains refused, and Hidden Glade is absent.

See [`reactive-surface/README.md`](reactive-surface/README.md).

## Unofficial Shadow Logic Glulx

The fifth layer derives explicitly from the Release 1212 manifest and artifact hash. It adds:

- `USE <object> ON/WITH <object>` routing that delegates established effects to canonical actions;
- native targeting of the player through the real Glulx `ME` object;
- rope restraint and recoverable movement blocking;
- telegraphed multi-turn clothing-fire state with bottled-water recovery;
- failed empty or closed bottle attempts that no longer pause fire escalation;
- material-specific touch and knock responses;
- qualitative `LIGHTS` reporting;
- the learned bare maintenance word `MELZAR` and `WORDS` report;
- mirror/light delayed-shadow behavior;
- `FOLLIES`, `MORTAL FOLLIES`, and `DEATHS` discovery reports;
- Shadow Logic state in `RECAP`.

### Locked Shadow Logic artifact

- output: `zork1-glulx-shadow-logic.ulx`
- identity: Release `1213` / serial `260720`
- Glulx version: `3.1.3` / `0x00030103`
- size: `197,376` bytes
- checksum: `0x2b0521e4`, valid
- SHA-256: `3b69b321537641dc9758b1a4eca9d5677f320a9eb6d41143f1a4af419d14b75e`

Qualification includes a real-map production route, an isolated startup-state laboratory using production logic, and separate terminal consequence routes. The production artifact contains no setup verb or test-only world mutation.

See [`shadow-logic/README.md`](shadow-logic/README.md).

## Unofficial Absurd Alternate Glulx

The sixth layer derives explicitly from the Release 1213 manifest and artifact hash. It ports the earned Release 122 outcomes as an isolated semantic layer:

- alert troll restraint failure;
- a one-use, timed `TRICK TROLL` opening;
- living restraint with the real rope;
- conditional drop of the real axe;
- east/west passage opening through existing world state;
- `UNTIE TROLL` restoration of rope, hostility, and danger;
- bound-troll reactions;
- deliberate `PUT SACK UNDER TREE` preparation;
- intact catch of the real egg with sandwich-aware or empty-sack narration;
- unprepared descent through canonical `BAD-EGG`;
- canonical non-torch burning everywhere else;
- persistent parity state in `RECAP`.

### Locked absurd-alternate artifact

- output: `zork1-glulx-absurd-alternates.ulx`
- identity: Release `1214` / serial `260720`
- Glulx version: `3.1.3` / `0x00030103`
- size: `202,240` bytes
- checksum: `0x53f5066d`, valid
- SHA-256: `10ea136e389aef8bf9e629ea854ea97ba69f1e5df3b9024540abc91cc61f0628`

Qualification rebuilds the locked Release 122 `.z3` artifact and proves every shared semantic outcome category against the native Glulxe routes. Byte-level parity and identical transcript wrapping are explicitly not required.

See [`absurd-alternates/README.md`](absurd-alternates/README.md).

## Unofficial Dam Mechanisms Glulx

The seventh layer derives explicitly from the Release 1214 manifest and artifact hash. It deepens Flood Control Dam #3 without replacing its canonical state machine:

- readable panel, green-bubble, bolt, and button state;
- physically validated wrench, screwdriver, guidebook, water, and putty interactions;
- the canonical yellow/brown interlock and wrench-and-bolt sluice cycle;
- untouched eight-turn reservoir fill and empty timing;
- the canonical red-button room lighting;
- the canonical blue-button leak and rising-water threat;
- wrong-tool repair feedback and real all-purpose-gunk repair;
- complete dam-specific `MELZAR` diagnostics;
- persistent mechanism discoveries in `RECAP`.

### Locked dam-mechanisms artifact

- output: `zork1-glulx-dam-mechanisms.ulx`
- identity: Release `1215` / serial `260720`
- Glulx version: `3.1.3` / `0x00030103`
- size: `207,360` bytes
- checksum: `0x3d135bb8`, valid
- SHA-256: `ea23c8ff739348162f32c798ff0ad6f5e8e6a4d310ad3daf5c2da58b86505eed`

Qualification compiles the locked production artifact and a separate test-only positioning story, then proves possession checks, panel diagnostics, both gate directions, bottled-water validation, light shutdown and restoration, live flooding, wrong-tool failure, canonical repair, and recap state under pinned native Glulxe.

See [`dam-mechanisms/README.md`](dam-mechanisms/README.md).

## Unofficial Ritual Resonance Glulx

The eighth layer derives explicitly from the Release 1215 manifest and artifact hash. It deepens the canonical exorcism materials while leaving the original puzzle state machine authoritative:

- ordinary and red-hot bell examination and listening;
- room-specific bell resonance in temples, mirrors, dam machinery, and ordinary rooms;
- black-book damaged-page study that reveals order without naming solution objects;
- paired-candle observation while preserving their original timer and misuse consequences;
- read-only `CEREMONY`, `RITE`, and `RITUAL` state reporting;
- mirror interactions with the held bell and held lit candles;
- lit candle/book ordering feedback;
- real bottled-water cooling of the real `HOT-BELL` through canonical `POUR-ON`;
- persistent wrong-order, resonance, cooling, and actual completion state in `RECAP`;
- observation—but never replacement—of canonical `XB`, `XC`, `LLD-FLAG`, `BELL`/`HOT-BELL`, `I-XBH`, and `GHOSTS` transitions.

### Locked ritual-resonance artifact

- output: `zork1-glulx-ritual-resonance.ulx`
- identity: Release `1216` / serial `260720`
- Glulx version: `3.1.3` / `0x00030103`
- size: `211,968` bytes
- checksum: `0x3d27d123`, valid
- SHA-256: `4f406e656b892feb5224e4e52afb98768417e1e761918334dfa94595e6091db2`

Qualification rebuilds exact Release 1215, enforces an exact five-path production delta, rejects setup verbs from production, runs a thief-isolated test-only positioning story, proves wrong-order preservation and the original bell → carried lit candles → black-book completion, verifies ghost removal, and proves real-water hot-bell cooling under pinned native Glulxe.

See [`ritual-resonance/README.md`](ritual-resonance/README.md).

## Release 1216 persistence qualification

The persistence train rebuilds and byte-verifies the exact locked Release `1216` production artifact, then creates a separate test-only story to exercise ordinary native Glulxe `SAVE` and `RESTORE` prompts.

It proves:

- living bound troll, committed rope, dropped axe, and open passages;
- prepared intact egg and canonical broken egg/broken canary object trees;
- dam interlock, open sluices, and resumed eight-turn reservoir timing;
- active rising and canonically repaired maintenance-leak snapshots;
- learned `MELZAR` and restored dam reporting;
- completed exorcism, learned and wrong-order memory, mirror resonance, ghost removal, transformed bell, and resumed 20-turn hot-bell cooldown;
- restored `CEREMONY` and `RECAP` agreement;
- deterministic repeated restore without object duplication.

This qualification assigns no new production identity and changes no Release `1216` serialization behavior. Test-only positioning and corruption commands are rejected from production source.

See [`persistence/README.md`](persistence/README.md).

## Locked toolchain

All eight production layers and the persistence qualification use:

- ZILF 1.8: `45c60f1e37651f266ac92d49ae01748bb4909fa5`
- Glazer 1.2.0: `1cc80bcdefb4b4125185e1170eb1ee178e97ff5a`
- Glazer source SHA-256: `a45edadb140111b5df44a3f49ca4e2b8ec0550d63a6cdee7c93bec93a79ed482`
- Glulxe: `56ab8743bab565de307bd892c555d8d8897ed517`
- CheapGlk: `14d8aaf6e4150669762bd4646a5368e75c1eeee6`

The Release 122 semantic reference uses its separately pinned Version 3 ZILF/ZAPF and `dfrotz` route pipeline.

## Deterministic serial normalization

Pinned ZILF 1.8 emits Glulx metadata serial using `DateTime.Now`. Each production pipeline compiles ZIL to Glazer assembly, replaces exactly one generated metadata serial with the edition's committed serial, and assembles the normalized output.

No upstream ZIL source is modified. The replacement count and final artifact SHA-256 are fail-closed.

## Next porting boundary: deeper material consequences

Persistence is now qualified without creating another production edition. The next separate layer should choose one coherent player-facing boundary:

1. deeper non-dam rope, water, shovel, axe, wrench, screwdriver, and container interactions;
2. controlled multi-object consequences that preserve canonical puzzle state;
3. focused room-density work for visible nouns and reasonable physical intent;
4. dedicated cyclops-lullaby and thief-bargain long routes;
5. semantic revisit routes proving prior puzzle solutions remain authoritative.

Songbird geography, Hidden Glade, troll bribes, the full Adventurer Misconduct surface, broad fire propagation, generalized crafting, and Version 3 object-slot cleanup remain later isolated layers.
