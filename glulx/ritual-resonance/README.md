# Unofficial Ritual Resonance Glulx Release 1216

This directory defines an isolated player-facing ritual layer above qualified Dam Mechanisms Release `1215`.

It does **not** replace the canonical Zork I exorcism. The original state machine remains authoritative:

1. ring the real brass bell at the Entrance to Hades;
2. carry and light the real pair of candles while the bell interval remains active;
3. read the real black book after the paired flames answer;
4. allow the original room logic to remove the ghosts and open the gate.

Release `1216` observes and explains those transitions without inventing a parallel solution.

## Locked identity

- edition: Unofficial Ritual Resonance Glulx
- release: `1216`
- serial: `260720`
- artifact: `zork1-glulx-ritual-resonance.ulx`
- Glulx version: `3.1.3` / `0x00030103`
- size: `211,968` bytes
- checksum: `0x3d27d123`, valid
- SHA-256: `4f406e656b892feb5224e4e52afb98768417e1e761918334dfa94595e6091db2`
- base: qualified Unofficial Dam Mechanisms Glulx Release `1215`

The pinned workflow rebuilds this identity and rejects any byte, checksum, or hash drift.

## Player-facing behavior

### The bell behaves like a resonant object

Players may examine or listen to the cool bell and the red-hot bell. Ringing the cool bell outside the exorcism produces room-aware physical responses:

- temple stone holds the note unnaturally long;
- enormous mirrors return the note and reflected movement slightly late;
- dam machinery answers at a lower pitch without operating itself;
- ordinary rooms let the note fade normally.

At the Entrance to Hades, the wrapper deliberately returns control to canonical `LLD-ROOM`. Only that routine starts `XB`, replaces `BELL` with `HOT-BELL`, drops and extinguishes carried candles, starts the timers, and terrifies the spirits.

### The damaged ceremonial page can be studied

Turning the black book or reading another page preserves the canonical damaged-page text and records the discovered order:

> resonance first, paired light second, spoken prayer last

The prose does not name the required objects. Players still have to reason from the real bell, candles, black book, and room behavior.

### `CEREMONY`, `RITE`, and `RITUAL`

This read-only report describes what the player has actually learned and the current canonical state:

- whether resonance is absent, active, expired, or completed;
- whether the paired candles are merely burning, have answered inside `XB`, or were fulfilled and released by completion;
- whether the black-book prayer is unknown, blocked by missing prerequisites, ready, or complete.

The command never moves objects, starts timers, sets `XB` or `XC`, removes ghosts, or changes `LLD-FLAG`.

### Physically valid `USE` combinations

Release `1216` adds only narrow material interactions:

- `USE BELL ON MIRROR` exposes delayed reflected sound and movement;
- `USE CANDLES ON MIRROR` requires held, lit candles and exposes delayed flame behavior;
- `USE CANDLES ON BOOK` or `USE BOOK ON CANDLES` reveals the damaged page's ordering clue only with real paired flame;
- `USE BOTTLE ON HOT BELL` requires the carried, open bottle with real water and routes through canonical `POUR-ON`, consuming the water and cooling the real bell.

These combinations do not grant spells or automatically advance the exorcism.

### Wrong-order attempts remain meaningful

Reading the prayer before the bell and paired candles does not banish the spirits. The failed order is remembered in `RECAP`, but the canonical world state remains unchanged.

### Persistent recap

`RECAP` may report:

- reconstruction of the damaged-page order;
- mirror resonance;
- the bell's canonical answer;
- the paired candles' canonical answer;
- deliberate hot-bell cooling;
- a confirmed wrong-order prayer attempt;
- completion of the canonical exorcism.

## Exact derivation boundary

The staging tool rebuilds the complete qualified Release `1215` source first and permits the Release `1216` production delta to exactly five paths:

- `1dungeon.zil`
- `assistance.zil`
- `ritual_resonance.zil`
- `shadow_logic.zil`
- `zork1.zil`

The test-only setup module is copied only into a separate qualification source tree. Production is rejected if any setup verb appears.

## Qualified route

The pinned native Glulxe route passes and proves:

- damaged-page discovery;
- read-only ceremony reporting;
- temple bell resonance;
- paired-flame page response;
- mirror bell and candle delays;
- wrong-order prayer failure without ghost removal;
- canonical bell transformation and active `XB` interval;
- canonical paired-candle `XC` response;
- canonical black-book exorcism, `LLD-FLAG`, and ghost removal;
- internally consistent completed-ceremony reporting;
- deliberate real-water hot-bell cooling;
- persistent recap;
- production/test isolation;
- deterministic qualification isolated from the roaming thief without changing production thief behavior.

## Explicit exclusions

This layer does not add:

- a generalized spell system;
- another exorcism solution;
- automatic ceremony completion;
- broad supernatural propagation between rooms;
- new treasure or scoring;
- Hidden Glade or character alternate ports;
- the Wizard of Frobozz.

The Wizard remains a Zork II employee whose beard has not yet passed a workplace fire assessment. 🤣
