# Glulx lineage qualification

## Scope

This record qualifies three additive Glulx layers:

1. Tara McGrew's unchanged Zork I Glulx source at commit `1ada70e58ac4933446b907d67949d9cab3119c0e`;
2. the repository's conservative Optimized Glulx Release `1201` port;
3. the repository's Release 121 action-and-assistance layer, Release `1211`.

Reactive scenery, optional geography, alternate NPC solutions, and Adventurer Misconduct are not yet qualified on Glulx.

## Upstream reconciliation

Tara's `glulx` branch is one commit ahead of its reconciled `master`, with merge base `97b7b3d68c075dd9af7da499c3e9690ada3471fd`.

The complete upstream source delta is limited to:

- `1actions.zil`
- `1dungeon.zil`
- `gclock.zil`
- `gmacros.zil`
- `gparser.zil`
- `gverbs.zil`
- `zork1.zil`

Every staged layer begins at Tara's exact tree `02b34128649bbb7fcddf99136e03fb67c032b089`.

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

The optimized staging gate permits changes only to `1actions.zil`, `1dungeon.zil`, `gverbs.zil`, and `zork1.zil`. It contains recursive-containment protection, printed-character corrections, dynamic candle descriptions, lowercase include paths, and the Release `1201` identity.

Native routes prove opening identity, recursive-containment rejection, and extinguished-candle behavior.

## Qualified Release 121 action and assistance layer

| Field | Value |
|---|---|
| File | `zork1-glulx-assisted.ulx` |
| Identity | Release 1211 / serial `260719` |
| Glulx version | 3.1.3 / `0x00030103` |
| Size | 185,600 bytes |
| Checksum | `0xd3e2209e`, valid |
| SHA-256 | `cf5e51d414bd786bdb4e911263534dcb5c9c61aaebc35b944a96e5269a864777` |
| Qualified base | Release 1201 / SHA-256 `f2f64b0696e91f325602f6d4f1a91182a940bfd28105576662bd54bdeb37d051` |

The Release 1211 staging gate permits changes only to:

- `1actions.zil`
- `1dungeon.zil`
- `assistance.zil`
- `gmain.zil`
- `gverbs.zil`
- `zork1.zil`

The new `assistance.zil` is a reviewed source addition with a recorded source hash. Both `PERFORM` implementations receive an exact state-neutral action-hook call after `PRSA`, `PRSO`, and `PRSI` are established.

This layer contains only:

- `GOALS`;
- `EXITS`;
- three-tier `HINT`;
- canonical-state `RECAP`;
- contextual `WHY`;
- `USE <object>` affordance guidance;
- state-neutral latest-action recording.

It does not change scenery behavior, add rooms or objects, introduce alternate NPC solutions, or add comedy grammar.

## Cross-VM semantic qualification

The same nine-move command script runs against:

- Expanded Release 121 `.z3` under `dfrotz`;
- Assisted Release 1211 `.ulx` under pinned Glulxe and CheapGlk.

Both routes prove:

- the canonical Great Underground Empire goal;
- opening visible exits;
- all three opening hint tiers;
- an initial recap;
- generic `USE MAILBOX` affordance guidance;
- a failed `CLIMB HOUSE` action;
- contextual roof explanation through `WHY`;
- normal score and exit handling after nine moves.

The parity gate compares stable semantic markers rather than identical wrapping or edition-specific prose.

## Existing-edition preservation gate

The separate optimized-and-expanded workflow continues to prove:

- preserved historical Release 119;
- optimized Release 120 `.z3`;
- expanded Release 121 `.z3`;
- completed beadtrain validation;
- deterministic Frotz transcripts.

The Glulx line is additive. A passing Glulx workflow cannot compensate for a failing `.z3` preservation gate.

## Exact reactive-surface next layer

The next train ports reactive surface-world behavior in isolated groups:

1. white house and roof attempts;
2. front door;
3. boards and boarded windows;
4. kitchen window;
5. mailbox;
6. forest nouns without optional geography;
7. persistent state needed by those reactions;
8. focused `.z3` versus `.ulx` semantic routes for each group.

Hidden Glade geography, troll/cyclops/thief alternatives, Adventurer Misconduct, `FOLLY`, troll bemusement, and version 3 object-slot cleanup remain later layers.
