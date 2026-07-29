#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/house-correspondence-visitors"
SRC="$BUILD/src"
TEST_SRC="$BUILD/test-src"
rm -rf "$BUILD"
mkdir -p "$BUILD"

python - <<'PY'
import json, os
from pathlib import Path
layer = json.loads(Path('glulx/house-correspondence-visitors/patch-series.json').read_text(encoding='utf-8'))
base = json.loads(Path('glulx/house-cellar-threshold/patch-series.json').read_text(encoding='utf-8'))
assert layer['release'] == int(os.environ['MAIL_RELEASE'])
assert layer['serial'] == os.environ['MAIL_SERIAL']
assert layer['upstream_commit'] == os.environ['ZORK_GLULX_COMMIT']
assert layer['upstream_tree'] == os.environ['ZORK_GLULX_TREE']
assert layer['base_release'] == int(os.environ['BASE_RELEASE'])
assert layer['base_artifact_sha256'] == os.environ['BASE_ARTIFACT_SHA256']
assert base['release'] == int(os.environ['BASE_RELEASE'])
assert base['expected_artifact']['sha256'] == os.environ['BASE_ARTIFACT_SHA256']
assert layer['expected_changed_paths'] == [
    '1actions.zil', 'assistance.zil', 'house_correspondence_visitors.zil',
    'shadow_logic.zil', 'zork1.zil'
]
assert layer['expected_artifact'] == {
    'file': os.environ['MAIL_FILE'],
    'glulx_version_hex': os.environ['MAIL_GLULX_VERSION'],
    'size_bytes': int(os.environ['MAIL_SIZE']),
    'checksum_hex': os.environ['MAIL_CHECKSUM'],
    'sha256': os.environ['MAIL_SHA256'],
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

curl --fail --location --silent --show-error "$GLAZER_SOURCE_URL" --output "$BUILD/glazer-source.tar.gz"
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

python glulx/tools/stage_house_correspondence_visitors.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest glulx/house-correspondence-visitors/patch-series.json
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
receipt = json.loads(Path('glulx/build/house-correspondence-visitors/src/STAGING-RECEIPT.json').read_text(encoding='utf-8'))
report = json.loads(Path('glulx/build/house-correspondence-visitors/smell-report.json').read_text(encoding='utf-8'))
assert receipt['base']['release'] == 1222
assert receipt['base']['artifact_sha256'] == '1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912'
assert receipt['changed_paths'] == [
    '1actions.zil', 'assistance.zil', 'house_correspondence_visitors.zil',
    'shadow_logic.zil', 'zork1.zil'
]
assert not report['errors']
assert not [item for item in report['includes'] if not item['resolved']]
source = Path('glulx/build/house-correspondence-visitors/src')
assert (source / 'house_correspondence_visitors.zil').is_file()
assert not (source / 'house_correspondence_visitors_test.zil').exists()
production = '\n'.join(path.read_text(errors='ignore') for path in source.glob('*.zil'))
assert not any(token in production for token in ('MSETUP', 'MREPORT', 'MMUTATE'))
PY

ASSEMBLY="$BUILD/zork1-glulx-house-correspondence-visitors.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" 2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" --serial "$MAIL_SERIAL" --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$MAIL_FILE" 2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/$MAIL_FILE" --json "$BUILD/story-report.json"
python - <<'PY'
import hashlib, json, os
from pathlib import Path
story = json.loads(Path('glulx/build/house-correspondence-visitors/story-report.json').read_text(encoding='utf-8'))
artifact = Path('glulx/build/house-correspondence-visitors') / os.environ['MAIL_FILE']
assert story['file'] == os.environ['MAIL_FILE']
assert story['version_hex'] == os.environ['MAIL_GLULX_VERSION']
assert story['size_bytes'] == int(os.environ['MAIL_SIZE'])
assert story['checksum_hex'] == os.environ['MAIL_CHECKSUM']
assert story['checksum_valid'] is True
assert story['sha256'] == os.environ['MAIL_SHA256']
assert artifact.stat().st_size == int(os.environ['MAIL_SIZE'])
assert hashlib.sha256(artifact.read_bytes()).hexdigest() == os.environ['MAIL_SHA256']
PY

make -C .tooling/cheapglk 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C .tooling/glulxe GLKDIR="$ROOT/.tooling/cheapglk" GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" 2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
test -x "$GLULXE_BIN"

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/house-correspondence-visitors/tests/house_correspondence_visitors_test.zil "$TEST_SRC/house_correspondence_visitors_test.zil"
python - <<'PY'
import sys
from pathlib import Path
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/house-correspondence-visitors/tests/001-include-mail-test.json').resolve(),
    Path('glulx/build/house-correspondence-visitors/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/zork1-glulx-house-correspondence-visitors-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" 2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$TEST_ASSEMBLY" --serial "$MAIL_TEST_SERIAL" --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/zork1-glulx-house-correspondence-visitors-test.ulx" 2>&1 | tee "$BUILD/test-glazer-assemble.log"

"$GLULXE_BIN" "$BUILD/zork1-glulx-house-correspondence-visitors-test.ulx" \
  < glulx/house-correspondence-visitors/tests/house_correspondence_visitors_commands.txt \
  2>&1 | tee "$BUILD/house-correspondence-visitors-transcript.txt"
while IFS= read -r marker; do
  test -z "$marker" || grep -F -- "$marker" "$BUILD/house-correspondence-visitors-transcript.txt"
done < glulx/house-correspondence-visitors/tests/house_correspondence_visitors_expectations.txt

python glulx/tools/run_interactive_story.py \
  --scenario glulx/house-correspondence-visitors/tests/house_correspondence_visitors_persistence.json \
  --transcript "$BUILD/house-correspondence-visitors-persistence-transcript.txt" \
  --var MAIL_SAVE_FILE="$BUILD/house-correspondence-visitors.sav" \
  -- "$GLULXE_BIN" "$BUILD/zork1-glulx-house-correspondence-visitors-test.ulx"
test -s "$BUILD/house-correspondence-visitors.sav"

python - <<'PY'
import json
from pathlib import Path
story = json.loads(Path('glulx/build/house-correspondence-visitors/story-report.json').read_text(encoding='utf-8'))
stage = json.loads(Path('glulx/build/house-correspondence-visitors/src/STAGING-RECEIPT.json').read_text(encoding='utf-8'))
receipt = {
    'qualification_status': 'passed',
    'identity': {'release': 1223, 'serial': '260724'},
    'base': stage['base'],
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'routes': {
        'deterministic_event_queue': 'passed',
        'message_provenance': 'passed',
        'canonical_mailbox_and_leaflet': 'passed',
        'bounded_fixed_replies': 'passed',
        'visitor_answer_refusal_acceptance': 'passed',
        'missed_notice_and_bounded_return': 'passed',
        'native_save_corrupt_restore': 'passed',
        'mail_recap': 'passed',
    },
    'production_contains_test_setup': False,
    'duplicate_mail_or_visitors': False,
    'free_form_mail_or_dialogue': False,
    'front_door_route_changed': False,
    'parallel_score': False,
}
Path('glulx/build/house-correspondence-visitors/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n', encoding='utf-8'
)
PY
