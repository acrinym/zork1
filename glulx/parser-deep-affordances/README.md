# Release 1232 — Parser Comprehension and Deep Affordances

Release 1232 connects a small set of reasonable player phrases to behavior Zork already understands. It does not add a universal intent engine, guess puzzle solutions, or replace the parser.

## Player-facing result

The following command families now reach canonical actions:

- `X OBJECT` and `INSPECT OBJECT` → `EXAMINE OBJECT`;
- `EXAMINE UNDER OBJECT` → `LOOK UNDER OBJECT`;
- `EXAMINE BEHIND OBJECT` → `LOOK BEHIND OBJECT`;
- `SWITCH ON OBJECT` and `SWITCH OFF OBJECT` → existing `TURN ON/OFF` grammar;
- `SEAL OBJECT WITH OBJECT` and `MEND OBJECT WITH OBJECT` → existing `PLUG` grammar.

The selected additions repair vocabulary and noun-role gaps. They do not alter the action routines that decide what physically happens.

## Explicit boundary

Release 1211 already contains bounded `USE OBJECT` assistance. It describes plausible affordances and tells the player to choose a concrete verb; it does not execute a guessed action. Release 1232 preserves that command unchanged and adds no new or broader `USE` routing.

The train adds no parser global, parser state, new `V-*` routine, player-visible response prose, generic synonym inventory, or change to the Release 1211 assistance layer. Because all responses remain canonical, aliases do not require invented replacement prose or artificial style receipts.

## Qualification

```bash
bash glulx/parser-deep-affordances/qualify.sh
```

The complete route runs seven direct tests, stages over locked Release 1231, checks the exact two-file delta, runs the ZIL smell check, compiles with ZILF, assembles with Glazer, verifies the ULX, builds Glulxe/CheapGlk, and types the selected phrases into the actual game.

The successful runtime transcript proves canonical examination, spatial inspection, plugging, and lantern-state responses. None of the selected words is rejected as unknown.

Locked Release 1232 artifact:

```text
serial:   260731
size:     337920 bytes
checksum: 0x2c2192e1
sha256:   2cffc734dbfbe346d0ec185c6962d927bc046343dccdb53b6a9e4439521b6f2e
```

`.github/workflows/glulx-parser-deep-affordances.yml` runs the exact route on GitHub-hosted CI with pinned source, compiler, assembler, and interpreter revisions and uploads the story, transcript, receipts, and build logs. A second hosted run must reproduce the locked identity before merge.
