#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/living-zork-consequences"
SRC="$BUILD/src"
MANIFEST="$ROOT/glulx/living-zork-consequences/patch-series.json"
CANDIDATE="$ROOT/glulx/living-zork-consequences/prose/living-consequences-prose.txt"
CORPUS_LOCAL="$ROOT/.upstream/zork1-glulx/.local/infocom-corpus/living-zork-consequences"
cd "$ROOT"
rm -rf "$BUILD" "$CORPUS_LOCAL"
mkdir -p "$BUILD/corpus" "$CORPUS_LOCAL"

IFS=$'\t' read -r LIVING_SERIAL LIVING_FILE < <(
  python - "$MANIFEST" <<'PY'
import json
from pathlib import Path
import sys
manifest = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
print('\t'.join((manifest['serial'], manifest['expected_artifact']['file'])))
PY
)

python -m unittest discover -s tests -p 'test_living_zork_consequences*.py' -v
python -m py_compile \
  glulx/living-zork-consequences/stage.py \
  tests/test_living_zork_consequences*.py

python glulx/living-zork-consequences/stage.py \
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
  --out "$BUILD/living-consequences-prose.overlap.json"
python -m tools.infocom_corpus receipt \
  --candidate "$CANDIDATE" \
  --corpus "$CORPUS_LOCAL/annotated.jsonl" \
  --profiles reference/infocom-corpus/profiles/authority-profiles.json \
  --profile-id zork1-action-response \
  --surface-family living-zork-consequences-great-canyon \
  --reviewer Justin \
  --intentional-departure 'The canyon warning names footing, preparation, and bodily consequence directly while leaving the canonical lethal line untouched in upstream source.' \
  --out "$BUILD/living-consequences-prose.style-receipt.json"

python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/living-zork-consequences/src')
stage = json.loads((source / 'STAGING-RECEIPT.json').read_text())
smell = json.loads(Path('glulx/build/living-zork-consequences/smell-report.json').read_text())
overlap = json.loads(Path('glulx/build/living-zork-consequences/living-consequences-prose.overlap.json').read_text())
receipt = json.loads(Path('glulx/build/living-zork-consequences/living-consequences-prose.style-receipt.json').read_text())
assert stage['base']['release'] == 1235
assert stage['base']['artifact_sha256'] == '14b8341c298028e7d762c59d5a5757e6a52dcafa074aa5cd63d7930079ff13cf'
assert stage['changed_paths'] == ['1dungeon.zil', 'living_zork_consequences.zil', 'zork1.zil']
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
module = (source / 'living_zork_consequences.zil').read_text()
dungeon = (source / '1dungeon.zil').read_text()
for required in (
    '<SYNTAX SECURE OBJECT',
    '<OBJECT LIVING-CANYON-EDGE',
    '<CONSTANT LIVING-CANYON-STATE <TABLE LIVING-CANYON-SCHEMA 0>>',
    '<MOVE ,ROPE ,LIVING-CANYON-EDGE>',
    '<IN? ,ROPE ,LIVING-CANYON-EDGE>',
    '<ROUTINE LIVING-CANYON-INTERCEPT?',
    '<CUISINE-PUT ,CUISINE-SLOT-STRAIN 1>',
):
    assert required in module
assert '<GLOBAL' not in module
assert 'Nice view, lousy place to jump.' not in module
assert 'LIVING-CANYON-SLOT-ROPE' not in module
assert 'LIVING-CANYON-ROPE-HOOK' not in module
assert '<IN? ,ROPE ,CANYON-VIEW>' not in module
assert dungeon.count('<LIVING-CANYON-INTERCEPT?>') == 1
assert dungeon.count('Nice view, lousy place to jump.') == 1
for forbidden in ('HAZARD-ENGINE', 'HAZARD-REGISTRY', 'RESCUE-CHANCE', 'INJURY-METER'):
    assert forbidden not in module.upper()
PY

if ! command -v dotnet >/dev/null 2>&1; then
  echo "dotnet is required for Release 1236 qualification." >&2
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

ASSEMBLY="$BUILD/zork1-glulx-living-zork-consequences.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" \
  2>&1 | tee "$BUILD/zilf-compile.log"
popd
python "$ROOT/glulx/tools/normalize_serial.py" \
  "$ASSEMBLY" \
  --serial "$LIVING_SERIAL" \
  --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$LIVING_FILE" \
  2>&1 | tee "$BUILD/glazer-assemble.log"
python "$ROOT/glulx/tools/verify_ulx.py" \
  "$BUILD/$LIVING_FILE" \
  --json "$BUILD/story-report.json"

make -C "$ROOT/.tooling/cheapglk" 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C "$ROOT/.tooling/glulxe" \
  GLKDIR="$ROOT/.tooling/cheapglk" \
  GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" \
  2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
test -x "$GLULXE_BIN"

cat > "$BUILD/commands.txt" <<'EOF_COMMANDS'
north
east
open window
west
west
take lantern
turn on lantern
east
up
take rope
down
east
east
east
leap
examine edge
secure rope
inventory
leap
check appetite
take rope
inventory
recover
check appetite
leap
quit
EOF_COMMANDS
"$GLULXE_BIN" "$BUILD/$LIVING_FILE" < "$BUILD/commands.txt" \
  2>&1 | tee "$BUILD/living-consequences-transcript.txt"

grep -F 'Your first shift of weight sends loose shale skittering over the rim.' "$BUILD/living-consequences-transcript.txt"
grep -F 'Loose shale slides from the canyon rim and vanishes before any impact can be heard.' "$BUILD/living-consequences-transcript.txt"
grep -F 'You work the real rope around a solid projection of the west wall and test the knot with your full weight.' "$BUILD/living-consequences-transcript.txt"
grep -F 'The shale breaks loose beneath you, but the prepared rope snaps taut against the west wall.' "$BUILD/living-consequences-transcript.txt"
grep -F 'The exertion leaves your breath short.' "$BUILD/living-consequences-transcript.txt"
grep -F 'Your appetite is quiet, and your exertion strain is moderate.' "$BUILD/living-consequences-transcript.txt"
grep -F 'You stop long enough for the accumulated strain to pass.' "$BUILD/living-consequences-transcript.txt"
grep -F 'Your appetite is quiet, and your exertion strain is clear.' "$BUILD/living-consequences-transcript.txt"
grep -F 'Nice view, lousy place to jump.' "$BUILD/living-consequences-transcript.txt"
for word in secure anchor edge rim recover; do
  if grep -Fi "I don't know the word \"$word\"" "$BUILD/living-consequences-transcript.txt"; then
    echo "Living consequences vocabulary was not recognized: $word" >&2
    exit 1
  fi
done
python - <<'PY'
from pathlib import Path
text = Path('glulx/build/living-zork-consequences/living-consequences-transcript.txt').read_text()
secure_tail = text.split('You work the real rope around a solid projection', 1)[1]
first_inventory = secure_tail.split('The shale breaks loose beneath you', 1)[0]
assert 'You are carrying:' in first_inventory
assert 'rope' not in first_inventory.lower().split('You are carrying:', 1)[1]
after_take = text.rsplit('Taken.', 1)[1]
second_inventory = after_take.split('You stop long enough for the accumulated strain to pass.', 1)[0]
assert 'You are carrying:' in second_inventory
assert 'rope' in second_inventory.lower().split('You are carrying:', 1)[1]
rescue = text.index('The shale breaks loose beneath you')
recovery = text.index('You stop long enough for the accumulated strain to pass.')
death = text.index('Nice view, lousy place to jump.')
assert rescue < recovery < death
PY

python - "$LIVING_SERIAL" "$MANIFEST" <<'PY'
import json
from pathlib import Path
import sys
serial, manifest_path = sys.argv[1:]
manifest = json.loads(Path(manifest_path).read_text())
expected = manifest['expected_artifact']
story = json.loads(Path('glulx/build/living-zork-consequences/story-report.json').read_text())
stage = json.loads(Path('glulx/build/living-zork-consequences/src/STAGING-RECEIPT.json').read_text())
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
    'identity': {'release': 1236, 'serial': serial},
    'base': {
        'release': stage['base']['release'],
        'artifact_sha256': stage['base']['artifact_sha256'],
    },
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'artifact_identity_locked': expected.get('locked', False),
    'routes': {
        'direct_living_consequences_tests': 'passed',
        'exact_release_1235_staging': 'passed',
        'zil_source_smell_check': 'passed',
        'living_consequences_prose_originality': 'passed',
        'zilf_glulx_compile': 'passed',
        'glazer_assemble': 'passed',
        'ulx_checksum_verification': 'passed',
        'first_bare_leap_warning_runtime': 'passed',
        'canyon_rim_examination_runtime': 'passed',
        'canonical_rope_preparation_runtime': 'passed',
        'prepared_near_fall_runtime': 'passed',
        'bounded_strain_runtime': 'passed',
        'canonical_rope_retrieval_runtime': 'passed',
        'recover_before_deliberate_leap_runtime': 'passed',
        'canonical_lethal_consequence_runtime': 'passed',
    },
    'generic_hazard_engine': False,
    'random_death': False,
    'automatic_rescue': False,
    'duplicate_rope_state': False,
    'new_global_variable': False,
    'sub_beads': False,
}
Path('glulx/build/living-zork-consequences/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n'
)
PY

rm -rf "$CORPUS_LOCAL"
cat "$BUILD/story-report.json"
cat "$BUILD/QUALIFICATION-RECEIPT.json"
