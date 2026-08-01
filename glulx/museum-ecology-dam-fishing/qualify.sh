#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/museum-ecology-dam-fishing"
SRC="$BUILD/src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/museum-ecology-dam-fishing/patch-series.json"
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

python -m unittest discover -s tests -p 'test_museum_ecology_dam_fishing.py' -v
python -m py_compile glulx/museum-ecology-dam-fishing/stage.py tests/test_museum_ecology_dam_fishing.py
python glulx/museum-ecology-dam-fishing/stage.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/museum-ecology-dam-fishing/src')
stage = json.loads((source / 'STAGING-RECEIPT.json').read_text(encoding='utf-8'))
smell = json.loads(Path('glulx/build/museum-ecology-dam-fishing/smell-report.json').read_text(encoding='utf-8'))
assert stage['base']['release'] == 1238
assert stage['base']['artifact_sha256'] == '95dd5a7e88be6c76732513e81c8e6b06f3f664053f3a3c8a23ebad0c61242ec8'
assert stage['changed_paths'] == [
    'museum_ecology_dam_fishing.zil',
    'museum_intake_first_gallery.zil',
    'zork1.zil',
]
assert not smell['errors']
module = (source / 'museum_ecology_dam_fishing.zil').read_text(encoding='utf-8')
intake = (source / 'museum_intake_first_gallery.zil').read_text(encoding='utf-8')
for token in (
    '<OBJECT MUSEUM-FISHING-ROD',
    '<OBJECT MUSEUM-FIELD-JAR',
    '<OBJECT DAM-SILVERFIN',
    '<OBJECT MUSEUM-WATERS-CASE',
    '<EQUAL? ,HERE ,DAM-BASE>',
    ',LOW-TIDE ,SILVERFIN-SPILLWAY',
    '<MOVE ,DAM-SILVERFIN ,MUSEUM-FIELD-JAR>',
    '<REMOVE ,DAM-SILVERFIN>',
):
    assert token in module
assert '<RETURN ,MUSEUM-WATERS-CASE>' in intake
production = '\n'.join(path.read_text(encoding='utf-8', errors='ignore') for path in source.glob('*.zil'))
for test_word in ('ANGLER', 'TIDEUP', 'GOHOME'):
    assert test_word not in production
assert '<RANDOM' not in module
assert 'PROCEDURAL' not in module
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

ASSEMBLY="$BUILD/museum-ecology-dam-fishing.asm"
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
cp glulx/museum-ecology-dam-fishing/tests/museum_ecology_dam_fishing_test.zil \
  "$TEST_SRC/museum_ecology_dam_fishing_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/museum-ecology-dam-fishing/tests/001-include-museum-fishing-test.json').resolve(),
    Path('glulx/build/museum-ecology-dam-fishing/test-src').resolve(),
)
PY
TEST_ASSEMBLY="$BUILD/museum-ecology-dam-fishing-test.asm"
pushd "$TEST_SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$TEST_ASSEMBLY" \
  2>&1 | tee "$BUILD/test-zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$TEST_ASSEMBLY" --serial "$SERIAL" \
  --receipt "$BUILD/TEST-SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$TEST_ASSEMBLY" -o "$BUILD/museum-ecology-dam-fishing-test.ulx" \
  2>&1 | tee "$BUILD/test-glazer-assemble.log"

cat > "$BUILD/commands.txt" <<'EOF_COMMANDS'
angler
examine rod
fish
look in jar
take silverfin from jar
examine silverfin
release silverfin
tideup
cast rod
look in jar
take silverfin from jar
examine silverfin
gohome
exhibit silverfin
catalog waters
read silverfin plaque
take silverfin
catalog waters
quit
yes
EOF_COMMANDS
"$GLULXE_BIN" "$BUILD/museum-ecology-dam-fishing-test.ulx" < "$BUILD/commands.txt" \
  2>&1 | tee "$BUILD/runtime-transcript.txt"

grep -F 'TEST PRECONDITION: ordinary River Frigid fishing site' "$BUILD/runtime-transcript.txt"
grep -F 'jointed ash with a cork grip' "$BUILD/runtime-transcript.txt"
grep -F 'narrow silver fish comes up fighting the River Frigid' "$BUILD/runtime-transcript.txt"
grep -F 'museum keeps the earned field record' "$BUILD/runtime-transcript.txt"
grep -F 'TEST PRECONDITION: reservoir at low tide' "$BUILD/runtime-transcript.txt"
grep -F 'broad-tailed silverfin breaks the surface with a pale gate scar' "$BUILD/runtime-transcript.txt"
grep -F 'The broad-tailed silverfin bears a pale line' "$BUILD/runtime-transcript.txt"
grep -F 'Waters of the Empire: the shallow case holds a living spillway silverfin' "$BUILD/runtime-transcript.txt"
grep -F 'Donated by the Adventurer' "$BUILD/runtime-transcript.txt"
grep -F 'the silverfin record is established, but the real specimen is currently absent' "$BUILD/runtime-transcript.txt"
python - <<'PY'
from pathlib import Path
text = Path('glulx/build/museum-ecology-dam-fishing/runtime-transcript.txt').read_text(encoding='utf-8')
assert text.index('narrow silver fish comes up fighting') < text.index('museum keeps the earned field record')
assert text.index('reservoir at low tide') < text.index('broad-tailed silverfin breaks the surface')
assert text.index('shallow case holds a living spillway silverfin') < text.index('real specimen is currently absent')
for word in ('angler', 'tideup', 'gohome', 'fish', 'cast', 'release', 'exhibit', 'catalog', 'waters', 'silverfin', 'plaque'):
    assert f'I don\'t know the word "{word}"' not in text
PY

python - "$SERIAL" "$MANIFEST" <<'PY'
import json, sys
from pathlib import Path
serial, manifest_path = sys.argv[1:]
manifest = json.loads(Path(manifest_path).read_text(encoding='utf-8'))
expected = manifest['expected_artifact']
story = json.loads(Path('glulx/build/museum-ecology-dam-fishing/story-report.json').read_text(encoding='utf-8'))
assert story['format'] == expected['format']
assert story['version_hex'] == expected['version_hex']
assert story['checksum_valid'] is True
if expected.get('locked', False):
    assert story['size_bytes'] == expected['size_bytes']
    assert story['checksum_hex'] == expected['checksum_hex']
    assert story['sha256'] == expected['sha256']
receipt = {
    'release': 1239,
    'serial': serial,
    'artifact': story,
    'artifact_identity_locked': expected.get('locked', False),
    'gameplay': {
        'physical_rod_and_jar': 'passed',
        'river_variety': 'passed',
        'live_release_registration': 'passed',
        'low_tide_spillway_variety': 'passed',
        'physical_museum_exhibit': 'passed',
        'provenance_plaque': 'passed',
        'physical_removal_updates_gallery': 'passed'
    },
    'generic_fishing_engine': False,
    'procedural_species': False,
    'object_copy': False
}
Path('glulx/build/museum-ecology-dam-fishing/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n', encoding='utf-8'
)
PY
cat "$BUILD/story-report.json"
