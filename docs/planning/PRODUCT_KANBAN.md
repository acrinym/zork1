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

### Release 1236 — Living Zork Consequences: Great Canyon Fall

**Player outcome:** the Great Canyon’s lethal leap becomes physically legible before death, and a player who deliberately prepares the real rope can experience a real near-fall and recovery instead of an unexplained binary trap.

**In production:** Canyon View gains an inspectable open-surface rim; the first unprepared leap produces a concrete footing warning; `SECURE ROPE` places the canonical Attic rope physically on that rim; only that real containment provides protection; a prepared leap catches the player and creates bounded exertion strain; ordinary `TAKE ROPE` restores custody and naturally removes protection; `RECOVER` permits a later deliberate unprotected leap; the untouched canonical death remains authoritative.

**Qualification:** PR **#39** on `agent/living-zork-consequences-20260801`. Public hosted run **30683325463** passed exact Release 1235 staging, 12 direct consequence tests, rights-safe prose originality, ZILF compilation, Glazer assembly, ULX verification, and the complete Glulxe route. The candidate artifact is `344320` bytes, checksum `0x8cb988cc`, SHA-256 `26b32e777be0fe6c44736ae483a594519bf98264ec95603dd4ff7238124c94d7`; the final gate is exact locked reproduction and review closure.

## NEXT

1. **Zork Plus / Veteran Expedition** — explicit post-victory content that recognizes completed history without invalidating canonical Zork I.
2. **Physical Expedition Stash** — bounded real-object staging, capacity, provenance, and later retrieval for post-victory expeditions.

## FUTURE

- **Living Zork Consequences — additional families** — machinery, water, fire, and creature-danger continuations only after the Great Canyon fall loop is complete; each remains a direct authored product, never a generic hazard engine.

## PARKED

- **S.T.A.L.K.E.R. Glulx** remains a separate game lane. It never rides inside a Highly Extended Zork gameplay PR.
- **Protected corpus acquisition** waits for lawful local copies or verified rights. Metadata, hashes, references, and derived analysis remain the public boundary.

## DONE

- **House of Records / Release 1230:** 12 trains, 96/96 beads, completed expedition archive, merged through PR #32. Locked artifact SHA-256: `b446e12ebffc570c0058347583bacc768f6a51f5f5166634da91898004d68c71`.
- **Infocom Corpus Foundation:** extraction, rights gates, authority profiles, originality validation, receipts, all review findings and nits resolved, 25 tests green, merged through PR #33 at `d7cc4750507fed9b505af66e0fd6afee2da70ffb`.
- **Release 1231 — Corpus-Coupled Causal Warning:** canonical flood warnings and repair affordance, merged through PR #34. Locked artifact: `337920` bytes, checksum `0x1b994d18`, SHA-256 `5daaa7307ef496a3ae37209a6e79e149c9dc3d202f148f143bbb571fa74b3609`.
- **Release 1232 — Parser Comprehension and Deep Affordances:** selected ordinary IF phrases route to canonical behavior, merged through PR #35 at `ce5be325a0d0f762edaa23362e5227d4788953d6`. Locked artifact: `337920` bytes, checksum `0x2c2192e1`, SHA-256 `2cffc734dbfbe346d0ec185c6962d927bc046343dccdb53b6a9e4439521b6f2e`.
- **Release 1233 — Museum Intake and First Gallery:** physical exhibit custody, catalog, review, and earned classification, merged through PR #36 at `f0bdd696d447cdb727b82229b218abf7a6905f91`. Locked artifact: `338432` bytes, checksum `0x7065f1fc`, SHA-256 `4ac789f379231cbc7a871f6d092f824f8098607ee60239936f57aa39585c5244`.
- **Release 1234 — Mara Arrival and Evidence Memory:** Mara’s physical presence and exact witnessed-object memory, merged through PR #37 at `76f1e451a4fb70dcf6ea1d41cb8705f2ad5236d4`. Locked artifact: `339712` bytes, checksum `0x69fd7910`, SHA-256 `38b966f47d771e0f5ae6229ff6a7542830ce6e365a3d2291f764581ae0b64a17`.
- **Release 1235 — Cuisine, Hunger, and Stamina:** authored canonical lunch-and-garlic meal, bounded exertion, situational hunger, `RECOVER`, and physical ingredient custody, squash-merged through PR #38 at `e2e5c9c3e269d8e18bb3ed1c75dd72baacbd495a`. Locked artifact: `342784` bytes, checksum `0x282c807e`, SHA-256 `14b8341c298028e7d762c59d5a5757e6a52dcafa074aa5cd63d7930079ff13cf`.

The JSON board is authoritative for tooling and card metadata. This Markdown view is the human operating surface.
