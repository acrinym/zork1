# Release 1268 — Clue Chains & Knowledge-Gated Interpretation

Release 1268 lets learned meaning travel across the map without turning clue objects into inventory keys or creating a generic detective notebook.

## Player-facing chain

The first authored chain uses three existing physical locations and one new field marking:

1. In the **North Temple**, deliberately `INTERPRET PRAYER`. The canonical prayer remains fixed on the wall; the Adventurer learns a small, named piece of ancient-script grammar from the rough meaning he can already recover.
2. In the **Engravings Cave**, `INTERPRET ENGRAVINGS`. Without the Temple grammar, the damaged symbolic material is too incomplete to separate notation from decoration. With that remembered grammar, one surviving practical motif becomes recognizable: paired angles around rising strokes denote a bounded opening that carries breath or moving air.
3. In the **Dragon Gallery**, an old geometric marking is visible in the heat-darkened basalt. Before the motif is known, `EXAMINE MARKING` reports its physical pattern but not its meaning. After the motif is learned, the same examination is intelligible.
4. `INTERPRET MARKING` follows that remembered meaning into the room's real soot geometry and identifies Release 1267's existing `DRAGON-VENT-SEAM`.

The source prayer and engravings never move. What crosses the world is learned interpretation.

## Existing authorities preserved

- canonical `PRAYER` remains the only North Temple prayer and its canonical `TEXT` is unchanged;
- canonical `ENGRAVINGS` remains the only Engravings Cave wall inscription and its canonical `TEXT` is unchanged;
- Release 1267 `SEMANTIC-DRAGON-BLACKENING` still independently discovers the same ventilation seam through physical examination;
- Release 1267 `DRAGON-VENT-SEAM` remains the only ventilation structure and keeps its smoke/fire behavior;
- Release 1262 dragon and Release 1257 fire/smoke authorities are untouched;
- Release 1266 learned-magic knowledge remains separate; this release does not turn `KNOWLEDGE` into a generic notebook.

## State model

Three exact facts live in one compact table: enough ancient-script grammar to compare a second source, the specific ancient air-passage motif, and whether the Gallery field mark has been interpreted.

There are zero new legacy VM globals and no generic clue registry. Save/restore persistence follows ordinary mutable story-table semantics.

## Qualification contract

The hosted qualifier reruns the complete locked Release 1267 chain, stages only `clue_interpretation.zil` and release/include wiring in `zork1.zil`, compiles production and test stories, and drives five natural-command histories:

1. Engravings Cave interpretation fails safely before the Temple grammar is learned;
2. Temple grammar and Engravings motif are learned across fixed source clues that remain physically in their original rooms;
3. the Dragon Gallery marking remains uninterpretable and does not expose the seam without prior knowledge;
4. the complete clue chain changes later examination and identifies the existing ventilation seam;
5. Release 1267's blackening route still independently discovers that same seam with zero clue knowledge.

## Boundaries

- no generic clue counter or clue registry;
- no notebook, quest log, or clue inventory;
- no generic symbol parser or archaeology engine;
- no moving/copying the Temple prayer or cave engravings;
- no second ventilation seam or alternate smoke model;
- no automatic hint engine;
- no interpretation that reconstructs the deliberately excised ancient doctrine beyond the bounded practical motif the surviving material supports.
