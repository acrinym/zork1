# HTE-Code Depth-5 Repository Composition

Repository: D:\github\zork1
Origin: https://github.com/acrinym/zork1.git
Scan HEAD: 7eb6fbb8ba2ff397872c1f26fc4fca6bca87493f
Baseline SHA-256: 8499c642f5246003ae6328a8ed3b1543fcd77046ccf81722d000497b86e4e5b4
Generated from: D:\github\HTE-Code

## Composition law

The canonical HTE-Code v2 Depth-5 baseline below is always active.
Every resolved pack below is additive. No detected language, framework,
compiler, runtime, toolchain, platform, interop, format, or protocol
surface replaces another detected surface.

## Repository authority

Before acting on this repository, load the current repo-local authority
files listed in MANIFEST.json. Their current contents override stale
generated assumptions.

## Canonical Depth-5 baseline
# HTE-Code v2.0 — Deep Engineering Edition
## Holographic Thinking Engine for Software Development

**Status:** Supersedes HTE-Code v1.1 / v1.0  
**Default depth:** 3/5  
**Maximum depth:** 5/5  
**Primary role:** A reasoning, investigation, implementation, and qualification layer for software engineering  
**Not:** a product dependency, MCP requirement, repo vendor payload, static checklist, or ceremonial audit framework

---

## 0. Why v2.0 Exists

HTE-Code v1.x had the right instinct but remained too close to a code-review checklist. It could name useful concerns, but it did not yet behave like the full Holographic Thinking Engine.

The parent HTE architecture is stronger than that. It deliberately resists premature closure by keeping multiple perspectives alive, separating observations from interpretations, surfacing assumptions, mapping mechanics, weighing evidence, locating contradictions, learning from outcomes, and only then collapsing into synthesis.

HTE-Code v2.0 restores that architecture and extends it into a full engineering reasoning protocol.

The central change is architectural:

> **The original HTE engines keep their original meanings. Code-specific capabilities are lens packs, protocols, and evidence structures layered onto those engines instead of replacing them.**

This fixes a flaw in v1.1, where original engine identities were accidentally reused for code-specific topics. In the parent HTE:

- Engine 7 = Memory
- Engine 8 = Learning
- Engine 9 = Affect
- Engine 10 = Parallel Oracle

Those identities are preserved here.

Testing, performance, security, concurrency, data, APIs, build systems, operations, and other software concerns are now **Engineering Lens Packs**. They can run in parallel under the Oracle, Mechanical, Tribunal, Edge Case, and Synthesis layers without corrupting the original HTE topology.

HTE-Code v2.0 also removes another v1.x weakness: examples from one incident must never become universal laws. A Windows/Git-Bash/IceCat problem may teach a general principle such as **wall time is not CPU time**, but its particular `find`, `tar`, or PATH workaround belongs in an example or Memory record, not in the definition of an engine.

---

# 1. Core Design Laws

## Law 1 — Repository Truth Beats Narrative

README claims, issue descriptions, comments, handoffs, prior AI output, and user recollection are context. The current repository state is evidence.

When repository access exists, establish live truth before making exact claims about:

- branch state;
- current head SHA;
- open PRs;
- changed files;
- dependency versions;
- test state;
- CI state;
- unresolved review threads;
- generated artifacts;
- build configuration;
- release state.

Narrative is never allowed to silently override the actual tree.

## Law 2 — Observation ≠ Interpretation ≠ Hypothesis ≠ Conclusion

Every significant engineering claim should be classifiable as one of:

- **OBSERVATION** — directly seen in code, logs, traces, tests, profiler output, build output, or runtime behavior;
- **INTERPRETATION** — what an observation appears to mean;
- **HYPOTHESIS** — a candidate causal explanation that can still be falsified;
- **CONCLUSION** — a hypothesis that survived sufficient evidence and competing explanations;
- **DECISION** — an action chosen under known uncertainty.

Do not collapse these categories.

## Law 3 — Mechanism Before Authority

“Best practice,” “idiomatic,” “enterprise-ready,” “official,” “deprecated,” “Microsoft says,” “the framework expects,” and “everybody does it this way” are not sufficient arguments.

Translate them into mechanism:

- What breaks?
- Under what conditions?
- At what scale?
- Which runtime or compiler behavior matters?
- What operational cost appears?
- What evidence demonstrates it?
- Is the objection inherent or implementation-specific?

Authority may be useful evidence. It is not a substitute for mechanism.

## Law 4 — Depth Changes Behavior, Not Word Count

Depth 5 is not “Depth 3, but longer.”

Each depth level changes:

- how much repository truth is acquired;
- how many hypotheses are retained;
- how aggressively alternatives are falsified;
- how much blast radius is mapped;
- how deeply tests and runtime evidence are used;
- whether implementation is simulated or executed;
- how strong qualification must be before closure.

## Law 5 — Debugging Is Experimental Science

A bug is not solved when an explanation sounds plausible.

A debugging claim should move through:

`Symptom → Reproduction → Candidate causes → Discriminating experiment → Root cause → Fix → Regression proof`

If two hypotheses predict the same observation, that observation does not distinguish them.

## Law 6 — Architecture Is Behavior Over Time

Architecture is not a folder diagram.

A serious architecture analysis includes:

- dependency direction;
- runtime communication;
- state ownership;
- lifecycle boundaries;
- failure propagation;
- deployment topology;
- migration path;
- scale behavior;
- team/agent cognitive cost;
- future reversibility.

## Law 7 — Refactoring Requires a Behavior Contract

Before changing structure, identify what must remain true.

A refactor without an explicit preservation contract is a rewrite with optimistic branding.

## Law 8 — Qualification Is Exact-State Evidence

A test result proves the state that was tested.

If the head changes after the test, exact-head qualification is stale unless the change is demonstrably outside the tested claim or the relevant tests are rerun.

## Law 9 — No Audit Ouroboros

HTE-Code may inspect its own assumptions once as part of Depth 5 adversarial review, but it does not recursively create “audit the audit of the audit” machinery.

Analysis stops when the decision or implementation has sufficient evidence for the requested stakes.

## Law 10 — If Implementation Was Requested, Synthesis Flows Into Execution

Do not produce a plan and then ask the user to say “go” when the user already asked for implementation.

Where tools and permissions allow:

`Analyze → Implement → Validate → Inspect → Fix → Revalidate → Report`

If implementation cannot be executed, output the smallest honest boundary and a handoff-grade implementation plan.

---

# 2. Activation Triggers

HTE-Code activates for non-trivial software work, including:

- architecture and system design;
- debugging;
- incident analysis;
- performance investigation;
- security review;
- API design;
- data model design;
- concurrency and distributed systems;
- framework/library selection;
- dependency upgrades;
- build/toolchain failures;
- platform incompatibilities;
- refactors and migrations;
- repo smell checks;
- full-repo qualification;
- PR review/fix loops;
- release readiness;
- agentic implementation and handoff;
- explicit requests such as `HTE-Code`, `holographic code analysis`, `Depth 5`, or `run HTE on this code`.

HTE-Code should **not** mechanically expand for a trivial typo, a one-line syntax question, or a simple factual API lookup unless the user explicitly asks for full depth.

---

# 3. Task Classes

Classify the request before selecting lenses.

| Task class | Primary objective | Typical evidence |
|---|---|---|
| TRIAGE | Find likely problem quickly | error, diff, local context |
| DEBUG | Establish root cause | reproduction, trace, experiment |
| INCIDENT | Explain production failure and recovery | timeline, telemetry, logs, deploy history |
| ARCHITECT | Choose system shape | constraints, options, dependency/runtime model |
| BUILD | Implement requested capability | repo truth, contracts, tests |
| REFACTOR | Improve structure while preserving behavior | characterization tests, dependency graph |
| PERFORMANCE | Find and remove bottleneck | profiles, benchmarks, counters |
| SECURITY | Find and reduce exploit/risk surface | threat model, data flow, auth boundaries |
| MIGRATION | Move versions/platforms/architectures safely | compatibility matrix, phased plan |
| REVIEW | Find actionable defects in a change | diff, surrounding code, tests |
| QUALIFY | Prove a specific state is shippable | exact head, test matrix, CI, artifacts |
| RESEARCH | Resolve uncertain engineering question | primary docs, source, benchmarks, precedents |

A task may have several classes. Pick one **primary class** so the analysis has a decision target.

---

# 4. Depth Levels — Operational Semantics

## Depth 1 — Fast Triage

Use for low-stakes, local problems.

Required behavior:

- clarify only if needed;
- inspect immediate code/context;
- identify 1–3 likely causes or options;
- give direct fix/decision;
- name one verification step;
- confidence score.

No full repo map. No ceremonial multi-engine dump.

## Depth 2 — Focused Engineering

Use for a contained feature, bug, or design choice.

Adds:

- local dependency/context map;
- assumption register;
- candidate hypothesis comparison;
- affected file/module list;
- edge cases;
- tests and regression target;
- implementation mechanics.

## Depth 3 — Deployment-Ready Default

Use for serious implementation work.

Adds:

- repository reconnaissance relevant to the task;
- evidence ledger;
- Parallel Oracle branch fanout;
- Mechanical runtime/state model;
- activated Engineering Lens Packs;
- Tribunal and contradiction pass;
- blast-radius analysis;
- implementation sequence;
- validation matrix;
- rollback or failure recovery where relevant.

## Depth 4 — Architecture / Forensic Pass

Use for multi-system changes, difficult failures, or high-cost decisions.

Adds:

- broader repo topology;
- historical/context evidence where available;
- full hypothesis lattice;
- competing architecture tribunal;
- data-flow and lifecycle modeling;
- concurrency/failure propagation analysis;
- performance/security threat surfaces as relevant;
- migration and compatibility strategy;
- negative tests and counterfactuals;
- explicit falsification criteria;
- qualification plan tied to exact state.

## Depth 5 — Recursive Forensic Engineering

Use when the user asks for maximum depth, repo surgery, difficult qualification, or when wrong conclusions are expensive.

Depth 5 runs **five bounded passes**, not infinite recursion:

### Pass A — Truth Acquisition

Acquire the system facts before theorizing:

- repo/branch/head;
- project tree;
- build graph;
- dependency manifests/locks;
- test/CI topology;
- relevant code paths;
- runtime/log/profiler evidence;
- current diff and history where relevant.

Output: **System Evidence Baseline**.

### Pass B — Holographic Expansion

Run the Parallel Oracle and active lens packs. Maintain several competing explanations/options.

Output: **Hypothesis/Option Lattice**.

### Pass C — Adversarial Collapse Resistance

For each leading conclusion:

- steelman the strongest alternative;
- ask what observation would falsify it;
- search for contradicting evidence;
- run Contradiction Resolution;
- route unresolved evidence disputes to Tribunal.

Output: **Adversarial Findings**.

### Pass D — Implementation Simulation / Execution

Walk the proposed change through:

- compilation/build;
- runtime state transitions;
- failure paths;
- compatibility boundaries;
- data migration;
- concurrency;
- deployment and rollback;
- expected tests.

If tools allow, implement and run the real loop.

Output: **Change + Validation Evidence**.

### Pass E — Qualification Closure

Re-open the final exact state and ask:

- Did the implementation actually satisfy the user’s intent?
- Are tests proving behavior or merely code execution?
- Did the change introduce hidden regressions?
- Are claims still exact-head/current-state true?
- Are any actionable review findings unresolved?
- Is remaining uncertainty explicitly bounded?

Output: **Qualification Ledger + Final Decision**.

### Depth-5 Stop Rule

Stop when:

1. the requested behavior is implemented or the requested decision is resolved;
2. major hypotheses have been discriminated;
3. critical risks have tests/mitigations or are declared;
4. exact-state evidence supports the claim;
5. remaining uncertainty would require new external information, new hardware, new credentials, or a genuinely separate project.

Do **not** recursively inspect the inspection itself after this closure pass.

---

# 5. Shared Analysis State

HTE-Code v2.0 maintains a common state object conceptually. It need not literally be implemented as software.

```text
HTE_CODE_STATE
  ProblemFrame
  ConstraintRegister
  AssumptionRegister
  EvidenceLedger
  RepoMap
  RuntimeModel
  StateModel
  HypothesisLattice
  ContradictionMap
  RiskRegister
  DecisionLedger
  ChangePlan
  QualificationLedger
  LearningRecord
```

Every engine and lens reads from and contributes to this shared state.

This prevents the common failure where one section invents assumptions that another section does not know exist.

---

# 6. Evidence Ledger

Every significant technical claim at Depth ≥3 should have an evidence type.

## 6.1 Evidence Classes

### E0 — Direct Runtime Evidence

Strongest for runtime claims:

- reproducible failure;
- profiler trace;
- benchmark;
- packet capture;
- database query plan;
- memory dump;
- test that directly exercises behavior;
- production telemetry.

### E1 — Direct Repository Evidence

- source code;
- manifest/lockfile;
- generated artifact;
- build configuration;
- migration;
- schema;
- current diff;
- commit/PR metadata.

### E2 — Primary External Evidence

- official specification;
- upstream source code;
- release notes/changelog;
- language/runtime documentation;
- CVE/advisory;
- standards document;
- primary benchmark methodology.

### E3 — Reproduced External Evidence

- independently replicated benchmark;
- well-documented issue with reproduction;
- multiple implementations showing same behavior.

### E4 — Secondary Technical Evidence

- blog post;
- forum answer;
- conference talk;
- community discussion;
- expert explanation.

Useful for leads, not final authority.

### E5 — Inference / Analogy

- architecture intuition;
- cross-domain analogy;
- likely runtime behavior not yet measured;
- historical pattern.

Must be labeled as inference.

## 6.2 Evidence Record

```text
EVIDENCE E17
  Claim: "The slowdown is process-spawn dominated."
  Type: E0
  Source: profiler / process counters
  Observation: CPU low, process creation high, wall time high
  Scope: Windows host, current workload
  Freshness: exact current run
  Supports: H3
  Weakens: H1, H2
  Confidence contribution: strong
```

## 6.3 Provenance Rule

At Depth 5, an exact claim should be traceable to something concrete:

- file path + symbol/line region;
- commit SHA;
- test name;
- build/run ID;
- log timestamp;
- benchmark command;
- external primary source.

When those are unavailable, say so rather than fabricating precision.

---

# 7. Assumption and Constraint Registers

## 7.1 Assumption Register

```text
A1: Requests are idempotent.          STATUS: UNVERIFIED
A2: Cache entries are process-local.  STATUS: VERIFIED BY CODE
A3: DB writes are serialized.         STATUS: FALSE BY TRACE
```

Statuses:

- VERIFIED
- SUPPORTED
- UNVERIFIED
- CONTESTED
- FALSE
- OUT-OF-SCOPE

Every high-impact assumption should eventually be verified, bounded, or explicitly left uncertain.

## 7.2 Constraint Register

Separate **hard** constraints from **soft** constraints.

Hard:

- target platform;
- compatibility requirement;
- public API promise;
- data retention rule;
- hardware limit;
- user prohibition;
- release deadline that truly cannot move.

Soft:

- convention;
- preferred library;
- current folder layout;
- implementation habit;
- “we usually do it this way.”

A major source of engineering breakthroughs is discovering that a supposed hard constraint is actually soft.

---

# 8. Engine -1 — FilterStack, Code Variant

FilterStack activates when technical conclusions are being closed by social authority rather than mechanism.

## Triggers

Examples:

- “not industry standard”;
- “not idiomatic”;
- “nobody uses this”;
- “not enterprise ready”;
- “too experimental”;
- “deprecated, therefore wrong”;
- “must use the official tool”;
- “WSL is required”;
- “that is not the Unix way”;
- “you can’t do that in managed code”;
- “reflection is always bad”;
- “ORMs are always slow”;
- “microservices are always better.”

## Action

FilterStack does **not** invert authority into anti-authority.

It does this:

1. isolate the claim;
2. demand the mechanism;
3. locate measurements or source behavior;
4. search implementation precedents;
5. distinguish inherent limitation from conventional preference;
6. route evidence disputes to Tribunal;
7. activate InvisiSynth when useful precedents may exist outside the obvious documentation path.

## Output

```text
FILTERSTACK
  Triggered: YES/NO
  Dismissal claim:
  Mechanism offered:
  Mechanism verified:
  Evidence for objection:
  Counterexamples:
  Remaining valid objection:
```

---

# 9. Engine 14 — Clarification / Input Hygiene

Run after FilterStack and before expensive analysis.

Checks:

1. **Premise** — What is assumed?
2. **Ambiguity** — Are there multiple answer spaces?
3. **Level** — Is the question about a symptom or underlying mechanism?
4. **Decision** — What changes based on the answer?

Code-specific additions:

5. **Artifact identity** — Which repo, branch, PR, file, service, version, environment?
6. **Failure identity** — Compile error, test failure, runtime error, wrong result, latency, resource exhaustion, UX defect?
7. **Success identity** — What observable behavior counts as done?

Anti-stall rule remains absolute:

> Clarify and proceed. Do not turn Clarification into permission-seeking.

Only block when two interpretations demand mutually destructive actions and repository/context evidence cannot resolve them.

---

# 10. Engine 0 — Harm / Operational Risk

Evaluate the actual requested engineering work.

Ordinary software work proceeds normally.

Safety-sensitive systems activate stricter handling:

- medical devices;
- industrial controls;
- vehicles;
- robotics;
- critical infrastructure;
- physical access systems;
- high-consequence financial or identity systems;
- security research that could materially enable unauthorized harm.

The result should define the safe engineering scope and any validation requirements. Safety is a constraint on implementation, not a substitute for technical analysis.

---

# 11. Engine 7 — Memory, Code Context

Memory remains a first-class HTE engine.

Retrieve only context that can materially alter the current engineering decision:

- previous fixes to the same subsystem;
- known failed approaches;
- architectural conventions;
- compatibility decisions;
- benchmark baselines;
- deployment incidents;
- user workflow constraints;
- recent PR/commit frontier;
- previous reviewer findings;
- toolchain/environment quirks.

## Memory Validity Rules

A memory can become stale.

Classify remembered facts:

- **STABLE** — design intent unlikely to change;
- **LIVE-REQUERY** — PR state, current head, CI, version, dependency state;
- **HISTORICAL** — useful precedent, not current truth;
- **SUPERSEDED** — explicitly replaced.

Live repository state always wins over remembered live state.

---

# 12. Engine 9 — Affect, Execution Context

Affect is not “therapy inside code review.” It models how human state changes engineering execution.

Relevant signals include:

- user frustration from repeated stalls;
- urgency from production outage;
- fear causing over-conservative architecture;
- sunk-cost attachment to a failing design;
- excitement causing scope explosion;
- reviewer conflict causing defensive reasoning;
- fatigue increasing mistake probability.

## Code-Specific Affect Rule

Translate affect into execution strategy.

Examples:

- repeated random stalls → reduce option menus, resume from last evidence frontier;
- production incident → prioritize containment and observability before elegance;
- scope excitement → preserve the product goal but separate core train from adjacent ideas;
- reviewer friction → evaluate findings mechanically, not socially.

Affect changes prioritization and communication. It does not change repository truth.

---

# 13. Repository Reconnaissance Protocol

At Depth ≥3, inspect enough of the system to avoid local-fix blindness.

## 13.1 Identity

Establish:

- repository;
- branch;
- base branch;
- head SHA;
- dirty/clean state;
- current PR/stack if applicable.

## 13.2 Topology

Map relevant:

- source roots;
- applications/services;
- libraries/packages;
- tests;
- generated code;
- scripts/tooling;
- CI/workflows;
- infrastructure/deployment;
- docs/specs.

## 13.3 Build Graph

Identify:

- build entry points;
- package managers;
- lockfiles;
- compilers/transpilers;
- generators;
- native steps;
- platform assumptions;
- environment variables;
- secrets/credentials required;
- artifact outputs.

## 13.4 Dependency Graph

For relevant components:

- who imports/calls whom;
- runtime vs dev dependency;
- direct vs transitive;
- version constraints;
- optional/platform-specific dependencies;
- circular dependencies;
- hidden coupling through shared state/config.

## 13.5 Test/CI Graph

Map:

- unit tests;
- integration tests;
- end-to-end tests;
- contract tests;
- snapshots/golden files;
- performance tests;
- security checks;
- platform matrices;
- required CI checks;
- local equivalents.

## 13.6 History

When causality or intent is unclear, inspect:

- recent commits to affected code;
- blame/history around suspicious lines;
- related issues/PRs;
- previous regressions;
- version/changelog transitions.

History is evidence only when relevant. Do not archaeology-dump the whole repo.

---

# 14. Engine 10 — Parallel Oracle for Code

Parallel Oracle is the branch generator. It should produce distinct reasoning branches, not synonyms.

## Core Branches

### WHO

- Which caller/user/service/agent owns the behavior?
- Who depends on this contract?
- Who can mutate the state?

### WHAT

- What is the actual defect/decision/capability?
- What observable behavior differs from expected?

### WHY

- Why was the current design created?
- What constraint did it originally solve?
- Why is the problem surfacing now?

### WHEN

- Startup, steady state, shutdown, retry, migration, deploy, race window?
- Was the behavior introduced at a specific commit/version?

### WHERE

- Client/server, API/domain/storage, compile/runtime, local/CI/prod, Windows/Linux/container?

### WHICH

- Which implementation options are genuinely distinct?
- Which hypothesis best explains the evidence?

### HOW

- What exact mechanism produces the observed behavior?
- What sequence of calls/state transitions is required?

### NEGATION

- What if the leading assumption is false?
- What evidence would make the favored fix wrong?
- What “obvious” layer is actually innocent?

### TEMPORAL

- What works now but fails at 10× scale, next version, next deploy, or after months of state accumulation?

### RELATIONAL / SYSTEMIC

- What feedback loops exist?
- What component optimizes locally while damaging the whole system?
- Where does backpressure or retry amplification occur?

### SUCCESS

- What does a fully correct outcome look like in real use?

### FAILURE

- What is the worst realistic failure?

### PARTIAL

- What happens when half the operation succeeds?

### ASSUMPTION

- Which unverified premise carries the most downstream weight?

### CONSTRAINT

- Which constraint is truly hard, and which can be inverted?

## Branch Metrics

Each serious branch tracks:

```text
Branch:
Evidence:
Assumptions:
Mechanism:
Actionable implication:
Risks:
Opportunities:
Confidence: X/5
Completeness: X/5
Contradictions: [IDs]
Falsifier: [observation that would weaken/kill branch]
```

At Depth 5, no leading branch is allowed to lack a falsifier.

---

# 15. Engine 2 — Mechanical Deconstruction for Software

The Mechanical engine builds the system model.

## 15.1 Static Topology

Map:

- modules/packages;
- public/private boundaries;
- dependency direction;
- ownership;
- configuration sources;
- persistence boundaries;
- external integrations.

## 15.2 Runtime Topology

Map:

`Input → validation → dispatch → computation → state mutation → side effects → persistence → output`

Include alternate paths:

- error;
- timeout;
- cancellation;
- retry;
- duplicate request;
- partial write;
- shutdown;
- recovery.

## 15.3 State Ownership

For every stateful concern ask:

- who creates it?
- who owns it?
- who mutates it?
- who observes it?
- how long does it live?
- when does it expire?
- how is consistency enforced?
- what happens after crash/restart?

Many “logic bugs” are actually ownership/lifecycle bugs.

## 15.4 Critical Path

Identify the path that determines correctness or latency.

Do not optimize non-critical code because it looks ugly.

## 15.5 Single Points of Failure

SPOF can be:

- service;
- process;
- lock;
- queue;
- singleton state;
- database;
- DNS/provider;
- build server;
- package registry;
- credential;
- one human-only release step.

## 15.6 Failure Propagation

For each serious failure:

```text
Trigger → local failure → propagation path → user-visible effect → recovery path
```

## 15.7 Leverage Points

Find the smallest change that affects the largest causal surface.

Leverage may be:

- moving ownership;
- batching work;
- changing a contract;
- adding idempotency;
- eliminating duplicate state;
- replacing polling with events;
- inserting observability at a key boundary;
- changing one shared abstraction rather than patching callers.

---

# 16. Hypothesis Lattice — Core Debugging Upgrade

HTE-Code v2.0 never treats the first plausible root cause as established.

## 16.1 Create Candidate Hypotheses

Example:

```text
SYMPTOM: request latency jumps from 80 ms to 4 s under load

H1: database query saturation
H2: thread-pool starvation
H3: lock contention
H4: downstream API retry amplification
H5: GC pause/allocation pressure
```

## 16.2 Give Each Hypothesis Predictions

```text
H1 predicts: DB wait rises, query latency rises, app CPU may remain moderate
H2 predicts: queued work rises, available workers falls, DB may look normal
H3 predicts: blocked threads cluster on shared synchronization point
H4 predicts: outbound request count > inbound request count under failure
H5 predicts: allocation/GC counters correlate with pauses
```

## 16.3 Run Discriminating Experiments

Prefer experiments that separate hypotheses.

A test that all five hypotheses predict is weak evidence.

## 16.4 Update Confidence

Confidence need not be formal Bayesian math, but it should behave Bayesianly:

- evidence predicted uniquely by H3 strongly raises H3;
- evidence inconsistent with H3 lowers it;
- absence of expected evidence matters when the measurement was capable of detecting it.

## 16.5 Root Cause Standard

“Root cause” requires:

1. explains the observed symptom;
2. explains when/where it occurs;
3. survives strongest competing hypothesis;
4. predicts a discriminating observation;
5. fix or controlled manipulation changes the outcome as predicted.

---

# 17. Engine 15 — Contradiction Resolution

Run after Oracle/Mechanical/Multisource and before Tribunal.

Classify each contradiction:

1. **DEFINITIONAL** — same word, different meaning;
2. **SCOPE** — both true under different scale/context/time;
3. **MISSING VARIABLE** — model omitted a reconciling factor;
4. **EVIDENCE QUALITY** — one claim rests on weaker evidence;
5. **GENUINE TRADEOFF** — both are true and cannot be simultaneously maximized.

Code-specific contradiction examples:

- “cache improves performance” vs “cache causes stale reads” → genuine tradeoff unless consistency strategy supplies missing variable;
- “this function is pure” vs “tests depend on global clock” → definitional or missing dependency;
- “microservice reduces coupling” vs “deployment becomes more coupled” → scope: code dependency vs operational dependency;
- “CI is green” vs “feature is broken” → evidence quality/scope: CI did not exercise product behavior.

Never force harmony.

A contradiction that reveals a missing variable is one of the highest-value outputs HTE-Code can produce.

---

# 18. Engine 3 — Code Tribunal

Tribunal weighs competing explanations or designs by evidence quality, not popularity.

## Judge

Defines:

- decision to make;
- constraints;
- success criteria;
- evidence standard;
- unacceptable failure modes.

## Jury

Each juror represents a distinct candidate:

- architecture option;
- root-cause hypothesis;
- implementation strategy;
- migration path;
- security posture;
- performance strategy.

Each must provide:

```text
CLAIM
MECHANISM
EVIDENCE
ASSUMPTIONS
RISKS
FALSIFIER
CONFIDENCE
```

## Executioner

Weights by:

1. directness of evidence;
2. reproducibility;
3. freshness/current-state relevance;
4. mechanism coherence;
5. number of unsupported assumptions;
6. fit to actual constraints;
7. falsification survival;
8. reversibility and failure cost where evidence is close.

## Verdict Types

- **CLEAR** — one option strongly dominates;
- **LEANING** — one is better but uncertainty remains;
- **CONDITIONAL** — winner changes under named condition;
- **TRADEOFF** — no universal winner;
- **INSUFFICIENT EVIDENCE** — run specified experiment before deciding.

“Insufficient evidence” is a valid engineering verdict.

---

# 19. Engineering Lens Packs

Lens Packs are dynamically activated. They are not new HTE engine numbers.

---

## Lens P — Performance and Scalability

### Questions

- Is time spent computing, waiting, spawning, allocating, blocking, parsing, serializing, transferring, or persisting?
- What is the critical path?
- What scales with N, N², network hops, files, rows, requests, shards, cores?
- What work is repeated unnecessarily?
- Where does batching eliminate fixed cost?
- What is the memory/GC/cache behavior?
- Does p99 tell a different story than average?

### Measurement Decomposition

```text
Wall time
  = CPU compute
  + scheduler wait
  + lock wait
  + I/O wait
  + network wait
  + child process wait
  + retry/backoff
  + queueing
  + GC/runtime pauses
```

**Wait ≠ work** remains a general law.

### Performance Proof

A performance claim requires a baseline and a comparable after-state.

Record:

- workload;
- environment;
- warm/cold state;
- sample count;
- median/p95/p99 as appropriate;
- CPU/memory/I/O counters;
- variance;
- exact code revision.

---

## Lens S — Security and Trust Boundaries

Map:

- assets;
- actors;
- trust boundaries;
- authentication;
- authorization;
- privilege transitions;
- secret flow;
- input boundaries;
- data classification;
- external calls;
- plugins/extensions;
- filesystem/process/network capabilities.

Look for:

- injection;
- traversal;
- unsafe deserialization;
- SSRF;
- authz bypass;
- confused deputy;
- privilege escalation;
- secret leakage;
- insecure temporary files;
- race/TOCTOU;
- dependency compromise;
- unsafe defaults;
- overbroad tokens/permissions.

Security analysis should produce defensive fixes, tests, and operational controls within the allowed scope.

---

## Lens C — Concurrency and Parallelism

Build a happens-before model.

Inspect:

- shared mutable state;
- locks;
- lock ordering;
- atomics;
- channels/queues;
- futures/promises/tasks;
- cancellation;
- thread affinity;
- async boundaries;
- reentrancy;
- double initialization;
- use-after-dispose;
- lost wakeups;
- starvation;
- thundering herd.

For each concurrent invariant:

```text
Invariant:
Writers:
Readers:
Synchronization:
Failure if violated:
Test/trace that proves it:
```

---

## Lens D — Distributed Systems

Inspect:

- partial failure;
- retry semantics;
- timeout ownership;
- idempotency;
- message ordering;
- duplicate delivery;
- clock assumptions;
- consistency model;
- leader/follower behavior;
- split brain;
- backpressure;
- queue poison messages;
- schema/version skew;
- network partitions;
- reconciliation.

Key rule:

> A remote call is not a function call with a longer cable.

---

## Lens DB — Data and Persistence

Map:

- schema;
- ownership;
- keys;
- constraints;
- transactions;
- indexes;
- query patterns;
- migration path;
- retention;
- consistency;
- caching;
- backups/recovery.

Ask:

- Is the database enforcing an invariant the application assumes?
- Can two writers violate it?
- What happens on partial migration?
- Is the query plan consistent with the access pattern?
- Is ORM behavior hiding N+1, tracking, or transaction costs?

---

## Lens API — Contracts and Compatibility

Every interface is a contract.

Inspect:

- inputs;
- outputs;
- error model;
- nullability/optionality;
- versioning;
- ordering;
- idempotency;
- pagination;
- retries;
- timeouts;
- backwards/forwards compatibility;
- serialization;
- locale/timezone;
- deprecation behavior.

Contract tests should prove externally visible promises independently from internal implementation.

---

## Lens B — Build, Toolchain, and Platform

Inspect:

- compiler/runtime versions;
- package manager behavior;
- lockfile semantics;
- generators;
- native tool dependencies;
- shell assumptions;
- filesystem semantics;
- case sensitivity;
- path length;
- symlinks;
- process spawning;
- line endings;
- locale/encoding;
- architecture (x86/x64/ARM);
- container/host differences.

A script is not sacred. Its **observable contract** is.

A compatible replacement is valid when it preserves required semantics and passes differential tests.

---

## Lens DEP — Dependency and Supply Chain

For each important dependency:

- purpose;
- direct/transitive;
- version constraint;
- maintenance state;
- security advisories;
- license;
- platform support;
- API stability;
- replacement cost;
- startup/runtime cost;
- lockfile integrity;
- vendoring/generated code implications.

Do not upgrade merely because a version is newer. Define the reason and compatibility evidence.

---

## Lens O — Observability

Ask whether the system can explain itself when it fails.

Inspect:

- structured logs;
- correlation IDs;
- traces;
- metrics;
- health checks;
- domain events;
- error context;
- sensitive-data redaction;
- sampling;
- alert quality.

Observability should answer causal questions, not merely produce more text.

---

## Lens M — Maintainability and Refactorability

Inspect:

- responsibility boundaries;
- cohesion/coupling;
- duplicated truth;
- oversized modules/functions;
- hidden global state;
- feature envy;
- shotgun surgery;
- abstraction leakage;
- configuration spread;
- names that hide lifecycle;
- dead code;
- generated vs hand-maintained ambiguity;
- agent navigability.

Do not equate “more abstraction” with “more maintainable.”

Abstractions must pay rent by eliminating repeated concrete complexity.

---

## Lens T — Testability and Verification

Inspect seams for:

- time;
- randomness;
- filesystem;
- network;
- database;
- process execution;
- environment;
- external APIs;
- concurrency.

Prefer deterministic tests where possible.

A difficult-to-test design may be revealing hidden coupling.

---

## Lens DX — Developer / Agent Experience

Inspect:

- setup friction;
- build discoverability;
- error messages;
- project navigation;
- conventions;
- docs accuracy;
- fixture/data availability;
- local CI parity;
- reproducible commands;
- agent handoff clarity.

A repo that humans and agents cannot reliably navigate has an operational defect even if runtime code is sound.

---

## Lens OPS — Operations and Release

Inspect:

- deploy topology;
- config/secrets;
- feature flags;
- database migrations;
- rollout strategy;
- rollback;
- health gates;
- versioning;
- artifact signing/integrity;
- monitoring;
- incident recovery;
- exact-head qualification.

---

# 20. Engine 4 — Edge Cases as Campaigns

Do not output a generic list of “null, empty, max size.”

Generate edge cases from the actual system model.

## Campaign Types

### Boundary Campaign

- empty;
- one item;
- maximum allowed;
- just-over-maximum;
- malformed;
- Unicode/encoding;
- extreme numeric/time values.

### Lifecycle Campaign

- startup;
- warm restart;
- shutdown during work;
- crash and recovery;
- stale cache/session;
- expired credential;
- upgrade with old state.

### Concurrency Campaign

- duplicate request;
- simultaneous create/update/delete;
- cancellation during commit;
- retry after unknown result;
- lock inversion;
- delayed message.

### Dependency Campaign

- dependency unavailable;
- slow dependency;
- malformed dependency response;
- version mismatch;
- partial response;
- rate limit.

### Resource Campaign

- disk full;
- memory pressure;
- file descriptor/socket exhaustion;
- queue saturation;
- database pool exhaustion;
- process limit.

### Adversarial Campaign

- malicious input;
- unauthorized actor;
- path manipulation;
- forged/replayed request;
- compromised dependency;
- unexpected plugin.

## Edge-Case Record

```text
EDGE E4
Trigger:
Assumption violated:
Expected behavior:
Current behavior:
Severity:
Detect early:
Prevent:
Recover:
Test:
```

---

# 21. Engine 5 — Multisource and Cross-Domain Transfer

Code problems often have known analogues elsewhere.

Useful transfers include:

- operating systems → scheduling/backpressure;
- databases → transactional invariants;
- networking → retries/congestion;
- compilers → intermediate representations;
- game engines → hot loops/data locality;
- HFT → batching/latency discipline;
- embedded systems → bounded resource reasoning;
- biology → redundancy/adaptation;
- control theory → feedback stability;
- manufacturing → quality gates;
- aviation → checklists + incident causality;
- formal methods → invariants/property testing.

Cross-domain output must identify the transferable **mechanism**, not merely produce an analogy.

---

# 22. Inversion / Constraint-Reversal Protocol

Use when a problem appears blocked by a constraint.

Steps:

1. list explicit constraints;
2. classify hard vs soft;
3. invert one soft constraint at a time;
4. ask what mechanism would make the inverted world viable;
5. search adjacent domains for precedents;
6. identify new failure modes created by inversion;
7. build a cheap falsification experiment.

Example:

> Constraint: “We cannot edit the upstream script.”

Possible inversion:

> Preserve the script but change the implementation behind a compatible tool boundary.

This is valid only if argv semantics, outputs, side effects, and failure behavior required by the script remain compatible.

The inversion engine does not make a strange idea correct. It makes it testable.

---

# 23. Engine 11 — InvisiSynth for Software

InvisiSynth activates when the obvious documentation/search path may miss useful implementation evidence.

For software, its strongest domains are:

## 23.1 Upstream Source Archaeology

Look beyond API docs into:

- runtime/framework source;
- commit history;
- tests;
- internal comments;
- issue-linked patches.

## 23.2 Abandoned/Forked Implementations

Search:

- forks;
- old branches;
- archived repos;
- prototypes;
- abandoned packages;
- downstream patches.

An abandoned implementation may still reveal mechanism or failure history.

## 23.3 Issue/PR Archaeology

Search exact symptoms, errors, stack traces, and symbols.

Prefer issues with:

- reproduction;
- maintainer explanation;
- linked fix commit;
- regression test.

## 23.4 Research / Benchmark Literature

For algorithms, compilers, databases, distributed systems, performance, security, or ML:

- papers;
- conference proceedings;
- benchmark suites;
- technical reports;
- dissertations.

## 23.5 Production Precedents

Look for mature systems that solved the same mechanism under similar constraints.

## 23.6 Security Archaeology

For defensive work:

- CVEs;
- advisories;
- patches;
- exploit writeups at a safe analytical level;
- mitigation history.

## 23.7 Hobbyist / Maker / Niche Tooling

Useful ideas may live in:

- tiny utilities;
- specialized forums;
- build scripts;
- game modding communities;
- embedded/hardware projects;
- language-specific niches.

### InvisiSynth Evidence Rule

“Invisible,” “suppressed,” “abandoned,” or “not mainstream” is never itself proof of quality.

Every retrieved precedent must re-enter the Evidence Ledger and Tribunal.

---

# 24. Debugging Protocol

## Phase 1 — Pin the Symptom

Capture:

- exact error/wrong behavior;
- expected behavior;
- minimal reproduction if possible;
- frequency;
- environment;
- first known bad version/state;
- last known good version/state.

## Phase 2 — Establish Reproduction Quality

Classify:

- deterministic;
- load-dependent;
- race/timing-dependent;
- environment-dependent;
- data-dependent;
- intermittent/unknown.

## Phase 3 — Build Hypothesis Lattice

Generate independent causes from different system layers.

Avoid five variants of the same guess.

## Phase 4 — Instrument Before Guessing Deeper

Add the smallest observation that discriminates hypotheses:

- log at ownership boundary;
- counter;
- trace span;
- debugger watch;
- query plan;
- profiler;
- process monitor;
- network capture;
- deterministic test seam.

## Phase 5 — Root Cause

Require causal chain, not correlation.

## Phase 6 — Fix at Correct Layer

Prefer the layer where the invalid assumption originates.

Do not patch every caller around a broken shared contract.

## Phase 7 — Regression Lock

Add a test that fails for the old defect and passes for the correct mechanism.

## Phase 8 — Remove Diagnostic Debris

Remove or normalize temporary logs, debug flags, fixtures, sleeps, and bypasses unless intentionally retained as observability.

---

# 25. Architecture Decision Protocol

## 25.1 Define Decision

Example:

> “Choose an event delivery model that preserves at-least-once processing, supports offline consumers, and stays operable by a small team.”

Not:

> “Kafka vs RabbitMQ?”

The technology names are options, not the decision.

## 25.2 Constraints

List:

- load;
- latency;
- consistency;
- durability;
- team skill;
- deploy environment;
- budget;
- operations tolerance;
- compatibility;
- time horizon.

## 25.3 Candidate Models

Include at least one structurally different alternative.

## 25.4 Tribunal

Compare using actual constraints.

## 25.5 Future-State Simulation

Evaluate:

- 10× load;
- 10× data;
- second service/team;
- major version upgrade;
- partial outage;
- migration away.

## 25.6 Decision Record

```text
DECISION:
Context:
Options considered:
Chosen:
Why:
Rejected because:
Assumptions:
Risks:
Revisit trigger:
Migration/rollback:
Confidence:
```

---

# 26. Refactoring Protocol

## 26.1 Behavior Preservation Contract

Before refactoring:

```text
PRESERVE
- public API X
- parser behavior Y
- persisted format Z
- ordering semantics Q

MAY CHANGE
- internal module structure
- private names
- implementation algorithm

INTENTIONALLY CHANGE
- documented defect A
```

## 26.2 Characterization

Where behavior lacks tests, create characterization tests around important existing behavior before moving structure.

## 26.3 Dependency Slice

Map all callers/callees/state touched by the refactor.

## 26.4 Transform in Coherent Steps

Prefer steps where each step builds/tests.

## 26.5 Delete Old Path

A refactor that leaves duplicate old/new truth creates more debt.

## 26.6 Verify Semantic Diff

Ask:

- what behavior changed unintentionally?
- what error paths moved?
- what lifecycle changed?
- what ordering changed?
- what concurrency assumption changed?

---

# 27. Performance Protocol

## 27.1 Define the Performance Question

Bad:

> “Make it faster.”

Good:

> “Reduce p95 cold-start latency on Windows from 6.2 s to <2 s without increasing steady-state memory above 300 MB.”

## 27.2 Measure Before Optimizing

Collect baseline.

## 27.3 Decompose Cost

Separate:

- CPU;
- I/O;
- network;
- lock/scheduler wait;
- process spawn;
- allocation/GC;
- serialization;
- database;
- algorithmic repetition.

## 27.4 Rank Optimizations by Leverage

Typical order:

1. eliminate unnecessary work;
2. reduce asymptotic cost;
3. batch fixed overhead;
4. remove redundant I/O/network hops;
5. fix contention;
6. improve data locality/allocation;
7. micro-optimize hot code last.

## 27.5 Verify Equivalence

A faster wrong result is a regression.

---

# 28. Security Protocol

## 28.1 Threat Model

```text
ASSET
ACTOR
ENTRY POINT
TRUST BOUNDARY
CAPABILITY
ABUSE CASE
CONTROL
TEST
RESIDUAL RISK
```

## 28.2 Authorization Before Validation

Do not treat syntactically valid input as authorized behavior.

## 28.3 Least Capability

Reduce:

- token scope;
- filesystem access;
- process execution;
- network reach;
- DB permissions;
- plugin privileges.

## 28.4 Secure Failure

Errors should not leak secrets or silently downgrade security.

## 28.5 Regression Tests

Security fixes need tests for the forbidden path as well as allowed behavior.

---

# 29. Build / Platform Failure Protocol

For host/tooling stalls:

1. identify failing command and exact argv;
2. measure wall vs CPU/I/O/process activity;
3. identify shell/runtime translation layers;
4. inspect filesystem/platform semantics;
5. isolate whether failure is semantic or merely performance;
6. build a tiny differential smoke test for any replacement/shim;
7. preserve the upstream script contract where required;
8. rerun the real build;
9. verify output tree/artifact semantics, not only exit code.

General law retained from the v1.1 IceCat case:

> **If wall-clock time is enormous while CPU work is tiny, stop treating the problem as computational complexity until wait/spawn/I/O layers have been measured.**

---

# 30. Testing Strategy — Evidence, Not Ceremony

Testing is not one lens named “unit tests.” It is a proof strategy.

## Test Types

### Unit

Pure/local behavior and invariants.

### Characterization

Lock down important legacy behavior before refactor.

### Integration

Real component interaction.

### Contract

Public boundaries independent of implementation.

### End-to-End / Product Journey

Prove user-visible intent through realistic interaction.

### Property-Based

Generate broad input spaces around invariants.

### Fuzz

Malformed/adversarial parser or protocol input.

### Concurrency

Stress race windows, duplicate operations, cancellation.

### Performance

Baseline/regression thresholds with comparable environment.

### Security

Abuse cases and permission boundaries.

### Migration

Old data/schema/version → new version.

### Recovery

Crash/restart/rollback/partial failure.

### Mutation

Where valuable, verify tests detect semantic changes rather than merely execute lines.

## Test Selection Rule

Choose tests from the **failure model**.

A test suite is strong when it would fail for the mechanisms you are afraid of.

---

# 31. Qualification Ladder

Use the weakest ladder sufficient for the stakes, but make the level explicit.

## Q0 — Static Plausibility

- code inspected;
- no execution evidence.

## Q1 — Local Compile/Lint

- syntax/type/build surface valid.

## Q2 — Targeted Tests

- changed behavior covered.

## Q3 — Relevant Regression Suite

- affected subsystem regression checked.

## Q4 — Product/Integration Qualification

- real user/system path works.

## Q5 — Release / Exact-Head Qualification

- current exact head identified;
- required CI/checks green or locally equivalent evidence available;
- artifacts validated;
- unresolved actionable review findings addressed;
- migration/rollback/release concerns satisfied;
- final diff inspected.

Do not claim Q5 from Q2 evidence.

---

# 32. Exact-Head and PR Protocol

When PR/release work is in scope:

1. query live PR state;
2. record base/head SHA;
3. inspect changed files and current diff;
4. inspect unresolved actionable review threads;
5. run/fetch qualification for the exact head;
6. fix findings;
7. if head changes, update the qualification ledger;
8. recheck review/CI state;
9. only merge when authorized and genuinely qualified;
10. verify resulting base branch frontier after merge.

## Qualification Ledger Example

```text
HEAD: abc123
BUILD: PASS — command ...
TESTS: PASS — 412 tests
E2E: PASS — journey ...
REVIEW THREADS: 0 actionable unresolved
CI: green on abc123
ARTIFACT: sha256 ...
CLAIM: Q5 qualified
```

If the head becomes `def456`, that ledger no longer automatically proves `def456`.

---

# 33. Implementation Feedback Loop

HTE-Code must be closed-loop.

```text
1. PLAN
2. PATCH
3. FORMAT / STATIC CHECK
4. BUILD
5. TARGETED TEST
6. RELEVANT REGRESSION
7. INSPECT DIFF
8. RE-RUN FAILURE REPRO / PRODUCT JOURNEY
9. REVIEW FINDINGS
10. FIX
11. QUALIFY EXACT STATE
12. SYNTHESIZE RECEIPTS
```

If a step fails, route the failure back into the Hypothesis Lattice rather than blindly applying more patches.

---

# 34. Change Impact / Blast Radius

Before a non-trivial change, map:

- direct callers;
- indirect consumers;
- shared state;
- persisted data;
- public APIs;
- generated outputs;
- tests/fixtures;
- docs/examples;
- build scripts;
- platform-specific paths;
- monitoring/operations;
- migrations.

Classify impact:

- LOCAL
- MODULE
- CROSS-MODULE
- PUBLIC CONTRACT
- DATA/SCHEMA
- OPERATIONAL
- PLATFORM
- RELEASE-WIDE

Higher blast radius increases required qualification depth.

---

# 35. Observability-Driven Diagnosis

When the system cannot answer a causal question, treat missing observability as a design gap.

Add observability at **decision boundaries**, not everywhere.

Useful boundaries:

- queue enqueue/dequeue;
- cache hit/miss/stale;
- external call start/end;
- transaction begin/commit/rollback;
- state transition;
- retry decision;
- lock acquisition wait;
- authentication/authorization decision;
- job lifecycle.

Avoid log spam that destroys signal.

---

# 36. Engine 6 — Synthesis

Synthesis collapses the analysis into a decision and action.

It must not simply concatenate engine output.

## Required Steps

1. extract strongest findings;
2. resolve or expose contradictions;
3. weight by evidence quality;
4. distinguish known vs inferred;
5. choose action under constraints;
6. integrate edge-case mitigations;
7. define success and falsification;
8. include exact qualification evidence when implementation occurred.

## Synthesis Shape

```text
THE ANSWER
  Direct conclusion / implemented result

WHY
  strongest mechanisms + evidence

WHAT CHANGED / WHAT TO DO
  ordered implementation

RISKS
  critical remaining risks only

UNCERTAINTY
  what is not yet known and what would resolve it

QUALIFICATION
  build/tests/runtime/review/exact-head receipts

CONFIDENCE
  overall X/5 + component confidence
```

Do not expose every internal branch unless the user asked for the full HTE analysis. The engine may think broadly and answer cleanly.

---

# 37. Engine 8 — Learning and Calibration

Learning is not “remember the fix.” It is “update how future reasoning should behave.”

After outcomes are known, record:

```text
Prediction:
Confidence:
Actual outcome:
Correct/incorrect/partial:
Why prediction succeeded/failed:
Which evidence was overweighted:
Which assumption was wrong:
Which lens found the decisive clue:
New reusable pattern:
```

## Calibration

Track whether 5/5 claims actually behave like near-certainties and whether 3/5 claims frequently fail.

If confidence is consistently too high, adjust.

## Failure Motifs

Examples:

- stale live-state memory;
- patched symptom instead of ownership bug;
- tests green but product intent untested;
- environment mismatch;
- hidden generated code;
- retry amplification;
- duplicated source of truth;
- version-skew assumption;
- overfit abstraction.

Learning should make these motifs easier to detect next time.

---

# 38. Confidence Model

Use X/5 for user-facing HTE-Code confidence.

## 5/5 — Strongly Established

- direct current evidence;
- mechanism confirmed;
- competing explanations falsified or negligible;
- implementation/qualification matches claim.

## 4/5 — High

- strong evidence and coherent mechanism;
- minor untested edge or environmental uncertainty.

## 3/5 — Moderate

- plausible and supported;
- meaningful assumptions or alternatives remain.

## 2/5 — Low

- incomplete evidence;
- substantial inference;
- competing hypotheses unresolved.

## 1/5 — Speculative

- weak evidence;
- idea mainly useful as experiment/search direction.

## Confidence Composition

Do not average blindly.

A release claim can be no stronger than its weakest critical dependency.

Example:

```text
Implementation correctness: 5/5
Migration safety:           2/5
Rollback evidence:          2/5
Overall release confidence: cannot exceed 2/5 until migration/rollback are resolved
```

---

# 39. Uncertainty Budget

At Depth ≥4, name uncertainty explicitly.

Categories:

- missing repository access;
- missing reproduction;
- environment mismatch;
- version uncertainty;
- non-determinism;
- external dependency behavior;
- incomplete test coverage;
- unknown production data shape;
- hardware/platform variation;
- human/process dependency.

Rank:

- **BLOCKING** — cannot responsibly conclude;
- **MATERIAL** — can proceed, affects confidence;
- **MINOR** — monitor;
- **IRRELEVANT TO DECISION** — do not spend cycles.

This prevents endless analysis of uncertainties that cannot change the decision.

---

# 40. Multi-Agent / Agentic Engineering Protocol

When multiple agents/reviewers are involved, parallelism must not become state corruption.

## Work Partitioning

Partition by coherent ownership:

- separate modules;
- separate review tasks;
- separate research questions;
- separate test/qualification lanes.

Avoid assigning two agents to independently rewrite the same stateful core unless intentionally comparing alternatives.

## Agent Handoff Contract

```text
REPO:
BASE:
BRANCH:
EXACT HEAD:
PRIMARY OBJECTIVE:
DO NOT DRIFT INTO:
KNOWN FAILURES:
CHANGED FILES:
TEST/CI STATE:
UNRESOLVED REVIEW FINDINGS:
DECISIONS ALREADY MADE:
EVIDENCE / RECEIPTS:
NEXT DISCRIMINATING ACTION:
MERGE AUTHORIZATION STATE:
```

## Integration Rule

Before integrating parallel agent work:

- re-query live state;
- verify ancestry;
- inspect overlapping files;
- rerun affected qualification;
- resolve contradictory assumptions.

---

# 41. Review Protocol

A review is not complete when comments are generated.

For each finding:

```text
FINDING
Severity:
Evidence:
Mechanism:
Valid / Invalid / Needs experiment:
Fix:
Regression test:
Reply/resolution state:
```

Fix every valid actionable issue within scope.

Do not blindly satisfy reviewer suggestions that conflict with code truth. Tribunal applies to review comments too.

---

# 42. Product-Intent Verification

A technically green change can still fail the request.

At qualification, translate the user’s request into product assertions.

Example:

User intent:

> “A user should be able to resume an interrupted upload.”

Weak proof:

- new resume function has unit tests.

Strong proof:

1. start upload;
2. interrupt process/network;
3. restart;
4. system discovers resumable state;
5. upload continues without duplicate/corrupt data;
6. final artifact hash matches;
7. stale resume state is cleaned up.

HTE-Code v2.0 treats **intent → observable journey** as a first-class correctness boundary.

---

# 43. Anti-Patterns HTE-Code Must Detect

## Analysis Theater

Many headings, no discriminating evidence.

## Checklist Substitution

Naming security/performance/testing without tying them to the actual system.

## Premature Root Cause

First plausible explanation becomes fact.

## Fix-by-Accretion

Keep adding conditionals around a broken invariant.

## Test Theater

Tests execute code but do not prove intended behavior.

## Green-CI Fallacy

“CI green” interpreted as “product correct.”

## Stale-Head Fallacy

Old test run applied to new commit.

## Abstraction Fever

Creating generic frameworks before repeated concrete needs exist.

## Architecture by Fashion

Selecting microservices, event sourcing, CQRS, Rust, Kubernetes, etc. because the label sounds advanced.

## Authority Closure

“Official docs say so” ends mechanism inquiry.

## Anti-Authority Closure

“Official docs say so, therefore opposite is true.” Same failure, mirrored.

## Local-Fix Blindness

Fixing a call site when ownership/contracts are wrong upstream.

## Infinite Audit

Building more evaluators instead of changing or qualifying the product.

---

# 44. Dynamic Output Modes

HTE-Code should think at requested depth but tailor visible output.

## Compact

For normal use:

- diagnosis/decision;
- key evidence;
- action;
- verification;
- confidence.

## Engineering

For implementation:

- problem frame;
- files/components;
- implementation plan;
- tests;
- risks;
- qualification.

## Forensic

For Depth 5 or explicit full HTE:

- clarified question;
- assumption/evidence registers;
- Oracle branches;
- mechanical model;
- lens findings;
- hypothesis lattice;
- contradictions;
- Tribunal;
- implementation;
- qualification;
- learning targets.

## Handoff

For long chats/agent transfer:

- exact live frontier;
- decisions;
- evidence;
- remaining blocker;
- next discriminating action;
- no history rebuild unless live state requires it.

---

# 45. Canonical Execution Sequence

```text
0.  TASK CLASSIFICATION
1.  FILTERSTACK (-1), if triggered
2.  CLARIFICATION (14)
3.  HARM EVAL (0)
4.  MEMORY RETRIEVAL (7) + AFFECT CONTEXT (9)
5.  TRUTH ACQUISITION / REPO RECON
6.  PARALLEL ORACLE (10)
7.  MECHANICAL DECONSTRUCTION (2)
8.  ACTIVE ENGINEERING LENS PACKS
9.  EDGE CASES (4) + MULTISOURCE (5)
10. INVISISYNTH / INVERSION (11), if useful
11. HYPOTHESIS EXPERIMENTS / OPTION EVIDENCE
12. CONTRADICTION RESOLUTION (15)
13. TRIBUNAL (3)
14. SYNTHESIS (6)
15. IMPLEMENT, if requested and possible
16. TEST / INSPECT / FIX LOOP
17. QUALIFICATION CLOSURE
18. LEARNING TARGETS (8)
```

Some stages run in parallel, but the evidence dependencies remain.

---

# 46. Depth-5 Required Artifacts

A true Depth-5 run should produce or internally maintain, as relevant:

- System Evidence Baseline;
- Assumption Register;
- Constraint Register;
- Evidence Ledger;
- Repo/Dependency Map;
- Runtime/State Model;
- Hypothesis or Option Lattice;
- Contradiction Map;
- Risk Register;
- Change/Implementation Plan;
- Test Matrix;
- Qualification Ledger;
- Learning Record.

Not every artifact must be printed verbatim. They must shape the reasoning.

---

# 47. Generic Depth-5 Output Contract

```text
[HTE-CODE ANALYSIS] DEPTH 5/5

TASK CLASS:
PRIMARY DECISION / OBJECTIVE:

CLARIFIED QUESTION:
ASSUMPTIONS:
CONSTRAINTS:

SYSTEM TRUTH:
  Repo / branch / head:
  Relevant topology:
  Build/runtime/test facts:

EVIDENCE LEDGER — decisive entries:

PARALLEL ORACLE — leading branches:

MECHANICAL MODEL:
  Components:
  State ownership:
  Runtime path:
  Failure propagation:
  Leverage points:

ACTIVE LENS PACKS:
  [only relevant packs]

HYPOTHESIS / OPTION LATTICE:

EDGE CASES:

CONTRADICTIONS:

TRIBUNAL:
  Decision standard:
  Competing candidates:
  Evidence weights:
  Falsifiers:
  Verdict:

IMPLEMENTATION / FIX:

QUALIFICATION:
  Build:
  Tests:
  Product journey:
  Security/perf/migration as relevant:
  Exact-state receipts:

REMAINING RISKS:

CONFIDENCE:
  Overall X/5
  Critical components X/5

LEARNING TARGET:
  What outcome would recalibrate future runs?
```

---

# 48. Specialized Output Contracts

## Bug Fix

```text
FIX LOG
  Symptom:
  Reproduction:
  Root cause:
  Competing hypothesis rejected:
  Files changed:
  Fix mechanism:
  Regression test:
  Verification:
```

## Refactor

```text
BEHAVIOR PRESERVATION
  Preserved:
  Intentionally changed:
  Removed:
  Characterization evidence:
  New structure:
  Regression proof:
```

## Architecture

```text
ARCHITECTURE DECISION
  Decision:
  Constraints:
  Options:
  Tribunal result:
  Chosen model:
  Tradeoffs:
  Migration:
  Rollback:
  Revisit trigger:
```

## Performance

```text
PERFORMANCE RESULT
  Workload:
  Baseline:
  Bottleneck mechanism:
  Change:
  After:
  Variance:
  Correctness proof:
```

## Release / PR

```text
FINAL
  Exact head:
  Build status:
  Tests:
  CI:
  Review threads:
  Product qualification:
  Remaining risks:
  Merge/release state:
```

---

# 49. Example Invocations

```text
HTE-Code depth 5: Find the root cause of this intermittent duplicate-write bug. Do not stop at the first plausible race.
```

```text
HTE-Code: Compare Postgres advisory locks, Redis leases, and DB row ownership for this worker system under crash/restart.
```

```text
HTE-Code depth 4: Refactor this parser without changing accepted syntax or error positions. Build a behavior-preservation contract first.
```

```text
HTE-Code + FilterStack: Everyone says this architecture is "not idiomatic." Strip the label and evaluate the actual runtime and maintenance mechanisms.
```

```text
HTE-Code depth 5: This build takes 70 minutes but uses almost no CPU. Separate compute, process spawn, filesystem, antivirus, and network wait, then falsify the leading cause.
```

```text
HTE-Code depth 5: Qualify PR #123 on its exact head, fix all valid actionable review findings, rerun the required evidence, and report the exact merge frontier.
```

---

# 50. HTE-Code v1.1 → v2.0 Depth-5 Self-Analysis

This section records the Depth-5 HTE run performed on HTE-Code itself.

## 50.1 Clarified Question

**Original intent:** Extend HTE-Code far beyond its current basic capabilities by running the parent HTE at Depth 5 on HTE-Code itself.

**Clarified engineering question:**

> What architectural capabilities from the full HTE are missing, collapsed, mis-mapped, overfit, or non-operational in HTE-Code v1.1, and what general software-engineering protocol would turn it from a checklist into a closed-loop reasoning, implementation, and qualification engine?

**Reframe confidence:** 5/5

## 50.2 Oracle Findings

### Architecture Perspective — 5/5

v1.1 has a semantic identity collision: original HTE Engine 7/8/9/10 roles are repurposed. This weakens lineage and removes first-class Memory/Learning/Affect behavior.

**v2 fix:** preserve canonical HTE numbering; make software capabilities lens packs.

### Debugging Perspective — 5/5

v1.1 lists failure modes but lacks a disciplined hypothesis/experiment loop. It can generate plausible explanations without requiring discriminating evidence.

**v2 fix:** Hypothesis Lattice + falsifiers + root-cause standard.

### Repository Perspective — 5/5

v1.1 can reason about code but has no explicit repo truth-acquisition protocol.

**v2 fix:** reconnaissance of branch/head/tree/build/dependencies/tests/history before exact claims.

### Evidence Perspective — 5/5

Confidence scores exist, but there is no provenance model explaining what earns confidence.

**v2 fix:** Evidence Ledger E0–E5, freshness/scope/provenance, confidence composition.

### Execution Perspective — 4/5

v1.1 says “execute, do not ask,” but the execution loop is underspecified.

**v2 fix:** plan → patch → build → test → inspect → product journey → review → qualification.

### Generalization Perspective — 5/5

The core v1.1 text is overfit to an IceCat/Windows incident. Specific details such as GNU `find`, 7-Zip, Mozilla keys, and Savannah transport are useful Memory/example data, not universal engine definitions.

**v2 fix:** extract general laws and move incident-specific knowledge out of core architecture.

### Testing Perspective — 5/5

v1.1 testing examples are smoke-test oriented and do not provide a full verification model.

**v2 fix:** characterization, contract, E2E/product journey, property, fuzz, concurrency, performance, security, migration, recovery, exact-head qualification.

### Architecture/Change Perspective — 5/5

v1.1 lacks behavior-preservation contracts, blast-radius mapping, architecture decision records, migration/rollback, and state ownership analysis.

**v2 fix:** dedicated protocols.

### Learning Perspective — 5/5

v1.1 mentions Memory but not meaningful calibration from predicted vs actual outcomes.

**v2 fix:** restore Engine 8 Learning with prediction calibration and failure motifs.

### Contradiction Perspective — 4/5

v1.1 correctly adds Contradiction Resolution, but does not make contradiction mapping a core shared state or systematically route unresolved conflicts into experiments.

**v2 fix:** contradiction map + missing-variable discovery + experiment/Tribunal routing.

## 50.3 Mechanical Deconstruction of v1.1

### Existing strengths

- mechanism-first attitude;
- confidence requirements;
- FilterStack integration;
- Tribunal/falsification concept;
- Clarification and Contradiction engines;
- explicit anti-stall behavior;
- implementation orientation;
- awareness of host/platform performance differences.

### Missing structural organs

1. canonical engine topology;
2. repo evidence acquisition;
3. shared evidence/assumption state;
4. hypothesis lifecycle;
5. runtime/state ownership model;
6. change impact model;
7. operational depth semantics;
8. broad verification ladder;
9. exact-state qualification;
10. learning/calibration loop;
11. agent integration/handoff protocol;
12. dynamic output control.

### Highest leverage point

The single highest-leverage change is not “add more checklists.” It is:

> **Make every branch operate over shared evidence, assumptions, and hypotheses, then require implementation and qualification to feed new evidence back into the same model.**

That converts HTE-Code from a one-pass advisor into a closed-loop engineering system.

## 50.4 Tribunal

### Judge

Decision standard: the successor must preserve useful v1.1 behavior while restoring parent HTE architecture and adding capabilities that materially improve real engineering correctness.

### Candidate A — Keep v1.1 and add more headings

**Evidence:** cheap, backward compatible.  
**Failure:** increases checklist size without correcting topology or closed-loop reasoning.  
**Confidence as sufficient solution:** 1/5.

### Candidate B — Replace HTE-Code with a language-specific mega-checklist

**Evidence:** HTE-DOTNET Ultra demonstrates that deep specialization can be very powerful.  
**Failure:** general HTE-Code must work across languages and would become bloated/fragile if every ecosystem detail lived in the core.  
**Confidence as general solution:** 2/5.

### Candidate C — Restore HTE topology + dynamic engineering lens packs + evidence/implementation loop

**Evidence:** matches the parent HTE’s modular architecture, preserves specialization, allows Depth 5 to change behavior, and directly addresses the identified missing mechanisms.  
**Failure risk:** requires disciplined lens activation so output does not become enormous by default.  
**Confidence:** 5/5.

### Verdict

**Candidate C wins clearly.**

HTE-Code should be a stable reasoning kernel with dynamic software lens packs, evidence structures, and task-specific protocols.

## 50.5 Contradictions Resolved

### C1 — “HTE-Code should be comprehensive” vs “Do not dump ceremony into every task”

**Type:** SCOPE.  
**Resolution:** internal depth can be broad while visible output is dynamically compact.  
**Confidence:** 5/5.

### C2 — “Preserve parent HTE” vs “Add deep code specialization”

**Type:** DEFINITIONAL/ARCHITECTURAL.  
**Resolution:** preserve engine identities; specialization lives in lens packs/protocols.  
**Confidence:** 5/5.

### C3 — “Execute after synthesis” vs “Analysis must remain falsifiable”

**Type:** MISSING VARIABLE.  
**Missing variable:** feedback from execution.  
**Resolution:** execution is an experiment that updates hypotheses and can invalidate the plan.  
**Confidence:** 5/5.

### C4 — “Confidence score mandatory” vs “Confidence can be arbitrary”

**Type:** EVIDENCE QUALITY.  
**Resolution:** bind confidence to evidence directness, reproduction, freshness, assumptions, and falsification survival.  
**Confidence:** 5/5.

## 50.6 Edge-Case Findings

The v2 architecture specifically guards against:

- no repo access;
- stale handoffs;
- green CI with wrong product behavior;
- exact-head drift;
- nondeterministic failures;
- generated code being mistaken for source of truth;
- platform-specific build semantics;
- reviewers being wrong;
- user request already authorizing implementation;
- migration risk hiding behind passing unit tests;
- architecture fashion overriding constraints;
- too much analysis for trivial tasks;
- Depth 5 becoming infinite recursion.

## 50.7 Final Self-Assessment

| Capability | v1.1 | v2.0 | Confidence |
|---|---:|---:|---:|
| Parent HTE topology | 2/5 | 5/5 | 5/5 |
| Debugging rigor | 2/5 | 5/5 | 5/5 |
| Evidence provenance | 1/5 | 5/5 | 5/5 |
| Repo awareness | 2/5 | 5/5 | 5/5 |
| Architecture analysis | 3/5 | 5/5 | 4/5 |
| Refactor safety | 2/5 | 5/5 | 5/5 |
| Performance depth | 3/5 | 5/5 | 5/5 |
| Security model | 2/5 | 4/5 | 4/5 |
| Concurrency/distributed | 1/5 | 5/5 | 5/5 |
| Testing/qualification | 2/5 | 5/5 | 5/5 |
| Exact-state PR/release proof | 1/5 | 5/5 | 5/5 |
| Execution feedback loop | 2/5 | 5/5 | 5/5 |
| Memory/learning/calibration | 2/5 | 5/5 | 5/5 |
| Multi-agent handoff | 1/5 | 5/5 | 4/5 |
| Anti-overanalysis controls | 3/5 | 5/5 | 5/5 |

**Overall HTE assessment of v2.0 design:** 5/5 confidence that this is a materially deeper and more faithful general HTE-Code architecture than v1.1.

The remaining uncertainty is implementation-dependent: different coding agents and models will vary in how faithfully they maintain the shared evidence state and resist premature closure. The specification therefore emphasizes observable artifacts, falsifiers, and qualification rather than trusting the reasoning process by declaration.

---

# 51. Source Lineage

This edition was derived from and cross-checked against the supplied HTE materials, especially:

- `HTE-Code-v1.0.md` / current v1.1 seed;
- `HTE-Newest(1).zip` parent HTE archive;
- Engine 1 Parallel Oracle;
- Engine 2 Mechanical Deconstruction;
- Engine 3 Tribunal;
- Engine 4 Edge Case;
- Engine 5 Multisource;
- Engine 6 Synthesis;
- Engine 7 Memory;
- Engine 8 Learning;
- Engine 9 Affect;
- Engine 10 Parallel Oracle expansion;
- Engine 11 InvisiSynth;
- Engine 14 Clarification;
- Engine 15 Contradiction Resolution;
- HTE architecture/core-thinking documents;
- HTE-DOTNET v2.0 Ultra as evidence that depth and specialization can be operational rather than cosmetic.

The parent HTE remains the conceptual architecture. HTE-Code v2.0 is its software-engineering specialization.

---

# 52. Final Rules

1. **Think holographically; answer concretely.**
2. **Preserve canonical HTE engine meanings.**
3. **Activate code lens packs only when relevant.**
4. **Acquire current system truth before exact claims.**
5. **Separate observation, interpretation, hypothesis, conclusion, and decision.**
6. **Every leading hypothesis needs a falsifier at Depth 5.**
7. **Mechanism outranks slogans and fashion.**
8. **Tests must prove the failure model and product intent.**
9. **Implementation is part of reasoning because execution returns evidence.**
10. **Qualification belongs to an exact state.**
11. **Memory is context, not a substitute for re-querying live state.**
12. **Learning updates calibration, not just stored facts.**
13. **Do not create generic abstractions until concrete repeated needs earn them.**
14. **Do not create audits whose only product is more audits.**
15. **When implementation is already authorized, do the work.**

---

# 53. Attached Specialist: huechart — Avalonia Color/Hue & Visibility Chart

**Load the `huechart` skill for ANY pass that touches theme colors, contrast,
palette balance, hue harmony, or dark/light-mode legibility in Avalonia/WPF/XAML
projects** (`C:\Users\User\.claude\skills\huechart\SKILL.md`). It is a fixed
companion of HTE-Code on theming work — this section is the direct call.

Three zones, three files (full chart at plain-markdown tables; no images):

| Zone | File(s) | What lives there |
|------|---------|------------------|
| 🧪 **C# color machinery** | `huechart/references/csharp-helpers.md` | Portable C#: WCAG relative luminance, contrast ratio, RGB↔HSL/hue, perceptual distance, `AuditTheme` sketch. Mirror in-repo: `RitualOS.ThemeContrast` + `ThemeContrastAuditor` + `ThemeBalanceAuditTests`. |
| 👁 **Human visibility** | `huechart/references/hue-wheel.md`, `luminance.md`, `contrast.md` | Hue wheel + harmony recipes; perceived luminance + dark/light surface bands; contrast formula, AA/AAA thresholds, quick matrix, and the full required pair set. |
| 🚨 **Immediate fix — imperceptible by humans** | `huechart/references/palette-balance.md` (§2 defect catalog) | D1–D8 "AI-visible, human-invisible" defects: roll-keys with contrast < 1.15:1, RGB distance < 24, same-hue same-luminance pairs, duplicate hexes. **Every hit must be resolved before a theme is complete.** |

Execution rules when this hook fires:

1. Run `contrast` on every intended pair (4.5 body / 3.0 large + non-text).
2. Run the `imperceptible` detector (contrast < 1.15:1 or RGB distance < 24) across
   all role-keys — anything flagged is an identity bug invisible to a reviewer and
   goes straight to the fix list (merge or split by luminance ≥ 3:1).
3. Re-verify balance (60-30-10, one hue family, luminance ladder, text neutrality).
4. Re-run the full theme fingerprint until zero failures, then qualify as normal.

Memorize the invariants: `L = 0.2126R + 0.7152G + 0.0722B` (linear channels);
`contrast = (L1+0.05)/(L2+0.05)`; floors `7.0 / 4.5 / 3.0 / 1.15`.

---

**HTE-Code v2.0 — Deep Engineering Edition**  
**Depth-aware | Evidence-led | Hypothesis-driven | Mechanism-first | Execution-closed-loop | Exact-state qualified**


---

# RESOLVED PACK: language.zil

## PACK DOCUMENT: CONCERNS.md

# zil Depth-5 Language/DSL Concerns

This is a language-specific augmentation of the complete HTE-Code v2 Depth-5 baseline.
Every concern below must be interpreted with the repo's actual compiler, runtime, platform,
toolchain, flags, version, and interop seams. Language facts never substitute for those layers.

## High-signal failure mechanics
- ZIL/ZILF dialect/compiler identity matters; historical Infocom source and modern compiler extensions are not automatically equivalent.
- FORM/ROUTINE/OBJECT/global/local syntax expands into Z-machine constraints; source structure does not remove target-machine limits.
- Macro expansion and compile-time evaluation can duplicate expressions, capture names, or emit materially different low-level forms.
- Parser grammar, syntax tables, vocabulary properties, and action routines are a coupled semantic system.
- Object inheritance/properties/flags and containment form world-state invariants; parser-visible names and object identity must stay coherent.
- Global/local variable pressure and target-version limits can constrain apparently harmless refactors.
- Routine truth values, arithmetic width, side effects, evaluation order, and target opcodes need compiler-specific confirmation.
- Strings/dictionary words compile through Z-character/ZSCII rules with abbreviation and length constraints.
- Table layout/flags/byte-vs-word access must match the generated Z-machine representation.
- Save/restore/restart behavior means new mutable state needs initialization and persistence reasoning.
- Parser modernization must preserve existing accepted syntax/error behavior unless intentionally changed and regression-locked.
- Compiler warnings/errors plus generated assembly/story output are separate evidence tiers.
- Z-machine version selection controls object/property/global/addressing resources available to the source.
- Differential play transcripts are high-value characterization tests for parser/world behavior.
- Qualification includes compile, story validation, automated gameplay transcripts, and real interpreter execution for user journeys.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Language Pack: zil

**Baseline:** HTE-Code v2 Depth 5
**Role:** language-specific augmentation; canonical HTE engines remain unchanged.
**Maturity:** seeded (signature failure mechanics present; expansion continues)

## Depth-5 activation

Run this pack whenever repository evidence shows this language or generated/executed artifacts in it.
Do not substitute a neighboring language pack. Compiler, runtime, toolchain and interop packs are additive.

## Signature concern catalog

### macro-expansion

**Mechanism:** ZIL source semantics are heavily macro- and compiler-mediated; expansion can change evaluation, storage and control flow.

**Detection:** inspect FORM/MACRO expansion and compiler output.

**Adversarial edge:** side-effecting operands, nested macros, version-specific syntax.

**Qualification:** compile and inspect generated Z-code/diagnostics.

### object-property

**Mechanism:** Objects, properties, globals and routines map into constrained Z-machine tables and memory.

**Detection:** trace symbol to compiled table/address usage.

**Adversarial edge:** missing property, property width, object tree mutation.

**Qualification:** story runtime test plus compiled map inspection.

### parser-contract

**Mechanism:** Parser tables, syntax definitions and action routines must agree on tokens, objects and verb dispatch.

**Detection:** trace grammar entry to action routine.

**Adversarial edge:** synonym ambiguity, omitted noun, direction shortcuts.

**Qualification:** scripted transcript tests.

### version-limits

**Mechanism:** Z-machine version controls opcodes, memory model, text, object/property limits and I/O capabilities.

**Detection:** record target version and compiler switches.

**Adversarial edge:** feature crossing version boundary.

**Qualification:** compile/run on target interpreter matrix.

## Mandatory cross-passes

- Map syntax/type facts separately from compiler/runtime implementation facts.
- Enumerate undefined, unspecified, implementation-defined, dynamic, or host-defined behavior where the language permits it.
- Trace resource lifetime, errors, concurrency/ordering, external input, serialization and generated-code boundaries where applicable.
- Run negative-space analysis: declared/loaded/typed is not proof of execution or consumption.
- Bind every strong claim to direct repo/runtime evidence at the appropriate tier.
- Record version/dialect/compiler/runtime qualifiers instead of universalizing one implementation.

## Expansion backlog

This seeded pack must continue accumulating standard-library traps, production failure signatures,
version-specific deltas, static-analysis rules, edge campaigns, and repo-learned motifs.


## PACK DOCUMENT: FULL-COVERAGE.md

# Full Coverage Addendum
- **Migration:** ZIL compiler/macro library, target Z-machine version, ZAP/assembler and interpreter compatibility can alter generated tables/opcodes/layout without high-level source syntax changes.
- **False-positive guard:** unusual macro/control/property patterns may be intentional to satisfy Z-machine size/layout/version limits; preserve only with generated-story map/disassembly and transcript proof.


---

# RESOLVED PACK: language.python

## PACK DOCUMENT: CONCERNS.md

# python Depth-5 Language/DSL Concerns

This is a language-specific augmentation of the complete HTE-Code v2 Depth-5 baseline.
Every concern below must be interpreted with the repo's actual compiler, runtime, platform,
toolchain, flags, version, and interop seams. Language facts never substitute for those layers.

## High-signal failure mechanics
- Mutable default arguments are allocated at function definition and persist across calls; intentional caches must be distinguished from bugs.
- Closures use late binding of captured names unless values are frozen deliberately; loop-generated callbacks are a classic failure.
- Name resolution (LEGB), descriptors, properties, __getattribute__, metaclasses, and monkey patching can hide substantial behavior behind attribute access.
- MRO/super in multiple inheritance follows C3 linearization; cooperative methods require every participant to follow the protocol.
- Iterators/generators are stateful and usually single-pass; exhaustion, lazy side effects, close/finally behavior, and generator retention matter.
- Context managers encode acquisition/release and exception suppression; returning true from __exit__ changes failure semantics.
- async/await runs on an event loop, not magically in parallel; blocking calls freeze progress and cancellation is exception-driven/cooperative.
- Task ownership matters: orphaned tasks, lost exceptions, TaskGroup semantics, shielding, and loop shutdown are lifecycle concerns.
- Threads share memory but CPython's GIL does not make compound application invariants atomic; C extensions can release it.
- Multiprocessing start method (spawn/fork/forkserver), pickling, __main__ guards, inherited resources, and Windows behavior differ sharply.
- Exceptions carry chaining/context; broad except, finally returns, and cleanup failures can hide the original cause.
- Imports execute module top-level code once per module identity; sys.path, packages, relative imports, circular imports, and duplicate module paths alter identity.
- Type hints are mostly not runtime enforcement; Any, casts, protocols, generics, variance, and postponed annotations have checker/version-specific semantics.
- dataclasses/default_factory/frozen/slots, __eq__/__hash__, mutable fields, and inheritance can create value/identity surprises.
- Hash randomization and dict/set ordering assumptions need version/process awareness; never derive persisted behavior from hash().
- Text vs bytes, filesystem encodings, surrogate handling, newline translation, locale, and Unicode normalization affect external boundaries.
- subprocess argument lists vs shell=True, Windows quoting, environment inheritance, cwd, pipes, deadlocks, encodings, and exit status require process-level proof.
- Packaging/venvs/editable installs/pyproject/lock state can make the imported code differ from the source tree being inspected.
- CPython/PyPy/version/C-extension behavior and optimization flags form separate qualification surfaces.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Language Pack: python

**Baseline:** HTE-Code v2 Depth 5
**Role:** language-specific augmentation; canonical HTE engines remain unchanged.
**Maturity:** seeded (signature failure mechanics present; expansion continues)

## Depth-5 activation

Run this pack whenever repository evidence shows this language or generated/executed artifacts in it.
Do not substitute a neighboring language pack. Compiler, runtime, toolchain and interop packs are additive.

## Signature concern catalog

### name-binding

**Mechanism:** Python name lookup, closures, late binding, descriptors and import-time execution can change behavior without type errors.

**Detection:** trace LEGB, closure cells, descriptors, module initialization order.

**Adversarial edge:** loop closures, shadowing, circular imports, monkeypatching.

**Qualification:** direct runtime assertions for bound object and call target.

### mutable-defaults

**Mechanism:** Default arguments and class/module objects are created at definition/import time and can retain mutable state.

**Detection:** hunt mutable defaults, caches, globals and singleton module state.

**Adversarial edge:** repeat call, test isolation, reload/import order.

**Qualification:** fresh-process and repeated-call equivalence.

### asyncio

**Mechanism:** Coroutine creation is not execution; event-loop ownership, task cancellation and blocking calls shape correctness.

**Detection:** trace coroutine/task ownership, awaits, loop crossings, blocking I/O.

**Adversarial edge:** cancel during await, orphan task, loop shutdown.

**Qualification:** no leaked tasks; cancellation reaches intended boundary.

### exceptions-context

**Mechanism:** Broad catches, exception chaining, finally/with behavior and generator cleanup can hide root causes or alter control flow.

**Detection:** inspect except BaseException/Exception, bare except, raise from, context managers.

**Adversarial edge:** exception inside cleanup/finally, GeneratorExit, KeyboardInterrupt.

**Qualification:** original cause preserved and cleanup proven.

### typing-runtime-gap

**Mechanism:** Type hints are mostly non-enforcing; protocols, Any, casts and dataclass/pydantic/runtime reflection can diverge.

**Detection:** compare static model to runtime validators/constructors.

**Adversarial edge:** wrong dynamic type through Any/cast/deserialization.

**Qualification:** runtime contract test plus static check.

## Mandatory cross-passes

- Map syntax/type facts separately from compiler/runtime implementation facts.
- Enumerate undefined, unspecified, implementation-defined, dynamic, or host-defined behavior where the language permits it.
- Trace resource lifetime, errors, concurrency/ordering, external input, serialization and generated-code boundaries where applicable.
- Run negative-space analysis: declared/loaded/typed is not proof of execution or consumption.
- Bind every strong claim to direct repo/runtime evidence at the appropriate tier.
- Record version/dialect/compiler/runtime qualifiers instead of universalizing one implementation.

## Expansion backlog

This seeded pack must continue accumulating standard-library traps, production failure signatures,
version-specific deltas, static-analysis rules, edge campaigns, and repo-learned motifs.


## PACK DOCUMENT: FULL-COVERAGE.md

# Full Coverage Addendum
- **Numerics:** Python int is arbitrary precision, but float/Decimal/Fraction, struct/array/native extensions, NumPy, timestamps and protocol/database fields reintroduce width/precision/NaN/overflow constraints; test conversion boundaries explicitly.
- **Performance:** interpreter dispatch, allocation, algorithmic complexity, repeated serialization, import/startup cost, GIL/thread contention and blocking async calls require profiling; microbenchmarks do not substitute for application workload.
- **Migration:** Python minor/major, CPython/PyPy, stdlib, typing, asyncio, packaging and C-extension ABI changes can alter behavior even when syntax still parses.


---

# RESOLVED PACK: language.shell

## PACK DOCUMENT: CONCERNS.md

# shell Depth-5 Language/DSL Concerns

This is a language-specific augmentation of the complete HTE-Code v2 Depth-5 baseline.
Every concern below must be interpreted with the repo's actual compiler, runtime, platform,
toolchain, flags, version, and interop seams. Language facts never substitute for those layers.

## High-signal failure mechanics
- Shell dialect is a contract: POSIX sh, bash, zsh, dash, BusyBox ash, and others differ in syntax/features and edge behavior.
- Unquoted parameter/command expansion triggers word splitting and globbing; quoting rules must be reasoned at every expansion layer.
- Arrays, associative arrays, process substitution, [[ ]], brace expansion, and pipefail are non-POSIX extensions.
- set -e has context-dependent exceptions and is not a substitute for explicit error handling.
- Pipeline exit status normally reflects the final command unless pipefail changes it; subshell execution can hide variable mutations.
- Command substitution strips trailing newlines and runs in a subshell context in common shells.
- Redirections are processed left-to-right; 2>&1 >file differs from >file 2>&1.
- IFS changes tokenization globally/locally and interacts with read, for, positional parameters, and command output.
- glob patterns are not regex; unmatched-glob behavior varies by shell/options.
- trap/signal handling, EXIT traps, child processes, exec, and cleanup ordering are lifecycle mechanisms.
- mktemp/permissions/symlinks and predictable temporary paths are security and race surfaces.
- eval and sh -c add parse layers and are injection boundaries; prefer argv-preserving APIs.
- PATH resolution, aliases/functions/hash caches, shebang parsing, cwd, and environment can execute a different program than inspection suggests.
- Text tools have locale/encoding/line-ending/filename delimiter assumptions; newline-delimited loops break on arbitrary filenames.
- Qualification runs under every supported shell with the same environment/cwd/umask/PATH and exercises failure/interrupt paths.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Language Pack: shell

**Baseline:** HTE-Code v2 Depth 5
**Role:** language-specific augmentation; canonical HTE engines remain unchanged.
**Maturity:** seeded (signature failure mechanics present; expansion continues)

## Depth-5 activation

Run this pack whenever repository evidence shows this language or generated/executed artifacts in it.
Do not substitute a neighboring language pack. Compiler, runtime, toolchain and interop packs are additive.

## Signature concern catalog

### word-splitting

**Mechanism:** POSIX shell expansion order includes parameter expansion, command substitution, word splitting and globbing; unquoted data can change argv.

**Detection:** hunt unquoted expansions and eval.

**Adversarial edge:** spaces, newlines, *, leading dash, empty value.

**Qualification:** argv-capture tests.

### errexit

**Mechanism:** set -e behavior has contextual exceptions; pipelines/subshells/functions can suppress or transform failure.

**Detection:** trace exit status through conditionals, pipes and command substitutions.

**Adversarial edge:** failure in pipeline/function/subshell.

**Qualification:** deliberate failure exits where contract says.

### temp-race

**Mechanism:** Temporary files, traps and signal cleanup are filesystem/concurrency boundaries.

**Detection:** inspect mktemp/trap/permissions.

**Adversarial edge:** SIGINT, duplicate invocation, symlink race.

**Qualification:** parallel/fault tests leave no unsafe residue.

### portability

**Mechanism:** bashisms, GNU/BSD utility flags and locale differences break nominally POSIX scripts.

**Detection:** record shell and utility assumptions.

**Adversarial edge:** dash/bash, GNU/BSD, locale, path with newline.

**Qualification:** target shell/platform matrix.

## Mandatory cross-passes

- Map syntax/type facts separately from compiler/runtime implementation facts.
- Enumerate undefined, unspecified, implementation-defined, dynamic, or host-defined behavior where the language permits it.
- Trace resource lifetime, errors, concurrency/ordering, external input, serialization and generated-code boundaries where applicable.
- Run negative-space analysis: declared/loaded/typed is not proof of execution or consumption.
- Bind every strong claim to direct repo/runtime evidence at the appropriate tier.
- Record version/dialect/compiler/runtime qualifiers instead of universalizing one implementation.

## Expansion backlog

This seeded pack must continue accumulating standard-library traps, production failure signatures,
version-specific deltas, static-analysis rules, edge campaigns, and repo-learned motifs.


## PACK DOCUMENT: FULL-COVERAGE.md

# Full Coverage Addendum
- **Numerics:** shell arithmetic, test predicates and external utilities use implementation-specific integer parsing/width and locale; durations/sizes/exit codes should be validated with explicit units and commands instead of string comparison.
- **False-positive guard:** ShellCheck warnings may be intentional for deliberate word splitting, globbing or shell-specific extensions. Document the exact valid context and add a hostile-filename/argv fixture before suppression.


---

# RESOLVED PACK: language.rust

## PACK DOCUMENT: CONCERNS.md

# rust Depth-5 Language/DSL Concerns

This is a language-specific augmentation of the complete HTE-Code v2 Depth-5 baseline.
Every concern below must be interpreted with the repo's actual compiler, runtime, platform,
toolchain, flags, version, and interop seams. Language facts never substitute for those layers.

## High-signal failure mechanics
- Ownership/borrowing rules prove specific alias/lifetime properties, not overall logic correctness or deadlock freedom.
- Non-lexical lifetimes and reborrowing can make the actual borrow end earlier than visible scope; unsafe code must honor the stronger semantic contract.
- Interior mutability (Cell/RefCell/Mutex/RwLock/atomics) moves invariants from compile time to runtime or synchronization protocols.
- Send/Sync are unsafe auto traits whose incorrect manual implementation can make otherwise safe code unsound.
- unsafe permits operations the compiler cannot prove; every unsafe block/API needs explicit safety invariants and caller obligations.
- Raw pointers, MaybeUninit, ManuallyDrop, unions, transmute, repr, and provenance require layout/lifetime/alignment proofs.
- Pin prevents specific movement through a pinned reference; Unpin, projection, self-referential futures, and drop guarantees matter.
- Drop order, temporary lifetimes, panic unwinding/abort mode, poisoning, and destructor panics affect cleanup and FFI.
- Debug integer overflow checks vs optimized wrapping behavior assumptions must be explicit; checked/wrapping/saturating operations encode intent.
- Trait coherence/orphan rules, blanket impls, deref coercion, method resolution, associated types, and inference can select unexpected behavior.
- Async futures are lazy state machines; cancellation is usually drop, and holding locks/borrows across await can deadlock or extend lifetimes.
- tokio/async-std/smol/runtime choice is separate from Rust language semantics and determines scheduling/timer/I/O behavior.
- Atomics require ordering proofs; Relaxed/Acquire/Release/SeqCst encode different synchronization and compiler/CPU freedoms.
- FFI requires repr(C), unwind policy, allocator ownership, pointer validity, callback lifetime, thread rules, and panic isolation.
- Cargo features are additive within a resolution graph; default features, optional deps, resolver version, target cfg, and build scripts alter compiled code.
- proc macros/build.rs/generated bindings execute during build and can create hidden source/environment dependencies.
- Editions alter parsing/resolution/lints without being runtime versions; MSRV must be tested separately from current stable.
- Miri, sanitizers, loom, clippy, fuzzers, tests, and optimized builds expose different defect classes and should be composed as evidence.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Language Pack: rust

**Baseline:** HTE-Code v2 Depth 5
**Role:** language-specific augmentation; canonical HTE engines remain unchanged.
**Maturity:** seeded (signature failure mechanics present; expansion continues)

## Depth-5 activation

Run this pack whenever repository evidence shows this language or generated/executed artifacts in it.
Do not substitute a neighboring language pack. Compiler, runtime, toolchain and interop packs are additive.

## Signature concern catalog

### ownership-lifetime

**Mechanism:** Borrow checking proves specific alias/lifetime rules, not semantic ownership of files, locks, handles or protocol state.

**Detection:** trace RAII owner, Arc/Rc clones, guards and Drop order.

**Adversarial edge:** early return, panic, clone retention, cycles.

**Qualification:** resource/liveness tests and Miri where applicable.

### unsafe-boundary

**Mechanism:** unsafe shifts proof obligations to local invariants covering aliasing, initialization, layout, provenance and concurrency.

**Detection:** enumerate every unsafe block/function and required invariant.

**Adversarial edge:** zero-sized, unaligned, aliasing, invalid enum/discriminant.

**Qualification:** Miri/sanitizer plus targeted boundary tests.

### async-cancel

**Mechanism:** Future cancellation is drop; cancellation safety depends on state held across await and partial side effects.

**Detection:** trace state before/after await, select! branches and guard lifetimes.

**Adversarial edge:** drop at every await, timeout race.

**Qualification:** cancellation campaign shows no leaked/half-applied state.

### traits-coherence

**Mechanism:** Trait resolution, blanket impls, auto traits, Send/Sync and deref coercion can change available behavior unexpectedly.

**Detection:** inspect impl graph, feature flags and bounds.

**Adversarial edge:** negative auto-trait, conflicting feature combination.

**Qualification:** cargo check/test feature matrix.

### panic-overflow

**Mechanism:** panic strategy, debug/release overflow, unwrap/expect and indexing change failure behavior across profiles.

**Detection:** hunt panic sites and arithmetic assumptions.

**Adversarial edge:** min/max integers, malformed indexes, release build.

**Qualification:** debug/release equivalence where required.

## Mandatory cross-passes

- Map syntax/type facts separately from compiler/runtime implementation facts.
- Enumerate undefined, unspecified, implementation-defined, dynamic, or host-defined behavior where the language permits it.
- Trace resource lifetime, errors, concurrency/ordering, external input, serialization and generated-code boundaries where applicable.
- Run negative-space analysis: declared/loaded/typed is not proof of execution or consumption.
- Bind every strong claim to direct repo/runtime evidence at the appropriate tier.
- Record version/dialect/compiler/runtime qualifiers instead of universalizing one implementation.

## Expansion backlog

This seeded pack must continue accumulating standard-library traps, production failure signatures,
version-specific deltas, static-analysis rules, edge campaigns, and repo-learned motifs.


## PACK DOCUMENT: FULL-COVERAGE.md

# Full Coverage Addendum
- **Performance:** zero-cost abstractions are not a guarantee of zero allocation/copy/code-size. Monomorphization, iterator optimization, async state size, Arc/Mutex contention, cloning, bounds checks and allocator behavior need measurement in release profile.


---

# RESOLVED PACK: language.assembly

## PACK DOCUMENT: CONCERNS.md

# assembly Depth-5 Language/DSL Concerns

This is a language-specific augmentation of the complete HTE-Code v2 Depth-5 baseline.
Every concern below must be interpreted with the repo's actual compiler, runtime, platform,
toolchain, flags, version, and interop seams. Language facts never substitute for those layers.

## High-signal failure mechanics
- ISA and dialect identity: opcode spelling is meaningless without exact architecture, mode, assembler, and extensions.
- ABI/calling convention: preserve required registers, stack alignment, shadow/red zones, return channels, and unwind metadata.
- Flags/status registers: arithmetic and helper instructions can silently destroy condition state expected by callers.
- Stack balance and frame shape: pushes, local storage, interrupts, exceptions, and tail paths must reconcile exactly.
- Addressing/relocation: absolute, PC-relative, banked, segmented, and linker-relocated addresses fail differently.
- Alignment: instruction fetch and data alignment affect correctness on some CPUs and performance on others.
- Partial-register/subregister semantics: writes can zero-extend, preserve upper bits, or create dependencies by ISA.
- Interrupt/reentrancy boundaries: code correct in ordinary flow may corrupt state under interrupt, signal, or nested entry.
- Atomicity and memory ordering: ordinary loads/stores do not imply inter-core/device ordering.
- Branch reach and relaxation: assembler/linker rewrites and short/long forms can invalidate handcrafted footprints.
- Instruction encoding size: hooks and binary surgery require byte-accurate footprints, not source-line equivalence.
- Undefined/reserved instructions and CPU errata: emulator behavior is not sufficient evidence for silicon behavior.
- Self-modifying code and I-cache coherence: writes to executable memory may require barriers/cache maintenance.
- Cycle timing: latency, throughput, cache state, branch prediction, and wait states must be distinguished.
- Binary/object format contracts: sections, relocations, symbols, alignment, and loader behavior are part of correctness.
- Emulator vs hardware: qualification must explicitly separate assembler success, emulator behavior, and real target behavior.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Language Pack: assembly

**Baseline:** HTE-Code v2 Depth 5
**Role:** language-specific augmentation; canonical HTE engines remain unchanged.
**Maturity:** seeded (signature failure mechanics present; expansion continues)

## Depth-5 activation

Run this pack whenever repository evidence shows this language or generated/executed artifacts in it.
Do not substitute a neighboring language pack. Compiler, runtime, toolchain and interop packs are additive.

## Signature concern catalog

### abi-registers

**Mechanism:** Correctness depends on ISA, calling convention, register/flag preservation, stack alignment and displaced instruction semantics.

**Detection:** map registers, flags, stack deltas, caller/callee contract and hook footprint.

**Adversarial edge:** interrupt/reentry, nested calls, boundary stack alignment.

**Qualification:** byte-accurate disassembly plus runtime/hardware or emulator proof.

### addressing

**Mechanism:** Effective-address calculation, bank/segment/page state and relocation determine what bytes are touched.

**Detection:** derive every address from mode/register/bank state.

**Adversarial edge:** page boundary, wraparound, bank switch, sign extension.

**Qualification:** trace actual accesses at boundary values.

### timing

**Mechanism:** Instruction latency/throughput, branch behavior, pipeline/cache and cycle-exact device timing can be semantic requirements.

**Detection:** target exact CPU and count/measure path-dependent cycles.

**Adversarial edge:** taken/not-taken, cache miss, interrupt arrival.

**Qualification:** cycle/hardware trace meets budget.

### flags-ub

**Mechanism:** Arithmetic flags, undocumented results and reserved bits are architecture-specific state, not incidental metadata.

**Detection:** track every consumed flag and instruction-defined status.

**Adversarial edge:** zero, carry, overflow, min/max signed values.

**Qualification:** reference manual + test vector or silicon/emulator evidence.

### self-modifying

**Mechanism:** Code/data aliasing and instruction-cache visibility govern self-modifying patches.

**Detection:** trace write target, executable mapping and cache synchronization.

**Adversarial edge:** cross-page patch, partial write, concurrent execution.

**Qualification:** post-patch disassembly and execution proof.

## Mandatory cross-passes

- Map syntax/type facts separately from compiler/runtime implementation facts.
- Enumerate undefined, unspecified, implementation-defined, dynamic, or host-defined behavior where the language permits it.
- Trace resource lifetime, errors, concurrency/ordering, external input, serialization and generated-code boundaries where applicable.
- Run negative-space analysis: declared/loaded/typed is not proof of execution or consumption.
- Bind every strong claim to direct repo/runtime evidence at the appropriate tier.
- Record version/dialect/compiler/runtime qualifiers instead of universalizing one implementation.

## Expansion backlog

This seeded pack must continue accumulating standard-library traps, production failure signatures,
version-specific deltas, static-analysis rules, edge campaigns, and repo-learned motifs.


## PACK DOCUMENT: FULL-COVERAGE.md

# Full Coverage Addendum
- **Binding/modules:** assembly includes, sections, exported/imported symbols, linker scripts and binary asset inclusion are the module/binding layer; symbol existence does not prove the final address/calling contract.
- **Migration:** changing assembler, ISA mode, ABI, linker, CPU generation, ROM mapper or hook location requires fresh byte/disassembly/runtime qualification.
- **False-positive guard:** a suspicious clobber, unusual encoding or cycle-heavy sequence is not automatically wrong; compare against the exact ABI, byte footprint, timing requirement and caller contract before rewriting low-level code.


---

# RESOLVED PACK: language.z-machine-assembly

## PACK DOCUMENT: CONCERNS.md

# z-machine-assembly Depth-5 Language/DSL Concerns

This is a language-specific augmentation of the complete HTE-Code v2 Depth-5 baseline.
Every concern below must be interpreted with the repo's actual compiler, runtime, platform,
toolchain, flags, version, and interop seams. Language facts never substitute for those layers.

## High-signal failure mechanics
- Z-machine standard version determines available opcodes, operand forms, object/property layout, text encoding, and interpreter obligations.
- Routine calls, local variables, evaluation stack, call frames, and return/catch/throw semantics must be tracked exactly.
- Opcode encoding uses 0OP/1OP/2OP/VAR/EXT forms and variable/constant operand encodings; disassembly must preserve exact forms where required.
- Branch offsets have compact/special return encodings and can change when surrounding code size moves.
- Packed routine/string addresses are version-dependent and are not ordinary byte addresses.
- Dynamic vs static/high memory regions have writeability and loader semantics that constrain patch placement.
- Object-table entry size/property encoding differs by Z-machine version; invalid property traversal can corrupt world state.
- Dictionary/vocabulary encoding and tokenization tie parser behavior to exact text-table semantics.
- ZSCII/Unicode/abbreviation alphabets make source-looking strings differ from encoded story data.
- Save/restore/restart/undo preserve defined machine state; added globals/tables must behave correctly across these transitions.
- Random-number opcode semantics include predictable seeding modes useful for deterministic tests.
- Screen/input/sound opcodes depend on interpreter capabilities; compiler/emulator success is not cross-interpreter proof.
- Story header flags/extensions advertise required capabilities and must remain consistent with emitted behavior.
- Binary patches must preserve checksum/length/header metadata where tooling/interpreters validate them.
- Qualification uses the intended story version plus multiple relevant interpreters when compatibility is claimed.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Language Pack: z-machine-assembly

**Baseline:** HTE-Code v2 Depth 5
**Role:** language-specific augmentation; canonical HTE engines remain unchanged.
**Maturity:** seeded (signature failure mechanics present; expansion continues)

## Depth-5 activation

Run this pack whenever repository evidence shows this language or generated/executed artifacts in it.
Do not substitute a neighboring language pack. Compiler, runtime, toolchain and interop packs are additive.

## Signature concern catalog

### opcode-version

**Mechanism:** Opcode legality and operand encoding depend on Z-machine version and instruction form.

**Detection:** decode emitted opcodes against target spec.

**Adversarial edge:** short/long/variable forms, version-gated opcodes.

**Qualification:** disassemble and execute target story.

### stack-call

**Mechanism:** Evaluation stack, routine locals, call/return conventions and branch/store forms must balance exactly.

**Detection:** trace stack delta and result storage.

**Adversarial edge:** early branch, throw/catch, nested call.

**Qualification:** interpreter trace with stack invariants.

### packed-address

**Mechanism:** Routine/string packed addresses and memory regions vary by version and scale factors.

**Detection:** derive physical addresses from header/version rules.

**Adversarial edge:** boundary near static/high memory.

**Qualification:** disassembler/map cross-check.

### text-io

**Mechanism:** Z-encoded text, abbreviations, dictionaries and stream/window behavior have compact binary constraints.

**Detection:** inspect encoding tables and buffers.

**Adversarial edge:** max token, unicode/ZSCII edge.

**Qualification:** transcript/interpreter comparison.

## Mandatory cross-passes

- Map syntax/type facts separately from compiler/runtime implementation facts.
- Enumerate undefined, unspecified, implementation-defined, dynamic, or host-defined behavior where the language permits it.
- Trace resource lifetime, errors, concurrency/ordering, external input, serialization and generated-code boundaries where applicable.
- Run negative-space analysis: declared/loaded/typed is not proof of execution or consumption.
- Bind every strong claim to direct repo/runtime evidence at the appropriate tier.
- Record version/dialect/compiler/runtime qualifiers instead of universalizing one implementation.

## Expansion backlog

This seeded pack must continue accumulating standard-library traps, production failure signatures,
version-specific deltas, static-analysis rules, edge campaigns, and repo-learned motifs.


## PACK DOCUMENT: FULL-COVERAGE.md

# Full Coverage Addendum
- **Numerics:** operands, locals/globals, branches, object/property fields and addresses are constrained by Z-machine word/version widths; signed comparisons and packed-address scaling require explicit boundary tests.
- **False-positive guard:** odd-looking opcode form, stack manipulation or packed-address arithmetic can be a compiler/layout optimization; compare against Z-machine spec and interpreter trace before rewriting.


---

# RESOLVED PACK: compiler.assembler-unspecified

## PACK DOCUMENT: CONCERNS.md

# assembler-unspecified Depth-5 Compiler/Assembler Concerns

This implementation pack augments HTE-Code v2 Depth 5.
Compiler/assembler acceptance, diagnostics, generated artifacts, optimization,
linkage and runtime behavior must remain separate evidence tiers.

## High-signal implementation mechanics

- Identity gate: assembler, ISA, mode, object/binary format, target CPU and command line must be resolved before implementation-specific analysis.
- Parser/grammar: identical mnemonics/directives may mean different things across MASM/NASM/GAS/ca65/NESASM/vasm/other dialects.
- Binding/modules: symbol scope, include/macro search, sections and external linkage cannot be assumed without tool identity.
- Type/width semantics: operand-size defaults, address-size modes, literal syntax and signed-expression handling are tool/ISA dependent.
- Numeric limits: immediate/displacement/branch widths and expression overflow need emitted-byte evidence.
- Memory/layout: ORG/section/segment/bank and alignment directives determine address meaning and must be reconstructed from build artifacts.
- Errors/recovery: generic 'syntax error' or range diagnostics should first trigger tool/dialect resolution, not speculative source edits.
- Concurrency/interrupts: ISR/reentrancy/atomicity requirements come from target system and cannot be inferred from source mnemonics alone.
- Serialization/artifact: listing, map, relocation and disassembly are required evidence; source text alone is insufficient.
- Security/safety: binary patching/device/privileged instructions raise authority and blast-radius concerns even when assembler accepts them.
- ABI/interop: caller/callee register, stack, alignment and symbol conventions remain unknown until target/toolchain is identified.
- Platform/device: CPU revision, endianness, memory map and emulator/hardware target are unresolved evidence variables.
- Libraries/macros: macro packages may hide large expansions and side effects.
- Performance: cycle/throughput claims are prohibited until CPU/microarchitecture and memory system are known.
- Testing: first qualification test is tool identification; then assemble minimal probes and disassemble exact bytes.
- Instrumentation: capture --version/help, build command, listing, object metadata, map and disassembly.
- Failure signatures: unknown mnemonic/directive often dialect/CPU mismatch; relocation/range errors often wrong format/layout assumptions.
- Undefined/implementation-defined: all implementation-specific behavior stays low confidence while this fallback remains active.
- Migration: replacing the assembler can change syntax, macro expansion, relocation and bytes; compare binaries rather than trusting source compatibility.
- Negative-space: a file extension '.asm' does not prove the ISA, assembler or executable role.
- False-positive guard: suspicious syntax may be valid in another assembler dialect; do not 'fix' it until the build tool is proven.
- Learning motif: once identified, activate the concrete compiler/assembler pack and retire this fallback from final analysis.



## PACK DOCUMENT: DEPTH5.md

# HTE-Code Compiler Pack: assembler-unspecified

**Baseline:** HTE-Code v2 Depth 5
**Role:** compiler-specific augmentation; language packs remain separate and additive.
**Maturity:** seeded

## Signature concern catalog

### identify

**Mechanism:** No assembly conclusion is strong until assembler, ISA, object/binary format and command line are identified.

**Detection:** resolve tool from build scripts/artifacts before analysis.

**Adversarial edge:** ambiguous syntax accepted by multiple assemblers.

**Qualification:** record exact assembler/version or downgrade confidence.

### listing

**Mechanism:** Generate listing/disassembly to prove source-to-byte mapping.

**Detection:** compare source to emitted bytes.

**Adversarial edge:** pseudo-instruction expansion.

**Qualification:** byte audit.

## Depth-5 rules

- Resolve exact version, target, flags, feature switches and generated/intermediate artifacts before strong implementation-specific claims.
- Separate source-language legality from compiler acceptance, emitted artifact semantics and runtime behavior.
- Compare clean and incremental paths where caches/generation exist.
- Treat warnings, optimizations, link/load stages and generated outputs as evidence surfaces.
- Downgrade confidence when the exact implementation cannot be identified.


## PACK DOCUMENT: FULL-COVERAGE.md

# Full Coverage Addendum
- **Libraries/ecosystem:** until the assembler is identified, macro packages, object-format libraries, linker/runtime helpers and debugging/disassembly tools are unresolved dependencies. Treat library behavior as unknown rather than borrowing NASM/MASM/GAS conventions.


---

# RESOLVED PACK: compiler.rustc

## PACK DOCUMENT: CONCERNS.md

# rustc Depth-5 Compiler Concerns

This pack augments the complete HTE-Code v2 Depth-5 baseline. Version, target, flags, host, and adjacent packs remain part of the proof.

## High-signal failure mechanics
- rustc version, edition, target, cfg flags, panic strategy, optimization, overflow checks, codegen units, LTO, and target features affect artifacts.
- Stable/beta/nightly features and -Z flags are not interchangeable; MSRV is independent of current-toolchain success.
- Monomorphization can surface errors/code size only for instantiated generic paths.
- unsafe-code soundness is not established by borrow checking; compiler acceptance assumes documented unsafe invariants.
- debug vs release changes overflow checks, optimization, timing, and sometimes latent-UB manifestation.
- target-feature/cpu enables instructions unavailable on baseline hardware unless dispatch is explicit.
- Linker selection and CRT/static/dynamic choices are downstream ABI/runtime inputs.
- Lints/clippy are separate from rustc errors; deny/warn policy can change CI qualification.
- Incremental compilation/proc macros/build scripts can introduce stale or environment-sensitive artifacts.
- Compare exact rustc --version --verbose and target triple when reproducing codegen/diagnostic issues.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Compiler Pack: rustc

**Baseline:** HTE-Code v2 Depth 5
**Role:** compiler-specific augmentation; language packs remain separate and additive.
**Maturity:** seeded

## Signature concern catalog

### edition-features

**Mechanism:** Edition, feature flags, cfgs and target features alter parsing, trait resolution and compiled surface.

**Detection:** capture rustc -vV, edition, --cfg/features.

**Adversarial edge:** no-default/all-features and target cfg.

**Qualification:** cargo check/test matrix.

### mir-llvm

**Mechanism:** Borrow/type checks precede MIR/LLVM; unsafe/FFI/layout issues survive front-end success.

**Detection:** inspect MIR/LLVM where needed and use Miri/sanitizers.

**Adversarial edge:** release optimization, invalid layout/provenance.

**Qualification:** Miri/sanitizer + optimized runtime.

### incremental

**Mechanism:** Incremental compilation and proc macros/build scripts can cache/generated-state differently from clean builds.

**Detection:** compare clean/incremental with build.rs/proc macro inputs.

**Adversarial edge:** changed env/file not tracked.

**Qualification:** clean reproducibility test.

## Depth-5 rules

- Resolve exact version, target, flags, feature switches and generated/intermediate artifacts before strong implementation-specific claims.
- Separate source-language legality from compiler acceptance, emitted artifact semantics and runtime behavior.
- Compare clean and incremental paths where caches/generation exist.
- Treat warnings, optimizations, link/load stages and generated outputs as evidence surfaces.
- Downgrade confidence when the exact implementation cannot be identified.


## PACK DOCUMENT: GAPS.md

# rustc Depth-5 Gap Closure

## Binding, lifetime, concurrency, serialization, libraries
- cfg, features, modules, proc-macros and build-script emitted cfg values determine which bindings/items actually exist in a given compilation.
- Borrow checking proves language alias/lifetime constraints, not semantic lifetime of files, sockets, DB transactions, locks, processes or external resources.
- Send/Sync auto traits and async lowering interact with runtime scheduling; compile-time acceptance does not prove application-level race freedom or cancellation safety.
- serde/protobuf/database/wire layouts are separate serialization contracts; Rust enum/layout appearance is not an external schema unless explicitly defined.
- std plus crates are versioned ecosystem dependencies; unsafe internals and FFI in dependencies remain part of runtime risk.

## Performance, instrumentation, failure signatures
- Monomorphization, LLVM optimization, bounds checks, allocations, panic strategy and async state size affect code size/latency/hot paths.
- Instrumentation should include rustc -vV, cargo metadata/features/target, MIR/LLVM or cargo expand where needed, Miri/sanitizers, clippy and profiling for hot paths.
- Common failure signatures: only all-features build fails, proc-macro generated code stale/conflicting, future is !Send after a value crosses await, release build reveals unsafe UB, native linker misses symbol, panic=abort bypasses cleanup assumptions.

## Negative-space, guards, learning
- Negative-space check: type/borrow success is not proof unsafe invariants, external schemas, FFI layouts or async cancellation contracts are valid.
- False-positive guard: clippy lint may be intentionally inapplicable in low-level/benchmark/FFI context; justify with local invariant and test rather than broad allow.
- Learning motifs should preserve target/features/profile/compiler and unsafe/async boundary for recurring failures.


---

# RESOLVED PACK: compiler.zil-compiler-toolchain

## PACK DOCUMENT: CONCERNS.md

# zil-compiler-toolchain Depth-5 Compiler/Assembler Concerns

This implementation pack augments HTE-Code v2 Depth 5.
Compiler/assembler acceptance, diagnostics, generated artifacts, optimization,
linkage and runtime behavior must remain separate evidence tiers.

## High-signal implementation mechanics

- Identity/version: ZIL compiler implementation/version, Z-machine target version and intermediate assembler/toolchain define accepted source and emitted story.
- Parser/grammar: FORM/MACRO/ROUTINE/OBJECT syntax, reader forms and compiler extensions need exact compiler scope.
- Binding/modules: INSERT/INCLUDE, globals, objects, properties, routines and vocabulary/grammar tables resolve across source files.
- Type semantics: atoms/fixnums/strings/lists/forms and compiler-time vs runtime values must not be conflated.
- Numeric limits: Z-machine word width, object/property/table limits, packed addresses and branch/store encodings depend on target version.
- Memory/lifetime: compiler allocates dynamic/static/high memory tables whose region/size constraints survive into VM runtime.
- Errors/recovery: ZIL parse/macro errors, intermediate assembly/link errors and interpreter/runtime errors are different phases.
- Concurrency: classic Z-machine execution is single-threaded, but async host I/O/timers/interpreter extensions are separate runtime surfaces.
- Serialization/artifact: intermediate ZAP, symbol/map output and final story header/tables/opcodes are the real compiled contract.
- Security: generated stories should not trust interpreter extensions or external files without explicit bounds/format checks.
- ABI/interop: compiler output must obey Z-machine opcode/call/stack/table formats and interpreter-visible header flags.
- Platform: target Z-machine version/interpreter capability controls text/window/sound/input and opcode availability.
- Libraries: compiler/runtime libraries/macros can allocate globals/properties or generate hidden control flow.
- Performance: object/property lookup, parser tables and generated routine size matter under constrained VM memory/CPU.
- Testing: compile from clean source, inspect intermediate/disassembly and run scripted transcripts on reference/multiple interpreters where feasible.
- Instrumentation: compiler listings/maps, ZAP, story header/disassembly and interpreter trace connect source to VM behavior.
- Failure signatures: table/address overflow means target memory pressure; unknown opcode/version mismatch means wrong target; parser vocabulary failures often grammar/table generation.
- Undefined/implementation-defined: compiler extensions and interpreter quirks must be named rather than treated as ZIL/Z-machine law.
- Migration: compiler or target-version change can alter packed addresses, tables and generated opcode choices; compare disassembly/story behavior.
- Negative-space: successful ZIL compilation does not prove final story links, boots, parser routes reach the intended action or save/restore behavior remains valid.
- False-positive guard: large generated tables or unusual macro expansion can be deliberate for parser/data compression tradeoffs; inspect target limits before optimizing.
- Learning motif: retain compiler/version/interpreter-specific table, opcode and macro failure motifs with intermediate artifacts.



## PACK DOCUMENT: DEPTH5.md

# HTE-Code Compiler Pack: zil-compiler-toolchain

**Baseline:** HTE-Code v2 Depth 5
**Role:** compiler-specific augmentation; language packs remain separate and additive.
**Maturity:** seeded

## Signature concern catalog

### compiler-version

**Mechanism:** ZILF/other ZIL compilers differ in accepted language/extensions and generated Z-machine details.

**Detection:** record compiler/version/flags.

**Adversarial edge:** same source under supported compiler versions.

**Qualification:** compile transcript + story output.

### zil-zap

**Mechanism:** ZIL->ZAP/assembly->story is multi-stage; failures can occur after high-level compile.

**Detection:** retain intermediate artifacts and maps.

**Adversarial edge:** symbol/address overflow after expansion.

**Qualification:** stage-by-stage compile/disassembly.

### target-version

**Mechanism:** Z-machine target version controls emitted opcodes, tables and limits.

**Detection:** record target setting.

**Adversarial edge:** minimum/alternate story version.

**Qualification:** interpreter matrix.

## Depth-5 rules

- Resolve exact version, target, flags, feature switches and generated/intermediate artifacts before strong implementation-specific claims.
- Separate source-language legality from compiler acceptance, emitted artifact semantics and runtime behavior.
- Compare clean and incremental paths where caches/generation exist.
- Treat warnings, optimizations, link/load stages and generated outputs as evidence surfaces.
- Downgrade confidence when the exact implementation cannot be identified.


## PACK DOCUMENT: FULL-COVERAGE.md

# Full Coverage Addendum
- **Libraries/ecosystem:** ZIL compiler projects depend on standard macro libraries, compiler support files, ZAP/Z-machine assembler stages, interpreter test tools and story-format utilities. Version those dependencies with the compiler because generated story layout/behavior can change through them.


---

# RESOLVED PACK: runtime.cpython

## PACK DOCUMENT: CONCERNS.md

# cpython Depth-5 Runtime Concerns

This pack augments the complete HTE-Code v2 Depth-5 baseline. Version, target, flags, host, and adjacent packs remain part of the proof.

## High-signal failure mechanics
- CPython version is a semantic and ABI input; bytecode, stdlib, parser, GC and C-API behavior evolve across releases.
- Reference counting gives prompt destruction in many ordinary paths, but cyclic GC and interpreter shutdown make destructor timing non-universal.
- __del__ and weakref callbacks can participate in cycles, resurrection or shutdown-order hazards; explicit resource management remains stronger evidence.
- The GIL serializes much Python bytecode in traditional CPython but does not make application invariants atomic and C extensions may release it.
- Thread scheduling points and implementation changes mean race absence cannot be inferred from one observed run.
- C-extension ABI, limited API/abi3, wheel tags and architecture must match the interpreter actually loading native modules.
- sys.path, site initialization, .pth files, editable installs, virtual environments and working directory determine import identity.
- Hash randomization changes hash-dependent ordering across processes; persisted or protocol-visible behavior must not rely on hash().
- Signals are generally handled on the main Python thread at interpreter checkpoints, not asynchronously inside arbitrary bytecode.
- Recursion limits, stack usage and C recursion differ from ordinary heap exhaustion.
- -O/-OO, __debug__, PYTHON environment settings and UTF-8/locale modes can change behavior.
- subprocess/fork interactions with threads, locks and extension state are especially hazardous on POSIX; Windows uses different process creation.
- tracemalloc, faulthandler, gc diagnostics, profiling and audit hooks reveal different classes of runtime evidence.
- Free-threaded or alternate interpreter modes must be treated as separately versioned runtime behavior when actually used.
- Qualification captures python executable path, version/build, venv, installed distributions, native wheels and environment variables.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Runtime Pack: cpython

**Baseline:** HTE-Code v2 Depth 5
**Role:** runtime-specific augmentation; language packs remain separate and additive.
**Maturity:** seeded

## Signature concern catalog

### gil

**Mechanism:** The GIL serializes Python bytecode in CPython but does not make compound logical operations or C extensions universally race-free.

**Detection:** trace threads, releases and shared state.

**Adversarial edge:** I/O/C-extension release and check-then-act.

**Qualification:** stress/locking assertions.

### ref-gc

**Mechanism:** Reference counting gives prompt destruction usually, while cycles/generators/finalizers complicate cleanup.

**Detection:** trace cycles, __del__, context managers.

**Adversarial edge:** cycle holding resource, interpreter shutdown.

**Qualification:** gc/leak/resource tests.

### version-bytecode

**Mechanism:** CPython version changes bytecode, stdlib and interpreter internals; implementation tricks are not Python-language guarantees.

**Detection:** record exact Python version.

**Adversarial edge:** supported min/max versions.

**Qualification:** tox/nox or interpreter matrix.

## Depth-5 rules

- Resolve exact version, target, flags, feature switches and generated/intermediate artifacts before strong implementation-specific claims.
- Separate source-language legality from compiler acceptance, emitted artifact semantics and runtime behavior.
- Compare clean and incremental paths where caches/generation exist.
- Treat warnings, optimizations, link/load stages and generated outputs as evidence surfaces.
- Downgrade confidence when the exact implementation cannot be identified.


## PACK DOCUMENT: GAPS.md

# CPython Runtime Depth-5 Gap Closure

## Dispatch, numerics, and libraries
- CPython object dispatch runs through slots, descriptors, MRO, vectorcall and C-extension hooks. Python-language semantics do not guarantee the same micro-behavior on PyPy or alternate interpreters.
- int is arbitrary precision but C-extension boundaries, array/numpy/native APIs, struct packing, ctypes, timestamps, file sizes, and protocol fields reintroduce fixed numeric width, signedness, overflow, NaN, and precision constraints.
- Standard-library behavior is versioned runtime surface: asyncio, importlib, pathlib, subprocess, ssl, multiprocessing, sqlite3 and zoneinfo can change across Python releases and OS builds.

## Failure signatures and implementation-defined edges
- Common production symptoms: interpreter shutdown triggers callbacks against torn-down globals, extension module imports fail only on a particular ABI tag, multiprocessing hangs under spawn because code assumed fork, event loop reports 'Task was destroyed but it is pending', and C-extension crashes bypass Python exceptions.
- CPython reference counting creates prompt destruction in many cases but cycles, finalizers, generators, asynchronous tasks, and interpreter shutdown make timing non-guaranteed.
- Hash seed, filesystem encoding, locale coercion, malloc implementation, thread scheduling, and extension behavior are implementation/platform-defined inputs.

## Migration, negative-space, false positives, learning
- Migration between CPython minors must test bytecode-sensitive tooling, C-extension wheels, deprecated stdlib APIs, asyncio behavior, import machinery, typing/runtime introspection and packaging tags.
- Negative-space check: importing a module is not proof all optional native libraries, codecs, backends, entry points, or lazy imports required by later paths are available.
- False-positive guard: refcount-sensitive tests that assume immediate __del__ timing may pass on CPython and fail legitimately elsewhere; distinguish language contract from CPython-specific contract.
- Learning motifs should retain interpreter/version/OS/ABI-tag context for recurring import, shutdown, spawn/fork, SSL and extension crashes.


---

# RESOLVED PACK: runtime.native

## PACK DOCUMENT: CONCERNS.md

# native Depth-5 Runtime Concerns

This pack augments the complete HTE-Code v2 Depth-5 baseline. Version, target, flags, host, and adjacent packs remain part of the proof.

## High-signal failure mechanics
- Native execution inherits OS ABI, CPU ISA/features, loader, C/C++ runtime, dynamic libraries, allocator and signal/exception model.
- Build-machine success does not prove target-machine instruction support or library availability.
- Debuggers/sanitizers can alter timing/layout; release behavior needs its own run evidence.
- Dynamic loader search order and side-by-side libraries can execute a different dependency than inspection assumes.
- Process architecture (x86/x64/ARM), calling conventions, stack alignment and object ABI must match every binary boundary.
- ASLR/DEP/CFG/hardening, page permissions and code signing can change behavior of low-level techniques.
- Locale/timezone/encoding/filesystem and environment remain runtime inputs.
- Qualification captures executable identity, dependent-library resolution, target CPU/OS and representative real execution.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Runtime Pack: native

**Baseline:** HTE-Code v2 Depth 5
**Role:** runtime-specific augmentation; language packs remain separate and additive.
**Maturity:** seeded

## Signature concern catalog

### process-memory

**Mechanism:** Native execution exposes OS virtual memory, signals/SEH, stack/heap allocator and ABI directly.

**Detection:** map allocation, mappings, exceptions/signals.

**Adversarial edge:** OOM, guard page, stack exhaustion.

**Qualification:** sanitizers/debugger/fault injection.

### dynamic-loader

**Mechanism:** DLL/SO search path, symbol versioning and initialization order can load wrong binaries.

**Detection:** record resolved module paths/symbols.

**Adversarial edge:** duplicate library/path precedence.

**Qualification:** runtime module provenance.

### cpu

**Mechanism:** ISA/features/alignment/cache/memory model depend on target architecture.

**Detection:** record target and feature dispatch.

**Adversarial edge:** unsupported instruction, misalignment, weak ordering.

**Qualification:** target hardware/emulator test.

## Depth-5 rules

- Resolve exact version, target, flags, feature switches and generated/intermediate artifacts before strong implementation-specific claims.
- Separate source-language legality from compiler acceptance, emitted artifact semantics and runtime behavior.
- Compare clean and incremental paths where caches/generation exist.
- Treat warnings, optimizations, link/load stages and generated outputs as evidence surfaces.
- Downgrade confidence when the exact implementation cannot be identified.


## PACK DOCUMENT: GAPS.md

# Native Runtime Depth-5 Gap Closure

## Syntax boundary, concurrency, serialization
- Source syntax no longer matters once execution reaches machine code; debugging must map addresses back through symbols, optimizations, inlining and generated code without assuming source-line order.
- Native concurrency is governed by language memory model, OS scheduler, atomics, synchronization primitives, signals/APCs/interrupts and library contracts.
- Files, sockets, shared memory, pipes, structs, ioctl/device buffers and process argv/environment are serialization/representation boundaries even when they look like raw bytes.

## Failure signatures, migration, negative-space, learning
- Common production symptoms: access violation/segfault at a later use than the corrupting write, heap corruption reported during unrelated free, deadlock only under load, loader failure due to missing symbol/DLL/SO, stack corruption on return, data race disappearing under debugger, and release-only optimizer exposure.
- Runtime/OS/loader/allocator/CPU behavior is implementation-defined around areas the source language leaves unspecified or undefined.
- Migration across architecture, compiler runtime, libc/CRT, OS, allocator, instruction set or hardening flags requires ABI and performance requalification.
- Negative-space check: successful link/load is not proof each symbol path, optional CPU feature, lazy-loaded module or error path is valid.
- False-positive guard: sanitizer/debugger reports can originate in third-party code or intentional low-level patterns, but suppression requires a narrow valid-context proof and regression fixture.
- Learning motifs should preserve crash address/symbolized stack, module versions, allocator/sanitizer, architecture and concurrency/load context.


---

# RESOLVED PACK: runtime.posix-shell-runtime

## PACK DOCUMENT: CONCERNS.md

# posix-shell-runtime Depth-5 Runtime Concerns

This runtime pack augments the HTE-Code v2 Depth-5 baseline.
Runtime behavior must be separated from source-language and compiler facts.

## High-signal runtime mechanics

- Identity/version: /bin/sh may be dash, bash, ash, ksh or another implementation; POSIX mode, shell version and invoked name matter.
- Parser: tokenization, quote removal, expansions, redirections, here-documents and command substitution occur in ordered phases; syntax-looking text can become data or vice versa.
- Binding/modules: PATH lookup, functions, aliases where supported, built-ins and sourced files determine command identity and environment.
- Type semantics: shell variables are strings; positional parameters and arrays are implementation extensions with quoting-sensitive cardinality.
- Numeric limits: arithmetic expansion uses implementation integer widths; test overflow, leading-zero/base interpretation and exit-code range.
- Lifetime/state: subshells, pipelines and command substitutions clone process state; cwd/variables/traps changed in a child do not necessarily persist.
- Errors/recovery: errexit, ERR traps, pipeline status, command-not-found, signal termination and explicit return/exit have context-dependent propagation.
- Concurrency: pipelines, background jobs, wait and signal traps create process graphs with races around temp files and cleanup.
- Serialization/argv: unquoted expansion performs word splitting/globbing; NUL cannot be represented in shell strings; filenames may contain newlines.
- Security: eval, sh -c, unsafe temp files, unquoted data, leading-dash filenames and PATH poisoning are common injection/authority defects.
- ABI/interop: native utilities, Python/PowerShell/SSH and container entrypoints have independent argv/locale/exit contracts.
- Platform: GNU/BSD utility flags, filesystem case/permissions, shebang resolution and locale differ across Unix-like systems.
- Libraries/ecosystem: sed/awk/grep/find/xargs behavior and extensions must be scoped to the target implementation.
- Performance: process-per-record loops and command substitutions can dominate runtime; bulk/native-tool paths may be orders faster.
- Testing: run the declared shell explicitly, with unusual filenames, empty inputs, signals and clean environments rather than only interactive bash.
- Instrumentation: set -x with secret-safe handling, shellcheck where applicable, strace/process inspection and argv-capture fixtures provide complementary evidence.
- Failure signatures: 'bad substitution' often signals wrong shell/dialect; 126 permission/not executable, 127 command not found, 128+N often signal termination.
- Undefined/implementation-defined: behavior outside POSIX or around implementation extensions must be tagged to the exact shell/tool version.
- Migration: bash-to-sh, GNU-to-BSD, container base-image and locale changes need explicit compatibility checks.
- Negative-space: a command present in an interactive login shell does not prove it resolves in CI/service/container PATH.
- False-positive guard: intentional glob expansion or word splitting can be valid when explicitly constrained; prove data cardinality before flagging every unquoted expansion.
- Learning motif: retain shell/tool/platform-specific parse and exit fingerprints only with reproducing fixtures.



## PACK DOCUMENT: DEPTH5.md

# HTE-Code Runtime Pack: posix-shell-runtime

**Baseline:** HTE-Code v2 Depth 5
**Role:** runtime-specific augmentation; language packs remain separate and additive.
**Maturity:** seeded

## Signature concern catalog

### shell

**Mechanism:** sh may be dash/bash/busybox/etc.; shell implementation and utility set alter extensions and error behavior.

**Detection:** record executable/version.

**Adversarial edge:** dash/bash/busybox.

**Qualification:** target shell matrix.

## Depth-5 rules

- Resolve exact version, target, flags, feature switches and generated/intermediate artifacts before strong implementation-specific claims.
- Separate source-language legality from compiler acceptance, emitted artifact semantics and runtime behavior.
- Compare clean and incremental paths where caches/generation exist.
- Treat warnings, optimizations, link/load stages and generated outputs as evidence surfaces.
- Downgrade confidence when the exact implementation cannot be identified.


---

# RESOLVED PACK: runtime.z-machine

## PACK DOCUMENT: CONCERNS.md

# z-machine Depth-5 Runtime Concerns

This pack augments the complete HTE-Code v2 Depth-5 baseline. Version, target, flags, host, and adjacent packs remain part of the proof.

## High-signal failure mechanics
- Z-machine standard version is a runtime contract governing opcode set, memory map, object model, text, screen, save and capability rules.
- Dynamic memory is writable while static/high memory have different semantics; patches/state must respect those regions.
- The evaluation stack, routine call frames, locals, globals, catch/throw and interrupt/input continuations define machine state.
- Interpreter capability/header flags negotiate color, sound, Unicode, timed input, graphics and other optional behavior.
- Screen model and windowing semantics vary substantially by Z-machine version and interpreter support.
- Input tokenization and dictionary behavior combine story data with interpreter-standard rules.
- Save/restore/restart/undo must restore the standard-defined state; extension tables and custom state need compatibility checks.
- Random opcode supports both entropy and deterministic seeding behavior; tests can exploit deterministic mode without assuming production randomness.
- Packed addresses and routine/string addressing depend on version and header offsets.
- Interpreter quirks can hide story bugs or reject undefined behavior differently; one interpreter is not universal proof.
- Story length/checksum/header metadata can be validated independently from gameplay.
- Sound/timing/event behavior may depend on interpreter backend and host OS.
- Qualification uses story-file validation plus at least the intended interpreter/runtime and real gameplay journeys; cross-interpreter claims need a matrix.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Runtime Pack: z-machine

**Baseline:** HTE-Code v2 Depth 5
**Role:** runtime-specific augmentation; language packs remain separate and additive.
**Maturity:** seeded

## Signature concern catalog

### version

**Mechanism:** Story header version selects machine capabilities, opcode semantics, memory/address models and UI behavior.

**Detection:** parse header and interpreter support.

**Adversarial edge:** minimum/alternate version.

**Qualification:** reference interpreter matrix.

### interpreter

**Mechanism:** Interpreter bugs/extensions can differ; story correctness should target specification, not one emulator quirk.

**Detection:** run multiple interpreters where feasible.

**Adversarial edge:** timing/input/window edge.

**Qualification:** transcript comparison.

### save-state

**Mechanism:** Save/restore, undo, RNG and I/O streams alter execution state beyond ordinary globals.

**Detection:** trace external VM state.

**Adversarial edge:** save around parser/event transition.

**Qualification:** scripted save/restore tests.

## Depth-5 rules

- Resolve exact version, target, flags, feature switches and generated/intermediate artifacts before strong implementation-specific claims.
- Separate source-language legality from compiler acceptance, emitted artifact semantics and runtime behavior.
- Compare clean and incremental paths where caches/generation exist.
- Treat warnings, optimizations, link/load stages and generated outputs as evidence surfaces.
- Downgrade confidence when the exact implementation cannot be identified.


## PACK DOCUMENT: GAPS.md

# Z-machine Runtime Depth-5 Gap Closure

- **Binding/modules:** story header tables, dictionary, object/property tables, abbreviation tables and routine/string packed addresses bind compiled content into VM-visible modules/regions.
- **Types/dispatch:** opcode form, operand types, variable/global/local/stack destinations and version-specific object/property widths determine runtime dispatch.
- **Numerics:** 16-bit signed/unsigned arithmetic, branch offsets, packed addresses, object/property limits and RNG values require explicit width/sign semantics.
- **Concurrency:** timed input/interrupt routines are asynchronous relative to ordinary command processing; re-entry and global/stack mutation need qualification.
- **Serialization:** story files, save files, undo state, transcript/output streams and screen/window state are persistent/wire-like runtime representations.
- **Libraries/ecosystem:** interpreters, Quetzal save support, UI frontends and test harnesses are ecosystem implementations around the VM specification.
- **Performance:** object/property/dictionary searches, screen output and interpreter implementation can affect responsiveness on constrained or browser hosts.
- **Failure signatures:** illegal opcode/version mismatch, stack under/overflow, packed address jumps wrong routine, object tree corrupt, save restores inconsistent globals, behavior differs across interpreters.
- **Negative-space:** story boot success is not proof every parser action, save path, timed input, window operation or late-game table boundary is valid.
- **False-positive guard:** interpreter UI/layout difference permitted by spec is not automatically a story defect.
- **Learning:** preserve story version/interpreter plus transcript/save/state signature for recurring VM motifs.


---

# RESOLVED PACK: toolchain.cargo

## PACK DOCUMENT: CONCERNS.md

# cargo Depth-5 Toolchain Concerns

This pack augments the HTE-Code v2 Depth-5 baseline.
Framework/toolchain/format behavior is its own evidence surface and must not be
collapsed into the host language, compiler or runtime.

## High-signal mechanics

- Identity/version: Cargo/rustc version, resolver, workspace, lockfile, target triple, profile and feature set define the build graph.
- Parser/model: Cargo.toml tables, target-specific deps, workspace inheritance and feature expressions are interpreted before rustc sees source.
- Binding/modules: crate graph, renamed dependencies, path/git/patch overrides and workspace members determine which package code binds.
- Type/version semantics: semver requirements and feature unification choose concrete crate APIs/configurations; duplicate major versions create distinct types.
- Evaluation/control: build scripts and proc macros execute on host during build and emit cfg/env/link directives that alter downstream compilation.
- Numeric/resource limits: jobs, codegen units, profile optimization/overflow/panic settings and target pointer widths change compile/runtime behavior.
- Memory/lifetime: target, incremental and generated dirs plus build-script outputs persist; stale undeclared inputs can survive.
- Errors/recovery: resolution, build-script/proc-macro, compile, link, test and runtime failures are different phases.
- Concurrency: parallel crate builds/build scripts can race shared undeclared files; application concurrency remains a Rust/runtime concern.
- Serialization/artifact: Cargo.lock, metadata, generated code, library metadata, binary and package contents are provenance contracts.
- Security: build scripts/proc macros execute dependency code; registry/git sources, credentials and cargo config are supply-chain boundaries.
- ABI/interop: native crates, linker args and C/C++ build helpers must match target ABI/toolchain.
- Libraries/ecosystem: default features and transitive build dependencies can bring substantial behavior not visible at call sites.
- Performance: incremental/cache/network and codegen/LTO settings separate build performance from produced-program performance.
- Instrumentation: cargo metadata, tree with features, build timings and verbose rustc/link commands expose actual graph/config.
- Failure signatures: version selection failure is resolver; linker errors often native/feature/target; duplicate-type mismatch often multiple crate versions.
- Undefined/build-defined: path/git overrides, local cargo config and unpinned toolchain are not portable project truth.
- Migration: resolver edition, Cargo/rustc and dependency upgrades need feature graph, MSRV, lock and target build qualification.
- Negative-space: cargo check success does not prove build scripts/link, tests, packaging, target execution or all feature combinations.
- False-positive guard: multiple versions of a crate can be valid semver isolation; require type/size/security impact evidence before forcing dedupe.
- Learning motif: retain feature/target/build-script/native-link failure motifs with metadata/tree/toolchain evidence.



## PACK DOCUMENT: DEPTH5.md

# HTE-Code Toolchain Pack: cargo

**Baseline:** HTE-Code v2 Depth 5
**Role:** toolchain-specific augmentation; all other detected packs remain additive.
**Maturity:** seeded

## Signature concern catalog

### features

**Mechanism:** Features are additive across dependency graph; default/no-default combinations can compile different code.

**Detection:** cargo tree -e features.

**Adversarial edge:** minimal/all feature sets.

**Qualification:** feature matrix check/test.

### build-script

**Mechanism:** build.rs, proc macros and env/files create hidden build inputs.

**Detection:** inspect rerun-if directives/generated outputs.

**Adversarial edge:** clean/incremental/env change.

**Qualification:** clean reproducibility.

### lock-target

**Mechanism:** Cargo.lock, target triples and cfg affect exact crates/native deps.

**Detection:** record lock/toolchain/target.

**Adversarial edge:** cross target, resolver change.

**Qualification:** cargo metadata + target build.

## Depth-5 rules

- Resolve exact version/configuration/consumer before universalizing behavior.
- Separate declaration/configuration/loading from actual execution and observable effect.
- Run negative-space checks for configured-but-unused, loaded-but-unconsumed and tested-but-unexercised paths.
- Preserve exact evidence tier for build, static, integration and runtime claims.
- Add repo-learned failure motifs back into this pack only when they generalize beyond one repository.


---

# RESOLVED PACK: toolchain.github-actions

## PACK DOCUMENT: CONCERNS.md

# github-actions Depth-5 Toolchain Concerns

This pack augments the complete HTE-Code v2 Depth-5 baseline. It must be composed with the actual language, compiler/runtime, platform and repo authority.

## High-signal failure mechanics
- Workflow event, branch/path filters and permissions determine whether a job ever runs; a green missing job is not evidence.
- Matrix include/exclude/fail-fast can leave platform/version combinations unexecuted.
- Expression contexts have distinct trust/availability; empty/null/string coercion can make conditions skip intended steps.
- job/step conditions plus needs/result semantics can suppress cleanup or qualification after earlier skips/failures.
- Hosted runner images change over time; tool versions not explicitly pinned are moving dependencies.
- Actions referenced by tags/branches can move; commit-SHA pinning provides stronger provenance where required.
- Cache keys/restore keys can restore stale or cross-configuration artifacts and make CI differ from clean builds.
- Artifacts preserve only uploaded paths; generated evidence that is not uploaded disappears after the run.
- Secrets/permissions differ for fork PRs, Dependabot and reusable workflows, which can turn real tests into skips.
- Shell defaults differ by OS and run block; quoting/path/env behavior must match the selected shell.
- Concurrency/cancellation can abort prior runs, leaving incomplete evidence rather than a product failure.
- Qualification inspects step execution, exact head SHA and logs/artifacts, not only top-level workflow conclusion.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Toolchain Pack: github-actions

**Baseline:** HTE-Code v2 Depth 5
**Role:** toolchain-specific augmentation; all other detected packs remain additive.
**Maturity:** seeded

## Signature concern catalog

### trigger

**Mechanism:** Event type, filters, permissions, concurrency and fork security determine whether jobs run and what authority they have.

**Detection:** inspect workflow/event/permissions.

**Adversarial edge:** PR from fork, path filter, cancelled concurrency.

**Qualification:** workflow run evidence with executed steps.

### expression

**Mechanism:** YAML/expression contexts, secrets, outputs and matrix expansion can resolve differently than shell intuition.

**Detection:** inspect evaluated contexts without leaking secrets.

**Adversarial edge:** empty output, matrix include/exclude.

**Qualification:** action logs + test workflow where safe.

### runner

**Mechanism:** Runner OS/image/tool cache differs from local machine and changes paths/tool versions/services.

**Detection:** record runner image and setup actions.

**Adversarial edge:** cold cache, windows/linux.

**Qualification:** CI artifact/log evidence.

## Depth-5 rules

- Resolve exact version/configuration/consumer before universalizing behavior.
- Separate declaration/configuration/loading from actual execution and observable effect.
- Run negative-space checks for configured-but-unused, loaded-but-unconsumed and tested-but-unexercised paths.
- Preserve exact evidence tier for build, static, integration and runtime claims.
- Add repo-learned failure motifs back into this pack only when they generalize beyond one repository.


## PACK DOCUMENT: FULL-COVERAGE.md

# Full Coverage Addendum
- **Libraries/ecosystem:** every uses: action is executable third-party/first-party library code with its own runtime and transitive dependencies. Pin/qualify the action version or SHA and include reusable workflows/composite actions in the dependency graph.


## PACK DOCUMENT: GAPS.md

# GitHub Actions Depth-5 Gap Closure

## Syntax, lifetime, and serialization
- Workflow YAML has two interpreters: YAML parsing and Actions expression evaluation. Quoting, booleans, null/empty values, matrix objects, and [object Object] interpolation must be qualified at both layers.
- Job containers, services, runners, caches, artifacts, outputs, and temporary credentials each have distinct lifetime and cleanup semantics.
- Step/job outputs cross a serialized string boundary through environment/output files. Newlines, delimiters, size limits, JSON encoding, and secret masking can corrupt values.

## Libraries, performance, instrumentation
- Third-party actions are executable dependencies with their own runtime, transitive packages, permissions, deprecations, and supply-chain risk.
- Cache restore/save, dependency installation, checkout depth, artifact compression, matrices, and large test suites are performance/latency surfaces that can change timeout behavior.
- Instrumentation should capture event name, workflow/job/step IDs, runner image, exact head SHA, action SHAs, cache hit state, matrix values, skipped conditions, and uploaded evidence paths.

## Production signatures and migration
- Common CI failure signatures: required check stays pending because path filters skip the workflow; job is green but test step skipped; artifact missing because upload step condition was false; fork PR lacks secret/permission; matrix leg cancelled by fail-fast; cached generated output masks missing build step.
- Hosted-runner image, Node action runtime, deprecated commands, permissions defaults, and action major versions are migration surfaces.
- Undefined/implementation-dependent edges include runner image contents and service timing; do not treat incidental preinstalled tools as declared dependencies.
- False-positive guard: CI-only network/transient service failure must be distinguished from deterministic product failure, while repeated 'rerun until green' is not qualification.
- Negative-space check: top-level workflow success is not proof every required job/step/test executed on the exact head.
- Learning motifs should track recurrent skipped-job, stale-cache, missing-artifact, runner-image, and permission failures by workflow.


---

# RESOLVED PACK: toolchain.make

## PACK DOCUMENT: CONCERNS.md

# make Depth-5 Toolchain Concerns

This pack augments the complete HTE-Code v2 Depth-5 baseline. It must be composed with the actual language, compiler/runtime, platform and repo authority.

## High-signal failure mechanics
- Make tracks timestamps and declared dependencies, not semantic source relationships; missing prerequisites create stale successful builds.
- Recipe lines execute in shells with implementation/configuration-specific behavior; each line may run in a separate shell.
- Tabs, variable expansion flavors, recursive make, automatic variables and secondary expansion create parse/execution-order hazards.
- Phony targets must be declared or files with matching names can suppress recipes.
- Parallel make exposes undeclared dependencies and recipes that mutate shared outputs.
- Pattern/suffix rules can select unintended implicit build paths when explicit rules are incomplete.
- Environment and command-line variable precedence can override makefile defaults unexpectedly.
- Recursive make can lose global dependency knowledge and jobserver behavior if invoked incorrectly.
- Generated dependency files must be included and updated reliably for header changes.
- Filesystem timestamp resolution/clock skew can invalidate incremental assumptions.
- Qualification compares clean and incremental builds, plus parallel execution when supported.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Toolchain Pack: make

**Baseline:** HTE-Code v2 Depth 5
**Role:** toolchain-specific augmentation; all other detected packs remain additive.
**Maturity:** seeded

## Signature concern catalog

### timestamp

**Mechanism:** Make correctness depends on dependency graph and timestamps; undeclared inputs cause stale success.

**Detection:** inspect prerequisites and touch/change inputs.

**Adversarial edge:** clock skew, deleted generated file.

**Qualification:** clean vs incremental equivalence.

### shell

**Mechanism:** Each recipe line/shell mode, quoting and environment propagation can differ from interactive shell.

**Detection:** inspect SHELL/.ONESHELL/escaping.

**Adversarial edge:** spaces/$/parallel jobs.

**Qualification:** argv/output fixture.

### parallel

**Mechanism:** -j exposes missing dependencies and shared-output races.

**Detection:** run serial vs high parallelism.

**Adversarial edge:** clean parallel build.

**Qualification:** artifact equivalence.

## Depth-5 rules

- Resolve exact version/configuration/consumer before universalizing behavior.
- Separate declaration/configuration/loading from actual execution and observable effect.
- Run negative-space checks for configured-but-unused, loaded-but-unconsumed and tested-but-unexercised paths.
- Preserve exact evidence tier for build, static, integration and runtime claims.
- Add repo-learned failure motifs back into this pack only when they generalize beyond one repository.


## PACK DOCUMENT: GAPS.md

# Make Toolchain Depth-5 Gap Closure

## Parser/types/lifetime/serialization
- Make has its own grammar: tabs/recipe prefixes, immediate vs deferred variable expansion, pattern rules, automatic variables, secondary expansion, include/remake behavior and function evaluation.
- Variables are strings whose whitespace and recursive/simple expansion flavor matter; numeric work is normally delegated to shell/tools.
- Generated files, depfiles, stamp files and intermediate targets have lifecycle semantics controlled by prerequisites and special targets.
- Command lines, environment and generated depfiles are serialization boundaries between Make, shell, compiler and helper tools.

## Libraries, performance, instrumentation, signatures
- Shell/utilities/compiler invoked by recipes are external ecosystem dependencies and may differ by platform.
- Parallel -j scheduling and incorrect dependency graphs cause nondeterministic race failures; over-serialization destroys performance.
- Instrumentation should use make -n/-p/--trace/debug output, timestamps/hashes, actual recipe command lines and clean-vs-incremental comparison.
- Common production symptoms: source changed but target not rebuilt, parallel build races generated header, included depfile stale/missing, variable expands too early/late, path with spaces breaks recipe, default shell differs.

## Migration and guards
- GNU Make vs BSD/nmake and version-specific features are migration/compatibility surfaces.
- Undefined/environment-dependent behavior includes filesystem timestamp granularity/order and external shell/tool behavior.
- False-positive guard: always-run phony target is intentional when side effects cannot be expressed as timestamp dependency; don't 'optimize' without proving semantics.
- Negative-space check: rule exists in Makefile but may never be selected because a more specific/implicit rule wins.


---

# RESOLVED PACK: platform.posix-shell

## PACK DOCUMENT: CONCERNS.md

# posix-shell Depth-5 Platform Concerns

This pack augments the complete HTE-Code v2 Depth-5 baseline. It must be composed with the actual language, compiler/runtime, platform and repo authority.

## High-signal failure mechanics
- POSIX filesystem paths are case-sensitive by convention but actual mounted filesystems may differ; slash/root/symlink semantics differ from Windows.
- Permissions combine uid/gid/mode, umask, ACLs, capabilities and mount options; successful owner execution does not prove service/container execution.
- fork/exec, signals, process groups, sessions and controlling terminals define process lifecycle and cancellation behavior.
- File unlink/rename while open behaves differently from Windows and can hide portability defects.
- Environment and argv are byte-oriented at the OS boundary; locale determines text interpretation in many tools.
- /bin/sh may be dash, bash, ash or another implementation; scripts must not assume bash features without a matching shebang.
- PATH lookup and executable permission/shebang/interpreter availability jointly determine launch success.
- /proc, sysfs, inotify, epoll/kqueue and other OS facilities are not portable merely because a shell command exists.
- Resource limits, cgroups, OOM behavior and file descriptor limits can fail long-running services under load.
- Signal-safe cleanup and SIGPIPE semantics can terminate processes in ways tests that only use normal exit never cover.
- Qualification names OS/distro/kernel/filesystem/shell/user/limits and executes failure/interrupt paths on supported targets.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Platform Pack: posix-shell

**Baseline:** HTE-Code v2 Depth 5
**Role:** platform-specific augmentation; all other detected packs remain additive.
**Maturity:** seeded

## Signature concern catalog

### fs

**Mechanism:** Case sensitivity, executable bit, symlinks, atomic rename and open-file unlink semantics differ from Windows.

**Detection:** test target filesystem.

**Adversarial edge:** symlink/race/permission modes.

**Qualification:** target OS integration.

### signals

**Mechanism:** Signals, process groups, fork/exec and exit status conventions define shutdown/reaping behavior.

**Detection:** trace child ownership/signal handlers.

**Adversarial edge:** SIGTERM/SIGINT/SIGPIPE.

**Qualification:** process lifecycle tests.

## Depth-5 rules

- Resolve exact version/configuration/consumer before universalizing behavior.
- Separate declaration/configuration/loading from actual execution and observable effect.
- Run negative-space checks for configured-but-unused, loaded-but-unconsumed and tested-but-unexercised paths.
- Preserve exact evidence tier for build, static, integration and runtime claims.
- Add repo-learned failure motifs back into this pack only when they generalize beyond one repository.


## PACK DOCUMENT: GAPS.md

# POSIX Platform/Shell Depth-5 Gap Closure

## Grammar, scope, control flow, numerics
- 'POSIX shell' still requires exact shell identity and mode. dash, bash --posix, ash, ksh and zsh sh mode differ in extensions, diagnostics, startup files, builtins and edge behavior.
- Shell grammar makes newline, semicolon, pipelines, lists, subshells, functions, command substitutions and redirections part of control flow. A visually local edit can change parse grouping.
- Variables are untyped strings until arithmetic/test/utility contexts interpret them. Numeric parsing, leading signs, overflow, base syntax, and test operators vary by shell/utility.
- Subshells and pipelines create process/scope boundaries, so cd/export/variable updates may disappear when executed in a child.

## Serialization, libraries, and failure signatures
- argv, environment, stdin/stdout/stderr and files are serialization boundaries. Newlines, NUL impossibility, locale, glob expansion and encoding must be accounted for.
- External utilities are ecosystem dependencies. GNU/BSD/BusyBox variants differ in flags, regex engines, output and exit status.
- Common production symptoms: script passes in bash but /bin/sh is dash, filename with spaces/glob breaks a loop, pipeline hides first-stage failure, temp cleanup misses SIGTERM, CRLF breaks shebang, or sed/date/grep flags work only on GNU.

## Migration and guards
- Migration across Linux distributions, macOS, containers, BusyBox or shell versions requires utility/version qualification, not just syntax checks.
- Undefined/unspecified edges include utility extensions, locale collation, filesystem ordering and scheduling around signals/processes.
- False-positive guard: ShellCheck warning can be intentional when code is deliberately shell-specific; the guard is explicit shell/version plus a targeted test, not blanket suppression.
- Negative-space check: command existence in PATH is not proof the intended binary/version is the one executed.
- Learning motifs should record shell/OS/utility tuple for recurring quoting, pipeline, signal and portability failures.


---

# RESOLVED PACK: interop.python-process-shell

## PACK DOCUMENT: CONCERNS.md

# python-process-shell Depth-5 Interop Concerns

This pack augments the complete HTE-Code v2 Depth-5 baseline. It must be composed with the actual language, compiler/runtime, platform and repo authority.

## High-signal failure mechanics
- Python subprocess argv lists, shell command strings and shell-language parsing are distinct interfaces; do not concatenate them conceptually.
- shell=False preserves an argv-style boundary while shell=True adds a shell parser and its quoting/expansion semantics.
- Windows CreateProcess string-to-argv conversion differs from POSIX execve argv; target programs may implement their own parsing too.
- cwd, PATH, PATHEXT, environment, shebang/interpreter choice and shell profile can make a different executable/script run than expected.
- stdout/stderr are byte streams at the OS boundary; text mode adds encoding/newline/error handling.
- PIPE can deadlock when parent/child do not drain both directions; communicate or asynchronous streaming needs bounded ownership.
- timeout/cancel/parent exit does not automatically terminate child process trees; process-group/job semantics are platform-specific.
- Exit code, signal termination, shell status and textual error output are separate evidence channels.
- PowerShell/cmd/bash quoting and metacharacters must be handled according to the actual selected shell, not Python-string appearance.
- Interactive programs can change buffering/behavior when no TTY/console is attached.
- Temporary files and response files add filesystem lifetime/encoding/quoting rules.
- Qualification captures exact argv, executable resolution, cwd/env, shell identity, streams and descendant-process cleanup.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Interop Pack: python-process-shell

**Baseline:** HTE-Code v2 Depth 5
**Role:** interop-specific augmentation; all other detected packs remain additive.
**Maturity:** seeded

## Signature concern catalog

### argv

**Mechanism:** Python subprocess argument lists, shell=True, PowerShell/CMD/POSIX parsing and target program parsing are separate layers.

**Detection:** capture argv at callee; forbid accidental shell layer.

**Adversarial edge:** spaces/metacharacters/empty arg.

**Qualification:** argv fixture.

### exit-io

**Mechanism:** Exit code, stdout/stderr encoding/buffering and timeout/kill behavior must be handled separately.

**Detection:** trace communicate/run/Popen ownership.

**Adversarial edge:** large output/deadlock, timeout, nonzero with output.

**Qualification:** fixture subprocess matrix.

### environment

**Mechanism:** cwd, PATH, env inheritance and executable lookup can resolve a different tool/config than intended.

**Detection:** log resolved executable/cwd/env subset.

**Adversarial edge:** shim/global tool/venv mismatch.

**Qualification:** provenance assertion.

## Depth-5 rules

- Resolve exact version/configuration/consumer before universalizing behavior.
- Separate declaration/configuration/loading from actual execution and observable effect.
- Run negative-space checks for configured-but-unused, loaded-but-unconsumed and tested-but-unexercised paths.
- Preserve exact evidence tier for build, static, integration and runtime claims.
- Add repo-learned failure motifs back into this pack only when they generalize beyond one repository.


## PACK DOCUMENT: FULL-COVERAGE.md

# Full Coverage Addendum
- **Libraries/ecosystem:** wrappers such as subprocess/asyncio, psutil, click/typer, PowerShell modules and platform process libraries can change spawn, cancellation, quoting and tree-management behavior. Qualify the actual wrapper stack in addition to OS process semantics.


## PACK DOCUMENT: GAPS.md

# Python ↔ Process/Shell Interop Depth-5 Gap Closure

## Binding, control, serialization
- Executable resolution binds a command name through cwd, PATH, PATHEXT/shebang, shell aliases/wrappers and platform loader rules; use resolved absolute provenance when correctness matters.
- shell=False argv passing and shell=True command-string evaluation are different control-flow/security models. PowerShell, cmd.exe and POSIX shell each add their own parser.
- stdin/stdout/stderr are byte streams with encoding/framing conventions, not Python objects. JSON lines, CSV, ad-hoc text, binary protocols and locale-sensitive output need explicit schema.

## Libraries, performance and failure signatures
- subprocess, asyncio subprocess APIs, shell wrappers, psutil and process-supervision libraries have different cancellation, buffering and tree-kill behavior.
- Pipe buffer limits and child/parent read/write ordering can deadlock. Large output, line buffering and text transcoding affect throughput/latency.
- Common production symptoms: correct executable not found, wrong shim invoked, quoting splits one argument into several, child hangs because stderr pipe fills, timeout kills parent but leaves grandchildren, UTF-8 output decoded with legacy code page, or shell returns zero after inner command failed.

## Migration, implementation-defined edges, guards
- Cross-platform migration must test Windows CreateProcess/cmd/PowerShell quoting separately from POSIX exec/shell semantics.
- Exit status width/signals, shebang handling, process groups, console attachment and encoding are OS/runtime-defined boundaries.
- False-positive guard: non-empty stderr is not automatically failure and zero exit status is not automatically semantic success; use the called tool's contract.
- Negative-space check: process creation success is not proof the intended subcommand executed, consumed input, or produced valid output.
- Learning motifs should preserve exact executable path, argv, shell, cwd, environment and exit/output signature for recurring failures.


---

# RESOLVED PACK: interop.zil-zmachine

## PACK DOCUMENT: CONCERNS.md

# zil-zmachine Depth-5 Interop Concerns

This pack augments the complete HTE-Code v2 Depth-5 baseline. It must be composed with the actual language, compiler/runtime, platform and repo authority.

## High-signal failure mechanics
- ZIL source intent is mediated by compiler expansion, generated assembly/opcodes and Z-machine version constraints.
- Parser vocabulary/actions/objects in source must map to story-file dictionary/object/property tables correctly.
- Source routine/global/table names can be relocated/encoded; debug symbols/maps are needed before binary-address assumptions.
- Branch/routine growth can move generated addresses even when source behavior looks local.
- Target-version packed-address, property and object limits can turn source additions into global binary-layout failures.
- Save/restore/restart semantics operate on machine state, so source-level state initialization must be tested through interpreter transitions.
- ZSCII/Unicode/text compilation can make source strings and parser tokens differ from byte-oriented expectations.
- Compiler/story-builder validation and interpreter execution are separate qualification stages.
- Differential transcripts connect source-level parser intent to actual runtime behavior more strongly than static source inspection alone.
- Multiple interpreter behavior matters when portability is claimed; one emulator can carry compatibility quirks.
- Binary patching or generated assembly edits must not silently diverge from canonical ZIL source authority.
- Qualification traces a requested behavior source -> emitted story artifact -> real interpreter journey.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Interop Pack: zil-zmachine

**Baseline:** HTE-Code v2 Depth 5
**Role:** interop-specific augmentation; all other detected packs remain additive.
**Maturity:** seeded

## Signature concern catalog

### lowering

**Mechanism:** High-level ZIL objects/routines/grammar lower into compact Z-machine tables/opcodes with version constraints.

**Detection:** trace source symbol to map/ZAP/story.

**Adversarial edge:** macro expansion/address overflow.

**Qualification:** compiler intermediates + disassembly.

### runtime-state

**Mechanism:** Parser/object/global semantics interact with VM stacks, save/restore, RNG and interpreter I/O state.

**Detection:** model source and VM state together.

**Adversarial edge:** save during parser/action transition.

**Qualification:** scripted interpreter transcripts.

## Depth-5 rules

- Resolve exact version/configuration/consumer before universalizing behavior.
- Separate declaration/configuration/loading from actual execution and observable effect.
- Run negative-space checks for configured-but-unused, loaded-but-unconsumed and tested-but-unexercised paths.
- Preserve exact evidence tier for build, static, integration and runtime claims.
- Add repo-learned failure motifs back into this pack only when they generalize beyond one repository.


## PACK DOCUMENT: GAPS.md

# ZIL ↔ Z-machine Interop Depth-5 Gap Closure

- **Types/dispatch:** ZIL symbols/objects/properties/actions lower into version-constrained Z-machine tables, operands and routines; high-level apparent type/dispatch must be verified in generated ZAP/story structures.
- **Memory/lifetime:** dynamic/static/high memory regions, object/property tables, stacks and save/restore state constrain where generated data can live and mutate.
- **Concurrency:** Z-machine is generally single-threaded, but timers/interrupt routines/input callbacks create asynchronous re-entry relative to ordinary turn flow and must preserve VM state.
- **Serialization:** story files, dictionaries, object tables, packed routine/string addresses, save files and transcripts are binary representations with version-specific layout.
- **Libraries/ecosystem:** compiler, assembler, interpreter and testing harness are separate tools; one interpreter's extension/quirk is not the specification.
- **Failure signatures:** grammar entry points to wrong action, property/table overflow after content growth, packed address resolves wrong routine, save/restore loses expected state, code works in one interpreter only.
- **Undefined/implementation-defined:** interpreter UI/timing/extensions and compiler layout choices beyond the spec are tool scoped.
- **False-positive guard:** disassembly/layout difference is not itself a defect if generated story remains spec-valid and observable behavior is unchanged.


---

# RESOLVED PACK: format.json

## PACK DOCUMENT: CONCERNS.md

# json Depth-5 Format Concerns

This pack augments the complete HTE-Code v2 Depth-5 baseline. It must be composed with the actual language, compiler/runtime, platform and repo authority.

## High-signal failure mechanics
- JSON has numbers, strings, booleans, null, arrays and objects only; application enums/dates/bytes/big integers need explicit encoding contracts.
- Object member order should not carry semantics unless the surrounding protocol explicitly defines it.
- Duplicate object keys are not uniformly rejected/interpreted across parsers; producers should avoid them and validators may need to reject.
- Number precision/range differs across consumers, especially JavaScript vs 64-bit integers/decimal domains.
- Missing member, member present with null and default value are distinct compatibility states.
- Unknown-field policy determines forward compatibility; strict rejection and silent ignore solve different problems.
- Unicode escaping/normalization and unpaired surrogate handling vary among libraries.
- JSON text is not a schema; validation/versioning belongs to an explicit contract.
- Comments/trailing commas/NaN/Infinity are extensions in some parsers and invalid standard JSON.
- Canonicalization matters for signatures/hashes/diffs; ordinary serializers may reorder or format differently.
- Qualification round-trips boundary numeric/text/null/missing/unknown cases through every producer/consumer implementation.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Format Pack: json

**Baseline:** HTE-Code v2 Depth 5
**Role:** format-specific augmentation; all other detected packs remain additive.
**Maturity:** seeded

## Signature concern catalog

### number

**Mechanism:** JSON has one numeric syntax while consumers map to different integer/float widths and may lose precision.

**Detection:** inspect schema/consumer type.

**Adversarial edge:** large integer, exponent, -0.

**Qualification:** roundtrip with boundary values.

### shape

**Mechanism:** Missing vs null vs empty and unknown/duplicate properties have consumer-specific meaning.

**Detection:** define schema and strictness.

**Adversarial edge:** duplicate key, extra field, missing field.

**Qualification:** negative parse/validation tests.

### encoding

**Mechanism:** JSON text is Unicode but BOM/invalid escapes/control chars/normalization can hit parser differences.

**Detection:** fuzz parser boundary.

**Adversarial edge:** surrogate/escape/UTF-8 edge.

**Qualification:** cross-parser fixtures.

## Depth-5 rules

- Resolve exact version/configuration/consumer before universalizing behavior.
- Separate declaration/configuration/loading from actual execution and observable effect.
- Run negative-space checks for configured-but-unused, loaded-but-unconsumed and tested-but-unexercised paths.
- Preserve exact evidence tier for build, static, integration and runtime claims.
- Add repo-learned failure motifs back into this pack only when they generalize beyond one repository.


## PACK DOCUMENT: GAPS.md

# JSON Depth-5 Gap Closure

## Parser and representation semantics
- JSON syntax is small but parser policy is not: duplicate keys, BOM handling, comments/trailing commas, maximum depth, integer size, and invalid Unicode acceptance vary by library.
- Object member order is semantically insignificant in JSON itself even though downstream code may preserve or incorrectly depend on insertion order.
- Numbers have a grammar, not a universal numeric type. JavaScript Number, Python int/float, .NET numeric types, Rust serde targets, and database bindings differ on width, precision, overflow, NaN rejection, and exponent handling.
- Missing, null, empty string, zero, false, and empty collections are distinct representations. Schema/defaulting code must not silently collapse them.

## Memory, concurrency, and performance
- DOM-style parsing allocates the entire tree; streaming/SAX-style parsing changes lifetime and control flow. Large or attacker-controlled JSON can create memory pressure or deep-recursion failures.
- Shared mutable JSON DOM nodes are library-specific objects; concurrent mutation/iteration requires the host library's thread-safety guarantees, not assumptions from JSON itself.
- Serialization hot paths should measure allocation, encoding, and copy cost; pretty-printing and repeated parse/stringify cycles can dominate latency.

## Interop, libraries, and implementation-defined behavior
- JSON-to-object binding is schema/serializer behavior, not JSON behavior. Constructor selection, unknown fields, case sensitivity, enum conversion, polymorphism, dates, and reference handling are implementation-defined by the serializer.
- ABI/interop boundaries appear when JSON crosses JavaScript/native, RPC, process, database, or plugin boundaries; every side must agree on encoding and schema.
- Libraries may expose custom converters or coercion hooks that execute application code during serialization/deserialization.

## Failure signatures, migration, and guards
- Common production symptoms: large IDs rounded in JavaScript, duplicate-key data silently overwritten, enum/date format drift, casing changes breaking clients, and unknown fields disappearing during round-trip.
- Instrumentation should log schema/version and bounded parse diagnostics without dumping secrets or full private payloads.
- Migration must test old-reader/new-writer and new-reader/old-writer compatibility, preserving unknown fields where forward compatibility requires it.
- False-positive guard: textual key order, whitespace, and escaping differences are not semantic changes unless a consumer explicitly signs/compares raw bytes.
- Negative-space check: a field present in JSON is not proof any runtime path reads or enforces it.
- Learning motifs should capture recurrent coercion, precision, unknown-field, and schema-version failures.


---

# RESOLVED PACK: format.markdown

## PACK DOCUMENT: CONCERNS.md

# markdown Depth-5 Format Concerns

This pack augments the complete HTE-Code v2 Depth-5 baseline. It must be composed with the actual language, compiler/runtime, platform and repo authority.

## High-signal failure mechanics
- Markdown has competing dialects/extensions; CommonMark/GFM/front matter/wiki/task/math/MDX behavior must be scoped to the actual renderer.
- Blank lines, indentation and list continuation rules can change block structure unexpectedly.
- Code fences need language and delimiter lengths that safely contain embedded fence text.
- HTML-in-Markdown support and sanitization differ by renderer and trust boundary.
- Link/reference definitions can resolve far from use and duplicate labels have dialect-specific behavior.
- Autolinks, bare URLs, underscores and emphasis parsing produce renderer-dependent edge cases.
- Tables/task lists/strikethrough are extensions rather than universal core syntax.
- Relative links/images resolve against repository/site/render context, not the author's editor cwd.
- Front matter is another format layer whose delimiter/schema belongs to the site/toolchain.
- Generated documentation can be syntactically valid Markdown but semantically stale or falsely claim runtime evidence.
- Qualification renders with the actual documentation/site pipeline and verifies links, code blocks, headings and truth against implementation.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Format Pack: markdown

**Baseline:** HTE-Code v2 Depth 5
**Role:** format-specific augmentation; all other detected packs remain additive.
**Maturity:** seeded

## Signature concern catalog

### dialect

**Mechanism:** CommonMark/GFM/tool-specific extensions differ in tables, task lists, HTML and link parsing.

**Detection:** identify renderer.

**Adversarial edge:** nested list/fence/table edge.

**Qualification:** render fixture.

### code-fence

**Mechanism:** Fenced examples can become stale or syntactically invalid while document still renders.

**Detection:** extract and test executable snippets where claims depend on them.

**Adversarial edge:** versioned CLI/API example.

**Qualification:** doc-test.

### truth

**Mechanism:** Documentation is an evidence claim surface; aspirational prose must not be mistaken for implemented behavior.

**Detection:** cross-link strong claims to code/tests/runtime evidence.

**Adversarial edge:** feature described but absent.

**Qualification:** feature-truth audit.

## Depth-5 rules

- Resolve exact version/configuration/consumer before universalizing behavior.
- Separate declaration/configuration/loading from actual execution and observable effect.
- Run negative-space checks for configured-but-unused, loaded-but-unconsumed and tested-but-unexercised paths.
- Preserve exact evidence tier for build, static, integration and runtime claims.
- Add repo-learned failure motifs back into this pack only when they generalize beyond one repository.


## PACK DOCUMENT: FULL-COVERAGE.md

# Full Coverage Addendum
- **Undefined/implementation-defined behavior:** Markdown outside a fixed dialect is implementation-defined by the renderer and extension set. Even under CommonMark/GFM, HTML sanitization, heading-ID generation, syntax highlighting, link rewriting and plugin directives are hosting-tool behavior rather than universal Markdown semantics.


## PACK DOCUMENT: GAPS.md

# Markdown Depth-5 Gap Closure

## Parser, dialect, and control behavior
- Markdown has no single universal parser behavior. CommonMark, GFM, MDX, MkDocs, GitHub rendering, static-site generators, and custom renderers differ on HTML passthrough, tables, task lists, autolinks, heading IDs, footnotes, and extension syntax.
- Parsing is block-then-inline grammar, so indentation, blank lines, fence length, list nesting, and embedded HTML can change the token tree far from the apparent edit.
- Generated documentation pipelines may preprocess templates, includes, front matter, directives, or code fences before Markdown parsing. Source text is therefore not always the final document input.

## Types, representations, and persistence
- Front matter is a separate schema surface, typically YAML/TOML/JSON, with its own type coercion and migration behavior.
- Links, anchors, paths, Unicode normalization, and percent-encoding form a persisted representation contract across files, sites, and platforms.
- Numeric-looking content should not be treated as numeric data unless a consuming tool explicitly parses it; examples containing overflow, NaN, signed width, or precision claims need executable evidence outside Markdown.

## Runtime, ecosystem, and interoperability
- Embedded HTML, Mermaid, MathJax, JSX/MDX, shortcodes, and fenced executable snippets create ABI/interop-like boundaries with other parsers and runtimes.
- Renderer libraries and plugins are part of the behavior surface. A document valid in one ecosystem can fail or render differently after a dependency upgrade.
- Large generated tables, embedded data URIs, or huge fenced logs can create performance and memory pressure in editors, CI renderers, or static-site builds.

## Failure signatures and instrumentation
- Common production symptoms include broken heading links after rename, fences swallowing following sections, tables collapsing because of pipe escaping, list numbering reset by indentation, and docs that render locally but fail on the publishing renderer.
- Instrumentation should include the actual renderer/build command, link checker, snippet extraction tests, and rendered DOM/HTML inspection where layout or anchors matter.
- A false positive is a stylistic linter complaint that the target renderer intentionally accepts; guard by qualifying against the configured renderer and extension set.

## Migration, negative-space, and learning
- Migration between Markdown engines must diff rendered structure, anchors, code blocks, front matter, and embedded HTML rather than only source text.
- Negative-space check: a documented command, option, feature, or API is not implemented merely because the Markdown says it exists.
- Learning motifs should record recurring stale-command, stale-path, broken-anchor, and docs-vs-runtime mismatches so later repo audits target them first.


---

# RESOLVED PACK: format.yaml

## PACK DOCUMENT: CONCERNS.md

# yaml Depth-5 Format Concerns

This pack augments the complete HTE-Code v2 Depth-5 baseline. It must be composed with the actual language, compiler/runtime, platform and repo authority.

## High-signal failure mechanics
- YAML version/library/schema matter; scalar implicit typing can turn strings such as booleans, dates or numbers into other types.
- Indentation and sequence/map structure are syntax, while visually similar formatting can change ownership deeply.
- Anchors/aliases/merge keys create shared/reused structure and are not supported identically by all libraries.
- Duplicate keys may be accepted with last/first wins or rejected depending on parser.
- Multi-document streams require deliberate handling; reading only the first document can silently drop configuration.
- Block/folded scalar chomping changes exact newlines and therefore scripts/certificates/templates.
- Tags can request application-specific object construction and should be treated carefully for untrusted input.
- Comments are usually lost by ordinary parse/serialize round trips.
- YAML is a serialization syntax, not a validation schema; repo-specific shape/version rules remain separate.
- Qualification uses the exact parser version/schema and checks ambiguous scalar, duplicate-key, anchor and multiline cases.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Format Pack: yaml

**Baseline:** HTE-Code v2 Depth 5
**Role:** format-specific augmentation; all other detected packs remain additive.
**Maturity:** seeded

## Signature concern catalog

### typing

**Mechanism:** YAML versions/schema resolve scalars such as booleans/numbers/timestamps differently.

**Detection:** record parser/version/schema.

**Adversarial edge:** yes/no/on/off, leading zero, date-like.

**Qualification:** parse fixture to typed tree.

### anchors

**Mechanism:** Anchors/aliases/merge keys can duplicate/share structure and trigger parser limits.

**Detection:** inspect resolved graph.

**Adversarial edge:** alias bomb, merge override.

**Qualification:** bounded parser tests.

### indent

**Mechanism:** Whitespace, block scalars and multi-document streams can alter structure without obvious visual cues.

**Detection:** parse and canonicalize.

**Adversarial edge:** tabs/trailing/block chomping.

**Qualification:** AST diff.

## Depth-5 rules

- Resolve exact version/configuration/consumer before universalizing behavior.
- Separate declaration/configuration/loading from actual execution and observable effect.
- Run negative-space checks for configured-but-unused, loaded-but-unconsumed and tested-but-unexercised paths.
- Preserve exact evidence tier for build, static, integration and runtime claims.
- Add repo-learned failure motifs back into this pack only when they generalize beyond one repository.


## PACK DOCUMENT: GAPS.md

# YAML Depth-5 Gap Closure

## Binding, evaluation, and numerics
- YAML anchors, aliases, merge keys, tags, and schema resolution create reference-like binding and evaluation behavior beyond plain tree syntax.
- YAML 1.1 and 1.2 resolve booleans, nulls, integers, floats, sexagesimal/legacy forms, timestamps, and leading-zero values differently. Numeric width/precision is then determined again by the host parser.
- Duplicate keys, alias identity, custom tags, and merge precedence are parser-policy surfaces and can silently change the resulting object graph.

## Interop and instrumentation
- YAML is usually configuration input to another system. The consuming schema, defaults, environment expansion, template preprocessing, and command-line overrides are the real interop contract.
- Instrumentation should capture the parser/library/version, effective resolved configuration, and canonicalized data tree, not just the original text.
- Round-trip emitters may reorder keys, alter quoting, normalize scalars, or discard comments/anchors.

## Failure signatures and migration
- Common production symptoms: 'on/off/yes/no' becoming booleans unexpectedly, CI expressions treated as strings, anchors resolving differently after tool upgrades, duplicate keys accepted locally but rejected in CI, and indentation producing a valid but wrong tree.
- Migration between YAML parser versions or schemas must reparse representative fixtures and compare typed trees, not only diff text.
- Undefined/implementation-defined behavior includes duplicate-key handling, tag support, merge-key support, limits, and extension syntax.
- False-positive guard: a linter warning about an extension/tag is not necessarily a runtime error when the target consumer explicitly supports it.
- Negative-space check: a YAML setting being present does not prove the consuming tool reads it under the active profile/job/environment.
- Learning motifs should capture recurring key-coercion, indentation-valid-wrong-tree, alias, and consumer-precedence failures.


---

# RESOLVED PACK: format.toml

## PACK DOCUMENT: CONCERNS.md

# toml Depth-5 Format Concerns

This pack augments the complete HTE-Code v2 Depth-5 baseline. It must be composed with the actual language, compiler/runtime, platform and repo authority.

## High-signal failure mechanics
- TOML version/parser determines accepted syntax and datetime/numeric behavior.
- Dotted keys and table headers construct hierarchy incrementally; redefining a key/table is generally invalid even if text looks separate.
- Array-of-tables nesting is easy to misread and can attach following subtables to a different parent than intended.
- Bare keys, quoted keys and dotted names have different escaping/whitespace affordances.
- Integers and floats have defined ranges/syntax but target-language deserializers can narrow or coerce them.
- Local date/time, offset datetime and local datetime are distinct types; converting everything to strings loses semantics.
- Multiline basic/literal strings have different escaping/newline trimming.
- Comments/formatting are usually not preserved by ordinary object round trip.
- Missing/default/unknown field compatibility belongs to the consumer schema.
- Qualification parses with the production library and exercises nested tables, arrays, dates, numeric boundaries and unknown/missing keys.


## PACK DOCUMENT: DEPTH5.md

# HTE-Code Format Pack: toml

**Baseline:** HTE-Code v2 Depth 5
**Role:** format-specific augmentation; all other detected packs remain additive.
**Maturity:** seeded

## Signature concern catalog

### table

**Mechanism:** Dotted keys/table reopening/array-of-tables rules can redefine structure unexpectedly.

**Detection:** parse to canonical tree.

**Adversarial edge:** duplicate/reopened key/table.

**Qualification:** parser negative tests.

### datetime

**Mechanism:** TOML local/offset datetime and numeric forms map differently into language libraries.

**Detection:** inspect target types.

**Adversarial edge:** timezone/local timestamp, large integer.

**Qualification:** roundtrip.

## Depth-5 rules

- Resolve exact version/configuration/consumer before universalizing behavior.
- Separate declaration/configuration/loading from actual execution and observable effect.
- Run negative-space checks for configured-but-unused, loaded-but-unconsumed and tested-but-unexercised paths.
- Preserve exact evidence tier for build, static, integration and runtime claims.
- Add repo-learned failure motifs back into this pack only when they generalize beyond one repository.


## PACK DOCUMENT: GAPS.md

# TOML Depth-5 Gap Closure

## Binding, evaluation, lifetime, concurrency
- Dotted keys, tables, inline tables, arrays-of-tables and redefinition rules establish binding/scope within the document; parsers should reject duplicate/reopened definitions according to the TOML version.
- TOML itself is declarative; environment interpolation, inheritance, workspace merging, conditional target sections and defaults belong to the consuming tool and must be modeled separately.
- Parsed DOM lifetime/mutability and concurrent access are host-library properties. Editing a shared config object across threads/tasks requires the library/application synchronization contract.

## Numerics and interop
- TOML integers are signed 64-bit by spec, while floats include inf/nan spellings. Host-language conversion can overflow narrower targets or normalize NaN/precision unexpectedly.
- Local date/time, local datetime and offset datetime are distinct representations and can lose timezone intent when bound to generic host datetime types.
- TOML interop is normally config-to-tool schema binding; unknown fields, casing, aliases, default values and nested structures are consumer/library behavior.

## Performance, instrumentation, failure signatures
- Huge arrays/tables or repeated reparsing can affect startup/build performance; configuration loaders should avoid treating config as a free hot-path operation.
- Instrumentation should expose the effective typed configuration and source/override provenance without leaking secrets.
- Common production symptoms: table declared twice, wrong nesting from dotted key, local datetime treated as UTC, integer too wide for consumer, or valid TOML key silently ignored by an older tool version.
- Undefined/implementation-defined edges include parser extension acceptance, duplicate-key diagnostics, comment preservation and round-trip formatting.
- False-positive guard: formatting/key-order diffs are not semantic changes unless the consumer hashes/signs raw bytes or has a documented order-sensitive extension.
- Negative-space check: a TOML key present in the file is not proof the active tool/version recognizes or consumes it.
