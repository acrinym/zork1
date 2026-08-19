# Global / State Compression Kanban — Temporary Scratch

Date started: 2026-08-19  
Repository scope lock: **`acrinym/zork1` only**  
Mainline: `master`  
Audit starting head: `507e72c3f2e086cfe299d13f4c26fdabd16ec2b8`

> **TEMPORARY WORKING DOCUMENT.** This exists so the global/state-compression audit can survive chat boundaries without making a giant conversation the source of truth. Keep it current while the audit and refactor are active. When the work is complete, move durable design conclusions, before/after global counts, and qualification receipts into the relevant Highly Extended release/PR documentation, then delete this scratch file.

## Safety / scope guard

- Writes for this work belong only in `acrinym/zork1`.
- Upstream/source repositories may be inspected as references when necessary but must not receive writes from this work.
- `master` is this repository's default production branch; direct scratch-document updates are allowed by the owner's instruction.
- Historical Z3/expanded sources and the active Glulx lineage must be tracked separately. Do not claim a historical global was reclaimed from the current Glulx production line unless its state is actually present in the staged/current lineage.

## Goal

Reduce pressure on the legacy global-variable budget without obscuring game semantics. Prefer compact state representations only where multiple values are genuinely one subsystem, one question, or one set of mutually related facts.

This is **semantic compression, not variable golf**.

## Design rules

1. Preserve canonical and earlier-release authority. Do not duplicate state merely to make packing convenient.
2. Use a bit/flag set when facts are independent yes/no members of one coherent family.
3. Use a compact mutable table when a subsystem owns several counters, enums, object references, or flags together.
4. Prefer real object flags, object location, or an existing canonical value when those already truthfully represent the state.
5. **Derive before storing.** A redundant global should disappear rather than merely move into a table.
6. Do not pack unrelated values merely because they fit in one word.
7. Preserve save/restore behavior and player-visible behavior exactly unless a separate design change is explicitly approved.
8. Every implemented compression must record before/after legacy-global count and validation evidence.
9. Newer Highly Extended precedent is valid: recent trains already use constant-address mutable tables instead of casually consuming legacy globals.
10. Favor named accessors/constants over raw magic indexes or bit masks at call sites.
11. A compression candidate may be rejected when separate globals communicate genuinely separate authorities better than a packed representation.

## Status legend

- `DISCOVERED` — found during inventory; not yet classified deeply.
- `PROPOSED` — coherent compression candidate ready for decision.
- `APPROVED` — approved for implementation.
- `IN PROGRESS` — conversion underway.
- `VALIDATED` — conversion complete and behavior validated.
- `REJECTED` — inspected and intentionally left separate; rationale recorded.
- `DOCUMENTED` — durable result copied to release/PR documentation.

## Running metrics

| Metric | Current value |
|---|---:|
| Current-line globals under credible compression/redundancy review | **49** |
| Current-line candidate families ready for decision | **7** |
| Current-line globals positively identified as derivation/elimination leads | **3** |
| Confirmed reclaimed globals | 0 |
| Historical candidates awaiting lineage classification | 23 |

The three current derivation/elimination leads are `MATERIAL-SACK-CINCHED`, `DAM-MECH-LEAK-REPAIRED`, and `RITUAL-PRAYER-COMPLETED`; exact equivalence must be proved before implementation. `DAM-MECH-LEAK-TRIGGERED` is also a possible derivation lead and remains under inspection.

The 23 historical candidates are from older Adventurer Misconduct / Expanded Release 121-era source previously inspected. They remain useful audit leads but are **not counted as current-line savings** until their equivalents/current ownership are traced into the Glulx lineage.

---

# Decision queue

## C01 — Glulx Assistance context state

**Status:** `PROPOSED`  
**Source:** `glulx/assistance/overrides/assistance.zil`  
**Globals:** 6

- `ASSIST-HINT-ROOM`
- `ASSIST-HINT-LEVEL`
- `ASSIST-LAST-FAIL`
- `ASSIST-LAST-ACTION`
- `ASSIST-LAST-PRSO`
- `ASSIST-LAST-PRSI`

### Semantic grouping

- hint session: room + tier;
- immediate action context: action + direct object + indirect object + WHY/failure code.

These are transient parser-assistance context, not six independent world authorities.

### Recommendation

**Approve one constant-address `ASSIST-STATE` table with named slots/accessors.** This keeps the two conceptual subgroups readable while consuming zero legacy globals.

Potential reclamation: **6**.

Validation: HINT room reset/tiering, action-hook PRSA/PRSO/PRSI capture, immediate WHY behavior, save/restore, existing assistance qualification.

---

## C02 — Glulx Absurd Alternates state

**Status:** `PROPOSED`  
**Source:** `glulx/absurd-alternates/overrides/absurd_alternates.zil`  
**Globals:** 6 booleans

- `GLULX-ALT-TROLL-DISTRACTED`
- `GLULX-ALT-TROLL-TRICK-USED`
- `GLULX-ALT-TROLL-BOUND`
- `GLULX-ALT-NEST-BURNED`
- `GLULX-ALT-EGG-CAUGHT`
- `GLULX-ALT-SACK-PREPARED`

### Semantic grouping

- troll alternate state: distracted / trick-used / bound;
- nest alternate state: nest-burned / egg-caught / sack-prepared.

### Recommendation

First prove none can be replaced by an existing canonical/object authority. Then store remaining independent facts in a named alternate-state flags field/table, with named bit accessors rather than raw masks at call sites.

Potential reclamation: **up to 6** with a constant-address table; **5** if implemented as one legacy-global bitfield instead. Table is preferred because the point is to relieve the legacy-global budget.

Validation: troll recovery timer, trick-used permanence, bound/unbound topology and canonical `TROLL-FLAG`, nest burn/catch/break paths, recap, save/restore, existing absurd-alternates qualification.

---

## C03 — Reactive Surface memory/state

**Status:** `PROPOSED`  
**Source:** `glulx/reactive-surface/overrides/reactive_surface.zil`  
**Globals:** 3

- `SURFACE-HOUSE-KNOCKS` — counter; prose distinguishes first, second, then repeated knocks.
- `SURFACE-BOARDS-SCARRED` — durable history fact.
- `SURFACE-MAIL-SLIP-FOUND` — durable discovery fact.

### Recommendation

Use one compact `SURFACE-STATE` table: one capped/ordinary knock-count slot plus a small flags slot for durable yes/no history. Do not infer scar/slip history solely from current object location because the splinter/slip can subsequently move.

Potential reclamation: **3**.

Validation: all knock prose thresholds, board first-damage behavior, one-time slip discovery, recap, object movement after discovery, save/restore, reactive-surface qualification.

---

## C04 — Dam Mechanisms observation/history flags

**Status:** `PROPOSED`  
**Source:** `glulx/dam-mechanisms/overrides/dam_mechanisms.zil`  
**Globals:** 8 booleans

- `DAM-MECH-PANEL-DIAGNOSED`
- `DAM-MECH-INTERLOCK-SEEN`
- `DAM-MECH-BOLT-ATTEMPTED`
- `DAM-MECH-GATES-CYCLED`
- `DAM-MECH-LIGHTS-TOGGLED`
- `DAM-MECH-LEAK-TRIGGERED`
- `DAM-MECH-LEAK-REPAIRED`
- `DAM-MECH-TOOL-PROBED`

### Semantic grouping

These are all **what the player has learned/done with the enhancement layer**. The actual dam continues to be owned by canonical authorities such as `GATE-FLAG`, `GATES-OPEN`, `LOW-TIDE`, `WATER-LEVEL`, and their interrupts.

### Derivation leads

- `DAM-MECH-LEAK-REPAIRED` is a strong elimination candidate because canonical repaired state is `WATER-LEVEL < 0` with the maintenance interrupt cancelled; persistence qualification explicitly treats canonical state, not extension scenery, as the sentinel.
- `DAM-MECH-LEAK-TRIGGERED` may also be derivable from canonical leak history/state (`WATER-LEVEL != 0`) if no production path returns it to zero after a genuine leak. Prove before removing.

### Recommendation

Derive leak facts where equivalence is exact; pack the remaining observation/history booleans in a named `DAM-MECH-MEMORY` flags state/table. Never pack or replace the canonical machine-state globals themselves as part of this candidate.

Potential reclamation: **8**.

Validation: button/interlock behavior, gate cycling, real leak/repair, MELZAR/status output, recap histories, save/restore with queued dam/leak interrupts, existing dam and persistence qualifications.

---

## C05 — Ritual Resonance memory flags

**Status:** `PROPOSED`  
**Source:** `glulx/ritual-resonance/overrides/ritual_resonance.zil`  
**Globals:** 8 booleans

- `RITUAL-CEREMONY-KNOWN`
- `RITUAL-BELL-RESONANCE-HEARD`
- `RITUAL-BELL-ANSWERED`
- `RITUAL-CANDLES-ANSWERED`
- `RITUAL-PRAYER-COMPLETED`
- `RITUAL-MIRROR-RESONANCE`
- `RITUAL-HOT-BELL-COOLED`
- `RITUAL-WRONG-ORDER-SEEN`

### Semantic grouping

All eight are learned/history facts surrounding a ritual whose live machinery remains canonical (`XB`, `XC`, `LLD-FLAG`, bell/candle/book state and timers).

### Derivation lead

`RITUAL-PRAYER-COMPLETED` appears potentially redundant with persistent canonical `LLD-FLAG`, because the layer explicitly refuses to advance exorcism outside the original LLD state machine. Prove that no production path can set `LLD-FLAG` without the completion meaning represented by this history flag before deleting it.

`RITUAL-MIRROR-RESONANCE` must not be blindly replaced with `SHADOW-MIRROR-DIAGNOSED`: ritual-specific recap asks whether *ritual resonance* exposed the mirror behavior, while the shadow diagnosis can have another cause.

### Recommendation

Derive exact canonical-equivalent facts; pack remaining ritual memories in `RITUAL-MEMORY` flags state/table.

Potential reclamation: **8**.

Validation: canonical LLD progression, timers, bell/candle response histories, wrong-order observation, mirror-specific history, hot-bell cooling, CEREMONY status, recap, save/restore, ritual and persistence qualification.

---

## C06 — Material Consequences state

**Status:** `PROPOSED`  
**Source:** `glulx/material-consequences/overrides/material_consequences.zil`  
**Globals:** 11

- `MATERIAL-ROPE-ANCHOR` — object reference / current rope commitment.
- `MATERIAL-SACK-CINCHED` — boolean.
- `MATERIAL-NEST-WET` — countdown.
- `MATERIAL-SHOVEL-CLEANED`
- `MATERIAL-WRENCH-CLEANED`
- `MATERIAL-SCREWDRIVER-CLEANED`
- `MATERIAL-AXE-CLEANED`
- `MATERIAL-RUST-WET` — countdown.
- `MATERIAL-RUST-WORSE` — durable outcome.
- `MATERIAL-BOARDS-PRIED` — durable history.
- `MATERIAL-BOARDS-HARDWARE-KNOWN` — durable knowledge.

### Confirmed structural opportunity

The four `*-CLEANED` globals are already accessed through `MATERIAL-TOOL-CLEAN?` / `MATERIAL-MARK-TOOL-CLEAN`; the code itself exposes that they are one multi-object property family. A flags slot or compact indexed representation fits the existing abstraction directly.

### Derivation lead

`MATERIAL-SACK-CINCHED` appears redundant with `MATERIAL-ROPE-ANCHOR == SANDWICH-BAG`: the inspected implementation sets them together when the bag is cinched and clears them together when the knot is undone. Prove there is no other production writer before deleting the boolean.

### Recommendation

Use one coherent `MATERIAL-STATE` table with named slots for anchor reference and countdowns plus named flags for cleaned tools/history facts. Derive sack-cinched if exact equivalence is confirmed.

Potential reclamation: **11**.

Validation: rope-anchor movement limits, sack cinch/open behavior, all four cleaned tools, nest wet countdown, rusty-knife wet/worse sequence, board-pry/hardware histories, recap, cross-composition with Absurd Alternates, save/restore, material qualification.

---

## C07 — Room Density seen-state family

**Status:** `PROPOSED`  
**Source:** `glulx/room-density/overrides/room_density.zil`  
**Globals:** 7 booleans

- `ROOM-DENSITY-TROLL-SEEN`
- `ROOM-DENSITY-GALLERY-SEEN`
- `ROOM-DENSITY-STUDIO-SEEN`
- `ROOM-DENSITY-CHASM-SEEN`
- `ROOM-DENSITY-PASSAGE-SEEN`
- `ROOM-DENSITY-TREASURE-SEEN`
- `ROOM-DENSITY-PATH-SEEN`

### Semantic grouping

All seven answer one question for different promoted-scenery families: **has the player meaningfully interacted with this room-density evidence yet?**

### Recommendation

One named room-density seen-flags state/table. Pseudo scenery is not a reliable independent object-state authority, so a compact remembered-seen set is clearer than inventing fake object state.

Potential reclamation: **7**.

Validation: every pseudo-scene interaction sets the correct seen bit, recap/history remains identical, no room cross-talk, save/restore, room-density qualification.

---

# Historical leads — do not count as current savings yet

## H01 — Release 121 Adventurer Misconduct permanent-history facts

**Status:** `DISCOVERED / TRACE INTO GLULX`

Ten boolean misconduct-history globals plus `ABS-TREE-CHOPS` and `ABS-TROLL-SACKS` counters were identified in the historical source. They remain an excellent compression family if that source is still shipped in a separate release, but they are not counted against the current Glulx-line total.

## H02 — Release 121 Expanded state

**Status:** `DISCOVERED / TRACE INTO GLULX`

Eleven historical `EXP-*` globals were identified. The modern Assistance and Reactive Surface layers visibly carry cleaner descendants of some of that behavior, so historical and current state must not be double-counted.

---

# Audit backlog

Finding a global does not automatically make it a compression target.

- [x] Glulx assistance — C01.
- [x] Glulx absurd alternates — C02.
- [x] reactive surface — C03.
- [x] Dam mechanisms — C04.
- [x] ritual resonance — C05.
- [x] material consequences — C06.
- [x] room density — C07.
- [x] persistence qualification — **no production source/state added**; this is validation infrastructure, not another state family.
- [ ] shadow logic / general object-combination state.
- [ ] House of Records / expedition-history releases 1219–1230.
- [ ] parser / museum / ecology / field-system releases 1231–1242.
- [ ] Mara / natural-play releases 1243–1261.
- [ ] dragon / hostile-room state 1262.
- [x] ablative protection 1263 — known good table-state precedent; inspect only for derivable redundancy.
- [ ] perilous affordances 1264.
- [ ] consumable light 1265.
- [ ] learned magic 1266 — known table-state precedent; confirm no legacy globals added.
- [ ] semantic examination 1267 — documented zero-new-global precedent.
- [ ] clue chains 1268 — documented compact-table / zero-new-global precedent.
- [ ] post-1268 production/staged trains present on current `master`; inventory against actual staged lineage, not only planning docs.
- [ ] inherited upstream/global authorities only where representation can safely change without damaging canonical ownership.

---

# Implementation ledger

No compression has been implemented yet. Candidate approval and source changes are intentionally separate from inventory.

| ID | Before globals | After globals | Reclaimed | Validation | Durable docs |
|---|---:|---:|---:|---|---|
| — | — | — | 0 | — | — |

---

# Completion criteria

This scratch kanban is finished only when:

1. the current Highly Extended staged lineage has been inventoried enough to identify all credible semantic-compression candidates;
2. every candidate is `VALIDATED` or `REJECTED` with rationale;
3. before/after legacy-global counts are recorded for every implemented conversion;
4. exact qualification / regression evidence is recorded;
5. durable state-budget and architecture conclusions are copied into the relevant release/PR documentation; and
6. this temporary scratch file is deleted in the final documentation commit.
