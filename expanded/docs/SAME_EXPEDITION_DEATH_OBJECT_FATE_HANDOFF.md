# Same-Expedition Death and Exact-Object Fate — Continuation Handoff

**Repository:** `acrinym/zork1`  
**Default branch:** `master`  
**Working branch:** `agent/same-expedition-death-object-fate-spec`  
**Branch point:** `2452bb6c35cae26753922072bbfe478d9e01f4ad`  
**Status:** documentation-only shaping; pre-BEADS; no production release change

## Resolve the live state first

Do not blindly trust the frozen SHAs, PR states, checks, review status, or branch relationships in this handoff.

Before editing:

1. resolve exact current `master`;
2. inspect every open pull request;
3. resolve the current head, base, mergeability, comments, reviews, inline threads, and checks for the PR associated with this branch;
4. recheck PR #11 and any production PR stacked above or below it;
5. confirm whether the House of Records program and the two July 23 planning Kanbans have been reconciled onto one branch;
6. read `expanded/docs/SAME_EXPEDITION_DEATH_AND_OBJECT_FATE_SPEC.md` completely;
7. keep every PR open and unmerged unless Justin explicitly gives the merge whistle.

## Live topology when this branch was created

At creation time on July 23, 2026:

- `master` was `e14c5f2f9ed7e134406507ae310171a12193e823`;
- PR #14 had merged its two pre-BEADS future-system Kanbans into `master`;
- PR #11 remained open and mergeable;
- PR #11's live head was `2452bb6c35cae26753922072bbfe478d9e01f4ad`;
- PR #12 had merged into PR #11's branch, not into `master`;
- PR #13 had previously merged into PR #12's branch;
- therefore the authoritative House of Records program lived on PR #11's branch while the stash/Zork Plus and Living Zork Kanbans lived on `master`;
- PR #11 had no unresolved review thread and all 23 workflows reported success at its live head;
- PR #12 had no inline review thread and all 23 workflows reported success at its closure head;
- PR #14 was documentation-only, had no inline review thread, and reported no workflow runs for its head.

This new branch was created from PR #11's exact live head so the specification could reference the authoritative House of Records program and qualified Release `1218` lineage without modifying PR #11 itself.

## Decision taken

The continuation chose **Path C — define same-expedition death and object-fate semantics first**.

That choice follows the planning dependency already recorded for the physical stash:

- a secure stash cannot be qualified until carried-item death fate is defined;
- death-site recovery cannot be designed without real locations, actor ownership, environmental transit, and unique-object safety;
- armor and Zork Plus loadouts need the same causal object-fate substrate;
- the archive must observe those outcomes without owning or repairing live objects.

## File added

Canonical shaping specification:

`expanded/docs/SAME_EXPEDITION_DEATH_AND_OBJECT_FATE_SPEC.md`

The specification defines:

- the canonical `JIGS-UP` and `RANDOMIZE-OBJECTS` baseline;
- same-expedition versus terminal-death boundaries;
- stable expedition, incident, death, family, object, actor, place, warning, and recovery identities;
- exact-object fate vocabulary;
- root-container and nested-containment rules;
- secure-house behavior;
- authored actor, water, machinery, fire, fall, collapse, creature, magical, and folly outcomes;
- completion-critical unique-object safety;
- recovery semantics;
- archive receipts;
- ordinary native save/restore proof;
- deterministic qualification routes;
- promotion gates;
- and the implementation boundary that must remain pre-BEADS until accepted.

## Controlling architectural rule

> An authored death may claim, move, damage, transform, lodge, scatter, or destroy specific real objects when the fatal event physically justifies it. Every unclaimed carried root object continues through Zork's canonical reincarnation disposition.

This is the key reconciliation between Living Zork consequences and historical behavior.

It prevents both bad extremes:

- no magical vacuum that returns every carried object to the house;
- no wholesale replacement of canonical reincarnation with a generic corpse-drop system.

## Canonical behavior preserved

The design preserves:

- ten-point canonical death penalty;
- canonical death count and return limit;
- South Temple / Land of the Living Dead phase;
- terminal death while already dead;
- canonical lamp and coffin destinations;
- canonical treasure versus ordinary-object scattering;
- sword threat-value reset;
- canonical interrupt reset by default;
- exact nested containment when a root container moves;
- real object identity and transformations;
- existing score, actors, puzzles, parser, and release lineage.

## No implementation commitments yet

This branch does not:

- change production ZIL;
- create or modify a release artifact;
- create BEADS;
- modify the existing ninety-six House of Records beads;
- add a stash;
- add armor;
- add Zork Plus;
- add a universal corpse container;
- select the final actor or environmental pilot;
- merge any PR.

## Required review decisions

Before promotion, decide:

1. whether canonical residual randomization is the accepted fallback for every unclaimed root object;
2. whether the first actor-held pilot should use the troll, thief, or another existing actor state;
3. whether the first environmental pilot should use river/current, dam machinery, or another already-qualified mechanism;
4. the compact stable ID representation suitable for Glulx saves;
5. the reviewed unique/completion-critical safety table format;
6. the exact changed-path contract;
7. whether death context belongs in a new isolated module or a narrowly wrapped existing death routine;
8. whether the first implementation train should precede or follow the House state foundation.

## Recommended order from here

1. review and tighten the specification;
2. select one actor-held and one environmental-transit pilot;
3. define the exact qualification routes and production changed-path boundary;
4. promote only the accepted first implementation slice into new additive BEADS;
5. qualify canonical compatibility before any authored exception;
6. after the death contract is stable, shape the one physical house/Cellar stash against it;
7. leave armor, local field caches, linked Imperial storage, and Zork Plus until their dependencies are mature.

## Definition of success for the shaping train

This documentation train succeeds when a future implementation can answer, without guessing:

- what the adventurer carried at death;
- what was safely secured at home;
- which exact object an actor took;
- which exact object water or machinery moved;
- which nested contents stayed together or split;
- what was damaged, transformed, or genuinely destroyed;
- where recovery must occur;
- which object must remain completion-safe;
- what canonical residual randomization still handles;
- and what native `SAVE` / `RESTORE` must reproduce exactly.

The house can then protect deliberate preparation without erasing the consequences of leaving it.
