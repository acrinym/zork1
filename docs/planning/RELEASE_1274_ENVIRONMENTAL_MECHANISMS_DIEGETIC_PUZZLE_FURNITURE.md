# Release 1274 — Environmental Mechanisms & Diegetic Puzzle Furniture

**Queued after:** Release 1273 — Living Biomes & Wilderness Expansion  
**Status:** planned; do not implement before the earlier queued trains unless the product order is explicitly changed.

## Inspiration and purpose

Use the environmental-puzzle language common to survival-horror adventure games as a design lens, especially the pattern where an ordinary-looking piece of architecture or furniture contains an authored mechanism revealed through observation and manipulation.

The principle is not to copy Resident Evil rooms, puzzle solutions, prose, art, object arrangements, keys, crests, statues, or exact sequences. The principle is to translate the interaction grammar into Zork-native parser play:

**notice an irregularity → examine it → learn a physical fact → manipulate the right concrete detail → the environment changes**.

In graphical adventure games the first step is often visual. In Zork the prose supplies the picture and the parser supplies a larger language space than a contextual interaction button.

## Player outcome

Rooms can contain authored mechanisms disguised as ordinary environment: a book that behaves unlike neighboring books, a painting whose frame is physically wrong, a clock whose stopped position matters, a clean brick in a sooty fireplace, a movable relief element, a recessed catch, a pivoting shelf, a pressure plate, a mismatched tile, or another concrete irregularity.

The player should be able to investigate that irregularity with sensible language and receive physically truthful responses. The puzzle should reward noticing *why the narrator mentioned that detail* without requiring one magic phrase.

## Core interaction doctrine

A representative puzzle may support a chain such as:

- `EXAMINE BOOK` notices missing dust or an unusual hinge;
- `TAKE BOOK` reveals that it moves only partway and catches;
- `PULL BOOK` trips a concealed latch;
- the bookcase physically pivots and exposes a real route or compartment;
- `LOOK BEHIND SHELF`, `LISTEN TO SHELF`, `PUSH SHELF`, or related sensible attempts receive authored responses rather than parser dead ends where appropriate.

The exact verbs and outcomes remain specific to the authored mechanism. Targetability does not guarantee success.

## Candidate mechanism families

- pivoting or sliding bookcases and wall panels;
- paintings, mirrors, plaques, or reliefs concealing catches or compartments;
- clocks, dials, levers, counterweights, and mechanical furniture;
- fireplaces, masonry, tiles, floor plates, and architectural seams;
- statues or ornaments with movable subparts;
- furniture with false backs, underside catches, hidden drawers, or non-obvious travel;
- multi-position objects whose orientation changes real room state;
- linked mechanisms where one physical control changes another room or object.

These are examples, not a checklist and not a requirement to implement every family in one release.

## Relationship to Releases 1267–1268

Release 1267 establishes that selected concrete details promised by prose can become trustworthy parser targets and that hidden structure can enter scope through semantic examination.

Release 1268 establishes that learned meaning can persist and alter later interpretation without requiring the original clue object to remain in inventory.

Release 1274 should compose those capabilities into environmental puzzles where observation and remembered interpretation identify *what might be a control*, while actual physical manipulation remains a separate authored step.

## Boundaries

- no generic `SECRET_SWITCH` framework sprayed across every room;
- no automatic promotion of every noun/adjective into a mechanism;
- no universal furniture state machine;
- no arbitrary `USE X ON Y` matrix;
- no pixel-hunt equivalent where prose gives no fair irregularity;
- no single magic parser phrase when several ordinary phrasings are physically synonymous;
- no mechanism should silently replace an existing canonical Zork authority;
- opening a secret route or compartment must modify real map/object state rather than only printing flavor prose;
- puzzles may be optional or consequential, but their clueing must be fair in the authored context.

## Success criteria

A successful train should demonstrate several distinct original Zork-native environmental mechanisms and prove that:

1. prose identifies a concrete irregularity;
2. the irregularity is parser-addressable;
3. examination provides useful but non-solution-spoiling physical information;
4. plausible wrong manipulations receive meaningful responses;
5. the correct manipulation changes real persistent world state;
6. the resulting route/compartment/object remains naturally usable afterward;
7. save/restore preserves the physical outcome through ordinary story state;
8. no generic secret-puzzle engine was introduced merely to make the examples look unified.
