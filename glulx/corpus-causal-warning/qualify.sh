#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/corpus-causal-warning"
SRC="$BUILD/src"
MANIFEST="$ROOT/glulx/corpus-causal-warning/patch-series.json"
cd "$ROOT"
rm -rf "$BUILD"
mkdir -p "$BUILD"

IFS=$'\t' read -r CAUSAL_WARNING_SERIAL CAUSAL_WARNING_FILE CAUSAL_WARNING_FORMAT CAUSAL_WARNING_VERSION < <(
  python - "$MANIFEST" <<'PY'
import json
from pathlib import Path
import sys
manifest = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
expected = manifest['expected_artifact']
print('\t'.join((manifest['serial'], expected['file'], expected['format'], expected['version_hex'])))
PY
)

python -m unittest discover -s tests -p 'test_corpus_causal_warning*.py' -v
python -m py_compile \
  glulx/corpus-causal-warning/stage.py \
  tests/test_corpus_causal_warning*.py

python glulx/corpus-causal-warning/stage.py \
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
source = Path('glulx/build/corpus-causal-warning/src')
stage = json.loads((source / 'STAGING-RECEIPT.json').read_text())
smell = json.loads(Path('glulx/build/corpus-causal-warning/smell-report.json').read_text())
assert stage['base']['release'] == 1230
assert stage['base']['artifact_sha256'] == 'b446e12ebffc570c0058347583bacc768f6a51f5f5166634da91898004d68c71'
assert stage['changed_paths'] == ['1actions.zil', 'corpus_causal_warning.zil', 'zork1.zil']
assert not smell['errors']
assert not [item for item in smell['includes'] if not item['resolved']]
production = '\n'.join(path.read_text(errors='ignore') for path in source.glob('*.zil'))
assert production.count('<GLOBAL WATER-LEVEL') == 1
assert production.count('<ROUTINE I-MAINT-ROOM') == 1
assert production.count('<GLOBAL MAINT-FLOOD-WARNING-STAGE') == 1
for forbidden in (
    '<GLOBAL MAINT-FLOOD-CAUSE-SEEN',
    '<GLOBAL MAINT-FLOOD-LEAK-EXAMINED',
    '<GLOBAL MAINT-FLOOD-REPAIRED',
    '<QUEUE CORPUS',
):
    assert forbidden not in production
module = (source / 'corpus_causal_warning.zil').read_text()
normalized_module = ' '.join(module.split())
for token in (
    'CORPUS-MAINT-FLOOD-START',
    'CORPUS-MAINT-FLOOD-TICK',
    'CORPUS-MAINT-FLOOD-EXAMINE',
    'CORPUS-MAINT-FLOOD-DROWN',
    'CORPUS-MAINT-FLOOD-REPAIRED',
    'The west and south doorways remain clear -- for now.',
    'The maintenance room keeps the evidence; you do not.',
):
    assert ' '.join(token.split()) in normalized_module
evidence = json.loads(Path(
    'glulx/corpus-causal-warning/qualification/corpus-evidence.json'
).read_text())
assert evidence['source_corpus_receipt']['contains_source_text'] is False
for style in evidence['style_receipts'].values():
    originality = style['originality_check']
    assert originality['passed'] is True
    assert originality['threshold_violation_count'] == 0
    assert originality['rare_phrase_match_count'] == 0
    assert originality['source_text_disclosed'] is False
PY

if ! command -v dotnet >/dev/null 2>&1; then
  echo "dotnet is required for full Release 1231 qualification." >&2
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
  echo "A local ZILF checkout or GLULX_ZILF_DLL is required for full qualification." >&2
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
  echo "A local Glazer build or GLAZER_BIN is required for full qualification." >&2
  exit 4
fi
GLAZER_BIN="$(realpath "$GLAZER_BIN")"
"$GLAZER_BIN" --version | tee "$BUILD/glazer-version.txt"

ASSEMBLY="$BUILD/zork1-glulx-corpus-causal-warning.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" \
  2>&1 | tee "$BUILD/zilf-compile.log"
popd
python "$ROOT/glulx/tools/normalize_serial.py" \
  "$ASSEMBLY" \
  --serial "$CAUSAL_WARNING_SERIAL" \
  --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$CAUSAL_WARNING_FILE" \
  2>&1 | tee "$BUILD/glazer-assemble.log"
python "$ROOT/glulx/tools/verify_ulx.py" \
  "$BUILD/$CAUSAL_WARNING_FILE" \
  --json "$BUILD/story-report.json"

python - "$CAUSAL_WARNING_SERIAL" "$CAUSAL_WARNING_FORMAT" "$CAUSAL_WARNING_VERSION" <<'PY'
import json
from pathlib import Path
import sys
serial, expected_format, expected_version = sys.argv[1:]
story = json.loads(Path('glulx/build/corpus-causal-warning/story-report.json').read_text())
assert story['format'] == expected_format
assert story['version_hex'] == expected_version
assert story['checksum_valid'] is True
assert story['size_bytes'] > 0
receipt = {
    'qualification_status': 'source-and-artifact-passed',
    'identity': {'release': 1231, 'serial': serial},
    'base': {
        'release': 1230,
        'artifact_sha256': 'b446e12ebffc570c0058347583bacc768f6a51f5f5166634da91898004d68c71',
    },
    'changed_paths': ['1actions.zil', 'corpus_causal_warning.zil', 'zork1.zil'],
    'artifact': story,
    'routes': {
        'direct_gameplay_asset_tests': 'passed',
        'exact_release_1230_staging': 'passed',
        'zil_source_smell_check': 'passed',
        'corpus_style_receipts': 'passed',
        'zilf_glulx_compile': 'passed',
        'glazer_assemble': 'passed',
        'ulx_checksum_verification': 'passed',
    },
    'interactive_runtime_transcript': 'not-claimed-by-this-receipt',
    'parallel_flood_controller': False,
    'automatic_escape_or_repair': False,
    'sub_beads': False,
}
Path('glulx/build/corpus-causal-warning/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n'
)
PY

cat "$BUILD/story-report.json"
cat "$BUILD/QUALIFICATION-RECEIPT.json"
