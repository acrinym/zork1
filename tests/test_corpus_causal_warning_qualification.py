"""Direct regression tests for Release 1231 state and artifact qualification."""

from __future__ import annotations

from pathlib import Path
import re
import subprocess
import unittest


ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx/corpus-causal-warning"


class CorpusCausalWarningQualificationTests(unittest.TestCase):
    """Check the production state boundary and executable qualification route."""

    def test_warning_stage_is_the_only_new_flood_state(self) -> None:
        module = (TRAIN / "overrides/corpus_causal_warning.zil").read_text()
        globals_found = re.findall(r"<GLOBAL (MAINT-FLOOD-[A-Z-]+)", module)
        self.assertEqual(globals_found, ["MAINT-FLOOD-WARNING-STAGE"])
        for dead_state in (
            "MAINT-FLOOD-CAUSE-SEEN",
            "MAINT-FLOOD-LEAK-EXAMINED",
            "MAINT-FLOOD-REPAIRED",
        ):
            self.assertNotIn(f"<GLOBAL {dead_state}", module)

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
            "QUALIFICATION-RECEIPT.json",
        ):
            self.assertIn(required, qualifier)
        self.assertNotIn(
            "run the repository's standard Glulx compile/assemble route",
            qualifier,
        )


if __name__ == "__main__":
    unittest.main()
