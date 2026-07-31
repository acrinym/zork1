# Infocom Corpus Foundation

This directory is the working language authority for **Highly Extended Zork**. It does not ask a model to “sound like Infocom.” It identifies exact source authorities, keeps protected study material outside Git, derives auditable linguistic evidence, and blocks suspicious source-phrase reuse before new prose is accepted.

## Product boundary

This train is independent of the completed House of Records program. It does not reopen House beads, alter Release 1230, implement Mara, build the museum, add cuisine, start Living Zork, or touch the separate S.T.A.L.K.E.R. lane.

## What is committed

- `manifest/infocom-corpus.json` — edition-level Zork I artifact records and per-artifact rights gates.
- `manifest/zork1-source-lineage.json` — the exact live `master` entrypoint/include chain and Git blob identities resolved for this train.
- `profiles/authority-profiles.json` — separate narrator, object, parser, death, action, actor, manual, transcript, institutional-document, and hint authority contracts.
- `schemas/` — interoperable artifact, local corpus-record, correction-record, and style-receipt schemas.
- `tools/infocom_corpus/` — executable standard-library extraction, annotation, profile, fingerprint, correction, overlap, and receipt tooling.
- `tests/test_infocom_corpus.py` — focused qualification of the actual product boundaries.

Protected source prose is **not** committed by this train.

## Rights model

The rights class belongs to each artifact and edition. A root repository license is not silently treated as permission for every imported historical file or external scan.

| Class | Meaning | Repository treatment |
|---|---|---|
| A | Verified repository-licensed text | Full text only when the license is verified for this repository |
| B | Permissioned elsewhere, not verified here | Metadata, hashes, references, and derived analysis |
| C | Lawfully held local study copy | Local extraction; public hashes, page references, corrections, and statistics |
| D | Verified public-domain or independent license | Treatment allowed by the verified license |
| E | Unknown, disputed, or unresolved | Metadata and non-expressive analysis only |

A full-text export is permitted only when all three conditions are true:

1. rights class is `A` or `D`;
2. `verification` is `verified-for-this-repository`;
3. `repository_text_policy` is `full-text-verified`.

The current selected Zork I source snapshot is intentionally **not** marked that way. Its extracted corpus therefore belongs under `.local/infocom-corpus/`.

## Run the complete local pipeline

From the repository root:

```bash
python -m tools.infocom_corpus validate-manifest \
  --manifest reference/infocom-corpus/manifest/infocom-corpus.json

python -m tools.infocom_corpus extract \
  --repo-root . \
  --manifest reference/infocom-corpus/manifest/infocom-corpus.json \
  --out .local/infocom-corpus/zork1.player-visible.jsonl \
  --summary-out .local/infocom-corpus/zork1.public-summary.json

python -m tools.infocom_corpus annotate \
  --corpus .local/infocom-corpus/zork1.player-visible.jsonl \
  --out .local/infocom-corpus/zork1.annotated.jsonl

python -m tools.infocom_corpus profile \
  --corpus .local/infocom-corpus/zork1.annotated.jsonl \
  --profiles reference/infocom-corpus/profiles/authority-profiles.json \
  --out .local/infocom-corpus/zork1.derived-profiles.json

python -m unittest discover -s tests -p 'test_infocom_corpus.py' -v
```

The extractor recursively follows the selected `INSERT-FILE` chain. It resolves historical case differences, computes SHA-256 for every source file, records line and byte spans, and classifies strings found in player-visible ZIL forms such as `DESC`, `LDESC`, `FDESC`, and `TELL`. Standalone source comments and compiler banners are excluded.

The local JSONL contains source text because linguistic analysis requires it. The safe summary contains record hashes, source paths, source hashes, line references, surface classes, authority profiles, and aggregate counts—but no prose.

## Protected manuals, feelies, scans, and OCR

Place protected study material only below:

```text
.local/infocom-corpus/
```

Fingerprint a local artifact without copying its text into Git:

```bash
python -m tools.infocom_corpus fingerprint-local \
  --artifact-id infocom-zork1-greybox-manual-en-us \
  --source .local/infocom-corpus/sources/zork1-greybox-manual.pdf \
  --page-count 24 \
  --page-reference 'p. 7: command examples' \
  --out .local/infocom-corpus/fingerprints/zork1-greybox-manual.json
```

The output contains SHA-256, byte size, page count, and page references. It does not contain the file path or document text.

Correction records for protected artifacts are hash-and-location records. They may identify a page, surface, block, or source line, but raw observed/corrected wording is rejected unless the artifact has verified repository full-text rights.

```bash
python -m tools.infocom_corpus validate-corrections \
  --manifest reference/infocom-corpus/manifest/infocom-corpus.json \
  --corrections .local/infocom-corpus/corrections/zork1-greybox.jsonl
```

## Authority profiles

There is no `INFOCOM_STYLE` profile.

Each profile names:

- actual primary authorities;
- secondary authorities;
- voices that must not leak into the family;
- retained linguistic traits;
- permitted intentional departures;
- necessary canonical phrases that should not create false overlap failures;
- whether evidence is executable from repository source, executable from a local study copy, or manifest-only until the artifact is acquired.

Shared trilogy files remain tagged as shared trilogy infrastructure. Zork I-specific room, object, and action files remain Zork I-specific. Later profiles can become more granular without losing this origin.

## Originality and style receipts

Check candidate prose against the local corpus:

```bash
python -m tools.infocom_corpus overlap \
  --candidate path/to/new-prose.txt \
  --corpus .local/infocom-corpus/zork1.annotated.jsonl \
  --profiles reference/infocom-corpus/profiles/authority-profiles.json \
  --profile-id zork1-narrator \
  --out .local/infocom-corpus/receipts/new-prose.overlap.json
```

The validator checks:

- longest contiguous token overlap;
- uncommon five-token phrase matches containing meaningful content;
- profile-specific allowed canonical phrases.

Reports disclose record IDs, token positions, and hashes—not protected source passages.

A passing candidate can receive a committed style receipt:

```bash
python -m tools.infocom_corpus receipt \
  --candidate path/to/new-prose.txt \
  --corpus .local/infocom-corpus/zork1.annotated.jsonl \
  --profiles reference/infocom-corpus/profiles/authority-profiles.json \
  --profile-id zork1-narrator \
  --surface-family museum-entry-hall \
  --reviewer Justin \
  --intentional-departure 'The persistent museum custody state requires one explicit provenance sentence.' \
  --out path/to/new-prose.style-receipt.json
```

The receipt records the candidate hash, actual authorities, excluded voices, retained traits, intentional departures, corpus digest, overlap thresholds, longest overlap, rare-match count, and reviewer. It cannot be issued when overlap validation fails.

## Contract for later product trains

Every substantial new prose family must ship with a style receipt. A train cannot substitute a generic prompt, an untraceable “Infocom-like” claim, or an averaged company-wide voice.

Later trains must deliberately select their evidence:

- a museum plaque needs a dedicated child of the object/institutional-document profiles;
- Mara needs a named human-dialogue profile and must explicitly exclude generic companion banter;
- a death family uses causal-warning evidence plus `zork1-death`;
- parser refusals use `zork1-parser-refusal`, not narrator comedy;
- recipes and cuisine failures require their own authorities and departures.

The corpus foundation is complete as tooling and governance. Its protected evidence coverage grows only through lawful local acquisition or verified repository permission; absence of permission never becomes permission by convenience.
