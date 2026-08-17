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

`DRAGON-VENT-SEAM` begins outside every room. Before discovery, natural `EXAMINE SEAM` returns that no seam is visible and leaves discovery state unchanged.

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
4. hidden ventilation-seam pre-discovery scope, discovery, direct reference, and failed traversal;
5. the discovered seam observing Release 1257's real burning/smoke state and Release 1262 smoke-cover authority.

### Qualification receipts

- source-lock run `32043988359` recovered merged Release 1266 staged identities: production `fa81100a54147f926eb20361ab9fb7314fe34695185626ee1999ead8e5e87ae9`, development `ca3ffeb0a4f0b4962120cb0506bcbe4566e5b0ca7b68474126c1a276198264b6`;
- run `32044333458` exposed the duplicate Troll authority; Release 1267 removed those objects rather than masking the collision;
- run `32044747546` proved the semantic histories but exposed a test-only fire-clock expectation; the smoke setup was corrected to retain the real burning stage through inspection;
- candidate run `32045064064` passed all five histories and intentionally stopped at the artifact-lock gate;
- locked run `32045369750` reproduced the exact artifact and passed green on implementation head `a939301c669a7bacadfad53ec72374a9eabbab48`.

Locked artifact:

- file: `zork1-glulx-semantic-examination-hidden-structure.ulx`
- Glulx: `0x00030103`
- size: `479744` bytes
- checksum: `0x464b20d2`
- SHA-256: `828383a78549cce45d26f888d14eb37838c74ce5b44588423eb8eca036ef77f0`
