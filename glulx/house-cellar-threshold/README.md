# Glulx Release 1222 — House Cellar Threshold

## Status

Qualified House of Records Train 4 implementation above exact House Kitchen Laboratory Release `1221`.

Train:

`onyx_zork_house_cellar_threshold`

Current capstone-candidate state is seven closed implementation/qualification beads and one open capstone bead. No sub-beads, sub-trains, or parallel planning hierarchy exist.

## Locked identity

- edition: Unofficial House Cellar Threshold Glulx;
- release: `1222`;
- serial: `260724`;
- output: `zork1-glulx-house-cellar-threshold.ulx`;
- Glulx version: `3.1.3` / `0x00030103`;
- size: `262,400` bytes;
- checksum: `0x54b04c7a`;
- SHA-256: `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912`.

Exact base Release `1221` SHA-256:

`93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f`

## Exact production delta

Release `1222` changes exactly:

- `1actions.zil`;
- `assistance.zil`;
- new `house_cellar_threshold.zil`;
- `shadow_logic.zil`;
- `zork1.zil`.

The stager rejects every other production change. Test-only setup, intrusion placement, cause removal, water restoration, mutation, and reporting verbs never enter production.

## Product boundary

The canonical Cellar gains:

- a broad stone staging bench;
- iron gear hooks;
- a closable stone quarantine niche;
- a targetable expedition threshold;
- targetable underground sounds, drafts, and dampness;
- persistent physical intrusion evidence;
- a Cellar-side observational underside of the real trap door.

The underside does not create another door, lock, or exit. It reports the canonical trap door's actual open, closed, or barred state and refuses fabricated unlocking actions.

Release `1222` uses the real rug, trap door, stair, Cellar routes, lantern, torch, candles, rope, tools, bottle, canonical water, fragile objects, ritual objects, thief, creatures, score, house state, Kitchen wetness, and existing material consequences.

Selected interactions cover:

- actual carried and staged readiness reporting without loadout automation;
- canonical descent through the real trap door, including the original slam and bar;
- bounded route sensing through sounds, drafts, dampness, and threshold inspection;
- warnings for darkness, live flame, exposed water, wet metal, living or fragile cargo, supernatural cargo, and unstable objects;
- ordinary object-tree staging on the bench and hooks;
- recoverable physical quarantine without deleting or abstracting objects;
- refusal to seal a live flame in the niche;
- bounded thief, creature, loose-water, smoke, and supernatural intrusion evidence;
- real bottled-water cleanup after the live causes are gone;
- concise `RECAP` receipts;
- native save, deliberate corruption, and exact restore.

All Cellar state is packed into one indexed persistent table so Release `1222` remains within the Glulx ZIL global-variable limit.

## Qualification corrections retained

- the first loader draft had an escaped-quote defect, one unclosed ZIL form, and bit/routine symbol collisions; the module was replaced with a balanced packed implementation rather than patched around malformed source;
- the project has no `TOUCH` action symbol, so tactile threshold inspection uses canonical `RUB`;
- from the Cellar, the original trap-door object is not parser-visible because it canonically lives in the Living Room; the observational underside exposes its state without duplicating its route;
- ordinary parser custody means staged rope and wrench are no longer carried;
- evidence correctly returns while the thief, creature, flame, water, or supernatural object remains present;
- evidence cleanup is qualified only after the live causes are removed;
- deliberate corruption removes live causes so zero state is meaningful, then native restore must recover exact evidence and object custody.

## Qualification

The permanent pinned route proves:

1. exact Release `1221` base identity;
2. exact five-path production staging;
3. exact Release `1222` size, checksum, and SHA-256;
4. canonical trap-door descent, first-entry slam, and bar;
5. Cellar-side observation without a duplicate route;
6. real-object staging and readiness;
7. bounded sounds, drafts, dampness, and route sensing;
8. carried-hazard warnings without cancellation or auto-preparation;
9. recoverable quarantine and live-flame refusal;
10. thief, creature, water, smoke, and supernatural evidence;
11. causal real-water cleanup;
12. packed threshold state and real fixture contents through native `SAVE` and `RESTORE` after deliberate corruption;
13. production/test isolation.

## Explicit exclusions

No inventory automation, equipment classes, unlimited storage, remote retrieval, generic hazard simulation, broad smoke/water/fire/creature/supernatural propagation, automatic puzzle preparation, safe passage, route unlocking, duplicated objects or actors, parallel score, or automatic puzzle completion.
