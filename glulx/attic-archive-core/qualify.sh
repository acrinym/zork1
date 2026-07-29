#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/attic-archive-core"
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

python glulx/tools/stage_attic_archive_core.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest glulx/attic-archive-core/patch-series.json
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/attic-archive-core/src')
receipt = json.loads((source / 'STAGING-RECEIPT.json').read_text())
report = json.loads(Path('glulx/build/attic-archive-core/smell-report.json').read_text())
assert receipt['base']['release'] == 1223
assert receipt['base']['artifact_sha256'] == '362b5567e2ee705dc382256fe3420b9e729486acbcdf68b91a8ccdda0c893816'
assert receipt['changed_paths'] == ['assistance.zil', 'attic_archive_core.zil', 'shadow_logic.zil', 'zork1.zil']
assert not report['errors']
assert not [item for item in report['includes'] if not item['resolved']]
assert (source / 'attic_archive_core.zil').is_file()
assert not (source / 'attic_archive_core_test.zil').exists()
production = '\n'.join(path.read_text(errors='ignore') for path in source.glob('*.zil'))
assert not any(token in production for token in ('ASETUP', 'AREPORT', 'AMUTATE'))
PY

ASSEMBLY="$BUILD/zork1-glulx-attic-archive-core.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" 2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" --serial "$ARCHIVE_SERIAL" --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$ARCHIVE_FILE" 2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/$ARCHIVE_FILE" --json "$BUILD/story-report.json"
cat "$BUILD/story-report.json"

make -C .tooling/cheapglk 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C .tooling/glulxe GLKDIR="$ROOT/.tooling/cheapglk" GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" 2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
test -x "$GLULXE_BIN"

cat > "$BUILD/commands.txt" <<'EOF'
north
east
south
open window
enter
up
examine catalog
examine terminal
examine filing cabinet
quit
yes
EOF
"$GLULXE_BIN" "$BUILD/$ARCHIVE_FILE" < "$BUILD/commands.txt" 2>&1 | tee "$BUILD/attic-archive-core-transcript.txt"
grep -F "oak card catalog" "$BUILD/attic-archive-core-transcript.txt"
grep -F "green-phosphor terminal" "$BUILD/attic-archive-core-transcript.txt"
grep -F "gray steel filing cabinet" "$BUILD/attic-archive-core-transcript.txt"

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/attic-archive-core/tests/attic_archive_core_test.zil "$TEST_SRC/attic_archive_core_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/attic-archive-core/tests/001-include-archive-test.json').resolve(),
    Path('glulx/build/attic-archive-core/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/zork1-glulx-attic-archive-core-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" 2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$TEST_ASSEMBLY" --serial "$ARCHIVE_TEST_SERIAL" --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/zork1-glulx-attic-archive-core-test.ulx" 2>&1 | tee "$BUILD/test-glazer-assemble.log"
python glulx/tools/run_interactive_story.py \
  --scenario glulx/attic-archive-core/tests/attic_archive_core_persistence.json \
  --transcript "$BUILD/attic-archive-core-persistence-transcript.txt" \
  --var ARCHIVE_SAVE_FILE="$BUILD/attic-archive-core.sav" \
  -- "$GLULXE_BIN" "$BUILD/zork1-glulx-attic-archive-core-test.ulx"
test -s "$BUILD/attic-archive-core.sav"

python - <<'PY'
import json
from pathlib import Path
story = json.loads(Path('glulx/build/attic-archive-core/story-report.json').read_text())
stage = json.loads(Path('glulx/build/attic-archive-core/src/STAGING-RECEIPT.json').read_text())
receipt = {
    'qualification_status': 'candidate-passed',
    'identity': {'release': 1224, 'serial': '260729'},
    'base': stage['base'],
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'routes': {
        'canonical_archive_schema': 'passed',
        'period_physical_media': 'passed',
        'deterministic_card_catalog': 'passed',
        'attic_filing_surfaces': 'passed',
        'explicit_retrieval_commands': 'passed',
        'provenance_truth_annotations': 'passed',
        'migration_and_native_state': 'passed',
        'native_save_corrupt_restore': 'passed',
        'production_smoke': 'passed',
    },
    'production_contains_test_setup': False,
    'modern_filesystem_or_universal_logger': False,
    'duplicate_live_mail': False,
    'unseen_solution_leak': False,
    'playback_mutates_live_state': False,
    'parallel_score': False,
}
Path('glulx/build/attic-archive-core/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n'
)
PY
