#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/troll-disarm-stolen-weapons-1254"
BUILD="$ROOT/glulx/build/thief-retaliation-sabotage-1255"
BASE_SRC="$BASE_BUILD/src"; BASE_DEV_SRC="$BASE_BUILD/dev-src"; SRC="$BUILD/src"; DEV_SRC="$BUILD/dev-src"; TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/thief-retaliation/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/troll-stolen-weapons/qualify.sh
python -m py_compile glulx/thief-retaliation/stage.py
python - "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import importlib.util,json,sys
from pathlib import Path
spec=importlib.util.spec_from_file_location('stage1255','glulx/thief-retaliation/stage.py'); mod=importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
m=json.loads(Path(sys.argv[1]).read_text()); actual={'production':mod.source_identity(Path(sys.argv[2])),'dev':mod.source_identity(Path(sys.argv[3]))}
for k,v in actual.items(): assert m['base_source_sha256'][k]==v,(k,m['base_source_sha256'][k],v)
PY
python glulx/thief-retaliation/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/thief-retaliation/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"
python - <<'PY'
import json
from pathlib import Path
b=Path('glulx/build/thief-retaliation-sabotage-1255'); s=b/'src'; d=b/'dev-src'
stage=json.loads((s/'STAGING-RECEIPT.json').read_text()); dev=json.loads((d/'STAGING-RECEIPT.json').read_text()); smell=json.loads((b/'smell-report.json').read_text()); dev_smell=json.loads((b/'dev-smell-report.json').read_text())
assert stage['release']==1255 and stage['base']['release']==1254 and stage['base']['artifact_sha256']=='5db6a858d30cc2a06d1becb520795587753ca3d29791447f253a1cdd9bbd2fb4'
assert stage['changed_paths']==sorted(['1actions.zil','1dungeon.zil','assistance.zil','zork1.zil']); assert stage['dev_mode'] is False and dev['dev_mode'] is True; assert not smell['errors'] and not dev_smell['errors']
actions=(s/'1actions.zil').read_text(); dungeon=(s/'1dungeon.zil').read_text(); assist=(s/'assistance.zil').read_text(); zork=(s/'zork1.zil').read_text()
for token in ('<GETP ,THIEF ,P?VALUE>','<ROUTINE THIEF-PROVOKE','<ROUTINE THIEF-ARMED-DETERRENT?','<ROUTINE THIEF-RETALIATION-TARGET','<ROUTINE THIEF-RETALIATION-STRIKE','<THIEF-RETALIATION-STRIKE> <RTRUE>','private list. This has become','This time the theft is plainly about inconvenience, not resale value.','The personal account appears settled.'):
    assert token in actions,token
for trigger in ('<THIEF-PROVOKE>\n\t\t\t      <FSET ,THIEF ,FIGHTBIT>','<THIEF-PROVOKE>\n\t\t       <TELL\n"The bag will be taken over his dead body."','<THIEF-PROVOKE>\n\t\t<FSET ,THIEF ,FIGHTBIT>'):
    assert trigger in actions,trigger
assert '(VALUE 0)>' in dungeon[dungeon.index('<OBJECT THIEF'):dungeon.index('<OBJECT PEDESTAL')] and 'visible steel can make him abandon an ambush' in assist and '<CONSTANT RELEASEID 1255>' in zork and 'THIEF RETALIATION AND SABOTAGE GLULX' in zork
for forbidden in ('GLOBAL THIEF-RETALIATING','THIEF-HOSTILITY','THIEF-ANGER-SCORE','THIEF-ATTITUDE','THIEF-INVENTORY-MODEL'):
    assert forbidden not in actions
PY
IFS=$'\t' read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text()); print('\t'.join((m['serial'],m['expected_artifact']['file'])))
PY
)
GLULX_ZILF_DLL="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"; GLAZER_BIN="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
compile_story(){ local source="$1" assembly="$2" output="$3" prefix="$4"; pushd "$source"; dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$assembly" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"; popd; python glulx/tools/normalize_serial.py "$assembly" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"; "$GLAZER_BIN" "$assembly" -o "$output" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"; }
STORY="$BUILD/$STORY_FILE"; compile_story "$SRC" "$BUILD/thief-retaliation.asm" "$STORY" production; python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
rm -rf "$TEST_SRC"; cp -a "$DEV_SRC" "$TEST_SRC"; cp glulx/thief-retaliation/tests/thief_retaliation_test.zil "$TEST_SRC/thief_retaliation_test.zil"
python - <<'PY'
from pathlib import Path
import sy

sys.path.insert(0,str(Path('glulx/tools').resolve())); from stage_release120 import apply_patch
apply_patch(Path('glulx/thief-retaliation/tests/001-include-thief-retaliation-test.json').resolve(),Path('glulx/build/thief-retaliation-sabotage-1255/test-src').resolve())
PY
TEST_STORY="$BUILD/thief-retaliation-test.ulx"; compile_story "$TEST_SRC" "$BUILD/thief-retaliation-test.asm" "$TEST_STORY" test
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"

cat > "$BUILD/sabotage.txt" <<'EOF1'
thiefsabotage
look
take lunch
put lunch in sack
inventory
quit
yes
EOF1
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/sabotage.txt" > "$BUILD/sabotage-transcript.txt" 2>&1
S="$BUILD/sabotage-transcript.txt"; grep -F 'Its contents scatter across the floor.' "$S"; grep -F 'Nothing is destroyed;' "$S"; grep -F 'TEST PRECONDITION: retaliatory sack sabotage executed without destroying any object.' "$S"; grep -F 'Taken.' "$S"

cat > "$BUILD/selective-theft.txt" <<'EOF2'
thiefsteal
thiefstatus
quit
yes
EOF2
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/selective-theft.txt" > "$BUILD/selective-theft-transcript.txt" 2>&1
T="$BUILD/selective-theft-transcript.txt"; grep -F 'takes the wrench with insulting precision' "$T"; grep -F 'This time the theft is plainly about inconvenience, not resale value.' "$T"; grep -F 'TEST wrench custody: thief' "$T"

cat > "$BUILD/avoidance.txt" <<'EOF3'
thiefavoid
thiefstatus
quit
yes
EOF3
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/avoidance.txt" > "$BUILD/avoidance-transcript.txt" 2>&1
A="$BUILD/avoidance-transcript.txt"; grep -F 'notices the weapon in your hand, and thinks better of the arrangement.' "$A"; grep -F 'TEST thief retaliation: active' "$A"; grep -F 'TEST thief visibility: hidden' "$A"

cat > "$BUILD/appeasement.txt" <<'EOF4'
thiefappease
thiefstatus
quit
yes
EOF4
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/appeasement.txt" > "$BUILD/appeasement-transcript.txt" 2>&1
P="$BUILD/appeasement-transcript.txt"; grep -F 'The personal account appears settled.' "$P"; grep -F 'His profession, of course, remains' "$P"; grep -F 'TEST thief retaliation: settled' "$P"

python - "$STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); manifest=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/thief-retaliation-sabotage-1255'); report=json.loads((b/'story-report.json').read_text())
identity={'file':story.name,'format':'Glulx','version_hex':report['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':report['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}; assert report['checksum_valid'] is True; expected=manifest['expected_artifact']
if expected.get('locked') is not True: print('RELEASE_1255_ARTIFACT_IDENTITY='+json.dumps(identity,sort_keys=True)); raise SystemExit(4)
for key in ('file','version_hex','size_bytes','checksum_hex','sha256'): assert expected[key]==identity[key],(key,expected[key],identity[key])
receipt={'release':1255,'serial':manifest['serial'],'artifact_identity_locked':True,'production':{**identity,'report':report},'base_release':1254,'base_artifact_sha256':manifest['base_artifact_sha256'],'sabotage':'sabotage-transcript.txt','selective_theft':'selective-theft-transcript.txt','avoidance':'avoidance-transcript.txt','appeasement':'appeasement-transcript.txt'}; (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(receipt,indent=2,sort_keys=True)+'\n'); print(json.dumps(receipt,indent=2,sort_keys=True))
PY
echo "Release 1255 Thief Retaliation & Sabotage qualified."
