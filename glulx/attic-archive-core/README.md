# Attic Archive Core — Release 1224

## What this train builds

The canonical Attic becomes a physical late-1970s archive of this player's actual expedition history.

It adds:

- an oak card catalog;
- a gray steel filing cabinet;
- a separate-expedition banker box;
- a green-phosphor location terminal;
- a cassette recorder;
- a film and microfiche viewer;
- a cross-reference corkboard;
- exact folders, cards, printouts, microfiche, and cassette records derived from already-earned correspondence and visitor evidence.

The terminal is an index, not a computer database. It tells the player where a physical record is filed. The record itself remains an ordinary object in the game tree.

## What the player can do

The archive supports ordinary `READ`, `FIND`, `TAKE`, and `PLAY`, plus explicit bounded commands:

- `FILE <record>`;
- `REVIEW <record>`;
- `SHOW <record>`;
- `CROSSREF <record>`.

Filing moves the exact record into the real steel cabinet. It does not generate a copy. Reviewing and cross-referencing expose only facts already earned by the current run.

## Record model

Each record can identify:

- people;
- places;
- objects;
- messages;
- incidents;
- chronology;
- outcomes;
- related filing codes;
- source and physical provenance;
- confidence and verification;
- contradictions, redactions, or missing evidence.

Release 1224 begins with bounded records for the Cellar threshold, Living Room display warning, Flood Control Dam #3 maintenance notice, visitor evidence, and house chronology.

## Canonical authority

Release 1224 does not move or rewrite live mail. The correspondence, mailbox, visitors, actors, objects, rooms, routes, score, and puzzle state remain authoritative.

The archive observes stable filing codes and exact source-object custody. Destroyed or missing evidence is not regenerated merely because an index entry once existed.

## Playback boundary

The cassette produces a curated textual retrospective. It cannot change:

- location;
- objects or custody;
- actors;
- timers;
- score;
- pronouns;
- puzzle state.

It is not time travel and is not a raw session logger.

## Persistence qualification

The dedicated test route:

1. seeds exact correspondence and visitor sources;
2. builds the deterministic index;
3. reads and cross-references a record;
4. files the exact physical folder;
5. plays the chronology cassette;
6. saves through the native interpreter;
7. removes all source records, archive records, index bits, filing state, annotations, and current location;
8. restores the save;
9. proves exact index state and physical custody return without repair.

## Explicit exclusions

No modern filesystem, cloud drive, email inbox, generic database, universal logger, raw transcript dump, unseen-solution disclosure, duplicate records, regenerated destroyed records, merged incompatible expeditions, parallel score, automatic puzzle completion, or sub-bead hierarchy.

## Stack

Release 1224 is built directly over exact qualified Release 1223 Correspondence and Visitors. PR #22 remains open and unmerged unless Justin gives the explicit merge whistle.
