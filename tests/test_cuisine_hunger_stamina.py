"""Direct qualification for Release 1235 cuisine gameplay assets."""

from __future__ import annotations

import json
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx/cuisine-hunger-stamina"


class CuisineHungerStaminaTests(unittest.TestCase):
    """Verify authored meals and bounded exertion without survival grind."""

    def test_manifest_is_release_1235_over_locked_release_1234(self) -> None:
        manifest = json.loads((TRAIN / "patch-series.json").read_text())
        self.assertEqual(manifest["release"], 1235)
        self.assertEqual(manifest["base_release"], 1234)
        self.assertEqual(
            manifest["base_artifact_sha256"],
            "38b966f47d771e0f5ae6229ff6a7542830ce6e365a3d2291f764581ae0b64a17",
        )
        self.assertEqual(
            manifest["expected_changed_paths"],
            ["cuisine_hunger_stamina.zil", "shadow_logic.zil", "zork1.zil"],
        )

    def test_state_is_saveable_table_without_new_global(self) -> None:
        module = (TRAIN / "overrides/cuisine_hunger_stamina.zil").read_text()
        self.assertIn(
            "<CONSTANT CUISINE-STATE <TABLE CUISINE-SCHEMA 0 0 0 0 0 0>>",
            module,
        )
        self.assertNotIn("<GLOBAL", module)
        for slot in (
            "CUISINE-SLOT-VERSION",
            "CUISINE-SLOT-STRAIN",
            "CUISINE-SLOT-HUNGER",
            "CUISINE-SLOT-SATIATION",
            "CUISINE-SLOT-RECIPE",
            "CUISINE-SLOT-MEALS",
            "CUISINE-SLOT-BLOCKED",
        ):
            self.assertIn(slot, module)
        self.assertNotIn("<CONSTANT CS-VERSION", module)

    def test_hunger_changes_only_after_selected_exertion(self) -> None:
        module = (TRAIN / "overrides/cuisine_hunger_stamina.zil").read_text()
        self.assertIn("<ROUTINE CUISINE-EXERTION?", module)
        self.assertIn("<VERB? CLIMB-UP CLIMB-DOWN CLIMB-FOO LEAP>", module)
        self.assertIn("<CUISINE-EXERTION?>", module)
        self.assertNotIn("CLOCKER-TICK", module)
        self.assertNotIn("EVERY-TURN-HUNGER", module)
        self.assertIn("<SHADOW-NON-TURN-COMMAND?>", module)

    def test_authored_recipe_requires_real_preparation(self) -> None:
        module = (TRAIN / "overrides/cuisine_hunger_stamina.zil").read_text()
        self.assertIn("<EQUAL? ,PRSO ,LUNCH>", module)
        self.assertIn("<EQUAL? ,PRSI ,GARLIC>", module)
        self.assertIn("<IN? ,LUNCH ,KITCHEN-WORKTOP>", module)
        self.assertIn("<KITCHEN-GET ,KS-LUNCH-PREPARED>", module)
        self.assertIn("<KITCHEN-GET ,KS-GARLIC-SLICED>", module)
        self.assertIn(
            "<CUISINE-PUT ,CUISINE-SLOT-RECIPE ,CUISINE-RECIPE-GARLIC-PEPPER>",
            module,
        )

    def test_recipe_preserves_canonical_garlic_and_lunch_until_eaten(self) -> None:
        module = (TRAIN / "overrides/cuisine_hunger_stamina.zil").read_text()
        combine = module.split("<ROUTINE V-CUISINE-COMBINE", 1)[1].split(
            "<ROUTINE CUISINE-EAT-MEAL", 1
        )[0]
        self.assertNotIn("<REMOVE ,GARLIC>", combine)
        self.assertNotIn("<MOVE ,GARLIC", combine)
        self.assertNotIn("MEAL-OBJECT", module)
        self.assertEqual(module.count("<REMOVE ,LUNCH>"), 1)

    def test_preparation_and_warmth_create_bounded_recovery_levels(self) -> None:
        module = (TRAIN / "overrides/cuisine_hunger_stamina.zil").read_text()
        self.assertIn("<ROUTINE CUISINE-MEAL-LEVEL", module)
        self.assertIn("<KITCHEN-GET ,KS-LUNCH-WARM>", module)
        self.assertIn("<RETURN 3>", module)
        self.assertIn("<RETURN 2>", module)
        self.assertIn("<RETURN 1>", module)
        self.assertIn("<CUISINE-PUT ,CUISINE-SLOT-SATIATION .LEVEL>", module)

    def test_recover_preserves_bedroom_rest_and_situational_hunger(self) -> None:
        module = (TRAIN / "overrides/cuisine_hunger_stamina.zil").read_text()
        self.assertIn("<SYNTAX RECOVER = V-CUISINE-REST>", module)
        self.assertNotIn("<SYNTAX REST = V-CUISINE-REST>", module)
        recover = module.split("<ROUTINE V-CUISINE-REST", 1)[1].split(
            "<ROUTINE V-CUISINE-STATUS", 1
        )[0]
        self.assertIn("<CUISINE-PUT ,CUISINE-SLOT-STRAIN 1>", recover)
        self.assertIn("<CUISINE-PUT ,CUISINE-SLOT-STRAIN 0>", recover)
        self.assertNotIn("<CUISINE-PUT ,CUISINE-SLOT-HUNGER 0>", recover)

    def test_appetite_status_is_interface_not_inventory(self) -> None:
        module = (TRAIN / "overrides/cuisine_hunger_stamina.zil").read_text()
        self.assertIn("<OBJECT CUISINE-BODY", module)
        self.assertIn("(IN GLOBAL-OBJECTS)", module)
        self.assertIn("(FLAGS NDESCBIT RMUNGBIT)", module)
        self.assertIn("<SYNTAX CHECK OBJECT (FIND RMUNGBIT) = V-CUISINE-STATUS>", module)
        self.assertNotIn("(IN KITCHEN)", module.split("<OBJECT CUISINE-BODY", 1)[1].split(">", 1)[0])

    def test_hooks_extend_existing_kitchen_chain_once(self) -> None:
        patch = json.loads((TRAIN / "patches/001-cuisine-hooks.json").read_text())
        self.assertEqual(patch["path"], "shadow_logic.zil")
        self.assertEqual(len(patch["replacements"]), 2)
        self.assertTrue(
            all(item["expected_count"] == 1 for item in patch["replacements"])
        )
        joined = "\n".join(item["new"] for item in patch["replacements"])
        self.assertEqual(joined.count("<CUISINE-ADVANCE>"), 1)
        self.assertEqual(joined.count("<CUISINE-ACTION-HOOK>"), 1)
        self.assertIn("<KITCHEN-ADVANCE>", joined)
        self.assertIn("<KITCHEN-ACTION-HOOK>", joined)

    def test_train_has_no_universal_crafting_or_survival_death(self) -> None:
        module = (TRAIN / "overrides/cuisine_hunger_stamina.zil").read_text().upper()
        for forbidden in (
            "CRAFTING-GRID",
            "RECIPE-DATABASE",
            "STARVATION",
            "JIGS-UP",
            "THIRST",
            "REAL-TIME",
            "EVERY TURN",
        ):
            self.assertNotIn(forbidden, module)

    def test_entrypoint_retains_release_1234_and_loads_cuisine_last(self) -> None:
        entrypoint = (TRAIN / "overrides/zork1.zil").read_text()
        self.assertIn("<CONSTANT RELEASEID 1235>", entrypoint)
        self.assertIn('<INSERT-FILE "mara_companion" T>', entrypoint)
        self.assertTrue(
            entrypoint.rstrip().endswith(
                '<INSERT-FILE "cuisine_hunger_stamina" T>'
            )
        )


if __name__ == "__main__":
    unittest.main()
