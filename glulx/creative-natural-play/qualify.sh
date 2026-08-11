#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/creative-natural-play-1245"
SRC="$BUILD/src"
MANIFEST="$ROOT/glulx/creative-natural-play/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"
IFS=$'\t' read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text())
print('\t'.join((m['serial'],m['expected_artifact']['file'])))
PY
)
python -m py_compile glulx/creative-natural-play/stage.py
python glulx/creative-natural-play/stage.py --upstream .upstream/zork1-glulx --destination "$SRC" --allowed-root "$BUILD" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
s=Path('glulx/build/creative-natural-play-1245/src')
stage=json.loads((s/'STAGING-RECEIPT.json').read_text())
smell=json.loads(Path('glulx/build/creative-natural-play-1245/smell-report.json').read_text())
assert stage['base']['release']==1244
assert stage['base']['artifact_sha256']=='e02b4b7c5809179d11a326987dc9f6cdcf94f2aa7aa3709763b6f7cfcb7e1e1d'
assert stage['changed_paths']==sorted(['1actions.zil','gglobals.zil','gparser.zil','gsyntax.zil','gverbs.zil','house_kitchen_laboratory.zil','mara_companion.zil','mara_companion_actions.zil','mara_companion_actor.zil','mara_companion_movement.zil','mara_companion_state.zil','zork1.zil'])
assert not smell['errors']
g=(s/'gparser.zil').read_text()
globals_=(s/'gglobals.zil').read_text()
syntax=(s/'gsyntax.zil').read_text()
verbs=(s/'gverbs.zil').read_text()
k=(s/'house_kitchen_laboratory.zil').read_text()
m=(s/'mara_companion.zil').read_text()
a=(s/'mara_companion_actions.zil').read_text()
actor=(s/'mara_companion_actor.zil').read_text()
state=(s/'mara_companion_state.zil').read_text()
move=(s/'mara_companion_movement.zil').read_text()
actions=(s/'1actions.zil').read_text()
assert '<DO-SL ,WINNER ,SH ,SC>' in g
assert '<EQUAL? <GET ,P-LEXV ,P-LEXSTART> ,W?SEND>' in g
assert 'Split sequential actions with a comma or THEN.' in g
assert '<SETG SIBREAKS ".,\\\"?!">' in g
assert '<SET SPTR <GETB ,P-LEXV <+ <* .PTR ,P-LEXELEN> 7>>>' in g
assert '<SETG P-NUMBER <- .EPTR .SPTR>>' in g
assert '<EQUAL? <GET ,P-LEXV .LEN> ,W?OF>' in g
assert '<EQUAL? <GET ,P-LEXV <- .LEN ,P-LEXELEN>> ,W?MADE>' in g
assert '<SETG P-LEN <- ,P-LEN 2>>' in g
assert ',W?SPEAK' in g
assert '(SYNONYM ME MYSELF SELF YOU CRETIN)' in globals_
assert '(DESC "yourself")' in globals_
assert '<OBJECT ZORK-INTERFACE' in globals_
assert '(DESC "Zork")' in globals_
assert '<SYNTAX COMMAND = V-COMMAND-SELF>' in syntax
assert '<SYNTAX YELL AT OBJECT' in syntax
assert '<SYNONYM SAY SPEAK>' in syntax
assert '<SYNTAX SAY = V-SAY>' in syntax
assert '<SYNTAX HELP = V-HELP>' in syntax
assert '<SYNTAX MOO = V-MOO>' in syntax
assert '<SYNTAX BARK = V-BARK>' in syntax
assert '<ROUTINE V-COMMAND-SELF ()' in verbs
assert '<ROUTINE V-YELL-AT ()' in verbs
assert '<EQUAL? ,PRSO ,ZORK-INTERFACE>' in verbs
assert '<ROUTINE V-TALK-UNSPECIFIED ()' in verbs
assert '<ROUTINE PRINT-SPOKEN-INPUT' in verbs
assert '<PRINTC .CHR>' in verbs
assert '<AND ,P-ADVERB <G? ,P-NUMBER 0>>' in verbs
assert 'is not something you can drink.' in verbs
assert '<SYNTAX COOK OBJECT = V-KITCHEN-COOK>' in k
assert '<ROUTINE V-KITCHEN-COOK ()' in k
assert '(ADJECTIVE KITCHEN CAST IRON)' in k
assert 'cast-iron range' not in k
assert '(FLAGS TAKEBIT CONTBIT SEARCHBIT TRYTAKEBIT)' in m
assert '<CONSTANT MARA-SCHEMA 5>' in m
assert '<CONSTANT MARA-SLOT-RESTRAINT-ATTEMPTED 23>' in m
assert '<CONSTANT MARA-SLOT-COMBAT-ORDER-ATTEMPTED 24>' in m
assert '<CONSTANT MARA-SLOT-DEATH-WITNESSED 26>' in m
assert '<CONSTANT MARA-SLOT-OFFSCREEN-GAG 27>' in m
assert '<SYNTAX TIE OBJECT (FIND ACTORBIT)' in m
assert '<SYNTAX SEND OBJECT (FIND ACTORBIT)' in m
assert 'AFTER OBJECT (FIND ACTORBIT)' in m
assert '<SYNTAX EAT OBJECT (FIND ACTORBIT)' in m
assert '<SYNTAX PUT OBJECT (FIND ACTORBIT)' in m
assert 'You cannot put yourself into the ' in actor
assert 'MARA-SLOT-RESTRAINT-ATTEMPTED 0' in state
assert 'MARA-SLOT-COMBAT-ORDER-ATTEMPTED 0' in state
assert 'MARA-SLOT-DEATH-WITNESSED 0' in state
assert 'MARA-SLOT-OFFSCREEN-GAG 0' in state
assert '<ROUTINE MARA-PRINT-NAME ()' in actor
assert '<ROUTINE MARA-RELOCATION-REFUSAL ()' in actor
assert '<ROUTINE MARA-SQUEEZE-GAG ()' in actor
assert '<ROUTINE MARA-WITNESS-PLAYER-DEATH ()' in actor
assert '<ROUTINE MARA-RESTRAINT-REFUSAL ()' in actor
assert '<ROUTINE MARA-COMBAT-ORDER-REFUSAL ()' in actor
assert 'Mara catches the rope before you can get it around her' in actor
assert 'I am your expedition partner, not something you point at an enemy.' in actor
assert 'There is an indeterminate amount of suspicious offscreen activity.' in actor
assert '<MARA-WITNESS-PLAYER-DEATH>' in actions
assert 'Mara already has the pack on her own shoulder.' in a
assert 'It is already here because this is the base I chose' in a
assert 'stops--not at the treasure' in move
assert 'stops—not at the treasure' not in move
PY
GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit 2>/dev/null || true)"
if [[ -z "$GLULX_ZILF_DLL" ]]; then
  pushd .tooling/zilf-glulx
  dotnet restore Zilf.sln --nologo
  dotnet build Zilf.sln --configuration Release --property:PortableTarget=true --no-restore --nologo
  popd
  GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)"
fi
GLULX_ZILF_DLL="$(realpath "$GLULX_ZILF_DLL")"
GLAZER_BIN="$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)"
GLAZER_BIN="$(realpath "$GLAZER_BIN")"
ASSEMBLY="$BUILD/creative-natural-play.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" 2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" --serial "$SERIAL" --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$STORY_FILE" 2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/$STORY_FILE" --json "$BUILD/story-report.json"
make -C .tooling/cheapglk >/dev/null
make -C .tooling/glulxe GLKDIR="$ROOT/.tooling/cheapglk" GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" >/dev/null
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"

cat > "$BUILD/kitchen.txt" <<'EOF'
south
east
open window
enter
examine cast iron range
take sack
open sack
take lunch
put lunch on worktop
cook lunch
cook lunch
cook sack
quit
yes
EOF
timeout 20s "$GLULXE_BIN" --rngseed 41001 "$BUILD/$STORY_FILE" < "$BUILD/kitchen.txt" > "$BUILD/kitchen-transcript.txt" 2>&1 || true
grep -F 'A cast iron range can be lit with a real held flame.' "$BUILD/kitchen-transcript.txt"
grep -F 'You unwrap and arrange the hot-pepper sandwich on the worktop.' "$BUILD/kitchen-transcript.txt"
grep -F 'There is no sensible way to cook the brown sack with the Kitchen fixtures.' "$BUILD/kitchen-transcript.txt"
grep -qF 'I don'"'"'t know the word "cook"' "$BUILD/kitchen-transcript.txt" && exit 1
grep -qF 'I don'"'"'t know the word "cast"' "$BUILD/kitchen-transcript.txt" && exit 1

cat > "$BUILD/nest.txt" <<'EOF'
north
north
up
take nest
down
south
east
open window
enter
put nest on worktop
cook nest
quit
yes
EOF
timeout 20s "$GLULXE_BIN" --rngseed 41003 "$BUILD/$STORY_FILE" < "$BUILD/nest.txt" > "$BUILD/nest-transcript.txt" 2>&1 || true
grep -F 'The woven nest is tinder, not food; the range would burn it rather than cook it.' "$BUILD/nest-transcript.txt"
grep -qF 'I don'"'"'t know the word "cook"' "$BUILD/nest-transcript.txt" && exit 1

cat > "$BUILD/mara.txt" <<'EOF'
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
examine mara
quit
yes
EOF
timeout 30s "$GLULXE_BIN" --rngseed 123456 "$BUILD/$STORY_FILE" < "$BUILD/mara.txt" > "$BUILD/mara-transcript.txt" 2>&1 || true
grep -F 'Mara already has the pack on her own shoulder.' "$BUILD/mara-transcript.txt"
grep -F 'It is already here because this is the base I chose' "$BUILD/mara-transcript.txt"
grep -F 'Mara crosses the threshold, then stops--not at the treasure' "$BUILD/mara-transcript.txt"
grep -qF 'seems confused. "I don'"'"'t see any pack here!"' "$BUILD/mara-transcript.txt" && exit 1
grep -qF 'field camp is at the Dam Base. She cannot pack a camp from a different room.' "$BUILD/mara-transcript.txt" && exit 1
grep -q $'stops\024not' "$BUILD/mara-transcript.txt" && exit 1

cat > "$BUILD/mara-hostile.txt" <<'EOF'
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
take sword
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
down
talk to mara
tie up mara with rope
tie mara with rope
send mara after mara with sword
send mara after mara
mara, attack me with sword
mara, attack me with sword
quit
yes
EOF
timeout 30s "$GLULXE_BIN" --rngseed 123456 "$BUILD/$STORY_FILE" < "$BUILD/mara-hostile.txt" > "$BUILD/mara-hostile-transcript.txt" 2>&1 || true
grep -F 'Mara catches the rope before you can get it around her' "$BUILD/mara-hostile-transcript.txt"
grep -F 'I answered this once' "$BUILD/mara-hostile-transcript.txt"
grep -F 'I am your expedition partner, not something you point at an enemy.' "$BUILD/mara-hostile-transcript.txt"
grep -F 'You already know I do not take combat orders from you' "$BUILD/mara-hostile-transcript.txt"
grep -qF 'struggles and you cannot tie him up' "$BUILD/mara-hostile-transcript.txt" && exit 1
grep -qF 'I don'"'"'t know the word "after"' "$BUILD/mara-hostile-transcript.txt" && exit 1

python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text())
story=json.loads(Path('glulx/build/creative-natural-play-1245/story-report.json').read_text())
e=m['expected_artifact']
assert story['format']==e['format'] and story['version_hex']==e['version_hex'] and story['checksum_valid'] is True
if e.get('locked'):
    assert story['size_bytes']==e['size_bytes']
    assert story['checksum_hex']==e['checksum_hex']
    assert story['sha256']==e['sha256']
receipt={'release':1245,'serial':m['serial'],'artifact':story,'artifact_identity_locked':e.get('locked',False),'gameplay':{'cook_parser':'passed','cast_iron_range_parser':'passed','weird_nest_cook':'passed','actor_carried_noun_scope':'passed','mara_carried_pack_repeat':'passed','mara_attic_pack_truth':'passed','mara_house_prose_glulx_safe':'passed','mara_restraint_refusal':'passed','mara_restraint_repeat_history':'passed','mara_send_after_refusal':'passed','mara_actor_combat_order_refusal':'passed'}}
Path('glulx/build/creative-natural-play-1245/QUALIFICATION-RECEIPT.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(receipt,indent=2))
PY
