# Highly Extended Zork — Product Kanban

**Updated:** August 12, 2026  
**Board data:** `docs/planning/product-kanban.json`  
**Current merged production frontier:** Release `1252` — Earned Sequence Breaks & Route Mastery  
**`master` head when Release 1253 began:** `7768710a8b4fd4d4d798011eec70fe6f88112e81`

This board is the human operating surface for the active Zork product queue. The JSON board remains the tooling surface.

## Operating rules

- **CURRENT** contains at most one actively implemented train and may be empty between merged trains.
- **NEXT** is ordered.
- New work must be a substantial player-facing train, not placeholder cleanup.
- Canonical solutions remain valid when new physically credible alternatives are added.
- Reusable tools remain reusable where the same physical logic reasonably applies.
- Player ingenuity should reduce repeated friction, not create a fetch-grind tax.
- Soft sequence breaks are allowed when physically earned, state-safe, and non-bricking.
- No universal crafting grid, arbitrary object-pair matrix, generic physics simulator, recursive audit machinery, TODO-only slice, or no-op scaffolding.
- **DONE** requires merged or otherwise immutable proof.

## CURRENT

### Release 1254 — Troll Disarm & Stolen Weapons

**Active branch:** `agent/troll-disarm-stolen-weapons-20260812`  
**Stacked on:** qualified Release 1253 / PR #58 (`agent/dam-survival-prepared-rescue-20260812`)

**Player outcome:** losing a real weapon to the canonical troll can now become persistent physical custody rather than a momentary combat message: the troll can seize the exact object, wield it against its owner, taunt with it, bargain over it, lose it through combat, and surrender it when subdued or killed.

Current showcase:

- canonical troll combat remains the authority for `LOSE-WEAPON`; when that authored result occurs, the troll can snatch the adventurer's exact sword or knife before it reaches the floor;
- the captured object is the one real canonical object—there is no duplicate weapon, ownership token, or shadow inventory;
- while holding a captured player weapon, the troll prefers it as his combat weapon, so the player can literally face the sword or knife they lost;
- direct attempts to take a weapon from the armed troll remain physically blocked rather than silently moving the object;
- disarming the troll can knock a captured weapon loose through the existing combat result path;
- unconsciousness or death releases real held player weapons for recovery;
- food can buy the exact captured weapon back, but the bargain does not pacify the troll or open the exits;
- examine/listen/greeting flavor makes stolen custody visible without adding a dialogue tree or relationship meter;
- canonical troll strength, axe recovery, combat, unconsciousness/death, and exit gating remain authoritative.

Release 1254 is fully qualified on the stacked branch. Locked production artifact SHA-256:

`5db6a858d30cc2a06d1becb520795587753ca3d29791447f253a1cdd9bbd2fb4`

Final locked qualification run: `31629388400`.

### Qualified prerequisite awaiting merge

Release 1253 — Dam Survival & Prepared Rescue remains fully qualified in PR #58 and is **not merged**. Its locked production artifact remains:

`41cf57d533f721c8be1d8932075d5e093c0daf8dde0610cc40bf85fea796cb11`

## NEXT — ordered

### 1. Release 1255 — Thief Retaliation & Sabotage

Add visible, causal retaliation through selective theft, sabotage, warnings, earned ambushes, avoidance, repair, and appeasement while preserving the canonical thief's roaming and treasure behavior.

### 2. Release 1256 — Grue Ecology & Colony Reveal

Support selected darkness experiments and authored grue ecology, including stronger-light consequences and a signature colony reveal without turning grues into ordinary combat mobs.

### 3. Release 1257 — Fire, Smoke & Structural Consequences

Extend physicality into a deliberately small set of authored fire, smoke, collapse, and machinery consequences.

### 4. Release 1258 — Mara Reciprocal Rescue & Shared Danger

Advance Mara through reciprocal rescue, injuries/recovery, promises, exact temporary custody, separation/reunion, and difficult shared decisions without an approval meter.

## FUTURE

- **Treasure Guardian Dragon & Hoard** — create an original Zork-native dragon encounter around a real treasure hoard, authored territorial behavior, visible warning signs, and dangerous fire breath. Fire should compose with the eventual fire/smoke/material-consequence systems, while the encounter supports multiple credible Zork solutions such as preparation, environmental manipulation, trickery, avoidance, containment, or direct confrontation rather than becoming a generic hit-point boss fight. Shadowgate is an inspiration for the encounter archetype only; all prose, code, map layout, puzzle expression, objects, and exact solution structure are rebuilt from scratch.
- **Cross-IF / RPG Mechanics Adaptation — Shadowgate First** — deliberately study high-value mechanics and interaction patterns from other interactive-fiction games and RPGs, beginning with Shadowgate, then rebuild selected ideas as original Zork-native systems that compose with canonical state and the existing physicality mesh. Borrow concepts and design lessons, not source code, text, art, maps, exact puzzles, or expressive sequencing. Later widen the inspiration pool to other IF/RPGs and eventually selected S.T.A.L.K.E.R.-inspired mechanics, while keeping the separate S.T.A.L.K.E.R. Glulx product lane distinct.
- **Forest That Answers Back / Described World = Interactive World** — promote selected concrete nouns already present in authored forest descriptions into targetable, stateful world objects whose interactions compose with existing physicality rather than becoming decorative prose or a generic object generator.
- **Time, Weather & Disaster Arc** — layer authored time/weather conditions and selected disasters onto real geography and existing material state only where they create meaningful preparation, shelter, traversal, rescue, and aftermath play; no generic climate simulator.
- **Causal Death & Warning Depth** — authored fair warning, near-death, delayed-consequence, and exact-object provenance expansions.
- **Museum & Ecology second expansion** — only where collection creates new field play rather than checklist accumulation.
- **Narrative Perspective Experiments** — isolated first-person, third-person, and interactive-storybook editions against real canonical state.
- **Far-horizon DRAW + multi-agent experiments** — isolated experimental editions/tools only after the playable product supports them; keep them out of the canonical release train until deliberately promoted.
- Additional selected authored consequences from `LIVING_ZORK_FUTURE_IDEAS_KANBAN.md`.

## PARKED / SEPARATE

- **S.T.A.L.K.E.R. Glulx** remains a separate product lane and never rides inside a Zork gameplay PR.
- **Protected Corpus Acquisition** remains rights-dependent.
- Universal crafting, randomized loot progression, generic physics, and procedural world generation remain out of scope.

## DONE — current merged frontier

| Release | Train | PR |
|---:|---|---:|
| 1219–1230 | House of Records program | #32 |
| 1231 | Corpus-Coupled Causal Warning | #34 |
| 1232 | Parser Comprehension and Deep Affordances | #35 |
| 1233 | Museum Intake and First Gallery | #36 |
| 1234 | Mara Arrival and Evidence Memory | #37 |
| 1235 | Cuisine, Hunger, and Stamina | #38 |
| 1236 | Great Canyon Living Consequences | #39 |
| 1237 | Zork Plus Veteran Survey Expedition | #40 |
| 1238 | Cellar Expedition Recovery Locker | #41 |
| 1239 | Museum Ecology and Dam Fishing | #42 |
| 1240 | Museum Songbird Correspondence | #43 |
| 1241 | Museum Troll Provenance | #44 |
| 1242 | Natural-Play Regression Repair | #45 |
| 1243 | Mara Companion Expedition Foundation | #46 |
| — | Narrative Perspective Experiments documentation | #47 |
| 1244 | Mara House Company | #48 |
| 1245 | Creative Natural Play | #49 |
| 1246 | Environmental Destruction | #50 |
| 1247 | Narrative Physicality | #51 |
| 1248 | Forest Consequence Physicality | #52 |
| 1249 | Underground Sensory Physicality | #53 |
| 1250 | Player Ingenuity / Systemic Workarounds | #55 |
| 1251 | Cross-System Utility Mesh | #56 |
| 1252 | Earned Sequence Breaks & Route Mastery | #57 |

Release `1252` merged as `43a253a83a7349c9d3838e07488a90233f92410b`.

Final Release 1252 production artifact SHA-256:

`b376808be57262d3cec9c43d9bd2e8972e64362864bbe6a9bab682a0cc3334b6`

The post-Release-1252 handoff commit left `master` at `7768710a8b4fd4d4d798011eec70fe6f88112e81` before Release 1253 began. Release 1253 and Release 1254 are qualified stacked trains, not merged frontier releases.

## Canonical roadmap

See `docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md` for the design doctrine and the post-1249 product arc. Release 1254 applies that doctrine to persistent troll weapon custody while preserving Release 1255 as the next committed train and retaining the dragon, cross-IF/RPG mechanics adaptation, forest-density, time/weather/disaster, and far-horizon experiment opportunities above.
