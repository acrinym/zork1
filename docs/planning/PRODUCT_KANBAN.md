# Highly Extended Zork — Product Kanban

**Updated:** September 7, 2026  
**Board data:** `docs/planning/product-kanban.json`  
**Current merged production frontier:** Release `1310` — Flathead Fair on `master` (PR #101; merge `20dab719f253c682f6ca7dd48e6400e61c89a246`)  
**Current `master` head:** `1903437d5591b48f27bd362c5c6b7ed78884b742` — 1310 capstone closure  
**Open work:** PR #98 (1309), PR #99 (1307), and planning PR #100  
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
- **SHA receipts:** merged trains record the exact PR merge commit; active implementation PRs record their current head SHA; planning-only trains record `not created`. SHAs are provenance, not merge authorization.
- Do not merge any new PR without a fresh explicit Justin merge whistle.

## OPEN STACKED PREDECESSORS

None.

Releases 1269–1278 are merged on `acrinym/zork1` `master`; see the DONE receipts below. Writable merges stay on `acrinym/zork1` `master` only.

## CURRENT

**1310 Flathead Fair** — `.beads/cursor_zork_flathead_fair.beadtrain`. Complete and merged through PR #101 with merge commit `20dab719f253c682f6ca7dd48e6400e61c89a246`. Capstone closure is `1903437d5591b48f27bd362c5c6b7ed78884b742`. Sixteen-location parser-first fair organ; independent of draft 1307/1309 until those lock.

## NEXT — explicit queued product trains

1. **1309 Adventurer body, clothing, House wardrobe** — `.beads/cursor_zork_adventurer_body_wardrobe.beadtrain`. PR #98 is an open draft at head `8784e0b2c89eeb13c5acf23cf220aded13aa4b1b`; its dedicated qualification currently fails. Not merged.
2. **1308 Second described-world census on live HE** — `.beads/cursor_zork_described_world_second_census.beadtrain`. Planned only: no implementation PR or head SHA exists yet. Follows the wardrobe train.
3. **1307 Time, Weather & Disaster** — `.beads/cursor_zork_time_weather_disaster.beadtrain`. PR #99 is an open draft at head `ce22b636bcb08d08a88c31bc4ccca680c6a97427`; its dedicated qualification currently fails. It remains queued behind wardrobe and census.
## FUTURE — remaining ideas/extended-zork wholes that never shipped as HE product

Parser-native. No photographs, DRAW, illustrated frontend, or other GUI. Living Collection **1304**, leaflet-hour **1296–1300**, and empire census **1301–1303** are DONE.

Shipped from that folder (do not reopen as new trains): cuisine/hunger **1235**, museum intake **1233**, museum ecology/fishing **1239**, Mara arrival through field capability **1234–1261**, Living Collection **1304**, Mara earned romance **1306**, narrative-perspective **documentation** PR #47.

Still **not** in the default HE game and represented in NEXT: Adventurer body / House wardrobe **1309**, Second Described-World Census **1308**, and Time, Weather & Disaster **1307**. Their beadtrains exist; their current implementation states and SHA receipts are recorded above.

`ideas/extended-zork/mara-tallow-implementation-status.md` is a status note, not a missing product. `cuisine-hunger-satiation-and-stamina.md` and `museum-ecology-and-fishing.md` already have merged first trains; do not duplicate them.

## NEWLY CAPTURED / UNSEQUENCED

- **Mara's Fair stuffed-animal keepsake and the Adventurer's proper name** — captured in `ideas/extended-zork/POST_1310_AFTER_FAIR.md` §8. A stuffed animal is a real Fair object: Mara may win one through an authored fair path, and/or the player may win or acquire one and offer it to her. Acceptance, refusal, custody, later storage, and relationship meaning remain authored and physical. The Adventurer should receive a proper name, but the naming mechanism and exact name remain unresolved; this pass does not hard-code one. This is concept work, not a release assignment.
## PARKED / SEPARATE

- **Illustrated Zork / DRAW / external scene rendering** — `docs/planning/FAR_HORIZON_ILLUSTRATED_ZORK.md`. Not in the product queue. Justin excluded photo/graphic and GUI work from the post-1286 program.
- **1277 instant photographs** stay as the already-shipped in-world camera. Do not grow them into a gallery UI or illustrated frontend.
- **S.T.A.L.K.E.R. Glulx** remains a separate product lane.
- **Protected Corpus Acquisition / Infocom Corpus Foundation** (`cursor_zork_infocom_corpus_foundation`, **blocked**) — `ideas/extended-zork/infocom-*.md`. Rights-dependent; no protected dumps in the public tree.
- **Narrative Perspective Alternate Editions** (`cursor_zork_narrative_perspective_editions`, **blocked**) — playable side edition; must not silently rewrite default HE master. Docs-only proof remains PR #47.
- Universal crafting, randomized loot, generic physics, procedural worlds, and recursive audit machinery remain out of the HE story queue. A Codex sidebar world-truth / interaction-audit system is **not** PR #94 and is **not** Release 1305.

## DONE — merged production history

| Release | Train | PR / proof | Merge SHA |
|---:|---|---|---|
| 1219–1230 | House of Records program | PR #32 | 18d3560c870fac9581c54a4632864f7eefc253b2 |
| 1231 | Corpus-Coupled Causal Warning | #34 | 28b90fe93a472087e64afcd0fb0e8776f80157f3 |
| 1232 | Parser Comprehension and Deep Affordances | #35 | ce5be325a0d0f762edaa23362e5227d4788953d6 |
| 1233 | Museum Intake and First Gallery | #36 | f0bdd696d447cdb727b82229b218abf7a6905f91 |
| 1234 | Mara Arrival and Evidence Memory | #37 | 76f1e451a4fb70dcf6ea1d41cb8705f2ad5236d4 |
| 1235 | Cuisine, Hunger, and Stamina | #38 | e2e5c9c3e269d8e18bb3ed1c75dd72baacbd495a |
| 1236 | Great Canyon Living Consequences | #39 | eaf92ed19156088954ce5e0ab828a8d021f0920d |
| 1237 | Zork Plus Veteran Survey Expedition | #40 | 325e5b7779f677febb02581dd934a2eae7bca1aa |
| 1238 | Cellar Expedition Recovery Locker | #41 | 0480813d4c9a95e5a29af45b956285cb86ad74dc |
| 1239 | Museum Ecology and Dam Fishing | #42 | c025b2d98004183f76adb3db92d24a11f65b8bec |
| 1240 | Museum Songbird Correspondence | #43 | d476ab8a9a7f9a78d8c460e56776e788c02553fc |
| 1241 | Museum Troll Provenance | #44 | 3ce83f2fe70eeb38e17e032db249c857dffba978 |
| 1242 | Natural-Play Regression Repair | #45 | 8f80c7d8004e3e4d5c2d546df5b82d4d330457e2 |
| 1243 | Mara Companion Expedition Foundation | #46 | e7367c4d433f2f555db08014b9dc629b93ef841b |
| — | Narrative Perspective Experiments documentation | #47 | cd1788e07b1aed568d0df81967ce933e02b9c740 |
| 1244 | Mara House Company | #48 | dcd65a623ec53fd34631c828b5e997dc8aef90d7 |
| 1245 | Creative Natural Play | #49 | 5fad5cc0b018823226fdaae7894e830e600090f1 |
| 1246 | Environmental Destruction | #50 | 816be4d8763a5b728be15e1e0e06719d1dc50d75 |
| 1247 | Narrative Physicality | #51 | 0bf3b96587e703e59fae14f9304fef37eea7ff14 |
| 1248 | Forest Consequence Physicality | #52 | 032fda633c8faacc5db5900a5c2812d336d1d4a6 |
| 1249 | Underground Sensory Physicality | #53 | bacb1a358f0ee126ee6ae629b589c3d3a0269ee9 |
| 1250 | Player Ingenuity / Systemic Workarounds | #55 | cd6a918795196b6918a2a5c5600b56c1c0d6e20b |
| 1251 | Cross-System Utility Mesh | #56 | 79b87248d567962fff2181e4996d1cf424cdcac0 |
| 1252 | Earned Sequence Breaks & Route Mastery | #57 | 43a253a83a7349c9d3838e07488a90233f92410b |
| 1253 | Dam Survival & Prepared Rescue | #58 | f5b1f1a3e7f65ff11db06f344580f83c3ed191b1 |
| 1254 | Troll Disarm & Stolen Weapons | #59 | 7b99869d8cb2e6db93243432fd8140a937205f44 |
| 1255 | Thief Retaliation & Sabotage | #60 | 8ad53ebc2ec2ce2a454ce6951d919bb1a2025937 |
| 1256 | Grue Ecology & Colony Reveal | #61 | 14d1be667db3110d532b0e2c28f00b92371693fc |
| 1257 | Fire, Smoke & Structural Consequences | #62 | 8b6a390f959b5156876faf9d421c345a74e54423 |
| 1258 | Mara Causal Biography & Shared Danger | #63 | e50e81ddfd356cb13c60d61c641d3e7ce1225685 |
| 1259 | Mara Field Capability Discovery | #64 | 2cb9fd6ef66914c64c8c57d6b9b51767595c664c |
| 1260 | Mara Lived Feeling, Rupture & Repair | #65 | 2fe55b412818b2eabd9207fa91ed48f20b32ca41 |
| 1261 | Mara Anticipation, Worry & Protective Initiative | #66 | 56772b585f6a6f87e2a7365e5ca813af5b59beb8 |
| 1262 | Hostile Rooms & Reactive Threats / Dragon & Hoard | #67 | 32ddee571a686411f672235aecffeab6b614bbb6 |
| 1263 | Ablative Protection & Equipment Consequence | #68 | 565d24d910e75ac6b28f1ce9d57de1506a642b62 |
| 1264 | Perilous Affordances / Let the Player Be Wrong | #69 | cdc8f51b08721756c796904d7132587ec40026f1 |
| 1265 | Consumable Light & Graduated Darkness | #70 | 59c9e843c4723692a0017e9f189407272b5a284f |
| 1266 | Learned Magic as Parser Capability | #71 | 4425732bfc2fa28347453d9991513aeb28aaa531 |
| 1267 | Semantic Examination & Hidden Structure | #72 | 90e30d59fcd44a5297d7524f65ee34c72aaff319 |
| 1268 | Clue Chains & Knowledge-Gated Interpretation | #73 | 2e16f6cebbfb5a7892feac08d9e6461e6bb9313b |
| 1269–1276 | Structural difficulty through Mara field guidance | PRs #75, #77–#82, #84 | #75 `5497b71cfe37032952ac9ecea3e966ef2f10c4fe`; #77 `6525bbdabb98c170f341f6507440e9e8822eadee`; #78 `c5301e9761e836684c94d67d305e0c3c760ce281`; #79 `c41144d2d77fa8354726fd3abbbbd2eacd3575fa`; #80 `ba90c6d9be03e9609dbcbaeed0fb7c8e709f0828`; #81 `85ab3e3684982fa9b35342a229bfc32e205c89e7`; #82 `4cb99d6c67d4f798b35fbd7d005831f744d2f1e0`; #84 `8839ffd91f47d69685e140d15c5cbf93a1f2daff` |
| 1277 | Mundane Objects, Field Caching & House Spatial Agency | #85 | 42c110095cb99c9aff6ef83956c391b437c76bef |
| 1278 | Honest Playthrough Records, Rest Syntax, House Jar | #86 | 080ba3a3d35f8f61da23f264ba088a6d59991b21 |
| 1279 | Glulxe optimization | #87 | 0e8ad864b644a7351cd795e43e402b59bc058dc8 |
| 1293 | Honest System Recap | #88 | 983bb03f4f193eb056533e3aec65e1c57f59db53 |
| 1294 | Forest That Answers Back | #89 | 691926c5b4f91106ed5534b293cbaff4df82630f |
| 1295 | West-of-House Described Nouns | #90 | f87089e2f4a4a3d7ec65204a9df750d9c1e188d2 |
| 1280–1286 | Runtime foundation (contract, globals, opt, interpreters, scale, bundle, chronicle) | #91 | 71c4a831b956184fd0bd811be498c61724987d56 |
| 1304 | Living Collection and Companionship | #91 | 71c4a831b956184fd0bd811be498c61724987d56 |
| 1296–1300 | Leaflet Hour Noun Honesty | #92 | 9be10c1969cbebd30ca82ec219991116b9b58e89 |
| 1301–1303 | Survey flags, census, empire noun honesty | #93 + capstone | `f3583c0025893c4bd3f34a00c5465a0976b96f39`; capstone `c0256aab9136e834418614dbb4fec365c541ecb5` |
| 1305 | HE Absurd Alternates | #94 | 482bb787d0bb585c7af473d18911e220fa970fb3 |
| 1306 | Mara Earned Romance and Partnership | #97 — locked artifact `76871675af153c55440ee472fde4aec25408c3f160a33f963e32ad2cf4e466c5` | a79b50bb02466b3bfb3b0faaacc952ac6b034e08 |
| 1310 | Flathead Fair | #101 — hosted lock; capstone closure `1903437d5591b48f27bd362c5c6b7ed78884b742` | 20dab719f253c682f6ca7dd48e6400e61c89a246 |

### Recent locked artifact / qualification receipts

| Release | Merge commit | Locked artifact SHA-256 | Final hosted qualification |
|---:|---|---|---|
| 1258 | `e50e81ddfd356cb13c60d61c641d3e7ce1225685` | `cfbe0e05ea2b70101aee2103bf07b80993ba479a41a905ad882102e6415d7263` | 31929719820 |
| 1259 | `2cb9fd6ef66914c64c8c57d6b9b51767595c664c` | `e3a1adc99a6849b4703a3fe4338310a12c8d38c6d94b1aeab762199bb8e43d77` | 31828682046 |
| 1260 | `2fe55b412818b2eabd9207fa91ed48f20b32ca41` | `81f686a1cd792b61f219e167fc0427e890151020d5b02f127cbd83d247c209c2` | 31886864766 |
| 1261 | `56772b585f6a6f87e2a7365e5ca813af5b59beb8` | `bc6f86c43803994143e5e188b8256d5ac681b51f1ab7711aeed27bbd4c6208a4` | 31927382213 |
| 1262 | `32ddee571a686411f672235aecffeab6b614bbb6` | `2c0f63695388732af365d0b72b014348c7f1fb438dde0c5b49616ae8fdb81cf9` | 31928781090 |
| 1263 | `565d24d910e75ac6b28f1ce9d57de1506a642b62` | `a29a94fe607130c6bc2f86c140b6d3a2d7c065c9ceb80263a5dbfb51db3b3997` | 31929398064 |
| 1264 | `cdc8f51b08721756c796904d7132587ec40026f1` | `04216477fb50deeb04f833122d5874c602277b2b4522cbf72420f2b987b52a1d` | 31949574481 |
| 1265 | `59c9e843c4723692a0017e9f189407272b5a284f` | `6908e60a4dc191e1f74353055aa3dce11e72172edb96557a0f66d069327c1070` | 32034566984 |
| 1266 | `4425732bfc2fa28347453d9991513aeb28aaa531` | `d26e66c95db2df733f4d2f0e8080650b4ec9ae4b5aa11082e6760835cb955fa9` | 32042641179 |
| 1267 | `90e30d59fcd44a5297d7524f65ee34c72aaff319` | `828383a78549cce45d26f888d14eb37838c74ce5b44588423eb8eca036ef77f0` | 32046910749 |
| 1268 | `2e16f6cebbfb5a7892feac08d9e6461e6bb9313b` | `bd663f335fb1500f809e797c92cc571a7828e5f410aebd2a1878298d65141f16` | 32052058707 |
| 1277 | `42c110095cb99c9aff6ef83956c391b437c76bef` | `582c86d1878c89a8e7f76d8e97c68fcb9b0fc061ecd38a67888cfdd7de5e5599` | PR #85 |
| 1278 | `080ba3a3d35f8f61da23f264ba088a6d59991b21` | `d1d5e7487a792079135e014dcdcfa0af73219307c12fbab2ef41d6af2b5f53f1` | PR #86 |
| 1279 | `0e8ad864b644a7351cd795e43e402b59bc058dc8` | runtime Glulxe; story unchanged | PR #87 |
| 1293 | `983bb03f4f193eb056533e3aec65e1c57f59db53` | `79196c07694bda604c283ae2b1da19dfad77aaef5b72b035ff4a99f2f237d641` | PR #88 |
| 1294 | `691926c5b4f91106ed5534b293cbaff4df82630f` | `20322d784cc97a50be9d49a32bfa6149bac73c327753a4192760548656523831` | PR #89 |
| 1295 | `f87089e2f4a4a3d7ec65204a9df750d9c1e188d2` | `a239f515902e77a35ffdb3d00557aca9d22c2d14d5c25f75f36b9543c5814a8b` | PR #90 |
| 1280–1286 | `71c4a831b956184fd0bd811be498c61724987d56` | runtime foundation; production player `.ulx` stayed 1295 until 1304 | PR #91 |
| 1304 | `71c4a831b956184fd0bd811be498c61724987d56` | `6e66dbd09897b829670d145c1340775de2a66fc82712bcdecf4a4bb008a9726b` | PR #91 |
| 1296–1300 | `9be10c1969cbebd30ca82ec219991116b9b58e89` | `05119257f303dc77383f8ab51e799233076e1dc7e3b20e08f1c439868aea361a` | PR #92 |
| 1301–1303 | `f3583c0025893c4bd3f34a00c5465a0976b96f39 / c0256aab9136e834418614dbb4fec365c541ecb5` | `4d3761931fcfe69a342e60d074c3ddfe7b6ee8c5a545cd58975158eae162db5c` | PR #93 — hosted qualify `33345233547` |
| 1305 | `482bb787d0bb585c7af473d18911e220fa970fb3` | `fbdb8232c2cd219ba1640cd3bd4f65e9162f3ec4f6f38a449b065745636a3dd9` | PR #94 — hosted qualify `33352160781` |
| 1306 | `a79b50bb02466b3bfb3b0faaacc952ac6b034e08` | `76871675af153c55440ee472fde4aec25408c3f160a33f963e32ad2cf4e466c5` | PR #97 — hosted lock |
| 1310 | `20dab719f253c682f6ca7dd48e6400e61c89a246` | not separately recorded in the source receipt | PR #101 — hosted lock; closure `1903437d5591b48f27bd362c5c6b7ed78884b742` |

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
- `ideas/extended-zork/POST_1310_AFTER_FAIR.md`

The live shape at this refresh: merged frontier **1310** on `master` head `1903437d5591b48f27bd362c5c6b7ed78884b742`. CURRENT is **1310** complete through [PR #101](https://github.com/acrinym/zork1/pull/101). NEXT is **1309** (PR #98 draft), **1308** (planned with no implementation SHA), then **1307** (PR #99 draft). PR #100 is planning-only. The Mara keepsake/name item is concept-only and unsequenced. Never merge to `historicalsource/zork1`.
