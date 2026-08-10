from __future__ import annotations

import json
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
EDITION = ROOT / "glulx" / "mara-house-company"
PATCHES = EDITION / "patches"


class MaraHouseThresholdTests(unittest.TestCase):
    def test_unbar_grammar_requires_mara_as_second_actor(self) -> None:
        patch = json.loads((PATCHES / "001-mara-threshold-grammar.json").read_text(encoding="utf-8"))
        rendered = "\n".join(item["new"] for item in patch["replacements"])
        self.assertIn("SYNTAX UNBAR OBJECT", rendered)
        self.assertIn("WITH OBJECT (FIND ACTORBIT) (IN-ROOM) = V-MARA-UNBAR-THRESHOLD", rendered)

    def test_action_opens_the_real_canonical_trap_door(self) -> None:
        patch = json.loads((PATCHES / "002-mara-threshold-action.json").read_text(encoding="utf-8"))
        rendered = "\n".join(item["new"] for item in patch["replacements"])
        self.assertIn("<EQUAL? ,PRSO ,CELLAR-THRESHOLD>", rendered)
        self.assertIn("<EQUAL? ,PRSI ,MARA>", rendered)
        self.assertIn("<EQUAL? ,HERE ,CELLAR>", rendered)
        self.assertIn("MARA-SLOT-DAM-SURVEY", rendered)
        self.assertIn("<FSET ,TRAP-DOOR ,OPENBIT>", rendered)
        self.assertIn("<FSET ,TRAP-DOOR ,TOUCHBIT>", rendered)
        self.assertNotIn("<OBJECT TRAP-DOOR", rendered)
        self.assertNotIn("<MOVE ,MARA", rendered)

    def test_cellar_proxy_accepts_natural_trap_door_nouns(self) -> None:
        patch = json.loads((PATCHES / "003-cellar-threshold-vocabulary.json").read_text(encoding="utf-8"))
        rendered = "\n".join(item["new"] for item in patch["replacements"])
        self.assertIn("TRAPDOOR DOOR HATCH", rendered)
        self.assertIn("CELLAR-THRESHOLD", rendered)

    def test_manifest_records_solo_canonical_boundary(self) -> None:
        manifest = json.loads((EDITION / "patch-series.json").read_text(encoding="utf-8"))
        self.assertIn("house_cellar_threshold.zil", manifest["expected_changed_paths"])
        boundaries = "\n".join(manifest["boundaries"])
        self.assertIn("canonical barred trap door remains canonical for solo play", boundaries)
        self.assertIn("no duplicate trap door", boundaries)


if __name__ == "__main__":
    unittest.main()
