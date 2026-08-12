#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/cross-system-utility-mesh-1251"
BUILD="$ROOT/glulx/build/earned-sequence-breaks-route-mastery-1252"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
MANIFEST="$ROOT/glulx/route-mastery/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

# Release 1252 composes directly over the exact qualified Release 1251 trees.
bash glulx/cross-system-utility/qualify.sh
python -m py_compile glulx/route-mastery/stage.py

python - "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import importlib.util,json,sys
from pathlib import Path
manifest=Path(sys.argv[1]); prod=Path(sys.argv[2]); dev=Path(sys.argv[3])
spec=importlib.util.spec_from_file_location('stage1252','glulx/route-mastery/stage.py')
mod=importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
m=json.loads(manifest.read_text())
actual={'production':mod.source_identity(prod),'dev':mod.source_identity(dev)}
expected=m.get('base_source_sha256',{})
for k,v in actual.items():
    assert expected[k] == v, (k,expected[k],v)
PY

python glulx/route-mastery/stage.py \
  --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/route-mastery/stage.py \
  --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"

python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path
b=Path('glulx/build/earned-sequence-breaks-route-mastery-1252')
s=b/'src'; d=b/'dev-src'
stage=json.loads((s/'STAGING-RECEIPT.json').read_text())
dev=json.loads((d/'STAGING-RECEIPT.json').read_text())
smell=json.loads((b/'smell-report.json').read_text())
dev_smell=json.loads((b/'dev-smell-report.json').read_text())
assert stage['release']==1252 and stage['base']['release']==1251
assert stage['base']['artifact_sha256']=='f109db13195574227d0487f732f63f16c4a2d8d48ea9823a15e63becd53791d7'
assert stage['changed_paths']==sorted(['1actions.zil','gsyntax.zil','material_consequences.zil','zork1.zil'])
assert stage['dev_mode'] is False and dev['dev_mode'] is True
assert not smell['errors'] and not dev_smell['errors']
material=(s/'material_consequences.zil').read_text()
actions=(s/'1actions.zil').read_text()
syntax=(s/'gsyntax.zil').read_text()
zork=(s/'zork1.zil').read_text()
assert '<EQUAL? ,PRSI ,LIVING-CANYON-EDGE>' in material
assert '<V-LIVING-SECURE>' in material
assert '<IN? ,ROPE ,LIVING-CANYON-EDGE> ,CLIFF-MIDDLE' in material
assert 'turning the authored climb into a prepared freight route' in material
assert 'The cargo is free, but the rope remains physically secured at the canyon rim above.' in material
assert '<ROUTINE ROUTE-MASTERY-CARRIED? (OBJ "AUX" HOLDER)' in actions
assert '<ROUTE-MASTERY-CARRIED? ,INFLATED-BOAT>' in actions
assert '<SYNONYM DEFLATE FOLD COLLAPSE>' in syntax
assert '<CONSTANT RELEASEID 1252>' in zork
assert 'EARNED SEQUENCE BREAKS AND ROUTE MASTERY GLULX' in zork
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
DEV_STORY="$BUILD/zork1-glulx-earned-route-mastery-dev.ulx"
compile_story "$SRC" "$BUILD/earned-route-mastery.asm" "$STORY" production
compile_story "$DEV_SRC" "$BUILD/earned-route-mastery-dev.asm" "$DEV_STORY" dev
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
python glulx/tools/verify_ulx.py "$DEV_STORY" --json "$BUILD/dev-story-report.json"

GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
cat > "$BUILD/canyon-route-mastery.txt" <<'EOF_PLAY'
south
east
open window
enter
take sack
west
take lamp
turn on lamp
east
up
take rope
down
tie rope to sack
east
east
east
tie rope to canyon rim
examine rope
lower sack
pull rope
lower sack
down
look
untie sack from rope
take sack
up
secure rope
jump
untie rope from canyon rim
quit
yes
EOF_PLAY
timeout 80s "$GLULXE_BIN" --rngseed 1252001 "$STORY" \
  < "$BUILD/canyon-route-mastery.txt" > "$BUILD/canyon-route-mastery-transcript.txt" 2>&1
CANYON="$BUILD/canyon-route-mastery-transcript.txt"
grep -F 'The rope now lies physically on the canyon rim' "$CANYON"
grep -F 'one end is cinched to the brown sack and the other is physically secured at the Great Canyon rim' "$CANYON"
grep -F 'turning the authored climb into a prepared freight route' "$CANYON"
grep -F 'you haul until the brown sack scrapes up from the Rocky Ledge' "$CANYON"
grep -F 'Rocky Ledge' "$CANYON"
grep -F 'The cargo is free, but the rope remains physically secured at the canyon rim above.' "$CANYON"
grep -F 'The rescue was earned by physical preparation' "$CANYON"
grep -F 'You free the rope from the canyon rim and recover the coil.' "$CANYON"

# Natural parser alias coverage: FASTEN must reach the same physical canyon authority,
# not a parallel shortcut path.
cat > "$BUILD/canyon-fasten-route-mastery.txt" <<'EOF_FASTEN'
south
east
open window
enter
take sack
west
take lamp
turn on lamp
east
up
take rope
down
tie rope to sack
east
east
east
fasten rope to rim
examine rope
lower sack
pull rope
lower sack
down
untie sack from rope
take sack
up
jump
untie rope from canyon rim
quit
yes
EOF_FASTEN
timeout 80s "$GLULXE_BIN" --rngseed 1252002 "$STORY" \
  < "$BUILD/canyon-fasten-route-mastery.txt" > "$BUILD/canyon-fasten-route-mastery-transcript.txt" 2>&1
FASTEN="$BUILD/canyon-fasten-route-mastery-transcript.txt"
grep -F 'The rope now lies physically on the canyon rim' "$FASTEN"
grep -F 'one end is cinched to the brown sack and the other is physically secured at the Great Canyon rim' "$FASTEN"
grep -F 'turning the authored climb into a prepared freight route' "$FASTEN"
grep -F 'you haul until the brown sack scrapes up from the Rocky Ledge' "$FASTEN"
grep -F 'The rescue was earned by physical preparation' "$FASTEN"
grep -F 'You free the rope from the canyon rim and recover the coil.' "$FASTEN"

# Natural White Cliffs expedition. This deliberately earns the setup from the House:
# acquire a real portable container, operate the Dam, retrieve the real hand pump,
# exercise FOLD/COLLAPSE against canonical deflation state, then carry an inflated
# boat nested in the coffin to the authored narrow White Cliffs passage.
cat > "$BUILD/white-cliffs-route-mastery.txt" <<'EOF_WHITE'
south
east
open window
enter
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
east
east
se
east
tie rope to railing
down
south
down
take coffin
west
south
pray
east
south
se
enter
west
open trap door
down
north
east
east
north
ne
east
north
north
take wrench
push yellow button
south
south
turn bolt with wrench
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
west
north
north
take pump
south
south
east
down
blow up boat with pump
fold boat
blow up boat with pump
take boat
collapse boat
drop boat
collapse boat
blow up boat with pump
open coffin
take boat
put boat in coffin
up
west
se
down
echo
east
east
south
look
quit
yes
EOF_WHITE
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/white-cliffs-route-mastery.txt" > "$BUILD/white-cliffs-route-mastery-transcript.txt" 2>&1
WHITE="$BUILD/white-cliffs-route-mastery-transcript.txt"
grep -F 'The boat inflates and appears seaworthy.' "$WHITE"
grep -F 'The boat deflates.' "$WHITE"
grep -F 'The boat must be on the ground to be deflated.' "$WHITE"
[[ "$(grep -Fc 'The boat deflates.' "$WHITE")" -ge 2 ]]
[[ "$(grep -Fc 'The boat inflates and appears seaworthy.' "$WHITE")" -ge 3 ]]
grep -F 'White Cliffs Beach' "$WHITE"
grep -F 'The path is too narrow.' "$WHITE"

python - "$STORY" "$DEV_STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); dev=Path(sys.argv[2]); manifest=json.loads(Path(sys.argv[3]).read_text())
b=Path('glulx/build/earned-sequence-breaks-route-mastery-1252')
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
    print('RELEASE_1252_ARTIFACT_IDENTITY='+json.dumps(identity,sort_keys=True))
    raise SystemExit(4)
for key in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    assert expected[key] == identity[key], (key,expected[key],identity[key])
receipt={
  'release':1252,
  'serial':manifest['serial'],
  'artifact_identity_locked':True,
  'production':{**identity,'report':report},
  'dev':{
    'file':dev.name,
    'size_bytes':dev.stat().st_size,
    'sha256':hashlib.sha256(dev.read_bytes()).hexdigest(),
    'report':dev_report,
  },
  'base_release':1251,
  'base_artifact_sha256':manifest['base_artifact_sha256'],
  'canyon_route_mastery':'canyon-route-mastery-transcript.txt',
  'canyon_fasten_route_mastery':'canyon-fasten-route-mastery-transcript.txt',
  'white_cliffs_route_mastery':'white-cliffs-route-mastery-transcript.txt',
}
(b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(receipt,indent=2,sort_keys=True)+'\n')
print(json.dumps(receipt,indent=2,sort_keys=True))
PY

echo "Release 1252 Earned Sequence Breaks & Route Mastery qualified."
