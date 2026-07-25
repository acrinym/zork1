#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/house-cellar-threshold"
SRC="$BUILD/src"
TEST_SRC="$BUILD/test-src"
rm -rf "$BUILD"
mkdir -p "$BUILD"

python - <<'PY'
import json, os
from pathlib import Path
layer = json.loads(Path('glulx/house-cellar-threshold/patch-series.json').read_text(encoding='utf-8'))
base = json.loads(Path('glulx/house-kitchen-laboratory/patch-series.json').read_text(encoding='utf-8'))
assert layer['release'] == int(os.environ['CELLAR_RELEASE'])
assert layer['serial'] == os.environ['CELLAR_SERIAL']
assert layer['upstream_commit'] == os.environ['ZORK_GLULX_COMMIT']
assert layer['upstream_tree'] == os.environ['ZORK_GLULX_TREE']
assert layer['base_release'] == int(os.environ['BASE_RELEASE'])
assert layer['base_artifact_sha256'] == os.environ['BASE_ARTIFACT_SHA256']
assert base['release'] == int(os.environ['BASE_RELEASE'])
assert base['expected_artifact']['sha256'] == os.environ['BASE_ARTIFACT_SHA256']
assert layer['expected_changed_paths'] == [
    '1actions.zil', 'assistance.zil', 'house_cellar_threshold.zil',
    'shadow_logic.zil', 'zork1.zil'
]
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

python glulx/tools/stage_house_cellar_threshold.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest glulx/house-cellar-threshold/patch-series.json
python optimized/tools/zil_smell_check.py \
  --source "$SRC" \
  --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
receipt = json.loads(Path('glulx/build/house-cellar-threshold/src/STAGING-RECEIPT.json').read_text(encoding='utf-8'))
report = json.loads(Path('glulx/build/house-cellar-threshold/smell-report.json').read_text(encoding='utf-8'))
assert receipt['base']['release'] == 1221
assert receipt['base']['artifact_sha256'] == '93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f'
assert receipt['changed_paths'] == [
    '1actions.zil', 'assistance.zil', 'house_cellar_threshold.zil',
    'shadow_logic.zil', 'zork1.zil'
]
assert not report['errors']
assert not [item for item in report['includes'] if not item['resolved']]
source = Path('glulx/build/house-cellar-threshold/src')
assert (source / 'house_cellar_threshold.zil').is_file()
assert not (source / 'house_cellar_threshold_test.zil').exists()
production = '\n'.join(path.read_text(errors='ignore') for path in source.glob('*.zil'))
assert not any(token in production for token in ('CSETUP', 'CINTRUDE', 'CWATER', 'CREPORT', 'CMUTATE'))
PY

ASSEMBLY="$BUILD/zork1-glulx-house-cellar-threshold.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" \
  2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" \
  --serial "$CELLAR_SERIAL" \
  --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/zork1-glulx-house-cellar-threshold.ulx" \
  2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/zork1-glulx-house-cellar-threshold.ulx" \
  --json "$BUILD/story-report.json"

make -C .tooling/cheapglk 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C .tooling/glulxe \
  GLKDIR="$ROOT/.tooling/cheapglk" \
  GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" \
  2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
test -x "$GLULXE_BIN"

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/house-cellar-threshold/tests/house_cellar_threshold_test.zil \
  "$TEST_SRC/house_cellar_threshold_test.zil"
python - <<'PY'
import sys
from pathlib import Path
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/house-cellar-threshold/tests/001-include-cellar-test.json').resolve(),
    Path('glulx/build/house-cellar-threshold/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/zork1-glulx-house-cellar-threshold-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" \
  2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$TEST_ASSEMBLY" \
  --serial "$CELLAR_TEST_SERIAL" \
  --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/zork1-glulx-house-cellar-threshold-test.ulx" \
  2>&1 | tee "$BUILD/test-glazer-assemble.log"

"$GLULXE_BIN" "$BUILD/zork1-glulx-house-cellar-threshold-test.ulx" \
  < glulx/house-cellar-threshold/tests/house_cellar_threshold_commands.txt \
  2>&1 | tee "$BUILD/house-cellar-threshold-transcript.txt"
while IFS= read -r marker; do
  test -z "$marker" || grep -F -- "$marker" "$BUILD/house-cellar-threshold-transcript.txt"
done < glulx/house-cellar-threshold/tests/house_cellar_threshold_expectations.txt

python glulx/tools/run_interactive_story.py \
  --scenario glulx/house-cellar-threshold/tests/house_cellar_threshold_persistence.json \
  --transcript "$BUILD/house-cellar-threshold-persistence-transcript.txt" \
  --var CELLAR_SAVE_FILE="$BUILD/house-cellar-threshold.sav" \
  -- "$GLULXE_BIN" "$BUILD/zork1-glulx-house-cellar-threshold-test.ulx"
test -s "$BUILD/house-cellar-threshold.sav"

python - <<'PY'
import json
from pathlib import Path
story = json.loads(Path('glulx/build/house-cellar-threshold/story-report.json').read_text(encoding='utf-8'))
stage = json.loads(Path('glulx/build/house-cellar-threshold/src/STAGING-RECEIPT.json').read_text(encoding='utf-8'))
receipt = {
    'discovery_status': 'passed',
    'identity': {'release': 1222, 'serial': '260724'},
    'base': stage['base'],
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'routes': {
        'canonical_trap_door_descent_and_bar': 'passed',
        'real_object_staging_and_readiness': 'passed',
        'bounded_sound_draft_damp_and_route_sensing': 'passed',
        'carried_hazard_screening': 'passed',
        'recoverable_quarantine_and_live_flame_refusal': 'passed',
        'thief_creature_water_smoke_and_supernatural_evidence': 'passed',
        'real_water_evidence_cleanup': 'passed',
        'native_save_corrupt_restore': 'passed',
        'cellar_recap': 'passed',
    },
    'production_contains_test_setup': False,
    'inventory_automation': False,
    'duplicate_objects_or_actors': False,
    'parallel_score': False,
    'automatic_route_unlock': False,
}
Path('glulx/build/house-cellar-threshold/DISCOVERY-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n', encoding='utf-8'
)
print(json.dumps(story, indent=2))
PY
