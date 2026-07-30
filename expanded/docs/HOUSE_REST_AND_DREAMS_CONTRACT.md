# House Rest and Dreams Contract

## Purpose

Train 10 gives the white house one optional place to sleep between expeditions without turning Zork I into a chore simulator or allowing time, danger, and recovery exploits.

## Commands

| Command | Contract |
|---|---|
| `WAIT` / `Z` | Original canonical waiting. Unchanged. |
| `SLEEP` / `REST` / `NAP` / `DOZE` | Attempt bounded Bedroom sleep. |
| `LIE DOWN` / `LIE ON BED` | Same bounded Bedroom sleep route. |
| `WAKE` / `WAKE UP` | Confirms that sleep resolves within one command; the player is already awake. |
| `WAKE <actor>` | Original actor-waking behavior remains canonical. |

## Room contract

The Bedroom is one authored room above the Living Room. It adds only:

- Living Room `UP -> BEDROOM`;
- Bedroom `DOWN -> LIVING-ROOM`.

No prior exit, puzzle route, exterior entrance, score, or object is replaced.

## Sleep execution

A full sleep must:

1. start in the Bedroom;
2. reject active fire, tied legs, and an active hostile presence;
3. run the canonical clock one step at a time;
4. stop on the first live interruption;
5. apply no recovery after an interrupted sleep;
6. apply only bounded temporary recovery after a completed sleep;
7. select a dream only from already-earned evidence;
8. apply deterministic overnight consequences through existing systems;
9. return control awake in the Bedroom.

If no new evidence has appeared since the previous completed sleep, the action becomes a one-turn shallow doze. It does not run the full recovery/dream sequence.

## Recovery boundary

Permitted once per newly earned evidence signature:

- one step toward zero for a negative temporary player-strength adjustment;
- removal of transient stagger;
- removal of lingering garlic scent.

Forbidden:

- resurrection;
- restoring destroyed, stolen, consumed, or misplaced objects;
- clearing permanent history;
- resetting actors, combat, mechanisms, routes, score, or puzzle state;
- repeatable recovery through identical sleep commands.

## Dream boundary

The authored dream pool is finite and deterministic. Eligibility comes only from evidence already present in the save image.

Dream prose may reinterpret earned history, but may not:

- predict a future event;
- name an unseen solution or command;
- complete a missing ceremony;
- disclose an actor interaction the player did not have;
- imply that an unresolved file is complete;
- replace canonical evidence with symbolism.

## Overnight boundary

Train 10 may advance or summarize existing systems:

- canonical mail and queued visitors;
- physical missed-visitor notices;
- existing museum-theft evidence;
- existing water/damp and smoke/fire evidence;
- physical archive records.

Train 10 may not originate Train 11's broader house vulnerability systems, including general burglary scheduling, damage propagation, structural conditions, follower intrusion, cursed-object effects, or repairs.

## Forced waking

A forced wake is a completed interruption, not a failed parser response. It must:

- explain the authored cause;
- preserve the live clock result that caused it;
- grant no recovery;
- produce at most one physical notice or record for the event;
- leave the player able to act immediately.

## Archive boundary

`REST-DREAM-01` and `REST-OVERNIGHT-02` are physical records. Reading them cannot alter location, score, timers, pronouns, or custody. Filing moves the exact held object into the canonical Attic cabinet; no duplicate is created.

## Persistence

Native save/restore must preserve:

- Bedroom access and room identity;
- completed rest count;
- last evidence signature;
- dream bits and last dream;
- overnight consequence bits;
- interruption and recovery receipts;
- wake-reason suppression bits;
- filing state;
- exact notebook, report, and missed-notice custody;
- the resulting canonical player-strength, stagger, and scent state.

Qualification deliberately corrupts all of the above and accepts only native restore without a repair command.

## Program hierarchy

This train executes the eight existing `zork1-house-rest-*` beads directly. It creates no sub-beads, sub-trains, duplicate roadmap, or parallel house controller.
