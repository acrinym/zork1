# Zork I — Release 1263 Post-Merge Handoff

**Date:** August 16, 2026  
**Repository:** `acrinym/zork1`  
**Default branch:** `master`  
**Production frontier:** Release `1263` — **Ablative Protection & Equipment Consequence**  
**`master` immediately before this handoff commit:** `6a29354e891663a7b56d804e8f7470c98194b6fb`

## Read this first in the next chat

The repository has crossed a clean product boundary.

Releases **1258 through 1263 are merged**. The Mara-focused expansion run is intentionally paused after Release 1261. Releases 1262 and 1263 begin the committed **Shadowgate → Parser IF Adaptation Program**, using Shadowgate only as a source of design principles while all actual Zork content, prose, objects, geography, puzzles, and implementation remain original.

The next product train is:

> **Release 1264 — Perilous Affordances / Let the Player Be Wrong**

Do **not** resume by inventing another Mara-only subsystem. Mara remains important, including the explicit future **Mara Earned Romance & Partnership** lane, but the immediate product direction is to deepen the wider world.

Before implementing 1264, read:

- `docs/planning/PRODUCT_KANBAN.md`
- `docs/planning/product-kanban.json`
- `docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md`
- `expanded/README.md`
- `glulx/README.md`
- this handoff

## Current merged production state

The merge whistle was given for the full active stack. Every PR was rechecked for mergeability and review-thread state, then merged predecessor-first.

| Release | Train | PR | Final qualified head | Merge commit |
|---:|---|---:|---|---|
| 1258 | Mara Causal Biography & Shared Danger | #63 | `21fb81f98d9bb33479813b78aeed7f07a812968f` | `e50e81ddfd356cb13c60d61c641d3e7ce1225685` |
| 1259 | Mara Field Capability Discovery | #64 | `ad41258fdce55cf53fa065fbb597eaa5f4d36863` | `2cb9fd6ef66914c64c8c57d6b9b51767595c664c` |
| 1260 | Mara Lived Feeling, Rupture & Repair | #65 | `b1f561cb180f16c3a1495f97ba4777c9ea40a57c` | `2fe55b412818b2eabd9207fa91ed48f20b32ca41` |
| 1261 | Mara Anticipation, Worry & Protective Initiative | #66 | `220a3064985a46a1dcbc7def220dc06548ac41b8` | `56772b585f6a6f87e2a7365e5ca813af5b59beb8` |
| 1262 | Hostile Rooms & Reactive Threats / Dragon Hoard | #67 | `b736e78eae3521297f244d5df8ca6d9d2ec4dd2f` | `32ddee571a686411f672235aecffeab6b614bbb6` |
| 1263 | Ablative Protection & Equipment Consequence | #68 | `ce340dfd72e656172fac53c3037ce4c439f8223c` | `565d24d910e75ac6b28f1ce9d57de1506a642b62` |

Post-merge documentation then advanced `master` to the pre-handoff baseline listed at the top of this file.

## Locked production receipts

### Release 1258 — Mara Causal Biography & Shared Danger

- artifact: `zork1-glulx-mara-causal-biography-shared-danger.ulx`
- size: `445440` bytes
- checksum: `0xa0517751`
- SHA-256: `cfbe0e05ea2b70101aee2103bf07b80993ba479a41a905ad882102e6415d7263`
- original locked qualification: run `31772178488`
- final post-board-reconciliation exact-head qualification: run `31929719820` — green on `21fb81f98d9bb33479813b78aeed7f07a812968f`

### Release 1259 — Mara Field Capability Discovery

- artifact: `zork1-glulx-mara-field-capability-discovery.ulx`
- size: `453376` bytes
- checksum: `0xf9e9abf8`
- SHA-256: `e3a1adc99a6849b4703a3fe4338310a12c8d38c6d94b1aeab762199bb8e43d77`
- final locked qualification: run `31828682046` — green

### Release 1260 — Mara Lived Feeling, Rupture & Repair

- artifact: `zork1-glulx-mara-lived-feeling-rupture-repair.ulx`
- size: `457984` bytes
- checksum: `0x88c4c803`
- SHA-256: `81f686a1cd792b61f219e167fc0427e890151020d5b02f127cbd83d247c209c2`
- final locked qualification: run `31886864766` — green

### Release 1261 — Mara Anticipation, Worry & Protective Initiative

- artifact: `zork1-glulx-mara-anticipation-protective-initiative.ulx`
- size: `460544` bytes
- checksum: `0xcc424c84`
- SHA-256: `bc6f86c43803994143e5e188b8256d5ac681b51f1ab7711aeed27bbd4c6208a4`
- final locked qualification: run `31927382213` — green on `220a3064985a46a1dcbc7def220dc06548ac41b8`

The earlier red 1261 run was a real deterministic stale artifact lock after the final source/comment correction. It was fixed by repinning the manifest to the exact artifact produced by the current source, then rerunning the locked qualifier.

### Release 1262 — Hostile Rooms & Reactive Threats

- artifact: `zork1-glulx-hostile-rooms-dragon-hoard.ulx`
- size: `466432` bytes
- checksum: `0x8d167131`
- SHA-256: `2c0f63695388732af365d0b72b014348c7f1fb438dde0c5b49616ae8fdb81cf9`
- final exact-head qualification: run `31928781090` — green on `b736e78eae3521297f244d5df8ca6d9d2ec4dd2f`
- pinned Release 1261 staged source:
  - production: `03d6a7ae7f4b0cfd052b42fc1daaf60dee14fe0871a70dc08fd5f5bcf5d5eb45`
  - development: `13ae275fd7d4801bb443d03e3eae3af8674a984759ca86a8d6e54c0587447309`

### Release 1263 — Ablative Protection & Equipment Consequence

- artifact: `zork1-glulx-ablative-protection-equipment-consequence.ulx`
- size: `468480` bytes
- checksum: `0xf5898239`
- SHA-256: `a29a94fe607130c6bc2f86c140b6d3a2d7c065c9ceb80263a5dbfb51db3b3997`
- final exact-head qualification: run `31929398064` — green on `ce340dfd72e656172fac53c3037ce4c439f8223c`
- pinned Release 1262 predecessor:
  - artifact SHA-256: `2c0f63695388732af365d0b72b014348c7f1fb438dde0c5b49616ae8fdb81cf9`
  - staged production source: `0725e2c777b499356b2da6b13d3f3f6e37261abae2d59e780b6ea3d94c769fa2`
  - staged development source: `be8b33560edaadd2af2ea13b6d9545d3daa65beeee8775d066af305b57e0022d`

## Release 1258–1261: what Mara now actually has

The current Mara work should be treated as a usable authored substrate, not an invitation to add another relationship organ every train.

### 1258 — causal biography and shared danger

Mara can now carry specific lived facts through real shared danger:

- she can independently decide to test the real Dam maintenance ladder;
- she can be injured on it;
- her exact measured field rope can pass into Adventurer custody during peril;
- promise, rescue, exact rope return, broken promise, and abandonment become named facts;
- later reciprocal rescue can depend on those named facts rather than a relationship score;
- private discovery and later disclosure are distinct events.

### 1259 — capability biography

Capability emerges from experience instead of XP/perks:

- recovery can occur without erasing injury history;
- Mara can improvise a real rope/geometry movement solution;
- later reuse proves learning rather than rediscovery;
- the brass survey plummet remains physically hers;
- acoustic ranging emerges from her history and can later be deliberately reused;
- canonical puzzle authority remains with the original world rather than Mara becoming an automatic solver.

### 1260 — lived feeling, rupture, and repair

The authored causal chain is:

> event fact → appraisal → carried meaning → current feeling → choice → new history

Important behavior:

- knowingly repeated danger can produce concerned anger with fear underneath it;
- repeated recklessness can change later willingness to help;
- intentional harm creates betrayal/rupture and distance;
- apology records acknowledgment but does not reset the relationship;
- repair requires actual boundary respect and later changed behavior;
- repaired histories retain the attack, apology, boundary, evidence, and renewed choice as facts.

There is still no generic emotion engine, affection score, trust meter, or romance meter.

### 1261 — anticipation and protective initiative

Mara can prospectively appraise a known danger before another injury:

- real entry into the Dam context can trigger a warning before ladder commitment;
- protective initiative only claims preparation she can truthfully make with equipment she actually possesses;
- later action distinguishes heeding from knowingly overriding;
- heeding can create relief because rescue became unnecessary;
- unresolved rupture does not erase concern, but it preserves refusal of intimate bodily backstop behavior.

This is the intended pause point for major Mara-only machinery.

## Mara romance is still explicitly planned

Do **not** reinterpret the pause above as removing or downgrading the Mara love-interest direction.

The committed future lane is **Mara Earned Romance & Partnership**.

That future arc should support a genuine love-interest/partner path through:

- mutual attraction;
- explicit mutual choice;
- emotional and physical closeness;
- initiative from both people;
- boundaries;
- disagreement;
- rupture and repair;
- partnership grounded in accumulated lived history.

It should **not** become a dating-sim approval meter or force romance in histories that have not earned or mutually chosen it. Existing harm, repair, capability, memory, and choice remain real if romance later develops.

## Release 1262 architecture — Dragon & Hoard

Release 1262 begins the Shadowgate-derived design program with an original Zork-native situation rather than a copied Shadowgate room.

### Geography

The encounter adds an authored region branching from the real Timber Room:

> **Scorched Cleft → Dragon Gallery → Hoard Vault**

### Threat behavior

The treasure guardian dragon is a live territorial threat.

The central design rule is:

> ordinary interaction consumes opportunity because a dangerous being is physically present, not because Zork switched to generic combat turns.

Supported approaches include:

- retreat;
- offering a held canonical treasure as a one-item toll;
- using held treasure as bait under an authored counterweight grille and physically containing the dragon;
- using real Release 1257 Timber Room fire/smoke through the authored ventilation relationship to force the dragon away from the hoard arch;
- direct/ignored-warning confrontation ending in authored fire-breath death.

The hoard includes original non-score-bearing objects including the **ashen silver circlet** and **star-glass**.

### Important authority rules

- no dragon HP;
- no generic boss fight;
- no initiative/combat-turn framework;
- no hostility meter;
- no random attack rolls;
- no duplicate fire/smoke authority;
- real object custody matters for bargain/bait;
- canonical portable light/darkness remains real;
- existing Timber Room traversal remains authoritative.

### Review fixes that matter

CodeRabbit found that the first implementation incorrectly used `<VERB? PULL>`. Canonical grammar maps player `PULL OBJECT` to internal `V-MOVE`, so the encounter now checks `<VERB? MOVE>` instead of inventing `V?PULL`.

A separate possession-authority audit also caught that an `M-BEG` interception could otherwise make dragon bargaining/bait bypass normal held-object semantics. The final implementation requires actual Adventurer custody rather than teleporting named treasure through scene logic.

The final qualification strengthened this further by asserting actual custody of hoard objects in bargain, containment, and smoke histories rather than merely grepping descriptive text.

## Release 1263 architecture — physical ablative protection

Release 1263 deliberately stays encounter-specific.

A portable **iron-bound hide fire screen** exists in the Scorched Cleft.

The player can use the existing parser authority:

- `USE SCREEN ON ME`
- `USE SCREEN ON DRAGON`

No new `BLOCK` grammar was introduced.

The exact Release 1262 `DRAGON-BREATH-DEATH` consequence remains the hazard authority. Release 1263 intercepts that consequence only when the real held screen is deliberately braced and physically capable of doing so.

Material history is qualitative:

> **sound → scorched → warped**

- a sound braced screen absorbs one real blast and becomes scorched;
- a deliberately rebraced scorched screen can absorb another and becomes warped;
- a warped screen remains a real portable record of what happened but no longer honestly protects;
- an unheld, unbraced, or warped screen leaves the original lethal dragon consequence authoritative.

There is:

- no armor class;
- no equipment HP;
- no durability percentage;
- no random mitigation;
- no repair/crafting economy;
- no generic equipment-damage engine;
- no new VM globals.

The condition state lives in a compact mutable table because Release 1262 exposed that the Glulx/ZIL global budget is already extremely tight.

OpenHands reviewed the exact final Release 1263 head and assessed it as low risk, specifically noting the existing-parser reuse, compact table state, and encounter-local scope. Its CI caveat was satisfied by final green run `31929398064`.

## Important VM budget lesson

During Release 1262 qualification, adding five obvious dragon globals exceeded the available VM/global ceiling:

- defined globals reached `241`;
- allowed globals were `236`.

The dragon state was moved into a compact mutable table rather than shrinking the player-facing feature.

Release 1263 therefore started with compact table state from the beginning.

**Next-train rule:** do not assume another standalone global is cheap. Prefer existing authorities or compact state where appropriate, and let the compiler/qualification enforce the real budget.

## Important qualification lessons from 1262

Several red runs were useful and should not be forgotten:

1. **Canonical darkness is still real.** An early dragon test setup teleported into the underground encounter without bringing/light­ing the real brass lantern and was eaten by a grue. The fix was the test setup, not production darkness.
2. **Parser vocabulary matters.** A test transcript used `TAKE STAR-GLASS`; the actual lexer expects the object through supported words such as `GLASS` / `STAR GLASS`. Production object accessibility was correct; the transcript was wrong.
3. **World clocks advance through test/status commands too.** The Timber Room fire state legitimately advanced farther than an assertion expected before the status snapshot. The correct fix was to assert the real state at the actual observation turn.
4. **Custody assertions should prove state, not prose.** The final qualifier checks whether the Adventurer really holds the relevant hoard objects.
5. **Candidate red vs. bad red are different.** The release process may intentionally run once with unlocked identities to discover exact production hashes, but compiler, staging, gameplay, or authority failures are real blockers and must be fixed before pinning.

## PR review / GraphQL completion state

The merge pass followed the standing PR-completion discipline:

1. inspect all review threads;
2. verify every actionable finding against current code;
3. fix real issues on the correct branch;
4. reply to the relevant inline thread with the concrete fix;
5. resolve only genuinely fixed threads through GitHub review-thread GraphQL/connector;
6. recheck that no unresolved actionable threads remain;
7. require appropriate exact-head qualification/review evidence;
8. merge only after the explicit merge whistle.

Examples from this stack:

- #63: historical rope-custody, artifact-lock, normalize-serial path, and injury-persistence findings are resolved;
- #65: schema-8 migration-before-read and shell negative-assertion findings are resolved;
- #66: schema-9 anticipation migration guard is present before slot reads; all threads resolved;
- #67: canonical `PULL → V-MOVE` and final manifest-lock findings were fixed, replied to, and resolved;
- #68: CodeRabbit could not produce an inline review for the stacked non-default target; a manual authority pass and exact-head OpenHands review were used instead, with final CI green and zero review threads.

## The PR #63 hitchhiker incident

During the final merge audit, PR #63's branch unexpectedly advanced after its intended requalification had started. The extra history included unrelated commits and an OpenHands merge/reconciliation that did **not** belong in Release 1258.

The contaminated/extra head was preserved before repair:

- backup branch: `backup/pr63-unrelated-pushes-20260816`
- preserved head: `48fedb61f17d69ca065d89d73756344160454e4b`

The Release 1258 PR branch was restored to the audited head:

- `21fb81f98d9bb33479813b78aeed7f07a812968f`

Then run `31929719820` completed green on that exact restored head before #63 was merged.

**Do not delete or casually merge the backup branch.** Treat it as quarantined unrelated history that was deliberately excluded from the Release 1258–1263 merge stack. If anything from it is wanted later, inspect/cherry-pick deliberately by commit and purpose rather than merging the branch wholesale.

## README / player onboarding state

The documentation was deliberately reorganized before the final stack merge.

### `expanded/README.md`

This is now player-first.

A newcomer who has never played Zork or parser interactive fiction should encounter, before engineering details:

- what interactive fiction is;
- what the `>` prompt means;
- movement and object interaction examples;
- useful starter commands;
- what to do when the parser rejects phrasing;
- why `EXAMINE`, mapping, saving, and experimentation matter;
- spoiler-light first-play advice;
- what this Highly Extended edition changes as a game.

Only after that does the README discuss Glulx, release lineage, artifact identities, staging, reproducibility, and canonical engineering boundaries.

It also describes the current dragon and ablative-protection behavior through Release 1263.

### root `README.md`

Points players toward the Highly Extended/player-first material rather than assuming repository archaeology is the desired entry point.

### `glulx/README.md`

Was refreshed from its old early-release snapshot into the modern staged/qualified release lineage and current engineering model.

### Release 1263 README

`glulx/ablative-protection/README.md` now records final exact-head green qualification run `31929398064` instead of saying a final run is still required.

## Current board state

The human and JSON Kanban surfaces agree:

- merged production frontier: **Release 1263 — Ablative Protection & Equipment Consequence**;
- `CURRENT`: **empty**;
- immediate `NEXT`: **Release 1264 — Perilous Affordances / Let the Player Be Wrong**;
- Releases 1265–1272 continue the Shadowgate → Parser IF Adaptation Program;
- Mara Earned Romance & Partnership remains an explicit future lane.

## Shadowgate → Parser IF program

The committed sequence from the current frontier is:

1. **1264 — Perilous Affordances / Let the Player Be Wrong**
2. **1265 — Consumable Light & Graduated Darkness**
3. **1266 — Learned Magic as Parser Capability**
4. **1267 — Semantic Examination & Hidden Structure**
5. **1268 — Clue Chains & Knowledge-Gated Interpretation**
6. **1269 — Structural Difficulty Modes**
7. **1270 — Causal Death & Failure Feedback**
8. **1271 — Creature Encounters as Systemic Puzzles**
9. **1272 — Shadowgate-Style Macrostructure, Original Zork Region**

1262 and 1263 are already complete and merged.

The program is **not** permission to copy Shadowgate. It is a design-language exercise: extract interaction principles and rebuild original Zork-native play from first principles.

## NEXT: Release 1264 — Perilous Affordances / Let the Player Be Wrong

### Product thesis

Classic adventure games frequently protect puzzle-critical objects with meta-game refusals:

> You probably shouldn't do that.

Release 1264 should move selected authored situations toward:

> If the Adventurer can physically do it, Zork may allow it — and then the world carries the consequence.

The train should make **agency** deeper, not make the game arbitrarily cruel.

### What 1264 should demonstrate

Choose a substantial set of **existing real objects/situations** where the world currently refuses a physically plausible bad decision primarily because the object is useful later.

For selected cases, support consequences such as:

- breaking;
- burning;
- consuming;
- discarding into an unrecoverable or difficult location;
- damaging;
- misusing;
- sacrificing;
- making something temporarily unusable;
- changing a later route or puzzle state.

The exact set should be chosen only after inspecting current `master` and identifying high-value authored seams.

### Fairness rules

Perilous affordances are **not** parser cruelty.

A damaging/irreversible action should be fair because at least one of these is true where appropriate:

- the physical danger is obvious;
- prose gives sufficient warning;
- the player explicitly chose a destructive verb;
- an alternate route remains;
- a substitute exists;
- the failure is recoverable through actual world behavior;
- the irreversible consequence is itself interesting and legible.

Do not create softlocks that occur merely because the parser guessed the wrong noun or because a harmless-looking command secretly destroys progress.

### Architectural boundaries

Do **not** solve 1264 by building:

- a universal object-destruction engine;
- arbitrary object-pair combinatorics;
- a generic crafting/material simulator;
- a global item durability system;
- a generic undo-proof punishment framework;
- hidden “bad choice” counters;
- another audit/test architecture that outweighs the gameplay;
- a giant generic damage abstraction merely to support several authored cases.

Prefer direct composition with existing object, fire, custody, route, container, creature, and material authorities.

### Qualification target

Qualification should use real parser commands and demonstrate multiple qualitatively different histories, for example:

1. a physically destructive choice is truly allowed and leaves visible/persistent consequence;
2. a recoverable mistake can actually be recovered through the world rather than a test reset;
3. an alternate/substitute solution remains possible where the design promises one;
4. an honestly warned irreversible choice really stays irreversible for that play history;
5. canonical normal play still works when the player does **not** make the destructive choice.

Do not lock these exact scenarios before inspecting the live source. They describe the evidence shape, not mandatory objects.

### Good implementation question for the next chat

Before writing code, ask:

> **Which current Zork refusals are protecting the game from the player rather than protecting the player from the physics?**

That is the best hunting question for Release 1264.

## Standing engineering/product rules

Keep these non-negotiable unless Justin explicitly changes them:

- Build full product trains, not tiny slice-first MVPs.
- No stubs, TODO-only implementations, placeholders, no-ops, or dishonest tracking claims.
- Do not create machinery merely to audit existing audit/test machinery.
- Prefer player-facing consequence over framework building.
- Preserve canonical Zork solutions while adding physically credible alternatives.
- Use exact real object identity and real world state; avoid shadow authorities.
- Reusable objects should remain reusable where the same physical logic actually applies.
- Do not invent generic physics, crafting, companion, creature-AI, emotion, or romance engines just because several authored systems now exist.
- Natural player commands should be the primary qualification evidence.
- Test-only setup/status helpers may support evidence but must not become production gameplay.
- Respect VM/global constraints.
- Preserve release manifests, staged-source identities, artifact hashes, and qualification receipts.
- Inspect PR review threads before declaring a PR clean.
- Fix real findings, reply on their threads, and resolve them via GitHub GraphQL/connector only after the fix is real.
- Recheck the exact final head after substantive fixes.
- OpenHands can be used as off-Actions review evidence where useful; do not repeatedly summon it on an unchanged head.
- **Do not merge without an explicit merge whistle.** The previous whistle was consumed by the now-completed #63–#68 stack; future PRs need a new whistle.

## Immediate next-session procedure

1. Start from current `master`, not any old feature branch.
2. Read this handoff and the current board/Shadowgate program docs.
3. Re-query live `master` before changing anything; do not assume the SHA above is still current after this handoff commit.
4. Inspect current source for physically plausible actions that are currently meta-game refused.
5. Choose a substantial coherent 1264 train from concrete high-value cases.
6. Create a fresh 1264 branch from current `master`.
7. Implement player-facing consequences using existing authorities where possible.
8. Add natural-play qualification and staged artifact/provenance machinery consistent with current releases.
9. Open the PR, inspect reviews, fix/reply/resolve actionable findings, and requalify the exact final head.
10. Leave it open until Justin gives the next explicit merge whistle.

## Paste-forward stub

Use this in the next chat:

> **Continue `acrinym/zork1` from `docs/handoffs/ZORK_RELEASE_1263_POST_MERGE_HANDOFF_2026-08-16.md`. Releases 1258–1263 are merged; Release 1263 is the current production frontier. Read the handoff, current product Kanban, Shadowgate→Parser IF program, and current player/Glulx READMEs first. NEXT is Release 1264 — Perilous Affordances / Let the Player Be Wrong. Inspect live `master` before coding and choose concrete existing meta-game refusals where physically plausible bad choices should instead produce fair authored consequences. Preserve canonical solutions and existing authorities; no universal destruction/physics/crafting machinery, no stubs/TODOs, no recursive audit work. Qualify through real player commands. For PRs: inspect code comments, fix actionable issues, reply, resolve genuinely fixed threads via GitHub GraphQL/connector, recheck the exact final head, and do not merge without a new explicit merge whistle.**
