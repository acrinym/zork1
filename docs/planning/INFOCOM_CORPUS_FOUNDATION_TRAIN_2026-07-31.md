# Infocom Corpus Foundation — Product Train

**Repository:** `acrinym/zork1`  
**Base:** live `master` at `552f52e56cb8c87a40f9e67af65b56001c4667db`  
**Branch:** `agent/infocom-corpus-foundation-20260731`  
**Date:** July 31, 2026  
**House of Records:** closed and untouched  
**S.T.A.L.K.E.R.:** separate and untouched

## Product result

The Infocom Corpus Foundation is an executable, rights-aware Zork-first corpus product. It connects source identity to prose approval without treating “sound like Infocom” as a usable specification.

The complete path is:

1. identify the selected Zork I source lineage;
2. validate edition and rights metadata;
3. extract player-visible ZIL strings locally with source provenance;
4. classify prose surfaces and authority profiles;
5. derive non-expressive linguistic annotations and statistics;
6. fingerprint protected local documents without copying their prose;
7. validate hash-only corrections;
8. compare candidate prose against every over-threshold source overlap;
9. issue a passing style receipt only when rights, authority, and originality gates hold.

## Delivered product

- Thirteen concrete Zork I artifact and edition records with per-artifact rights gates.
- Exact `zork1.zil` recursive include lineage with repository blob identities.
- Case-insensitive historical include resolution confined to the repository root.
- ZIL tokenization that excludes comments and compiler banners while retaining player-visible forms.
- True UTF-8 byte offsets, source hashes, line spans, entity/routine context, surface family, and authority profile per record.
- Ten separate authority contracts for narrator, object, parser, death, action, actor, manual, transcript, institutional documents, and hints.
- Protected local-copy fingerprints restricted to `.local/infocom-corpus/` and structural page/block/surface/line references.
- Canonical corpus digest shared by extraction, profiles, public summaries, and style receipts.
- Full overlap evaluation across all source records, including ties and prohibited matches hidden behind an allowed longer phrase.
- Style receipts requiring authorities, exclusions, retained traits, intentional departures, valid hashes, and zero originality violations.
- Standard-library CLI, schemas, documentation, and direct behavioral qualification.

## Review closure

The review train fixed every valid major, minor, critical, and nit-level finding:

- schema-level full-text rights enforcement;
- concrete correction locators;
- mandatory receipt departures and SHA-256 corpus digest;
- all-record source-prose disclosure assertions;
- canonical digest consistency;
- typed `authority_order` validation;
- normalized strict UTF-8 failures;
- escaped-backslash ZIL string termination;
- true UTF-8 byte provenance;
- stale annotation rebuilding;
- complete per-record overlap violation collection;
- local fingerprint containment and source-text-safe references;
- fail-closed extraction output policy for absolute and out-of-repository paths;
- production docstrings and focused module boundaries rather than artificial coverage padding.

No recursive audit framework, audit-of-audit layer, test generator, or meta-validation system was added. Existing tests were strengthened and one direct regression test was added for the newly discovered output-path vulnerability.

## Qualification truth

Local qualification performed against the published implementation content:

```text
python -m unittest discover -s tests -p 'test_infocom_corpus*.py' -v
Ran 25 tests
OK

python -m py_compile tools/infocom_corpus/*.py tests/test_infocom_corpus*.py
OK
```

The tests directly cover rights gates, schemas, lineage resolution, extraction, escaping, UTF-8 failures, byte offsets, annotations, source-prose exclusion, digest consistency, overlap edge cases, receipts, fingerprints, correction records, and fail-closed output paths.

No GitHub Actions workflow was added or consumed.

## Explicit non-work

This train does not reopen the House hierarchy, alter Release 1230 gameplay, create a universal `INFOCOM_STYLE`, publish protected manuals or OCR, implement Mara, museum intake, cuisine, Living Zork, Zork Plus, expedition storage, or S.T.A.L.K.E.R.

## Next consumer

The next product train must couple the corpus to real gameplay by selecting named surface profiles, authoring original player-visible prose, validating overlap locally, and committing style receipts beside the gameplay evidence. A version-controlled product kanban will make current, next, future, parked, and completed trains explicit.
