# Unofficial Material Consequences Glulx — Release 1217

Release `1217` is the ninth production layer in this repository's unofficial Zork I Glulx lineage. It derives from the exact qualified Ritual Resonance Release `1216` source and artifact identity, then deepens a deliberately small set of non-dam physical interactions.

This is not a crafting grid, a general-purpose physics engine, or permission for every object to affect every other object. It adds reviewed consequences only where the real objects, their materials, their locations, and existing puzzle state support them.

## Locked identity

- edition: Unofficial Material Consequences Glulx
- release: `1217`
- serial: `260722`
- output: `zork1-glulx-material-consequences.ulx`
- Glulx version: `3.1.3` / `0x00030103`
- size: `217,344` bytes
- checksum: `0xb0028984`, valid
- SHA-256: `2714d63760fa890be9ece3b23fc91bab67a660c42675e0302b745173aba700da`

The build is fail-closed against all three artifact dimensions.

## Exact derivation

Release `1217` stages exact Release `1216` and requires its locked SHA-256:

`4f406e656b892feb5224e4e52afb98768417e1e761918334dfa94595e6091db2`

The reviewed production delta changes exactly four staged paths:

1. `zork1.zil` — assigns Release `1217` and loads the new module;
2. `shadow_logic.zil` — runs material timers and specialized handling after existing Shadow Logic threats but before generic material prose;
3. `assistance.zil` — adds persistent material discoveries to `RECAP`;
4. `material_consequences.zil` — contains the isolated Release `1217` mechanics.

No canonical object definition, scoring routine, combat routine, dam state machine, exorcism routine, or egg transformation routine is replaced.

## Rope consequences

The real rope can now be deliberately committed to a small set of reachable anchors:

- wooden railing;
- ladder;
- wooden door;
- brown sack.

A fixed anchor:

- keeps the remaining coil under player control;
- answers pulling with real tension;
- refuses dropping or surrendering the rope;
- checks movement when the player reaches its useful limit;
- remains recoverable through `UNTIE`.

This does not replace the existing self-restraint or troll-restraint mechanics. The new anchor state is separate, visible, persistent, and always reversible.

### Cinching the brown sack

Using the rope on the real brown sack closes and cinches its mouth. The sack cannot be opened until untied, and the rope remains committed to it.

The game refuses to cinch the sack while it is spread beneath the tree as the prepared egg catcher. Existing Release `1214` preparation remains authoritative.

## Water and tool state

Real bottled water can rinse:

- shovel;
- wrench;
- screwdriver;
- axe.

Cleaning exposes working surfaces and changes observation state. It does not sharpen weapons, improve combat strength, bypass possession checks, alter dam operation, create score, or solve a puzzle automatically.

### Rust is not dirt

Applying water to the rusty knife removes loose surface rust but leaves water in its pits. If the player does not rub it dry before the short timer expires, a fresh orange bloom develops and the knife becomes visibly worse.

This is a recoverable lesson, not a new death or treasure state. The knife remains the same canonical object.

## Temporary nest soaking

Real bottled water can soak the real bird's nest.

While wet:

- the nest is visibly and tactually soaked;
- the ivory torch chars a few fibers but cannot establish flame;
- the real egg remains untouched;
- no alternate egg or nest object is created.

The wet state dries through ordinary turn progression. Once dry, fire delegates back to the original Release `1214` nest logic:

- a correctly prepared real sack catches the real egg intact;
- an unprepared fall invokes canonical `BAD-EGG`, producing the existing broken egg and broken canary state.

Release `1217` delays a consequence; it does not replace or soften it.

## Boarded entrance experiments

The existing boarded front entrance now distinguishes three real tools:

- **shovel:** works as a crude pry bar, flexes the board, and reuses the existing painted splinter;
- **screwdriver:** traces the seams and proves there is no exterior screw head;
- **wrench:** proves there is no exposed exterior nut or bolt.

The experiment reveals why the approach fails: the working hardware faces the inaccessible room inside. The boards remain secured and the canonical kitchen-window route remains the real entrance.

## Turn ordering

Release `1217` integrates inside the existing Shadow Logic action hook:

1. existing self-fire and other Shadow Logic threats advance first;
2. Release `1217` nest and rust timers advance;
3. existing rope-threat blocking remains authoritative;
4. specialized rope, nest, water, tool, and board handling runs;
5. generic Shadow Logic material prose runs only if nothing more specific applies.

This ordering prevents the new layer from pausing established danger or hiding its own specialized consequences behind generic material responses.

## Qualification

### Deterministic gameplay route

A separate test-only positioning story exercises the real production mechanics and proves:

- shovel prying and painted-splinter reuse;
- screwdriver and wrench fastener diagnosis;
- persistent `RECAP` discoveries;
- rope anchoring, tension, drop refusal, and untie recovery;
- sack cinching, blocked opening, and untie recovery;
- real-water tool cleaning;
- timed rusty-knife deterioration;
- temporary nest soaking and failed torch ignition;
- ordinary drying;
- canonical destructive egg and broken-canary consequences after drying.

### Save and restore route

The prompt-aware native Glulxe driver saves two independent Release `1217` snapshots.

The first contains:

- rope anchored to the real railing;
- pried board and discovered interior hardware;
- cleaned shovel;
- worsened rusty knife;
- active wet-nest timer.

After deliberate corruption and `RESTORE`, the route proves all state returns, the saved wet timer resumes rather than resetting, and the restored rope still blocks travel.

The second contains the rope-cinched real brown sack. After deliberate corruption and restore, the route proves the sack remains cinched and still refuses opening.

Test-only setup and mutation verbs are rejected from production source.

## Explicit boundary

Release `1217` does not add:

- universal object combination;
- crafting recipes;
- a general wet/dry system for every object;
- permanent destruction of rope or tools;
- a new front-door or boarded-window solution;
- broad fire or flood propagation;
- new treasure or scoring;
- automatic puzzle completion;
- Hidden Glade or songbird geography;
- broad troll, cyclops, or thief alternatives;
- the Wizard of Frobozz.

## Next coherent frontier

The next layer should not simply add more arbitrary object pairs. The strongest boundaries are:

1. room-density and parser-kindness work for visible nouns and reasonable physical intent;
2. dedicated long routes for renewed troll danger, cyclops impatience/lullaby behavior, and thief bargains;
3. focused character memory that records gifts, threats, deception, mercy, and restraint without becoming an open-ended chatbot;
4. optional geography only where story or puzzle logic justifies it.
