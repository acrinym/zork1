# Release 1263 — Ablative Protection & Equipment Consequence

Release 1263 takes the next Shadowgate → Parser IF lesson and makes it Zork-native: **protection should work because a physical object takes the consequence for you, and the object should remember what happened to it.**

The showcase is intentionally narrow and authored around Release 1262's real treasure-guardian dragon rather than introducing a universal armor system.

## Player-facing contract

A portable **iron-bound hide fire screen** now rests in the Scorched Cleft before the Dragon Gallery.

The player can carry it into the dragon encounter and deliberately brace it using the already-existing parser grammar, for example:

```text
USE SCREEN ON ME
```

or, while facing the guardian:

```text
USE SCREEN ON DRAGON
```

Those commands do not cast a protection spell or set an invisible armor score. They put a real held object between the Adventurer and a known source of fire.

When the exact Release 1262 dragon-breath consequence occurs:

1. a **sound** braced screen takes the blast, letting the Adventurer survive while the hide blackens, shrinks, and smokes;
2. the resulting **scorched** screen can be deliberately braced again, but a second blast warps the iron rim and burns the hide down further;
3. the resulting **warped** screen remains a real portable object and a record of what happened, but its geometry no longer honestly supports the same protection claim;
4. an unheld, unbraced, or already-warped screen does not silently grant protection, so Release 1262's original lethal dragon-breath authority remains in force.

`EXAMINE SCREEN` reports those physical condition changes in prose. There is no durability number to inspect.

## Why this matters

The important mechanic is not “the player has armor.” It is:

> **the equipment bears the physical history of the event it prevented from reaching the player.**

That creates useful consequences without a stat layer. A later player can look at the same object and understand that it has already been through fire.

## Architectural boundaries

Release 1263 deliberately adds none of the following:

- armor class;
- hit points for equipment;
- a durability percentage;
- a generic `BLOCK` action;
- random mitigation rolls;
- a repair bench or crafting economy;
- a universal equipment-damage engine;
- a generic inventory-wide resistance system.

The screen's three authored material conditions are stored in a compact mutable table, consuming no new VM global slots.

The existing `USE <object> ON/WITH <object>` authority remains the parser route. The existing Release 1262 `DRAGON-BREATH-DEATH` routine remains the hazard authority. Release 1263 composes those two existing systems rather than creating replacements.

## Qualification

The qualifier first re-runs the entire locked Release 1262 dragon qualification, then proves four separate histories:

1. **Sound screen:** brace the intact screen, provoke the dragon's real breath, survive, and prove the screen is now scorched.
2. **Scorched screen:** deliberately rebrace a previously scorched screen, survive another real breath, and prove the screen is now warped.
3. **Warped screen:** attempt to brace the warped object, receive an honest refusal based on its physical geometry, then prove the unchanged dragon breath is lethal.
4. **No screen:** face the dragon without carrying the screen and prove Release 1262's lethal consequence is unchanged.

No qualification verb exists in production; setup/status commands are test-only.

### Locked production artifact

The exact production identity pinned in `patch-series.json` is:

- file: `zork1-glulx-ablative-protection-equipment-consequence.ulx`
- Glulx version: `0x00030103`
- size: `468480` bytes
- checksum: `0xf5898239`
- SHA-256: `a29a94fe607130c6bc2f86c140b6d3a2d7c065c9ceb80263a5dbfb51db3b3997`

The exact Release 1262 predecessor is pinned at artifact SHA-256 `2c0f63695388732af365d0b72b014348c7f1fb438dde0c5b49616ae8fdb81cf9`, with staged-source identities:

- production: `0725e2c777b499356b2da6b13d3f3f6e37261abae2d59e780b6ea3d94c769fa2`
- dev: `be8b33560edaadd2af2ea13b6d9545d3daa65beeee8775d066af305b57e0022d`

### Final hosted receipt

Hosted qualification run **`31929398064` completed successfully on exact locked PR head `ce340dfd72e656172fac53c3037ce4c439f8223c`** before merge. It requalified the complete Release 1262 predecessor and all four Release 1263 player histories against the locked artifact above.

Release 1263 merged through PR #68 at merge commit `565d24d910e75ac6b28f1ce9d57de1506a642b62`.
