#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/leaflet-spine-1296"
BUILD="$ROOT/glulx/build/empire-census-1303"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/empire-census/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/leaflet-spine/qualify.sh
python -m py_compile glulx/empire-census/stage.py glulx/empire-census/survey_cli.py glulx/empire-census/tests/survey_jigsup_inject.py

python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
    r=Path(root)
    files={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
    return hashlib.sha256(json.dumps(files,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1303_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True))
Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
expected=m.get('base_source_sha256') or {}
if any(not isinstance(expected.get(k),str) or not expected.get(k) for k in ('production','dev')):
    raise SystemExit('Release 1303 predecessor source identities are candidate-only; lock the printed exact identities and rerun.')
if ids!=expected:
    raise SystemExit(f'Release 1303 predecessor source pins drift: expected {expected}, got {ids}')
PY_BASE

python glulx/empire-census/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/empire-census/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/empire-census-1303'); s=b/'src'; p=Path('glulx/build/leaflet-spine-1296/src'); m=json.loads(Path('glulx/empire-census/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1303 and r['base']['release']==1296,'Release 1303 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1303 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1303 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1303 dev smell errors')
nouns=(s/'empire_nouns.zil').read_text()
zork=(s/'zork1.zil').read_text()
dun=(s/'1dungeon.zil').read_text()
req('<OBJECT GALLERY-PAINTINGS' in nouns,'Release 1303 missing gallery paintings')
req('<OBJECT MAZE-TWISTS' in nouns,'Release 1303 missing maze passages')
req('<OBJECT FOREST-SUNLIGHT' in nouns,'Release 1303 missing forest sunlight')
req('(GLOBAL MAZE-TWISTS)>' in dun,'Release 1303 maze rooms missing MAZE-TWISTS')
req('FOREST-SUNLIGHT' in dun,'Release 1303 western forest missing sunlight global')
req('<CONSTANT RELEASEID 1303>' in zork,'Release 1303 identity missing')
req('<INSERT-FILE "empire_nouns" T>' in zork,'Release 1303 empire_nouns not loaded')
req(zork.index('<INSERT-FILE "leaflet_spine" T>') < zork.index('<INSERT-FILE "empire_nouns" T>'),'Release 1303 empire_nouns must follow leaflet_spine')
prod='\n'.join(path.read_text(errors='ignore') for path in s.glob('*.zil'))
for bad in ('SURVEYKILL','SURVEYREWIND','SVYMAZE','SVYTEMPLE','SVYDAMLOBBY','SVYSTREAM','SVYHADES','SVYBARROW','SVYROUND','SVYPASSAGE','SVYRIVER','SVYMAINT','SURVEY-NO-KILLING','SURVEY-NO-RESET','--no-killing','--no-reset-on-death','SCENERY-REGISTRY','GENERIC-NOUN-TABLE','WORLD-SCANNER'):
    req(bad not in prod,'Release 1303 production contains test-only or forbidden token: '+bad)
for f in ('leaflet_spine.zil','living_collection.zil','mara_companion_actor.zil'):
    req((s/f).read_bytes()==(p/f).read_bytes(),'Release 1303 unexpectedly rewrote predecessor authority: '+f)
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
compile_story "$SRC" "$BUILD/release1303.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
compile_story "$DEV_SRC" "$BUILD/release1303-dev.asm" "$BUILD/release1303-dev.ulx" dev

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/empire-census/tests/survey_flags.zil "$TEST_SRC/survey_flags.zil"
python - <<'PY_TEST'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/empire-census/tests/001-include-survey-flags.json').resolve(),
    Path('glulx/build/empire-census-1303/test-src').resolve(),
)
PY_TEST
python glulx/empire-census/tests/survey_jigsup_inject.py "$TEST_SRC/1actions.zil"
compile_story "$TEST_SRC" "$BUILD/release1303-test.asm" "$BUILD/release1303-test.ulx" test

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

printf 'look\nquit\nyes\n' > "$BUILD/production-smoke.txt"
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/production-smoke.txt" > "$BUILD/production-smoke-transcript.txt" 2>&1
grep -F 'West of House' "$BUILD/production-smoke-transcript.txt"
grep -F 'Release 1303' "$BUILD/production-smoke-transcript.txt"

cat > "$BUILD/production-death.txt" <<'EOF_DEATH'
north
west
south
east
open window
west
take lamp
turn on lamp
west
move rug
open trap door
down
south
jump
quit
yes
EOF_DEATH
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/production-death.txt" > "$BUILD/production-death-transcript.txt" 2>&1
grep -F 'You have died' "$BUILD/production-death-transcript.txt"

cat > "$BUILD/flagless-empire.txt" <<'EOF_EMPIRE'
west
examine sunlight
east
south
west
south
east
open window
west
up
examine stairway
down
west
take lamp
turn on lamp
move rug
open trap door
down
examine crawlway
examine passageway
south
examine chasm
east
examine paintings
examine vandals
quit
yes
EOF_EMPIRE
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$BUILD/flagless-empire.txt" > "$BUILD/flagless-empire-transcript.txt" 2>&1
E="$BUILD/flagless-empire-transcript.txt"
dump_e() { echo '--- flagless empire transcript ---' >&2; cat "$E" >&2; }
grep -F 'daylight actually reaches' "$E" || grep -F 'sunlight' "$E" || { dump_e; exit 1; }
grep -F 'Empty hooks' "$E" || grep -F 'vandals already' "$E" || { dump_e; exit 1; }
grep -F 'crawlway' "$E" || grep -F 'narrow passageway' "$E" || { dump_e; exit 1; }
if grep -F "You can't see any paintings here!" "$E"; then echo 'Release 1303 gallery still cannot see paintings' >&2; dump_e; exit 1; fi
if grep -F "You can't see any crawlway here!" "$E"; then echo 'Release 1303 cellar still cannot see crawlway' >&2; dump_e; exit 1; fi

cat > "$BUILD/survey-flags.txt" <<'EOF_SURVEY'
surveykill
surveyrewind
north
west
south
east
open window
west
take lamp
turn on lamp
west
move rug
open trap door
down
north
wait
wait
south
south
jump
svymaze
examine passages
svytemple
examine prayer
examine pillars
svydamlobby
examine doorways
svymaint
examine equipment
svystream
examine beach
svyhades
examine souls
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
EOF_SURVEY
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$BUILD/release1303-test.ulx" < "$BUILD/survey-flags.txt" > "$BUILD/survey-flags-transcript.txt" 2>&1
S="$BUILD/survey-flags-transcript.txt"
dump_s() { echo '--- survey flags transcript ---' >&2; cat "$S" >&2; }
grep -F 'SURVEY FLAG --no-killing' "$S" || { dump_s; exit 1; }
grep -F 'SURVEY FLAG --no-reset-on-death' "$S" || { dump_s; exit 1; }
grep -F 'SURVEY REWIND:' "$S" || { dump_s; exit 1; }
grep -F 'West of House' "$S" || { dump_s; exit 1; }
grep -F 'twisty little passages' "$S" || grep -F 'all alike on purpose' "$S" || { dump_s; exit 1; }
grep -F 'forgotten language' "$S" || { dump_s; exit 1; }
grep -F 'tour route' "$S" || { dump_s; exit 1; }
if grep -F "You can't see any passages here!" "$S"; then echo 'Release 1303 maze still cannot see passages' >&2; dump_s; exit 1; fi
if grep -F "You can't see any prayer here!" "$S"; then echo 'Release 1303 temple still cannot see prayer' >&2; dump_s; exit 1; fi

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/empire-census-1303'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1303_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
if r.get('checksum_valid') is not True: raise SystemExit('Release 1303 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']; rec={'release':1303,'serial':m['serial'],'base_release':1296,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['production-smoke','production-death','flagless-empire','survey-flags']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1303 candidate completed product gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1303 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1303 Empire Noun Honesty (1301-1303) qualification passed.'
