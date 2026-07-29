# Attic NPC Dossiers — Release 1225

## Qualified identity

- edition: Unofficial Attic NPC Dossiers Glulx
- release: `1225`
- serial: `260729`
- output: `zork1-glulx-attic-npc-dossiers.ulx`
- Glulx: `3.1.3` / `0x00030103`
- size: `287,744` bytes
- checksum: `0x4b4d66a0`
- SHA-256: `e775d0a5ab74f5115d09b380ac4397e845ef539a1260df166120e1c25594db10`
- exact Release 1224 base SHA-256: `c8490c39b3ee8a17e257419aa13998529086573ddb6172132998f8353e92a356`

GitHub Actions run `30480017488` passed staging, compilation, assembly, the production no-unearned-dossier journey, exact dossier interaction, and native save/corrupt/restore.

## What this train builds

The Attic archive now creates physical records for the player's actual encounters with:

- the troll;
- the cyclops;
- the thief;
- a curated encounter timeline cassette.

A dossier appears only after direct player interaction or observable canonical evidence. Actors merely existing elsewhere in the map do not create encyclopedia entries.

## Evidence model

The files distinguish:

- first contact;
- observed hostility;
- gift or thrown-object attempts;
- attacks and restraint attempts;
- bargains and contextual statements;
- verified outcomes;
- object or property custody;
- recovery evidence;
- absent, invisible, contradictory, or missing evidence.

Attempts never become successes merely because the action was typed. Combat rolls, actor decisions, route authority, score, timers, randomness, and object custody remain canonical.

## Physical archive behavior

The player may use ordinary `READ`, `EXAMINE`, `TAKE`, and `PLAY`, plus the Release 1224 archive commands:

- `FILE <dossier>`;
- `REVIEW <dossier>`;
- `SHOW <dossier>`;
- `CROSSREF <dossier>`.

Filing moves one exact physical dossier into the existing steel cabinet. It creates no duplicate actor, property, record, or replacement for missing evidence.

## Troll file

`NPC-TROLL-01` can retain first contact, hostility, gift/throw attempts, combat, restraint attempts, passage outcome, renewed danger, and canonical axe custody.

## Cyclops file

`NPC-CYCLOPS-02` can retain first contact, hostility, offers, pepper/water impatience state, the contextual Odysseus exchange, sleep outcome, and the canonical route opening. It does not disclose an unobserved solution.

## Thief and property file

`NPC-THIEF-03` can retain direct contact, hostility, treasure exchange or engrossment, museum theft evidence, invisibility or missing-location status, and canonical stiletto or bag custody. Missing property stays missing.

## Curated timeline

The encounter cassette summarizes only retained actor evidence in observed order. It is not a raw transcript and cannot replay hidden movement, random rolls, future behavior, or the live actors themselves.

## Persistence qualification

The dedicated qualification route:

1. creates exact troll, cyclops, thief, and timeline records from controlled canonical evidence;
2. reviews and cross-references the troll file;
3. files that exact dossier in the steel cabinet;
4. plays the curated timeline;
5. saves through the native interpreter;
6. removes every dossier and resets actor-memory state and location;
7. restores the save;
8. proves exact state bits, physical records, and cabinet custody return without repair.

## Explicit exclusions

No static omniscient encyclopedia, raw command logger, future prediction, combat advice, actor control, hidden-solution disclosure, duplicate actors, reconstructed property, parallel combat, parallel score, or sub-bead hierarchy.

## Stack

Release 1225 is stacked directly on exact qualified Release 1224 / PR #22. PR #24 remains open and unmerged unless Justin gives the explicit merge whistle.
