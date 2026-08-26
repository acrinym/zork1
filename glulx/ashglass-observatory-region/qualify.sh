#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/creature-systemic-puzzles-1271"
BUILD="$ROOT/glulx/build/ashglass-observatory-1272"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/ashglass-observatory-region/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/creature-systemic-puzzles/qualify.sh
python -m py_compile glulx/ashglass-observatory-region/stage.py
python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
    r=Path(root); files={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
    return hashlib.sha256(json.dumps(files,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1272_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True)); Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
if ids!=(m.get('base_source_sha256') or {}): raise SystemExit(f'Release 1272 predecessor source pins drift: expected {m.get("base_source_sha256")}, got {ids}')
PY_BASE
python glulx/ashglass-observatory-region/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/ashglass-observatory-region/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"
python - <<'PY_STATIC'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/ashglass-observatory-1272'); s=b/'src'; p=Path('glulx/build/creature-systemic-puzzles-1271/src'); m=json.loads(Path('glulx/ashglass-observatory-region/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1272 and r['base']['release']==1271,'Release 1272 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1272 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1272 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1272 dev smell errors')
a=(s/'ashglass_observatory.zil').read_text(); req(a.count('<ROOM ASHGLASS-')==24,'Release 1272 must ship exactly 24 authored Ashglass rooms in this train')
for token in ('ASHGLASS-FOREST-ENTRY','ASHGLASS-CANYON-ENTRY','V-ASHGLASS-FOCUS','CONSUMABLE-CURRENT-LIGHT-LEVEL','CL-CANDLE-WET','CK-AIR-PASSAGE-MOTIF','I-ASHGLASS-ROOK-RETURN','<WEIGHT ,WINNER>','JIGS-UP'):
    req(token in a,'Release 1272 missing composition token: '+token)
for bad in ('REGION-ENGINE','GENERIC-CREATURE','BIOME-GENERATOR','PUZZLE-REGISTRY','SECRET-DOOR-FRAMEWORK','OBJECT-PAIR-MATRIX'):
    req(bad not in a,'Release 1272 crossed generic framework boundary: '+bad)
for f in ('troll_passage_opportunity.zil','cyclops_appetite_route.zil','grue_fissure_recovery.zil','dragon_hoard.zil','structural_difficulty.zil','learned_magic.zil','clue_interpretation.zil'):
    req((s/f).read_bytes()==(p/f).read_bytes(),'Release 1272 unexpectedly rewrote predecessor authority: '+f)
req('(SOUTH PER ASHGLASS-FOREST-ENTRY)' in (s/'1dungeon.zil').read_text(),'Forest Ashglass entry missing')
req('(SOUTH PER ASHGLASS-CANYON-ENTRY)' in (s/'1dungeon.zil').read_text(),'Canyon Ashglass entry missing')
req('<CONSTANT RELEASEID 1272>' in (s/'zork1.zil').read_text(),'Release 1272 identity missing')
PY_STATIC

read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY_M'
import json,sys; from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text()); print(m['serial'],m['expected_artifact']['file'])
PY_M
)
ZILF="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"
GLAZER="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
compile_story(){ local source="$1" asm="$2" out="$3" prefix="$4"; pushd "$source"; dotnet "$ZILF" build --glulx --stop-after-compile zork1.zil "$asm" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"; popd; python "$ROOT/glulx/tools/normalize_serial.py" "$asm" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"; "$GLAZER" "$asm" -o "$out" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"; }
STORY="$BUILD/$STORY_FILE"; compile_story "$SRC" "$BUILD/ashglass-observatory.asm" "$STORY" production; python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
rm -rf "$TEST_SRC"; cp -a "$DEV_SRC" "$TEST_SRC"; cp glulx/ashglass-observatory-region/tests/ashglass_test.zil "$TEST_SRC/ashglass_test.zil"
python - <<'PY_TEST'
from pathlib import Path
import sys; sys.path.insert(0,str(Path('glulx/tools').resolve())); from stage_release120 import apply_patch
apply_patch(Path('glulx/ashglass-observatory-region/tests/001-include-ashglass-test.json').resolve(),Path('glulx/build/ashglass-observatory-1272/test-src').resolve())
PY_TEST
TEST_STORY="$BUILD/ashglass-test.ulx"; compile_story "$TEST_SRC" "$BUILD/ashglass-test.asm" "$TEST_STORY" test
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
run_case(){ local n="$1"; timeout 120s "$GLULXE" --rngseed 123456 "$TEST_STORY" < "$BUILD/$n.txt" > "$BUILD/$n-transcript.txt" 2>&1; }

cat > "$BUILD/forest-entry.txt" <<'CASE1'
ashforest
examine stormfall
cut stormfall with axe
south
look
quit
yes
CASE1
run_case forest-entry; F="$BUILD/forest-entry-transcript.txt"; grep -F 'leaving a narrow but honest passage south through the windthrow' "$F"; grep -F 'Windthrow Margin' "$F"

cat > "$BUILD/canyon-entry.txt" <<'CASE2'
ashcanyon
examine milestone
push milestone
south
look
quit
yes
CASE2
run_case canyon-entry; F="$BUILD/canyon-entry-transcript.txt"; grep -F 'exposing two old footholds and a narrow shelf descending south' "$F"; grep -F 'Rain Shelf' "$F"

cat > "$BUILD/focus-route.txt" <<'CASE3'
ashfocus
read slate
north
north
focus ring
east
south
look
quit
yes
CASE3
run_case focus-route; F="$BUILD/focus-route-transcript.txt"; grep -F 'FOCUS the ring only after the three-star notch is visible' "$F"; grep -F 'door-seam that had been invisible in flat light' "$F"; grep -F 'Archive Crossing' "$F"

cat > "$BUILD/vent-bypass.txt" <<'CASE4'
ashvent
examine marking
interpret marking
examine seam
open seam
west
look
quit
yes
CASE4
run_case vent-bypass; F="$BUILD/vent-bypass-transcript.txt"; grep -F 'same air-passage motif' "$F"; grep -F 'maintenance crawl opens beyond' "$F"; grep -F 'Vent Chamber' "$F"

cat > "$BUILD/wet-candles.txt" <<'CASE5'
ashcandles
south
examine candles
ward candles
examine candles
quit
yes
CASE5
run_case wet-candles; F="$BUILD/wet-candles-transcript.txt"; grep -F 'water visibly soaks the paired wicks' "$F"; grep -F 'leaving the wicks dry enough to accept flame again' "$F"

cat > "$BUILD/rook-window.txt" <<'CASE6'
ashrook
drop tube
east
look
quit
yes
CASE6
run_case rook-window; F="$BUILD/rook-window-transcript.txt"; grep -F 'The rook' "$F"; grep -F 'borrowed time rather than victory' "$F"; grep -F 'Counterweight Room' "$F"

cat > "$BUILD/bright-shaft.txt" <<'CASE7'
ashshaft
down
look
quit
yes
CASE7
run_case bright-shaft; F="$BUILD/bright-shaft-transcript.txt"; grep -F 'Star Chamber' "$F"

cat > "$BUILD/brake-safe.txt" <<'CASE8'
ashbrake
examine lever
push lever
pull chain
down
look
quit
yes
CASE8
run_case brake-safe; F="$BUILD/brake-safe-transcript.txt"; grep -F 'counterweight ratchet' "$F"; grep -F 'vault lift is open' "$F"; grep -F 'Vault Antechamber' "$F"

cat > "$BUILD/glass-load.txt" <<'CASE9'
ashheavy
east
drop coffin
east
look
quit
yes
CASE9
run_case glass-load; F="$BUILD/glass-load-transcript.txt"; grep -F 'too much mass on old glass' "$F"; grep -F 'Vault Antechamber' "$F"

cat > "$BUILD/counterweight-death.txt" <<'CASE10'
ashdeath
examine chain
pull chain
no
quit
yes
CASE10
run_case counterweight-death; F="$BUILD/counterweight-death-transcript.txt"; grep -F 'The polished middle brake notch was the missing physical state' "$F"

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/ashglass-observatory-1272'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
if r.get('checksum_valid') is not True: raise SystemExit('Release 1272 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n'); print('RELEASE_1272_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
e=m['expected_artifact']; rec={'release':1272,'serial':m['serial'],'base_release':1271,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['forest-entry','canyon-entry','focus-route','vent-bypass','wet-candles','rook-window','bright-shaft','brake-safe','glass-load','counterweight-death']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1272 candidate completed gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1272 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1272 Ashglass Observatory qualification passed.'
