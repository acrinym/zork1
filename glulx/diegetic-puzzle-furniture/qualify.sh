#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/living-biomes-wilderness-1273"
BUILD="$ROOT/glulx/build/diegetic-puzzle-furniture-1274"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/diegetic-puzzle-furniture/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/living-biomes-wilderness/qualify.sh
python -m py_compile glulx/diegetic-puzzle-furniture/stage.py
python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
    r=Path(root); files={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
    return hashlib.sha256(json.dumps(files,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1274_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True)); Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
if ids!=(m.get('base_source_sha256') or {}): raise SystemExit(f'Release 1274 predecessor source pins drift: expected {m.get("base_source_sha256")}, got {ids}')
PY_BASE
python glulx/diegetic-puzzle-furniture/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/diegetic-puzzle-furniture/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"
python - <<'PY_STATIC'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/diegetic-puzzle-furniture-1274'); s=b/'src'; p=Path('glulx/build/living-biomes-wilderness-1273/src'); m=json.loads(Path('glulx/diegetic-puzzle-furniture/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1274 and r['base']['release']==1273,'Release 1274 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1274 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1274 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1274 dev smell errors')
a=(s/'diegetic_puzzle_furniture.zil').read_text()
for token in ('DIEGETIC-INDEX-VOLUME','DIEGETIC-VAULT-TRAY','DIEGETIC-WEATHER-CLOCK','DIEGETIC-CISTERN-BRICK','DIEGETIC-CISTERN-SOUTH-EXIT'):
    req(token in a,'Release 1274 missing mechanism token: '+token)
for bad in ('SECRET_SWITCH','SECRET-SWITCH','FURNITURE-ENGINE','GENERIC-FURNITURE','PUZZLE-REGISTRY','AUTO-NOUN','USE-MATRIX'):
    req(bad not in a,'Release 1274 crossed generic mechanism boundary: '+bad)
for f in ('living_biomes_wilderness.zil','zork_plus_veteran_expedition.zil','consumable_light.zil','dragon_hoard.zil','learned_magic.zil'):
    req((s/f).read_bytes()==(p/f).read_bytes(),'Release 1274 unexpectedly rewrote predecessor authority: '+f)
ash=(s/'ashglass_observatory.zil').read_text()
req('(EAST PER DIEGETIC-SCRIPTORIUM-EAST-EXIT)' in ash,'Release 1274 Scriptorium route missing')
req('(SOUTH PER DIEGETIC-CISTERN-SOUTH-EXIT)' in ash,'Release 1274 cistern route missing')
req('<CONSTANT RELEASEID 1274>' in (s/'zork1.zil').read_text(),'Release 1274 identity missing')
PY_STATIC

read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY_M'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text()); print(m['serial'],m['expected_artifact']['file'])
PY_M
)
ZILF="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"
GLAZER="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
compile_story(){ local source="$1" asm="$2" out="$3" prefix="$4"; pushd "$source"; dotnet "$ZILF" build --glulx --stop-after-compile zork1.zil "$asm" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"; popd; python "$ROOT/glulx/tools/normalize_serial.py" "$asm" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"; "$GLAZER" "$asm" -o "$out" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"; }
STORY="$BUILD/$STORY_FILE"; compile_story "$SRC" "$BUILD/diegetic-puzzle-furniture.asm" "$STORY" production; python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
rm -rf "$TEST_SRC"; cp -a "$DEV_SRC" "$TEST_SRC"; cp glulx/diegetic-puzzle-furniture/tests/diegetic_puzzle_furniture_test.zil "$TEST_SRC/diegetic_puzzle_furniture_test.zil"
python - <<'PY_TEST'
from pathlib import Path
import sys; sys.path.insert(0,str(Path('glulx/tools').resolve())); from stage_release120 import apply_patch
apply_patch(Path('glulx/diegetic-puzzle-furniture/tests/001-include-diegetic-test.json').resolve(),Path('glulx/build/diegetic-puzzle-furniture-1274/test-src').resolve())
PY_TEST
TEST_STORY="$BUILD/diegetic-puzzle-furniture-test.ulx"; compile_story "$TEST_SRC" "$BUILD/diegetic-puzzle-furniture-test.asm" "$TEST_STORY" test
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
run_case(){ local n="$1"; timeout 120s "$GLULXE" --rngseed 123456 "$TEST_STORY" < "$BUILD/$n.txt" > "$BUILD/$n-transcript.txt" 2>&1; }

cat > "$BUILD/scriptorium-shelf.txt" <<'EOF1'
dfbook
examine book
take book
push book
pull book
east
look
quit
yes
EOF1
run_case scriptorium-shelf; F="$BUILD/scriptorium-shelf-transcript.txt"; grep -F 'suspiciously captive' "$F"; grep -F 'slides outward barely an inch' "$F"; grep -F 'other direction' "$F"; grep -F 'pivots east on a stone pin' "$F"; grep -F 'Broken Gallery' "$F"

cat > "$BUILD/vault-compartment.txt" <<'EOF2'
dfvault
examine tray
pull tray
push tray
take wheel
inventory
quit
yes
EOF2
run_case vault-compartment; F="$BUILD/vault-compartment-transcript.txt"; grep -F 'finger-width proud' "$F"; grep -F 'wrong direction for removal' "$F"; grep -F 'shallow compartment remains open' "$F"; grep -F 'small bronze star-wheel' "$F"

cat > "$BUILD/weather-clock.txt" <<'EOF3'
dfclock
examine clock
pull chain
move hand
pull chain
examine recess
quit
yes
EOF3
run_case weather-clock; F="$BUILD/weather-clock-transcript.txt"; grep -F 'unusually clean index notch' "$F"; grep -F 'alignment is wrong before the pull' "$F"; grep -F 'spring-loaded click' "$F"; grep -F 'exposing a shallow maintenance recess' "$F"; grep -F 'Whatever tool once lived here is gone' "$F"

cat > "$BUILD/cistern-original-wet.txt" <<'EOF4'
dfwet
south
examine candles
quit
yes
EOF4
run_case cistern-original-wet; F="$BUILD/cistern-original-wet-transcript.txt"; grep -F 'water visibly soaks the paired wicks' "$F"; grep -F 'dark and waterlogged' "$F"

cat > "$BUILD/cistern-diversion.txt" <<'EOF5'
dfdry
examine brick
push brick
examine rod
pull rod
south
examine candles
quit
yes
EOF5
run_case cistern-diversion; F="$BUILD/cistern-diversion-transcript.txt"; grep -F 'one corner will accept a fingertip' "$F"; grep -F 'The brick was a cover, not the control itself' "$F"; grep -F 'main spill now drops through a lower channel' "$F"; grep -F 'newly dry stone ledge south' "$F"; grep -F 'burning with two small ritual flames' "$F"

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/diegetic-puzzle-furniture-1274'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
if r.get('checksum_valid') is not True: raise SystemExit('Release 1274 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n'); print('RELEASE_1274_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
e=m['expected_artifact']; rec={'release':1274,'serial':m['serial'],'base_release':1273,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['scriptorium-shelf','vault-compartment','weather-clock','cistern-original-wet','cistern-diversion']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1274 candidate completed gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1274 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1274 Environmental Mechanisms & Diegetic Puzzle Furniture qualification passed.'
