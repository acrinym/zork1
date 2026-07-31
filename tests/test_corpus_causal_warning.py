"""Direct qualification for Release 1231 corpus-coupled gameplay assets."""

from __future__ import annotations

from hashlib import sha256
import json
from pathlib import Path
import re
import unittest


ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx/corpus-causal-warning"


class CorpusCausalWarningTests(unittest.TestCase):
    """Check product contracts without introducing a meta-audit framework."""

    def test_manifest_is_release_1231_over_locked_release_1230(self) -> None:
        manifest = json.loads((TRAIN / "patch-series.json").read_text())
        self.assertEqual(manifest["release"], 1231)
        self.assertEqual(manifest["base_release"], 1230)
        self.assertEqual(
            manifest["base_artifact_sha256"],
            "b446e12ebffc570c0058347583bacc768f6a51f5f5166634da91898004d68c71",
        )
        self.assertEqual(
            manifest["expected_changed_paths"],
            ["1actions.zil", "corpus_causal_warning.zil", "zork1.zil"],
        )

    def test_module_uses_canonical_flood_authorities(self) -> None:
        module = (TRAIN / "overrides/corpus_causal_warning.zil").read_text()
        self.assertNotIn("<GLOBAL WATER-LEVEL", module)
        self.assertNotIn("<GLOBAL MAINT-FLOOD-", module)
        self.assertNotIn("<ROUTINE I-MAINT-ROOM", module)
        self.assertNotIn("<OBJECT LEAK", module)
        self.assertNotIn("<QUEUE CORPUS", module)
        for token in (
            ",WATER-LEVEL",
            "<JIGS-UP",
            "CORPUS-MAINT-FLOOD-START",
            "CORPUS-MAINT-FLOOD-TICK",
            "CORPUS-MAINT-FLOOD-EXAMINE",
            "CORPUS-MAINT-FLOOD-DROWN",
            "CORPUS-MAINT-FLOOD-REPAIRED",
        ):
            self.assertIn(token, module)

    def test_warning_chain_uses_exact_canonical_crossings(self) -> None:
        module = (TRAIN / "overrides/corpus_causal_warning.zil").read_text()
        self.assertNotIn("<SETG MAINT-FLOOD-", module)
        self.assertEqual(module.count("<EQUAL? ,WATER-LEVEL 3>"), 1)
        self.assertEqual(module.count("<EQUAL? ,WATER-LEVEL 5>"), 1)
        self.assertEqual(module.count("<EQUAL? ,WATER-LEVEL 11>"), 1)

    def test_patch_couples_only_existing_canonical_hooks(self) -> None:
        patch = json.loads(
            (TRAIN / "patches/001-maintenance-flood-coupling.json").read_text()
        )
        self.assertEqual(patch["path"], "1actions.zil")
        self.assertEqual(len(patch["replacements"]), 5)
        self.assertTrue(all(item["expected_count"] == 1 for item in patch["replacements"]))
        joined = "\n".join(item["new"] for item in patch["replacements"])
        for canonical in (
            "WATER-LEVEL",
            "I-MAINT-ROOM",
            "LEAK-FUNCTION",
            "FIX-MAINT-LEAK",
            "PUTTY",
        ):
            self.assertIn(canonical, joined)
        self.assertNotIn("AUTO-ESCAPE", joined)
        self.assertNotIn("AUTO-REPAIR", joined)

    def test_candidate_prose_and_style_receipts_match_module(self) -> None:
        module = (TRAIN / "overrides/corpus_causal_warning.zil").read_text()
        normalized_module = re.sub(r"\s+", " ", module)
        evidence = json.loads(
            (TRAIN / "qualification/corpus-evidence.json").read_text()
        )
        source_receipt = evidence["source_corpus_receipt"]
        digest = source_receipt["corpus_digest"]
        self.assertFalse(source_receipt["contains_source_text"])
        self.assertEqual(source_receipt["record_count"], 10)
        for record in source_receipt["record_receipts"]:
            self.assertNotIn("text", record)

        self.assertEqual(
            set(evidence["candidates"]),
            set(evidence["overlap_results"]),
        )
        self.assertEqual(
            set(evidence["candidates"]),
            set(evidence["style_receipts"]),
        )
        for candidate_id, text in evidence["candidates"].items():
            for paragraph in text.splitlines():
                if paragraph.strip():
                    self.assertIn(
                        re.sub(r"\s+", " ", paragraph.strip()),
                        normalized_module,
                    )
            receipt = evidence["style_receipts"][candidate_id]
            overlap = evidence["overlap_results"][candidate_id]
            expected_hash = sha256(text.encode("utf-8")).hexdigest()
            expected_words = len(text.split())
            self.assertEqual(receipt["candidate"]["sha256"], expected_hash)
            self.assertEqual(receipt["candidate"]["word_count"], expected_words)
            self.assertEqual(overlap["candidate_word_count"], expected_words)
            self.assertEqual(receipt["originality_check"]["corpus_digest"], digest)
            self.assertEqual(overlap["corpus_digest"], digest)
            self.assertTrue(receipt["originality_check"]["passed"])
            self.assertTrue(overlap["passed"])
            self.assertEqual(
                receipt["originality_check"]["threshold_violation_count"], 0
            )
            self.assertEqual(
                receipt["originality_check"]["rare_phrase_match_count"], 0
            )
            self.assertFalse(
                receipt["originality_check"]["source_text_disclosed"]
            )
            self.assertTrue(receipt["intentional_departures"])
            self.assertTrue(receipt["primary_authorities"])
            self.assertTrue(receipt["excluded_voices"])

    def test_release_entrypoint_retains_1230_and_loads_new_module_last(self) -> None:
        entrypoint = (TRAIN / "overrides/zork1.zil").read_text()
        self.assertIn("<CONSTANT RELEASEID 1231>", entrypoint)
        self.assertIn(
            '<INSERT-FILE "completed_expedition_archive" T>', entrypoint
        )
        self.assertTrue(
            entrypoint.rstrip().endswith(
                '<INSERT-FILE "corpus_causal_warning" T>'
            )
        )

    def test_product_kanban_has_operational_lanes_and_proof(self) -> None:
        board = json.loads((ROOT / "docs/planning/product-kanban.json").read_text())
        self.assertEqual(
            set(board["lanes"]),
            {"current", "next", "future", "parked", "done"},
        )
        self.assertEqual(len(board["lanes"]["current"]), 1)
        for lane, cards in board["lanes"].items():
            for card in cards:
                for key in (
                    "train_id",
                    "outcome",
                    "scope",
                    "acceptance",
                    "boundaries",
                ):
                    self.assertTrue(
                        card.get(key),
                        f"{lane}:{card.get('train_id')}:{key}",
                    )
        done = {
            card["train_id"]: card for card in board["lanes"]["done"]
        }
        self.assertIn("zork-house-of-records-1230", done)
        self.assertIn("zork-infocom-corpus-foundation", done)
        completed = done["zork-corpus-causal-warning-1231"]
        self.assertEqual(completed["status"], "done")
        self.assertEqual(completed["pr"], 34)
        self.assertTrue(completed["proof"])
        self.assertTrue(
            any(
                "5daaa7307ef496a3ae37209a6e79e149c9dc3d202f148f143bbb571fa74b3609"
                in proof
                for proof in completed["proof"]
            )
        )


if __name__ == "__main__":
    unittest.main()
