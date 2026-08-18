#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/clue-chains-1268"
BUILD="$ROOT/glulx/build/structural-difficulty-1269"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/structural-difficulty/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/clue-chains/qualify.sh
python -m py_compile glulx/structural-difficulty/stage.py
python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
 r=Path(root); f={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
 return hashlib.sha256(json.dumps(f,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1269_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True)); Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
if ids!=(m.get('base_source_sha256') or {}): raise SystemExit(f'Release 1269 predecessor source pins drift: expected {m.get("base_source_sha256")}, got {ids}')
PY_BASE

python glulx/structural-difficulty/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/structural-difficulty/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json,re
from pathlib import Path
def req(x,m):
 if not x: raise SystemExit(m)
b=Path('glulx/build/structural-difficulty-1269'); s=b/'src'; p=Path('glulx/build/clue-chains-1268/src'); m=json.loads(Path('glulx/structural-difficulty/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1269 and r['base']['release']==1268,'Release 1269 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1269 changed-path mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1269 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1269 dev smell errors')
c=(s/'structural_difficulty.zil').read_text(); d=(s/'dragon_hoard.zil').read_text(); a=(s/'ablative_protection.zil').read_text(); z=(s/'zork1.zil').read_text()
for t in ('<SYNTAX DIFFICULTY = V-STRUCTURAL-DIFFICULTY>','SD-FORGIVING','SD-CLASSIC','SD-EXACTING','STRUCTURAL-DIFFICULTY-WATCH-LIMIT','STRUCTURAL-DIFFICULTY-FORGIVING-RETREAT?','STRUCTURAL-DIFFICULTY-DRAGON-APPROACH-F'):
 req(t in c,'missing Release 1269 structural token: '+t)
req(re.search(r'(?m)^<GLOBAL\b',c) is None,'Release 1269 consumed legacy VM globals')
for n in ('clue_interpretation.zil','semantic_examination.zil','learned_magic.zil','fire_structural.zil','perilous_affordances.zil','consumable_light.zil','gsyntax.zil','gverbs.zil'):
 req((s/n).read_bytes()==(p/n).read_bytes(),'Release 1269 unexpectedly rewrote predecessor authority: '+n)
for t in ('DRAGON-ACCEPT-TOLL','DRAGON-LURE','DRAGON-PULL-CHAIN','DRAGON-SMOKE-COVER?','<STRUCTURAL-DIFFICULTY-WATCH-LIMIT>','<STRUCTURAL-DIFFICULTY-FORGIVING-RETREAT?>'):
 req(t in d,'Release 1269 dragon authority lost required token: '+t)
req('<ROUTINE ABLATIVE-APPLY-STRUCTURAL-DIFFICULTY ()' in a,'Release 1269 ablative initializer missing')
req('<STRUCTURAL-DIFFICULTY-EXACTING?>' in a and ',AP-SCORCHED' in a,'Exacting does not use canonical screen condition authority')
req('<CONSTANT RELEASEID 1269>' in z and '<INSERT-FILE "structural_difficulty" T>' in z,'Release 1269 identity/include missing')
PY_STATIC

read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY_MANIFEST'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text()); print(m['serial'],m['expected_artifact']['file'])
PY_MANIFEST
)
[[ -n "$SERIAL" && -n "$STORY_FILE" ]]
ZILF="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"
GLAZER="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
compile_story(){ local source="$1" asm="$2" out="$3" prefix="$4"; pushd "$source"; dotnet "$ZILF" build --glulx --stop-after-compile zork1.zil "$asm" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"; popd; python "$ROOT/glulx/tools/normalize_serial.py" "$asm" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"; "$GLAZER" "$asm" -o "$out" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"; }
STORY="$BUILD/$STORY_FILE"
compile_story "$SRC" "$BUILD/structural-difficulty.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"; cp -a "$DEV_SRC" "$TEST_SRC"
cp glulx/structural-difficulty/tests/structural_difficulty_test.zil "$TEST_SRC/structural_difficulty_test.zil"
python - <<'PY_TEST'
from pathlib import Path
import sys
sys.path.insert(0,str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(Path('glulx/structural-difficulty/tests/001-include-structural-difficulty-test.json').resolve(),Path('glulx/build/structural-difficulty-1269/test-src').resolve())
PY_TEST
TEST_STORY="$BUILD/structural-difficulty-test.ulx"
compile_story "$TEST_SRC" "$BUILD/structural-difficulty-test.asm" "$TEST_STORY" test
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
run_case(){ local n="$1"; timeout 120s "$GLULXE" --rngseed 123456 "$TEST_STORY" < "$BUILD/$n.txt" > "$BUILD/$n-transcript.txt" 2>&1; }

cat > "$BUILD/mode-lock.txt" <<'EOF1'
sdreset
difficulty
difficulty forgiving
difficulty
sdapproach
look
difficulty exacting
sdstat
quit
yes
EOF1
run_case mode-lock; F="$BUILD/mode-lock-transcript.txt"
grep -F 'Structural difficulty is Classic.' "$F"
grep -F 'Structural difficulty set to Forgiving.' "$F"
grep -F 'retreat around that bend can break a line of fire' "$F"
grep -F 'Changing difficulty now would rewrite evidence and equipment history behind your back' "$F"
grep -F 'mode=1 locked=1 recovery-used=0 dragon-initialized=1' "$F"

cat > "$BUILD/forgiving-window-retreat.txt" <<'EOF2'
sdreset
difficulty forgiving
sdgallery
examine dragon
examine chain
listen to dragon
sdstat
quit
yes
EOF2
run_case forgiving-window-retreat; F="$BUILD/forgiving-window-retreat-transcript.txt"
grep -F 'spent one opportunity in a room containing a live territorial animal' "$F"
grep -F 'another delay will put you in the line of fire' "$F"
grep -F 'You survive in the Scorched Cleft. That recoverable hesitation is spent.' "$F"
grep -F 'mode=1 locked=1 recovery-used=1 dragon-initialized=1 watch=0' "$F"
grep -F 'here-approach=1' "$F"

cat > "$BUILD/classic-parity.txt" <<'EOF3'
sdreset
difficulty classic
sdgallery
examine dragon
listen to dragon
no
quit
yes
EOF3
run_case classic-parity; F="$BUILD/classic-parity-transcript.txt"
grep -F 'Structural difficulty set to Classic.' "$F"
grep -F 'spent one opportunity in a room containing a live territorial animal' "$F"
grep -F 'The first wash of fire turns the air white' "$F"
if grep -Fq 'recoverable hesitation is spent' "$F"; then echo 'Classic incorrectly gained Forgiving recovery' >&2; exit 1; fi

cat > "$BUILD/exacting-screen.txt" <<'EOF4'
sdreset
difficulty exacting
sdapproach
examine screen
take screen
use screen on me
sdgallery
examine dragon
listen to dragon
sdstat
quit
yes
EOF4
run_case exacting-screen; F="$BUILD/exacting-screen-transcript.txt"
grep -F 'Structural difficulty set to Exacting.' "$F"
grep -F "screen's hide is blackened, blistered, and shrunken" "$F"
grep -F 'A second blast catches the already-shrunken hide' "$F"
grep -F 'mode=3 locked=1 recovery-used=0 dragon-initialized=1 watch=0 screen-condition=2' "$F"

cat > "$BUILD/exacting-toll-route.txt" <<'EOF5'
sdreset
difficulty exacting
sdgallery
give chalice to dragon
east
take ashen circlet
west
sdstat
quit
yes
EOF5
run_case exacting-toll-route; F="$BUILD/exacting-toll-route-transcript.txt"
grep -F 'A bargain has occurred' "$F"
grep -F 'passage, and one thing from the hoard' "$F"
grep -F 'toll=1' "$F"

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/structural-difficulty-1269'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n'); print('RELEASE_1269_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
e=m['expected_artifact']; rec={'release':1269,'serial':m['serial'],'base_release':1268,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['mode-lock','forgiving-window-retreat','classic-parity','exacting-screen','exacting-toll-route']}
if e.get('locked') is not True:
 rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1269 candidate completed gameplay qualification; lock the exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
 if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1269 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo "Release 1269 Structural Difficulty qualification passed."
