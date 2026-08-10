from __future__ import annotations

import json
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
EDITION = ROOT / "glulx" / "mara-house-company"
OVERRIDES = EDITION / "overrides"


class MaraHouseCompanyTests(unittest.TestCase):
    def test_release_lineage_is_exact(self) -> None:
        manifest = json.loads((EDITION / "patch-series.json").read_text(encoding="utf-8"))
        self.assertEqual(manifest["release"], 1244)
        self.assertEqual(manifest["serial"], "260810")
        self.assertEqual(manifest["base_release"], 1243)
        self.assertEqual(
            manifest["base_artifact_sha256"],
            "8d3f4bf555ba15be82d4d4e849c1501fa61bb3f57630f0a4e91061e89560d629",
        )
        artifact = manifest["expected_artifact"]
        self.assertTrue(artifact["locked"])
        self.assertEqual(artifact["size_bytes"], 386560)
        self.assertEqual(artifact["checksum_hex"], "0x098863ac")
        self.assertEqual(
            artifact["sha256"],
            "e02b4b7c5809179d11a326987dc9f6cdcf94f2aa7aa3709763b6f7cfcb7e1e1d",
        )

    def test_house_state_extends_without_erasing_release_1243_history(self) -> None:
        main = (OVERRIDES / "mara_companion.zil").read_text(encoding="utf-8")
        state = (OVERRIDES / "mara_companion_state.zil").read_text(encoding="utf-8")
        self.assertIn("<CONSTANT MARA-SCHEMA 3>", main)
        self.assertIn("<CONSTANT MARA-PREVIOUS-SCHEMA 2>", main)
        for slot in (
            "MARA-SLOT-HOUSE-INVITED 19",
            "MARA-SLOT-PACK-RETRIEVED 20",
            "MARA-SLOT-HOUSE-STAY 21",
            "MARA-SLOT-MEAL-SHARED 22",
        ):
            self.assertIn(slot, main)
        migration = state.index("<EQUAL? <GET ,MARA-STATE 0> ,MARA-PREVIOUS-SCHEMA>")
        reset = state.index("<NOT <EQUAL? <GET ,MARA-STATE 0> ,MARA-SCHEMA>>")
        self.assertLess(migration, reset)
        preserved_prefix = state[migration:reset]
        self.assertNotIn("MARA-SLOT-DAM-SURVEY 0", preserved_prefix)
        self.assertNotIn("MARA-SLOT-LEAK-CAUSED 0", preserved_prefix)

    def test_invitation_requires_physical_pack_retrieval(self) -> None:
        actions = (OVERRIDES / "mara_companion_actions.zil").read_text(encoding="utf-8")
        actor = (OVERRIDES / "mara_companion_actor.zil").read_text(encoding="utf-8")
        self.assertIn("<ROUTINE V-MARA-INVITE-STAY ()", actions)
        self.assertIn("my field pack is still at the Dam", actions)
        self.assertIn("ask me to take my pack", actions)
        self.assertIn("<ROUTINE MARA-PACK-CAMP ()", actions)
        self.assertIn("<MOVE ,MARA-FIELD-PACK ,MARA>", actions)
        self.assertIn("<MARA-PUT ,MARA-SLOT-PACK-RETRIEVED 1>", actions)
        self.assertIn("<MOVE ,MARA-FIELD-PACK ,ATTIC>", actions)
        self.assertIn("<MARA-PUT ,MARA-SLOT-HOUSE-STAY 1>", actions)
        self.assertIn("<EQUAL? ,PRSO ,MARA-FIELD-PACK>", actor)
        self.assertIn("<MARA-PACK-CAMP>", actor)

    def test_shared_meal_consumes_one_real_lunch(self) -> None:
        main = (OVERRIDES / "mara_companion.zil").read_text(encoding="utf-8")
        actions = (OVERRIDES / "mara_companion_actions.zil").read_text(encoding="utf-8")
        self.assertIn("<SYNTAX SHARE OBJECT", main)
        self.assertIn("WITH OBJECT (FIND ACTORBIT) (IN-ROOM) = V-MARA-SHARE-MEAL>", main)
        self.assertIn("<IN? ,LUNCH ,KITCHEN-WORKTOP>", actions)
        self.assertIn("<KITCHEN-GET ,KS-LUNCH-PREPARED>", actions)
        self.assertIn("<REMOVE ,LUNCH>", actions)
        self.assertIn("<MARA-PUT ,MARA-SLOT-MEAL-SHARED 1>", actions)
        self.assertIn("no duplicate sandwich", actions)
        self.assertNotIn("<MOVE ,LUNCH", actions)

    def test_shared_meal_reserve_is_strictly_less_than_whole_meal(self) -> None:
        actions = (OVERRIDES / "mara_companion_actions.zil").read_text(encoding="utf-8")
        self.assertIn("<ROUTINE MARA-SHARED-MEAL-LEVEL", actions)
        self.assertIn("<G? .LEVEL 0> <RETURN <- .LEVEL 1>>", actions)
        self.assertIn("<SET LEVEL <MARA-SHARED-MEAL-LEVEL>>", actions)
        self.assertNotIn("<ZERO? .LEVEL> <SET LEVEL 1>", actions)

    def test_house_history_changes_dialogue_without_romance_reward(self) -> None:
        state = (OVERRIDES / "mara_companion_state.zil").read_text(encoding="utf-8")
        actor = (OVERRIDES / "mara_companion_actor.zil").read_text(encoding="utf-8")
        self.assertIn("The Dam survey is honest now", state)
        self.assertNotIn("Finish this survey honestly", state)
        self.assertIn("That is friendship with weight in the world", state)
        self.assertIn("My pack is in the Attic by consent", state)
        self.assertIn("A shared base and a shared meal are history", actor)
        self.assertIn("not permission to skip the history that has not happened yet", actor)

    def test_no_generic_companion_or_test_cheats_enter_production(self) -> None:
        production = "\n".join(
            path.read_text(encoding="utf-8") for path in sorted(OVERRIDES.glob("*.zil"))
        )
        for forbidden in (
            "MARATELEPORT",
            "MARAAPPROVAL",
            "MARAROMANCE",
            "MARAQUESTLOG",
            "MARADEBUG",
            "TODO",
            "STUB",
        ):
            self.assertNotIn(forbidden, production)


if __name__ == "__main__":
    unittest.main()
