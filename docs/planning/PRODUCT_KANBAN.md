# Highly Extended Zork — Product Kanban

**Updated:** August 30, 2026  
**Board data:** `docs/planning/product-kanban.json`  
**Current merged production frontier:** Release `1277` — Mundane Objects, Field Caching & House Spatial Agency  
**Live `master` observed before this refresh:** `42c110095cb99c9aff6ef83956c391b437c76bef` (PR #85)  
**Open PRs observed before this refresh:** Release 1278 honest-playthrough / house-jar (this train)

This board is the human operating surface for the active Zork product queue. The JSON board remains the tooling surface.

## Repository boundary

- **Writable product repository:** `acrinym/zork1`.
- **Read-only upstream reference:** `historicalsource/zork1`.
- Never open, push, commit, retarget, merge, or otherwise mutate `historicalsource/zork1`.

## Operating rules

- **CURRENT** contains at most one actively implemented product train and may be empty between trains.
- **NEXT** is ordered and contains concrete player-facing work, not cleanup placeholders.
- Preserve canonical Zork solutions and exact object/state authority while layering physically credible alternatives.
- Natural player commands are the product qualification surface.
- No universal crafting grid, arbitrary object-pair matrix, generic physics simulator, generic creature brain, recursive audit machinery, TODO-only slice, stub, or no-op scaffolding.
- Difficulty must never become a parser-phrasing tax or enemy-health multiplier masquerading as puzzle difficulty.
- Mara remains one authored human adventurer: no approval meter, generic follower framework, skill tree, omniscient companion AI, or romance meter.
- **DONE** requires merged or otherwise immutable proof.
- Do not merge any new PR without a fresh explicit Justin merge whistle.

## OPEN STACKED PREDECESSORS

None.

Releases 1269–1277 are merged through PR #85. Writable merges stay on `acrinym/zork1` `master` only.

## CURRENT

### Release 1278 — Honest Playthrough Records, Rest Syntax, House Jar

A new playthrough must not recap unearned attic architecture, rug/trap events, or garlic slicing. Rest records must not print qualification telemetry. `LIE` / `LIE DOWN` must put the Adventurer to bed. `DRINK FROM SINK` must reach the tap. A sword or axe can shatter the museum field jar. No generic smash engine.

Playtest evidence: `docs/planning/PLAYTEST_1245_DESTRUCTION_HONESTY_GAPS_2026-08-30.md`.

## NEXT — explicit queued product trains

The former **1278–1284 runtime foundation queue** slides by one after this honesty/destruction repair. See `docs/planning/POST_1277_RUNTIME_FOUNDATION_QUEUE_1278_1284_2026-08-21.md`.

### 1. Release 1279 — Glulxe Optimization

**Planning contract:** `docs/planning/RELEASE_1278_GLULXE_OPTIMIZATION.md` (numbering slide: that document is now the 1279 train).

### 2. Release 1269 — Structural Difficulty Modes (MERGED; kept here only as historical queue text)

Historical queue text below 1269–1275 remains as the completed post-1268 program. Do not re-open those trains.

Difficulty changes the **structure of problem-solving**, not just numbers.

- preserve the same underlying world identity across modes;
- lower-pressure play may expose clearer environmental evidence, redundant resources/substitutes, more recoverable failures, or wider consequence windows;
- higher-pressure play may rely on subtler but still fair evidence, fewer substitutes, less recovery, and tighter consequence windows;
- no deliberately obscure parser phrasing;
- no enemy-health multiplier pretending to be puzzle difficulty;
- no generic scalar difficulty framework sprayed across unrelated systems;
- authored differences must be testable through natural commands.

### 2. Release 1270 — Causal Death & Failure Feedback

Death and near-death should communicate physical cause, ignored evidence, partially sound ideas, and the exact state/action difference that changed the outcome without turning the failure screen into a walkthrough.

### 3. Release 1271 — Creature Encounters as Systemic Puzzles

Living beings remain authored situations with distinct motives, senses, capacities, fears, possessions, territory, and memory rather than hit-point-shaped locks. Troll, thief, grue, dragon, Mara, and future creatures must remain meaningfully different; no generic creature AI brain or universal disposition meter.

### 4. Release 1272 — Shadowgate-Style Macrostructure, Original Zork Region

Build a substantial original Zork region composing the preceding design language into one coherent adventure. Roughly 20–30 authored rooms only if the design earns that size. Do not copy Shadowgate source code, maps, prose, art, exact puzzles, spell names, object lists, or expressive sequencing.

### 5. Release 1273 — Living Biomes & Wilderness Expansion

Expand actual Zork geography/ecology with genuinely new wilderness identities, including a new forest subregion and a first wholly new climate/biome if the authored design earns them. No procedural biome generator, palette-swapped room factory, universal biome stat sheet, generic climate simulator, or room-count padding.

### 6. Release 1274 — Environmental Mechanisms & Diegetic Puzzle Furniture

**Planning contract:** `docs/planning/RELEASE_1274_ENVIRONMENTAL_MECHANISMS_DIEGETIC_PUZZLE_FURNITURE.md`

Interaction grammar: **notice a prose-visible irregularity → examine it → learn a physical fact → manipulate the correct concrete detail → the environment changes**.

No generic secret-switch framework, automatic noun promotion, universal furniture state machine, arbitrary `USE X ON Y` matrix, parser pixel hunt, or copied Resident Evil content.

### 7. Release 1275 — Expand Existing Slim Locales / Locations — with Justin's Explicit Feedback

**Planning contract:** `docs/planning/RELEASE_1275_EXPAND_EXISTING_SLIM_LOCALES_WITH_JUSTIN_FEEDBACK.md`

Release 1275 returns to existing geography and expands only under-realized locations that genuinely benefit from authored growth. **Justin's explicit feedback is required for each expansion target and intended direction before implementation.**

The assistant may inspect candidates, explain why a locale feels slim, surface materially different expansion axes, and show tradeoffs. It must not independently settle which locale grows, which direction it grows, how much is enough, or whether a compact locale needs expansion at all.

No procedural locale expander, generic room generator, room-count quota, palette-swapped filler, or ceremonial after-the-fact approval.

## FUTURE — explicit lanes

- **Mara Earned Romance & Partnership** — mutual attraction, explicit mutual choice, closeness, boundaries, disagreement, initiative, repair, and partnership growing from lived history; no approval/love meter and no compulsory romance.
- **Forest That Answers Back / Existing-Region Interactivity** — continue promoting selected concrete nouns in existing forest and wilderness prose into targetable stateful world objects.
- **Time, Weather & Disaster Arc** — authored conditions/disasters layered onto real geography and material state; no generic climate simulator.
- **Museum & Ecology second expansion** — only where collection creates new field play instead of checklist accumulation.
- **Cross-IF / RPG Mechanics Adaptation — later inspirations** — rebuild transferable design principles as original Zork-native systems.
- **Narrative Perspective Experiments** — isolated first-person, third-person, and interactive-storybook editions.
- **Far-horizon DRAW + multi-agent experiments** — isolated experiments only after the playable product supports them.

## PARKED / SEPARATE

- **S.T.A.L.K.E.R. Glulx** remains a separate product lane and never rides inside a Zork gameplay PR.
- **Protected Corpus Acquisition** remains rights-dependent.
- Universal crafting, randomized loot progression, generic physics, and procedural world generation remain out of scope.

## DONE — merged production history

| Release | Train | PR / proof |
|---:|---|---|
| 1219–1230 | House of Records program | PR #32 |
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
| 1264 | Perilous Affordances / Let the Player Be Wrong | #69 |
| 1265 | Consumable Light & Graduated Darkness | #70 |
| 1266 | Learned Magic as Parser Capability | #71 |
| 1267 | Semantic Examination & Hidden Structure | #72 — merged `90e30d59fcd44a5297d7524f65ee34c72aaff319` |
| 1268 | Clue Chains & Knowledge-Gated Interpretation | #73 — merged `2e16f6cebbfb5a7892feac08d9e6461e6bb9313b` |
| 1269–1276 | Structural difficulty through Mara field guidance | merged on `acrinym/zork1` `master` before #85 |
| 1277 | Mundane Objects, Field Caching & House Spatial Agency | #85 — merged `42c110095cb99c9aff6ef83956c391b437c76bef` |

### Recent locked artifact / qualification receipts

| Release | Merge commit | Locked artifact SHA-256 | Final hosted qualification |
|---:|---|---|---:|
| 1258 | `e50e81ddfd356cb13c60d61c641d3e7ce1225685` | `cfbe0e05ea2b70101aee2103bf07b80993ba479a41a905ad882102e6415d7263` | `31929719820` |
| 1259 | `2cb9fd6ef66914c64c8c57d6b9b51767595c664c` | `e3a1adc99a6849b4703a3fe4338310a12c8d38c6d94b1aeab762199bb8e43d77` | `31828682046` |
| 1260 | `2fe55b412818b2eabd9207fa91ed48f20b32ca41` | `81f686a1cd792b61f219e167fc0427e890151020d5b02f127cbd83d247c209c2` | `31886864766` |
| 1261 | `56772b585f6a6f87e2a7365e5ca813af5b59beb8` | `bc6f86c43803994143e5e188b8256d5ac681b51f1ab7711aeed27bbd4c6208a4` | `31927382213` |
| 1262 | `32ddee571a686411f672235aecffeab6b614bbb6` | `2c0f63695388732af365d0b72b014348c7f1fb438dde0c5b49616ae8fdb81cf9` | `31928781090` |
| 1263 | `565d24d910e75ac6b28f1ce9d57de1506a642b62` | `a29a94fe607130c6bc2f86c140b6d3a2d7c065c9ceb80263a5dbfb51db3b3997` | `31929398064` |
| 1264 | `cdc8f51b08721756c796904d7132587ec40026f1` | `04216477fb50deeb04f833122d5874c602277b2b4522cbf72420f2b987b52a1d` | `31949574481` |
| 1265 | `59c9e843c4723692a0017e9f189407272b5a284f` | `6908e60a4dc191e1f74353055aa3dce11e72172edb96557a0f66d069327c1070` | `32034566984` |
| 1266 | `4425732bfc2fa28347453d9991513aeb28aaa531` | `d26e66c95db2df733f4d2f0e8080650b4ec9ae4b5aa11082e6760835cb955fa9` | `32042641179` |
| 1267 | `90e30d59fcd44a5297d7524f65ee34c72aaff319` | `828383a78549cce45d26f888d14eb37838c74ce5b44588423eb8eca036ef77f0` | `32046910749` |
| 1268 | `2e16f6cebbfb5a7892feac08d9e6461e6bb9313b` | `bd663f335fb1500f809e797c92cc571a7828e5f410aebd2a1878298d65141f16` | `32052058707` |

## Canonical roadmap

- `docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md`
- `docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md`
- `docs/planning/RELEASE_1274_ENVIRONMENTAL_MECHANISMS_DIEGETIC_PUZZLE_FURNITURE.md`
- `docs/planning/RELEASE_1275_EXPAND_EXISTING_SLIM_LOCALES_WITH_JUSTIN_FEEDBACK.md`

The live shape at this refresh: Release 1277 is merged on `acrinym/zork1` `master`; Release 1278 is the honesty/jar train in CURRENT; Glulxe optimization and the rest of the runtime foundation queue begin at 1279. Never merge to `historicalsource/zork1`.
