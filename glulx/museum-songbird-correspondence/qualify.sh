#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/museum-songbird-correspondence"
SRC="$BUILD/src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/museum-songbird-correspondence/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

IFS=$'\t' read -r SERIAL STORY_FILE < <(
  python - "$MANIFEST" <<'PY'
import json, sys
from pathlib import Path
manifest = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
print('\t'.join((manifest['serial'], manifest['expected_artifact']['file'])))
PY
)

python -m unittest discover -s tests -p 'test_museum_songbird_correspondence.py' -v
python -m py_compile glulx/museum-songbird-correspondence/stage.py tests/test_museum_songbird_correspondence.py
python glulx/museum-songbird-correspondence/stage.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/museum-songbird-correspondence/src')
stage = json.loads((source / 'STAGING-RECEIPT.json').read_text(encoding='utf-8'))
smell = json.loads(Path('glulx/build/museum-songbird-correspondence/smell-report.json').read_text(encoding='utf-8'))
assert stage['base']['release'] == 1239
assert stage['base']['artifact_sha256'] == '5b81448327cb5a2a60298f28d76062c0c5498ec5fc11f6d627a4873e82cba11f'
assert stage['changed_paths'] == [
    '1actions.zil',
    'museum_intake_first_gallery.zil',
    'museum_songbird_correspondence.zil',
    'zork1.zil',
]
assert not smell['errors']
module = (source / 'museum_songbird_correspondence.zil').read_text(encoding='utf-8')
intake = (source / 'museum_intake_first_gallery.zil').read_text(encoding='utf-8')
actions = (source / '1actions.zil').read_text(encoding='utf-8')
for token in (
    '<OBJECT SONGBIRD-FEATHER',
    '<OBJECT MUSEUM-FOREST-CASE',
    '<MOVE ,SONGBIRD-FEATHER <LOC ,BAUBLE>>',
    '<MOVE ,SONGBIRD-FEATHER ,NEST>',
    '<IN? ,BAUBLE ,TROPHY-CASE>',
):
    assert token in module
assert '<OBJECT SONGBIRD-NEST' not in module
assert '<MUSEUM-SONGBIRD-OBSERVED>' in actions
assert '<RETURN ,MUSEUM-FOREST-CASE>' in intake
production = '\n'.join(path.read_text(encoding='utf-8', errors='ignore') for path in source.glob('*.zil'))
for test_word in ('BIRDREADY', 'NESTHIGH', 'MUSEUMHOME'):
    assert test_word not in production
assert module.count('<OBJECT SONGBIRD-FEATHER') == 1
assert '<OBJECT BAUBLE' not in module
assert '<OBJECT CANARY' not in module
assert '<RANDOM' not in module
PY

if ! command -v dotnet >/dev/null 2>&1; then
  echo "dotnet is required." >&2
  exit 4
fi
GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit 2>/dev/null || true)"
if [[ -z "$GLULX_ZILF_DLL" ]]; then
  pushd .tooling/zilf-glulx
  dotnet restore Zilf.sln --nologo 2>&1 | tee "$BUILD/zilf-restore.log"
  dotnet build Zilf.sln --configuration Release --property:PortableTarget=true --no-restore --nologo \
    2>&1 | tee "$BUILD/zilf-build.log"
  popd
  GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)"
fi
GLULX_ZILF_DLL="$(realpath "$GLULX_ZILF_DLL")"
GLAZER_BIN="$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)"
GLAZER_BIN="$(realpath "$GLAZER_BIN")"

ASSEMBLY="$BUILD/museum-songbird-correspondence.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" \
  2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" --serial "$SERIAL" \
  --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$STORY_FILE" 2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/$STORY_FILE" --json "$BUILD/story-report.json"

make -C .tooling/cheapglk 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C .tooling/glulxe GLKDIR="$ROOT/.tooling/cheapglk" \
  GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" 2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/museum-songbird-correspondence/tests/museum_songbird_correspondence_test.zil \
  "$TEST_SRC/museum_songbird_correspondence_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/museum-songbird-correspondence/tests/001-include-songbird-test.json').resolve(),
    Path('glulx/build/museum-songbird-correspondence/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/museum-songbird-correspondence-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" \
  2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$TEST_ASSEMBLY" --serial "$SERIAL" \
  --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/museum-songbird-correspondence-test.ulx" \
  2>&1 | tee "$BUILD/test-glazer-assemble.log"

cat > "$BUILD/commands.txt" <<'EOF_COMMANDS'
birdready
wind canary
look
take bauble
take feather
nesthigh
examine nest
put feather in nest
examine feather
take feather from nest
museumhome
open trophy case
exhibit bauble
catalog forest
read songbird plaque
birdready
wind canary
take bauble
take feather
museumhome
open trophy case
exhibit feather
exhibit bauble
catalog forest
read songbird plaque
take feather
take bauble from trophy case
catalog forest
quit
yes
EOF_COMMANDS
"$GLULXE_BIN" "$BUILD/museum-songbird-correspondence-test.ulx" < "$BUILD/commands.txt" \
  2>&1 | tee "$BUILD/runtime-transcript.txt"

grep -F 'TEST PRECONDITION: intact canary carried to the forest path' "$BUILD/runtime-transcript.txt"
grep -F 'From out of the greenery flies a lovely songbird' "$BUILD/runtime-transcript.txt"
grep -F 'A single blue-black flight feather turns once after the bauble' "$BUILD/runtime-transcript.txt"
grep -F "You work the real feather into the bird's nest beside the jeweled egg" "$BUILD/runtime-transcript.txt"
grep -F "The blue-black flight feather is woven into the real bird's nest beside the jeweled egg" "$BUILD/runtime-transcript.txt"
grep -F 'Pulling apart the woven twigs would turn a field decision into vandalism' "$BUILD/runtime-transcript.txt"
grep -F "the real brass bauble is displayed in the trophy case, while the feather has been returned to the bird's nest at Up a Tree" "$BUILD/runtime-transcript.txt"
grep -F 'the case holds the real blue-black feather beside a linked record of the brass bauble in the trophy case' "$BUILD/runtime-transcript.txt"
grep -F 'neither the real feather nor the real bauble is in museum custody' "$BUILD/runtime-transcript.txt"
python - <<'PY'
from pathlib import Path
text = Path('glulx/build/museum-songbird-correspondence/runtime-transcript.txt').read_text(encoding='utf-8')
assert text.index('From out of the greenery flies a lovely songbird') < text.index('blue-black flight feather turns once')
assert text.index("work the real feather into the bird's nest") < text.index("woven into the real bird's nest")
assert text.index("returned to the bird's nest at Up a Tree") < text.index('case holds the real blue-black feather')
assert text.index('case holds the real blue-black feather') < text.index('neither the real feather nor the real bauble')
for word in ('birdready', 'nesthigh', 'museumhome', 'wind', 'canary', 'feather', 'nest', 'exhibit', 'catalog', 'forest', 'songbird', 'plaque'):
    assert f'I don\'t know the word "{word}"' not in text
assert 'Which nest do you mean' not in text
PY

python - "$SERIAL" "$MANIFEST" <<'PY'
import json, sys
from pathlib import Path
serial, manifest_path = sys.argv[1:]
manifest = json.loads(Path(manifest_path).read_text(encoding='utf-8'))
expected = manifest['expected_artifact']
story = json.loads(Path('glulx/build/museum-songbird-correspondence/story-report.json').read_text(encoding='utf-8'))
assert story['format'] == expected['format']
assert story['version_hex'] == expected['version_hex']
assert story['checksum_valid'] is True
if expected.get('locked', False):
    assert story['size_bytes'] == expected['size_bytes']
    assert story['checksum_hex'] == expected['checksum_hex']
    assert story['sha256'] == expected['sha256']
receipt = {
    'release': 1240,
    'serial': serial,
    'artifact': story,
    'artifact_identity_locked': expected.get('locked', False),
    'gameplay': {
        'canonical_canary_exchange': 'passed',
        'physical_feather_drop': 'passed',
        'canonical_nest_return_choice': 'passed',
        'permanent_nest_custody': 'passed',
        'physical_forest_case_exhibit': 'passed',
        'canonical_bauble_trophy_custody': 'passed',
        'provenance_plaque': 'passed',
        'physical_removal_updates_gallery': 'passed'
    },
    'generic_bird_engine': False,
    'second_nest': False,
    'procedural_wildlife': False,
    'object_copy': False
}
Path('glulx/build/museum-songbird-correspondence/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n', encoding='utf-8'
)
PY
cat "$BUILD/story-report.json"
