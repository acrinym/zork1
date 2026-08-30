# Highly Extended Zork — Product Kanban

**Updated:** August 30, 2026  
**Board data:** `docs/planning/product-kanban.json`  
**Current merged production frontier:** Release `1278` — Honest Playthrough Records, Rest Syntax, House Jar  
**Live `master` observed before this refresh:** `080ba3a3d35f8f61da23f264ba088a6d59991b21` (PR #86)  
**Open PRs observed before this refresh:** Release 1279 Glulxe optimization (PR #87); Release 1293 Honest System Recap

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

Releases 1269–1278 are merged through PR #86. Writable merges stay on `acrinym/zork1` `master` only.

## CURRENT

1279 is runtime-only (story file unchanged). 1293 is story honesty from the locked-1278 playtest and does not steal 1280–1292.

### Release 1279 — Glulxe Optimization

Ship a faster native Glulxe for the locked Release 1278 story: `-O3`, LTO, and PGO. Transcripts, save/restore, and undo must match. VERIFY_MEMORY_ACCESS stays on. The `.ulx` is unchanged.

Planning: `docs/planning/RELEASE_1278_GLULXE_OPTIMIZATION.md`. PR #87.

### Release 1293 — Honest System Recap

A live 1278 playtest still dumped House-of-Records architecture on a fresh `RECAP`. 1293 stages locked 1278 and recaps only visited places and earned events. No GUI. No AI.

Planning: `docs/planning/PLAYTEST_1278_HONEST_SYSTEM_RECAP_2026-08-30.md`. Train: `glulx/honest-system-recap/`.

## NEXT — explicit queued product trains

Runtime foundation continues. No museum/Mara/fish implementation until 1279–1286 have reached the locked frontier. Filenames below keep their original numbers so old links resolve; **live release numbers** are in parentheses.

See `docs/planning/POST_1277_RUNTIME_FOUNDATION_QUEUE_1278_1284_2026-08-21.md`.

### 1. Release 1280 — Future-Proof Runtime Contract
`docs/planning/RELEASE_1279_FUTURE_PROOF_RUNTIME_CONTRACT.md`

### 2. Release 1281 — Extended Globals / Compiler State Scaling
`docs/planning/RELEASE_1280_EXTENDED_GLOBALS_COMPILER_STATE_SCALING.md`

### 3. Release 1282 — Story-Code Optimization
`docs/planning/RELEASE_1281_STORY_CODE_OPTIMIZATION.md`

### 4. Release 1283 — Cross-Interpreter Compatibility
`docs/planning/RELEASE_1282_CROSS_INTERPRETER_COMPATIBILITY.md`

### 5. Release 1284 — Large-World Scaling
`docs/planning/RELEASE_1283_LARGE_WORLD_SCALING.md`

### 6. Release 1285 — Portable Runtime Bundle
`docs/planning/RELEASE_1284_PORTABLE_RUNTIME_BUNDLE.md`

### 7. Release 1286 — Opt-In Playthrough Chronicle Export
`docs/planning/RELEASE_1285_OPT_IN_PLAYTHROUGH_CHRONICLE_EXPORT.md` — local side-channel export only. Not a GUI, not illustration, not a network feature.

## FUTURE — Living Collection & Companionship (after 1286)

Parser-native whole trains. No photographs, DRAW, illustrated frontend, or other GUI. Planning contract: `docs/planning/POST_1286_MUSEUM_MARA_AQUATIC_PROGRAM.md`.

1. **1287 — Second Water / Reservoir Fishery** — one authored second species from Reservoir water, using the existing rod and smashable field jar.
2. **1288 — Mara as Collection Witness** — she only knows catches, releases, and exhibits she actually saw or was told in the world.
3. **1289 — Living Waters Husbandry** — the circulating case stays a real vessel: dam water, absence, and smashable-jar risk, not an aquarium checklist.
4. **1290 — Mara House Stewardship** — she uses Kitchen, Bedroom, Attic, and museum as a person living there, not a maid skill tree.
5. **1291 — Specimen Custody & Return** — real objects move on loan or return the way the songbird feather can return to the nest.
6. **1292 — Mara Agreed Field Errands** — she travels on a real agreed purpose using 1276 field guidance, not a quest log.

Also remaining (not numbered until 1286 lands):

- **Mara Earned Romance & Partnership** — explicit mutual choice; no approval/love meter.
- **Forest That Answers Back** — live **1294**. Promote selected existing wilderness nouns into stateful objects. Playtest: `EXAMINE TREE` at North of House fails while the prose names trees.
- **Time, Weather & Disaster Arc** — authored conditions on real geography; no climate simulator.

## PARKED / SEPARATE

- **Illustrated Zork / DRAW / external scene rendering** — `docs/planning/FAR_HORIZON_ILLUSTRATED_ZORK.md`. Not in the product queue. Justin excluded photo/graphic and GUI work from the post-1286 program.
- **1277 instant photographs** stay as the already-shipped in-world camera. Do not grow them into a gallery UI or illustrated frontend.
- **S.T.A.L.K.E.R. Glulx** remains a separate product lane.
- **Protected Corpus Acquisition** remains rights-dependent.
- Universal crafting, randomized loot, generic physics, procedural worlds, and recursive audit machinery remain out of scope.

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
| 1278 | Honest Playthrough Records, Rest Syntax, House Jar | #86 — merged `080ba3a3d35f8f61da23f264ba088a6d59991b21` |

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
| 1277 | `42c110095cb99c9aff6ef83956c391b437c76bef` | `582c86d1878c89a8e7f76d8e97c68fcb9b0fc061ecd38a67888cfdd7de5e5599` | PR #85 |
| 1278 | `080ba3a3d35f8f61da23f264ba088a6d59991b21` | `d1d5e7487a792079135e014dcdcfa0af73219307c12fbab2ef41d6af2b5f53f1` | PR #86 |

## Canonical roadmap

- `docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md`
- `docs/planning/POST_1277_RUNTIME_FOUNDATION_QUEUE_1278_1284_2026-08-21.md`
- `docs/planning/POST_1286_MUSEUM_MARA_AQUATIC_PROGRAM.md`
- `docs/planning/PLAYTEST_1245_DESTRUCTION_HONESTY_GAPS_2026-08-30.md`

- `docs/planning/PLAYTEST_1278_HONEST_SYSTEM_RECAP_2026-08-30.md`

The live shape at this refresh: Release 1278 is merged on `acrinym/zork1` `master`; Release 1279 (runtime) is PR #87; Release 1293 (story honesty) is in CURRENT and does not steal 1280–1292; runtime foundation remains 1280–1285; chronicle export is 1286; Living Collection is 1287–1292 after that. Never merge to `historicalsource/zork1`.
