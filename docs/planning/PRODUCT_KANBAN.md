# Highly Extended Zork — Product Kanban

**Updated:** September 4, 2026  
**Board data:** `docs/planning/product-kanban.json`  
**Current merged production frontier:** Release `1305` — HE Absurd Alternates on `master` (PR #94)  
**Open work:** Release **1306** Mara Earned Romance on `agent/1306-mara-earned-romance`  
**Lock receipt:** `docs/planning/RELEASE_1305_HE_ABSURD_ALTERNATES.md`  
**Ideas lane:** `ideas/extended-zork/` (concept sources; not compiled progress)

This board is the human operating surface for the active Zork product queue. The JSON board remains the tooling surface.

## Repository boundary

- **Writable product repository:** `acrinym/zork1`.
- **Read-only upstream reference:** `historicalsource/zork1`.
- Never open, push, commit, retarget, merge, or otherwise mutate `historicalsource/zork1`.

## Operating rules

- **CURRENT** contains at most one actively implemented product train and may be empty between trains.
- **NEXT** is ordered and contains concrete player-facing work, not cleanup placeholders.
- Preserve canonical Zork solutions and exact object/state authority while layering physically credible alternatives.
- **Described world is law:** if room prose named a noun, the parser must treat it as real (`docs/planning/DESCRIBED_WORLD_IS_LAW_2026-08-30.md`).
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

### Release 1306 — Mara Earned Romance and Partnership

Train: `.beads/cursor_zork_mara_earned_romance.beadtrain`. Staging: `glulx/mara-earned-romance/`. Stages locked 1305. No love meter. Not merged.

## NEXT — explicit queued product trains

1. **1309 Adventurer body, clothing, House wardrobe** — `.beads/cursor_zork_adventurer_body_wardrobe.beadtrain` (coupler after 1306 capstone)
2. **1308 Second described-world census on live HE** — `.beads/cursor_zork_described_world_second_census.beadtrain` (coupler after wardrobe; whole HE map, not original rooms only)
3. **1307 Time, Weather & Disaster** — remains queued, does not skip wardrobe/census

## FUTURE — remaining ideas/extended-zork wholes that never shipped as HE product

Parser-native. No photographs, DRAW, illustrated frontend, or other GUI. Living Collection **1304**, leaflet-hour **1296–1300**, and empire census **1301–1303** are DONE.

Shipped from that folder (do not reopen as new trains): cuisine/hunger **1235**, museum intake **1233**, museum ecology/fishing **1239**, Mara arrival through field capability **1234–1261**, Living Collection **1304**, narrative-perspective **documentation** PR #47.

Still **not** in the default HE game — trains exist, status planned:

- **Mara Earned Romance & Partnership** (`cursor_zork_mara_earned_romance`, planned **1306**) — `ideas/extended-zork/human-companion-bond-and-love-interest.md`. Explicit mutual choice; no meter.
- **Time, Weather & Disaster Arc** (`cursor_zork_time_weather_disaster`, planned **1307**) — recovered pre-House geography hazards; no climate simulator.
- **Second Described-World Census** (`cursor_zork_described_world_second_census`, planned **1308**) — community-wish remainder; 1302 ledger close is not whole-map remaining-noun proof.

`ideas/extended-zork/mara-tallow-implementation-status.md` is a status note, not a missing product. `cuisine-hunger-satiation-and-stamina.md` and `museum-ecology-and-fishing.md` already have merged first trains; do not duplicate them.

## PARKED / SEPARATE

- **Illustrated Zork / DRAW / external scene rendering** — `docs/planning/FAR_HORIZON_ILLUSTRATED_ZORK.md`. Not in the product queue. Justin excluded photo/graphic and GUI work from the post-1286 program.
- **1277 instant photographs** stay as the already-shipped in-world camera. Do not grow them into a gallery UI or illustrated frontend.
- **S.T.A.L.K.E.R. Glulx** remains a separate product lane.
- **Protected Corpus Acquisition / Infocom Corpus Foundation** (`cursor_zork_infocom_corpus_foundation`, **blocked**) — `ideas/extended-zork/infocom-*.md`. Rights-dependent; no protected dumps in the public tree.
- **Narrative Perspective Alternate Editions** (`cursor_zork_narrative_perspective_editions`, **blocked**) — playable side edition; must not silently rewrite default HE master. Docs-only proof remains PR #47.
- Universal crafting, randomized loot, generic physics, procedural worlds, and recursive audit machinery remain out of the HE story queue. A Codex sidebar world-truth / interaction-audit system is **not** PR #94 and is **not** Release 1305.

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
| 1279 | Glulxe optimization | #87 |
| 1293 | Honest System Recap | #88 |
| 1294 | Forest That Answers Back | #89 |
| 1295 | West-of-House Described Nouns | #90 |
| 1280–1286 | Runtime foundation (contract, globals, opt, interpreters, scale, bundle, chronicle) | #91 |
| 1304 | Living Collection and Companionship | #91 |
| 1296–1300 | Leaflet Hour Noun Honesty | #92 — merged `9be10c1969cbebd30ca82ec219991116b9b58e89` |
| 1301–1303 | Survey flags, census, empire noun honesty | #93 — merged `f3583c0025893c4bd3f34a00c5465a0976b96f39`; capstones closed `c0256aab9136e834418614dbb4fec365c541ecb5` |

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
| 1279 | `0e8ad864b644a7351cd795e43e402b59bc058dc8` | runtime Glulxe; story unchanged | PR #87 |
| 1293 | `983bb03f4f193eb056533e3aec65e1c57f59db53` | `79196c07694bda604c283ae2b1da19dfad77aaef5b72b035ff4a99f2f237d641` | PR #88 |
| 1294 | `691926c5b4f91106ed5534b293cbaff4df82630f` | `20322d784cc97a50be9d49a32bfa6149bac73c327753a4192760548656523831` | PR #89 |
| 1295 | `f87089e` | `a239f515902e77a35ffdb3d00557aca9d22c2d14d5c25f75f36b9543c5814a8b` | PR #90 |
| 1280–1286 | `71c4a83` | runtime foundation; production player `.ulx` stayed 1295 until 1304 | PR #91 |
| 1304 | `71c4a83` | `6e66dbd09897b829670d145c1340775de2a66fc82712bcdecf4a4bb008a9726b` | PR #91 |
| 1296–1300 | `9be10c1` | `05119257f303dc77383f8ab51e799233076e1dc7e3b20e08f1c439868aea361a` | PR #92 |
| 1301–1303 | `f3583c0` / `c0256aa` | `4d3761931fcfe69a342e60d074c3ddfe7b6ee8c5a545cd58975158eae162db5c` | PR #93 — hosted qualify `33345233547` |
| 1305 | PR #94 (unmerged) | `fbdb8232c2cd219ba1640cd3bd4f65e9162f3ec4f6f38a449b065745636a3dd9` | hosted qualify `33352160781` |

## Canonical roadmap

- `docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md`
- `docs/planning/POST_1277_RUNTIME_FOUNDATION_QUEUE_1278_1284_2026-08-21.md`
- `docs/planning/POST_1286_MUSEUM_MARA_AQUATIC_PROGRAM.md`
- `docs/planning/PLAYTEST_1245_DESTRUCTION_HONESTY_GAPS_2026-08-30.md`

- `docs/planning/PLAYTEST_1278_HONEST_SYSTEM_RECAP_2026-08-30.md`
- `docs/planning/DESCRIBED_WORLD_IS_LAW_2026-08-30.md`
- `docs/planning/DESCRIBED_WORLD_CENSUS_1302.md`
- `docs/planning/RELEASE_1305_HE_ABSURD_ALTERNATES.md`
- `docs/ADVENTURER_GUIDE.md`

The live shape at this refresh: merged frontier **1303** on `c0256aa`. CURRENT is **1305** locked on [#94](https://github.com/acrinym/zork1/pull/94). FUTURE holds planned 1306–1308. Corpus and storybook editions stay PARKED/blocked. Never merge to `historicalsource/zork1`.
