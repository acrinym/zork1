# Zork I — Release 1252 Post-Merge Handoff

**Date:** August 12, 2026  
**Repository:** `acrinym/zork1`  
**Default branch:** `master`

## Current production state

Release 1252 — **Earned Sequence Breaks & Route Mastery** — is merged.

- PR: `#57` — `Release 1252: Earned sequence breaks and route mastery`
- Source branch: `agent/earned-sequence-breaks-route-mastery-20260812`
- Final PR head before merge: `3ef41627c8f2354f0e98a83e27690c9fb21acf8c`
- Merge commit: `43a253a83a7349c9d3838e07488a90233f92410b`
- Locked Release 1252 production artifact SHA-256: `b376808be57262d3cec9c43d9bd2e8972e64362864bbe6a9bab682a0cc3334b6`

The Release 1252 product work itself was complete before the final documentation-only commits. The final locked story bytes did not change during the review-fix pass.

## Release 1252 player-facing result

Release 1252 made selected route mastery a consequence of real preparation rather than magic shortcuts.

### Great Canyon

- Reuses the existing Release 1236 physical canyon-rim rope authority.
- `SECURE ROPE`, `TIE ROPE TO CANYON RIM`, and `FASTEN ROPE TO RIM` converge on the same real rope state.
- A cinched brown sack can be lowered from Canyon View to the authored Rocky Ledge / `CLIFF-MIDDLE` stage.
- The sack can be hauled back up.
- The cargo knot and rim knot remain distinct physical truths.
- The canonical prepared Canyon `JUMP` rescue remains valid.
- No teleport verbs or parallel canyon-anchor state were added.

### White Cliffs

- The width check now sees an inflated magic boat even when the boat is nested inside a carried container.
- Hiding the inflated boat in a coffin does not magically shrink it.
- `FOLD BOAT` and `COLLAPSE BOAT` route through canonical deflation behavior.
- Ground-only deflation remains authoritative.
- Folded/deflated boat state remains a valid narrow-passage state.

### Qualification receipts

The final Release 1252 qualification before merge was green in both push and PR contexts:

- push run: `31600575657`
- PR-context run: `31600581216`

The CodeRabbit actionable review thread was fixed, replied to directly, and explicitly resolved through the GitHub review-thread GraphQL/connector path. The runtime qualification was expanded to cover the exact alternate rope and boat vocabulary plus the carried-container White Cliffs case.

One unrelated inherited workflow remained red:

- `Zork I Glulx Corpus-Coupled Causal Warning`
- run `31600581203`

That failure belongs to the old Release 1231 board contract and expects the obsolete always-occupied `CURRENT`/old board schema. It was intentionally **not** turned into another audit/test-repair train. Release 1252's own qualification was green and the PR was mergeable.

## Standing product rules

Continue to preserve these:

- Build product trains, not recursive audit machinery.
- Natural play is preferred over synthetic test-only surfaces.
- Do not replace canonical solutions merely because new physically credible alternatives are added.
- Use real object identity and real world state; avoid duplicate shadow authorities.
- No universal crafting matrix, generic physics simulator, random shortcut layer, or debug transport as product behavior.
- A described concrete noun should increasingly behave like a real part of the world when a player naturally tries to interact with it.
- Dangerous things should remain dangerous when the player deliberately experiments with them; do not protect the player from interesting, causally fair consequences.
- For PR completion: inspect review threads, fix actionable items, reply directly, resolve via GitHub review-thread GraphQL/connector, re-check unresolved threads, then merge only on an explicit merge whistle.

## Newly identified forest-density opportunity

A review of the existing forest code exposed a strong player-facing density gap. Existing forest support already includes forest/tree/songbird examine/listen behavior, ambient chirps, tree-room drop physics, a room-density path pseudo, and selected tree interactions, but many nouns already named by the prose are still not targetable or do not answer natural verbs.

High-value candidates discussed:

- `KNOCK TREE`, with location/height-sensitive sound.
- Forest-room `SMELL` responses for pine/resin/needles/undergrowth.
- `ROOTS` pseudo where the prose explicitly says roots hump above the soil.
- `NEEDLES` pseudo in forest rooms.
- `UNDERGROWTH` pseudo.
- `CANOPY` / light-shaft scenery.
- `SUNLIGHT` in Forest 1, including natural directional interaction where authored geography supports it.
- Mountains as more than a climb-only global noun.
- Pine and hemlock distinction rather than one generic tree response.
- Noise response to `SING`, `YELL`, or `SHOUT` in the forest.
- Forest-specific `PRAY` where appropriate.
- `SIT` / `REST` on roots or needled ground.

Important botanical/product note: the dangerous-plant idea should be implemented only where the actual world contains a genuinely hazardous plant. The design principle is the important part: if Zork presents a dangerous thing and the player deliberately gets intimate with it, the game may allow the bad decision and follow through causally.

A possible future train name discussed was **Forest That Answers Back** / **Described World = Interactive World**. This was discussion, not yet a canonical roadmap renumbering. The currently committed board still names the next numbered train as Release 1253 — Dam Survival & Prepared Rescue.

## Existing canonical next queue at merge time

The committed product board still orders:

1. Release 1253 — Dam Survival & Prepared Rescue
2. Release 1254 — Troll Disarm & Stolen Weapons
3. Release 1255 — Thief Retaliation & Sabotage
4. Release 1256 — Grue Ecology & Colony Reveal
5. Release 1257 — Fire, Smoke & Structural Consequences
6. Release 1258 — Mara Reciprocal Rescue & Shared Danger

If the forest-density train is promoted ahead of Dam Survival, update the human and machine roadmap deliberately rather than silently reusing a release number.

## Future world-time / weather arc discussed

A major future environmental arc was proposed but has **not yet been canonicalized into the committed roadmap**:

### Living Time & Daylight

A real world clock / coarse time-of-day state:

- early morning
- morning
- midday
- afternoon
- dusk
- evening
- night
- deep night
- dawn

Time should affect light, forest ambience, songbirds, shadows, outdoor visibility, artificial-light relevance, room overlays, rest, and `WAIT`, without becoming a chore timer that breaks canonical Zork.

### Living Weather

A bounded weather authority layered on top of world time, potentially including clear, cloud, overcast, drizzle, rain, heavy rain, thunderstorm, fog, wind, and other geography-appropriate states.

Weather should change real world behavior rather than emit decorative random messages: wet objects, slippery authored surfaces, exposed flame, smoke, visibility, sound, forest smell, water state, and so on.

### Severe Weather & Natural Disasters

Farther out, authored severe consequences should emerge from real state rather than random instant-death rolls: flooding, falling limbs/trees, rockfall/landslide, wildfire potential, dangerous winds, lightning exposure, and compounded structural damage.

The especially valuable interaction is delayed causality: something the player damaged earlier can later fail under storm conditions because the existing damage plus elapsed time plus weather actually justify it.

Provisional numbers `1259`–`1261` were discussed only conversationally. Treat those numbers as placeholders until the roadmap is intentionally updated.

## Far-horizon experiment docs merged with Release 1252

Two intentionally distant ideas are now preserved in repository docs.

### Opt-in Illustrated Zork

File:

`docs/planning/FAR_HORIZON_ILLUSTRATED_ZORK.md`

Core idea:

- The player explicitly opts in to external rendering and supplies an image-capable provider/API key.
- `DRAW` captures the exact authoritative scene at the current turn.
- Future variants may include `DRAW ROOM`, `DRAW <subject>`, and `DRAW LAST`.
- Zork determines reality; the image model only illustrates it.
- Scene data should include exact room, objects, custody, damage, lighting, time, weather, hazards, actor state, identity, and pronouns.
- Pronouns/identity must be structured facts, not model guesses.
- Render failure must never alter game state.
- Images may later live in a per-playthrough illustration gallery with provenance.
- Do not build this until stable world-state export/event infrastructure exists.

### Multi-Agent Zork experiment

File:

`docs/planning/FAR_HORIZON_MULTI_AGENT_ZORK_EXPERIMENT.md`

Core idea:

- Explicit future **experiment**, not normal production behavior.
- One AI controls the male Adventurer.
- One AI controls Mara, female.
- Separate AI agents can control the troll, thief, and other substantially overhauled NPCs.
- Each actor has independent observations, memory, plans, beliefs, goals, and private knowledge.
- No single omniscient LLM pretends to be everybody.
- Zork remains authoritative; agents propose actions and Zork accepts/rejects/resolves them.
- Experimental actors may receive intentionally unbounded routes across the expanded world.
- "Unbounded" means freed from production NPC route cages, **not** teleportation, immunity, or bypassing world rules.
- Geography, doors, darkness, ropes, boats, injuries, weather, inventory, custody, and hazards still matter.
- Agents may independently roam, pursue, hide, steal, bargain, rescue, sabotage, retreat, misremember, deceive, or collide with each other's plans.
- Keep this isolated from normal canonical saves and behavior.
- Do not build it merely because multi-agent APIs become easy; wait until the world is rich enough that turning several independent minds loose inside it is worth doing.

## Immediate next-session guidance

Start from merged `master`, not the old Release 1252 branch.

Before coding the next product train, inspect the current board and choose the intended product direction. The canonical queue says Dam Survival & Prepared Rescue; the newly discovered forest-density train is also exceptionally ripe and can be promoted deliberately if desired.

Whichever train is selected:

- create a new branch from current `master`;
- keep it player-facing and substantial;
- avoid test-for-test work;
- reuse existing authorities rather than creating parallel state;
- qualify through real gameplay;
- leave the PR open until an explicit merge whistle.

## Paste-forward stub

Use this in the next chat:

> Continue `acrinym/zork1` from the August 12, 2026 post-Release-1252 handoff at `docs/handoffs/ZORK_RELEASE_1252_POST_MERGE_HANDOFF_2026-08-12.md`. Release 1252 / PR #57 is merged at `43a253a83a7349c9d3838e07488a90233f92410b`; locked artifact SHA-256 is `b376808be57262d3cec9c43d9bd2e8972e64362864bbe6a9bab682a0cc3334b6`. Start from current `master`. Read the handoff first. Keep this PRODUCT, not an endless audit/test train. The canonical board says next is Dam Survival & Prepared Rescue, but the handoff also captures the newly identified Forest That Answers Back / Described World = Interactive World opportunity. Pick up the next full train from there. Do not merge without my explicit whistle. For PRs: inspect review threads, fix actionable items, reply, resolve with GitHub GraphQL/connector, re-check, then merge only when I say so.