# Player Ingenuity / Systemic Workarounds — Release 1250

Release 1250 changes the question Highly Extended Zork asks when a player notices that two established facts ought to interact.

> **Canonical puzzles describe a reliable intended solution. They do not define the only physically valid solution.**

This train does not add a universal solver. It selects three real pieces of friction and lets existing world properties matter deliberately.

## 1. Hearing protection is hearing protection

A battered pair of industrial earmuffs can be found in the Attic before the first underground expedition.

They are one real portable object with reversible worn state. When worn:

- the Loud Room remains violently loud, but the adventurer is protected enough to remain in the room and use the ordinary parser;
- peak Dam noise no longer forcibly ejects the adventurer from the Loud Room;
- canonical `ECHO` still changes the room through the canonical `LOUD-FLAG` / bar authority;
- `LISTEN` is muffled elsewhere too, including quiet contexts where the protection is a disadvantage rather than a key;
- removing or dropping the earmuffs restores ordinary hearing.

The earmuffs live in the Attic rather than the Maintenance Room because the live map places the Maintenance Room downstream of the Loud Room through Deep Canyon and Dam. An alternate solution that can only be acquired after the puzzle it bypasses is not useful player ingenuity.

## 2. A loose stone can be a wedge

Release 1246 already established one real fist-sized field stone. Release 1250 lets the player put, push, or slide that same stone under the open Living Room trap door.

On the next descent:

- the canonical automatic closure still happens physically;
- the door strikes the wedge instead of reaching the floor;
- the existing `OPENBIT` remains true, so the canonical Cellar `UP` exit remains usable;
- the stone stays physically in the Living Room;
- taking the stone back releases the wedge and restores ordinary automatic closure on a later descent.

No duplicate prop, shortcut flag, score, or generic door-jamming system is created.

## 3. Containers reduce package count

The Studio chimney already allows a climb only when the adventurer has the brass lantern and no more than a small number of directly carried packages. The brown sack already owns its actual child objects.

Release 1250 recognizes the physically meaningful combination: smaller gear packed inside an intact loaded sack remains one direct carried package for the narrow climb. The underlying carry test is unchanged; the game now deliberately acknowledges the container doing useful work.

This does not increase sack capacity, erase item identity, or create an abstract packing system.

## Qualification philosophy

Release 1250 requalifies the complete locked Release 1249 lineage first, stages production and dev/test from the resulting exact source identities, smell-checks and compiles both trees, verifies Glulx checksums, and then exercises the new behavior through ordinary map travel.

The natural route:

1. enters the House normally;
2. retrieves and wears the real Attic earmuffs;
3. packs them into the real brown sack;
4. wedges the real trap door with the existing field stone;
5. proves the Cellar return route remains open;
6. reaches the Studio naturally and climbs its chimney with the loaded sack;
7. retrieves and wears the earmuffs again;
8. defeats the canonical troll;
9. reaches the Loud Room normally;
10. remains functional under the noise, listens through the protection, and still solves the canonical `ECHO` puzzle;
11. verifies hearing tradeoffs outside the first room.

Separate production routes prove removing the wedge restores the original trap-door slam and that canonical `ECHO` still works without hearing protection.

## Boundaries

- no universal equipment framework;
- no universal door-propping or packing framework;
- no crafting recipes or ingredient economy;
- no arbitrary object-pair matrix;
- no generic physics simulator;
- no new score for alternate solutions;
- no deletion or replacement of canonical `ECHO`;
- no duplicate field stone, sack, bar, lantern, trap door, or route authority;
- no RNG gate or long fetch chain;
- no production debug shortcut;
- no recursive audit machinery;
- no TODO/stub/no-op product behavior.
