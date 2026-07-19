# Glulx upstream baseline qualification

## Scope

This gate qualifies only Tara McGrew's unchanged Zork I Glulx source at commit `1ada70e58ac4933446b907d67949d9cab3119c0e`.

It does not qualify a Glulx port of Optimized Release 120 or Expanded Release 121.

## Upstream reconciliation

Tara's `glulx` branch is one commit ahead of current `master`, with merge base `97b7b3d68c075dd9af7da499c3e9690ada3471fd`.

The complete source delta is limited to:

- `1actions.zil`
- `1dungeon.zil`
- `gclock.zil`
- `gmacros.zil`
- `gparser.zil`
- `gverbs.zil`
- `zork1.zil`

The local baseline checks out Tara's commit directly. It does not copy or rewrite those seven files into a separate local fork.

## Toolchain lock

| Component | Immutable pin |
|---|---|
| ZILF | Release 1.8 / `45c60f1e37651f266ac92d49ae01748bb4909fa5` |
| Glazer | Release 1.2.0 / `1cc80bcdefb4b4125185e1170eb1ee178e97ff5a` |
| Glazer source | SHA-256 `a45edadb140111b5df44a3f49ca4e2b8ec0550d63a6cdee7c93bec93a79ed482` |
| Glulxe | `56ab8743bab565de307bd892c555d8d8897ed517` |
| CheapGlk | `14d8aaf6e4150669762bd4646a5368e75c1eeee6` |

## Qualified repository build

| Field | Value |
|---|---|
| File | `zork1-glulx-upstream.ulx` |
| Identity | Release 1 / serial `251203` |
| Glulx version | 3.1.3 / `0x00030103` |
| Size | 180,736 bytes |
| Checksum | `0xad5a809b`, valid |
| SHA-256 | `15dd2b654693e4f1c63e09a2308de1f366913c13be080baa33af3f76c5679ac8` |

The build is fail-closed against the pinned source tarball, artifact SHA-256, header checksum, native identity transcript, and expected serial-normalization count.

## Archived reference inspection

The IF Archive ZIP contains exactly two files:

| Member | Size | SHA-256 |
|---|---:|---|
| `LICENSE` | 1,087 bytes | `820ff92d890bd6b411c38249f050d652ffb76c1bc750268be23fd75f4fc67f29` |
| `zork1.ulx` | 167,424 bytes | `42b74ce1ce32e9f483418409642b1be425e66e93c7741961e90917e2bb30b129` |

Archive SHA-256: `6e9879f36d7d15ddebee1333244be016a9f3a40756718292264815e8881c51ad`.

The archived story has a valid Glulx checksum, identifies itself as Release 1 / serial `251203`, and passes the pinned native opening smoke route.

## Native smoke gate

Both the repository build and archived story must:

- start under pinned Glulxe linked to pinned CheapGlk;
- print Release 1 / serial `251203`;
- reach West of House;
- expose the mailbox;
- accept ordinary commands;
- exit normally.

## Existing-edition preservation gate

The separate optimized-and-expanded workflow must continue to prove:

- preserved historical Release 119;
- optimized Release 120;
- expanded Release 121;
- completed beadtrain validation;
- deterministic Frotz transcripts.

The Glulx line is additive. A passing Glulx workflow cannot compensate for a failing `.z3` preservation gate.

## Exact Release 120 port layer

The next train creates a new Glulx staging layer derived from Tara's qualified baseline and ports the Release 120 changes one at a time.

Acceptance order:

1. reproduce the qualified baseline before patches;
2. apply recursive-containment protection through an exact, fail-closed patch;
3. port the candle object and routine corrections;
4. port unsafe printed-character replacements;
5. preserve Tara's seven-file Glulx compatibility delta;
6. run structural and case-sensitive include audits against the staged Glulx source;
7. assign a clearly unofficial repository-local Glulx Release 120 identity;
8. verify header, checksum, size, SHA-256, native transcript, and canonical opening behavior;
9. prove historical Release 119 and both existing `.z3` project editions still pass;
10. document the exact Release 121 action-hook layer without implementing it in the same train.

No expanded gameplay code enters this layer.
