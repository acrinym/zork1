# Release 1265 — Consumable Light & Graduated Darkness

Release 1265 takes the next Shadowgate → Parser IF lesson and applies it to
authorities Zork already had: the brass lantern and ritual candles already
consume time, matches already burn briefly, the ivory torch already provides
persistent flame, darkness already matters to grues, and Release 1257 already
owns the Timber Room's fire and smoke.

The release does **not** replace those facts with a lighting simulator. It makes
their existing physical differences legible and consequential.

## Player-facing contract

Selected existing portable light now has an authored qualitative reach:

- **bright** — a fresh brass lantern or the canonical flaming ivory torch can
  push strong light into a dangerous dark space;
- **weak** — a depleted lantern or the small candle pair still provides normal
  binary Zork visibility, but its useful reach is visibly contracted;
- **ember** — a nearly spent lamp, nearly spent candles, or a lit match buys a
  very small local circle rather than pretending to equal a full lamp or torch;
- **dark** — the existing parser `LIT?` and canonical grue/darkness authority
  remain in charge.

There is no numeric brightness value shown to the player. `EXAMINE LAMP`,
`EXAMINE CANDLES`, and the existing `LIGHTS` command describe physical
condition and useful reach in prose.

## Canonical consumption remains canonical

Release 1265 does not add a second lamp battery or candle-fuel counter.

The original `LAMP-TABLE`, `CANDLE-TABLE`, `I-LANTERN`, `I-CANDLES`, and
`LIGHT-INT` remain the resource/timer authority. Release 1265 observes their
already-authored warning milestones and maps them onto qualitative physical
states:

- the lamp's existing "definitely dimmer" milestone becomes **weak**;
- the existing "nearly out" milestone becomes **ember**;
- its existing exhaustion remains **dark/burned out**;
- the candle pair similarly reaches an ember state at its existing final
  warning milestone before exhaustion.

Turning a source off pauses the same canonical interrupt it already paused.
Turning it back on resumes the same consumable history rather than resetting a
new resource.

## Grue-colony pressure

Release 1256's authored grue colony in the mine now reacts to the useful reach
of the actual light in the room rather than hard-coding "ivory torch" as the
only strong-light fact.

- **bright light** drives far enough into the fissures to reveal the colony's
  multiple retreats;
- **weak light** keeps ordinary visibility but cannot settle what is moving
  deeper in the cracks;
- **ember light** produces a deliberately alarming close circle: scrapes crowd
  just outside the failing reach;
- **full darkness** is not reimplemented here. Canonical Zork darkness and grue
  danger remain authoritative.

The ivory torch therefore remains the canonical permanent strong-light
solution. A fresh brass lantern becomes a physically credible alternate while
it is still genuinely bright.

## Wet candles and real flame transfer

The existing bottled-water and `USE ... ON ...` authorities now matter to the
ritual candles as material objects.

Applying real bottled water to the candles:

1. consumes the existing real `WATER` object from the open bottle;
2. extinguishes the candle flames;
3. leaves the wicks visibly waterlogged;
4. makes immediate relighting hiss and fail for a stated physical reason;
5. dries over a short, narrated sequence of ordinary actions;
6. then allows the existing match → candle flame-transfer route to work again.

There is no hidden wetness percentage. The player is explicitly told that the
wicks need time and explicitly told when they can hold flame again.

## Existing fire and smoke consume fragile light

Release 1257 remains the only Timber Room fire authority.

When its real authored state is actively burning or collapsed-hot, a held **ember-stage candle pair** cannot survive the room's hot smoke and hard
westward draft. The tiny flames gutter out. Release 1265 reads the existing fire
stage; it does not create parallel smoke, draft, or fire state.

The permanent ivory torch is intentionally not subjected to this candle rule,
and a healthy lantern remains electrically lit. This is an authored material
interaction, not a universal fire-resistance matrix.

## Architectural boundaries

Release 1265 deliberately adds no:

- room lux values;
- generic brightness map;
- numeric fuel points;
- second lamp/candle timer;
- universal fuel/material registry;
- generic light-source class;
- replacement `LIT?`;
- replacement grue death logic;
- replacement fire/smoke authority;
- new legacy VM globals.

Qualitative state lives in one compact mutable table and is evaluated only for
the exact authored lamp, candles, match, and ivory torch.

## Qualification

The qualifier first re-runs the complete locked Release 1264 qualification,
then stages Release 1265 over the exact newly proved Release 1264 production
and development source identities.

It compiles production and test stories and drives six natural player-command
histories:

1. **bright lamp / colony reveal** — a fresh canonical lamp pushes bright light
   into the existing grue-colony fissures and reveals the multiple retreats;
2. **weak lamp** — the same room remains usable, but weaker light cannot reveal
   the colony;
3. **ember emergency** — the player deliberately turns off the lamp in the
   colony, gets canonical pitch darkness, lights a real match, receives a tiny
   ember-scale warning circle, then restores the bright lamp;
4. **wet candles / recovery** — real bottled water soaks the candle wicks,
   immediate match relighting fails causally, drying is narrated, and the
   existing match-to-candle flame transfer succeeds afterward;
5. **smoke versus ember candles** — Release 1257's active Timber Room fire and
   draft extinguish carried ember-stage candles;
6. **canonical ivory torch** — the original flaming torch remains permanent
   bright light and still reveals the grue colony.

Test-only setup/status verbs establish late-game preconditions efficiently.
The actions under qualification are normal parser commands.

### Locked predecessor

Release 1265 is pinned to Release 1264's locked production artifact:

- SHA-256:
  `04216477fb50deeb04f833122d5874c602277b2b4522cbf72420f2b987b52a1d`

and to the exact staged Release 1264 source identities recovered from its final
green hosted qualification artifact:

- production:
  `6833f6c84654294fdf701f043a9fd8cb04168967addb3f8e471d1a7cde52cf8b`
- development:
  `fa6f07494fc29647abc13d09ba3f4494ae4c18c1c1cde9a266f1d5211c9bc45d`

### Locked Release 1265 artifact

Candidate run `32029901887` on exact head
`63775f454e5fab4538f63a37dca8b637047cfdc0` requalified the complete locked
Release 1264 predecessor, staged exactly the six intended production paths,
compiled production and test stories, passed all six natural-command histories,
and then stopped only at the intentional artifact-lock gate.

That proved and locked this exact production artifact:

- file: `zork1-glulx-consumable-light-graduated-darkness.ulx`
- Glulx version: `0x00030103`
- size: `474112` bytes
- checksum: `0x69f582b5`
- SHA-256: `6908e60a4dc191e1f74353055aa3dce11e72172edb96557a0f66d069327c1070`

Every subsequent qualification must reproduce that identity exactly as well as
all six player histories.
