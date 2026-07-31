# Infocom Corpus Foundation — Product Train

**Repository:** `acrinym/zork1`  
**Base:** live `master` at `552f52e56cb8c87a40f9e67af65b56001c4667db`  
**Branch:** `agent/infocom-corpus-foundation-20260731`  
**Date:** July 31, 2026  
**House of Records:** closed and untouched  
**S.T.A.L.K.E.R.:** separate and untouched  
**Merge policy:** implementation PR remains open until Justin gives the explicit merge whistle

## Product result

The Infocom Corpus Foundation is promoted from concept material into an executable Zork-first corpus product.

It now provides one connected path from source identity to prose approval:

1. identify the selected Zork I source lineage;
2. validate edition and rights metadata;
3. extract player-visible ZIL strings locally with exact provenance;
4. classify prose surfaces and authority profiles;
5. attach reproducible linguistic annotations;
6. derive non-expressive statistics without committing protected prose;
7. fingerprint protected local documents without copying them;
8. validate hash-only transcription corrections;
9. compare new prose against source wording;
10. issue a style receipt naming authorities, exclusions, retained traits, departures, and originality results.

## Delivered train

### 1. Rights-aware edition manifest

`reference/infocom-corpus/manifest/infocom-corpus.json`

The manifest contains thirteen concrete Zork-first records:

- the selected development-drive ZIL snapshot;
- Personal Software zip-bag documentation;
- early Infocom folio documentation;
- grey-box manual/browsie;
- grey-box package surfaces;
- product sample transcript;
- InvisiClues booklet;
- InvisiClues map;
- Zork Trilogy documentation;
- Solid Gold manual;
- Solid Gold integrated hints;
- Lost Treasures I documentation;
- platform reference-card edition set.

Unknown dates, release numbers, and fingerprints remain explicitly unresolved rather than guessed. Each acquired physical or verified digital variant can be split into a child edition while retaining the stable family identity.

### 2. Exact source-lineage receipt

`reference/infocom-corpus/manifest/zork1-source-lineage.json`

The selected entrypoint and its nine included files are bound to the live base by Git blob SHA. Each file is tagged as Zork I-specific or shared trilogy infrastructure. Local extraction adds content SHA-256, line spans, and record hashes.

### 3. Real extraction

`tools/infocom_corpus/core.py`

The extractor is not a regular-expression dump of every quoted string. It:

- follows recursive `INSERT-FILE` references;
- resolves historical case differences safely inside the repository root;
- lexes ZIL strings while ignoring source comments;
- tracks angle-form and property-form context;
- excludes standalone documentation strings and compiler output;
- recognizes player-visible description and output forms;
- records source file SHA-256, line range, byte range, context head, entity, and routine;
- assigns a prose surface and default authority profile;
- emits full text only to the local protected area unless rights are verified.

### 4. Annotation and profiles

The annotation layer records sentence rhythm, fragments, punctuation, function-word ratio, second-person stance, sensory markers, narrator-stance evidence, parser failure class, and comedy-mechanic markers.

Derived profiles contain aggregate statistics and hashes, never source prose. Ten authority contracts separate narrator, object, parser, death, action, actor, manual, transcript, institutional-document, and hint behavior.

### 5. Protected-study workflow

A local scan or PDF can be fingerprinted into a safe record containing SHA-256, byte size, page count, and page references. The tool never copies the source file.

Protected correction records are validated against the artifact rights class. Raw correction text is rejected for metadata-only artifacts; hashes and exact page/block/line references remain allowed.

### 6. Originality validation

The overlap validator checks contiguous phrase reuse and uncommon five-token matches. It records candidate/source span hashes, record IDs, and token positions while withholding protected source wording.

Necessary canonical phrases are profile-scoped. They do not become a broad escape hatch for copied sentences.

### 7. Style receipts

A receipt cannot pass without:

- a named surface family;
- a real authority profile;
- non-empty primary authorities;
- explicit excluded voices;
- retained linguistic traits;
- intentional departures;
- a passing overlap report;
- candidate and corpus hashes;
- a reviewer.

This is the enforceable replacement for “make it sound like Infocom.”

## Qualification truth

Local qualification performed against the completed implementation:

```text
python -m unittest discover -s tests -p 'test_infocom_corpus.py' -v
Ran 9 tests
OK
```

The tests cover:

- rights-complete manifest validation;
- rejection of unauthorized full-text publication;
- recursive, case-insensitive source inclusion;
- player-visible extraction and build-comment exclusion;
- room/object surface classification;
- non-destructive linguistic annotation;
- long phrase-overlap blocking without source disclosure;
- passing style-receipt generation;
- non-expressive profile output;
- protected artifact fingerprint safety;
- hash-only correction enforcement.

No GitHub Actions workflow was added. The product is standard-library Python and qualifies locally without consuming repository Actions budget.

## Explicit non-work

This train does not:

- reopen any House hierarchy or bead;
- alter Release 1230 game behavior;
- create an `INFOCOM_STYLE` average;
- download or commit manuals, feelies, scans, or OCR;
- claim the root license clears imported Infocom prose;
- implement Mara;
- implement museum intake;
- implement cuisine, hunger, satiation, or stamina;
- implement Living Zork deaths;
- implement Zork Plus or the expedition stash;
- add S.T.A.L.K.E.R. material.

Those product families remain deliberately sequenced after this foundation.

## Next consumer

The next prose-bearing product train must:

1. choose a surface-specific authority profile;
2. add a child profile when the existing one is too broad;
3. name excluded voices;
4. author original candidate prose;
5. run local overlap validation;
6. commit the passing style receipt beside the prose;
7. keep the source corpus local unless its artifact rights permit publication.

The implementation PR must remain open until Justin explicitly orders the merge.
