#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/runtime-foundation-1280-1286"
STORY_BUILD="$ROOT/glulx/build/west-of-house-nouns-1295"
CONTRACT="$ROOT/glulx/runtime-foundation/hoe-glulx-contract.json"
cd "$ROOT"
rm -rf "$BUILD"
mkdir -p "$BUILD"

python -m py_compile glulx/runtime-foundation/validate_contract.py \
  glulx/runtime-foundation/generate_scale_probe.py \
  glulx/runtime-foundation/chronicle.py \
  glulx/runtime-foundation/pack_bundle.py
python glulx/runtime-foundation/validate_contract.py "$CONTRACT"

bash glulx/west-of-house-nouns/qualify.sh
STORY="$STORY_BUILD/zork1-glulx-west-of-house-nouns.ulx"
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json" \
  --expect-sha256 a239f515902e77a35ffdb3d00557aca9d22c2d14d5c25f75f36b9543c5814a8b

python - "$CONTRACT" <<'PY_PIN'
import json, os, subprocess, sys
from pathlib import Path
c=json.loads(Path(sys.argv[1]).read_text())
root=Path(os.environ.get('GITHUB_WORKSPACE') or subprocess.check_output(['git','rev-parse','--show-toplevel'], text=True).strip())
def rev(path):
    return subprocess.check_output(['git','-C',str(path),'rev-parse','HEAD'], text=True).strip()
got={'glulxe':rev(root/'.tooling/glulxe'),'cheapglk':rev(root/'.tooling/cheapglk')}
exp=c['interpreter_pins']
print('RELEASE_1280_RUNTIME_SOURCE='+json.dumps(got,sort_keys=True))
if got!=exp:
    raise SystemExit(f'Release 1280 pin drift: {got} vs {exp}')
PY_PIN

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
  make -C "$ROOT/.tooling/cheapglk"
  make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

printf 'look\nquit\nyes\n' > "$BUILD/smoke.txt"
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/smoke.txt" > "$BUILD/smoke-transcript.txt" 2>&1
grep -F 'West of House' "$BUILD/smoke-transcript.txt"
grep -F 'Release 1295' "$BUILD/smoke-transcript.txt"

# 1282/1283: second Glulxe at -O3 (no PGO); same transcript as -O2 on a short history.
O3_SRC="$BUILD/glulxe-o3"
rm -rf "$O3_SRC"
cp -a "$ROOT/.tooling/glulxe" "$O3_SRC"
bash glulx/glulxe-optimization/build-glulxe.sh "$O3_SRC" "$ROOT/.tooling/cheapglk" glulxe "-O3 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
GLULXE_O3="$(realpath "$O3_SRC/glulxe")"
cat > "$BUILD/compat.txt" <<'EOF'
look
examine grass
wait
wait
quit
yes
EOF
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/compat.txt" > "$BUILD/compat-o2.txt" 2>&1
timeout 120s "$GLULXE_O3" --rngseed 123456 "$STORY" < "$BUILD/compat.txt" > "$BUILD/compat-o3.txt" 2>&1
python - "$BUILD/compat-o2.txt" "$BUILD/compat-o3.txt" <<'PY_EQ'
from pathlib import Path
import sys
a=Path(sys.argv[1]).read_text(errors='replace')
b=Path(sys.argv[2]).read_text(errors='replace')
for needle in ('West of House','ordinary field grass','Time passes'):
    if needle not in a or needle not in b:
        raise SystemExit('compat history missing '+needle)
if 'Release 1295' not in a:
    raise SystemExit('O2 lost release banner')
print('RELEASE_1282_1283_TRANSCRIPT_CORE_OK')
PY_EQ

# 1281/1284 scale probe on a test-only 1295 tree
SCALE_SRC="$BUILD/scale-src"
rm -rf "$SCALE_SRC"
cp -a "$STORY_BUILD/src" "$SCALE_SRC"
python glulx/runtime-foundation/generate_scale_probe.py --globals 320 --rooms 96 --out "$SCALE_SRC/scale_probe.zil"
python - <<'PY_PATCH'
import sys
from pathlib import Path
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/runtime-foundation/tests/001-include-scale-probe.json').resolve(),
    Path('glulx/build/runtime-foundation-1280-1286/scale-src').resolve(),
)
prod='\n'.join(p.read_text(errors='ignore') for p in Path('glulx/build/west-of-house-nouns-1295/src').glob('*.zil'))
if 'SCALEPROBE' in prod or 'SCALERM0' in prod:
    raise SystemExit('scale probe leaked into production 1295 source')
PY_PATCH
ZILF="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"
GLAZER="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
pushd "$SCALE_SRC"
dotnet "$ZILF" build --glulx --stop-after-compile zork1.zil "$BUILD/scale.asm" 2>&1 | tee "$BUILD/scale-zilf.log"
popd
"$GLAZER" "$BUILD/scale.asm" -o "$BUILD/scale-probe.ulx" 2>&1 | tee "$BUILD/scale-glazer.log"
python glulx/tools/verify_ulx.py "$BUILD/scale-probe.ulx" --json "$BUILD/scale-story-report.json"
printf 'scaleprobe\nquit\nyes\n' > "$BUILD/scale-commands.txt"
timeout 120s "$GLULXE" --rngseed 123456 "$BUILD/scale-probe.ulx" < "$BUILD/scale-commands.txt" > "$BUILD/scale-transcript.txt" 2>&1
grep -F 'SCALE PROBE: globals 320, rooms 96' "$BUILD/scale-transcript.txt"

python glulx/runtime-foundation/pack_bundle.py \
  --story "$STORY" --glulxe "$GLULXE" --contract "$CONTRACT" \
  --destination "$BUILD/hoe-runtime-bundle-1285"

printf 'look\nexamine grass\nquit\nyes\n' > "$BUILD/chronicle-commands.txt"
python glulx/runtime-foundation/chronicle.py \
  --glulxe "$GLULXE" --story "$STORY" --commands "$BUILD/chronicle-commands.txt" \
  --transcript-out "$BUILD/chronicle-off-transcript.txt"
test ! -f "$BUILD/chronicle.json"
python glulx/runtime-foundation/chronicle.py \
  --glulxe "$GLULXE" --story "$STORY" --commands "$BUILD/chronicle-commands.txt" \
  --transcript-out "$BUILD/chronicle-on-transcript.txt" \
  --chronicle-output "$BUILD/chronicle.json"
python - "$BUILD/chronicle.json" "$BUILD/chronicle-off-transcript.txt" "$BUILD/chronicle-on-transcript.txt" <<'PY_CH'
import json,sys
from pathlib import Path
doc=json.loads(Path(sys.argv[1]).read_text())
off=Path(sys.argv[2]).read_text()
on=Path(sys.argv[3]).read_text()
if doc.get('network') is not False: raise SystemExit('chronicle must not network')
if not doc.get('turns'): raise SystemExit('chronicle missing turns')
if 'West of House' not in off or 'West of House' not in on: raise SystemExit('chronicle host changed play')
print('RELEASE_1286_CHRONICLE_OK')
PY_CH

python - "$BUILD" "$STORY" <<'PY_REC'
import json, hashlib, sys
from pathlib import Path
b=Path(sys.argv[1]); story=Path(sys.argv[2])
rec={
  'releases':[1280,1281,1282,1283,1284,1285,1286],
  'story_sha256':hashlib.sha256(story.read_bytes()).hexdigest(),
  'production_story_unchanged': True,
  'scale_probe_globals':320,
  'scale_probe_rooms':96,
  'bundle': 'hoe-runtime-bundle-1285',
  'chronicle_opt_in': True,
}
(b/'RUNTIME-FOUNDATION-RECEIPT.json').write_text(json.dumps(rec,indent=2)+'\n')
print('RELEASE_1280_1286_RUNTIME_FOUNDATION_OK')
PY_REC
echo 'Releases 1280-1286 runtime foundation qualification passed.'
