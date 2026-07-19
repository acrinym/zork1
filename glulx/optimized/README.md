# Unofficial Optimized Glulx Release 120 port

This directory defines the first repository-local layer built on the qualified unchanged-upstream Glulx baseline.

It ports only the conservative corrections from project Release 120. It does not contain Release 121 assistance, reactive scenery, optional geography, alternate NPC solutions, or Adventurer Misconduct.

## Identity

- edition: Unofficial Optimized Glulx
- release: `1201`
- serial: `260719`
- artifact: `zork1-glulx-optimized.ulx`
- relationship to `.z3` Release 120: same conservative correction set, separate format and clearly separate identity

Release `1201` is a repository-local identifier. It is not presented as an official Infocom release.

## Exact source boundary

The staging pipeline starts from Tara McGrew's exact Glulx commit:

- commit: `1ada70e58ac4933446b907d67949d9cab3119c0e`
- tree: `02b34128649bbb7fcddf99136e03fb67c032b089`

Only four paths may differ after staging:

- `1actions.zil`
- `1dungeon.zil`
- `gverbs.zil`
- `zork1.zil`

Any other changed path fails staging.

## Ported corrections

1. **Recursive containment protection**
   - prevents moving a container into one of its own descendants;
   - preserves normal container and capacity behavior.
2. **Printed-character portability**
   - replaces two player-facing tab characters with equivalent spaces.
3. **State-aware candle descriptions**
   - removes the static Glulx first-sighting sentence that always called the candles burning;
   - installs a single dynamic room-description callback;
   - prints `burning` only while `ONBIT` remains set.
4. **Case-sensitive include portability and identity**
   - uses exact lowercase tracked include names;
   - retains Tara's Glulx `WORD-SIZE` compatibility block;
   - assigns Release `1201`.

Every change is represented by a reviewed overlay or an exact-count JSON patch. The staging receipt records patch hashes, target hashes before and after, source hashes, changed paths, and the complete tracked-source inventory.

## Qualified artifact

- Glulx version: `3.1.3` / `0x00030103`
- size: `180,992` bytes
- checksum: `0xaa478295`, valid
- SHA-256: `f2f64b0696e91f325602f6d4f1a91182a940bfd28105576662bd54bdeb37d051`

The workflow fails if any of these values change without an intentional provenance update.

## Native qualification routes

The artifact runs under pinned Glulxe linked to pinned CheapGlk.

### Opening and identity

The route proves:

- Release `1201` / serial `260719`;
- West of House;
- visible mailbox;
- ordinary command handling and clean exit.

### Recursive containment

The route enters the kitchen, opens the sack and bottle, places the bottle inside the sack, and then attempts to put the containing sack into that bottle.

The game rejects the cycle with `How can you do that?` and remains live with the nested bottle still visible in inventory.

### Extinguished candles

A separately compiled **test-only** artifact changes startup to South Temple and clears `ONBIT` and `FLAMEBIT` before the first room description.

It must print:

```text
On the two ends of the altar are candles.
```

It must not print the static historical sentence claiming the extinguished candles are burning.

The test-only startup patch is never applied to the production artifact and is marked as such in its staging receipt.

## Toolchain

This layer uses the same locked toolchain as the upstream baseline:

- ZILF 1.8: `45c60f1e37651f266ac92d49ae01748bb4909fa5`
- Glazer 1.2.0: `1cc80bcdefb4b4125185e1170eb1ee178e97ff5a`
- Glulxe: `56ab8743bab565de307bd892c555d8d8897ed517`
- CheapGlk: `14d8aaf6e4150669762bd4646a5368e75c1eeee6`

## Next layer

The next Glulx train ports Release 121 action hooks and optional assistance only:

- `GOALS`
- `EXITS`
- `HINT`
- `RECAP`
- `WHY`
- `USE <object>`

Reactive scenery, Hidden Glade, NPC alternatives, comedy grammar, `FOLLY`, and version 3 object-slot cleanup remain later isolated layers.
