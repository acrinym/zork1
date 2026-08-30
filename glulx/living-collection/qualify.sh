#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/west-of-house-nouns-1295"
BUILD="$ROOT/glulx/build/living-collection-1304"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/living-collection/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/west-of-house-nouns/qualify.sh
python -m py_compile glulx/living-collection/stage.py

python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
    r=Path(root)
    files={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
    return hashlib.sha256(json.dumps(files,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1304_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True))
Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
expected=m.get('base_source_sha256') or {}
if any(not isinstance(expected.get(k),str) or not expected.get(k) for k in ('production','dev')):
    raise SystemExit('Release 1304 predecessor source identities are candidate-only; lock the printed exact identities and rerun.')
if ids!=expected:
    raise SystemExit(f'Release 1304 predecessor source pins drift: expected {expected}, got {ids}')
PY_BASE

python glulx/living-collection/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/living-collection/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/living-collection-1304'); s=b/'src'; p=Path('glulx/build/west-of-house-nouns-1295/src'); m=json.loads(Path('glulx/living-collection/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1304 and r['base']['release']==1295,'Release 1304 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1304 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1304 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1304 dev smell errors')
lc=(s/'living_collection.zil').read_text()
zork=(s/'zork1.zil').read_text()
state=(s/'mara_companion_state.zil').read_text()
req('<OBJECT RESERVOIR-CHAR' in lc,'Release 1304 missing reservoir char')
req('<ROUTINE V-LC-MARA-JAR-ERRAND' in lc,'Release 1304 missing Dam jar errand')
req('<ROUTINE V-LC-MARA-PREPARE' in lc,'Release 1304 missing house stewardship')
req('I have not seen that catch' in state,'Release 1304 Mara still pretends to know unwitnessed catches')
req('<CONSTANT RELEASEID 1304>' in zork,'Release 1304 identity missing')
req('<INSERT-FILE "living_collection_syntax" T>' in zork,'Release 1304 living_collection_syntax not loaded before Mara')
req('<INSERT-FILE "living_collection" T>' in zork,'Release 1304 living_collection not loaded')
req(zork.index('<INSERT-FILE "living_collection_syntax" T>') < zork.index('<INSERT-FILE "mara_companion" T>'),'Release 1304 syntax must precede mara_companion')
prod='\n'.join(path.read_text(errors='ignore') for path in s.glob('*.zil'))
for bad in ('LCSETUP','LCSOLO','LCHOME','LCTIDE','LCKITCHEN','LCERRAND','LCBANK','GENERIC-FISHING','AQUARIUM-SIM'):
    req(bad not in prod,'Release 1304 production contains test-only or forbidden token: '+bad)
for f in ('1dungeon.zil','reactive_surface.zil','museum_ecology_dam_fishing.zil'):
    req((s/f).read_bytes()==(p/f).read_bytes(),'Release 1304 unexpectedly rewrote predecessor authority: '+f)
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
compile_story "$SRC" "$BUILD/release1304.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
compile_story "$DEV_SRC" "$BUILD/release1304-dev.asm" "$BUILD/release1304-dev.ulx" dev

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/living-collection/tests/living_collection_test.zil "$TEST_SRC/living_collection_test.zil"
python - <<'PY_TEST'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/living-collection/tests/001-include-living-collection-test.json').resolve(),
    Path('glulx/build/living-collection-1304/test-src').resolve(),
)
PY_TEST
compile_story "$TEST_SRC" "$BUILD/release1304-test.asm" "$BUILD/release1304-test.ulx" test

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

printf 'look\nquit\nyes\n' > "$BUILD/production-smoke.txt"
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/production-smoke.txt" > "$BUILD/production-smoke-transcript.txt" 2>&1
grep -F 'West of House' "$BUILD/production-smoke-transcript.txt"
grep -F 'Release 1304' "$BUILD/production-smoke-transcript.txt"

cat > "$BUILD/living-collection.txt" <<'EOF_LC'
lcsetup
fish
examine char
ask mara about char
lchome
exhibit char
catalog waters
read char plaque
take char
lcbank
release char
lcsolo
fish
lchome
ask mara about silverfin
show silverfin to mara
ask mara about silverfin
lctide
fish
lckitchen
ask mara to prepare
lcerrand
mara, take jar to dam
look
quit
yes
EOF_LC
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$BUILD/release1304-test.ulx" < "$BUILD/living-collection.txt" > "$BUILD/living-collection-transcript.txt" 2>&1
F="$BUILD/living-collection-transcript.txt"
grep -F 'thick-bodied char from quiet water' "$F"
grep -F 'Different body, different current' "$F"
grep -F 'A quiet-water reservoir char occupies the vessel.' "$F"
grep -F 'plaque will record absence' "$F"
grep -F 'I have not seen that catch' "$F"
grep -F 'You showed me that catch' "$F"
grep -F 'drawn down to mud' "$F"
grep -F 'Mara checks the real stove' "$F"
grep -F 'I know this water' "$F"
if grep -F 'I don'\''t know the word "fish"' "$F"; then echo 'Release 1304 lost FISH' >&2; exit 1; fi

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/living-collection-1304'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1304_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
if r.get('checksum_valid') is not True: raise SystemExit('Release 1304 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']; rec={'release':1304,'serial':m['serial'],'base_release':1295,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['production-smoke','living-collection']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1304 candidate completed product gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1304 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1304 Living Collection and Companionship qualification passed.'
