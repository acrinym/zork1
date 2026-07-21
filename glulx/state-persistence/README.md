# Glulx Release 1216 state persistence qualification

This train does **not** invent Release `1217` and does not modify production game source.

It rebuilds the exact locked Unofficial Ritual Resonance Glulx Release `1216`, verifies its exact artifact identity, then compiles a separate test-only story containing deterministic setup, mutation, and reporting verbs. Each route uses the game's real `SAVE` and `RESTORE` commands under pinned native Glulxe and CheapGlk.

## Qualification result

The complete route suite passed under pinned native Glulxe and CheapGlk. It produced six real, non-empty save files and restored every asserted object graph, global, room property, discovery flag, and queued interrupt.

- `troll.sav`: `1,022` bytes
- `egg-caught.sav`: `1,038` bytes
- `egg-broken.sav`: `1,030` bytes
- `dam.sav`: `1,008` bytes
- `ritual.sav`: `1,036` bytes
- `timer.sav`: `1,014` bytes

The build receipt records:

- `object_graph_restoration`: passed;
- `global_and_property_restoration`: passed;
- `interrupt_table_restoration`: passed;
- `production_source_changes`: none;
- `production_contains_test_setup`: false.

## Why this train exists

The newest Glulx layers add meaningful state outside the original 1980-era puzzle variables:

- a living bound troll with the rope inside the troll, the real axe dropped, and passages opened;
- an intact egg caught inside the prepared real sack or the canonical broken egg/canary consequence;
- dam interlock, sluice, reservoir, lighting, leak, repair, and learned diagnostic state;
- ritual knowledge, mirror observations, wrong-order memory, completed exorcism, ghost removal, and bell object exchange;
- queued timed recovery of the distracted troll.

A feature is not trustworthy merely because it survives consecutive turns. It must survive a complete VM serialization and restoration cycle with object containment, flags, globals, room properties, and the clock interrupt table intact.

## Qualified production artifact

The workflow rebuilds and verifies the unchanged production artifact:

- edition: Unofficial Ritual Resonance Glulx
- release: `1216`
- serial: `260720`
- Glulx version: `3.1.3` / `0x00030103`
- file: `zork1-glulx-ritual-resonance.ulx`
- size: `211,968` bytes
- checksum: `0x3d27d123`
- SHA-256: `4f406e656b892feb5224e4e52afb98768417e1e761918334dfa94595e6091db2`

No production override or patch is introduced by this train.

## Save/restore proof pattern

Every route follows the same fail-closed pattern:

1. establish a meaningful state using real production globals, objects, properties, and routines;
2. print a deterministic state report;
3. invoke the canonical `SAVE` verb and create a real save file;
4. deliberately mutate or destroy the state;
5. print the changed report;
6. invoke the canonical `RESTORE` verb on the real save file;
7. prove the exact earlier report returns;
8. where relevant, exercise production commands such as `RECAP`, `MELZAR`, or `CEREMONY` after restoration.

The transcript checker requires markers in order, rejects any `Failed.` result, and the workflow requires every expected save file to exist and be non-empty.

## Routes

### Bound troll

Proves restoration of:

- `GLULX-ALT-TROLL-BOUND`;
- `TROLL-FLAG` and open passages;
- the rope contained by the troll;
- the real axe on the room floor;
- the troll's non-fighting state and custom recap entry.

### Prepared intact egg

Proves restoration of:

- burned nest state;
- prepared-sack and caught-egg flags;
- the real intact egg inside the real brown sack;
- the canary still nested inside the egg;
- removal of the nest from the tree;
- the persistent recap outcome.

### Broken egg consequence

Proves restoration of the canonical destructive branch, including the broken egg/canary object graph rather than a duplicated treasure.

### Dam machinery

Proves restoration of:

- yellow interlock state;
- open sluice gates;
- low-tide reservoir state;
- active maintenance water level;
- visible leak and lit maintenance room;
- learned `MELZAR` state, dam discovery globals, and restored `MELZAR`/`RECAP` output.

### Completed ritual

Proves restoration of:

- learned ritual order and all persistent observations;
- completed `LLD-FLAG` state;
- canonical post-completion `XC` state;
- removed ghosts;
- cool bell restored and hot bell absent;
- completed `CEREMONY` and `RECAP` reports.

### Queued troll recovery

Proves that save/restore preserves the actual Glulx clock interrupt table. After restoration the distracted troll remains temporarily non-hostile, then the original queued `I-GLULX-ALT-TROLL-RECOVER` routine fires after the saved delay and restores hostility.

## Isolation boundary

`state_persistence_test.zil` is copied only into a separate qualification source tree. Production staging is checked before this copy, and the production tree is rejected if any of the test verbs appears.

The test module is allowed to arrange deterministic world states. It is not shipped, and it does not redefine `SAVE`, `RESTORE`, the clock system, or any production mechanic.
