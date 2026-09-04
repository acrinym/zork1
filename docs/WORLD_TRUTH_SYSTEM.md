# Extended Zork World Truth System

World Truth is the reusable audit system for the rule **described world is law**. It does not assume that parser recognition alone is truthful. It keeps four distinct kinds of evidence:

1. **Declared world** — rooms, exits, objects, pseudo-scenery, containment, room globals, names, adjectives, flags, and action routines extracted from the complete `INSERT-FILE` lineage.
2. **English surface** — player-facing room and object prose tokenized into mapped references and candidate unmapped referents, with file, line, room, and source-entity evidence.
3. **Interaction contract** — affordances inferred from flags, concrete nouns, explicit action handlers, grammar routes, and authored expectations in `world-truth.toml`.
4. **Runtime truth** — isolated interpreter probes which replay a declared state route, issue one interaction, classify the response, and retain pass/fail evidence.

The distinction is deliberate. `EXAMINE DOOR` may be:

- **explicit**: the door's routine directly handles `EXAMINE`;
- **generic-afforded**: parser grammar and a matching flag contract handle it;
- **parser-recognized**: the command parses, but runtime evidence is still needed;
- **expected-missing**: the object implies an action for which no grammar route exists.

A parser-only response is not silently counted as a success. It becomes a runtime-proof candidate.

## Complete model

The JSON model is intentionally usable by more than the Markdown report. It contains:

- the source lineage and SHA-256 identity of every input file;
- rooms and directed/conditional exits;
- objects, actors (via `ACTORBIT`), pseudo-scenery, global scenery, containment, vocabulary, flags, and routines;
- grammar forms, direct/indirect-object shape, constraints, canonical actions, and pre-actions;
- vocabulary grouped as verbs, nouns, adjectives, prepositions, buzz/function words, and directions;
- every extracted prose reference, including mapped references rather than only failures;
- raw prose tokens plus a separate match key—stemming never replaces report evidence;
- duplicate entity definitions, ambiguity, adjacent-room-only matches, and described nouns whose only starting match is invisible;
- the sparse room × state × subject × interaction matrix with the evidence basis and initial visibility (`direct`, room-global, visible/occluded containment, or hidden) for each row;
- stable finding fingerprints and baseline state.

Fingerprints use versioned `semantic-v2` identity: code, room, subject, interaction, raw word, and stable related subjects where applicable. File paths and line numbers remain display evidence and never participate in the hash. Comment changes, include reshuffling, and line movement therefore do not rebase reviewed debt; an older line-based baseline fails closed instead of silently matching the new scheme.

The matrix is sparse by meaning, not by convenience. A literal Cartesian product of every room, every word, and every verb mostly describes impossible nonsense. World Truth still covers **every room and every described noun**: flag-implied verbs, explicit handlers, EXAMINE, and unmapped prose EXAMINE probes. It does not fuzz arbitrary verbs against every object. Authored `[[states]]` are arrival recipes and state variants (dark attic, bound troll, open window). They are not a permission to ignore the rest of the map. Unconditional `TO` exits from `policy.start_room` auto-generate the remaining room routes; rooms that need `IF`/`PER` still require an authored state or they are reported as `room-no-unconditional-route`.

## Commands

Audit any staged Extended Zork source tree:

```powershell
python -m tools.world_truth audit `
  --source glulx/build/empire-census-1303/src `
  --entrypoint zork1.zil `
  --config world-truth.toml `
  --json glulx/build/world-truth/world.json `
  --markdown glulx/build/world-truth/report.md `
  --probe-plan glulx/build/world-truth/probes.json `
  --fail-on error
```

Create a reviewed debt baseline (never generated implicitly):

```powershell
python -m tools.world_truth audit --source <staged-source> `
  --write-baseline reference/world-truth/baseline.json
```

Later CI runs use `--baseline` and fail only on selected severities that are not already reviewed. Known findings remain visible and counted.

Run generated probes with any stdin/stdout command-line interpreter:

```powershell
python -m tools.world_truth run-probes `
  --plan glulx/build/world-truth/probes.json `
  --results glulx/build/world-truth/runtime-results.json `
  -- glulxe --rngseed 123456 --undo 16 zork1.ulx
```

Each probe starts a fresh interpreter. Its setup route, final prompt-local room title, subject(s), command, allowed response classes, release marker, return code, and evidence basis are saved. The room title is checked in the prompt segment immediately surrounding the probe, not anywhere in the transcript; walking through the right room and ending in the wrong one cannot pass. Transcripts are omitted by default to keep artifacts small; `--include-transcripts` retains them for diagnosis.

## Authoring contracts

`world-truth.toml` is versioned product law, not a cache. It supports:

- `states`: reproducible production-valid command routes plus light, inventory, visibility, open, and closed contracts;
- `expectations`: object, two-object, conversation, and direct actor-command interactions;
- `probe_rules`: verb-, flag-, and interaction-kind response policy;
- `ignores`: narrowly reviewed static-analysis false positives with rationale;
- `policy`: project metadata and future gates.

Multiple states may name the same room. This is how the audit distinguishes, for example, a dark attic from a lit attic, an intact door from a broken door, a living actor from a dead one, water before and after the dam changes, or an object before and after custody transfer. Compile-time containment does not manufacture runtime scope.

Runtime probes default to the full reachable map. `policy.probe_inferred_interactions` is on unless a configuration turns it off. Inferred rows (explicit handlers, flag/lexical affordances, parser-recognized verbs, and unmapped prose EXAMINE) run in every non-dark state for that room, including auto-reached rooms. Authored expectations remain the place to pin two-object, conversation, and actor-command contracts that inference will not invent.

Response policy is data, not per-room Python logic. `recognized-specific`, `subject-refusal`, `generic-refusal`, parser failure, and visibility failure remain distinct. A policy may allow a refusal only for selected verbs, flags, and interaction kinds; subject-refusal requires the actual response segment to name a subject term.

Two-object expectations bind both subjects to an extracted grammar template, for example `tie up {object} with {other}` and `put {object} under {other}`. Conversation and direct-address commands have separate kinds, so `ASK MARA ABOUT X` and `MARA, TAKE X` are not misrepresented as unary affordances on Mara.

## CI policy

The fast workflow runs unit and contract tests only. Product truth is audited exclusively inside a release qualification workflow against `glulx/build/<release>/src` and that release's `.ulx`. Product policy requires a valid `STAGING-RECEIPT.json` and the `empire_nouns` include lineage; pointing the CLI at repository-root historical source fails closed. Runtime uses the same deterministic RNG seed and undo capacity as qualification.

Recommended gates:

- immediately fail new `error` findings (broken references and violated authored contracts);
- report `warning` and `candidate` debt until its first reviewed baseline;
- after runtime routes cover a region, fail new runtime probe regressions for that region;
- never treat a baseline as resolution—the report continues to show known debt until the world or a narrowly reasoned ignore closes it.

## Extending the system

Affordance inference lives in `tools/world_truth/audit.py`. Prefer flags, explicit object/PSEUDO action routines, and PRSA comparisons over a growing noun dictionary. Put unique narrative promises in `world-truth.toml`. The production contract already begins the Release 1302 opening/House/Cellar rooms and the production-valid Release 1305 troll/nest routes. Those authored routes are variants and gated arrivals, not the census. Test-only survey verbs may be used in a separate qualification configuration but must never enter the production story or production state contract.
