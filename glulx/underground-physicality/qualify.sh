#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/underground-sensory-physicality-1249"
BASE_1245="$BUILD/base-1245-src"
BASE_1246="$BUILD/base-1246-src"
BASE_1246_DEV="$BUILD/base-1246-dev-src"
BASE_1247="$BUILD/base-1247-src"
BASE_1247_DEV="$BUILD/base-1247-dev-src"
BASE_1248="$BUILD/base-1248-src"
BASE_1248_DEV="$BUILD/base-1248-dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
MANIFEST="$ROOT/glulx/underground-physicality/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

IFS=$'\t' read -r SERIAL STORY_FILE LOCKED < <(python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text())
print('\t'.join((m['serial'],m['expected_artifact']['file'],str(m['expected_artifact'].get('locked',False)).lower())))
PY
)

python -m py_compile glulx/underground-physicality/stage.py
python glulx/creative-natural-play/stage.py \
  --upstream .upstream/zork1-glulx \
  --destination "$BASE_1245" \
  --allowed-root "$BUILD" \
  --manifest glulx/creative-natural-play/patch-series.json
python glulx/environmental-destruction/stage.py \
  --base-source "$BASE_1245" --destination "$BASE_1246" \
  --manifest glulx/environmental-destruction/patch-series.json
python glulx/environmental-destruction/stage.py \
  --base-source "$BASE_1245" --destination "$BASE_1246_DEV" \
  --manifest glulx/environmental-destruction/patch-series.json --dev
python glulx/narrative-physicality/stage.py \
  --base-source "$BASE_1246" --destination "$BASE_1247" \
  --manifest glulx/narrative-physicality/patch-series.json
python glulx/narrative-physicality/stage.py \
  --base-source "$BASE_1246_DEV" --destination "$BASE_1247_DEV" \
  --manifest glulx/narrative-physicality/patch-series.json
python glulx/forest-consequences/stage.py \
  --base-source "$BASE_1247" --destination "$BASE_1248" \
  --manifest glulx/forest-consequences/patch-series.json
python glulx/forest-consequences/stage.py \
  --base-source "$BASE_1247_DEV" --destination "$BASE_1248_DEV" \
  --manifest glulx/forest-consequences/patch-series.json
python glulx/underground-physicality/stage.py \
  --base-source "$BASE_1248" --destination "$SRC" --manifest "$MANIFEST"
python glulx/underground-physicality/stage.py \
  --base-source "$BASE_1248_DEV" --destination "$DEV_SRC" --manifest "$MANIFEST"

python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path
build=Path('glulx/build/underground-sensory-physicality-1249')
s=build/'src'; d=build/'dev-src'; b=build/'base-1248-src'
stage=json.loads((s/'STAGING-RECEIPT.json').read_text())
dev=json.loads((d/'STAGING-RECEIPT.json').read_text())
smell=json.loads((build/'smell-report.json').read_text())
dev_smell=json.loads((build/'dev-smell-report.json').read_text())
assert stage['release']==1249 and stage['base']['release']==1248
assert stage['base']['artifact_sha256']=='efd06838a2196144435643f636ec7cafe712fca2ea07089c08c998464ac93d56'
assert stage['changed_paths']==sorted(['1actions.zil','1dungeon.zil','material_consequences.zil','zork1.zil'])
assert stage['dev_mode'] is False and dev['dev_mode'] is True
assert not smell['errors'] and not dev_smell['errors']
material=(s/'material_consequences.zil').read_text()
base_material=(b/'material_consequences.zil').read_text()
actions=(s/'1actions.zil').read_text()
dungeon=(s/'1dungeon.zil').read_text()
zork=(s/'zork1.zil').read_text()
assert material.count('<GLOBAL ') == base_material.count('<GLOBAL ')
assert '<ROUTINE UNDERGROUND-PHYSICALITY-HOOK ()' in material
assert '<UNDERGROUND-PHYSICALITY-HOOK> <RTRUE>' in material
assert '<FSET ,HERE ,RMUNGBIT>' not in material
assert '<FSET? ,EW-PASSAGE ,RMUNGBIT>' not in material
assert '<FCLEAR ,EW-PASSAGE ,RMUNGBIT>' not in material
assert '<CONSTANT MD-UNDERGROUND-EW-PASSAGE-SCAR 2>' in material
assert '<CONSTANT MATERIAL-UNDERGROUND-SCAR-STATE <TABLE <> <> <> <> <> <> <> <> <>>>' in material
assert '<PUT ,MATERIAL-UNDERGROUND-SCAR-STATE ,MD-UNDERGROUND-CHASM-SCAR <>>' in material
assert '<NOT <EQUAL? ,PRSO ,BOTTLE ,EGG ,LAMP>>>' in material
assert 'The cellar masonry is cool, damp, and load-bearing' in material
assert 'The rushing roar occupies the room completely.' in material
assert 'The Troll Room is small enough that the stone feels close around you.' in dungeon
assert '(GLOBAL TRAP-DOOR SLIDE STAIRS WHITE-HOUSE WALL)' in dungeon
assert '(GLOBAL CRACK STAIRS WALL)' in dungeon
assert 'There is no downward route here; the chasm edge simply falls away into darkness.' in dungeon
assert 'Hard walls rise on every side, giving the room exactly the architecture an echo would have ordered.' in actions
assert 'The near edge gives you no usable landing line' in actions
assert '<CONSTANT RELEASEID 1249>' in zork
assert 'UNDERGROUND SENSORY PHYSICALITY GLULX' in zork
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
DEV_STORY="$BUILD/zork1-glulx-underground-sensory-physicality-dev.ulx"
compile_story "$SRC" "$BUILD/underground-physicality.asm" "$STORY" production
compile_story "$DEV_SRC" "$BUILD/underground-physicality-dev.asm" "$DEV_STORY" dev
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
python glulx/tools/verify_ulx.py "$DEV_STORY" --json "$BUILD/dev-story-report.json"

make -C .tooling/cheapglk >/dev/null
make -C .tooling/glulxe GLKDIR="$ROOT/.tooling/cheapglk" GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" >/dev/null
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"

cat > "$BUILD/underground-natural.txt" <<'EOF_PLAY'
take rock
south
east
open window
enter
west
take lantern
take sword
move rug
open trap door
turn on lantern
down
look
smell air
listen to air
examine wall
throw rock at wall
examine wall
take rock
north
attack troll with sword
attack troll with sword
attack troll with sword
look
smell air
listen to wall
east
look
examine stairs
smell air
listen to air
throw rock at wall
take rock
east
look
smell air
listen to air
east
echo
look
listen to air
smell air
examine stairs
east
look
smell air
listen to crack
west
west
west
down
look
smell air
listen to air
examine crack
throw rock off chasm
down
quit
yes
EOF_PLAY
timeout 55s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/underground-natural.txt" > "$BUILD/underground-natural-transcript.txt" 2>&1 || true
OUT="$BUILD/underground-natural-transcript.txt"
grep -F 'dark, damp cellar where cool masonry holds the day' "$OUT"
grep -F 'With the trap door shut, the cross-draft belongs entirely to the underground passages.' "$OUT"
grep -F 'The cellar masonry is cool, damp, and load-bearing' "$OUT"
grep -F 'strikes stone with a hard report' "$OUT"
grep -F 'Fresh pale chips and a new score interrupt the older surface.' "$OUT"
grep -F 'The unconscious troll cannot defend himself: He dies.' "$OUT"
grep -F 'Stone, old iron, stale air' "$OUT"
grep -F 'A narrow passage runs east and west between close rough walls.' "$OUT"
grep -F 'The narrow stone stair descends from the north end of the passage toward the chasm.' "$OUT"
grep -F 'The narrow passage smells mostly of cool stone and settled grit.' "$OUT"
grep -F 'This circular chamber is shaped from stone' "$OUT"
grep -F 'Dry stone dust hangs faintly in the round room' "$OUT"
grep -F 'The acoustics of the room change subtly.' "$OUT"
grep -F 'The famous acoustics are still here, but the room is eerily subdued' "$OUT"
grep -F 'This low cave opens east and west and pinches southward into a narrow crack.' "$OUT"
grep -F 'A faint draft whispers at the crack' "$OUT"
grep -F 'A dark chasm cuts southwest to northeast' "$OUT"
grep -F 'clears the edge, falls cleanly into darkness, and is lost to sight' "$OUT"
grep -F 'There is no downward route here; the chasm edge simply falls away into darkness.' "$OUT"
if grep -qF 'Which wall do you mean' "$OUT"; then
  echo "Release 1249 left plain WALL ambiguous in its authored underground circuit" >&2
  exit 1
fi
if grep -qF 'Are you out of your mind?' "$OUT"; then
  echo "Release 1249 regressed to player-psychological chasm narration" >&2
  exit 1
fi

cat > "$BUILD/canonical-fragile.txt" <<'EOF_FRAGILE'
south
east
open window
enter
take bottle
west
take lantern
move rug
open trap door
turn on lantern
down
throw bottle at wall
quit
yes
EOF_FRAGILE
timeout 35s "$GLULXE_BIN" --rngseed 1249002 "$STORY" \
  < "$BUILD/canonical-fragile.txt" > "$BUILD/canonical-fragile-transcript.txt" 2>&1
FRAGILE="$BUILD/canonical-fragile-transcript.txt"
grep -F 'The bottle hits the far wall and shatters.' "$FRAGILE" || grep -F 'Glass snaps outward in a brief glittering spray; the bottle is finished.' "$FRAGILE"
if grep -qF 'Which wall do you mean' "$FRAGILE"; then
  echo "plain WALL remained ambiguous for canonical fragile projectiles" >&2
  exit 1
fi
if grep -qF 'remains an object rather than a geological event' "$FRAGILE"; then
  echo "generic underground projectile handling stole canonical bottle authority" >&2
  exit 1
fi

cat > "$BUILD/dev-underground-reset.txt" <<'EOF_DEV'
take rock
south
east
open window
enter
west
take lantern
move rug
open trap door
turn on lantern
down
throw rock at wall
examine wall
reset damage
examine wall
quit
yes
EOF_DEV
timeout 35s "$GLULXE_BIN" --rngseed 1249003 "$DEV_STORY" \
  < "$BUILD/dev-underground-reset.txt" > "$BUILD/dev-underground-reset-transcript.txt" 2>&1
DEV_OUT="$BUILD/dev-underground-reset-transcript.txt"
grep -F 'Fresh pale chips and a new score interrupt the older surface.' "$DEV_OUT"
grep -F 'Developer reset restored the authored environmental breakages' "$DEV_OUT"
grep -F 'The cellar masonry is cool, damp, and load-bearing' "$DEV_OUT"
if grep -qF 'Which wall do you mean' "$DEV_OUT"; then
  echo "dev/test Release 1249 left plain WALL ambiguous" >&2
  exit 1
fi
python - "$DEV_OUT" <<'PY'
from pathlib import Path
import sys
t=Path(sys.argv[1]).read_text()
reset=t.index('Developer reset restored the authored environmental breakages')
after=t[reset:]
assert 'Fresh pale chips and a new score interrupt the older surface.' not in after
PY

python - "$STORY" "$DEV_STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); dev=Path(sys.argv[2]); manifest=json.loads(Path(sys.argv[3]).read_text())
build=Path('glulx/build/underground-sensory-physicality-1249')
report=json.loads((build/'story-report.json').read_text())
dev_report=json.loads((build/'dev-story-report.json').read_text())
expected=manifest['expected_artifact']
story_sha=hashlib.sha256(story.read_bytes()).hexdigest(); dev_sha=hashlib.sha256(dev.read_bytes()).hexdigest()
assert report['checksum_valid'] is True and dev_report['checksum_valid'] is True
identity={'file':story.name,'format':'Glulx','version_hex':report['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':report['checksum_hex'],'sha256':story_sha}
if expected.get('locked') is True:
    for key in ('file','version_hex','size_bytes','checksum_hex','sha256'):
        assert expected[key]==identity[key], (key,expected[key],identity[key])
else:
    print('BOOTSTRAP_ARTIFACT_IDENTITY=' + json.dumps(identity,sort_keys=True))
receipt={
  'release':1249,
  'serial':manifest['serial'],
  'artifact_identity_locked':expected.get('locked') is True,
  'production':{**identity,'report':report},
  'dev':{'file':dev.name,'size_bytes':dev.stat().st_size,'sha256':dev_sha,'report':dev_report},
  'qualification':['exact Release 1248 source provenance','no-new-globals','smell-check','compile','Glulx-checksum','natural early-GUE sensory and wall physicality','plain WALL parser resolution in authored underground rooms','underground cosmetic scar state isolated from canonical room movement flags','canonical troll gate and Loud Room ECHO','canonical chasm object-loss authority','canonical bottle delegation','bounded dev underground-scar reset'],
}
(build/'QUALIFICATION.json').write_text(json.dumps(receipt,indent=2,sort_keys=True)+'\n')
print(json.dumps(receipt,indent=2,sort_keys=True))
PY

echo "Release 1249 Underground Sensory Physicality qualification passed."
