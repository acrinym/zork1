# Highly Extended Zork — Product Kanban

**Updated:** July 31, 2026  
**Board data:** `docs/planning/product-kanban.json`

This board answers five different questions: what is being built now, what is already sequenced next, what remains real but later, what is intentionally parked, and what is actually finished. A card is not “done” because a document mentions it. Done requires merged or immutable proof.

## Operating rules

- **CURRENT** contains one product train. Finishing or deliberately stopping it is required before another card moves in.
- **NEXT** is ordered. Every card has a player outcome, scope, dependency, acceptance contract, and boundary.
- **FUTURE** preserves product sequence without pretending work has started.
- **PARKED** names the dependency or separation rule that prevents accidental scope mixing.
- **DONE** carries proof.
- This board does not create sub-beads, reopen the completed House hierarchy, or become an audit of other planning files.

## CURRENT

### Release 1232 — Parser Comprehension and Deep Affordances

**Player outcome:** selected ordinary interactive-fiction phrases reach world behavior Zork already implements instead of failing at vocabulary or noun-role gaps.

**In production:** `X`, `INSPECT`, `EXAMINE UNDER`, `EXAMINE BEHIND`, `SWITCH ON/OFF`, `SEAL`, and `MEND` route to existing examination, spatial inspection, lamp, and plugging actions. The train adds no parser state, action routine, or response prose. Release 1211's bounded `USE OBJECT` assistance remains present and unchanged; Release 1232 does not broaden it.

**Proof required:** exact two-path staging, direct parser tests, source smell check, ZILF/Glazer artifact qualification, and a Glulxe transcript proving the actual commands and canonical outputs. PR: **#35**.

## NEXT

1. **Museum Intake and First Gallery** — physical donation, provenance, refusal rules, and earned exhibit descriptions without duplicate treasures or an encyclopedia HUD.

## FUTURE

- **Mara Companion** — bounded knowledge, presence, relationship memory, and a dedicated dialogue profile.
- **Cuisine, Hunger, and Stamina** — authored combinations and situational consequences without survival grind.
- **Living Zork Consequences** — extend the Release 1231 cause-warning-consequence pattern across selected canonical dangers.
- **Zork Plus / Veteran Expedition** — explicit post-victory content recognizing completed history.
- **Physical Expedition Stash** — real-object staging and capacity for later expeditions.

## PARKED

- **S.T.A.L.K.E.R. Glulx** remains a separate game lane. It never rides inside a Highly Extended Zork gameplay PR.
- **Protected corpus acquisition** waits for lawful local copies or verified rights. Metadata, hashes, references, and derived analysis remain the public boundary.

## DONE

- **House of Records / Release 1230:** 12 trains, 96/96 beads, completed expedition archive, merged through PR #32. Locked artifact SHA-256: `b446e12ebffc570c0058347583bacc768f6a51f5f5166634da91898004d68c71`.
- **Infocom Corpus Foundation:** extraction, rights gates, authority profiles, originality validation, receipts, all review findings and nits resolved, 25 tests green, merged through PR #33 at `d7cc4750507fed9b505af66e0fd6afee2da70ffb`.
- **Release 1231 Corpus-Coupled Causal Warning:** zero-state flood warnings, inspection, repair feedback, causal death prose, four style receipts, and hosted locked artifact qualification; merged through PR #34 at `28b90fe93a472087e64afcd0fb0e8776f80157f3`. Artifact SHA-256: `5daaa7307ef496a3ae37209a6e79e149c9dc3d202f148f143bbb571fa74b3609`.

The JSON board is authoritative for tooling and card metadata. This Markdown view is the human operating surface.
