from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path


OPTIMIZED_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(OPTIMIZED_ROOT / "tools"))

import stage_source  # noqa: E402
import verify_story  # noqa: E402
import zil_smell_check  # noqa: E402


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

    def test_include_resolution_is_case_exact(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "gmacros.zil").write_text("", encoding="utf-8")
            self.assertEqual(
                root / "gmacros.zil",
                zil_smell_check.resolve_include(root, "gmacros"),
            )


class StagingTests(unittest.TestCase):
    def test_git_blob_sha_matches_git(self) -> None:
        self.assertEqual(
            "b6fc4c620b67d95f953a5c1c1230aaab5db5a1b0",
            stage_source.git_blob_sha(b"hello"),
        )


class StoryVerificationTests(unittest.TestCase):
    def test_minimal_version_three_header_and_checksum(self) -> None:
        data = bytearray(128)
        data[0] = 3
        data[0x02:0x04] = (1).to_bytes(2, "big")
        data[0x04:0x06] = (64).to_bytes(2, "big")
        data[0x06:0x08] = (64).to_bytes(2, "big")
        data[0x08:0x0A] = (66).to_bytes(2, "big")
        data[0x0A:0x0C] = (68).to_bytes(2, "big")
        data[0x0C:0x0E] = (70).to_bytes(2, "big")
        data[0x0E:0x10] = (64).to_bytes(2, "big")
        data[0x12:0x18] = b"260718"
        data[0x1A:0x1C] = (64).to_bytes(2, "big")
        data[0x1C:0x1E] = (0).to_bytes(2, "big")

        with tempfile.TemporaryDirectory() as directory:
            story = Path(directory) / "sample.z3"
            story.write_bytes(data)
            info = verify_story.inspect(story)
            self.assertTrue(info["checksum_valid"])
            self.assertEqual(3, info["version"])
            self.assertEqual([], verify_story.validate(info, 3))


if __name__ == "__main__":
    unittest.main()
