#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-earned-romance-1306"
BUILD="$ROOT/glulx/build/adventurer-body-wardrobe-1309"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/adventurer-body-wardrobe/patch-series.json"
cd "$ROOT"

# Reproduce the exact locked Release 1306 predecessor first.
bash glulx/mara-earned-romance/qualify.sh
rm -rf "$BUILD"
mkdir -p "$BUILD"
python -m py_compile glulx/adventurer-body-wardrobe/stage.py
python glulx/adventurer-body-wardrobe/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/adventurer-body-wardrobe/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path

def req(c, m):
    if not c:
        raise SystemExit(m)

b = Path('glulx/build/adventurer-body-wardrobe-1309')
s = b / 'src'
m = json.loads(Path('glulx/adventurer-body-wardrobe/patch-series.json').read_text())
r = json.loads((s / 'STAGING-RECEIPT.json').read_text())
req(r['release'] == 1309 and r['base']['release'] == 1306, 'Release 1309 staging mismatch')
req(r['changed_paths'] == sorted(m['expected_changed_paths']), 'Release 1309 changed paths mismatch')
req(not json.loads((b / 'smell-report.json').read_text())['errors'], '1309 smell errors')
req(not json.loads((b / 'dev-smell-report.json').read_text())['errors'], '1309 dev smell errors')
req('<CONSTANT RELEASEID 1309>' in (s / 'zork1.zil').read_text(), '1309 identity missing')
comp = (s / 'mara_companion.zil').read_text()
req('<INSERT-FILE "adventurer_body_wardrobe" T>' in comp, 'wardrobe include missing')
req('<INSERT-FILE "mara_boundary_continuity" T>' in comp, 'boundary continuity include missing')
bound = (s / 'mara_boundary_continuity.zil').read_text()
req('MARA-SLOT-RUPTURE-OPEN' in bound, 'boundary logic is not coupled to existing rupture authority')
req('MARA-SLOT-TRUST' not in bound and 'MARA-SLOT-RESPECT' not in bound, 'boundary logic must not become a relationship meter')
prod = '\n'.join(p.read_text(errors='ignore') for p in s.glob('*.zil'))
for bad in ('BNDCOAT', 'BNDFOOD', 'BNDHERE', 'BNDAUTO'):
    req(bad not in prod, 'production test-verb leak ' + bad)
PY

read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text()); print(m['serial'], m['expected_artifact']['file'])
PY
)
ZILF="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"
GLAZER="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"

compile_story(){
  local source="$1" asm="$2" out="$3" prefix="$4"
  pushd "$source"
  dotnet "$ZILF" build --glulx --stop-after-compile zork1.zil "$asm" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"
  popd
  python "$ROOT/glulx/tools/normalize_serial.py" "$asm" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"
  "$GLAZER" "$asm" -o "$out" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"
}

STORY="$BUILD/$STORY_FILE"
compile_story "$SRC" "$BUILD/release1309.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/adventurer-body-wardrobe/tests/mara_boundary_test.zil "$TEST_SRC/mara_boundary_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(Path('glulx/adventurer-body-wardrobe/tests/001-include-boundary-test.json').resolve(), Path('glulx/build/adventurer-body-wardrobe-1309/test-src').resolve())
PY
compile_story "$TEST_SRC" "$BUILD/release1309-test.asm" "$BUILD/release1309-test.ulx" test

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
  make -C "$ROOT/.tooling/cheapglk"
  make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

cat > "$BUILD/production-smoke.txt" <<'EOF'
examine me
south
east
open window
enter
west
examine wardrobe
quit
yes
EOF
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/production-smoke.txt" > "$BUILD/production-smoke-transcript.txt" 2>&1
grep -F 'Nothing here is a stat block.' "$BUILD/production-smoke-transcript.txt"
grep -F 'wardrobe' "$BUILD/production-smoke-transcript.txt"

cat > "$BUILD/boundary-test.txt" <<'EOF'
bndcoat
take mara coat
take mara coat
kiss mara
apologize to mara
kiss mara
south
west
ask mara about rupture
kiss mara
bndfood
take mara ration
bndhere
examine mara
examine mara
give ration to mara
kiss mara
bndauto
mara, wait
mara, wait
kiss mara
quit
yes
EOF
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$BUILD/release1309-test.ulx" < "$BUILD/boundary-test.txt" > "$BUILD/boundary-test-transcript.txt" 2>&1
R="$BUILD/boundary-test-transcript.txt"
dump(){ echo '--- Release 1309 boundary test ---' >&2; cat "$R" >&2; }
grep -F 'Do not try again.' "$R" || { dump; exit 1; }
grep -F 'The second attempt is not curiosity.' "$R" || { dump; exit 1; }
grep -F 'ignoring what I said about my body and clothes into affection' "$R" || { dump; exit 1; }
grep -F 'It does not make me safe with you again by itself.' "$R" || { dump; exit 1; }
grep -F 'You heard the part where I asked for space.' "$R" || { dump; exit 1; }
grep -F 'willing to work at ordinary distance again' "$R" || { dump; exit 1; }
grep -F 'That is my food' "$R" || { dump; exit 1; }
grep -F 'Returning property is a real action' "$R" || { dump; exit 1; }
grep -F 'Affection does not overwrite that.' "$R" || { dump; exit 1; }
grep -F 'Repeating the order until my answer changes is not cooperation.' "$R" || { dump; exit 1; }
grep -F 'overruling my choices' "$R" || { dump; exit 1; }
! grep -F 'rewrite an attack as affection' "$R" || { dump; exit 1; }

python - "$STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/adventurer-body-wardrobe-1309'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1309_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']; rec={'release':1309,'serial':m['serial'],'base_release':1306,'histories':['production-smoke','boundary-test']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1309 candidate completed product gameplay; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1309 artifact drift for {k}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY

echo 'Release 1309 Adventurer Body/Wardrobe + Mara Boundary Continuity qualification passed.'
