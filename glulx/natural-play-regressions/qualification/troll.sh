cat > "$BUILD/troll-commands.txt" <<'EOF_TROLL'
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
examine fur
quit
yes
EOF_TROLL
"$GLULXE_BIN" --rngseed 123456 "$BUILD/$STORY_FILE" < "$BUILD/troll-commands.txt" 2>&1 | tee "$BUILD/troll-transcript.txt"
grep -F 'The troll is battered into unconsciousness.' "$BUILD/troll-transcript.txt"
grep -F 'The unconscious troll cannot defend himself: He dies.' "$BUILD/troll-transcript.txt"
grep -F 'recovered after the canonical troll was killed and its bloody axe fell to the floor' "$BUILD/troll-transcript.txt"
python - <<'PY_TROLL'
from pathlib import Path
t = Path('glulx/build/natural-play-regressions/troll-transcript.txt').read_text()
assert t.count('A coarse iron-grey tuft shakes loose') == 1
assert 'without a confirmed kill' not in t
assert t.count('The tuft is coarse iron-grey fur') == 1
PY_TROLL
