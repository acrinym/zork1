# Unofficial Shadow Logic Glulx Release 1213

This directory contains the qualified first Shadow Logic layer built on Reactive Surface Glulx Release `1212`.

Shadow Logic borrows a design principle rather than content from graphical adventure games such as *Shadowgate*: ordinary objects may be combined experimentally, risky actions give readable state feedback, and the world remembers notable mistakes. It does not copy Shadowgate rooms, puzzles, text, art, spells, interface, or story material.

## Identity

- edition: Unofficial Shadow Logic Glulx
- release: `1213`
- serial: `260720`
- artifact: `zork1-glulx-shadow-logic.ulx`
- base: qualified Unofficial Reactive Surface Glulx Release `1212`

Release `1213` is a repository-local migration identity, not an official Infocom release.

## Qualified artifact

- Glulx version: `3.1.3` / `0x00030103`
- size: `197,376` bytes
- checksum: `0xeb7138e8`, valid
- SHA-256: `af71704cf8c0aca091a4fb26a5f18dd31f94181fffb801578a2f1d63ae79232f`

The workflow fails closed if the pinned upstream tree, qualified Release `1212` base, reviewed source boundary, toolchain, story size, checksum, or SHA-256 changes unexpectedly.

## Included systems

### Object-on-object experimentation

The parser accepts:

- `USE <object> ON <object>`
- `USE <object> WITH <object>`

The router delegates established actions to canonical Zork routines instead of replacing them. Examples include applying flame to burnable objects, cutting burnable objects with weapons, transferring flame between supported light sources, extinguishing supported flames with available water, and reflecting active light in the enormous mirrors.

### Native player targeting

Glulx uses the real `ME` object directly; no Version 3 carrier-object workaround is needed. Supported experiments include:

- tying the rope around the player and blocking travel until `UNTIE ME`;
- applying garlic to clothing;
- examining or diagnosing current player state;
- bringing an active flame against clothing;
- extinguishing that state with an open carried bottle containing water;
- testing a held weapon against the operator, with the expected terminal consequence.

### Telegraphing and recoverability

The clothing-fire route is not an unannounced parser joke:

1. the first action produces smoke and states that this is the warning stage;
2. the next turn escalates to visible flame and explicitly recommends water;
3. available bottled water extinguishes the state and is consumed;
4. continued inaction reaches the terminal outcome.

Informational commands such as `LIGHTS`, `WORDS`, and `FOLLIES` do not secretly advance the threat clock.

### Material responses

Representative objects are classified as paper, wood, metal, glass, or fiber. The existing `TOUCH`/`FEEL`/`RUB` family and canonical `KNOCK ON` grammar produce material-specific physical or acoustic responses without altering puzzle state.

### Qualitative light inventory

`LIGHTS` reports reachable light sources and their current qualitative state, including:

- brass-lantern electric light;
- ivory-torch open flame;
- ritual candle flames;
- unsafe local illumination from burning clothing.

It is intentionally descriptive rather than a numerical fuel dashboard.

### Learned maintenance word

Reading the owner's manual teaches `MELZAR`, an original repository-local Great Underground Empire maintenance diagnostic. `WORDS` lists learned spoken knowledge, and the player invokes the word directly as a classic Zork-style magic word:

`MELZAR`

Its response depends on location and state. Exterior diagnostics identify the inaccessible main entrance and eastern aperture; dam diagnostics report controls and gate state; mirror diagnostics reveal a delayed reflected shadow; darkness receives a momentary structural flash rather than a free persistent light source.

### Mortal-folly ledger

`FOLLIES`, `MORTAL FOLLIES`, and `DEATHS` report only categories the current playthrough has actually discovered. The ledger records representative player-fire, weapon, rope, and carried-fire experiments without spoiling unseen interactions.

### Persistent recap

`RECAP` now includes meaningful Shadow Logic state such as:

- current rope restraint;
- learned MELZAR knowledge;
- delayed-shadow discovery;
- active clothing fire.

## Layer derivation

The stage begins from Tara McGrew's pinned Glulx commit and tree, verifies the qualified Release `1212` manifest and artifact hash, replays every earlier qualified layer, and then permits differences to exactly eight source paths:

- `1actions.zil`
- `1dungeon.zil`
- `assistance.zil`
- `gmain.zil`
- `gverbs.zil`
- `reactive_surface.zil`
- `shadow_logic.zil`
- `zork1.zil`

`assistance.zil`, `reactive_surface.zil`, and `shadow_logic.zil` are reviewed source additions whose hashes are written to the staging receipt.

## Qualification routes

The pinned native Glulxe/CheapGlk pipeline proves:

1. a real-map production route for material responses, light reporting, retrieving the attic rope, restraint, blocked travel, recovery, and the folly ledger;
2. a startup-state test story using production logic for manual reading, bare `MELZAR`, metal and glass responses, mirror/light behavior, garlic state, fire warning and escalation, bottled-water recovery, `FOLLIES`, and `RECAP`;
3. a separate telegraphed terminal fire route;
4. a separate held-weapon consequence route;
5. absence of every test-only startup mutation from the production source and artifact.

All five Gemini review findings were implemented before qualification: canonical `PERFORM` return propagation, physical water availability, water consumption, and consistent water checks for player, flame, and metal targets.

## Explicit exclusions

This foundation does not yet add:

- a broad spell system beyond the single maintenance word;
- room-wide fire propagation;
- generalized material simulation for every object;
- troll, cyclops, or thief alternate solutions;
- Hidden Glade or songbird-follow geography;
- the full Adventurer Misconduct comedy surface;
- removal of Version 3 workarounds from the `.z3` editions;
- a graphical Shadowgate-style interface.

## Next isolated layer

The next Shadow Logic train should expand the foundation into deeper mechanism and ritual interactions: dam machinery, bell resonance, candle state, black-book knowledge, mirrors, rope, water, wrench, shovel, axe, and controlled multi-object consequences, while keeping every canonical Zork solution valid.
