#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/forest-consequences-1248"
BASE_1245="$BUILD/base-1245-src"
BASE_1246="$BUILD/base-1246-src"
BASE_1246_DEV="$BUILD/base-1246-dev-src"
BASE_1247="$BUILD/base-1247-src"
BASE_1247_DEV="$BUILD/base-1247-dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
MANIFEST="$ROOT/glulx/forest-consequences/patch-series.json"
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

python -m py_compile glulx/forest-consequences/stage.py
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
  --destination "$BASE_1247" \
  --manifest glulx/narrative-physicality/patch-series.json
python glulx/narrative-physicality/stage.py \
  --base-source "$BASE_1246_DEV" \
  --destination "$BASE_1247_DEV" \
  --manifest glulx/narrative-physicality/patch-series.json
python glulx/forest-consequences/stage.py \
  --base-source "$BASE_1247" \
  --destination "$SRC" \
  --manifest "$MANIFEST"
python glulx/forest-consequences/stage.py \
  --base-source "$BASE_1247_DEV" \
  --destination "$DEV_SRC" \
  --manifest "$MANIFEST"

python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path
build=Path('glulx/build/forest-consequences-1248')
s=build/'src'
d=build/'dev-src'
b=build/'base-1247-src'
stage=json.loads((s/'STAGING-RECEIPT.json').read_text())
dev=json.loads((d/'STAGING-RECEIPT.json').read_text())
smell=json.loads((build/'smell-report.json').read_text())
dev_smell=json.loads((build/'dev-smell-report.json').read_text())
assert stage['release']==1248 and stage['base']['release']==1247
assert stage['base']['artifact_sha256']=='71def5651d7f956016f769abd9b007f1b88f12eb2935d2510e75122f46ad8cb5'
assert stage['changed_paths']==sorted(['1actions.zil','1dungeon.zil','material_consequences.zil','zork1.zil'])
assert stage['dev_mode'] is False and dev['dev_mode'] is True
assert not smell['errors'] and not dev_smell['errors']
material=(s/'material_consequences.zil').read_text()
base_material=(b/'material_consequences.zil').read_text()
actions=(s/'1actions.zil').read_text()
dungeon=(s/'1dungeon.zil').read_text()
zork=(s/'zork1.zil').read_text()
assert material.count('<GLOBAL ') == base_material.count('<GLOBAL ')
assert '<ROUTINE FOREST-CONSEQUENCE-HOOK ("AUX" DEST)' in material
assert '<ROUTINE FOREST-SACK-IMPACT (DEST' in material
assert '<ROUTINE NARRATIVE-SPILL-SACK-CONTENTS-TO (DEST' in material
assert '<FOREST-CONSEQUENCE-HOOK> <RTRUE>' in material
assert ',WOODEN-DOOR ,SANDWICH-BAG ,TREE>>' in material
assert '<VERB? SHADOW-USE-ON TIE>' in material
assert '<FSET? ,TREE ,RMUNGBIT>' in material
assert '<FCLEAR ,TREE ,RMUNGBIT>' in material
assert 'Ten feet of gravity turns an ordinary container into a compact argument about momentum.' in material
assert 'canonical broken version of itself' in material
assert 'one particularly large tree claims the edge of the path' in dungeon
assert 'ten feet above the Forest Path' in actions
assert 'That was several feet farther down than wisdom suggested.' in actions
assert 'falling view' in dungeon
assert '<CONSTANT RELEASEID 1248>' in zork
assert 'FOREST CONSEQUENCE PHYSICALITY GLULX' in zork
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
DEV_STORY="$BUILD/zork1-glulx-forest-consequences-dev.ulx"
compile_story "$SRC" "$BUILD/forest-consequences.asm" "$STORY" production
compile_story "$DEV_SRC" "$BUILD/forest-consequences-dev.asm" "$DEV_STORY" dev
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
python glulx/tools/verify_ulx.py "$DEV_STORY" --json "$BUILD/dev-story-report.json"

make -C .tooling/cheapglk >/dev/null
make -C .tooling/glulxe GLKDIR="$ROOT/.tooling/cheapglk" GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" >/dev/null
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"

cat > "$BUILD/sack-bottle-tree.txt" <<'EOF'
south
east
open window
enter
take sack
open sack
take lunch
take bottle
put bottle in sack
close sack
east
north
north
look
throw sack at tree
open sack
look in sack
quit
yes
EOF
timeout 35s "$GLULXE_BIN" --rngseed 1248001 "$STORY" \
  < "$BUILD/sack-bottle-tree.txt" > "$BUILD/sack-bottle-tree-transcript.txt" 2>&1
BOTTLE_OUT="$BUILD/sack-bottle-tree-transcript.txt"
grep -F 'one particularly large tree claims the edge of the path' "$BOTTLE_OUT"
grep -F 'loaded brown sack strikes the trunk with a heavy, fabric-muted thump' "$BOTTLE_OUT"
grep -F 'unmistakable crack of breaking glass' "$BOTTLE_OUT"
grep -F 'The sack lands with whatever survived the impact still inside.' "$BOTTLE_OUT"
if grep -qF 'Glass snaps outward in a brief glittering spray; the bottle is finished.' "$BOTTLE_OUT"; then
  echo "contained bottle incorrectly escaped to canonical bare-bottle throw narration" >&2
  exit 1
fi

cat > "$BUILD/open-sack-stone.txt" <<'EOF'
take rock
south
east
open window
enter
take sack
open sack
take lunch
take garlic
put rock in sack
east
north
north
throw sack at tree
look
look in sack
quit
yes
EOF
timeout 35s "$GLULXE_BIN" --rngseed 1248002 "$STORY" \
  < "$BUILD/open-sack-stone.txt" > "$BUILD/open-sack-stone-transcript.txt" 2>&1
STONE_OUT="$BUILD/open-sack-stone-transcript.txt"
grep -F 'loaded brown sack strikes the trunk with a heavy, fabric-muted thump' "$STONE_OUT"
grep -F "The sack's open geometry declines to remain theoretical" "$STONE_OUT"
grep -F 'fist-sized loose stone' "$STONE_OUT"

cat > "$BUILD/sack-egg-height.txt" <<'EOF'
south
east
open window
enter
take sack
open sack
take lunch
take garlic
east
north
north
up
take egg
put egg in sack
close sack
drop sack
down
open sack
look in sack
quit
yes
EOF
timeout 35s "$GLULXE_BIN" --rngseed 1248003 "$STORY" \
  < "$BUILD/sack-egg-height.txt" > "$BUILD/sack-egg-height-transcript.txt" 2>&1
EGG_OUT="$BUILD/sack-egg-height-transcript.txt"
grep -F 'Ten feet of gravity turns an ordinary container into a compact argument about momentum.' "$EGG_OUT"
grep -F 'canonical broken version of itself' "$EGG_OUT"
grep -F 'broken jewel-encrusted egg' "$EGG_OUT"

cat > "$BUILD/tree-scar-death.txt" <<'EOF'
south
east
open window
enter
west
take sword
east
east
north
north
examine tree
cut tree with sword
examine tree
up
jump
quit
EOF
timeout 35s "$GLULXE_BIN" --rngseed 1248004 "$STORY" \
  < "$BUILD/tree-scar-death.txt" > "$BUILD/tree-scar-death-transcript.txt" 2>&1 || true
TREE_OUT="$BUILD/tree-scar-death-transcript.txt"
grep -F 'bites through bark and raises a pale wound' "$TREE_OUT"
grep -F 'carries a fresh scar through its bark' "$TREE_OUT"
grep -F 'For one astonished instant the forest opens beneath you' "$TREE_OUT"
grep -F '****  You have died  ****' "$TREE_OUT"

cat > "$BUILD/dev-tree-reset.txt" <<'EOF'
south
east
open window
enter
west
take sword
east
east
north
north
cut tree with sword
reset damage
examine tree
quit
yes
EOF
timeout 35s "$GLULXE_BIN" --rngseed 1248005 "$DEV_STORY" \
  < "$BUILD/dev-tree-reset.txt" > "$BUILD/dev-tree-reset-transcript.txt" 2>&1
DEV_OUT="$BUILD/dev-tree-reset-transcript.txt"
grep -F 'Developer reset restored the authored environmental breakages' "$DEV_OUT"
grep -F 'The tree is old enough to have acquired weight' "$DEV_OUT"
if grep -qF 'carries a fresh scar through its bark' "$DEV_OUT"; then
  echo "dev reset left the Forest Path tree scarred" >&2
  exit 1
fi

python - "$STORY" "$DEV_STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1])
dev=Path(sys.argv[2])
manifest=json.loads(Path(sys.argv[3]).read_text())
report=json.loads(Path('glulx/build/forest-consequences-1248/story-report.json').read_text())
dev_report=json.loads(Path('glulx/build/forest-consequences-1248/dev-story-report.json').read_text())
expected=manifest['expected_artifact']
story_sha=hashlib.sha256(story.read_bytes()).hexdigest()
dev_sha=hashlib.sha256(dev.read_bytes()).hexdigest()
assert report['checksum_valid'] is True and dev_report['checksum_valid'] is True
identity={
  'file':story.name,
  'format':'Glulx',
  'version_hex':report['version_hex'],
  'size_bytes':story.stat().st_size,
  'checksum_hex':report['checksum_hex'],
  'sha256':story_sha,
}
if expected.get('locked') is True:
    assert expected['file']==identity['file']
    assert expected['version_hex']==identity['version_hex']
    assert expected['size_bytes']==identity['size_bytes']
    assert expected['checksum_hex']==identity['checksum_hex']
    assert expected['sha256']==identity['sha256']
else:
    print('BOOTSTRAP_ARTIFACT_IDENTITY=' + json.dumps(identity,sort_keys=True))
receipt={
  'release':1248,
  'serial':manifest['serial'],
  'artifact_identity_locked':expected.get('locked') is True,
  'production':{**identity,'report':report},
  'dev':{
    'file':dev.name,
    'size_bytes':dev.stat().st_size,
    'sha256':dev_sha,
    'report':dev_report,
  },
  'qualification':[
    'staging',
    'no-new-globals',
    'smell-check',
    'compile',
    'Glulx-checksum',
    'closed sack plus contained bottle tree impact',
    'open sack plus field-stone impact spill',
    'sack plus canonical egg height consequence',
    'persistent tree scar plus canonical JIGS-UP death',
    'bounded dev tree-scar reset',
  ],
}
Path('glulx/build/forest-consequences-1248/QUALIFICATION.json').write_text(
    json.dumps(receipt,indent=2,sort_keys=True)+'\n'
)
print(json.dumps(receipt,indent=2,sort_keys=True))
PY

echo "Release 1248 Forest Consequence Physicality qualification passed."
