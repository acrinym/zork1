#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/dam-survival-prepared-rescue-1253"
STORY="$BUILD/zork1-glulx-dam-survival-prepared-rescue.ulx"
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

LOSS="$BUILD/dam-overflow-gear-loss-transcript.txt"
python - "$LOSS" <<'PY'
from pathlib import Path
import sys
text = Path(sys.argv[1]).read_text()
loss = 'The sword tears free and clatters onto the landing below, where it can be recovered.'
assert loss in text
post_loss = text[text.index(loss) + len(loss):]
assert 'Taken.' in post_loss, 'sword recovery was not confirmed after the gear-loss event'
PY

DAM_APPROACH=$(cat <<'EOF_ROUTE'
south
east
open window
enter
west
take lantern
turn on lantern
take sword
east
up
take rope
down
west
move rug
open trap door
down
north
attack troll with sword
attack troll with sword
attack troll with sword
east
east
north
ne
east
EOF_ROUTE
)

{
  printf '%s\n' "$DAM_APPROACH"
  cat <<'EOF_ENTRY'
north
north
take wrench
push yellow button
south
south
turn bolt with wrench
down
enter river
quit
yes
EOF_ENTRY
} > "$BUILD/dam-enter-river-unprepared.txt"
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/dam-enter-river-unprepared.txt" > "$BUILD/dam-enter-river-unprepared-transcript.txt" 2>&1
UNPREPARED="$BUILD/dam-enter-river-unprepared-transcript.txt"
grep -F 'You enter the Frigid River below open sluice gates.' "$UNPREPARED"
grep -F 'Prepared rescue would have made this an experiment instead of an ending.' "$UNPREPARED"

{
  printf '%s\n' "$DAM_APPROACH"
  cat <<'EOF_ENTRY'
north
north
take wrench
push yellow button
south
south
turn bolt with wrench
tie rope to ladder
climb down ladder
enter river
quit
yes
EOF_ENTRY
} > "$BUILD/dam-enter-river-prepared.txt"
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/dam-enter-river-prepared.txt" > "$BUILD/dam-enter-river-prepared-transcript.txt" 2>&1
PREPARED="$BUILD/dam-enter-river-prepared-transcript.txt"
grep -F 'the maintenance-ladder knot holds.' "$PREPARED"

echo 'Release 1253 review regressions passed.'
