# Parser Comprehension and Deep Affordances — Release 1232

**Repository:** `acrinym/zork1`  
**Base:** Release 1231 merge `28b90fe93a472087e64afcd0fb0e8776f80157f3`  
**Branch:** `agent/parser-deep-affordances-20260731`  
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

## Why these phrases

- `X` and `INSPECT` are common examination intentions and do not alter object behavior.
- `EXAMINE UNDER/BEHIND` preserves the player’s explicit spatial role instead of collapsing to generic examination.
- `SWITCH ON/OFF` names the same binary action as canonical `TURN ON/OFF`.
- `SEAL` and `MEND` identify the same physical relation as canonical `PLUG`; the existing parser still asks for a missing tool when necessary.

## What is deliberately absent

A generic `USE` command is not added. The parser cannot safely infer whether `USE SWORD` means attack, cut, threaten, pry, or something else. Guessing would change intent and leak puzzle solutions.

The train also adds no:

- parser global or state machine;
- new verb routine;
- new response prose;
- universal synonym catalog;
- House hierarchy work;
- S.T.A.L.K.E.R. coupling;
- meta-audit or parser-audit framework.

## Production delta

Exactly two staged source paths may change:

- `gsyntax.zil` — three narrow grammar replacements;
- `zork1.zil` — Release 1232 identity while retaining every Release 1231 layer.

## Acceptance proof

The hosted route must:

1. pass the direct Release 1232 tests;
2. stage exactly over locked Release 1231 SHA-256 `5daaa7307ef496a3ae37209a6e79e149c9dc3d202f148f143bbb571fa74b3609`;
3. report no ZIL smell errors;
4. compile and assemble the real Glulx story;
5. verify the artifact checksum;
6. run the selected phrases through Glulxe;
7. prove canonical outputs rather than merely detecting grammar strings;
8. upload the story, transcript, receipts, and logs.

The first successful hosted artifact will be locked and reproduced before merge.
