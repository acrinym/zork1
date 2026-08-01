#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/zork-plus-veteran-expedition"
SRC="$BUILD/src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/zork-plus-veteran-expedition/patch-series.json"
CANDIDATE="$ROOT/glulx/zork-plus-veteran-expedition/prose/veteran-expedition-prose.txt"
CORPUS_LOCAL="$ROOT/.upstream/zork1-glulx/.local/infocom-corpus/zork-plus-veteran-expedition"
cd "$ROOT"
rm -rf "$BUILD" "$CORPUS_LOCAL"
mkdir -p "$BUILD/corpus" "$CORPUS_LOCAL"

IFS=$'\t' read -r VETERAN_SERIAL VETERAN_FILE < <(
  python - "$MANIFEST" <<'PY'
import json
from pathlib import Path
import sys
manifest = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
print('\t'.join((manifest['serial'], manifest['expected_artifact']['file'])))
PY
)

python -m unittest discover -s tests -p 'test_zork_plus_veteran_expedition*.py' -v
python -m py_compile \
  glulx/zork-plus-veteran-expedition/stage.py \
  tests/test_zork_plus_veteran_expedition*.py

python glulx/zork-plus-veteran-expedition/stage.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py \
  --source "$SRC" \
  --json "$BUILD/smell-report.json"

python -m tools.infocom_corpus validate-manifest \
  --manifest reference/infocom-corpus/manifest/infocom-corpus.json
python -m tools.infocom_corpus extract \
  --repo-root .upstream/zork1-glulx \
  --manifest reference/infocom-corpus/manifest/infocom-corpus.json \
  --out "$CORPUS_LOCAL/player-visible.jsonl" \
  --summary-out "$BUILD/corpus/public-summary.json"
python -m tools.infocom_corpus annotate \
  --corpus "$CORPUS_LOCAL/player-visible.jsonl" \
  --out "$CORPUS_LOCAL/annotated.jsonl"
python -m tools.infocom_corpus overlap \
  --candidate "$CANDIDATE" \
  --corpus "$CORPUS_LOCAL/annotated.jsonl" \
  --profiles reference/infocom-corpus/profiles/authority-profiles.json \
  --profile-id zork1-action-response \
  --out "$BUILD/veteran-expedition-prose.overlap.json"
python -m tools.infocom_corpus receipt \
  --candidate "$CANDIDATE" \
  --corpus "$CORPUS_LOCAL/annotated.jsonl" \
  --profiles reference/infocom-corpus/profiles/authority-profiles.json \
  --profile-id zork1-action-response \
  --surface-family zork-plus-veteran-survey \
  --reviewer Justin \
  --intentional-departure 'The post-victory survey uses explicit archive, loadout, custody, and separate-history language rather than silently rewriting the canonical opening.' \
  --out "$BUILD/veteran-expedition-prose.style-receipt.json"

python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/zork-plus-veteran-expedition/src')
stage = json.loads((source / 'STAGING-RECEIPT.json').read_text())
smell = json.loads(Path('glulx/build/zork-plus-veteran-expedition/smell-report.json').read_text())
overlap = json.loads(Path('glulx/build/zork-plus-veteran-expedition/veteran-expedition-prose.overlap.json').read_text())
receipt = json.loads(Path('glulx/build/zork-plus-veteran-expedition/veteran-expedition-prose.style-receipt.json').read_text())
assert stage['base']['release'] == 1236
assert stage['base']['artifact_sha256'] == '26b32e777be0fe6c44736ae483a594519bf98264ec95603dd4ff7238124c94d7'
assert stage['changed_paths'] == ['completed_expedition_archive.zil', 'zork1.zil', 'zork_plus_veteran_expedition.zil']
assert not smell['errors']
assert not [item for item in smell['includes'] if not item['resolved']]
assert overlap['passed'] is True
assert overlap['source_text_disclosed'] is False
assert overlap['threshold_violations'] == []
assert overlap['rare_phrase_matches'] == []
assert receipt['authority_profile'] == 'zork1-action-response'
originality = receipt['originality_check']
assert originality['passed'] is True
assert originality['source_text_disclosed'] is False
assert originality['threshold_violation_count'] == 0
assert originality['rare_phrase_match_count'] == 0
module = (source / 'zork_plus_veteran_expedition.zil').read_text()
archive = (source / 'completed_expedition_archive.zil').read_text()
entrypoint = (source / 'zork1.zil').read_text()
for required in (
    '<SYNTAX CHOOSE OBJECT',
    '<SYNTAX BEGIN OBJECT (FIND RMUNGBIT) = V-VETERAN-BEGIN>',
    '<SYNTAX CROSS OBJECT',
    '<SYNTAX RECORD OBJECT',
    '<SYNTAX COMPLETE OBJECT (FIND RMUNGBIT) = V-VETERAN-COMPLETE>',
    '<OBJECT VETERAN-EXPEDITION-INTERFACE',
    '<CONSTANT VETERAN-STATE <TABLE VETERAN-SCHEMA 0 0 0 0 0 0>>',
    '<EXPEDITION-HAS? ,ES-SEALED 1>',
    '<MOVE .ITEM ,VETERAN-HOLD-TRUNK>',
    '<MOVE ,ROPE ,VETERAN-CUT-NEAR>',
    '<FSET? ,LAMP ,ONBIT>',
    '<EXPEDITION-CAPTURE-B>',
    '<MOVE ,VETERAN-FIELD-CARD ,EXPEDITION-BOX-B>',
):
    assert required in module
assert '<GLOBAL' not in module
assert archive.count('<VETERAN-MATERIALIZE>') == 1
assert entrypoint.rstrip().endswith('<INSERT-FILE "zork_plus_veteran_expedition" T>')
production = '\n'.join(path.read_text(errors='ignore') for path in source.glob('*.zil'))
for forbidden in (
    'VETSETLAMP',
    'VETSETROPE',
    'VETERAN-TEST-SEAL-A',
    'NEW-GAME-PLUS-ENGINE',
    'LOADOUT-SYSTEM',
    'RESTART-MENU',
):
    assert forbidden not in production
PY

if ! command -v dotnet >/dev/null 2>&1; then
  echo "dotnet is required for Release 1237 qualification." >&2
  exit 4
fi

GLULX_ZILF_DLL="${GLULX_ZILF_DLL:-$(find "$ROOT/.tooling/zilf-glulx" -path '*/bin/Release/*/zilf.dll' -print -quit 2>/dev/null || true)}"
if [[ -z "$GLULX_ZILF_DLL" && -f "$ROOT/.tooling/zilf-glulx/Zilf.sln" ]]; then
  pushd "$ROOT/.tooling/zilf-glulx"
  dotnet restore Zilf.sln --nologo 2>&1 | tee "$BUILD/zilf-restore.log"
  dotnet build Zilf.sln --configuration Release --property:PortableTarget=true --no-restore --nologo \
    2>&1 | tee "$BUILD/zilf-build.log"
  popd
  GLULX_ZILF_DLL="$(find "$ROOT/.tooling/zilf-glulx" -path '*/bin/Release/*/zilf.dll' -print -quit)"
fi
if [[ -z "$GLULX_ZILF_DLL" || ! -f "$GLULX_ZILF_DLL" ]]; then
  echo "A local ZILF checkout or GLULX_ZILF_DLL is required." >&2
  exit 4
fi
GLULX_ZILF_DLL="$(realpath "$GLULX_ZILF_DLL")"

GLAZER_BIN="${GLAZER_BIN:-$(find "$ROOT/.tooling/glazer-source" -type f -name glazer -perm -111 -print -quit 2>/dev/null || true)}"
if [[ -z "$GLAZER_BIN" && -f "$ROOT/.tooling/glazer-source/Makefile" ]]; then
  make -C "$ROOT/.tooling/glazer-source" 2>&1 | tee "$BUILD/glazer-build.log"
  GLAZER_BIN="$(find "$ROOT/.tooling/glazer-source" -type f -name glazer -perm -111 -print -quit)"
fi
if [[ -z "$GLAZER_BIN" ]] && command -v glazer >/dev/null 2>&1; then
  GLAZER_BIN="$(command -v glazer)"
fi
if [[ -z "$GLAZER_BIN" || ! -x "$GLAZER_BIN" ]]; then
  echo "A local Glazer build or GLAZER_BIN is required." >&2
  exit 4
fi
GLAZER_BIN="$(realpath "$GLAZER_BIN")"
"$GLAZER_BIN" --version | tee "$BUILD/glazer-version.txt"

ASSEMBLY="$BUILD/zork1-glulx-zork-plus-veteran-expedition.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" \
  2>&1 | tee "$BUILD/zilf-compile.log"
popd
python "$ROOT/glulx/tools/normalize_serial.py" \
  "$ASSEMBLY" \
  --serial "$VETERAN_SERIAL" \
  --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$VETERAN_FILE" \
  2>&1 | tee "$BUILD/glazer-assemble.log"
python "$ROOT/glulx/tools/verify_ulx.py" \
  "$BUILD/$VETERAN_FILE" \
  --json "$BUILD/story-report.json"

make -C "$ROOT/.tooling/cheapglk" 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C "$ROOT/.tooling/glulxe" \
  GLKDIR="$ROOT/.tooling/cheapglk" \
  GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" \
  2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
test -x "$GLULXE_BIN"

cat > "$BUILD/pre-victory-commands.txt" <<'EOF_COMMANDS'
review veteran
north
east
open window
west
west
take lantern
turn on lantern
east
up
begin veteran
quit
yes
EOF_COMMANDS
"$GLULXE_BIN" "$BUILD/$VETERAN_FILE" < "$BUILD/pre-victory-commands.txt" \
  2>&1 | tee "$BUILD/pre-victory-transcript.txt"
grep -F 'Veteran Expedition remains locked until a genuine completed Expedition A is sealed.' "$BUILD/pre-victory-transcript.txt"
grep -F 'A sealed Expedition A is required before any veteran departure.' "$BUILD/pre-victory-transcript.txt"
for forbidden in \
  'veteran survey dispatch' \
  'veteran hold trunk' \
  'Veteran Survey Trailhead'
do
  if grep -F "$forbidden" "$BUILD/pre-victory-transcript.txt"; then
    echo "unearned veteran content appeared before sealed victory: $forbidden" >&2
    exit 1
  fi
done

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/zork-plus-veteran-expedition/tests/zork_plus_veteran_expedition_test.zil \
  "$TEST_SRC/zork_plus_veteran_expedition_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/zork-plus-veteran-expedition/tests/001-include-veteran-test.json').resolve(),
    Path('glulx/build/zork-plus-veteran-expedition/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/zork1-glulx-zork-plus-veteran-expedition-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" \
  2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python "$ROOT/glulx/tools/normalize_serial.py" \
  "$TEST_ASSEMBLY" \
  --serial "$VETERAN_SERIAL" \
  --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/zork1-glulx-zork-plus-veteran-expedition-test.ulx" \
  2>&1 | tee "$BUILD/test-glazer-assemble.log"

cat > "$BUILD/lantern-commands.txt" <<'EOF_COMMANDS'
vetsetlamp
examine veteran dispatch
choose lantern
begin veteran
inventory
turn on lantern
cross cut
record marker
read field card
cross cut
complete veteran
look in trunk
status expedition
examine field card
review veteran
quit
yes
EOF_COMMANDS
"$GLULXE_BIN" "$BUILD/zork1-glulx-zork-plus-veteran-expedition-test.ulx" \
  < "$BUILD/lantern-commands.txt" 2>&1 | tee "$BUILD/lantern-transcript.txt"

grep -F 'TEST PRECONDITION: sealed Expedition A' "$BUILD/lantern-transcript.txt"
grep -F 'You declare the real brass lantern as the single veteran field item.' "$BUILD/lantern-transcript.txt"
grep -F 'You close the Attic hold trunk on every unselected carried object' "$BUILD/lantern-transcript.txt"
grep -F 'The lit lantern reveals a narrow shelf under the broken survey edge.' "$BUILD/lantern-transcript.txt"
grep -F "You copy the marker's weathered boundary notation onto the veteran field card." "$BUILD/lantern-transcript.txt"
grep -F 'The same lit shelf carries you back to the veteran trailhead.' "$BUILD/lantern-transcript.txt"
grep -F 'You return to the Attic and seal the veteran survey as Expedition B.' "$BUILD/lantern-transcript.txt"
grep -F 'Completed expedition archive status: boxes A and B sealed separately.' "$BUILD/lantern-transcript.txt"
grep -F 'The selected canonical item was retained at completion.' "$BUILD/lantern-transcript.txt"
grep -F 'rope' "$BUILD/lantern-transcript.txt"

cat > "$BUILD/rope-commands.txt" <<'EOF_COMMANDS'
vetsetrope
choose rope
begin veteran
inventory
cross cut
inventory
record marker
cross cut
complete veteran
look in trunk
status expedition
examine field card
review veteran
quit
yes
EOF_COMMANDS
"$GLULXE_BIN" "$BUILD/zork1-glulx-zork-plus-veteran-expedition-test.ulx" \
  < "$BUILD/rope-commands.txt" 2>&1 | tee "$BUILD/rope-transcript.txt"

grep -F 'TEST PRECONDITION: sealed Expedition A' "$BUILD/rope-transcript.txt"
grep -F 'You declare the real rope as the single veteran field item.' "$BUILD/rope-transcript.txt"
grep -F 'You secure the real rope across the abandoned cut and cross hand over hand.' "$BUILD/rope-transcript.txt"
grep -F 'You cross back along the same physically secured rope.' "$BUILD/rope-transcript.txt"
grep -F 'You return to the Attic and seal the veteran survey as Expedition B.' "$BUILD/rope-transcript.txt"
grep -F 'Completed expedition archive status: boxes A and B sealed separately.' "$BUILD/rope-transcript.txt"
grep -F 'The selected canonical item was left in the field at completion.' "$BUILD/rope-transcript.txt"
grep -F 'brass lantern' "$BUILD/rope-transcript.txt"

for transcript in "$BUILD/lantern-transcript.txt" "$BUILD/rope-transcript.txt"; do
  for word in choose veteran cross record complete expedition; do
    if grep -Fi "I don't know the word \"$word\"" "$transcript"; then
      echo "Veteran Expedition vocabulary was not recognized: $word" >&2
      exit 1
    fi
  done
done

python - <<'PY'
from pathlib import Path
lamp = Path('glulx/build/zork-plus-veteran-expedition/lantern-transcript.txt').read_text()
rope = Path('glulx/build/zork-plus-veteran-expedition/rope-transcript.txt').read_text()
lamp_departure = lamp.split('You close the Attic hold trunk', 1)[1].split('The lit lantern reveals', 1)[0]
assert 'You are carrying:' in lamp_departure
lamp_inventory = lamp_departure.lower().split('you are carrying:', 1)[1]
assert 'brass lantern' in lamp_inventory
assert 'field card' in lamp_inventory
assert 'rope' not in lamp_inventory
rope_departure = rope.split('You close the Attic hold trunk', 1)[1].split('You secure the real rope', 1)[0]
assert 'You are carrying:' in rope_departure
rope_inventory = rope_departure.lower().split('you are carrying:', 1)[1]
assert 'rope' in rope_inventory
assert 'field card' in rope_inventory
assert 'brass lantern' not in rope_inventory
rope_after_cross = rope.split('You secure the real rope across the abandoned cut', 1)[1].split("You copy the marker's", 1)[0]
assert 'You are carrying:' in rope_after_cross
assert 'rope' not in rope_after_cross.lower().split('you are carrying:', 1)[1]
status = 'Completed expedition archive status: boxes A and B sealed separately.'
assert lamp.index('The lit lantern reveals') < lamp.index(status)
assert rope.index('You secure the real rope') < rope.index(status)
PY

python - "$VETERAN_SERIAL" "$MANIFEST" <<'PY'
import json
from pathlib import Path
import sys
serial, manifest_path = sys.argv[1:]
manifest = json.loads(Path(manifest_path).read_text())
expected = manifest['expected_artifact']
story = json.loads(Path('glulx/build/zork-plus-veteran-expedition/story-report.json').read_text())
stage = json.loads(Path('glulx/build/zork-plus-veteran-expedition/src/STAGING-RECEIPT.json').read_text())
assert story['format'] == expected['format']
assert story['version_hex'] == expected['version_hex']
assert story['checksum_valid'] is True
assert story['size_bytes'] > 0
if expected.get('locked', False):
    assert story['size_bytes'] == expected['size_bytes']
    assert story['checksum_hex'] == expected['checksum_hex']
    assert story['sha256'] == expected['sha256']
receipt = {
    'qualification_status': 'source-corpus-artifact-and-runtime-passed',
    'identity': {'release': 1237, 'serial': serial},
    'base': {
        'release': stage['base']['release'],
        'artifact_sha256': stage['base']['artifact_sha256'],
    },
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'artifact_identity_locked': expected.get('locked', False),
    'routes': {
        'direct_veteran_expedition_tests': 'passed',
        'exact_release_1236_staging': 'passed',
        'zil_source_smell_check': 'passed',
        'veteran_prose_originality': 'passed',
        'zilf_glulx_compile': 'passed',
        'glazer_assemble': 'passed',
        'ulx_checksum_verification': 'passed',
        'pre_victory_lock_runtime': 'passed',
        'sealed_expedition_a_unlock_runtime': 'passed',
        'single_item_lantern_loadout_runtime': 'passed',
        'single_item_rope_loadout_runtime': 'passed',
        'physical_hold_trunk_runtime': 'passed',
        'lantern_crossing_round_trip_runtime': 'passed',
        'rope_crossing_round_trip_runtime': 'passed',
        'boundary_marker_record_runtime': 'passed',
        'retained_item_history_runtime': 'passed',
        'left_behind_item_history_runtime': 'passed',
        'separate_expedition_b_archive_runtime': 'passed',
    },
    'generic_ng_plus_framework': False,
    'silent_first_run_change': False,
    'duplicate_canonical_object': False,
    'take_everything_loadout': False,
    'merged_expedition_histories': False,
    'production_contains_test_setup': False,
    'new_global_variable': False,
    'sub_beads': False,
}
Path('glulx/build/zork-plus-veteran-expedition/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n'
)
PY

rm -rf "$CORPUS_LOCAL"
cat "$BUILD/story-report.json"
cat "$BUILD/QUALIFICATION-RECEIPT.json"
