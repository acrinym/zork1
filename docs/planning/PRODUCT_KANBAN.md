# Highly Extended Zork — Product Kanban

**Updated:** August 15, 2026  
**Board data:** `docs/planning/product-kanban.json`  
**Current merged production frontier:** Release `1257` — Fire, Smoke & Structural Consequences  
**`master` planning head before this update:** `8cd2edf91befab4411f3565a14e21d8b635bfe66`

This board is the human operating surface for the active Zork product queue. The JSON board remains the tooling surface.

## Operating rules

- **CURRENT** contains at most one actively implemented train and may be empty between merged trains.
- **NEXT** is ordered.
- New work must be a substantial player-facing train, not placeholder cleanup.
- Canonical solutions remain valid when new physically credible alternatives are added.
- Reusable tools remain reusable where the same physical logic reasonably applies.
- Player ingenuity should reduce repeated friction, not create a fetch-grind tax.
- Soft sequence breaks are allowed when physically earned, state-safe, and non-bricking.
- Mara remains one authored human adventurer: no approval meter, generic follower framework, skill tree, omniscient companion AI, or romance meter.
- Mara becoming a genuine love interest is an explicit future product direction; romance must be earned through lived history and mutual choice rather than bolted on as a score system.
- No universal crafting grid, arbitrary object-pair matrix, generic physics simulator, recursive audit machinery, TODO-only slice, or no-op scaffolding.
- **DONE** requires merged or otherwise immutable proof.

## CURRENT / STACKED FRONTIER

The merged production frontier remains Release 1257. The active unmerged Mara stack currently extends beyond this board's older 1258 snapshot:

1. Release 1258 — Mara Causal Biography & Shared Danger — PR #63.
2. Release 1259 — Mara Field Capability Discovery — PR #64, stacked on #63.
3. Release 1260 — Mara Lived Feeling, Rupture & Repair — PR #65, stacked on #64.
4. Release 1261 — Mara Anticipation, Worry & Protective Initiative — PR #66, stacked on #65; final artifact qualification still needs to be made honest/green before acceptance.

All remain unmerged unless Justin gives the explicit merge whistle.

The design purpose of this stack is now bounded: Mara has enough causal history, feeling, capability, rupture/repair, and prospective concern machinery to **live in the game**. After 1261, major Mara-only organ expansion pauses so the wider Zork world can catch up.

## NEXT — ordered after the Mara stack

The next program is a deliberate **Shadowgate → Parser IF Adaptation Program**. Shadowgate is a design lens only: borrow interaction principles and rebuild them from scratch as original Zork-native parser play. Do not copy source code, prose, art, maps, spell names, exact puzzles, object lists, or expressive sequencing.

Full train specifications: `docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md`.

### 1. Release 1262 — Hostile Rooms & Reactive Threats

Begin with the **Treasure Guardian Dragon & Hoard**, but treat the dragon as the first showcase of a deeper idea: a live threat observes and reacts to what the player actually does inside a dangerous room. Interaction costs opportunity because the threat is physically present, not because the game switched to generic combat turns.

- original Zork-native dragon and hoard;
- visible warning signs and dangerous fire breath;
- fire composes with existing fire/smoke/material consequence authorities;
- preparation, trickery, environmental manipulation, avoidance, containment, theft, negotiation where appropriate, and direct confrontation can produce different outcomes;
- retreat remains real where geography permits;
- no generic hit-point boss fight.

### 2. Release 1263 — Ablative Protection & Equipment Consequence

Protection takes the consequence itself. Shields, rope, clothing, helmets, improvised barriers, and other authored equipment can char, dent, soak, abrade, warp, crack, or otherwise carry physical evidence of what they survived.

- no durability percentage;
- condition is communicated through description and behavior;
- degradation exists only where it creates interesting decisions rather than inventory maintenance.

### 3. Release 1264 — Perilous Affordances / Let the Player Be Wrong

Stop using meta-game refusals to protect puzzle-critical objects from physically possible bad choices. If the Adventurer can honestly break, burn, discard, consume, drop, or misuse something, allow it where the world can support the consequence.

- recoverable failures and substitutes where physically credible;
- alternate routes where appropriate;
- genuine irreversible mistakes only when sufficiently warned;
- agency, not arbitrary punishment.

### 4. Release 1265 — Consumable Light & Graduated Darkness

Turn illumination into authored world state rather than a binary lamp flag.

- bright / weak / ember / darkness states where useful;
- flame transfer between real objects;
- wet/damaged fuel behavior;
- interaction with existing fire, smoke, and grue ecology;
- loss of light can become an emergency rather than hidden timer busywork;
- no universal lux simulator.

### 5. Release 1266 — Learned Magic as Parser Capability

Original Zork-native magical knowledge can expand what the parser meaningfully lets the Adventurer do because the character has actually learned a word, rite, formula, sign, or command.

- no copied Shadowgate spells;
- no mana bar pasted over Zork;
- knowledge acquisition happens in-world;
- learned capabilities remain bounded to authored world authorities.

### 6. Release 1267 — Semantic Examination & Hidden Structure

Promote selected meaningful descriptive details into trustworthy parser targets.

- pale blocks, seams, scorches, drafts, stains, hinges, damaged fittings, and other authored details can be examined/referenced naturally;
- targetability does not guarantee success;
- no generic noun generator;
- selected descriptions stop promising details the parser cannot honor.

### 7. Release 1268 — Clue Chains & Knowledge-Gated Interpretation

Knowledge persists as meaning rather than requiring the player to carry the original clue forever.

- earlier inscriptions/documents/symbols can change later EXAMINE interpretation;
- museum/archive knowledge can become useful in the field;
- Mara or another being may know a different piece without becoming an automatic hint system;
- prefer named causal facts over generic `FOUND_CLUE_17` design.

### 8. Release 1269 — Structural Difficulty Modes

Difficulty changes the puzzle/world structure instead of merely multiplying damage.

- clearer evidence, redundant resources, and more recoverable mistakes at lower pressure;
- subtler evidence, fewer substitutes, tighter consequence windows, and more irreversible choices at higher pressure;
- same underlying world identity;
- no parser-phrasing difficulty tax.

### 9. Release 1270 — Causal Death & Failure Feedback

Death and near-death should explain the physical cause, the warning/evidence involved, and whether part of the attempted idea was sound without simply giving the solution away.

A strong failure should help the player infer: what killed me, what did I ignore, what part nearly worked, and what exact state/action changed the result.

### 10. Release 1271 — Creature Encounters as Systemic Puzzles

Living beings remain authored beings with motives, senses, capacities, fears, possessions, territory, and memory where appropriate rather than becoming hit-point-shaped locks.

- frighten, bribe, distract, trap, outrun, negotiate, trick, incapacitate, kill, befriend, manipulate, avoid, or leave alone depending on the specific being and state;
- troll, thief, grue, dragon, and Mara should remain meaningfully different;
- no generic creature AI brain or universal disposition meter.

### 11. Release 1272 — Shadowgate-Style Macrostructure, Original Zork Region

Capstone the program with a substantial original Zork region whose **design grammar** reflects the prior trains while all actual content/expression remains original.

Target a roughly 20–30-room authored adventure region if the design earns that size, with cross-location clues, multiple-use objects, reactive threats, meaningful consumables, learned knowledge/magic, hidden structure, unsafe-before-prepared routes, creature situations, intersecting solution paths, persistent consequences, and optional secrets.

The point is to prove that Releases 1262–1271 became a coherent gameplay language rather than eleven disconnected demonstrations.

## FUTURE — explicit lanes after / around the Shadowgate program

- **Mara Earned Romance & Partnership** — Mara becoming a genuine love interest is planned, not brushed aside. Build mutual attraction, explicit mutual choice, physical/emotional closeness, boundaries, disagreement, repair, initiative, and partnership out of lived history. Prior harm/repair remains true; romance does not reset biography. No dating-sim approval/love meter, and no compulsory romance in histories that have not earned or mutually chosen it.
- **Forest That Answers Back / Described World = Interactive World** — continue promoting selected concrete nouns in authored descriptions into targetable, stateful objects whose interactions compose with existing physicality.
- **Time, Weather & Disaster Arc** — layer authored conditions and selected disasters onto real geography/material state where they create preparation, shelter, traversal, rescue, and aftermath play; no generic climate simulator.
- **Museum & Ecology second expansion** — only where collection creates new field play rather than checklist accumulation.
- **Cross-IF / RPG Mechanics Adaptation — later inspirations** — after the Shadowgate-first program, study other games for transferable design principles and rebuild selected ideas from scratch. Keep S.T.A.L.K.E.R. Glulx a separate product lane.
- **Narrative Perspective Experiments** — isolated first-person, third-person, and interactive-storybook editions against real canonical state.
- **Far-horizon DRAW + multi-agent experiments** — isolated experimental editions/tools only after the playable product supports them.
- Additional selected authored consequences from `LIVING_ZORK_FUTURE_IDEAS_KANBAN.md` where present.

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

Recent merged production receipts:

- Release 1253 merge `f5b1f1a3e7f65ff11db06f344580f83c3ed191b1`; artifact `232baaa8255f4b95ab5f90e13e6669874bcd42c66744d8173f360169ffb499ff`.
- Release 1254 merge `7b99869d8cb2e6db93243432fd8140a937205f44`; artifact `86fe8c6be4d377299ec66ae08801510303232d03a7dd5d5d42dc77357a51e6e0`.
- Release 1255 merge `8ad53ebc2ec2ce2a454ce6951d919bb1a2025937`; artifact `03dde8995474368119597a6b4ba87e35feeb4147a8f1ff1327574a7af34820be`.
- Release 1256 merge `14d1be667db3110d532b0e2c28f00b92371693fc`; artifact `59a457cc4aeb17e3d1d1b4e219be82156302f982804310c996cd928f03b79975`.
- Release 1257 merge is present on current `master`; its locked artifact is `d5080468723731018db587bcb5320cb88bb0a0b7585ee1c83156497dfb7fc444`.

## Canonical roadmap

See `docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md` for the broader design doctrine and `docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md` for the detailed Releases 1262–1272 design program.

The intended shape is now explicit: finish the current Mara stack through 1261; let the wider game catch up through the Shadowgate-derived parser-IF program; retain Mara romance/partnership as a real future authored path rather than replacing it with endless Mara-only subsystem trains.
