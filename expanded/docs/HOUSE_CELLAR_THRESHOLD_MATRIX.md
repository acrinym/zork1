# House Cellar Threshold — Release 1222 Matrix

## Authority

Train: `onyx_zork_house_cellar_threshold`

Qualified artifact:

- Release `1222` / serial `260724`;
- 262,400 bytes;
- checksum `0x54b04c7a`;
- SHA-256 `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912`.

Exact base: Release `1221` SHA-256 `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f`.

## Interaction matrix

| Surface, route, or state | Supported operation | Real authority retained | Explicit boundary |
|---|---|---|---|
| Canonical rug and trap door | Descend through ordinary route | Existing rug, door, stair, slam, bar, and score behavior | No duplicate exit or automatic unlock |
| Trap-door underside | Inspect, listen, smell, attempt movement | Reports the real door's current flags | Observation only; cannot open a barred door |
| Stone staging bench | Place and retrieve selected real expedition objects | Canonical object tree | No loadout abstraction or remote retrieval |
| Iron gear hooks | Stage real rope and light sources | Canonical object tree | No equipment slots or copies |
| Stone quarantine niche | Store, close, reopen, and recover selected risky objects | Canonical object identity and custody | Refuses sealing live flame; no deletion or neutralization |
| `READINESS` | Report actual carried and staged state | Real lights, tools, bottle, water, and custody | Does not equip, move, light, dry, or prepare anything |
| Underground sounds | Inspect or listen | Existing actor and route state | Bounded evidence; no unseen solution disclosure |
| Drafts | Inspect | Existing trap-door and route state | No airflow simulation |
| Dampness | Inspect | Existing Cellar climate and intrusion bits | No new water source |
| Descent screening | Warn about darkness, flame, water, wet metal, fragile/living, supernatural, or unstable cargo | Existing flags, Kitchen wetness, material rust, and object custody | Warnings never cancel movement or consequences |
| Intrusion evidence | Record thief, creature, loose water, smoke, or supernatural presence | Existing actors and objects | No broad propagation or synthetic actor |
| Evidence cleanup | Rinse physical marks after live causes are gone | Consumes the real canonical water | Historical receipt remains; active causes recreate evidence |
| Native save/restore | Preserve packed state and object trees | VM snapshot remains authoritative | No post-restore repair pass |

## Persistent state

All Release `1222` Cellar state is packed into one indexed persistent table:

- schema version;
- descent and return counts;
- sensing bits;
- hazard-warning bits;
- intrusion-evidence bits;
- bounded staging, trap-door, sensing, hazard, containment, intrusion, and readiness receipts.

Native `SAVE` and `RESTORE` preserve this table together with:

- rope on real hooks;
- wrench on the real bench;
- black book in the closed real niche;
- canonical trap-door open/barred flags;
- physical evidence visibility;
- real object and actor custody.

Qualification deliberately clears the packed table, fixture trees, trap-door flags, evidence, actors, ritual objects, flame sources, and water before restore.

## Parser truth

- From below, the original trap-door object remains canonically located in the Living Room and is not directly parser-visible.
- `UNDERSIDE` names an observational Cellar surface that reports the same door's flags.
- Tactile threshold inspection uses canonical `RUB`, not a nonexistent `TOUCH` action.
- Ordinary `PUT` changes real custody; staged items stop counting as carried readiness.
- Physical evidence returns if its real cause remains in the Cellar.

## Exclusions

No inventory automation, equipment classes, generic hazard engine, unlimited storage, teleporting retrieval, broad propagation, duplicate door, duplicate object or actor, parallel score, route unlock, auto-preparation, or auto-solve.

## Downstream hooks

Train 5 may use bounded threshold receipts or physical house state when correspondence or visitors interact with the house, but it must not replace the Cellar table or create an automatic delivery inventory.

Later archive trains may record Cellar readiness, crossings, quarantined objects, and intrusion evidence, but playback remains observational and cannot mutate live Cellar state.
