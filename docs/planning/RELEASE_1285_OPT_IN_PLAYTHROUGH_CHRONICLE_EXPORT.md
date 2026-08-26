# Release 1285 - Opt-In Playthrough Chronicle Export

**Status:** planned product train  
**Position:** after Release 1284 Portable Runtime Bundle  
**Default behavior:** completely disabled unless explicitly requested at process launch  
**Network behavior:** none  

## Product thesis

Highly Extended Zork should be able to emit a second, much richer account of a playthrough for tools outside the game without changing what the player sees while playing.

The player-facing transcript remains Zork.

The chronicle export is a parallel local artifact generated only when the runtime is launched with an explicit command-line switch.

The governing rule is:

> **Zork plays normally for the player while, when explicitly enabled, also writing a literal, scene-faithful chronicle of what each turn meant in the world.**

This is not an illustrated frontend, not an external model integration, not a hidden network feature, and not alternate gameplay authority.

## Hard boundary from normal play

When chronicle mode is not enabled:

- no chronicle file is created;
- no additional prose is shown to the player;
- no extra parser commands appear;
- no network request occurs;
- no external provider is contacted;
- no gameplay state, timing, scoring, puzzle behavior, save behavior, or RNG behavior changes merely because the feature exists in the codebase.

Chronicle mode must therefore be observational and side-channel only.

## Launch shape

Exact CLI spelling is deferred to runtime implementation, but the intended shape is process-level opt-in, for example:

```text
zork --chronicle
zork --chronicle-output ./playthroughs/session-001
```

This must be a launcher/runtime switch rather than an in-world parser command. Ordinary players should never encounter it accidentally while playing the story.

## What the chronicle records

The export should retain both exact gameplay evidence and a greatly expanded scene interpretation suitable for later non-game tooling.

Each turn record should be able to include, where the authoritative world actually knows the facts:

- monotonically increasing turn/event identity;
- exact player command text;
- exact visible game response text;
- room/location identity before and after the command;
- movement and route taken;
- visible actors and their physical positions/custody;
- visible important objects, containers, surfaces, and unusual placements;
- current light and visibility facts;
- environmental state such as open/closed/broken/burned/wet/collapsed conditions;
- object transfers, drops, destruction, transformations, and custody changes;
- Mara or other companion participation and authored reactions when they actually occurred;
- hazards, injuries, combat outcomes, deaths, rescues, discoveries, and other consequential events;
- persistent world changes caused by the turn;
- relevant recent context needed to understand what just happened;
- a verbose scene description written for reconstruction rather than for parser economy.

The verbose description may say much more than the normal Zork response, but it may not invent facts the simulation does not know.

## Reconstruction prose

The export should deliberately be more descriptive than player-facing text.

A normal player turn may produce something concise such as:

```text
You drag the carpet outside.
```

The chronicle may instead describe, from authoritative state, the route, physical awkwardness, participating actors, final placement, surrounding architecture, time/light if known, and the immediately visible result.

The chronicle is therefore closer to a storyboard or prose scene ledger than a conventional transcript.

However:

- it must distinguish authoritative fact from optional descriptive inference;
- it must not assign facial expressions, motives, clothing details, weather, camera angles, colors, architecture, or character appearance that Zork does not actually know;
- it must not silently convert ambiguity into canon;
- it must not rewrite failed actions into successful ones;
- it must not turn hidden/unseen state into visible scene description.

When a useful visual detail is unknown, the export should preserve that unknown explicitly rather than fabricate it.

## Output format

The train should produce a local playthrough directory with at least two complementary outputs:

1. **machine-readable event stream** for deterministic downstream processing;
2. **human-readable chronicle** that can be read as a richly described record of the run.

A plausible layout is:

```text
playthroughs/session-001/
  manifest.json
  events.jsonl
  chronicle.md
  raw-transcript.txt
```

Exact names may change during implementation.

### Machine-readable record

Prefer append-only JSON Lines or another simple streaming-safe format so a long session does not require rewriting one giant document every turn.

Each record should carry a schema version and stable IDs where the runtime has them.

### Human-readable record

The Markdown/text chronicle should group the run into readable scenes or turns while preserving exact command/output provenance.

It should be possible to read the document later and understand what physically happened without having to reconstruct every consequence from terse parser responses.

## Scene continuity

The main value of the chronicle is continuity across an entire run.

Later consumers must be able to tell that:

- this is the same carpet that was previously in the Living Room;
- this photograph depicts an earlier state rather than the current room;
- this is the same sword the troll stole and later dropped;
- this cabinet still contains the same files after being moved;
- Mara is present because she actually followed or agreed to help, not because a downstream renderer found her aesthetically useful;
- damage, missing objects, repaired state, weather/time state when implemented, and other persistent facts remain consistent from frame to frame.

Stable identity is more important than decorative prose.

## Relationship to existing far-horizon Illustrated Zork work

The older `FAR_HORIZON_ILLUSTRATED_ZORK.md` concept proposed opt-in external scene rendering.

Release 1285 deliberately extracts the prerequisite that is useful even without any renderer:

```text
Authoritative Zork state
        |
        v
Turn/event capture
        |
        v
Structured scene chronicle
        |
        v
Local files
```

Nothing beyond `Local files` belongs to this train.

External image generation, graphical frontends, computer vision consumers, book composition, or any other downstream use are separate systems and are intentionally unspecified here.

This separation keeps Zork useful as a truthful scene source without making external AI or networking part of the game.

## Privacy and locality

Chronicle mode is local by design.

- The runtime writes only to the requested local output path.
- It performs no upload.
- It performs no provider discovery.
- It contains no API credential handling.
- It does not phone home.
- It does not require an account.
- It does not make a player's chronicle part of gameplay save-state unless a later explicit design requires a minimal linkage identifier.

A user can choose what to do with the exported files after Zork exits. That is outside this train.

## Save/restore and branching play

The chronicle must record native `SAVE`, `RESTORE`, restart, death recovery, and other timeline-changing operations honestly.

Do not rewrite the file as though restored turns never happened.

A restored game should produce an explicit timeline branch or restoration marker so the historical chronicle can distinguish:

- what the player originally did;
- the point they restored to;
- what they did afterward.

This matters because the chronicle is a history of the actual play session, not merely a dump of the final surviving world state.

## Performance and failure behavior

Chronicle export must not make the game fragile.

- File-write failure should report a launcher/runtime error without corrupting story state.
- If chronicle output becomes unavailable mid-session, gameplay should remain recoverable where practical.
- Event serialization must be bounded and streaming-friendly.
- The feature should not require walking the entire object tree every turn if a smaller authoritative event/state delta can produce the same truth.
- No network latency exists because the train has no network component.

## Qualification

Release 1285 qualification should run one substantial natural playthrough with chronicle mode enabled and the same playthrough with it disabled.

Prove at minimum:

1. disabled mode creates no chronicle output;
2. enabled mode creates the expected local files;
3. player-visible game transcript is unchanged by enabling the exporter;
4. commands and exact game responses are preserved;
5. room transitions are recorded correctly;
6. object custody/location changes remain consistent across turns;
7. one persistent environmental consequence survives into later scene records;
8. one Mara interaction is recorded only when she actually participates;
9. one failed action remains a failed action in the chronicle;
10. one save/restore sequence is represented as historical branching rather than silently erased history;
11. one moved House object remains the same stable object across multiple later records;
12. a long run can stream output without unbounded memory growth;
13. the chronicle contains no hidden world facts that were not visible or otherwise explicitly marked as non-visual authoritative context;
14. gameplay continuation remains normal after chronicle writes.

## Non-goals

- no image generation;
- no external model/API integration;
- no computer-vision integration;
- no automatic book generation;
- no public gallery;
- no network service;
- no player-facing illustrated mode;
- no `DRAW` parser command in this train;
- no second simulation;
- no transcript replacement;
- no omniscient prose that leaks puzzle secrets;
- no audit framework.

## Success criterion

A complete session should leave behind a faithful enough local record that a future external tool can reconstruct the playthrough scene by scene without asking Zork to rerun the adventure and without guessing what physically happened.

The game remains the source of truth.

The chronicle is the preserved memory of that truth.
