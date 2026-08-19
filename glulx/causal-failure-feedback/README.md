# Release 1270 — Causal Death & Failure Feedback

Release 1270 makes selected deaths explain **why the world killed the Adventurer** without turning death into a walkthrough.

The release changes no hazard ownership and adds no generic death engine. `JIGS-UP` remains canonical death/recovery authority. Dragon state/routes remain in `dragon_hoard.zil`; dam survival remains in the existing dam routines; Great Canyon warning/interception remains in `living_zork_consequences.zil` and its canonical room hook. `causal_failure_feedback.zil` is deliberately state-free: it owns only authored terminal phrasing.

## Player-facing doctrine

Selected failures now make four things legible in ordinary prose:

1. the immediate physical cause;
2. evidence the world had already exposed;
3. whether part of the attempted idea was sound;
4. the state or action difference that made this attempt terminal.

This is not `HINT: use X`. The game names physical relationships already demonstrated by the authored situation and leaves the player to choose a response.

## Showcases

- **Dragon trap timing:** pulling the real grille chain is recognized as a sound mechanism used while the dragon is still outside the trap geometry.
- **Dragon watch window:** lingering after visible heat/body warnings explains that one additional exposed action crossed the consequence threshold.
- **Dragon bargain:** the first paid take is validated while a second take is identified as the exact breach.
- **Dragon direct attack / naked hoard theft:** physically possible actions are distinguished from safe states without parser prohibition.
- **Flood Control Dam #3:** fatal current and overloaded ladder failures identify discharge, footing/load, and prepared arrest as concrete causes already represented by the world.
- **Great Canyon:** an unarrested fall acknowledges the earlier loose-shale warning and the existing prepared-rope interception path without issuing an itemized solution.

## Boundaries

- no generic failure registry, hint database, or global `LAST_DEATH_CAUSE` state;
- no new death/restart/restore authority;
- no duplicate dragon/dam/canyon state;
- no new deaths merely to demonstrate feedback;
- no explicit walkthrough language or parser-command prescription;
- natural player commands drive qualification.

## Qualification

Hosted qualification first reruns locked Release 1269, verifies exact predecessor production/dev source identities, stages only the declared production paths, smell-checks both staged profiles, compiles production and test stories, and drives natural-command histories for wrong trap timing, ignored dragon warning, bargain breach, open-sluice swimming, and an unarrested canyon leap. The first candidate intentionally stops only at the artifact-identity gate; the exact candidate identity is then locked and requalified on the exact head.
