# Forest Consequence Physicality — Release 1248

Release 1248 takes the physicality work out of the white House and into Zork I's forest.

The release philosophy is deliberately simple:

> **Never psychoanalyze the player. Interpret the adventurer's action.**
>
> If a reckless, absurd, destructive, or plainly fatal command is physically meaningful in an authored situation, prefer a world consequence over a generic refusal. Death is a game-state consequence, not evidence about the human at the keyboard.

That principle is already native to Zork I. Canonical `UP-A-TREE` and `CANYON-VIEW` both contain authored fatal `LEAP` outcomes. Release 1248 keeps those `JIGS-UP` authorities and gives them fuller physical narration rather than inventing a second death system.

## What this train adds

### A forest that behaves like a place

The Forest Path, surrounding forest, and climbable tree receive denser Infocom-style description and sensory responses. The large Path tree can be examined, felt, smelled, listened to, kicked, cut, and struck. A suitable tool can leave a visible scoreless scar, but the tree remains climbable and the canonical nest/egg journey remains intact.

### Compound sack projectiles

The brown sack is still the canonical sandwich bag. Release 1248 makes its contents matter when the whole container is thrown or dropped:

- a loaded sack hits with more authority than an empty one;
- an intact closed sack travels with surviving contents still inside;
- an open or already-torn sack can spill surviving contents at the landing point;
- a glass bottle can break **inside** the sack;
- a jewel-encrusted egg can become the existing canonical `BROKEN-EGG` inside the sack;
- dropping or throwing the sack from `UP-A-TREE` sends the container and its consequences to the Forest Path below.

There is no generic mass simulator. These are authored interactions among existing Zork objects whose combinations are especially meaningful.

### Trees, projectiles, and height

`THROW BOTTLE AT TREE`, `THROW EGG AT TREE`, `THROW NEST AT TREE`, ordinary objects thrown at the tree, and throws from`UP-A-TREE` now respect the material and location involved.

The bottle retains the canonical destruction end state: the bottle is removed and contained water is removed. The egg retains the canonical `BAD-EGG` / `BROKEN-EGG` authority. The release does not create shadow copies of either object.

### Rope uses the rope system already present

`TREE` becomes one more valid anchor for the existing recoverable material-rope authority. `TIE ROPE TO TREE` and `USE ROPE ON TREE` therefore gain physical meaning without a second knot or rope subsystem. Existing `UNTIE` and movement-limit behavior remain authoritative.

## Deliberate boundaries

Release 1248 does **not** infer depression, sadness, intent, instability, or any other mental state from commands. It also does not implement real-world self-harm procedures, knot instructions, suspension calculations, or injury tutorials.

Authored environmental death remains ordinary Zork: the adventurer can make a fatal choice, `JIGS-UP` ends the run, and the game continues to treat that as fiction and game state.

Other boundaries remain:

- no universal physics engine;
- no arbitrary object-pair matrix;
- no new globals;
- no score for destruction or stupidity;
- no permanent removal of the Forest Path tree or canonical egg route;
- no production reset/cheat verb;
- no recursive audit machinery;
- no TODO/stub/no-op scaffolding.

## Qualification

The release qualification stages the full locked Glulx lineage through Release 1247, applies Release 1248 to production and dev/test trees, runs the ZIL smell check, compiles both artifacts, verifies Glulx checksums, and naturally plays focused forest abuse laps covering:

1. a bottle inside a thrown closed sack;
2. a field stone spilled from an open thrown sack;
3. the jewel-encrusted egg broken inside a sack dropped from the tree;
4. persistent tree scarring and the canonical fatal tree leap.

The final production artifact is locked in `patch-series.json` after the first measured CI build.
