#!/usr/bin/env python3
"""Compare qualified Release 122 and Glulx parity transcripts by outcome semantics."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Any


CONTRACT: dict[str, dict[str, list[str]]] = {
    "troll": {
        "alert_restraint_failure": [
            "You approach the alert, armed troll with the rope arranged confidently."
        ],
        "one_use_distraction": ["You gasp and point behind the troll."],
        "living_restraint": [
            "loop the rope around his arms",
            "The bound troll remains alive, furious",
        ],
        "conditional_axe_drop": ["His axe clatters to the floor."],
        "passage_opening": ["East-West Passage"],
        "persistent_recap": [
            "What you currently remember:",
            "The troll remains alive, thoroughly tied",
        ],
    },
    "safe": {
        "deliberate_sack_preparation": [
            "You spread the brown sack beneath the branch"
        ],
        "prepared_intact_catch": [
            "lands in the prepared brown sack",
            "jewel-encrusted egg",
        ],
        "sandwich_narration": [
            "hot-pepper sandwich contributes the first useful cushioning"
        ],
        "empty_sack_narration": [
            "relying entirely on canvas, luck, and questionable preparation"
        ],
        "caught_egg_description": [
            "A large jewel-encrusted egg rests here, intact"
        ],
    },
    "broken": {
        "unprepared_sack_failure": [
            "unprepared sack beneath the tree",
            "springs open with an expensive crunch",
        ],
        "canonical_bad_egg": ["There is a somewhat ruined egg here."],
        "canonical_non_torch_burn": [
            "The bird's nest catches fire and is consumed."
        ],
        "abandoned_trick_recovery": [
            "You gasp and point behind the troll.",
            "You approach the alert, armed troll with the rope arranged confidently.",
        ],
        "unarmed_bind_without_phantom_axe": [
            "[Test-only unarmed troll scenario.]",
            "You seize the troll's present disadvantage and loop the rope",
        ],
    },
}


def read(path: Path) -> str:
    """Read one transcript as tolerant UTF-8 text."""
    return path.read_text(encoding="utf-8", errors="replace")


def evaluate(route: str, text: str) -> dict[str, Any]:
    """Evaluate every semantic category for one route transcript."""
    results: dict[str, Any] = {}
    for category, markers in CONTRACT[route].items():
        missing = [marker for marker in markers if marker not in text]
        results[category] = {"passed": not missing, "missing": missing}
    if route == "broken":
        unarmed = text.split("[Test-only unarmed troll scenario.]", 1)
        if len(unarmed) == 2:
            segment = unarmed[1].split("[Test-only bound troll restoration scenario.]", 1)[0]
            phantom = "His axe clatters to the floor." in segment
        else:
            phantom = True
        results["unarmed_bind_without_phantom_axe"]["passed"] &= not phantom
        results["unarmed_bind_without_phantom_axe"]["phantom_axe_drop"] = phantom
    return results


def main() -> int:
    """Compare both virtual-machine routes and write a machine-readable receipt."""
    parser = argparse.ArgumentParser()
    for vm in ("v3", "glulx"):
        for route in CONTRACT:
            parser.add_argument(f"--{vm}-{route}", type=Path, required=True)
    parser.add_argument("--json", type=Path, required=True)
    args = parser.parse_args()

    report: dict[str, Any] = {
        "comparison": "semantic outcomes; byte and prose wrapping parity not required",
        "virtual_machines": {},
    }
    failures: list[str] = []
    for vm in ("v3", "glulx"):
        vm_results: dict[str, Any] = {}
        for route in CONTRACT:
            path = getattr(args, f"{vm}_{route}")
            route_results = evaluate(route, read(path))
            vm_results[route] = route_results
            for category, result in route_results.items():
                if not result["passed"]:
                    failures.append(f"{vm}:{route}:{category}")
        report["virtual_machines"][vm] = vm_results

    parity: dict[str, Any] = {}
    for route, categories in CONTRACT.items():
        parity[route] = {}
        for category in categories:
            v3_passed = report["virtual_machines"]["v3"][route][category]["passed"]
            glulx_passed = report["virtual_machines"]["glulx"][route][category]["passed"]
            parity[route][category] = {
                "v3": v3_passed,
                "glulx": glulx_passed,
                "semantic_parity": v3_passed and glulx_passed,
            }
    report["parity"] = parity
    report["passed"] = not failures
    report["failures"] = failures
    args.json.parent.mkdir(parents=True, exist_ok=True)
    args.json.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n")
    if failures:
        raise SystemExit("semantic parity failures: " + ", ".join(failures))
    print("Release 122 and Glulx Release 1214 satisfy the shared outcome contract.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
