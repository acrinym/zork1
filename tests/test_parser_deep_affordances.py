"""Direct qualification for Release 1232 parser intent routes."""

from __future__ import annotations

import json
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx/parser-deep-affordances"


class ParserDeepAffordancesTests(unittest.TestCase):
    """Verify selected player intentions route to canonical actions."""

    def test_manifest_is_release_1232_over_locked_release_1231(self) -> None:
        manifest = json.loads((TRAIN / "patch-series.json").read_text())
        self.assertEqual(manifest["release"], 1232)
        self.assertEqual(manifest["base_release"], 1231)
        self.assertEqual(
            manifest["base_artifact_sha256"],
            "5daaa7307ef496a3ae37209a6e79e149c9dc3d202f148f143bbb571fa74b3609",
        )
        self.assertEqual(
            manifest["expected_changed_paths"], ["gsyntax.zil", "zork1.zil"]
        )

    def test_hosted_artifact_identity_is_locked(self) -> None:
        expected = json.loads((TRAIN / "patch-series.json").read_text())[
            "expected_artifact"
        ]
        self.assertTrue(expected["locked"])
        self.assertEqual(expected["size_bytes"], 337920)
        self.assertEqual(expected["checksum_hex"], "0x2c2192e1")
        self.assertEqual(
            expected["sha256"],
            "2cffc734dbfbe346d0ec185c6962d927bc046343dccdb53b6a9e4439521b6f2e",
        )

    def test_examination_routes_are_explicit(self) -> None:
        patch = json.loads(
            (TRAIN / "patches/001-parser-intent-routes.json").read_text()
        )
        joined = "\n".join(item["new"] for item in patch["replacements"])
        self.assertIn("<SYNONYM EXAMINE X INSPECT", joined)
        self.assertIn("<SYNTAX EXAMINE UNDER OBJECT = V-LOOK-UNDER>", joined)
        self.assertIn("<SYNTAX EXAMINE BEHIND OBJECT = V-LOOK-BEHIND>", joined)

    def test_switch_and_repair_routes_preserve_accumulated_synonyms(self) -> None:
        patch = json.loads(
            (TRAIN / "patches/001-parser-intent-routes.json").read_text()
        )
        replacements = patch["replacements"]
        self.assertEqual(replacements[1]["old"], "<SYNONYM PLUG ")
        self.assertEqual(replacements[1]["new"], "<SYNONYM PLUG SEAL MEND ")
        self.assertEqual(replacements[2]["old"], "<SYNONYM TURN ")
        self.assertEqual(replacements[2]["new"], "<SYNONYM TURN SWITCH ")
        joined = "\n".join(item["new"] for item in replacements)
        self.assertNotIn("V-SWITCH", joined)
        self.assertNotIn("V-SEAL", joined)
        self.assertNotIn("V-MEND", joined)

    def test_train_does_not_add_or_expand_use_routing(self) -> None:
        manifest = json.loads((TRAIN / "patch-series.json").read_text())
        patch = json.loads(
            (TRAIN / "patches/001-parser-intent-routes.json").read_text()
        )
        serialized_patch = json.dumps(patch)
        self.assertNotIn("V-USE", serialized_patch)
        self.assertNotIn("SYNTAX USE", serialized_patch)
        self.assertIn(
            "no new or expanded generic USE routing", manifest["boundaries"]
        )
        self.assertIn(
            "Release 1211 bounded USE OBJECT assistance remains unchanged",
            manifest["preserved_parser_behavior"],
        )

    def test_every_replacement_is_single_anchor(self) -> None:
        patch = json.loads(
            (TRAIN / "patches/001-parser-intent-routes.json").read_text()
        )
        self.assertEqual(patch["path"], "gsyntax.zil")
        self.assertEqual(len(patch["replacements"]), 3)
        self.assertTrue(
            all(item["expected_count"] == 1 for item in patch["replacements"])
        )

    def test_entrypoint_retains_release_1231_layers(self) -> None:
        entrypoint = (TRAIN / "overrides/zork1.zil").read_text()
        self.assertIn("<CONSTANT RELEASEID 1232>", entrypoint)
        self.assertIn('<INSERT-FILE "corpus_causal_warning" T>', entrypoint)
        self.assertNotIn("parser_deep_affordances", entrypoint)


if __name__ == "__main__":
    unittest.main()
