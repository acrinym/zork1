# Described-world census (Release 1302)

**Law:** `docs/planning/DESCRIBED_WORLD_IS_LAW_2026-08-30.md`  
**Closed on:** flagless production play of Release 1303 (this PR), plus already-shipped 1294–1296.

Each row is a described noun the parser must treat as real. Closed means EXAMINE (or the named verb) no longer yields `You can't see any X here!` on a flagless story.

| Region | Room | Quoted / described noun | Command | Closed by |
|---|---|---|---|---|
| Surface | West of House | wild grass | EXAMINE GRASS | 1295 |
| Surface | West of House | settled silence | EXAMINE SILENCE | 1295 |
| Surface | West of House | boards | EXAMINE BOARDS | 1295 / vanilla |
| Surface | North of House | trees | EXAMINE TREE | 1294 |
| Surface | North of House | windows | EXAMINE WINDOWS | 1296 |
| Surface | Forest (west pines) | sunlight | EXAMINE SUNLIGHT | 1303 |
| Surface | Forest Path | large tree / branches | EXAMINE TREE / UP | 1294 / vanilla |
| Surface | Clearing | forest path | EXAMINE PATH / FOREST | vanilla local-globals |
| Surface | Stone Barrow | stone door / tomb | EXAMINE DOOR | 1303 |
| House | Kitchen | crumbs | EXAMINE CRUMBS | 1296 |
| House | Kitchen | chimney | EXAMINE CHIMNEY | vanilla / 1296 |
| House | Living Room | trophy case | EXAMINE TROPHY CASE | 1296 |
| House | Attic | stairway | EXAMINE STAIRS | vanilla STAIRS |
| Cellar | Cellar | ramp | EXAMINE RAMP | 1296 / SLIDE |
| Cellar | Cellar | crawlway / passageway | EXAMINE CRAWLWAY | 1303 |
| Cellar | Troll Room | hole / bloodstains | EXAMINE HOLE / BLOODSTAINS | 1296 |
| Underground | East of Chasm | chasm | EXAMINE CHASM | vanilla PSEUDO |
| Underground | Gallery | paintings / vandals | EXAMINE PAINTINGS | 1303 |
| Underground | Studio | fireplace | EXAMINE FIREPLACE | 1303 |
| Underground | Maze | twisty passages | EXAMINE PASSAGES | 1303 |
| Underground | Maze-5 | skeleton | EXAMINE SKELETON | vanilla |
| Underground | Strange Passage | wooden door | EXAMINE DOOR | 1303 |
| Underground | Round Room | cave-ins | EXAMINE CAVEINS | 1303 |
| Underground | North Temple | prayer / pillars | EXAMINE PRAYER / PILLARS | 1303 |
| Underground | Altar | floor hole | EXAMINE HOLE | 1303 |
| Water | Dam | walkway / panel | EXAMINE WALKWAY / PANEL | 1296 |
| Water | Dam Lobby | doorways | EXAMINE DOORWAYS | 1303 |
| Water | Maintenance | equipment | EXAMINE EQUIPMENT | 1303 |
| Water | In-Stream | beach | EXAMINE BEACH | 1303 |
| Water | River-2 | rocks | EXAMINE ROCKS | 1303 |
| Water | Hades | gate | EXAMINE GATE | vanilla PSEUDO / 1296 |
| Water | Land of the Dead | lost souls | EXAMINE SOULS | 1303 |

Survey play uses test-only `--no-killing` and `--no-reset-on-death` so combat and death do not stop the walk. Those flags are not a player menu and are not present in production.

**1305 re-walk (PR #94):** the same rows were examined on Highly Extended Absurd Alternates. Hosted census was empty. `EXAMINE GATE` is in scope at Entrance to Hades, not in the Land of the Living Dead. Remaining HE rooms (museum, kitchen laboratory, Mara) belong to planned **1308**.
