#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/house-rest-and-dreams"
SRC="$BUILD/src"
TEST_SRC="$BUILD/test-src"
rm -rf "$BUILD"
mkdir -p "$BUILD"

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

python glulx/tools/stage_house_rest_and_dreams.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest glulx/house-rest-and-dreams/patch-series.json
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/house-rest-and-dreams/src')
receipt = json.loads((source / 'STAGING-RECEIPT.json').read_text())
report = json.loads(Path('glulx/build/house-rest-and-dreams/smell-report.json').read_text())
assert receipt['base']['release'] == 1227
assert receipt['base']['artifact_sha256'] == '6146311cd1fab20c5fde50f12a569c3ea9b34fd0f42038448f44f3740b9936f0'
assert receipt['changed_paths'] == [
    '1actions.zil',
    '1dungeon.zil',
    'assistance.zil',
    'attic_archive_core.zil',
    'gsyntax.zil',
    'house_rest_and_dreams.zil',
    'shadow_logic.zil',
    'zork1.zil',
]
assert not report['errors']
assert not [item for item in report['includes'] if not item['resolved']]
assert (source / 'house_rest_and_dreams.zil').is_file()
assert not (source / 'house_rest_and_dreams_test.zil').exists()
production = '\n'.join(path.read_text(errors='ignore') for path in source.glob('*.zil'))
assert not any(token in production for token in ('RSETUP', 'RREPORT', 'RFOREST', 'RDAM', 'RATTIC', 'RMUTATE'))
assert '<SYNTAX WAIT = V-WAIT>' in (source / 'gsyntax.zil').read_text()
assert '<SYNTAX SLEEP = V-HOUSE-SLEEP>' in (source / 'gsyntax.zil').read_text()
PY

ASSEMBLY="$BUILD/zork1-glulx-house-rest-and-dreams.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" 2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" --serial "$REST_SERIAL" --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$REST_FILE" 2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/$REST_FILE" --json "$BUILD/story-report.json"
cat "$BUILD/story-report.json"
python - <<'PY'
import json
from pathlib import Path
story = json.loads(Path('glulx/build/house-rest-and-dreams/story-report.json').read_text())
manifest = json.loads(Path('glulx/house-rest-and-dreams/patch-series.json').read_text())
expected = manifest['expected_artifact']
assert story['format'] == expected['format']
assert story['version_hex'] == expected['version_hex']
assert story['size_bytes'] == expected['size_bytes']
assert story['checksum_hex'] == expected['checksum_hex']
assert story['sha256'] == expected['sha256']
assert story['checksum_valid'] is True
PY

make -C .tooling/cheapglk 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C .tooling/glulxe GLKDIR="$ROOT/.tooling/cheapglk" GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" 2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
test -x "$GLULXE_BIN"

cat > "$BUILD/commands.txt" <<'EOF'
north
east
open window
west
west
take lamp
turn on lamp
wait
up
sleep
read dream notebook
down
east
up
examine catalog
review overnight report
quit
yes
EOF
"$GLULXE_BIN" "$BUILD/$REST_FILE" < "$BUILD/commands.txt" 2>&1 | tee "$BUILD/house-rest-and-dreams-transcript.txt"
grep -F "Time passes..." "$BUILD/house-rest-and-dreams-transcript.txt"
grep -F "Bedroom" "$BUILD/house-rest-and-dreams-transcript.txt"
grep -F "one more stair than you remember" "$BUILD/house-rest-and-dreams-transcript.txt"
grep -F "REST-DREAM-01" "$BUILD/house-rest-and-dreams-transcript.txt"
grep -F "REST-OVERNIGHT-02" "$BUILD/house-rest-and-dreams-transcript.txt"
grep -F "WAIT and Z remain ordinary canonical waiting" "$BUILD/house-rest-and-dreams-transcript.txt"
grep -F "REST-RECORD-INTEGRITY:PASS" "$BUILD/house-rest-and-dreams-transcript.txt"
for forbidden in \
  "Earned forest-path dream" \
  "Dam relay and wet-concrete dream" \
  "Hades bell-and-water dream" \
  "Player-specific actor-door dream" \
  "Attic printer dream" \
  "Retained folly warning dream" \
  "Museum absence dream"
do
  if grep -F "$forbidden" "$BUILD/house-rest-and-dreams-transcript.txt"; then
    echo "unearned dream content appeared in production smoke: $forbidden" >&2
    exit 1
  fi
done

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/house-rest-and-dreams/tests/house_rest_and_dreams_test.zil "$TEST_SRC/house_rest_and_dreams_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/house-rest-and-dreams/tests/001-include-rest-test.json').resolve(),
    Path('glulx/build/house-rest-and-dreams/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/zork1-glulx-house-rest-and-dreams-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" 2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$TEST_ASSEMBLY" --serial "$REST_TEST_SERIAL" --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/zork1-glulx-house-rest-and-dreams-test.ulx" 2>&1 | tee "$BUILD/test-glazer-assemble.log"
python glulx/tools/run_interactive_story.py \
  --scenario glulx/house-rest-and-dreams/tests/house_rest_and_dreams_persistence.json \
  --transcript "$BUILD/house-rest-and-dreams-persistence-transcript.txt" \
  --var REST_SAVE_FILE="$BUILD/house-rest-and-dreams.sav" \
  -- "$GLULXE_BIN" "$BUILD/zork1-glulx-house-rest-and-dreams-test.ulx"
test -s "$BUILD/house-rest-and-dreams.sav"

python - <<'PY'
import json
import os
from pathlib import Path
story = json.loads(Path('glulx/build/house-rest-and-dreams/story-report.json').read_text())
stage = json.loads(Path('glulx/build/house-rest-and-dreams/src/STAGING-RECEIPT.json').read_text())
receipt = {
    'qualification_status': 'candidate-passed',
    'identity': {'release': 1228, 'serial': os.environ['REST_SERIAL']},
    'base': stage['base'],
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'routes': {
        'optional_rest_and_wake_contract': 'passed',
        'canonical_timer_advancement_and_exploit_prevention': 'passed',
        'bounded_nonterminal_recovery': 'passed',
        'discovery_driven_dream_records': 'passed',
        'deterministic_overnight_house_changes': 'passed',
        'authored_warning_and_forced_waking': 'passed',
        'native_save_corrupt_restore': 'passed',
        'bedroom_rest_and_dreams_capstone': 'passed',
        'production_no_unearned_dream_smoke': 'passed',
        'wait_command_preserved': 'passed',
    },
    'production_contains_test_setup': False,
    'mandatory_sleep_cycle': False,
    'timer_skip_or_healing_farm': False,
    'predictive_or_solution_leaking_dream': False,
    'train11_vulnerability_controller': False,
    'parallel_house_simulation': False,
}
Path('glulx/build/house-rest-and-dreams/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n'
)
PY
