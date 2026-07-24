# Glulx Release 1221 — House Kitchen Laboratory

## Status

Train 3 implementation is in progress above exact qualified Living Room Museum Release `1220`.

This layer executes the existing beadtrain:

`onyx_zork_house_kitchen_laboratory`

No sub-beads, sub-trains, or parallel planning hierarchy are introduced.

## Product boundary

The canonical Kitchen gains four fixed fixtures:

- porcelain sink;
- wooden worktop;
- wooden cupboard;
- cast-iron range.

The layer uses the real bottle, the single canonical `WATER` object, the real lunch and garlic, the real knives and tools, existing material-cleaning flags, and the existing rusty-knife consequence.

Selected interactions cover:

- refilling the real bottle without cloning water;
- washing and drying selected tools and containers;
- temporary range heat from a real held flame;
- warming ordinary food and water;
- drying wet metal without granting bonuses;
- preparing the existing lunch;
- slicing the existing garlic with a clean, dry real knife;
- bounded water-on-hot-iron and worktop-cleaning reactions;
- ordinary object-tree storage on the worktop, in the sink, in the cupboard, or on the range;
- authored offering context for the bat and cyclops without replacing canonical solutions;
- native save and restore.

## Explicit exclusions

No hunger or thirst meter, mandatory chores, recipe economy, generic crafting, universal chemistry, automatic puzzle-water replenishment, duplicated objects, broad fire/flood simulation, parallel score, or automatic puzzle completion.

## Exact base

Release `1220` SHA-256:

`f5bd739e38ea4b355ddfc089b887e32742740444f69179facc51af7de1fb91c4`

The Release `1221` artifact identity remains discovery-gated until the parser-driven production and persistence routes pass.
