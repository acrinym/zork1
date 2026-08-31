#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/empire-census-1303"
BUILD="$ROOT/glulx/build/he-absurd-1305"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/he-absurd-1305/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/empire-census/qualify.sh
python -m py_compile glulx/he-absurd-1305/stage.py

python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
    r=Path(root)
    files={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
    return hashlib.sha256(json.dumps(files,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1305_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True))
Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
expected=m.get('base_source_sha256') or {}
if any(not isinstance(expected.get(k),str) or not expected.get(k) for k in ('production','dev')):
    raise SystemExit('Release 1305 predecessor source identities are candidate-only; lock the printed exact identities and rerun.')
if ids!=expected:
    raise SystemExit(f'Release 1305 predecessor source pins drift: expected {expected}, got {ids}')
PY_BASE

python glulx/he-absurd-1305/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/he-absurd-1305/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/he-absurd-1305'); s=b/'src'; p=Path('glulx/build/empire-census-1303/src'); m=json.loads(Path('glulx/he-absurd-1305/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1305 and r['base']['release']==1303,'Release 1305 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1305 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1305 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1305 dev smell errors')
alt=(s/'absurd_alternates.zil').read_text()
zork=(s/'zork1.zil').read_text()
dun=(s/'1dungeon.zil').read_text()
req('<SYNTAX TRICK OBJECT' in alt,'Release 1305 missing TRICK syntax')
req('<ROUTINE GLULX-ALT-BIND-TROLL' in alt,'Release 1305 missing bind routine')
req('<ROUTINE GLULX-ALT-BURN-NEST' in alt,'Release 1305 missing nest-fire routine')
req('(ACTION GLULX-ALT-TROLL-F)' in dun,'Release 1305 troll not hooked')
req('GLULX-ALT-NEST-F' in dun,'Release 1305 nest not hooked')
req('GLULX-ALT-TREE-F' in dun,'Release 1305 tree not hooked')
req('<CONSTANT RELEASEID 1305>' in zork,'Release 1305 identity missing')
req('<INSERT-FILE "absurd_alternates" T>' in zork,'Release 1305 absurd_alternates not loaded')
req(zork.index('<INSERT-FILE "empire_nouns" T>') < zork.index('<INSERT-FILE "absurd_alternates" T>'),'Release 1305 absurd_alternates must follow empire_nouns')
prod='\n'.join(path.read_text(errors='ignore') for path in s.glob('*.zil'))
for bad in ('ALTSAFE','ALTEMPTY','ALTBREAK','ALTCANON','ALTTROLL','ALTUNARM','ALTBOUND','SURVEYKILL','SURVEYREWIND','SCENERY-REGISTRY','GENERIC-NOUN-TABLE','WORLD-SCANNER'):
    req(bad not in prod,'Release 1305 production contains test-only or forbidden token: '+bad)
for f in ('empire_nouns.zil','leaflet_spine.zil','living_collection.zil','mara_companion_actor.zil'):
    req((s/f).read_bytes()==(p/f).read_bytes(),'Release 1305 unexpectedly rewrote predecessor authority: '+f)
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
compile_story "$SRC" "$BUILD/release1305.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
compile_story "$DEV_SRC" "$BUILD/release1305-dev.asm" "$BUILD/release1305-dev.ulx" dev

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/he-absurd-1305/tests/absurd_alt_test.zil "$TEST_SRC/absurd_alt_test.zil"
python - <<'PY_TEST'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/he-absurd-1305/tests/001-include-alt-test.json').resolve(),
    Path('glulx/build/he-absurd-1305/test-src').resolve(),
)
PY_TEST
compile_story "$TEST_SRC" "$BUILD/release1305-test.asm" "$BUILD/release1305-test.ulx" test

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

printf 'look\nquit\nyes\n' > "$BUILD/production-smoke.txt"
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/production-smoke.txt" > "$BUILD/production-smoke-transcript.txt" 2>&1
grep -F 'West of House' "$BUILD/production-smoke-transcript.txt"
grep -F 'Release 1305' "$BUILD/production-smoke-transcript.txt"

cat > "$BUILD/he-nouns.txt" <<'EOF_HE'
west
examine sunlight
quit
yes
EOF_HE
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/he-nouns.txt" > "$BUILD/he-nouns-transcript.txt" 2>&1
H="$BUILD/he-nouns-transcript.txt"
grep -F 'daylight actually reaches' "$H" || grep -F 'sunlight' "$H" || { echo '--- he nouns ---' >&2; cat "$H" >&2; exit 1; }
if grep -F "You can't see any sunlight here!" "$H"; then echo 'Release 1305 lost 1303 sunlight' >&2; cat "$H" >&2; exit 1; fi

cat > "$BUILD/production-troll.txt" <<'EOF_TROLL'
north
west
south
east
open window
west
west
take lamp
turn on lamp
east
up
take rope
down
west
move rug
open trap door
down
north
tie up troll with rope
trick troll
tie up troll with rope
trick troll
examine troll
east
west
recap
quit
yes
EOF_TROLL
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$BUILD/production-troll.txt" > "$BUILD/production-troll-transcript.txt" 2>&1
T="$BUILD/production-troll-transcript.txt"
dump_t() { echo '--- production troll transcript ---' >&2; cat "$T" >&2; }
grep -F 'alert, armed troll' "$T" || { dump_t; exit 1; }
grep -F 'gasp and point behind the troll' "$T" || { dump_t; exit 1; }
grep -F 'loop the rope' "$T" || { dump_t; exit 1; }
grep -F 'axe clatters' "$T" || { dump_t; exit 1; }
grep -F 'not presently available for further tactical deception' "$T" || { dump_t; exit 1; }
grep -F 'tied securely with the rope' "$T" || { dump_t; exit 1; }
grep -F 'troll remains alive, thoroughly tied' "$T" || { dump_t; exit 1; }

cat > "$BUILD/test-nest-troll.txt" <<'EOF_TEST'
altsafe
put sack under tree
up
burn nest with torch
down
take egg from sack
inventory
recap
altbreak
up
burn nest with torch
down
recap
alttroll
tie up troll with rope
trick troll
tie up troll with rope
untie troll
quit
yes
EOF_TEST
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$BUILD/release1305-test.ulx" < "$BUILD/test-nest-troll.txt" > "$BUILD/test-nest-troll-transcript.txt" 2>&1
N="$BUILD/test-nest-troll-transcript.txt"
dump_n() { echo '--- test nest/troll transcript ---' >&2; cat "$N" >&2; }
grep -F 'prepared brown sack' "$N" || grep -F 'lands in the prepared' "$N" || { dump_n; exit 1; }
grep -F 'expensive crunch' "$N" || { dump_n; exit 1; }
grep -F 'You release the final knot' "$N" || { dump_n; exit 1; }

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/he-absurd-1305'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1305_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
if r.get('checksum_valid') is not True: raise SystemExit('Release 1305 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']; rec={'release':1305,'serial':m['serial'],'base_release':1303,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['production-smoke','he-nouns','production-troll','test-nest-troll']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1305 candidate completed product gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1305 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1305 Highly Extended Absurd Alternates qualification passed.'
