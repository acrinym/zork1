#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-house-company"
BUILD="$ROOT/glulx/build/creative-natural-play"
STORY="$BASE_BUILD/zork1-glulx-mara-house-company.ulx"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

# Rebuild and qualify the exact current Release 1244 production story first.
bash glulx/mara-house-company/qualify.sh

GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
[[ -f "$STORY" ]]

run_probe() {
  local name="$1"
  local seed="$2"
  local commands="$BUILD/$name-commands.txt"
  # Exploratory input may reach a death/restart, save, disambiguation, or other
  # interactive prompt we did not predict. Preserve that as evidence instead of
  # allowing one session to block the rest of the play train.
  timeout 20s "$GLULXE_BIN" --rngseed "$seed" "$STORY" < "$commands" \
    > "$BUILD/$name-transcript.txt" 2>&1 || true
}

cat > "$BUILD/house-kitchen-rest-mail-commands.txt" <<'EOF'
look
open mailbox
take leaflet
read leaflet
south
east
open window
enter
look
examine broad worktop
examine cast-iron range
take sack
open sack
take lunch
put lunch on worktop
cook lunch
prepare lunch
cook lunch
warm lunch
check appetite
put garlic on worktop
cut garlic
combine lunch with garlic
warm lunch
check appetite
west
status house
check house
inspect house
up
look
lie down
rest
sleep
read dream notebook
down
east
look in cupboard
wash sack
put sack on range
cook sack
cook garlic
cook nest
west
west
look in mailbox
read mail
respond to letter
put stamped card in mailbox
wait
wait
look in mailbox
recap
quit
yes
EOF
run_probe house-kitchen-rest-mail 41001

cat > "$BUILD/troll-absurd-combat-commands.txt" <<'EOF'
south
east
open window
enter
west
take lantern
take sword
east
up
take rope
down
west
move rug
open trap door
turn on lantern
down
north
look
trick troll
tie up troll with rope
examine troll
examine rope
take axe
west
east
untie troll
trick troll
tie troll with rope
attack troll with sword
attack troll with sword
attack troll with sword
examine troll
examine tuft
take tuft
recap
south
up
east
west
exhibit tuft
catalog troll
quit
yes
EOF
run_probe troll-absurd-combat 123456

cat > "$BUILD/nest-fire-kitchen-commands.txt" <<'EOF'
look
north
north
look
up
look
examine nest
take nest
take egg
cook nest
burn nest
burn nest with torch
down
south
south
south
east
open window
enter
put nest on worktop
cook nest
warm nest
put egg on worktop
cook egg
warm egg
prepare egg
cut egg
wash egg
examine egg
quit
yes
EOF
run_probe nest-fire-kitchen 41003

cat > "$BUILD/mara-fishing-home-commands.txt" <<'EOF'
south
east
open window
enter
west
take lantern
take sword
take fishing rod
take field jar
examine fishing rod
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
look
fish
cast rod
look in jar
examine silverfin
talk to mara
ask mara about fish
ask mara about silverfin
ask mara about survey
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
ask mara about silverfin
south
sw
south
west
west
south
unbar trap door with mara
up
exhibit silverfin
catalog waters
ask mara about museum
ask mara about silverfin
invite mara
down
north
east
east
north
ne
east
down
mara, take pack
mara, follow me
up
south
sw
south
west
west
south
up
east
up
invite mara
examine mara
down
west
up
rest
sleep
read dream notebook
down
west
look in mailbox
read mail
recap
quit
yes
EOF
run_probe mara-fishing-home 123456

cat > "$BUILD/repetition-and-custody-commands.txt" <<'EOF'
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
survey control panel with mara
south
sw
south
west
west
south
unbar trap door with mara
unbar trap door with mara
up
invite mara
invite mara
down
north
east
east
north
ne
east
down
mara, take pack
mara, take pack
mara, follow me
up
south
sw
south
west
west
south
up
east
up
invite mara
invite mara
mara, take pack
examine mara
down
take sack
open sack
take lunch
put lunch on worktop
prepare lunch
share lunch with mara
share lunch with mara
ask mara about company
mara, drop pack
mara, take lunch
mara, eat lunch
kill mara
attack mara with sword
kiss mara
quit
yes
EOF
run_probe repetition-and-custody 123456

python - <<'PY'
from pathlib import Path
import json, re
build = Path('glulx/build/creative-natural-play')
summary = {}
patterns = {
    'unknown_word': re.compile(r'I don\'t know the word "([^"]+)"'),
    'generic_failure': re.compile(r"You may know how to do that, but I don't\.|I don\'t understand that sentence\.|There was no verb in that sentence!"),
    'cant_see': re.compile(r"You can\'t see any ([^!]+) here!"),
    'death': re.compile(r'\*\*\*\*  You have died  \*\*\*\*|You have died'),
}
for transcript in sorted(build.glob('*-transcript.txt')):
    text = transcript.read_text(encoding='utf-8', errors='replace')
    item = {
        'lines': len(text.splitlines()),
        'timed_out': text.rstrip().endswith('Terminated'),
        'unknown_words': sorted(set(patterns['unknown_word'].findall(text))),
        'generic_failures': len(patterns['generic_failure'].findall(text)),
        'cant_see': sorted(set(patterns['cant_see'].findall(text))),
        'death_count': len(patterns['death'].findall(text)),
    }
    summary[transcript.name] = item
Path(build / 'OBSERVATION-SUMMARY.json').write_text(json.dumps(summary, indent=2) + '\n', encoding='utf-8')
print(json.dumps(summary, indent=2))
PY

# Observation is intentionally non-failing on player-facing surprises. Build and
# Release 1244 qualification failures still fail the job; weird play is evidence.
