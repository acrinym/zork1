#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/empire-census-1303"
BUILD="$ROOT/glulx/build/he-absurd-1305"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_ALT_SRC="$BUILD/test-alt-src"
TEST_CENSUS_SRC="$BUILD/test-census-src"
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
zork=(s/'zork1.zil').read_text()
req('<CONSTANT RELEASEID 1305>' in zork,'Release 1305 identity missing')
req('<INSERT-FILE "absurd_alternates" T>' in zork,'Release 1305 lost predecessor absurd_alternates include')
req('<SYNTAX TRICK OBJECT' in (s/'absurd_alternates.zil').read_text(),'Release 1305 lost TRICK syntax')
req((s/'absurd_alternates.zil').read_bytes()==(p/'absurd_alternates.zil').read_bytes(),'Release 1305 must not rewrite stacked 1214 absurd_alternates; it is already on 1303')
req((s/'1dungeon.zil').read_bytes()==(p/'1dungeon.zil').read_bytes(),'Release 1305 unexpectedly rewrote 1dungeon')
req((s/'assistance.zil').read_bytes()==(p/'assistance.zil').read_bytes(),'Release 1305 unexpectedly rewrote assistance')
req((s/'gsyntax.zil').read_bytes()==(p/'gsyntax.zil').read_bytes(),'Release 1305 unexpectedly rewrote gsyntax')
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

stage_test_story(){
  local dest="$1" extra_zil="$2" extra_name="$3" patch="$4"
  rm -rf "$dest"
  cp -a "$SRC" "$dest"
  cp "$extra_zil" "$dest/$extra_name"
  python - "$patch" "$dest" <<'PY_TEST'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(Path(sys.argv[1]).resolve(), Path(sys.argv[2]).resolve())
PY_TEST
}
stage_test_story "$TEST_ALT_SRC" glulx/he-absurd-1305/tests/absurd_alt_test.zil absurd_alt_test.zil glulx/he-absurd-1305/tests/001-include-alt-test.json
compile_story "$TEST_ALT_SRC" "$BUILD/release1305-test-alt.asm" "$BUILD/release1305-test-alt.ulx" test-alt
stage_test_story "$TEST_CENSUS_SRC" glulx/empire-census/tests/survey_flags.zil survey_flags.zil glulx/he-absurd-1305/tests/002-include-survey-flags.json
compile_story "$TEST_CENSUS_SRC" "$BUILD/release1305-test-census.asm" "$BUILD/release1305-test-census.ulx" test-census

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
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$BUILD/release1305-test-alt.ulx" < "$BUILD/test-nest-troll.txt" > "$BUILD/test-nest-troll-transcript.txt" 2>&1
N="$BUILD/test-nest-troll-transcript.txt"
dump_n() { echo '--- test nest/troll transcript ---' >&2; cat "$N" >&2; }
grep -F 'prepared brown sack' "$N" || grep -F 'lands in the prepared' "$N" || { dump_n; exit 1; }
grep -F 'expensive crunch' "$N" || { dump_n; exit 1; }
grep -F 'You release the final knot' "$N" || { dump_n; exit 1; }

cat > "$BUILD/census-lies.txt" <<'EOF_CENSUS'
surveykill
surveyrewind
examine grass
examine silence
examine boards
west
examine sunlight
east
south
examine tree
examine windows
west
south
east
open window
west
examine crumbs
examine chimney
west
examine trophy case
up
examine stairway
examine stairs
down
west
move rug
open trap door
down
examine crawlway
examine passageway
examine ramp
north
examine hole
examine bloodstains
south
south
examine chasm
east
examine paintings
examine vandals
north
examine fireplace
south
svymaze
examine passages
svytemple
examine prayer
examine pillars
south
examine hole
north
svydamlobby
examine doorways
south
examine walkway
examine panel
north
svymaint
examine equipment
svystream
examine beach
svyhades
examine souls
examine gate
svybarrow
examine door
svyround
examine caveins
svypassage
examine door
svyriver
examine rocks
quit
yes
EOF_CENSUS
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$BUILD/release1305-test-census.ulx" < "$BUILD/census-lies.txt" > "$BUILD/census-lies-transcript.txt" 2>&1
python - "$BUILD/census-lies-transcript.txt" "$BUILD/CENSUS-LIES.json" <<'PY_LIES'
import json,re,sys
from pathlib import Path
text=Path(sys.argv[1]).read_text(errors='replace')
lies=sorted(set(re.findall(r"You can't see any (.+?) here!", text)))
Path(sys.argv[2]).write_text(json.dumps({'count':len(lies),'nouns':lies},indent=2)+'\n')
print('RELEASE_1305_CENSUS_LIES='+json.dumps(lies))
if lies:
    print(text[-8000:], file=sys.stderr)
    raise SystemExit('Release 1305 described-world lies remain: '+', '.join(lies)+'. Build those nouns on the HE story.')
PY_LIES

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/he-absurd-1305'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1305_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
if r.get('checksum_valid') is not True: raise SystemExit('Release 1305 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']; rec={'release':1305,'serial':m['serial'],'base_release':1303,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['production-smoke','he-nouns','production-troll','test-nest-troll','census-lies']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1305 candidate completed product gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1305 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1305 Highly Extended Absurd Alternates qualification passed.'
