#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/cellar-recovery-locker"
SRC="$BUILD/src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/cellar-recovery-locker/patch-series.json"
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

python -m unittest discover -s tests -p 'test_cellar_recovery_locker.py' -v
python -m py_compile glulx/cellar-recovery-locker/stage.py tests/test_cellar_recovery_locker.py
python glulx/cellar-recovery-locker/stage.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/cellar-recovery-locker/src')
stage = json.loads((source / 'STAGING-RECEIPT.json').read_text(encoding='utf-8'))
smell = json.loads(Path('glulx/build/cellar-recovery-locker/smell-report.json').read_text(encoding='utf-8'))
assert stage['base']['release'] == 1237
assert stage['base']['artifact_sha256'] == 'f2748088e7440419cc871877e396b9e85b8e662f735ff535433dcbf17f06fa0c'
assert stage['changed_paths'] == [
    'cellar_recovery_locker.zil',
    'completed_expedition_archive.zil',
    'zork1.zil',
]
assert not smell['errors']
module = (source / 'cellar_recovery_locker.zil').read_text(encoding='utf-8')
for token in (
    '<SYNTAX SEAL OBJECT = V-RECOVERY-LOCKER-SEAL>',
    '<OBJECT EXPEDITION-RECOVERY-LOCKER',
    '<EXPEDITION-HAS? ,ES-SEALED 2>',
    '<RECOVERY-LOCKER-PUT ,RLS-DEATHS-AT-SEAL ,DEATHS>',
    '<G? ,DEATHS',
    '(CAPACITY 30)',
):
    assert token in module
production = '\n'.join(path.read_text(encoding='utf-8', errors='ignore') for path in source.glob('*.zil'))
assert 'STASHREADY' not in production
assert 'STASHDIE' not in production
assert '<JIGS-UP' not in module
assert '<RANDOMIZE-OBJECTS' not in module
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

ASSEMBLY="$BUILD/cellar-recovery-locker.asm"
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
cp glulx/cellar-recovery-locker/tests/cellar_recovery_locker_test.zil \
  "$TEST_SRC/cellar_recovery_locker_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/cellar-recovery-locker/tests/001-include-recovery-locker-test.json').resolve(),
    Path('glulx/build/cellar-recovery-locker/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/cellar-recovery-locker-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" \
  2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$TEST_ASSEMBLY" --serial "$SERIAL" \
  --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/cellar-recovery-locker-test.ulx" \
  2>&1 | tee "$BUILD/test-glazer-assemble.log"

cat > "$BUILD/commands.txt" <<'EOF_COMMANDS'
stashready
put lantern in locker
put rope in locker
put garlic in locker
look in locker
seal locker
stashdie
east
south
east
open window
west
west
move rug
open trap door
down
look
open locker
look in locker
take lantern
take rope
inventory
quit
yes
EOF_COMMANDS
"$GLULXE_BIN" "$BUILD/cellar-recovery-locker-test.ulx" < "$BUILD/commands.txt" \
  2>&1 | tee "$BUILD/runtime-transcript.txt"

grep -F 'TEST PRECONDITION: Expedition B sealed' "$BUILD/runtime-transcript.txt"
grep -F 'The recovery locker has only two real kit positions.' "$BUILD/runtime-transcript.txt"
grep -F 'Whatever remains on your body is still exposed to the Great Underground Empire' "$BUILD/runtime-transcript.txt"
grep -F '****  You have died  ****' "$BUILD/runtime-transcript.txt"
grep -F 'The prepared seal breaks. After death scattered what remained on your body' "$BUILD/runtime-transcript.txt"
grep -F 'brass lantern and coil of rope' "$BUILD/runtime-transcript.txt"
grep -F 'Taken.' "$BUILD/runtime-transcript.txt"
python - <<'PY'
from pathlib import Path
text = Path('glulx/build/cellar-recovery-locker/runtime-transcript.txt').read_text(encoding='utf-8')
after = text.split('The prepared seal breaks.', 1)[1]
assert 'brass lantern' in after
assert 'coil of rope' in after
assert 'clove of garlic' not in after.split('You are carrying:', 1)[-1]
for word in ('stashready', 'stashdie', 'seal', 'locker'):
    assert f'I don\'t know the word "{word}"' not in text
PY

python - "$SERIAL" "$MANIFEST" <<'PY'
import json, sys
from pathlib import Path
serial, manifest_path = sys.argv[1:]
manifest = json.loads(Path(manifest_path).read_text(encoding='utf-8'))
expected = manifest['expected_artifact']
story = json.loads(Path('glulx/build/cellar-recovery-locker/story-report.json').read_text(encoding='utf-8'))
assert story['format'] == expected['format']
assert story['version_hex'] == expected['version_hex']
assert story['checksum_valid'] is True
if expected.get('locked', False):
    assert story['size_bytes'] == expected['size_bytes']
    assert story['checksum_hex'] == expected['checksum_hex']
    assert story['sha256'] == expected['sha256']
receipt = {
    'release': 1238,
    'serial': serial,
    'artifact': story,
    'artifact_identity_locked': expected.get('locked', False),
    'gameplay': {
        'expedition_b_unlock': 'passed',
        'two_object_limit': 'passed',
        'prepared_physical_seal': 'passed',
        'canonical_death': 'passed',
        'physical_house_return': 'passed',
        'same_object_recovery': 'passed',
        'carried_object_not_protected': 'passed',
    },
    'death_hook': False,
    'remote_inventory': False,
    'object_copy': False,
}
Path('glulx/build/cellar-recovery-locker/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n', encoding='utf-8'
)
PY
cat "$BUILD/story-report.json"
