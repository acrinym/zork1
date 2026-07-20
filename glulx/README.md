# Zork I Glulx lineage

This directory defines the additive, unofficial Glulx lineage for this repository.

Five layers are now qualified:

| Layer | Identity | Purpose |
|---|---:|---|
| Unchanged upstream baseline | Release 1 / serial `251203` | Reproduce and qualify Tara McGrew's existing Glulx port without project changes |
| Unofficial Optimized Glulx | Release 1201 / serial `260719` | Port only the conservative corrections from project Release 120 |
| Unofficial Assisted Glulx | Release 1211 / serial `260719` | Port Release 121 action hooks and optional assistance with cross-VM semantic parity |
| Unofficial Reactive Surface Glulx | Release 1212 / serial `260719` | Port proximity-safe white-house, door, board, window, mailbox, forest, tree, and songbird reactions without optional geography |
| Unofficial Shadow Logic Glulx | Release 1213 / serial `260720` | Add native object-on-object experimentation, player-state consequences, material responses, light reporting, learned maintenance knowledge, and a discovered-folly ledger |

Historical Release 119, Optimized Release 120, and Expanded Release 121 remain supported `.z3` editions and are not replaced or relabeled.

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

## Locked toolchain

All five layers use:

- ZILF 1.8: `45c60f1e37651f266ac92d49ae01748bb4909fa5`
- Glazer 1.2.0: `1cc80bcdefb4b4125185e1170eb1ee178e97ff5a`
- Glazer source SHA-256: `a45edadb140111b5df44a3f49ca4e2b8ec0550d63a6cdee7c93bec93a79ed482`
- Glulxe: `56ab8743bab565de307bd892c555d8d8897ed517`
- CheapGlk: `14d8aaf6e4150669762bd4646a5368e75c1eeee6`

## Deterministic serial normalization

Pinned ZILF 1.8 emits Glulx metadata serial using `DateTime.Now`. Each pipeline compiles ZIL to Glazer assembly, replaces exactly one generated metadata serial with the edition's committed serial, and assembles the normalized output.

No upstream ZIL source is modified. The replacement count and final artifact SHA-256 are fail-closed.

## Next porting boundary: deeper Shadow Logic

The next isolated layer should extend the qualified foundation into:

1. dam and control-panel experimentation;
2. bell resonance and candle-state combinations;
3. black-book knowledge and additional learned words where justified;
4. deeper mirror, rope, water, wrench, shovel, axe, and tool interactions;
5. controlled multi-object consequence chains;
6. focused semantic routes proving canonical puzzle solutions remain valid.

Songbird geography, Hidden Glade, troll/cyclops/thief alternatives, the full Adventurer Misconduct surface, and Version 3 object-slot cleanup remain later isolated layers.
