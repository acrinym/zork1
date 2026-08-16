#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/hostile-rooms-dragon-hoard-1262"; BUILD="$ROOT/glulx/build/ablative-protection-1263"
BASE_SRC="$BASE_BUILD/src"; BASE_DEV_SRC="$BASE_BUILD/dev-src"; SRC="$BUILD/src"; DEV_SRC="$BUILD/dev-src"; TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/ablative-protection/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"
bash glulx/hostile-rooms-dragon-hoard/qualify.sh
python -m py_compile glulx/ablative-protection/stage.py
python glulx/ablative-protection/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/ablative-protection/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"
python - <<'PY'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/ablative-protection-1263'); s=b/'src'; base=Path('glulx/build/hostile-rooms-dragon-hoard-1262/src'); m=json.loads(Path('glulx/ablative-protection/patch-series.json').read_text())
r=json.loads((s/'STAGING-RECEIPT.json').read_text()); req(r['release']==1263 and r['base']['release']==1262,'Release 1263 staging/base mismatch'); req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1263 changed-path mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'] and not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1263 smell errors')
a=(s/'ablative_protection.zil').read_text(); d=(s/'dragon_hoard.zil').read_text(); sh=(s/'shadow_logic.zil').read_text(); z=(s/'zork1.zil').read_text()
for t in ('<OBJECT DRAGON-FIRE-SCREEN','<ROUTINE ABLATIVE-PREPARE','<ROUTINE ABLATIVE-DRAGON-BREATH?','AP-SOUND','AP-SCORCHED','AP-WARPED','It looks used, not numerically damaged'):
    req(t in a,f'missing Release 1263 token: {t}')
for bad in ('DURABILITY','ARMOR-CLASS','ARMOUR-CLASS','HIT-POINT','REPAIR-BENCH','GENERIC-EQUIPMENT','BLOCK-ACTION'):
    req(bad not in a,f'Release 1263 crossed generic equipment boundary: {bad}')
req('<ABLATIVE-DRAGON-BREATH?>' in d,'Release 1263 does not intercept exact dragon breath authority')
req('<EQUAL? ,PRSO ,DRAGON-FIRE-SCREEN>' in sh and '<ABLATIVE-PREPARE>' in sh,'Release 1263 missing existing USE routing')
req((s/'gsyntax.zil').read_bytes()==(base/'gsyntax.zil').read_bytes(),'Release 1263 changed parser grammar')
req((s/'gverbs.zil').read_bytes()==(base/'gverbs.zil').read_bytes(),'Release 1263 changed verb authority')
req('<CONSTANT RELEASEID 1263>' in z and '<INSERT-FILE "ablative_protection" T>' in z,'Release 1263 identity/include missing')
PY
IFS=$'\t' read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text()); print("\t".join((m['serial'],m['expected_artifact']['file'])))
PY
)
GLULX_ZILF_DLL="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"; GLAZER_BIN="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
compile_story(){ local source="$1" assembly="$2" output="$3" prefix="$4"; pushd "$source"; dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$assembly" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"; popd; python "$ROOT/glulx/tools/normalize_serial.py" "$assembly" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"; "$GLAZER_BIN" "$assembly" -o "$output" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"; }
STORY="$BUILD/$STORY_FILE"; compile_story "$SRC" "$BUILD/ablative-protection.asm" "$STORY" production; python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
rm -rf "$TEST_SRC"; cp -a "$DEV_SRC" "$TEST_SRC"; cp glulx/ablative-protection/tests/ablative_protection_test.zil "$TEST_SRC/ablative_protection_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0,str(Path('glulx/tools').resolve())); from stage_release120 import apply_patch
apply_patch(Path('glulx/ablative-protection/tests/001-include-ablative-test.json').resolve(),Path('glulx/build/ablative-protection-1263/test-src').resolve())
PY
TEST_STORY="$BUILD/ablative-protection-test.ulx"; compile_story "$TEST_SRC" "$BUILD/ablative-protection-test.asm" "$TEST_STORY" test
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"; run_case(){ local n="$1"; timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/$n.txt" > "$BUILD/$n-transcript.txt" 2>&1; }
cat > "$BUILD/sound-screen.txt" <<'EOF1'
aprep
use screen on me
examine dragon
astatus
quit
yes
EOF1
run_case sound-screen; F="$BUILD/sound-screen-transcript.txt"; grep -F "The dragon's breath hits the braced screen" "$F"; grep -F 'condition=1 prepared=0 screen-held=1' "$F"
cat > "$BUILD/scorched-screen.txt" <<'EOF2'
ascorched
use screen on dragon
listen to dragon
astatus
quit
yes
EOF2
run_case scorched-screen; F="$BUILD/scorched-screen-transcript.txt"; grep -F 'A second blast catches the already-shrunken hide' "$F"; grep -F 'condition=2 prepared=0 screen-held=1' "$F"
cat > "$BUILD/warped-screen.txt" <<'EOF3'
awarped
use screen on me
examine dragon
no
quit
yes
EOF3
run_case warped-screen; F="$BUILD/warped-screen-transcript.txt"; grep -F 'cannot honestly be trusted as a fire barrier' "$F"; grep -F 'The first wash of fire turns the air white' "$F"
cat > "$BUILD/no-screen.txt" <<'EOF4'
anoscreen
examine dragon
listen to dragon
no
quit
yes
EOF4
run_case no-screen; F="$BUILD/no-screen-transcript.txt"; grep -F 'The first wash of fire turns the air white' "$F"; if grep -Fq 'braced screen' "$F"; then echo 'Unheld screen incorrectly protected player' >&2; exit 1; fi
python - "$STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); mp=Path(sys.argv[2]); m=json.loads(mp.read_text()); b=Path('glulx/build/ablative-protection-1263'); report=json.loads((b/'story-report.json').read_text()); identity={'file':story.name,'format':'Glulx','version_hex':report['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':report['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}; (b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(identity,indent=2,sort_keys=True)+'\n'); print('RELEASE_1263_ARTIFACT_IDENTITY='+json.dumps(identity,sort_keys=True))
e=m['expected_artifact']
if e.get('locked') is not True: raise SystemExit(4)
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if e.get(k)!=identity.get(k): raise SystemExit(f'Release 1263 artifact {k} mismatch: expected {e.get(k)}, got {identity.get(k)}')
receipt={'release':1263,'serial':m['serial'],'artifact_identity_locked':True,'production':{**identity,'report':report},'base_release':1262,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'sound_screen':'sound-screen-transcript.txt','scorched_screen':'scorched-screen-transcript.txt','warped_screen':'warped-screen-transcript.txt','no_screen':'no-screen-transcript.txt'}; (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(receipt,indent=2,sort_keys=True)+'\n'); print(json.dumps(receipt,indent=2,sort_keys=True))
PY
echo 'Release 1263 Ablative Protection & Equipment Consequence qualified.'
