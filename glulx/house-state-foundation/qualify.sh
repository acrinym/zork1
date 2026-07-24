#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/house-state-foundation"
SRC="$BUILD/src"
TEST_SRC="$BUILD/test-src"
mkdir -p "$BUILD"

python - <<'PY'
import json, os
from pathlib import Path
layer = json.loads(Path('glulx/house-state-foundation/patch-series.json').read_text(encoding='utf-8'))
base = json.loads(Path('glulx/room-density/patch-series.json').read_text(encoding='utf-8'))
assert layer['release'] == int(os.environ['HOUSE_RELEASE'])
assert layer['serial'] == os.environ['HOUSE_SERIAL']
assert layer['upstream_commit'] == os.environ['ZORK_GLULX_COMMIT']
assert layer['upstream_tree'] == os.environ['ZORK_GLULX_TREE']
assert layer['base_release'] == int(os.environ['BASE_RELEASE'])
assert layer['base_artifact_sha256'] == os.environ['BASE_ARTIFACT_SHA256']
assert base['release'] == int(os.environ['BASE_RELEASE'])
assert base['expected_artifact']['sha256'] == os.environ['BASE_ARTIFACT_SHA256']
assert layer['expected_changed_paths'] == [
    '1actions.zil', '1dungeon.zil', 'assistance.zil',
    'house_state_foundation.zil', 'zork1.zil'
]
assert layer['expected_artifact'] == {
    'file': 'zork1-glulx-house-state-foundation.ulx',
    'glulx_version_hex': '0x00030103',
    'size_bytes': int(os.environ['HOUSE_SIZE']),
    'checksum_hex': os.environ['HOUSE_CHECKSUM'],
    'sha256': os.environ['HOUSE_SHA256'],
}
PY

pushd .tooling/zilf-glulx
dotnet restore Zilf.sln --nologo 2>&1 | tee "$BUILD/zilf-restore.log"
dotnet build Zilf.sln --configuration Release --property:PortableTarget=true --no-restore --nologo \
  2>&1 | tee "$BUILD/zilf-build.log"
popd
GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)"
test -n "$GLULX_ZILF_DLL"
GLULX_ZILF_DLL="$(realpath "$GLULX_ZILF_DLL")"

curl --fail --location --silent --show-error "$GLAZER_SOURCE_URL" \
  --output "$BUILD/glazer-source.tar.gz"
echo "$GLAZER_SOURCE_SHA256  $BUILD/glazer-source.tar.gz" | sha256sum --check
rm -rf .tooling/glazer-source
mkdir -p .tooling/glazer-source
tar -xf "$BUILD/glazer-source.tar.gz" --strip-components=1 -C .tooling/glazer-source
make -C .tooling/glazer-source 2>&1 | tee "$BUILD/glazer-build.log"
GLAZER_BIN="$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)"
test -n "$GLAZER_BIN"
GLAZER_BIN="$(realpath "$GLAZER_BIN")"
"$GLAZER_BIN" --version | tee "$BUILD/glazer-version.txt"
grep -Fx "glazer 1.2.0" "$BUILD/glazer-version.txt"

python glulx/tools/stage_house_state_foundation.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest glulx/house-state-foundation/patch-series.json
python optimized/tools/zil_smell_check.py \
  --source "$SRC" \
  --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
receipt = json.loads(Path('glulx/build/house-state-foundation/src/STAGING-RECEIPT.json').read_text(encoding='utf-8'))
report = json.loads(Path('glulx/build/house-state-foundation/smell-report.json').read_text(encoding='utf-8'))
assert receipt['base']['release'] == 1218
assert receipt['base']['artifact_sha256'] == 'efc8bd9f264f60bb56f2daf3e4d7d6d32a272997434802ee76455781a8edf521'
assert receipt['changed_paths'] == [
    '1actions.zil', '1dungeon.zil', 'assistance.zil',
    'house_state_foundation.zil', 'zork1.zil'
]
assert not report['errors']
assert not [item for item in report['includes'] if not item['resolved']]
source = Path('glulx/build/house-state-foundation/src')
assert (source / 'house_state_foundation.zil').is_file()
assert not (source / 'house_state_foundation_test.zil').exists()
forbidden = ('HSLIVING', 'HSKITCHEN', 'HSATTIC', 'HSCELLAR', 'HSRETURN',
             'HSCOLLECT', 'HSREPORT', 'HSMUTATE', 'HSMIGRATE')
production = '\n'.join(path.read_text(errors='ignore') for path in source.glob('*.zil'))
assert not any(token in production for token in forbidden)
PY

ASSEMBLY="$BUILD/zork1-glulx-house-state-foundation.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" \
  2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" \
  --serial "$HOUSE_SERIAL" \
  --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/zork1-glulx-house-state-foundation.ulx" \
  2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/zork1-glulx-house-state-foundation.ulx" \
  --expect-sha256 "$HOUSE_SHA256" \
  --json "$BUILD/story-report.json"
python - <<'PY'
import json, os
from pathlib import Path
story = json.loads(Path('glulx/build/house-state-foundation/story-report.json').read_text(encoding='utf-8'))
assert story['version_hex'] == '0x00030103'
assert story['size_bytes'] == int(os.environ['HOUSE_SIZE'])
assert story['checksum_hex'] == os.environ['HOUSE_CHECKSUM']
assert story['checksum_valid'] is True
assert story['sha256'] == os.environ['HOUSE_SHA256']
PY

make -C .tooling/cheapglk 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C .tooling/glulxe \
  GLKDIR="$ROOT/.tooling/cheapglk" \
  GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" \
  2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
test -x "$GLULXE_BIN"

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/house-state-foundation/tests/house_state_foundation_test.zil \
  "$TEST_SRC/house_state_foundation_test.zil"
python - <<'PY'
import sys
from pathlib import Path
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/house-state-foundation/tests/001-include-house-state-test.json').resolve(),
    Path('glulx/build/house-state-foundation/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/zork1-glulx-house-state-foundation-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" \
  2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$TEST_ASSEMBLY" \
  --serial "$HOUSE_TEST_SERIAL" \
  --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/zork1-glulx-house-state-foundation-test.ulx" \
  2>&1 | tee "$BUILD/test-glazer-assemble.log"

set -o pipefail
"$GLULXE_BIN" "$BUILD/zork1-glulx-house-state-foundation-test.ulx" \
  < glulx/house-state-foundation/tests/house_state_commands.txt \
  2>&1 | tee "$BUILD/house-state-transcript.txt"
while IFS= read -r marker; do
  test -z "$marker" || grep -F -- "$marker" "$BUILD/house-state-transcript.txt"
done < glulx/house-state-foundation/tests/house_state_expectations.txt

python glulx/tools/run_interactive_story.py \
  --scenario glulx/house-state-foundation/tests/house_state_persistence.json \
  --transcript "$BUILD/house-state-persistence-transcript.txt" \
  --var STATE_SAVE_FILE="$BUILD/house-state.sav" \
  -- "$GLULXE_BIN" "$BUILD/zork1-glulx-house-state-foundation-test.ulx"
test -s "$BUILD/house-state.sav"

python - <<'PY'
import json, os
from pathlib import Path
story = json.loads(Path('glulx/build/house-state-foundation/story-report.json').read_text(encoding='utf-8'))
stage = json.loads(Path('glulx/build/house-state-foundation/src/STAGING-RECEIPT.json').read_text(encoding='utf-8'))
serial = json.loads(Path('glulx/build/house-state-foundation/SERIAL-NORMALIZATION.json').read_text(encoding='utf-8'))
receipt = {
    'qualification_status': 'qualified',
    'identity': {'release': int(os.environ['HOUSE_RELEASE']), 'serial': os.environ['HOUSE_SERIAL']},
    'base': stage['base'],
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'serial_normalization': serial,
    'routes': {
        'house_entry_receipt': 'passed',
        'attic_receipt_and_projection': 'passed',
        'cellar_threshold_and_return': 'passed',
        'trophy_case_collection_projection': 'passed',
        'rug_and_trap_door_disturbance': 'passed',
        'canonical_score_and_object_tree': 'passed',
        'schema_migration_defaults': 'passed',
        'native_save_restore': 'passed',
        'house_recap': 'passed',
    },
    'production_contains_test_setup': False,
    'bedroom_placeholder_added': False,
}
Path('glulx/build/house-state-foundation/BUILD-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n', encoding='utf-8'
)
PY
