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

There is deliberately no generic `USE` verb. `USE LANTERN`, `USE SWORD`, or `USE PUTTY` can represent several different intentions, and guessing one would leak solutions or change player meaning. Release 1232 adds only phrases whose destination is unambiguous.

The train adds:

- no parser global;
- no parser state;
- no new `V-*` action routine;
- no new player-visible response prose;
- no generic synonym inventory.

Because all responses remain canonical, this train does not manufacture a new corpus style receipt merely for aliases.

## Qualification

```bash
bash glulx/parser-deep-affordances/qualify.sh
```

The complete route runs direct tests, stages over locked Release 1231, checks the exact two-file delta, runs the ZIL smell check, compiles with ZILF, assembles with Glazer, verifies the ULX, builds Glulxe/CheapGlk, and types the new phrases into the actual game.

The runtime transcript must prove:

- both `X` and `INSPECT` examine the mailbox;
- `EXAMINE UNDER` and `EXAMINE BEHIND` reach canonical spatial responses;
- `SEAL` and `MEND` reach canonical plugging behavior;
- `SWITCH ON/OFF LANTERN` changes the real lamp state;
- none of the selected words is rejected as unknown.

`.github/workflows/glulx-parser-deep-affordances.yml` runs this route on GitHub-hosted CI with pinned source, compiler, assembler, and interpreter revisions and uploads the story, transcript, receipts, and build logs.
