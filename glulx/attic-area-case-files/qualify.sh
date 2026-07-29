#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/attic-area-case-files"
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

python glulx/tools/stage_attic_area_case_files.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest glulx/attic-area-case-files/patch-series.json
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/attic-area-case-files/src')
receipt = json.loads((source / 'STAGING-RECEIPT.json').read_text())
report = json.loads(Path('glulx/build/attic-area-case-files/smell-report.json').read_text())
assert receipt['base']['release'] == 1225
assert receipt['base']['artifact_sha256'] == 'e775d0a5ab74f5115d09b380ac4397e845ef539a1260df166120e1c25594db10'
assert receipt['changed_paths'] == ['assistance.zil', 'attic_archive_core.zil', 'attic_area_case_files.zil', 'shadow_logic.zil', 'zork1.zil']
assert not report['errors']
assert not [item for item in report['includes'] if not item['resolved']]
assert (source / 'attic_area_case_files.zil').is_file()
assert not (source / 'attic_area_case_files_test.zil').exists()
production = '\n'.join(path.read_text(errors='ignore') for path in source.glob('*.zil'))
assert not any(token in production for token in ('APARTIAL', 'ACOMPLETE', 'AREPORT', 'AMUTATE'))
PY

ASSEMBLY="$BUILD/zork1-glulx-attic-area-case-files.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" 2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" --serial "$AREA_SERIAL" --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$AREA_FILE" 2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/$AREA_FILE" --json "$BUILD/story-report.json"
cat "$BUILD/story-report.json"
python - <<'PY'
import json
from pathlib import Path
story = json.loads(Path('glulx/build/attic-area-case-files/story-report.json').read_text())
assert story['format'] == 'Glulx'
assert story['version_hex'] == '0x00030103'
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
quit
yes
EOF
"$GLULXE_BIN" "$BUILD/$AREA_FILE" < "$BUILD/commands.txt" 2>&1 | tee "$BUILD/attic-area-case-files-transcript.txt"
grep -F "AREA-HOUSE-01" "$BUILD/attic-area-case-files-transcript.txt"
if grep -F "AREA-DAM-03" "$BUILD/attic-area-case-files-transcript.txt"; then
  echo "unearned Dam case file appeared in production smoke" >&2
  exit 1
fi
if grep -F "AREA-HADES-04" "$BUILD/attic-area-case-files-transcript.txt"; then
  echo "unearned Hades case file appeared in production smoke" >&2
  exit 1
fi
if grep -F "AREA-SYNTHESIS" "$BUILD/attic-area-case-files-transcript.txt"; then
  echo "premature regional synthesis appeared in production smoke" >&2
  exit 1
fi

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/attic-area-case-files/tests/attic_area_case_files_test.zil "$TEST_SRC/attic_area_case_files_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/attic-area-case-files/tests/001-include-area-test.json').resolve(),
    Path('glulx/build/attic-area-case-files/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/zork1-glulx-attic-area-case-files-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" 2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$TEST_ASSEMBLY" --serial "$AREA_TEST_SERIAL" --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/zork1-glulx-attic-area-case-files-test.ulx" 2>&1 | tee "$BUILD/test-glazer-assemble.log"
python glulx/tools/run_interactive_story.py \
  --scenario glulx/attic-area-case-files/tests/attic_area_case_files_persistence.json \
  --transcript "$BUILD/attic-area-case-files-persistence-transcript.txt" \
  --var AREA_SAVE_FILE="$BUILD/attic-area-case-files.sav" \
  -- "$GLULXE_BIN" "$BUILD/zork1-glulx-attic-area-case-files-test.ulx"
test -s "$BUILD/attic-area-case-files.sav"

python - <<'PY'
import json
from pathlib import Path
story = json.loads(Path('glulx/build/attic-area-case-files/story-report.json').read_text())
stage = json.loads(Path('glulx/build/attic-area-case-files/src/STAGING-RECEIPT.json').read_text())
receipt = {
    'qualification_status': 'candidate-passed',
    'identity': {'release': 1226, 'serial': '260729'},
    'base': stage['base'],
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'routes': {
        'area_evidence_and_completion_model': 'passed',
        'incomplete_missing_redacted_presentation': 'passed',
        'flood_control_dam_case_file': 'passed',
        'hades_ceremony_case_file': 'passed',
        'house_forest_underground_pilots': 'passed',
        'complete_retrospective_synthesis': 'passed',
        'native_save_corrupt_restore': 'passed',
        'production_no_unearned_case_or_synthesis_smoke': 'passed',
    },
    'production_contains_test_setup': False,
    'checklist_hud': False,
    'unseen_solution_leak': False,
    'puzzle_or_actor_mutation': False,
    'automatic_completion': False,
    'duplicate_record_or_controller': False,
    'parallel_score': False,
}
Path('glulx/build/attic-area-case-files/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n'
)
PY
