#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-world-integrity-1312"
BUILD="$ROOT/glulx/build/full-game-regression-1314"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
MANIFEST="$ROOT/glulx/full-game-regression-1314/patch-series.json"
QDIR="$ROOT/glulx/full-game-regression-1314/qualification"
cd "$ROOT"

bash glulx/mara-world-integrity-1312/qualify.sh
rm -rf "$BUILD"
mkdir -p "$BUILD"
python -m py_compile glulx/full-game-regression-1314/stage.py
python glulx/full-game-regression-1314/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/full-game-regression-1314/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"
python - <<'PY'
import json
from pathlib import Path
def req(c, m):
    if not c: raise SystemExit(m)
b = Path('glulx/build/full-game-regression-1314')
s = b / 'src'
m = json.loads(Path('glulx/full-game-regression-1314/patch-series.json').read_text())
r = json.loads((s / 'STAGING-RECEIPT.json').read_text())
req(r['release'] == 1314 and r['base']['release'] == 1312, 'Release 1314 staging mismatch')
req(r['changed_paths'] == sorted(m['expected_changed_paths']), 'Release 1314 changed paths mismatch')
req(not json.loads((b / 'smell-report.json').read_text())['errors'], '1314 production smell errors')
req(not json.loads((b / 'dev-smell-report.json').read_text())['errors'], '1314 dev smell errors')
req('<CONSTANT RELEASEID 1314>' in (s / 'zork1.zil').read_text(), '1314 identity missing')
parser = (s / 'gparser.zil').read_text()
req('PREFER-TROPHY-CASE' in parser, 'canonical CASE preference missing')
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
  pushd "$source" >/dev/null
  dotnet "$ZILF" build --glulx --stop-after-compile zork1.zil "$asm" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"
  popd >/dev/null
  python "$ROOT/glulx/tools/normalize_serial.py" "$asm" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"
  "$GLAZER" "$asm" -o "$out" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"
}
STORY="$BUILD/$STORY_FILE"
compile_story "$SRC" "$BUILD/release1314.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
compile_story "$DEV_SRC" "$BUILD/release1314-dev.asm" "$BUILD/release1314-dev.ulx" dev
python glulx/tools/verify_ulx.py "$BUILD/release1314-dev.ulx" --json "$BUILD/dev-story-report.json"

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
  make -C "$ROOT/.tooling/cheapglk"
  make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
TRANSCRIPT="$BUILD/canonical-case-natural-transcript.txt"
timeout 180s "$GLULXE" --rngseed 3 --undo 16 "$STORY" < "$QDIR/canonical-case-natural.txt" > "$TRANSCRIPT" 2>&1
grep -F 'Full Game Regression Repair Glulx ZORK I' "$TRANSCRIPT" >/dev/null
grep -F 'This case preserves the songbird trace.' "$TRANSCRIPT" >/dev/null
! grep -F 'Which case do you mean' "$TRANSCRIPT" >/dev/null || { cat "$TRANSCRIPT" >&2; exit 1; }
python - "$STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text())
b=Path('glulx/build/full-game-regression-1314')
r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1314_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']
rec={'release':1314,'serial':m['serial'],'base_release':1312,'histories':['canonical-case-natural']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident})
    (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
    raise SystemExit('Release 1314 product gameplay passed; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k) != e.get(k):
        raise SystemExit(f'Release 1314 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident})
(b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY
echo 'Release 1314 Full Game Regression Repair qualification passed.'
