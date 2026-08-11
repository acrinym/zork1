#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/creative-natural-play-1245"
STORY="$BUILD/zork1-glulx-creative-natural-play.ulx"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
[[ -x "$GLULXE_BIN" && -f "$STORY" ]]

cat > "$BUILD/mara-bound-troll-order.txt" <<'EOF'
south
east
open window
enter
west
take lantern
turn on lantern
east
up
take rope
down
west
move rug
open trap door
down
north
trick troll
tie up troll with rope
take axe
east
east
north
ne
east
down
talk to mara
mara, follow me
up
examine control panel
north
north
take wrench
mara, push yellow button
mara, follow me
south
south
mara, brace control panel
turn bolt with wrench
survey control panel with mara
south
sw
south
west
west
look
send mara after troll with axe
send mara after troll
mara, attack troll with axe
quit
yes
EOF

timeout 35s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/mara-bound-troll-order.txt" > "$BUILD/mara-bound-troll-order-transcript.txt" 2>&1 || true

TRANSCRIPT="$BUILD/mara-bound-troll-order-transcript.txt"
grep -F 'The bound troll remains alive, furious, and no longer able to block the passages.' "$TRANSCRIPT"
grep -F 'Mara steps into the Troll Room only after studying the knots from the threshold.' "$TRANSCRIPT"
grep -F 'Alive, disarmed, and actually restrained, she says. That changes the route.' "$TRANSCRIPT"
grep -F 'I am your expedition partner, not something you point at an enemy.' "$TRANSCRIPT"
grep -F 'You already know I do not take combat orders from you' "$TRANSCRIPT"
grep -qF 'I don'"'"'t know the word "after"' "$TRANSCRIPT" && exit 1
grep -qF 'I don'"'"'t know the word "with"' "$TRANSCRIPT" && exit 1
grep -qF 'I don'"'"'t see any troll here' "$TRANSCRIPT" && exit 1
grep -qF 'Mara stops short of the Troll Room' "$TRANSCRIPT" && exit 1
true
