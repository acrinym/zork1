# Release 1277 Extension - Mara Cooperative Requests

**Parent train:** Release 1277 - Mundane Objects, Field Caching & Uncertain Utility  
**Status:** required companion-agency extension to planned Release 1277  
**Implementation gate:** planning only until the current Release 1276 product-playtest gauntlet is healthy

## Product principle

Mara is a companion, not a second player-character and not a controllable unit.

The parser may directly control the Adventurer because that is the player's interface into their own character. That does not imply interpersonal command authority over Mara.

The governing rule is:

> **The player can ask Mara to act. Mara decides whether, when, and how she agrees.**

This is not gender-specific behavior. The distinction exists because Mara is an autonomous companion with her own biography, body state, knowledge, priorities, custody, boundaries, and relationship history. The same rule should apply to any future autonomous companion regardless of gender.

## Request grammar

The preferred player-facing form is explicitly a request.

Representative natural commands:

- `ASK MARA TO HELP ME MOVE THE CARPET`
- `ASK MARA TO HELP WITH THE CARPET`
- `ASK MARA TO MOVE THE CARPET`
- `ASK MARA TO CARRY THE CHAIR`
- `ASK MARA TO HELP BRING THE CARPET OUTSIDE`
- `ASK MARA TO HOLD THE OTHER END`

Natural polite aliases may be accepted where parser-safe, such as `MARA, COULD YOU HELP ME MOVE THE CARPET?`, but the semantic authority is the same request action rather than imperative possession of Mara.

Direct second-person imperative syntax may be parsed for robustness if existing Zork grammar naturally reaches it, but it must not bypass Mara's decision. If the player types `MARA, MOVE THE CARPET`, the engine may interpret that as a request directed at Mara rather than as guaranteed command execution. Mara remains free to object to the tone, refuse, reinterpret it, or cooperate according to authored circumstances.

Do not implement a universal natural-language planner. The grammar should dispatch only into explicitly supported companion-request actions.

## Mara's answer is a decision, not a canned gate

A valid request may produce several materially different outcomes.

### Agree now

Mara agrees and participates immediately when:

- she is physically present or can reasonably join through existing movement authority;
- the requested action is one she can truthfully perform;
- her current body state permits it;
- the object and route physically permit it;
- she is not occupied by a higher-priority authored situation;
- current relationship/boundary state does not make close cooperation inappropriate;
- the request does not ask her to violate established knowledge or custody truth.

Example tone:

> Mara looks at the rolled carpet, then at the doorway. "All right. You take that end."

### Refuse

Mara may simply say no.

Refusal can be caused by:

- injury or insufficient physical capability;
- danger that she reasonably recognizes;
- a route or object that physically cannot support the proposal;
- an unresolved boundary or rupture;
- an action that would destroy or surrender something she considers hers;
- a task she has no reason to perform;
- a request that conflicts with a specific established priority;
- a genuinely bad or nonsensical proposal where her existing knowledge gives her reason to reject it.

Refusal prose should explain Mara's reason when she can articulate one. Avoid generic `Mara refuses.` when a concrete causal reason is available.

### Disagree but cooperate

A dumb idea is not automatically a refusal.

If the proposal is harmless, physically possible, and compatible with Mara's current relationship and priorities, she may tell the Adventurer exactly what she thinks and then help anyway.

Example:

> Mara stares at the carpet, then at the boarded front door. "There isn't even a porch." She takes the other end. "Fine. Your imaginary welcome mat."

This is often more interesting than either blind obedience or automatic snippiness.

### Busy / not now

Mara may decline the timing without rejecting the task.

Examples include:

- actively surveying or recording something;
- tending an injury;
- dealing with immediate danger;
- carrying out an already-authored action whose interruption would be nonsensical;
- a current argument/boundary state where she will revisit the request later but not immediately.

The response should distinguish `not now` from `no`.

### Promise to do it later

For selected bounded tasks, Mara may accept the request but defer execution.

A promise is a real remembered commitment, not flavor text.

If she says she will do it later, the game must preserve enough state to make one of the following happen honestly:

- she performs the task when the required conditions become true;
- she tells the player why the promise is no longer possible;
- she asks to renegotiate it when circumstances materially changed;
- she explicitly abandons or refuses the promise for an authored reason.

Do not let promises evaporate silently.

Do not create a generic infinite NPC task queue. Release 1277 should support only a small bounded set of named cooperative request commitments required by authored gameplay. If multiple simultaneous promises would make state or prose dishonest, Mara can decline to take another one until the current commitment is completed or released.

## Cooperative labor

The first major request family should be ordinary physical cooperation inside and around the House.

This composes directly with the Release 1277 House Spatial Agency extension.

Candidate supported requests include:

- help move or drag the canonical oriental carpet;
- help roll/unroll or reposition the carpet where the authored action benefits from two people;
- help move selected chairs, tables, cabinets, archive furniture, or other explicitly relocatable furnishings;
- hold one end while the Adventurer navigates a route;
- help carry a bulky object through a physically valid doorway, stair, window, or exterior route;
- help empty/reload a selected bulky furnishing when that is the physically sensible way to move it.

The action must manipulate the real object and real containment/location state. Mara's help does not teleport the object or create a shadow position.

## Cooperation changes feasibility, not reality

Mara's presence may change what is physically practical.

Example classes:

- **easy alone:** chair, carpet fragment, small loose object;
- **awkward alone but easier together:** rolled whole carpet, table, loaded box;
- **requires two people in an authored case:** especially bulky cabinet or object that cannot safely be maneuvered solo;
- **impossible even together:** route too narrow, fixed architecture, object actually built in, unsafe geometry, or mass beyond the authored participants.

A second person does not override room dimensions, locked doors, missing routes, broken body state, or object identity.

Example causal refusal:

> Mara takes the lower corner and the two of you get the cabinet as far as the stair turn. It jams between the wall and banister. She lets her end settle back to the floor. "No. Not upright, and not with all that still inside it."

## Route-grounded cooperative movement

Requests such as `ASK MARA TO HELP BRING THE CARPET OUTSIDE` should respect actual geography.

The carpet and participants must traverse a physically valid House route rather than jumping directly from `LIVING-ROOM` to `WEST-OF-HOUSE`.

Movement can therefore encounter intermediate complications:

- a closed door;
- a narrow window;
- a stair turn;
- another furnishing blocking clearance;
- an object that needs rolling or emptying first;
- an environmental hazard;
- Mara becoming unable or unwilling to continue.

The player should see enough of that journey to understand the physical event. Do not replace a multi-room haul with an unexplained location assignment.

## Mara body state remains authoritative

Existing Mara biography already makes physical capability dependent on lived history.

A shoulder injury, recovery state, current encumbrance, or other established physical limitation must matter.

If Mara cannot safely help haul a cabinet because of her shoulder, the request system must not route around that merely because `ASK` parsed successfully.

Likewise later recovery may make the same request possible without erasing the history that she was previously injured.

## Relationship and boundary state remains authoritative

Cooperative requests must compose with existing rupture, repair, apology, respected-space, and renewed-choice history.

Mara may remain willing to warn the Adventurer about danger while refusing optional close physical cooperation during an unresolved rupture.

Example:

> "If somebody's trapped under it, I'll help," Mara says. "If you're redecorating, no. Not right now."

Repair does not erase the refusal from history; it simply permits future choices to differ because the relationship state genuinely changed.

Do not add a generic obedience, affection, trust, or compliance score.

## Knowledge constrains judgment

Mara may only call an idea dangerous, impossible, useful, or foolish from information she can honestly possess.

If she has never seen the route or object condition and has not been told about it, she cannot reject a request using omniscient topology.

She may instead say she does not know, ask to inspect it, agree conditionally, or refuse to guess.

Conversely, when her field knowledge genuinely reveals a flaw in the plan, she should be allowed to say so.

## Custody and ownership

A request is not permission to seize Mara's inventory.

If the task requires an object she owns or currently carries, she decides whether to use, lend, transfer, or retain it through the existing custody authority.

The Adventurer cannot use `ASK MARA TO ...` as a parser exploit that silently transfers her rope, plummet, notebook, or other possessions.

## Participating creates biography

When Mara helps perform a significant action, that participation can become a truthful remembered event using existing Mara-history authorities or a narrowly extended named fact.

Examples:

- Mara helped drag the oriental carpet outside;
- Mara helped relocate the archive cabinet;
- Mara refused because her shoulder was not ready;
- Mara promised to move something later and fulfilled it;
- Mara thought the welcome-mat plan was ridiculous but participated anyway.

Later conversation may refer to those facts when they matter.

Example:

`ASK MARA ABOUT CARPET`

> "The ridiculous welcome mat? Yes. I helped you put it there."

Do not create a parallel generic event-log or second Mara-memory engine solely for requests.

## Requests can interact with `SNAPSHOT`

The House Spatial Agency extension allows physical player-authored photographs.

If Mara is present and helping when a snapshot is taken, the photograph may truthfully capture her participation.

A particularly good authored sequence is:

1. ask Mara to help carry the whole carpet outside;
2. Mara comments on the lack of porch/patio and nevertheless agrees;
3. both physically haul it to `WEST-OF-HOUSE`;
4. player takes a snapshot while Mara is present;
5. carpet later moves elsewhere;
6. photograph preserves that earlier ridiculous shared moment;
7. Mara can later recognize or discuss the photograph if shown through an authored interaction.

This composes request agency, shared biography, House spatial agency, and frozen historical photographs without creating a generic memory simulator.

## Tone rule

Mara should not become uniformly snippy merely because the player directed grammar toward her.

Her response should come from the situation.

Possible tones include:

- willing;
- amused;
- skeptical;
- annoyed;
- concerned;
- occupied;
- injured;
- teasing;
- firm;
- curious;
- enthusiastic;
- baffled but cooperative.

The product goal is not `Mara resists commands because she is a woman.`

The product goal is:

> **Mara has agency because she is a companion rather than the player's avatar.**

Any future autonomous companion should receive the same architectural respect.

## What this extension must not do

- no generic companion AI;
- no universal natural-language task planner;
- no arbitrary remote orders;
- no universal NPC job queue;
- no hidden obedience/compliance meter;
- no gender-specific refusal mechanic;
- no automatic puzzle solving;
- no omniscient route planning;
- no teleporting Mara or requested objects to satisfy a task;
- no parser exploit that steals Mara's inventory;
- no promise flavor text that silently disappears;
- no guaranteed compliance merely because the grammar parsed;
- no generic event-log duplicating existing Mara history;
- no conversion of Mara into a second player-character.

## Qualification shape

Release 1277 qualification should include natural player-command histories for cooperative requests after the current Release 1276 playtest gate is healthy.

At minimum demonstrate:

1. `ASK MARA TO HELP MOVE THE CARPET` parses as a request;
2. healthy/present/cooperative Mara agrees when the action is physically valid;
3. the real carpet moves through real location authority;
4. a solo awkward move and a cooperative move produce meaningfully different feasibility where authored;
5. an impossible route remains impossible with two people and gives a causal reason;
6. an injured Mara refuses a physically inappropriate lift for the real injury reason;
7. a recovered Mara can later reconsider without erasing injury history;
8. unresolved rupture can block optional close cooperation while preserving other protective behavior;
9. repaired relationship can later permit a fresh request;
10. one harmless ridiculous request receives authored skeptical/amused judgment but still succeeds;
11. one genuinely bad request is refused because Mara possesses the specific evidence needed to reject it;
12. one request receives `not now` because Mara is genuinely occupied;
13. one bounded deferred request becomes a real promise;
14. the promise survives save/restore;
15. the promised task later completes or is explicitly renegotiated rather than disappearing;
16. Mara participation becomes queryable/referencable history where appropriate;
17. `ASK MARA TO HELP BRING THE CARPET OUTSIDE` uses a real House route;
18. place the carpet at `WEST-OF-HOUSE` as the absurd welcome mat;
19. take a snapshot of the shared result with Mara present;
20. move the live carpet later and verify both Mara's memory and the photograph still refer truthfully to the earlier event;
21. continue normal play afterward.

## Success criterion

The player should come away thinking neither:

> Mara is a commandable NPC.

nor:

> Mara exists to reject whatever I type at her.

The desired thought is:

> **I can ask Mara for help because she is actually here with me, and her answer depends on who she is, what has happened, what she knows, and what we are trying to do.**
