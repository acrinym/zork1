# Release 1269 — Structural Difficulty Modes

Release 1269 proves difficulty as **authored problem structure**, not a global numeric multiplier.

The first concrete situation is the existing Release 1262–1263 dragon encounter. The dragon, Scorched Cleft, Dragon Gallery, Hoard Vault, toll route, lure/grille route, smoke route, fire screen, parser vocabulary, and predecessor object/state authorities remain the same. The selected mode changes only specific structural properties of that authored situation.

## Player command

- `DIFFICULTY` — report the current structure and when it can still be changed.
- `DIFFICULTY FORGIVING`
- `DIFFICULTY CLASSIC`
- `DIFFICULTY EXACTING`

Aliases such as `GENTLE`, `STANDARD`, `NORMAL`, `HARD`, and `SEVERE` resolve to the same three explicit modes. Difficulty is mutable until the player enters the Scorched Cleft/Dragon Gallery. At that threshold it locks so the world cannot retroactively rewrite evidence or equipment history.

## Structural differences

### Forgiving

- adds one redundant, physically grounded clue in the Scorched Cleft: the scorch pattern records that the bend breaks the dragon's line of fire;
- allows two watched investigative actions instead of one before breath becomes unavoidable;
- if the player still hesitates too long without a braced screen, one forced retreat around that already-telegraphed bend is recoverable;
- begins with the existing fire screen sound.

### Classic — default

Preserves the Release 1268 product behavior exactly: existing evidence, one watched action, existing fire-screen condition, existing routes, and existing lethal consequence all remain unchanged.

### Exacting

- keeps Classic's evidence, parser language, routes, and one-action watch window;
- begins the **same existing fire screen** already visibly scorched, so it has one fewer protective survival before becoming warped.

There is no enemy-health scaling, parser-phrasing tax, universal difficulty scalar, random loot modifier, generic recovery system, or second dragon/fire-screen authority.

## Authority boundary

`structural_difficulty.zil` owns only mode selection, lock state, the Forgiving evidence/recovery rule, and the authored dragon watch limit. `dragon_hoard.zil` remains the canonical dragon threat/route authority and is patched to consult those exact structural decisions. `ablative_protection.zil` remains the canonical screen-condition authority and receives one narrow initializer for the selected structure.

## Qualification target

Hosted qualification reruns locked Release 1268 first, stages only four production paths, smell-checks production/dev sources, compiles a Glulx story, and drives natural command histories for:

1. mode selection, commitment, and post-threshold lock;
2. Forgiving redundant evidence + wider watch window + one recoverable retreat;
3. Classic parity with the existing lethal watch behavior;
4. Exacting's reduced fire-screen substitute through the screen's real condition authority;
5. canonical dragon toll route under Exacting, proving difficulty does not replace route authority.
