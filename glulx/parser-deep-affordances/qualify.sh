#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/parser-deep-affordances"
SRC="$BUILD/src"
MANIFEST="$ROOT/glulx/parser-deep-affordances/patch-series.json"
cd "$ROOT"
rm -rf "$BUILD"
mkdir -p "$BUILD"

IFS=$'\t' read -r PARSER_SERIAL PARSER_FILE < <(
  python - "$MANIFEST" <<'PY'
import json
from pathlib import Path
import sys
manifest = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
print('\t'.join((manifest['serial'], manifest['expected_artifact']['file'])))
PY
)

python -m unittest discover -s tests -p 'test_parser_deep_affordances*.py' -v
python -m py_compile \
  glulx/parser-deep-affordances/stage.py \
  tests/test_parser_deep_affordances*.py

python glulx/parser-deep-affordances/stage.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py \
  --source "$SRC" \
  --json "$BUILD/smell-report.json"

python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/parser-deep-affordances/src')
stage = json.loads((source / 'STAGING-RECEIPT.json').read_text())
smell = json.loads(Path('glulx/build/parser-deep-affordances/smell-report.json').read_text())
assert stage['base']['release'] == 1231
assert stage['base']['artifact_sha256'] == '5daaa7307ef496a3ae37209a6e79e149c9dc3d202f148f143bbb571fa74b3609'
assert stage['changed_paths'] == ['gsyntax.zil', 'zork1.zil']
assert not smell['errors']
assert not [item for item in smell['includes'] if not item['resolved']]
syntax = (source / 'gsyntax.zil').read_text()
for required in (
    '<SYNONYM EXAMINE X INSPECT DESCRIBE WHAT WHATS>',
    '<SYNTAX EXAMINE UNDER OBJECT = V-LOOK-UNDER>',
    '<SYNTAX EXAMINE BEHIND OBJECT = V-LOOK-BEHIND>',
    '<SYNONYM TURN SWITCH ',
    '<SYNONYM PLUG SEAL MEND ',
):
    assert syntax.count(required) == 1
for forbidden in ('V-SWITCH', 'V-SEAL', 'V-MEND'):
    assert forbidden not in syntax
production = '\n'.join(path.read_text(errors='ignore') for path in source.glob('*.zil'))
assert '<GLOBAL PARSER-AFFORDANCE' not in production
assert production.count('<SYNTAX USE OBJECT = V-USE>') == 1
assert production.count('<ROUTINE V-USE') == 1
PY

if ! command -v dotnet >/dev/null 2>&1; then
  echo "dotnet is required for Release 1232 qualification." >&2
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

ASSEMBLY="$BUILD/zork1-glulx-parser-deep-affordances.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" \
  2>&1 | tee "$BUILD/zilf-compile.log"
popd
python "$ROOT/glulx/tools/normalize_serial.py" \
  "$ASSEMBLY" \
  --serial "$PARSER_SERIAL" \
  --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$PARSER_FILE" \
  2>&1 | tee "$BUILD/glazer-assemble.log"
python "$ROOT/glulx/tools/verify_ulx.py" \
  "$BUILD/$PARSER_FILE" \
  --json "$BUILD/story-report.json"

make -C "$ROOT/.tooling/cheapglk" 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C "$ROOT/.tooling/glulxe" \
  GLKDIR="$ROOT/.tooling/cheapglk" \
  GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" \
  2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
test -x "$GLULXE_BIN"

cat > "$BUILD/commands.txt" <<'EOF_COMMANDS'
x mailbox
inspect mailbox
examine under mailbox
examine behind mailbox
seal mailbox with mailbox
mend mailbox with mailbox
north
east
open window
west
close window
west
take lantern
switch on lantern
switch off lantern
quit
yes
EOF_COMMANDS
"$GLULXE_BIN" "$BUILD/$PARSER_FILE" < "$BUILD/commands.txt" \
  2>&1 | tee "$BUILD/parser-affordances-transcript.txt"

test "$(grep -Fc 'The small mailbox is closed.' "$BUILD/parser-affordances-transcript.txt")" -ge 2
grep -F "There is nothing but dust there." "$BUILD/parser-affordances-transcript.txt"
grep -F "There is nothing behind the small mailbox." "$BUILD/parser-affordances-transcript.txt"
test "$(grep -Fc 'This has no effect.' "$BUILD/parser-affordances-transcript.txt")" -ge 2
grep -F "The brass lantern is now on." "$BUILD/parser-affordances-transcript.txt"
grep -F "The brass lantern is now off." "$BUILD/parser-affordances-transcript.txt"
for word in x inspect seal mend switch; do
  if grep -Fi "I don't know the word \"$word\"" "$BUILD/parser-affordances-transcript.txt"; then
    echo "selected parser word was not recognized: $word" >&2
    exit 1
  fi
done

python - "$PARSER_SERIAL" "$MANIFEST" <<'PY'
import json
from pathlib import Path
import sys
serial, manifest_path = sys.argv[1:]
manifest = json.loads(Path(manifest_path).read_text())
expected = manifest['expected_artifact']
story = json.loads(Path('glulx/build/parser-deep-affordances/story-report.json').read_text())
stage = json.loads(Path(
    'glulx/build/parser-deep-affordances/src/STAGING-RECEIPT.json'
).read_text())
assert story['format'] == expected['format']
assert story['version_hex'] == expected['version_hex']
assert story['checksum_valid'] is True
assert story['size_bytes'] > 0
if expected.get('locked', False):
    assert story['size_bytes'] == expected['size_bytes']
    assert story['checksum_hex'] == expected['checksum_hex']
    assert story['sha256'] == expected['sha256']
receipt = {
    'qualification_status': 'source-artifact-and-runtime-passed',
    'identity': {'release': 1232, 'serial': serial},
    'base': {
        'release': stage['base']['release'],
        'artifact_sha256': stage['base']['artifact_sha256'],
    },
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'artifact_identity_locked': expected.get('locked', False),
    'routes': {
        'direct_parser_tests': 'passed',
        'exact_release_1231_staging': 'passed',
        'zil_source_smell_check': 'passed',
        'zilf_glulx_compile': 'passed',
        'glazer_assemble': 'passed',
        'ulx_checksum_verification': 'passed',
        'x_and_inspect_runtime': 'passed',
        'spatial_examination_runtime': 'passed',
        'seal_and_mend_runtime': 'passed',
        'switch_lamp_runtime': 'passed',
    },
    'new_player_visible_prose': False,
    'existing_bounded_use_preserved': True,
    'generic_use_routing_expanded': False,
    'new_parser_state': False,
    'guessed_puzzle_solution': False,
    'sub_beads': False,
}
Path('glulx/build/parser-deep-affordances/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n'
)
PY

cat "$BUILD/story-report.json"
cat "$BUILD/QUALIFICATION-RECEIPT.json"
