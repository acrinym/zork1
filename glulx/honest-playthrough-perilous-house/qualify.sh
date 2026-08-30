#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mundane-objects-spatial-agency-1277"
BUILD="$ROOT/glulx/build/honest-playthrough-perilous-house-1278"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/honest-playthrough-perilous-house/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/mundane-objects-spatial-agency/qualify.sh
python -m py_compile glulx/honest-playthrough-perilous-house/stage.py

python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
    r=Path(root)
    files={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
    return hashlib.sha256(json.dumps(files,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1278_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True))
Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
expected=m.get('base_source_sha256') or {}
if any(not isinstance(expected.get(k),str) or not expected.get(k) for k in ('production','dev')):
    raise SystemExit('Release 1278 predecessor source identities are candidate-only; lock the printed exact identities and rerun.')
if ids!=expected:
    raise SystemExit(f'Release 1278 predecessor source pins drift: expected {expected}, got {ids}')
PY_BASE

python glulx/honest-playthrough-perilous-house/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/honest-playthrough-perilous-house/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/honest-playthrough-perilous-house-1278'); s=b/'src'; p=Path('glulx/build/mundane-objects-spatial-agency-1277/src'); m=json.loads(Path('glulx/honest-playthrough-perilous-house/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1278 and r['base']['release']==1277,'Release 1278 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1278 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1278 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1278 dev smell errors')
attic=(s/'attic_archive_core.zil').read_text()
house=(s/'house_state_foundation.zil').read_text()
kitchen=(s/'house_kitchen_laboratory.zil').read_text()
rest=(s/'house_rest_and_dreams.zil').read_text()
gsyn=(s/'gsyntax.zil').read_text()
jar=(s/'museum_ecology_dam_fishing.zil').read_text()
req('<NOT <FSET? ,ATTIC ,TOUCHBIT>>' in attic,'Release 1278 attic recap is not gated on an actual Attic visit')
req('The kitchen window is open.' in house,'Release 1278 house recap does not name the open window as its own fact')
req('You moved the living-room rug.' in house,'Release 1278 house recap does not name the moved rug as its own fact')
req('Opened routes, the moved rug, or the exposed trap door' not in house,'Release 1278 still ORs unearned house-disturbance facts into one recap line')
req('You prepared the real lunch without creating a recipe economy.' in kitchen,'Release 1278 kitchen recap does not split prepared lunch')
req('You sliced the real garlic without creating a recipe economy.' in kitchen,'Release 1278 kitchen recap does not split sliced garlic')
req('You prepared the real lunch or sliced the real garlic' not in kitchen,'Release 1278 still recaps lunch and garlic as one OR-fact')
req('<VERB? DRINK DRINK-FROM>' in kitchen,'Release 1278 kitchen sink does not accept DRINK FROM')
req('REST-RECORD-INTEGRITY' not in rest,'Release 1278 still prints rest-record integrity telemetry to the player')
req('<SYNTAX LIE = V-HOUSE-SLEEP>' in gsyn,'Release 1278 missing bare LIE sleep syntax')
req('<SYNTAX LIE DOWN = V-HOUSE-SLEEP>' in gsyn,'Release 1278 missing LIE DOWN sleep syntax')
req('<SYNTAX LIE ON OBJECT (ON-GROUND IN-ROOM) = V-HOUSE-SLEEP>' in gsyn,'Release 1278 missing LIE ON OBJECT sleep syntax')
req('<SYNTAX LIE DOWN ON OBJECT' not in gsyn,'Release 1278 still uses illegal two-preposition LIE DOWN ON OBJECT syntax')
req('<SYNTAX DRINK FROM OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-DRINK-FROM>' in gsyn,'Release 1278 DRINK FROM still cannot target room fixtures')
req('The blow reaches the glass.' in jar,'Release 1278 field jar has no authored shatter')
for bad in ('DURABILITY','ARMOR-CLASS','HIT-POINT','CRAFTING-REGISTRY','MATERIAL-TYPE-REGISTRY','BAD-CHOICE-COUNTER'):
    req(bad not in jar,'Release 1278 crossed a forbidden generic-system boundary: '+bad)
for f in ('mara_field_guidance.zil','release1277.zil','perilous_affordances.zil'):
    req((s/f).read_bytes()==(p/f).read_bytes(),'Release 1278 unexpectedly rewrote predecessor authority: '+f)
req('<CONSTANT RELEASEID 1278>' in (s/'zork1.zil').read_text(),'Release 1278 identity missing')
req(not (s/'release1278_test.zil').exists(),'Release 1278 test-only setup verbs leaked into production staging')
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
compile_story "$SRC" "$BUILD/release1278.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"; cp -a "$DEV_SRC" "$TEST_SRC"
cp glulx/honest-playthrough-perilous-house/tests/release1278_test.zil "$TEST_SRC/release1278_test.zil"
python - <<'PY_TEST'
from pathlib import Path
import sys; sys.path.insert(0,str(Path('glulx/tools').resolve())); from stage_release120 import apply_patch
apply_patch(Path('glulx/honest-playthrough-perilous-house/tests/001-include-release1278-test.json').resolve(),Path('glulx/build/honest-playthrough-perilous-house-1278/test-src').resolve())
PY_TEST
TEST_STORY="$BUILD/release1278-test.ulx"
compile_story "$TEST_SRC" "$BUILD/release1278-test.asm" "$TEST_STORY" test

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
run_case(){ local n="$1"; timeout 120s "$GLULXE" --rngseed 123456 "$TEST_STORY" < "$BUILD/$n.txt" > "$BUILD/$n-transcript.txt" 2>&1; }
forbid(){ local f="$1"; shift; local token; for token in "$@"; do if grep -F -- "$token" "$f"; then echo "Release 1278 unearned recap leaked: $token" >&2; exit 1; fi; done; }

printf 'look\nquit\nyes\n' > "$BUILD/production-smoke.txt"
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/production-smoke.txt" > "$BUILD/production-smoke-transcript.txt" 2>&1
grep -F 'West of House' "$BUILD/production-smoke-transcript.txt"

cat > "$BUILD/fresh-recap.txt" <<'EOF_FRESH'
open mailbox
take leaflet
recap
quit
yes
EOF_FRESH
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/fresh-recap.txt" > "$BUILD/fresh-recap-transcript.txt" 2>&1
F="$BUILD/fresh-recap-transcript.txt"
grep -F 'What you currently remember:' "$F"
forbid "$F" 'microfiche' 'card catalog indexed' 'Versioned archive state rebuilt' 'You moved the living-room rug.' 'You sliced the real garlic' 'REST-RECORD-INTEGRITY'

cat > "$BUILD/window-recap.txt" <<'EOF_WIN'
hpwin
recap
quit
yes
EOF_WIN
run_case window-recap; F="$BUILD/window-recap-transcript.txt"
grep -F -- '- The kitchen window is open.' "$F"
forbid "$F" 'You moved the living-room rug.' 'The living-room trap door is open.' 'microfiche' 'You sliced the real garlic'

cat > "$BUILD/lie.txt" <<'EOF_LIE'
hplie
lie
quit
yes
EOF_LIE
run_case lie; F="$BUILD/lie-transcript.txt"
grep -F 'You settle into the four-poster bed.' "$F"
if grep -F "That sentence isn't one I recognize." "$F"; then echo 'Release 1278 LIE still fails to parse' >&2; exit 1; fi

cat > "$BUILD/lie-down.txt" <<'EOF_LIEDOWN'
hplie
lie down
quit
yes
EOF_LIEDOWN
run_case lie-down; F="$BUILD/lie-down-transcript.txt"
grep -F 'You settle into the four-poster bed.' "$F"
if grep -F "That sentence isn't one I recognize." "$F"; then echo 'Release 1278 LIE DOWN still fails to parse' >&2; exit 1; fi

cat > "$BUILD/lie-on-bed.txt" <<'EOF_LIEON'
hplie
lie on bed
quit
yes
EOF_LIEON
run_case lie-on-bed; F="$BUILD/lie-on-bed-transcript.txt"
grep -F 'You settle into the four-poster bed.' "$F"
if grep -F "That sentence isn't one I recognize." "$F"; then echo 'Release 1278 LIE ON BED still fails to parse' >&2; exit 1; fi

cat > "$BUILD/drink-from.txt" <<'EOF_DRINK'
hpdrk
drink from sink
quit
yes
EOF_DRINK
run_case drink-from; F="$BUILD/drink-from-transcript.txt"
grep -F 'You drink from the cold tap.' "$F"
forbid "$F" 'How peculiar!'

cat > "$BUILD/jar-shatter.txt" <<'EOF_JAR'
hpjar
break jar with sword
quit
yes
EOF_JAR
run_case jar-shatter; F="$BUILD/jar-shatter-transcript.txt"
grep -F 'The blow reaches the glass.' "$F"
forbid "$F" 'Nice try, but'

cat > "$BUILD/lamp-break.txt" <<'EOF_LAMP'
hplmp
break lamp with sword
quit
yes
EOF_LAMP
run_case lamp-break; F="$BUILD/lamp-break-transcript.txt"
grep -F 'The same broken lantern left by a hard throw' "$F"

cat > "$BUILD/notebook.txt" <<'EOF_NOTE'
hpntb
rest
read notebook
quit
yes
EOF_NOTE
run_case notebook; F="$BUILD/notebook-transcript.txt"
grep -F 'You settle into the four-poster bed.' "$F"
forbid "$F" 'REST-RECORD-INTEGRITY'

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/honest-playthrough-perilous-house-1278'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1278_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
if r.get('checksum_valid') is not True: raise SystemExit('Release 1278 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']; rec={'release':1278,'serial':m['serial'],'base_release':1277,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['production-smoke','fresh-recap','window-recap','lie','lie-down','lie-on-bed','drink-from','jar-shatter','lamp-break','notebook']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1278 candidate completed product gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1278 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1278 Honest Playthrough Records, Rest Syntax, and House Jar qualification passed.'
