# Release 1277 — Mundane Objects, Field Caching & House Spatial Agency

Release 1277 composes directly over the locked Release 1276 Mara Field Guidance artifact. It makes ordinary objects physically persistent without assigning every object a puzzle destiny, extends the canonical oriental rug into a genuinely movable/cuttable world object, adds bounded player-authored instant photographs, and lets the player request physical cooperation from Mara without converting her into a commandable NPC.

The implementation is intentionally bounded:

- all 23 approved mundane catalog entries are authored into actual world locations;
- the oatmeal box contains four physical flavor packets;
- the lensless frame and both missing lenses are separate persistent objects;
- the hot coffee changes from hot to cool with elapsed turns and refuses sealed-container assumptions;
- the beehive remains a living defensive colony rather than an inventory token;
- copper wire is materially useful but explicitly not load-bearing rope;
- the canonical `RUG`, `RUG-MOVED`, and `TRAP-DOOR` remain authoritative;
- credible cutting transforms the real whole rug into three independently located pieces;
- `SNAPSHOT` uses a real three-exposure instant camera and creates real photograph objects with frozen scene state;
- `ASK MARA TO ...` is a bounded request path whose answer consumes Mara's existing body/history state.

There is no crafting grid, generic junk generator, shadow furniture coordinate system, infinite photo generator, generic companion AI, or new relationship score.

## Staging

`stage.py` requires an exact staged Release 1276 source and the locked Release 1276 artifact identity. The manifest pins both production and dev predecessor source identities once candidate qualification has measured them. All patching is exact-count and the staging receipt records every changed path.

## Qualification

`qualify.sh` first requalifies Release 1276, measures the exact predecessor source identities, stages production and dev Release 1277, smell-checks both trees, compiles/assembles Glulx, verifies the artifact, and exercises natural player-facing commands. Candidate qualification intentionally stops when a predecessor/source or artifact identity has not yet been locked; the printed identity becomes the value committed for the exact-head rerun.

Final qualification must leave the Release 1277 artifact locked and reproducible.