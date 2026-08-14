# Mara Tallow — Design and Implementation Status

## Canonical design source

The primary design document is:

- `ideas/extended-zork/human-companion-bond-and-love-interest.md`

That document defines Mara as one deeply authored human causal adventurer who may become the Adventurer's closest friend or optional love interest through actual shared play. It explicitly rejects a generic follower, dialogue prop, approval meter, dating simulator, inventory mule, hint engine, and permanent attachment to the player's room.

## Locked identity

The working candidate is now the active character direction:

- **Name:** Mara Tallow
- **Profession:** field surveyor, route historian, practical expeditionist
- **Independent goal:** reconstruct the Last Honest Survey of the Great Underground Empire
- **Temperament:** observant, dryly funny, evidence-minded, brave without being fearless, slow to trust declarations, capable of tenderness without being available on demand
- **First relationship principle:** competence witnessed under danger

## Implemented history

### Release 1234 — Arrival and Evidence Memory

Mara first became a visible actor with conversation, physical evidence handling, and one-object memory. That release proved evidence-limited knowledge but incorrectly placed her in the Living Room beside the museum displays, making the implementation read like a curator instead of the intended companion.

### Release 1243 — Companion Expedition Foundation

Release 1243 corrected the introduction and implemented her first complete field chapter:

- physical first presence at Flood Control Dam #3;
- independent field camp and owned equipment;
- direct-address follow, wait, button, and brace behavior;
- authored regional movement with exact location and refusal;
- joint canonical Dam operation and one physical survey record;
- witnessed warning, reckless disagreement, autonomous retreat, repair, and apology history;
- witnessed silverfin ecology and live-release memory;
- an earned route toward House integration;
- early intimacy boundaries without romance progression machinery.

### Release 1244 — Mara House Company

Release 1244 carried the earned Dam partnership into the existing House instead of introducing another companion subsystem.

It added:

- a second physical two-person operation at the canonical barred Cellar trap door;
- preservation of the original solo slam-and-bar behavior while Mara's own measured rope and the Adventurer's lift can together draw the real upper bar after the Dam survey;
- physical arrival at the Living Room through the reopened real stair rather than teleportation;
- a House invitation that does not relocate Mara or her camp automatically;
- a required return to Flood Control Dam #3 so Mara can retrieve her own waxed field pack herself;
- exact pack custody during the return journey;
- Attic residence by explicit consent, with Mara choosing where to set her own pack;
- one shared Kitchen meal made from the canonical prepared lunch and consumed exactly once;
- House, company, and intimacy dialogue grounded in those events rather than an exposed relationship score;
- schema migration preserving Release 1243 witnessed history.

### Release 1245 — Creative Natural Play

Release 1245 made Mara respond more truthfully to ordinary player behavior and expanded the history she can carry without turning her into a generic simulation.

It added or strengthened:

- hostile-interaction history and personhood refusals;
- restraint and combat-order memory;
- witnessed bound-troll state;
- witnessed player death and later behavioral acknowledgement;
- evidence-aware natural-play responses;
- bounded offscreen comedy/history without omniscient simulation;
- schema 5 continuity for the growing witnessed record.

The legacy `TRUST`, `RESPECT`, and `SAFETY` fields remain part of already-shipped Mara behavior, but they are not the intended long-term explanation for her most important choices.

## Active Release 1258 train — Mara Causal Biography & Shared Danger

PR #63 is the active, **unmerged** Release 1258 train. It is the first explicit proof of Mara's causal biography: later behavior is explained by named things that happened, not by consulting a global approval score.

The train composes with the real Release 1253 Flood Control Dam #3 maintenance-ladder hazard and Mara's one real measured field rope.

The authored chapter includes:

- Mara attempting the real Dam maintenance ladder under dangerous sluice conditions;
- a persistent scraped palm and injured shoulder rather than a disposable scene flag;
- exact temporary custody: Mara's physical field-rope object lands in the Adventurer's hands during peril;
- one narrow, world-grounded promise to return that exact rope before moving away;
- reciprocal rescue in both directions;
- ordinary `GIVE FIELD ROPE TO MARA` as the act that actually restores custody;
- separate recorded meanings for rescuing Mara, returning the entrusted object, breaking a promise, abandoning her in active peril, and Mara later rescuing the Adventurer;
- conversion of the existing warned-and-ignored blue-circuit history into an explicit biographical proposition;
- a later overloaded-ladder decision that deliberately does **not** read `MARA-SLOT-TRUST`, `MARA-SLOT-RESPECT`, or `MARA-SLOT-SAFETY`;
- a negative history in which Mara blocks reckless repetition for a concrete reason;
- an earned-reciprocity history in which she remembers both the earlier ignored warning and the later rescue/rope return, then physically backstops the Adventurer with her rope;
- a bounded private experience during separation: Mara notices evidence at a lower retaining bolt and rejoins without automatically disclosing it;
- later disclosure through asking Mara about the real maintenance ladder;
- schema 6 migration preserving older Mara history rather than resetting her.

The release does **not** add a generic NPC simulator, romance meter, universal emotion engine, generic injury system, generic promise framework, party framework, duplicate rope, duplicate ladder, or second Dam-survival authority.

The release is not complete until its production Glulx artifact is generated, cryptographically pinned, requalified against that exact identity, all actionable review threads are addressed and resolved, and Justin gives an explicit merge whistle. PR #63 must not merge before that whistle.

## Causal-biography direction

The durable design primitive is an **appraised biographical fact**: something Mara witnessed or experienced, what she understood it to mean, and the reason that meaning gives her in a later situation.

The intended chain is:

> event fact → Mara's appraisal → carried meaning → current feeling → choice → new history

The carried meaning is durable. A transient emotion does not need to become a permanent scalar.

Future Mara work should keep proving this with authored life rather than broad infrastructure. Strong later directions include recovery that changes behavior over time, conflicting promises, longer separations, discoveries she chooses when or whether to disclose, archive disagreement, thief manipulation, troll judgment, mistakes Mara makes without the Adventurer present, repair after betrayal, changing interpretations of the Adventurer, deeper friendship and emotional intimacy, and only eventually any romantic recognition that the lived history actually earns.
