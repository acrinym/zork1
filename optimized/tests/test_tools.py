from __future__ import annotations

import shutil
import sys
import tempfile
import unittest
from pathlib import Path


OPTIMIZED_ROOT = Path(__file__).resolve().parents[1]
REPO_ROOT = OPTIMIZED_ROOT.parent
sys.path.insert(0, str(OPTIMIZED_ROOT / "tools"))

import build_story  # noqa: E402
import stage_source  # noqa: E402
import verify_story  # noqa: E402
import zil_smell_check  # noqa: E402


PATCH_TARGETS = ("gverbs.zil", "1dungeon.zil", "1actions.zil")


def copy_patch_targets(destination: Path) -> None:
    for name in PATCH_TARGETS:
        shutil.copy2(REPO_ROOT / name, destination / name)


class ZilCommentTests(unittest.TestCase):
    def test_semicolon_suppresses_complete_multiline_form(self) -> None:
        source = """<ROUTINE LIVE () <RTRUE>>
;<ROUTINE DEAD ()
  <COND (<1? 1> <RTRUE>)
        (T <RFALSE>)>>
<GLOBAL SURVIVES 1>
"""
        cleaned = zil_smell_check.strip_strings_and_comments(source)
        self.assertIn("LIVE", cleaned)
        self.assertIn("SURVIVES", cleaned)
        self.assertNotIn("DEAD", cleaned)
        self.assertEqual([], zil_smell_check.structural_balance(Path("sample.zil"), source))

    def test_semicolon_suppresses_multiline_string_object(self) -> None:
        source = ''';"historical note with fake <FORM
and another > line"
<GLOBAL REAL 1>
'''
        cleaned = zil_smell_check.strip_strings_and_comments(source)
        self.assertNotIn("historical", cleaned)
        self.assertIn("REAL", cleaned)
        self.assertEqual([], zil_smell_check.structural_balance(Path("sample.zil"), source))

    def test_semicolon_suppresses_only_one_atom(self) -> None:
        source = "<COND (<VERB? ;AGAIN SAVE RESTORE> <RTRUE>)>\n"
        cleaned = zil_smell_check.strip_strings_and_comments(source)
        self.assertNotIn("AGAIN", cleaned)
        self.assertIn("SAVE", cleaned)
        self.assertIn("RESTORE", cleaned)
        self.assertEqual([], zil_smell_check.structural_balance(Path("sample.zil"), source))

    def test_character_quote_does_not_begin_string(self) -> None:
        source = r'<SETG WBREAKS <STRING !\" !,WBREAKS>>' + "\n"
        self.assertEqual([], zil_smell_check.structural_balance(Path("sample.zil"), source))

    def test_escaped_quote_token_does_not_begin_string(self) -> None:
        source = r'<BUZZ A EXCEPT \. \, \" YES NO>' + "\n"
        cleaned = zil_smell_check.strip_strings_and_comments(source)
        self.assertIn("YES", cleaned)
        self.assertIn("NO", cleaned)
        self.assertEqual([], zil_smell_check.structural_balance(Path("sample.zil"), source))

    def test_splice_prefix_preserves_following_form(self) -> None:
        source = "<FORM PROG () !<MAPF ,LIST <FUNCTION () <RTRUE>>>>\n"
        cleaned = zil_smell_check.strip_strings_and_comments(source)
        self.assertIn("<MAPF", cleaned)
        self.assertEqual([], zil_smell_check.structural_balance(Path("sample.zil"), source))

    def test_active_include_strings_are_preserved(self) -> None:
        source = '<INSERT-FILE "gmacros" T>\n;<INSERT-FILE "dead" T>\n'
        active = zil_smell_check.sanitize_source(source, blank_strings=False)
        self.assertEqual(["gmacros"], zil_smell_check.INCLUDE_RE.findall(active))

    def test_include_resolution_is_case_exact(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "gmacros.zil").write_text("", encoding="utf-8")
            self.assertEqual(
                root / "gmacros.zil",
                zil_smell_check.resolve_include(root, "gmacros"),
            )


class BuildIdentityTests(unittest.TestCase):
    def test_accepts_project_identity(self) -> None:
        build_story.validate_identity(120, "260718")

    def test_rejects_zero_release(self) -> None:
        with self.assertRaises(RuntimeError):
            build_story.validate_identity(0, "260718")

    def test_rejects_non_six_digit_serial(self) -> None:
        with self.assertRaises(RuntimeError):
            build_story.validate_identity(120, "2026-07-18")


class StagingTests(unittest.TestCase):
    def test_git_blob_sha_matches_git(self) -> None:
        self.assertEqual(
            "b6fc4c620b67d95f953a5c1c1230aaab5db5a1b0",
            stage_source.git_blob_sha(b"hello"),
        )

    def test_all_exact_patches_apply_to_verified_root_shape(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            destination = Path(directory)
            copy_patch_targets(destination)
            receipt = stage_source.apply_patches(
                OPTIMIZED_ROOT / "patches", destination
            )
            ids = [item["id"] for item in receipt]
            self.assertEqual(
                ["Z1-BUG-001", "Z1-PORT-001", "Z1-BUG-002", "Z1-BUG-002"],
                ids,
            )

            verbs = (destination / "gverbs.zil").read_text(encoding="utf-8")
            dungeon = (destination / "1dungeon.zil").read_text(encoding="utf-8")
            actions = (destination / "1actions.zil").read_text(encoding="utf-8")

            self.assertIn("<ROUTINE OPT-DESCENDANT?", verbs)
            self.assertIn("<OPT-DESCENDANT? ,PRSI ,PRSO>", verbs)
            self.assertNotIn('"\tFlood Control Dam #3|', dungeon)
            self.assertNotIn("\t  All-Purpose Gunk", dungeon)
            self.assertIn('"        Flood Control Dam #3|', dungeon)
            self.assertIn("          All-Purpose Gunk", dungeon)
            self.assertIn("(DESCFCN CANDLES-D)", dungeon)
            self.assertIn("<ROUTINE CANDLES-D (RARG)", actions)
            self.assertIn("<FSET? ,CANDLES ,ONBIT>", actions)

            for name in PATCH_TARGETS:
                text = (destination / name).read_text(encoding="utf-8")
                self.assertEqual(
                    [],
                    zil_smell_check.structural_balance(Path(name), text),
                )

    def test_exact_patch_refuses_source_drift(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            destination = root / "source"
            patches = root / "patches"
            destination.mkdir()
            patches.mkdir()
            (destination / "sample.zil").write_text("changed", encoding="utf-8")
            (patches / "001.json").write_text(
                '{"path":"sample.zil","replacements":['
                '{"old":"original","new":"fixed","expected_count":1}]}',
                encoding="utf-8",
            )
            with self.assertRaises(RuntimeError):
                stage_source.apply_patches(patches, destination)


class StoryVerificationTests(unittest.TestCase):
    def make_story(self, path: Path) -> None:
        data = bytearray(128)
        data[0] = 3
        data[0x02:0x04] = (120).to_bytes(2, "big")
        data[0x04:0x06] = (64).to_bytes(2, "big")
        data[0x06:0x08] = (64).to_bytes(2, "big")
        data[0x08:0x0A] = (66).to_bytes(2, "big")
        data[0x0A:0x0C] = (68).to_bytes(2, "big")
        data[0x0C:0x0E] = (70).to_bytes(2, "big")
        data[0x0E:0x10] = (64).to_bytes(2, "big")
        data[0x12:0x18] = b"260718"
        data[0x1A:0x1C] = (64).to_bytes(2, "big")
        data[0x1C:0x1E] = (0).to_bytes(2, "big")
        path.write_bytes(data)

    def test_minimal_version_three_header_identity_and_checksum(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            story = Path(directory) / "sample.z3"
            self.make_story(story)
            info = verify_story.inspect(story)
            self.assertTrue(info["checksum_valid"])
            self.assertEqual(3, info["version"])
            self.assertEqual(120, info["release"])
            self.assertEqual("260718", info["serial"])
            self.assertEqual(
                [], verify_story.validate(info, 3, 120, "260718")
            )

    def test_identity_mismatch_is_reported(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            story = Path(directory) / "sample.z3"
            self.make_story(story)
            errors = verify_story.validate(
                verify_story.inspect(story), 3, 121, "880429"
            )
            self.assertIn("expected release 121, got 120", errors)
            self.assertIn("expected serial 880429, got 260718", errors)


if __name__ == "__main__":
    unittest.main()
