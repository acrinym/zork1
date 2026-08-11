#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/environmental-destruction-1246"
BASE_SRC="$BUILD/base-1245-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
PROD_COMPLETION_SRC="$BUILD/completion-production-src"
DEV_COMPLETION_SRC="$BUILD/completion-dev-src"
MANIFEST="$ROOT/glulx/environmental-destruction/patch-series.json"
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

python -m py_compile glulx/environmental-destruction/stage.py
python glulx/creative-natural-play/stage.py \
  --upstream .upstream/zork1-glulx \
  --destination "$BASE_SRC" \
  --allowed-root "$BUILD" \
  --manifest glulx/creative-natural-play/patch-series.json
python glulx/environmental-destruction/stage.py \
  --base-source "$BASE_SRC" \
  --destination "$SRC" \
  --manifest "$MANIFEST"
python glulx/environmental-destruction/stage.py \
  --base-source "$BASE_SRC" \
  --destination "$DEV_SRC" \
  --manifest "$MANIFEST" \
  --dev

python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path
build=Path('glulx/build/environmental-destruction-1246')
s=build/'src'
d=build/'dev-src'
b=build/'base-1245-src'
stage=json.loads((s/'STAGING-RECEIPT.json').read_text())
dev_stage=json.loads((d/'STAGING-RECEIPT.json').read_text())
smell=json.loads((build/'smell-report.json').read_text())
dev_smell=json.loads((build/'dev-smell-report.json').read_text())
assert stage['release']==1246 and stage['base']['release']==1245
assert stage['base']['artifact_sha256']=='d84c724aa34afc30312d69e7ac2064c5f9f182311a441681cf5b585ec83a0a16'
assert stage['changed_paths']==sorted(['1actions.zil','gsyntax.zil','material_consequences.zil','shadow_logic.zil','zork1.zil'])
assert stage['dev_mode'] is False and stage['test_only'] is False
assert dev_stage['dev_mode'] is True and dev_stage['test_only'] is True
assert dev_stage['changed_paths']==stage['changed_paths']
assert not smell['errors'] and not dev_smell['errors']
material=(s/'material_consequences.zil').read_text()
dev_material=(d/'material_consequences.zil').read_text()
base_material=(b/'material_consequences.zil').read_text()
syntax=(s/'gsyntax.zil').read_text()
shadow=(s/'shadow_logic.zil').read_text()
actions=(s/'1actions.zil').read_text()
zork=(s/'zork1.zil').read_text()
assert '<OBJECT FIELD-STONE' in material
assert '(SYNONYM ROCK STONE)' in material
assert '<OBJECT ENVIRONMENTAL-DAMAGE' in material
assert '(SYNONYM DAMAGE ENVIRONMENT BREAKAGE)' in material
assert '<CONSTANT MD-MAILBOX-DAMAGE 0>' in material
assert '<CONSTANT MD-DEV-MODE 5>' in material
assert '<CONSTANT MATERIAL-DESTRUCTION-STATE <TABLE 0 <> <> <> <> <>>>' in material
assert '<CONSTANT MATERIAL-DESTRUCTION-STATE <TABLE 0 <> <> <> <> T>>' in dev_material
assert '<ROUTINE MATERIAL-DESTRUCTION-GET (SLOT)' in material
assert '<ROUTINE MATERIAL-DESTRUCTION-PUT (SLOT VALUE)' in material
assert material.count('<GLOBAL ') == base_material.count('<GLOBAL ')
assert 'MATERIAL-DESTRUCTION-DEV-MODE' not in material
assert '<ROUTINE V-RESET-DAMAGE ()' in material
assert '<ROUTINE MATERIAL-RESETTABLE-STATE? ()' in material
assert '<NOT <MATERIAL-RESETTABLE-STATE?>>' in material
assert '<COND (<G? <MATERIAL-DESTRUCTION-GET ,MD-MAILBOX-DAMAGE> 0>' in material
assert '<COND (<MATERIAL-DESTRUCTION-GET ,MD-WINDOW-BROKEN>' in material
assert '<ROUTINE MATERIAL-DESTRUCTION-COMPLETION-PROMPT ()' in material
assert '<AND <MATERIAL-DESTRUCTION-GET ,MD-DEV-MODE> <MATERIAL-DAMAGE-PRESENT?>>' in material
assert '<ROUTINE MATERIAL-DESTRUCTION-HOOK ()' in material
assert '<MATERIAL-DESTRUCTION-HOOK> <RTRUE>' in shadow
assert '<SYNTAX RESET OBJECT (FIND RMUNGBIT) = V-RESET-DAMAGE>' in syntax
assert '<SYNTAX RESET DAMAGE = V-RESET-DAMAGE>' in syntax
assert '<SYNTAX RESET ENVIRONMENT = V-RESET-DAMAGE>' in syntax
assert '<SYNTAX RESET BREAKAGE = V-RESET-DAMAGE>' in syntax
assert '<SYNTAX KILL OBJECT (ON-GROUND IN-ROOM HELD CARRIED)\n\tWITH OBJECT (FIND WEAPONBIT)' in syntax
assert '<SYNTAX THROW OBJECT (HELD CARRIED HAVE)\n\tAT OBJECT (ON-GROUND IN-ROOM) = V-THROW>' in syntax
assert '<SYNTAX THROW OBJECT (HELD CARRIED HAVE)\n\tWITH OBJECT (ON-GROUND IN-ROOM) = V-THROW>' in syntax
assert actions.count('<MATERIAL-DESTRUCTION-COMPLETION-PROMPT>') == 1
assert 'ZORK: The Great Underground Empire.|" CR>)>\n\t\t<MATERIAL-DESTRUCTION-COMPLETION-PROMPT>\n\t\t<FINISH>)>>' in actions
assert '<CONSTANT RELEASEID 1246>' in zork
assert not (s/'environmental_destruction_completion_test.zil').exists()
assert not (d/'environmental_destruction_completion_test.zil').exists()
assert 'EDWIN' not in zork
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

compile_story() {
  local source="$1" assembly="$2" output="$3" log_prefix="$4"
  pushd "$source"
  dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$assembly" \
    2>&1 | tee "$BUILD/$log_prefix-zilf-compile.log"
  popd
  python glulx/tools/normalize_serial.py "$assembly" --serial "$SERIAL" \
    --receipt "$BUILD/$log_prefix-SERIAL-NORMALIZATION.json"
  "$GLAZER_BIN" "$assembly" -o "$output" \
    2>&1 | tee "$BUILD/$log_prefix-glazer-assemble.log"
}

ASSEMBLY="$BUILD/environmental-destruction.asm"
STORY="$BUILD/$STORY_FILE"
compile_story "$SRC" "$ASSEMBLY" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

DEV_ASSEMBLY="$BUILD/environmental-destruction-dev.asm"
DEV_STORY="$BUILD/zork1-glulx-environmental-destruction-dev.ulx"
compile_story "$DEV_SRC" "$DEV_ASSEMBLY" "$DEV_STORY" dev
python glulx/tools/verify_ulx.py "$DEV_STORY" --json "$BUILD/dev-story-report.json"

rm -rf "$PROD_COMPLETION_SRC" "$DEV_COMPLETION_SRC"
cp -a "$SRC" "$PROD_COMPLETION_SRC"
cp -a "$DEV_SRC" "$DEV_COMPLETION_SRC"
cp glulx/environmental-destruction/tests/environmental_destruction_completion_test.zil \
  "$PROD_COMPLETION_SRC/environmental_destruction_completion_test.zil"
cp glulx/environmental-destruction/tests/environmental_destruction_completion_test.zil \
  "$DEV_COMPLETION_SRC/environmental_destruction_completion_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
patch=Path('glulx/environmental-destruction/tests/001-include-completion-test.json').resolve()
for target in (
    Path('glulx/build/environmental-destruction-1246/completion-production-src').resolve(),
    Path('glulx/build/environmental-destruction-1246/completion-dev-src').resolve(),
):
    apply_patch(patch, target)
PY
PROD_COMPLETION_STORY="$BUILD/zork1-glulx-environmental-destruction-completion-production-test.ulx"
DEV_COMPLETION_STORY="$BUILD/zork1-glulx-environmental-destruction-completion-dev-test.ulx"
compile_story "$PROD_COMPLETION_SRC" "$BUILD/completion-production.asm" "$PROD_COMPLETION_STORY" completion-production
compile_story "$DEV_COMPLETION_SRC" "$BUILD/completion-dev.asm" "$DEV_COMPLETION_STORY" completion-dev
python glulx/tools/verify_ulx.py "$PROD_COMPLETION_STORY" --json "$BUILD/completion-production-story-report.json"
python glulx/tools/verify_ulx.py "$DEV_COMPLETION_STORY" --json "$BUILD/completion-dev-story-report.json"

make -C .tooling/cheapglk >/dev/null
make -C .tooling/glulxe GLKDIR="$ROOT/.tooling/cheapglk" GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" >/dev/null
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"

cat > "$BUILD/production-destruction.txt" <<'EOF'
take rock
throw rock at mailbox
examine mailbox
kill mailbox
take rock
south
east
throw rock through window
examine window
enter
examine window
reset damage
quit
yes
EOF
timeout 25s "$GLULXE_BIN" --rngseed 1246001 "$STORY" \
  < "$BUILD/production-destruction.txt" > "$BUILD/production-destruction-transcript.txt" 2>&1
PROD="$BUILD/production-destruction-transcript.txt"
grep -F 'The impact caves a broad dent into the side of the mailbox.' "$PROD"
grep -F "I've known strange people, but fighting a small mailbox?" "$PROD"
grep -F 'punches through the Kitchen window.' "$PROD"
grep -F 'continues through the opening and lands in the Kitchen.' "$PROD"
grep -F 'The Kitchen window has been shattered out.' "$PROD"
grep -F 'Environmental damage reset is available only in the Release 1246 dev/test build.' "$PROD"
if grep -qF 'I don'"'"'t know the word "rock"' "$PROD"; then exit 1; fi
if grep -qF 'I don'"'"'t know the word "through"' "$PROD"; then exit 1; fi
if grep -qF 'I don'"'"'t know the word "reset"' "$PROD"; then exit 1; fi

cat > "$BUILD/dev-reset.txt" <<'EOF'
take rock
throw rock at mailbox
reset damage
take mailbox
take rock
south
east
throw rock through window
enter
reset environment
examine window
quit
yes
EOF
timeout 25s "$GLULXE_BIN" --rngseed 1246002 "$DEV_STORY" \
  < "$BUILD/dev-reset.txt" > "$BUILD/dev-reset-transcript.txt" 2>&1
DEV="$BUILD/dev-reset-transcript.txt"
grep -F 'Developer reset restored the authored environmental breakages without changing score, treasures, relationship history, or canonical puzzle progress.' "$DEV"
grep -F 'It is securely anchored.' "$DEV"
grep -F 'The window is slightly ajar, but not enough to allow entry.' "$DEV"
if grep -qF 'Environmental damage reset is available only in the Release 1246 dev/test build.' "$DEV"; then exit 1; fi

cat > "$BUILD/dev-stone-only-reset.txt" <<'EOF'
open mailbox
take rock
reset damage
look
close mailbox
quit
yes
EOF
timeout 20s "$GLULXE_BIN" --rngseed 1246004 "$DEV_STORY" \
  < "$BUILD/dev-stone-only-reset.txt" > "$BUILD/dev-stone-only-reset-transcript.txt" 2>&1
DEV_STONE="$BUILD/dev-stone-only-reset-transcript.txt"
grep -F 'Developer reset restored the authored environmental breakages without changing score, treasures, relationship history, or canonical puzzle progress.' "$DEV_STONE"
grep -F 'A fist-sized loose stone rests in the grass.' "$DEV_STONE"
if grep -qF 'The warped mailbox door no longer stays closed.' "$DEV_STONE"; then exit 1; fi

cat > "$BUILD/axe-mailbox.txt" <<'EOF'
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
south
south
east
north
up
east
south
west
destroy mailbox with axe
take mailbox
examine mailbox
quit
yes
EOF
timeout 35s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/axe-mailbox.txt" > "$BUILD/axe-mailbox-transcript.txt" 2>&1
AXE_OUT="$BUILD/axe-mailbox-transcript.txt"
grep -F 'The bloody axe bites through the wooden post with a brutal crack.' "$AXE_OUT"
grep -F 'You pick up the mailbox. Severing the post has converted landscaping into luggage.' "$AXE_OUT"
grep -F 'The small mailbox has been cut free from its severed post.' "$AXE_OUT"
if grep -qF 'Trying to destroy the small mailbox with a bloody axe is futile.' "$AXE_OUT"; then exit 1; fi

cat > "$BUILD/troll-rock.txt" <<'EOF'
take rock
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
throw rock at troll
quit
yes
EOF
timeout 30s "$GLULXE_BIN" --rngseed 1246003 "$STORY" \
  < "$BUILD/troll-rock.txt" > "$BUILD/troll-rock-transcript.txt" 2>&1
TROLL_OUT="$BUILD/troll-rock-transcript.txt"
if grep -qF 'I don'"'"'t understand that sentence.' "$TROLL_OUT"; then exit 1; fi
if grep -qF 'I don'"'"'t know the word "rock"' "$TROLL_OUT"; then exit 1; fi

cat > "$BUILD/completion-production.txt" <<'EOF'
take rock
throw rock at mailbox
edwin
enter
quit
EOF
timeout 20s "$GLULXE_BIN" --rngseed 1246010 "$PROD_COMPLETION_STORY" \
  < "$BUILD/completion-production.txt" > "$BUILD/completion-production-transcript.txt" 2>&1
COMP_PROD="$BUILD/completion-production-transcript.txt"
grep -F 'Inside the Barrow' "$COMP_PROD"
grep -F 'completed a great and perilous adventure' "$COMP_PROD"
if grep -qF 'Dev/test world damage remains.' "$COMP_PROD"; then exit 1; fi
if grep -qF 'Developer reset complete.' "$COMP_PROD"; then exit 1; fi

cat > "$BUILD/completion-dev-damage.txt" <<'EOF'
take rock
throw rock at mailbox
edwin
enter
yes
quit
EOF
timeout 20s "$GLULXE_BIN" --rngseed 1246011 "$DEV_COMPLETION_STORY" \
  < "$BUILD/completion-dev-damage.txt" > "$BUILD/completion-dev-damage-transcript.txt" 2>&1
COMP_DEV="$BUILD/completion-dev-damage-transcript.txt"
grep -F 'Inside the Barrow' "$COMP_DEV"
grep -F 'Dev/test world damage remains. Reset environmental breakages before ending this completed run?' "$COMP_DEV"
grep -F 'Developer reset complete. The next test run starts from an undamaged authored environment.' "$COMP_DEV"

cat > "$BUILD/completion-dev-stone-only.txt" <<'EOF'
take rock
edwin
enter
quit
EOF
timeout 20s "$GLULXE_BIN" --rngseed 1246012 "$DEV_COMPLETION_STORY" \
  < "$BUILD/completion-dev-stone-only.txt" > "$BUILD/completion-dev-stone-only-transcript.txt" 2>&1
COMP_STONE="$BUILD/completion-dev-stone-only-transcript.txt"
grep -F 'Inside the Barrow' "$COMP_STONE"
if grep -qF 'Dev/test world damage remains.' "$COMP_STONE"; then exit 1; fi
if grep -qF 'Developer reset complete.' "$COMP_STONE"; then exit 1; fi

test -f "$BUILD/story-report.json"
python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text())
b=Path('glulx/build/environmental-destruction-1246')
story=json.loads((b/'story-report.json').read_text())
dev=json.loads((b/'dev-story-report.json').read_text())
e=m['expected_artifact']
assert story['format']==e['format']
assert story['version_hex']==e['version_hex']
assert story['checksum_valid'] is True
assert dev['format']=='Glulx' and dev['checksum_valid'] is True
if e.get('locked'):
    assert story['size_bytes']==e['size_bytes']
    assert story['checksum_hex']==e['checksum_hex']
    assert story['sha256']==e['sha256']
receipt={
  'release':1246,
  'serial':m['serial'],
  'artifact':story,
  'artifact_identity_locked':e.get('locked',False),
  'dev_artifact':dev,
  'gameplay':{
    'mailbox_blunt_damage':'passed',
    'bare_kill_mailbox_delegation':'passed',
    'mailbox_axe_sever':'passed',
    'mailbox_carry_after_sever':'passed',
    'throw_rock_through_window':'passed',
    'broken_window_traversal':'passed',
    'production_reset_refusal':'passed',
    'dev_reset':'passed',
    'dev_stone_only_reset':'passed',
    'troll_throw_delegation':'passed',
    'completion_production_no_meta_prompt':'passed',
    'completion_dev_breakage_prompt_and_reset':'passed',
    'completion_dev_stone_only_no_prompt':'passed',
    'compact_state_without_new_globals':'passed',
    'real_axe_return_via_chimney':'passed'
  },
  'production_contains_completion_fixture':False,
  'dev_artifact_contains_completion_fixture':False
}
(b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(receipt,indent=2))
PY
true
