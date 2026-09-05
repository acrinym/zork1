# Flathead Fair RNG contract

**Status:** STABLE FOR PLANNING  
**Scope:** optional fair randomness, commitment timing, player SAVE/RESTORE behavior, deterministic qualification  
**Runtime basis:** active Highly Extended Glulx lineage, Glulx 3.1.3, pinned Glulxe `56ab8743bab565de307bd892c555d8d8897ed517`

## Why RNG belongs here

A fair benefits from uncertainty. Fishing, races, raffles, crowd texture, performer ordering, limited stock and minor incidents should not resolve identically forever.

Randomness is therefore allowed as an **authored variation mechanism**. It is not a content generator, canonical-progress gate, relationship oracle or substitute for mechanics.

## Verified runtime fact: player SAVE does not rewind the Glulx RNG

The active Highly Extended line is Glulx, and the repository's qualification authority pins Glulx 3.1.3 with Glulxe `56ab8743bab565de307bd892c555d8d8897ed517`.

Glulx defines the random-number generator's internal state as **not part of player-managed saved-game state**.

That means:

1. ordinary game RAM/stack state is restored by player `RESTORE`;
2. the interpreter's internal random-generator position is not restored with it;
3. a raw random call made after restoring an older player save is therefore not required to return the same value it returned on the abandoned timeline.

This is not an implementation accident to work around. It is the VM contract.

The pinned Glulxe runtime separately supports interpreter-managed autosave/autorestore of its RNG state. That facility is **not** the design contract for the fair and must not be confused with the game's ordinary `SAVE` / `RESTORE` commands.

## Existing qualification affordance

The exact pinned Glulxe supports:

```text
--rngseed <nonzero-number>
```

A nonzero initial interpreter seed makes the Glulxe random sequence deterministic for qualification.

The historical parser source also contains a `#RANDOM` debug command. The fair does **not** require a new production seed verb and should not expose fair internals merely to make tests convenient.

Preferred qualification control is interpreter/process-level seeding plus explicit authored scenario state where needed.

## Core design consequence: commit outcomes into story state

If a random result has become a fact of the world, store that fact in ordinary game state.

Examples:

- which critter is in lane three;
- which raffle ticket won once the drawing occurs;
- whether today's visiting craft seller attended;
- which fish is currently hooked once the hook event exists;
- which performer is next once the order has been announced/posted;
- whether a specific minor incident has already happened;
- which prize variant was actually handed over.

Once committed, repeated `LOOK`, `EXAMINE`, conversation, SAVE/RESTORE and re-entry must read the **committed fact**, not call RNG again.

The fair should never behave as though reality changes merely because the parser described it twice.

## Do not reseed the global VM RNG to create a fair day

The earlier planning phrase `fair-day seed` describes a **coherent event envelope**, not permission to repeatedly call `setrandom` and take ownership of the interpreter's global random stream.

The fair shares the game with existing and future systems. Re-seeding the global VM RNG for a ride, booth or day could couple unrelated systems and make another subsystem's randomness depend on whether the Adventurer visited the fair.

Therefore:

- production fair code should consume ordinary VM randomness only when an authored outcome genuinely needs a draw;
- the resulting world fact should then be committed into saveable story state at the correct commitment boundary;
- the fair should not globally reseed the interpreter as part of ordinary play;
- qualification may seed the interpreter at process launch using the pinned Glulxe affordance.

A future implementation may use a local deterministic derivation structure **only if** implementation planning demonstrates that it is simpler and safer than explicit committed outcomes. This contract does not require a custom PRNG.

## Three commitment scopes

### 1. Fair-cycle / fair-day commitments

Use for facts that should plausibly exist before the Adventurer discovers them.

Good candidates:

- which optional transient vendor attended;
- bounded vendor stock variations;
- performer order where the program is already established;
- raffle prize package / drawing schedule;
- selected minor ambient incidents that belong to that fair day;
- race entrants or starting arrangements that are already posted.

These facts should be established once per relevant fair cycle/day and persist for that cycle.

They must not reroll when the player walks out and back in.

### 2. Event-setup commitments

Use when a result becomes real as an activity begins.

Good candidates:

- a critter-race field/order once entries are set;
- a memory-table arrangement once the round is laid out;
- a target-gallery cycle variant once the paid round begins;
- a fish/hook state once a cast actually produces a bite/hook event;
- a raffle winner once the drawing is performed.

Once setup commits the state, observation and completion consume that same state.

### 3. Action-time draws

Use only where uncertainty genuinely occurs at the instant of action and no prior world fact should exist.

Good candidates:

- whether a cast produces a bite on this attempt;
- bounded noncritical crowd texture;
- a minor physical variation that has not been advertised or observed yet.

Action-time randomness should be the smallest category because it interacts most visibly with player restore behavior.

## SAVE/RESTORE and save-scumming

The fair will **not** build an anti-save punishment system.

Because player RESTORE does not rewind the VM RNG, restoring to a point **before** an outcome was committed may naturally lead to a different later draw.

That is acceptable.

The product promise is narrower and stronger:

- once the world has committed an outcome, SAVE/RESTORE preserves that committed outcome through ordinary saveable story state;
- repeated observation never rerolls it;
- leaving and returning never rerolls it within the same event/day scope;
- the game does not maintain hidden non-saveable anti-player state solely to remember that the player restored;
- the fair does not punish, shame or secretly worsen odds because the player used SAVE/RESTORE.

This means the design prevents trivial `LOOK -> different reality -> LOOK again` randomness and most post-commit reroll exploits, while refusing to wage war on a player who saves **before** a genuinely unresolved chance event.

`SAVE` is a normal parser-IF affordance, not misconduct.

## Fishing contract

Fishing needs uncertainty but not slot-machine behavior.

Recommended planning sequence:

1. chosen position, gear, bait, weather/time and known pond state establish an authored candidate table/modifiers;
2. a cast may make a bounded action-time bite/no-bite draw;
3. once a bite/hook creates a specific catch candidate, the fish identity/specimen properties become committed event state;
4. landing/losing that fish uses authored mechanics and committed specimen state rather than replacing the fish with a new draw;
5. inspection/weigh-in reads the same specimen;
6. record-class status is derived from the real species/specimen result, never from a separate `LEGENDARY` spawn class.

Relationship state never alters odds.

## Race contract

Races must remain mechanically distinct from other games.

Before the race visibly starts:

- entrants and any publicly knowable characteristics are committed;
- the event's variation state is committed far enough that repeated observation cannot change a runner's identity or advertised condition.

During the race, authored chance may affect progression where the eventual implementation needs it, but the result must emerge from the race model rather than `RANDOM winner from 1..N` followed by decorative prose.

Once finish order exists, it is durable event state and can feed current Fair Office results.

## Raffle contract

A raffle can use chance because chance is the point.

Rules:

- eligible entries are physical/current state before the draw;
- the winner is selected once at the authored draw boundary;
- the winner/result is committed immediately;
- repeated `ASK`, `LOOK`, SAVE/RESTORE after the draw or office review returns the same result;
- a public raffle result may become current Fair Office paperwork;
- durable archival graduation follows the House-of-Records policy rather than RNG rules.

## Vendor attendance and stock

Optional attendance/stock variation is allowed only for genuinely optional service.

Never randomize away:

- a necessary NPC;
- canonical progression;
- a mandatory object;
- a service the current fair story requires with no alternate path.

If Sella Birch, Vera Tallow or another persistent named vendor is authored as guaranteed for a specific story/fair state, RNG cannot silently make that person absent.

A future transient vendor can be an attendance-random candidate precisely because no required product/story depends on them.

## Crowd, performer and minor-incident randomness

These are useful only when bounded.

Good use:

- choose one of several authored crowd incidents for AFTERNOON;
- choose a performer order from a small authored allowed set;
- vary a noncritical prize pattern;
- choose whether one authored background interruption happens.

Bad use:

- synthesize dialogue;
- invent lore;
- manufacture arbitrary NPC personalities;
- trigger relationship success/failure;
- turn after-hours into random horror mode;
- flood every turn with a random event.

## Mara law

Never randomize Mara's fundamental personality or preferences.

Random world circumstances may give Mara different **inputs**:

- a ride closes for wind;
- Cassa lands a large fish;
- a booth is crowded;
- rain moves people into the pavilion;
- a race has an unexpected result.

Mara then responds through authored character/context authority.

Do not roll `MARA LIKES THIS TODAY`.

## Canonical safety law

RNG must never decide:

- whether canonical Zork is solvable;
- whether a required exit exists;
- whether a canonical necessary NPC exists;
- whether a mandatory item spawned;
- whether a canonical hazard warning exists;
- whether the player is allowed to finish the original game.

Fair RNG is optional-world variation only.

## Qualification strategy

Natural-play qualification must prove both **variation** and **state commitment**.

### Deterministic fixture mode

For hosted/native qualification:

- launch the pinned Glulxe with a known nonzero `--rngseed`;
- begin from a known staged artifact/state;
- use a transcript that reaches the real fair through parser commands;
- assert authored outcomes/state, not raw RNG numbers;
- rerun with the same seed and route to prove reproducibility where deterministic reproduction is required.

Different known seeds may be used in separate fixtures to prove multiple authored branches.

### SAVE/RESTORE qualification

At least one eventual qualification route should explicitly prove:

1. establish a random fair fact;
2. inspect it;
3. SAVE;
4. advance play;
5. RESTORE;
6. inspect the committed fact again;
7. confirm the fact did not reroll.

A second route should document that a draw which had **not yet been committed** before the save is not promised to replay identically after RESTORE, because Glulx does not save RNG state.

The test should validate the contract rather than pretend the VM behaves differently.

### Interpreter portability

Do not make production correctness depend on Glulxe-specific autosave RNG restoration.

Compatible Glulx interpreters must receive the same game-state semantics for already committed outcomes because those outcomes live in ordinary story state.

## Existing `#RANDOM` command boundary

The historical Zork parser contains a `#RANDOM <number>` debugging command.

Fair implementation planning should:

- leave that historical/debug surface under its existing ownership;
- not create a second fair seed command;
- not require ordinary players to know or use it;
- prefer interpreter-level `--rngseed` for pinned Glulxe qualification.

If later hardening decides the historical command should be restricted, that is a broader product/tooling decision, not part of the Flathead Fair.

## Allowed random families

- fish bite/catch selection within authored mechanics and tables;
- race/contest variation where chance is genuinely part of the activity;
- raffle results;
- bounded crowd incidents;
- bounded performer order;
- optional transient vendor attendance/stock;
- fortunes from an authored set;
- minor incidents;
- noncritical prize variation.

## Forbidden random families

- canonical puzzle solvability;
- required exits;
- whether a necessary NPC exists;
- whether a mandatory object exists;
- irreversible catastrophic fair outcomes without warning/recovery;
- Mara's fundamental preferences/personality;
- arbitrary relationship success;
- generated dialogue;
- generated lore;
- generated fair geography;
- author-side hidden cheating presented as player failure.

## Authored randomness law

Random selection chooses among authored semantic outcomes. It does not synthesize final content.

## Planning closure

The save/RNG question is no longer open at the product-contract level:

- player SAVE/RESTORE does not preserve Glulx RNG internal state;
- committed fair facts therefore live in ordinary saved story state;
- the fair does not globally reseed production RNG;
- pre-commit chance may differ after a restore and the game does not punish this;
- deterministic qualification uses the pinned Glulxe process seed and known fixtures;
- interpreter-managed autosave behavior is not the portable gameplay contract.

Implementation details such as exact variable/table layout remain intentionally deferred until an implementation train is explicitly authorized.
