"""Direct regression tests for Release 1231 state and artifact qualification."""

from __future__ import annotations

import json
from pathlib import Path
import re
import subprocess
import unittest


ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx/corpus-causal-warning"


class CorpusCausalWarningQualificationTests(unittest.TestCase):
    """Check the production state boundary and executable qualification route."""

    def test_causal_warnings_add_no_flood_globals(self) -> None:
        module = (TRAIN / "overrides/corpus_causal_warning.zil").read_text()
        globals_found = re.findall(r"<GLOBAL (MAINT-FLOOD-[A-Z-]+)", module)
        self.assertEqual(globals_found, [])
        self.assertIn("<EQUAL? ,WATER-LEVEL 3>", module)
        self.assertIn("<EQUAL? ,WATER-LEVEL 5>", module)
        self.assertIn("<EQUAL? ,WATER-LEVEL 11>", module)

    def test_hosted_artifact_identity_is_locked(self) -> None:
        manifest = json.loads((TRAIN / "patch-series.json").read_text())
        expected = manifest["expected_artifact"]
        self.assertTrue(expected["locked"])
        self.assertEqual(expected["size_bytes"], 337920)
        self.assertEqual(expected["checksum_hex"], "0x1b994d18")
        self.assertEqual(
            expected["sha256"],
            "5daaa7307ef496a3ae37209a6e79e149c9dc3d202f148f143bbb571fa74b3609",
        )

    def test_full_qualifier_compiles_assembles_and_verifies(self) -> None:
        qualifier_path = TRAIN / "qualify.sh"
        qualifier = qualifier_path.read_text()
        subprocess.run(["bash", "-n", str(qualifier_path)], check=True)
        for required in (
            'dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile',
            "glulx/tools/normalize_serial.py",
            '"$GLAZER_BIN" "$ASSEMBLY"',
            "glulx/tools/verify_ulx.py",
            "story['checksum_valid'] is True",
            "story['sha256'] == expected['sha256']",
            "QUALIFICATION-RECEIPT.json",
        ):
            self.assertIn(required, qualifier)
        self.assertNotIn(
            "run the repository's standard Glulx compile/assemble route",
            qualifier,
        )


if __name__ == "__main__":
    unittest.main()
