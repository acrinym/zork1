# Release 1234 — Mara Arrival and Evidence Memory

Release 1234 introduces Mara as a specific person in the Living Room, not as a generic follower or conversational framework.

## Player-facing behavior

- `TALK TO MARA` introduces her and revisits the relationship.
- `SHOW OBJECT TO MARA` lets her examine a real object the player is holding.
- `ASK MARA ABOUT MUSEUM` changes after she has personally handled evidence.
- `ASK MARA ABOUT OBJECT` receives a provenance-backed answer only when that exact object is the evidence she remembers.

Mara does not take permanent custody. The canonical object stays with the player, and her memory stores the object identity rather than creating a duplicate evidence token.

## State model

Mara has one small saveable table:

- whether the player has met her;
- bounded trust from direct evidence sharing;
- the last canonical object she personally examined.

The table does not consume another global variable. It is not a dialogue database, companion controller, quest log, or remote inventory.

## Boundaries

This train adds no:

- follower or party system;
- generated dialogue or chatbot behavior;
- omniscient knowledge;
- generic NPC framework;
- duplicate evidence object;
- museum rewrite;
- House hierarchy reopening;
- S.T.A.L.K.E.R. coupling.

## Qualification direction

The hosted Release 1234 route will stage exactly over locked Release 1233, compile and assemble the real story, and type a complete Mara interaction into Glulxe: meet Mara, obtain the sword, ask about unwitnessed evidence, show her the sword, ask again, and verify that the real sword remains in the player's possession.
