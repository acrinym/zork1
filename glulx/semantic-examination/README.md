# Release 1267 — Semantic Examination & Hidden Structure

Release 1267 makes selected concrete details already promised by Zork's prose into honest parser targets. It does not create a generic noun-promoter, hotspot system, or hidden-object lottery.

## Player-facing contract

This train promotes new semantic targets where the current lineage still has a real parser gap:

- the Timber Room's strong westward draft;
- the Scorched Cleft's broad claw-like scratches and old white bones;
- the Dragon Gallery's old heat blackening;
- a high ventilation seam that can be discovered by examining the Gallery's heat/soot pattern closely enough.

The Troll Room's bloodstains and deep scratches are deliberately **not** reimplemented here. Release 1218 Room Density already promoted those prose details into authored parser targets. Release 1267 treats that as predecessor authority and carries a regression history proving those existing details still answer natural commands unchanged.

Targetability is not success. The draft cannot be picked up. Stone scratches and old heat marks do not become inventory. The ventilation seam is measured in inches and never becomes a new route.

## Hidden structure without guess-the-noun play

`DRAGON-VENT-SEAM` begins outside every room, so the hidden structure is not placed in parser scope merely because the implementation knows its noun.

Examining the Gallery's already-described old heat blackening reveals the soot geometry and moves the real seam object into the Dragon Gallery. Ordinary object location therefore represents discovery and naturally survives save/restore without a new clue counter or legacy VM global.

The seam then reports the existing world truth:

- with no active Timber Room fire, it shows old soot and faint moving air;
- while Release 1257's real Timber Room fire is in a smoke-producing stage, it reports that real smoke passing through the cut;
- Release 1262's `DRAGON-SMOKE-COVER?` remains authoritative for whether smoke changes the dragon encounter.

Release 1267 does not invent a second smoke flag, ventilation simulation, dragon state, or new passage.

## Canonical-authority boundaries

The train adds one new production module and story-identity wiring only. It deliberately leaves these predecessor authorities byte-identical:

- canonical `1dungeon.zil` room prose and map;
- Release 1218 `room_density.zil`, including its existing Troll Room detail objects;
- Release 1257 `fire_structural.zil`;
- Release 1262 `dragon_hoard.zil`;
- Release 1266 `learned_magic.zil`;
- generic parser grammar/verb files.

It also adds **zero legacy VM globals**.

## Qualification

The qualifier re-runs the complete locked Release 1266 qualification, pins its exact staged production/development source identities, stages exactly `semantic_examination.zil` plus `zork1.zil`, compiles production and test stories, and drives five natural-command histories:

1. inherited Troll Room bloodstains/scratches regression — proves the existing Room Density authority remains intact instead of being duplicated;
2. Timber Room draft examination/listening/smell;
3. Scorched Cleft scratches and bones;
4. hidden ventilation-seam discovery followed by direct reference and a failed attempt to use it as a route;
5. the discovered seam observing Release 1257's real burning/smoke state and Release 1262 smoke-cover authority.

The first source-lock pass records the exact Release 1266 staged identities. After those are pinned, the first full gameplay candidate intentionally stops at the artifact-lock gate; the exact candidate identity is then locked and reproduced on a final run.
