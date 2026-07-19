# Glulx lineage qualification

## Scope

This record qualifies two additive Glulx layers:

1. Tara McGrew's unchanged Zork I Glulx source at commit `1ada70e58ac4933446b907d67949d9cab3119c0e`;
2. the repository's conservative Optimized Glulx Release `1201` port.

It does not qualify Expanded Release 121 behavior on Glulx.

## Upstream reconciliation

Tara's `glulx` branch is one commit ahead of current `master`, with merge base `97b7b3d68c075dd9af7da499c3e9690ada3471fd`.

The complete upstream source delta is limited to:

- `1actions.zil`
- `1dungeon.zil`
- `gclock.zil`
- `gmacros.zil`
- `gparser.zil`
- `gverbs.zil`
- `zork1.zil`

The unchanged baseline checks out Tara's commit directly. The optimized layer stages its exact tree `02b34128649bbb7fcddf99136e03fb67c032b089` before applying reviewed patches.

## Toolchain lock

| Component | Immutable pin |
|---|---|
| ZILF | Release 1.8 / `45c60f1e37651f266ac92d49ae01748bb4909fa5` |
| Glazer | Release 1.2.0 / `1cc80bcdefb4b4125185e1170eb1ee178e97ff5a` |
| Glazer source | SHA-256 `a45edadb140111b5df44a3f49ca4e2b8ec0550d63a6cdee7c93bec93a79ed482` |
| Glulxe | `56ab8743bab565de307bd892c555d8d8897ed517` |
| CheapGlk | `14d8aaf6e4150669762bd4646a5368e75c1eeee6` |

## Qualified unchanged-upstream build

| Field | Value |
|---|---|
| File | `zork1-glulx-upstream.ulx` |
| Identity | Release 1 / serial `251203` |
| Glulx version | 3.1.3 / `0x00030103` |
| Size | 180,736 bytes |
| Checksum | `0xad5a809b`, valid |
| SHA-256 | `15dd2b654693e4f1c63e09a2308de1f366913c13be080baa33af3f76c5679ac8` |

The build is fail-closed against the source commit, toolchain inputs, artifact SHA-256, header checksum, native identity transcript, and expected serial-normalization count.

## Archived reference inspection

The IF Archive ZIP contains exactly two files:

| Member | Size | SHA-256 |
|---|---:|---|
| `LICENSE` | 1,087 bytes | `820ff92d890bd6b411c38249f050d652ffb76c1bc750268be23fd75f4fc67f29` |
| `zork1.ulx` | 167,424 bytes | `42b74ce1ce32e9f483418409642b1be425e66e93c7741961e90917e2bb30b129` |

Archive SHA-256: `6e9879f36d7d15ddebee1333244be016a9f3a40756718292264815e8881c51ad`.

The archived story has a valid Glulx checksum, identifies itself as Release 1 / serial `251203`, and passes the pinned native opening route.

## Qualified Optimized Glulx Release 120 port

| Field | Value |
|---|---|
| File | `zork1-glulx-optimized.ulx` |
| Identity | Release 1201 / serial `260719` |
| Glulx version | 3.1.3 / `0x00030103` |
| Size | 180,992 bytes |
| Checksum | `0xaa478295`, valid |
| SHA-256 | `f2f64b0696e91f325602f6d4f1a91182a940bfd28105576662bd54bdeb37d051` |

The optimized staging gate permits changes only to:

- `1actions.zil`
- `1dungeon.zil`
- `gverbs.zil`
- `zork1.zil`

The source layer contains only:

- recursive-containment protection;
- two printed-character portability replacements;
- a Glulx-specific dynamic candle room description;
- state-aware candle prose;
- exact lowercase include paths;
- the repository-local Release `1201` identity.

Every patch is exact-count and every changed target has recorded before-and-after hashes.

## Native qualification routes

### Both production artifacts

The unchanged and optimized repository builds must:

- start under pinned Glulxe linked to pinned CheapGlk;
- print their committed release and serial identities;
- reach West of House;
- expose the mailbox;
- accept ordinary commands;
- exit normally.

### Optimized recursive-containment route

The optimized story must reject placing a containing sack into the open bottle already inside it. The route must print `How can you do that?`, remain live, and retain the valid one-way bottle-inside-sack state.

### Optimized extinguished-candle route

A separately staged test-only story begins at South Temple with `ONBIT` and `FLAMEBIT` cleared before the first room description.

It must print `On the two ends of the altar are candles.` and must not claim that the extinguished candles are burning.

The production artifact never receives the test-only startup patch.

## Existing-edition preservation gate

The separate optimized-and-expanded workflow must continue to prove:

- preserved historical Release 119;
- optimized Release 120 `.z3`;
- expanded Release 121 `.z3`;
- completed beadtrain validation;
- deterministic Frotz transcripts.

The Glulx line is additive. A passing Glulx workflow cannot compensate for a failing `.z3` preservation gate.

## Exact Release 121 action and assistance layer

The next train ports only:

1. Release 121 action hooks;
2. `GOALS`;
3. `EXITS`;
4. tiered `HINT`;
5. `RECAP`;
6. contextual `WHY`;
7. `USE <object>` affordance guidance;
8. opening and assistance semantic parity routes between `.z3` and `.ulx`.

Reactive scenery, songbird and Hidden Glade, troll/cyclops/thief alternatives, Adventurer Misconduct, `FOLLY`, troll bemusement, and version 3 object-slot cleanup remain later layers.
