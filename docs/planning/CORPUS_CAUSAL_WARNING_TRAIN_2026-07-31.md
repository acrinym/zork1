# Corpus-Coupled Causal Warning — Release 1231 Train

**Repository:** `acrinym/zork1`  
**Base:** merged Infocom Corpus Foundation at `d7cc4750507fed9b505af66e0fd6afee2da70ffb`  
**Branch:** `agent/corpus-causal-warning-20260731`  
**Date:** July 31, 2026

## Product decision

The first corpus consumer is not a prose demo. It is the existing Flood Control Dam #3 Maintenance Room flood because that system already has a canonical cause, clock, rising-water state, physical repair, escape routes, and death. Release 1231 improves what the player can perceive while preserving every underlying authority.

## Coupled gameplay

- Pushing the canonical blue button starts the canonical leak and records the visible west/south escape affordance.
- The existing `I-MAINT-ROOM` event still increments `WATER-LEVEL`; a bounded helper emits warnings at three thresholds and never owns time or water state.
- Examining the canonical `LEAK` identifies the east-wall pipe opening and one physical affordance without naming PUTTY or spelling out a command.
- The existing PUTTY route still calls `FIX-MAINT-LEAK`; Release 1231 reports the pipe shudder and draining water.
- The terminal Maintenance Room branch still calls `JIGS-UP`; the new death line explains the failed escape and follows the earned warning chain.

## Corpus coupling

Four player-visible families are stored with their style receipts in `qualification/corpus-evidence.json`:

| Family | Authority profile | Purpose |
|---|---|---|
| warning chain | `zork1-action-response` | physical cause, bounded escalation, state-aware repetition |
| leak examination | `zork1-object-description` | material specificity and one repair affordance |
| drowning | `zork1-death` | causal clarity, abrupt terminal rhythm, restrained dark humor |
| repair | `zork1-action-response` | show two changed physical states without tutorial prose |

The overlap corpus is a local ten-record canonical subset from relevant `1actions.zil` Maintenance Room, reservoir-warning, repair, and death surfaces. The committed source receipt contains record IDs, source hashes, surface labels, and digest `fa0f84c53c9e5c8f4eff49cc02749b2f6ec1a92f0680ce8f2fc7ff1a1f01dfd3`; it contains no source text and does not claim whole-lineage coverage.

All four candidates pass:

- contiguous overlap threshold: maximum six tokens;
- rare phrase width: five tokens;
- threshold violations: zero;
- rare phrase violations: zero;
- protected source text disclosed: false.

## Production delta

Exactly three staged paths may change:

- `1actions.zil` — five narrow canonical hook replacements;
- `corpus_causal_warning.zil` — bounded warning-memory and prose helpers;
- `zork1.zil` — Release 1231 identity and final module include.

## Qualification

Direct qualification covers:

- exact Release 1230 base identity;
- canonical flood ownership and absence of a parallel clock/water state;
- three bounded warning stages;
- exact hook count and expected production paths;
- candidate prose equality with ZIL strings;
- candidate hashes, corpus digest, passing overlap evidence, and receipt authorities;
- operational kanban lanes and DONE proof.

The full `qualify.sh` also stages Release 1231 and runs the repository ZIL smell checker. It uses an already installed local ZILF toolchain when available; this environment does not contain that binary, so no Release 1231 `.ulx` identity is claimed or fabricated here.

## Explicit exclusions

No automatic escape, automatic repair, alternate water meter, generic hazard engine, survival loop, hidden command solution, House bead reopening, archive mutation, S.T.A.L.K.E.R. mixing, Mara, museum intake, cuisine, Zork Plus, sub-beads, or recursive audit system.
