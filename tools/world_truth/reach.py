"""Unconditional walk of the declared exit graph from the start room."""

from __future__ import annotations

from collections import deque

from .config import State, TruthConfig
from .model import Entity, WorldModel

DIRECTION_COMMANDS = {
    "NORTH": "north",
    "SOUTH": "south",
    "EAST": "east",
    "WEST": "west",
    "NE": "ne",
    "NW": "nw",
    "SE": "se",
    "SW": "sw",
    "UP": "up",
    "DOWN": "down",
    "IN": "in",
    "OUT": "out",
    "LAND": "land",
    "CROSS": "cross",
    "ENTER": "enter",
    "EXIT": "exit",
}


def _rooms(model: WorldModel) -> dict[str, Entity]:
    return {entity.id: entity for entity in model.entities if entity.kind == "room"}


def unconditional_target(exit_data: dict) -> str | None:
    target = exit_data.get("target")
    if not isinstance(target, str) or not target:
        return None
    atoms = [str(item).upper() for item in exit_data.get("condition") or []]
    if "IF" in atoms or "PER" in atoms:
        return None
    return target


def start_room(model: WorldModel, config: TruthConfig) -> str | None:
    rooms = _rooms(model)
    requested = str(config.policy.get("start_room", "WEST-OF-HOUSE")).upper()
    if requested in rooms:
        return requested
    for entity in model.entities:
        if entity.kind == "room":
            return entity.id
    return None


def _object_room(entity: Entity, by_id: dict[str, Entity]) -> str | None:
    current = entity.container
    seen: set[str] = set()
    while current and current not in seen:
        seen.add(current)
        host = by_id.get(current)
        if not host:
            return None
        if host.kind == "room":
            return host.id
        current = host.container
    return None


def walk_commands(model: WorldModel, origin: str, goal: str) -> list[str] | None:
    rooms = _rooms(model)
    if origin == goal:
        return []
    if origin not in rooms or goal not in rooms:
        return None
    queue: deque[tuple[str, list[str]]] = deque([(origin, [])])
    seen = {origin}
    while queue:
        room_id, path = queue.popleft()
        for direction, data in rooms[room_id].exits.items():
            target = unconditional_target(data)
            command = DIRECTION_COMMANDS.get(direction)
            if not target or not command or target not in rooms or target in seen:
                continue
            next_path = [*path, command]
            if target == goal:
                return next_path
            seen.add(target)
            queue.append((target, next_path))
    return None


def reachable_from(model: WorldModel, origin: str) -> dict[str, list[str]]:
    rooms = _rooms(model)
    reached = {origin: []}
    queue: deque[str] = deque([origin])
    while queue:
        room_id = queue.popleft()
        for direction, data in rooms[room_id].exits.items():
            target = unconditional_target(data)
            command = DIRECTION_COMMANDS.get(direction)
            if not target or not command or target not in rooms or target in reached:
                continue
            reached[target] = [*reached[room_id], command]
            queue.append(target)
    return reached


def lamp_prefix(model: WorldModel, origin: str, destination: str, dest_path: list[str]) -> list[str]:
    dest = next((item for item in model.entities if item.id == destination), None)
    if dest and "ONBIT" in dest.flags:
        return dest_path
    by_id = {item.id: item for item in model.entities}
    lamp = by_id.get("LAMP")
    if not lamp:
        return dest_path
    lamp_room = _object_room(lamp, by_id)
    if not lamp_room:
        return dest_path
    to_lamp = walk_commands(model, origin, lamp_room)
    if to_lamp is None:
        return dest_path
    after = walk_commands(model, lamp_room, destination)
    if after is None:
        return dest_path
    return [*to_lamp, "take lamp", "turn on lamp", *after]


def auto_states(model: WorldModel, config: TruthConfig) -> tuple[list[State], list[str]]:
    origin = start_room(model, config)
    rooms = _rooms(model)
    if not origin:
        return [], []
    reached = reachable_from(model, origin)
    authored_rooms = {item.room for item in config.states}
    generated: list[State] = []
    for room_id, path in sorted(reached.items()):
        if room_id in authored_rooms:
            continue
        room = rooms[room_id]
        setup = lamp_prefix(model, origin, room_id, path)
        by_id = {item.id: item for item in model.entities}
        lit = "ONBIT" in room.flags or "take lamp" in setup or "LAMP" not in by_id
        generated.append(State(
            id=f"reach-{room_id.lower()}",
            room=room_id,
            setup=setup,
            expected_title=room.description,
            light="lit" if lit else "dark",
        ))
    unreachable = sorted(room_id for room_id in rooms if room_id not in reached and room_id not in authored_rooms)
    return generated, unreachable


def merged_states(model: WorldModel, config: TruthConfig) -> tuple[list[State], list[str]]:
    generated, unreachable = auto_states(model, config)
    return [*config.states, *generated], unreachable
