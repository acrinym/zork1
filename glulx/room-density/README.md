# Unofficial Room Density Glulx — Release 1218

Release `1218` is the tenth production layer in this repository's additive Zork I Glulx lineage.

It derives from exact qualified Release `1217` and addresses one specific parser failure mode:

> When room prose explicitly names a physical feature, the player should usually be able to refer to it with a reasonable canonical verb.

This is a bounded scenery layer, not a free-form language model, universal fallback, crafting system, or room rewrite.

## Locked identity

- edition: Unofficial Room Density Glulx
- release: `1218`
- serial: `260723`
- output: `zork1-glulx-room-density.ulx`
- Glulx version: `3.1.3` / `0x00030103`
- size: `227,840` bytes
- checksum: `0x3b65ecaf`, valid
- SHA-256: `efc8bd9f264f60bb56f2daf3e4d7d6d32a272997434802ee76455781a8edf521`

The artifact derives from exact Release `1217` SHA-256:

`2714d63760fa890be9ece3b23fc91bab67a660c42675e0302b745173aba700da`

## Exact production delta

Release `1218` changes exactly four staged paths:

1. `1dungeon.zil` — room-scoped `PSEUDO` vocabulary for explicitly described scenery;
2. `assistance.zil` — room-discovery entries in `RECAP`;
3. `room_density.zil` — bounded responses and discovery flags;
4. `zork1.zil` — Release `1218` identity and module include.

No canonical object definition, room exit, score routine, combat routine, timer, puzzle solution, treasure, or portable inventory object is replaced.

## Player-facing room pass

### Troll Room

The description's bloodstains, scratches, forbidding western hole, and passages are now targetable.

Supported intent includes examination, searching, touch, smell, listening, knocking, looking around the damage, and entering the real western opening. Entering the hole delegates to the existing west exit and maze topology.

The troll, axe, combat, passage blocking, restraint, and recovery state remain authoritative.

### Gallery

The remaining paintings, frames, and long-departed vandals can be examined instead of existing only in prose.

Players can look behind the mounted work, knock on frames, inspect evidence of theft, and confirm that no secret exit or portable replacement treasure was added.

The real valuable painting remains the canonical object and treasure.

### Studio

The advertised floor, fireplace, hearth, and sixty-nine paint colors now respond to reasonable physical inspection.

The paint is dry scenery rather than a collectible material. The fireplace points toward the already existing climbable chimney but does not create a new route or bypass its carrying constraints. The existing Studio door behavior remains authoritative.

### East of Chasm

The described eastern path and narrow northern passage are targetable.

The path provides edge, sound, and surface feedback. Entering the northern passage delegates to the existing north exit to the Cellar. The chasm itself remains governed by its original pseudo routine and death behavior.

### Strange Passage

The old wooden door and cyclops-shaped opening can be inspected, touched, knocked, looked through, and entered.

Entering the opening delegates to the existing east exit into the Living Room. No new door state, hidden route, or cyclops solution is created.

### Treasure Room

The discarded crumbling bags, debris, fragments, and floor can be searched and examined.

They remain empty, nonportable scenery. The thief, chalice, treasure-removal behavior, room value, and staircase remain canonical.

### Forest Path and Stream View

The explicitly described paths can be examined, searched, smelled, touched, and listened around.

They remain routes attached to the existing map. No tracks, side branch, Hidden Glade, dropped treasure, or optional geography is introduced.

## Parser boundary

Release `1218` uses the parser's existing canonical actions, including:

- `EXAMINE`;
- `SEARCH`;
- `LISTEN`;
- `SMELL`;
- `TOUCH` / `FEEL` through canonical `RUB`;
- `KNOCK` / `STRIKE`;
- `PUSH`;
- `PULL` through canonical `MOVE`;
- `LOOK IN`, `LOOK UNDER`, and `LOOK BEHIND`;
- `ENTER` / `THROUGH` where an established exit already exists.

It does not add a universal scenery object, broad synonym inference, arbitrary preposition repair, or bespoke response for every nonsense pairing.

## Production/test isolation

The production artifact contains none of the qualification verbs:

- `RDTROLL`;
- `RDGALLERY`;
- `RDSTUDIO`;
- `RDCHASM`;
- `RDPASSAGE`;
- `RDTREASURE`;
- `RDPATH`;
- `RDSTREAM`;
- `RDREPORT`;
- `RDMUTATE`.

Those commands exist only in a separate test story used to position the player, silence unrelated actors after canonical room-entry hooks, deliberately corrupt discovery state, and report deterministic markers.

## Qualification

The fail-closed qualification script:

1. validates exact Release `1217` manifest and artifact identity;
2. stages the exact four-path Release `1218` delta;
3. rejects unresolved includes and ZIL smell errors;
4. rebuilds pinned ZILF 1.8 and Glazer 1.2.0;
5. normalizes the committed serial exactly once;
6. enforces Release `1218` size, checksum, and SHA-256;
7. builds pinned native Glulxe and CheapGlk;
8. compiles a separate test-only story;
9. runs a deterministic tour across every selected room category;
10. proves established openings still invoke canonical travel;
11. runs native `SAVE` and `RESTORE` through the prompt-aware driver;
12. deliberately clears all seven discovery categories after saving;
13. proves all categories return after restore without post-restore repair;
14. writes a machine-readable qualification receipt and uploads full evidence.

## Explicit exclusions

Release `1218` does not add:

- unconstrained natural-language parsing;
- universal scenery or generic material physics;
- new hidden passages or optional geography;
- new treasure, score, inventory objects, or alternate solutions;
- actor memory or expanded conversation;
- cyclops lullaby or thief bargain logic;
- Adventurer Misconduct;
- broad fire or flood propagation;
- the Wizard of Frobozz.

## Next coherent boundary

The strongest next train is focused actor state and long-route verification:

1. restored bound troll → `UNTIE` → queued recovery → renewed danger;
2. cyclops impatience and lullaby timing;
3. thief bargain with carried real treasure;
4. remembered gifts, threats, mercy, deception, and restraint;
5. deterministic revisit and save/restore behavior without infinite-chatbot conversation.
