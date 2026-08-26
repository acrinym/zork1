#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/structural-difficulty-1269"
BUILD="$ROOT/glulx/build/causal-failure-feedback-1270"
BASE_SRC="$BASE_BUILD/src"; BASE_DEV_SRC="$BASE_BUILD/dev-src"; SRC="$BUILD/src"; DEV_SRC="$BUILD/dev-src"; TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/causal-failure-feedback/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/structural-difficulty/qualify.sh
python -m py_compile glulx/causal-failure-feedback/stage.py
python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
 r=Path(root); f={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
 return hashlib.sha256(json.dumps(f,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1270_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True)); Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
if ids!=(m.get('base_source_sha256') or {}): raise SystemExit(f'Release 1270 predecessor source pins drift: expected {m.get("base_source_sha256")}, got {ids}')
PY_BASE

python glulx/causal-failure-feedback/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/causal-failure-feedback/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json,re
from pathlib import Path
def req(x,m):
 if not x: raise SystemExit(m)
b=Path('glulx/build/causal-failure-feedback-1270'); s=b/'src'; p=Path('glulx/build/structural-difficulty-1269/src'); m=json.loads(Path('glulx/causal-failure-feedback/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1270 and r['base']['release']==1269,'Release 1270 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1270 changed-path mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1270 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1270 dev smell errors')
c=(s/'causal_failure_feedback.zil').read_text(); d=(s/'dragon_hoard.zil').read_text(); a=(s/'1actions.zil').read_text(); dun=(s/'1dungeon.zil').read_text(); z=(s/'zork1.zil').read_text()
for t in ('CAUSAL-FAILURE-DRAGON-TRAP','CAUSAL-FAILURE-DRAGON-WATCH','CAUSAL-FAILURE-DRAGON-TOLL-BREACH','CAUSAL-FAILURE-DAM-CURRENT','CAUSAL-FAILURE-CANYON-LEAP'):
 req(t in c,'missing Release 1270 authored feedback routine: '+t)
req(re.search(r'(?m)^<GLOBAL\\b',c) is None,'Release 1270 added global failure state')
req('<TABLE' not in c,'Release 1270 added a generic failure-state table')
for t in ('DRAGON-ACCEPT-TOLL','DRAGON-LURE','DRAGON-PULL-CHAIN','DRAGON-SMOKE-COVER?','STRUCTURAL-DIFFICULTY-WATCH-LIMIT'):
 req(t in d,'Release 1270 dragon authority lost required token: '+t)
for t in ('<CAUSAL-FAILURE-DRAGON-TRAP>','<CAUSAL-FAILURE-DRAGON-WATCH>','<CAUSAL-FAILURE-DRAGON-TOLL-BREACH>'):
 req(t in d,'Release 1270 dragon feedback hook missing: '+t)
req('<CAUSAL-FAILURE-DAM-LADDER>' in a and '<CAUSAL-FAILURE-DAM-CURRENT>' in a,'Release 1270 dam hooks missing')
req('<LIVING-CANYON-INTERCEPT?>' in dun and '<CAUSAL-FAILURE-CANYON-LEAP>' in dun,'Release 1270 canyon authority/hook mismatch')
for n in ('structural_difficulty.zil','ablative_protection.zil','fire_structural.zil','clue_interpretation.zil','semantic_examination.zil','learned_magic.zil'):
 req((s/n).read_bytes()==(p/n).read_bytes(),'Release 1270 unexpectedly rewrote predecessor authority: '+n)
req('<CONSTANT RELEASEID 1270>' in z and '<INSERT-FILE "causal_failure_feedback" T>' in z,'Release 1270 identity/include missing')
PY_STATIC

read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY_MANIFEST'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text()); print(m['serial'],m['expected_artifact']['file'])
PY_MANIFEST
)
ZILF="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"
GLAZER="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
compile_story(){ local source="$1" asm="$2" out="$3" prefix="$4"; pushd "$source"; dotnet "$ZILF" build --glulx --stop-after-compile zork1.zil "$asm" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"; popd; python "$ROOT/glulx/tools/normalize_serial.py" "$asm" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"; "$GLAZER" "$asm" -o "$out" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"; }
STORY="$BUILD/$STORY_FILE"
compile_story "$SRC" "$BUILD/causal-failure-feedback.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"; cp -a "$DEV_SRC" "$TEST_SRC"
cp glulx/causal-failure-feedback/tests/causal_failure_feedback_test.zil "$TEST_SRC/causal_failure_feedback_test.zil"
python - <<'PY_TEST'
from pathlib import Path
import sys
sys.path.insert(0,str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(Path('glulx/causal-failure-feedback/tests/001-include-causal-failure-test.json').resolve(),Path('glulx/build/causal-failure-feedback-1270/test-src').resolve())
PY_TEST
TEST_STORY="$BUILD/causal-failure-feedback-test.ulx"
compile_story "$TEST_SRC" "$BUILD/causal-failure-feedback-test.asm" "$TEST_STORY" test
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
run_case(){ local n="$1"; timeout 120s "$GLULXE" --rngseed 123456 "$TEST_STORY" < "$BUILD/$n.txt" > "$BUILD/$n-transcript.txt" 2>&1; }

cat > "$BUILD/dragon-trap-timing.txt" <<'EOF1'
cffdragon
pull chain
quit
yes
EOF1
run_case dragon-trap-timing; F="$BUILD/dragon-trap-timing-transcript.txt"
grep -F 'The chain was a sound mechanism used at the wrong moment.' "$F"
grep -F "The missing state was the dragon's position beneath the grille." "$F"

cat > "$BUILD/dragon-ignored-warning.txt" <<'EOF2'
cffdragon
examine dragon
listen to dragon
quit
yes
EOF2
run_case dragon-ignored-warning; F="$BUILD/dragon-ignored-warning-transcript.txt"
grep -F 'spent one opportunity in a room containing a live territorial animal' "$F"
grep -F 'taking one more unprotected action after the warning changed observation into immolation' "$F"

cat > "$BUILD/dragon-bargain-breach.txt" <<'EOF3'
cffdragon
give chalice to dragon
east
take ashen circlet
take star glass
quit
yes
EOF3
run_case dragon-bargain-breach; F="$BUILD/dragon-bargain-breach-transcript.txt"
grep -F 'A bargain has occurred' "$F"
grep -F 'taking the first piece was sound, while reaching for a second changed paid passage into theft' "$F"

cat > "$BUILD/dam-current.txt" <<'EOF4'
cffdam
swim
quit
yes
EOF4
run_case dam-current; F="$BUILD/dam-current-transcript.txt"
grep -F 'open sluice gates' "$F"
grep -F 'The current, not the cold or a hidden swimming check, killed you.' "$F"
grep -F 'the missing state was any prepared restraint capable of stopping that current' "$F"

cat > "$BUILD/canyon-unarrested.txt" <<'EOF5'
cffcanyon
examine edge
leap
quit
yes
EOF5
run_case canyon-unarrested; F="$BUILD/canyon-unarrested-transcript.txt"
grep -F 'The drop is sheer, and an unprotected leap would not leave room for correction.' "$F"
grep -F 'Gravity did exactly what the canyon rim said it would.' "$F"
grep -F 'LEAP was honored rather than parser-blocked' "$F"

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/causal-failure-feedback-1270'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
if r.get('checksum_valid') is not True: raise SystemExit('Release 1270 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n'); print('RELEASE_1270_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
e=m['expected_artifact']; rec={'release':1270,'serial':m['serial'],'base_release':1269,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['dragon-trap-timing','dragon-ignored-warning','dragon-bargain-breach','dam-current','canyon-unarrested']}
if e.get('locked') is not True:
 rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1270 candidate completed gameplay qualification; lock the exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
 if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1270 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo "Release 1270 Causal Death & Failure Feedback qualification passed."
