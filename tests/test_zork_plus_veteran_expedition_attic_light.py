"""Direct gameplay contract for the fixed Veteran Expedition archive light."""

from __future__ import annotations

import json
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx/zork-plus-veteran-expedition"


class VeteranAtticWorkLightTests(unittest.TestCase):
    def test_light_is_physical_fixed_and_post_victory_materialized(self) -> None:
        patch = json.loads(
            (TRAIN / "patches/002-veteran-attic-work-light.json").read_text(
                encoding="utf-8"
            )
        )
        self.assertEqual(patch["path"], "zork_plus_veteran_expedition.zil")
        rendered = "\n".join(item["new"] for item in patch["replacements"])
        self.assertIn("<OBJECT VETERAN-ARCHIVE-WORK-LIGHT", rendered)
        self.assertIn("(FLAGS LIGHTBIT ONBIT TRYTAKEBIT)", rendered)
        self.assertIn("<MOVE ,VETERAN-ARCHIVE-WORK-LIGHT ,ATTIC>", rendered)
        self.assertIn("<VERB? LAMP-OFF>", rendered)
        self.assertIn("bolted to the rafters", rendered)
        self.assertNotIn("TAKEBIT", rendered)

    def test_manifest_stages_light_without_new_changed_path(self) -> None:
        manifest = json.loads(
            (TRAIN / "patch-series.json").read_text(encoding="utf-8")
        )
        self.assertIn(
            "patches/002-veteran-attic-work-light.json", manifest["patches"]
        )
        self.assertEqual(
            manifest["expected_changed_paths"],
            [
                "completed_expedition_archive.zil",
                "zork1.zil",
                "zork_plus_veteran_expedition.zil",
            ],
        )


if __name__ == "__main__":
    unittest.main()
