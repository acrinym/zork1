# Corpus-Coupled Causal Warning — Release 1231 Train

**Repository:** `acrinym/zork1`  
**Base:** merged Infocom Corpus Foundation at `d7cc4750507fed9b505af66e0fd6afee2da70ffb`  
**Branch:** `agent/corpus-causal-warning-20260731`  
**PR:** `#34`  
**Date:** July 31, 2026

## Product decision

The first corpus consumer is not a prose demo. It is the existing Flood Control Dam #3 Maintenance Room flood because that system already has a canonical cause, clock, rising-water state, physical repair, escape routes, and death. Release 1231 improves what the player can perceive while preserving every underlying authority.

## Coupled gameplay

- Pushing the canonical blue button starts the canonical leak and reports the visible west/south escape affordance.
- The existing `I-MAINT-ROOM` event still increments `WATER-LEVEL`; a bounded helper speaks only at exact levels 3, 5, and 11.
- Examining the canonical `LEAK` identifies the east-wall pipe opening and one physical affordance without naming PUTTY or spelling out a command.
- The existing PUTTY route still calls `FIX-MAINT-LEAK`; Release 1231 reports the pipe shudder and draining water.
- The terminal Maintenance Room branch still calls `JIGS-UP`; the new death line explains the failed escape and follows the earned warning chain.

Release 1231 adds **zero flood globals**. GitHub-hosted ZILF proved that Release 1230 already occupied all 236 available globals, so the earlier warning-stage variable was removed. Monotonic canonical `WATER-LEVEL` crossings make each warning occur once without shadow state, another timer, or another controller.

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
- `corpus_causal_warning.zil` — zero-state warning, inspection, repair, and death prose helpers;
- `zork1.zil` — Release 1231 identity and final module include.

## Qualification

Direct qualification covers:

- exact Release 1230 base identity;
- canonical flood ownership and absence of a parallel clock, water state, or new flood global;
- three exact, depth-consistent `WATER-LEVEL` crossings;
- exact hook count and expected production paths;
- candidate prose equality with ZIL strings;
- candidate hashes, word counts, corpus digest, passing overlap evidence, and receipt authorities;
- operational kanban lanes and DONE proof;
- shell syntax and an executable ZILF → serial normalization → Glazer → ULX verification route.

GitHub-hosted qualification uses:

- pinned Zork I Glulx source `1ada70e58ac4933446b907d67949d9cab3119c0e`;
- pinned Glulx ZILF `45c60f1e37651f266ac92d49ae01748bb4909fa5`;
- checksum-verified Glazer 1.2.0;
- Python 3.12 and .NET 10.

The workflow uploads the compiled ULX, assembly, staging receipt, corpus evidence, smell report, serial receipt, artifact report, final qualification receipt, and build logs. It is direct product CI, not a reusable audit framework.

## Explicit exclusions

No automatic escape, automatic repair, alternate water meter, generic hazard engine, survival loop, hidden command solution, House bead reopening, archive mutation, S.T.A.L.K.E.R. mixing, Mara, museum intake, cuisine, Zork Plus, sub-beads, recursive audit system, or shared staging-framework refactor.
