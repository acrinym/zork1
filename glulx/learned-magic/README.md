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

## State budget

Release 1266 adds **zero new legacy VM globals**. Learned-state and qualification-evidence bits live in one compact four-slot mutable table:

- stilling ward known;
- untaught ward failure witnessed;
- wet candles dried by the learned ward;
- canonical hot bell cooled by the learned ward.

The qualifier rejects any line-level `GLOBAL` declaration in the Release 1266 production module so later maintenance cannot casually regress this constraint.

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

## Qualification

The qualifier first reruns the complete locked Release 1265 qualification, then pins its exact staged production/development source identities. Release 1266 changes only `zork1.zil` plus the new `learned_magic.zil` module.

Pinned Release 1265 predecessor identities:

- locked artifact SHA-256: `6908e60a4dc191e1f74353055aa3dce11e72172edb96557a0f66d069327c1070`;
- production staged source: `e7302276f42a32c2359a694797ff5498e43a6bb62f6e44958b7921b92e002bbd`;
- development staged source: `d9defde0413a845f43514f3dac5a355721b8f0cedd12efe2b66a6b2efc8629eb`.

Four natural-command histories qualify the new behavior:

1. **learning gate** — an untaught ward fails, premature study fails, existing damaged-page reconstruction succeeds, deliberate study learns the ward, `KNOWLEDGE` reports it, and an unrelated lamp remains unaffected;
2. **wet-candle ward** — learned ward dries Release 1265's real waterlogged wicks without lighting them;
3. **hot-bell ward** — natural `RING BELL` creates the canonical red-hot bell, then the learned ward invokes canonical cooldown while leaving the ceremony interval active;
4. **house-ward grammar coexistence** — `WARD HOUSE WITH GARLIC` still routes to the pre-existing bounded house action rather than the new one-object learned ward.

Candidate run `32041714915` on exact head `4e9e30eab54946850d8df2d3227ce27f52454b52` passed the complete Release 1265 replay, both compiles, static/smell gates, and all four natural-command histories, then intentionally stopped only at the artifact-lock gate.

That candidate established the exact Release 1266 artifact identity:

- file: `zork1-glulx-learned-magic-parser-capability.ulx`;
- Glulx: `0x00030103`;
- size: `475904` bytes;
- checksum: `0xb7efb785`;
- SHA-256: `d26e66c95db2df733f4d2f0e8080650b4ec9ae4b5aa11082e6760835cb955fa9`.

Locked run `32042145187` is green on exact implementation head `8e242267b9919be1f33828f1030a7ece24013d13`. It reproduced that artifact identity exactly and passed the complete nested qualification end-to-end.
