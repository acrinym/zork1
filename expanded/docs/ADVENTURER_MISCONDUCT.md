# Office of Adventurer Misconduct

Release 121 treats ridiculous but grammatically understandable experiments as part of exploration rather than parser errors.

The rule is simple:

> A foolish idea should receive a specific response whenever the parser can reasonably understand what the player meant.

## Flagship commands

The comedy layer explicitly supports experiments such as:

- `EAT NEST`
- `WEAR NEST`
- `SLEEP IN NEST`
- `LICK NEST`
- `CUT DOWN TREE WITH AXE`
- `HUG TREE`
- `MARRY TREE`
- `HEADBUTT TREE`
- `THROW SELF`
- `HURL SELF AT TROLL`
- `THROW TROLL AT LAMP`
- `KILL TROLL WITH SELF`
- `SACK TROLL`
- `PUT TROLL IN SACK`
- `THROW VOICE`
- `THROW VOICE AT MAILBOX`
- `THROW FIT`

The parser also recognizes a broader family of absurd social actions:

- hugging;
- licking;
- riding;
- marrying;
- apologizing;
- insulting;
- complimenting;
- dancing;
- juggling;
- headbutting;
- yelling at things.

## Zero-slot noun reuse

Z-machine version 3 permits only 255 objects, and the expanded world already uses the complete table. Release 121 therefore does not add fake SELF, VOICE, or FIT inventory objects.

Instead it extends three existing global parser objects without removing their original vocabulary:

- the original `ME` object already recognizes `ME`, `SELF`, and `MYSELF`;
- the lightweight blessings object additionally recognizes `VOICE` and `WORDS`;
- the existing hands object additionally recognizes `FIT`.

Their misconduct-aware action wrappers respond only to the relevant absurd verbs and otherwise fall back to original behavior. This preserves every real world object and every original synonym while allowing natural commands such as `THROW SELF AT TREE`, `THROW VOICE AT MAILBOX`, and `THROW FIT`.

These noun carriers cannot become collectible comedy items. They cannot be sold, scored, used to manufacture treasure, or inserted into the object tree as new inventory.

## Harmlessness boundary

Comedy actions do not:

- kill or remove an NPC;
- solve a puzzle;
- create treasure;
- consume required objects;
- alter scoring;
- bypass inventory, capacity, or route rules;
- make an absurd response necessary for completion.

When an ordinary valid command reaches the comedy grammar, it delegates back to the original Zork action. Food still uses normal eating behavior. Real weapons still use normal combat. Held objects still use normal container behavior.

## Physical continuity

Jokes should acknowledge the actual state of the world.

Examples:

- the nest reacts differently while the jeweled egg remains inside;
- attempting to sack the troll notices whether the player carries the brown sack;
- repeated forestry attempts escalate without pretending the tree has fallen;
- throwing a normal held object at scenery leaves it nearby;
- throwing the troll never makes him portable;
- throwing yourself never moves or injures the player.

## Voice

The prose remains dry, material, and bureaucratic. It should sound like the Great Underground Empire has a department responsible for documenting the player's misconduct.

Avoid:

- internet slang;
- contemporary meme phrasing;
- references that make the fiction feel like a modern game patch;
- random jokes unrelated to the attempted action.

Prefer:

- literal consequences;
- hostile arithmetic;
- administrative language;
- objects maintaining professional boundaries;
- architecture winning arguments through mass and foundations.

## Folly report

`FOLLY`, `NONSENSE`, or `MISCHIEF` opens the provisional report maintained by the Frobozz Office of Adventurer Misconduct.

The report lists only categories the player has actually discovered. It does not spoil unseen commands.

Tracked findings include:

- self-propelled ammunition;
- troll ballistics;
- thrown voice;
- thrown fit;
- bulk troll storage;
- using oneself as a weapon;
- nest cuisine;
- nest apparel;
- unauthorized forestry;
- proposed marriage to scenery.

## Extension pattern

New absurd interactions should follow this order:

1. Confirm that a human player could reasonably expect the parser to understand the wording.
2. Reuse an existing verb when possible.
3. Widen grammar only inside the expanded edition.
4. Route valid canonical uses back to their original action routines.
5. Preserve world state unless a physical consequence is safe, visible, and non-puzzle-breaking.
6. Add transcript coverage for representative syntax and state.
7. Record only notable discoveries in `FOLLY`; do not turn every joke into an achievement.
