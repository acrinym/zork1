# Zork Narrative Perspective and Storybook Experiments

## Status

Documentation-only experimental lane.

These experiments do not replace normal Zork I, rename the protagonist, make the parser into a speaking character, or authorize implementation in the primary release lineage. Each experiment should remain an isolated alternate edition or selectable presentation mode until it has been built, played, and judged on its own merits.

## Foundational identity

The game contains three distinct roles that must not be collapsed:

1. **The player** chooses and types actions.
2. **Zork** is the parser and interface that interprets those actions.
3. **The adventurer** is the unnamed person physically present in the Great Underground Empire.

Zork is not currently a character speaking through the adventurer. Mara, the thief, the troll, and other inhabitants interact with the adventurer, not with a possessing parser entity.

The adventurer has no established personal name. Experimental prose must therefore use perspective, context, `you`, `I`, or `the adventurer` without silently inventing one.

## Control edition: ordinary Zork

Normal Zork should retain its familiar second-person interactive-fiction relationship:

```text
You are standing in an open field west of a white house.
```

Commands remain imperative input from the player:

```text
OPEN MAILBOX
GO NORTH
TALK TO MARA
```

The parser remains functionally invisible. World characters answer the adventurer. Actual spoken dialogue may naturally use first person because the adventurer is speaking as a person:

```text
“I will turn the bolt. You brace the panel.”
```

That does not turn the surrounding narration into first person and does not make Zork a voice possessing the adventurer.

The four experiments below deliberately disturb this familiar relationship in different ways.

---

# Experiment 1 — Zork I in First Person

## Premise

Rewrite the complete playable experience so the adventure is narrated as the adventurer's own immediate experience.

```text
I am standing in an open field west of a white house. A small mailbox stands nearby.
```

The player still enters actions, but results are expressed through the adventurer's perspective:

```text
> OPEN MAILBOX
I open the small mailbox. Inside, I find a leaflet.
```

## Central question

Does first-person narration make the Great Underground Empire feel more intimate and embodied, or does it improperly assign a private voice and personality to an intentionally unnamed protagonist?

## Strict form

The strict experiment should attempt first person across:

- room descriptions;
- movement;
- object examination;
- action success and failure;
- danger, injury, hunger, fatigue, dreams, and death;
- memory and retrospective records;
- conversations and internal judgments;
- parser misunderstandings and disambiguation prompts.

The difficult cases are part of the experiment rather than reasons to avoid it. For example:

```text
I do not understand the word “flibbertigibbet.”
```

That line intentionally tests whether the parser and adventurer become uncomfortably fused. If it sounds as though the adventurer has become the parser, the experiment has discovered a real boundary.

## Possible secondary form

A less absolute variant may keep technical parser messages neutral while converting only world narration to first person. That variant should not be mistaken for the strict experiment; it answers a different question.

## Risks

- The unnamed adventurer may acquire an unintended authored personality.
- Parser errors may sound like the adventurer is interpreting the command.
- Hidden information and narrator knowledge may become implausible as personal observation.
- Death text may become awkward if the dead adventurer continues narrating.
- Mara and other companions may appear to be speaking to the player directly rather than to a distinct person in the world.

## What would make it worthwhile

The edition should produce a genuinely different emotional experience: confinement, darkness, pain, discovery, hunger, fear, humor, and companionship should feel personally inhabited rather than merely reported.

A word-for-word pronoun substitution is not enough.

---

# Experiment 2 — Zork I in Second Person

## Premise

Build a deliberately complete second-person edition as the control against which the other perspectives are compared.

Zork I already uses second person extensively. This experiment is therefore not merely “leave the game alone.” It would normalize every added system, expansion, companion interaction, archive, dream, consequence, and parser response around a consistent relationship between player and adventurer.

```text
You descend the staircase. The trap door crashes shut above you.
```

## Central question

Why does second person work so well for parser fiction, and where does it stop working as the game becomes larger, more relational, and more novelistic?

## Scope

The second-person edition should establish clear rules for:

- immediate action narration;
- remembered action and historical records;
- dreams and altered states;
- dialogue spoken by the adventurer;
- companion observations about the adventurer;
- parser errors and clarification;
- scenes where the adventurer is unconscious, absent, deceived, or observed by others;
- postgame expedition histories.

## Governing distinction

Second-person narration addresses the adventurer as `you`, but the parser is still not an in-world speaker. `You` is the embodied protagonist, not Zork.

## Why this experiment matters

As Highly Extended Zork accumulates authored companions, cuisine, physical injuries, house life, museum records, dreams, and long-term consequences, inconsistent perspective can creep in unnoticed. A complete second-person edition provides the stable baseline and may remain the best final form.

---

# Experiment 3 — Zork I in Third Person

## Premise

Narrate the game as the story of an unnamed adventurer whose actions are directed by the player.

```text
The adventurer stands in an open field west of a white house. A small mailbox waits nearby.
```

```text
> OPEN MAILBOX
The adventurer opens the mailbox and finds a leaflet inside.
```

The protagonist must remain unnamed unless a separate future design explicitly establishes a name. The default third-person subject is therefore **the adventurer** rather than an invented proper noun.

## Central question

Does third person create useful narrative distance and make Zork feel like a living chronicle, or does it weaken the player's identification with the person taking the risks?

## Opportunities

Third person may support scenes that ordinary second person handles awkwardly:

- Mara observing the adventurer from across a room;
- the thief acting while the adventurer is absent;
- dreams, unconsciousness, rescue, captivity, or presumed death;
- parallel events whose consequences later meet;
- House records that describe the adventurer historically;
- a more literary narrator capable of framing a scene without pretending every fact is currently perceived.

## Risks

- Repeating `the adventurer` may become stiff or comic.
- Introducing pronouns would implicitly establish identity details that the game has not chosen.
- The player may feel like a remote director rather than the person underground.
- Parser commands remain second-person-like imperatives while results become third-person prose, creating intentional but possibly unpleasant distance.
- Classic Zork immediacy and humor may be weakened.

## Required test

The experiment must survive ordinary play, parser failure, combat, death, dialogue, solitude, and companionship. It cannot be judged only from polished room descriptions.

---

# Experiment 4 — Zork I as an Interactive Storybook

## Premise

Present Zork I as though the player is reading a narrated book whose next passage is selected through visible choices.

The player still causes the actions. The difference is that meaningful choices are no longer left entirely silent behind an empty parser prompt.

Example:

```text
The adventurer stood west of the white house while late light settled over the field. The front door had been boarded shut. A small mailbox leaned beside the road.

What happened next?

1. Open the mailbox.
2. Walk around the north side of the house.
3. Walk around the south side of the house.
4. Examine the boarded front door.
```

Choosing an option executes the corresponding real action in the same underlying game state.

## Central question

Can canonical Zork become a satisfying choose-your-own-adventure without reducing the world to a fake sequence of predetermined branches?

## Core design

This is not a separate simplified story loosely inspired by Zork. It should remain a presentation of the actual game:

- one canonical world state;
- real objects and custody;
- real puzzle conditions;
- real movement and danger;
- real score and consequences;
- real companion state;
- real save and restore continuity.

The storybook layer interprets that state and presents authored choices that are currently meaningful.

## Choice presentation

A passage may provide:

- numbered actions;
- short descriptive action labels;
- optional consequences already obvious to the adventurer;
- a `Something else...` path for free parser input when appropriate.

Choices should not reveal hidden solutions merely because they are valid parser commands. The mode must distinguish:

- obvious physical options;
- actions already learned or inferred;
- risky actions whose danger is perceptible;
- hidden possibilities that should remain discoverable;
- absurd or experimental commands that belong to free input rather than the visible list.

## Narrative form

This edition may use either second-person storybook prose or third-person book prose, but the first implementation should choose one explicitly rather than drifting between them.

A strong initial candidate is third-person past tense:

```text
The adventurer lifted the mailbox lid and found a leaflet curled inside.
```

Another valid candidate is second-person present tense:

```text
You lift the mailbox lid and find a leaflet curled inside.
```

Those are sub-editions of the storybook experiment and should be compared rather than mixed casually.

## Choice cadence

The storybook should not interrupt after every trivial parser action. Choices should appear at meaningful beats:

- entering a new scene;
- encountering danger;
- discovering a puzzle state;
- beginning or ending a conversation;
- making a custody or moral decision;
- choosing an expedition route;
- responding to a companion;
- deciding whether to retreat, prepare, or proceed.

Minor actions can be grouped into a flowing passage when no meaningful decision is lost.

## Companion conversations

Mara and later characters make this experiment especially interesting. Dialogue choices can be explicit without becoming a generic dialogue wheel:

```text
Mara waited beside the scarred control panel.

1. Ask what she is measuring.
2. Offer to turn the bolt while she braces the panel.
3. Warn her that you intend to test the blue circuit.
4. Leave her to the survey and return to the dam crest.
5. Say something else...
```

Each option must correspond to an authored action, statement, or parser command with causal consequences. No approval icons, romance-point labels, or omniscient previews should appear.

## Risks

- Visible choices may spoil discovery and puzzle solving.
- Too many options may become a menu version of the parser rather than a book.
- Too few options may create false rails and erase Zork's experimental freedom.
- Generating choices from every parser affordance would produce noise.
- Authored choices may become stale when the world changes unless they are grounded in exact state.
- The mode may accidentally become a dialogue tree or generic choice framework instead of a Zork storybook.

## What would make it worthwhile

The player should feel that they are reading a real evolving adventure while still owning its decisions. The result should be more narratively inviting than a silent prompt without sacrificing the surprise, danger, object permanence, and strange freedom that make Zork Zork.

---

# Shared experiment rules

## Preserve one real game

Perspective experiments should change narration and interaction presentation, not secretly fork puzzle truth, duplicate objects, alter score, or simplify canonical causality.

## Keep editions isolated

Each experiment should be developed and qualified separately. Do not add a universal narration framework merely because four editions share some vocabulary.

The first implementation may use narrowly authored transformations and rewritten high-value routes. The goal is to discover whether an edition is good, not to build machinery capable of converting all prose in all possible games.

## No automatic winner

Second person is the current baseline, not a predetermined permanent victor. First person, third person, and storybook mode should be allowed to reveal strengths that ordinary parser fiction does not have.

## Compare complete play, not samples

Every edition should be tested across at least:

- West of House and House entry;
- parser misunderstanding and disambiguation;
- darkness and the grue threat;
- inventory and object custody;
- the troll encounter;
- death and restart or restore;
- a canonical puzzle mechanism;
- Mara following, refusing, waiting, and conversing;
- a quiet domestic or reflective scene;
- a long expedition history.

## Preserve parser freedom where promised

The first-, second-, and third-person editions remain parser games.

The storybook experiment may foreground choices, but it should explicitly decide whether freeform commands remain available. That decision must be visible to the player rather than hidden as an implementation detail.

## Record findings honestly

Each experiment should document:

- where the perspective feels natural;
- where pronouns or tense become confusing;
- which parser messages break the illusion;
- whether the adventurer gains an unintended personality;
- whether companions feel more or less real;
- whether humor survives;
- whether danger becomes stronger or weaker;
- whether puzzle discovery is preserved;
- whether the player feels embodied, directed, detached, or merely informed.

# Suggested experiment order

1. **Second-person control edition** — define the stable rules already implicit in normal Zork.
2. **Strict first-person edition** — push the parser/adventurer boundary until it reveals exactly where it breaks.
3. **Third-person edition** — test narrative distance, unnamed-protagonist language, and scenes beyond immediate perception.
4. **Interactive storybook edition** — build visible choices over real canonical state after the perspective lessons are understood.

This order is for learning efficiency, not product priority.

# Open questions

- Does `Zork` appear anywhere to the player as the parser's name, or remain purely our design term?
- Should strict first person include parser errors, score reports, save/restore messages, and death continuation?
- Can third person avoid inventing a gendered pronoun without repeating `the adventurer` mechanically?
- Should storybook mode preserve unrestricted freeform commands through `Something else...`, or commit fully to authored choices?
- Should the first storybook edition use second-person present or third-person past?
- Can one saved game move between editions, or should each experiment preserve its own narration history?
- How should transcripts and House records distinguish what happened from how a particular edition narrated it?

# Current conclusion

Normal Zork remains second person. Zork remains the parser rather than a character speaking through the unnamed adventurer.

The four experiments are retained because changing perspective may reveal entirely different forms of embodiment, distance, companionship, humor, and player agency. They should be treated as real alternate Zork experiences—not as a search-and-replace exercise and not as permission to destabilize the primary game.