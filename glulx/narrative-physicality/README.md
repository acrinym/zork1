# Release 1247 — Narrative Physicality

Release 1247 is the first dense implementation train for the product direction: make Zork I increasingly understand the physical and sensory meaning of ordinary, reckless, destructive, and absurd commands while preserving the canonical adventure.

This release deliberately does **not** introduce a universal physics engine. It authors a richer House zone using the existing Zork objects and the existing material-consequence authority.

## Player-facing expansion

- West of House, Behind House, Kitchen, and Living Room receive richer room imagery in a restrained Infocom-like voice.
- Broken Kitchen-window state is now visible directly in room narration rather than being reduced to the generic word `open`.
- The white house understands examination, touch, smell, listening, kicking, attempted taking, and tool-assisted abuse.
- The front-door and boarded-window barriers can be struck, kicked, cut, and scarred without accidentally bypassing the canonical early entry problem.
- The kitchen table gains physical and sensory detail and can retain visible scuffs and gouges while remaining a canonical surface.
- The brown sack can be examined as a real material object. A suitable carried destructive tool can tear a seam; current contents spill naturally, the damaged sack remains an object, and later attempts to use it as a dependable container are understood.
- The oriental rug can be touched, smelled, kicked, and frayed while its canonical move/trap-door behavior remains authoritative.
- Existing bottle destruction remains canonical but now receives more specific physical prose.
- `TAKE HOUSE` is understood as an attempt to take the house and fails because the house has foundations and rooms, not because the parser forgot what a house is.

## Persistent consequence model

Release 1247 consumes no new global variables. Safe cosmetic damage uses existing per-object `RMUNGBIT` state on House objects that do not otherwise use it for canonical progression. This state naturally participates in ordinary save/restore.

The existing dev/test `RESET DAMAGE` authority is extended to clear these Release 1247 physical scars. It deliberately does not teleport spilled sack contents back into the sack, move the rug back over the trap door, restore score, or rewind puzzle progress.

## Boundaries

- Canonical object routines remain authoritative where they already solve the problem well.
- The front-door boards remain a barrier; physical damage is not an accidental puzzle bypass.
- Moving the rug still uses the canonical trap-door state machine.
- Existing environmental-destruction authority continues to own mailbox and Kitchen-window destruction.
- No score is created by vandalism.
- No arbitrary object-pair simulation is introduced.
- No recursive audit system, test-only production verb, stub, or TODO scaffold is added.

The intended feeling is simple: when the player wonders, **“Will Zork understand what I mean?”**, the answer should be “yes” much more often—even when the narrator's answer to the actual plan is a dry and physically specific “no.”
