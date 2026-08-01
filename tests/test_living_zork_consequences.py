"""Direct qualification for Release 1236 Great Canyon consequences."""

from __future__ import annotations

import json
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx/living-zork-consequences"


class LivingZorkConsequencesTests(unittest.TestCase):
    """Verify one concrete fall-warning-rescue-consequence loop."""

    def test_manifest_is_release_1236_over_locked_release_1235(self) -> None:
        manifest = json.loads((TRAIN / "patch-series.json").read_text())
        self.assertEqual(manifest["release"], 1236)
        self.assertEqual(manifest["base_release"], 1235)
        self.assertEqual(
            manifest["base_artifact_sha256"],
            "14b8341c298028e7d762c59d5a5757e6a52dcafa074aa5cd63d7930079ff13cf",
        )
        self.assertEqual(
            manifest["expected_changed_paths"],
            [
                "1actions.zil",
                "1dungeon.zil",
                "living_zork_consequences.zil",
                "zork1.zil",
            ],
        )

    def test_state_is_saveable_table_without_new_global(self) -> None:
        module = (TRAIN / "overrides/living_zork_consequences.zil").read_text()
        self.assertIn(
            "<CONSTANT LIVING-CANYON-STATE <TABLE LIVING-CANYON-SCHEMA 0 0>>",
            module,
        )
        self.assertNotIn("<GLOBAL", module)
        self.assertIn("LIVING-CANYON-SLOT-WARNED", module)
        self.assertIn("LIVING-CANYON-SLOT-ROPE", module)

    def test_canyon_rim_is_a_physical_local_affordance(self) -> None:
        module = (TRAIN / "overrides/living_zork_consequences.zil").read_text()
        edge = module.split("<OBJECT LIVING-CANYON-EDGE", 1)[1].split(">", 1)[0]
        self.assertIn("(IN CANYON-VIEW)", edge)
        self.assertIn("(SYNONYM EDGE RIM DROP PRECIPICE)", edge)
        self.assertIn("(FLAGS NDESCBIT)", edge)
        self.assertNotIn("GLOBAL-OBJECTS", edge)

    def test_first_bare_leap_warns_through_world_cause(self) -> None:
        module = (TRAIN / "overrides/living_zork_consequences.zil").read_text()
        intercept = module.split("<ROUTINE LIVING-CANYON-INTERCEPT?", 1)[1]
        warning = "Your first shift of weight sends loose shale skittering over the rim."
        self.assertIn(warning, intercept)
        self.assertIn("LIVING-CANYON-SLOT-WARNED 1", intercept)
        self.assertNotIn("ARE YOU SURE", intercept.upper())
        self.assertNotIn("CONFIRM", intercept.upper())

    def test_canonical_death_stays_in_upstream_routine(self) -> None:
        module = (TRAIN / "overrides/living_zork_consequences.zil").read_text()
        patch = json.loads(
            (TRAIN / "patches/001-canyon-view-leap.json").read_text()
        )
        replacement = patch["replacements"][0]
        self.assertNotIn("Nice view, lousy place to jump.", module)
        self.assertNotIn("Nice view, lousy place to jump.", replacement["old"])
        self.assertNotIn("Nice view, lousy place to jump.", replacement["new"])
        self.assertIn("<LIVING-CANYON-INTERCEPT?>", replacement["new"])
        self.assertIn("<JIGS-UP", replacement["new"])

    def test_secure_rope_uses_canonical_object_and_physical_location(self) -> None:
        module = (TRAIN / "overrides/living_zork_consequences.zil").read_text()
        secure = module.split("<ROUTINE V-LIVING-SECURE", 1)[1].split(
            "<ROUTINE LIVING-CANYON-ROPE-HOOK", 1
        )[0]
        self.assertIn("<EQUAL? ,PRSO ,ROPE>", secure)
        self.assertIn("<IN? ,ROPE ,WINNER>", secure)
        self.assertIn("<MOVE ,ROPE ,CANYON-VIEW>", secure)
        self.assertNotIn("RESCUE-ROPE", module)
        self.assertNotIn("SAFETY-ROPE", module)

    def test_prepared_leap_requires_rope_at_canyon(self) -> None:
        module = (TRAIN / "overrides/living_zork_consequences.zil").read_text()
        intercept = module.split("<ROUTINE LIVING-CANYON-INTERCEPT?", 1)[1]
        self.assertIn("<LIVING-CANYON-GET ,LIVING-CANYON-SLOT-ROPE>", intercept)
        self.assertIn("<IN? ,ROPE ,CANYON-VIEW>", intercept)
        self.assertIn("the prepared rope snaps taut", intercept)

    def test_near_fall_reuses_bounded_cuisine_strain(self) -> None:
        module = (TRAIN / "overrides/living_zork_consequences.zil").read_text()
        intercept = module.split("<ROUTINE LIVING-CANYON-INTERCEPT?", 1)[1]
        self.assertIn("<CUISINE-ENSURE>", intercept)
        self.assertIn("<CUISINE-GET ,CUISINE-SLOT-STRAIN>", intercept)
        self.assertIn("<CUISINE-PUT ,CUISINE-SLOT-STRAIN 1>", intercept)
        self.assertNotIn("INJURY", module.upper())
        self.assertNotIn("LIVING-STAMINA", module)

    def test_taking_rope_removes_protection_without_replacing_take(self) -> None:
        module = (TRAIN / "overrides/living_zork_consequences.zil").read_text()
        hook = module.split("<ROUTINE LIVING-CANYON-ROPE-HOOK", 1)[1].split(
            "<ROUTINE LIVING-CANYON-INTERCEPT?", 1
        )[0]
        self.assertIn("<VERB? TAKE>", hook)
        self.assertIn("<LIVING-CANYON-PUT ,LIVING-CANYON-SLOT-ROPE 0>", hook)
        self.assertIn("<RFALSE>", hook)
        self.assertNotIn("<MOVE ,ROPE ,WINNER>", hook)

    def test_patches_are_exact_single_integration_points(self) -> None:
        canyon = json.loads(
            (TRAIN / "patches/001-canyon-view-leap.json").read_text()
        )
        rope = json.loads(
            (TRAIN / "patches/002-canyon-rope-custody.json").read_text()
        )
        self.assertEqual(canyon["path"], "1dungeon.zil")
        self.assertEqual(rope["path"], "1actions.zil")
        self.assertEqual(canyon["replacements"][0]["expected_count"], 1)
        self.assertEqual(rope["replacements"][0]["expected_count"], 1)
        self.assertEqual(
            canyon["replacements"][0]["new"].count(
                "<LIVING-CANYON-INTERCEPT?>"
            ),
            1,
        )
        self.assertEqual(
            rope["replacements"][0]["new"].count("<LIVING-CANYON-ROPE-HOOK>"),
            1,
        )

    def test_train_contains_no_generic_hazard_machinery(self) -> None:
        module = (TRAIN / "overrides/living_zork_consequences.zil").read_text().upper()
        for forbidden in (
            "HAZARD-ENGINE",
            "HAZARD-REGISTRY",
            "RANDOM-DEATH",
            "RESCUE-CHANCE",
            "INJURY-METER",
            "PARALLEL-WORLD",
        ):
            self.assertNotIn(forbidden, module)

    def test_entrypoint_retains_release_1235_and_loads_consequences_last(self) -> None:
        entrypoint = (TRAIN / "overrides/zork1.zil").read_text()
        self.assertIn("<CONSTANT RELEASEID 1236>", entrypoint)
        self.assertIn('<INSERT-FILE "cuisine_hunger_stamina" T>', entrypoint)
        self.assertTrue(
            entrypoint.rstrip().endswith(
                '<INSERT-FILE "living_zork_consequences" T>'
            )
        )


if __name__ == "__main__":
    unittest.main()
