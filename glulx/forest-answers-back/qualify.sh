#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/honest-system-recap-1293"
BUILD="$ROOT/glulx/build/forest-answers-back-1294"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
MANIFEST="$ROOT/glulx/forest-answers-back/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/honest-system-recap/qualify.sh
python -m py_compile glulx/forest-answers-back/stage.py

python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
    r=Path(root)
    files={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
    return hashlib.sha256(json.dumps(files,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1294_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True))
Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
expected=m.get('base_source_sha256') or {}
if any(not isinstance(expected.get(k),str) or not expected.get(k) for k in ('production','dev')):
    raise SystemExit('Release 1294 predecessor source identities are candidate-only; lock the printed exact identities and rerun.')
if ids!=expected:
    raise SystemExit(f'Release 1294 predecessor source pins drift: expected {expected}, got {ids}')
PY_BASE

python glulx/forest-answers-back/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/forest-answers-back/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/forest-answers-back-1294'); s=b/'src'; p=Path('glulx/build/honest-system-recap-1293/src'); m=json.loads(Path('glulx/forest-answers-back/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1294 and r['base']['release']==1293,'Release 1294 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1294 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1294 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1294 dev smell errors')
dungeon=(s/'1dungeon.zil').read_text()
surface=(s/'reactive_surface.zil').read_text()
zork=(s/'zork1.zil').read_text()
north=dungeon.split('<ROOM NORTH-OF-HOUSE',1)[1].split('<ROOM SOUTH-OF-HOUSE',1)[0]
forest1=dungeon.split('<ROOM FOREST-1',1)[1].split('<ROOM FOREST-2',1)[0]
forest2=dungeon.split('<ROOM FOREST-2',1)[1].split('<ROOM MOUNTAINS',1)[0]
path=dungeon.split('<ROOM PATH',1)[1].split('<ROOM UP-A-TREE',1)[0]
east=dungeon.split('<ROOM EAST-OF-HOUSE',1)[1].split('<ROOM FOREST-1',1)[0]
req('FOREST TREE)' in north,'Release 1294 North of House does not expose TREE')
req('There is no tree here suitable for climbing.' in north,'Release 1294 North of House climb still has no local UP refusal')
req('FOREST-NEEDLES' in forest1 and 'FOREST-CANOPY' in forest1,'Release 1294 western pines missing needles or canopy')
req('FOREST-NEEDLES' in forest2 and 'FOREST-UNDERSTORY' in forest2,'Release 1294 dim pines missing needles or undergrowth')
req('HOUSE-FOUNDATION-STONE' in east,'Release 1294 Behind House missing foundation stone')
req('(GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)' in path or 'GLOBAL TREE' in path,'Release 1294 Forest Path lost TREE')
req('<ROUTINE FOREST-NEEDLES-F' in surface,'Release 1294 missing needle replies')
req('<ROUTINE HOUSE-FOUNDATION-STONE-F' in surface,'Release 1294 missing foundation replies')
req('<CONSTANT RELEASEID 1294>' in zork,'Release 1294 identity missing')
for bad in ('SCENERY-REGISTRY','GENERIC-NOUN-TABLE','WORLD-SCANNER'):
    req(bad not in dungeon and bad not in surface,'Release 1294 crossed a scenery-engine boundary: '+bad)
for f in ('attic_npc_dossiers.zil','house_rest_and_dreams.zil','gsyntax.zil','living_biomes_wilderness.zil'):
    req((s/f).read_bytes()==(p/f).read_bytes(),'Release 1294 unexpectedly rewrote predecessor authority: '+f)
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
compile_story "$SRC" "$BUILD/release1294.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

compile_story "$DEV_SRC" "$BUILD/release1294-dev.asm" "$BUILD/release1294-dev.ulx" dev

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

printf 'look\nquit\nyes\n' > "$BUILD/production-smoke.txt"
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/production-smoke.txt" > "$BUILD/production-smoke-transcript.txt" 2>&1
grep -F 'West of House' "$BUILD/production-smoke-transcript.txt"
grep -F 'Release 1294' "$BUILD/production-smoke-transcript.txt"

cat > "$BUILD/north-tree.txt" <<'EOF_TREE'
north
examine tree
climb tree
quit
yes
EOF_TREE
timeout 120s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$BUILD/north-tree.txt" > "$BUILD/north-tree-transcript.txt" 2>&1
F="$BUILD/north-tree-transcript.txt"
grep -F 'The tree is old, deeply rooted' "$F"
grep -F 'There is no tree here suitable for climbing.' "$F"
if grep -F "You can't see any tree here!" "$F"; then echo 'Release 1294 North of House still cannot see a tree' >&2; exit 1; fi

cat > "$BUILD/forest-nouns.txt" <<'EOF_FOR'
west
examine needles
examine canopy
examine undergrowth
quit
yes
EOF_FOR
timeout 120s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$BUILD/forest-nouns.txt" > "$BUILD/forest-nouns-transcript.txt" 2>&1
F="$BUILD/forest-nouns-transcript.txt"
grep -F 'Old needles make a quiet layer over the soil.' "$F"
grep -F 'The canopy thins to the east' "$F"
grep -F 'Blackberry cane' "$F"

cat > "$BUILD/path-climb.txt" <<'EOF_PATH'
north
north
climb tree
quit
yes
EOF_PATH
timeout 120s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$BUILD/path-climb.txt" > "$BUILD/path-climb-transcript.txt" 2>&1
F="$BUILD/path-climb-transcript.txt"
grep -F 'Up a Tree' "$F"

cat > "$BUILD/foundation.txt" <<'EOF_FND'
south
east
examine foundation
quit
yes
EOF_FND
timeout 120s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$BUILD/foundation.txt" > "$BUILD/foundation-transcript.txt" 2>&1
F="$BUILD/foundation-transcript.txt"
grep -F 'Old foundation stone shows where the painted wall gives way' "$F"

cat > "$BUILD/fresh-recap.txt" <<'EOF_REC'
look
recap
quit
yes
EOF_REC
timeout 120s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$BUILD/fresh-recap.txt" > "$BUILD/fresh-recap-transcript.txt" 2>&1
F="$BUILD/fresh-recap-transcript.txt"
grep -F -- '- No major persistent change has been established yet.' "$F"
if grep -F 'Versioned dossier state' "$F"; then echo 'Release 1294 leaked unearned recap architecture' >&2; exit 1; fi

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/forest-answers-back-1294'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1294_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
if r.get('checksum_valid') is not True: raise SystemExit('Release 1294 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']; rec={'release':1294,'serial':m['serial'],'base_release':1293,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['production-smoke','north-tree','forest-nouns','path-climb','foundation','fresh-recap']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1294 candidate completed product gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1294 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1294 Forest That Answers Back qualification passed.'
