"""Regression coverage for the corpus lexer used by Release 1233."""

from __future__ import annotations

import unittest

from tools.infocom_corpus.core import CorpusError, lex_zil


class MuseumIntakeCorpusLexerTests(unittest.TestCase):
    """Keep historical multiline ZIL comments out of extracted prose."""

    def test_multiline_comment_string_is_consumed_as_comment(self) -> None:
        source = '''<ROUTINE SAMPLE ()
    ;"This historical comment spans
      more than one physical source line."
    <TELL "Visible response." CR>>'''
        strings = [token.value for token in lex_zil(source) if token.kind == "string"]
        self.assertEqual(strings, ["Visible response."])

    def test_unterminated_multiline_comment_reports_comment_origin(self) -> None:
        source = '<ROUTINE SAMPLE ()\n    ;"unfinished comment\n'
        with self.assertRaisesRegex(
            CorpusError, "unterminated ZIL comment string at line 2"
        ):
            list(lex_zil(source))


if __name__ == "__main__":
    unittest.main()
