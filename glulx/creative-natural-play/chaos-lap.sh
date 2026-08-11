#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/creative-natural-play-1245"
STORY="$BUILD/zork1-glulx-creative-natural-play.ulx"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
[[ -x "$GLULXE_BIN" && -f "$STORY" ]]

run_probe() {
  local name="$1" seed="$2" seconds="$3"
  local status=0
  timeout "$seconds" "$GLULXE_BIN" --rngseed "$seed" "$STORY" \
    < "$BUILD/$name-commands.txt" > "$BUILD/$name-transcript.txt" 2>&1 || status=$?
  printf '%s\n' "$status" > "$BUILD/$name-status.txt"
}

# Correctly acquire and light the old House equipment before combining the
# absurd troll alternatives with later provenance/combat state.
cat > "$BUILD/chaos-troll-commands.txt" <<'EOF'
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
untie troll
trick troll
tie up troll with rope
attack troll with sword
attack troll with sword
attack troll with sword
attack troll with sword
examine troll
examine rope
take tuft
south
up
recap
quit
yes
EOF
run_probe chaos-troll 123456 25s

# Exercise the shipped protected fall, recovery, rope removal, and deliberate
# later canonical death as one continuous stupid decision chain.
cat > "$BUILD/chaos-canyon-commands.txt" <<'EOF'
north
east
open window
west
west
take lantern
turn on lantern
east
up
take rope
down
east
east
east
look
leap
examine edge
secure rope
inventory
leap
check appetite
take rope
inventory
recover
check appetite
leap
restart
no
quit
yes
EOF
run_probe chaos-canyon 41012 25s

# Earn the entire Mara House history naturally, then keep her physically present
# while trying ordinary affection, violence, and remote-inventory nonsense.
cat > "$BUILD/chaos-mara-boundaries-commands.txt" <<'EOF'
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
south
sw
south
west
west
south
unbar trap door with mara
up
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
mara, take pack
mara, follow me
down
take sack
open sack
take lunch
put lunch on worktop
cook lunch
share lunch with mara
share lunch with mara
kiss mara
kill mara
attack mara with sword
mara, take lunch
mara, drop pack
mara, take sword
mara, follow me
west
examine mara
recap
quit
yes
EOF
run_probe chaos-mara-boundaries 123456 40s

# Use the actual outdoor mailbox, then live through House rest/cues and come back
# outside rather than asking the Living Room to impersonate a mailbox.
cat > "$BUILD/chaos-house-mail-rest-commands.txt" <<'EOF'
open mailbox
look in mailbox
take leaflet
read leaflet
south
east
open window
enter
west
status house
check house
inspect house
up
rest
sleep
read dream notebook
down
east
look in cupboard
examine cast iron range
cook bottle
west
west
north
west
open mailbox
look in mailbox
read mail
respond to letter
wait
look in mailbox
recap
quit
yes
EOF
run_probe chaos-house-mail-rest 41013 25s

python - <<'PY'
from pathlib import Path
import json,re
build=Path('glulx/build/creative-natural-play-1245')
summary={}
for p in sorted(build.glob('chaos-*-transcript.txt')):
    text=p.read_text(errors='replace')
    status_path=p.with_name(p.name.replace('-transcript.txt','-status.txt'))
    status=int(status_path.read_text().strip())
    summary[p.name]={
        'lines':len(text.splitlines()),
        'unknown_words':sorted(set(re.findall(r'I don\'t know the word "([^"]+)"',text))),
        'actor_confusion':sorted(set(re.findall(r'seems confused\. "([^"]+)"',text))),
        'generic_failures':len(re.findall(r"You may know how to do that, but I don't\.|I couldn't understand that sentence\.|I don't understand that sentence\.",text)),
        'cant_see':sorted(set(re.findall(r"You can't see any ([^!]+) here!",text))),
        'death_count':len(re.findall(r'You have died|\*\*\*\*  You have died',text)),
        'contains_stale_pack_dam_claim':'field camp is at the Dam Base. She cannot pack a camp from a different room.' in text,
        'contains_control_glyph':'\x14' in text,
        'probe_status':status,
        'timed_out':status == 124,
    }
(build/'CHAOS-LAP-SUMMARY.json').write_text(json.dumps(summary,indent=2)+'\n')
print(json.dumps(summary,indent=2))
PY
