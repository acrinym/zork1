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

- size: `107,880` bytes
- checksum: `0xf13d`, valid
- SHA-256: `98320cd2c11a963b3f23c9a36782f31887279798c26958942ef48ba6ff939a28`

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
- drops the real axe into the room;
- moves the real rope into the restraint;
- opens the passages through the canonical `TROLL-FLAG` route;
- changes the troll's persistent description;
- records the outcome through `RECAP`.

The bound troll remains present, angry, and interactive. Attacking a helpless bound troll is rejected as ordinary villainy rather than tactical misconduct.

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

This spreads the real brown sack beneath the branch and makes it open and searchable.

Then, from Up a Tree:

`BURN NEST WITH TORCH`

The nest burns and is consumed. The real jewel-encrusted egg falls into the real sack intact. Its fixed description is updated so it no longer claims to remain in a nest that has burned away.

No treasure, egg, canary, container, or score value is duplicated.

### Unprepared fall

Without the sack below, burning the nest drops the real egg to the Forest Path and invokes Zork's existing `BAD-EGG` routine.

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
- proves the axe drops;
- traverses east and west through the opened passages;
- verifies the persistent description and recap.

### Test-only scenario story

A separately compiled qualification story adds setup verbs that never enter the production artifact. It proves:

- prepared sack catches the intact egg;
- intact egg remains accessible and correctly described;
- unprepared fall invokes canonical `BAD-EGG`;
- ordinary nest burning with lit candles still invokes canonical `V-BURN`;
- leaving during the troll trick and returning restores live hostile behavior;
- the restored troll attacks and rejects the rope as alert and armed.

The production source and artifact are checked to contain none of the setup verbs or the setup module.

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
