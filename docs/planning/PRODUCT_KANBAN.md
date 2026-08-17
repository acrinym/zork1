# Highly Extended Zork — Product Kanban

**Updated:** August 17, 2026  
**Board data:** `docs/planning/product-kanban.json`  
**Current merged production frontier:** Release `1266` — Learned Magic as Parser Capability  
**Current `master`:** `4425732bfc2fa28347453d9991513aeb28aaa531`

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

## OPEN STACKED PREDECESSOR

### Release 1267 — Semantic Examination & Hidden Structure

**PR:** #72 — open, non-draft, review-clean, mergeable, based directly on merged `master`; **do not merge without a new explicit merge whistle**.  
**Current reviewed head:** `4c3522a0cfa8194764f52ce2e91930ef89bda1bf`  
**Base:** Release 1266 / `4425732bfc2fa28347453d9991513aeb28aaa531`  
**Locked artifact SHA-256:** `828383a78549cce45d26f888d14eb37838c74ce5b44588423eb8eca036ef77f0`  
**Post-review exact-head qualification:** run `32046910749` green.

1267 remains the immediate gameplay predecessor for CURRENT Release 1268. Its one CodeRabbit qualification finding was fixed, replied to, confirmed, and resolved; OpenHands judged the PR ready to merge. It remains deliberately unmerged because the previous merge whistle was already consumed.

## CURRENT

### Release 1268 — Clue Chains & Knowledge-Gated Interpretation

**PR:** #73 — open, non-draft, stacked directly on PR #72; **do not merge without a new explicit merge whistle**.  
**Base:** Release 1267 / `4c3522a0cfa8194764f52ce2e91930ef89bda1bf`  
**Locked implementation head:** `78a6c0ef6a4202c384deab93accd66f2620b3e4c`  
**Locked artifact SHA-256:** `bd663f335fb1500f809e797c92cc571a7828e5f410aebd2a1878298d65141f16`  
**Locked qualification:** run `32050047910` green.

Release 1268 proves that learned meaning can travel without carrying the original clue object:

- `INTERPRET PRAYER` at the fixed North Temple prayer learns a bounded piece of ancient-script grammar;
- `INTERPRET ENGRAVINGS` at the fixed Engravings Cave refuses secure interpretation before that knowledge exists, then recognizes one surviving practical air-passage motif after the Temple comparison is learned;
- an old geometric marking in the Dragon Gallery is physically visible before learning but semantically opaque;
- after the motif is learned, the same `EXAMINE MARKING` has more meaning;
- deliberate `INTERPRET MARKING` can identify Release 1267's **existing** ventilation seam rather than creating a second structure;
- the Temple prayer and cave engravings remain physically fixed in their canonical rooms throughout qualification;
- Release 1267's independent `EXAMINE BLACKENING` route still discovers the same seam with every 1268 knowledge bit at zero;
- three exact facts live in one compact table and the train adds zero legacy VM globals.

The hosted qualifier reruns the complete locked Release 1267 chain, pins exact predecessor staged identities, stages only `clue_interpretation.zil` plus `zork1.zil` identity/include wiring, smell-checks production/dev trees, compiles production/test stories, and drives five natural-command histories: premature Engravings refusal, learning across fixed source clues, unread field marking refusal, the full Temple → Cave → Gallery chain, and the untouched predecessor blackening route.

Candidate run `32049638837` passed all five histories and intentionally stopped at the artifact-lock gate. Locked run `32050047910` reproduced the exact artifact and passed green.

## NEXT — queued product trains

### 1. Release 1269 — Structural Difficulty Modes

Difficulty changes evidence redundancy, recoverability, substitutes, resources, and consequence windows instead of merely multiplying damage.

- same underlying world identity;
- no parser-phrasing difficulty tax;
- no enemy-health multiplier masquerading as puzzle difficulty.

### 2. Release 1270 — Causal Death & Failure Feedback

Death and near-death should communicate physical cause, ignored evidence, partially sound ideas, and what exact state/action changed the outcome without simply handing over the solution.

### 3. Release 1271 — Creature Encounters as Systemic Puzzles

Living beings remain authored situations with distinct motives, senses, capacities, fears, possessions, territory, and memory rather than hit-point-shaped locks.

- frighten, bribe, distract, trap, outrun, negotiate, trick, incapacitate, kill, befriend, manipulate, avoid, or leave alone where appropriate to that specific being;
- troll, thief, grue, dragon, and Mara remain meaningfully different;
- no generic creature AI brain or universal disposition meter.

### 4. Release 1272 — Shadowgate-Style Macrostructure, Original Zork Region

Capstone the Shadowgate-as-design-lens program with a substantial original Zork region whose design grammar composes the prior trains into one coherent adventure language.

Target roughly 20–30 authored rooms only if the design earns that size. Do not copy Shadowgate source code, prose, art, maps, exact puzzles, spell names, object lists, or expressive sequencing.

### 5. Release 1273 — Living Biomes & Wilderness Expansion

Expand Zork's actual geography and ecology with genuinely new wilderness identities, including a new forest subregion and a first wholly new jungle/rainforest climate if the authored design earns them.

No procedural biome generator, palette-swapped room factory, universal biome stat sheet, generic climate simulator, or room-count padding.

### 6. Release 1274 — Environmental Mechanisms & Diegetic Puzzle Furniture

**Planning contract:** `docs/planning/RELEASE_1274_ENVIRONMENTAL_MECHANISMS_DIEGETIC_PUZZLE_FURNITURE.md`

Translate the environmental-puzzle interaction grammar common to survival-horror/adventure games into original Zork-native parser play:

**notice a prose-visible irregularity → examine it → learn a physical fact → manipulate the correct concrete detail → the environment changes**.

Candidate authored situations include pivoting/sliding bookcases or panels, paintings/reliefs concealing catches, clocks/dials/counterweights, fireplaces/masonry/tiles, movable statue details, false backs/hidden drawers, multi-position furniture, and linked mechanisms.

The important part is the interaction language, not copying Resident Evil content. A suspicious book can support sensible attempts such as `EXAMINE BOOK`, `TAKE BOOK`, `PULL BOOK`, `LOOK BEHIND SHELF`, or `LISTEN TO SHELF`; the correct physical manipulation may expose a real persistent route or compartment.

Boundaries are strict: no generic secret-switch framework, no automatic noun promotion, no universal furniture state machine, no arbitrary `USE X ON Y` matrix, no unfair parser pixel hunt, and no copied Resident Evil maps, prose, art, exact puzzles, objects, or sequences.

## FUTURE — explicit lanes

- **Mara Earned Romance & Partnership** — mutual attraction, explicit mutual choice, closeness, boundaries, disagreement, initiative, repair, and partnership growing from lived history; no approval/love meter and no compulsory romance.
- **Forest That Answers Back / Existing-Region Interactivity** — continue promoting selected concrete nouns in existing forest and wilderness prose into targetable stateful world objects; complements Release 1273 rather than substituting for geographic expansion.
- **Time, Weather & Disaster Arc** — authored conditions/disasters layered onto real geography and material state; no generic climate simulator.
- **Museum & Ecology second expansion** — only where collection creates new field play instead of checklist accumulation.
- **Cross-IF / RPG Mechanics Adaptation — later inspirations** — rebuild transferable design principles as original Zork-native systems.
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
| 1264 | Perilous Affordances / Let the Player Be Wrong | #69 |
| 1265 | Consumable Light & Graduated Darkness | #70 |
| 1266 | Learned Magic as Parser Capability | #71 |

### Releases 1258–1266 merge and artifact receipts

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

Releases 1267 and 1268 are explicitly **not DONE** while PRs #72 and #73 remain open.

## Canonical roadmap

See `docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md` for broader design doctrine, `docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md` for Releases 1262–1272, and `docs/planning/RELEASE_1274_ENVIRONMENTAL_MECHANISMS_DIEGETIC_PUZZLE_FURNITURE.md` for the newly queued environmental-mechanism train.

The current shape is concrete: Releases 1262–1266 are merged; **Release 1267 / PR #72 is the open stacked predecessor; Release 1268 / PR #73 is CURRENT; Release 1269 — Structural Difficulty Modes — is next; Release 1274 — Environmental Mechanisms & Diegetic Puzzle Furniture — is now the end of the explicit queue.**
