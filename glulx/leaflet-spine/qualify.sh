#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/living-collection-1304"
BUILD="$ROOT/glulx/build/leaflet-spine-1296"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/leaflet-spine/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/living-collection/qualify.sh
python -m py_compile glulx/leaflet-spine/stage.py

python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
    r=Path(root)
    files={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
    return hashlib.sha256(json.dumps(files,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1296_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True))
Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
expected=m.get('base_source_sha256') or {}
if any(not isinstance(expected.get(k),str) or not expected.get(k) for k in ('production','dev')):
    raise SystemExit('Release 1296 predecessor source identities are candidate-only; lock the printed exact identities and rerun.')
if ids!=expected:
    raise SystemExit(f'Release 1296 predecessor source pins drift: expected {expected}, got {ids}')
PY_BASE

python glulx/leaflet-spine/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/leaflet-spine/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/leaflet-spine-1296'); s=b/'src'; p=Path('glulx/build/living-collection-1304/src'); m=json.loads(Path('glulx/leaflet-spine/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1296 and r['base']['release']==1304,'Release 1296 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1296 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1296 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1296 dev smell errors')
spine=(s/'leaflet_spine.zil').read_text()
zork=(s/'zork1.zil').read_text()
act=(s/'1actions.zil').read_text()
req('<OBJECT KITCHEN-CRUMBS' in spine,'Release 1296 missing kitchen crumbs')
req('<OBJECT TROLL-HOLE' in spine,'Release 1296 missing troll doorway')
req('<OBJECT DAM-WALKWAY' in spine,'Release 1296 missing dam walkway')
req('cabinet, not a score panel' in act,'Release 1296 trophy case lost cabinet refusal')
req('walkable lie' in act,'Release 1296 rainbow lost uniqueness reply')
req('<CONSTANT RELEASEID 1296>' in zork,'Release 1296 identity missing')
req('<INSERT-FILE "leaflet_spine" T>' in zork,'Release 1296 leaflet_spine not loaded')
req(zork.index('<INSERT-FILE "living_collection" T>') < zork.index('<INSERT-FILE "leaflet_spine" T>'),'Release 1296 leaflet_spine must follow living_collection')
prod='\n'.join(path.read_text(errors='ignore') for path in s.glob('*.zil'))
for bad in ('LSPDAM','LSPCYCLOPS','LSPRAINBOW','LSPHADES','LSPTIMBER','LSPTHIEF','SCENERY-REGISTRY','GENERIC-NOUN-TABLE','WORLD-SCANNER'):
    req(bad not in prod,'Release 1296 production contains test-only or forbidden token: '+bad)
for f in ('living_collection.zil','mara_companion_actor.zil','reactive_surface.zil'):
    req((s/f).read_bytes()==(p/f).read_bytes(),'Release 1296 unexpectedly rewrote predecessor authority: '+f)
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
STORY="$BUILD/$STORY_FILE"
compile_story "$SRC" "$BUILD/release1296.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
compile_story "$DEV_SRC" "$BUILD/release1296-dev.asm" "$BUILD/release1296-dev.ulx" dev

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/leaflet-spine/tests/leaflet_spine_test.zil "$TEST_SRC/leaflet_spine_test.zil"
python - <<'PY_TEST'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/leaflet-spine/tests/001-include-leaflet-spine-test.json').resolve(),
    Path('glulx/build/leaflet-spine-1296/test-src').resolve(),
)
PY_TEST
compile_story "$TEST_SRC" "$BUILD/release1296-test.asm" "$BUILD/release1296-test.ulx" test

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

printf 'look\nquit\nyes\n' > "$BUILD/production-smoke.txt"
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/production-smoke.txt" > "$BUILD/production-smoke-transcript.txt" 2>&1
grep -F 'West of House' "$BUILD/production-smoke-transcript.txt"
grep -F 'Release 1296' "$BUILD/production-smoke-transcript.txt"

cat > "$BUILD/house-ring.txt" <<'EOF_HOUSE'
north
examine boards
examine windows
south
south
east
open window
west
examine table
examine crumbs
examine chimney
west
take lamp
turn on lamp
examine case
look in case
take case
move rug
open trap
down
examine ramp
north
examine troll
examine hole
examine bloodstains
quit
yes
EOF_HOUSE
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$BUILD/house-ring.txt" > "$BUILD/house-ring-transcript.txt" 2>&1
H="$BUILD/house-ring-transcript.txt"
dump_h() { echo '--- house-ring transcript ---' >&2; cat "$H" >&2; }
grep -F 'The boards are securely fastened.' "$H" || { dump_h; exit 1; }
grep -F 'crumbs of interrupted cooking' "$H" || grep -F 'Someone was cooking here' "$H" || { dump_h; exit 1; }
grep -F 'chimney leads' "$H" || grep -F 'looks climbable' "$H" || { dump_h; exit 1; }
grep -F 'cabinet, not a score panel' "$H" || { dump_h; exit 1; }
grep -F 'trap door crashes shut' "$H" || { dump_h; exit 1; }
grep -F 'forbidding west hole' "$H" || grep -F 'real hole in a wall' "$H" || { dump_h; exit 1; }
if grep -F "You can't see any crumbs here!" "$H"; then echo 'Release 1296 kitchen still cannot see crumbs' >&2; dump_h; exit 1; fi
if grep -F "You can't see any hole here!" "$H"; then echo 'Release 1296 troll room still cannot see the hole' >&2; dump_h; exit 1; fi

cat > "$BUILD/leaflet-setpieces.txt" <<'EOF_SET'
lspdam
examine walkway
examine panel
examine dam
lspcyclops
examine cyclops
lsprainbow
examine rainbow
lsphades
examine gate
lsptimber
examine timbers
lspthief
examine bag
quit
yes
EOF_SET
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$BUILD/release1296-test.ulx" < "$BUILD/leaflet-setpieces.txt" > "$BUILD/leaflet-setpieces-transcript.txt" 2>&1
F="$BUILD/leaflet-setpieces-transcript.txt"
dump_f() { echo '--- leaflet setpieces transcript ---' >&2; cat "$F" >&2; }
grep -F 'walkable crown of Flood Control Dam #3' "$F" || { dump_f; exit 1; }
grep -F 'unique to this dam' "$F" || { dump_f; exit 1; }
grep -F 'hungry cyclops' "$F" || { dump_f; exit 1; }
grep -F 'walkable lie' "$F" || { dump_f; exit 1; }
grep -F 'invisible force' "$F" || { dump_f; exit 1; }
grep -F 'broken timber' "$F" || grep -F 'pile of timber' "$F" || grep -F 'timber' "$F" || { dump_f; exit 1; }
grep -F 'bag is underneath the thief' "$F" || grep -F 'dead body' "$F" || { dump_f; exit 1; }

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/leaflet-spine-1296'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1296_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
if r.get('checksum_valid') is not True: raise SystemExit('Release 1296 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']; rec={'release':1296,'serial':m['serial'],'base_release':1304,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['production-smoke','house-ring','leaflet-setpieces']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1296 candidate completed product gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1296 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1296 Leaflet Hour Noun Honesty qualification passed.'
