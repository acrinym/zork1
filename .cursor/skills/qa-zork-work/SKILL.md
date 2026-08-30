---
name: qa-zork-work
description: >-
  Loads HTE-Zork doctrine for acrinym/zork1 Highly Extended engineering: ZIL,
  parser vs prose, Glulx trains, qualify/lock, beadtrains, census, production
  leak of test verbs. Use when the workspace is zork1, files are .zil/glulx/
  patch-series/beadtrain/Glulx workflows, or the user says HTE-Zork, QA Zork,
  zork-work, described world, SURVEYKILL, leaflet-spine, empire-census, or
  artifact SHA. Do not use for historicalsource mutations, BibleMind/Unrelated,
  GUI/illustrated Zork, or a one-line question with no Zork file or train.
---

# QA Zork Work (HTE-Zork)

Repo-native quality gate for **Zork I Highly Extended** on `acrinym/zork1` `master`.

Full doctrine: [references/HTE-Zork-Highly-Extended-v1.0.md](references/HTE-Zork-Highly-Extended-v1.0.md) (also `docs/engineering/HTE-Zork-Highly-Extended-v1.0.md`). Live GitHub beats that snapshot.

**Do not set `disable-model-invocation`.** This skill is meant to auto-load from the description.

**REQUIRED SUB-SKILL when trains are named:** beadtrains. **REQUIRED BACKGROUND for Depth ≥4 debug:** hte-code.

## Agent: you must load this when

You are the Cursor/Grok agent in `acrinym/zork1`. Load this skill **before** editing or claiming qualify if **any** row matches. Do not wait for the user to name the skill.

## When this must load

Load this skill (and the HTE reference at Depth ≥3) if **any** of these are true:

| Trigger | Why |
|---|---|
| Editing `*.zil`, `glulx/**`, `patch-series.json`, Glulx workflows, or `.beads/*.beadtrain` | Stack collapse risk |
| Parser transcript vs prose (`You can't see any X`) | Described-world contract |
| Qualify/CI lock gate, SHA drift, nested predecessor | Provenance, not “CI failed” |
| Test verbs, `SURVEYKILL`, LSP*, setup teleports | Production leak |
| SYNTAX / `V?` / include order / `WINNER` | Compile-time vs actor routing |
| `.ulx` vs Glulxe vs Glk vs `.z3` | Distinct layers |
| User says HTE-Zork, QA Zork, optimize this train | Explicit |

Do **not** load for: historicalsource mutations, GUI/illustrated Zork, generic-engine design, BibleMind/Unrelated, or work outside `acrinym/zork1`.

Default depth **3/5**. Depth **5** for release trains, VM/toolchain, save/undo, or unexplained qualify failure.

## Agent entry (every session)

1. Re-query live `acrinym/zork1`: `master` SHA, open PRs, exact head, merge state.
2. Identify active train: `patch-series.json`, `qualify.sh`, changed-path contract.
3. Name the failing **layer**: ZIL / parser / world / ZILF / Z-machine / Glulx / Glulxe / Glk / provenance / test.
4. Prefer existing object/flag/table/location as owner. No parallel truth. No scenery engine.
5. Qualify: production compile → natural parser route → no test-token leak → predecessor pins → artifact lock → exact-head rerun.
6. Merge only after a fresh Justin whistle.

## Beadtrains

Validate before claiming complete:

```text
python .beads/beadtrains/scripts/validate_beadtrain.py .beads/<train>.beadtrain
```

Cars need real ids in `.beads/issues.jsonl`. Close cars when the car summary is proven; leave **capstone** open until hosted qualify + artifact lock. One PR for coupled trains unless Justin says otherwise. Writable repo is **only** `acrinym/zork1`.

## Compact card

```text
1. Live GitHub first. README/HTE snapshot is provenance, not HEAD.
2. Do not collapse parser / ZIL / ZILF / Glulx / Glulxe / Glk.
3. SYNTAX load order can create V? atoms. Include order is semantics.
4. Diagnose first parser gate: word → syntax → scope/light → action → world.
5. WINNER ≠ PLAYER on actor commands.
6. Test controls stay out of production .ulx.
7. Candidate lock-gate exit is intentional. Do not relock SHA without a cause.
8. Natural play > state injection for product claims.
9. No generic crafting/physics/AI/scenery engine.
10. Still Zork: canonical puzzles remain the authority.
```

## Optimization (this skill’s job)

- Smallest honest object/synonym, not a framework.
- Tables/flags/location before new globals.
- Fix the test when product grammar is already correct.
- Pin toolchain; do not “upgrade ZILF because 1.9 exists.”

## Output

For debug/qualify, use the HTE-Zork debug or release-qualification template in the reference (sections 42–43). Keep claims labeled E0–E5.
