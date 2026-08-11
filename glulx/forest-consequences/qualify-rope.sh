#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/forest-consequences-1248"
STORY="$BUILD/zork1-glulx-forest-consequences.ulx"
QUALIFICATION="$BUILD/QUALIFICATION.json"
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

if [[ ! -f "$STORY" || ! -f "$QUALIFICATION" ]]; then
  echo "Release 1248 must complete its primary qualification before the rope scenario." >&2
  exit 1
fi

cat > "$BUILD/tree-rope-authority.txt" <<'EOF'
south
east
open window
enter
up
take rope
down
east
north
north
tie rope to tree
south
untie rope
use rope on tree
south
untie rope
south
quit
yes
EOF

timeout 35s "$GLULXE_BIN" --rngseed 1248006 "$STORY" \
  < "$BUILD/tree-rope-authority.txt" > "$BUILD/tree-rope-authority-transcript.txt" 2>&1
ROPE_OUT="$BUILD/tree-rope-authority-transcript.txt"

ANCHOR_COUNT="$(grep -Fc 'You tie one end of the rope securely to the tree.' "$ROPE_OUT")"
LIMIT_COUNT="$(grep -Fc 'The anchored rope reaches its useful limit and checks your movement.' "$ROPE_OUT")"
UNTIE_COUNT="$(grep -Fc 'You undo the knot around the tree. The rope is fully available again.' "$ROPE_OUT")"

if [[ "$ANCHOR_COUNT" -ne 2 ]]; then
  echo "expected both TIE ROPE TO TREE and USE ROPE ON TREE to reach the existing anchor authority; got $ANCHOR_COUNT successful anchors" >&2
  exit 1
fi
if [[ "$LIMIT_COUNT" -ne 2 ]]; then
  echo "expected the existing movement limit exactly twice while the rope was anchored; got $LIMIT_COUNT" >&2
  exit 1
fi
if [[ "$UNTIE_COUNT" -ne 2 ]]; then
  echo "expected UNTIE to release both tree anchors; got $UNTIE_COUNT successful untiers" >&2
  exit 1
fi

python - "$QUALIFICATION" <<'PY'
import json
import sys
from pathlib import Path

path = Path(sys.argv[1])
receipt = json.loads(path.read_text())
entry = 'tree rope anchor via TIE and USE-ON plus movement limit and canonical UNTIE'
qualification = receipt.setdefault('qualification', [])
if entry not in qualification:
    qualification.append(entry)
path.write_text(json.dumps(receipt, indent=2, sort_keys=True) + '\n')
print(json.dumps({
    'rope_anchor_qualification': 'passed',
    'successful_anchor_commands': 2,
    'movement_limits_observed': 2,
    'successful_unties': 2,
}, indent=2, sort_keys=True))
PY

echo "Release 1248 tree rope authority qualification passed."
