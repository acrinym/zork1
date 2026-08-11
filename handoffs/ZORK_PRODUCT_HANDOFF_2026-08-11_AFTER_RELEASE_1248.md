# Zork I Product Development Handoff — After Release 1248

## Purpose

This is the canonical continuation handoff for the next Zork I product-development chat after **Release 1248 — Forest Consequence Physicality**.

Do **not** treat this document as a frozen substitute for live GitHub state. The first action in a new chat should be to query the repository for the current `master` head and open pull requests, then use this handoff to recover product intent, workflow rules, recent context, and the next likely train.

The detailed history is already in the repository. Do not recreate a giant changelog from memory. For recent archaeology, inspect the merged PRs and release directories identified below.

---

## Repository coordinates

- Repository: `acrinym/zork1`
- Default branch: `master`
- Public repository: yes
- GitHub Actions / CI: allowed
- Latest product PR at handoff: **#52 — Release 1248: Add forest consequence physicality**
- PR #52 merge commit: `032fda633c8faacc5db5900a5c2812d336d1d4a6`
- Open PRs immediately after that merge: **none**

This handoff is committed directly to `master` after the Release 1248 merge, so its own commit necessarily becomes newer than the merge commit above. Always query live `master` rather than attempting to infer the current head from a self-referential document.

---

## Operating rules — preserve these

Justin develops Zork in **trains**: substantial, human-facing product passes rather than tiny slices.

### Merge discipline

- **Do not merge future product PRs unless Justin explicitly gives the merge whistle.**
- Create ready/non-draft PRs unless there is a genuine reason not to; Justin is the only developer.
- Before any merge, re-query the PR head and merge using the exact current SHA.
- If review comments exist:
  1. inspect the actual current code;
  2. fix only actionable findings that are still valid;
  3. reply directly on the relevant inline review thread with what changed or why the proposed change is wrong;
  4. resolve the GraphQL review thread;
  5. requalify the current head;
  6. merge only after the explicit whistle.
- Do not blindly satisfy a reviewer by duplicating existing authorities. Prove the current behavior first.

### Product-development discipline

- Prefer **substantial product trains**, not “MVP slices.”
- No TODO-only work, stubs, placeholders, no-op scaffolding, or pretend product behavior.
- No recursive audit/test/review machinery whose main purpose is inspecting Zork itself.
- Do not “audit the audit to audit the audit.”
- Tests and qualification exist to prove actual player-facing work, not to become the product.
- Use existing game authorities rather than parallel replacements.
- Preserve physical object identity where possible: one real troll, one real egg, one real bottle, one real rope, one real treasure, etc.
- Canonical Zork must remain playable as ordinary Zork. Extended behavior should deepen the world, not make experimentation mandatory.
- Natural play is a first-class development technique. Launch the compiled game and type plausible player commands rather than validating only synthetic setup paths.
- When a natural-play transcript exposes an unrelated regression in finished work, repair the real seam rather than working around it in the test.
- GitHub Actions are permitted for this repository.

---

## Product identity that must not drift

### Zork / adventurer / narrator

- The **adventurer is unnamed**.
- **Zork is the parser/interface**, not the adventurer.
- Zork should not be treated as a character possessing or speaking through the adventurer.
- Current ordinary Zork remains second-person interactive fiction.
- The repository separately documents experiments for first-person, normalized second-person, third-person, and interactive storybook / choose-your-own-adventure editions. Those are isolated presentation experiments, not authorization to rewrite mainline narration into a universal perspective framework.

See merged PR **#47 — Document Zork narrative perspective experiments** for the experiment boundaries.

### Mara Tallow

- Mara is a **companion in disguise**, not a museum curator.
- She is one physical human actor with her own equipment, work, custody, judgment, boundaries, location, and evidence-limited memory.
- Do not turn her into a chatbot, follower framework, party system, combat pet, inventory mule, approval meter, generic romance engine, or omniscient narrator.
- Her reactions should depend on what she physically witnessed, learned, discussed, read, measured, or handled.
- Existing Mara history is product state; do not casually reset or bypass it.

For current Mara implementation history, merged PRs **#46, #48, and #49** are the useful recent anchors.

---

## Current physicality philosophy

The extended-game direction is now explicit:

> **Make it severely possible to do dumb, reckless, experimental, pointless, destructive, creative, and physically plausible things in Zork I without making those things the point of the game.**

Release 1248 sharpened that into a second rule:

> **Never psychoanalyze the player. Interpret the adventurer’s action.**

That means:

- If a command is absurd but understandable, understand it.
- If an action is impossible, narrate the physical reason specifically.
- If an action can visibly damage something without breaking the canonical journey, let the world remember the damage.
- If an authored situation makes a reckless action fatal, game death is a valid consequence.
- Do not infer depression, instability, sadness, intent, or other mental states from a fictional command.
- Do not replace consequence with generic moralizing refusal.
- Do not create real-world self-harm tutorials, injury calculations, knot instructions, or other procedural harmful guidance. Zork death remains authored fictional game state under canonical `JIGS-UP`.
- Humor should usually arise from serious Infocom-like narration taking an absurd command seriously rather than turning the entire game into a comedy conversion.

The physicality architecture is deliberately **authored, object-specific, and authority-preserving**. Do not build a universal physics engine or an arbitrary object-pair simulator just because several physical interactions now exist.

---

## Recent product arc — where to look, not a duplicate changelog

The fastest way to understand the current game is to inspect the following merged PRs and release directories.

### Release 1245 — Creative Natural Play

- PR **#49 — Release 1245: Repair creative natural-play seams**
- Release directory: `glulx/creative-natural-play/`

Important theme: ordinary hostile/absurd/Mara commands exposed personhood, parser, carried-object, and witnessed-death seams. Natural play became the primary integration detector.

### Release 1246 — Environmental Destruction

- PR **#50 — Release 1246: Add destructible environment with dev reset**
- Release directory: `glulx/environmental-destruction/`

Important theme: real field stone, destructible mailbox, shattered Kitchen window, persistent breakage, separate bounded dev/test reset, zero new global slots.

### Release 1247 — Narrative Physicality

- PR **#51 — Release 1247: Deepen narrative physicality across the House**
- Release directory: `glulx/narrative-physicality/`

Important theme: richer Infocom-like House narration plus authored physical/sensory responses. Natural play also repaired an inherited Mara parser dispatch bug that hijacked ordinary object actions.

### Release 1248 — Forest Consequence Physicality

- PR **#52 — Release 1248: Add forest consequence physicality**
- Release directory: `glulx/forest-consequences/`

Important theme: take the same philosophy out of the House and into the forest, with compound containers, height, tree damage, rope anchoring, richer forest prose, and authored death consequences.

If detailed “what happened recently?” analysis is needed, read PRs **#49–#52** and those four release directories instead of relying on this handoff to duplicate hundreds of implementation details.

---

## Release 1248 state worth knowing before touching the next train

Release 1248 is merged and its final production artifact is locked.

### Locked production artifact

- File: `zork1-glulx-forest-consequences.ulx`
- Serial: `260811`
- Glulx version: `0x00030103`
- Size: `408320` bytes
- Checksum: `0x50b07f00`
- SHA-256: `efd06838a2196144435643f636ec7cafe712fca2ea07089c08c998464ac93d56`

### Player-facing capabilities established by 1248

- Forest / Forest Path / Up a Tree receive denser Infocom-like narration and sensory affordances.
- The large Forest Path tree is a real authored interaction surface: examine, touch/rub, smell, listen, kick, cut, impacts, persistent cosmetic scar.
- A suitable tool can scar the tree without turning it into lumber or destroying the canonical nest/egg journey.
- The brown sack can carry absurd cargo combinations that matter physically on impact.
- Closed sack: surviving contents stay together.
- Open/torn sack: surviving contents can spill at the landing point.
- A bottle can break **inside** a thrown sack while canonical bottle/water end state remains authoritative.
- The jewel-encrusted egg can become the real canonical broken egg from a compound sack fall.
- Height matters for authored tree interactions.
- `TREE` is now a valid anchor for the existing material-rope authority.
- Both `TIE ROPE TO TREE` and `USE ROPE ON TREE` were qualified naturally, including inherited movement restraint and `UNTIE` recovery.
- The dormant fatal `TREE-ROOM` leap path was repaired; `JIGS-UP` remains the sole death authority.

### Canonical authorities that Release 1248 intentionally reuses

Do not create competing versions of these unless a future product requirement truly demands it:

- `JIGS-UP` — death authority.
- `TREE-ROOM` — canonical Up-a-Tree room behavior, including ordinary `DROP` handling.
- `BAD-EGG` / `BROKEN-EGG` — egg destruction authority.
- canonical bottle destruction/removal semantics.
- existing Material Consequences rope anchor / movement-limit / `UNTIE` authority.
- existing bounded dev/test environmental reset authority.
- existing object custody and parser dispatch.

---

## Recent traps and lessons — high value for the next chat

These are not merely anecdotes; they are integration facts discovered by actual play.

### 1. Do not duplicate `TREE-ROOM` drop handling

A reviewer initially suggested adding parallel `DROP` behavior to the Release 1248 forest hook. That was wrong.

Canonical `TREE-ROOM` already owns ordinary `DROP` from Up a Tree, including the nest/egg cases and moving other droppable objects to `PATH`. Release 1248 should allow those commands to fall through to that authority.

The reviewer withdrew the finding after the source authority was demonstrated.

### 2. The sack still contains garlic after `TAKE LUNCH`

In the closed-sack bottle qualification, removing `LUNCH` does **not** empty the sack: canonical `GARLIC` remains inside. Release 1248 deliberately expands sack capacity so the bottle can coexist with the garlic.

When the bottle breaks inside the sack, garlic survives; therefore “whatever survived the impact still inside” is a real tested path, not a false assertion.

The reviewer withdrew that finding after runtime/source evidence.

### 3. Natural play exposed the unreachable tree death

The canonical `TREE-ROOM` `LEAP` clause existed but had accidentally become structurally nested inside the `DROP` handler. As a result, ordinary jump behavior could bypass the intended authored fatal branch.

Release 1248 repairs that dormant branch while preserving canonical `DROP` behavior. Do not regress the repair by rewriting the whole room casually.

### 4. A dark Attic is actually dark

The first rope qualification tried to walk into the Attic and take the rope without a light. Naturally, the adventurer could not see it.

The corrected qualification retrieves the real brass lantern from the Living Room, turns it on, then enters the Attic and takes the real rope.

Keep doing this kind of qualification: satisfy the actual game world instead of inventing test-only shortcuts.

### 5. Provenance checks should bind the real staged predecessor

Review correctly found that checking only `release == 1247` was insufficient to authenticate the staged base. Release 1248 now binds immutable Release 1247 staged-source identities before applying its patches.

Preserve that lineage discipline for future release staging, but do not turn it into generalized audit bureaucracy.

### 6. Review comments are hypotheses, not commands

Release 1248 had three inline CodeRabbit findings:

- one real provenance issue — fixed;
- two incorrect behavior assumptions — disproved with canonical source/runtime evidence and withdrawn.

The correct workflow is: inspect, reproduce, fix if valid, otherwise explain with evidence. Do not damage product architecture to satisfy an automated comment mechanically.

---

## Current review / CI state at handoff

Before PR #52 merged:

- Current PR head was `05f43f0de74a9bc21dd976c1e1e91237f41852e4`.
- `Zork I Forest Consequence Physicality` was green.
- `Zork I House of Records Roadmap` was green.
- All three inline CodeRabbit threads were resolved.
- A requested fresh CodeRabbit full review of the final composition was service-rate-limited. That was an external review-quota condition, not a failing repository check.
- CodeRabbit pre-merge checks that did run were green.
- Justin then explicitly authorized merging all open PRs.
- PR #52 merged successfully as `032fda633c8faacc5db5900a5c2812d336d1d4a6`.

When resuming, query live Actions state rather than assuming this snapshot remains current.

---

## Mainline design boundaries accumulated across recent releases

These are especially easy to violate while extending physicality:

- Do not build a universal physics engine just because many objects now have material behavior.
- Do not build a universal crafting system unless explicitly requested.
- Do not build an arbitrary object-pair reaction matrix.
- Do not make destruction the objective or award score for stupidity.
- Do not permanently destroy irreplaceable canonical routes without an authored recovery path.
- Do not replace canonical combat, death, puzzle, treasure, container, actor, or movement authorities with “extended” duplicates.
- Do not create duplicate physical specimens or substitute objects when the real canonical object exists.
- Do not introduce production cheat/reset verbs; bounded dev/test reset is separate and narrow.
- Do not create meta-systems whose purpose is observing or auditing Zork itself.
- Do not flatten the game into generic generated prose. Rich narration should remain authored and place/object aware.

---

## What “richer Infocom style” means here

The target is not verbosity for its own sake.

Good expanded narration:

- notices material, position, wear, light, smell, sound, distance, temperature, weight, and prior damage where those details matter;
- changes when the physical state of the room changes;
- gives impossible actions specific physical reasons;
- can be funny because the narrator treats absurdity with dignity;
- preserves Zork’s terseness where terseness is stronger;
- does not reveal puzzle solutions merely because description is richer;
- makes revisiting a damaged or altered room feel observably different.

The House in Release 1247 and Forest Path in Release 1248 are the immediate reference points.

---

## Recommended next product train: Release 1249

### Strong default direction

**Release 1249 — Underground Sensory & Physical World**

Release 1248 completed the first serious surface/forest proving ground. The natural continuation is to make the Great Underground Empire itself feel materially present without creating a universal simulator.

A substantial 1249 could combine several authored underground dimensions in one coherent train:

### Underground room density

Deepen a meaningful cross-section of underground rooms with state-aware Infocom-like imagery:

- rough/granite/brick/constructed stone distinctions;
- dust, grit, dampness, soot, rust, roots, mineral surfaces;
- temperature and moving/stale air;
- echoes and acoustic differences;
- dripping or flowing water where actually present;
- darkness and light-source behavior reflected in prose;
- evidence of prior passage or damage where the game already owns that history.

### Sensory affordances

Expand `LISTEN`, `SMELL`, `RUB`/touch, and careful examination for selected underground rooms/objects using existing verbs and authorities.

Do not create a second sensory-verb framework merely for this train.

### Stone / walls / doors / openings

Author physically meaningful interactions for selected existing doors, walls, passages, openings, hinges, boards, locks, or stone surfaces:

- tool/material-appropriate impacts;
- resistance that explains *why* something does not yield;
- safe cosmetic scars/debris where appropriate;
- no bypass of canonical lock/key/puzzle authority simply because the player owns an axe or rock.

### Projectiles underground

Continue the Release 1248 rule that thrown objects should have understandable destinations and consequences rather than teleporting back into inventory.

Select important rooms/targets and author them deliberately. Do not generalize into a trajectory simulator.

### Height / ledges / pits / water

Where canonical geography already provides meaningful height, falls, water, chasms, ledges, shafts, or drops, let the location matter to thrown/dropped objects and reckless movement choices.

Preserve existing canonical death/puzzle authorities.

### Persistent environmental memory

Use existing state capacity/authorities where safe for a limited number of meaningful scars or debris states. The environment should remember significant experimentation, but not every tap of every wall.

### Qualification philosophy

Qualify by actually navigating from West of House into the underground and performing the new actions with canonical equipment. Do not teleport or fabricate objects just to make the test convenient.

A good 1249 natural-play route should be capable of discovering integration regressions in old systems, just as 1247 and 1248 did.

---

## Other legitimate future directions

If Justin redirects away from the underground, these remain aligned with current intent:

- doors / hinges / locks / openings as a dedicated physicality train;
- projectile expansion across more authored targets;
- fire and heat consequences;
- water flow / wetness / drying where existing game objects support it;
- rope interactions with more real anchors and geometry;
- container and furniture physicality;
- machinery and Dam physicality;
- richer NPC reactions to visible destruction;
- Mara awareness of physical environmental changes she actually witnesses;
- debris / repair / persistent room-state narration;
- broader parser synonym saturation for player-visible nouns;
- narration-density passes across untouched canonical rooms;
- isolated narrative-perspective experiments documented in PR #47, but only when explicitly chosen as an experiment.

---

## Resume protocol for the next chat

The next chat should begin approximately like this:

1. Query `acrinym/zork1` live state.
2. Confirm default branch and current `master` head.
3. Search for open PRs; do not assume there are none merely because this handoff says so.
4. Read this handoff from `handoffs/ZORK_PRODUCT_HANDOFF_2026-08-11_AFTER_RELEASE_1248.md`.
5. Inspect merged PRs #49–#52 and the recent release directories only as deeply as the next task requires.
6. If continuing the suggested direction, branch from **live `master`** for Release 1249 Underground Sensory & Physical World.
7. Build a substantial player-facing train, not a slice.
8. Naturally play/qualify the real game.
9. Open a ready PR.
10. Address valid inline reviews directly and resolve threads.
11. Keep the PR unmerged until Justin explicitly gives a new merge whistle.

---

## Short version for orientation

Zork I has moved from “extended features attached to canonical Zork” toward a more coherent **living physical interactive-fiction world**.

The current direction is not “simulate everything.” It is:

- understand more plausible player language;
- let actual objects matter;
- let place/material/history matter;
- keep canonical puzzle and object authorities intact;
- make absurd experimentation produce authored consequences;
- make the prose richer without ceasing to sound like Zork;
- make natural play the judge of whether all these finished systems actually coexist.

Release 1248 proved that philosophy in the forest.

The strongest next move is to take it underground.
