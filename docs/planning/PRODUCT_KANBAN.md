# Highly Extended Zork — Product Kanban

**Updated:** August 13, 2026  
**Board data:** `docs/planning/product-kanban.json`  
**Current merged production frontier:** Release `1256` — Grue Ecology & Colony Reveal  
**`master` head before Release 1257 merge:** `14d1be667db3110d532b0e2c28f00b92371693fc`

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
**Base:** merged Release 1256 on `master`

**Player outcome:** the canonical Timber Room now supports one persistent authored fire lifecycle using real flame, limited bottled water, existing mine airflow, and persistent physical aftermath instead of a generic fire or chemistry simulator.

Current showcase:

- the dry broken timbers are a real burn target, but first ignition produces a recoverable smolder rather than instant deletion or explosion;
- a new smolder can be stamped out or doused with the real bottled water before it earns open flame;
- ignored smolder becomes open flame, and the room's existing westward draft drives smoke into the narrow west crawl while preserving the wide east escape;
- once open flame has established through the timber pile, one bottle of water is no fire hose: it hisses into steam and darkens a patch, but the structural fire continues advancing;
- repeatedly trying the bottle or `EXTINGUISH TIMBERS` after open flame cannot freeze the fire clock;
- ignored open flame gives audible structural warning before one old brace drops into the burning clutter;
- the fire eventually burns itself down to a persistent charred heap and fallen brace;
- the collapse does not widen, delete, or brick the canonical `EMPTY-HANDED` narrow passage;
- fire state is table-backed and consumes zero new VM globals;
- canonical `gverbs.zil` / `V-BURN` and canonical Gas Room behavior in `1actions.zil` remain byte-for-byte unchanged;
- the canonical coal object remains real, movable, and burnable.

Release 1257 is fully qualified against the repaired merged Release-1256 lineage. Locked production artifact SHA-256:

`d5080468723731018db587bcb5320cb88bb0a0b7585ee1c83156497dfb7fc444`

Artifact size/checksum:

- size: `438784` bytes
- checksum: `0x73c14bad`

Exact qualified staged-source identities:

- production: `f73099921f56be8e496aab560e81c5fcf4722b6b9c45c97750597140d8d25ff6`
- dev: `e99fd0e5331edbb4bc0a8faea0961f200e8fa356c84e8ac608c4df738814071c`

Final locked qualification run: `31741847431`.

The qualification explicitly proves both sides of the water-scale rule: bottled water can stop the fresh smolder, while bottled water used after open flame produces steam but leaves the fire burning, after which the brace still falls and the aftermath still reaches the charred state.

## NEXT — ordered

### 1. Release 1258 — Mara Reciprocal Rescue & Shared Danger

Advance Mara through reciprocal rescue, injuries/recovery, promises, exact temporary custody, separation/reunion, and difficult shared decisions without an approval meter.

**Discussion checkpoint:** do not begin implementation until the train is discussed with Justin.

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
| 1253 | Dam Survival & Prepared Rescue | #58 |
| 1254 | Troll Disarm & Stolen Weapons | #59 |
| 1255 | Thief Retaliation & Sabotage | #60 |
| 1256 | Grue Ecology & Colony Reveal | #61 |

Recent merged production receipts:

- Release 1253 merge `f5b1f1a3e7f65ff11db06f344580f83c3ed191b1`; artifact `232baaa8255f4b95ab5f90e13e6669874bcd42c66744d8173f360169ffb499ff`.
- Release 1254 merge `7b99869d8cb2e6db93243432fd8140a937205f44`; artifact `86fe8c6be4d377299ec66ae08801510303232d03a7dd5d5d42dc77357a51e6e0`.
- Release 1255 merge `8ad53ebc2ec2ce2a454ce6951d919bb1a2025937`; artifact `03dde8995474368119597a6b4ba87e35feeb4147a8f1ff1327574a7af34820be`.
- Release 1256 merge `14d1be667db3110d532b0e2c28f00b92371693fc`; artifact `59a457cc4aeb17e3d1d1b4e219be82156302f982804310c996cd928f03b79975`.

## Canonical roadmap

See `docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md` for the design doctrine and post-1249 product arc. Release 1257 establishes the first shared authored world-fire authority with scale-aware suppression: a bottle can stop a fresh smolder but not an established structural fire. Release 1258 remains the next committed train, but implementation is intentionally paused for discussion before any Mara work begins.
