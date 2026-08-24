# Release 1277 Extension - House Spatial Agency & Player Memory

**Parent train:** Release 1277 - Mundane Objects, Field Caching & Uncertain Utility  
**Status:** required product extension to the planned Release 1277 train  
**Implementation gate:** do not begin production implementation until the current Release 1276 product-playtest gauntlet is healthy

## Why this belongs in Release 1277

Release 1277 already establishes a world where ordinary physical objects have persistent location, custody, material behavior, and uncertain utility.

That doctrine should not stop at expedition junk.

The white house should also become a place the player can physically inhabit and rearrange. The player should be able to move selected ordinary furnishings, leave objects where they want them, change what a room looks like through those choices, and preserve selected moments of the adventure as physical photographs.

The governing doctrine for this extension is:

> **The house remembers not only what happened to the player, but what the player chose to do with the house.**

This is spatial agency, not a decorating minigame.

It extends the same persistent physical-world rules already required for field caches into the player's home base.

## Existing authorities this extension must preserve

This work must compose with the current Zork lineage rather than create a parallel house/furniture/save system.

### Canonical rug and trap-door authority

At the current Release 1276 lineage, the canonical `RUG` is the real Living Room carpet from `1dungeon.zil`.

Its inherited behavior is still deliberately restrictive:

- it begins in `LIVING-ROOM`;
- it has `TRYTAKEBIT`, not ordinary portable `TAKEBIT` behavior;
- `TAKE RUG` refuses because it is extremely heavy;
- its canonical one-time `MOVE` / `PUSH` behavior sets `RUG-MOVED` and reveals `TRAP-DOOR`;
- Living Room and trap-door routing still depend on the established `RUG-MOVED` / trap-door state.

Release 1247 narrative physicality added richer material behavior without replacing that puzzle authority. Cutting or damaging the rug currently marks/frays it through the existing damage state, but it does **not** yet transform the rug into movable pieces.

Release 1277 must therefore extend the real canonical rug rather than introduce a duplicate carpet object or shadow trap-door state.

### Existing object-location and containment authority

Normal object location and containment remain the source of truth.

If a chair is in the Bedroom, it is physically in the Bedroom.

If an archive cabinet is moved with papers inside it, those papers remain contained by that same real cabinet unless another established action physically removes them.

Do not add a second furniture-position table that disagrees with `LOC`, `MOVE`, containers, surfaces, or the existing object tree.

### House of Records authority

The completed House of Records program already establishes the Attic as a period-authentic archive containing maps, photographs, cassettes, printouts, dossiers, case files, dream records, and completed expedition records.

Release 1230 also already uses bounded final world/house snapshots derived from real state.

Player-created photographs should compose with those ideas, but must not reopen or replace the completed 96/96 House of Records program. This is a new player-agency extension above it.

## The oriental carpet becomes a real movable object

The Living Room carpet must stop being a one-shot puzzle prop that becomes effectively nailed to one side of the room after revealing the Cellar.

After preserving the canonical reveal interaction, the player must be able to physically relocate the carpet.

Desired ordinary play includes:

- revealing the trap door normally;
- taking, hauling, folding, rolling, dragging, or otherwise transporting the carpet through physically plausible House routes using authored parser behavior;
- leaving it in another House room;
- bringing it outside;
- putting it west of the House as an absurd improvised welcome mat;
- later retrieving it and bringing it somewhere else;
- native save/restore preserving its exact physical location and condition.

The carpet may remain heavy and awkward. Heavy must mean **difficult**, not **cosmically fixed**.

Do not solve this by silently teleporting it between room IDs. The command history should represent the player's physical handling of it.

### West of House welcome-mat consequence

If the real carpet, or a substantial recognizable piece of it, is physically present at `WEST-OF-HOUSE`, ordinary `LOOK` should notice the mismatch.

The exact final prose can be authored during implementation, but the intended tone is something like:

> A large oriental carpet lies inexplicably in front of the boarded entrance, trying very hard to be a welcome mat despite the notable absence of a porch, patio, or any architectural reason for it to be here.

The point is not this exact sentence. The point is **location-aware narration**.

A player-created arrangement should become part of what the room looks like rather than existing only as a bland object-list footer.

Other particularly ridiculous or meaningful placements may earn similarly bounded authored prose.

## Cutting the carpet must eventually produce real pieces

Current Release 1276 physicality only frays/damages the rug. Release 1277 should finish the material consequence where a sufficiently destructive, credible cutting action actually divides it.

Requirements:

- use the one canonical carpet as the source object;
- do not clone a pristine second carpet;
- preserve the established trap-door reveal state;
- transform the whole carpet into a bounded set of real carpet-piece objects only when the authored cutting action genuinely reaches that consequence;
- pieces inherit the relevant worn/damaged identity of the original carpet;
- each resulting piece has its own real persistent location and can be moved independently;
- pieces may be used as smaller mats, padding, covering, wrapping, fuel only if existing material rules and authored geometry make those uses credible;
- no magical reconstitution unless a future explicitly authored repair system earns it;
- room narration may distinguish a whole oriental carpet from a ridiculous carpet fragment being used as a doormat.

If the carpet is cut before the player has formally used the inherited `MOVE RUG` reveal, the implementation must still preserve the canonical physical truth that removing or opening the covering can expose the trap door. It must not softlock Cellar access because the old one-shot verb path was bypassed.

## Selected House furniture becomes relocatable

Release 1277 should make a bounded, deliberately chosen set of **freestanding** House furnishings movable.

Candidate classes include:

- chairs;
- the real Kitchen table;
- the real Attic table;
- selected archive/filing cabinets;
- small shelving or display furniture where it is genuinely freestanding;
- the oriental carpet and carpet pieces;
- later ordinary House furniture introduced by other releases.

This is not permission to make architecture portable.

Walls, built-in fixtures, stairs, doors, windows, sinks, ranges, structural shelving, and other genuinely fixed elements remain fixed unless a specific authored mechanic says otherwise.

### Carry versus haul

Different objects should move in ways that fit their mass and shape.

A chair or rolled carpet may be carryable if existing carrying authority permits it.

A loaded filing cabinet or large table should generally be pushed, dragged, hauled, emptied, or otherwise handled as a bulky object rather than disappearing into the Adventurer's pocket.

The implementation may add narrow parser synonyms or movement forms where existing grammar is insufficient, but must not create a universal furniture/navigation engine.

### Contents move with their container

If a real movable cabinet, box, drawer unit, table surface, or similar furnishing contains other objects, moving the furnishing must respect the real containment tree.

A cabinet carried or hauled from the Attic to another room does not leave its files floating behind because a separate location table forgot about them.

Contents may affect whether the furnishing is too heavy or awkward to move. That is an authored physical constraint, not a second inventory system.

## Room fit is authored, not simulated

Justin's desired rule is simple: move the furniture **if there is space**.

Release 1277 should implement that through bounded authored fit/path constraints rather than a generic volumetric room simulator.

Examples:

- a chair fits in most House rooms;
- a broad table may fit in the Living Room but not through a narrow stair or crowded Bedroom route without first clearing/turning it;
- a loaded archive cabinet may be impossible to drag down a particular stair until emptied;
- a large rug can be rolled to negotiate a route that its fully spread form cannot;
- a cabinet cannot be pushed through a closed door or through an opening narrower than the authored object geometry permits.

The player should receive causal prose explaining the actual obstruction.

Bad refusal:

> You can't do that.

Good refusal:

> The cabinet reaches the turn in the stairwell and jams solidly between the banister and wall. It will not make that corner while loaded and upright.

No numeric floor-plan UI is required.

## Player-created arrangements affect room narration

The white House already evolves from adventure consequences. Release 1277 should also allow restrained prose projection from player-created arrangements.

Examples:

- carpet outside the front door;
- chair dragged beside the trophy case;
- Attic cabinet brought into the Living Room;
- a table removed from the Kitchen, leaving the room noticeably barer;
- a wall or display area containing player-created photographs;
- a pile of carpet pieces left somewhere absurd.

The room does not need bespoke prose for every combinatorial arrangement.

Use a bounded projection rule:

1. preserve the canonical room description;
2. append one or a few high-value authored arrangement observations for specially meaningful placements;
3. let ordinary object listing handle the rest;
4. never invent an arrangement that is not present in the real object tree.

## `SNAPSHOT` - player-authored photographs of actual moments

Release 1277 should add a player command for deliberately preserving a moment as a physical photograph.

Representative command:

`SNAPSHOT`

Useful synonyms may include `TAKE PHOTO`, `TAKE PICTURE`, or another parser-natural form if they compose cleanly with existing grammar.

### Physical authority

`SNAPSHOT` should be backed by a real camera/film authority rather than behaving as unexplained out-of-world UI.

A period-appropriate instant camera is especially compatible with the House of Records aesthetic because the resulting photograph can become a real object immediately.

Use a bounded number of exposures. The game should not manufacture infinitely many dynamic objects merely because the player can type `SNAPSHOT` forever.

When an exposure is available:

1. the shutter captures the current scene;
2. a real photograph object is materialized;
3. that photograph retains the captured moment even after the live world changes;
4. the photograph can be carried, dropped, lost, damaged, stored, filed, displayed, or destroyed according to ordinary physical rules;
5. save/restore preserves both the photograph's custody and the exact captured scene identity.

### What the photograph remembers

A photograph is a frozen observation, not a live portal into the current room.

The player should be able to take a picture of a scene, change that scene, return to the House, and later examine the photograph and receive the description of **what was there when the shutter fired**.

At minimum, a captured scene should preserve enough bounded state to describe:

- the room/location;
- important visible actors, including Mara when present;
- important visible objects and unusual placements;
- major visible object conditions or damage;
- major visible mechanism/environment state;
- an important current consequence when the scene has one;
- the fact that this is the historical captured moment rather than the room's present state.

Implementation may store a compact scene fingerprint and render from that frozen fingerprint instead of storing an arbitrary raw transcript string. The requirement is player-facing fidelity: later examination must describe the captured moment and must not silently re-query current live state.

### Photographs become House objects

The player should be able to bring photographs home and decide what to do with them.

Possible physical homes include:

- an Attic photo box or archive cabinet;
- a corkboard;
- a frame or display surface in the Living Room;
- a Bedroom wall or other authored display area;
- ordinary loose storage or a pile on a table.

This should enable personal House histories such as:

- a photograph of Mara at a significant location;
- the troll after a ridiculous fight outcome;
- the first view of a new region;
- a bizarre object cache the player created;
- the damaged House exterior;
- the oriental carpet lying outside as an improvised welcome mat;
- a room after the player rearranged its furniture.

The archive may classify or describe these photographs, but it must not claim the player photographed something they never actually captured.

## Interaction with Mara

Mara must not become omniscient about player rearrangements or photographs.

If she is present while furniture is moved or a snapshot is taken, authored reactions or memory may be appropriate through her existing knowledge/relationship authorities.

If she is absent and never learns about it, she does not automatically know the player moved a cabinet downstairs or photographed a scene elsewhere.

A photograph can itself later become evidence the player shows her if an existing or future authored interaction supports that.

Do not create a second Mara-memory system solely for furniture.

## Persistence and consequence

All of these choices are real world state.

Native `SAVE` / `RESTORE` must preserve:

- whole-carpet location and condition;
- carpet-fragment existence and independent locations after cutting;
- selected furniture locations;
- container contents inside moved furniture;
- meaningful House arrangement projections;
- camera/film remaining exposures;
- every materialized photograph's location;
- every photograph's frozen scene identity.

A save restored after deliberate corruption must return the arrangement exactly, not approximately.

## What this extension must not do

- no universal furniture physics engine;
- no arbitrary room-capacity number shown to the player;
- no duplicate House coordinate system;
- no second object-location authority;
- no magical furniture teleportation;
- no turning built-in architecture into inventory objects;
- no infinite photograph generator;
- no live photograph that changes when the photographed room changes;
- no photograph that reveals unseen objects or future consequences;
- no raw omniscient transcript recorder hidden behind `SNAPSHOT`;
- no reopening the completed House of Records 96/96 program;
- no replacement for canonical rug/trap-door state;
- no object duplication to avoid transforming the real rug;
- no score farming for decorating, moving furniture, or taking photographs;
- no procedural interior-design minigame;
- no generic simulator introduced merely to support one table and one cabinet.

## Qualification shape

This extension should eventually receive a real-player journey inside Release 1277 qualification, after the current pre-1277 product-playtest gauntlet has been made healthy.

The journey should demonstrate, with ordinary commands and no teleport/setup cheats:

1. enter the House naturally;
2. reveal the Cellar entrance through the real rug/trap-door authority;
3. physically relocate the whole carpet to another House area;
4. move it outside to `WEST-OF-HOUSE`;
5. `LOOK` and receive location-aware out-of-place welcome-mat narration;
6. retrieve it again rather than treating the outside placement as a scripted endpoint;
7. cut the canonical carpet through a credible destructive interaction and produce real persistent pieces;
8. move at least two resulting pieces to different locations;
9. relocate one light furnishing, such as a chair;
10. attempt one oversized/blocked furniture move and receive a physical fit/path explanation;
11. successfully relocate one bulky furnishing through a valid route;
12. prove contents remain inside a moved cabinet/container where physically appropriate;
13. take at least three snapshots of genuinely different live scenes;
14. alter at least one photographed scene after the shutter fires;
15. examine the corresponding photograph and prove it still describes the earlier captured state;
16. bring at least one photograph to the House and display/store it physically;
17. save with a non-default arrangement and photographs distributed across the House;
18. deliberately alter that state;
19. restore and prove exact carpet, fragment, furniture, contents, photograph custody, and snapshot identity;
20. continue normal play afterward.

One particularly valuable scenario is deliberately silly:

- put the oriental carpet outside the boarded front entrance;
- take a snapshot of the absurd improvised welcome mat;
- later move the carpet elsewhere;
- return to the photograph in the House;
- verify the photograph still describes the old outside-carpet moment while `WEST-OF-HOUSE` correctly describes the current world without it.

That single history proves spatial agency, location-aware narration, frozen player memory, and separation between historical record and live state.

## Success criteria

Release 1277 should now support two complementary player thoughts:

> I have no idea whether this stupid thing matters, but I have to decide where to leave it.

and:

> This is my House. I put that there, I moved that here, and this picture is from when that happened.

The second thought is the purpose of this extension.
