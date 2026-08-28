#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-field-guidance-1276"
BUILD="$ROOT/glulx/build/mundane-objects-spatial-agency-1277"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/mundane-objects-spatial-agency/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

# The predecessor is a locked product artifact. Rebuild it rather than trusting
# an unqualified source checkout.
bash glulx/mara-field-guidance/qualify.sh
python -m py_compile glulx/mundane-objects-spatial-agency/stage.py

python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
    r=Path(root)
    files={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
    return hashlib.sha256(json.dumps(files,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1277_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True))
Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
expected=m.get('base_source_sha256') or {}
if any(not isinstance(expected.get(k),str) or not expected.get(k) for k in ('production','dev')):
    raise SystemExit('Release 1277 predecessor source identities are candidate-only; lock the printed exact identities and rerun.')
if ids!=expected:
    raise SystemExit(f'Release 1277 predecessor source pins drift: expected {expected}, got {ids}')
PY_BASE

python glulx/mundane-objects-spatial-agency/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/mundane-objects-spatial-agency/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/mundane-objects-spatial-agency-1277'); s=b/'src'; p=Path('glulx/build/mara-field-guidance-1276/src'); m=json.loads(Path('glulx/mundane-objects-spatial-agency/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1277 and r['base']['release']==1276,'Release 1277 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1277 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1277 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1277 dev smell errors')
a=(s/'release1277.zil').read_text()
for token in (
 'R1277-LARGE-THUMBTACK','R1277-SEAT-CUSHION','R1277-LUXURIOUS-PILLOW','R1277-HOT-COFFEE','R1277-BENDY-STRAW','R1277-OATMEAL-BOX','R1277-KETCHUP-PACKET','R1277-GLASSES-FRAME','R1277-BEEHIVE','R1277-COPPER-WIRE','R1277-INCENSE-CONES','R1277-LEFT-GLOVE','R1277-PURPLE-STONE','R1277-SALT-SHAKER','R1277-CLOTHESPIN','R1277-SHOELACE','R1277-GROCERY-RECEIPT','R1277-RUBBER-DUCK','R1277-CRACKED-COMB','R1277-MARBLE','R1277-CORK-COASTER','R1277-BUTTON-ONE','R1277-PINECONE',
 'R1277-LEFT-LENS','R1277-RIGHT-LENS','R1277-RUG-PIECE-ONE','V-R1277-SNAPSHOT','V-R1277-ASK-MOVE','R1277-MARA-REQUEST-OBJECT'):
    req(token in a,'Release 1277 missing product token: '+token)
req('<GLOBAL ' not in a,'Release 1277 must add zero legacy globals')
for bad in ('CRAFTING-GRID','QUEST-ITEM','JUNK-GENERATOR','NPC-TASK-QUEUE','OBEDIENCE-SCORE','FURNITURE-COORDINATES'):
    req(bad not in a,'Release 1277 crossed a forbidden generic-system boundary: '+bad)
for f in ('mara_field_guidance.zil','living_biomes_wilderness.zil','structural_difficulty.zil','diegetic_puzzle_furniture.zil'):
    req((s/f).read_bytes()==(p/f).read_bytes(),'Release 1277 unexpectedly rewrote predecessor authority: '+f)
req('<CONSTANT RELEASEID 1277>' in (s/'zork1.zil').read_text(),'Release 1277 identity missing')
req('R1277-TAKE-RUG' in (s/'1actions.zil').read_text(),'Canonical RUG-FCN was not extended')
req('R1277-CUT-RUG' in (s/'material_consequences.zil').read_text(),'Canonical rug material consequence was not extended')
req('R1277-MARA-REQUEST-OBJECT' in (s/'mara_companion_actor.zil').read_text(),'Native Mara actor requests do not reach Release 1277 consent logic')
req(not (s/'release1277_test.zil').exists(),'Release 1277 test-only setup verbs leaked into production staging')
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
compile_story "$SRC" "$BUILD/release1277.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

# Compile a test-only copy with deterministic setup verbs. Production never
# contains these verbs; every assertion below is made through normal player
# commands after setup, matching the established Release 1276 qualification pattern.
rm -rf "$TEST_SRC"; cp -a "$DEV_SRC" "$TEST_SRC"
cp glulx/mundane-objects-spatial-agency/tests/release1277_test.zil "$TEST_SRC/release1277_test.zil"
python - <<'PY_TEST'
from pathlib import Path
import sys; sys.path.insert(0,str(Path('glulx/tools').resolve())); from stage_release120 import apply_patch
apply_patch(Path('glulx/mundane-objects-spatial-agency/tests/001-include-release1277-test.json').resolve(),Path('glulx/build/mundane-objects-spatial-agency-1277/test-src').resolve())
PY_TEST
TEST_STORY="$BUILD/release1277-test.ulx"
compile_story "$TEST_SRC" "$BUILD/release1277-test.asm" "$TEST_STORY" test

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
run_case(){ local n="$1"; timeout 120s "$GLULXE" --rngseed 123456 "$TEST_STORY" < "$BUILD/$n.txt" > "$BUILD/$n-transcript.txt" 2>&1; }

# Actual production artifact still gets a real boot, independent of test setup verbs.
printf 'look\nquit\nyes\n' > "$BUILD/production-smoke.txt"
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/production-smoke.txt" > "$BUILD/production-smoke-transcript.txt" 2>&1
grep -F 'West of House' "$BUILD/production-smoke-transcript.txt"

cat > "$BUILD/mara-rug.txt" <<'EOF_RUG'
r1277rug
ask mara to move rug
take rug
quit
yes
EOF_RUG
run_case mara-rug; F="$BUILD/mara-rug-transcript.txt"
grep -F 'She is agreeing to this move, not surrendering judgment over every command that can be typed.' "$F"
grep -F 'Mara takes one end while you roll and lift the real oriental carpet.' "$F"
grep -F 'without pretending it weighs nothing' "$F"

cat > "$BUILD/promise-furniture.txt" <<'EOF_PROMISE'
r1277promise
ask mara to help with kitchen table
east
haul kitchen table west
west
take sack
quit
yes
EOF_PROMISE
run_case promise-furniture; F="$BUILD/promise-furniture-transcript.txt"
grep -F 'That is a real promise to revisit the lift, not permission to teleport anything here.' "$F"
grep -F 'I said I would revisit this when we were both with the actual thing. I meant it.' "$F"
grep -F 'Mara keeps the opposite corner under control while you haul the real kitchen table into Living Room.' "$F"
grep -F 'Taken.' "$F"

cat > "$BUILD/photo-freeze.txt" <<'EOF_PHOTO'
r1277photo
snapshot
take rug
examine first photograph
snapshot
snapshot
snapshot
quit
yes
EOF_PHOTO
run_case photo-freeze; F="$BUILD/photo-freeze-transcript.txt"
grep -F 'The instant photograph preserves Living Room as it was when the shutter fired.' "$F"
grep -F 'Mara is visibly present in the captured moment.' "$F"
grep -F 'The whole oriental carpet is visibly part of that old arrangement' "$F"
grep -F 'Nothing in the photograph changes merely because the live room has changed since then.' "$F"
grep -F "The camera's three-exposure film pack is empty." "$F"

cat > "$BUILD/coffee-clock.txt" <<'EOF_COFFEE'
r1277coffee
examine coffee
wait
wait
wait
wait
wait
wait
wait
wait
wait
wait
wait
wait
wait
examine coffee
quit
yes
EOF_COFFEE
run_case coffee-clock; F="$BUILD/coffee-clock-transcript.txt"
grep -F 'Steam still lifts from the coffee.' "$F"
grep -F 'The coffee has gone cool.' "$F"

cat > "$BUILD/beehive.txt" <<'EOF_HIVE'
r1277hive
examine beehive
take beehive
quit
yes
EOF_HIVE
run_case beehive; F="$BUILD/beehive-transcript.txt"
grep -F 'The hive is a living colony built into sheltering wood.' "$F"
grep -F 'The hive is not a box waiting to become inventory.' "$F"
grep -F 'defensive boil of bees' "$F"

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/mundane-objects-spatial-agency-1277'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1277_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
if r.get('checksum_valid') is not True: raise SystemExit('Release 1277 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']; rec={'release':1277,'serial':m['serial'],'base_release':1276,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['production-smoke','mara-rug','promise-furniture','photo-freeze','coffee-clock','beehive']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1277 candidate completed product gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1277 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1277 Mundane Objects, Field Caching & House Spatial Agency qualification passed.'
