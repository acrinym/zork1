#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/causal-failure-feedback-1270"
BUILD="$ROOT/glulx/build/creature-systemic-puzzles-1271"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/creature-systemic-puzzles/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

bash glulx/causal-failure-feedback/qualify.sh
python -m py_compile glulx/creature-systemic-puzzles/stage.py

python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
    r=Path(root)
    files={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
    return hashlib.sha256(json.dumps(files,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text())
ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1271_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True))
Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
if ids!=(m.get('base_source_sha256') or {}):
    raise SystemExit(f'Release 1271 predecessor source pins drift: expected {m.get("base_source_sha256")}, got {ids}')
PY_BASE

python glulx/creature-systemic-puzzles/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/creature-systemic-puzzles/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path
def req(cond,msg):
    if not cond: raise SystemExit(msg)
b=Path('glulx/build/creature-systemic-puzzles-1271')
s=b/'src'
p=Path('glulx/build/causal-failure-feedback-1270/src')
m=json.loads(Path('glulx/creature-systemic-puzzles/patch-series.json').read_text())
r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1271 and r['base']['release']==1270,'Release 1271 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1271 changed-path mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1271 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1271 dev smell errors')
for f in ('troll_passage_opportunity.zil','cyclops_appetite_route.zil','grue_fissure_recovery.zil'):
    req((s/f).is_file(),'missing Release 1271 module: '+f)
combined='\n'.join((s/f).read_text() for f in ('troll_passage_opportunity.zil','cyclops_appetite_route.zil','grue_fissure_recovery.zil'))
for forbidden in ('CREATURE_AI','DISPOSITION-METER','CREATURE-DISPOSITION','GENERIC-CREATURE','NPC-BRAIN'):
    req(forbidden not in combined,'Release 1271 crossed generic-creature boundary: '+forbidden)
req('GLULX-ALT-TROLL-DISTRACTED' in (s/'troll_passage_opportunity.zil').read_text(),'Troll route lost existing attention authority')
req('CYCLOWRATH' in (s/'cyclops_appetite_route.zil').read_text(),'Cyclops route lost canonical appetite authority')
req('CYCLOPS-FLAG' in (s/'cyclops_appetite_route.zil').read_text(),'Cyclops route lost canonical sleep authority')
req('GRUE-COLONY-STRONG-LIGHT?' in (s/'grue_fissure_recovery.zil').read_text(),'Grue recovery lost canonical light/colony authority')
for f in ('dragon_hoard.zil','structural_difficulty.zil','causal_failure_feedback.zil'):
    req((s/f).read_bytes()==(p/f).read_bytes(),'Release 1271 unexpectedly rewrote predecessor authority: '+f)
req((s/'1actions.zil').read_text().count('<CREATURE-GRUE-RECOVERY-REVEAL>')==1,'Release 1271 grue hook count mismatch')
req('<CONSTANT RELEASEID 1271>' in (s/'zork1.zil').read_text(),'Release 1271 identity missing')
PY_STATIC

read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY_MANIFEST'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text())
print(m['serial'],m['expected_artifact']['file'])
PY_MANIFEST
)
ZILF="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"
GLAZER="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
compile_story(){
  local source="$1" asm="$2" out="$3" prefix="$4"
  pushd "$source"
  dotnet "$ZILF" build --glulx --stop-after-compile zork1.zil "$asm" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"
  popd
  python "$ROOT/glulx/tools/normalize_serial.py" "$asm" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"
  "$GLAZER" "$asm" -o "$out" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"
}
STORY="$BUILD/$STORY_FILE"
compile_story "$SRC" "$BUILD/creature-systemic-puzzles.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"
cp -a "$DEV_SRC" "$TEST_SRC"
cp glulx/creature-systemic-puzzles/tests/creature_systemic_test.zil "$TEST_SRC/creature_systemic_test.zil"
python - <<'PY_TEST'
from pathlib import Path
import sys
sys.path.insert(0,str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(Path('glulx/creature-systemic-puzzles/tests/001-include-creature-systemic-test.json').resolve(),Path('glulx/build/creature-systemic-puzzles-1271/test-src').resolve())
PY_TEST
TEST_STORY="$BUILD/creature-systemic-test.ulx"
compile_story "$TEST_SRC" "$BUILD/creature-systemic-test.asm" "$TEST_STORY" test
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
  make -C "$ROOT/.tooling/cheapglk"
  make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
run_case(){ local n="$1"; timeout 120s "$GLULXE" --rngseed 123456 "$TEST_STORY" < "$BUILD/$n.txt" > "$BUILD/$n-transcript.txt" 2>&1; }

cat > "$BUILD/troll-slip.txt" <<'EOF1'
createtroll
trick troll
east
west
trick troll
quit
yes
EOF1
run_case troll-slip
F="$BUILD/troll-slip-transcript.txt"
grep -F 'one very brief opportunity' "$F"
grep -F 'You slip through the eastern passage' "$F"
grep -F 'He points just as urgently behind you and keeps watching.' "$F"

cat > "$BUILD/cyclops-drop-route.txt" <<'EOF2'
createcyclops
drop lunch
up
down
look
quit
yes
EOF2
run_case cyclops-drop-route
F="$BUILD/cyclops-drop-route-transcript.txt"
grep -F 'The stairs are physically clear for one brief opportunity.' "$F"
grep -F 'this did not put him to sleep' "$F"
grep -F 'having eaten the hot peppers, appears to be gasping' "$F"

cat > "$BUILD/grue-bright-recovery.txt" <<'EOF3'
creategrue
look
examine survey tube
take survey tube
inventory
quit
yes
EOF3
run_case grue-bright-recovery
F="$BUILD/grue-bright-recovery-transcript.txt"
grep -F 'dented brass survey tube' "$F"
grep -F 'bright light holds the separate movements deep in the fissures' "$F"
grep -F 'dented brass survey tube' "$F"

cat > "$BUILD/grue-weak-refusal.txt" <<'EOF4'
creategrueweak
take survey tube
inventory
quit
yes
EOF4
run_case grue-weak-refusal
F="$BUILD/grue-weak-refusal-transcript.txt"
grep -F 'does not drive it back far enough to own the reach' "$F"
grep -F 'dented brass survey tube' "$F"

cat > "$BUILD/thief-gift.txt" <<'EOF5'
createthief
give chalice to thief
quit
yes
EOF5
run_case thief-gift
F="$BUILD/thief-gift-transcript.txt"
grep -F 'stops to admire its beauty' "$F"
grep -F 'The personal account appears settled. His profession, of course, remains unchanged.' "$F"

cat > "$BUILD/dragon-distinct.txt" <<'EOF6'
createdragon
give chalice to dragon
east
quit
yes
EOF6
run_case dragon-distinct
F="$BUILD/dragon-distinct-transcript.txt"
grep -F 'A bargain has occurred' "$F"
grep -F 'Hoard Vault' "$F"

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1])
m=json.loads(Path(sys.argv[2]).read_text())
b=Path('glulx/build/creature-systemic-puzzles-1271')
r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
if r.get('checksum_valid') is not True: raise SystemExit('Release 1271 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
print('RELEASE_1271_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
e=m['expected_artifact']
rec={'release':1271,'serial':m['serial'],'base_release':1270,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['troll-slip','cyclops-drop-route','grue-bright-recovery','grue-weak-refusal','thief-gift','dragon-distinct']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident})
    (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
    raise SystemExit('Release 1271 candidate completed gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1271 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident})
(b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1271 Creature Encounters as Systemic Puzzles qualification passed.'
