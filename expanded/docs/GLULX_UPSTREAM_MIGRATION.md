# Glulx upstream migration

## Decision

The long-term expanded lineage will migrate from Z-machine version 3 to Glulx by reconciling with the existing upstream work in Tara McGrew's `taradinoc/zork1` branch `glulx` and a modern ZILF/Glazer toolchain.

This replaces the earlier repository assumption that Glulx support was only a future concept. A playable and winnable Zork I Glulx port was published in December 2025, and ZILF gained experimental Glulx output through Glazer.

The migration is therefore an **upstream reconciliation and parity project**, not a greenfield virtual-machine or compiler-backend project.

## Product line after migration

| Line | Artifact | Role |
|---|---|---|
| Historical | Release 119 / `.z3` | Untouched preservation artifact |
| Optimized | Release 120 / `.z3` | Conservative corrected Z-machine edition |
| Expanded compatibility | Release 121 / `.z3` | Current reactive and comedic edition, retained as a compact compatibility build |
| Expanded Glulx | New repository-local release / `.ulx` or `.gblorb` | Long-term expanded platform with parity first and additional capacity later |

The Glulx edition must not replace or rewrite the three existing identities.

## Why Glulx

The current Release 121 occupies the complete Z-machine version 3 object table and must reuse unrelated parser globals to recognize concepts such as `VOICE` and `FIT`. Glulx provides 32-bit values and addresses, substantially larger memory, Glk I/O, heap allocation, Unicode, and established native and browser interpreters.

That removes the architectural pressure that forced the zero-slot noun design while preserving the compiled, portable interactive-fiction artifact model.

## Existing upstream foundation

The first implementation train must resolve and pin, rather than assume:

- `taradinoc/zork1`, branch `glulx`, exact live head;
- its merge base and complete diff against Tara's current `master`;
- the archived `zork1-glulx.zip`, Release 1 / serial `251203`;
- the current stable ZILF release and exact commit selected for this repository;
- the matching Glazer assembler version and exact commit;
- a deterministic command-line Glulx interpreter for CI, preferably Glulxe with a suitable Glk implementation;
- an optional browser interpreter baseline such as Quixe for later product work.

Do not trust release numbers, branch heads, or tool versions frozen in this document. Re-resolve them at train start.

## Controlling migration rules

1. **Parity before expansion.** Do not add new rooms, puzzles, media, or runtime extensions until the upstream Glulx baseline builds deterministically and Release 121 behavior has a credible parity harness.
2. **Preservation remains immutable.** Repository-root historical files and Release 119 remain untouched.
3. **Existing `.z3` editions remain first-class.** The Glulx train adds a new artifact; it does not silently relabel or replace Release 121.
4. **Source changes must be reviewable.** Prefer explicit overlays, manifests, or clearly documented source forks over opaque generated rewrites.
5. **No invented compiler backend.** Use modern ZILF and Glazer unless a specific upstream defect directly blocks the migration.
6. **No custom VM fork at the start.** Target standard Glulx and standard Glk first. Host extensions belong after portable baseline success.
7. **Determinism is a release requirement.** Pin upstream commits, verify checksums, control RNG in transcripts where supported, and fail closed when expected source no longer matches.
8. **Licensing and provenance are build inputs.** Follow [`GLULX_LICENSING.md`](GLULX_LICENSING.md) and record every imported upstream component.

## Train A — upstream baseline

Deliverables:

- provenance manifest for Tara's branch, ZILF, Glazer, and interpreter;
- repository-local tool bootstrap with exact pins;
- an unchanged upstream Glulx build;
- verification of Glulx header, version, checksum, release, serial, and story identity;
- a deterministic smoke transcript proving startup, movement, object handling, save/restore, and clean exit;
- CI artifact containing the baseline `.ulx`, build receipt, compiler log, verifier report, and transcript.

This stage must not carry Release 120 or 121 changes yet.

## Train B — optimized parity

Port the conservative Release 120 changes onto the Glulx source path:

- recursive-containment prevention;
- state-aware candle descriptions;
- unsafe output-character correction;
- include and path portability;
- structural auditing appropriate to Glulx output;
- deterministic build and artifact verification.

Prove that the optimized Glulx edition retains canonical puzzle behavior before proceeding.

## Train C — expanded parity

Port Release 121 in coherent layers:

1. expanded action hooks and contextual assistance;
2. reactive house, forest, dam, ritual, rope, mirror, and tool behavior;
3. optional songbird and Hidden Glade path;
4. troll bribe, cyclops lullaby, and thief bargain;
5. Adventurer Misconduct grammar, reactions, `FOLLY`, and troll bemusement.

Each layer should compile and pass focused transcripts before the next layer lands.

## Train D — remove version 3 compromises

Only after parity:

- replace `VOICE`, `WORDS`, and `FIT` carrier reuse with honest dedicated objects or parser concepts;
- remove any version 3-only object-slot workarounds;
- model additional persistent character and world state directly;
- increase scenery density where it improves understandable interaction;
- keep old `.z3` behavior and architecture documented rather than pretending the compromises never existed.

## Train E — standard Glulx product capabilities

Use standard Glk capabilities before inventing custom host contracts:

- Unicode and typography;
- hyperlinks and optional command affordances;
- graphics and sound resources where appropriate;
- robust save, restore, undo, and autosave qualification;
- browser packaging through a standard interpreter;
- accessible window and input behavior.

Any richer structured-event or companion-runtime protocol must be optional, capability-detected, documented separately, and unable to corrupt ordinary Glulx play.

## Parity strategy

Exact transcript equality is not always realistic across VMs because wrapping, status presentation, RNG behavior, and interpreter messages may differ. Qualification should therefore use three levels:

### Semantic parity

Assert stable facts:

- room reached;
- object acquired, moved, consumed, or preserved;
- score and move count where meaningful;
- NPC state;
- exits opened or blocked;
- player survival;
- puzzle outcome.

### Required prose markers

Assert key canonical and expanded lines without requiring identical whitespace or presentation framing.

### Differential routes

Run equivalent command scripts against `.z3` and `.ulx`, normalize interpreter-only differences, and compare resulting milestones and required prose markers.

## Required first qualification routes

- opening house and cellar path;
- troll canonical confrontation and treasure bribe;
- cyclops canonical routes and lullaby timing;
- thief bargain and later state;
- complete bell/candles/book ceremony;
- dam high- and low-water states;
- save and restore after expanded persistent changes;
- recursive-container rejection;
- extinguished-candle descriptions;
- representative `SELF`, `VOICE`, `FIT`, nest, tree, and troll misconduct;
- `FOLLY` discovered-only behavior;
- full-score or broad canonical walkthrough when the focused suite is stable.

## Naming

Do not assign the Glulx artifact an official-looking Infocom release identity. Select a repository-local release number and serial only after the baseline is reproducible. Documentation must state plainly that it is an unofficial expanded edition derived from the MIT-licensed source.

## Definition of migration success

The migration is successful when:

- all historical and Z-machine artifacts still build and verify;
- the Glulx artifact builds from pinned, documented sources in CI;
- the baseline and expanded parity suites pass;
- save/restore and persistent expanded state are qualified;
- the Glulx source no longer depends on version 3 object-slot tricks;
- licensing and provenance records ship with the artifact;
- the game runs in at least one native and one browser-capable standard Glulx interpreter;
- no custom runtime is required for ordinary play.

## Upstream references

- Tara's repository: <https://github.com/taradinoc/zork1>
- Tara's Glulx branch comparison: <https://github.com/taradinoc/zork1/compare/master...glulx>
- Zork I for Glulx announcement: <https://intfiction.org/t/zork-i-for-glulx/78103>
- Archived build: <https://ifarchive.org/if-archive/games/glulx/zork1-glulx.zip>
- ZILF: <https://github.com/taradinoc/zilf>
- Glulx specification: <https://eblong.com/zarf/glulx/Glulx-Spec.html>
- Glulxe: <https://github.com/erkyrath/glulxe>
- Quixe: <https://github.com/erkyrath/quixe>
