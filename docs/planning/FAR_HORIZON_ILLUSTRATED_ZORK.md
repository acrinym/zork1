# Far Horizon — Illustrated Zork / External Scene Rendering

**Status:** FAR HORIZON — intentionally not an active or near-term train  
**Captured:** August 12, 2026  
**Implementation posture:** Do not pull forward ahead of the existing world-state, time/weather, consequence, and renderer-export work.  
**Network posture:** EXCLUSIVE OPT-IN. No external model call may occur unless the player explicitly enables the feature and invokes it.

> **2026-08-30:** Justin parked photo/graphic and GUI work. This document stays FAR HORIZON. It is not in CURRENT, NEXT, or the 1287–1292 Living Collection program. Release 1286 chronicle export remains a local text side-channel only.

> **2026-08-23 boundary clarification:** Release 1285 — Opt-In Playthrough Chronicle Export promotes only the local truthful scene/event export prerequisite into the active product queue. This far-horizon item remains separate. Release 1285 performs no image generation, provider calls, computer-vision integration, book composition, or other downstream consumption.

## Vision

Eventually, Highly Extended Zork should be able to illustrate the exact current scene from authoritative game state.

The player supplies an API key for an image-capable external model/provider and explicitly enables external illustration. A command such as:

```text
> DRAW
```

captures the current Zork scene, compiles it into a structured rendering request, and sends that request to the configured provider. The resulting image is an illustration of the player's actual playthrough state rather than generic Zork fan art.

The defining idea is simple:

> **Zork decides what is true. The external model only illustrates it.**

The image model must not invent authoritative world state, silently move objects, restore missing equipment, change character identity, rewrite pronouns, undo damage, change weather, alter time of day, or otherwise become a second simulation.

## Player-facing shape

The minimal eventual command family may include:

- `DRAW` — illustrate the scene currently visible to the adventurer.
- `DRAW ROOM` — request a wider environmental composition of the current location.
- `DRAW <VISIBLE SUBJECT>` — focus on a visible actor, object, or feature while preserving current scene truth.
- `DRAW LAST` — illustrate the immediately preceding significant event from recorded authoritative state, when such a snapshot exists.

These are horizon concepts, not parser commitments. The final vocabulary should be chosen only when the underlying scene/state export is mature.

## Explicit opt-in and BYOK requirements

This feature must be disabled by default.

Enabling it requires an explicit player action and a configured provider/API key. The game must clearly state that scene data will leave the local runtime when a render is requested.

Requirements:

1. No automatic render calls.
2. No hidden background calls.
3. No bundled developer key as the normal player path.
4. Player-supplied credentials remain outside story/save-state content wherever practical.
5. Provider choice is adapter-based rather than hard-wired to one vendor.
6. Disabling external illustration returns the game to a completely local/non-networked state.
7. A failed, refused, rate-limited, or unavailable render changes no Zork state.

Possible future providers may include any image-capable service available at implementation time. No present provider is canonically required.

## Authoritative scene snapshot

`DRAW` must operate on a structured snapshot produced by Zork, not on a loose prompt generated from room prose alone.

A snapshot should eventually be able to contain, where relevant:

- stable room/location identity;
- current room description and important authored prose;
- time of day and daylight state;
- weather and atmospheric state;
- current lighting sources and visibility;
- visible exits and major geometry;
- exact visible object identities;
- object containment and custody;
- open/closed/locked/broken/burned/wet/damaged/transformed state;
- exact placement of dropped or moved objects;
- current hazards and persistent consequences;
- visible NPCs/companions;
- character identity, presentation, and pronouns as structured facts;
- clothing/equipment/custody state where the game actually knows it;
- injuries or other visible condition state where authored;
- recent significant event context when rendering `DRAW LAST`;
- perspective/composition hints derived from what the adventurer can actually perceive.

The renderer must never infer character pronouns from a name. Pronouns and other identity facts known by the game are supplied explicitly.

## Rendering pipeline

The intended eventual architecture is:

```text
Authoritative Zork state
        |
        v
Structured scene snapshot
        |
        v
Illustration prompt/compiler
        |
        v
Player-selected external image provider
        |
        v
Rendered image + local provenance record
```

The illustration compiler may add visual-language detail, composition guidance, period texture, camera framing, and prose-derived atmosphere, but it may not override state facts.

This should consume the same stable IDs/read-only state/event infrastructure needed by future graphical frontends rather than introducing an AI-specific duplicate representation of the world.

## Playthrough gallery and provenance

A future implementation may save successful illustrations into a local per-playthrough gallery, for example under an `illustrations/` area owned by the frontend/runtime rather than the ZIL world itself.

Each illustration should be accompanied by a compact provenance manifest containing enough information to reproduce or understand the request, such as:

- playthrough/save identity;
- game turn or event identity;
- room ID;
- scene snapshot version;
- provider/model identifier;
- rendering request text or normalized prompt;
- timestamp of the external request;
- resulting local image filename/identity.

This provenance is for player history and reproducibility, not a new audit bureaucracy and not authoritative gameplay state.

## Why this belongs late

Illustrated Zork becomes genuinely interesting only after the world itself has enough persistent truth to illustrate.

Examples that should eventually survive into an image include:

- morning, dusk, night, storms, fog, and other future temporal/weather state;
- a tree still damaged by an earlier action;
- floodwater changed by the actual dam state;
- a real dropped lantern remaining in the mud where the player left it;
- a thief visibly carrying the player's actual stolen sword;
- Mara appearing with her current authored state rather than a generic companion portrait;
- smoke, fire, collapsed geometry, wet objects, or other persistent consequences;
- a rainbow or route feature appearing only when the authoritative world says it exists.

If the scene renderer must guess these facts, it has been built too early.

## Design laws

1. **Simulation first, illustration second.**
2. **External rendering is exclusively opt-in.**
3. **Zork remains authoritative.** The image model cannot modify gameplay truth.
4. **Exact objects stay exact.** Missing, stolen, burned, broken, committed, or transformed objects are represented accordingly.
5. **Identity facts are explicit.** Pronouns are structured input, never guessed from names.
6. **No provider lock-in.** Use a replaceable adapter boundary.
7. **No network dependency for ordinary play.** Highly Extended Zork remains playable without this feature.
8. **No render failure may alter game state.**
9. **No generic fan-art shortcut.** The point is to illustrate this specific playthrough at this specific moment.
10. **Do not promote this horizon item until the necessary world-state export is mature.**

## Relationship to future renderer work

The existing far-horizon graphical/frontend direction already calls for stable room/object/actor IDs, read-only state export, and an event stream for movement, damage, sound, light, dialogue, timers, and deaths.

Illustrated Zork should be a consumer of that architecture.

A mature state export could support both:

- deterministic graphical frontends; and
- on-demand generative illustrations.

Neither should become an alternate authority over the Zork simulation.

## Promotion gate

Do not move this into an implementation train until all of the following are true:

- stable scene-relevant room/object/actor identities exist;
- read-only world-state export is trustworthy;
- visible containment/custody/damage state can be represented without transcript guessing;
- identity/pronoun state can be exported explicitly;
- future time/daylight and weather state, if shipped, have authoritative representations;
- external provider credentials can be handled without contaminating save/story state;
- network consent and failure behavior are explicit;
- one dense scene can be rendered from state without the model inventing gameplay facts.

Until then, this stays where it belongs:

> **Far off in the distance — waiting for Zork to become sufficiently alive that drawing one exact moment is worth doing.**
