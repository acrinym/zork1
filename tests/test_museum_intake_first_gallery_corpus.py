"""Regression coverage for the corpus lexer used by Release 1233."""

from __future__ import annotations

import unittest

from tools.infocom_corpus.core import CorpusError, lex_zil


class MuseumIntakeCorpusLexerTests(unittest.TestCase):
    """Keep historical comments and character literals out of prose."""

    def test_multiline_comment_string_is_consumed_as_comment(self) -> None:
        source = '''<ROUTINE SAMPLE ()
    ;"This historical comment spans
      more than one physical source line!"
    <TELL "Visible response." CR>>'''
        strings = [token.value for token in lex_zil(source) if token.kind == "string"]
        self.assertEqual(strings, ["Visible response."])

    def test_unterminated_multiline_comment_reports_comment_origin(self) -> None:
        source = '<ROUTINE SAMPLE ()\n    ;"unfinished comment\n'
        with self.assertRaisesRegex(
            CorpusError, "unterminated ZIL comment string at line 2"
        ):
            list(lex_zil(source))

    def test_exclamation_before_closing_quote_ends_visible_string(self) -> None:
        source = '<TELL "Nothing happens here!" CR>\n<TELL "Next response." CR>'
        strings = [token.value for token in lex_zil(source) if token.kind == "string"]
        self.assertEqual(strings, ["Nothing happens here!", "Next response."])

    def test_quote_character_literal_is_not_a_string(self) -> None:
        source = '''<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\\" !,WBREAKS>>>
<PRINC "Visible title.">'''
        tokens = list(lex_zil(source))
        strings = [token.value for token in tokens if token.kind == "string"]
        atoms = [token.value for token in tokens if token.kind == "atom"]
        self.assertEqual(strings, ["Visible title."])
        self.assertIn('!\\"', atoms)
        self.assertIn('!,', atoms)

    def test_backslash_escaped_parser_punctuation_is_not_prose(self) -> None:
        source = '<BUZZ EXCEPT \\. \\, \\" HERE>\n<PRINC "Visible title.">'
        tokens = list(lex_zil(source))
        strings = [token.value for token in tokens if token.kind == "string"]
        atoms = [token.value for token in tokens if token.kind == "atom"]
        self.assertEqual(strings, ["Visible title."])
        self.assertIn('\\.', atoms)
        self.assertIn('\\,', atoms)
        self.assertIn('\\"', atoms)


if __name__ == "__main__":
    unittest.main()
