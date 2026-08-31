# HTE-Zork v1.0 — Highly Extended Zork Engineering Edition
## Holographic Thinking Engine for ZIL, ZILF, Z-machine, Glulx, Glulxe, and the `acrinym/zork1` release lineage

> **Purpose:** Give any AI, coding agent, or human engineer a repo-native reasoning system for changing **Zork I Highly Extended** without confusing source language, compiler, parser, VM, interpreter, artifact, or player behavior.
>
> **Scope:** `acrinym/zork1`, with particular emphasis on the active additive **Highly Extended Glulx lineage** while preserving the historical/optimized/expanded Z-machine line where the repository requires it.
>
> **Status:** Engineering brain / agent doctrine. This document is a thinking and execution layer. It is not a runtime dependency, not an interpreter, not a replacement for the normative VM specifications, and not permission to bypass release qualification.
>
> **Default depth:** 3/5. For release trains, parser archaeology, VM boundary work, toolchain changes, interpreter changes, save/restore bugs, or unexplained qualification failures: **Depth 5**.
>
> **Primary law:** **Re-query live GitHub first. Live repository state beats this document.**
>
> **When agents use this file:** Load via project skill `.cursor/skills/qa-zork-work/SKILL.md` (Cursor rule `.cursor/rules/qa-zork-work.mdc`, globs only — not always-on). Do not treat this snapshot as `HEAD`.

---

# 0. Why HTE-Zork Exists

Generic software reasoning is not enough for this repository.

Zork I Highly Extended crosses several abstraction layers which look similar from a distance and are dangerously different up close:

```text
player command
    ↓
parser vocabulary + grammar + scope
    ↓
ZIL action/world routines
    ↓
ZILF interpreted compile-time environment
    ↓
ZILF compiled embedded-language routines
    ↓
Z-machine OR Glulx assembly/output model
    ↓
ZAPF / Glazer assembly
    ↓
.z3 / .ulx story artifact
    ↓
Z-machine interpreter OR Glulx interpreter
    ↓
Glk I/O layer where applicable
    ↓
observable player transcript + persistent world state
```

A failure at one layer can impersonate a failure at another.

Examples from the live repository:

- a word exists in prose but not parser vocabulary;
- vocabulary exists but no legal `SYNTAX` line matches the command;
- `SYNTAX` has not loaded yet, so the expected `V?` verb atom does not exist when another file compiles;
- a word is already functioning as a preposition and is therefore a poor actor-command verb;
- a routine is correct but the target object is out of scope because the room is dark;
- `ASK MARA TO PREPARE` is a player-winner parse while `MARA, COOK` is an actor-winner parse;
- a story compiles but a test verb leaked into production;
- a `.ulx` boots but has the wrong serial/checksum/SHA-256;
- the story artifact is correct but a changed Glulxe interpreter alters undo/save behavior;
- documentation describes an older release while live `master` and locked artifacts have moved forward.

HTE-Zork exists to make those distinctions explicit and operational.

---

# 1. Repo Identity and Live-State Rule

## 1.1 Repository

```text
repository: acrinym/zork1
default branch: master
project identity: Zork I Highly Extended
active large lineage: additive Glulx release trains
historical preservation: Z-machine editions remain meaningful and must not be casually overwritten
```

## 1.2 Snapshot at creation

**Snapshot date:** 2026-08-30

At the time this document was created:

```text
master:
71c4a831b956184fd0bd811be498c61724987d56

latest merged PR:
#91 — Release 1304 Living Collection (POST_1286, renumbered)

open train:
#92 — Release 1296 Leaflet Hour Noun Honesty (1296-1300)

known #92 head at snapshot:
1a8a6cdd0d313f12a4446382d02f5ca085097715
```

This snapshot is provenance, **not authority**.

Every new AI session must re-query:

1. repository default branch and exact current SHA;
2. open PRs;
3. exact active PR head SHA;
4. merge/base state;
5. latest relevant release manifest and locked predecessor;
6. required CI/qualification state.

If any of those differ from this document, **live GitHub wins**.

## 1.3 Stale-document rule

README files, planning docs, handoffs, issue bodies, and this HTE document can become stale.

Use them to understand **intent and history**.

Do not use them to override:

- live source;
- exact Git ancestry;
- the active train manifest;
- exact artifact identities;
- exact source identities;
- successful/failing current qualification evidence.

---

# 2. Prime Engineering Laws

## Law 1 — Do Not Collapse the Stack

Never say “the Z-machine” when the evidence only shows “the parser.”

Never say “ZILF bug” when the evidence only shows “the story rejected a command.”

Never say “Glulx bug” when the evidence only shows “Glulxe crashed.”

Never say “story bug” when only a custom interpreter build differs.

Always name the layer.

---

## Law 2 — Source Truth, Parser Truth, VM Truth, Artifact Truth, and Player Truth Are Separate

A change is not established merely because the source looks right.

HTE-Zork recognizes at least these truth domains:

| Domain | Question |
|---|---|
| Repository truth | Is this the exact intended source/head/train? |
| Compile-time truth | Did ZILF read/expand/compile the definitions in the intended order? |
| Parser truth | Does ordinary player input resolve to the intended object/action? |
| World truth | Does the real object/state authority change correctly? |
| VM truth | Does generated code obey the selected VM contract? |
| Artifact truth | Is the compiled story the exact locked file/checksum/hash? |
| Interpreter truth | Does the pinned interpreter execute it correctly? |
| Player truth | Does an ordinary natural play history demonstrate the claim? |
| Preservation truth | Did existing Z-machine/Glulx behavior that must remain intact stay intact? |

A green compile proves **compile truth**, not all truth.

---

## Law 3 — Canonical Authority Before New State

Before creating a flag, table slot, object, routine, parser action, route, timer, or “system,” ask:

> **Who already owns this fact?**

Examples of existing authority classes:

- object location;
- object identity;
- object flags;
- room exits;
- canonical puzzle flags;
- canonical timers;
- parser verb/action routing;
- creature state;
- physical fire/smoke/light/water authorities;
- Mara’s existing state/knowledge;
- save/restore semantics;
- an earlier Highly Extended release module.

If an existing authority can represent the truth honestly, compose with it.

Do not create a parallel truth because it is easier locally.

---

## Law 4 — Exact Objects Beat Abstract Copies

Highly Extended Zork increasingly treats provenance as gameplay truth.

If there is one fish, one jar, one rope, one screen, one silverfin, one canonical rug, one real route, or one real state transition, the system should normally move or mutate **that object/state**, not award a conceptual duplicate.

This gives the game causal memory.

---

## Law 5 — Parser Failures Are Diagnostic Evidence

“I don’t know the word” is not equivalent to “that action is impossible.”

A refusal can indicate:

- dictionary/vocabulary failure;
- syntax/grammar failure;
- object scope failure;
- darkness/touchability failure;
- ambiguity resolution;
- action dispatch;
- object/action routine refusal;
- world-state refusal.

Diagnose the stage before editing grammar.

---

## Law 6 — Do Not Add Grammar to Make a Bad Test Pass

If the product supports:

```text
KNOCK ON HOUSE
LISTEN TO DOOR
```

and a test uses:

```text
KNOCK HOUSE
LISTEN DOOR
```

the first question is not “how can we add aliases?”

The first question is:

> **Is the test wrong, or is the product contract actually missing grammar?**

The repository has already qualified cases where the correct fix was to correct the transcript rather than teach artificial shorthand.

---

## Law 7 — Load Order Is Semantics

In ZIL/ZILF, source order is not merely organization.

Definitions may be established at read/interpret time.

`SYNTAX` can create verb/action atoms needed by later code.

A module that references `V?COOK` before the relevant `SYNTAX COOK ...` has been evaluated can fail even when both files exist.

Therefore include order belongs in the dependency graph.

---

## Law 8 — ZIL Is Not “Basically Lisp”

ZIL descends from MDL and uses Lisp-like notation, but an AI must not import Lisp semantics by resemblance.

Key distinction:

```text
(+ 1 2)    ; a list/data value
<+ 1 2>    ; an executable form
```

The interpreted language and the compiled embedded language also differ.

Reason from ZIL/ZILF semantics, not visual similarity.

---

## Law 9 — ZILF Version Knowledge ≠ Repo Toolchain Authority

Upstream ZILF evolves.

At document creation, upstream has ZILF **1.9**, while this repository’s locked modern Glulx qualification uses:

```text
ZILF 1.8
commit 45c60f1e37651f266ac92d49ae01748bb4909fa5
```

New upstream features are research evidence, not implicit permission to change the repo toolchain.

A ZILF upgrade is a **toolchain migration train** with its own compatibility proof.

---

## Law 10 — Glulx ≠ Glulxe ≠ Glk

Use exact terminology:

- **Glulx**: 32-bit virtual machine and `.ulx` executable format.
- **Glulxe**: reference Glulx interpreter implementation.
- **Glk**: portable IF I/O API.
- **CheapGlk**: a Glk implementation used by this repo for reproducible/headless interpreter runs.

A Glulxe optimization must not silently redefine Glulx semantics.

A Glk difference must not be diagnosed as source semantics without evidence.

---

## Law 11 — Glulx Is Not a “Bigger Z-machine”

Glulx was designed partly to escape Z-machine limits.

It is a distinct VM with 32-bit arithmetic, a different memory model, and Glk-native I/O.

ZILF can preserve ZIL-level programming conventions across targets, which makes the transition *feel* Z-machine-like.

That compatibility layer is not identity.

When low-level behavior matters, inspect the selected target and normative VM spec.

---

## Law 12 — Interpreter Optimization Requires Story Identity

If optimizing Glulxe:

- the `.ulx` may remain byte-identical;
- reference and optimized interpreters must produce semantically equivalent transcripts;
- save/restore/undo must round-trip;
- memory verification remains enabled unless there is an explicit, separately justified decision;
- performance claims require measurements on representative workloads.

Changing the interpreter to “help” one story is not optimization. It is a new semantic dependency.

---

## Law 13 — Test Controls Must Not Become Product Features

Deterministic late-game setup is legitimate in test stories.

The production artifact must not accidentally expose:

- setup verbs;
- teleport verbs;
- state-injection verbs;
- hidden test status commands;
- test-only nouns;
- fake journey shortcuts.

Test overlays are evidence machinery, not gameplay.

---

## Law 14 — Exact-Artifact Qualification Is Two-Phase by Design

A candidate may intentionally reach the artifact identity gate and stop.

That is not failure in the ordinary sense.

Typical sequence:

```text
candidate build
→ prove predecessor/source pins
→ compile
→ gameplay qualification
→ emit exact artifact identity
→ lock identity in manifest
→ rerun exact head
→ require exact match
→ qualify/merge
```

Do not bypass the lock gate.

---

## Law 15 — A Passing Glulx Train Cannot Erase Z-machine Preservation Obligations

When the train contract includes historical `.z3` preservation or cross-VM parity, both matter.

A `.ulx` success cannot compensate for a broken preserved `.z3`.

Likewise, preserving `.z3` does not prove a new Glulx-only feature.

Classify the intended relationship.

---

## Law 16 — Highly Extended Means Authored Depth, Not Generic-System Fever

The project repeatedly rejects automatic escalation into:

- universal crafting;
- generic physics;
- generic creature AI;
- generic companion AI;
- generic scenery engines;
- universal clue registries;
- universal machine systems;
- RPG stat layers;
- procedural filler.

An abstraction must be earned by multiple actual authored cases.

---

## Law 17 — Described World Is a Contract

When room prose names a concrete thing, the project increasingly treats that as a claim about the world.

The direction is:

> If the game speaks a concrete noun as meaningful scenery, the parser should increasingly be able to answer reasonable questions about it.

This does **not** mean every noun gets every verb.

It means player-visible prose and parser reality should not casually contradict each other.

---

## Law 18 — Natural Play Is Stronger Than State Injection

Test setup can establish hard-to-reach preconditions.

But a player-facing claim ultimately wants a real journey.

Prefer:

```text
ordinary parser commands
→ real movement
→ real object acquisition
→ real consequences
→ actual observation
```

over:

```text
magic setup command
→ direct flag mutation
→ claim feature works
```

Use setup to isolate mechanics, then natural play to prove product truth.

---

## Law 19 — Do Not Merge Historical Provenance into the Wrong Repository/Branch

Modern work targets:

```text
acrinym/zork1
master
```

Historical sources are provenance, not a default merge destination.

Always verify repository and base branch before mutation.

---

## Law 20 — Implementation Requested Means Execute, Then Qualify

Once the task is clear enough:

```text
analyze
→ patch
→ compile
→ run targeted proof
→ run required regressions
→ inspect exact head
→ close review findings
→ merge only when authorization + gates allow
```

Do not park indefinitely at “here is what I would do.”

---

# 3. Stack Map — Know What You Are Touching

## 3.1 ZIL

**ZIL** is the source language family used by Infocom-style games.

For agent work, treat it as two related execution contexts:

### Interpreted / definition-time ZIL

This is where constructs such as:

```text
<OBJECT ...>
<ROUTINE ...>
<CONSTANT ...>
<SYNTAX ...>
<INSERT-FILE ...>
<DEFMAC ...>
```

build the compiler’s definition environment.

Some values and macros are evaluated here.

### Compiled embedded routine language

Code inside `ROUTINE` is compiled for the target VM.

It resembles the interpreted language but does not have identical semantics.

Do not transfer a rule from one context without checking.

---

## 3.2 ZILF

**ZILF** is a modern toolchain which interprets enough MDL/ZIL semantics to process source and compiles the embedded game language.

It is not:

- the original Infocom ZILCH compiler;
- full MDL;
- the Z-machine;
- Glulxe.

For this repository, ZILF is part of the reproducible toolchain and must be treated as an exact versioned dependency.

---

## 3.3 ZAP / ZAPF and Glazer

Compilation may produce assembly rather than a final story directly.

For Z-machine lineage, ZILF’s assembler tooling includes ZAPF.

For the active repo Glulx lineage, the qualification flow commonly does:

```text
ZILF --glulx --stop-after-compile
→ Glulx assembly
→ serial normalization
→ Glazer
→ .ulx
```

Therefore a failure can occur in:

1. source interpretation;
2. source compilation;
3. assembly generation;
4. serial normalization;
5. assembly;
6. artifact verification.

Do not call all of these “ZILF compile.”

---

## 3.4 Z-machine

The **Z-machine** is Infocom’s virtual-machine family.

The historical Zork source begins with:

```text
<VERSION ZIP>
```

which places the original mental model in the classic early Z-machine/ZIP family.

The Z-machine has version-specific constraints and structures, including:

- version byte in story header;
- 16-bit word-oriented runtime values;
- version-specific object/property tables;
- packed-address rules;
- dictionary/lexical structures;
- globals;
- dynamic/static/high-memory boundaries;
- opcode version constraints;
- save/restore conventions.

When touching low-level Z-machine assumptions, consult the standard for the target version.

Do not infer V3 behavior from V5/V8 examples.

---

## 3.5 Glulx

**Glulx** is a distinct 32-bit IF VM.

Current normative Glulx specification at document creation:

```text
Glulx VM spec 3.1.3
story version encoding: 0x00030103
```

The repository’s qualified modern `.ulx` artifacts commonly target exactly that version.

Key Glulx facts:

- arithmetic is 32-bit;
- memory is byte-addressed;
- there are explicit 8/16-bit memory access opcodes;
- file data is big-endian;
- VM memory is divided around `RAMSTART`, `EXTSTART`, and `ENDMEM`;
- the header contains version, memory boundaries, stack size, start function, string table, checksum;
- I/O is normally through Glk;
- optional capabilities are discoverable through gestalt tests;
- save state is based on a Quetzal-derived format with Glulx-specific differences.

Do not assume a Z-machine object table exists simply because the ZIL source uses `OBJECT`.

The compiler/runtime compatibility layer is responsible for implementing the high-level model.

---

## 3.6 Glulxe

**Glulxe** is the reference interpreter for Glulx.

For this repo it is both:

- an execution engine for qualification;
- a separately optimizable native component.

The repo pins Glulxe source for reproducibility.

Useful interpreter controls include deterministic RNG seeding and undo capacity.

When a failure appears only under one Glulxe build:

> compare the same `.ulx` under the reference pinned interpreter before changing story source.

---

## 3.7 Glk and CheapGlk

**Glk** abstracts text-IF I/O:

- text output;
- line input;
- windows;
- files/streams;
- styles and related portable capabilities.

Glulx uses Glk as its native I/O surface.

The repo uses **CheapGlk** for reproducible automated runs.

Therefore:

```text
story logic
≠ VM execution
≠ I/O backend behavior
```

If save path, terminal behavior, buffering, or input/output differs, inspect the Glk layer too.

---

# 4. HTE-Zork Activation Triggers

Activate automatically for:

- any `.zil` change in `acrinym/zork1`;
- parser grammar work;
- object/scope/darkness/touchability bugs;
- ZILF warnings/errors;
- include/load-order problems;
- new actions or actor commands;
- `PRSO`, `PRSI`, `HERE`, `WINNER`, `PLAYER` behavior;
- table/global/property/flag state changes;
- Z-machine compatibility;
- `.z3` preservation;
- Glulx compilation;
- `.ulx` verification;
- Glulxe crashes/performance;
- save/restore/undo;
- release train staging;
- patch-series changes;
- source/artifact identity drift;
- exact-head qualification;
- parser transcript disagreement;
- “the test passes but the player cannot do it”;
- “the README says X but live code says Y”;
- “ZILF upgraded, should we use it?”;
- explicit request: **HTE-Zork**, **HTE ZIL**, **HTE Glulx**, **HTE Z-machine**, or **Zork Highly Extended engineering pass**.

---

# 5. HTE Engine Topology — Preserve the Parent Architecture

HTE-Zork is a specialization of HTE-Code / HTE, not a replacement engine numbering scheme.

The parent engine identities remain intact:

| Engine | Parent role | Zork specialization |
|---:|---|---|
| -1 | FilterStack | detect unsupported “that is just how ZIL/Zork works” appeals; require mechanism/spec/repo evidence |
| 0 | Harm / Operational Risk | protect repositories, artifacts, credentials, destructive operations, and historical preservation |
| 1 | Oracle | examine the problem from parser, source, VM, runtime, player, preservation, and release perspectives |
| 2 | Mechanical Deconstruction | trace source → compile-time definitions → parser → world state → VM → artifact → interpreter |
| 3 | Tribunal | compare conventional/local/reusable/toolchain/interpreter solutions and demand falsification |
| 4 | Edge Cases | run parser, state, VM, artifact, save/restore, and lifecycle campaigns |
| 5 | Cross-Domain / Multisource | transfer useful patterns from compilers, VMs, interpreters, state machines, provenance systems |
| 6 | Synthesis | convert evidence into the smallest executable plan, then execute when implementation was requested |
| 7 | Memory | retain validated repo motifs, ownership rules, pins, and historical failure patterns |
| 8 | Learning | update confidence and reusable motifs after each compile/play/qualification cycle |
| 9 | Affect / Execution Context | respond to agent/user frustration by resuming causal work rather than offering endless menus |
| 10 | Parallel Oracle | branch simultaneously across WHO/WHAT/WHY/WHEN/WHERE/WHICH/HOW/NEGATION/TEMPORAL/SUCCESS/FAILURE |
| 11 | InvisiSynth | upstream ZILF/Glulxe/spec/repo archaeology, abandoned paths, obscure compiler/interpreter evidence |
| 12 | Clarity | rewrite vague claims such as “the parser is broken” into testable layer-specific statements |
| 14 | Clarification | resolve the right engineering question without blocking execution when the task is already actionable |
| 15 | Contradiction Resolution | classify disagreements as definitional, scope, temporal, authority, VM, toolchain, or genuine tradeoff |

The ZIL/parser/VM/toolchain sections in this document are **lens packs** invoked by those engines. They do not overwrite Memory, Learning, Affect, Parallel Oracle, or the other parent roles.

## 5.1 Engine -1 — FilterStack for IF Engineering

Trigger when an argument relies on labels instead of mechanism, for example:

- “you cannot do that in ZIL” without compiler/spec evidence;
- “Glulx is basically just a large Z-machine” as a substitute for target analysis;
- “that parser behavior is canonical” without locating the owning grammar/routine;
- “use the latest ZILF because newer is better” without a migration proof;
- “Infocom never did it that way” as the sole reason to reject an additive Highly Extended behavior;
- “best practice says make a generic engine” despite the repo’s authored-locality contract.

FilterStack response:

```text
CLAIM
→ mechanism actually asserted
→ direct repository evidence
→ normative specification/compiler evidence
→ counterexample search
→ falsifying experiment
→ conclusion
```

Historical convention is relevant evidence. It is not self-proving authority over a modern additive train.

## 5.2 Engine 12 — Clarity Rewrites

Rewrite:

```text
“ZILF hates this routine.”
```

into:

```text
“Pinned ZILF 1.8 emits diagnostic X while compiling routine Y after definition Z is interpreted.”
```

Rewrite:

```text
“Glulxe broke the fish.”
```

into:

```text
“The same locked `.ulx` produces outcome A under pinned reference Glulxe and outcome B under candidate Glulxe.”
```

Rewrite:

```text
“The parser cannot see Mara.”
```

into:

```text
“In room R under lighting state L, the noun phrase MARA fails at scope resolution although Mara’s LOC is R.”
```

Precise language exposes the correct experiment.

## 5.3 Engine 10 — Parallel Oracle Branches

At Depth ≥3, branch across:

```text
WHO:       which actor/state owner/compiler/interpreter owns the behavior?
WHAT:      what exact source construct / command / artifact differs?
WHY:       what mechanism produces the result?
WHEN:      read-time, compile-time, parse-time, action-time, save-time, restore-time?
WHERE:     which file, room, object, memory region, artifact, or runtime layer?
WHICH:     Z-machine target or Glulx target? production/dev/test? reference/optimized terp?
HOW:       exact call/parse/state/compile chain?
NEGATION:  what evidence would prove our favored explanation wrong?
TEMPORAL:  did this work on the predecessor? what changed first?
SUCCESS:   what exact natural transcript/state/artifact proves completion?
FAILURE:   what is the first gate that currently fails?
PARTIAL:   which layers are already proven and which are not?
ASSUMPTION: what are we treating as true without direct evidence?
CONSTRAINT: what may not change in this train?
```

## 5.4 Engine 6 — Required Synthesis Shape

A serious HTE-Zork synthesis ends as:

```text
SYNTHESIS
  Exact live state
  Clarified problem
  Root cause / best current hypothesis
  State/behavior owner
  Smallest coherent patch
  Commands/tests to execute
  Regression set
  Artifact/provenance gates
  Confidence + named uncertainty
  Success condition
```

If implementation was requested, synthesis flows directly into execution. Do not ask for “go” after the plan is already selected and safe to execute.

---

# 6. Task Classes

Classify before going deep.

| Code | Task class | Typical evidence |
|---|---|---|
| Z-SRC | ZIL source semantics | source, compiler output |
| Z-PARSE | parser/vocabulary/grammar | parser transcript, `SYNTAX`, vocab |
| Z-WORLD | object/state/world authority | object tree, flags, tables, routines |
| Z-TOOL | ZILF/toolchain | pin, compiler/assembler logs |
| Z-ZVM | Z-machine compatibility | spec + `.z3` behavior |
| Z-GLULX | Glulx VM/artifact | spec + header + `.ulx` behavior |
| Z-GLULXE | interpreter/runtime | exact `.ulx` across interpreter builds |
| Z-GLK | I/O/backend | streams/windows/files/input |
| Z-PROV | provenance/staging | patch-series, identities, changed paths |
| Z-QUAL | release qualification | exact head, workflows, receipts |
| Z-PARITY | cross-VM preservation | shared natural routes |
| Z-PROD | player/product truth | natural play transcript |
| Z-ARCH | architecture/authority | state owner map |
| Z-PERF | runtime/toolchain performance | measured workloads |

Multiple classes may apply.

---

# 7. Operational Depth Levels

## Depth 1 — Fast Triage

Use for obvious local failures.

Required:

- identify layer;
- identify file/symbol;
- state likely failure class;
- make smallest safe change;
- run one direct proof.

No broad archaeology unless the symptom survives.

---

## Depth 2 — Focused Engineering

Adds:

- nearby callers/definitions;
- include order;
- parser grammar path;
- target object scope;
- one relevant regression;
- state-owner check.

---

## Depth 3 — Default Deployment-Ready

Adds:

- exact repo/head check;
- train/predecessor context;
- production vs test distinction;
- staging/changed-path awareness;
- relevant static/smell checks;
- production compile;
- direct natural parser route;
- affected regressions;
- evidence/confidence ledger.

---

## Depth 4 — Forensic / Architectural

Adds:

- repo history around the behavior;
- authority graph;
- cross-file include/compile dependency graph;
- ZILF semantic check;
- VM target distinction;
- save/restore implications;
- cross-VM parity when applicable;
- artifact verification;
- edge campaigns;
- alternative hypotheses with falsifiers.

---

## Depth 5 — Recursive Release Engineering

Depth 5 changes **method**, not verbosity.

Run five bounded passes.

### Pass A — Live Truth Acquisition

Acquire:

- exact `master`;
- exact active PR head;
- active release/train;
- predecessor release;
- base source identities;
- base artifact identity;
- expected changed paths;
- toolchain pins;
- current failing gate;
- current review state.

Record stale documentation separately.

### Pass B — Semantic Topology

Map:

```text
include order
→ compile-time definitions
→ syntax/vocabulary
→ action dispatch
→ object/world authority
→ VM-facing generated behavior
→ artifact
→ interpreter
→ player route
```

Explicitly name every state owner affected.

### Pass C — Adversarial Hypothesis Lattice

Generate at least 3 plausible causes for a nontrivial bug.

For each:

- predicted evidence;
- cheapest discriminating experiment;
- disconfirming evidence;
- layer affected.

Do not commit to the first plausible explanation.

### Pass D — Surgical Execution

Implement the smallest coherent authority-preserving change.

Then:

- compile production;
- compile dev/test if train requires it;
- run parser route;
- inspect artifact;
- run interpreter checks;
- verify no forbidden test controls leaked.

### Pass E — Qualification Closure

Require the train’s actual gates:

- predecessor/source pin;
- staging;
- smell/static checks;
- production artifact;
- natural histories;
- regression histories;
- artifact lock;
- exact-head rerun;
- CI;
- review-thread closure;
- merge authorization.

### Depth-5 stop rule

Stop expanding analysis when:

1. the root cause is demonstrated;
2. the fix has a direct causal link;
3. the relevant regressions are locked;
4. the exact current state is qualified.

Do not produce an audit of the audit.

---

# 8. Shared Analysis State

Every serious HTE-Zork run should maintain this state:

```yaml
repo:
  name:
  default_branch:
  exact_base_sha:
  exact_head_sha:
  pr:
  release_train:

provenance:
  predecessor_release:
  predecessor_artifact_sha256:
  production_source_sha256:
  dev_source_sha256:
  expected_changed_paths:

toolchain:
  zilf:
  assembler:
  glulxe:
  glk:

target:
  vm:
  artifact:
  story_version:

behavior:
  player_command:
  expected_parse:
  expected_action:
  state_owner:
  expected_world_change:
  expected_output:

evidence: []
assumptions: []
constraints: []
hypotheses: []
regressions: []
uncertainties: []
```

If a field matters but is unknown, mark it unknown.

Do not invent it.

---

# 9. Evidence Ledger

## E0 — Natural Runtime Evidence

Highest-value player-facing evidence:

- ordinary parser transcript;
- save/restore round-trip;
- undo;
- actual movement/object state;
- interpreter crash trace;
- deterministic reproduction.

Use exact story and interpreter identities.

---

## E1 — Direct Repository Evidence

- current source;
- active manifest;
- staging receipt;
- workflow;
- exact Git history;
- changed paths;
- locked artifact JSON;
- compile logs.

---

## E2 — Normative / Primary External Evidence

- Z-machine Standard;
- Glulx specification;
- Glk specification;
- ZILF upstream source/docs;
- Glulxe source/docs.

Primary evidence explains semantics, but does not override repo pins.

---

## E3 — Reproduction Against Upstream

Examples:

- minimal ZILF repro;
- same `.ulx` in pinned and upstream Glulxe;
- same source against current and proposed ZILF;
- VM-level fixture.

Useful for separating repo bug from toolchain bug.

---

## E4 — Historical / Secondary Evidence

- old release README;
- issue/PR discussion;
- handoff;
- archived source commentary;
- community documentation.

Useful, but vulnerable to staleness.

---

## E5 — Inference

- likely compiler behavior;
- analogy to another IF system;
- architectural speculation.

Must have a falsifier.

---

# 10. Assumption and Constraint Registers

## 9.1 Assumption record

```text
A#: [assumption]
WHY HELD:
EVIDENCE:
RISK IF FALSE:
TEST:
STATUS: open / confirmed / falsified
```

Examples:

- “The parser already has the noun.”
- “This action runs with `WINNER = PLAYER`.”
- “The existing object is in scope here.”
- “The current train inherits Release 1304 source exactly.”
- “The optimized Glulxe is semantically identical.”

---

## 9.2 Constraint classes

### Product constraints

- preserve recognizably Zork behavior;
- preserve canonical puzzle solutions;
- deepen authored physicality;
- no generic-system replacement without evidence.

### Parser constraints

- ordinary parser grammar;
- no fake test-only aliases in production;
- maintain actor/person routing semantics.

### State constraints

- no parallel truth;
- conserve legacy globals where possible;
- save/restore must carry new persistent state correctly.

### Provenance constraints

- exact predecessor;
- exact changed paths;
- exact artifact;
- deterministic serial normalization.

### Process constraints

- live GitHub first;
- exact-head evidence;
- do not merge without current required authorization;
- no historical-source merge drift.

---

# 11. ZIL Semantic Engine

## 10.1 Forms vs lists

Do not mentally translate brackets as punctuation.

```zil
(+ 1 2)
```

is data.

```zil
<+ 1 2>
```

is an executable form.

Angle-bracket balance is semantic.

---

## 10.2 Local vs global value syntax

Common source conventions:

```zil
.LOCAL
,GLOBAL
```

Do not erase prefixes while refactoring.

They are not cosmetic.

When a routine unexpectedly reads a different value:

- inspect local bindings;
- inspect globals;
- inspect comma/dot usage;
- inspect macro expansion.

---

## 10.3 `OBJECT` is world state, not a class declaration

An object can carry:

- location;
- synonyms/adjectives;
- description;
- flags;
- properties;
- action routine.

Its **actual object identity and location** often are the canonical state.

Prefer moving the real object over recording an abstract “has object” flag.

---

## 10.4 `ROUTINE` context

Inside compiled routines, reason about:

- arguments;
- `"AUX"` locals;
- return behavior;
- `COND`;
- loops;
- object/global values;
- VM word size for target.

Do not assume arbitrary high-level types exist at runtime.

---

## 10.5 `RETURN`, `RTRUE`, `RFALSE`

Be exact about control flow.

Within iteration forms, `RETURN` may exit the loop construct rather than the whole routine depending on the construct.

`RTRUE` / `RFALSE` exit the routine.

When a loop “mysteriously continues,” inspect which construct received the return.

---

## 10.6 `DO`, `REPEAT`, and `AGAIN`

`AGAIN` is dangerous in loops because it returns to the top of the body and can bypass advancement.

Potential symptom:

```text
interpreter appears hung
CPU active or loop stable
same object repeatedly processed
```

Test loop progress explicitly.

When uncertain, use a straightforward `REPEAT` with explicit mutation.

---

## 10.7 Tables

Use tables as compact owned state when they honestly model a subsystem.

Patterns used in this repo:

```zil
<CONSTANT LC-SCHEMA 1>
<CONSTANT LC-SLOT-VERSION 0>
...
<CONSTANT LC-STATE <TABLE LC-SCHEMA 0 0 ...>>
```

Advantages:

- conserve legacy globals;
- centralize subsystem state;
- make schema/version explicit;
- easier save/restore reasoning.

For truly immutable data, prefer pure/ROM-oriented table constructs where supported and appropriate.

---

## 10.8 Prefix comments

Historical ZIL comment idiom:

```zil
;"comment text"
```

`;` comments out the next value.

Do not casually import C/JS/Python comment assumptions.

Newer upstream ZILF has added `;;` line comments, but the repo toolchain/style may not treat a new language convenience as permission to rewrite source.

---

## 10.9 Read-time evaluation

`%` means read-time evaluation.

Example concept:

```zil
%<VOC "XYZZY">
```

If a value must exist in the compiler/interpreter environment before routine compilation, understand when it is evaluated.

---

## 10.10 Equality

Do not assume interpreted and compiled equality operators have identical arity/identity semantics.

Before changing `=?`, `==?`, or `EQUAL?`, check context.

---

## 10.11 Macro hygiene

Macros can hide:

- compile-time side effects;
- generated globals;
- generated syntax;
- repeated forms;
- target-specific behavior.

When generated behavior is surprising:

1. inspect macro definition;
2. inspect invocation context;
3. inspect any read-time forms;
4. inspect generated assembly when needed.

---

# 12. Include-Order and Definition-Time Engine

## 11.1 Treat `INSERT-FILE` as a dependency graph

The root source is not “a bag of files.”

Order matters.

Create a graph:

```text
file A defines symbol X
file B references X
therefore A must be interpreted before B compiles
```

---

## 11.2 `SYNTAX` can create action/verb atoms

Release 1304 demonstrated the exact hazard:

```zil
<SYNTAX COOK = V-LC-MARA-PREPARE>
```

must be processed before code expecting the corresponding verb atom/action identity.

The repo therefore uses a separate syntax file loaded before the Mara module.

This is a general pattern:

> If a file needs a parser-created symbol during compilation, syntax registration must precede that file.

---

## 11.3 Compile failure triage

If an undefined symbol resembles:

```text
V?SOMETHING
ACT?SOMETHING
P?SOMETHING
```

ask:

1. what construct creates it?
2. is it a pseudo-property?
3. is it generated by `SYNTAX`?
4. does a module load too early?
5. did a word collide with an existing grammar role?

Do not immediately add a constant with the missing name.

That can mask the real semantic dependency.

---

# 13. Parser Engine — Vocabulary, Grammar, Scope, Dispatch

A parser command passes through multiple gates.

```text
raw text
→ tokenization/dictionary
→ vocabulary match
→ grammar (`SYNTAX`)
→ noun phrase resolution
→ scope/accessibility
→ action selection
→ `PRSO` / `PRSI`
→ action/object hooks
→ world change
```

Diagnose the first failing gate.

---

## 12.1 Failure taxonomy

### “I don’t know the word …”

Likely dictionary/vocabulary.

Check:

- `SYNONYM`;
- `ADJECTIVE`;
- `VOC`;
- syntax-defined words;
- conditional scope/vocabulary.

### “You used the word … in a way that I don’t understand”

Likely grammar shape.

Check `SYNTAX`.

### Correct verb, wrong object

Check:

- local/global object scope;
- duplicate synonyms;
- adjectives;
- object location;
- parser disambiguation.

### Object exists but cannot be referred to

Check:

- darkness/light;
- containment;
- visibility;
- touchability;
- room scope;
- discovery gating.

### Correct parse but wrong behavior

Inspect action routing and object/action routines.

---

## 12.2 `PRSO` and `PRSI`

Treat parser-selected objects as evidence.

Before adding special-case code, capture:

```text
verb/action
PRSO
PRSI
WINNER
HERE
```

The human-readable sentence does not guarantee the object slots you guessed.

---

## 12.3 `WINNER` vs `PLAYER`

Actor commands can switch the performing actor.

In the Mara work, this distinction matters materially.

Conceptually:

```text
ASK MARA TO PREPARE
```

may parse as an action performed by the player involving Mara/topic/object.

Whereas:

```text
MARA, COOK
```

routes with Mara as the acting `WINNER`.

Do not write actor routines assuming `WINNER` always means the human Adventurer.

---

## 12.4 Preposition collision

A word which looks like a nice verb in English may already be grammar material.

Release 1304 discovered collisions around words such as:

```text
FILE
PREPARE
REST
SLEEP
```

The safe solution was not “force those words to be new actor verbs at any cost.”

The player-facing `ASK MARA TO ...` path retained its intended grammar, while actor-winner commands used distinct verb words such as:

```text
COOK
NAP
ARCHIVE
```

General law:

> Respect the parser’s existing lexical role before assigning a new one.

---

## 12.5 Topic vs object vs verb

A word may be:

- vocabulary for a concrete object;
- a topic token;
- a preposition;
- a verb;
- an adjective;
- parser metadata.

Do not add an object solely because a topic parse failed.

Do not add a verb solely because an object/topic phrase failed.

First establish intended grammar.

---

## 12.6 Darkness is parser truth

An object can be correctly authored and still fail a transcript because the player cannot see it.

If a test says an NPC/object is “missing”:

- inspect room lighting;
- inspect carried light;
- inspect `HERE`;
- inspect object location;
- inspect visibility rules.

Do not patch the object into `GLOBAL-OBJECTS` merely to make a dark-room test see it unless global scope is product truth.

---

## 12.7 Parser hooks are global blast radius

Changing global parser routines, syntax, dictionary behavior, or action dispatch can affect hundreds of commands.

Before changing a global parser layer:

1. prove a local object/action hook cannot express the intended behavior;
2. enumerate affected grammar;
3. run parser regression routes;
4. preserve canonical actions.

---

# 14. World and State Authority Engine

## 13.1 State owner table

Before a feature:

| Fact | Existing owner | New owner allowed? |
|---|---|---|
| where an object is | object location | usually no |
| whether object is lit/open/etc | flags/properties | usually no parallel flag |
| canonical puzzle state | predecessor routine/global | compose |
| new subsystem history | dedicated table may be correct | yes |
| NPC witnessed knowledge | NPC state owner | extend carefully |
| traversal | room exit/canonical router | compose |
| save persistence | VM dynamic state | must naturally include state |

---

## 13.2 Object location as truth

If:

```zil
<IN? ,FISH ,MUSEUM-WATERS-CASE>
```

already answers whether the fish occupies the case, do not add:

```text
FISH-IN-CASE = true
```

unless there is a distinct concept.

Parallel state drifts.

---

## 13.3 Provenance as mechanics

The repo increasingly rejects “convenient duplicate” objects.

If the one known specimen is already in the world, a repeated fishing action should not spawn a copy merely because the player invoked the verb again.

This preserves:

- identity;
- custody;
- memory;
- consequence;
- meaningful absence.

---

## 13.4 Schema/versioned state

When a subsystem table can evolve, use an explicit schema slot and initialization strategy.

Ask:

- what happens in a fresh game?
- what happens after save/restore?
- what happens if initialization routine runs twice?
- is the state idempotent?
- can a later release migrate it safely?

---

## 13.5 Legacy-global budget

The active Glulx source line inherits architectural constraints from classic Zork/ZIL structures.

Do not assume “Glulx is 32-bit, therefore globals are unlimited.”

The repo itself documents pressure around the legacy global-variable model.

Prefer, when honest:

- compact mutable tables;
- object flags;
- object properties;
- object locations;
- existing owner state.

---

# 15. Z-machine Engine

## 14.1 First identify the exact version

The story header’s first byte identifies the Z-machine version.

Do not reason about “the Z-machine” generically when:

- object-table layout changes by version;
- property behavior differs;
- opcode availability differs;
- address packing differs;
- screen/I/O features differ.

For preserved Zork I `.z3`, V3 constraints are especially relevant.

---

## 14.2 V1–V3 object-table awareness

Classic Z-machine object tables include:

- property defaults;
- object entries;
- parent/sibling/child tree;
- object attributes;
- property tables.

Object identity is numeric at runtime.

The high-level ZIL `OBJECT` abstraction is compiled into these structures.

When object-count/property-space limits appear, inspect actual target constraints rather than guessing.

---

## 14.3 16-bit runtime reasoning

Classic Z-machine values are 16-bit words.

Be careful with:

- signed arithmetic;
- counters;
- addresses;
- table offsets;
- bitmasks;
- shifts;
- sentinel values.

A technique safe in Glulx may overflow or encode differently in V3.

---

## 14.4 Memory regions

The Z-machine distinguishes dynamic/static/high-memory concepts.

Persistence primarily concerns mutable story state.

When debugging save/restore:

- identify which state is actually mutable;
- verify it lives in save-covered memory;
- verify object tree/flags/globals/tables restore;
- do not depend on host/interpreter side state unless explicitly part of the product.

---

## 14.5 Dictionary/parser representation

The Z-machine has its own dictionary/tokenization structures.

ZILF/parser code may abstract them.

When crossing versions, verify:

- word truncation/encoding;
- dictionary entry expectations;
- parser buffers;
- ZSCII/character behavior.

Do not infer Unicode-rich Glulx behavior applies to `.z3`.

---

## 14.6 Opcode/version discipline

If a low-level feature needs a VM opcode:

1. identify target version;
2. check opcode availability;
3. check operand/store/branch semantics;
4. check interpreter support;
5. add capability/version guard where required;
6. preserve historical story behavior.

---

## 14.7 Save format

Z-machine interpreters commonly use **Quetzal** save files.

Cross-interpreter save portability is valuable, but a repo test must still pin enough environment to be reproducible.

Never treat “SAVE command printed success” as a complete round-trip test.

---

# 16. Glulx Engine

## 15.1 Current normative target

The modern repo artifacts commonly verify:

```text
Glulx 3.1.3
0x00030103
```

This matches the current normative specification at document creation.

---

## 15.2 32-bit arithmetic

Glulx uses 32-bit arithmetic.

This gives room compared to classic Z-machine constraints, but can expose assumptions hidden in source designed around 16-bit values.

When porting shared code, ask:

- does the source depend on wraparound?
- does a bitmask assume 16-bit width?
- does a table slot hold an address or object identifier?
- is a “word” abstraction target-dependent?

---

## 15.3 Memory layout

Glulx header includes:

```text
magic
version
RAMSTART
EXTSTART
ENDMEM
stack size
start function
string decoding table
checksum
```

ROM precedes RAM.

The file contains initial memory through `EXTSTART`; memory above it to `ENDMEM` begins zeroed.

Artifact verification should at least validate:

- magic;
- version;
- bounds;
- checksum.

The repo already has tooling for this.

---

## 15.4 Big-endian artifact semantics

Glulx values in story memory/file representation are big-endian.

When writing verification scripts, do not use host-native unpacking without explicit byte order.

---

## 15.5 Gestalt

Optional interpreter capabilities are queried rather than assumed.

When using optional VM or Glk facilities:

```text
capability test
→ supported path
→ fallback or explicit requirement
```

Do not silently make one modern interpreter the new minimum unless the release contract says so.

---

## 15.6 Glulx object model caution

Glulx is deliberately lower-level/general compared with the Z-machine’s IF-specific structures.

If ZIL source continues to expose Zork-like object/property semantics, those are compiler/library conventions layered over Glulx.

When debugging a source-level `OBJECT`, inspect the compiler-generated representation before claiming a Glulx object-table bug.

---

## 15.7 Save/restore

Glulx save format is based on Quetzal with Glulx-specific memory/stack handling.

Qualification must test the product-level behavior, not only file creation.

For release-critical state:

```text
establish state
SAVE
mutate state
RESTORE
verify exact prior state
```

Also test `UNDO` when the feature participates in mutable gameplay history.

---

# 17. Glulxe Runtime Engine

## 16.1 Story vs interpreter isolation

Given a runtime discrepancy:

```text
same .ulx + reference Glulxe
same .ulx + candidate Glulxe
```

If only candidate fails, story source is not the first edit target.

Conversely:

```text
two .ulx builds + same pinned Glulxe
```

can isolate story/toolchain drift.

---

## 16.2 Repo pin

The repo has used a pinned Glulxe source commit:

```text
56ab8743bab565de307bd892c555d8d8897ed517
```

Do not replace it casually with “latest Glulxe” during a story train.

---

## 16.3 Deterministic RNG

For reproducible automated histories, use a fixed RNG seed where supported.

Repo pattern:

```text
--rngseed 123456
```

Determinism is test instrumentation.

It is not permission to change production randomness semantics.

---

## 16.4 Undo depth

Tests may specify undo capacity, e.g.:

```text
--undo 16
```

If a failure disappears only with a larger/smaller undo buffer, inspect interpreter/resource assumptions separately from story logic.

---

## 16.5 Memory verification

The repo’s interpreter optimization train keeps:

```text
VERIFY_MEMORY_ACCESS
```

enabled.

Do not trade safety checks for a benchmark win without explicit evidence and approval.

---

## 16.6 Interpreter optimization protocol

For a faster Glulxe:

1. freeze exact story SHA-256;
2. build reference interpreter;
3. build optimized interpreter;
4. use representative workloads;
5. compare transcripts;
6. compare save/restore/undo;
7. measure repeatably;
8. keep safety verification;
9. prove aggregate performance target;
10. ship interpreter separately from story identity.

Release 1279 used this exact philosophy.

---

## 16.7 Glk working-directory effects

CheapGlk file behavior can depend on the working directory.

A save may be created next to the story file.

When a save/restore test fails:

- locate the actual save path;
- inspect cwd;
- prevent the second run from overwriting the reference save;
- distinguish file-path failure from VM state failure.

---

# 18. Toolchain Engine — ZILF, Assembly, Serial, Reproducibility

## 17.1 Pin first

Record:

```text
ZILF version + commit
assembler version/source
Glulxe commit
CheapGlk commit
host/compiler flags where interpreter build matters
```

The repo’s modern locked set has included:

```text
ZILF 1.8:
45c60f1e37651f266ac92d49ae01748bb4909fa5

Glulxe:
56ab8743bab565de307bd892c555d8d8897ed517

CheapGlk:
14d8aaf6e4150669762bd4646a5368e75c1eeee6

Glazer:
v1.2.0 source identity pinned by repo qualification
```

Always confirm live train.

---

## 17.2 Upstream ZILF 1.9 is research evidence

At this document’s creation, upstream ZILF 1.9 exists.

That means:

- agents may consult its diagnostics and documentation;
- fixes in 1.9 may explain a 1.8 behavior;
- features from 1.9 may suggest future work.

It does **not** mean:

```text
change CI to 1.9
```

inside an unrelated product release.

---

## 17.3 Compile-to-assembly separation

Repo pattern:

```bash
dotnet "$ZILF" build --glulx --stop-after-compile zork1.zil release.asm
```

Then normalize and assemble.

This separation is powerful for diagnosis.

If ZILF generates assembly successfully but Glazer fails:

- inspect assembly;
- inspect target syntax/version;
- inspect serial normalization;
- inspect assembler toolchain.

---

## 17.4 Serial normalization

Build-date metadata can destroy byte-for-byte reproducibility.

The repo normalizes the committed serial before final assembly.

Therefore:

> “Same source” does not imply “same artifact” unless volatile metadata is normalized.

Artifact identity is downstream evidence.

---

## 17.5 Compiler warnings are semantic signals

Do not globally suppress a new warning without classifying it.

Warnings can reveal:

- invalid pseudo-property use;
- property-vs-table confusion;
- unreachable replacement definition;
- too many locals;
- target-specific unsupported operation.

Use the pinned compiler’s actual warning catalog.

---

# 19. Provenance and Release-Train Engine

## 18.1 A train is a reproducible transformation

Conceptually:

```text
locked predecessor
+ explicit patch set
+ explicit changed paths
+ exact toolchain
+ qualification histories
= candidate successor
```

Do not treat a train as “whatever happens to be on this branch.”

---

## 18.2 `patch-series.json`

A modern train manifest should answer:

- release identity;
- predecessor;
- serial;
- base artifact SHA-256;
- base production/dev source identities;
- expected changed paths;
- patch ordering;
- expected artifact identity;
- lock state.

HTE-Zork must inspect the manifest before broad edits.

---

## 18.3 Source identity

The repo hashes staged source trees.

This proves:

- predecessor source is exact;
- the train did not silently pick up unrelated drift;
- production/dev ancestry is reproducible.

An AI should not “refresh” the base tree during qualification unless the train is explicitly rebased/rebuilt as a new candidate.

---

## 18.4 Changed-path gate

The changed-path list is a blast-radius contract.

If the code change requires a new path:

- update the train contract intentionally;
- explain why;
- qualify the expanded blast radius.

Do not make stage scripts permissive merely because the patch touched an unexpected file.

---

## 18.5 Byte-preserved predecessor authority

Some trains explicitly verify selected predecessor files are byte-identical.

That is stronger than “tests still pass.”

It proves the train did not rewrite an existing owner.

When such a gate fails, first ask whether the train violated its authority boundary.

---

# 20. Candidate → Lock → Exact-Head Protocol

## Phase 1 — Candidate

Run the whole intended qualification until the system prints:

- predecessor source identities;
- candidate artifact identity.

A deliberate nonzero exit at a lock gate can be expected.

---

## Phase 2 — Lock predecessor/source pins

Record exact values in the manifest.

Rerun.

If they drift, do not update the expected value automatically.

Find the drift.

---

## Phase 3 — Complete gameplay qualification

The candidate must survive real feature histories before locking final artifact identity.

---

## Phase 4 — Lock artifact

Record:

```text
file
format
version
size
header checksum
SHA-256
locked: true
```

---

## Phase 5 — Exact-head rerun

Rerun on the exact head containing the lock.

No code change after qualification may be hand-waved as “docs only” without evaluating whether exact-head policy allows it.

---

## Phase 6 — CI/review/merge

Require:

- expected workflows green;
- review findings resolved or explicitly non-actionable;
- PR head unchanged;
- mergeable/clean state as required;
- current merge authorization.

Use expected-head protection when merging where tooling supports it.

---

# 21. Production / Dev / Test Story Separation

A modern train may have:

```text
production source
development source
test source
```

Do not conflate them.

## Production

What players receive.

Must exclude:

- setup verbs;
- state injection;
- diagnostics not intended for players.

## Development

May include debug observability allowed by repo contract.

Still should preserve semantics.

## Test story

May inject deterministic setup/status controls.

Its purpose is to make hard states reproducible.

A test story proving a routine works is **not by itself** proof that the production player can reach that routine.

---

# 22. Qualification Ladder

## Q0 — Static plausibility

- syntax visually sane;
- intended files changed;
- no obvious test token leak.

## Q1 — Pinned compilation

- pinned ZILF;
- target correct;
- assembly succeeds;
- story assembles.

## Q2 — Artifact integrity

- correct VM magic/version;
- checksum valid;
- serial normalized;
- expected artifact type.

## Q3 — Targeted mechanic

- minimal route proves exact fix.

## Q4 — Parser/world integration

- ordinary grammar;
- object scope;
- state persistence;
- correct actor;
- causal output.

## Q5 — Relevant regressions

- predecessor authority;
- neighboring commands;
- canonical solution;
- save/restore/undo if relevant.

## Q6 — Cross-VM preservation

When required:

- `.z3` preserved;
- `.ulx` correct;
- shared natural routes semantically match.

## Q7 — Product journey

A real-player route reaches and uses the feature.

No state injection in the claim path.

## Q8 — Exact release

- source pins;
- artifact lock;
- exact head;
- CI;
- review;
- merge readiness.

For a merge-worthy major train, **Q8** is the target.

---

# 23. Specialized Debugging Protocols

## 22.1 Undefined `V?` / action atom

Hypotheses:

1. missing `SYNTAX`;
2. syntax file loads after consumer;
3. word collision prevented intended grammar creation;
4. action name differs from assumption.

Experiments:

- search exact atom;
- inspect syntax definition;
- inspect root include ordering;
- compile a minimal reordered source;
- inspect compiler diagnostics.

Do not fabricate the atom manually until generation semantics are understood.

---

## 22.2 “Parser doesn’t understand feature”

First capture exact transcript.

Classify:

```text
unknown word?
bad grammar?
not visible?
ambiguous?
action refusal?
wrong actor?
```

Then inspect only the relevant layer.

---

## 22.3 Actor command broken

Capture:

```text
command
WINNER
PLAYER
PRSO
PRSI
HERE
```

Compare:

```text
ASK MARA TO X
MARA, X
```

Do not assume they share dispatch.

---

## 22.4 Test object invisible

Check:

1. room light;
2. carried light;
3. object `LOC`;
4. containment;
5. scope/global placement;
6. discovery state.

Only then change parser scope.

---

## 22.5 Save/restore loses new feature state

Map every state item:

| State | Stored where | Expected save? |
|---|---|---|
| object location | VM object state | yes |
| object flag | mutable memory | yes |
| table slot | mutable memory | yes |
| host temp file | no | no |
| interpreter-only cache | usually no story authority | no |

Run:

```text
establish → SAVE → mutate → RESTORE → inspect
```

Then test `UNDO`.

---

## 22.6 Artifact SHA drift

Possible causes:

- source changed;
- predecessor changed;
- patch order changed;
- serial not normalized;
- toolchain changed;
- build path injected metadata;
- assembler version changed;
- nondeterministic generation.

Compare:

```text
source-tree identities
assembly
normalization receipt
header fields
binary diff
tool versions
```

Do not relock until drift is explained.

---

## 22.7 Glulxe crash/hang

Test matrix:

| Story | Interpreter | Result |
|---|---|---|
| locked known-good | pinned reference | ? |
| candidate | pinned reference | ? |
| locked known-good | candidate interpreter | ? |
| candidate | candidate interpreter | ? |

This isolates story vs interpreter.

Then inspect:

- memory-access verification;
- call stack;
- undo;
- I/O;
- malformed artifact/header;
- infinite ZIL loop.

---

## 22.8 Infinite loop

For ZIL loops:

- inspect `AGAIN`;
- inspect mutation of loop variable;
- inspect child traversal and `NEXT?`;
- inspect routines which return to same state;
- reproduce with a bounded fixture.

---

## 22.9 Global budget failure

Do not immediately raise a limit.

Classify each new state element:

- can object location own it?
- can a flag own it?
- can a property own it?
- can an existing table own it?
- can a compact new subsystem table own several facts?
- is the “state” derived and therefore should not be stored?

If the limit itself is a compatibility shim and the repo has an explicit runtime-foundation mechanism to raise it, follow that mechanism rather than ad hoc edits.

---

# 24. Parser Failure Decision Tree

```text
COMMAND FAILS
|
+-- "unknown word"?
|    |
|    +-- yes → vocabulary/dictionary
|
+-- grammar complaint?
|    |
|    +-- yes → SYNTAX / preposition / grammar form
|
+-- asks "which do you mean"?
|    |
|    +-- vocabulary collision / scope / distinguishability
|
+-- says object not visible/present?
|    |
|    +-- scope / LOC / light / containment / discovery
|
+-- parses but refuses?
|    |
|    +-- action routine / object action / world precondition
|
+-- NPC does wrong thing?
|    |
|    +-- WINNER / actor routing / NPC state
|
+-- test passes, real play fails?
     |
     +-- test-only setup / unreachable precondition / leaked control /
         missing real journey
```

---

# 25. Cross-VM Parity Engine

## 24.1 Classify feature relation

Each feature is one of:

### Shared semantic feature

Should behave equivalently in `.z3` and `.ulx`.

### Glulx-only extension

Deliberately exceeds preserved Z-machine edition.

Still must preserve the historical line.

### Preservation-only

Historical artifact must remain unchanged; new active line need not reproduce every obsolete technical limitation.

### Interpreter-only

Changes runtime implementation, not story semantics.

Never mix categories in one claim.

---

## 24.2 Shared route

For shared behavior, prefer the same natural command route.

Compare **semantic outcomes**, not necessarily every byte of screen formatting unless formatting is the contract.

Record intentional differences.

---

## 24.3 No false parity

Do not claim parity if one side uses:

- test-only verbs;
- teleport/setup;
- different puzzle state;
- different parser shorthand;
- a different story lineage.

Parity requires comparable conditions.

---

# 26. Performance Engine

## 25.1 Story performance

Measure before optimizing.

Separate:

- parser time;
- object scans;
- table loops;
- output volume;
- save/restore;
- interpreter overhead;
- host I/O.

A slow transcript is not proof of slow ZIL logic.

---

## 25.2 Interpreter performance

Use a fixed story artifact.

Compare native interpreter builds.

Representative workloads should include:

- parser-heavy input;
- movement;
- inventory/object traversal;
- timers/clock;
- Mara/NPC behavior;
- House of Records or other persistence-heavy paths;
- undo;
- save/restore.

Performance result:

```text
speedup + transcript equivalence + state equivalence
```

not speedup alone.

---

## 25.3 Compiler performance

If ZILF compilation becomes slow:

- distinguish source expansion from assembly;
- inspect generated assembly size;
- inspect include duplication;
- inspect macro explosion;
- inspect host process/I/O cost.

Do not optimize story semantics to repair a toolchain bottleneck without evidence.

---

# 27. Security / Robustness Lens

This repo is a game, but robustness still matters.

Inspect:

- unsafe shell interpolation in qualification;
- untrusted artifact inputs;
- path traversal in staging;
- accidental executable/tool replacement;
- dependency pin drift;
- downloaded tool checksum;
- test/prod boundary;
- temporary-directory/cwd assumptions;
- malformed story verification.

Fail closed on provenance.

---

# 28. Edge Campaigns

## Parser boundaries

- singular/plural;
- adjectives;
- same synonym on multiple objects;
- darkness;
- nested containers;
- NPC vs player actor;
- direct vs indirect object;
- malformed commands;
- canonical shorthand.

## World-state boundaries

- object already moved;
- object destroyed;
- repeat action;
- state already complete;
- low/high tide;
- NPC absent;
- prerequisite not witnessed;
- save/restore mid-sequence.

## VM boundaries

- max/sentinel values;
- object/property counts;
- table bounds;
- stack/locals;
- Z-machine word overflow;
- Glulx 32-bit differences;
- invalid memory access.

## Artifact boundaries

- unlocked candidate;
- wrong serial;
- wrong checksum;
- wrong story version;
- stale predecessor;
- changed toolchain.

## Runtime boundaries

- RNG;
- undo capacity;
- save path;
- EOF/input termination;
- timeout;
- reference vs optimized interpreter.

---

# 29. Contradiction Resolution

Classify contradictions.

## DEFINITIONAL

Example:

> “`PREPARE` should be an actor verb”  
> vs  
> “`PREPARE` already behaves as parser grammar/preposition material.”

Resolve lexical role before code.

## SCOPE

Example:

> object exists  
> vs  
> player cannot see it.

Check scope/light.

## TEMPORAL

Example:

> README says Release 1294 is current  
> vs  
> live master contains 1304.

Live state wins; README is stale.

## AUTHORITY

Example:

> new table says fish is exhibited  
> vs  
> fish object is physically elsewhere.

Object location likely wins; remove parallel state.

## VM

Example:

> technique works in Glulx  
> vs  
> `.z3` breaks.

Classify shared vs Glulx-only feature.

## TOOLCHAIN

Example:

> upstream ZILF 1.9 accepts pattern  
> vs  
> pinned 1.8 rejects it.

Repo pin governs current train.

## GENUINE TRADEOFF

Example:

> local parser special-case  
> vs  
> reusable grammar abstraction.

Use Tribunal and actual repeated cases.

---

# 30. Code Tribunal — Zork Variant

When approaches compete:

## Judge — Conservative Zork

Argue for:

- preserve canonical behavior;
- minimal local authored change;
- reuse existing authority;
- no new framework.

## Jury — Evidence

Examine:

- natural transcripts;
- source ownership;
- existing similar modules;
- ZILF semantics;
- VM spec;
- earlier regressions;
- state budget;
- player intent.

## Executioner — Falsification

Build the smallest POC which could disprove the chosen design.

Examples:

- parser smoke in the real room;
- actor command with captured `WINNER`;
- save/restore fixture;
- same `.ulx` under two interpreters;
- cross-VM route.

## Verdicts

- LOCAL AUTHORED CHANGE
- REUSE EXISTING AUTHORITY
- SHARED ABSTRACTION EARNED
- TOOLCHAIN MIGRATION REQUIRED
- INTERPRETER FIX
- TEST IS WRONG
- PRODUCT CONTRACT IS WRONG
- INSUFFICIENT EVIDENCE

---

# 31. HTE-Zork Lens Packs

Activate only relevant packs.

## Lens ZIL — Language Semantics

Questions:

- interpreted or compiled context?
- local/global binding?
- read-time evaluation?
- macro expansion?
- table purity/mutability?
- loop semantics?
- return semantics?

## Lens PARSER — Grammar

Questions:

- vocabulary?
- syntax?
- preposition?
- scope?
- actor?
- direct/indirect object?
- parser hook blast radius?

## Lens WORLD — State

Questions:

- who owns fact?
- exact object?
- location?
- flag/property?
- table?
- duplicate state?
- persistence?

## Lens ZILF — Toolchain

Questions:

- exact pin?
- compile target?
- compiler warning?
- generated assembly?
- version-specific behavior?

## Lens ZVM — Z-machine

Questions:

- exact VM version?
- 16-bit constraint?
- object/property limit?
- opcode version?
- save semantics?

## Lens GLULX — VM

Questions:

- version?
- 32-bit assumptions?
- memory/header?
- gestalt?
- checksum?
- save memory?

## Lens GLULXE — Interpreter

Questions:

- exact source/build?
- memory verification?
- RNG?
- undo?
- save path?
- semantic equivalence?

## Lens PROV — Provenance

Questions:

- predecessor?
- source identity?
- changed paths?
- toolchain?
- candidate/lock state?

## Lens PRODUCT — Player Truth

Questions:

- can player reach it?
- ordinary grammar?
- physical/state prerequisites?
- does prose promise it?
- causal output?
- canonical solution preserved?

---

# 32. Product-Intent Engine — “Still Zork”

A technically valid feature can still be wrong.

Before shipping, ask:

1. Does it preserve the original world’s authority?
2. Does the parser interaction feel like parser IF rather than a command API?
3. Is the behavior authored and causal?
4. Does a real object remain a real object?
5. Does failure teach something?
6. Does the feature avoid becoming a universal framework without need?
7. Does the canonical puzzle remain valid?
8. Does the prose tell the truth?
9. Does an NPC know only what they can honestly know?
10. Can an ordinary player discover/use the feature?

---

# 33. “Described World Is Law” Protocol

For noun-honesty work:

## Step 1 — Capture prose

Record exact room/object prose which names a concrete noun.

## Step 2 — Test parser

Try:

```text
EXAMINE NOUN
LOOK AT NOUN
```

and any obvious local physical verb.

## Step 3 — Classify existing owner

Does an object already represent it elsewhere?

Could it be:

- a room-local semantic target;
- a synonym for an existing object;
- a globally shared object;
- intentionally unaddressable atmosphere?

## Step 4 — Add the smallest honest representation

No generic scenery engine merely to close one noun.

## Step 5 — Preserve existing puzzle semantics

Examinable does not imply takeable, openable, breakable, or useful.

## Step 6 — Natural transcript

Prove the room’s own sentence no longer becomes a parser lie.

---

# 34. NPC / Mara Integrity Protocol

Mara is an authored person, not a generic AI agent.

When extending her:

## Knowledge

She should know through:

- witnessing;
- being shown;
- being told where authored;
- her own physical journey;
- prior established memory.

Not engine omniscience.

## Movement

Physical routes and prerequisites matter.

No teleportation to satisfy a test.

## Actor commands

Respect `WINNER`.

## State

Use existing Mara authority first.

## Boundaries

Do not turn authored behavior into:

- approval meter;
- affinity stat;
- quest log;
- generic party AI;
- omniscient hint engine.

---

# 35. Natural Product-Journey Protocol

A release claim should eventually have a route shaped like:

```text
fresh/known start
→ ordinary LOOK / movement
→ acquire real prerequisite
→ traverse real map
→ manipulate real object
→ observe result
→ save/restore/undo if relevant
→ revisit consequence
```

Allowed test setup should be clearly marked as **mechanic isolation**, not the final product journey.

---

# 36. Review Protocol

Review changed code through five lenses:

## 1. Compile-time

- symbols defined before use?
- bracket structure?
- macro/read-time semantics?
- target-specific compile?

## 2. Parser

- grammar legal?
- vocabulary honest?
- no collision?
- actor correct?
- scope?

## 3. World

- state owner?
- no duplicate object/state?
- repeated action?
- persistence?

## 4. VM/runtime

- target correct?
- bounds?
- save/undo?
- interpreter assumptions?

## 5. Release

- changed paths?
- prod/test separation?
- predecessor preserved?
- artifact lock?
- exact head?

Do not fill review with style nits while a state-authority bug exists.

---

# 37. Anti-Patterns HTE-Zork Must Detect

## 36.1 Lisp hallucination

“ZIL is Lisp, so this construct should work.”

Wrong reasoning model.

---

## 36.2 Grammar-by-test

Adding syntax aliases because a test used unsupported shorthand.

Fix the test when the product grammar is already correct.

---

## 36.3 Missing-verb constant hack

Manually defining a missing `V?FOO` rather than fixing syntax/load order.

---

## 36.4 Everything-global

Adding a new global for every fact.

Use honest state ownership.

---

## 36.5 Parallel truth

Object is in Room A but a boolean says Room B.

---

## 36.6 Duplicate canonical object

Creating a “new rug,” “new fish,” or second route instead of extending the real owner.

---

## 36.7 Test verb leakage

Setup command reaches production.

Immediate release blocker.

---

## 36.8 Latest-toolchain drift

Updating ZILF/Glulxe because upstream is newer during an unrelated train.

---

## 36.9 Glulx-is-Z-machine

Assuming Z-machine object/opcode/memory rules directly describe a `.ulx`.

---

## 36.10 Glulxe-is-Glulx

Changing interpreter code and calling it a VM feature.

---

## 36.11 Compile-green fallacy

“ZILF compiled, therefore the release works.”

No.

---

## 36.12 Transcript-only fallacy

A scripted transcript passed because test setup injected impossible state.

---

## 36.13 README authority fallacy

An older README overrides live exact head.

---

## 36.14 Artifact relock without diagnosis

SHA changed, so update manifest.

Forbidden unless the change is understood and intended.

---

## 36.15 Generic-engine fever

One mechanism succeeds, so build a universal framework.

Earn abstraction.

---

## 36.16 Playerless feature

A test can trigger it, but no ordinary player can.

---

## 36.17 Parser omniscience

Put an object in `GLOBAL-OBJECTS` only so a test can name it anywhere.

---

## 36.18 NPC omniscience

Mara reports unseen facts because the engine knows them.

---

## 36.19 State injection as product proof

Setup verb establishes every prerequisite, then calls that a real journey.

---

## 36.20 Audit Ouroboros

Build another validator to validate the validator rather than fixing the feature.

Stop when evidence is sufficient.

---

# 38. Agent Entry Protocol

Every new AI working on this repo should begin here.

## Step 1 — Re-query live GitHub

Get:

- master SHA;
- open PRs;
- active PR head;
- base;
- merge state.

## Step 2 — Identify the active train

Read:

- PR body;
- train README;
- `patch-series.json`;
- qualifier;
- planning contract only as supporting context.

## Step 3 — Identify predecessor

Record exact:

- release;
- artifact SHA;
- production source identity;
- dev source identity.

## Step 4 — Inspect changed-path contract

Do not wander outside it casually.

## Step 5 — Inspect the real owner

Search source for:

- object;
- flag;
- route;
- syntax;
- action;
- table;
- prior release module.

## Step 6 — Classify the failure layer

ZIL?
parser?
world?
ZILF?
VM?
artifact?
Glulxe?
Glk?
test?
provenance?

## Step 7 — Reproduce

Prefer the smallest natural command sequence which still demonstrates the issue.

## Step 8 — Build hypotheses

At Depth 5, at least three.

## Step 9 — Patch surgically

Preserve authority.

## Step 10 — Qualify in layers

Targeted → regressions → product → exact release.

---

# 39. Multi-Agent Handoff Contract

When handing to another AI, include:

```text
REPO:
DEFAULT BRANCH:
CURRENT MASTER SHA:

ACTIVE PR:
PR HEAD:
PR BASE:

RELEASE/TRAIN:
PREDECESSOR RELEASE:
PREDECESSOR ARTIFACT SHA256:
PRODUCTION SOURCE ID:
DEV SOURCE ID:

TOOLCHAIN:
ZILF:
ASSEMBLER:
GLULXE:
CHEAPGLK:

EXPECTED CHANGED PATHS:

CURRENT FAILING GATE:
EXACT FAILURE:
REPRO COMMAND/TRANSCRIPT:

WHAT HAS BEEN PROVED:
WHAT HAS NOT BEEN PROVED:

CURRENT CANDIDATE ARTIFACT:
LOCKED?:

OPEN REVIEW THREADS:

FORBIDDEN DRIFT:
MERGE AUTHORITY:
```

Do not hand off “it mostly works.”

Hand off an exact frontier.

---

# 40. Current Live Lessons — PR #91 / Release 1304

Release 1304 is a compact case study in why HTE-Zork exists.

## Lesson 1 — Syntax definition timing is real

The release eventually isolated parser syntax into:

```text
living_collection_syntax.zil
```

and required it before Mara code so created verb atoms existed when referenced.

Generalize:

> compile-time parser definitions are dependencies.

---

## Lesson 2 — Natural language labels are not parser roles

`FILE`, `PREPARE`, `REST`, and `SLEEP` looked semantically attractive but interacted with existing grammar roles.

The repaired actor-winner verbs became distinct forms such as:

```text
COOK
NAP
ARCHIVE
```

while player-facing “ASK MARA TO …” retained its intended route.

Generalize:

> choose grammar that fits the parser, not merely English labels.

---

## Lesson 3 — Actor routing matters

Mara-winner commands required different reasoning from player-winner `ASK` grammar.

Generalize:

> capture `WINNER` before assuming dispatch.

---

## Lesson 4 — Lighting is product state

Qualification needed lit test rooms where object/NPC visibility was required.

Generalize:

> a scope failure may be correct simulation, not parser failure.

---

## Lesson 5 — Exact objects preserve evidence

One reservoir char exists.

The story refuses to create a convenient duplicate if that known specimen already exists.

Generalize:

> physical provenance can be a first-class mechanic.

---

## Lesson 6 — State table beats global sprawl

The Living Collection uses a compact schema/versioned table for its narrow facts.

Generalize:

> state structure should match subsystem authority and global-budget reality.

---

## Lesson 7 — Qualification is multi-layered

The train checks:

- predecessor;
- source identities;
- changed paths;
- smell reports;
- include order;
- forbidden production tokens;
- byte-preserved authority files;
- production/dev/test compile;
- serial normalization;
- `.ulx` checksum;
- production boot;
- deterministic parser history;
- artifact identity;
- candidate/lock rerun.

Generalize:

> the release contract is stronger than “CI green.”

---

# 41. Current Live Lessons — PR #92 / Next Product Frontier

At creation time, PR #92 is open on exact head:

```text
1a8a6cdd0d313f12a4446382d02f5ca085097715
```

It builds a described-world honesty spine on locked 1304.

Its direction reinforces several core laws:

- house architecture named in prose should answer parser questions;
- the cellar descent is physical commitment, not fast travel;
- Dam #3 is authored unique machinery, not a generic machine framework;
- test overlay controls must not leak into production;
- nested earlier release qualification remains meaningful;
- existing 1304/1295/1279 authority must compose rather than be reinvented.

Every future AI must re-query PR #92 because this snapshot may already be stale.

---

# 42. Release Qualification Template

```text
[HTE-ZORK RELEASE QUALIFICATION]

LIVE REPO
  repository:
  master:
  active PR:
  exact head:
  base:

TRAIN
  release:
  predecessor:
  changed paths:
  production/test split:

TOOLCHAIN
  ZILF:
  assembler:
  Glulxe:
  Glk:

SOURCE GATES
  predecessor source identity:
  staging:
  smell/static:
  authority preservation:

COMPILATION
  production:
  dev:
  test:

ARTIFACT
  format:
  VM version:
  serial:
  checksum:
  size:
  sha256:
  locked:

PLAYER EVIDENCE
  targeted route:
  natural journey:
  save/restore:
  undo:
  regressions:
  cross-VM:

REVIEW
  threads:
  current head after fixes:

VERDICT
  Q-level:
  confidence:
  merge-ready:
  blockers:
```

---

# 43. Debugging Output Template

```text
[HTE-ZORK DEBUG] Depth X/5

LIVE STATE:
  repo/head/train

SYMPTOM:
  exact command/error

LAYER:
  parser / ZIL / ZILF / Z-machine / Glulx / Glulxe / Glk / provenance / test

OBSERVATIONS:
  O1...
  O2...

ASSUMPTIONS:
  A1...

HYPOTHESES:
  H1:
    predicts:
    falsifier:
  H2:
  H3:

STATE OWNER:
  ...

DISCRIMINATING TEST:
  ...

ROOT CAUSE:
  ...

PATCH:
  ...

PROOF:
  compile:
  parser:
  world:
  artifact:
  runtime:
  regression:

CONFIDENCE:
  X/5
```

---

# 44. Architecture Decision Template

```text
[HTE-ZORK ARCHITECTURE]

QUESTION:
CONSTRAINTS:
EXISTING AUTHORITY:
VM TARGETS:
STATE BUDGET:

OPTION A:
  mechanism:
  parser impact:
  state owner:
  save impact:
  cross-VM impact:
  migration:
  falsifier:

OPTION B:
...

TRIBUNAL:
  Judge:
  Jury:
  Executioner:

VERDICT:
WHY:
REGRESSION CONTRACT:
```

---

# 45. ZIL Parser Change Checklist

Before changing grammar:

- [ ] exact player sentence is known;
- [ ] current failure text captured;
- [ ] vocabulary checked;
- [ ] existing `SYNTAX` checked;
- [ ] preposition/verb collision checked;
- [ ] object scope checked;
- [ ] lighting checked;
- [ ] `WINNER` checked;
- [ ] `PRSO` / `PRSI` checked;
- [ ] canonical grammar preserved;
- [ ] no test-only alias motivation;
- [ ] natural transcript added.

---

# 46. New Object Checklist

Before adding an `OBJECT`:

- [ ] no existing object already owns the noun;
- [ ] not merely a topic;
- [ ] not merely prose atmosphere;
- [ ] location is honest;
- [ ] synonyms do not steal another object;
- [ ] flags/properties minimal;
- [ ] action routine local where possible;
- [ ] object does not create parallel puzzle state;
- [ ] save/restore behavior is natural;
- [ ] repeated interactions considered;
- [ ] player prose remains true.

---

# 47. New Persistent State Checklist

Before adding a state bit:

- [ ] fact cannot be derived;
- [ ] existing flag/property/location cannot own it;
- [ ] existing subsystem table cannot own it;
- [ ] new table slot has clear authority;
- [ ] initialization is deterministic;
- [ ] save/restore tested;
- [ ] undo tested if player-visible;
- [ ] reset/restart tested where relevant;
- [ ] no stale mirror of another state source.

---

# 48. Toolchain Upgrade Protocol

A ZILF, Glazer, Glulxe, or CheapGlk upgrade is its own engineering event.

## Step 1 — Freeze known-good artifacts

Record current story/source identities.

## Step 2 — Change one tool layer

Do not upgrade the whole stack at once unless required.

## Step 3 — Recompile unchanged source

Compare:

- diagnostics;
- assembly;
- artifact;
- transcripts.

## Step 4 — Classify artifact drift

Expected due compiler change?

Bug fix?

Metadata only?

Semantic?

## Step 5 — Run preservation suite

Historical `.z3`, active `.ulx`, parser routes, save/restore.

## Step 6 — Decide migration

Only then update repo pins.

---

# 49. VM-Level Escalation Protocol

Most product work should remain at ZIL/parser/world level.

Escalate to VM internals when evidence requires it.

Triggers:

- invalid memory access;
- object/property limit;
- malformed header;
- opcode mismatch;
- stack corruption;
- save file mismatch;
- interpreter discrepancy;
- compiler-generated assembly bug.

At escalation:

1. freeze source;
2. inspect generated assembly;
3. inspect VM spec;
4. inspect interpreter behavior;
5. create minimal fixture;
6. fix lowest responsible layer.

Do not rewrite gameplay code to avoid a demonstrated compiler/runtime defect unless that workaround is explicitly chosen.

---

# 50. HTE-Zork Confidence Model

## 5/5 — Established

- direct source + runtime evidence;
- exact artifact;
- relevant normative spec;
- regression proof;
- exact-head qualification.

## 4/5 — High

- strong source/runtime evidence;
- one minor unverified boundary.

## 3/5 — Moderate

- likely root cause;
- partial reproduction;
- meaningful uncertainty remains.

## 2/5 — Low

- inference or stale evidence;
- no discriminating test yet.

## 1/5 — Speculative

- analogy;
- no direct evidence.

Do not use confidence as decoration.

If 5/5, name the evidence.

---

# 51. Learning / Memory Protocol

After a meaningful failure, record the **motif**, not merely the incident.

Good memory:

```text
Motif: V? atom referenced before SYNTAX is interpreted.
Signal: undefined action/verb atom during compile.
Check: root include order and syntax registration.
```

Bad memory:

```text
Release 1304 was annoying.
```

Useful motifs from current history:

- syntax load-order dependency;
- preposition/verb collision;
- actor `WINNER` distinction;
- darkness/scope false parser diagnosis;
- stale README vs live head;
- test transcript grammar drift;
- exact specimen/provenance;
- candidate lock gate mistaken for normal failure;
- Glk save cwd;
- interpreter optimization must preserve story identity.

---

# 52. InvisiSynth / Archaeology for Zork Engineering

When conventional reading does not explain behavior, search:

## Upstream ZILF

- changelog;
- compiler diagnostics;
- parser library;
- tests;
- language skill/docs.

## Historical Infocom source conventions

Use for understanding, not automatic authority over the repo’s current adapted lineage.

## VM specs

- Z-machine standard;
- Glulx spec;
- Glk spec;
- Quetzal;
- Blorb when resources matter.

## Interpreter source

- Glulxe;
- reference Z-machine interpreter behavior if parity issue;
- CheapGlk.

## Repo archaeology

- earlier release README;
- patch series;
- previous exact qualifier;
- commit that introduced owner state;
- PR discussion.

### Evidence rule

Archaeology can explain mechanism.

It cannot override the active train’s exact contract without an intentional change.

---

# 53. Normative / Primary References

These references are for semantics. **Live repo pins remain authoritative for actual builds.**

## ZILF

Repository:

https://github.com/taradinoc/zilf

At document creation, upstream changelog includes ZILF 1.9 (2026-06-13), while `acrinym/zork1` modern qualification remains pinned to ZILF 1.8 commit `45c60f1e37651f266ac92d49ae01748bb4909fa5`.

Relevant upstream AI coding guidance:

https://github.com/taradinoc/zilf/blob/branch/default/.agents/skills/zil-coding/SKILL.md

## Glulx

IFTF Glulx specification:

https://github.com/iftechfoundation/ifarchive-if-specs/blob/main/Glulx-Spec.md

Current spec at document creation: **3.1.3**.

## Glk

IFTF Glk specification:

https://github.com/iftechfoundation/ifarchive-if-specs/blob/main/Glk-Spec.md

## Blorb

IFTF Blorb specification:

https://github.com/iftechfoundation/ifarchive-if-specs/blob/main/Blorb-Spec.md

## Glulxe

Reference interpreter:

https://github.com/erkyrath/glulxe

## Z-machine

Standards index:

https://inform-fiction.org/zmachine/standards/

IF Archive specification index:

https://www.ifarchive.org/indexes/if-archive/infocom/interpreters/specification/

When making version-sensitive claims, consult the exact section for the target Z-machine version.

---

# 54. Repo-Native References

Always read live versions from `acrinym/zork1`.

High-value current locations:

```text
glulx/README.md
glulx/QUALIFICATION.md
expanded/README.md
docs/ADVENTURER_GUIDE.md
docs/planning/PRODUCT_KANBAN.md
docs/planning/product-kanban.json

glulx/<active-train>/README.md
glulx/<active-train>/patch-series.json
glulx/<active-train>/stage.py
glulx/<active-train>/qualify.sh
glulx/<active-train>/tests/

.github/workflows/
.beads/
```

Root/source files often include:

```text
zork1.zil
1actions.zil
1dungeon.zil
gclock.zil
gglobals.zil
gmacros.zil
gmain.zil
gparser.zil
gverbs.zil
...
```

Do not assume this list is complete.

---

# 55. AI Working Agreement

An AI entering Zork Highly Extended should behave as follows.

### It MAY

- inspect live source/history;
- run compiler/interpreter tests;
- build targeted release code;
- add local authored mechanics;
- add test-only setup when clearly isolated;
- research VM/compiler behavior;
- improve qualification evidence;
- optimize interpreter with semantic proof;
- use tables/object state to conserve globals.

### It SHOULD NOT

- invent a generic engine because one feature needs a local rule;
- rewrite canonical authorities casually;
- add parser aliases only to satisfy a bad test;
- use stale docs as current truth;
- swap toolchain versions without a migration;
- merge to historical source;
- leak test controls;
- claim natural play from state injection;
- relock artifact drift without explanation;
- conflate ZIL/ZILF/Z-machine/Glulx/Glulxe/Glk;
- stop after compile when product behavior was requested.

---

# 56. Invocation Examples

```text
HTE-Zork depth 5:
MARA, PREPARE fails to compile after this syntax change.
Trace ZILF definition-time semantics, WINNER routing, and parser grammar,
then patch and qualify the active train.
```

```text
HTE-Zork:
EXAMINE CHIMNEY fails at West of House.
Determine whether this is vocabulary, scope, an existing authority,
or a new semantic-target object.
```

```text
HTE-Zork + Z-machine:
This refactor works in the .ulx but breaks preserved .z3.
Find the version-specific constraint and preserve both.
```

```text
HTE-Zork + Glulxe:
The exact locked .ulx has different undo behavior under the optimized interpreter.
Isolate story vs interpreter and produce a falsifiable diagnosis.
```

```text
HTE-Zork depth 5 release:
Re-query acrinym/zork1, finish the active PR from exact live head,
qualify candidate → lock → exact-head rerun, close actionable review findings,
and merge only if the repo's current merge conditions are satisfied.
```

---

# 57. Compact Runtime Card

When context is tight, load this card:

```text
HTE-ZORK QUICK CARD

1. Re-query live acrinym/zork1.
2. Identify exact train, head, predecessor, pins, changed paths.
3. Name the failing layer:
   ZIL / parser / world / ZILF / Z-machine / Glulx / Glulxe / Glk / provenance.
4. Source order is semantics. SYNTAX may create V? atoms.
5. ZIL is MDL-derived, not Lisp. Interpreted ≠ compiled context.
6. Parser pipeline:
   word → syntax → noun/scope → action → PRSO/PRSI → world.
7. Check WINNER for actor commands.
8. Darkness/scope can impersonate parser failure.
9. Reuse canonical authority; avoid parallel state.
10. Exact objects/provenance beat duplicate convenience objects.
11. Conserve globals; tables/flags/location may be better owners.
12. Z-machine ≠ Glulx. Glulx ≠ Glulxe. Glk is I/O.
13. Repo pin beats upstream latest.
14. Test verbs stay out of production.
15. Natural journey > state injection.
16. Candidate lock gate is intentional.
17. Verify source identity + artifact checksum/hash + exact head.
18. A passing compile is not a passing release.
19. Preserve .z3 when train contract requires it.
20. No generic-system fever. Still Zork.
```

---

# 58. Depth-5 Self-Test for Any Proposed Change

Before calling a nontrivial change complete, answer every question.

## Repository

- What exact SHA did I start from?
- What exact SHA am I qualifying?
- What PR/train owns this work?
- What predecessor is locked?

## Language

- Is this interpreted ZIL or compiled routine semantics?
- Did I verify include order?
- Did I inspect macro/read-time behavior?

## Parser

- What exact command does a player type?
- What vocabulary is used?
- Which `SYNTAX` matches?
- What are `PRSO`, `PRSI`, `WINNER`, and `HERE`?
- Is the target visible/touchable?

## State

- What exact object/table/flag owns the fact?
- Did I duplicate existing truth?
- Does SAVE/RESTORE preserve it?
- Does UNDO behave honestly?

## VM

- Z-machine or Glulx?
- Exact VM version?
- Any word-size/object/opcode assumptions?
- Any optional capability?

## Artifact

- serial?
- checksum?
- SHA-256?
- exact source pins?
- locked?

## Interpreter

- exact Glulxe/Glk?
- deterministic test controls?
- reference comparison if interpreter changed?

## Product

- real player journey?
- canonical solution?
- prose truthful?
- no test leaks?
- causal failure?

## Release

- relevant regressions?
- exact-head CI?
- review threads?
- current merge authorization?

If any answer is unknown and materially affects correctness, the job is not complete.

---

# 59. Closing Principle

The technical challenge of Highly Extended Zork is not merely making **more code** compile.

It is preserving a chain of truth:

```text
the prose says a world exists
→ the parser can understand the player
→ the action reaches the intended authored mechanism
→ the real object/state changes
→ the compiled VM artifact encodes it correctly
→ the interpreter executes it faithfully
→ save/restore/undo preserve causality
→ a real player can experience it
→ the release can prove exactly what shipped
```

HTE-Zork exists to keep that chain unbroken.

When in doubt:

> **Find the real owner. Name the real layer. Reproduce the real player behavior. Lock the real artifact.**

---

**HTE-Zork v1.0**  
**ZIL / ZILF / Z-machine / Glulx / Glulxe / Glk / `acrinym/zork1`**  
**Created from HTE-Code v2.0 principles and the live Highly Extended Zork release lineage, 2026-08-30.**
