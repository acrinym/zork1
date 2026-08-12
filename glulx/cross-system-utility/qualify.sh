#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/player-ingenuity-systemic-workarounds-1250"
BUILD="$ROOT/glulx/build/cross-system-utility-mesh-1251"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
MANIFEST="$ROOT/glulx/cross-system-utility/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

# Requalify the exact locked Release 1250 lineage first. Release 1251 is a
# composition layer, not a parallel rebuild of predecessor authority.
bash glulx/player-ingenuity/qualify.sh

python -m py_compile glulx/cross-system-utility/stage.py

python - "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import importlib.util,json,sys
from pathlib import Path
manifest=Path(sys.argv[1]); prod=Path(sys.argv[2]); dev=Path(sys.argv[3])
spec=importlib.util.spec_from_file_location('stage1251','glulx/cross-system-utility/stage.py')
mod=importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
m=json.loads(manifest.read_text())
actual={'production':mod.source_identity(prod),'dev':mod.source_identity(dev)}
expected=m.get('base_source_sha256',{})
for k,v in actual.items():
    assert expected[k] == v, (k,expected[k],v)
PY

python glulx/cross-system-utility/stage.py \
  --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/cross-system-utility/stage.py \
  --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"

python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path
b=Path('glulx/build/cross-system-utility-mesh-1251')
s=b/'src'; d=b/'dev-src'; base=Path('glulx/build/player-ingenuity-systemic-workarounds-1250/src')
stage=json.loads((s/'STAGING-RECEIPT.json').read_text())
dev=json.loads((d/'STAGING-RECEIPT.json').read_text())
smell=json.loads((b/'smell-report.json').read_text())
dev_smell=json.loads((b/'dev-smell-report.json').read_text())
assert stage['release']==1251 and stage['base']['release']==1250
assert stage['base']['artifact_sha256']=='d6c2a7b4512d90d388c763943d09e89f5df4b4dc033e96c5e6a30e1de9d2f6d3'
assert stage['changed_paths']==sorted(['material_consequences.zil','zork1.zil'])
assert stage['dev_mode'] is False and dev['dev_mode'] is True
assert not smell['errors'] and not dev_smell['errors']
material=(s/'material_consequences.zil').read_text()
base_material=(base/'material_consequences.zil').read_text()
zork=(s/'zork1.zil').read_text()
assert material.count('<GLOBAL ') == base_material.count('<GLOBAL ')
assert '<ROUTINE UTILITY-MESH-CARGO-TIED? ()' in material
assert '<ROUTINE UTILITY-MESH-LOWER-SACK' in material
assert '<ROUTINE UTILITY-MESH-HAUL-SACK' in material
assert '<ROUTINE UTILITY-MESH-CARGO-SPAN-BLOCK? ()' in material
assert '<EQUAL? ,PRSI ,RAILING> <RFALSE>' in material
assert '<AND <UTILITY-MESH-CARGO-TIED?> ,DOME-FLAG>' in material
assert 'The closed grating leaves no opening for the sack.' in material
assert 'Hand over hand, you haul the brown sack up the chimney.' in material
assert 'ten feet below' in material
assert 'one end is cinched to the brown sack and the other is secured to the Dome Room railing' in material
assert '<CONSTANT RELEASEID 1251>' in zork
assert 'CROSS-SYSTEM UTILITY MESH GLULX' in zork
PY

IFS=$'\t' read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text())
print('\t'.join((m['serial'],m['expected_artifact']['file'])))
PY
)

GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)"
GLULX_ZILF_DLL="$(realpath "$GLULX_ZILF_DLL")"
GLAZER_BIN="$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)"
GLAZER_BIN="$(realpath "$GLAZER_BIN")"

compile_story() {
  local source="$1" assembly="$2" output="$3" prefix="$4"
  pushd "$source"
  dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$assembly" \
    2>&1 | tee "$BUILD/$prefix-zilf-compile.log"
  popd
  python glulx/tools/normalize_serial.py "$assembly" --serial "$SERIAL" \
    --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"
  "$GLAZER_BIN" "$assembly" -o "$output" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"
}

STORY="$BUILD/$STORY_FILE"
DEV_STORY="$BUILD/zork1-glulx-cross-system-utility-mesh-dev.ulx"
compile_story "$SRC" "$BUILD/cross-system-utility.asm" "$STORY" production
compile_story "$DEV_SRC" "$BUILD/cross-system-utility-dev.asm" "$DEV_STORY" dev
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
python glulx/tools/verify_ulx.py "$DEV_STORY" --json "$BUILD/dev-story-report.json"

GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"

cat > "$BUILD/tree-chimney.txt" <<'EOF_PLAY'
south
east
open window
enter
take sack
west
take lantern
turn on lantern
east
up
take rope
take earmuffs
down
open sack
put earmuffs in sack
east
north
north
tie rope to sack
drop sack
up
north
pull rope
lower sack
down
untie sack from rope
take sack
south
se
west
west
move rug
open trap door
down
south
east
north
tie rope to sack
drop sack
up
pull rope
lower sack
pull rope
untie sack from rope
quit
yes
EOF_PLAY
timeout 70s "$GLULXE_BIN" --rngseed 1251001 "$STORY" \
  < "$BUILD/tree-chimney.txt" > "$BUILD/tree-chimney-transcript.txt" 2>&1 || true
TREE="$BUILD/tree-chimney-transcript.txt"
grep -F 'The rope draws taut toward the brown sack at the other end of the vertical run.' "$TREE"
grep -F 'You haul steadily on the rope until the brown sack rises from the path' "$TREE"
grep -F 'lower it to the forest path ten feet below' "$TREE"
grep -F 'Hand over hand, you haul the brown sack up the chimney.' "$TREE"
grep -F 'You pay out rope through the chimney.' "$TREE"
grep -F 'without ever becoming another package on your body.' "$TREE"

cat > "$BUILD/dome-mesh.txt" <<'EOF_DOME'
south
east
open window
enter
take sack
west
take lantern
turn on lantern
take sword
east
up
take rope
take earmuffs
down
open sack
put earmuffs in sack
west
move rug
open trap door
down
north
attack troll with sword
attack troll with sword
attack troll with sword
east
east
se
east
tie rope to sack
tie rope to railing
examine rope
lower sack
down
look
untie sack from rope
quit
yes
EOF_DOME
timeout 70s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/dome-mesh.txt" > "$BUILD/dome-mesh-transcript.txt" 2>&1 || true
DOME="$BUILD/dome-mesh-transcript.txt"
grep -F 'The rope drops over the side and comes within ten feet of the floor.' "$DOME"
grep -F 'one end is cinched to the brown sack and the other is secured to the Dome Room railing' "$DOME"
grep -F "you lower the brown sack over the dome's edge until it reaches the Torch Room below" "$DOME"
grep -F 'Torch Room' "$DOME"
grep -F 'You undo the knot around the brown sack. The rope is fully available again.' "$DOME"

cat > "$BUILD/grate-mesh.txt" <<'EOF_GRATE'
south
east
open window
enter
take sack
west
take lantern
turn on lantern
take sword
east
up
take rope
down
west
move rug
open trap door
down
north
attack troll with sword
attack troll with sword
attack troll with sword
west
south
east
up
take key
sw
up
east
up
ne
unlock grate with key
open grate
tie rope to sack
drop sack
up
pull rope
close grate
lower sack
open grate
lower sack
down
untie sack from rope
quit
yes
EOF_GRATE
timeout 80s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/grate-mesh.txt" > "$BUILD/grate-mesh-transcript.txt" 2>&1 || true
GRATE="$BUILD/grate-mesh-transcript.txt"
grep -F 'The grate is unlocked.' "$GRATE"
grep -F 'The rope tightens, the brown sack rises through the open grating' "$GRATE"
grep -F 'The closed grating leaves no opening for the sack.' "$GRATE"
grep -F 'You feed the brown sack through the open grating and lower it into the chamber below' "$GRATE"
grep -F 'You undo the knot around the brown sack. The rope is fully available again.' "$GRATE"

python - "$STORY" "$DEV_STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); dev=Path(sys.argv[2]); manifest=json.loads(Path(sys.argv[3]).read_text())
b=Path('glulx/build/cross-system-utility-mesh-1251')
report=json.loads((b/'story-report.json').read_text()); dev_report=json.loads((b/'dev-story-report.json').read_text())
identity={
  'file':story.name,
  'format':'Glulx',
  'version_hex':report['version_hex'],
  'size_bytes':story.stat().st_size,
  'checksum_hex':report['checksum_hex'],
  'sha256':hashlib.sha256(story.read_bytes()).hexdigest(),
}
assert report['checksum_valid'] is True and dev_report['checksum_valid'] is True
expected=manifest['expected_artifact']
if expected.get('locked') is not True:
    print('RELEASE_1251_ARTIFACT_IDENTITY='+json.dumps(identity,sort_keys=True))
    raise SystemExit(4)
for key in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    assert expected[key] == identity[key], (key,expected[key],identity[key])
receipt={
  'release':1251,
  'serial':manifest['serial'],
  'artifact_identity_locked':True,
  'production':{**identity,'report':report},
  'dev':{
    'file':dev.name,
    'size_bytes':dev.stat().st_size,
    'sha256':hashlib.sha256(dev.read_bytes()).hexdigest(),
    'report':dev_report,
  },
  'base_release':1250,
  'base_artifact_sha256':manifest['base_artifact_sha256'],
  'tree_chimney':'tree-chimney-transcript.txt',
  'dome_mesh':'dome-mesh-transcript.txt',
  'grate_mesh':'grate-mesh-transcript.txt',
}
(b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(receipt,indent=2,sort_keys=True)+'\n')
print(json.dumps(receipt,indent=2,sort_keys=True))
PY

echo "Release 1251 Cross-System Utility Mesh qualified."
