#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/dam-survival-prepared-rescue-1253"
BUILD="$ROOT/glulx/build/troll-disarm-stolen-weapons-1254"
BASE_SRC="$BASE_BUILD/src"; BASE_DEV_SRC="$BASE_BUILD/dev-src"; SRC="$BUILD/src"; DEV_SRC="$BUILD/dev-src"; TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/troll-stolen-weapons/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/dam-survival/qualify.sh
python -m py_compile glulx/troll-stolen-weapons/stage.py
python - "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import importlib.util,json,sys
from pathlib import Path
spec=importlib.util.spec_from_file_location('stage1254','glulx/troll-stolen-weapons/stage.py'); mod=importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
m=json.loads(Path(sys.argv[1]).read_text()); actual={'production':mod.source_identity(Path(sys.argv[2])),'dev':mod.source_identity(Path(sys.argv[3]))}
for k,v in actual.items(): assert m['base_source_sha256'][k]==v,(k,m['base_source_sha256'][k],v)
PY
python glulx/troll-stolen-weapons/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/troll-stolen-weapons/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"
python - <<'PY'
import json
from pathlib import Path
b=Path('glulx/build/troll-disarm-stolen-weapons-1254'); s=b/'src'; d=b/'dev-src'
stage=json.loads((s/'STAGING-RECEIPT.json').read_text()); dev=json.loads((d/'STAGING-RECEIPT.json').read_text()); smell=json.loads((b/'smell-report.json').read_text()); dev_smell=json.loads((b/'dev-smell-report.json').read_text())
assert stage['release']==1254 and stage['base']['release']==1253 and stage['base']['artifact_sha256']=='232baaa8255f4b95ab5f90e13e6669874bcd42c66744d8173f360169ffb499ff'
assert stage['changed_paths']==sorted(['1actions.zil','assistance.zil','zork1.zil']); assert stage['dev_mode'] is False and dev['dev_mode'] is True; assert not smell['errors'] and not dev_smell['errors']
actions=(s/'1actions.zil').read_text(); assist=(s/'assistance.zil').read_text(); zork=(s/'zork1.zil').read_text()
for token in ('<ROUTINE TROLL-STOLEN-WEAPON','<ROUTINE TROLL-CAPTURE-WEAPON','<ROUTINE TROLL-STOLEN-BLOW-REMARK','<TROLL-CAPTURE-WEAPON .DWEAPON>','<TROLL-DROP-STOLEN-WEAPONS>','The bargain buys the weapon, not safe passage.','The troll answers by raising your stolen '): assert token in actions,token
assert '<AND <EQUAL? .VILLAIN ,TROLL>' in actions and '<EQUAL? .O ,TROLL>' in actions and '<FSET? ,PRSO ,FOODBIT>' in actions
assert 'food can buy that exact weapon back' in assist and '<CONSTANT RELEASEID 1254>' in zork and 'TROLL DISARM AND STOLEN WEAPONS GLULX' in zork
for forbidden in ('TROLL-OWNERSHIP','TROLL-HOSTILITY','TROLL-INVENTORY','<GLOBAL TROLL-STOLEN'): assert forbidden not in actions
PY
IFS=$'\t' read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text()); print('\t'.join((m['serial'],m['expected_artifact']['file'])))
PY
)
GLULX_ZILF_DLL="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"; GLAZER_BIN="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
compile_story(){ local source="$1" assembly="$2" output="$3" prefix="$4"; pushd "$source"; dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$assembly" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"; popd; python glulx/tools/normalize_serial.py "$assembly" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"; "$GLAZER_BIN" "$assembly" -o "$output" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"; }
STORY="$BUILD/$STORY_FILE"; compile_story "$SRC" "$BUILD/troll-stolen-weapons.asm" "$STORY" production; python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
rm -rf "$TEST_SRC"; cp -a "$DEV_SRC" "$TEST_SRC"; cp glulx/troll-stolen-weapons/tests/troll_stolen_weapons_test.zil "$TEST_SRC/troll_stolen_weapons_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0,str(Path('glulx/tools').resolve())); from stage_release120 import apply_patch
apply_patch(Path('glulx/troll-stolen-weapons/tests/001-include-troll-stolen-test.json').resolve(),Path('glulx/build/troll-disarm-stolen-weapons-1254/test-src').resolve())
PY
TEST_STORY="$BUILD/troll-stolen-weapons-test.ulx"; compile_story "$TEST_SRC" "$BUILD/troll-stolen-weapons-test.asm" "$TEST_STORY" test
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"

cat > "$BUILD/custody-armed.txt" <<'EOF1'
trollcustody
examine troll
take sword
trollarmed
quit
yes
EOF1
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/custody-armed.txt" > "$BUILD/custody-armed-transcript.txt" 2>&1
C="$BUILD/custody-armed-transcript.txt"; grep -F 'Before the sword can hit the floor, the troll snatches it out of the air.' "$C"; grep -F 'The sword in his hands is unmistakably yours.' "$C"; grep -F 'The troll swings it out of your reach.' "$C"; grep -F 'TEST troll preferred weapon: sword' "$C"

cat > "$BUILD/custody-bargain.txt" <<'EOF2'
trollcustody
give lunch to troll
quit
yes
EOF2
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/custody-bargain.txt" > "$BUILD/custody-bargain-transcript.txt" 2>&1
B="$BUILD/custody-bargain-transcript.txt"; grep -F 'Before the sword can hit the floor, the troll snatches it out of the air.' "$B"; grep -F 'The bargain buys the weapon, not safe passage.' "$B"

cat > "$BUILD/custody-subdue.txt" <<'EOF3'
trollcustody
trollsubdue
look
take sword
inventory
quit
yes
EOF3
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/custody-subdue.txt" > "$BUILD/custody-subdue-transcript.txt" 2>&1
S="$BUILD/custody-subdue-transcript.txt"; grep -F 'TEST PRECONDITION: canonical troll unconsciousness resolved after stolen-weapon custody.' "$S"; grep -F 'An unconscious troll is sprawled on the floor. All passages' "$S"; grep -F 'Taken.' "$S"

python - "$STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); manifest=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/troll-disarm-stolen-weapons-1254'); report=json.loads((b/'story-report.json').read_text())
identity={'file':story.name,'format':'Glulx','version_hex':report['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':report['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}; assert report['checksum_valid'] is True; expected=manifest['expected_artifact']
if expected.get('locked') is not True: print('RELEASE_1254_ARTIFACT_IDENTITY='+json.dumps(identity,sort_keys=True)); raise SystemExit(4)
for key in ('file','version_hex','size_bytes','checksum_hex','sha256'): assert expected[key]==identity[key],(key,expected[key],identity[key])
receipt={'release':1254,'serial':manifest['serial'],'artifact_identity_locked':True,'production':{**identity,'report':report},'base_release':1253,'base_artifact_sha256':manifest['base_artifact_sha256'],'custody_armed':'custody-armed-transcript.txt','custody_bargain':'custody-bargain-transcript.txt','custody_subdue':'custody-subdue-transcript.txt'}; (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(receipt,indent=2,sort_keys=True)+'\n'); print(json.dumps(receipt,indent=2,sort_keys=True))
PY
echo "Release 1254 Troll Disarm & Stolen Weapons qualified."
