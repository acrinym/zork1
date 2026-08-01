"""Direct gameplay contracts for Release 1239."""

from __future__ import annotations

import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx/museum-ecology-dam-fishing"
MODULE = TRAIN / "overrides/museum_ecology_dam_fishing.zil"
INTAKE = TRAIN / "overrides/museum_intake_first_gallery.zil"


class MuseumEcologyDamFishingTests(unittest.TestCase):
    def test_release_1239_uses_locked_1238_base(self) -> None:
        manifest = json.loads((TRAIN / "patch-series.json").read_text(encoding="utf-8"))
        self.assertEqual(manifest["release"], 1239)
        self.assertEqual(manifest["base_release"], 1238)
        self.assertEqual(
            manifest["base_artifact_sha256"],
            "95dd5a7e88be6c76732513e81c8e6b06f3f664053f3a3c8a23ebad0c61242ec8",
        )

    def test_rod_jar_fish_and_case_are_physical_objects(self) -> None:
        module = MODULE.read_text(encoding="utf-8")
        for object_name in (
            "MUSEUM-FISHING-ROD",
            "MUSEUM-FIELD-JAR",
            "DAM-SILVERFIN",
            "MUSEUM-WATERS-CASE",
            "SILVERFIN-PLAQUE",
        ):
            self.assertIn(f"<OBJECT {object_name}", module)
        self.assertIn("(IN LIVING-ROOM)", module)
        self.assertIn("<MOVE ,DAM-SILVERFIN ,MUSEUM-FIELD-JAR>", module)

    def test_catch_uses_existing_dam_state(self) -> None:
        module = MODULE.read_text(encoding="utf-8")
        self.assertIn("<EQUAL? ,HERE ,DAM-BASE>", module)
        self.assertIn(",LOW-TIDE ,SILVERFIN-SPILLWAY", module)
        self.assertIn("(T ,SILVERFIN-RIVER)", module)
        self.assertNotIn("<RANDOM", module)

    def test_release_removes_real_specimen_but_keeps_observation(self) -> None:
        module = MODULE.read_text(encoding="utf-8")
        self.assertIn("<REMOVE ,DAM-SILVERFIN>", module)
        self.assertIn("<AQUATIC-PUT ,AQUATIC-SLOT-RELEASED 1>", module)
        self.assertNotIn("OBJECT-ID", module)
        self.assertNotIn("COPY", module.upper())

    def test_museum_intake_routes_fish_to_waters_case(self) -> None:
        intake = INTAKE.read_text(encoding="utf-8")
        self.assertIn("<MUSEUM-AQUATIC-ACCEPTS? .OBJ>", intake)
        self.assertIn("<RETURN ,MUSEUM-WATERS-CASE>", intake)
        self.assertIn("<MUSEUM-AQUATIC-PROJECT>", intake)

    def test_entrypoint_loads_ecology_before_intake(self) -> None:
        entry = (TRAIN / "overrides/zork1.zil").read_text(encoding="utf-8")
        self.assertIn("<CONSTANT RELEASEID 1239>", entry)
        ecology = entry.index('<INSERT-FILE "museum_ecology_dam_fishing" T>')
        intake = entry.index('<INSERT-FILE "museum_intake_first_gallery" T>')
        self.assertLess(ecology, intake)
        self.assertTrue(entry.rstrip().endswith('<INSERT-FILE "cellar_recovery_locker" T>'))


if __name__ == "__main__":
    unittest.main()
