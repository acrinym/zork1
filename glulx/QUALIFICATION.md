# Glulx lineage qualification

## Scope

This record qualifies four additive Glulx layers:

1. Tara McGrew's unchanged Zork I Glulx source at commit `1ada70e58ac4933446b907d67949d9cab3119c0e`;
2. the repository's conservative Optimized Glulx Release `1201` port;
3. the Release 121 action-and-assistance layer, Release `1211`;
4. the focused Release 121 reactive-surface layer, Release `1212`.

Optional geography, alternate NPC solutions, deeper underground reactions, and Adventurer Misconduct are not yet qualified on Glulx.

## Upstream reconciliation

Tara's `glulx` branch is one commit ahead of its reconciled `master`, with merge base `97b7b3d68c075dd9af7da499c3e9690ada3471fd`.

The complete upstream source delta is limited to `1actions.zil`, `1dungeon.zil`, `gclock.zil`, `gmacros.zil`, `gparser.zil`, `gverbs.zil`, and `zork1.zil`.

Every staged layer begins at Tara's exact tree `02b34128649bbb7fcddf99136e03fb67c032b089`.

## Toolchain lock

| Component | Immutable pin |
|---|---|
| ZILF | Release 1.8 / `45c60f1e37651f266ac92d49ae01748bb4909fa5` |
| Glazer | Release 1.2.0 / `1cc80bcdefb4b4125185e1170eb1ee178e97ff5a` |
| Glazer source | SHA-256 `a45edadb140111b5df44a3f49ca4e2b8ec0550d63a6cdee7c93bec93a79ed482` |
| Glulxe | `56ab8743bab565de307bd892c555d8d8897ed517` |
| CheapGlk | `14d8aaf6e4150669762bd4646a5368e75c1eeee6` |

## Qualified artifacts

| Layer | File | Identity | Size | Checksum | SHA-256 |
|---|---|---:|---:|---|---|
| Unchanged upstream | `zork1-glulx-upstream.ulx` | Release 1 / `251203` | 180,736 | `0xad5a809b` | `15dd2b654693e4f1c63e09a2308de1f366913c13be080baa33af3f76c5679ac8` |
| Optimized | `zork1-glulx-optimized.ulx` | Release 1201 / `260719` | 180,992 | `0xaa478295` | `f2f64b0696e91f325602f6d4f1a91182a940bfd28105576662bd54bdeb37d051` |
| Assisted | `zork1-glulx-assisted.ulx` | Release 1211 / `260719` | 185,600 | `0xd3e2209e` | `cf5e51d414bd786bdb4e911263534dcb5c9c61aaebc35b944a96e5269a864777` |
| Reactive surface | `zork1-glulx-reactive-surface.ulx` | Release 1212 / `260719` | 189,440 | `0x01ea5062` | `78bbfd36d03c29714c4ccf0aac45f314568db1ef60aa37732167891a7329e002` |

All four artifacts target Glulx 3.1.3 (`0x00030103`) and have valid header checksums.

## Archived reference inspection

The IF Archive ZIP contains `LICENSE` and `zork1.ulx`. The archived story is 167,424 bytes with SHA-256 `42b74ce1ce32e9f483418409642b1be425e66e93c7741961e90917e2bb30b129`; the ZIP SHA-256 is `6e9879f36d7d15ddebee1333244be016a9f3a40756718292264815e8881c51ad`.

The archived story identifies itself as Release 1 / serial `251203`, has a valid checksum, and passes the pinned native opening route.

## Optimized Release 120 qualification

Release 1201 permits changes only to `1actions.zil`, `1dungeon.zil`, `gverbs.zil`, and `zork1.zil`. It contains recursive-containment protection, printed-character corrections, dynamic candle descriptions, lowercase include paths, and the repository-local identity.

Native routes prove opening identity, recursive-containment rejection, and extinguished-candle behavior.

## Release 1211 assistance qualification

Release 1211 derives from the committed Release 1201 artifact and permits changes only to `1actions.zil`, `1dungeon.zil`, `assistance.zil`, `gmain.zil`, `gverbs.zil`, and `zork1.zil`.

It adds a reviewed assistance module, state-neutral action hook, `GOALS`, `EXITS`, three-tier `HINT`, canonical-state `RECAP`, contextual `WHY`, and `USE <object>` guidance.

The same canonical command route passes under Expanded Release 121 `.z3` and Release 1211 `.ulx`.

## Release 1212 reactive-surface qualification

Release 1212 derives from the committed Release 1211 artifact SHA-256 `cf5e51d414bd786bdb4e911263534dcb5c9c61aaebc35b944a96e5269a864777`.

Its staging gate permits changes only to:

- `1actions.zil`
- `1dungeon.zil`
- `assistance.zil`
- `gmain.zil`
- `gverbs.zil`
- `reactive_surface.zil`
- `zork1.zil`

The layer adds only:

- proximity-safe white-house and front-door reactions;
- board and boarded-window reactions;
- persistent board scarring and the painted splinter;
- kitchen-window reactions while retaining canonical traversal;
- mailbox reactions and maintenance-slip discovery;
- ordinary forest and tree reactions;
- songbird listening and greeting;
- surface-state recap entries.

It adds no rooms and no score-bearing puzzle route.

### Cross-VM real-map route

The shared route uses classic parser grammar and walks the actual world. Under both Expanded Release 121 `.z3` and Release 1212 `.ulx`, it proves:

- `KNOCK ON HOUSE` and front-door behavior;
- `LISTEN TO DOOR`;
- failed roof climbing plus contextual `WHY`;
- the original mailbox/leaflet sequence;
- maintenance-slip discovery, taking, and reading;
- the original kitchen-window opening and traversal route;
- original sword retrieval;
- board damage with the sword;
- creation and visibility of the painted splinter;
- surface-state `RECAP` entry point;
- forest and songbird reactions.

### Native boundary route

A separate pinned Glulxe route begins in `FOREST-1` and proves:

- distant `KNOCK ON HOUSE` receives `You're not close enough to the house to do that.`;
- distant `LISTEN TO HOUSE` receives `You are too far away to hear anything from the house.`;
- distant `CLIMB HOUSE` is rejected without changing house state;
- forest examination;
- tree examination and listening;
- songbird listening and greeting;
- Tara's canonical `It can't be followed.` response;
- absence of `Hidden Glade`.

The initial candidate route used unsupported shorthand such as `KNOCK HOUSE` and `LISTEN DOOR`. Qualification corrected the transcript to the shipped `KNOCK ON` and `LISTEN TO` grammar rather than adding artificial parser aliases.

## Existing-edition preservation gate

The separate optimized-and-expanded workflow continues to prove preserved historical Release 119, optimized Release 120 `.z3`, expanded Release 121 `.z3`, completed beadtrain validation, and deterministic Frotz transcripts.

The Glulx line is additive. A passing Glulx workflow cannot compensate for a failing `.z3` preservation gate.

## Exact deeper-reactivity next layer

The next train ports, in isolated groups:

1. dam and control-panel feedback;
2. bell resonance;
3. candle-state examination beyond the Release 120 correction;
4. optional black-book pages;
5. rope, mirror, water, wrench, shovel, axe, and related object reactions;
6. focused semantic `.z3` versus `.ulx` routes for each group.

Hidden Glade geography, troll/cyclops/thief alternatives, Adventurer Misconduct, `FOLLY`, troll bemusement, and version 3 object-slot cleanup remain later layers.
