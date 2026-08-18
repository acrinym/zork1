# Zork I — Release 1268 Post-Merge / Release 1275 Queue Handoff

Date: 2026-08-17
Repository: `acrinym/zork1`
Default branch: `master`

## START HERE — HARD REPOSITORY BOUNDARY

`historicalsource/zork1` is an upstream historical reference only. **READ ONLY.**

All branches, commits, pull requests, fixes, planning changes, qualification work, and merges belong in **`acrinym/zork1` only** unless Justin explicitly says otherwise.

Before every GitHub mutation, verify the repository owner/name is exactly `acrinym/zork1`.

Do not open, push, commit, retarget, merge, or otherwise mutate anything in `historicalsource/zork1`.

Mnemonic:

- `historicalsource/zork1` = museum exhibit
- `acrinym/zork1` = laboratory

This boundary exists because earlier tooling accidentally created upstream PRs. Do not repeat that mistake.

## LIVE STATE AT HANDOFF CREATION

Re-query live GitHub before doing any work in the next chat. Do not trust this document if live state has moved.

Immediately before this handoff file was committed:

- `master` head was `5702e9268cc4d26bef550dfa342c279acb13950b`
- open PR count in `acrinym/zork1`: **0**
- Release 1267 / PR #72: **merged**
- Release 1268 / PR #73: **merged**
- archival PR #74: **closed, unmerged, intentionally archival**

This handoff commit advances `master` once more, so the next chat must re-query the exact live `master` SHA first.

## MOST RECENT COMMITS / PRS

### Release 1267 — Semantic Examination & Hidden Structure

PR: `acrinym/zork1#72`

- final reviewed head: `4c3522a0cfa8194764f52ce2e91930ef89bda1bf`
- merge commit: `90e30d59fcd44a5297d7524f65ee34c72aaff319`
- state: merged
- final exact-head qualification: run `32046910749` green
- locked artifact: `zork1-glulx-semantic-examination-hidden-structure.ulx`
- artifact SHA-256: `828383a78549cce45d26f888d14eb37838c74ce5b44588423eb8eca036ef77f0`

Product result:

- selected concrete details already promised by room prose became honest parser targets;
- Timber Room westward draft became targetable;
- Scorched Cleft scratches/bones became targetable;
- Dragon Gallery heat blackening became targetable;
- examining the blackening can reveal the existing `DRAGON-VENT-SEAM`;
- the seam begins outside room scope and becomes a real object in the Gallery only after discovery;
- existing Release 1257 fire/smoke and Release 1262 dragon smoke-cover authority remain canonical;
- zero new legacy VM globals;
- pre-existing Troll Room semantic authority was deliberately not duplicated.

Review result:

- CodeRabbit found one valid hidden-seam qualification gap;
- fixed at exact reviewed head `4c3522a0...`;
- thread replied to, confirmed, and resolved;
- OpenHands judged the PR worth merging / ready.

### Release 1268 — Clue Chains & Knowledge-Gated Interpretation

PR: `acrinym/zork1#73`

- final exact head: `72751017dbec29b96e8b9ac2d972ca0ad195bb88`
- merge commit: `2e16f6cebbfb5a7892feac08d9e6461e6bb9313b`
- state: merged
- locked implementation head: `78a6c0ef6a4202c384deab93accd66f2620b3e4c`
- locked qualification: run `32050047910` green
- final exact-head post-review qualification: run `32052058707` green
- locked artifact: `zork1-glulx-clue-chains-knowledge-interpretation.ulx`
- artifact SHA-256: `bd663f335fb1500f809e797c92cc571a7828e5f410aebd2a1878298d65141f16`

Product chain:

1. `INTERPRET PRAYER` at the fixed North Temple prayer learns bounded ancient-script comparison knowledge.
2. `INTERPRET ENGRAVINGS` at the fixed Engravings Cave refuses secure interpretation before that knowledge exists; afterward it recognizes one surviving practical air-passage motif.
3. A visible old geometric marking in the Dragon Gallery is physically visible before learning but semantically opaque.
4. After learning, `EXAMINE MARKING` has more meaning.
5. `INTERPRET MARKING` can identify Release 1267's **existing** `DRAGON-VENT-SEAM`.
6. Release 1267's independent `EXAMINE BLACKENING` route remains valid with all 1268 knowledge bits zero.

1268 state/authority boundaries:

- three exact facts live in one compact table;
- zero new legacy VM globals;
- no generic clue counter;
- no notebook/quest-log engine;
- no automatic hint system;
- no second ventilation seam;
- no rewriting of canonical prayer/engravings source objects;
- physical source clues remain fixed in their canonical rooms; remembered meaning travels.

CodeRabbit review finding on #73:

- qualification workflow path filters were too narrow for the full Glulx dependency closure;
- fixed in commit `72751017dbec29b96e8b9ac2d972ca0ad195bb88` by including `glulx/**`;
- exact-head Release 1268 qualification run `32052058707` completed green;
- review thread was replied to, CodeRabbit confirmed the fix, and the GraphQL thread was resolved before merge.

## ARCHIVAL PR #74 — DO NOT MERGE

PR: `acrinym/zork1#74`
Title: `Mega pull request — recovered archival copy of historicalsource/zork1#10`

State:

- closed
- unmerged
- archival only

Purpose:

The historical Mega PR had accidentally been opened against `historicalsource/zork1`. Its exact historical diff was reconstructed inside **our fork** using two archival refs:

- base: `archive/historicalsource-pr-10-base`
  - SHA `97b7b3d68c075dd9af7da499c3e9690ada3471fd`
- head: `archive/historicalsource-pr-10-head`
  - SHA `a70bdcf56a71fe36721a5ed1f90d7207e6450ebb`

The historical head is already an ancestor of modern `acrinym/zork1` master, so no code recovery is required.

Keep #74 closed and unmerged. It exists only so the historical PR record lives in the correct repository.

## LATEST DIRECT PLANNING COMMIT

Commit:

`5702e9268cc4d26bef550dfa342c279acb13950b`

Message:

`Plan Release 1275 slim-locale expansion with explicit Justin feedback`

New planning document:

`docs/planning/RELEASE_1275_EXPAND_EXISTING_SLIM_LOCALES_WITH_JUSTIN_FEEDBACK.md`

Release 1275 is now the explicit end of the currently queued train list unless Justin extends the roadmap again.

## CURRENT EXPLICIT QUEUE

The merged production frontier is Release **1268**.

### NEXT: Release 1269 — Structural Difficulty Modes

Difficulty must alter the **structure of problem-solving**, not just numbers.

Core doctrine:

- same underlying world identity across modes;
- difficulty changes evidence redundancy, recoverability, available substitutes, resources, and consequence windows;
- no parser-phrasing difficulty tax;
- no enemy-health multiplier masquerading as puzzle difficulty;
- no generic scalar difficulty framework sprayed across unrelated systems.

When starting 1269, inspect the live roadmap and game state first, then choose concrete authored situations that demonstrate structural difficulty while preserving canonical authorities.

Natural player-command qualification is required.

### Release 1270 — Causal Death & Failure Feedback

Death and near-death should communicate:

- physical cause;
- ignored evidence;
- partially sound ideas;
- exact state/action differences that changed the outcome;

without simply handing the player the solution.

### Release 1271 — Creature Encounters as Systemic Puzzles

Living beings remain authored situations with distinct motives, senses, capacities, fears, possessions, territory, and memory rather than hit-point-shaped locks.

Possible authored interactions where appropriate:

- frighten
- bribe
- distract
- trap
- outrun
- negotiate
- trick
- incapacitate
- kill
- befriend
- manipulate
- avoid
- leave alone

Troll, thief, grue, dragon, Mara, and any future creature must remain meaningfully different.

No generic creature AI brain or universal disposition meter.

### Release 1272 — Shadowgate-Style Macrostructure, Original Zork Region

Capstone the Shadowgate-as-design-lens program with a substantial **original Zork region** composing prior trains into one coherent adventure language.

Target roughly 20–30 authored rooms **only if the design earns that size**.

Do not copy Shadowgate source code, maps, prose, art, exact puzzles, spell names, object lists, or expressive sequencing.

### Release 1273 — Living Biomes & Wilderness Expansion

Expand Zork's actual geography/ecology with genuinely new wilderness identities.

Current intended scope includes:

- a genuinely new forest subregion beyond the existing forest/tree scene and vine/underbrush edge;
- a first wholly new climate/biome such as an authored jungle/rainforest region if the design earns it;
- distinct climate, canopy, water, ground, flora, fauna, traversal, hazards, resources, sensory language, and scripted scenes.

No procedural biome generator, palette-swapped room factory, universal biome stat sheet, generic climate simulator, or room-count padding.

### Release 1274 — Environmental Mechanisms & Diegetic Puzzle Furniture

Planning document:

`docs/planning/RELEASE_1274_ENVIRONMENTAL_MECHANISMS_DIEGETIC_PUZZLE_FURNITURE.md`

Core interaction grammar:

**notice a prose-visible irregularity → examine it → learn a physical fact → manipulate the correct concrete detail → the environment changes**

Candidate authored mechanism families include:

- pivoting/sliding bookcases or wall panels;
- paintings, mirrors, plaques, or reliefs concealing catches/compartments;
- clocks, dials, levers, counterweights, and mechanical furniture;
- fireplaces, masonry, tiles, pressure plates, and architectural seams;
- statues or ornaments with movable subparts;
- furniture with false backs, hidden drawers, or underside catches;
- multi-position objects whose orientation changes real room state;
- linked mechanisms where one concrete control changes another room/object.

Strict boundaries:

- no generic secret-switch framework;
- no automatic noun promotion;
- no universal furniture state machine;
- no arbitrary `USE X ON Y` matrix;
- no parser pixel-hunt equivalent;
- no copied Resident Evil maps, prose, art, exact puzzles, objects, or sequences;
- correct manipulation must create real persistent world state, not flavor-only output.

### Release 1275 — Expand Existing Slim Locales / Locations — with Justin's Explicit Feedback

Planning document:

`docs/planning/RELEASE_1275_EXPAND_EXISTING_SLIM_LOCALES_WITH_JUSTIN_FEEDBACK.md`

This train returns to **existing geography** and expands places that are under-realized relative to what Zork says or implies they are.

The governing requirement is in the title:

**Justin's explicit feedback is required.**

The assistant may:

- inspect the live map/game;
- inventory candidate thin locales;
- explain why a locale feels under-realized;
- surface possible expansion axes;
- show concrete tradeoffs.

The assistant must **not** autonomously settle:

- which locale is expanded;
- what direction it grows in;
- how much expansion is enough;
- whether a compact location actually needs expansion.

Justin chooses, redirects, rejects, combines, or constrains the locale and intended shape before implementation proceeds.

1275 is not an autonomous mega-expansion and not a room-count exercise.

No procedural locale expander, generic room generator, palette-swapped filler, or ceremonial after-the-fact approval.

## IMPORTANT: STALE PLANNING BOARDS

At handoff time, these older board files still contain pre-merge bookkeeping that describes #72/#73 as open and 1266 as the merged frontier:

- `docs/planning/PRODUCT_KANBAN.md`
- `docs/planning/product-kanban.json`

Those entries are stale because #72 and #73 have since merged and Release 1275 was added directly afterward.

**Next chat should refresh the human and machine boards from live GitHub before starting Release 1269.**

Do not mistake those stale entries for current truth.

Desired refreshed board state:

- merged frontier: Release 1268
- #72: DONE / merged at `90e30d59fcd44a5297d7524f65ee34c72aaff319`
- #73: DONE / merged at `2e16f6cebbfb5a7892feac08d9e6461e6bb9313b`
- open PRs: none at handoff creation
- CURRENT: empty between trains
- NEXT 1: Release 1269
- explicit queue continues through Release 1275
- Release 1275 planning doc recorded

Refreshing those boards is bookkeeping, not a new product train.

## ENGINEERING / PRODUCT RULES TO PRESERVE

- Justin is the sole developer; PRs should normally be non-draft.
- Do not merge without a **fresh explicit merge whistle**.
- A whistle is scoped/consumed; do not reuse an old whistle for future PRs.
- Preserve PR stacks when multiple trains are open.
- If a stacked parent merges, retarget descendants to `master` before considering merge.
- Before merging, re-query exact live head, base, mergeability, checks, reviews, top-level review comments, and GraphQL review threads.
- Fix actionable review findings; reply and resolve threads only after the fix is real.
- Preserve canonical object/state authority; do not create duplicate authorities.
- Prove product behavior through real natural player commands.
- No stubs, TODOs, no-ops, or fake product slices.
- Do not build generic machinery merely because several examples look superficially similar.
- No recursive audit machinery / audit-the-audit behavior.
- Canonical Zork solutions remain valid when physically credible alternatives are added.
- Reusable tools are acceptable where the same physical logic truly applies.
- Cleverness should reduce player friction, not create arbitrary fetch-grind.
- Soft sequence breaks must be physically earned, state-safe, and non-bricking.
- Mara remains one authored person, not a follower framework, approval meter, romance meter, skill tree, or omniscient companion AI.

## ACTIONS / QUALIFICATION PRACTICE

Hosted Glulx qualification is an established source of truth for these trains.

When a train changes after review:

- qualify the exact post-review head;
- preserve artifact identity where the change should not alter the compiled product;
- record run IDs and exact SHAs;
- use actual command histories, not only unit-style structural checks.

GitHub Actions cost awareness remains important, but these existing release-specific hosted qualification workflows are intentional and established.

## NEXT CHAT FIRST MOVES

1. Verify the repository is **`acrinym/zork1`**. Never mutate `historicalsource/zork1`.
2. Re-query live `master` and open PRs.
3. Read this handoff.
4. Read both planning boards and note that their #72/#73/frontier entries are stale relative to live GitHub.
5. Read the Release 1274 and Release 1275 planning documents.
6. Refresh the human and machine Kanban to the merged Release 1268 frontier and queue through 1275.
7. Start **Release 1269 — Structural Difficulty Modes** from live `master` on a new branch in `acrinym/zork1`.
8. Build a complete player-facing train, qualify with natural commands, open a non-draft PR, request review, fix actionable findings, and stop before merge.
9. **Do not merge without a new explicit Justin merge whistle.**

## CLEAN NEW-CHAT SEED

Use this:

> Continue `acrinym/zork1` from `docs/handoffs/ZORK_RELEASE_1268_POST_MERGE_1275_QUEUE_HANDOFF_2026-08-17.md`. Re-query live `master` and open PRs first. Releases 1267 and 1268 are merged; the explicit queue now runs 1269–1275, with Release 1275 requiring Justin's explicit feedback for every slim-locale expansion target/direction. Refresh the stale human/machine Kanban from live state before beginning Release 1269 — Structural Difficulty Modes. **Never mutate `historicalsource/zork1`; it is read-only upstream reference.** Work only in `acrinym/zork1`, preserve canonical authorities, qualify through real player commands, and do not merge without a new explicit merge whistle.
