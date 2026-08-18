# Release 1276 — Mara Field Guidance & Earned Clues

**Queued after:** Release 1275 — Expand Existing Slim Locales / Locations  
**Status:** planned; explicit post-1275 product train

## Purpose

Make Mara genuinely useful as a field partner because she is an authored adventurer with her own memory, observations, recovered evidence, route knowledge, and mapping practice — not because the game secretly turns her into an omniscient hint terminal.

Mara is a mappist. Release 1276 makes that fact materially useful.

The governing rule is simple:

> **Mara may guide only from facts she could truthfully possess.**

If she witnessed something, recovered it, mapped it, was told about it, handled the object, or independently discovered it, she may later reason from it. If she could not know it, she does not get to hint from it.

## Player outcome

The Adventurer can ask Mara about places, threats, evidence, objects, routes, and prior attempts and receive guidance grounded in Mara's actual state.

Potential natural commands include:

- `ASK MARA ABOUT DRAGON`
- `ASK MARA ABOUT RAVINE`
- `ASK MARA WHAT SHE FOUND`
- `ASK MARA WHERE I LEFT THE CUSHION`
- `SHOW GLASSES TO MARA`
- `ASK MARA ABOUT THE MAP`

Exact parser grammar is implementation work; this planning contract does not require those exact spellings if existing conversational authority already supplies better natural forms.

## Mara's map is real knowledge, not a magic minimap

Mara may remember and annotate geography she actually knows, including:

- routes she personally traveled;
- landmarks she saw;
- blocked, dangerous, or uncertain passages she investigated;
- connections she inferred but has not yet confirmed;
- places where she noticed water, drafts, sounds, smoke, spoor, structural damage, or another meaningful environmental fact;
- caches or dropped objects she personally witnessed the Adventurer leave;
- places where she herself left or recovered something;
- unresolved map gaps such as an unexplored branch or a route whose far end remains unknown.

She must not know unexplored topology merely because the engine does.

## Knowledge asymmetry is desirable

Mara and the Adventurer are allowed to know different things.

If the Adventurer discovers something while separated from Mara and never tells her, Mara does not automatically know it.

If Mara discovers something while separated from the Adventurer, she may later possess a clue the player character does not yet know.

This allows `ASK MARA WHAT SHE FOUND` to be a conversation with another adventurer rather than a disguised global hint command.

## Progressive guidance ladder

When Mara has enough relevant knowledge, her help may become progressively more useful without becoming an automatic walkthrough.

A typical authored ladder may be:

1. **Recall:** resurface an observation already possessed — what she saw, heard, mapped, recovered, or remembers the Adventurer trying.
2. **Connection:** relate two possessed facts that appear causally relevant.
3. **Directional nudge:** identify a promising physical relationship or route without dictating the exact command sequence.
4. **Concrete advice:** only where Mara could reasonably know the answer from her own experience or sufficient shared evidence.

The progression is situational, not a universal `HINT 1 / HINT 2 / SOLUTION` machine.

## Difficulty-mode composition

Structural difficulty may change **when Mara volunteers what she knows**, not what she knows.

Candidate behavior:

- **Forgiving:** Mara may volunteer relevant earned observations sooner after repeated failure, visible uncertainty, or revisiting a mapped problem.
- **Classic:** Mara usually waits for a relevant question, a repeated failed approach, or a naturally conversational moment.
- **Exacting:** Mara primarily answers direct questions and otherwise trusts the Adventurer to work the problem.

All modes use the same underlying Mara knowledge and map state. Difficulty must never grant her information she could not possess.

## Field-cache composition

Release 1276 should compose naturally with later object-logistics play.

If Mara witnesses the Adventurer leaving an object at a location, she may later remember where it was left. If she did not witness it and was not told, she must not provide magical inventory tracking.

Likewise, if Mara moved, recovered, lost, or cached an object herself, her answer should reflect her actual custody history.

## Boundaries

- no omniscient companion AI;
- no generic quest-marker layer;
- no universal walkthrough database spoken through Mara;
- no hidden access to facts the engine knows but Mara does not;
- no generic notebook that silently synchronizes every clue between characters;
- no approval meter or affection economy attached to asking for help;
- no requirement that Mara always be correct when her evidence is incomplete;
- no flattening Mara into a generic party member or follower framework;
- no replacing ordinary player exploration, examination, mapping, or reasoning.

## Success criteria

A successful Release 1276 should prove through natural play that:

1. Mara can answer at least several materially different questions from facts she actually possesses;
2. she can truthfully say she does not know when the relevant discovery occurred outside her knowledge path;
3. she can possess at least one useful fact the Adventurer did not personally discover;
4. her mapping knowledge distinguishes explored, blocked, uncertain, and unknown geography where appropriate;
5. she can recall at least one witnessed cache or object-placement event without becoming an omniscient tracker;
6. progressive help can resurface evidence and connect facts without directly handing the player an unsupported solution;
7. difficulty mode affects guidance cadence without changing Mara's underlying knowledge;
8. existing Mara biography, location, custody, and memory authorities remain canonical.
