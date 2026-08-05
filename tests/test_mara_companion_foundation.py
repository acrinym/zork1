from __future__ import annotations

import hashlib
import json
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx" / "mara-companion-foundation"
MANIFEST = TRAIN / "patch-series.json"
MODULE = TRAIN / "overrides" / "mara_companion.zil"
STATUS = ROOT / "ideas" / "extended-zork" / "mara-tallow-implementation-status.md"


class MaraCompanionFoundationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.manifest = json.loads(MANIFEST.read_text(encoding="utf-8"))
        cls.module = MODULE.read_text(encoding="utf-8")

    def test_release_lineage_is_locked_to_release_1242(self) -> None:
        self.assertEqual(self.manifest["release"], 1243)
        self.assertEqual(self.manifest["base_release"], 1242)
        self.assertEqual(
            self.manifest["base_artifact_sha256"],
            "1e6b61f68a32289e6085e784493518f0662083907390bdba900557548a53f173",
        )
        self.assertEqual(self.manifest["serial"], "260805")

    def test_override_identity_is_exact(self) -> None:
        override = self.manifest["overrides"][0]
        self.assertEqual(override["destination"], "mara_companion.zil")
        self.assertEqual(
            hashlib.sha256(MODULE.read_bytes()).hexdigest(),
            override["expected_sha256"],
        )
        self.assertEqual(
            override["expected_base_sha256"],
            "3084214bafb50b6f5995173e2c5555c51176c29a69a5080d04a406c693903734",
        )

    def test_mara_is_a_dam_companion_not_museum_furniture(self) -> None:
        self.assertIn("<OBJECT MARA\n    (IN DAM-BASE)", self.module)
        self.assertNotIn("(IN LIVING-ROOM)\n    (SYNONYM MARA", self.module)
        self.assertIn("Last Honest Survey", self.module)
        self.assertIn("she is not its curator", self.module)

    def test_direct_address_and_joint_actions_are_real_parser_actions(self) -> None:
        for grammar in (
            "<SYNTAX BRACE OBJECT = V-MARA-BRACE>",
            "<SYNTAX SURVEY OBJECT WITH OBJECT",
            "<SYNTAX THANK OBJECT",
            "<SYNTAX APOLOGIZE TO OBJECT",
        ):
            self.assertIn(grammar, self.module)
        self.assertIn("<AND <EQUAL? ,WINNER ,MARA> <VERB? FOLLOW>>", self.module)
        self.assertIn("<AND <EQUAL? ,WINNER ,MARA> <VERB? WAIT>>", self.module)
        self.assertIn("MARA, BRACE PANEL", self.module)

    def test_physical_state_and_custody_are_persistent(self) -> None:
        for object_name in (
            "MARA-FIELD-PACK",
            "MARA-NOTEBOOK",
            "MARA-FIELD-ROPE",
            "MARA-FIELD-LANTERN",
            "MARA-DAM-SURVEY-SHEET",
        ):
            self.assertEqual(self.module.count(f"<OBJECT {object_name}"), 1)
        self.assertIn("<MOVE ,MARA-DAM-SURVEY-SHEET ,MARA>", self.module)
        self.assertIn("exact custody remains hers", self.module)
        self.assertNotIn("<GLOBAL MARA-", self.module)

    def test_following_is_authored_and_non_teleporting(self) -> None:
        self.assertIn("<ROUTINE MARA-AFTER-PLAYER-MOVE (FROM TO)", self.module)
        self.assertIn("<EQUAL? <LOC ,MARA> .FROM>", self.module)
        self.assertIn("<MOVE ,MARA .TO>", self.module)
        self.assertIn("outside the plan you made together", self.module)
        self.assertIn("<ROUTINE MARA-CAN-ENTER? (RM)", self.module)
        self.assertIn("<IN? ,TROLL ,TROLL-ROOM>", self.module)

    def test_relationship_evidence_cannot_be_command_ground(self) -> None:
        self.assertIn("MARA-SLOT-EVIDENCE-SHARED", self.module)
        self.assertIn("Repetition does not turn gratitude into currency", self.module)
        self.assertIn("She is watching the behavior that follows it", self.module)
        self.assertIn("The boundary is calm and complete", self.module)
        self.assertNotIn("AFFECTION-SCORE", self.module)
        self.assertNotIn("APPROVAL", self.module)

    def test_warning_refusal_repair_and_apology_are_specific(self) -> None:
        self.assertIn("<ROUTINE MARA-ACTION-HOOK ()", self.module)
        self.assertIn("<EQUAL? ,PRSO ,BLUE-BUTTON>", self.module)
        self.assertIn("you may not issue it as hers", self.module)
        self.assertIn("<MOVE ,MARA ,DAM-LOBBY>", self.module)
        self.assertIn("Seal the pipe first", self.module)
        self.assertIn("You name the warning you ignored", self.module)

    def test_ecology_memory_requires_physical_presence(self) -> None:
        self.assertIn("<ROUTINE MARA-WITNESS-FISH (VARIETY)", self.module)
        self.assertIn("<ROUTINE MARA-WITNESS-RELEASE ()", self.module)
        self.assertGreaterEqual(self.module.count("<MARA-HERE?>"), 8)
        self.assertIn("Evidence observed, animal alive, custody closed", self.module)

    def test_changed_paths_are_narrow_and_product_facing(self) -> None:
        self.assertEqual(
            set(self.manifest["expected_changed_paths"]),
            {
                "dam_mechanisms.zil",
                "gverbs.zil",
                "mara_companion.zil",
                "museum_ecology_dam_fishing.zil",
                "shadow_logic.zil",
                "zork1.zil",
            },
        )
        self.assertEqual(len(self.manifest["patches"]), 5)

    def test_implementation_status_preserves_the_full_design(self) -> None:
        text = STATUS.read_text(encoding="utf-8")
        self.assertIn("human-companion-bond-and-love-interest.md", text)
        self.assertIn("Mara Tallow", text)
        self.assertIn("Release 1243", text)
        self.assertIn("deeper friendship", text)


if __name__ == "__main__":
    unittest.main()
