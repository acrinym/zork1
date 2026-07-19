# Zork I Glulx lineage

This directory defines the additive, unofficial Glulx lineage for this repository.

Two layers are now qualified:

| Layer | Identity | Purpose |
|---|---:|---|
| Unchanged upstream baseline | Release 1 / serial `251203` | Reproduce and qualify Tara McGrew's existing Glulx port without project changes |
| Unofficial Optimized Glulx | Release 1201 / serial `260719` | Port only the conservative corrections from project Release 120 |

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

See [`QUALIFICATION.md`](QUALIFICATION.md) for the unchanged-upstream gate.

## Unofficial Optimized Glulx

The second layer stages Tara's exact source tree and ports only:

- recursive-containment protection;
- two printed-character portability corrections;
- fully state-aware temple-candle room descriptions;
- exact lowercase include portability;
- a separate repository-local identity.

### Locked optimized artifact

- output: `zork1-glulx-optimized.ulx`
- identity: Release `1201` / serial `260719`
- Glulx version: `3.1.3` / `0x00030103`
- size: `180,992` bytes
- checksum: `0xaa478295`, valid
- SHA-256: `f2f64b0696e91f325602f6d4f1a91182a940bfd28105576662bd54bdeb37d051`

The optimized staging gate permits changes to exactly four paths and records every overlay, patch hash, and before/after target hash. Native qualification proves opening identity, recursive-containment rejection, and extinguished-candle behavior.

See [`optimized/README.md`](optimized/README.md) for the complete source boundary and route details.

## Locked toolchain

Both layers use:

- ZILF 1.8: `45c60f1e37651f266ac92d49ae01748bb4909fa5`
- Glazer 1.2.0: `1cc80bcdefb4b4125185e1170eb1ee178e97ff5a`
- Glazer source SHA-256: `a45edadb140111b5df44a3f49ca4e2b8ec0550d63a6cdee7c93bec93a79ed482`
- Glulxe: `56ab8743bab565de307bd892c555d8d8897ed517`
- CheapGlk: `14d8aaf6e4150669762bd4646a5368e75c1eeee6`

## Deterministic serial normalization

Pinned ZILF 1.8 emits Glulx metadata serial using `DateTime.Now`. Each pipeline therefore compiles unchanged or staged ZIL to Glazer assembly, replaces exactly one generated metadata serial with the edition's committed six-digit serial, and assembles the normalized output.

No upstream ZIL source is modified by this normalization. The replacement count and final artifact SHA-256 are fail-closed.

## Next porting boundary: Release 121 action and assistance layer

The next layer ports only:

- the Release 121 action-hook foundation;
- `GOALS`;
- `EXITS`;
- tiered `HINT`;
- `RECAP`;
- contextual `WHY`;
- `USE <object>` affordance guidance.

Reactive scenery, songbird and Hidden Glade, troll/cyclops/thief alternatives, Adventurer Misconduct, `FOLLY`, troll bemusement, semantic parity expansion, and version 3 object-slot cleanup remain later isolated layers.
