# Zork I Future Concept Lanes

**Created:** July 30, 2026

This directory preserves substantial future ideas without retroactively mixing them into the completed House of Records implementation program.

The House of Records closed in Release `1230` with 12 trains and 96/96 beads complete. These files remain **concept lanes**, not hidden sub-beads, not an alternate Kanban, and not claims that implementation has begun. An idea may be promoted into a real product train only when its scope, dependencies, and place in the release lineage are deliberately chosen.

## The two lanes

### 1. `stalker-glulx-if/`

A separate-game concept: remake or reinterpret the experience of **S.T.A.L.K.E.R.: Shadow of Chernobyl** as a Glulx interactive-fiction world centered on lore, anomalies, artifacts, field observation, survival, persistent inhabitants, and the Zone as a readable system.

This lane does **not** become part of Zork's fiction, source tree, or House systems merely because its ideas were discovered while working on Zork.

### 2. `extended-zork/`

A future Zork-expansion concept lane: deepen the existing game into a much larger persistent world while preserving canonical objects, places, puzzles, and consequences.

Captured directions now include:

- a real museum and natural-history system;
- fish species and circumstance-driven varieties from different waters;
- donations, loans, documentation, exhibit upgrades, and provenance-aware plaques;
- revisitable text exhibits with optional Glulx TUI and 2D gallery presentation;
- cuisine built from fish, plants, fungi, pantry goods, magical ingredients, and creature-derived materials;
- slow hunger, distinct satiation, exertion-based stamina, regional food traditions, recipe discovery, and memorable failed dishes;
- choices between releasing, donating, preserving, selling, researching, or cooking rare specimens.

The cuisine direction is governed by a strict guardrail: food must create decisions, discoveries, humor, and stories—not repetitive eating chores or generic survival meters.

## Post-House transition

The dependency that kept these concepts outside implementation is now satisfied: the House of Records program is complete on `master`.

That makes **Highly Extended Zork** a valid candidate for the next Zork product phase. PR #31 still remains documentation-only. Actual implementation should begin on a fresh branch from the live post-House `master` only after Justin explicitly promotes the lane.

The first promoted train should deliver a complete playable museum beginning rather than an infrastructure-only foundation:

- an authored route to the first museum space;
- a real curator or intake authority;
- donation, loan, registration, and refusal behavior;
- a small set of canonical-safe exhibits with real custody and provenance;
- revisitable plaques and visible gallery change;
- parser-complete play and native save/restore;
- no fishing database, cuisine system, or generic collection checklist before the museum loop itself is fun and complete.

Fishing and ecology can then expand the museum's living collections. Cuisine, hunger, satiation, and stamina should follow once real ingredients, habitats, preparation locations, and provenance already exist.

## Separation rules

- Do not count these documents as House trains or House beads.
- Do not place S.T.A.L.K.E.R. concepts inside Zork's canonical world.
- Do not quietly turn an idea document into an implementation promise.
- Do not create sub-beads under completed House beads to absorb these ideas.
- Preserve canonical game authority when extending Zork: real objects, custody, score, puzzles, actors, and consequences remain authoritative.
- Build complete player-facing systems when a concept is eventually promoted; do not substitute documentation for product.

## Why this directory exists

The House of Records demonstrated that a classic parser world can support persistent evidence, provenance, physical records, visitors, dreams, event playback, damage, repair, and save/restore continuity. Those discoveries naturally produced ideas larger than the House program.

This directory gives those ideas a truthful home while preserving the completed House lineage and defining where the next product era may begin.