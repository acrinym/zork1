# Flathead Fair product bible

**Status:** DESIGNING

## North star

Build a fair the Adventurer can visit because it is enjoyable to be there, not because the main adventure requires it.

The fair should support ten minutes of incidental wandering or an entire in-world day. It should reward curiosity with food, rides, games, shopping, fishing, performances, conversation, tiny objectives, social memories, rare incidents, and repeat visits.

The fair is a **place**, not a menu of minigames.

## Product promises

1. **Optionality.** Canonical Zork remains solvable without attending.
2. **Density.** Fair rooms exist because several meaningful things happen there. Avoid corridor rooms whose only purpose is traversal.
3. **Parser reality.** Food, prizes, drinks, tickets, merchandise, fish, gifts, and fair objects are real objects where practical.
4. **Contextual knowledge.** `ASK`, `EXAMINE`, `SMELL`, `TASTE`, `LISTEN`, `BUY`, `GIVE`, and related verbs reveal authored information rather than collapsing into generic replies.
5. **Adult social life.** Couples, dates, dancing, private conversations, affection, evening venues, and established relationships belong naturally in the fair.
6. **Mara agency.** Mara is a participant, not a romance vending machine.
7. **Recurring life.** The fair opens, changes through the day, closes, tears down, and later returns with continuity and variation.
8. **Controlled chance.** Fishing, races, raffles, incidental encounters, stock, and similar activities may vary, but required content must remain fair and recoverable.
9. **Persistent history.** Records, prizes, memorable incidents, vendor relationships, and Mara memories can survive a visit and sometimes a later fair.
10. **Zork voice.** Bureaucratic absurdity, physical comedy, confident narration, odd products, real consequences, and exact object identity matter more than carnival cliché.

## What the fair is not

- not Guardia Fair with renamed nouns;
- not a Gato substitute or robot-animal gag;
- not a mandatory quest hub;
- not a generic `CarnivalEngine` intended to manufacture arbitrary fairs;
- not a procedural-content generator;
- not a romance meter arcade;
- not a GUI attraction selector;
- not an economy simulator that forces bookkeeping;
- not an excuse to rewrite canonical routes.

## Interaction-density rule

Each major fair location should support at least three interaction families. Example: Food Row may support buying, eating/sharing, vendor conversation, Mara preferences, crowd incidents, and one discovered errand. The House of Mirrors may support navigation, reflection interactions, Mara reactions, secrets, and rare anomalies.

## Completion philosophy

The fair may have records, prizes, ribbons, fish, rare objects, and discoverable stories, but it should not conceptually become `FAIR 100% COMPLETE`. The design target is a place players revisit, not a checklist to exhaust.

## Relationship to existing Highly Extended Zork

The fair should compose existing authorities instead of duplicating them: time/weather, world-state persistence, material/object identity, Mara relationship and autonomy, clothing/property, NPC memory, darkness/light, and natural-play qualification.

Where a needed authority does not yet exist, the fair plan must name the dependency rather than silently inventing a parallel system.
