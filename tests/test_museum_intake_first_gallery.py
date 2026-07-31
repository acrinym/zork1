"""Direct qualification for Release 1233 museum intake assets."""

from __future__ import annotations

import json
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx/museum-intake-first-gallery"


class MuseumIntakeFirstGalleryTests(unittest.TestCase):
    """Verify physical intake delegates to existing museum authorities."""

    def test_manifest_is_release_1233_over_locked_release_1232(self) -> None:
        manifest = json.loads((TRAIN / "patch-series.json").read_text())
        self.assertEqual(manifest["release"], 1233)
        self.assertEqual(manifest["base_release"], 1232)
        self.assertEqual(
            manifest["base_artifact_sha256"],
            "2cffc734dbfbe346d0ec185c6962d927bc046343dccdb53b6a9e4439521b6f2e",
        )
        self.assertEqual(
            manifest["expected_changed_paths"],
            ["museum_intake_first_gallery.zil", "zork1.zil"],
        )

    def test_intake_uses_existing_museum_surfaces(self) -> None:
        module = (TRAIN / "overrides/museum_intake_first_gallery.zil").read_text()
        for surface in (
            "TROPHY-CASE",
            "MUSEUM-FRAME",
            "MUSEUM-WEAPON-WALL",
            "MUSEUM-RECORD-SHELF",
            "MUSEUM-RELIC-STAND",
        ):
            self.assertIn(surface, module)
        self.assertIn("MUSEUM-ACCEPTS?", module)
        self.assertIn("MUSEUM-PROJECT", module)

    def test_intake_routes_each_class_to_its_exact_surface(self) -> None:
        module = (TRAIN / "overrides/museum_intake_first_gallery.zil").read_text()
        for target in (
            "<RETURN ,TROPHY-CASE>",
            "<RETURN ,MUSEUM-FRAME>",
            "<RETURN ,MUSEUM-WEAPON-WALL>",
            "<RETURN ,MUSEUM-RECORD-SHELF>",
            "<RETURN ,MUSEUM-RELIC-STAND>",
        ):
            self.assertEqual(module.count(target), 1)
        self.assertIn(
            "<PERFORM ,V?PUT-ON ,PRSO ,MUSEUM-RELIC-STAND>", module
        )

    def test_intake_delegates_to_canonical_put_actions(self) -> None:
        module = (TRAIN / "overrides/museum_intake_first_gallery.zil").read_text()
        self.assertIn("<PERFORM ,V?PUT ,PRSO .SURFACE>", module)
        self.assertIn("<PERFORM ,V?PUT-ON ,PRSO .SURFACE>", module)
        self.assertNotIn("<MOVE ,PRSO", module)
        self.assertNotIn("<REMOVE ,PRSO", module)

    def test_outside_gallery_refusal_matches_corpus_asset(self) -> None:
        module = (TRAIN / "overrides/museum_intake_first_gallery.zil").read_text()
        refusal = (TRAIN / "prose/outside-gallery-refusal.txt").read_text().strip()
        self.assertEqual(refusal, "There is no museum intake here.")
        self.assertEqual(module.count(f'<TELL "{refusal}" CR>'), 2)

    def test_train_adds_no_parallel_collection_state(self) -> None:
        module = (TRAIN / "overrides/museum_intake_first_gallery.zil").read_text()
        self.assertNotIn("<GLOBAL", module)
        self.assertNotIn("<TABLE", module)
        self.assertNotIn("REGISTRY", module)
        self.assertNotIn("DATABASE", module)

    def test_catalog_noun_is_interface_not_collection_state(self) -> None:
        module = (TRAIN / "overrides/museum_intake_first_gallery.zil").read_text()
        self.assertIn("<OBJECT MUSEUM-CATALOG-OBJECT", module)
        self.assertIn("(IN GLOBAL-OBJECTS)", module)
        self.assertIn("(SYNONYM MUSEUM GALLERY COLLECTION)", module)
        self.assertIn("(FLAGS NDESCBIT RMUNGBIT)", module)
        self.assertNotIn("(IN LIVING-ROOM)", module)
        self.assertNotIn("(ACTION", module.split("<OBJECT MUSEUM-CATALOG-OBJECT", 1)[1].split(">", 1)[0])

    def test_parser_surface_is_bounded(self) -> None:
        module = (TRAIN / "overrides/museum_intake_first_gallery.zil").read_text()
        self.assertIn(
            "<SYNTAX EXHIBIT OBJECT (MANY HELD HAVE) = V-MUSEUM-EXHIBIT>",
            module,
        )
        self.assertIn(
            "<SYNTAX CATALOG OBJECT (FIND RMUNGBIT) = V-MUSEUM-CATALOG>",
            module,
        )
        self.assertIn(
            "<SYNTAX REVIEW OBJECT (FIND RMUNGBIT) = V-MUSEUM-CATALOG>",
            module,
        )
        self.assertNotIn("<BUZZ MUSEUM>", module)
        self.assertNotIn("DONATE", module)
        self.assertNotIn("COLLECT ALL", module)

    def test_entrypoint_retains_release_1232_and_loads_intake_last(self) -> None:
        entrypoint = (TRAIN / "overrides/zork1.zil").read_text()
        self.assertIn("<CONSTANT RELEASEID 1233>", entrypoint)
        self.assertIn('<INSERT-FILE "corpus_causal_warning" T>', entrypoint)
        self.assertTrue(
            entrypoint.rstrip().endswith(
                '<INSERT-FILE "museum_intake_first_gallery" T>'
            )
        )


if __name__ == "__main__":
    unittest.main()
