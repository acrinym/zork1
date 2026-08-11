#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/narrative-physicality-1247"
SRC="$BUILD/src"
BASE="$BUILD/base-1246-src"
STORY="$BUILD/zork1-glulx-narrative-physicality.ulx"
cd "$ROOT"

python - "$SRC" "$BASE" <<'PY'
import json
import sys
from pathlib import Path
src = Path(sys.argv[1])
base = Path(sys.argv[2])
receipt = json.loads((src / "STAGING-RECEIPT.json").read_text())
for name in receipt["changed_paths"]:
    patched_globals = (src / name).read_text().count("<GLOBAL ")
    base_globals = (base / name).read_text().count("<GLOBAL ")
    if patched_globals != base_globals:
        raise SystemExit(
            f"new-global boundary violated in {name}: base={base_globals}, patched={patched_globals}"
        )
print("No-new-globals boundary holds across every changed ZIL source file.")
PY

GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
cat > "$BUILD/review-sack-spill.txt" <<'EOF'
open mailbox
take leaflet
south
east
open window
enter
take sack
open sack
take lunch
put leaflet in sack
look in sack
west
take sword
east
cut sack with sword
look in sack
look
quit
yes
EOF

timeout 30s "$GLULXE_BIN" --rngseed 1247010 "$STORY" \
  < "$BUILD/review-sack-spill.txt" > "$BUILD/review-sack-spill-transcript.txt" 2>&1
OUT="$BUILD/review-sack-spill-transcript.txt"
BEFORE="$BUILD/review-sack-before.txt"
AFTER="$BUILD/review-sack-after.txt"

awk '/The brown sack contains:/{seen=1} seen{print} /Living Room/{if (seen) exit}' "$OUT" > "$BEFORE"
awk '/opens a ragged seam in the brown sack/{seen=1} seen{print}' "$OUT" > "$AFTER"

grep -F 'The brown sack contains:' "$BEFORE"
grep -Fi 'leaflet' "$BEFORE"
grep -Fi 'garlic' "$BEFORE"
grep -F 'opens a ragged seam in the brown sack' "$AFTER"
grep -Fi 'empty' "$AFTER"
grep -Fi 'leaflet' "$AFTER"
grep -Fi 'garlic' "$AFTER"

if grep -qi 'not enough room' "$OUT"; then
  echo 'Player-supplied leaflet did not fit in the sack before the tear.' >&2
  exit 1
fi
if grep -qi 'cannot put a person' "$OUT"; then
  echo 'Mara actor routing regressed during sack qualification.' >&2
  exit 1
fi

echo "Review qualification passed: all changed files preserve the no-new-globals boundary and a player-added sack item spills with canonical contents."
