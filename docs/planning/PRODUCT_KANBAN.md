# Highly Extended Zork — Product Kanban

**Updated:** August 17, 2026  
**Board data:** `docs/planning/product-kanban.json`  
**Current merged production frontier:** Release `1263` — Ablative Protection & Equipment Consequence  
**`master` head when the 1264–1265 stack started:** `1a5b9cb27e85648fd7cd95cd1c9c890be1d71e66`

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

### Release 1264 — Perilous Affordances / Let the Player Be Wrong

**PR:** #69 — open, non-draft, mergeable, **do not merge without a new explicit merge whistle**.  
**Current branch head:** `7a11375160d8893698f6df3ce16b8c8c35a810fc`  
**Locked artifact SHA-256:** `04216477fb50deeb04f833122d5874c602277b2b4522cbf72420f2b987b52a1d`  
**Release-specific exact-artifact qualification:** run `31949574481` green on implementation/review head `931b7653b38db58b71e77b8efe6085d7120b6dbd`; the later `7a113751...` change is maintenance-only Kanban regression repair and does not alter Release 1264 production/staging inputs.

Release 1264 remains an unmerged prerequisite for Release 1265. It is not CURRENT because its descendant train is now the active product surface, and it is not DONE because PR #69 has not been merged.

Its authored consequences remain:

- explicit weapon-driven destruction of the canonical brass lantern reaches the existing `BROKEN-LAMP` consequence family;
- the canonical hemp rope can be deliberately cut or burned, including the recoverable self-fire history when burned around the Adventurer's legs;
- deliberate burning/cutting of the Release 1263 fire screen consumes or ruins its existing qualitative protection state;
- explicit destruction of Release 1262 star-glass removes that treasure while other dragon routes and substitutes remain real;
- untouched canonical lantern, rope, and star-glass histories remain qualified.

## CURRENT

### Release 1265 — Consumable Light & Graduated Darkness

**PR:** #70 — open stacked PR targeting the Release 1264 branch; **do not merge without a new explicit merge whistle**.  
**Stack base:** PR #69 head `7a11375160d8893698f6df3ce16b8c8c35a810fc`  
**Locked artifact SHA-256:** `6908e60a4dc191e1f74353055aa3dce11e72172edb96557a0f66d069327c1070`  
**Locked qualification:** run `32030511091` green on head `461f55f566770cfec17d87708cc85fdec388a1ed`.

Release 1265 promotes existing light/resource authorities into qualitative authored world state rather than replacing them:

- the canonical `LAMP-TABLE`, `CANDLE-TABLE`, `I-LANTERN`, `I-CANDLES`, and `LIGHT-INT` remain the consumable-resource authority;
- selected exact portable sources now have authored **bright / weak / ember / dark** useful reach while binary `LIT?` remains authoritative for visibility and canonical darkness;
- a fresh bright brass lantern can physically reveal the Release 1256 grue colony, while a weak lamp preserves ordinary visibility without reaching deeply enough into the fissures;
- a real lit match provides only a tiny, one-turn ember-scale emergency circle before its canonical flame expires;
- real bottled water can waterlog the ritual candles, extinguish them, block immediate relighting for a stated physical reason, and then allow the existing match-to-candle transfer route again after narrated drying;
- Release 1257's real Timber Room fire/smoke/draft can snuff carried ember-stage candles without any duplicate fire state;
- the canonical ivory torch remains permanent bright light and still reveals the colony;
- no lux map, numeric fuel points, generic light-source class, universal fuel registry, replacement grue logic, replacement `LIT?`, or new legacy VM globals were added.

Qualification replays the complete locked Release 1264 predecessor, stages exactly six intended production paths, compiles production and test stories, and proves six natural-command histories: bright lamp, weak lamp, ember emergency, wet/dry candles, Timber Room smoke versus ember candles, and canonical ivory torch.

Candidate run `32029901887` intentionally stopped only after all six histories passed to obtain the exact artifact identity. Locked run `32030511091` reproduced that identity exactly and passed the complete nested qualification green.

The Mara-focused run remains intentionally paused after Release 1261 while the wider world receives comparable authored depth.

## NEXT — Shadowgate → Parser IF Adaptation Program

Shadowgate is a **design lens only**. Borrow interaction principles and rebuild them from scratch as original Zork-native parser play. Do not copy source code, prose, art, maps, exact puzzles, spell names, object lists, or expressive sequencing.

Full train specifications: `docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md`.

### 1. Release 1266 — Learned Magic as Parser Capability

Let original Zork-native magical knowledge expand what the parser meaningfully permits because the Adventurer actually learned a word, rite, formula, sign, or command.

- no copied Shadowgate spells;
- no mana-bar overlay;
- knowledge acquisition happens in-world;
- learned capability remains bounded to authored world authority.

### 2. Release 1267 — Semantic Examination & Hidden Structure

Promote selected meaningful descriptive details into trustworthy parser targets.

- seams, scorches, drafts, stains, hinges, damaged fittings, and other authored details can be examined/referenced naturally;
- targetability does not guarantee success;
- no generic noun generator.

### 3. Release 1268 — Clue Chains & Knowledge-Gated Interpretation

Carry learned meaning across locations so earlier documents, symbols, observations, museum evidence, and testimony can change later interpretation without requiring the original clue object forever.

- prefer named causal facts over generic clue counters;
- museum/archive knowledge can become useful in the field;
- companions do not become automatic hint engines.

### 4. Release 1269 — Structural Difficulty Modes

Difficulty changes evidence redundancy, recoverability, substitutes, resources, and consequence windows instead of merely multiplying damage.

- same underlying world identity;
- no parser-phrasing difficulty tax;
- no enemy-health multiplier masquerading as puzzle difficulty.

### 5. Release 1270 — Causal Death & Failure Feedback

Death and near-death should communicate physical cause, ignored evidence, partially sound ideas, and what exact state/action changed the outcome without simply handing over the solution.

### 6. Release 1271 — Creature Encounters as Systemic Puzzles

Living beings remain authored situations with distinct motives, senses, capacities, fears, possessions, territory, and memory rather than hit-point-shaped locks.

- frighten, bribe, distract, trap, outrun, negotiate, trick, incapacitate, kill, befriend, manipulate, avoid, or leave alone where appropriate to that specific being;
- troll, thief, grue, dragon, and Mara remain meaningfully different;
- no generic creature AI brain or universal disposition meter.

### 7. Release 1272 — Shadowgate-Style Macrostructure, Original Zork Region

Capstone the program with a substantial original Zork region whose **design grammar** composes the prior trains into one coherent adventure language.

Target roughly 20–30 authored rooms only if the design earns that size, with cross-location clues, multiple-use objects, reactive threats, meaningful consumables, learned knowledge/magic, hidden structure, unsafe-before-prepared routes, creature situations, intersecting solution paths, persistent consequences, and optional secrets.

## FUTURE — explicit lanes

- **Mara Earned Romance & Partnership** — mutual attraction, explicit mutual choice, closeness, boundaries, disagreement, initiative, repair, and partnership growing from lived history; no approval/love meter and no compulsory romance.
- **Forest That Answers Back / Described World = Interactive World** — continue promoting selected concrete nouns into targetable stateful world objects.
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

Releases 1264 and 1265 are explicitly **not DONE** while PRs #69 and #70 remain open.

## Canonical roadmap

See `docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md` for broader design doctrine and `docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md` for Releases 1262–1272.

The current shape is concrete: the Mara stack through 1261 is merged; Releases 1262–1263 are the merged Shadowgate-derived trains; Release 1264 is the open stacked predecessor; **Release 1265 is the qualified CURRENT train; Release 1266 — Learned Magic as Parser Capability — is next.**
