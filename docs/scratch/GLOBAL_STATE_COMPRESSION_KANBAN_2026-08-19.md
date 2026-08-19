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
4. Prefer real object flags or object location when those already truthfully represent the state.
5. Do not pack unrelated values merely because they fit in one word.
6. Preserve save/restore behavior and player-visible behavior exactly unless a separate design change is explicitly approved.
7. Every implemented compression must record before/after legacy-global count and validation evidence.
8. Newer Highly Extended precedent is valid: recent trains already use constant-address mutable tables instead of casually consuming legacy globals.
9. Favor named accessors/constants over raw magic indexes or bit masks at call sites.
10. A compression candidate may be rejected when separate globals communicate genuinely separate authorities better than a packed representation.

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
| Current-line candidate globals positively identified | 12 |
| Current-line candidate families ready for decision | 2 |
| Confirmed reclaimed globals | 0 |
| Historical candidates awaiting lineage classification | 23 |

The 23 historical candidates are from older Adventurer Misconduct / Expanded Release 121-era source previously inspected. They remain useful audit leads but are **not counted as current-line savings** until their equivalents/current ownership are traced into the Glulx lineage.

---

# Decision queue

## C01 — Glulx Assistance context state

**Status:** `PROPOSED`  
**Current-line source:** `glulx/assistance/overrides/assistance.zil`

Current globals:

- `ASSIST-HINT-ROOM`
- `ASSIST-HINT-LEVEL`
- `ASSIST-LAST-FAIL`
- `ASSIST-LAST-ACTION`
- `ASSIST-LAST-PRSO`
- `ASSIST-LAST-PRSI`

### Why these are one state family

The first two are one hint-session state: **which room is being hinted and which tier is next**. The remaining four are one immediate action/failure context: **what action just happened, to what direct/indirect objects, and whether that action has a WHY explanation**.

They are not six independent world authorities. They are transient parser-assistance context owned by one subsystem.

### Recommended representation

Use one constant-address mutable table, with named slots/accessors, for example conceptually:

```zil
<CONSTANT AS-HINT-ROOM 0>
<CONSTANT AS-HINT-LEVEL 1>
<CONSTANT AS-LAST-FAIL 2>
<CONSTANT AS-LAST-ACTION 3>
<CONSTANT AS-LAST-PRSO 4>
<CONSTANT AS-LAST-PRSI 5>
<CONSTANT ASSIST-STATE <TABLE <> 0 0 <> <> <>>>
```

Exact syntax/initial values must be verified against the pinned compiler before implementation.

### Choices

- **A — Full assistance-state table (recommended):** 6 globals → 0 legacy globals for this subsystem; potential reclamation **6**.
- **B — Split tables:** hint pair in one table + action context in another; still potentially 6 → 0, with stronger conceptual separation at the cost of two table authorities.
- **C — Leave separate:** no reclamation.

### Validation requirements

- `HINT` resets tier when room changes and advances tiers identically.
- global action hook preserves `PRSA`/`PRSO`/`PRSI` behavior.
- `WHY` still describes only the immediately relevant failure.
- save/restore preserves assistance state exactly as before.
- existing assistance qualification passes unchanged.

---

## C02 — Glulx Absurd Alternates state

**Status:** `PROPOSED`  
**Current-line source:** `glulx/absurd-alternates/overrides/absurd_alternates.zil`

Current boolean globals:

- `GLULX-ALT-TROLL-DISTRACTED`
- `GLULX-ALT-TROLL-TRICK-USED`
- `GLULX-ALT-TROLL-BOUND`
- `GLULX-ALT-NEST-BURNED`
- `GLULX-ALT-EGG-CAUGHT`
- `GLULX-ALT-SACK-PREPARED`

### Why these are combinable

All six are yes/no facts owned by one bounded alternate-solutions layer. They naturally divide into two coherent subfamilies:

- **Troll alternate state:** distracted / trick-used / bound.
- **Nest alternate state:** nest-burned / egg-caught / sack-prepared.

Several are also constrained by real canonical object/world state, so implementation must avoid creating a packed parallel authority where an existing object fact can replace a boolean altogether.

### Recommended decision order

1. First test whether any boolean is redundant with truthful object/location/flag state.
2. Pack only the remaining independent alternate-history facts.
3. Prefer one named flags field/table for the subsystem, or two named flag fields if troll and nest state should remain visibly separate.

### Choices

- **A — One alternate-state flags field/table (recommended pending redundancy check):** potentially 6 globals → 0; potential reclamation **up to 6**.
- **B — Two subfamily flag fields/tables:** troll + nest; potentially still 6 → 0 while preserving conceptual separation.
- **C — One legacy-global bitfield:** 6 → 1; reclamation **5**, simpler but still consumes a scarce legacy global.
- **D — Leave separate:** no reclamation.

### Validation requirements

- troll distraction timer/recovery remains identical.
- trick-used permanence is preserved.
- bound/unbound troll behavior and canonical `TROLL-FLAG` authority remain correct.
- prepared sack, nest destruction, egg catch/break outcomes remain identical.
- `GLULX-ALT-RECAP` reports exactly the same histories.
- save/restore works across each alternate state transition.
- existing absurd-alternates qualification passes unchanged.

---

# Historical leads — do not count as current savings yet

## H01 — Release 121 Adventurer Misconduct permanent-history facts

**Status:** `DISCOVERED / TRACE INTO GLULX`

Previously identified booleans:

- `ABS-THREW-SELF`
- `ABS-THREW-TROLL`
- `ABS-THREW-VOICE`
- `ABS-THREW-FIT`
- `ABS-SACKED-TROLL`
- `ABS-KILLED-WITH-SELF`
- `ABS-ATE-NEST`
- `ABS-WORE-NEST`
- `ABS-CHOPPED-TREE`
- `ABS-MARRIED-SCENERY`

Related counters:

- `ABS-TREE-CHOPS`
- `ABS-TROLL-SACKS`

These are an excellent semantic-compression family in the historical source, but the active Glulx equivalent must be traced before assigning current-line savings.

## H02 — Release 121 Expanded state

**Status:** `DISCOVERED / TRACE INTO GLULX`

Previously identified globals:

- `EXP-HOUSE-KNOCKS`
- `EXP-BOARDS-SCARRED`
- `EXP-SONGBIRD-FOLLOWED`
- `EXP-MAIL-SLIP-FOUND`
- `EXP-TROLL-BRIBED`
- `EXP-CYCLOPS-SONG`
- `EXP-THIEF-BARGAINED`
- `EXP-BOOK-PAGE`
- `EXP-HINT-ROOM`
- `EXP-HINT-LEVEL`
- `EXP-LAST-FAIL`

Strong historical subfamilies:

- five permanent yes/no discovery/history facts → flags candidate;
- `EXP-HINT-ROOM` + `EXP-HINT-LEVEL` → one hint-state pair;
- other counters/enums require semantic inspection before grouping.

The modern assistance layer appears to carry a cleaner descendant of some hint/failure behavior, so do **not** compress both as though both independently exist in the current production build.

---

# Audit backlog

The following areas are to be inventoried for current globals and state ownership. Finding a global does not automatically make it a compression target.

- [x] Glulx assistance — first candidate family recorded as C01.
- [x] Glulx absurd alternates — first candidate family recorded as C02.
- [ ] reactive surface
- [ ] Dam mechanisms
- [ ] ritual resonance
- [ ] material consequences
- [ ] room density
- [ ] persistence
- [ ] House of Records / expedition-history releases 1219–1230
- [ ] parser / museum / ecology / field-system releases 1231–1242
- [ ] Mara / natural-play releases 1243–1261
- [ ] dragon / hostile-room state 1262
- [x] ablative protection 1263 — known good table-state precedent; inspect for no further action.
- [ ] perilous affordances 1264
- [ ] consumable light 1265
- [ ] learned magic 1266 — known table-state precedent; confirm no legacy globals added.
- [ ] semantic examination 1267 — documented zero-new-global precedent.
- [ ] clue chains 1268 — documented compact-table / zero-new-global precedent.
- [ ] any post-1268 production/staged trains present on current `master`; inventory against the actual staged lineage, not only planning docs.
- [ ] inherited upstream/global authorities only where changing representation is safe and does not damage canonical ownership.

---

# Implementation ledger

No compression has been implemented yet.

| ID | Before | After | Reclaimed | Validation | Durable docs |
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
