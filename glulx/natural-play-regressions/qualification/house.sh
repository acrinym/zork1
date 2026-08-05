cat > "$BUILD/house-commands.txt" <<'EOF_HOUSE'
south
east
open window
enter
west
take lantern
turn on lantern
status house
check house
inspect house
check appetite
examine creatures case
examine monstrous zoology case
east
examine broad worktop
examine cast iron range
take sack
open sack
take lunch
put lunch on worktop
prepare lunch
up
examine archive cabinet
examine compact viewer
examine first completed expedition box
status expedition
quit
yes
EOF_HOUSE
"$GLULXE_BIN" "$BUILD/$STORY_FILE" < "$BUILD/house-commands.txt" 2>&1 | tee "$BUILD/house-transcript.txt"
grep -F 'House vulnerability status:' "$BUILD/house-transcript.txt"
grep -F 'Your appetite is quiet, and your exertion strain is clear.' "$BUILD/house-transcript.txt"
grep -F 'Creatures and Monstrous Zoology: the troll case is empty.' "$BUILD/house-transcript.txt"
grep -F 'A broad wooden worktop supports real food, containers, and tools.' "$BUILD/house-transcript.txt"
grep -F 'A cast-iron range can be lit with a real held flame.' "$BUILD/house-transcript.txt"
grep -F 'You unwrap and arrange the hot-pepper sandwich on the worktop.' "$BUILD/house-transcript.txt"
grep -F 'It is a bounded late-1970s archive surface.' "$BUILD/house-transcript.txt"
grep -F "This physical banker box holds one completed playthrough's exact master file" "$BUILD/house-transcript.txt"
grep -F 'Completed expedition archive status: no sealed victory record.' "$BUILD/house-transcript.txt"
python - <<'PY_HOUSE'
from pathlib import Path
t = Path('glulx/build/natural-play-regressions/house-transcript.txt').read_text()
assert t.count('House vulnerability status:') == 3
assert t.count('Creatures and Monstrous Zoology: the troll case is empty.') == 2
assert 'Only the expedition recovery locker accepts this preparation.' not in t
assert 'A first completed expedition box waits beneath the chronology shelf.' in t
for word in ('creatures','monstrous','broad','cast','archive','compact','completed'):
    assert f'i don\'t know the word "{word}"' not in t.lower()
PY_HOUSE
