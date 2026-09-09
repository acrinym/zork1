#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/flathead-fair-1310"
BUILD="$ROOT/glulx/build/natural-play-fidelity-1311"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
MANIFEST="$ROOT/glulx/natural-play-fidelity-1311/patch-series.json"
TRAIN="$ROOT/.beads/onyx_zork_natural_play_fidelity_1311.beadtrain"
cd "$ROOT"
bash glulx/flathead-fair/qualify.sh
rm -rf "$BUILD"
mkdir -p "$BUILD"
python -m py_compile glulx/natural-play-fidelity-1311/stage.py
python .beads/beadtrains/scripts/validate_beadtrain.py "$TRAIN"
python glulx/natural-play-fidelity-1311/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/natural-play-fidelity-1311/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"python - <<'PY'
import json
from pathlib import Path
def req(c, m):
    if not c: raise SystemExit(m)
b = Path('glulx/build/natural-play-fidelity-1311')
s = b / 'src'
m = json.loads(Path('glulx/natural-play-fidelity-1311/patch-series.json').read_text())
r = json.loads((s / 'STAGING-RECEIPT.json').read_text())
req(r['release'] == 1311 and r['base']['release'] == 1310, 'Release 1311 staging mismatch')
req(r['changed_paths'] == sorted(m['expected_changed_paths']), 'Release 1311 changed paths mismatch')
req(not json.loads((b / 'smell-report.json').read_text())['errors'], '1311 production smell errors')
req(not json.loads((b / 'dev-smell-report.json').read_text())['errors'], '1311 dev smell errors')
z = (s / 'zork1.zil').read_text()
req('<CONSTANT RELEASEID 1311>' in z, '1311 identity missing')
g = (s / 'gsyntax.zil').read_text()
req('<SYNONYM NE NORTHE NORTHEAST>' in g, 'full NORTHEAST vocabulary missing')
req('<SYNONYM SE SOUTHE SOUTHEAST>' in g, 'full SOUTHEAST vocabulary missing')
f = (s / 'flathead_fair.zil').read_text()
for noun in ('FAIR-ENTRANCE-NOTICE', 'FAIR-MIRROR-SCREW', 'FAIR-POND-BANK'):
    req(noun in f, 'missing referable Fair noun ' + noun)
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
compile_story "$SRC" "$BUILD/release1311.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
  make -C "$ROOT/.tooling/cheapglk"
  make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
cat > "$BUILD/natural-play.txt" <<'EOF'
look
s
e
e
take pouch
northeast
n
examine notice
northwest
look
ask tomas about drinks
buy elephant ear
inventory
eat elephant ear
inventory
southeast
northeast
northeast
north
in
north
examine screw
south
out
west
southwest
north
look
examine bank
ask silas about fishing
quit
yes
EOF
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$BUILD/natural-play.txt" > "$BUILD/natural-play-transcript.txt" 2>&1
R="$BUILD/natural-play-transcript.txt"
dump(){ echo '--- Release 1311 natural play ---' >&2; cat "$R" >&2; }
grep -F 'Release 1311' "$R" || { dump; exit 1; }
grep -F 'painted notice, signed Berrin Vale' "$R" || { dump; exit 1; }
grep -F 'Ephraim Peake is here.' "$R" || { dump; exit 1; }
grep -F 'large drink is pear-lime fizz' "$R" || { dump; exit 1; }
grep -F 'Sugar, oil, and a fair that does not require this to finish Zork.' "$R" || { dump; exit 1; }
grep -F 'The brass screw sits firmly in the east mirror frame.' "$R" || { dump; exit 1; }
grep -F 'Grass and packed earth slope gently to the working pond.' "$R" || { dump; exit 1; }
grep -F 'Rod rental 3 zm, bait 1 zm, derby entry 5 zm.' "$R" || { dump; exit 1; }
! grep -F 'There is a Ephraim Peake here.' "$R" || { dump; exit 1; }
! grep -F 'I don'"'"'t know the word "northeast".' "$R" || { dump; exit 1; }
! grep -F 'I don'"'"'t know the word "southeast".' "$R" || { dump; exit 1; }
! grep -F 'I don'"'"'t know the word "drinks".' "$R" || { dump; exit 1; }
python - "$R" <<'PY'
from pathlib import Path
import sys
t = Path(sys.argv[1]).read_text(errors='replace')
needle = 'Sugar, oil, and a fair that does not require this to finish Zork.'
pos = t.find(needle)
if pos < 0:
    raise SystemExit('eat response missing')
tail = t[pos:]
if 'You are empty-handed.' not in tail:
    raise SystemExit('post-eat inventory did not become empty-handed')
PY
python - "$STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text())
b=Path('glulx/build/natural-play-fidelity-1311')
r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1311_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']
rec={'release':1311,'serial':m['serial'],'base_release':1310,'histories':['production-natural-play']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident})
    (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
    raise SystemExit('Release 1311 natural play passed; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k) != e.get(k):
        raise SystemExit(f'Release 1311 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident})
(b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY
echo 'Release 1311 Natural-Play Fidelity qualification passed.'