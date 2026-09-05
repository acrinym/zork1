# Flathead Fair persistence and memory

**Status:** DESIGNING

## Persistence layers

### Same visit

Purchases, eaten food, won prizes, broken records, conversations, fish catches, ride state, and incidents remain coherent until the player leaves/returns.

### Same fair

Daily records, vendor familiarity, contest outcomes, stock depletion where meaningful, and unresolved mini-stories may carry across fair days.

### Later fair

Selected long-term facts can persist:

- important records;
- trophies/ribbons/prizes still owned;
- gifts given to Mara;
- recurring vendor relationships;
- notable incidents;
- Mara shared memories;
- prior winners;
- collectible-year items;
- NPC life changes;
- replaced/retired attractions where authored.

## Memory quality

Persistence must refer to semantic events, not raw transcript strings. `Mara remembers the elephant-ear dispute` is a stable event identity; storing every sentence spoken at the stall is not.

## Change over time

The fair can become emotionally meaningful because it returns while people and objects change. A vendor may retire. A child may be older. A ride may be replaced. A record may still stand.

## Reset boundaries

Not everything persists. Disposable stock, crowd composition, minor incidents, ordinary food, and temporary decoration can reset according to fair lifecycle.

The persistence plan must explicitly classify each system before implementation.
