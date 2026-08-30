# Zork I Future Concept Lanes

**Created:** July 30, 2026  
**Expanded recovery:** July 31, 2026

This directory preserves substantial future ideas without retroactively mixing them into the completed House of Records implementation program.

The House of Records closed in Release `1230` with 12 trains and 96/96 beads complete. These files remain **concept lanes**, not hidden sub-beads. Live product queue: `docs/planning/PRODUCT_KANBAN.md`. Post-1286 museum / Mara / fish: `docs/planning/POST_1286_MUSEUM_MARA_AQUATIC_PROGRAM.md`. Illustrated / DRAW work stays parked.

## The two lanes

### 1. `stalker-glulx-if/`

A separate-game concept: remake or reinterpret the experience of **S.T.A.L.K.E.R.: Shadow of Chernobyl** as a Glulx interactive-fiction world centered on lore, anomalies, artifacts, field observation, survival, persistent inhabitants, and the Zone as a readable system.

This lane does **not** become part of Zork's fiction, source tree, or House systems merely because its ideas were discovered while working on Zork.

### 2. `extended-zork/`

A future Zork-expansion concept lane: deepen the existing game into a much larger persistent world while preserving canonical objects, places, puzzles, actors, score, danger, humor, and consequences.

Captured directions include:

- causal deaths that remember enabling actions, warnings, exact objects, and player knowledge;
- physical warning chains and knowledge-aware narrator culpability;
- deeper dam falls, swimming, drowning, encumbrance, machinery, and rescue preparation;
- troll stolen-weapon history and the possibility of being killed with the real lost sword;
- thief relationship escalation, sabotage, warning, ambush, and deliberate retaliation;
- grue ecology and one signature colony reveal;
- broader smoke, fire, collapse, machinery, suffocation, poison, magical, and self-inflicted consequences;
- richer NPC memory and interaction with player-created hazards;
- deeper rope, water, tool, sound, scent, damage, scenery, noun, and parser affordances;
- authored replayability and different histories behind the same canonical score;
- a physical House or Cellar expedition stash;
- bounded bottle filling, lighter refueling, food packing, preparation, and armor;
- `ZORK PLUS`, `SECOND EXPEDITION`, or `VETERAN EXPEDITION` postgame play with exact-object relocation rather than duplication;
- a real museum and natural-history system;
- fish species and circumstance-driven varieties from different waters;
- donations, loans, documentation, exhibit upgrades, and provenance-aware plaques;
- cuisine built from fish, plants, fungi, pantry goods, magical ingredients, and creature-derived materials;
- slow hunger, distinct satiation, exertion-based stamina, regional food traditions, recipe discovery, and memorable failed dishes;
- choices between releasing, donating, preserving, selling, researching, or cooking rare specimens;
- Shadowgate-style Glulx presentation, an illustrated state corpus, and a far-horizon 3D bridge;
- Ethical Zork as a separate optional edition that leaves normal dangerous Zork unchanged.

The recovered pre-House source map is preserved in:

```text
ideas/extended-zork/recovered-pre-house-directions.md
```

It points back to the two July 23 planning boards already present on live `master`:

```text
docs/planning/LIVING_ZORK_FUTURE_IDEAS_KANBAN.md
docs/planning/HOUSE_EXPEDITION_STASH_AND_ZORK_PLUS_KANBAN.md
```

The cuisine direction retains a strict guardrail: food must create decisions, discoveries, humor, and stories—not repetitive eating chores or generic survival meters.

## Post-House transition

The dependency that kept these concepts outside implementation is now satisfied: the House of Records program is complete on `master`.

That makes **Highly Extended Zork** a valid candidate for the next Zork product phase. PR #31 still remains documentation-only. Actual implementation should begin on a fresh branch from live post-House `master` only after Justin explicitly promotes one product family.

The museum remains fully retained, but it is not automatically the next train. Strong first-train candidates include:

1. causal death and warning foundations;
2. a physical expedition stash;
3. museum intake and the first gallery;
4. parser comprehension and deeper existing-world affordances.

These are sequencing alternatives. They are not four implementation trains silently started by this document.

## Separation rules

- Do not count these documents as House trains or House beads.
- Do not place S.T.A.L.K.E.R. concepts inside Zork's canonical world.
- Do not quietly turn an idea document into an implementation promise.
- Do not create sub-beads under completed House beads to absorb these ideas.
- Do not let the museum erase or replace earlier Living Zork and Zork Plus directions.
- Preserve canonical game authority when extending Zork: real objects, custody, score, puzzles, actors, warnings, and consequences remain authoritative.
- Keep Ethical Zork an explicit alternate edition or mode; normal Zork remains unchanged when it is disabled.
- Keep Onyx's private heartbeat, journals, belief graph, emotional state, and cognitive continuity outside the public game product unless separately and explicitly promoted.
- Build complete player-facing systems when a concept is eventually promoted; do not substitute documentation for product.

## Why this directory exists

The House of Records demonstrated that a classic parser world can support persistent evidence, provenance, physical records, visitors, dreams, event playback, damage, repair, completed-run archives, and save/restore continuity.

The earlier pre-House conversations had already imagined the next layers: a world that understands what the player attempted, what he knew, what warned him, which exact object or actor caused the result, how one expedition differed from another, and how the Great Underground Empire could become deeper before merely becoming larger.

This directory gives all of those directions a truthful home while preserving the completed House lineage and keeping each future product family separate until deliberately selected.
