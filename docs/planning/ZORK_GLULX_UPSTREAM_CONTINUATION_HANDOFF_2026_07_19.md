# Zork Glulx Upstream Continuation Handoff

## Repository and pull request

- **Repository:** `acrinym/zork1`
- **Base branch:** `master`
- **Working branch:** `agent/preservation-first-optimized-edition`
- **Pull request:** #1 — `Add preserved, optimized, and expanded Zork I with comedy reactivity`
- **PR policy:** keep PR #1 open, ready for review, and unmerged unless Justin explicitly requests a merge.

Do not trust any frozen SHA, commit count, review count, workflow state, or upstream version in this handoff. At the start of the next chat, resolve the exact live branch head, current `master`, merge base, PR state and body, changed files, comments, reviews, inline review threads, workflow runs, checks, and branch drift.

At the moment immediately before this handoff file was committed, the branch included documentation through commit `88146d9c8c0bbd60ed0da813a6b4c994e189abd5`. The handoff commit itself advances the branch beyond that value, so the next agent must resolve the live head rather than treating it as current.

## Starting prompt for the next chat

Use the following as the controlling instruction:

> Continue Zork I in `acrinym/zork1` from `docs/planning/ZORK_GLULX_UPSTREAM_CONTINUATION_HANDOFF_2026_07_19.md`.
>
> Work on branch `agent/preservation-first-optimized-edition` and continue PR #1, `Add preserved, optimized, and expanded Zork I with comedy reactivity`.
>
> PR #1 must remain open, ready, and unmerged unless I explicitly request otherwise.
>
> Begin by resolving the exact live branch head, current `master`, merge base, PR body and state, changed files, comments, review submissions, inline review threads, workflow runs, checks, and branch drift. Do not trust frozen SHAs or counts in the handoff.
>
> Fix actionable review feedback first. Then begin the controlling **Glulx upstream reconciliation train**. Do not invent a new VM or a new ZIL-to-Glulx compiler backend. Reconcile with Tara McGrew's existing `taradinoc/zork1` `glulx` branch and a current, explicitly pinned ZILF/Glazer toolchain.
>
> Build and qualify the unchanged upstream Glulx baseline before porting Release 120 or Release 121 changes. Preserve all historical and `.z3` editions. Establish licensing provenance, deterministic CI, native Glulx execution, artifact verification, and semantic transcript parity before adding new gameplay features.

## Why the project direction changed

The repository had treated Glulx as a conceptual future migration. That assumption is obsolete.

Tara McGrew published a playable and winnable Zork I Glulx port on December 4, 2025. The public discussion identifies:

- repository: `taradinoc/zork1`;
- branch: `glulx`;
- source comparison: `master...glulx`;
- archived artifact: `zork1-glulx.zip`;
- artifact identity: Release 1 / serial `251203`;
- ZILF 1.0 experimental Glulx support through Glazer.

Therefore, this project is not facing a greenfield compiler-backend problem. The correct task is to reconcile the current preservation/optimized/expanded architecture with an existing upstream ZIL-to-Glulx path.

## Licensing conclusion

The software path is permissive, with important documentation and branding boundaries.

### Zork source

The repository-root `LICENSE` is MIT, copyright Microsoft (2025). It permits use, modification, merging, publication, distribution, sublicensing, and sale, subject to retaining the copyright and permission notice in copies or substantial portions.

### Tara's Glulx branch

`taradinoc/zork1` branch `glulx` contains the same MIT `LICENSE` file. The IF Archive also describes `zork1-glulx.zip` as released under the same MIT license as the original source.

### Glulx

The Glulx VM specification states that the VM it describes is an idea and anyone may create programs, compilers, interpreters, debuggers, and related implementations for it.

The **specification document itself**, version 3.1.3, is licensed CC BY-NC-SA 4.0. Do not copy substantial specification prose into commercial documentation. Link to the specification and write independent implementation documentation.

The Glulxe reference interpreter is MIT licensed.

### Branding

The Microsoft source release explicitly does not grant rights to trademarks, brands, commercial packaging, or marketing materials. Keep local release identities visibly unofficial and do not imply Microsoft, Activision, Xbox, or Infocom endorsement.

Read and follow:

- `expanded/docs/GLULX_LICENSING.md`

## Existing project identities

| Edition | Identity | Purpose |
|---|---:|---|
| Historical | Release 119 / serial `880429` / `.z3` | Original repository-root source and compiled story, untouched |
| Optimized | Release 120 / serial `260718` / `.z3` | Conservative bug, portability, build, and audit corrections |
| Expanded | Release 121 / serial `260719` / `.z3` | Reactive world, alternate reasoning, assistance, character behavior, and Adventurer Misconduct |
| Planned Glulx | New repository-local identity / `.ulx` or `.gblorb` | Long-term expanded platform, parity first |

The Glulx edition is additive. It must not replace, relabel, or mutate the existing three identities.

## Completed work on PR #1

### Preservation and optimized edition

- Historical repository-root sources remain untouched.
- Exact historical Git blobs are verified before staging.
- Release 120 includes recursive-containment protection, corrected candle descriptions, safe printed characters, include portability, deterministic builds, structural auditing, and artifact verification.

### Expanded Release 121

Release 121 currently includes:

- reactive house, boards, doors, windows, mailbox, forest, and environmental objects;
- optional songbird and Hidden Glade content;
- contextual `GOALS`, `EXITS`, `HINT`, `RECAP`, `WHY`, and `USE <object>` assistance;
- genuine-treasure troll bribery;
- cyclops lullaby and thief bargain alternatives;
- persistent world and NPC outcomes;
- extensive Adventurer Misconduct grammar and reactions;
- discovered-only `FOLLY`, `NONSENSE`, and `MISCHIEF` ledger;
- troll bemusement without weakening or bypassing the canonical threat.

### Version 3 object-table constraint

The version 3 world uses the complete 255-object table. Release 121 therefore reuses existing parser objects:

- `ME` for `SELF` and `MYSELF`;
- a lightweight blessings global for `VOICE` and `WORDS`;
- `HANDS` for `FIT`.

This workaround is valid for the `.z3` compatibility edition but should be removed in the Glulx edition after parity is established.

### Completed beadtrains

- `.beads/onyx_zork_reactive_world.beadtrain`
- `.beads/onyx_zork_living_underground.beadtrain`
- `.beads/onyx_zork_adventurer_misconduct.beadtrain`

All three were complete and all 30 live beads were closed at the last verified pre-handoff state. Re-resolve this before relying on it.

### Last fully validated pre-Glulx artifact

The last fully validated expanded `.z3` artifact before the documentation pivot was:

- file: `zork1-expanded.z3`;
- Z-machine version: 3;
- release: 121;
- serial: `260719`;
- size: 105,374 bytes;
- checksum: 43,405, valid;
- SHA-256: `1c055ec839e60ced36c996c69b9df5f3c2b4bc70dcfa0b5c641e6c6f0c1a9002`.

The exact-head GitHub Actions run was `29678701697` on pre-documentation head `9de178a2dd5a0bd49fa20e7f84414cf6ad278cdf`. Both preservation and optimized/expanded build jobs passed. The documentation commits added after that run may trigger newer checks; resolve their live state.

## Documentation added for this pivot

- `expanded/docs/GLULX_UPSTREAM_MIGRATION.md`
- `expanded/docs/GLULX_LICENSING.md`
- `expanded/docs/NEXT_TRAINS.md` now makes Glulx reconciliation the controlling next train.
- `expanded/README.md` now links and summarizes the migration direction.
- this handoff: `docs/planning/ZORK_GLULX_UPSTREAM_CONTINUATION_HANDOFF_2026_07_19.md`

## Controlling implementation direction

Read these first:

1. `AGENTS.MD` and any nearer repository guidance, if present;
2. this handoff;
3. `expanded/docs/GLULX_UPSTREAM_MIGRATION.md`;
4. `expanded/docs/GLULX_LICENSING.md`;
5. `expanded/docs/DESIGN_CHARTER.md`;
6. `expanded/docs/VALIDATION.md`;
7. `expanded/docs/FEATURE_MATRIX.md`;
8. `expanded/docs/NEXT_TRAINS.md`;
9. `optimized/docs/PRESERVATION_POLICY.md`;
10. `.beads/issues.jsonl` and all completed beadtrain files;
11. the current workflow and build tooling.

## Glulx train execution order

### 1. Resolve live upstreams

Resolve and pin:

- `taradinoc/zork1` branch `glulx`, exact head;
- Tara's current `master`, merge base, and complete branch diff;
- the IF Archive `zork1-glulx.zip` artifact and its contents;
- a current stable ZILF release and exact commit;
- matching Glazer assembler version and exact commit;
- Glulxe and the selected Glk implementation for deterministic CI;
- optionally Quixe later, after native baseline success.

Do not rely on the December 2025 versions or any version named here without checking current upstream state.

### 2. Add provenance before code import

Create a provenance manifest recording:

- repository URLs;
- exact commits;
- license paths and checksums;
- imported paths;
- local modifications;
- build tools and interpreter pins.

No imported source should land without this record.

### 3. Build unchanged upstream baseline

First produce Tara's upstream Glulx Zork without Release 120 or 121 modifications.

Required outputs:

- `.ulx` artifact;
- compiler and assembler logs;
- staging/provenance receipt;
- Glulx header, length, checksum, release, and serial report;
- native interpreter smoke transcript;
- CI artifact bundle.

### 4. Port Release 120

Port conservative fixes and audit behavior first. Do not intermingle gameplay expansion with the base migration.

### 5. Port Release 121 in layers

Recommended order:

1. action hooks and optional assistance;
2. reactive scenery and state-aware world objects;
3. songbird and Hidden Glade;
4. troll, cyclops, and thief alternate reasoning;
5. Adventurer Misconduct grammar and reactions;
6. `FOLLY` and troll bemusement.

Compile and run focused routes after every layer.

### 6. Establish semantic differential parity

Do not require byte-for-byte or whitespace-identical transcripts across Z-machine and Glulx interpreters. Compare:

- rooms reached;
- object movement and ownership;
- score and moves where stable;
- NPC state;
- puzzle outcomes;
- exits and world mutations;
- player survival;
- required prose markers.

Normalize interpreter-only wrapping and presentation differences.

### 7. Remove version 3 compromises

Only after Release 121 parity:

- create honest dedicated Glulx concepts or objects for `VOICE`, `WORDS`, and `FIT`;
- remove carrier reuse in the Glulx lineage;
- add richer object and persistent-state structure where justified;
- keep the `.z3` compatibility implementation intact and documented.

### 8. Product capabilities come later

After standard Glulx success, consider standard Glk graphics, sound, hyperlinks, Unicode, browser packaging, accessibility, autosave, and richer UI.

Do not begin with a proprietary interpreter fork, custom opcode set, AI host protocol, or new VM. Any future host extension must be optional and incapable of breaking ordinary Glulx play.

## Qualification frontier

The existing `.z3` edition still deserves dedicated isolated routes for:

- cyclops lullaby timing;
- thief bargaining;
- full bell/candles/book ceremony;
- dam high- and low-water states;
- save and restore after expanded persistent changes;
- recursive-container and extinguished-candle regressions.

The troll treasure bribe already has broad transcript coverage but should receive an isolated semantic parity route during migration.

## Non-goals for the first Glulx train

- no new continent or broad geography expansion;
- no room-density mega-wave;
- no new NPC chat system;
- no custom VM;
- no replacement compiler backend;
- no proprietary-only story artifact;
- no removal of `.z3` support;
- no branding that implies an official Zork release;
- no merge of PR #1 without Justin's explicit instruction.

## Definition of first-train success

The first Glulx reconciliation train is complete only when:

- upstream and toolchain commits are pinned and documented;
- license and provenance gates pass;
- unchanged upstream Zork Glulx builds deterministically in this repository;
- a standard native Glulx interpreter runs the artifact in CI;
- verification and smoke artifacts are uploaded;
- the existing historical, optimized, and expanded `.z3` builds still pass;
- PR #1 remains open and unmerged;
- the next porting layer is documented precisely.

## Primary external references

- Tara repository: <https://github.com/taradinoc/zork1>
- Tara branch comparison: <https://github.com/taradinoc/zork1/compare/master...glulx>
- Zork I for Glulx discussion: <https://intfiction.org/t/zork-i-for-glulx/78103>
- IF Archive artifact: <https://ifarchive.org/if-archive/games/glulx/zork1-glulx.zip>
- ZILF: <https://github.com/taradinoc/zilf>
- Glulx specification: <https://eblong.com/zarf/glulx/Glulx-Spec.html>
- Glulxe: <https://github.com/erkyrath/glulxe>
- Quixe: <https://github.com/erkyrath/quixe>
- Microsoft source-release notes: <https://opensource.microsoft.com/blog/2025/11/20/preserving-code-that-shaped-generations-zork-i-ii-and-iii-go-open-source/>
