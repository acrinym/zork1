#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/forest-answers-back-1294"
BUILD="$ROOT/glulx/build/west-of-house-nouns-1295"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
MANIFEST="$ROOT/glulx/west-of-house-nouns/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/forest-answers-back/qualify.sh
python -m py_compile glulx/west-of-house-nouns/stage.py

python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
    r=Path(root)
    files={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
    return hashlib.sha256(json.dumps(files,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1295_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True))
Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
expected=m.get('base_source_sha256') or {}
if any(not isinstance(expected.get(k),str) or not expected.get(k) for k in ('production','dev')):
    raise SystemExit('Release 1295 predecessor source identities are candidate-only; lock the printed exact identities and rerun.')
if ids!=expected:
    raise SystemExit(f'Release 1295 predecessor source pins drift: expected {expected}, got {ids}')
PY_BASE

python glulx/west-of-house-nouns/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/west-of-house-nouns/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/west-of-house-nouns-1295'); s=b/'src'; p=Path('glulx/build/forest-answers-back-1294/src'); m=json.loads(Path('glulx/west-of-house-nouns/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1295 and r['base']['release']==1294,'Release 1295 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1295 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1295 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1295 dev smell errors')
dungeon=(s/'1dungeon.zil').read_text()
surface=(s/'reactive_surface.zil').read_text()
zork=(s/'zork1.zil').read_text()
west=dungeon.split('<ROOM WEST-OF-HOUSE',1)[1].split('<ROOM STONE-BARROW',1)[0]
req('FIELD-GRASS' in west and 'FIELD-SILENCE' in west,'Release 1295 West of House missing grass or silence')
req(' BOARD ' in west or 'BOARD FOREST' in west,'Release 1295 West of House lost BOARD')
req('<ROUTINE FIELD-GRASS-F' in surface,'Release 1295 missing grass replies')
req('<ROUTINE FIELD-SILENCE-F' in surface,'Release 1295 missing silence replies')
req('<ROUTINE SURFACE-BOARD-F' in surface,'Release 1295 lost board replies')
req('Highly Extended Zork' in dungeon,'Release 1295 leaflet missing Highly Extended honesty')
req('WELCOME TO ZORK!' in dungeon,'Release 1295 leaflet lost the Infocom advertisement')
req('<CONSTANT RELEASEID 1295>' in zork,'Release 1295 identity missing')
req('<OBJECT MAILBOX\n\t(IN WEST-OF-HOUSE)' in dungeon,'Release 1295 mailbox left West of House')
for bad in ('SCENERY-REGISTRY','GENERIC-NOUN-TABLE','WORLD-SCANNER'):
    req(bad not in dungeon and bad not in surface,'Release 1295 crossed a scenery-engine boundary: '+bad)
for f in ('1actions.zil','gsyntax.zil','attic_npc_dossiers.zil','house_rest_and_dreams.zil'):
    req((s/f).read_bytes()==(p/f).read_bytes(),'Release 1295 unexpectedly rewrote predecessor authority: '+f)
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
compile_story "$SRC" "$BUILD/release1295.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

compile_story "$DEV_SRC" "$BUILD/release1295-dev.asm" "$BUILD/release1295-dev.ulx" dev

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

printf 'look\nquit\nyes\n' > "$BUILD/production-smoke.txt"
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/production-smoke.txt" > "$BUILD/production-smoke-transcript.txt" 2>&1
grep -F 'West of House' "$BUILD/production-smoke-transcript.txt"
grep -F 'Release 1295' "$BUILD/production-smoke-transcript.txt"
grep -F 'wild around it' "$BUILD/production-smoke-transcript.txt"

cat > "$BUILD/opening-nouns.txt" <<'EOF_OPEN'
examine grass
examine silence
examine boards
open mailbox
read leaflet
quit
yes
EOF_OPEN
timeout 120s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$BUILD/opening-nouns.txt" > "$BUILD/opening-nouns-transcript.txt" 2>&1
F="$BUILD/opening-nouns-transcript.txt"
grep -F 'ordinary field grass' "$F"
grep -F 'settled quality of a place left alone too long' "$F"
grep -F 'The boards are securely fastened.' "$F"
grep -F 'WELCOME TO ZORK!' "$F"
grep -F 'Highly Extended Zork' "$F"
if grep -F "You can't see any grass here!" "$F"; then echo 'Release 1295 West of House still cannot see grass' >&2; exit 1; fi
if grep -F "You can't see any silence here!" "$F"; then echo 'Release 1295 West of House still cannot see silence' >&2; exit 1; fi

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/west-of-house-nouns-1295'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1295_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
if r.get('checksum_valid') is not True: raise SystemExit('Release 1295 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']; rec={'release':1295,'serial':m['serial'],'base_release':1294,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['production-smoke','opening-nouns']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1295 candidate completed product gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1295 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1295 West-of-House Described Nouns qualification passed.'
