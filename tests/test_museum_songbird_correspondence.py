"""Direct gameplay contracts for Release 1240."""

from __future__ import annotations

import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx/museum-songbird-correspondence"
MODULE = TRAIN / "overrides/museum_songbird_correspondence.zil"
INTAKE = TRAIN / "overrides/museum_intake_first_gallery.zil"
PATCH = TRAIN / "patches/001-canary-songbird-feather.json"


class MuseumSongbirdCorrespondenceTests(unittest.TestCase):
    def test_release_1240_uses_locked_1239_base(self) -> None:
        manifest = json.loads((TRAIN / "patch-series.json").read_text(encoding="utf-8"))
        self.assertEqual(manifest["release"], 1240)
        self.assertEqual(manifest["base_release"], 1239)
        self.assertEqual(
            manifest["base_artifact_sha256"],
            "5b81448327cb5a2a60298f28d76062c0c5498ec5fc11f6d627a4873e82cba11f",
        )

    def test_feather_case_nest_and_plaque_are_physical_objects(self) -> None:
        module = MODULE.read_text(encoding="utf-8")
        for object_name in (
            "MUSEUM-FOREST-CASE",
            "SONGBIRD-PLAQUE",
            "SONGBIRD-NEST",
            "SONGBIRD-FEATHER",
        ):
            self.assertIn(f"<OBJECT {object_name}", module)
        self.assertIn("(IN UP-A-TREE)", module)
        self.assertIn("(IN LIVING-ROOM)", module)

    def test_canonical_canary_event_drops_one_real_feather_beside_bauble(self) -> None:
        patch = json.loads(PATCH.read_text(encoding="utf-8"))
        self.assertEqual(patch["path"], "1actions.zil")
        replacement = patch["replacements"][0]
        self.assertEqual(replacement["expected_count"], 1)
        self.assertIn("<MUSEUM-SONGBIRD-OBSERVED>", replacement["new"])
        module = MODULE.read_text(encoding="utf-8")
        self.assertIn("<MOVE ,SONGBIRD-FEATHER <LOC ,BAUBLE>>", module)
        self.assertEqual(module.count("<OBJECT SONGBIRD-FEATHER"), 1)
        self.assertNotIn("<OBJECT BAUBLE", module)
        self.assertNotIn("<OBJECT CANARY", module)

    def test_nest_return_moves_same_feather_and_blocks_vandalism(self) -> None:
        module = MODULE.read_text(encoding="utf-8")
        self.assertIn("<MOVE ,SONGBIRD-FEATHER ,SONGBIRD-NEST>", module)
        self.assertIn("<IN? ,SONGBIRD-FEATHER ,SONGBIRD-NEST>", module)
        self.assertIn("Pulling apart the woven cup", module)
        self.assertNotIn("COPY", module.upper())
        self.assertNotIn("<OBJECT SONGBIRD-REPLICA", module)

    def test_museum_intake_routes_only_feather_to_forest_case(self) -> None:
        intake = INTAKE.read_text(encoding="utf-8")
        self.assertIn("<MUSEUM-FOREST-ACCEPTS? .OBJ>", intake)
        self.assertIn("<RETURN ,MUSEUM-FOREST-CASE>", intake)
        self.assertIn("<G? <GETP .OBJ ,P?TVALUE> 0>", intake)
        self.assertIn("<RETURN ,TROPHY-CASE>", intake)
        self.assertIn("<MUSEUM-FOREST-PROJECT>", intake)

    def test_catalog_and_plaque_read_actual_object_locations(self) -> None:
        module = MODULE.read_text(encoding="utf-8")
        for token in (
            "<IN? ,SONGBIRD-FEATHER ,MUSEUM-FOREST-CASE>",
            "<IN? ,SONGBIRD-FEATHER ,SONGBIRD-NEST>",
            "<IN? ,BAUBLE ,TROPHY-CASE>",
        ):
            self.assertIn(token, module)
        self.assertNotIn("FOREST-SLOT", module)
        self.assertNotIn("COLLECTION-REGISTRY", module)

    def test_entrypoint_loads_songbird_before_intake(self) -> None:
        entry = (TRAIN / "overrides/zork1.zil").read_text(encoding="utf-8")
        self.assertIn("<CONSTANT RELEASEID 1240>", entry)
        songbird = entry.index('<INSERT-FILE "museum_songbird_correspondence" T>')
        intake = entry.index('<INSERT-FILE "museum_intake_first_gallery" T>')
        self.assertLess(songbird, intake)
        self.assertTrue(entry.rstrip().endswith('<INSERT-FILE "cellar_recovery_locker" T>'))


if __name__ == "__main__":
    unittest.main()
