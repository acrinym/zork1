#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/creative-natural-play-1245"
STORY="$BUILD/zork1-glulx-creative-natural-play.ulx"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
[[ -x "$GLULXE_BIN" && -f "$STORY" ]]

cat > "$BUILD/mara-personhood.txt" <<'EOF'
south
east
open window
enter
take sack
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
take mara
push mara
pull mara
drop mara
throw mara
put mara in sack
eat mara
squeeze mara
squeeze mara
examine mara
ask mara about incident
ask mara about incident
hello mara
kick mara
quit
yes
EOF

timeout 35s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/mara-personhood.txt" > "$BUILD/mara-personhood-transcript.txt" 2>&1 || true

TRANSCRIPT="$BUILD/mara-personhood-transcript.txt"
grep -F 'Mara Tallow looks down at your hands, then back at you. Take what, exactly?' "$TRANSCRIPT"
test "$(grep -F -c 'Mara Tallow is not an object you get to relocate.' "$TRANSCRIPT")" -ge 4
grep -F 'Mara Tallow looks at the brown sack, then at you. That holds sandwiches' "$TRANSCRIPT"
grep -F 'Mara Tallow lowers the field notebook very slowly. No, she says.' "$TRANSCRIPT"
grep -F 'There is an indeterminate amount of suspicious offscreen activity.' "$TRANSCRIPT"
grep -F 'Mara returns flushed, slightly out of breath, and looking entirely too pleased with herself.' "$TRANSCRIPT"
grep -F 'We are not turning that into a repeatable field procedure' "$TRANSCRIPT"
grep -F 'She is trying very hard not to make eye contact with you.' "$TRANSCRIPT"
grep -F 'No, Mara says.' "$TRANSCRIPT"
grep -F 'Absolutely not, Mara says.' "$TRANSCRIPT"
grep -F 'Mara gives you a small nod. Hello, she says. Still here.' "$TRANSCRIPT"
grep -F 'Mara Tallow looks back at you. Whatever you meant by that' "$TRANSCRIPT"
! grep -Fi 'the Mara' "$TRANSCRIPT"
! grep -F 'struggles and you cannot tie him up' "$TRANSCRIPT"
