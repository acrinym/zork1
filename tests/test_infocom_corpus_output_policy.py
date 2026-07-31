"""Direct regression qualification for protected corpus output paths."""

from __future__ import annotations

import json
from pathlib import Path
import tempfile
import unittest

from tools.infocom_corpus.core import CorpusError, ensure_output_policy


ROOT = Path(__file__).resolve().parents[1]
MANIFEST_PATH = ROOT / "reference/infocom-corpus/manifest/infocom-corpus.json"


class OutputPolicyTests(unittest.TestCase):
    """Verify protected extraction fails closed outside the repository."""

    def test_protected_output_outside_repository_fails_closed(self) -> None:
        manifest = json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))
        protected_artifact = manifest["artifacts"][0]
        with tempfile.TemporaryDirectory() as repo_temp, tempfile.TemporaryDirectory() as outside_temp:
            output = Path(outside_temp) / "leak.jsonl"
            with self.assertRaisesRegex(CorpusError, "full extracted text"):
                ensure_output_policy(output, Path(repo_temp), protected_artifact)


if __name__ == "__main__":
    unittest.main()
