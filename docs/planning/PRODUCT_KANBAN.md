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

### Release 1253 — Dam Survival & Prepared Rescue

**Active branch:** `agent/dam-survival-prepared-rescue-20260812`

**Player outcome:** Flood Control Dam #3 now answers to its real gate/water state, the adventurer's real carried weight, a physical maintenance ladder, and the existing rope authority so deliberate risky actions can cause recoverable loss, death, or earned rescue depending on preparation.

Current showcase:

- an iron maintenance ladder physically connects the dam top and Dam Base while ordinary authored exits remain safe;
- closed/high overflow can make an overloaded ladder descent knock the heaviest eligible loose item to Dam Base, where it can be recovered;
- open sluices plus an overloaded, unprepared ladder descent can kill the adventurer;
- tying the existing rope to the maintenance ladder creates a real fixed handline that catches the same dangerous slip;
- with sluices open, deliberately entering the Frigid River without a fixed line is lethal, while the prepared handline lets the adventurer survive the experiment and claw back to the landing;
- the canonical inflatable/magic boat and `RBOAT-FUNCTION` remain the authored river-travel solution;
- canonical `GATES-OPEN` / `LOW-TIDE`, carried-object identity, rope anchoring, and normal dam movement remain authoritative—no parallel dam simulation was added.

Release 1253 is fully qualified on the branch and waiting for PR review/merge whistle. Locked production artifact SHA-256:

`41cf57d533f721c8be1d8932075d5e093c0daf8dde0610cc40bf85fea796cb11`

## NEXT — ordered

### 1. Release 1254 — Troll Disarm & Stolen Weapons

Let the canonical troll seize or retain real weapons under authored conditions, creating persistent custody, taunts, bargaining, recovery, and consequences for losing your own weapon.

### 2. Release 1255 — Thief Retaliation & Sabotage

Add visible, causal retaliation through selective theft, sabotage, warnings, earned ambushes, avoidance, repair, and appeasement.

### 3. Release 1256 — Grue Ecology & Colony Reveal

Support selected darkness experiments and authored grue ecology, including stronger-light consequences and a signature colony reveal without turning grues into ordinary combat mobs.

### 4. Release 1257 — Fire, Smoke & Structural Consequences

Extend physicality into a deliberately small set of authored fire, smoke, collapse, and machinery consequences.

### 5. Release 1258 — Mara Reciprocal Rescue & Shared Danger

Advance Mara through reciprocal rescue, injuries/recovery, promises, exact temporary custody, separation/reunion, and difficult shared decisions without an approval meter.

## FUTURE

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

The post-Release-1252 handoff commit left `master` at `7768710a8b4fd4d4d798011eec70fe6f88112e81` before Release 1253 began.

## Canonical roadmap

See `docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md` for the design doctrine and the post-1249 product arc. Release 1253 applies that doctrine to Flood Control Dam #3 while preserving Release 1254 as the next committed train and retaining the newer forest-density, time/weather/disaster, and far-horizon experiment opportunities above.
