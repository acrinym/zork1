"""Direct qualification for Release 1237 Veteran Survey Expedition."""

from __future__ import annotations

import json
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx/zork-plus-veteran-expedition"


class ZorkPlusVeteranExpeditionTests(unittest.TestCase):
    """Verify one real post-victory expedition without NG+ machinery."""

    def test_manifest_is_release_1237_over_locked_release_1236(self) -> None:
        manifest = json.loads((TRAIN / "patch-series.json").read_text())
        self.assertEqual(manifest["release"], 1237)
        self.assertEqual(manifest["base_release"], 1236)
        self.assertEqual(
            manifest["base_artifact_sha256"],
            "26b32e777be0fe6c44736ae483a594519bf98264ec95603dd4ff7238124c94d7",
        )
        self.assertEqual(
            manifest["expected_changed_paths"],
            [
                "completed_expedition_archive.zil",
                "zork1.zil",
                "zork_plus_veteran_expedition.zil",
            ],
        )

    def test_state_is_saveable_table_without_new_global(self) -> None:
        module = (TRAIN / "overrides/zork_plus_veteran_expedition.zil").read_text()
        self.assertIn(
            "<CONSTANT VETERAN-STATE <TABLE VETERAN-SCHEMA 0 0 0 0 0 0>>",
            module,
        )
        self.assertNotIn("<GLOBAL", module)
        for slot in (
            "VETERAN-SLOT-ACTIVE",
            "VETERAN-SLOT-SELECTED",
            "VETERAN-SLOT-ROUTE",
            "VETERAN-SLOT-RECORDED",
            "VETERAN-SLOT-COMPLETED",
            "VETERAN-SLOT-RETAINED",
        ):
            self.assertIn(slot, module)

    def test_unlock_requires_sealed_expedition_a_not_bare_won_flag(self) -> None:
        module = (TRAIN / "overrides/zork_plus_veteran_expedition.zil").read_text()
        unlocked = module.split("<ROUTINE VETERAN-UNLOCKED?", 1)[1].split(
            "<ROUTINE VETERAN-MATERIALIZE", 1
        )[0]
        self.assertIn("<EXPEDITION-HAS? ,ES-SEALED 1>", unlocked)
        self.assertNotIn("WON-FLAG", unlocked)
        self.assertIn("EXPEDITION-BOX-A", module)
        self.assertIn("EXPEDITION-BOX-B", module)

    def test_materialization_is_one_exact_archive_hook(self) -> None:
        patch = json.loads(
            (TRAIN / "patches/001-veteran-materialization.json").read_text()
        )
        self.assertEqual(patch["path"], "completed_expedition_archive.zil")
        self.assertEqual(len(patch["replacements"]), 1)
        self.assertEqual(patch["replacements"][0]["expected_count"], 1)
        self.assertEqual(
            patch["replacements"][0]["new"].count("<VETERAN-MATERIALIZE>"),
            1,
        )

    def test_loadout_is_exactly_lantern_or_rope(self) -> None:
        module = (TRAIN / "overrides/zork_plus_veteran_expedition.zil").read_text()
        choose = module.split("<ROUTINE V-VETERAN-CHOOSE", 1)[1].split(
            "<ROUTINE VETERAN-STOW-OTHER-GEAR", 1
        )[0]
        self.assertIn("<EQUAL? ,PRSO ,LAMP>", choose)
        self.assertIn("<EQUAL? ,PRSO ,ROPE>", choose)
        self.assertIn("<IN? ,PRSO ,WINNER>", choose)
        self.assertNotIn("TAKE EVERYTHING", module.upper())
        self.assertNotIn("LOADOUT-SLOT", module.upper())

    def test_unselected_direct_inventory_moves_to_physical_trunk(self) -> None:
        module = (TRAIN / "overrides/zork_plus_veteran_expedition.zil").read_text()
        stow = module.split("<ROUTINE VETERAN-STOW-OTHER-GEAR", 1)[1].split(
            "<ROUTINE V-VETERAN-BEGIN", 1
        )[0]
        self.assertIn("<FIRST? ,WINNER>", stow)
        self.assertIn("<NEXT? .ITEM>", stow)
        self.assertIn("<MOVE .ITEM ,VETERAN-HOLD-TRUNK>", stow)
        trunk = module.split("<OBJECT VETERAN-HOLD-TRUNK", 1)[1].split(">", 1)[0]
        self.assertIn("CONTBIT", trunk)
        self.assertIn("OPENBIT", trunk)
        self.assertIn("SEARCHBIT", trunk)

    def test_begin_is_explicit_and_preserves_first_history(self) -> None:
        module = (TRAIN / "overrides/zork_plus_veteran_expedition.zil").read_text()
        begin = module.split("<ROUTINE V-VETERAN-BEGIN", 1)[1].split(
            "<ROUTINE VETERAN-CROSS-LANTERN", 1
        )[0]
        self.assertIn("<SYNTAX BEGIN VETERAN = V-VETERAN-BEGIN>", module)
        self.assertIn("<MOVE ,WINNER ,VETERAN-TRAILHEAD>", begin)
        self.assertIn("Expedition A remains sealed behind you as a separate history", begin)
        self.assertNotIn("RESTART", begin.upper())
        self.assertNotIn("WON-FLAG", begin)

    def test_lantern_route_requires_real_lit_lantern(self) -> None:
        module = (TRAIN / "overrides/zork_plus_veteran_expedition.zil").read_text()
        route = module.split("<ROUTINE VETERAN-CROSS-LANTERN", 1)[1].split(
            "<ROUTINE VETERAN-CROSS-ROPE", 1
        )[0]
        self.assertIn("<IN? ,LAMP ,WINNER>", route)
        self.assertIn("<FSET? ,LAMP ,ONBIT>", route)
        self.assertIn("<MOVE ,WINNER ,VETERAN-OVERLOOK>", route)
        self.assertIn("<CUISINE-PUT ,CUISINE-SLOT-STRAIN 1>", route)
        self.assertNotIn("<MOVE ,LAMP", route)

    def test_rope_route_physically_secures_canonical_rope(self) -> None:
        module = (TRAIN / "overrides/zork_plus_veteran_expedition.zil").read_text()
        route = module.split("<ROUTINE VETERAN-CROSS-ROPE", 1)[1].split(
            "<ROUTINE V-VETERAN-CROSS", 1
        )[0]
        self.assertIn("<MOVE ,ROPE ,VETERAN-CUT-NEAR>", route)
        self.assertIn("<IN? ,ROPE ,VETERAN-CUT-NEAR>", route)
        self.assertNotIn("RESCUE-ROPE", module)
        self.assertNotIn("VETERAN-ROPE", module)

    def test_marker_is_recorded_not_taken_or_duplicated(self) -> None:
        module = (TRAIN / "overrides/zork_plus_veteran_expedition.zil").read_text()
        record = module.split("<ROUTINE V-VETERAN-RECORD", 1)[1].split(
            "<ROUTINE V-VETERAN-COMPLETE", 1
        )[0]
        self.assertIn("<EQUAL? ,PRSO ,VETERAN-MARKER>", record)
        self.assertIn("<VETERAN-PUT ,VETERAN-SLOT-RECORDED 1>", record)
        self.assertNotIn("<MOVE ,VETERAN-MARKER", record)
        self.assertNotIn("<REMOVE ,VETERAN-MARKER>", record)

    def test_completion_seals_separate_box_b_and_field_card(self) -> None:
        module = (TRAIN / "overrides/zork_plus_veteran_expedition.zil").read_text()
        complete = module.split("<ROUTINE V-VETERAN-COMPLETE", 1)[1].split(
            "<ROUTINE V-VETERAN-STATUS", 1
        )[0]
        self.assertIn("<EXPEDITION-CAPTURE-B>", complete)
        self.assertIn("<MOVE ,VETERAN-FIELD-CARD ,EXPEDITION-BOX-B>", complete)
        self.assertIn("<EXPEDITION-HAS? ,ES-SEALED 2>", complete)
        self.assertIn("VETERAN-SLOT-RETAINED", complete)
        self.assertNotIn("EXPEDITION-CAPTURE-A", complete)

    def test_train_contains_no_generic_ng_plus_or_duplicate_objects(self) -> None:
        module = (TRAIN / "overrides/zork_plus_veteran_expedition.zil").read_text().upper()
        for forbidden in (
            "NEW-GAME-PLUS-ENGINE",
            "MODE-REGISTRY",
            "LOADOUT-SYSTEM",
            "RESTART-MENU",
            "DUPLICATE-LAMP",
            "DUPLICATE-ROPE",
            "AUTO-SOLVE",
        ):
            self.assertNotIn(forbidden, module)

    def test_entrypoint_retains_release_1236_and_loads_zork_plus_last(self) -> None:
        entrypoint = (TRAIN / "overrides/zork1.zil").read_text()
        self.assertIn("<CONSTANT RELEASEID 1237>", entrypoint)
        self.assertIn('<INSERT-FILE "living_zork_consequences" T>', entrypoint)
        self.assertTrue(
            entrypoint.rstrip().endswith(
                '<INSERT-FILE "zork_plus_veteran_expedition" T>'
            )
        )


if __name__ == "__main__":
    unittest.main()
