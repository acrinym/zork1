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
    corpus_digest,
    derive_profiles,
    extract_player_visible_strings,
    fingerprint_local_artifact,
    load_profiles,
    public_summary_from_records,
    validate_correction_records,
    validate_manifest,
)


ROOT = Path(__file__).resolve().parents[1]
MANIFEST_PATH = ROOT / "reference/infocom-corpus/manifest/infocom-corpus.json"
PROFILES_PATH = ROOT / "reference/infocom-corpus/profiles/authority-profiles.json"
SCHEMA_ROOT = ROOT / "reference/infocom-corpus/schemas"


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

    def test_authority_order_rejects_unhashable_or_empty_entries(self) -> None:
        for invalid in ({"tier": 1}, ""):
            unsafe = copy.deepcopy(self.manifest)
            unsafe["authority_order"][0] = invalid
            with self.subTest(invalid=invalid), self.assertRaises(CorpusError):
                validate_manifest(unsafe)


class SchemaContractTests(unittest.TestCase):
    def _schema(self, name: str) -> dict:
        return json.loads((SCHEMA_ROOT / name).read_text(encoding="utf-8"))

    def test_artifact_schema_enforces_all_full_text_rights_gates(self) -> None:
        rights = self._schema("artifact.schema.json")["properties"]["rights"]
        then = rights["allOf"][0]["then"]["properties"]
        self.assertEqual(then["class"]["enum"], ["A", "D"])
        self.assertEqual(then["verification"]["const"], "verified-for-this-repository")
        self.assertEqual(then["repository_text_policy"]["const"], "full-text-verified")

    def test_correction_schema_requires_a_non_null_locator(self) -> None:
        location = self._schema("correction-record.schema.json")["properties"]["location"]
        self.assertEqual(len(location["anyOf"]), 4)
        for branch in location["anyOf"]:
            key = branch["required"][0]
            self.assertNotIn("null", branch["properties"][key].get("type", []))

    def test_receipt_schema_requires_departure_digest_and_zero_violations(self) -> None:
        schema = self._schema("style-receipt.schema.json")
        self.assertEqual(schema["properties"]["intentional_departures"]["minItems"], 1)
        originality = schema["properties"]["originality_check"]
        self.assertEqual(originality["properties"]["corpus_digest"]["pattern"], "^[0-9a-f]{64}$")
        self.assertEqual(originality["properties"]["threshold_violation_count"]["const"], 0)

    def test_record_schema_declares_real_utf8_byte_offsets(self) -> None:
        source = self._schema("corpus-record.schema.json")["properties"]["source"]["properties"]
        self.assertIn("UTF-8 byte offset", source["byte_offset_start"]["description"])
        self.assertIn("UTF-8 byte offset", source["byte_offset_end"]["description"])


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

    def test_escaped_backslash_before_closing_quote_is_terminated(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            repo = Path(temp)
            (repo / "zork1.zil").write_text(
                '<ROUTINE V-PATH () <TELL "Path ends with \\\\" CR>>\n',
                encoding="utf-8",
            )
            records, _ = extract_player_visible_strings(repo, "zork1.zil", "fixture")
            self.assertEqual(records[0]["text"], "Path ends with \\")

    def test_offsets_are_utf8_bytes_not_character_indices(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            repo = Path(temp)
            raw = '; café\n<ROUTINE V-SEE () <TELL "Visible text." CR>>\n'.encode("utf-8")
            (repo / "zork1.zil").write_bytes(raw)
            records, _ = extract_player_visible_strings(repo, "zork1.zil", "fixture")
            source = records[0]["source"]
            self.assertEqual(source["byte_offset_start"], raw.index(b'"Visible text."'))
            self.assertEqual(source["byte_offset_end"], raw.index(b'"Visible text."') + len(b'"Visible text."'))

    def test_invalid_utf8_source_raises_corpus_error(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            repo = Path(temp)
            (repo / "zork1.zil").write_bytes(b'<TELL "bad \xff text">')
            with self.assertRaisesRegex(CorpusError, "not valid UTF-8"):
                extract_player_visible_strings(repo, "zork1.zil", "fixture")

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

    def test_incomplete_reused_annotation_is_rebuilt(self) -> None:
        profiles = load_profiles(PROFILES_PATH)
        record = {
            "record_id": "r1",
            "surface": "room-description",
            "text": "You stand beside a cold iron gate.",
            "text_sha256": "0" * 64,
            "authority_profile": "zork1-narrator",
            "annotation": {"word_count": 999},
        }
        output = derive_profiles([record], profiles, "b" * 64)
        narrator = next(item for item in output["profiles"] if item["profile_id"] == "zork1-narrator")
        self.assertNotEqual(narrator["derived_statistics"]["word_count"], 999)


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
        self.assertTrue(result["threshold_violations"])
        self.assertFalse(result["source_text_disclosed"])
        self.assertNotIn("text", result["longest_overlap"])

    def test_allowed_longest_match_does_not_hide_other_violation(self) -> None:
        records = [
            {
                "record_id": "allowed",
                "text": "one two three four five six seven eight",
                "text_sha256": "1" * 64,
            },
            {
                "record_id": "blocked",
                "text": "nine ten eleven twelve thirteen fourteen fifteen",
                "text_sha256": "2" * 64,
            },
        ]
        candidate = (
            "one two three four five six seven eight meanwhile "
            "nine ten eleven twelve thirteen fourteen fifteen"
        )
        result = check_overlap(
            candidate,
            records,
            max_allowed_tokens=6,
            rare_ngram_tokens=5,
            allowed_phrases=["one two three four five six seven eight"],
        )
        self.assertFalse(result["passed"])
        self.assertTrue(result["longest_overlap"]["allowed_exact_phrase"])
        self.assertEqual(
            {item["source_record_id"] for item in result["threshold_violations"]},
            {"blocked"},
        )

    def test_tied_threshold_violations_are_all_retained(self) -> None:
        records = [
            {"record_id": "a", "text": "red blue green black white gold silver", "text_sha256": "1" * 64},
            {"record_id": "b", "text": "cat dog bird fish horse sheep goat", "text_sha256": "2" * 64},
        ]
        result = check_overlap(
            "red blue green black white gold silver then cat dog bird fish horse sheep goat",
            records,
            max_allowed_tokens=6,
            rare_ngram_tokens=5,
        )
        self.assertEqual(len(result["threshold_violations"]), 2)

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
        self.assertEqual(receipt["originality_check"]["threshold_violation_count"], 0)
        self.assertTrue(receipt["excluded_voices"])

    def test_receipt_requires_departure_and_valid_corpus_digest(self) -> None:
        candidate = "A soot-dark hinge complains once, then settles."
        overlap = check_overlap(candidate, self.records)
        profile = load_profiles(PROFILES_PATH)["zork1-narrator"]
        for digest, departures in (("not-a-hash", ["Reason"]), ("a" * 64, [])):
            with self.subTest(digest=digest, departures=departures), self.assertRaises(CorpusError):
                build_style_receipt(
                    surface_family="test-room-description",
                    candidate_path="candidate.txt",
                    candidate_text=candidate,
                    profile=profile,
                    overlap=overlap,
                    corpus_digest=digest,
                    intentional_departures=departures,
                    reviewer="unit-test",
                )

    def test_profile_output_contains_no_source_prose(self) -> None:
        annotated = annotate_records(self.records)
        profiles = load_profiles(PROFILES_PATH)
        output = derive_profiles(annotated, profiles, "b" * 64)
        serialized = json.dumps(output)
        self.assertFalse(output["contains_source_prose"])
        for record in self.records:
            self.assertNotIn(record["text"], serialized)
        narrator = next(
            profile for profile in output["profiles"]
            if profile["profile_id"] == "zork1-narrator"
        )
        self.assertIsNotNone(narrator["derived_statistics"])

    def test_extraction_and_public_summary_share_one_digest_definition(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            repo = Path(temp)
            (repo / "zork1.zil").write_text(
                '<ROUTINE V-SEE () <TELL "A new sentence appears." CR>>\n',
                encoding="utf-8",
            )
            records, extraction = extract_player_visible_strings(repo, "zork1.zil", "fixture")
            public = public_summary_from_records(records, artifact_id="fixture", source_files=[])
            self.assertEqual(extraction["corpus_digest"], public["corpus_digest"])
            self.assertEqual(extraction["corpus_digest"], corpus_digest(records))


class ProtectedStudyCopyTests(unittest.TestCase):
    def setUp(self) -> None:
        self.manifest = json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))

    def test_fingerprint_contains_hash_not_file_content(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            repo = Path(temp)
            source = repo / ".local/infocom-corpus/manual.pdf"
            source.parent.mkdir(parents=True)
            source.write_bytes(b"protected test bytes")
            record = fingerprint_local_artifact(
                source,
                "infocom-zork1-greybox-manual-en-us",
                repo_root=repo,
                page_count=12,
                page_references=["p. 7"],
            )
            serialized = json.dumps(record)
            self.assertTrue(record["safe_to_commit"])
            self.assertFalse(record["contains_source_text"])
            self.assertNotIn("protected test bytes", serialized)

    def test_fingerprint_rejects_outside_path_and_quoted_reference(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            repo = Path(temp)
            outside = repo / "manual.pdf"
            outside.write_bytes(b"protected")
            with self.assertRaisesRegex(CorpusError, "must remain below"):
                fingerprint_local_artifact(outside, "manual", repo_root=repo)

            inside = repo / ".local/infocom-corpus/manual.pdf"
            inside.parent.mkdir(parents=True)
            inside.write_bytes(b"protected")
            with self.assertRaisesRegex(CorpusError, "structural locator"):
                fingerprint_local_artifact(
                    inside,
                    "manual",
                    repo_root=repo,
                    page_references=['p. 7: "quoted source wording"'],
                )

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

    def test_correction_requires_concrete_typed_locator(self) -> None:
        base = {
            "correction_id": "greybox-location",
            "artifact_id": "infocom-zork1-greybox-manual-en-us",
            "location": {},
            "observed_sha256": "a" * 64,
            "corrected_sha256": "b" * 64,
            "reason": "Test",
            "confidence": "certain",
        }
        for location in ({}, {"page": None}, {"surface": ""}, {"line": 0}):
            record = copy.deepcopy(base)
            record["location"] = location
            with self.subTest(location=location), self.assertRaises(CorpusError):
                validate_correction_records([record], self.manifest)


if __name__ == "__main__":
    unittest.main()
