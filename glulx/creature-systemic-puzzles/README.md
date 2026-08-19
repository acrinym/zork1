# Release 1271 — Creature Encounters as Systemic Puzzles

Release 1271 makes several already-distinct living beings matter through their own authored motives, senses, attention, appetite, fears, possessions, territory, and memory rather than introducing a generic creature brain.

## Player-facing situations

- **Troll — attention and memory.** The existing one-use deception now creates a real passage opportunity. If the troll turns to inspect the invented emergency, the Adventurer may slip through one of the passages he was physically blocking. The troll remains alive, resumes guarding when attention returns, and remembers the trick, so the same lie is not a resettable key.
- **Cyclops — appetite and position.** Dropping the hot-pepper lunch is materially different from handing it over. The hungry cyclops lunges away from the stair to claim the food, creating one brief path upward. He remains awake and becomes canonically thirsty/agitated after eating the same peppers; the route trades a sleeping guardian for a still-dangerous one on return.
- **Grue colony — light aversion and reach.** Strong authored light drives the colony far enough back from the fissure mouths to expose a lost brass survey tube. It can be recovered only while bright light still commands the cracks; under weak/ember light, movement closes around the hand and the Adventurer withdraws. The item is optional, physical, and persistent once found.
- **Thief and dragon — distinct-behavior regressions.** Qualification proves the existing thief's valuable-gift/grudge behavior and dragon bargain behavior remain separate authorities rather than being normalized into disposition points.

## Authority boundaries

This release deliberately does **not** create `CREATURE_AI`, a universal disposition meter, an action matrix, generic hunger/fear tables, or a common NPC state object.

- Troll passage opportunity consults the existing `GLULX-ALT-TROLL-DISTRACTED`, `GLULX-ALT-TROLL-TRICK-USED`, `GLULX-ALT-TROLL-BOUND`, and `TROLL-FLAG` authorities.
- Cyclops appetite uses canonical `CYCLOWRATH`, `CYCLOPS-FLAG`, `I-CYCLOPS`, and the real `LUNCH`, plus one narrow temporary fact: whether the cyclops is physically away from the stair eating the dropped food.
- Grue recovery consults canonical qualitative light through `CONSUMABLE-CURRENT-LIGHT-LEVEL` and the existing colony reveal state. The survey tube's own visibility/location is its persistent recovery state.
- Thief and dragon code is byte-preserved from Release 1270.

## Qualification

Hosted qualification reruns locked Release 1270, verifies its exact production/dev source identities, stages only declared paths, smell-checks both profiles, compiles production/test stories, and drives natural player commands for troll passage/memory, cyclops food distraction and return consequence, bright/weak grue recovery, thief gift/grudge semantics, and dragon bargain regression.

The first candidate reaches the artifact-identity gate only after those histories pass. The exact artifact is then locked and requalified on the exact PR head.
