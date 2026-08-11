# Underground Sensory & Physical World — Release 1249

Release 1249 carries the authored physicality work from the House and forest into the Great Underground Empire itself.

The train keeps the two rules established by Releases 1247–1248:

> **Make physically meaningful experimentation possible without making it the objective.**
>
> **Never psychoanalyze the player. Interpret the adventurer's action.**

This is not a cave generator or a universal physics engine. It is a deliberately authored early-underground circuit whose rooms, walls, air, acoustics, stairs, cracks, projectiles, and chasm edges behave more like places.

## The underground circuit

The first dense pass follows a route an ordinary player can actually walk from the House:

- Cellar;
- Troll Room;
- East-West Passage;
- Round Room;
- Loud Room;
- Damp Cave;
- North-South Passage;
- Chasm;
- Deep Canyon.

Descriptions distinguish close masonry, rough passage stone, cave-in dust, damp natural cave surface, long echoes, moving cool air, wet mineral smells, and the unusually aggressive acoustics of the Loud Room. Existing exits, puzzle gates, and room routines remain authoritative.

## Existing sensory verbs, existing objects

Release 1249 does not create a second sensory command framework.

- `SMELL AIR` and `LISTEN TO AIR` use the already-global `LUNGS`/air object and canonical `V-SMELL` / `V-LISTEN` actions.
- `EXAMINE`, `RUB`, `SMELL`, `LISTEN`, `KICK`, and `TAKE` against the existing global wall objects receive room-aware physical answers.
- Existing `STAIRS` and `CRACK` objects receive authored inspection and touch/listen/smell responses where those objects are already in room scope.

## Stone can be struck without becoming a shortcut

The real loose field stone and existing hard tools can strike an underground wall. A sufficiently hard impact leaves a persistent, scoreless cosmetic chip/score on **that room**, stored with the room object's existing flag capacity rather than a new global variable.

The damage is observable later and can be cleared only by the already-bounded dev/test environmental reset. It never opens a route, bypasses a lock, clears a cave-in, defeats the troll, or creates a new puzzle solution.

Ordinary thrown objects hit stone and remain in the current room rather than magically returning to inventory. The canonical bottle, jewel-encrusted egg, and brass lantern are explicitly left to their existing object authorities rather than being swallowed by this generic underground impact path.

## Loud Room and Chasm stay canonical

The Loud Room's special entry loop and `ECHO` solution remain untouched. Release 1249 only gives its ordinary room and post-puzzle sensory prose more physical texture.

The Chasm keeps its canonical pseudo-object authority. Objects deliberately thrown over it are still removed by the existing consequence path. `CROSS`, `LEAP`, and impossible `DOWN` attempts now explain the actual geometry instead of insulting or psychoanalyzing the player.

## Boundaries

- no universal physics or trajectory engine;
- no arbitrary object-pair matrix;
- no new global variables;
- no new passage opened by damaging walls;
- no alternate bottle, egg, lantern, troll, chasm, Loud Room, movement, death, or scoring authority;
- no score for destruction or absurdity;
- no production reset/cheat path;
- no reset of score, treasures, Mara history, or unrelated puzzle state;
- no recursive audit machinery;
- no TODO/stub/no-op product behavior.

## Qualification

The hosted qualification reconstructs the complete locked lineage through Release 1248 for production and dev/test, binds the exact staged Release 1248 source identities, smell-checks and compiles both Release 1249 trees, verifies Glulx checksums, and naturally plays the new circuit.

The natural play starts at West of House, takes the real loose field stone, enters through the real Kitchen window, retrieves the real brass lantern and sword, opens the real trap door, descends into the Cellar, defeats the canonical troll under the same fixed combat seed already used by Release 1242, solves the canonical Loud Room with `ECHO`, reaches the Damp Cave and Chasm, and exercises the new physical/sensory behavior without teleporting or fabricating objects.

A separate dev/test lap proves that an underground wall scar is cleared by the existing bounded environmental reset while production behavior remains persistent.
