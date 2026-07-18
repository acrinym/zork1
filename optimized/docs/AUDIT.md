# Initial Code and Build Audit

## Scope

This audit covers the repository’s Release 119 / serial 880429 final-development snapshot and its historical build records. It does not assume that Release 119 is identical to the commercially distributed Release 88.

## Confirmed findings

### 1. Historical and generated material are mixed at the repository root

Source, compiler records, frequency data, intermediate output, and compiled story files sit together. This makes it easy for a modern build to overwrite historical evidence.

**Treatment:** all optimized-edition staging and output is confined to `optimized/build`.

### 2. The original entrypoint uses uppercase include names while the files are lowercase

The root `zork1.zil` asks for `GMACROS`, `GSYNTAX`, `1DUNGEON`, and related names, while the repository files use lowercase names. Filesystems and compilers differ in how forgiving they are about case.

**Treatment:** the isolated overlay uses exact lowercase include names. No game logic changes.

### 3. There is no reproducible source receipt

Without an integrity check, a build can unknowingly combine source files from different revisions.

**Treatment:** `source-manifest.json` records the branch-head commit and Git blob identity of every staged input. Staging fails on drift.

### 4. Generic `PUT` permits recursive containment

`V-PUT` checks direct self-containment and duplicate placement, then calls `MOVE`. It does not determine whether the target container is already below the moved object in the parent chain. A successful cyclic move violates the object-tree invariant and can make objects disappear from normal traversal.

**Treatment:** exact patch `Z1-BUG-001` adds an ancestry guard without changing legitimate nesting, capacity, weight, scoring, parser behavior, or prose beyond reusing the existing impossible-action response. Runtime transcript validation remains required.

### 5. The old compiler report lists unused symbols, but deletion is not yet justified

The historical report names `UNTIE-FROM`, `BREATHE`, `CYCLOPS-MELEE`, `TROLL-MELEE`, `P-DIRECTION`, `DEF2A`, `DEF3C`, and `THIEF-MELEE` as unused. In this codebase, unused can mean dormant, version-conditional, compatibility-oriented, generated, or genuinely dead.

**Treatment:** report, do not delete. Each symbol requires call-site and behavior evidence first.

### 6. The clock scheduler has a fixed implicit capacity

`C-TABLELEN` is 180 words and each entry is 6 words, yielding 30 interrupt slots. Allocation works backward through the table and has no obvious player-facing diagnostic for exhaustion.

**Treatment:** expose the capacity in the audit report. Do not alter the scheduler until tests establish whether exhaustion is reachable and what the historical compiler/runtime expected.

### 7. Global state and magic values are pervasive by design

The parser, action dispatcher, object model, clock, and world logic communicate through globals, bit flags, table offsets, and numeric return conventions. Replacing this architecture would create a new engine rather than optimize Zork I.

**Treatment:** add names, reports, and tests around the architecture; do not refactor it wholesale.

### 8. Exact transcript comparison is unsafe for every route

Combat, randomized messages, timed events, and thief behavior can vary. Interpreter banners and formatting also differ.

**Treatment:** smoke tests use deterministic opening commands and assert meaningful output fragments. Later gameplay tests should normalize only known nondeterministic text, not hide arbitrary differences.

## Smell categories to investigate next

- commented-out historical branches that may no longer be reachable;
- duplicate conditional implementations selected by compiler environment;
- implicit assumptions about table lengths and object counts;
- parser pronoun state (`IT`) across nested or synthetic `PERFORM` calls;
- timer queue exhaustion and demon/interrupt partitioning;
- text or vocabulary typos that alter command recognition;
- behavior differences between Release 88 and Release 119;
- generated-file dependencies that are not documented by the entrypoint.

## Deliberately not changed

- parser grammar and object resolution;
- puzzles and room graph;
- object properties and starting locations;
- scoring and maximum score;
- thief, troll, cyclops, or combat behavior;
- clock timing and randomness;
- player-visible prose except an existing rejection message reused by the cycle guard;
- historical root files.

The next safe step is to run this pipeline under ZILF/ZAPF, capture baseline command transcripts, and then investigate one behavior family at a time.
