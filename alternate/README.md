# Absurd Alternate Zork I — Release 122

Release 122 turns a small set of ridiculous but physically coherent ideas into real alternate outcomes.

It is additive to Expanded Release 121. Release 121 remains independently reproducible and unchanged.

## Identity

- edition: Absurd Alternate Zork I
- format: Z-machine version 3 (`.z3`)
- release: `122`
- serial: `260720`
- artifact: `zork1-absurd-alternates.z3`

Release 122 is a repository-local identity, not an official Infocom release.

## Qualified artifact

- size: `107,992` bytes
- checksum: `0x3ab5`, valid
- SHA-256: `58153ea7f2b59dfc94ca2367ae2e4507e3eef02d14c60023790953a8415498db`

The qualification workflow fails closed if the source boundary, header identity, file size, checksum, or SHA-256 changes without an intentional update.

## Design rule

A ridiculous action may produce a real world-state change only when:

1. the requested result is physically understandable;
2. the player possesses the needed objects;
3. the relevant character or mechanism is genuinely vulnerable;
4. preparation and timing matter;
5. failure has an honest consequence;
6. the canonical solution remains available.

This is not a universal “say something funny and win” system.

## Troll restraint

### Alert troll

`TIE UP TROLL WITH ROPE` fails while the troll is alert and armed.

The player must be holding the real rope. Approaching with some other object does not create a generic restraint system.

### Trick window

`TRICK TROLL` is a one-use deception. The troll turns away briefly, suppressing his immediate response and creating one practical opportunity.

The player must use that opportunity immediately. Leaving and later returning restores normal danger; the troll attacks and an attempted tie again receives the alert, armed failure.

### Successful restraint

`TRICK TROLL` followed immediately by `TIE UP TROLL WITH ROPE`:

- leaves the troll alive;
- drops the real axe into the room when he is carrying it;
- moves the real rope into the restraint;
- opens the passages through the canonical `TROLL-FLAG` route;
- changes the troll's persistent description;
- records the outcome through `RECAP`.

The same restraint machinery can bind a troll who is already unarmed or otherwise genuinely vulnerable, but it does not falsely narrate a distraction or an axe drop that did not occur.

The bound troll remains present, angry, and interactive. `TRICK TROLL` receives the bound-state rejection instead of falling through to generic actor handling. Attacking a helpless bound troll is rejected as ordinary villainy rather than tactical misconduct.

### Releasing him

`UNTIE TROLL`:

- returns the rope;
- restores the troll as an active threat;
- closes the passages under the original troll-gating logic.

## Burning the bird's nest

The special alternate solution requires:

- the real ivory torch;
- the torch held, lit, and flaming;
- the nest still in `UP-A-TREE`;
- the player beside it.

Other burning situations continue through Zork's canonical `V-BURN` behavior.

### Prepared catcher

At the Forest Path:

`PUT SACK UNDER TREE`

This spreads the real brown sack beneath the branch, marks the deliberate preparation, and makes the sack open and searchable.

Then, from Up a Tree:

`BURN NEST WITH TORCH`

The nest burns and is consumed. The real jewel-encrusted egg falls into the real sack intact. Its fixed description is updated so it no longer claims to remain in a nest that has burned away.

If the lunch remains in the sack, the narration credits the hot-pepper sandwich with cushioning. If the sack is empty, the catch still works but uses accurate canvas-and-luck prose.

No treasure, egg, canary, container, or score value is duplicated.

### Unprepared fall

Merely placing or moving the sack to the Forest Path is not sufficient. Unless the player deliberately performs `PUT SACK UNDER TREE`, burning the nest drops the real egg and invokes Zork's existing `BAD-EGG` routine—even if the sack happens to occupy the same room.

That produces the canonical:

- broken jewel-encrusted egg;
- broken clockwork canary;
- reduced treasure values;
- ruined-egg room description.

The player has exchanged climbing for an expensive lesson in gravity.

## Source boundary

Release 122 first stages the complete verified Release 121 source, then changes exactly:

- `1dungeon.zil`
- `absurd_alternates.zil`
- `expansions.zil`
- `gsyntax.zil`
- `zork1.zil`

The staging receipt records complete before-and-after inventories and rejects any sixth changed path.

## Qualification routes

### Production troll journey

A real route from West of House:

- enters through the kitchen window;
- retrieves and lights the lamp;
- retrieves the rope from the attic;
- enters the cellar and Troll Room;
- proves alert restraint failure;
- tricks and binds the troll;
- proves the real axe drops;
- proves `TRICK TROLL` receives the bound-state rejection;
- traverses east and west through the opened passages;
- verifies the persistent description and recap.

### Test-only scenario story

A separately compiled qualification story adds setup verbs that never enter the production artifact. It proves:

- a deliberately prepared sack catches the intact egg;
- both sandwich-filled and empty prepared-sack narration;
- a physically present but unprepared sack does not catch the egg;
- unprepared fall invokes canonical `BAD-EGG`;
- ordinary nest burning with lit candles still invokes canonical `V-BURN`;
- leaving during the troll trick and returning restores live hostile behavior;
- the restored troll attacks and rejects the rope as alert and armed;
- an unarmed troll can be restrained without phantom distraction or axe-drop narration;
- a bound troll rejects another trick attempt through the alternate handler.

The production source and artifact are checked to contain none of the setup verbs or the setup module.

## Review hardening

Before merge, all actionable review findings were implemented:

- offscreen troll recovery restores `FIGHTBIT` regardless of the player's location;
- canonical non-torch nest burning remains delegated;
- wrapper routines preserve the original optional-mode contract;
- troll binding narration reflects actual distraction and axe state;
- bound-troll `TRICK` reaches the custom rejection;
- catches require deliberate sack preparation;
- sandwich cushioning prose depends on the sandwich actually being present.

## Explicit exclusions

Release 122 does not add:

- the Wizard of Frobozz;
- Wizard burning, restraint, or gift interactions;
- new rooms;
- new treasure objects;
- a universal trick command that defeats every actor;
- automatic puzzle completion;
- Glulx parity for these outcomes.

The Wizard belongs to Zork II. His highly flammable beard remains a separate future problem. 😄

## Next boundary

The next isolated work should either:

1. port Release 122's earned alternate outcomes to Glulx with semantic parity; or
2. extend Release 122 with another tightly bounded set of prepared, risky alternate solutions.

Potential additions must continue to use real objects and canonical consequences rather than manufacturing convenient parallel state.
