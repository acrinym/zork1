# Parser Comprehension and Deep Affordances — Release 1232

**Repository:** `acrinym/zork1`  
**Base:** Release 1231 merge `28b90fe93a472087e64afcd0fb0e8776f80157f3`  
**Branch:** `agent/parser-deep-affordances-20260731`  
**PR:** `#35`  
**Date:** July 31, 2026

## Product decision

This train repairs selected failures between ordinary interactive-fiction language and behavior Zork already implements. It is not a parser rewrite, synonym harvest, or natural-language guessing system.

Every accepted phrase has one clear canonical destination:

| Player phrase | Canonical route |
|---|---|
| `X OBJECT` | `V-EXAMINE` |
| `INSPECT OBJECT` | `V-EXAMINE` |
| `EXAMINE UNDER OBJECT` | `V-LOOK-UNDER` |
| `EXAMINE BEHIND OBJECT` | `V-LOOK-BEHIND` |
| `SWITCH ON/OFF OBJECT` | existing `TURN ON/OFF` syntax |
| `SEAL ... WITH ...` | `V-PLUG` |
| `MEND ... WITH ...` | `V-PLUG` |

## Product behavior

- `X` and `INSPECT` are common examination intentions and do not alter object behavior.
- `EXAMINE UNDER/BEHIND` preserves the player’s explicit spatial role instead of collapsing to generic examination.
- `SWITCH ON/OFF` names the same binary action as canonical `TURN ON/OFF`.
- `SEAL` and `MEND` identify the same physical relation as canonical `PLUG`; the existing parser still asks for a missing tool when necessary.

The PLUG and TURN changes are prefix additions with exact-count anchors. They preserve every synonym accumulated by prior trains instead of replacing whole vocabulary lines.

## Existing USE assistance

Release 1211 already added bounded `USE OBJECT` assistance. It describes plausible affordances and redirects the player to concrete verbs; it does not execute a guessed action. Release 1232 preserves that behavior unchanged and adds no new or expanded `USE` routing.

## Production boundary

Exactly two staged source paths change:

- `gsyntax.zil` — three narrow grammar replacements;
- `zork1.zil` — Release 1232 identity while retaining every Release 1231 layer.

The train adds no parser global, state machine, new verb routine, response prose, universal synonym catalog, guessed puzzle action, House hierarchy work, S.T.A.L.K.E.R. coupling, or meta-audit framework.

## Hosted qualification result

The first complete GitHub-hosted route passed seven direct tests, exact Release 1231 staging, ZIL smell checking, ZILF compilation, Glazer assembly, ULX verification, CheapGlk/Glulxe building, and the real runtime transcript.

The transcript proved:

- `X MAILBOX` and `INSPECT MAILBOX` both returned the canonical closed-mailbox response;
- `EXAMINE UNDER MAILBOX` returned the canonical dust response;
- `EXAMINE BEHIND MAILBOX` returned the canonical behind-object response;
- `SEAL` and `MEND` both reached canonical plugging behavior;
- `SWITCH ON/OFF LANTERN` changed the real lantern state;
- none of `X`, `INSPECT`, `SEAL`, `MEND`, or `SWITCH` was rejected as unknown.

Locked Release 1232 artifact:

- serial: `260731`;
- size: `337920` bytes;
- checksum: `0x2c2192e1`;
- SHA-256: `2cffc734dbfbe346d0ec185c6962d927bc046343dccdb53b6a9e4439521b6f2e`.

The locked hosted gate must reproduce this identity before merge. The workflow uploads the story, assembly, runtime transcript, receipts, reports, and build logs.
