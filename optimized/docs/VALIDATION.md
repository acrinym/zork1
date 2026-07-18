# Validation Record

## Validated revision

- Repository: `acrinym/zork1`
- Branch: `agent/preservation-first-optimized-edition`
- Source head validated: `24ca7ba22135e30d45ec76ee359e5bc91b82cfad`
- GitHub Actions run: `29647010355`
- Validation date: 2026-07-18

Both workflow jobs passed:

1. `preservation-audit`
2. `optimized-build`

## Historical input proof

The stage step verified 13 historical files against their recorded Git blob identities before copying them. The receipt identifies the source as:

- commit `97b7b3d68c075dd9af7da499c3e9690ada3471fd`
- Release 119
- serial 880429

One entrypoint overlay and four exact patch files were then applied. Every replacement matched exactly once. No repository-root historical file was modified.

## Structural audit

The staged edition contained:

- 10 ZIL files
- 11,978 lines
- 0 structural errors
- 2 retained warnings
- 30 clock interrupt slots, derived from 180 table words / 6 words per entry

The retained warnings are duplicate definitions of `LUCKY` and `WON-FLAG`. They occur across generic and game-specific source layers under the historical redefinition model. They remain visible because deleting or silently suppressing them has not been proven behavior-neutral.

## Compiler and assembler

CI built a pinned revision of ZILF and ZAPF:

- repository: `taradinoc/zilf`
- commit: `d3b79f348b692647ab7ee3b13e5ac7c99b70f471`
- reported tool version: 1.9

The optimized build uses two explicit phases:

1. ZILF generates `zork1.zap` with automatic assembly disabled.
2. ZAPF assembles the story with explicit `--release 120 --serial 260718` arguments.

Modern ZILF reported `26 warnings (26 suppressed)` according to the source’s own warning controls. The CI-specific unsafe ZSCII check passed: no `ZIL0410` tab-character warning remained after `Z1-PORT-001`.

## Story-file verification

### Preserved baseline

- Z-machine version: 3
- Release: 119
- Serial: 880429
- Size: 86,838 bytes
- Stored checksum: 48,964
- Calculated checksum: 48,964
- Checksum valid: yes

### Optimized edition

- Z-machine version: 3
- Release: 120
- Serial: 260718
- Size: 87,012 bytes
- Stored checksum: 41,234
- Calculated checksum: 41,234
- Checksum valid: yes
- SHA-256: `7e38f3a949a67ed0ab9e38923b89537d875fc80f3fbb9bf268c86cf0d325b107`

The verifier also confirmed the declared file length and the high-memory, initial-PC, dictionary, object-table, global-table, and static-memory addresses are inside the story file.

## Runtime smoke test

Frotz successfully loaded the optimized story and displayed:

```text
ZORK I: The Great Underground Empire
Release 120 / Serial number 260718
```

The deterministic command route passed:

```text
look
open mailbox
read leaflet
inventory
quit
y
```

Expected fragments were observed:

- `West of House`
- `small mailbox`
- `leaflet`
- `ZORK`

This proves the optimized story starts, accepts commands, changes object state, prints game text, reports inventory and score, and exits normally.

## What is proven for each fix

### Z1-BUG-001 — Recursive containment

Proven:

- exact patch anchors match the verified Release 119 source;
- patched ZIL is structurally valid;
- the complete game compiles and assembles;
- the resulting game starts and executes an unrelated opening route normally.

Still needed:

- a targeted player transcript that creates normal nested containers and then attempts the reverse cycle;
- save/restore and object traversal checks after the rejected move.

### Z1-BUG-002 — Candle description

Proven:

- the object and callback patches match exactly once;
- lit wording preserves the original text;
- extinguished wording omits only the inaccurate word `burning`;
- the complete game compiles, verifies, and starts normally.

Still needed:

- a targeted route to the temple that records room descriptions before and after extinguishing the candles.

### Z1-PORT-001 — Printed tab characters

Proven:

- exactly two historical tab characters were replaced with spaces;
- prose content remains unchanged;
- modern ZILF no longer emits the unsafe ZSCII tab warning;
- the complete story compiles and passes runtime smoke.

## Artifact

The workflow artifact archive contains the runnable story, reports, receipts, transcript, and compiler logs.

- Archive SHA-256: `6c92ff8752bd014bc3e9fbb48d04cd7978685c610fb7e700ca69a2d1e720d77b`
- Archive size: 68,258 bytes

The archive is build evidence, not a replacement for the preserved repository-root Release 119 files.
