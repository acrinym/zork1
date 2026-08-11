#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/narrative-physicality-1247"
BASE_1245="$BUILD/base-1245-src"
BASE_1246="$BUILD/base-1246-src"
BASE_1246_DEV="$BUILD/base-1246-dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
MANIFEST="$ROOT/glulx/narrative-physicality/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

IFS=$'\t' read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text())
assert m['expected_artifact']['locked'] is True
print('\t'.join((m['serial'],m['expected_artifact']['file'])))
PY
)

python -m py_compile glulx/narrative-physicality/stage.py
python glulx/creative-natural-play/stage.py \
  --upstream .upstream/zork1-glulx \
  --destination "$BASE_1245" \
  --allowed-root "$BUILD" \
  --manifest glulx/creative-natural-play/patch-series.json
python glulx/environmental-destruction/stage.py \
  --base-source "$BASE_1245" \
  --destination "$BASE_1246" \
  --manifest glulx/environmental-destruction/patch-series.json
python glulx/environmental-destruction/stage.py \
  --base-source "$BASE_1245" \
  --destination "$BASE_1246_DEV" \
  --manifest glulx/environmental-destruction/patch-series.json \
  --dev
python glulx/narrative-physicality/stage.py \
  --base-source "$BASE_1246" \
  --destination "$SRC" \
  --manifest "$MANIFEST"
python glulx/narrative-physicality/stage.py \
  --base-source "$BASE_1246_DEV" \
  --destination "$DEV_SRC" \
  --manifest "$MANIFEST"

python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path
build=Path('glulx/build/narrative-physicality-1247')
s=build/'src'
d=build/'dev-src'
b=build/'base-1246-src'
stage=json.loads((s/'STAGING-RECEIPT.json').read_text())
dev=json.loads((d/'STAGING-RECEIPT.json').read_text())
smell=json.loads((build/'smell-report.json').read_text())
dev_smell=json.loads((build/'dev-smell-report.json').read_text())
assert stage['release']==1247 and stage['base']['release']==1246
assert stage['base']['artifact_sha256']=='28ee345b8a393aedce28c0d9514785d8034aa78026783cdcf8c518bfc584bcf1'
assert stage['changed_paths']==sorted(['1actions.zil','mara_companion_actor.zil','material_consequences.zil','shadow_logic.zil','zork1.zil'])
assert stage['dev_mode'] is False and dev['dev_mode'] is True
assert not smell['errors'] and not dev_smell['errors']
material=(s/'material_consequences.zil').read_text()
base_material=(b/'material_consequences.zil').read_text()
shadow=(s/'shadow_logic.zil').read_text()
actions=(s/'1actions.zil').read_text()
actor=(s/'mara_companion_actor.zil').read_text()
zork=(s/'zork1.zil').read_text()
assert material.count('<GLOBAL ') == base_material.count('<GLOBAL ')
assert '<ROUTINE NARRATIVE-PHYSICALITY-HOOK ()' in material
assert '<ROUTINE NARRATIVE-SPILL-SACK-CONTENTS ()' in material
assert '<NARRATIVE-PHYSICALITY-HOOK> <RTRUE>' in shadow
assert '<VERB? PUT MARA-PUT-ACTOR>' in material
assert '<FSET? ,WHITE-HOUSE ,RMUNGBIT>' in material
assert '<FSET? ,KITCHEN-TABLE ,RMUNGBIT>' in material
assert '<FSET? ,SANDWICH-BAG ,RMUNGBIT>' in material
assert '<FSET? ,RUG ,RMUNGBIT>' in material
assert '<FCLEAR ,SANDWICH-BAG ,RMUNGBIT>' in material
assert '<FCLEAR ,RUG ,RMUNGBIT>' in material
assert '(T <PERFORM ,V?EAT ,PRSO>)' in actor
assert '(T <PERFORM ,V?DROP ,PRSO>)' in actor
assert '(T <PERFORM ,V?THROW ,PRSO>)' in actor
assert '(T <PERFORM ,V?PUT ,PRSO ,PRSI>)' in actor
assert 'large white colonial house' in actions
assert 'small kitchen window is ' in actions
assert 'interrupted domestic life' in actions
assert actions.count('shattered out; jagged remnants frame an opening') >= 2
assert 'Dust softens the abandoned grandeur' in actions
assert 'Glass snaps outward in a brief glittering spray' in actions
assert '<CONSTANT RELEASEID 1247>' in zork
assert 'NARRATIVE PHYSICALITY GLULX' in zork
PY

GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit 2>/dev/null || true)"
if [[ -z "$GLULX_ZILF_DLL" ]]; then
  pushd .tooling/zilf-glulx
  dotnet restore Zilf.sln --nologo
  dotnet build Zilf.sln --configuration Release --property:PortableTarget=true --no-restore --nologo
  popd
  GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)"
fi
GLULX_ZILF_DLL="$(realpath "$GLULX_ZILF_DLL")"
GLAZER_BIN="$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)"
GLAZER_BIN="$(realpath "$GLAZER_BIN")"

compile_story() {
  local source="$1" assembly="$2" output="$3" log_prefix="$4"
  pushd "$source"
  dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$assembly" \
    2>&1 | tee "$BUILD/$log_prefix-zilf-compile.log"
  popd
  python glulx/tools/normalize_serial.py "$assembly" --serial "$SERIAL" \
    --receipt "$BUILD/$log_prefix-SERIAL-NORMALIZATION.json"
  "$GLAZER_BIN" "$assembly" -o "$output" \
    2>&1 | tee "$BUILD/$log_prefix-glazer-assemble.log"
}

STORY="$BUILD/$STORY_FILE"
DEV_STORY="$BUILD/zork1-glulx-narrative-physicality-dev.ulx"
compile_story "$SRC" "$BUILD/narrative-physicality.asm" "$STORY" production
compile_story "$DEV_SRC" "$BUILD/narrative-physicality-dev.asm" "$DEV_STORY" dev
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
python glulx/tools/verify_ulx.py "$DEV_STORY" --json "$BUILD/dev-story-report.json"

make -C .tooling/cheapglk >/dev/null
make -C .tooling/glulxe GLKDIR="$ROOT/.tooling/cheapglk" GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" >/dev/null
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"

cat > "$BUILD/house-abuse.txt" <<'EOF'
look
examine house
touch house
smell house
listen to house
take house
kick house
take rock
throw rock at door
examine door
south
east
look
open window
enter
look
examine table
kick table
west
look
take sword
examine rug
cut rug with sword
examine rug
move rug
east
take sack
cut sack with sword
examine sack
take bottle
put bottle in sack
throw bottle
quit
yes
EOF
timeout 35s "$GLULXE_BIN" --rngseed 1247001 "$STORY" \
  < "$BUILD/house-abuse.txt" > "$BUILD/house-abuse-transcript.txt" 2>&1
OUT="$BUILD/house-abuse-transcript.txt"
grep -F 'large white colonial house' "$OUT"
grep -F 'The house, having foundations and several rooms, wins immediately.' "$OUT"
grep -F 'The house contributes creaks, settling wood, and a silence too large to be reassuring.' "$OUT"
grep -F 'One weathered surface is newly scarred' "$OUT"
grep -F 'fresh dents, cuts, and bruised grain' "$OUT"
grep -F 'interrupted domestic life' "$OUT"
grep -F 'fresh scuff appears low on one leg' "$OUT"
grep -F 'Dust softens the abandoned grandeur' "$OUT"
grep -F 'leaves a ragged edge' "$OUT"
grep -F 'revealing the dusty cover of a closed trap door' "$OUT"
grep -F 'opens a ragged seam in the brown sack' "$OUT"
grep -F 'torn seam makes it a poor container' "$OUT"
grep -F 'Glass snaps outward in a brief glittering spray' "$OUT"
if grep -qF 'I don'"'"'t know the word "house"' "$OUT"; then exit 1; fi
if grep -qF 'I don'"'"'t know the word "rug"' "$OUT"; then exit 1; fi
if grep -qF 'You cannot put a person into an object as though they were inventory.' "$OUT"; then exit 1; fi
if grep -qF 'You cannot throw a person as though they were inventory.' "$OUT"; then exit 1; fi

cat > "$BUILD/broken-window-room.txt" <<'EOF'
take rock
south
east
throw rock at window
look
enter
look
quit
yes
EOF
timeout 25s "$GLULXE_BIN" --rngseed 1247002 "$STORY" \
  < "$BUILD/broken-window-room.txt" > "$BUILD/broken-window-room-transcript.txt" 2>&1
BROKEN="$BUILD/broken-window-room-transcript.txt"
grep -F 'punches through the Kitchen window' "$BROKEN"
grep -F 'small kitchen window is shattered out; jagged remnants frame an opening large enough to use.' "$BROKEN"
grep -F 'small window is shattered out; jagged remnants frame an opening large enough to use.' "$BROKEN"

cat > "$BUILD/dev-reset.txt" <<'EOF'
take rock
throw rock at door
south
east
open window
enter
kick table
west
take sword
cut rug with sword
east
take sack
cut sack with sword
reset damage
west
examine rug
east
examine table
examine sack
quit
yes
EOF
timeout 35s "$GLULXE_BIN" --rngseed 1247003 "$DEV_STORY" \
  < "$BUILD/dev-reset.txt" > "$BUILD/dev-reset-transcript.txt" 2>&1
DEVOUT="$BUILD/dev-reset-transcript.txt"
grep -F 'Developer reset restored the authored environmental breakages' "$DEVOUT"
grep -F 'The oriental rug is thick, old, and extremely heavy.' "$DEVOUT"
grep -F 'The kitchen table is heavy wood, marked by recent food preparation' "$DEVOUT"
grep -F 'The elongated brown sack is thin, flexible paper or fiber' "$DEVOUT"
if grep -qF 'now visibly frayed' "$DEVOUT"; then exit 1; fi
if grep -qF 'now newly gouged' "$DEVOUT"; then exit 1; fi
if grep -qF 'one seam has been cut open' "$DEVOUT"; then exit 1; fi

python - "$STORY" "$DEV_STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); dev=Path(sys.argv[2]); manifest=json.loads(Path(sys.argv[3]).read_text())
report=json.loads(Path('glulx/build/narrative-physicality-1247/story-report.json').read_text())
dev_report=json.loads(Path('glulx/build/narrative-physicality-1247/dev-story-report.json').read_text())
expected=manifest['expected_artifact']
story_sha=hashlib.sha256(story.read_bytes()).hexdigest()
dev_sha=hashlib.sha256(dev.read_bytes()).hexdigest()
assert report['checksum_valid'] is True and dev_report['checksum_valid'] is True
assert expected['locked'] is True
assert expected['file']==story.name
assert expected['version_hex']==report['version_hex']
assert expected['size_bytes']==story.stat().st_size==report['size_bytes']
assert expected['checksum_hex']==report['checksum_hex']
assert expected['sha256']==story_sha==report['sha256']
receipt={
  'release':1247,
  'serial':manifest['serial'],
  'artifact_identity_locked':True,
  'production':{'file':story.name,'size_bytes':story.stat().st_size,'sha256':story_sha,'report':report},
  'dev':{'file':dev.name,'size_bytes':dev.stat().st_size,'sha256':dev_sha,'report':dev_report},
  'qualification':['staging','smell-check','compile','locked-artifact-checksum','House natural-play abuse','Mara canonical PERFORM delegation','persistent damage narration','two-sided broken-window room narration','bounded dev reset']
}
Path('glulx/build/narrative-physicality-1247/QUALIFICATION.json').write_text(json.dumps(receipt,indent=2,sort_keys=True)+'\n')
print(json.dumps(receipt,indent=2,sort_keys=True))
PY

echo "Release 1247 narrative physicality qualification passed."
