#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-earned-romance-1306"
BUILD="$ROOT/glulx/build/flathead-fair-1310"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/flathead-fair/patch-series.json"
cd "$ROOT"
bash glulx/mara-earned-romance/qualify.sh
rm -rf "$BUILD"
mkdir -p "$BUILD"
python -m py_compile glulx/flathead-fair/stage.py
python glulx/flathead-fair/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/flathead-fair/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"
python - <<'PY'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/flathead-fair-1310'); s=b/'src'; m=json.loads(Path('glulx/flathead-fair/patch-series.json').read_text())
r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1310 and r['base']['release']==1306,'Release 1310 staging mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1310 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'1310 smell errors')
z=(s/'zork1.zil').read_text()
req('<CONSTANT RELEASEID 1310>' in z,'1310 identity missing')
mc=(s/'mara_companion.zil').read_text()
req('<INSERT-FILE "flathead_fair_syntax" T>' in mc,'fair syntax include missing')
req('<INSERT-FILE "flathead_fair" T>' in mc,'fair include missing')
d=(s/'1dungeon.zil').read_text()
req('(NE TO FAIR-ROAD)' in d,'CLEARING NE spur missing')
req('(EAST TO CANYON-VIEW)' in d,'CLEARING east must remain')
req('(WEST TO EAST-OF-HOUSE)' in d,'CLEARING west must remain')
prod='\n'.join(p.read_text(errors='ignore') for p in s.glob('*.zil'))
for bad in ('SURVEYKILL','SURVEYREWIND','ALTSAFE','ALTTROLL','FAIRHERE','FAIRBANK','FAIRDUSK','FAIRWIND','FAIRWATCH','FAIRFISH'):
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
compile_story "$SRC" "$BUILD/release1310.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/flathead-fair/tests/flathead_fair_test.zil "$TEST_SRC/flathead_fair_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(Path('glulx/flathead-fair/tests/001-include-fair-test.json').resolve(), Path('glulx/build/flathead-fair-1310/test-src').resolve())
PY
compile_story "$TEST_SRC" "$BUILD/release1310-test.asm" "$BUILD/release1310-test.ulx" test
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
cat > "$BUILD/production-smoke.txt" <<'EOF'
look
s
e
e
look
ne
look
n
look
s
s
e
quit
yes
EOF
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/production-smoke.txt" > "$BUILD/production-smoke-transcript.txt" 2>&1
grep -F 'West of House' "$BUILD/production-smoke-transcript.txt"
grep -F 'Release 1310' "$BUILD/production-smoke-transcript.txt"
grep -F 'northeast' "$BUILD/production-smoke-transcript.txt"
grep -F 'Fair Road' "$BUILD/production-smoke-transcript.txt"
grep -F 'Fair Entrance' "$BUILD/production-smoke-transcript.txt"
cat > "$BUILD/fair-test.txt" <<'EOF'
fairhere
fairbank
look
nw
ask mabel about food
buy elephant ear
ask tomas about drink
buy large drink
smell drink
se
ne
play ring stand
examine bottles
play bottles
fairwatch
play gallery
examine shell booth
examine wax
play shell booth
n
look
hello nell
hello ada
s
ne
ride carousel
n
in
n
e
n
examine mirror
e
s
s
w
w
n
ask silas about fishing
buy rental rod
fairfish
weigh
fairdusk
s
ne
ask tomas about cider
dance
fairwind
n
ride wheel
quit
yes
EOF
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$BUILD/release1310-test.ulx" < "$BUILD/fair-test.txt" > "$BUILD/fair-test-transcript.txt" 2>&1
R="$BUILD/fair-test-transcript.txt"
dump(){ echo '--- fair test ---' >&2; cat "$R" >&2; }
grep -F 'Fair Entrance' "$R" || { dump; exit 1; }
grep -F 'cinnamon-sugar' "$R" || { dump; exit 1; }
grep -F 'Pear and lime' "$R" || { dump; exit 1; }
grep -F 'Two tickets' "$R" || { dump; exit 1; }
grep -F 'Clean knockdown' "$R" || { dump; exit 1; }
grep -F 'Eight tickets' "$R" || { dump; exit 1; }
grep -F 'tack-wax' "$R" || { dump; exit 1; }
grep -F 'House of Records' "$R" || { dump; exit 1; }
grep -F 'beat late' "$R" || { dump; exit 1; }
grep -F 'redfin bream' "$R" || { dump; exit 1; }
grep -F 'Lantern Table' "$R" || grep -F 'hot spiced cider' "$R" || { dump; exit 1; }
grep -F 'refunds the unused fare' "$R" || grep -F 'No sale' "$R" || grep -F 'past his limit' "$R" || { dump; exit 1; }
python - "$STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/flathead-fair-1310'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1310_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']; rec={'release':1310,'serial':m['serial'],'base_release':1306,'histories':['production-smoke','fair-test']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1310 candidate completed product gameplay; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1310 artifact drift for {k}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY
echo 'Release 1310 Flathead Fair qualification passed.'
