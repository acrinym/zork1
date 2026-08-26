#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/diegetic-puzzle-furniture-1274"
BUILD="$ROOT/glulx/build/mara-field-guidance-1276"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/mara-field-guidance/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/diegetic-puzzle-furniture/qualify.sh
python -m py_compile glulx/mara-field-guidance/stage.py
python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
    r=Path(root); files={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
    return hashlib.sha256(json.dumps(files,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1276_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True)); Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
if ids!=(m.get('base_source_sha256') or {}): raise SystemExit(f'Release 1276 predecessor source pins drift: expected {m.get("base_source_sha256")}, got {ids}')
PY_BASE

python glulx/mara-field-guidance/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/mara-field-guidance/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/mara-field-guidance-1276'); s=b/'src'; p=Path('glulx/build/diegetic-puzzle-furniture-1274/src'); m=json.loads(Path('glulx/mara-field-guidance/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1276 and r['base']['release']==1274,'Release 1276 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1276 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1276 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1276 dev smell errors')
a=(s/'mara_field_guidance.zil').read_text()
for token in ('MARA-FIELD-GUIDANCE-CAN-ENTER?','MARA-FIELD-GUIDANCE-VISIT','MARA-FIELD-GUIDANCE-WITNESS-CACHE','MARA-FIELD-GUIDANCE-ABOUT','MFG-FOX-DISCOVERED'):
    req(token in a,'Release 1276 missing field-guidance token: '+token)
req('<GLOBAL ' not in a,'Release 1276 must add zero legacy globals')
for bad in ('PATHFINDER','QUEST-MARKER','HINT-ENGINE','KNOWLEDGE-REGISTRY','AUTO-HINT','INVENTORY-TRACKER'):
    req(bad not in a,'Release 1276 crossed generic guidance boundary: '+bad)
for f in ('living_biomes_wilderness.zil','structural_difficulty.zil','mara_anticipation.zil','diegetic_puzzle_furniture.zil','dragon_hoard.zil'):
    req((s/f).read_bytes()==(p/f).read_bytes(),'Release 1276 unexpectedly rewrote predecessor authority: '+f)
req('<CONSTANT RELEASEID 1276>' in (s/'zork1.zil').read_text(),'Release 1276 identity missing')
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
STORY="$BUILD/$STORY_FILE"; compile_story "$SRC" "$BUILD/mara-field-guidance.asm" "$STORY" production; python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"; cp -a "$DEV_SRC" "$TEST_SRC"; cp glulx/mara-field-guidance/tests/mara_field_guidance_test.zil "$TEST_SRC/mara_field_guidance_test.zil"
python - <<'PY_TEST'
from pathlib import Path
import sys; sys.path.insert(0,str(Path('glulx/tools').resolve())); from stage_release120 import apply_patch
apply_patch(Path('glulx/mara-field-guidance/tests/001-include-mara-field-guidance-test.json').resolve(),Path('glulx/build/mara-field-guidance-1276/test-src').resolve())
PY_TEST
TEST_STORY="$BUILD/mara-field-guidance-test.ulx"; compile_story "$TEST_SRC" "$BUILD/mara-field-guidance-test.asm" "$TEST_STORY" test
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
run_case(){ local n="$1"; timeout 120s "$GLULXE" --rngseed 123456 "$TEST_STORY" < "$BUILD/$n.txt" > "$BUILD/$n-transcript.txt" 2>&1; }

cat > "$BUILD/classic-field.txt" <<'EOF1'
mfgclassic
west
west
north
west
ask mara about findings
southwest
south
ask mara about map
south
north
ask mara about map
quit
yes
EOF1
run_case classic-field; F="$BUILD/classic-field-transcript.txt"
grep -F 'I found a route fact' "$F"
grep -F 'The fox tracks leave the muddy run southwest' "$F"
grep -F 'Warmwind Notch' "$F"
grep -F 'warm wet descent' "$F"
grep -F 'route I did not enter' "$F"

cat > "$BUILD/cache.txt" <<'EOF2'
mfgcache
drop machete
ask mara about cache
take machete
ask mara about cache
quit
yes
EOF2
run_case cache; F="$BUILD/cache-transcript.txt"
grep -F 'I watched you leave the old forester' "$F"
grep -F 'still where it is' "$F"
grep -F 'it is not there now' "$F"
grep -F 'I cannot invent who moved it or where it went afterward' "$F"

cat > "$BUILD/forgiving.txt" <<'EOF3'
mfgforgiving
west
west
north
west
southwest
quit
yes
EOF3
run_case forgiving; F="$BUILD/forgiving-transcript.txt"
grep -F 'Fox route southwest' "$F"
grep -F 'I actually traced it' "$F"
grep -F 'Warmwind Notch' "$F"

cat > "$BUILD/exacting.txt" <<'EOF4'
mfgexacting
west
west
north
west
southwest
ask mara about findings
southwest
quit
yes
EOF4
run_case exacting; F="$BUILD/exacting-transcript.txt"
grep -F 'you have not yet found a human-usable line through it' "$F"
grep -F 'The fox tracks leave the muddy run southwest' "$F"
grep -F 'Warmwind Notch' "$F"
if grep -Fq 'I found a route fact' "$F"; then echo 'Exacting improperly volunteered field guidance' >&2; exit 1; fi

cat > "$BUILD/unknown.txt" <<'EOF5'
mfgclassic
ask mara about warmrain
quit
yes
EOF5
run_case unknown; F="$BUILD/unknown-transcript.txt"
grep -F 'not on any route I have personally confirmed' "$F"

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/mara-field-guidance-1276'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
if r.get('checksum_valid') is not True: raise SystemExit('Release 1276 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n'); print('RELEASE_1276_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
e=m['expected_artifact']; rec={'release':1276,'serial':m['serial'],'base_release':1274,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['classic-field','cache','forgiving','exacting','unknown']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1276 candidate completed gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1276 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1276 Mara Field Guidance & Earned Clues qualification passed.'
