# Release 1235 — Cuisine, Hunger, and Stamina

Release 1235 makes the existing white-house Kitchen and canonical food matter without turning Zork into a constant survival meter.

## Authored meal loop

The player can already prepare the real hot-pepper lunch, slice the real garlic, and warm food on the temporary cast-iron range. Release 1235 connects those actions:

1. place and prepare the lunch on the worktop;
2. slice the garlic with a real blade;
3. `COMBINE LUNCH WITH GARLIC`;
4. optionally warm the lunch on the range;
5. eat the resulting authored meal.

The garlic is used as seasoning but remains the canonical puzzle object. No meal copy or ingredient inventory is created. The canonical lunch is consumed only when the player eats it.

## Bounded exertion

Selected strenuous actions—climbing and leaping—accumulate strain. Ordinary movement, parser mistakes, inventory management, waiting, and the passage of turns do not create hunger.

- early strain produces feedback but does not block play;
- repeated exertion can make the player situationally hungry;
- `REST` recovers enough breath to continue even without food;
- a prepared meal clears strain and grants a small number of supported exertions;
- there is no starvation death, permanent debuff, or mandatory meal schedule.

`CHECK APPETITE` reports the current bounded state without exposing a numerical survival HUD.

## Boundaries

This train adds no:

- hunger increase merely because turns pass;
- thirst or real-time decay;
- generic crafting grid or recipe economy;
- arbitrary ingredient combinations;
- food-generated score or puzzle completion;
- duplicate lunch, garlic, or meal object;
- stamina check on every action;
- House hierarchy reopening or S.T.A.L.K.E.R. coupling.

## Qualification direction

Hosted qualification will stage exactly over locked Release 1234, compile and assemble the real story, and run a complete interpreter route that prepares and seasons the canonical lunch, creates exertion strain, rests, eats the meal, verifies recovery, and proves the garlic remains available while the lunch is consumed.
