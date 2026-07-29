# House Kitchen Laboratory — Release 1221 Matrix

## Authority

Train: `onyx_zork_house_kitchen_laboratory`

Qualified artifact:

- Release `1221` / serial `260724`;
- 249,600 bytes;
- checksum `0x85d64142`;
- SHA-256 `93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f`.

Exact base: Release `1220` SHA-256 `f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4`.

## Interaction matrix

| Surface or object | Supported operation | Real authority retained | Explicit boundary |
|---|---|---|---|
| Porcelain sink | Fill real bottle | Single canonical `WATER` object | Refuses cloning or generic containers |
| Porcelain sink | Wash selected tools, knives, bottle | Existing material-clean and rust state | No universal cleaning vocabulary |
| Wooden worktop | Place, retrieve, prepare lunch, slice garlic | Canonical object tree and canonical `CUT` | No recipe graph or automatic ingredient combination |
| Wooden cupboard | Store and retrieve real objects | Ordinary `TAKE` and `PUT` | No automatic equipment locker or retirement |
| Cast-iron range | Light with real held flame | Existing real flame objects | Temporary heat only; no fuel economy |
| Cast-iron range | Warm lunch, garlic, water | Same food, garlic, bottle, and water objects | No potion, new food, score, or hunger system |
| Cast-iron range | Dry selected wet metal | Existing tool and rust identity | No repair, sharpening, damage bonus, or puzzle bypass |
| Hot range + bottled water | Quench bounded heat | Consumes real canonical water | No broad steam/flood simulation |
| Worktop + bottled water | Remove authored food residue | Consumes real canonical water | Leaves bounded wet state only |
| Prepared garlic + bat | Authored refusal context | Canonical bat remains authoritative | No alternate bat solution |
| Prepared lunch + cyclops | Authored scent context | Canonical cyclops response remains authoritative | No alternate cyclops solution |

## Persistent state

All Release 1221 Kitchen state is packed into one indexed persistent table:

- schema version;
- range heat;
- temporary lunch, water, and garlic warmth;
- selected wetness timers;
- cleaned knife and bottle state;
- prepared lunch and sliced garlic state;
- worktop residue;
- bounded event receipts.

Native `SAVE` and `RESTORE` preserve this table together with real fixture contents and canonical object custody. Qualification deliberately clears both table state and fixture object trees before restore.

## Parser truth

- `NASTY KNIFE` disambiguates the food knife from the rusty knife.
- Ordinary `PUT` changes real custody; later storage uses ordinary `TAKE` first.
- `SLICE` is canonical `CUT`; the Kitchen intercepts only garlic with the real nasty knife.
- Every other `CUT` delegates unchanged.

## Exclusions

No hunger/thirst meter, mandatory upkeep, recipe economy, generic crafting, universal chemistry, automatic water replenishment, duplicate object, broad fire/flood propagation, parallel score, auto-solve, or test-only production command.

## Downstream hooks

Train 4 may inspect Kitchen-origin wet, warm, prepared, or stored state when crossing the Cellar threshold, but it must not replace the Kitchen table or duplicate its objects.

Later archive trains may record bounded Kitchen receipts and final object state, but playback remains observational and cannot mutate live Kitchen state.
