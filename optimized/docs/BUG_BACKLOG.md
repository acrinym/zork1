# Behavioral Bug Ledger

This ledger separates confirmed defects from historical reports and speculative cleanup. A reported oddity is not automatically a bug, and a bug is not automatically safe to patch.

## Status meanings

- **Source-confirmed** — the defect is visible in this exact Release 119 source.
- **Patched, runtime pending** — a narrow source fix exists, but the rebuilt story and player transcript still need ZILF/Frotz validation.
- **Reproduction needed** — historically reported, but not yet demonstrated in this exact source/build.
- **Intent review** — behavior may be deliberate, edition-specific, or part of classic parser character.

## Z1-BUG-001 — Recursive containment corrupts the object tree

**Status:** Patched, runtime pending  
**Area:** Generic `PUT` / container behavior  
**Risk:** High state corruption, low patch breadth

### What was broken

`V-PUT` rejects putting an object into itself and rejects putting an object into a container that already directly contains it. It does not reject putting a container into one of that container’s descendants.

That permits sequences equivalent to:

1. Put container B inside container A.
2. Put container A inside container B.

The second move creates a cycle in a data structure that is intended to be a tree. Objects in that cycle can disappear from ordinary room/inventory traversal and later routines can follow malformed parent links.

### Why the fix preserves intent

The patch does not alter capacity, weight, openness, parser resolution, scoring, or normal nesting. It adds one ancestry guard before the existing `MOVE` operation and reuses the existing self-containment response: `How can you do that?`

Legitimate nesting still works. Only a move that would make an object its own ancestor is rejected.

### Implementation

`optimized/patches/001-prevent-containment-cycles.json` inserts a small `OPT-DESCENDANT?` ancestry check and extends the existing self-containment condition. The patch uses exact source anchors and fails closed if the verified historical text no longer matches.

### Remaining proof

- Compile the staged edition with ZILF/ZAPF.
- Run a transcript that exercises the classic raft/coffin cycle or an equivalent pair of portable containers.
- Confirm ordinary nested containers still work.
- Confirm save, restore, inventory, room descriptions, and object traversal remain stable afterward.

## Candidates awaiting reproduction

### Clock table exhaustion

The scheduler has 30 fixed interrupt slots. There is no demonstrated Release 119 route that exhausts them, so increasing the table would currently be speculative and could alter memory layout.

### Historical unused symbols

The preserved compiler report lists eight unused symbols. They may be dead, generated, version-conditional, or compatibility hooks. None will be deleted until call-site and build evidence proves removal is behavior-neutral.

### Parser pronoun state during synthetic actions

`PERFORM` updates global `IT` state while actions can invoke other actions. This is fragile, but fragility alone is not a defect. It needs concrete command transcripts before modification.

### Release 88 versus Release 119 differences

This repository represents Release 119, a final-development build. Differences from Release 88 may be fixes, experiments, compiler accommodations, or unfinished changes. They will be cataloged rather than flattened into one assumed “correct” version.
