#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/honest-playthrough-perilous-house-1278"
BUILD="$ROOT/glulx/build/honest-system-recap-1293"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
MANIFEST="$ROOT/glulx/honest-system-recap/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/honest-playthrough-perilous-house/qualify.sh
python -m py_compile glulx/honest-system-recap/stage.py

python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
    r=Path(root)
    files={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
    return hashlib.sha256(json.dumps(files,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1293_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True))
Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
expected=m.get('base_source_sha256') or {}
if any(not isinstance(expected.get(k),str) or not expected.get(k) for k in ('production','dev')):
    raise SystemExit('Release 1293 predecessor source identities are candidate-only; lock the printed exact identities and rerun.')
if ids!=expected:
    raise SystemExit(f'Release 1293 predecessor source pins drift: expected {expected}, got {ids}')
PY_BASE

python glulx/honest-system-recap/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/honest-system-recap/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/honest-system-recap-1293'); s=b/'src'; p=Path('glulx/build/honest-playthrough-perilous-house-1278/src'); m=json.loads(Path('glulx/honest-system-recap/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1293 and r['base']['release']==1278,'Release 1293 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1293 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1293 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1293 dev smell errors')
npc=(s/'attic_npc_dossiers.zil').read_text()
area=(s/'attic_area_case_files.zil').read_text()
play=(s/'attic_playback.zil').read_text()
cellar=(s/'house_cellar_threshold.zil').read_text()
risk=(s/'house_vulnerability_integration.zil').read_text()
mail=(s/'house_correspondence_visitors.zil').read_text()
zork=(s/'zork1.zil').read_text()
req('<NPC-PUT ,NS-EVENT-RESTORE T>' not in npc,'Release 1293 still treats schema init as a restore recap event')
req('<NOT <FSET? ,ATTIC ,TOUCHBIT>>' in npc.split('<ROUTINE NPC-RECAP',1)[1].split('<ROUTINE ',1)[0],'Release 1293 NPC recap is not gated on an Attic visit')
req('<NOT <FSET? ,ATTIC ,TOUCHBIT>>' in area.split('<ROUTINE AREA-RECAP',1)[1].split('<ROUTINE ',1)[0],'Release 1293 AREA recap is not gated on an Attic visit')
req('<NOT <FSET? ,ATTIC ,TOUCHBIT>>' in play.split('<ROUTINE PLAYBACK-RECAP',1)[1].split('<ROUTINE ',1)[0],'Release 1293 PLAYBACK recap is not gated on an Attic visit')
req('<NOT <FSET? ,CELLAR ,TOUCHBIT>>' in cellar.split('<ROUTINE CELLAR-RECAP',1)[1].split('<ROUTINE ',1)[0],'Release 1293 CELLAR recap is not gated on a Cellar visit')
req('Real fire, water, routes, actors, ritual objects, and custody produced bounded authored house conditions.' not in risk,'Release 1293 still dumps generic house-risk architecture into RECAP')
req('<AND <FSET? ,ATTIC ,TOUCHBIT> <MAIL-GET ,MS-EVENT-QUEUE>>' in mail,'Release 1293 still recaps queued correspondence without an Attic visit')
req('<CONSTANT RELEASEID 1293>' in zork,'Release 1293 identity missing')
for f in ('gsyntax.zil','house_rest_and_dreams.zil','house_state_foundation.zil','museum_ecology_dam_fishing.zil'):
    req((s/f).read_bytes()==(p/f).read_bytes(),'Release 1293 unexpectedly rewrote predecessor authority: '+f)
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
compile_story "$SRC" "$BUILD/release1293.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

compile_story "$DEV_SRC" "$BUILD/release1293-dev.asm" "$BUILD/release1293-dev.ulx" dev

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
forbid(){ local f="$1"; shift; local token; for token in "$@"; do if grep -F -- "$token" "$f"; then echo "Release 1293 unearned recap leaked: $token" >&2; exit 1; fi; done; }
ARCH=('Versioned dossier state' 'Actor memory normalized' 'Regional files retained' 'Playback retained unique' 'Real fire, water, routes' 'Thief, creature, water, smoke' 'Meaningful house and expedition events queued' 'microfiche' 'card catalog indexed' 'REST-RECORD-INTEGRITY')

printf 'look\nquit\nyes\n' > "$BUILD/production-smoke.txt"
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/production-smoke.txt" > "$BUILD/production-smoke-transcript.txt" 2>&1
grep -F 'West of House' "$BUILD/production-smoke-transcript.txt"
grep -F 'Release 1293' "$BUILD/production-smoke-transcript.txt"

cat > "$BUILD/fresh-recap.txt" <<'EOF_FRESH'
look
recap
quit
yes
EOF_FRESH
timeout 120s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$BUILD/fresh-recap.txt" > "$BUILD/fresh-recap-transcript.txt" 2>&1
F="$BUILD/fresh-recap-transcript.txt"
grep -F 'What you currently remember:' "$F"
grep -F -- '- No major persistent change has been established yet.' "$F"
forbid "$F" "${ARCH[@]}"

cat > "$BUILD/window-recap.txt" <<'EOF_WIN'
south
east
open window
enter
recap
quit
yes
EOF_WIN
timeout 120s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$BUILD/window-recap.txt" > "$BUILD/window-recap-transcript.txt" 2>&1
F="$BUILD/window-recap-transcript.txt"
grep -F -- '- The kitchen window is open.' "$F"
grep -F -- '- You began using the white house as a place rather than merely passing through it.' "$F"
forbid "$F" "${ARCH[@]}" 'You moved the living-room rug.' 'The living-room trap door is open.'

cat > "$BUILD/forest-sleep.txt" <<'EOF_SLEEP'
west
lie down
recap
quit
yes
EOF_SLEEP
timeout 120s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$BUILD/forest-sleep.txt" > "$BUILD/forest-sleep-transcript.txt" 2>&1
F="$BUILD/forest-sleep-transcript.txt"
grep -F 'real sleep belongs to the Bedroom upstairs' "$F"
grep -F -- '- Unsafe or out-of-room sleep attempts were refused instead of bypassing danger.' "$F"
forbid "$F" 'Versioned dossier state' 'Actor memory normalized' 'Regional files retained' 'Playback retained unique' 'Real fire, water, routes' 'Thief, creature, water, smoke' 'Meaningful house and expedition events queued' 'microfiche' 'card catalog indexed'

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/honest-system-recap-1293'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1293_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
if r.get('checksum_valid') is not True: raise SystemExit('Release 1293 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']; rec={'release':1293,'serial':m['serial'],'base_release':1278,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['production-smoke','fresh-recap','window-recap','forest-sleep']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1293 candidate completed product gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1293 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1293 Honest System Recap qualification passed.'
