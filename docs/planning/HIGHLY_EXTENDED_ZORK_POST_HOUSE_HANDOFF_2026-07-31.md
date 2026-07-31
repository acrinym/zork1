# Highly Extended Zork — Post-House Handoff

**Repository:** `acrinym/zork1`  
**Date:** July 31, 2026  
**Default branch:** `master`  
**House of Records:** complete in Release `1230`  
**Merged concept PR:** #31  
**PR #31 source head:** `547c58f64df8d9d26e76b0c8b8fbae3c2e2cd814`  
**PR #31 merge commit:** `c00cb788068e54a2f615d35a347f062d9e286fd3`

## Mission

Continue Zork I from the completed House of Records into **Highly Extended Zork** without flattening the original game into generic AI-written interactive fiction.

The new direction is broader than one feature. It preserves several product families that can be deliberately promoted into complete player-facing trains:

- Living Zork causal deaths, warnings, knowledge, and culpability;
- deeper physical and parser affordances;
- Zork Plus / Veteran Expedition preparation;
- a physical expedition stash;
- museum, ecology, fishing, and natural-history systems;
- cuisine, hunger, satiation, and stamina without survival-game grind;
- one deeply authored human adventuring companion who may become a close friend or love interest through shared play;
- Infocom linguistic-corpus work so new prose is grounded in actual Infocom language evidence;
- optional Glulx visual presentation and far-horizon renderer experiments;
- Ethical Zork as a separate optional edition rather than a rewrite of normal dangerous Zork.

The next chat must not silently start all of these at once.

## Current repository truth

PR #31 has been merged into `master`.

It added ten documentation files with 4,573 additions and no production-code changes:

```text
ideas/README.md
ideas/stalker-glulx-if/README.md
ideas/extended-zork/README.md
ideas/extended-zork/recovered-pre-house-directions.md
ideas/extended-zork/museum-ecology-and-fishing.md
ideas/extended-zork/community-wishes-and-lost-ideas.md
ideas/extended-zork/cuisine-hunger-satiation-and-stamina.md
ideas/extended-zork/human-companion-bond-and-love-interest.md
ideas/extended-zork/infocom-linguistic-corpus-and-document-markdown.md
ideas/extended-zork/infocom-document-corpus-manifest.md
```

PR #31 was documentation-only. It created no beads, no source changes, no release, no workflows, and no hidden implementation claim.

All inline review threads were resolved before merge.

## Read first

A continuation agent should read these files in this order:

1. `docs/planning/HIGHLY_EXTENDED_ZORK_POST_HOUSE_HANDOFF_2026-07-31.md`
2. `ideas/README.md`
3. `ideas/extended-zork/README.md`
4. `ideas/extended-zork/infocom-linguistic-corpus-and-document-markdown.md`
5. `ideas/extended-zork/infocom-document-corpus-manifest.md`
6. `ideas/extended-zork/recovered-pre-house-directions.md`
7. `ideas/extended-zork/human-companion-bond-and-love-interest.md`
8. `ideas/extended-zork/museum-ecology-and-fishing.md`
9. `ideas/extended-zork/cuisine-hunger-satiation-and-stamina.md`
10. `ideas/extended-zork/community-wishes-and-lost-ideas.md`

For the completed House lineage and its actual production state, also inspect:

```text
docs/planning/LIVING_ZORK_FUTURE_IDEAS_KANBAN.md
docs/planning/HOUSE_EXPEDITION_STASH_AND_ZORK_PLUS_KANBAN.md
```

Then inspect the live Release `1230` source and qualification records before starting any implementation train.

## Hard boundaries

### Do not reopen the House program

The House of Records is closed:

- 12 trains complete;
- 96/96 beads closed;
- no sub-beads;
- Release `1230` landed through PR #32.

Do not attach new concepts beneath old House beads or pretend these ideas were unfinished House work.

### Start implementation from fresh `master`

The old concept branch is historical. Any real product train must begin on a new branch from the current live `master` after resolving the latest head.

### Keep the two idea lanes separate

`ideas/stalker-glulx-if/` is a separate-game concept.

Do not place S.T.A.L.K.E.R. lore, names, setting, artifacts, factions, or protected elements inside Zork merely because both concepts were discussed together.

### Preserve canonical authority

Do not duplicate unique treasures, silently solve puzzles, replace canonical score, fabricate object custody, merge contradictory expeditions, or turn actors into generic omniscient AI.

The real object, room, actor, warning, puzzle, and score state remains authoritative.

### Product, not recursive audit

Justin does not want endless audits, audit-of-audits, test tools for test tools, slices, stubs, no-ops, placeholders, or beads beneath beads.

When a family is promoted, build one complete player-facing train with its genuine dependencies, qualification, documentation, and closure.

## Infocom linguistic-corpus requirement

This is now a hard cross-cutting requirement:

> Highly Extended Zork must be written from traceable Infocom language evidence, not from a generic prompt to “sound like Infocom.”

The corpus must distinguish separate linguistic authorities rather than creating one averaged `INFOCOM_STYLE` voice.

### Authority order

1. exact selected Zork I game-source lineage;
2. Zork I manuals, transcripts, packaging, hints, and documents;
3. Zork II and Zork III;
4. later Great Underground Empire titles;
5. company-wide Infocom craft;
6. game- and author-specific contrast corpora.

Do not let Douglas Adams adaptation prose, *Bureaucracy* forms, *Plundered Hearts* relationship prose, or another title-specific voice silently become the Zork narrator.

### Corpus surfaces

The long-term corpus includes:

- player-visible ZIL prose;
- manuals and technical manuals;
- reference cards and command sheets;
- sample transcripts;
- packaging, folios, browsies, labels, catalogs, and advertisements;
- feelies and fictional documents;
- InvisiClues and hint escalation;
- newsletters and company publications;
- samplers, collections, and rereleases;
- edition and platform differences;
- public Implementor writing when relevant and lawful.

### Rights boundary

Online availability is not redistribution permission.

- Commit full text only when a verified license or permission covers this repository.
- Protected scans or user-owned study copies may be processed locally but must remain outside public Git unless cleared.
- Public Git may retain manifests, hashes, page references, correction records, non-expressive analysis, annotations, statistics, and derived style profiles.
- Unknown or disputed material remains metadata-only.
- Do not upload complete protected manuals or wholesale OCR based on an assumed permission theory.

### Style receipts

Every substantial new prose family should eventually identify:

- primary source authority;
- secondary source authority;
- excluded voices;
- retained linguistic traits;
- intentional departures;
- phrase-overlap results to prevent sentence assembly from source text.

A museum plaque, Mara survey note, parser refusal, death message, House record, and failed recipe must use different evidence profiles.

## Human companion direction

The strongest design is one deeply authored human woman, not a roster and not a dating simulator.

Current working candidate: **Mara Tallow**.

She is an independent field surveyor and route historian reconstructing the **Last Honest Survey of the Great Underground Empire**.

Her proposed first meeting occurs during a developing emergency at Flood Control Dam #3. The Adventurer and Mara are separated by water and machinery; each has something the other needs, and both witness whether the other keeps a promise under pressure.

The first bond is competence witnessed under danger—not flirtation.

Mara must be another causal adventurer with:

- exact body, location, posture, injury, fatigue, light, equipment, and carrying state;
- her own inventory and real object custody;
- incomplete evidence-based knowledge, theories, errors, and suspicions;
- her own mission, schedule, field camp, promises, boundaries, and ability to leave;
- direct-address parser grammar;
- joint physical actions;
- bounded autonomy and meaningful refusal;
- deep friendship as a complete outcome;
- optional love emerging from exact shared history rather than gifts, meters, dates, or dialogue-wheel courtship;
- possible separation, reconciliation, departure, injury, or authored death without cheap melodrama.

She must never degrade into a chatbot, hint dispenser, pack mule, escort objective, constant quip generator, submissive follower, or romance prize.

## Museum direction

The museum remains fully retained.

It should be a persistent playable institution, not a completion menu. It may include:

- donation, loan, registration, refusal, and custody;
- artifacts, specimens, replicas, sketches, rubbings, measurements, and testimony;
- provenance-aware plaques;
- curators, researchers, visitors, correspondence, disputes, theft risk, and upgrades;
- fish, plants, fungi, creature traces, stones, residues, and anomalous substances;
- exhibits that become active story locations;
- save/restore continuity and expedition-specific history.

A strong first museum train would deliver one complete intake-to-gallery loop with real objects and revisit behavior.

## Cuisine direction

Cuisine may connect ecology, travel, regional history, exertion, expedition preparation, and provenance.

Its governing rule is:

> Food must create decisions, discoveries, humor, and stories—not repetitive eating chores or generic survival meters.

The system distinguishes:

- slow hunger;
- satiation;
- immediate exertion-based stamina;
- physical condition;
- preparation and preservation;
- regional cuisine;
- contextual meal effects;
- recipe discovery;
- memorable failure;
- rare-specimen choices between release, donation, study, preservation, sale, or cooking.

## Recovered pre-House directions

Do not let the museum or companion erase the earlier direction.

Important recovered systems include:

- causal death architecture;
- player knowledge and warning-attention state;
- escalating physical warning chains;
- Dam falls, swimming, drowning, encumbrance, machinery, and prepared rescue;
- the troll stealing and later using the real sword;
- thief relationship escalation through irritation, sabotage, warning, ambush, hunting, and execution-ready hostility;
- grue ecology and the authored colony reveal;
- deeper rope, water, sound, scent, damage, machinery, and scenery affordances;
- authored replayability and conduct histories;
- a physical House or Cellar expedition stash;
- bounded supplies, equipment preparation, and authored armor;
- `ZORK PLUS`, `SECOND EXPEDITION`, or `VETERAN EXPEDITION` using exact-object relocation rather than duplication;
- parser comprehension and limited intent classification;
- Shadowgate-style Glulx presentation;
- far-horizon 2.5D or 3D renderer experiments.

## Candidate first post-House product trains

These are sequencing alternatives, not simultaneous work:

1. **Infocom Corpus Foundation**
2. **Causal Death and Warning Foundation**
3. **Physical Expedition Stash**
4. **Museum Intake and First Gallery**
5. **Parser Comprehension and Deep Affordances**
6. **Companion Expedition Foundation**

### Recommended next move

Because every prose-heavy train depends on language authority, the strongest immediate foundation is **Infocom Corpus Foundation**.

That train should be a complete usable corpus product—not merely a list of links. A strong complete scope would include:

- current repository source/license inventory;
- exact Zork I player-visible prose extraction from the selected source lineage;
- artifact manifest schema and stable IDs;
- Zork I edition-level manual/package/feelie inventory;
- local-source and public-repository rights classes;
- Markdown transcription contract;
- annotation taxonomy;
- initial Zork narrator, object-description, parser-refusal, death, manual, transcript, institutional-document, and hint profiles;
- style-receipt format;
- overlap/originality validation;
- documentation showing how the next product train consumes the corpus.

Do not begin by downloading and committing every PDF found online.

## Suggested next-chat prompt

```text
@GitHub Continue acrinym/zork1 from docs/planning/HIGHLY_EXTENDED_ZORK_POST_HOUSE_HANDOFF_2026-07-31.md.

Resolve the current live master head first. PR #31 is merged. Do not reopen the completed House of Records bead hierarchy.

Promote Infocom Corpus Foundation into one complete product train. Build a traceable Zork-first linguistic corpus from licensed player-visible source prose and a rights-aware edition-level document manifest. Do not publish protected manuals or wholesale OCR without verified repository redistribution rights. Create real extraction, schema, annotation, style-receipt, and overlap-validation tooling and documentation—no generic “sound like Infocom” prompt, no stubs, no slices, and no recursive audit train.

Keep S.T.A.L.K.E.R. separate. Preserve all Highly Extended Zork idea families for later deliberate sequencing.
```

## Merge and continuation policy

- PR #31 is merged.
- Begin new implementation from current `master` on a fresh branch.
- Keep future implementation PRs open until Justin gives an explicit merge whistle.
- Address real review findings before merging.
- Preserve exact heads, release identity, validation truth, and handoff state.
