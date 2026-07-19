#!/usr/bin/env python3
"""Validate v1.3 beadtrain structure, live bead ids, DAGs, and couplers."""

from __future__ import annotations

import argparse
import json
import sys
import tomllib
from pathlib import Path
from typing import Any


ALLOWED_TRAIN_STATUS = {"planned", "in_progress", "complete", "blocked"}
ALLOWED_COUPLER_MODES = {"after", "with"}


def load_toml(path: Path) -> dict[str, Any]:
    try:
        with path.open("rb") as handle:
            return tomllib.load(handle)
    except (OSError, tomllib.TOMLDecodeError) as exc:
        raise RuntimeError(f"cannot read {path}: {exc}") from exc


def load_issues(path: Path) -> dict[str, dict[str, Any]]:
    issues: dict[str, dict[str, Any]] = {}
    try:
        for number, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
            if not line.strip():
                continue
            value = json.loads(line)
            issue_id = str(value.get("id", ""))
            if not issue_id:
                raise RuntimeError(f"{path}:{number}: issue has no id")
            if issue_id in issues:
                raise RuntimeError(f"{path}:{number}: duplicate issue id {issue_id}")
            issues[issue_id] = value
    except (OSError, json.JSONDecodeError) as exc:
        raise RuntimeError(f"cannot read {path}: {exc}") from exc
    return issues


def find_cycle(graph: dict[str, list[str]]) -> list[str] | None:
    visiting: set[str] = set()
    visited: set[str] = set()
    stack: list[str] = []

    def visit(node: str) -> list[str] | None:
        if node in visiting:
            start = stack.index(node)
            return stack[start:] + [node]
        if node in visited:
            return None
        visiting.add(node)
        stack.append(node)
        for dependency in graph[node]:
            cycle = visit(dependency)
            if cycle:
                return cycle
        stack.pop()
        visiting.remove(node)
        visited.add(node)
        return None

    for node in graph:
        cycle = visit(node)
        if cycle:
            return cycle
    return None


def coupler_rows(data: dict[str, Any]) -> list[dict[str, Any]]:
    rows = data.get("couplers", [])
    return rows if isinstance(rows, list) else []


def validate(path: Path, repo_root: Path) -> list[str]:
    errors: list[str] = []
    data = load_toml(path)
    train = data.get("train")
    if not isinstance(train, dict):
        return ["missing [train] table"]

    name = str(train.get("name", ""))
    if name != path.stem:
        errors.append(f"train.name {name!r} must match filename stem {path.stem!r}")
    if train.get("status") not in ALLOWED_TRAIN_STATUS:
        errors.append(f"invalid train status {train.get('status')!r}")
    for field in ("title", "description", "created"):
        if not train.get(field):
            errors.append(f"train.{field} is required")

    cars = data.get("cars")
    if not isinstance(cars, list) or not cars:
        return errors + ["at least one [[cars]] row is required"]

    issues = load_issues(repo_root / ".beads" / "issues.jsonl")
    ids: set[str] = set()
    graph: dict[str, list[str]] = {}
    bead_ids: list[str] = []
    for index, car in enumerate(cars, 1):
        if not isinstance(car, dict):
            errors.append(f"car {index} is not a table")
            continue
        car_id = str(car.get("id", ""))
        bead = str(car.get("bead", ""))
        if not car_id:
            errors.append(f"car {index} has no id")
            continue
        if car_id in ids:
            errors.append(f"duplicate car id {car_id}")
        ids.add(car_id)
        bead_ids.append(bead)
        if bead not in issues:
            errors.append(f"car {car_id} references missing bead {bead!r}")
        if not car.get("title") or not car.get("summary"):
            errors.append(f"car {car_id} requires title and summary")
        if not isinstance(car.get("parallel_start"), bool):
            errors.append(f"car {car_id} parallel_start must be boolean")
        dependencies = car.get("depends_on")
        if not isinstance(dependencies, list) or not all(
            isinstance(item, str) for item in dependencies
        ):
            errors.append(f"car {car_id} depends_on must be a string list")
            dependencies = []
        graph[car_id] = list(dependencies)

    for car_id, dependencies in graph.items():
        for dependency in dependencies:
            if dependency not in ids:
                errors.append(
                    f"car {car_id} depends on unknown local car {dependency!r}; "
                    "cross-train gates belong in [[couplers]]"
                )
    if not errors:
        cycle = find_cycle(graph)
        if cycle:
            errors.append("dependency cycle: " + " -> ".join(cycle))

    if train.get("status") == "complete":
        for bead in bead_ids:
            issue = issues.get(bead, {})
            if issue.get("status") != "closed":
                errors.append(f"complete train references non-closed bead {bead}")

    meta = data.get("meta", {})
    peers = meta.get("couples_with", []) if isinstance(meta, dict) else []
    if peers and not isinstance(peers, list):
        errors.append("meta.couples_with must be a list")
        peers = []

    all_trains: dict[str, dict[str, Any]] = {}
    for candidate in (repo_root / ".beads").glob("*.beadtrain"):
        peer_data = load_toml(candidate)
        peer_name = str(peer_data.get("train", {}).get("name", candidate.stem))
        all_trains[peer_name] = peer_data

    for row in coupler_rows(data):
        required = ("id", "from_train", "from_car", "to_train", "to_car", "mode")
        missing = [field for field in required if not row.get(field)]
        if missing:
            errors.append(f"coupler missing fields: {', '.join(missing)}")
            continue
        if row["mode"] not in ALLOWED_COUPLER_MODES:
            errors.append(f"coupler {row['id']} has invalid mode {row['mode']!r}")
        if row["from_train"] != name:
            errors.append(f"coupler {row['id']} from_train must be {name}")
        if row["from_car"] not in ids:
            errors.append(f"coupler {row['id']} references unknown from_car {row['from_car']}")
        target = all_trains.get(str(row["to_train"]))
        if target is None:
            errors.append(f"coupler {row['id']} target train is missing")
        else:
            target_ids = {str(car.get("id")) for car in target.get("cars", [])}
            if row["to_car"] not in target_ids:
                errors.append(f"coupler {row['id']} target car {row['to_car']} is missing")

    for peer in peers:
        peer_data = all_trains.get(str(peer))
        if peer_data is None:
            errors.append(f"meta.couples_with references missing train {peer}")
            continue
        connecting = coupler_rows(data) + coupler_rows(peer_data)
        if not any(
            {str(row.get("from_train")), str(row.get("to_train"))} == {name, str(peer)}
            for row in connecting
        ):
            errors.append(f"no [[couplers]] row connects {name} and {peer}")

    return errors


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("train", type=Path)
    args = parser.parse_args()
    path = args.train.resolve()
    repo_root = Path(__file__).resolve().parents[3]
    try:
        errors = validate(path, repo_root)
    except RuntimeError as exc:
        print(f"validate_beadtrain: {exc}", file=sys.stderr)
        return 2
    if errors:
        for error in errors:
            print(f"ERROR: {error}")
        return 1
    print(f"Valid beadtrain: {path.relative_to(repo_root)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
