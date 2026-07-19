# Unofficial Reactive Surface Glulx Release 121 layer

This directory contains the qualified focused surface-world layer built on Assisted Glulx Release `1211`.

## Identity

- edition: Unofficial Reactive Surface Glulx
- release: `1212`
- serial: `260719`
- artifact: `zork1-glulx-reactive-surface.ulx`
- base: qualified Unofficial Assisted Glulx Release `1211`

Release `1212` is a repository-local migration identity, not an official Infocom release.

## Qualified artifact

- Glulx version: `3.1.3` / `0x00030103`
- size: `189,184` bytes
- checksum: `0xec1c9be9`, valid
- SHA-256: `409cbf1602bd88b3d83a88f2a3d682907950aa5bc87b25b70fc2fabce947e1ab`

The workflow fails closed if the source layer, qualified base, compiler inputs, size, checksum, or SHA-256 changes without an intentional provenance update.

## Included behavior

The layer adds only:

- repeated white-house knocking;
- house listening and roof-climb explanation;
- front-door knocking and listening;
- board and boarded-window inspection, knocking, and damage responses;
- persistent board scarring and a recoverable painted splinter;
- kitchen-window knocking and listening;
- mailbox knocking and listening;
- maintenance-slip discovery after removing the leaflet;
- ordinary forest and tree examination/listening;
- songbird listening and greeting without optional geography;
- surface state surfaced through `RECAP`.

Every wrapper delegates unhandled actions to the canonical Tara routine. Original routes, scoring, door behavior, window traversal, and puzzle outcomes remain authoritative.

## Explicit exclusions

This layer does not include:

- the songbird-follow route;
- Hidden Glade;
- the brass feather;
- troll bribery;
- cyclops lullaby;
- thief bargaining;
- deeper dam, ritual, rope, mirror, water, or tool reactions;
- Adventurer Misconduct;
- `FOLLY` or troll bemusement;
- removal of version 3 object-slot workarounds.

`FOLLOW SONGBIRD` continues to receive Tara's canonical refusal, and qualification fails if `Hidden Glade` appears in the native boundary transcript.

## Layer derivation

The stage begins from Tara McGrew's pinned Glulx commit and tree, then verifies the committed Release `1211` base manifest and artifact SHA-256:

`cf5e51d414bd786bdb4e911263534dcb5c9c61aaebc35b944a96e5269a864777`

It replays all qualified Release 1201 and Release 1211 source changes before applying this layer.

Exactly seven source paths may differ from Tara's pinned tree:

- `1actions.zil`
- `1dungeon.zil`
- `assistance.zil`
- `gmain.zil`
- `gverbs.zil`
- `reactive_surface.zil`
- `zork1.zil`

`assistance.zil` and `reactive_surface.zil` are reviewed source additions whose source hashes are written to the staging receipt.

## Persistent state

Three new globals persist through the normal save model:

- number of house knocks;
- whether the boards have been scarred;
- whether the maintenance slip has been discovered.

The painted splinter and maintenance slip are normal world objects. They can be taken, dropped, burned where canonical flags allow, saved, and restored.

## Qualified routes

### Shared `.z3` and `.ulx` route

The route walks the actual map using canonical parser grammar. It:

1. knocks on the house and door;
2. listens at the door;
3. attempts to climb the house and asks `WHY`;
4. opens the mailbox, removes the leaflet, discovers and reads the slip;
5. walks around the house;
6. knocks on and listens at the kitchen window;
7. enters through the original window route;
8. retrieves the original sword;
9. returns to the front of the house;
10. damages the boards and exposes the splinter;
11. checks `RECAP`;
12. enters the forest and exercises shared forest/songbird reactions.

Stable semantic markers pass under Expanded Release 121 `.z3` and Release 1212 `.ulx`; interpreter wrapping and edition-only recap lines are not required to match byte-for-byte.

### Native boundary route

A separate Glulx route proves:

- forest examination;
- tree examination and listening;
- songbird listening and greeting;
- canonical refusal of `FOLLOW SONGBIRD`;
- absence of Hidden Glade.

## Parser grammar evidence

The initial candidate transcript deliberately exposed that classic Zork requires prepositional forms for these verbs. Qualification therefore uses the game’s shipped grammar:

- `KNOCK ON HOUSE`
- `KNOCK ON DOOR`
- `LISTEN TO DOOR`
- `KNOCK ON WINDOW`
- `LISTEN TO WINDOW`
- `LISTEN TO FOREST`
- `LISTEN TO BIRD`

No parser aliases were added merely to make the test easier.

## Next layer

The next isolated Glulx layer moves underground and ports deeper mechanism and ritual feedback:

1. dam and control-panel examination/listening;
2. bell resonance;
3. candle-state examination beyond the Release 120 correction;
4. optional black-book pages;
5. rope, mirror, water, wrench, shovel, and axe reactions;
6. focused semantic routes for each group.

Optional geography, alternate NPC solutions, and Adventurer Misconduct remain later layers.
