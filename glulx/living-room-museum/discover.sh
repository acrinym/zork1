#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/living-room-museum"
SRC="$BUILD/src"
TEST_SRC="$BUILD/test-src"
mkdir -p "$BUILD"

python - <<'PY'
import json, os
from pathlib import Path
layer = json.loads(Path('glulx/living-room-museum/patch-series.json').read_text(encoding='utf-8'))
base = json.loads(Path('glulx/house-state-foundation/patch-series.json').read_text(encoding='utf-8'))
assert layer['release'] == int(os.environ['MUSEUM_RELEASE'])
assert layer['serial'] == os.environ['MUSEUM_SERIAL']
assert layer['upstream_commit'] == os.environ['ZORK_GLULX_COMMIT']
assert layer['upstream_tree'] == os.environ['ZORK_GLULX_TREE']
assert layer['base_release'] == int(os.environ['BASE_RELEASE'])
assert layer['base_artifact_sha256'] == os.environ['BASE_ARTIFACT_SHA256']
assert base['release'] == int(os.environ['BASE_RELEASE'])
assert base['expected_artifact']['sha256'] == os.environ['BASE_ARTIFACT_SHA256']
assert layer['expected_changed_paths'] == [
    '1actions.zil', 'assistance.zil', 'living_room_museum.zil', 'zork1.zil'
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

python glulx/tools/stage_living_room_museum.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest glulx/living-room-museum/patch-series.json
python optimized/tools/zil_smell_check.py \
  --source "$SRC" \
  --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
receipt = json.loads(Path('glulx/build/living-room-museum/src/STAGING-RECEIPT.json').read_text(encoding='utf-8'))
report = json.loads(Path('glulx/build/living-room-museum/smell-report.json').read_text(encoding='utf-8'))
assert receipt['base']['release'] == 1219
assert receipt['changed_paths'] == [
    '1actions.zil', 'assistance.zil', 'living_room_museum.zil', 'zork1.zil'
]
assert not report['errors']
assert not [item for item in report['includes'] if not item['resolved']]
source = Path('glulx/build/living-room-museum/src')
assert (source / 'living_room_museum.zil').is_file()
assert not (source / 'living_room_museum_test.zil').exists()
forbidden = ('MSETUP', 'MCOMPLETE', 'MREPORT', 'MMUTATE', 'MRECOVER')
production = '\n'.join(path.read_text(errors='ignore') for path in source.glob('*.zil'))
assert not any(token in production for token in forbidden)
PY

ASSEMBLY="$BUILD/zork1-glulx-living-room-museum.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" \
  2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" \
  --serial "$MUSEUM_SERIAL" \
  --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/zork1-glulx-living-room-museum.ulx" \
  2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/zork1-glulx-living-room-museum.ulx" \
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
cp glulx/living-room-museum/tests/living_room_museum_test.zil \
  "$TEST_SRC/living_room_museum_test.zil"
python - <<'PY'
import sys
from pathlib import Path
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/living-room-museum/tests/001-include-museum-test.json').resolve(),
    Path('glulx/build/living-room-museum/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/zork1-glulx-living-room-museum-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" \
  2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$TEST_ASSEMBLY" \
  --serial "$MUSEUM_TEST_SERIAL" \
  --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/zork1-glulx-living-room-museum-test.ulx" \
  2>&1 | tee "$BUILD/test-glazer-assemble.log"

set -o pipefail
"$GLULXE_BIN" "$BUILD/zork1-glulx-living-room-museum-test.ulx" \
  < glulx/living-room-museum/tests/living_room_museum_commands.txt \
  2>&1 | tee "$BUILD/living-room-museum-transcript.txt"
while IFS= read -r marker; do
  test -z "$marker" || grep -F -- "$marker" "$BUILD/living-room-museum-transcript.txt"
done < glulx/living-room-museum/tests/living_room_museum_expectations.txt

python glulx/tools/run_interactive_story.py \
  --scenario glulx/living-room-museum/tests/living_room_museum_persistence.json \
  --transcript "$BUILD/living-room-museum-persistence-transcript.txt" \
  --var MUSEUM_SAVE_FILE="$BUILD/living-room-museum.sav" \
  -- "$GLULXE_BIN" "$BUILD/zork1-glulx-living-room-museum-test.ulx"
test -s "$BUILD/living-room-museum.sav"

python - <<'PY'
import json, os
from pathlib import Path
story = json.loads(Path('glulx/build/living-room-museum/story-report.json').read_text(encoding='utf-8'))
stage = json.loads(Path('glulx/build/living-room-museum/src/STAGING-RECEIPT.json').read_text(encoding='utf-8'))
receipt = {
    'qualification_status': 'discovered-and-routes-passed',
    'identity': {'release': int(os.environ['MUSEUM_RELEASE']), 'serial': os.environ['MUSEUM_SERIAL']},
    'base': stage['base'],
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'routes': {
        'real_object_registry_and_surface_acceptance': 'passed',
        'canonical_trophy_case_score_authority': 'passed',
        'ordinary_put_take_and_active_object_warning': 'passed',
        'provenance_surface_inspection': 'passed',
        'house_ritual_dam_conflict_group_synthesis': 'passed',
        'unsecured_display_theft_and_evidence': 'passed',
        'canonical_thief_booty_recovery': 'passed',
        'nested_canary_object_tree': 'passed',
        'native_save_corrupt_restore': 'passed',
        'museum_recap': 'passed',
    },
    'production_contains_test_setup': False,
    'parallel_museum_score': False,
    'duplicate_display_objects': False,
}
Path('glulx/build/living-room-museum/BUILD-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n', encoding='utf-8'
)
PY
