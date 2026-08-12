# Highly Extended Zork — Product Kanban

**Updated:** August 11, 2026  
**Board data:** `docs/planning/product-kanban.json`  
**Current production frontier:** Release `1249` — Underground Sensory Physicality  
**`master` head when updated:** `bacb1a358f0ee126ee6ae629b589c3d3a0269ee9`

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

None.

Release `1249` is merged. The repository is between product trains.

## NEXT — ordered

### 1. Release 1250 — Player Ingenuity / Systemic Workarounds

**Player outcome:** intentionally exploit established mechanics in physically credible ways without the game treating ingenuity as cheating.

**First showcase:** Loud Room hearing protection.

- canonical `ECHO` remains valid;
- reusable earmuffs or a small plausible improvised-earplug route can suppress the worst acoustic interference;
- no pure-RNG lockout;
- no huge material-fetch chain;
- hearing protection remains useful on future crossings and impairs listening where appropriate;
- at least two additional authored workarounds reuse existing world authorities.

### 2. Release 1251 — Cross-System Utility Mesh

Make selected existing objects operate as real reusable tools across multiple contexts: rope, containers, light, hearing protection/sound, weight, breakable surfaces, and selected water interactions.

### 3. Release 1252 — Earned Sequence Breaks & Route Mastery

Allow selected physically earned shortcuts and soft sequence breaks. Preserve canonical routes and completion safety. Once a recurring nuisance is genuinely mastered, repeated travel should stay easier.

### 4. Release 1253 — Dam Survival & Prepared Rescue

Deepen Flood Control Dam #3 with authored water-state survival, encumbrance, rope/ladder preparation, buoyancy opportunities, object loss, and recovery.

### 5. Release 1254 — Troll Disarm & Stolen Weapons

Let the canonical troll seize or retain real weapons under authored conditions, creating persistent custody, taunts, bargaining, recovery, and consequences for losing your own weapon.

### 6. Release 1255 — Thief Retaliation & Sabotage

Add visible, causal retaliation through selective theft, sabotage, warnings, earned ambushes, avoidance, repair, and appeasement.

### 7. Release 1256 — Grue Ecology & Colony Reveal

Support selected darkness experiments and authored grue ecology, including stronger-light consequences and a signature colony reveal without turning grues into ordinary combat mobs.

### 8. Release 1257 — Fire, Smoke & Structural Consequences

Extend physicality into a deliberately small set of authored fire, smoke, collapse, and machinery consequences.

### 9. Release 1258 — Mara Reciprocal Rescue & Shared Danger

Advance Mara through reciprocal rescue, injuries/recovery, promises, exact temporary custody, separation/reunion, and difficult shared decisions without an approval meter.

## FUTURE

- **Causal Death & Warning Depth** — authored fair warning, near-death, delayed-consequence, and exact-object provenance expansions.
- **Museum & Ecology second expansion** — only where collection creates new field play rather than checklist accumulation.
- **Narrative Perspective Experiments** — isolated first-person, third-person, and interactive-storybook editions against real canonical state.
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

Release `1249` merged as `bacb1a358f0ee126ee6ae629b589c3d3a0269ee9`.

Final Release 1249 production artifact SHA-256:

`b36d4a17ab9682af64c94263fee317065aeacf9072d24cdc9392016ecd32a7a6`

## Canonical roadmap

See `docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md` for the design doctrine, Loud Room example, and expanded acceptance direction.

The next implementation train should start at **Release 1250 — Player Ingenuity / Systemic Workarounds** unless the live repository reveals a concrete dependency that must precede it.
