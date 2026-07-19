#!/usr/bin/env python3
"""Validate one v1.3 beadtrain against all issues*.jsonl ledgers."""

from __future__ import annotations

import argparse
import json
import sys
import tomllib
from pathlib import Path
from typing import Any

ALLOWED_TRAIN_STATUS = {"planned", "in_progress", "complete", "blocked"}


def load_issues(beads_dir: Path) -> dict[str, dict[str, Any]]:
    """Merge the canonical ledger and additive issue shards without duplicates."""
    issues: dict[str, dict[str, Any]] = {}
    paths = sorted(beads_dir.glob("issues*.jsonl"))
    if not paths:
        raise RuntimeError("no issues*.jsonl ledgers found")
    for path in paths:
        for number, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
            if not line.strip():
                continue
            try:
                issue = json.loads(line)
            except json.JSONDecodeError as exc:
                raise RuntimeError(f"{path}:{number}: {exc}") from exc
            issue_id = str(issue.get("id", ""))
            if not issue_id:
                raise RuntimeError(f"{path}:{number}: issue has no id")
            if issue_id in issues:
                raise RuntimeError(f"duplicate issue id {issue_id} in {path}")
            issues[issue_id] = issue
    return issues


def find_cycle(graph: dict[str, list[str]]) -> list[str] | None:
    """Return one local dependency cycle, if present."""
    visiting: set[str] = set()
    visited: set[str] = set()
    stack: list[str] = []

    def visit(node: str) -> list[str] | None:
        if node in visiting:
            return stack[stack.index(node):] + [node]
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


def validate(path: Path, repo_root: Path) -> list[str]:
    """Validate train structure, sharded bead references, DAG, and completion."""
    errors: list[str] = []
    try:
        with path.open("rb") as handle:
            data = tomllib.load(handle)
    except (OSError, tomllib.TOMLDecodeError) as exc:
        return [f"cannot read {path}: {exc}"]

    train = data.get("train")
    if not isinstance(train, dict):
        return ["missing [train] table"]
    if str(train.get("name", "")) != path.stem:
        errors.append("train.name must match the filename stem")
    if train.get("status") not in ALLOWED_TRAIN_STATUS:
        errors.append(f"invalid train status {train.get('status')!r}")
    for field in ("title", "description", "created"):
        if not train.get(field):
            errors.append(f"train.{field} is required")

    cars = data.get("cars")
    if not isinstance(cars, list) or not cars:
        return errors + ["at least one [[cars]] row is required"]

    issues = load_issues(repo_root / ".beads")
    ids: set[str] = set()
    graph: dict[str, list[str]] = {}
    beads: list[str] = []
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
        beads.append(bead)
        if bead not in issues:
            errors.append(f"car {car_id} references missing bead {bead!r}")
        if not car.get("title") or not car.get("summary"):
            errors.append(f"car {car_id} requires title and summary")
        if not isinstance(car.get("parallel_start"), bool):
            errors.append(f"car {car_id} parallel_start must be boolean")
        dependencies = car.get("depends_on")
        if not isinstance(dependencies, list) or not all(isinstance(item, str) for item in dependencies):
            errors.append(f"car {car_id} depends_on must be a string list")
            dependencies = []
        graph[car_id] = list(dependencies)

    for car_id, dependencies in graph.items():
        for dependency in dependencies:
            if dependency not in ids:
                errors.append(f"car {car_id} depends on unknown local car {dependency!r}")
    cycle = find_cycle(graph) if not errors else None
    if cycle:
        errors.append("dependency cycle: " + " -> ".join(cycle))

    if train.get("status") == "complete":
        for bead in beads:
            if issues.get(bead, {}).get("status") != "closed":
                errors.append(f"complete train references non-closed bead {bead}")
    return errors


def main() -> int:
    """Command-line entry point."""
    parser = argparse.ArgumentParser()
    parser.add_argument("train", type=Path)
    args = parser.parse_args()
    path = args.train.resolve()
    repo_root = Path(__file__).resolve().parents[3]
    try:
        errors = validate(path, repo_root)
    except RuntimeError as exc:
        print(f"validate_sharded_beadtrain: {exc}", file=sys.stderr)
        return 2
    if errors:
        for error in errors:
            print(f"ERROR: {error}")
        return 1
    print(f"Valid sharded beadtrain: {path.relative_to(repo_root)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
