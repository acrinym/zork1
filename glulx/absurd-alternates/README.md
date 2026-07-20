# Unofficial Absurd Alternate Glulx Release 1214

This directory defines the isolated Glulx semantic-parity layer for the earned alternate outcomes in project Release `122`.

It builds above the exact qualified Shadow Logic Release `1213` source and artifact identity. It does not modify or relabel Release `1213`, and it does not silently import the broader Version 3 expansion or Adventurer Misconduct layers.

## Identity

- edition: Unofficial Absurd Alternate Glulx
- release: `1214`
- serial: `260720`
- artifact: `zork1-glulx-absurd-alternates.ulx`
- base: qualified Unofficial Shadow Logic Glulx Release `1213`
- semantic reference: qualified Absurd Alternate Zork I Release `122`

Release `1214` is a repository-local migration identity, not an official Infocom release.

The exact deterministic artifact size, checksum, and SHA-256 are measured by the first complete qualification run and then committed as a fail-closed lock in this same train.

## Player-facing outcomes

### One-use troll opening

`TRICK TROLL` works once while the living troll is present and unbound. The troll looks away for one immediate tactical opportunity, then recovers and resumes guarding if the player delays or leaves.

Repeating the trick after he has learned it produces a different rejection. Attempting it after restraint acknowledges that he is no longer available for further tactical deception.

### Real-rope restraint

`TIE UP TROLL WITH ROPE` requires the actual carried rope and genuine troll vulnerability.

- an alert, armed troll rejects the attempt without silently disabling combat;
- immediate restraint after the one-use trick succeeds;
- an unarmed or already weakened troll may also be restrained without inventing distraction narration;
- the real rope moves into the restraint;
- the real axe drops only when the troll actually carries it;
- the troll remains alive and reacts as a bound character;
- east and west open through the existing `TROLL-FLAG` world state.

`UNTIE TROLL` returns the real rope, closes the alternate passage state, restores the troll's fight state, and makes another alert restraint attempt dangerous again.

### Deliberate brown-sack catcher

`PUT SACK UNDER TREE` works only at the Forest Path or Up a Tree while the player actually carries the brown sack. It places the real sack beneath the branch and opens it as a searchable catcher.

Merely leaving the sack beneath the tree does not count as preparation.

### Ivory-torch nest outcome

The special route requires all of the following:

1. `BURN NEST WITH TORCH`;
2. the real ivory torch in the player's possession;
3. the torch currently lit as a flame source;
4. the real nest still Up a Tree;
5. the player beside the nest.

With the deliberately prepared sack below, the real jewel-encrusted egg lands intact in the real sack. The narration distinguishes sandwich cushioning from an empty prepared sack, and the egg receives an accurate post-descent description.

Without preparation, the real egg falls and invokes canonical `BAD-EGG`, preserving the existing broken egg, broken canary, and reduced treasure consequences. An empty nest receives its own outcome.

Every other burning context delegates to canonical Zork behavior. Burning the nest with candles on the ground remains ordinary `V-BURN`; this layer does not create broad fire propagation.

## Persistent state

`RECAP` reports meaningful current or discovered parity state:

- the troll's one-use learned deception state;
- a currently active brief distraction;
- living bound-troll state;
- deliberate sack preparation before the fire;
- intact caught egg or canonical destructive descent.

The state is production logic, not transcript-only narration.

## Layer derivation

The staging tool rebuilds the exact qualified Release `1213` source first, inventories it, copies it, and permits the Release `1214` delta to exactly five paths:

- `1dungeon.zil`
- `absurd_alternates.zil`
- `assistance.zil`
- `gsyntax.zil`
- `zork1.zil`

The new module is reviewed source. Setup verbs live only in the separate qualification story and are rejected if found in production.

## Cross-VM semantic qualification

The workflow rebuilds the locked Release `122` `.z3` reference and the Release `1214` `.ulx` candidate in one run with their separately pinned toolchains.

The shared contract proves outcomes rather than byte identity or identical line wrapping:

- alert troll restraint failure;
- one-use timed distraction;
- living real-rope restraint;
- conditional real axe drop;
- east/west passage opening;
- abandoned-opportunity hostility restoration;
- `UNTIE TROLL` threat restoration;
- no phantom axe-drop narration for an unarmed troll;
- deliberate sack preparation;
- intact prepared catch;
- sandwich and empty-sack narration;
- unprepared sack failure;
- canonical `BAD-EGG` destruction;
- canonical non-torch burning;
- corrected caught-egg description;
- persistent recap state.

The production troll route starts at West of House and retrieves the real lamp and rope through the real map. Nest scenarios use a test-only startup-state module but execute the exact production mechanics.

## Explicit exclusions

This layer does not add:

- Hidden Glade or songbird-follow geography;
- troll bribes;
- cyclops lullabies;
- thief bargains;
- the full Adventurer Misconduct command surface;
- room-wide fire propagation;
- a generalized spell system;
- Version 3 object-slot cleanup;
- a graphical Shadowgate-style interface;
- the Wizard of Frobozz.

The Wizard belongs to Zork II. Beard combustion remains somebody else's future workplace incident. 🤣
