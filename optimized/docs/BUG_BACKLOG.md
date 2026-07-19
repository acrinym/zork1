# Behavioral Bug Ledger

This ledger separates confirmed defects from historical reports and speculative cleanup. A reported oddity is not automatically a bug, and a bug is not automatically safe to patch.

## Status meanings

- **Source-confirmed** — the defect is visible in this exact Release 119 source.
- **Compiled and smoke-tested** — the patch is present in a verified runnable story, but its dedicated gameplay route may still be pending.
- **Targeted runtime verified** — a player transcript directly demonstrates the defect before and corrected behavior after the patch.
- **Reproduction needed** — historically reported, but not yet demonstrated in this exact source/build.
- **Intent review** — behavior may be deliberate, edition-specific, or part of classic parser character.

## Z1-BUG-001 — Recursive containment corrupts the object tree

**Status:** Compiled and smoke-tested; targeted runtime verification pending  
**Area:** Generic `PUT` / container behavior  
**Risk:** High state corruption, low patch breadth

### What was broken

`V-PUT` rejects putting an object into itself and rejects putting an object into a container that already directly contains it. It did not reject putting a container into one of that container’s descendants.

That permits sequences equivalent to:

1. Put container B inside container A.
2. Put container A inside container B.

The second move creates a cycle in a data structure intended to be a tree. Objects in that cycle can disappear from ordinary room or inventory traversal, and later routines can follow malformed parent links.

### Why the fix preserves intent

The patch does not alter capacity, weight, openness, parser resolution, scoring, or normal nesting. It adds one ancestry guard before the existing `MOVE` operation and reuses the existing self-containment response: `How can you do that?`

Legitimate nesting still works. Only a move that would make an object its own ancestor is rejected.

### Implementation

`optimized/patches/001-prevent-containment-cycles.json` inserts `OPT-DESCENDANT?` and extends the existing self-containment condition. The patch uses exact source anchors and fails closed if the verified historical text no longer matches.

### Validation state

The patch applies exactly, passes structural checks, compiles into Release 120, and coexists with a passing Frotz opening route.

Still needed:

- exercise the classic raft/coffin cycle or an equivalent pair of portable containers;
- confirm ordinary nesting remains valid;
- confirm save, restore, inventory, room descriptions, and traversal remain stable after the rejected move.

## Z1-BUG-002 — Extinguished candles remain “burning” in room descriptions

**Status:** Compiled and smoke-tested; targeted runtime verification pending  
**Area:** Object room description  
**Risk:** Low state inconsistency, minimal patch breadth

### What was broken

The temple candle object used a static first-description string saying the candles were burning. Candle actions and timers can clear `ONBIT`, but the static room description did not consult that state.

### Why the fix preserves intent

The new description callback reproduces the original sentence while `ONBIT` is set. When the candles are off, it removes only the inaccurate state word and prints `On the two ends of the altar are candles.`

The timer, remaining burn time, light flags, parser vocabulary, object location, score, and puzzle logic are unchanged.

### Implementation

- `003-candles-description-object.json` attaches `CANDLES-D` as `DESCFCN`.
- `004-candles-description-routine.json` inserts the state-aware callback before the existing action routine.

Both patches use exact source anchors and apply once.

### Validation state

The patches pass structural checks, compile into Release 120, and coexist with a passing Frotz opening route.

Still needed:

- capture the South Temple description while the candles are lit;
- extinguish the candles through ordinary play;
- capture the same room description with `ONBIT` cleared.

## Z1-PORT-001 — Literal printed tabs are unsafe in Z-machine version 3

**Status:** Targeted compiler verification complete  
**Area:** Printed guidebook and tube text  
**Risk:** Portability only

Two player-facing strings contained literal tab characters. Modern ZILF warned that Z-machine version 3 cannot safely represent them. The patch replaces exactly those two characters with spaces and leaves the words unchanged.

The CI compile rejects any remaining `ZIL0410` warning. The Release 120 build passes that check.

## Classified smells retained for investigation

### Generic/game-specific redefinitions

`LUCKY` and `WON-FLAG` are each defined in both generic and game-specific source layers. This matches the historical `REDEFINE T` composition model closely enough that deletion would be reckless. They remain visible audit warnings until build and behavior evidence justifies a stronger classification.

### Clock table exhaustion

The scheduler has 30 fixed interrupt slots. There is no demonstrated Release 119 route that exhausts them, so increasing the table would currently be speculative and could alter memory layout.

### Historical unused symbols

The preserved compiler report lists eight unused symbols. They may be dead, generated, version-conditional, or compatibility hooks. None will be deleted until call-site and behavior evidence proves removal is neutral.

### Parser pronoun state during synthetic actions

`PERFORM` updates global `IT` state while actions can invoke other actions. This is fragile, but fragility alone is not a defect. It needs concrete command transcripts before modification.

### Release 88 versus Release 119 differences

This repository represents Release 119, a final-development build. Differences from Release 88 may be fixes, experiments, compiler accommodations, or unfinished changes. They will be cataloged rather than flattened into one assumed “correct” version.
