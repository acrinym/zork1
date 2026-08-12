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

### Release 1257 — Fire, Smoke & Structural Consequences

**Active branch:** `agent/fire-smoke-structural-consequences-20260812`  
**PR:** #62  
**Stacked on:** qualified Release 1256 / PR #61 (`agent/grue-ecology-colony-reveal-20260812`)

**Player outcome:** the canonical Timber Room now supports one persistent authored fire lifecycle using real flame, real bottled water, existing mine airflow, and persistent physical aftermath instead of a generic fire or chemistry simulator.

Current showcase:

- the dry broken timbers are a real burn target, but first ignition produces a recoverable smolder rather than instant deletion or explosion;
- a new smolder can be stamped out before it earns open flame;
- ignored smolder becomes open flame, and the room's existing westward draft drives smoke into the narrow west crawl while preserving the wide east escape;
- the real open bottle containing the real water can douse active timber fire, consuming that water and leaving scorched aftermath;
- ignored open flame gives audible structural warning before one old brace drops into the burning clutter;
- the fire eventually burns itself down to a persistent charred heap and fallen brace;
- the collapse does not widen, delete, or brick the canonical `EMPTY-HANDED` narrow passage;
- fire state is table-backed and consumes zero new VM globals;
- canonical `gverbs.zil` / `V-BURN` and canonical Gas Room behavior in `1actions.zil` remain byte-for-byte unchanged;
- the canonical coal object remains real, movable, and burnable.

Release 1257 is fully qualified on the stacked branch. Locked production artifact SHA-256:

`0664b758da1809195489f577f655497e5ccb981f7b6c5fb1b69b8b48b77a5b23`

Exact qualified staged-source identities:

- production: `addcfb42663813c49ff822b009ce46302f750739cda345854bf143f77836aa31`
- dev: `5d383e7e920369fd0b6a78f424b013a17d702a7bdd884ba1dd8b2c7478844ed8`

Final locked qualification run: `31650907894`.

### Qualified prerequisites awaiting merge

- **Release 1256 — Grue Ecology & Colony Reveal / PR #61** — `dbad355f6d18245d48671102bf4d449f227c03bd8e39ec569c9a41d8508c7c4a`
- **Release 1255 — Thief Retaliation & Sabotage / PR #60** — `89664ebb9b728257f14b2831f6a9fda45d9de0e6bacb807fba8a1eec7b9b667e`
- **Release 1254 — Troll Disarm & Stolen Weapons / PR #59** — `5db6a858d30cc2a06d1becb520795587753ca3d29791447f253a1cdd9bbd2fb4`
- **Release 1253 — Dam Survival & Prepared Rescue / PR #58** — `41cf57d533f721c8be1d8932075d5e093c0daf8dde0610cc40bf85fea796cb11`

All remain **unmerged** above the Release-1252 production frontier.

## NEXT — ordered

### 1. Release 1258 — Mara Reciprocal Rescue & Shared Danger

Advance Mara through reciprocal rescue, injuries/recovery, promises, exact temporary custody, separation/reunion, and difficult shared decisions without an approval meter.

## FUTURE

- **Treasure Guardian Dragon & Hoard** — create an original Zork-native dragon encounter around a real treasure hoard, authored territorial behavior, visible warning signs, and dangerous fire breath. Fire should compose with the Release-1257 fire/smoke/material-consequence authority, while the encounter supports multiple credible Zork solutions such as preparation, environmental manipulation, trickery, avoidance, containment, or direct confrontation rather than becoming a generic hit-point boss fight. Shadowgate is inspiration for the encounter archetype only; all prose, code, map layout, puzzle expression, objects, and exact solution structure are rebuilt from scratch.
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

The post-Release-1252 handoff commit left `master` at `7768710a8b4fd4d4d798011eec70fe6f88112e81` before Release 1253 began. Releases 1253–1257 are qualified stacked trains, not merged frontier releases.

## Canonical roadmap

See `docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md` for the design doctrine and post-1249 product arc. Release 1257 establishes the first shared authored world-fire authority while preserving Release 1258 as the next committed train and retaining the dragon, Shadowgate-first cross-IF/RPG adaptation, forest-density, time/weather/disaster, and far-horizon experiment opportunities above.
