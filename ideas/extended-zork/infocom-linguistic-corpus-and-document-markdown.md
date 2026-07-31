# Infocom Linguistic Corpus and Document Markdown Strategy

## Status

Future-design and corpus-planning material for **Highly Extended Zork**.

This document does not yet transcribe the complete Infocom documentation library, create implementation beads, alter Release `1230`, or claim that a style corpus is complete.

It records a hard product requirement:

> **Highly Extended Zork must be written from traceable Infocom language evidence, not from a generic instruction to “sound like Infocom.”**

The goal is not to have an AI invent an approximation of an Infocom game. The goal is to assemble a provenance-aware corpus of original Infocom prose, documentation forms, parser behavior, packaging voices, and Great Underground Empire language so that every extension can be authored and reviewed against real evidence.

## Why this matters

“Infocom style” is often reduced to a few superficial traits:

- second-person narration;
- dry jokes;
- short room descriptions;
- occasional parser sarcasm;
- fake bureaucratic language;
- a grue reference.

That produces imitation, not continuity.

The real Infocom material contains several distinct linguistic systems:

- room and object description;
- action consequence prose;
- parser refusal and clarification;
- death and restart language;
- hints and escalating clue structure;
- sample transcripts;
- instruction-manual explanation;
- fictional institutional documents;
- advertisements and catalogs;
- newsletters;
- legal parody;
- field reports, maps, letters, forms, certificates, diaries, and other feelies;
- game-specific author voices.

These systems must not be flattened into one undifferentiated “retro text adventure” voice.

## Core rule

Every substantial new prose surface should be able to answer three questions:

1. **Which original Infocom source families are authoritative for this surface?**
2. **Which linguistic traits were deliberately retained or adapted?**
3. **How was new wording kept original rather than copied from the corpus?**

A museum plaque, Mara’s survey note, a parser refusal, a death message, a House record, and a comedy response should not all be generated from the same style prompt.

## Complete-document ambition

The long-term inventory includes every original Infocom textual artifact that can materially inform language, presentation, worldbuilding, or interaction.

### Game documentation

- manuals;
- technical manuals;
- folio text;
- grey-box browsies;
- reference cards;
- command summaries;
- sample transcripts;
- platform-specific instruction sheets;
- collection manuals;
- Solid Gold manuals and hint documentation;
- trilogy and anthology documentation;
- errata, warranty, registration, and support sheets when linguistically relevant.

### Packaging and marketing

- front, back, spine, flap, tray, slipcase, and folio copy;
- catalogs;
- advertisements;
- dealer sheets;
- product descriptions;
- sampler text;
- newsletters, including *The New Zork Times* and *The Status Line*;
- contest, survey, subscription, and response-card language.

### Feelies and in-world documents

- letters;
- maps containing text;
- forms;
- reports;
- brochures;
- newspapers;
- diaries;
- dossiers;
- certificates;
- identification cards;
- tickets;
- notices;
- legal documents;
- technical diagrams with labels;
- marginalia;
- fictional books and booklets;
- object labels and packaging;
- copy-protection documents that also function as fiction.

### Hint and support material

- InvisiClues question structure;
- hint escalation;
- answer phrasing;
- maps distributed with hints;
- support letters and published clarifications where available and suitable;
- known official solution or walkthrough prose when rights and provenance permit.

### Source-language evidence

- shipped ZIL strings;
- room and object descriptions;
- parser responses;
- actor dialogue;
- alternate and discarded strings where provenance is clear;
- compiler-era source comments only when they inform writing practice and their licensing permits use;
- version differences between released builds.

### Company and craft material

- internal or public style guidance;
- Implementor essays and interviews;
- official writing or parser-design documentation;
- public technical papers;
- production notes where their rights status permits study and citation.

## Rights-aware corpus classes

Online availability does not automatically grant republication rights. The corpus therefore requires an explicit rights basis for every artifact.

### Class A — repository-licensed full text

Material whose license permits repository inclusion and transformation.

Examples may include original source repositories carrying an explicit permissive license. Every imported file must retain the required notices and exact source revision.

Allowed repository treatment:

- full Markdown extraction;
- normalized text;
- structural annotation;
- linguistic analysis;
- short source-linked examples;
- generated indexes and statistics.

### Class B — expressly permissioned documentation

Material hosted by a preservation project under permission granted to that project or by the rights holder.

Permission granted to another site is not silently treated as permission for this repository. Before mirroring complete text, obtain or verify permission that covers this repository and its intended distribution.

Until then, commit only:

- metadata;
- canonical links;
- checksums where locally acquired;
- document structure;
- page and section references;
- derived linguistic features;
- brief, properly attributed excerpts within applicable limits.

### Class C — user-owned local study copies

Scans, PDFs, or physical-document captures Justin lawfully possesses but which lack repository redistribution permission.

These may feed a local private analysis pipeline, but the public repository should contain only:

- manifest records;
- local filename conventions;
- hashes;
- OCR confidence and correction logs;
- non-expressive statistics;
- derived style rules;
- source references;
- no wholesale transcription.

Raw files and full OCR output remain outside Git history unless rights are cleared.

### Class D — public-domain or independently licensed material

Material with a verified public-domain status or explicit license allowing redistribution.

Allowed repository treatment depends on that license and should preserve attribution, notices, and source provenance.

### Class E — unknown or disputed

No full text enters the repository.

The manifest records the artifact and the unresolved rights question.

## Important permission boundary

The Infocom Documentation Project states that it recreates manuals with Activision’s permission and that its images and text remain copyrighted and reproduced with permission.

That makes it an excellent authoritative source and possible collaboration target. It does **not** automatically extend its permission to a separate GitHub mirror.

Likewise, current Activision terms reserve rights in related documentation and prohibit reproduction except where an applicable license or written permission allows it.

Therefore:

- do not scrape the complete Documentation Project into this repository;
- do not assume archive scans are public domain;
- do not publish full OCR from commercial manuals merely because scans are accessible;
- pursue explicit permission or keep protected full text local;
- commit the analysis, provenance, and original style specification even when raw text cannot be committed.

This is not a retreat from the corpus goal. It is how the corpus remains usable, defensible, and release-ready.

## Style authority hierarchy for Highly Extended Zork

“All Infocom” is useful for breadth, but it is not the correct undifferentiated authority for Zork prose.

### Tier 0 — exact Zork I game authority

Highest authority for normal gameplay prose:

- the selected canonical Zork I source lineage;
- shipped room descriptions;
- object descriptions;
- action responses;
- actor behavior;
- parser language;
- score, death, restart, and victory language;
- edition-specific differences relevant to the repository’s chosen base.

New ordinary world prose should fit here first.

### Tier 1 — Zork I documentation authority

Highest authority for explaining this game to the player and presenting its immediate fiction:

- original manuals;
- sample transcripts;
- reference cards;
- packaging copy;
- Zork I advertisements;
- authorized hints;
- original product-specific inserts and documents.

### Tier 2 — commercial Zork trilogy authority

Useful for the shared Adventurer, Great Underground Empire, objects, institutions, humor, and historical language:

- Zork II;
- Zork III;
- their source prose;
- manuals;
- packaging;
- hints;
- feelies;
- edition differences.

### Tier 3 — Great Underground Empire lineage

Useful where later canonical or quasi-canonical games expand vocabulary, institutions, magic, geography, history, and document forms:

- Enchanter;
- Sorcerer;
- Spellbreaker;
- Wishbringer;
- Beyond Zork;
- Zork Zero;
- other rights-cleared GUE material deliberately selected after canon review.

This tier must not silently overwrite Zork I’s voice or facts.

### Tier 4 — Infocom house craft

Useful for parser conventions, manuals, comedy timing, fictional documentation, support material, and product presentation across the company.

This tier can teach technique without importing another game’s world voice.

### Tier 5 — game- and author-specific contrast corpus

Titles such as *The Hitchhiker’s Guide to the Galaxy*, *A Mind Forever Voyaging*, *Trinity*, *Bureaucracy*, *Plundered Hearts*, *Shogun*, and others are highly valuable—but their distinctive voices must be tagged rather than averaged into Zork.

Examples:

- Douglas Adams adaptation language must not become default GUE narration;
- *Bureaucracy* document parody may inform one bureaucratic artifact, not every museum form;
- romantic prose from *Plundered Hearts* may inform historical comparison, not Mara’s automatic voice;
- *Trinity* may inform tonal control and image-rich description without transferring its setting or diction wholesale.

## Author and surface separation

Every corpus record should identify, where reasonably known:

- game;
- artifact;
- author or credited writer;
- editor;
- year;
- edition;
- platform or packaging family;
- fictional speaker or institution;
- prose surface;
- certainty of attribution.

The style system should support profiles such as:

- `ZORK1_NARRATOR`;
- `ZORK1_PARSER_REFUSAL`;
- `ZORK1_OBJECT_DESCRIPTION`;
- `ZORK_TRILOGY_DEATH`;
- `INFOCOM_SAMPLE_TRANSCRIPT`;
- `INFOCOM_TECHNICAL_MANUAL`;
- `GUE_INSTITUTIONAL_DOCUMENT`;
- `INFOCOM_BOX_COPY`;
- `INFOCOM_INVISICLUES_ESCALATION`;
- `INFOCOM_NEWSLETTER_EDITORIAL`;
- a named author/game profile used only where deliberately selected.

There should be no default `INFOCOM_STYLE` bucket that mixes everything.

## Markdown transcription contract

A faithful Markdown edition is not merely OCR dumped into a file.

Each artifact should use stable front matter or an equivalent metadata header:

```yaml
artifact_id: zork1-folio-manual-en-us-r1
title: Zork I Manual
product: Zork I
artifact_type: manual
release_family: folio
edition: first-known
language: en-US
source_location: local://...
canonical_reference_url: https://...
rights_class: B
rights_basis: permission-required-for-repository-mirror
source_sha256: ...
page_count: ...
ocr_engine: ...
ocr_confidence: ...
transcription_status: manifest-only
review_status: unreviewed
```

### Page identity

Preserve source page identity even when the Markdown is reflowed:

```markdown
<a id="page-07"></a>

## Page 7
```

For unnumbered objects, use stable surface identifiers:

```markdown
<a id="destruction-order-front"></a>

## Destruction Order — Front
```

### Block identity

Tag semantically important blocks:

- heading;
- body paragraph;
- caption;
- warning;
- command example;
- transcript input;
- transcript output;
- form field;
- handwritten note;
- marginalia;
- map label;
- legal parody;
- advertisement;
- inventory list;
- hint question;
- hint answer;
- uncertain text.

### OCR uncertainty

Never silently guess.

Use a consistent notation:

```markdown
[unclear: probable reading]
[illegible]
[handwritten]
[symbol description]
```

Every correction should remain auditable against the page image or source text.

### Layout truth

Markdown cannot reproduce every physical arrangement, but it should preserve relationships:

- reading order;
- columns;
- table structure;
- form labels and fields;
- captions and images;
- front/back relationships;
- fold order;
- nested inserts;
- typography that changes meaning;
- handwritten versus printed text.

A separate facsimile or page image remains the visual authority when legally distributable.

### No modernization inside source transcription

The transcription layer preserves:

- original spelling;
- punctuation;
- capitalization;
- abbreviations;
- intentional errors;
- period terminology;
- line or paragraph breaks where they carry meaning.

Corrections and normalized forms belong in annotations, not silently inside the source text.

## Derived linguistic annotation

The committed value of the corpus is not only searchable text. It is structured evidence about how Infocom wrote.

### Sentence and rhythm

Record:

- sentence length distribution;
- clause count;
- paragraph length;
- fragments;
- delayed punch lines;
- abrupt final sentences;
- parenthetical use;
- semicolon and dash behavior;
- list cadence;
- repetition and escalation.

### Narrator stance

Record:

- neutral observation;
- dry judgment;
- direct mockery;
- mock sympathy;
- bureaucratic impersonality;
- ominous understatement;
- sensory immediacy;
- withholding;
- unreliable or game-specific narration.

### Player reference

Record:

- second person;
- implied body;
- competence assumptions;
- culpability;
- knowledge-aware wording;
- responses to repeated attempts;
- distinction between inability, impossibility, ignorance, danger, and absurdity.

### Parser behavior language

Classify:

- unknown word;
- missing noun;
- ambiguity;
- wrong preposition;
- impossible action;
- reasonable but unsupported action;
- already-done action;
- repeated action;
- dangerous refusal;
- actor refusal;
- physical obstruction;
- joke response;
- redirection toward a supported intent.

### Comedy mechanics

Record the mechanism, not merely “funny”:

- reversal;
- literalism;
- anticlimax;
- pompous institution;
- over-specificity;
- understatement;
- narrator impatience;
- player culpability;
- callback;
- escalation;
- object dignity;
- bureaucratic absurdity;
- physical consequence;
- delayed recognition.

### Description mechanics

Record:

- first-view versus repeat-view length;
- landmark order;
- exits stated or implied;
- foreground object placement;
- sensory channels;
- active versus static scenery;
- mystery preservation;
- clue density;
- material vocabulary;
- adjective restraint;
- final-image selection.

### Document voice

For manuals and feelies, record:

- fictional issuing institution;
- intended reader;
- stated purpose;
- concealed purpose;
- typography or formality markers;
- jargon density;
- politeness strategy;
- threat or warning strategy;
- seriousness-to-parody ratio;
- relationship to actual game mechanics.

## Style receipts for new writing

Every large new prose family should have a small committed style receipt.

Example:

```yaml
surface: museum-specimen-plaques
primary_authority:
  - zork1-object-description
  - gue-institutional-document
secondary_authority:
  - infocom-field-report
excluded_profiles:
  - hitchhiker-narrator
  - bureaucracy-global-parody
retained_traits:
  - concrete object-first description
  - one disputed scholarly claim
  - restrained final joke
originality_check:
  longest_source_overlap_tokens: 5
reviewed_by: ...
```

The receipt does not mechanically prove quality. It prevents untraceable voice drift and makes review possible.

## Originality safeguards

The corpus exists to support authorship, not to assemble passages from borrowed sentences.

New writing should:

- use source material to identify patterns, not copy expressions;
- avoid long phrase overlap;
- flag rare phrase reuse;
- preserve canonical names only where needed;
- distinguish necessary franchise vocabulary from expressive borrowing;
- be reviewed side-by-side with source examples;
- remain attributable to this extension project rather than presented as lost Infocom prose.

An automated overlap report should compare proposed prose against the corpus and surface suspicious matches before merge.

## Proposed repository architecture

When promoted on a fresh post-House branch:

```text
reference/
└── infocom-corpus/
    ├── README.md
    ├── MANIFEST.md
    ├── RIGHTS_LEDGER.md
    ├── SOURCE_AUTHORITY.md
    ├── schemas/
    │   ├── artifact.schema.json
    │   ├── block.schema.json
    │   └── style-receipt.schema.json
    ├── licensed-source-prose/
    │   ├── zork1/
    │   ├── zork2/
    │   └── zork3/
    ├── permissioned-docs/
    ├── metadata-only/
    ├── annotations/
    ├── style-profiles/
    └── reports/

tools/
└── infocom-corpus/
    ├── extract_zil_strings.py
    ├── normalize_markdown.py
    ├── validate_manifest.py
    ├── audit_rights_gate.py
    ├── analyze_style.py
    └── check_phrase_overlap.py
```

Protected local sources should be addressed through ignored paths such as:

```text
.local/infocom-sources/
.local/infocom-ocr/
```

The public manifest may retain hashes and metadata without exposing those files.

## Validation requirements

A corpus artifact is not complete merely because a Markdown file exists.

Validation should check:

- required metadata;
- rights class and rights basis;
- stable artifact ID;
- source hash where available;
- page or surface anchors;
- no missing referenced images;
- OCR uncertainty markers;
- transcript speaker separation;
- command formatting;
- link validity;
- duplicate artifact detection;
- edition conflicts;
- source-to-Markdown coverage;
- no protected full text committed under metadata-only status.

## Zork-first execution order

The entire Infocom catalog should be inventoried, but Highly Extended Zork should not wait for every distant product to be fully analyzed before gaining useful authority.

### Phase 1 — exact Zork I source prose

- inventory all source files that emit player-visible text;
- extract strings with source path, routine, object, and line provenance;
- separate shipped, unused, test, and uncertain strings;
- classify room, object, action, parser, actor, death, score, hint, and system prose;
- generate the first style profiles.

### Phase 2 — Zork I documentation family

- inventory every known manual and packaging edition;
- compare folio, blister, grey-box, collection, and later-release documentation;
- acquire rights-cleared text or maintain local-only transcriptions;
- Markdown the manual, sample transcript, reference cards, packaging copy, and product-specific documents;
- record edition differences rather than merging them silently.

### Phase 3 — Zork II and Zork III

Repeat source and documentation ingestion, then identify:

- trilogy-wide constants;
- deliberate shifts in narrator tone;
- Great Underground Empire vocabulary;
- actor and institution language;
- death, victory, and puzzle-feedback patterns.

### Phase 4 — GUE lineage

Ingest and tag Enchanter-line and later Zork-line material without allowing it to overwrite Zork I authority.

### Phase 5 — complete Infocom documentation inventory

Inventory and process the full catalog, company publications, hint systems, and feelies.

### Phase 6 — writing gates

Require style receipts and overlap checks for major new Highly Extended Zork prose families.

## Product relationship

This corpus should become a dependency for:

- causal death prose;
- warning chains;
- parser comprehension and refusal language;
- museum plaques and curator documents;
- Mara Tallow’s survey records and dialogue;
- cuisine descriptions and failed dishes;
- Zork Plus preparation and expedition documents;
- House and Attic records;
- visitor correspondence;
- regional lore;
- optional illustrated presentation text;
- manuals for the extension itself.

## Governing principle

> **We are not asking a model to create an Infocom game. We are building enough primary-source authority that new Zork writing can be authored, challenged, revised, and qualified against what Infocom actually did.**

The corpus must preserve differences, provenance, rights, and uncertainty. Exactness comes from disciplined evidence—not from a stronger adjective in a prompt.
