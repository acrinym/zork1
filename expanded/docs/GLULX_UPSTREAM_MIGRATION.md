# Glulx upstream migration

## Decision

The long-term expanded lineage is migrating from Z-machine version 3 to Glulx by reconciling with Tara McGrew's existing `taradinoc/zork1` branch `glulx` and a pinned ZILF/Glazer toolchain.

This is an **upstream reconciliation and semantic-parity project**, not a greenfield virtual-machine or compiler-backend project.

## Current migration status

| Train | Identity | Status |
|---|---:|---|
| A — unchanged upstream baseline | Release 1 / serial `251203` | Qualified |
| B — conservative optimized parity | Release 1201 / serial `260719` | Qualified |
| C1 — Release 121 action hooks and assistance | not assigned | Controlling next train |
| C2 — reactive scenery and world state | not assigned | Planned after C1 |
| C3 — optional geography and living characters | not assigned | Planned after C2 |
| D — remove version 3 compromises | not assigned | Planned after Release 121 parity |
| E — standard Glulx product capabilities | not assigned | Later product work |

## Product line

| Line | Artifact | Role |
|---|---|---|
| Historical | Release 119 / `.z3` | Untouched preservation artifact |
| Optimized | Release 120 / `.z3` | Conservative corrected Z-machine edition |
| Expanded compatibility | Release 121 / `.z3` | Reactive and comedic compatibility edition |
| Unchanged upstream Glulx | Release 1 / `.ulx` | Qualified Tara baseline and archive reference |
| Optimized Glulx | Release 1201 / `.ulx` | Qualified conservative Release 120 port |
| Expanded Glulx | future repository-local `.ulx` | Long-term expanded platform, migrated in isolated parity layers |

No Glulx artifact replaces or relabels an existing `.z3` identity.

## Why Glulx

Release 121 occupies the complete Z-machine version 3 object table and must reuse unrelated parser globals for concepts such as `VOICE` and `FIT`. Glulx provides 32-bit values and addresses, substantially larger memory, Glk I/O, heap allocation, Unicode, and established native and browser interpreters.

That removes the pressure that forced the zero-slot noun design while preserving the compiled, portable interactive-fiction artifact model.

## Resolved upstream foundation

The repository now pins:

- Tara Zork Glulx commit `1ada70e58ac4933446b907d67949d9cab3119c0e`;
- Tara Glulx tree `02b34128649bbb7fcddf99136e03fb67c032b089`;
- upstream `master` and merge base `97b7b3d68c075dd9af7da499c3e9690ada3471fd`;
- the complete seven-file upstream delta;
- ZILF 1.8 commit `45c60f1e37651f266ac92d49ae01748bb4909fa5`;
- Glazer 1.2.0 commit `1cc80bcdefb4b4125185e1170eb1ee178e97ff5a` and source tarball SHA-256;
- Glulxe commit `56ab8743bab565de307bd892c555d8d8897ed517`;
- CheapGlk commit `14d8aaf6e4150669762bd4646a5368e75c1eeee6`;
- the IF Archive ZIP and archived story checksums.

Future trains must still check for upstream drift before intentionally changing any pin.

## Controlling migration rules

1. **Parity before expansion.** Add no unrelated rooms, puzzles, media, or runtime extensions during a parity layer.
2. **Preservation remains immutable.** Repository-root historical files and Release 119 remain untouched.
3. **Existing `.z3` editions remain first-class.** Glulx adds artifacts; it does not silently replace Release 120 or 121.
4. **Source changes must be reviewable.** Use exact overlays, patch manifests, changed-path gates, and before/after hashes.
5. **No invented compiler backend.** Use pinned ZILF and Glazer unless a specific upstream defect directly blocks migration.
6. **No custom VM fork.** Target standard Glulx and standard Glk first.
7. **Determinism is a release requirement.** Pin upstreams, downloaded source hashes, generated identity normalization, and final artifact hashes.
8. **Licensing and provenance are build inputs.** Follow [`GLULX_LICENSING.md`](GLULX_LICENSING.md).
9. **Every layer remains separately reproducible.** The unchanged baseline and optimized port continue building after expanded layers begin.
10. **A passing Glulx gate cannot excuse a failing `.z3` gate.** Every edition keeps its own qualification boundary.

## Train A — unchanged upstream baseline — complete

The completed baseline provides:

- exact upstream reconciliation and provenance;
- pinned compiler, assembler, interpreter, and Glk implementation;
- unchanged upstream compilation;
- deterministic normalization of ZILF's wall-clock metadata serial;
- Glulx header, memory-map, checksum, size, and SHA verification;
- archive ZIP inspection and member checksums;
- native execution of repository and archived stories;
- license and build receipts;
- artifact upload.

Qualified repository artifact:

- `zork1-glulx-upstream.ulx`;
- Release 1 / serial `251203`;
- 180,736 bytes;
- checksum `0xad5a809b`;
- SHA-256 `15dd2b654693e4f1c63e09a2308de1f366913c13be080baa33af3f76c5679ac8`.

## Train B — optimized parity — complete

The optimized layer stages Tara's exact commit and tree and allows only four changed paths:

- `1actions.zil`;
- `1dungeon.zil`;
- `gverbs.zil`;
- `zork1.zil`.

It ports:

- recursive-containment prevention;
- printed-character portability corrections;
- a Glulx-specific fully dynamic candle room description;
- state-aware candle prose;
- exact lowercase includes;
- structural auditing;
- repository-local Release `1201` identity.

Qualified artifact:

- `zork1-glulx-optimized.ulx`;
- Release 1201 / serial `260719`;
- 180,992 bytes;
- checksum `0xaa478295`;
- SHA-256 `f2f64b0696e91f325602f6d4f1a91182a940bfd28105576662bd54bdeb37d051`.

Focused native routes prove:

- opening identity and normal command handling;
- recursive-container rejection while preserving valid nesting;
- extinguished candles are never described by the stale static burning sentence.

## Train C1 — action hooks and assistance — controlling next train

Port only:

1. Release 121 action-hook foundation;
2. `GOALS`;
3. `EXITS`;
4. tiered `HINT`;
5. `RECAP`;
6. contextual `WHY`;
7. `USE <object>` affordance guidance.

Requirements:

- stage from qualified Release 1201;
- use exact changed-path and patch boundaries;
- assign a new unofficial Glulx identity;
- retain baseline and Release 1201 artifacts;
- run equivalent opening and assistance routes on `.z3` and `.ulx`;
- compare semantic milestones and required prose markers rather than whitespace-identical transcripts;
- prove every historical and `.z3` gate still passes;
- leave reactive scenery and gameplay expansion out of this train.

## Train C2 — reactive scenery and world state

After assistance parity, port:

- house, boards, doors, windows, and mailbox;
- forest behavior;
- dam and control panel;
- ritual objects;
- rope, mirror, water, and tool reactions;
- persistent expanded state.

Compile and run focused semantic routes after each group.

## Train C3 — optional geography and living characters

Port in this order:

1. songbird and Hidden Glade;
2. troll bribe;
3. cyclops lullaby;
4. thief bargain;
5. Adventurer Misconduct actions;
6. `FOLLY` and troll bemusement.

## Train D — remove version 3 compromises

Only after Release 121 semantic parity:

- replace `VOICE`, `WORDS`, and `FIT` carrier reuse with dedicated Glulx concepts or objects;
- remove version 3-only object-slot workarounds from the Glulx lineage;
- model additional persistent character and world state directly;
- keep the `.z3` architecture intact and documented.

## Train E — standard Glulx product capabilities

Use standard Glk capabilities before inventing custom host contracts:

- Unicode and typography;
- hyperlinks and optional command affordances;
- graphics and sound resources where appropriate;
- robust save, restore, undo, and autosave qualification;
- browser packaging through a standard interpreter;
- accessible window and input behavior.

Any richer host protocol must be optional, capability-detected, documented separately, and unable to break ordinary Glulx play.

## Semantic parity strategy

Exact transcript equality is not required across VMs because wrapping, status presentation, RNG behavior, and interpreter messages may differ.

### Stable facts

Assert:

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

Run equivalent command scripts against `.z3` and `.ulx`, normalize interpreter-only differences, and compare milestones and required markers.

## Qualification route backlog

Already isolated on optimized Glulx:

- recursive-container rejection;
- extinguished-candle descriptions.

Required during Release 121 layers:

- opening assistance commands;
- house and cellar path;
- troll canonical confrontation and treasure bribe;
- cyclops canonical routes and lullaby timing;
- thief bargain and later state;
- complete bell/candles/book ceremony;
- dam high- and low-water states;
- save and restore after expanded persistent changes;
- representative `SELF`, `VOICE`, `FIT`, nest, tree, and troll misconduct;
- `FOLLY` discovered-only behavior;
- broad canonical or full-score route after focused suites stabilize.

## Definition of migration success

The full migration succeeds when:

- all historical and Z-machine artifacts still build and verify;
- every Glulx layer builds from pinned, documented sources;
- Release 121 semantic parity suites pass;
- save/restore and persistent expanded state are qualified;
- the Glulx source no longer depends on version 3 object-slot tricks;
- licensing and provenance records ship with artifacts;
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
