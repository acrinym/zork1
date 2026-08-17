# Highly Extended Zork — Product Kanban

**Updated:** August 17, 2026  
**Board data:** `docs/planning/product-kanban.json`  
**Current merged production frontier:** Release `1263` — Ablative Protection & Equipment Consequence  
**`master` head when the 1264–1266 stack started:** `1a5b9cb27e85648fd7cd95cd1c9c890be1d71e66`

This board is the human operating surface for the active Zork product queue. The JSON board remains the tooling surface.

## Operating rules

- **CURRENT** contains at most one actively implemented product train and may be empty between trains.
- **NEXT** is ordered and contains concrete player-facing work, not cleanup placeholders.
- Open stacked predecessors are recorded separately from CURRENT and are never treated as DONE merely because a descendant train is active.
- Canonical Zork solutions remain valid when new physically credible alternatives are added.
- Reusable tools remain useful where the same physical logic reasonably applies.
- Cleverness should reduce repeated friction rather than create a new fetch-grind tax.
- Soft sequence breaks are allowed only when physically earned, state-safe, and non-bricking.
- Mara remains one authored human adventurer: no approval meter, generic follower framework, skill tree, omniscient companion AI, or romance meter.
- Mara romance/partnership remains an explicit future authored path and must grow from lived history and mutual choice.
- No universal crafting grid, arbitrary object-pair matrix, generic physics simulator, generic creature brain, recursive audit machinery, TODO-only slice, or no-op scaffolding.
- **DONE** requires merged or otherwise immutable proof.

## OPEN STACKED PREDECESSORS

The active stack is:

`master` / merged Release 1263 → **PR #69 / Release 1264** → **PR #70 / Release 1265** → **PR #71 / Release 1266 CURRENT**.

None of the three open releases is DONE, and none may be merged without a new explicit merge whistle.

### Release 1264 — Perilous Affordances / Let the Player Be Wrong

**PR:** #69 — open, non-draft, mergeable.  
**Current branch head:** `7a11375160d8893698f6df3ce16b8c8c35a810fc`  
**Locked artifact SHA-256:** `04216477fb50deeb04f833122d5874c602277b2b4522cbf72420f2b987b52a1d`  
**Release-specific exact-artifact qualification:** run `31949574481` green on implementation/review head `931b7653b38db58b71e77b8efe6085d7120b6dbd`; the later `7a113751...` change is maintenance-only Kanban regression repair and does not alter Release 1264 production/staging inputs.

Release 1264 remains the first unmerged prerequisite in the current stack. Its authored consequences remain:

- explicit weapon-driven destruction of the canonical brass lantern reaches the existing `BROKEN-LAMP` consequence family;
- the canonical hemp rope can be deliberately cut or burned, including the recoverable self-fire history when burned around the Adventurer's legs;
- deliberate burning/cutting of the Release 1263 fire screen consumes or ruins its existing qualitative protection state;
- explicit destruction of Release 1262 star-glass removes that treasure while other dragon routes and substitutes remain real;
- untouched canonical lantern, rope, and star-glass histories remain qualified.

### Release 1265 — Consumable Light & Graduated Darkness

**PR:** #70 — open, non-draft, mergeable, stacked on PR #69.  
**Current branch head:** `3d0b15efbf6ba227fcbc1a2edad1b325e2e0c197`  
**Stack base:** PR #69 head `7a11375160d8893698f6df3ce16b8c8c35a810fc`  
**Locked artifact SHA-256:** `6908e60a4dc191e1f74353055aa3dce11e72172edb96557a0f66d069327c1070`  
**Final exact production-head qualification:** run `32034566984` green on `b431122a87b20340e1c4ebbd2515549012e21bd6`; the later `3d0b15ef...` commit changes only workflow trigger/error-handling surfaces and no Release 1265 production story path.

Release 1265 remains the immediate unmerged predecessor for Release 1266. It promotes existing light/resource authorities into qualitative authored world state rather than replacing them:

- canonical lamp/candle timers remain the consumable-resource authority;
- selected exact portable sources have authored **bright / weak / ember / dark** useful reach while binary `LIT?` remains authoritative;
- a bright lamp or canonical ivory torch can reveal the existing grue colony, while weaker light has contracted reach;
- real bottled water can waterlog ritual candles and the existing flame-transfer route works again after narrated drying;
- Release 1257's Timber Room fire/smoke/draft can snuff carried ember-stage candles;
- no lux map, numeric fuel points, generic light-source class, universal fuel registry, replacement grue logic, replacement `LIT?`, or new legacy VM globals were added.

## CURRENT

### Release 1266 — Learned Magic as Parser Capability

**PR:** #71 — open, non-draft stacked PR targeting the Release 1265 branch; **do not merge without a new explicit merge whistle**.  
**Stack base:** PR #70 head `3d0b15efbf6ba227fcbc1a2edad1b325e2e0c197`  
**Locked artifact SHA-256:** `d26e66c95db2df733f4d2f0e8080650b4ec9ae4b5aa11082e6760835cb955fa9`  
**Locked implementation qualification:** run `32042145187` green on exact implementation head `8e242267b9919be1f33828f1030a7ece24013d13`.

Release 1266 makes learned knowledge change what the parser can meaningfully do without introducing a generic spell system:

- `STUDY <readable object>` creates a deliberate learning action rather than treating possession as expertise;
- one-object `WARD <object>` parses before learning but changes nothing until the Adventurer has actually learned the technique;
- `KNOWLEDGE` / `LORE` reports what has genuinely been learned;
- the existing damaged black-book material must first be reconstructed through existing Ritual Resonance interaction; only then can deliberate study teach the original GUE **stilling ward**;
- `WARD CANDLES` dries Release 1265's exact waterlogged-wick state without lighting or restoring the candles;
- after natural `RING BELL` produces the canonical `HOT-BELL`, `WARD BELL` routes through canonical `I-XBH` cooldown while leaving the active ceremony interval authoritative;
- the existing two-object `WARD HOUSE WITH GARLIC` grammar remains owned by House Vulnerability;
- unrelated objects are explicitly not generic spell targets;
- learned state occupies one compact four-slot mutable table and adds **zero new legacy VM globals**.

The qualifier reruns the complete locked Release 1265 predecessor, pins its exact staged production/development source identities, stages exactly `learned_magic.zil` plus Release identity/include wiring in `zork1.zil`, byte-checks unchanged parser/ritual/light/house-ward authorities, compiles production and test stories, and proves four natural-command histories: learning gate, wet-candle ward, canonical hot-bell ward, and old house-ward grammar coexistence.

Candidate run `32041714915` intentionally stopped only at the artifact-lock gate after all gameplay and compile/static gates passed. Locked run `32042145187` reproduced the exact artifact and passed the complete nested qualification green.

The Mara-focused run remains intentionally paused after Release 1261 while the wider world receives comparable authored depth.

## NEXT — Shadowgate → Parser IF Adaptation Program

Shadowgate is a **design lens only**. Borrow interaction principles and rebuild them from scratch as original Zork-native parser play. Do not copy source code, prose, art, maps, exact puzzles, spell names, object lists, or expressive sequencing.

Full train specifications: `docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md`.

### 1. Release 1267 — Semantic Examination & Hidden Structure

Promote selected meaningful descriptive details into trustworthy parser targets.

- seams, scorches, drafts, stains, hinges, damaged fittings, and other authored details can be examined/referenced naturally;
- targetability does not guarantee success;
- no generic noun generator.

### 2. Release 1268 — Clue Chains & Knowledge-Gated Interpretation

Carry learned meaning across locations so earlier documents, symbols, observations, museum evidence, and testimony can change later interpretation without requiring the original clue object forever.

- prefer named causal facts over generic clue counters;
- museum/archive knowledge can become useful in the field;
- companions do not become automatic hint engines.

### 3. Release 1269 — Structural Difficulty Modes

Difficulty changes evidence redundancy, recoverability, substitutes, resources, and consequence windows instead of merely multiplying damage.

- same underlying world identity;
- no parser-phrasing difficulty tax;
- no enemy-health multiplier masquerading as puzzle difficulty.

### 4. Release 1270 — Causal Death & Failure Feedback

Death and near-death should communicate physical cause, ignored evidence, partially sound ideas, and what exact state/action changed the outcome without simply handing over the solution.

### 5. Release 1271 — Creature Encounters as Systemic Puzzles

Living beings remain authored situations with distinct motives, senses, capacities, fears, possessions, territory, and memory rather than hit-point-shaped locks.

- frighten, bribe, distract, trap, outrun, negotiate, trick, incapacitate, kill, befriend, manipulate, avoid, or leave alone where appropriate to that specific being;
- troll, thief, grue, dragon, and Mara remain meaningfully different;
- no generic creature AI brain or universal disposition meter.

### 6. Release 1272 — Shadowgate-Style Macrostructure, Original Zork Region

Capstone the program with a substantial original Zork region whose **design grammar** composes the prior trains into one coherent adventure language.

Target roughly 20–30 authored rooms only if the design earns that size, with cross-location clues, multiple-use objects, reactive threats, meaningful consumables, learned knowledge/magic, hidden structure, unsafe-before-prepared routes, creature situations, intersecting solution paths, persistent consequences, and optional secrets.

## POST-SHADOWGATE WORLD EXPANSION

### Release 1273 — Living Biomes & Wilderness Expansion

Expand Zork's **actual geography and ecology**, rather than treating “enhance the forest” as another pass over the existing tree/bird/egg scene or the existing vine-and-dense-underbrush edge.

The initial train should earn at least two genuinely new wilderness identities:

1. **a new forest subregion** — additional connected forest geography with its own landmarks, routes, material state, animals/plants, discoveries, hazards, and authored situations; and
2. **a first wholly new climate/biome: jungle or rainforest** — a place whose heat, humidity, canopy, water, mud, flora, fauna, visibility, sounds, traversal, and danger make it play differently from the existing temperate forest.

A biome is not a palette swap. New geography should create new things that can happen:

- canopy and undergrowth can alter sight lines, light, navigation, falling objects, climbing, concealment, and shelter;
- rain, standing water, mud, heat, and humidity can matter to real objects and existing material authorities where physically appropriate;
- biome-specific plants and animals can be concrete parser targets with authored behavior rather than decorative nouns;
- routes can include rivers, ravines, flooded crossings, roots, cliffs, fallen trees, dense growth, clearings, caves, ruins, nests, or other terrain when the map earns them;
- new areas can own fully scripted scenes, encounters, discoveries, weather moments, creature situations, optional secrets, and persistent consequences;
- existing systems such as light, fire, water, equipment consequence, creature behavior, learned knowledge, evidence, Mara, and survival should be reused when the same physical fact genuinely applies rather than duplicated under biome-specific counters.

This train also establishes the **authored-biome doctrine** for later expansion: future marsh/wetland, highland/alpine, arid/desert, coast, or other climates may be added if they earn distinct geography and play. Release 1273 does not promise all of those at once.

Deliberate boundaries:

- no procedural biome generator;
- no palette-swapped room factory;
- no universal biome stat sheet;
- no generic climate simulator;
- no “every plant is harvestable” crafting economy;
- no map growth merely to increase room count.

The existing **Forest That Answers Back** lane remains complementary: it deepens targetability and consequence inside already-described places. Release 1273 is the separate expansion lane that creates **new places and new ecological situations**.

## FUTURE — explicit lanes

- **Mara Earned Romance & Partnership** — mutual attraction, explicit mutual choice, closeness, boundaries, disagreement, initiative, repair, and partnership growing from lived history; no approval/love meter and no compulsory romance.
- **Forest That Answers Back / Existing-Region Interactivity** — continue promoting selected concrete nouns in existing forest and wilderness prose into targetable stateful world objects; complements Release 1273 rather than substituting for geographic expansion.
- **Time, Weather & Disaster Arc** — authored conditions/disasters layered onto real geography and material state; no generic climate simulator.
- **Museum & Ecology second expansion** — only where collection creates new field play instead of checklist accumulation.
- **Cross-IF / RPG Mechanics Adaptation — later inspirations** — after the Shadowgate-first program, rebuild transferable design principles as original Zork-native systems.
- **Narrative Perspective Experiments** — isolated first-person, third-person, and interactive-storybook editions.
- **Far-horizon DRAW + multi-agent experiments** — isolated experiments only after the playable product supports them.

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
| 1257 | Fire, Smoke & Structural Consequences | #62 |
| 1258 | Mara Causal Biography & Shared Danger | #63 |
| 1259 | Mara Field Capability Discovery | #64 |
| 1260 | Mara Lived Feeling, Rupture & Repair | #65 |
| 1261 | Mara Anticipation, Worry & Protective Initiative | #66 |
| 1262 | Hostile Rooms & Reactive Threats / Dragon & Hoard | #67 |
| 1263 | Ablative Protection & Equipment Consequence | #68 |

### Releases 1258–1263 merge and artifact receipts

| Release | Merge commit | Locked artifact SHA-256 | Final hosted qualification |
|---:|---|---|---:|
| 1258 | `e50e81ddfd356cb13c60d61c641d3e7ce1225685` | `cfbe0e05ea2b70101aee2103bf07b80993ba479a41a905ad882102e6415d7263` | `31929719820` |
| 1259 | `2cb9fd6ef66914c64c8c57d6b9b51767595c664c` | `e3a1adc99a6849b4703a3fe4338310a12c8d38c6d94b1aeab762199bb8e43d77` | `31828682046` |
| 1260 | `2fe55b412818b2eabd9207fa91ed48f20b32ca41` | `81f686a1cd792b61f219e167fc0427e890151020d5b02f127cbd83d247c209c2` | `31886864766` |
| 1261 | `56772b585f6a6f87e2a7365e5ca813af5b59beb8` | `bc6f86c43803994143e5e188b8256d5ac681b51f1ab7711aeed27bbd4c6208a4` | `31927382213` |
| 1262 | `32ddee571a686411f672235aecffeab6b614bbb6` | `2c0f63695388732af365d0b72b014348c7f1fb438dde0c5b49616ae8fdb81cf9` | `31928781090` |
| 1263 | `565d24d910e75ac6b28f1ce9d57de1506a642b62` | `a29a94fe607130c6bc2f86c140b6d3a2d7c065c9ceb80263a5dbfb51db3b3997` | `31929398064` |

Releases 1264, 1265, and 1266 are explicitly **not DONE** while PRs #69, #70, and #71 remain open.

## Canonical roadmap

See `docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md` for broader design doctrine and `docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md` for Releases 1262–1272.

The current shape is concrete: the Mara stack through 1261 is merged; Releases 1262–1263 are the merged Shadowgate-derived trains; Releases 1264 and 1265 are open stacked predecessors; **Release 1266 is the qualified CURRENT train; Release 1267 — Semantic Examination & Hidden Structure — is next; Release 1273 — Living Biomes & Wilderness Expansion — remains the first explicitly queued post-Shadowgate world-expansion train.**
