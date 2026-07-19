# Expanded-edition design charter

## Product promise

Zork I Expanded should feel like the game players remember imagining: a coherent, peculiar underground world that notices reasonable ideas and replies in character.

It is not a replacement for historical Zork. It is a clearly labeled creative continuation built beside preserved Release 119 and optimized Release 120.

## Core rules

### 1. Make the world denser before making the map larger

An existing room gains value when its important nouns support observation, manipulation, sound, material consequences, and remembered change. New rooms should be optional or should connect naturally to established geography.

### 2. Preserve every canonical solution

No new route may invalidate, silently bypass, or mock the original solution. Alternate solutions are additional demonstrations of valid reasoning.

### 3. Reward ideas, not vocabulary guessing

When a player's intention is reasonable but the exact phrasing differs, add synonyms or route it to an existing action where practical. When the action cannot work, explain the relevant obstacle rather than pretending the idea was meaningless.

### 4. Failure should pay the player

A failed experiment should normally provide at least one of:

- comedy;
- world information;
- a clue;
- a persistent consequence.

Generic refusal remains appropriate only when no specific response would add value.

### 5. Objects have affordances, not crafting recipes

A rope may tie, lower, retrieve, or secure. Water may quench, reveal, carry, or satisfy thirst. That does not require a universal crafting economy. The game remains a command-driven adventure, not an inventory manufacturing system.

### 6. Characters remember meaningful treatment

Bribery, humiliation, mercy, deception, gifts, repeated songs, and bargains should matter when the character is capable of noticing them. Memory should create personality and consequences, not endless state bookkeeping.

### 7. Assistance is optional and diegetically modest

`HINT`, `RECAP`, `GOALS`, `EXITS`, `WHY`, and `USE` support players who need orientation. They must not issue complete walkthroughs on first request or replace experimentation.

### 8. New prose must belong in Zork

Prefer dry confidence, absurd institutional detail, understated danger, specific physical comedy, and Great Underground Empire bureaucracy. Avoid current internet slang, explicit references to modern fandom, or jokes whose only purpose is proving the author lives later than 1983.

### 9. State changes should remain visible

Damage leaves marks. Discoveries remain discovered. Creatures remember decisive encounters. Mechanisms report their state. The player's history should be legible in the world and in `RECAP`.

### 10. Expansion must remain testable

Every shipped train requires:

- exact-match staging patches;
- a structurally clean staged source;
- successful compilation;
- verified Release 121 identity and checksum;
- deterministic player-facing transcript coverage for representative behavior;
- documented limits for behavior not yet exercised end-to-end.

## Alternate-solution test

A proposed solution is suitable when all answers are yes:

1. Would a player reasonably think of it from visible information?
2. Does it use an object's material, a character's motivation, or a mechanism's state?
3. Does it require enough setup or risk to remain a puzzle?
4. Does it preserve the canonical route?
5. Can the result be explained in Zork's voice?
6. Can the state transition be tested and saved safely?

If the proposal is merely a shortcut, an omnipotent new verb, or an out-of-world convenience, it does not belong in the expanded edition.
