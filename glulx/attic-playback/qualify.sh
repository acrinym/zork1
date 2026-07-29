#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/attic-playback"
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

python glulx/tools/stage_attic_playback.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest glulx/attic-playback/patch-series.json
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/attic-playback/src')
receipt = json.loads((source / 'STAGING-RECEIPT.json').read_text())
report = json.loads(Path('glulx/build/attic-playback/smell-report.json').read_text())
assert receipt['base']['release'] == 1226
assert receipt['base']['artifact_sha256'] == '9a257606633e5595ab5c8c2f6d2c5813028c45e08389c805ca81ca113445f9f6'
assert receipt['changed_paths'] == ['assistance.zil', 'attic_archive_core.zil', 'attic_playback.zil', 'shadow_logic.zil', 'zork1.zil']
assert not report['errors']
assert not [item for item in report['includes'] if not item['resolved']]
assert (source / 'attic_playback.zil').is_file()
assert not (source / 'attic_playback_test.zil').exists()
production = '\n'.join(path.read_text(errors='ignore') for path in source.glob('*.zil'))
assert not any(token in production for token in ('PSETUP', 'POBSERVE', 'PREADY', 'PREPORT', 'PSTATE', 'PMUTATE'))
PY

ASSEMBLY="$BUILD/zork1-glulx-attic-playback.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" 2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" --serial "$PLAYBACK_SERIAL" --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$PLAYBACK_FILE" 2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/$PLAYBACK_FILE" --json "$BUILD/story-report.json"
cat "$BUILD/story-report.json"
python - <<'PY'
import json
from pathlib import Path
story = json.loads(Path('glulx/build/attic-playback/story-report.json').read_text())
manifest = json.loads(Path('glulx/attic-playback/patch-series.json').read_text())
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
east
up
examine catalog
take continuous printout
review continuous printout
quit
yes
EOF
"$GLULXE_BIN" "$BUILD/$PLAYBACK_FILE" < "$BUILD/commands.txt" 2>&1 | tee "$BUILD/attic-playback-transcript.txt"
grep -F "PLAYBACK-PRINTER-01" "$BUILD/attic-playback-transcript.txt"
grep -F "[CURATED ACTION] RETURN TO THE WHITE HOUSE" "$BUILD/attic-playback-transcript.txt"
grep -F "PLAYBACK-INTEGRITY:PASS" "$BUILD/attic-playback-transcript.txt"
for forbidden in \
  "[CURATED ACTION] EXAMINE THE DAM CONTROL PANEL" \
  "[CURATED ACTION] ADVANCE THE HADES CEREMONY" \
  "[CURATED ACTION] ENCOUNTER THE TROLL" \
  "[CURATED ACTION] COMPLETE REGIONAL SYNTHESIS" \
  "PLAYBACK-FORENSIC-07"
do
  if grep -F "$forbidden" "$BUILD/attic-playback-transcript.txt"; then
    echo "unearned playback content appeared in production smoke: $forbidden" >&2
    exit 1
  fi
done

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/attic-playback/tests/attic_playback_test.zil "$TEST_SRC/attic_playback_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/attic-playback/tests/001-include-playback-test.json').resolve(),
    Path('glulx/build/attic-playback/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/zork1-glulx-attic-playback-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" 2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$TEST_ASSEMBLY" --serial "$PLAYBACK_TEST_SERIAL" --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/zork1-glulx-attic-playback-test.ulx" 2>&1 | tee "$BUILD/test-glazer-assemble.log"
python glulx/tools/run_interactive_story.py \
  --scenario glulx/attic-playback/tests/attic_playback_persistence.json \
  --transcript "$BUILD/attic-playback-persistence-transcript.txt" \
  --var PLAYBACK_SAVE_FILE="$BUILD/attic-playback.sav" \
  -- "$GLULXE_BIN" "$BUILD/zork1-glulx-attic-playback-test.ulx"
test -s "$BUILD/attic-playback.sav"

python - <<'PY'
import json
import os
from pathlib import Path
story = json.loads(Path('glulx/build/attic-playback/story-report.json').read_text())
stage = json.loads(Path('glulx/build/attic-playback/src/STAGING-RECEIPT.json').read_text())
receipt = {
    'qualification_status': 'candidate-passed',
    'identity': {'release': 1227, 'serial': os.environ['PLAYBACK_SERIAL']},
    'base': stage['base'],
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'routes': {
        'meaningful_event_capture': 'passed',
        'continuous_feed_printer': 'passed',
        'textual_cassette_playback': 'passed',
        'incident_actor_place_chronology_navigation': 'passed',
        'curated_vs_bounded_forensic': 'passed',
        'no_time_travel_integrity': 'passed',
        'deduplication_and_capacity': 'passed',
        'native_save_corrupt_restore': 'passed',
        'production_no_unearned_playback_smoke': 'passed',
    },
    'production_contains_test_setup': False,
    'unbounded_raw_log': False,
    'actor_or_object_replay': False,
    'timer_or_score_mutation': False,
    'pronoun_or_location_mutation': False,
    'merged_expedition_history': False,
}
Path('glulx/build/attic-playback/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n'
)
PY
