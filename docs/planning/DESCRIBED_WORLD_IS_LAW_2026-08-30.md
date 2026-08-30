# Described world is law (2026-08-30)

**Law:** If the game already told the player a thing exists, the parser must treat that thing as real. Prose is the spec. `You can't see any X here!` is a lie when the room just named X.

**Scope:** The entire reachable Highly Extended Zork map, not only the leaflet-hour spine. No GUI. No AI. No scenery engine. Do not steal 1280–1292.

**How it ships (three coupled trains):**

1. **1301 — Survey developer flags** — `--no-killing` and `--no-reset-on-death` for census play only. Never in the production `.ulx`.
2. **1302 — Described-world census** — play the whole map with those flags; write every prose/parser lie into a ledger.
3. **1303 — Empire noun honesty** — build until that ledger is empty on a flagless play.

Leaflet-spine trains 1294–1300 are the same law on the 1980 first loop. They do not replace the census. Later honesty trains close census rows; they do not invent a new continent.

## `--no-killing`

Developer/qualify flag only. During survey, lethal combat and unnecessary enemy obstruction must not stop traversal (troll, thief, cyclops, grue, and similar). Canonical puzzles remain in the production story. The flag does not exist as a player-facing menu.

## `--no-reset-on-death`

Developer/qualify flag only. If the Adventurer still dies (pit, drowning, or any remaining fatal command): resume **in the room where death happened**, with world and inventory **exactly as they were before the fatal command** (one-step rewind). The player can type a different command. This is not a save-file restore and not a GUI.

## Census ledger

Each row: room, quoted prose noun, command that failed, failure text, whether production (flagless) still lies. The ledger is the only backlog for 1303.
