#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/museum-intake-first-gallery"
SRC="$BUILD/src"
MANIFEST="$ROOT/glulx/museum-intake-first-gallery/patch-series.json"
CANDIDATE="$ROOT/glulx/museum-intake-first-gallery/prose/outside-gallery-refusal.txt"
CORPUS_LOCAL="$ROOT/.upstream/zork1-glulx/.local/infocom-corpus/museum-intake-first-gallery"
cd "$ROOT"
rm -rf "$BUILD" "$CORPUS_LOCAL"
mkdir -p "$BUILD/corpus" "$CORPUS_LOCAL"

IFS=$'\t' read -r MUSEUM_SERIAL MUSEUM_FILE < <(
  python - "$MANIFEST" <<'PY'
import json
from pathlib import Path
import sys
manifest = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
print('\t'.join((manifest['serial'], manifest['expected_artifact']['file'])))
PY
)

python -m unittest discover -s tests -p 'test_museum_intake_first_gallery*.py' -v
python -m py_compile \
  glulx/museum-intake-first-gallery/stage.py \
  tests/test_museum_intake_first_gallery*.py

python glulx/museum-intake-first-gallery/stage.py \
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
  --profile-id zork1-parser-refusal \
  --out "$BUILD/outside-gallery-refusal.overlap.json"
python -m tools.infocom_corpus receipt \
  --candidate "$CANDIDATE" \
  --corpus "$CORPUS_LOCAL/annotated.jsonl" \
  --profiles reference/infocom-corpus/profiles/authority-profiles.json \
  --profile-id zork1-parser-refusal \
  --surface-family museum-intake-boundary \
  --reviewer Justin \
  --intentional-departure 'The command names the repository-local museum intake boundary without hinting at collection placement.' \
  --out "$BUILD/outside-gallery-refusal.style-receipt.json"

python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/museum-intake-first-gallery/src')
stage = json.loads((source / 'STAGING-RECEIPT.json').read_text())
smell = json.loads(Path('glulx/build/museum-intake-first-gallery/smell-report.json').read_text())
overlap = json.loads(Path('glulx/build/museum-intake-first-gallery/outside-gallery-refusal.overlap.json').read_text())
receipt = json.loads(Path('glulx/build/museum-intake-first-gallery/outside-gallery-refusal.style-receipt.json').read_text())
assert stage['base']['release'] == 1232
assert stage['base']['artifact_sha256'] == '2cffc734dbfbe346d0ec185c6962d927bc046343dccdb53b6a9e4439521b6f2e'
assert stage['changed_paths'] == ['museum_intake_first_gallery.zil', 'zork1.zil']
assert not smell['errors']
assert not [item for item in smell['includes'] if not item['resolved']]
assert overlap['threshold_violations'] == []
assert overlap['rare_match_violations'] == []
assert receipt['profile_id'] == 'zork1-parser-refusal'
assert receipt['overlap']['threshold_violations'] == 0
assert receipt['overlap']['rare_match_violations'] == 0
module = (source / 'museum_intake_first_gallery.zil').read_text()
for required in (
    '<SYNTAX EXHIBIT OBJECT (MANY HELD HAVE) = V-MUSEUM-EXHIBIT>',
    '<SYNTAX CATALOG MUSEUM = V-MUSEUM-CATALOG>',
    '<SYNTAX REVIEW MUSEUM = V-MUSEUM-CATALOG>',
    '<PERFORM ,V?PUT ,PRSO .SURFACE>',
    '<PERFORM ,V?PUT-ON ,PRSO .SURFACE>',
):
    assert module.count(required) == 1
for forbidden in ('<GLOBAL', '<TABLE', '<MOVE ,PRSO', '<REMOVE ,PRSO', 'DONATE'):
    assert forbidden not in module
PY

if ! command -v dotnet >/dev/null 2>&1; then
  echo "dotnet is required for Release 1233 qualification." >&2
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

ASSEMBLY="$BUILD/zork1-glulx-museum-intake-first-gallery.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" \
  2>&1 | tee "$BUILD/zilf-compile.log"
popd
python "$ROOT/glulx/tools/normalize_serial.py" \
  "$ASSEMBLY" \
  --serial "$MUSEUM_SERIAL" \
  --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$MUSEUM_FILE" \
  2>&1 | tee "$BUILD/glazer-assemble.log"
python "$ROOT/glulx/tools/verify_ulx.py" \
  "$BUILD/$MUSEUM_FILE" \
  --json "$BUILD/story-report.json"

make -C "$ROOT/.tooling/cheapglk" 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C "$ROOT/.tooling/glulxe" \
  GLKDIR="$ROOT/.tooling/cheapglk" \
  GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" \
  2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
test -x "$GLULXE_BIN"

cat > "$BUILD/commands.txt" <<'EOF_COMMANDS'
catalog museum
north
east
open window
west
west
take sword
exhibit sword
catalog museum
take sword
review museum
quit
yes
EOF_COMMANDS
"$GLULXE_BIN" "$BUILD/$MUSEUM_FILE" < "$BUILD/commands.txt" \
  2>&1 | tee "$BUILD/museum-intake-transcript.txt"

grep -F 'There is no museum intake here.' "$BUILD/museum-intake-transcript.txt"
grep -F 'The weapon wall holds' "$BUILD/museum-intake-transcript.txt"
grep -F 'A deep frame, a bracketed weapon wall, a narrow record shelf, and a low relic stand' "$BUILD/museum-intake-transcript.txt"
test "$(grep -Fc 'Taken.' "$BUILD/museum-intake-transcript.txt")" -ge 2
for word in exhibit catalog review; do
  if grep -Fi "I don't know the word \"$word\"" "$BUILD/museum-intake-transcript.txt"; then
    echo "museum command was not recognized: $word" >&2
    exit 1
  fi
done
if grep -F 'That object does not belong on that display surface.' "$BUILD/museum-intake-transcript.txt"; then
  echo "supported sword exhibit was rejected" >&2
  exit 1
fi

python - "$MUSEUM_SERIAL" "$MANIFEST" <<'PY'
import json
from pathlib import Path
import sys
serial, manifest_path = sys.argv[1:]
manifest = json.loads(Path(manifest_path).read_text())
expected = manifest['expected_artifact']
story = json.loads(Path('glulx/build/museum-intake-first-gallery/story-report.json').read_text())
stage = json.loads(Path(
    'glulx/build/museum-intake-first-gallery/src/STAGING-RECEIPT.json'
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
    'qualification_status': 'source-corpus-artifact-and-runtime-passed',
    'identity': {'release': 1233, 'serial': serial},
    'base': {
        'release': stage['base']['release'],
        'artifact_sha256': stage['base']['artifact_sha256'],
    },
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'artifact_identity_locked': expected.get('locked', False),
    'routes': {
        'direct_museum_tests': 'passed',
        'exact_release_1232_staging': 'passed',
        'zil_source_smell_check': 'passed',
        'parser_refusal_corpus_overlap': 'passed',
        'parser_refusal_style_receipt': 'passed',
        'zilf_glulx_compile': 'passed',
        'glazer_assemble': 'passed',
        'ulx_checksum_verification': 'passed',
        'outside_gallery_refusal_runtime': 'passed',
        'sword_intake_runtime': 'passed',
        'catalog_runtime': 'passed',
        'physical_retrieval_runtime': 'passed',
    },
    'collection_state_authority': 'canonical-object-location',
    'canonical_put_delegation': True,
    'parallel_registry_added': False,
    'duplicate_exhibit_added': False,
    'remote_intake_added': False,
    'sub_beads': False,
}
Path('glulx/build/museum-intake-first-gallery/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n'
)
PY

rm -rf "$CORPUS_LOCAL"
cat "$BUILD/story-report.json"
cat "$BUILD/QUALIFICATION-RECEIPT.json"
