# Zork I Glulx House State Foundation — Release 1219

Release `1219` is the first production train in the existing **House of Records** roadmap.

It does not add another planning hierarchy. It implements the eight existing beads in:

- `.beads/onyx_zork_house_state_foundation.beadtrain`
- `.beads/issues-zork-house-of-records-01.jsonl`

The result is a compact, persistent substrate that lets the canonical white house reflect meaningful adventure history without becoming a base-building game, a chore loop, or a replacement for Zork's object and score systems.

## Qualified identity

- edition: Unofficial House State Foundation Glulx
- release: `1219`
- serial: `260724`
- output: `zork1-glulx-house-state-foundation.ulx`
- Glulx version: `3.1.3` / `0x00030103`
- size: `230,144` bytes
- checksum: `0xbe6bc80a`, valid
- SHA-256: `e0de2b66453e6539370377691486a133ad32b3d53d2ff3e676d0d90f23be0e0f`

Release `1219` derives from exact qualified Release `1218`:

- base artifact SHA-256: `efc8bd9f264f60bb56f2daf3e4d7d6d32a272997434802ee76455781a8edf521`

## Exact production delta

The fail-closed stager changes exactly five production paths:

- `1actions.zil`
- `1dungeon.zil`
- `assistance.zil`
- new `house_state_foundation.zil`
- `zork1.zil`

Every other Release `1218` production path must remain byte-identical.

## Compact house state

The foundation keeps five deliberately small state axes:

1. **condition** — whether the house is untouched, being used, or visibly disturbed;
2. **collection** — a coarse projection of the real trophy-case value;
3. **knowledge** — whether the player has begun using the house and completed a return cycle;
4. **security** — whether established house routes or supernatural conditions leave it exposed;
5. **atmosphere** — whether the house still feels abandoned, newly used, or lived-in between expeditions.

These are not independent replacement facts. They are projections from real canonical state such as:

- room visits;
- the real trophy case and existing `OTVAL-FROB` calculation;
- the real oriental rug;
- the real trap door;
- the real kitchen window;
- the real Cellar threshold;
- the player's return to the Living Room after entering the underground.

## Meaningful receipts

Release `1219` records only six foundation-level events:

- first meaningful use of the white house;
- first Attic visit;
- first Cellar threshold crossing;
- first return to the Living Room after entering the underground;
- first real trophy-case collection;
- first visible house disturbance through established physical state.

It does **not** log every move, room transition, parser command, object shuffle, or ordinary container action.

`RECAP` can report these receipts after they actually occur.

## Room projection

Release `1219` appends bounded state-aware prose to canonical descriptions for:

- Living Room;
- Kitchen;
- Attic;
- Cellar.

The original descriptions, objects, exits, score routines, and puzzle actions run first and remain authoritative.

Release `1218` has no canonical Bedroom room. This train therefore adds no unreachable Bedroom placeholder and no topology change. A deliberately authored future Bedroom may consume the same foundation substrate in its own ordinary train.

## Canonical isolation

The foundation does not:

- duplicate treasure;
- replace the trophy case;
- alter treasure values;
- award house-state points;
- open routes automatically;
- move real objects for presentation;
- complete puzzles;
- create maintenance chores;
- create a generalized event database;
- repair state after restore.

The qualification route opens the real trophy case and places the real painting inside through ordinary parser commands. Canonical score rises through the existing trophy-case machinery, not through the house substrate.

## Migration

The schema carries an explicit version.

When an older or uninitialized snapshot is encountered, migration derives safe foundation defaults from already-existing canonical world state:

- touched house rooms;
- real trophy-case contents;
- rug position;
- trap-door state;
- kitchen-window state.

Migration does not invent return history, unseen events, new objects, score, or puzzle completion.

## Qualification

The permanent qualification route proves:

1. exact Release `1218` base identity;
2. exact five-path production delta;
3. production/test isolation;
4. Living Room, Kitchen, Attic, and Cellar projection;
5. real Cellar-to-house return receipt;
6. real trophy-case collection and canonical scoring;
7. rug and trap-door disturbance;
8. bounded `RECAP` output;
9. schema migration defaults;
10. deliberate corruption of globals, object location, rug, trap door, and window;
11. ordinary native `SAVE` and `RESTORE` returning exact state without repair;
12. exact Release `1219` artifact size, checksum, and SHA-256.

Test-only positioning, mutation, migration, and report verbs exist only in the isolated qualification story and are rejected from production.

## Downstream hooks

This foundation is intentionally small so the existing later House of Records trains can build above it:

1. Living Room museum;
2. Kitchen laboratory and preparation;
3. Cellar expedition threshold;
4. correspondence and visitors;
5. Attic archive core;
6. NPC dossiers;
7. area case files;
8. playback;
9. rest and dreams;
10. house vulnerability;
11. completed expedition archive.

Those trains should consume the stable house-state and receipt boundary rather than creating parallel house memory systems.

## Explicit exclusions

Release `1219` adds no:

- Bedroom placeholder;
- display-surface registry;
- crafting, recipes, hunger, thirst, or housekeeping;
- equipment locker or stash;
- mail queue or visitor;
- dream system;
- playback or completed-run comparison;
- death-site recovery;
- armor;
- Zork Plus;
- linked storage;
- broad fire, flood, or intrusion propagation;
- Wizard of Frobozz.

## Files

- production module: `overrides/house_state_foundation.zil`
- exact story wrapper: `overrides/zork1.zil`
- manifest: `patch-series.json`
- patches: `patches/`
- test-only story: `tests/house_state_foundation_test.zil`
- deterministic route: `tests/house_state_commands.txt`
- native persistence scenario: `tests/house_state_persistence.json`
- stager: `../tools/stage_house_state_foundation.py`
- qualification: `qualify.sh`
- workflow: `.github/workflows/glulx-house-state-foundation.yml`
