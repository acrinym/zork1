# Release 1231 — Corpus-Coupled Causal Warning

This train is the first gameplay consumer of the Infocom Corpus Foundation. It couples original, receipt-backed prose to the canonical Maintenance Room flood while leaving the actual puzzle machinery intact.

## Player-facing result

After the blue button breaks the east-wall pipe, the player receives:

- immediate notice that the west and south exits remain open;
- three one-time warnings tied to exact canonical `WATER-LEVEL` crossings;
- an inspectable physical break with one non-spoiling repair affordance;
- visible confirmation that a successful repair stops pressure and drains the room;
- a causal death line if the player remains through the final flood stage.

## Canonical authority

Release 1231 does not create another flood system or any new flood state:

- `WATER-LEVEL` is the only water state;
- `I-MAINT-ROOM` is the only rising-water clock event;
- exact levels 3, 5, and 11 make the three warnings naturally one-time;
- `LEAK` is the real break;
- PUTTY and `FIX-MAINT-LEAK` remain the repair route;
- the room's west and south exits remain escape routes;
- `JIGS-UP` remains death/restart authority.

Hosted ZILF qualification exposed that Release 1230 already used all available globals. The earlier warning-stage global was removed rather than hidden, compressed, or moved into another controller.

## Corpus evidence

`qualification/corpus-evidence.json` contains the exact candidate families, hash-only source receipt, overlap results, and style receipts. It records selected authority profiles, retained traits, excluded voices, intentional departures, candidate hashes, and the corpus digest without committing canonical source prose.

## Run direct qualification

```bash
python -m unittest discover -s tests -p 'test_corpus_causal_warning*.py' -v
python -m py_compile \
  glulx/corpus-causal-warning/stage.py \
  tests/test_corpus_causal_warning*.py
bash -n glulx/corpus-causal-warning/qualify.sh
```

## Run complete source and artifact qualification

```bash
bash glulx/corpus-causal-warning/qualify.sh
```

The complete route:

1. runs the direct gameplay, evidence, and kanban tests;
2. stages exactly three production paths over locked Release 1230;
3. runs the repository ZIL smell checker;
4. compiles the staged story to Glulx assembly with ZILF;
5. normalizes serial `260731`;
6. assembles the Release 1231 ULX with Glazer;
7. verifies format, Glulx version, checksum, and nonzero artifact size;
8. writes `QUALIFICATION-RECEIPT.json`.

`.github/workflows/glulx-corpus-causal-warning.yml` runs that exact route on GitHub-hosted CI using pinned Zork source, pinned Glulx ZILF, and checksum-verified Glazer 1.2.0. It uploads the ULX, assembly, receipts, reports, and build logs.

The receipt deliberately does not claim an interactive runtime transcript. Source coupling, staging, corpus evidence, compilation, assembly, and artifact integrity are the qualified routes in this train.
