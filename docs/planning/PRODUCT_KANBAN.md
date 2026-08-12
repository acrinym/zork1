# Highly Extended Zork — Product Kanban

**Updated:** August 12, 2026  
**Board data:** `docs/planning/product-kanban.json`  
**Current merged production frontier:** Release `1251` — Cross-System Utility Mesh  
**`master` head when Release 1252 began:** `147236fcc61ac98b993ff1905c6e07c6bfbb6079`

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

### Release 1252 — Earned Sequence Breaks & Route Mastery

**Active branch:** `agent/earned-sequence-breaks-route-mastery-20260812`

**Player outcome:** a knowledgeable player can prepare real geography and reuse real equipment so selected routes become meaningfully easier without replacing canonical traversal or creating magic shortcuts.

Current showcase:

- the Release 1236 Great Canyon rim anchor and Release 1251 rope/cargo mesh become one physical truth;
- `SECURE ROPE` and natural `TIE/FASTEN ROPE TO CANYON RIM` operate the same real rope authority;
- a cinched brown sack can be lowered from Canyon View to Rocky Ledge, hauled back, or recovered after following the authored climb;
- the rope remains physically committed to the canyon rim until that knot is actually freed;
- White Cliffs width checks see an inflated magic boat even when it is nested in a carried container;
- `FOLD BOAT` and `COLLAPSE BOAT` use the canonical deflation action and preserve its on-ground requirement;
- the rainbow remains stateful traversal geometry, not a rope anchor, and its lethal unsupported state is unchanged.

No teleport verbs, shortcut menu, generic route solver, object-pair recipe matrix, or universal physics engine.

## NEXT — ordered

### 1. Release 1253 — Dam Survival & Prepared Rescue

Deepen Flood Control Dam #3 with authored water-state survival, encumbrance, rope/ladder preparation, buoyancy opportunities, object loss, and recovery.

### 2. Release 1254 — Troll Disarm & Stolen Weapons

Let the canonical troll seize or retain real weapons under authored conditions, creating persistent custody, taunts, bargaining, recovery, and consequences for losing your own weapon.

### 3. Release 1255 — Thief Retaliation & Sabotage

Add visible, causal retaliation through selective theft, sabotage, warnings, earned ambushes, avoidance, repair, and appeasement.

### 4. Release 1256 — Grue Ecology & Colony Reveal

Support selected darkness experiments and authored grue ecology, including stronger-light consequences and a signature colony reveal without turning grues into ordinary combat mobs.

### 5. Release 1257 — Fire, Smoke & Structural Consequences

Extend physicality into a deliberately small set of authored fire, smoke, collapse, and machinery consequences.

### 6. Release 1258 — Mara Reciprocal Rescue & Shared Danger

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
| 1250 | Player Ingenuity / Systemic Workarounds | #55 |
| 1251 | Cross-System Utility Mesh | #56 |

Release `1250` merged as `cd6a918795196b6918a2a5c5600b56c1c0d6e20b`.

Release `1251` merged as `79b87248d567962fff2181e4996d1cf424cdcac0`.

Final Release 1251 production artifact SHA-256:

`f109db13195574227d0487f732f63f16c4a2d8d48ea9823a15e63becd53791d7`

The subsequent planning refresh merged through PR #54 and left `master` at `147236fcc61ac98b993ff1905c6e07c6bfbb6079` before Release 1252 began.

## Canonical roadmap

See `docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md` for the design doctrine and the post-1249 product arc. Release 1252 applies that doctrine to the Great Canyon / White Cliffs route-mastery seam while preserving the future train order above.
