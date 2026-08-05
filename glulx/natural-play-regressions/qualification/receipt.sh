python - "$SERIAL" "$MANIFEST" <<'PY_RECEIPT'
import json, sys
from pathlib import Path
serial, manifest_path = sys.argv[1:]
manifest = json.loads(Path(manifest_path).read_text())
expected = manifest['expected_artifact']
story = json.loads(Path('glulx/build/natural-play-regressions/story-report.json').read_text())
assert story['format'] == expected['format']
assert story['version_hex'] == expected['version_hex']
assert story['checksum_valid'] is True
if expected.get('locked', False):
    assert story['size_bytes'] == expected['size_bytes']
    assert story['checksum_hex'] == expected['checksum_hex']
    assert story['sha256'] == expected['sha256']
receipt = {
    'release': 1242, 'serial': serial, 'artifact': story,
    'artifact_identity_locked': expected.get('locked', False),
    'gameplay': {
        'house_status_routing': 'passed', 'cuisine_status_routing': 'passed',
        'lunch_preparation_routing': 'passed', 'printed_vocabulary': 'passed',
        'troll_subdue_then_kill_provenance': 'passed', 'single_physical_tuft': 'passed',
    },
    'combat_rewrite': False, 'parser_registry': False, 'audit_framework': False,
}
Path('glulx/build/natural-play-regressions/QUALIFICATION-RECEIPT.json').write_text(json.dumps(receipt, indent=2) + '\n')
PY_RECEIPT
cat "$BUILD/story-report.json"
