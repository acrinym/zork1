# Release 1262 — Hostile Rooms & Reactive Threats

Release 1262 begins the Shadowgate → Parser IF adaptation program with an original Zork-native **Treasure Guardian Dragon & Hoard**.

The design lesson being adapted is not “put a dragon in a room.” It is that a dangerous room contains a live threat which watches what the Adventurer actually does. Time and attention become physical resources because the threat is present, not because the game has entered a generic combat mode.

## Player-facing contract

The new route branches north from the existing Timber Room through a visibly scorched cleft. Warning arrives before commitment: unusual heat, broad scratches, deliberately piled bones, blackened basalt, a visible dragon, its visible hoard, an old hanging grille, and an open retreat route.

Inside the Dragon Gallery:

- ordinary non-movement experimentation spends the dragon's patience; the first such action earns a clear warning and another careless action can earn lethal fire;
- retreat remains physically available rather than becoming a menu command or combat escape roll;
- direct violence against the unrestrained dragon is a deliberately bad but physically permitted choice;
- a real treasure can be **offered** as a toll, producing a narrow bargain for passage and one hoard item;
- a real treasure can instead be **dropped as bait**, drawing the possessive dragon beneath an old iron grille so the Adventurer can pull the counterweight chain and contain it;
- the existing Release 1257 Timber Room fire is not duplicated: when that real authored fire reaches open flame, its smoke can travel through the new ventilation seam and force the dragon away from the eastern arch long enough to exploit the environment;
- the contained dragon remains alive and furious; the solution changes custody and geometry rather than silently deleting the creature.

The hoard introduces two original non-score-bearing physical treasures, an ashen silver circlet and a piece of star-glass. Canonical Zork treasures can also participate in the dragon's greed without changing their original identity.

## What this is not

- no `DRAGON_HP` or boss health bar;
- no generic turn-order combat system;
- no universal reactive-enemy framework;
- no random attack rolls;
- no generic disposition or hostility meter;
- no duplicated fire simulator;
- no requirement that the dragon be killed;
- no deletion of the existing Timber Room east/west routes or EMPTY-HANDED authority.

The dragon is one authored animal with one authored territory, senses, greed, fire, patience, and environmental context.

## Qualification routes

The Release 1262 qualifier proves several materially different histories through real parser commands after test-only precondition setup:

1. **Bargain:** give the dragon a real canonical treasure, pass east, take one hoard object, and leave under the one-item bargain.
2. **Bait and containment:** drop a real treasure, let the dragon move under the grille, pull the real chain, enter the hoard, and take multiple objects while the living dragon remains contained.
3. **Environmental leverage:** light the already-authored Timber Room timbers with a real live flame, allow the existing fire authority to establish smoke, then use that real smoke state to alter the Dragon Gallery.
4. **Ignored warning:** spend opportunity under the uncontained dragon and prove that a second careless action produces the authored fire-breath death rather than an invisible combat roll.
5. **Retreat:** enter the hostile room and leave south without needing to defeat, bribe, or trap anything.

## Architectural boundary

Release 1262 deliberately does **not** generalize the encounter. If a later creature independently proves that a reusable abstraction is justified, that can be evaluated then. For this train the dragon's behavior belongs to the dragon.

The one intentional cross-system composition is the existing Release 1257 fire state. A future threat should reuse a real authority when the physics genuinely match rather than inventing a private copy.
