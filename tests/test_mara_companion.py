"""Direct qualification for Release 1234 Mara gameplay assets."""

from __future__ import annotations

import json
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx/mara-companion"


class MaraCompanionTests(unittest.TestCase):
    """Verify Mara is a specific actor with bounded witnessed memory."""

    def test_manifest_is_release_1234_over_locked_release_1233(self) -> None:
        manifest = json.loads((TRAIN / "patch-series.json").read_text())
        self.assertEqual(manifest["release"], 1234)
        self.assertEqual(manifest["base_release"], 1233)
        self.assertEqual(
            manifest["base_artifact_sha256"],
            "4ac789f379231cbc7a871f6d092f824f8098607ee60239936f57aa39585c5244",
        )
        self.assertEqual(
            manifest["expected_changed_paths"],
            [
                "mara_companion.zil",
                "museum_intake_first_gallery.zil",
                "zork1.zil",
            ],
        )
        artifact = manifest["expected_artifact"]
        self.assertTrue(artifact["locked"])
        self.assertEqual(artifact["size_bytes"], 339712)
        self.assertEqual(artifact["checksum_hex"], "0x69fd7910")
        self.assertEqual(
            artifact["sha256"],
            "38b966f47d771e0f5ae6229ff6a7542830ce6e365a3d2291f764581ae0b64a17",
        )

    def test_mara_is_a_visible_physical_living_room_actor(self) -> None:
        module = (TRAIN / "overrides/mara_companion.zil").read_text()
        self.assertIn("<OBJECT MARA", module)
        self.assertIn("(IN LIVING-ROOM)", module)
        self.assertIn("(FLAGS ACTORBIT TRYTAKEBIT)", module)
        self.assertIn("(LDESC \"Mara sits near the museum displays", module)
        self.assertNotIn("NDESCBIT", module)

    def test_memory_uses_saveable_table_without_a_new_global(self) -> None:
        module = (TRAIN / "overrides/mara_companion.zil").read_text()
        self.assertIn(
            "<CONSTANT MARA-STATE <TABLE MARA-SCHEMA 0 0 0>>", module
        )
        for slot in (
            "MARA-SLOT-MET",
            "MARA-SLOT-TRUST",
            "MARA-SLOT-LAST-EVIDENCE",
        ):
            self.assertIn(slot, module)
        self.assertNotIn("<GLOBAL", module)

    def test_show_command_is_bounded_to_held_evidence_and_actor(self) -> None:
        module = (TRAIN / "overrides/mara_companion.zil").read_text()
        self.assertIn(
            "<SYNTAX SHOW OBJECT (HELD CARRIED HAVE) TO OBJECT (FIND ACTORBIT) (IN-ROOM)",
            module,
        )
        self.assertIn("= V-MARA-SHOW>", module)
        self.assertIn("<SYNONYM SHOW PRESENT>", module)
        self.assertNotIn("FOLLOW", module)
        self.assertNotIn("COMPANION COMMAND", module)

    def test_showing_evidence_records_the_real_object_without_moving_it(self) -> None:
        module = (TRAIN / "overrides/mara_companion.zil").read_text()
        self.assertIn(
            "<MARA-PUT ,MARA-SLOT-LAST-EVIDENCE ,PRSO>", module
        )
        self.assertIn("<MUSEUM-PROVENANCE ,PRSO>", module)
        self.assertNotIn("<MOVE ,PRSO", module)
        self.assertNotIn("<REMOVE ,PRSO", module)
        self.assertNotIn("MARA-EVIDENCE-OBJECT", module)

    def test_mara_only_claims_knowledge_she_has_witnessed(self) -> None:
        module = (TRAIN / "overrides/mara_companion.zil").read_text()
        self.assertIn(
            "<EQUAL? .TOPIC <MARA-GET ,MARA-SLOT-LAST-EVIDENCE>>", module
        )
        self.assertIn("Mara cannot honestly claim that history yet", module)
        self.assertIn("Show her the evidence first", module)
        self.assertIn("<MUSEUM-PROVENANCE .TOPIC>", module)

    def test_existing_talk_and_ask_route_through_actor_action(self) -> None:
        module = (TRAIN / "overrides/mara_companion.zil").read_text()
        self.assertIn("<VERB? TELL>", module)
        self.assertIn("<MARA-MEET>", module)
        self.assertIn("<MARA-ABOUT ,PRSI>", module)
        self.assertNotIn("<SYNTAX TALK", module)
        self.assertNotIn("<SYNTAX ASK", module)

    def test_museum_specific_classes_precede_generic_treasure(self) -> None:
        museum = (
            TRAIN / "overrides/museum_intake_first_gallery.zil"
        ).read_text()
        frame = museum.index("<MUSEUM-ACCEPTS? ,MUSEUM-FRAME .OBJ>")
        weapon = museum.index("<MUSEUM-ACCEPTS? ,MUSEUM-WEAPON-WALL .OBJ>")
        records = museum.index("<MUSEUM-ACCEPTS? ,MUSEUM-RECORD-SHELF .OBJ>")
        treasure = museum.index("<G? <GETP .OBJ ,P?TVALUE> 0>")
        relic = museum.index("<MUSEUM-ACCEPTS? ,MUSEUM-RELIC-STAND .OBJ>")
        self.assertLess(frame, weapon)
        self.assertLess(weapon, records)
        self.assertLess(records, treasure)
        self.assertLess(treasure, relic)
        self.assertEqual(museum.count("<RETURN ,MUSEUM-WEAPON-WALL>"), 1)
        self.assertEqual(museum.count("<RETURN ,TROPHY-CASE>"), 1)

    def test_train_does_not_create_generic_companion_machinery(self) -> None:
        module = (TRAIN / "overrides/mara_companion.zil").read_text().upper()
        for forbidden in (
            "CHATBOT",
            "DIALOGUE-GENERATOR",
            "FOLLOWER-ENGINE",
            "NPC-FRAMEWORK",
            "BANTER",
        ):
            self.assertNotIn(forbidden, module)

    def test_entrypoint_retains_release_1233_and_loads_mara_last(self) -> None:
        entrypoint = (TRAIN / "overrides/zork1.zil").read_text()
        self.assertIn("<CONSTANT RELEASEID 1234>", entrypoint)
        self.assertIn('<INSERT-FILE "museum_intake_first_gallery" T>', entrypoint)
        self.assertTrue(
            entrypoint.rstrip().endswith('<INSERT-FILE "mara_companion" T>')
        )


if __name__ == "__main__":
    unittest.main()
