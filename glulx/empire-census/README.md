# Release 1303 — Empire Noun Honesty (1301–1303)

One locked Glulx story staging **1296**. Planning map:

- **1301** survey flags `--no-killing` / `--no-reset-on-death` exist only on the test story and `survey_cli.py`. They are never in the production `.ulx`.
- **1302** census ledger: `docs/planning/DESCRIBED_WORLD_CENSUS_1302.md`
- **1303** remaining reachable-map nouns become parser-real on flagless play.

No GUI. No AI. No scenery engine. Does not steal 1280–1292.

Production `.ulx` must not contain `SURVEYKILL`, `SURVEYREWIND`, or the SVY* test verbs.

Merges go to `acrinym/zork1` `master` only.
