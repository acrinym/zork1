# Release 1251 — Cross-System Utility Mesh

Release 1251 turns the first Player Ingenuity cases into a **small reusable mesh of existing authorities**. The design rule is the one that emerged in play:

> **state/property + capability noun + carrier noun + world noun → useful affordance**

Examples in this release:

- **loaded + rope + brown sack + chimney → cargo hoist**
- **loaded + rope + brown sack + tree → branch freight line**
- **open + rope + brown sack + forest grate → reversible freight opening**
- **secured + rope + brown sack + Dome railing → anchored lowering line**

This is deliberately not a recipe table. The rope already knows how to be committed to an anchor, the sack already knows how to be cinched and contain real objects, and the world already knows which rooms are vertically related. Release 1251 lets those truths meet.

## Player-facing behavior

### Chimney: carry the line, not the cargo

In the Studio, cinch the sack to the rope, leave the sack behind, and climb with the lantern and free rope end. From the Kitchen, `PULL ROPE` or `RAISE ROPE` hauls the sack up separately. `LOWER SACK` sends it back down. This goes beyond Release 1250 bundling: the sack is no longer another package on the adventurer's body at all.

The cargo line does **not** turn the canonical one-way chimney into a player descent route. After lowering the sack, the free end is in the adventurer's hands and the other end is tied to cargo below; nothing is anchored above to bear the adventurer's weight. `DOWN` therefore explains that physical boundary. If the line is needed again, haul the sack back up and untie it.

### Tree: ten feet becomes useful geometry

The existing tree room explicitly places the adventurer about ten feet above the path. A cinched sack left on the path can therefore be hauled into the branches after climbing with the free line, or lowered back to the path. While the sack is hanging at the other end, the line goes taut if the adventurer tries to wander away instead of hauling it or returning down.

### Forest grating: open is a physical adjective

The existing grating already lets suitably small objects pass downward. Once it has been unlocked from below and is open, rope plus sack makes that one-way freight behavior reversible. Closing the grating blocks the cargo line because iron now occupies the opening.

### Dome Room: authorities compose instead of competing

The repository's material rope layer previously intercepted `TIE ROPE TO RAILING` before the canonical `ROPE-FUNCTION` could set `DOME-FLAG`. Release 1251 yields the railing interaction back to canonical Zork. If the sack is already cinched to the other end, canonical railing state and material sack state coexist: `LOWER SACK` reaches the Torch Room, and ordinary `DOWN` remains the canonical rope descent.

## Commands

Existing parser language is sufficient; no new grammar dialect is introduced. Useful forms include:

- `TIE ROPE TO SACK` / `TIE SACK TO ROPE`
- `UNTIE SACK FROM ROPE`
- `LOWER SACK` or `LOWER ROPE` when the sack is at the upper end
- `PULL ROPE` / `RAISE ROPE` when the sack is below
- canonical `TIE ROPE TO RAILING` in the Dome Room

## Geography deliberately not faked

- **Flood Control Dam #3:** the Dam Base text says the dam *looms above*. Nothing currently establishes the Attic rope as long enough to span top to base. The dam can gain freight opportunities later where actual platforms, railings, ladders, or shorter drops are authored.
- **Rainbow / White Cliffs:** a rainbow is not an anchor. The cliff region gets no rope shortcut until the world supplies an honest anchor and reachable endpoint.
- **Mine shaft:** it already has a real chain-and-basket lift with raise/lower authority. The player should use the machinery that exists rather than receive a duplicate rope implementation.

## Boundaries

Release 1251 adds no new rope-state global and no universal physics engine. It reuses `MATERIAL-ROPE-ANCHOR`, `MATERIAL-SACK-CINCHED`, canonical `DOME-FLAG`, the existing brown sack containment/capacity, and authored room relations. The small route resolver contains geography only; it does not enumerate object combinations or puzzle solutions. A rope tied to cargo is treated as cargo control; player traversal requires a physically valid route or a real load-bearing anchor.
