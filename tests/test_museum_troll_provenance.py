"""Direct gameplay contracts for Release 1241."""

from __future__ import annotations

import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx/museum-troll-provenance"
MODULE = TRAIN / "overrides/museum_troll_provenance.zil"
INTAKE = TRAIN / "overrides/museum_intake_first_gallery.zil"
PATCH = TRAIN / "patches/001-troll-outcome-trace.json"


class MuseumTrollProvenanceTests(unittest.TestCase):
    def test_release_1241_uses_locked_1240_base(self) -> None:
        manifest = json.loads((TRAIN / "patch-series.json").read_text(encoding="utf-8"))
        self.assertEqual(manifest["release"], 1241)
        self.assertEqual(manifest["base_release"], 1240)
        self.assertEqual(
            manifest["base_artifact_sha256"],
            "067ab63fd33bd35a3bb7f4a118e3d49e09f24b268231922ad9f68417c1560630",
        )

    def test_one_physical_tuft_case_and_plaque_exist(self) -> None:
        module = MODULE.read_text(encoding="utf-8")
        for object_name in (
            "MUSEUM-MONSTER-CASE",
            "TROLL-PLAQUE",
            "TROLL-FUR",
        ):
            self.assertIn(f"<OBJECT {object_name}", module)
        self.assertEqual(module.count("<OBJECT TROLL-FUR"), 1)
        self.assertNotIn("<OBJECT TROLL\n", module)
        self.assertNotIn("<OBJECT AXE", module)

    def test_canonical_troll_outcomes_create_the_trace(self) -> None:
        patch = json.loads(PATCH.read_text(encoding="utf-8"))
        self.assertEqual(patch["path"], "1actions.zil")
        self.assertEqual(len(patch["replacements"]), 2)
        for replacement in patch["replacements"]:
            self.assertEqual(replacement["expected_count"], 1)
        joined = "\n".join(item["new"] for item in patch["replacements"])
        self.assertIn("<MUSEUM-TROLL-TRACE 1>", joined)
        self.assertIn("<MUSEUM-TROLL-TRACE 2>", joined)
        self.assertIn("F-UNCONSCIOUS", joined)
        module = MODULE.read_text(encoding="utf-8")
        self.assertIn("<MOVE ,TROLL-FUR ,HERE>", module)
        self.assertIn("<NOT <LOC ,TROLL-FUR>>", module)

    def test_historical_outcome_is_bounded_and_saveable(self) -> None:
        module = MODULE.read_text(encoding="utf-8")
        self.assertIn("<CONSTANT TROLL-TRACE-STATE <TABLE", module)
        self.assertIn("TROLL-OUTCOME-SUBDUED", module)
        self.assertIn("TROLL-OUTCOME-KILLED", module)
        self.assertIn("rendered unconscious", module)
        self.assertIn("confirmed kill", module)
        self.assertNotIn("<GLOBAL TROLL-TRACE", module)
        self.assertNotIn("<RANDOM", module)

    def test_museum_intake_routes_only_real_fur_to_creature_case(self) -> None:
        intake = INTAKE.read_text(encoding="utf-8")
        self.assertIn("<MUSEUM-MONSTER-ACCEPTS? .OBJ>", intake)
        self.assertIn("<RETURN ,MUSEUM-MONSTER-CASE>", intake)
        self.assertIn("<MUSEUM-MONSTER-PROJECT>", intake)
        module = MODULE.read_text(encoding="utf-8")
        self.assertIn("<EQUAL? .OBJ ,TROLL-FUR>", module)

    def test_catalog_and_plaque_read_actual_custody(self) -> None:
        module = MODULE.read_text(encoding="utf-8")
        for token in (
            "<IN? ,TROLL-FUR ,MUSEUM-MONSTER-CASE>",
            "<IN? ,TROLL-FUR ,TROLL-ROOM>",
        ):
            self.assertIn(token, module)
        self.assertNotIn("COLLECTION-REGISTRY", module)
        self.assertNotIn("TROLL-CASE-COMPLETE", module)

    def test_entrypoint_loads_troll_module_before_intake(self) -> None:
        entry = (TRAIN / "overrides/zork1.zil").read_text(encoding="utf-8")
        self.assertIn("<CONSTANT RELEASEID 1241>", entry)
        troll = entry.index('<INSERT-FILE "museum_troll_provenance" T>')
        intake = entry.index('<INSERT-FILE "museum_intake_first_gallery" T>')
        self.assertLess(troll, intake)
        self.assertTrue(entry.rstrip().endswith('<INSERT-FILE "cellar_recovery_locker" T>'))


if __name__ == "__main__":
    unittest.main()
