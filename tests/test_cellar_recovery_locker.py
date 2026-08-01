"""Direct gameplay contracts for Release 1238."""

from __future__ import annotations

import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / "glulx/cellar-recovery-locker"
MODULE = TRAIN / "overrides/cellar_recovery_locker.zil"


class CellarRecoveryLockerTests(unittest.TestCase):
    def test_release_1238_uses_locked_1237_base(self) -> None:
        manifest = json.loads((TRAIN / "patch-series.json").read_text(encoding="utf-8"))
        self.assertEqual(manifest["release"], 1238)
        self.assertEqual(manifest["base_release"], 1237)
        self.assertEqual(
            manifest["base_artifact_sha256"],
            "f2748088e7440419cc871877e396b9e85b8e662f735ff535433dcbf17f06fa0c",
        )

    def test_locker_is_real_bounded_and_cellar_materialized(self) -> None:
        module = MODULE.read_text(encoding="utf-8")
        self.assertIn("<OBJECT EXPEDITION-RECOVERY-LOCKER", module)
        self.assertIn("(CAPACITY 30)", module)
        self.assertIn("<MOVE ,EXPEDITION-RECOVERY-LOCKER ,CELLAR>", module)
        self.assertIn("<G? <RECOVERY-LOCKER-COUNT> 1>", module)
        self.assertNotIn("<GLOBAL", module)

    def test_unlock_requires_sealed_expedition_b(self) -> None:
        module = MODULE.read_text(encoding="utf-8")
        unlocked = module.split("<ROUTINE RECOVERY-LOCKER-UNLOCKED?", 1)[1].split(
            "<ROUTINE RECOVERY-LOCKER-MATERIALIZE", 1
        )[0]
        self.assertIn("<EXPEDITION-HAS? ,ES-SEALED 2>", unlocked)
        self.assertNotIn("WON-FLAG", unlocked)

    def test_seal_uses_canonical_death_count_not_object_copies(self) -> None:
        module = MODULE.read_text(encoding="utf-8")
        self.assertIn("<RECOVERY-LOCKER-PUT ,RLS-DEATHS-AT-SEAL ,DEATHS>", module)
        self.assertIn("<G? ,DEATHS", module)
        for forbidden in ("JIGS-UP", "RANDOMIZE-OBJECTS", "OBJECT-ID", "REMOTE-RETRIEVE"):
            self.assertNotIn(forbidden, module)

    def test_entrypoint_loads_recovery_locker_last(self) -> None:
        entry = (TRAIN / "overrides/zork1.zil").read_text(encoding="utf-8")
        self.assertIn("<CONSTANT RELEASEID 1238>", entry)
        self.assertTrue(entry.rstrip().endswith('<INSERT-FILE "cellar_recovery_locker" T>'))


if __name__ == "__main__":
    unittest.main()
