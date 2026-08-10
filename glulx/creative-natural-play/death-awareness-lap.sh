#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/creative-natural-play-1245"
STORY="$BUILD/zork1-glulx-creative-natural-play.ulx"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
[[ -x "$GLULXE_BIN" && -f "$STORY" ]]

cat > "$BUILD/mara-death-present.txt" <<'EOF'
south
east
open window
enter
west
take lantern
take sword
move rug
open trap door
turn on lantern
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
down
talk to mara
attack me with sword
quit
yes
EOF

timeout 35s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/mara-death-present.txt" > "$BUILD/mara-death-present-transcript.txt" 2>&1 || true

PRESENT="$BUILD/mara-death-present-transcript.txt"
grep -F 'Mara is moving before you finish falling.' "$PRESENT"
grep -F 'She checks for breath, finds none, and goes very still.' "$PRESENT"
grep -F '****  You have died  ****' "$PRESENT"

cat > "$BUILD/mara-death-remote.txt" <<'EOF'
south
east
open window
enter
west
take sword
attack me with sword
quit
yes
EOF

timeout 20s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/mara-death-remote.txt" > "$BUILD/mara-death-remote-transcript.txt" 2>&1 || true

REMOTE="$BUILD/mara-death-remote-transcript.txt"
grep -F '****  You have died  ****' "$REMOTE"
! grep -F 'Mara is moving before you finish falling.' "$REMOTE"
! grep -F 'Mara catches you before the floor does.' "$REMOTE"
