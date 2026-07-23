#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/room-density"
SRC="$BUILD/src"
TEST_SRC="$BUILD/test-src"
mkdir -p "$BUILD"

python - <<'PY'
import json, os
from pathlib import Path
layer = json.loads(Path('glulx/room-density/patch-series.json').read_text(encoding='utf-8'))
base = json.loads(Path('glulx/material-consequences/patch-series.json').read_text(encoding='utf-8'))
assert layer['release'] == int(os.environ['ROOM_RELEASE'])
assert layer['serial'] == os.environ['ROOM_SERIAL']
assert layer['upstream_commit'] == os.environ['ZORK_GLULX_COMMIT']
assert layer['upstream_tree'] == os.environ['ZORK_GLULX_TREE']
assert layer['base_release'] == int(os.environ['BASE_RELEASE'])
assert layer['base_artifact_sha256'] == os.environ['BASE_ARTIFACT_SHA256']
assert base['release'] == int(os.environ['BASE_RELEASE'])
assert base['expected_artifact']['sha256'] == os.environ['BASE_ARTIFACT_SHA256']
assert layer['expected_changed_paths'] == [
    '1dungeon.zil', 'assistance.zil', 'room_density.zil', 'zork1.zil'
]
artifact = layer['expected_artifact']
assert artifact == {
    'file': 'zork1-glulx-room-density.ulx',
    'glulx_version_hex': '0x00030103',
    'size_bytes': int(os.environ['ROOM_SIZE']),
    'checksum_hex': os.environ['ROOM_CHECKSUM'],
    'sha256': os.environ['ROOM_SHA256'],
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

python glulx/tools/stage_room_density.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest glulx/room-density/patch-series.json
python optimized/tools/zil_smell_check.py \
  --source "$SRC" \
  --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
receipt = json.loads(Path('glulx/build/room-density/src/STAGING-RECEIPT.json').read_text(encoding='utf-8'))
report = json.loads(Path('glulx/build/room-density/smell-report.json').read_text(encoding='utf-8'))
assert receipt['base']['release'] == 1217
assert receipt['base']['artifact_sha256'] == '2714d63760fa890be9ece3b23fc91bab67a660c42675e0302b745173aba700da'
assert receipt['changed_paths'] == [
    '1dungeon.zil', 'assistance.zil', 'room_density.zil', 'zork1.zil'
]
assert not report['errors']
assert not [item for item in report['includes'] if not item['resolved']]
source = Path('glulx/build/room-density/src')
assert (source / 'room_density.zil').is_file()
assert not (source / 'room_density_test.zil').exists()
forbidden = (
    'RDTROLL', 'RDGALLERY', 'RDSTUDIO', 'RDCHASM', 'RDPASSAGE',
    'RDTREASURE', 'RDPATH', 'RDSTREAM', 'RDREPORT', 'RDMUTATE'
)
production = '\n'.join(path.read_text(errors='ignore') for path in source.glob('*.zil'))
assert not any(token in production for token in forbidden)
PY

ASSEMBLY="$BUILD/zork1-glulx-room-density.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" \
  2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" \
  --serial "$ROOM_SERIAL" \
  --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/zork1-glulx-room-density.ulx" \
  2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/zork1-glulx-room-density.ulx" \
  --expect-sha256 "$ROOM_SHA256" \
  --json "$BUILD/story-report.json"
python - <<'PY'
import json, os
from pathlib import Path
story = json.loads(Path('glulx/build/room-density/story-report.json').read_text(encoding='utf-8'))
assert story['version_hex'] == '0x00030103'
assert story['size_bytes'] == int(os.environ['ROOM_SIZE'])
assert story['checksum_hex'] == os.environ['ROOM_CHECKSUM']
assert story['checksum_valid'] is True
assert story['sha256'] == os.environ['ROOM_SHA256']
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
cp glulx/room-density/tests/room_density_test.zil "$TEST_SRC/room_density_test.zil"
python - <<'PY'
import sys
from pathlib import Path
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/room-density/tests/001-include-room-density-test.json').resolve(),
    Path('glulx/build/room-density/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/zork1-glulx-room-density-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" \
  2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$TEST_ASSEMBLY" \
  --serial "$ROOM_TEST_SERIAL" \
  --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/zork1-glulx-room-density-test.ulx" \
  2>&1 | tee "$BUILD/test-glazer-assemble.log"

set -o pipefail
"$GLULXE_BIN" "$BUILD/zork1-glulx-room-density-test.ulx" \
  < glulx/room-density/tests/room_density_commands.txt \
  2>&1 | tee "$BUILD/room-density-transcript.txt"
while IFS= read -r marker; do
  test -z "$marker" || grep -F -- "$marker" "$BUILD/room-density-transcript.txt"
done < glulx/room-density/tests/room_density_expectations.txt

python glulx/tools/run_interactive_story.py \
  --scenario glulx/room-density/tests/room_density_persistence.json \
  --transcript "$BUILD/room-density-persistence-transcript.txt" \
  --var STATE_SAVE_FILE="$BUILD/room-density-state.sav" \
  -- "$GLULXE_BIN" "$BUILD/zork1-glulx-room-density-test.ulx"
grep -F "ROOM-DENSITY-STATE:TROLL=SEEN;GALLERY=SEEN;STUDIO=SEEN;CHASM=SEEN;PASSAGE=SEEN;TREASURE=SEEN;PATH=SEEN" \
  "$BUILD/room-density-persistence-transcript.txt"
grep -F "ROOM-DENSITY-STATE:TROLL=CLEAR;GALLERY=CLEAR;STUDIO=CLEAR;CHASM=CLEAR;PASSAGE=CLEAR;TREASURE=CLEAR;PATH=CLEAR" \
  "$BUILD/room-density-persistence-transcript.txt"
test -s "$BUILD/room-density-state.sav"

python - <<'PY'
import json, os
from pathlib import Path
story = json.loads(Path('glulx/build/room-density/story-report.json').read_text(encoding='utf-8'))
stage = json.loads(Path('glulx/build/room-density/src/STAGING-RECEIPT.json').read_text(encoding='utf-8'))
serial = json.loads(Path('glulx/build/room-density/SERIAL-NORMALIZATION.json').read_text(encoding='utf-8'))
receipt = {
    'qualification_status': 'qualified',
    'identity': {'release': int(os.environ['ROOM_RELEASE']), 'serial': os.environ['ROOM_SERIAL']},
    'base': stage['base'],
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'serial_normalization': serial,
    'routes': {
        'troll_room_visible_nouns': 'passed',
        'gallery_visible_nouns': 'passed',
        'studio_visible_nouns': 'passed',
        'chasm_path_and_passage': 'passed',
        'strange_passage_door_and_opening': 'passed',
        'treasure_room_bags_and_floor': 'passed',
        'forest_and_streamside_paths': 'passed',
        'canonical_opening_travel': 'passed',
        'room_recap': 'passed',
        'room_discovery_save_restore': 'passed',
    },
    'production_contains_test_setup': False,
    'universal_scenery_or_free_form_parser': False,
}
Path('glulx/build/room-density/BUILD-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n', encoding='utf-8'
)
PY
