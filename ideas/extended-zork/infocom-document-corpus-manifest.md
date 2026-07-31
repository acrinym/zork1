# Infocom Document Corpus Manifest

## Status

Initial catalog-level manifest for the future Infocom linguistic corpus.

This is not yet an artifact-complete inventory. A title may have many releases, manuals, reference cards, feelies, maps, package surfaces, hint editions, and platform sheets. Each distinct physical or digital artifact eventually requires its own record.

The purpose of this file is to ensure that “all Infocom documents” has a concrete, auditable scope rather than meaning “whatever PDFs happened to be easy to find.”

## Status vocabulary

- `UNINVENTORIED` — title or publication family is known, but artifact-level enumeration has not begun.
- `INVENTORY_STARTED` — some artifacts are identified, but editions or package contents remain incomplete.
- `MANIFESTED` — known artifacts have stable IDs and provenance records.
- `LOCAL_TEXT` — a private/local transcription exists but is not cleared for repository publication.
- `REPO_TEXT` — full Markdown text is committed under a verified rights basis.
- `ANNOTATED` — linguistic blocks and style features are classified.
- `QUALIFIED` — source coverage, rights status, transcription, and annotations have passed review.

## Rights vocabulary

- `A` — repository-licensed full text.
- `B` — third-party permissioned source; repository mirroring permission still requires verification.
- `C` — lawfully held local study copy; full text remains outside Git.
- `D` — verified public domain or independently licensed.
- `E` — unknown, disputed, or not yet researched.

## Core Infocom interactive-fiction catalog

The following 35 titles form the central product-document inventory. The list is title-level only; later work must split every packaging and documentation edition.

| ID | Title | Year | Primary corpus value | Initial status |
|---|---|---:|---|---|
| `infocom-zork1` | Zork I: The Great Underground Empire | 1980 | Highest Zork narration, parser, manual, transcript, and packaging authority | `INVENTORY_STARTED` |
| `infocom-zork2` | Zork II: The Wizard of Frobozz | 1981 | Trilogy voice, Wizard material, GUE geography and institutions | `UNINVENTORIED` |
| `infocom-zork3` | Zork III: The Dungeon Master | 1982 | Trilogy culmination, Dungeon Master, death and consequence language | `UNINVENTORIED` |
| `infocom-deadline` | Deadline | 1982 | Dossier, letter, evidence, police-document, and investigative prose | `UNINVENTORIED` |
| `infocom-starcross` | Starcross | 1982 | Technical science-fiction description, map and package language | `UNINVENTORIED` |
| `infocom-suspended` | Suspended | 1983 | Multi-actor perception, robot reports, system documentation | `UNINVENTORIED` |
| `infocom-witness` | The Witness | 1983 | Detective narration, evidence, correspondence, period documents | `UNINVENTORIED` |
| `infocom-planetfall` | Planetfall | 1983 | Comic narrator control, companionship, manuals and institutional parody | `UNINVENTORIED` |
| `infocom-enchanter` | Enchanter | 1983 | GUE magic, spell language, folio/manual voice | `UNINVENTORIED` |
| `infocom-infidel` | Infidel | 1983 | Expedition documents, archaeology, maps, warnings and culpability | `UNINVENTORIED` |
| `infocom-sorcerer` | Sorcerer | 1984 | GUE magic continuation, dreams, guild and spell documentation | `UNINVENTORIED` |
| `infocom-seastalker` | Seastalker | 1984 | Youth-facing manual clarity, scientific and underwater interaction | `UNINVENTORIED` |
| `infocom-cutthroats` | Cutthroats | 1984 | Diving, equipment, nautical documents, crew interaction | `UNINVENTORIED` |
| `infocom-hitchhiker` | The Hitchhiker’s Guide to the Galaxy | 1984 | Distinct adaptation voice and feelie design; contrast corpus only for Zork narration | `UNINVENTORIED` |
| `infocom-suspect` | Suspect | 1984 | Social investigation, party actors, evidence and legal documents | `UNINVENTORIED` |
| `infocom-wishbringer` | Wishbringer | 1985 | GUE-adjacent accessible prose, magic, postal and town documents | `UNINVENTORIED` |
| `infocom-amfv` | A Mind Forever Voyaging | 1985 | Serious political prose, simulation reports, institutional documents | `UNINVENTORIED` |
| `infocom-spellbreaker` | Spellbreaker | 1985 | GUE magic authority, guild language, high-level consequence prose | `UNINVENTORIED` |
| `infocom-ballyhoo` | Ballyhoo | 1986 | Circus documents, performance copy, social and investigative voice | `UNINVENTORIED` |
| `infocom-trinity` | Trinity | 1986 | Controlled tonal shifts, image-rich prose, historical-document treatment | `UNINVENTORIED` |
| `infocom-lgop` | Leather Goddesses of Phobos | 1986 | Comedy systems, package props, comic-book and institutional parody | `UNINVENTORIED` |
| `infocom-moonmist` | Moonmist | 1986 | Social mystery, letters, castle documentation and variant structure | `UNINVENTORIED` |
| `infocom-hollywood-hijinx` | Hollywood Hijinx | 1986 | Physical comedy, estate documents, scavenger-style clue writing | `UNINVENTORIED` |
| `infocom-bureaucracy` | Bureaucracy | 1987 | Bureaucratic forms, institutional parody, escalating frustration language | `UNINVENTORIED` |
| `infocom-stationfall` | Stationfall | 1987 | Science-fiction institutional prose, companion continuity, station documents | `UNINVENTORIED` |
| `infocom-lurking-horror` | The Lurking Horror | 1987 | Horror restraint, campus documents, weather and underground atmosphere | `UNINVENTORIED` |
| `infocom-nord-and-bert` | Nord and Bert Couldn’t Make Head or Tail of It | 1987 | Wordplay classification, pun mechanics, language-game contrast corpus | `UNINVENTORIED` |
| `infocom-plundered-hearts` | Plundered Hearts | 1987 | Relationship and romantic-adventure prose; contrast and historical reference | `UNINVENTORIED` |
| `infocom-beyond-zork` | Beyond Zork: The Coconut of Quendor | 1987 | GUE expansion, RPG-like state language, geography and lore | `UNINVENTORIED` |
| `infocom-border-zone` | Border Zone | 1987 | Multi-perspective suspense, real-time pressure, espionage documents | `UNINVENTORIED` |
| `infocom-sherlock` | Sherlock: The Riddle of the Crown Jewels | 1988 | Adaptation, investigation, London documents and companion interaction | `UNINVENTORIED` |
| `infocom-zork-zero` | Zork Zero: The Revenge of Megaboz | 1988 | GUE history, illustrated presentation, encyclopedia and puzzle language | `UNINVENTORIED` |
| `infocom-shogun` | James Clavell’s Shōgun | 1989 | Adaptation, historical register and glossary/manual structure; contrast corpus | `UNINVENTORIED` |
| `infocom-arthur` | Arthur: The Quest for Excalibur | 1989 | Adaptation, medieval documentation, illustrated interface prose | `UNINVENTORIED` |
| `infocom-journey` | Journey: The Quest Begins | 1989 | Menu-driven narrative, party interaction and late-Infocom presentation | `UNINVENTORIED` |

## Zork-first artifact breakdown

These are the first artifact families to enumerate at edition level.

### Zork I

Required records include, where they existed:

- Personal Software zip-bag manual;
- early Infocom manual editions;
- folio or blister package text;
- grey-box manual/browsie;
- grey-box exterior and tray copy;
- disk labels;
- platform reference cards;
- sample transcripts;
- warranty and registration material;
- advertisements and catalog entries;
- InvisiClues booklet and maps;
- trilogy-box documentation;
- Solid Gold documentation;
- Lost Treasures and later collection documentation;
- authorized downloadable-release readme files;
- PDP-11 documentation and other historically significant variants;
- original ZIL player-visible strings by release lineage;
- known shipped-version text differences.

### Zork II

Required records include:

- early package and folio text;
- manuals and instruction sheets;
- grey-box documentation;
- reference cards;
- sample transcripts;
- InvisiClues and maps;
- trilogy and collection documentation;
- Solid Gold material where applicable;
- source-prose extraction and version differences.

### Zork III

Required records include:

- early package and folio text;
- manuals and instruction sheets;
- grey-box documentation;
- reference cards;
- sample transcripts;
- InvisiClues and maps;
- trilogy and collection documentation;
- Solid Gold material where applicable;
- source-prose extraction and version differences.

## Great Underground Empire expansion set

These titles receive elevated processing priority after the trilogy:

1. Enchanter
2. Sorcerer
3. Spellbreaker
4. Wishbringer
5. Beyond Zork
6. Zork Zero

For each, inventory:

- source prose;
- manuals;
- reference cards;
- packaging;
- feelies;
- hints;
- maps;
- newsletters and advertisements;
- edition variants;
- later collection reproductions.

Their language is evidence for GUE institutions, magic, history, and product presentation, but does not automatically override Zork I authority.

## Company-wide publication families

### Newsletters

- *The New Zork Times*;
- *The Status Line*;
- subscription notices;
- letters to readers;
- game announcements;
- contests;
- columns;
- advertisements;
- catalogs embedded in newsletters.

Status: `UNINVENTORIED`

### InvisiClues

For every title with official InvisiClues:

- booklet cover and instructions;
- question hierarchy;
- invisible-answer text;
- map package;
- order forms;
- hint subscription or catalog material;
- edition differences;
- Solid Gold on-screen hint variants where applicable.

Status: `UNINVENTORIED`

### Catalogs and advertisements

- company catalogs;
- seasonal catalogs;
- dealer sheets;
- magazine advertisements;
- direct-mail advertisements;
- sampler packaging;
- compilation advertisements;
- order forms.

Status: `UNINVENTORIED`

### Samplers and tutorials

- four-in-one samplers;
- Mini-Zork material;
- Zork demos;
- tutorial text;
- non-interactive sample transcripts;
- magazine-bundled descriptions;
- platform-specific sampler instructions.

Status: `UNINVENTORIED`

### Collections and rereleases

- Zork Trilogy;
- Enchanter Trilogy;
- Science-Fiction Classics;
- Classic Mystery Library;
- Lost Treasures of Infocom I and II;
- Masterpieces of Infocom;
- 1995 genre collections;
- Solid Gold editions;
- Mastertronic editions;
- Commodore, Digital, Dysan, and other licensed repackagings;
- downloadable releases;
- official readme and installation documentation.

Status: `UNINVENTORIED`

## Non-core Infocom and adjacent published products

These may contain useful company-language or documentation evidence and should be inventoried separately rather than mixed into the 35-game IF catalog.

### Fooblitzky

Potential artifacts:

- rules;
- Official Ordinances, Rules and Regulations for the City of Fooblitzky;
- workboards;
- package copy;
- labels and supporting sheets.

Status: `UNINVENTORIED`

### Infocomics

Inventory each title, player instruction, package surface, advertisement, and supporting document.

Known title family includes:

- ZorkQuest: Assault on Egreth Castle;
- ZorkQuest II: The Crystal of Doom;
- Lane Mastodon vs. the Blubbermen;
- Gamma Force in Pit of a Thousand Screams.

Status: `UNINVENTORIED`

### Cornerstone

Inventory:

- user manuals;
- tutorials;
- reference cards;
- package copy;
- advertisements;
- internal or public technical documentation where licensed.

Status: `UNINVENTORIED`

### Infocom-published or late-label graphical/RPG products

Inventory publication responsibility and exact relevance before inclusion:

- Quarterstaff;
- BattleTech: The Crescent Hawk’s Inception;
- other products carrying Infocom branding or documentation.

These are a separate product-document corpus, not automatic interactive-fiction style authority.

Status: `UNINVENTORIED`

## Internal and historical-source material

Potential categories:

- ZIL source repositories;
- discarded or alternate source strings;
- internal manuals;
- Implementor notes;
- testing transcripts;
- style guidance;
- technical papers;
- parser and Z-machine documentation;
- production memos;
- newsletters for employees;
- source-drive artifacts.

Each item requires its own rights and privacy review. Historical availability is not enough.

Status: `INVENTORY_STARTED`

## Authoritative source locations to record

Every artifact record should consider, without assuming redistribution rights:

- the Infocom Documentation Project;
- the Infocom Gallery;
- the IF Archive shipped-documentation collection;
- the Museum of Computer Adventure Game History;
- Historical Source repositories;
- official or authorized Infocom/Activision download pages;
- physical copies held by Justin or contributors;
- library, museum, and archive catalogs;
- archived official web pages;
- collector scans with verifiable provenance.

A preferred source ranking should favor:

1. original physical artifact;
2. rights-holder or expressly permissioned preservation copy;
3. high-quality facsimile scan;
4. verified plain-text transcription;
5. collection reproduction;
6. secondary quotation or description.

## Artifact record template

```yaml
artifact_id: infocom-zork1-greybox-manual-en-us-r1
product_id: infocom-zork1
title: Zork I Manual
artifact_type: manual
release_family: grey-box
edition: unknown
platform_scope: universal
language: en-US
publication_year: 1984
source_kind: permissioned-preservation-site
source_url: https://...
local_source_path: null
source_sha256: null
rights_class: B
rights_basis: permission-does-not-yet-cover-this-repository
repository_text_policy: metadata-and-analysis-only
page_count: null
transcription_status: manifest-only
annotation_status: none
review_status: unreviewed
notes: []
```

## Definition of corpus completeness

The corpus cannot be called complete until:

- all 35 core IF titles have edition-aware artifact inventories;
- all known manuals, reference cards, sample transcripts, package surfaces, feelies, official hints, and maps are accounted for;
- newsletters, catalogs, samplers, and major rereleases are inventoried;
- rights status is explicit for every artifact;
- every committed full text has a verified repository rights basis;
- protected local-only texts have hashes and metadata without accidental publication;
- Zork I–III source prose is extracted and classified;
- GUE lineage materials are separated from broader Infocom contrast material;
- transcription uncertainty and edition conflicts remain visible;
- style profiles are derived from tagged surfaces rather than an undifferentiated text dump.

## Immediate first pass

The first implementation pass should not begin by OCRing random PDFs.

It should:

1. create the real `reference/infocom-corpus/` structure on a fresh post-House branch;
2. write the schemas and rights gate;
3. build the artifact manifest;
4. extract licensed Zork I player-visible source strings with provenance;
5. enumerate every known Zork I documentation edition;
6. establish local-only ingestion for protected scans;
7. generate the first Zork-specific style profiles;
8. apply a style receipt to one bounded new prose family as proof.

That produces a trustworthy foundation rather than a pile of text files with unknown origin and mixed voices.
