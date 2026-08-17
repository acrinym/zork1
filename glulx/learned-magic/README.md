# Release 1266 — Learned Magic as Parser Capability

Release 1266 takes the next Shadowgate → Parser IF lesson and makes **learned knowledge change what the parser can meaningfully do** without adding a generic spell system.

The train grows from authorities Zork already owns:

- the canonical black book and Hades ceremony;
- Release 1216 Ritual Resonance, which made damaged ceremonial notation and resonance legible without replacing the exorcism;
- Release 1265 candle wetness and recovery;
- the canonical red-hot bell and its real cooldown transition;
- the existing bounded `WARD HOUSE WITH GARLIC` grammar from House Vulnerability.

## Player-facing capability

Release 1266 adds three player commands:

- `STUDY <readable object>` — deliberate learning rather than passive possession;
- `WARD <object>` — a one-object learned ritual action;
- `KNOWLEDGE` / `LORE` — a read-only report of the learned technique.

The existing two-object `WARD HOUSE WITH GARLIC` command remains a separate authored house-vulnerability action.

## Learning is earned

The Adventurer does **not** begin knowing the new technique.

1. Before the damaged black-book material has been reconstructed, `STUDY BOOK` explains that page 569 is a prayer and the compressed damaged leaves are not yet understood.
2. Existing Ritual Resonance interaction such as `TURN BOOK` reconstructs the ceremonial order — resonance, paired light, then prayer.
3. Only after that understanding does a deliberate `STUDY BOOK` decode and memorize a separate marginal technique: the **stilling ward**.
4. `WARD ...` parses before learning, but solemn gestures do nothing until the knowledge has actually been acquired.

Possessing the book, reaching Hades, or advancing the release number does not silently grant expertise.

## One bounded ward, two real contact points

The stilling ward acts only where the current world already has an exact authored condition it can settle.

### Waterlogged ritual candles

If Release 1265's real candle-wetness authority says the ritual wicks are waterlogged, `WARD CANDLES` dries that exact state to zero and explicitly leaves the candles unlit.

It does not:

- restore spent wax;
- light the candles;
- create a second wetness model;
- prevent the existing ordinary wait-for-drying route.

### Red-hot ceremonial bell

After the canonical Hades bell has actually become `HOT-BELL`, `WARD BELL` routes through the canonical `I-XBH` cooldown transition. The real hot bell disappears and the real cool bell returns exactly as it does after its timer or the existing water-cooling route.

The ward does not create parallel bell temperature, alter `XB`/`XC`, remove ghosts, or complete the ceremony.

## Explicit boundaries

Release 1266 deliberately adds no:

- mana or magic points;
- spell slots;
- spellbook inventory;
- generic enchantment registry;
- universal target tags;
- arbitrary spell dispatch;
- combat magic;
- automatic Hades completion;
- replacement ritual, candle, bell, house-ward, or parser authority.

A learned magical fact is represented directly by authored knowledge state and exact consequences where that knowledge genuinely applies.

## Qualification plan

The qualifier first reruns the complete locked Release 1265 qualification, then pins its exact staged production/development source identities. Release 1266 changes only `zork1.zil` plus the new `learned_magic.zil` module.

Four natural-command histories qualify the new behavior:

1. **learning gate** — an untaught ward fails, premature study fails, existing damaged-page reconstruction succeeds, deliberate study learns the ward, `KNOWLEDGE` reports it, and an unrelated lamp remains unaffected;
2. **wet-candle ward** — learned ward dries Release 1265's real waterlogged wicks without lighting them;
3. **hot-bell ward** — natural `RING BELL` creates the canonical red-hot bell, then the learned ward invokes canonical cooldown while leaving the ceremony interval active;
4. **house-ward grammar coexistence** — `WARD HOUSE WITH GARLIC` still routes to the pre-existing bounded house action rather than the new one-object learned ward.

The first candidate run intentionally stops after gameplay qualification so the exact Glulx artifact identity can be locked and rerun.
