# Unofficial Assisted Glulx Release 121 layer

This directory contains the first qualified Release 121 semantic-parity layer built on the Optimized Glulx Release 1201 artifact.

## Scope

Release `1211` adds only:

- a state-neutral global action hook after `PRSA`, `PRSO`, and `PRSI` are established;
- `GOALS`;
- `EXITS`;
- three-tier `HINT`;
- `RECAP`;
- contextual `WHY`;
- `USE <object>` affordance guidance;
- cross-VM semantic parity tests against Expanded Release 121 `.z3`.

It intentionally excludes:

- reactive house, forest, dam, ritual, rope, mirror, water, or tool prose;
- songbird and Hidden Glade geography;
- troll bribery, cyclops lullaby, and thief bargaining;
- Adventurer Misconduct grammar and reactions;
- `FOLLY` and troll bemusement;
- removal of version 3 object-slot workarounds.

## Identity

- edition: Unofficial Assisted Glulx
- release: `1211`
- serial: `260719`
- artifact: `zork1-glulx-assisted.ulx`
- base: qualified Unofficial Optimized Glulx Release `1201`

Release `1211` is a repository-local migration identity, not an official Infocom release.

## Qualified artifact

- Glulx version: `3.1.3` / `0x00030103`
- size: `185,600` bytes
- checksum: `0xd3e2209e`, valid
- SHA-256: `cf5e51d414bd786bdb4e911263534dcb5c9c61aaebc35b944a96e5269a864777`

The workflow fails closed if the source layer, compiler inputs, size, checksum, or SHA-256 changes without an intentional provenance update.

## Layer derivation

The staging receipt verifies both:

1. Tara McGrew's pinned Glulx commit and tree;
2. the committed Release 1201 base manifest and artifact SHA-256.

The stage then replays the qualified Release 120 correction set and applies only the assistance layer.

Exactly six paths may differ from Tara's pinned tree:

- `1actions.zil`
- `1dungeon.zil`
- `assistance.zil`
- `gmain.zil`
- `gverbs.zil`
- `zork1.zil`

`assistance.zil` is a reviewed source addition. Its source hash is recorded in the staging receipt.

## Action-hook boundary

Both `PERFORM` implementations invoke `ASSIST-ACTION-HOOK` only after the active action and objects have been assigned to `PRSA`, `PRSO`, and `PRSI`.

The hook:

- records the latest ordinary action and objects;
- records a small set of failure contexts used by `WHY`;
- returns false so normal actor, room, preaction, object, container, and default-action dispatch remains authoritative;
- does not add scenery reactions or alter puzzle outcomes.

Later Release 121 layers may call `ASSIST-REMEMBER-FAIL` or extend the hook through separately reviewed patches.

Tara's Glulx grammar does not expose a `PULL` action constant. A separate exact vocabulary patch therefore limits the control-panel failure context to `PUSH`, `MOVE`, and `TURN` rather than inventing a new parser action in this layer.

## Assistance behavior

### `GOALS`

States the canonical exploration and treasure objective without solving a puzzle.

### `EXITS`

Summarizes stable visible routes in major rooms and falls back to the canonical room description elsewhere.

### `HINT`

Resets when the player changes rooms and reveals three progressively more explicit tiers. This layer describes canonical solutions only; later alternate solutions are not teased before they are ported.

### `RECAP`

Reports established canonical persistent states such as the rug, troll, cyclops, dam, exorcism, and final path.

### `WHY`

Explains selected immediately preceding failed experiments without changing the original failure response.

### `USE <object>`

Describes plausible affordances while requiring the player to issue a concrete action.

## Qualified semantic parity route

The same command script runs against:

- Expanded Release 121 `.z3` under `dfrotz`;
- Assisted Release 1211 `.ulx` under pinned Glulxe and CheapGlk.

Both routes prove stable markers for:

- canonical goals;
- opening exits;
- all three opening hint tiers;
- an initial recap;
- generic object-use guidance;
- a failed `CLIMB HOUSE` followed by contextual `WHY`;
- normal quitting after nine moves.

The two formats deliberately retain different edition-specific prose around those markers. Qualification compares semantic milestones and required text rather than whitespace-identical transcripts.

## Next layer

The controlling next Glulx layer ports reactive scenery and persistent world state in focused groups. It begins with the white house exterior, doors, boards, windows, and mailbox while retaining Release 1211 as a separately reproducible artifact.
