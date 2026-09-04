#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/he-absurd-1305"
BUILD="$ROOT/glulx/build/mara-earned-romance-1306"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/mara-earned-romance/patch-series.json"
cd "$ROOT"
bash glulx/he-absurd-1305/qualify.sh
rm -rf "$BUILD"
mkdir -p "$BUILD"
python -m py_compile glulx/mara-earned-romance/stage.py
python glulx/mara-earned-romance/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/mara-earned-romance/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"
python - <<'PY'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/mara-earned-romance-1306'); s=b/'src'; m=json.loads(Path('glulx/mara-earned-romance/patch-series.json').read_text())
r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1306 and r['base']['release']==1305,'Release 1306 staging mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1306 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'1306 smell errors')
z=(s/'zork1.zil').read_text()
req('<CONSTANT RELEASEID 1306>' in z,'1306 identity missing')
req('<INSERT-FILE "mara_earned_romance" T>' in (s/'mara_companion.zil').read_text(),'romance include missing')
req('MARA-PARTNERSHIP-DANGER-HOOK' in (s/'mara_companion_movement.zil').read_text(),'romance cellar hook missing')
rom=(s/'mara_earned_romance.zil').read_text()
req('MARA-SLOT-TRUST' not in rom,'romance must not consult TRUST')
req('MARA-SLOT-RESPECT' not in rom,'romance must not consult RESPECT')
prod='\n'.join(p.read_text(errors='ignore') for p in s.glob('*.zil'))
for bad in ('SURVEYKILL','SURVEYREWIND','ALTSAFE','ALTTROLL'):
    req(bad not in prod,'production leak '+bad)
PY
read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text()); print(m['serial'], m['expected_artifact']['file'])
PY
)
ZILF="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"
GLAZER="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
compile_story(){ local source="$1" asm="$2" out="$3" prefix="$4"; pushd "$source"; dotnet "$ZILF" build --glulx --stop-after-compile zork1.zil "$asm" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"; popd; python "$ROOT/glulx/tools/normalize_serial.py" "$asm" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"; "$GLAZER" "$asm" -o "$out" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"; }
STORY="$BUILD/$STORY_FILE"
compile_story "$SRC" "$BUILD/release1306.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/mara-earned-romance/tests/mara_earned_romance_test.zil "$TEST_SRC/mara_earned_romance_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(Path('glulx/mara-earned-romance/tests/001-include-romance-test.json').resolve(), Path('glulx/build/mara-earned-romance-1306/test-src').resolve())
PY
compile_story "$TEST_SRC" "$BUILD/release1306-test.asm" "$BUILD/release1306-test.ulx" test
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
printf 'look\nquit\nyes\n' > "$BUILD/production-smoke.txt"
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/production-smoke.txt" > "$BUILD/production-smoke-transcript.txt" 2>&1
grep -F 'West of House' "$BUILD/production-smoke-transcript.txt"
grep -F 'Release 1306' "$BUILD/production-smoke-transcript.txt"
cat > "$BUILD/romance-test.txt" <<'EOF'
romhalf
ask mara to stay
romsafe
examine mara
examine mara
examine mara
ask mara about partnership
kiss mara
ask mara to stay
ask mara about partnership
romrupture
kiss mara
ask mara to stay
romfriend
ask mara about friendship
refuse mara
quit
yes
EOF
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$BUILD/release1306-test.ulx" < "$BUILD/romance-test.txt" > "$BUILD/romance-test-transcript.txt" 2>&1
R="$BUILD/romance-test-transcript.txt"
dump(){ echo '--- romance test ---' >&2; cat "$R" >&2; }
grep -F 'specific person' "$R" || { dump; exit 1; }
grep -F 'Not tonight' "$R" || { dump; exit 1; }
grep -F 'Yes, Mara says' "$R" || { dump; exit 1; }
grep -F 'rewrite an attack as affection' "$R" || { dump; exit 1; }
grep -F 'colleague when the work is real' "$R" || grep -F 'Friendship' "$R" || { dump; exit 1; }
grep -F 'I will still survey' "$R" || { dump; exit 1; }
python - "$STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/mara-earned-romance-1306'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1306_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']; rec={'release':1306,'serial':m['serial'],'base_release':1305,'histories':['production-smoke','romance-test']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1306 candidate completed product gameplay; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1306 artifact drift for {k}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY
echo 'Release 1306 Mara Earned Romance qualification passed.'
