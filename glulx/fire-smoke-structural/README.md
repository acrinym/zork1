# Release 1257 — Fire, Smoke & Structural Consequences

This train gives one real mine location a persistent authored fire lifecycle without adding a generic chemistry/fire simulator.

## Player-facing contract

- `BURN TIMBERS WITH TORCH` (or another real live flame) starts with visible smolder rather than deleting the object.
- A new smolder can be stamped out with `EXTINGUISH TIMBERS`; open flame requires the real bottled water or retreat.
- Ignored fire becomes open flame and draft-driven smoke. While smoke is concentrated through the west crawl, the game refuses that unsafe crawl and preserves the wide east escape.
- If ignored longer, one old brace falls into the burning clutter. The roof settles, the fire eventually burns itself down, and the room retains permanent charred structural evidence.
- The collapse does **not** widen, delete, or permanently block the canonical narrow route. `EMPTY-HANDED` remains the authority for the coal-mine crawl.
- Fire state lives in a compact mutable table plus flags on the real `TIMBERS` object; Release 1257 consumes no new VM global.
- Canonical `V-BURN` and canonical Gas Room `BOOM-ROOM` remain unchanged.

This is intended to become the first shared authored world-fire authority that later hazards (including a future original treasure-guardian dragon) can compose with rather than reimplementing their own fake fire.
