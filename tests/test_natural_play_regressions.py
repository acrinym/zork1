import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]
TRAIN = ROOT / 'glulx' / 'natural-play-regressions'

class NaturalPlayRegressionsTests(unittest.TestCase):
    def test_manifest_is_one_coherent_release(self):
        manifest = json.loads((TRAIN / 'patch-series.json').read_text())
        self.assertEqual(manifest['release'], 1242)
        self.assertEqual(manifest['base_release'], 1241)
        self.assertEqual(manifest['base_artifact_sha256'], '95f5d3428b366cbae6bf5c83eccb750caeea2fe1d747b83a1112dee18eb3263f')
        self.assertEqual(len(manifest['patches']), 8)
        self.assertEqual(set(manifest['expected_changed_paths']), {
            'museum_troll_provenance.zil', 'completed_expedition_archive.zil',
            'cuisine_hunger_stamina.zil', 'cellar_recovery_locker.zil',
            'reactive_surface.zil', 'attic_archive_core.zil',
            'house_kitchen_laboratory.zil', 'zork1.zil',
        })

    def test_patches_are_exact_non_noops(self):
        manifest = json.loads((TRAIN / 'patch-series.json').read_text())
        for relative in manifest['patches']:
            patch = json.loads((TRAIN / relative).read_text())
            self.assertTrue(patch['replacements'])
            for replacement in patch['replacements']:
                self.assertEqual(replacement['expected_count'], 1)
                self.assertNotEqual(replacement['old'], replacement['new'])
                self.assertTrue(replacement['old'])
                self.assertTrue(replacement['new'])

    def test_scope_is_gameplay_not_machinery(self):
        text = '\n'.join((TRAIN / p).read_text() for p in ['README.md', 'patch-series.json'])
        self.assertIn('ordinary play', text.lower())
        self.assertIn('no audit framework', text.lower())
        self.assertIn('no combat rewrite', text.lower())
        self.assertIn('no debug verbs', text.lower())

if __name__ == '__main__':
    unittest.main()
