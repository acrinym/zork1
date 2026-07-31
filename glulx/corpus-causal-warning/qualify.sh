#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/corpus-causal-warning"
SRC="$BUILD/src"
rm -rf "$BUILD"
mkdir -p "$BUILD"

python -m unittest discover -s tests -p 'test_corpus_causal_warning.py' -v
python -m py_compile \
  glulx/corpus-causal-warning/stage.py \
  tests/test_corpus_causal_warning.py

python glulx/corpus-causal-warning/stage.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest glulx/corpus-causal-warning/patch-series.json
python optimized/tools/zil_smell_check.py \
  --source "$SRC" \
  --json "$BUILD/smell-report.json"

python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/corpus-causal-warning/src')
receipt = json.loads((source / 'STAGING-RECEIPT.json').read_text())
report = json.loads(Path('glulx/build/corpus-causal-warning/smell-report.json').read_text())
assert receipt['base']['release'] == 1230
assert receipt['base']['artifact_sha256'] == 'b446e12ebffc570c0058347583bacc768f6a51f5f5166634da91898004d68c71'
assert receipt['changed_paths'] == [
    '1actions.zil',
    'corpus_causal_warning.zil',
    'zork1.zil',
]
assert not report['errors']
assert not [item for item in report['includes'] if not item['resolved']]
production = '\n'.join(path.read_text(errors='ignore') for path in source.glob('*.zil'))
assert production.count('<GLOBAL WATER-LEVEL') == 1
assert production.count('<ROUTINE I-MAINT-ROOM') == 1
assert '<QUEUE CORPUS' not in production
module = (source / 'corpus_causal_warning.zil').read_text()
for token in (
    'CORPUS-MAINT-FLOOD-START',
    'CORPUS-MAINT-FLOOD-TICK',
    'CORPUS-MAINT-FLOOD-EXAMINE',
    'CORPUS-MAINT-FLOOD-DROWN',
    'CORPUS-MAINT-FLOOD-REPAIRED',
    'The west and south doorways remain clear -- for now.',
    'The maintenance room keeps the evidence; you do not.',
):
    assert token in module
evidence = json.loads(
    Path('glulx/corpus-causal-warning/qualification/corpus-evidence.json').read_text()
)
assert evidence['source_corpus_receipt']['contains_source_text'] is False
for style in evidence['style_receipts'].values():
    assert style['originality_check']['passed'] is True
    assert style['originality_check']['threshold_violation_count'] == 0
    assert style['originality_check']['rare_phrase_match_count'] == 0
    assert style['originality_check']['source_text_disclosed'] is False
PY

if [[ -x "$ROOT/.tooling/zilf-glulx/zilf" || -f "$ROOT/.tooling/zilf-glulx/zilf.dll" ]]; then
  echo "Existing local ZILF toolchain detected; run the repository's standard Glulx compile/assemble route against $SRC."
else
  echo "Source, staging, smell, corpus-receipt, and direct gameplay qualification passed; no local ZILF binary is installed in this environment."
fi
