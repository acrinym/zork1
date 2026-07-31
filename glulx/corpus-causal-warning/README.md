# Release 1231 — Corpus-Coupled Causal Warning

This train is the first gameplay consumer of the Infocom Corpus Foundation. It couples original, receipt-backed prose to the canonical Maintenance Room flood while leaving the actual puzzle machinery intact.

## Player-facing result

After the blue button breaks the east-wall pipe, the player receives:

- immediate notice that the west and south exits remain open;
- three deduplicated warnings tied to the real `WATER-LEVEL`;
- an inspectable physical break with one non-spoiling repair affordance;
- visible confirmation that a successful repair stops pressure and drains the room;
- a causal death line if the player remains through the final flood stage.

## Canonical authority

Release 1231 does not create another flood system:

- `WATER-LEVEL` is the only water state;
- `I-MAINT-ROOM` is the only rising-water clock event;
- `LEAK` is the real break;
- PUTTY and `FIX-MAINT-LEAK` remain the repair route;
- the room's west and south exits remain escape routes;
- `JIGS-UP` remains death/restart authority.

The new globals remember only whether cause/examination/repair were seen and which warning stage has already spoken.

## Corpus evidence

`qualification/corpus-evidence.json` contains the exact candidate families, hash-only source receipt, overlap results, and style receipts. It records selected authority profiles, retained traits, excluded voices, intentional departures, candidate hashes, and the corpus digest without committing canonical source prose.

## Run direct qualification

```bash
python -m unittest discover -s tests -p 'test_corpus_causal_warning.py' -v
python -m py_compile glulx/corpus-causal-warning/stage.py tests/test_corpus_causal_warning.py
```

Run the complete source/staging route:

```bash
bash glulx/corpus-causal-warning/qualify.sh
```

The full route stages over locked Release 1230 and runs the repository ZIL smell checker. Artifact compilation requires the existing local ZILF/Glazer toolchain; this train does not download toolchains or consume GitHub Actions merely to manufacture an identity receipt.
