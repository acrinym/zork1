# Highly Extended Zork — Product Kanban

**Updated:** August 14, 2026  
**Board data:** `docs/planning/product-kanban.json`  
**Current merged production frontier:** Release `1257` — Fire, Smoke & Structural Consequences  
**`master` head:** `8b6a390f959b5156876faf9d421c345a74e54423`

This board is the human operating surface for the active Zork product queue. The JSON board remains the tooling surface.

## Operating rules

- **CURRENT** contains at most one actively implemented train and may be empty between merged trains.
- **NEXT** is ordered.
- New work must be a substantial player-facing train, not placeholder cleanup.
- Canonical solutions remain valid when new physically credible alternatives are added.
- Reusable tools remain reusable where the same physical logic reasonably applies.
- Player ingenuity should reduce repeated friction, not create a fetch-grind tax.
- Soft sequence breaks are allowed when physically earned, state-safe, and non-bricking.
- Mara remains one authored human adventurer: no approval meter, generic follower framework, skill tree, or omniscient companion AI.
- No universal crafting grid, arbitrary object-pair matrix, generic physics simulator, recursive audit machinery, TODO-only slice, or no-op scaffolding.
- **DONE** requires merged or otherwise immutable proof.

## CURRENT

### Release 1258 — Mara Causal Biography & Shared Danger

**Active branch:** `agent/mara-causal-biography-shared-danger-20260813`  
**PR:** #63  
**Base:** merged Release 1257 on `master`  
**Status:** artifact locked; final hosted qualification in progress / awaiting clean completion; merge still requires Justin's explicit whistle.

**Player outcome:** Mara's later behavior can now be caused by named things she actually lived through rather than a global relationship score.

Current showcase:

- asking Mara about the dangerous Dam ladder can lead **her** to decide to inspect it herself;
- a real slip creates a persistent bodily injury and moves her one exact measured field rope into the Adventurer's custody;
- `PROMISE MARA`, `RESCUE MARA`, ordinary `GIVE FIELD ROPE TO MARA`, movement, and abandonment create distinct lived facts;
- returning the exact entrusted rope can complete the narrow promise, while leaving with it can break the promise without inventing a dialogue-choice abstraction;
- later overloaded ladder danger can be refused because of concrete precedent or accepted because rescue + exact rope return created stronger contrary evidence;
- in the earned history Mara catches the Adventurer with her own rope, then independently notices an old survey punch and withholds disclosure until later asked;
- the new causal decision does not consult legacy `TRUST`, `RESPECT`, or `SAFETY` slots;
- Release 1253 Dam survival remains authoritative outside Mara's narrow intervention; Release 1257 fire authority remains unchanged.

Locked Release 1258 production artifact:

- SHA-256: `cfbe0e05ea2b70101aee2103bf07b80993ba479a41a905ad882102e6415d7263`
- size: `445440` bytes
- checksum: `0xa0517751`

Hosted candidate qualification run `31771976811` played all four histories successfully and intentionally stopped at the artifact-lock gate; the exact identity above is now pinned for the final rerun.

## NEXT — ordered

### 1. Release 1259 — Mara Field Capability Discovery

**Stack branch reserved:** `agent/mara-field-capability-discovery-20260814`  
**Dependency:** inherit the final Release 1258 head after its locked qualification completes.

Build **capability biography**, not a skill tree. Mara discovers that things she already knows intellectually or professionally can become surprising physical and perceptual abilities under real conditions.

Planned authored expedition arc:

- a completed House rest can let her Dam shoulder recover without erasing the biographical fact or scar of the injury;
- at the River Frigid, survey geometry plus her measured field rope and a real fixed overhead service point can become an improvised pendulum traversal she did not know she could physically execute;
- the first successful traversal should surprise Mara herself rather than announce an unlock;
- the traversal can recover a real old survey object, giving the discovery physical evidence rather than a capability flag alone;
- a later Loud Room / canyon situation can reveal bounded acoustic-ranging ability rooted in years of listening to structures and spaces;
- at least one newly discovered capability must later be deliberately reused by Mara, proving learning rather than a one-off cutscene;
- helpful field competence may include bounded first aid / stabilization where an authored injury makes it physically relevant.

Boundaries:

- no `Acrobatics +1`, XP, perk menu, class system, or generic skill framework;
- no superpowers or sudden personality rewrite;
- no automatic puzzle solving or conversion of Mara into a hint engine;
- no Lara Croft clone: adventurous physical competence is allowed, but Mara remains fallible, independent, injured by mistakes, and capable of choosing not to act;
- discoveries must grow from Mara Tallow's existing biography: survey math, route history, field practice, observation, and lived danger.

## FUTURE

- **Mara Longer Biography** — recovery over time, conflicting promises, longer separation, discoveries she chooses whether/when to disclose, archive disagreement, thief manipulation, troll judgment, mistakes made without the player present, repair after betrayal, changing interpretations of the Adventurer, deeper friendship, and optional romance only if lived history earns it.
- **Treasure Guardian Dragon & Hoard** — original Zork-native dragon encounter around a real treasure hoard, authored territorial behavior, visible warning signs, dangerous fire breath, and multiple credible Zork approaches rather than a generic hit-point boss fight.
- **Cross-IF / RPG Mechanics Adaptation — Shadowgate First** — study useful mechanics and rebuild selected concepts from scratch as original Zork-native systems; borrow design lessons, not protected expression.
- **Forest That Answers Back / Described World = Interactive World** — promote selected concrete nouns already present in forest descriptions into targetable, stateful world objects.
- **Time, Weather & Disaster Arc** — authored conditions layered onto real geography and existing material state; no generic climate simulator.
- **Causal Death & Warning Depth** — fair warning, near-death, delayed-consequence, and exact-object provenance expansions.
- **Museum & Ecology second expansion** — only where collection creates new field play rather than checklist accumulation.
- **Narrative Perspective Experiments** — isolated first-person, third-person, and interactive-storybook editions against real canonical state.
- **Far-horizon DRAW + multi-agent experiments** — isolated experimental editions/tools only after the playable product supports them.
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
- Release 1257 merge `8b6a390f959b5156876faf9d421c345a74e54423`; artifact `d5080468723731018db587bcb5320cb88bb0a0b7585ee1c83156497dfb7fc444`.

## Canonical roadmap

See `docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md` for the broader design doctrine. Release 1258 is the active qualified Mara causal-biography train. Release 1259 is the next concrete Mara train: abilities emerge from authored lived situations and are remembered because she did them, not because the game awarded a perk.
