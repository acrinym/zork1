# Flathead Fair RNG contract

**Status:** DESIGNING

## Why RNG belongs here

A fair benefits from uncertainty. Races, fishing, raffles, incidental crowds, performers, and some stock should not resolve identically forever.

## Allowed random families

- fish/catch selection within authored tables;
- race/contest outcomes where chance is part of the activity;
- raffle results;
- incidental crowd encounters;
- bounded performer order;
- rare vendor attendance/stock;
- minor fair incidents;
- fortune-teller variants;
- noncritical prize variations.

## Forbidden random families

- canonical puzzle solvability;
- required exits;
- whether a necessary NPC ever appears;
- whether a mandatory object exists;
- irreversible catastrophic fair outcomes without warning/recovery;
- Mara's fundamental preferences/personality;
- arbitrary relationship success;
- generated dialogue or generated world lore.

## Seed strategy

Prefer coherent **fair-day or event seeds** for outcomes that should feel as if they existed before the player looked. This can prevent trivial `SAVE -> ROLL -> RESTORE` fishing/raffle exploitation while retaining uncertainty.

Exact save/restore semantics must match interpreter/game constraints and be tested, not assumed.

## Authored randomness law

Random selection chooses among authored semantic outcomes. It does not synthesize final content.
