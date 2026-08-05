#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/museum-troll-provenance"
SRC="$BUILD/src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/museum-troll-provenance/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

IFS=$'\t' read -r SERIAL STORY_FILE < <(
  python - "$MANIFEST" <<'PY'
import json, sys
from pathlib import Path
manifest = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
print('\t'.join((manifest['serial'], manifest['expected_artifact']['file'])))
PY
)

python -m unittest discover -s tests -p 'test_museum_troll_provenance.py' -v
python -m py_compile glulx/museum-troll-provenance/stage.py tests/test_museum_troll_provenance.py
python glulx/museum-troll-provenance/stage.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/museum-troll-provenance/src')
stage = json.loads((source / 'STAGING-RECEIPT.json').read_text(encoding='utf-8'))
smell = json.loads(Path('glulx/build/museum-troll-provenance/smell-report.json').read_text(encoding='utf-8'))
assert stage['base']['release'] == 1240
assert stage['base']['artifact_sha256'] == '067ab63fd33bd35a3bb7f4a118e3d49e09f24b268231922ad9f68417c1560630'
assert stage['changed_paths'] == [
    '1actions.zil',
    'museum_intake_first_gallery.zil',
    'museum_troll_provenance.zil',
    'zork1.zil',
]
assert not smell['errors']
module = (source / 'museum_troll_provenance.zil').read_text(encoding='utf-8')
intake = (source / 'museum_intake_first_gallery.zil').read_text(encoding='utf-8')
actions = (source / '1actions.zil').read_text(encoding='utf-8')
for token in (
    '<OBJECT TROLL-FUR',
    '<OBJECT MUSEUM-MONSTER-CASE',
    '<OBJECT TROLL-PLAQUE',
    '<MOVE ,TROLL-FUR ,HERE>',
    '<IN? ,TROLL-FUR ,MUSEUM-MONSTER-CASE>',
    '<IN? ,TROLL-FUR ,TROLL-ROOM>',
):
    assert token in module
assert '<MUSEUM-TROLL-TRACE 1>' in actions
assert '<MUSEUM-TROLL-TRACE 2>' in actions
assert '<RETURN ,MUSEUM-MONSTER-CASE>' in intake
production = '\n'.join(path.read_text(encoding='utf-8', errors='ignore') for path in source.glob('*.zil'))
for test_word in ('TROLLSUBDUE', 'TROLLKILL', 'MUSEUMHOME'):
    assert test_word not in production
assert module.count('<OBJECT TROLL-FUR') == 1
assert '<OBJECT TROLL\n' not in module
assert '<OBJECT AXE' not in module
assert '<RANDOM' not in module
PY

if ! command -v dotnet >/dev/null 2>&1; then
  echo "dotnet is required." >&2
  exit 4
fi
GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit 2>/dev/null || true)"
if [[ -z "$GLULX_ZILF_DLL" ]]; then
  pushd .tooling/zilf-glulx
  dotnet restore Zilf.sln --nologo 2>&1 | tee "$BUILD/zilf-restore.log"
  dotnet build Zilf.sln --configuration Release --property:PortableTarget=true --no-restore --nologo \
    2>&1 | tee "$BUILD/zilf-build.log"
  popd
  GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)"
fi
GLULX_ZILF_DLL="$(realpath "$GLULX_ZILF_DLL")"
GLAZER_BIN="$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)"
GLAZER_BIN="$(realpath "$GLAZER_BIN")"

ASSEMBLY="$BUILD/museum-troll-provenance.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" \
  2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" --serial "$SERIAL" \
  --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$STORY_FILE" 2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/$STORY_FILE" --json "$BUILD/story-report.json"

make -C .tooling/cheapglk 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C .tooling/glulxe GLKDIR="$ROOT/.tooling/cheapglk" \
  GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" 2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/museum-troll-provenance/tests/museum_troll_provenance_test.zil \
  "$TEST_SRC/museum_troll_provenance_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/museum-troll-provenance/tests/001-include-troll-test.json').resolve(),
    Path('glulx/build/museum-troll-provenance/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/museum-troll-provenance-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" \
  2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$TEST_ASSEMBLY" --serial "$SERIAL" \
  --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/museum-troll-provenance-test.ulx" \
  2>&1 | tee "$BUILD/test-glazer-assemble.log"

cat > "$BUILD/commands.txt" <<'EOF_COMMANDS'
trollsubdue
look
take fur
museumhome
exhibit fur
catalog creatures
read troll plaque
take fur
catalog creatures
trollkill
look
take fur
museumhome
exhibit fur
catalog creatures
read troll plaque
take fur
catalog creatures
quit
yes
EOF_COMMANDS
"$GLULXE_BIN" "$BUILD/museum-troll-provenance-test.ulx" < "$BUILD/commands.txt" \
  2>&1 | tee "$BUILD/runtime-transcript.txt"

grep -F 'TEST PRECONDITION: the canonical troll was rendered unconscious in the Troll Room.' "$BUILD/runtime-transcript.txt"
grep -F 'A coarse iron-grey tuft shakes loose from the sprawled troll' "$BUILD/runtime-transcript.txt"
grep -F 'the case holds the one real iron-grey troll tuft, shed when the canonical troll was rendered unconscious' "$BUILD/runtime-transcript.txt"
grep -F 'TEST PRECONDITION: the canonical troll was killed in the Troll Room.' "$BUILD/runtime-transcript.txt"
grep -F 'A coarse iron-grey tuft clings briefly to the fallen axe' "$BUILD/runtime-transcript.txt"
grep -F 'the case holds the one real iron-grey troll tuft, recovered after the canonical troll was killed' "$BUILD/runtime-transcript.txt"
grep -F 'the troll encounter is documented, but the real tuft is currently outside museum custody' "$BUILD/runtime-transcript.txt"
python - <<'PY'
from pathlib import Path
text = Path('glulx/build/museum-troll-provenance/runtime-transcript.txt').read_text(encoding='utf-8')
assert text.index('rendered unconscious in the Troll Room') < text.index('shed when the canonical troll was rendered unconscious')
assert text.index('canonical troll was killed in the Troll Room') < text.index('recovered after the canonical troll was killed')
assert text.rindex('outside museum custody') > text.index('recovered after the canonical troll was killed')
for word in ('trollsubdue', 'trollkill', 'museumhome', 'fur', 'tuft', 'exhibit', 'catalog', 'creatures', 'read', 'troll', 'plaque'):
    assert f'I don\'t know the word "{word}"' not in text
PY

python - "$SERIAL" "$MANIFEST" <<'PY'
import json, sys
from pathlib import Path
serial, manifest_path = sys.argv[1:]
manifest = json.loads(Path(manifest_path).read_text(encoding='utf-8'))
expected = manifest['expected_artifact']
story = json.loads(Path('glulx/build/museum-troll-provenance/story-report.json').read_text(encoding='utf-8'))
assert story['format'] == expected['format']
assert story['version_hex'] == expected['version_hex']
assert story['checksum_valid'] is True
if expected.get('locked', False):
    assert story['size_bytes'] == expected['size_bytes']
    assert story['checksum_hex'] == expected['checksum_hex']
    assert story['sha256'] == expected['sha256']
receipt = {
    'release': 1241,
    'serial': serial,
    'artifact': story,
    'artifact_identity_locked': expected.get('locked', False),
    'gameplay': {
        'canonical_troll_unconscious_hook': 'passed',
        'canonical_troll_death_hook': 'passed',
        'single_physical_tuft': 'passed',
        'outcome_specific_provenance': 'passed',
        'physical_creature_case_exhibit': 'passed',
        'provenance_plaque': 'passed',
        'physical_removal_updates_gallery': 'passed'
    },
    'combat_rewrite': False,
    'generic_monster_engine': False,
    'object_copy': False
}
Path('glulx/build/museum-troll-provenance/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n', encoding='utf-8'
)
PY
cat "$BUILD/story-report.json"
