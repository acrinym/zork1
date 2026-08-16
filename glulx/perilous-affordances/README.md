# Release 1264 — Perilous Affordances / Let the Player Be Wrong

Release 1264 applies the next Shadowgate → Parser IF design lesson directly to existing Zork objects: **an explicit physically destructive choice should not be vetoed merely because the object may be useful later.**

The train is deliberately authored, not systemic. Four exact seams were chosen after inspecting the staged Release 1263 world:

1. the canonical **brass lantern** already shatters when thrown, but an explicit weapon-driven `BREAK`/`DESTROY` currently falls through to the generic refusal;
2. the canonical **hemp rope** participates in many real routes and material anchors but is parser-proof against burning and cutting;
3. the Release 1263 **iron-bound hide fire screen** can be consumed by dragon breath but cannot be deliberately damaged by the player;
4. the Release 1262 **star-glass** is a real treasure/bargaining object but explicit destruction is refused despite other dragon solutions and substitute treasures remaining available.

## Player-facing contract

Release 1264 lets those exact choices land:

- destroying the lantern with a real weapon reaches the existing `BROKEN-LAMP` world object, the same canonical consequence family already used by `THROW LAMP`;
- cutting or burning the rope removes the exact canonical rope and clears the physical tie states that depended on that exact object;
- if the rope is burned while tied around the Adventurer's own legs, it burns through **and** transfers the existing authored clothing-fire warning state, which can still be recovered from with real bottled water;
- deliberately burning the fire screen spends its already-authored material margin before the dragon ever touches it; cutting it ruins the hide barrier while leaving the frame as a carried record of the choice;
- smashing the star-glass removes that exact treasure for the play history, while the dragon's other bargains, bait/containment route, smoke route, and other treasures remain governed by their existing authorities.

The release does not guess that every sword can destroy every object. It does not create hit points, durability percentages, crafting salvage, generic shards, or a material-type registry.

## Fairness

Every new irreversible transition requires an explicitly destructive player command and an appropriate existing tool/flame source where the parser already requires one. Harmless commands do not silently destroy progress.

The rope/fire case intentionally demonstrates a recoverable bad choice: setting fire to hemp tied around your own legs frees the legs but ignites clothing using the existing self-fire state; using real bottled water on yourself extinguishes that danger.

The star-glass case intentionally demonstrates substitute play: once the glass is smashed, another real treasure can still buy the dragon's toll.

## Architectural boundaries

Release 1264 adds no:

- universal object-destruction engine;
- generic material simulator;
- generic durability or item HP;
- crafting/salvage economy;
- hidden bad-choice counter;
- new parser grammar;
- replacement dragon, rope, fire, or equipment authority.

The release composes the existing `LANTERN`, `ROPE-FUNCTION`, `DRAGON-TREASURE-F`, Release 1263 ablative condition table, material-rope anchors, and existing self-fire recovery behavior.

## Qualification

The qualifier first re-runs the complete locked Release 1263 qualification. Release 1264 then compiles the staged production and test stories and drives natural player commands through six histories:

1. **lantern destruction:** turn on the real lantern, explicitly break it with a real sword, then pick up the existing broken-lantern object;
2. **recoverable rope mistake:** tie the canonical rope around yourself, burn it with a live torch, then extinguish the transferred clothing fire with real bottled water;
3. **screen consequence:** deliberately scorch a sound fire screen, then face the real dragon and prove that one actual breath now consumes the screen's remaining trustworthy margin;
4. **star-glass substitute:** smash the star-glass, then use the real chalice to buy the dragon toll and take a different hoard object;
5. **untouched lamp/rope:** use the canonical lantern and Dome Room rope route normally without destructive commands;
6. **untouched star-glass:** offer the intact star-glass to the real dragon and use the normal bargain route.

Test-only setup/status verbs materialize those histories efficiently, but the actions under qualification are normal parser commands.

### Locked predecessor

Release 1264 is pinned to the exact Release 1263 production artifact:

- SHA-256: `a29a94fe607130c6bc2f86c140b6d3a2d7c065c9ceb80263a5dbfb51db3b3997`

and to the exact staged Release 1263 source identities recovered from the final green qualification artifact:

- production: `5962b663b387d1a82d594f7a5ad3fc94881d87b13c32899a1a7043459b24a237`
- dev: `be9927dc9b3153bad4d8abd9cd7ce793aa8601ea7da4e43dd48001d4791124a0`

### Locked production artifact

Candidate qualification run `31948799279` first requalified Release 1263, staged Release 1264 with zero smell errors, compiled both production and test stories, and passed all six natural-command histories. It then stopped deliberately because the candidate identity was not yet locked.

That proven candidate is pinned exactly as:

- file: `zork1-glulx-perilous-affordances-let-player-be-wrong.ulx`
- format: Glulx
- version: `0x00030103`
- size: `471040` bytes
- checksum: `0xb70ad718`
- SHA-256: `04216477fb50deeb04f833122d5874c602277b2b4522cbf72420f2b987b52a1d`

Locked qualification run `31949037137` reproduced that exact artifact and all six histories successfully on head `c80af99c864cfb9f58aa77415121ef476ca14e7d` before the planning-board refresh.

### Pull request state

Release 1264 is open as **PR #69**. It is not merged and must not be merged without a new explicit merge whistle. Any later release-path or substantive code change must reproduce the locked artifact and qualification evidence on the new exact head before the PR can be considered clean.
