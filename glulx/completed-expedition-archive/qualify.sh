#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/completed-expedition-archive"
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

python glulx/completed-expedition-archive/stage.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest glulx/completed-expedition-archive/patch-series.json
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/completed-expedition-archive/src')
receipt = json.loads((source / 'STAGING-RECEIPT.json').read_text())
report = json.loads(Path('glulx/build/completed-expedition-archive/smell-report.json').read_text())
assert receipt['base']['release'] == 1229
assert receipt['base']['artifact_sha256'] == '94a665cb16069b31473dcf9fdf194d49c13e70aa23c32bd75888c78a074c3b4f'
assert receipt['changed_paths'] == [
    'assistance.zil',
    'attic_archive_core.zil',
    'completed_expedition_archive.zil',
    'zork1.zil',
]
assert not report['errors']
assert not [item for item in report['includes'] if not item['resolved']]
assert (source / 'completed_expedition_archive.zil').is_file()
assert not (source / 'completed_expedition_archive_test.zil').exists()
production = '\n'.join(path.read_text(errors='ignore') for path in source.glob('*.zil'))
assert not any(token in production for token in (
    'EXPRESET', 'EXPVICTORYA', 'EXPVICTORYB', 'EXPREPORT', 'EXPMUTATE'))
expedition = (source / 'completed_expedition_archive.zil').read_text()
for token in (
    '<SYNTAX ARCHIVE OBJECT = V-EXPEDITION-SEAL>',
    '<SYNTAX SEAL OBJECT = V-EXPEDITION-SEAL>',
    '<SYNTAX COMPARE OBJECT = V-EXPEDITION-COMPARE>',
    '<SYNTAX EXPORT OBJECT = V-EXPEDITION-EXPORT>',
    'EXPEDITION-ARCHIVE-INDEX',
    '<COND (,WON-FLAG <RTRUE>)>',
    'EXPEDITION-A-MASTER',
    'EXPEDITION-B-MASTER',
    'EXPEDITION-CROSSRUN',
    'Alternative outcomes may exist',
):
    assert token in expedition
assert '<EXPEDITION-CATALOG-LIST>' in (source / 'attic_archive_core.zil').read_text()
assert '<EXPEDITION-RECAP>' in (source / 'assistance.zil').read_text()
PY

ASSEMBLY="$BUILD/zork1-glulx-completed-expedition-archive.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" 2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" --serial "$EXPEDITION_SERIAL" --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$EXPEDITION_FILE" 2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/$EXPEDITION_FILE" --json "$BUILD/story-report.json"
cat "$BUILD/story-report.json"
python - <<'PY'
import json
from pathlib import Path
story = json.loads(Path('glulx/build/completed-expedition-archive/story-report.json').read_text())
manifest = json.loads(Path('glulx/completed-expedition-archive/patch-series.json').read_text())
expected = manifest['expected_artifact']
assert story['format'] == expected['format']
assert story['version_hex'] == expected['version_hex']
assert story['checksum_valid'] is True
if expected.get('locked', False):
    assert story['size_bytes'] == expected['size_bytes']
    assert story['checksum_hex'] == expected['checksum_hex']
    assert story['sha256'] == expected['sha256']
PY

make -C .tooling/cheapglk 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C .tooling/glulxe GLKDIR="$ROOT/.tooling/cheapglk" GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" 2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
test -x "$GLULXE_BIN"

cat > "$BUILD/commands.txt" <<'EOF_COMMANDS'
north
east
open window
west
close window
west
take lantern
activate lantern
up
look
down
east
up
archive expedition
status expedition
examine catalog
quit
yes
EOF_COMMANDS
"$GLULXE_BIN" "$BUILD/$EXPEDITION_FILE" < "$BUILD/commands.txt" 2>&1 | tee "$BUILD/completed-expedition-transcript.txt"
grep -F "master expedition file remains victory-gated" "$BUILD/completed-expedition-transcript.txt"
grep -F "no sealed victory record" "$BUILD/completed-expedition-transcript.txt"
grep -F "HOUSE-RISK-01" "$BUILD/completed-expedition-transcript.txt"
for forbidden in \
  "EXPEDITION-A: victory-gated master" \
  "EXPEDITION-B: separately sealed master" \
  "EXPEDITION-CROSSRUN" \
  "EXPEDITION-EXPORT-01"
do
  if grep -F "$forbidden" "$BUILD/completed-expedition-transcript.txt"; then
    echo "unearned completed-expedition content appeared before victory: $forbidden" >&2
    exit 1
  fi
done

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/completed-expedition-archive/tests/completed_expedition_archive_test.zil "$TEST_SRC/completed_expedition_archive_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/completed-expedition-archive/tests/001-include-expedition-test.json').resolve(),
    Path('glulx/build/completed-expedition-archive/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/zork1-glulx-completed-expedition-archive-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" 2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$TEST_ASSEMBLY" --serial "$EXPEDITION_TEST_SERIAL" --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/zork1-glulx-completed-expedition-archive-test.ulx" 2>&1 | tee "$BUILD/test-glazer-assemble.log"
python glulx/tools/run_interactive_story.py \
  --scenario glulx/completed-expedition-archive/tests/completed_expedition_archive_persistence.json \
  --transcript "$BUILD/completed-expedition-persistence-transcript.txt" \
  --var EXPEDITION_SAVE_FILE="$BUILD/completed-expedition.sav" \
  -- "$GLULXE_BIN" "$BUILD/zork1-glulx-completed-expedition-archive-test.ulx"
test -s "$BUILD/completed-expedition.sav"

python - <<'PY'
import json
import os
from pathlib import Path
story = json.loads(Path('glulx/build/completed-expedition-archive/story-report.json').read_text())
stage = json.loads(Path('glulx/build/completed-expedition-archive/src/STAGING-RECEIPT.json').read_text())
receipt = {
    'qualification_status': 'candidate-passed',
    'identity': {'release': 1230, 'serial': os.environ['EXPEDITION_SERIAL']},
    'base': stage['base'],
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'routes': {
        'victory_gated_master_archive': 'passed',
        'partial_pre_victory_records_preserved': 'passed',
        'bounded_chronological_route_and_incident_timeline': 'passed',
        'final_world_and_house_snapshot': 'passed',
        'separate_physical_expedition_boxes': 'passed',
        'cross_run_comparison_without_merge': 'passed',
        'unseen_alternate_outcome_boundaries': 'passed',
        'schema_versioned_human_readable_export': 'passed',
        'native_save_corrupt_restore': 'passed',
        'production_no_unearned_master_smoke': 'passed',
    },
    'production_contains_test_setup': False,
    'raw_command_log': False,
    'hidden_solution_disclosure': False,
    'merged_mutually_exclusive_histories': False,
    'modern_database_or_cloud_state': False,
    'sub_beads': False,
}
Path('glulx/build/completed-expedition-archive/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n'
)
PY
