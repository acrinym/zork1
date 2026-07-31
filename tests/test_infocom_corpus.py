from __future__ import annotations

import copy
import json
from pathlib import Path
import tempfile
import unittest

from tools.infocom_corpus.core import (
    CorpusError,
    annotate_records,
    build_style_receipt,
    check_overlap,
    derive_profiles,
    extract_player_visible_strings,
    fingerprint_local_artifact,
    load_profiles,
    validate_correction_records,
    validate_manifest,
)


ROOT = Path(__file__).resolve().parents[1]
MANIFEST_PATH = ROOT / "reference/infocom-corpus/manifest/infocom-corpus.json"
PROFILES_PATH = ROOT / "reference/infocom-corpus/profiles/authority-profiles.json"


class ManifestTests(unittest.TestCase):
    def setUp(self) -> None:
        self.manifest = json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))

    def test_manifest_is_rights_complete(self) -> None:
        summary = validate_manifest(self.manifest)
        self.assertEqual(summary["artifact_count"], 13)
        self.assertEqual(summary["selected_game_source"], "infocom-zork1-source-shutdown-snapshot")
        self.assertEqual(summary["full_text_artifact_count"], 0)

    def test_protected_artifact_cannot_enable_full_text(self) -> None:
        unsafe = copy.deepcopy(self.manifest)
        artifact = unsafe["artifacts"][1]
        artifact["rights"]["full_text_allowed"] = True
        artifact["rights"]["repository_text_policy"] = "full-text-verified"
        artifact["rights"]["verification"] = "verified-for-this-repository"
        with self.assertRaises(CorpusError):
            validate_manifest(unsafe)


class ExtractionTests(unittest.TestCase):
    def test_recursive_case_insensitive_include_and_surface_classification(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            repo = Path(temp)
            (repo / "zork1.zil").write_text(
                '"build header only"\n'
                '<PRINC "compiler banner">\n'
                '<INSERT-FILE "ROOMS" T>\n'
                '<ROUTINE V-TAKE () <TELL "You take the object." CR>>\n',
                encoding="utf-8",
            )
            (repo / "rooms.ZIL").write_text(
                '<ROOM WEST-OF-HOUSE\n'
                ' (DESC "West of House")\n'
                ' (LDESC "You are standing in an open field west of a white house.")>\n'
                '<OBJECT LAMP (DESC "brass lantern")\n'
                ' (FDESC "A battery-powered brass lantern is on the ground.")>\n',
                encoding="utf-8",
            )
            records, summary = extract_player_visible_strings(
                repo, "zork1.zil", "infocom-zork1-source-shutdown-snapshot"
            )
            texts = [record["text"] for record in records]
            self.assertNotIn("build header only", texts)
            self.assertNotIn("compiler banner", texts)
            self.assertIn("West of House", texts)
            self.assertIn("You take the object.", texts)
            self.assertEqual(summary["source_file_count"], 2)
            surfaces = {record["text"]: record["surface"] for record in records}
            self.assertEqual(surfaces["West of House"], "room-title")
            self.assertEqual(
                surfaces["You are standing in an open field west of a white house."],
                "room-description",
            )
            self.assertEqual(surfaces["brass lantern"], "object-name")
            self.assertEqual(
                surfaces["A battery-powered brass lantern is on the ground."],
                "object-description",
            )

    def test_annotations_are_traceable_and_non_destructive(self) -> None:
        records = [{
            "record_id": "r1",
            "surface": "parser-refusal",
            "text": "You cannot do that because the door is locked.",
            "text_sha256": "0" * 64,
        }]
        annotated = annotate_records(records)
        self.assertEqual(annotated[0]["text"], records[0]["text"])
        features = annotated[0]["annotation"]
        self.assertTrue(features["second_person_present"])
        self.assertIn("impossible-action", features["parser_behavior"])
        self.assertIn("physical-obstruction", features["parser_behavior"])


class OriginalityTests(unittest.TestCase):
    def setUp(self) -> None:
        self.records = [
            {
                "record_id": "source:1",
                "text": "The narrow passage bends sharply before a silent iron door.",
                "text_sha256": "1" * 64,
                "surface": "room-description",
                "authority_profile": "zork1-narrator",
            },
            {
                "record_id": "source:2",
                "text": "A brass lamp rests beside the coiled rope.",
                "text_sha256": "2" * 64,
                "surface": "object-description",
                "authority_profile": "zork1-object-description",
            },
        ]

    def test_long_phrase_overlap_blocks_without_disclosing_source(self) -> None:
        result = check_overlap(
            "Beyond the arch, the narrow passage bends sharply before a silent iron door.",
            self.records,
            max_allowed_tokens=6,
            rare_ngram_tokens=5,
        )
        self.assertFalse(result["passed"])
        self.assertGreater(result["longest_overlap"]["tokens"], 6)
        self.assertFalse(result["source_text_disclosed"])
        self.assertNotIn("text", result["longest_overlap"])

    def test_original_candidate_can_receive_style_receipt(self) -> None:
        candidate = "A soot-dark hinge complains once, then settles."
        overlap = check_overlap(candidate, self.records)
        self.assertTrue(overlap["passed"])
        profiles = load_profiles(PROFILES_PATH)
        receipt = build_style_receipt(
            surface_family="test-room-description",
            candidate_path="candidate.txt",
            candidate_text=candidate,
            profile=profiles["zork1-narrator"],
            overlap=overlap,
            corpus_digest="a" * 64,
            intentional_departures=["Test fixture only."],
            reviewer="unit-test",
        )
        self.assertEqual(receipt["authority_profile"], "zork1-narrator")
        self.assertTrue(receipt["originality_check"]["passed"])
        self.assertTrue(receipt["excluded_voices"])

    def test_profile_output_contains_no_source_prose(self) -> None:
        annotated = annotate_records(self.records)
        profiles = load_profiles(PROFILES_PATH)
        output = derive_profiles(annotated, profiles, "b" * 64)
        serialized = json.dumps(output)
        self.assertFalse(output["contains_source_prose"])
        self.assertNotIn("narrow passage bends", serialized)
        narrator = next(
            profile for profile in output["profiles"]
            if profile["profile_id"] == "zork1-narrator"
        )
        self.assertIsNotNone(narrator["derived_statistics"])


class ProtectedStudyCopyTests(unittest.TestCase):
    def setUp(self) -> None:
        self.manifest = json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))

    def test_fingerprint_contains_hash_not_file_content(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            source = Path(temp) / "manual.pdf"
            source.write_bytes(b"protected test bytes")
            record = fingerprint_local_artifact(
                source,
                "infocom-zork1-greybox-manual-en-us",
                page_count=12,
                page_references=["p. 7"],
            )
            serialized = json.dumps(record)
            self.assertTrue(record["safe_to_commit"])
            self.assertFalse(record["contains_source_text"])
            self.assertNotIn("protected test bytes", serialized)

    def test_protected_correction_must_be_hash_only(self) -> None:
        valid = [{
            "correction_id": "greybox-p7-b3",
            "artifact_id": "infocom-zork1-greybox-manual-en-us",
            "location": {"page": 7, "block_id": "body-3"},
            "observed_sha256": "a" * 64,
            "corrected_sha256": "b" * 64,
            "reason": "OCR character substitution confirmed against the page image.",
            "confidence": "certain",
        }]
        summary = validate_correction_records(valid, self.manifest)
        self.assertEqual(summary["correction_count"], 1)

        unsafe = copy.deepcopy(valid)
        unsafe[0]["corrected_text"] = "Protected source wording"
        with self.assertRaises(CorpusError):
            validate_correction_records(unsafe, self.manifest)


if __name__ == "__main__":
    unittest.main()
