#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/underground-sensory-physicality-1249"
BUILD="$ROOT/glulx/build/player-ingenuity-systemic-workarounds-1250"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
MANIFEST="$ROOT/glulx/player-ingenuity/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

# Requalify the exact locked Release 1249 source/artifact lineage first. This
# deliberately reuses its existing authority instead of rebuilding a parallel
# predecessor pipeline inside Release 1250.
bash glulx/underground-physicality/qualify.sh

python -m py_compile glulx/player-ingenuity/stage.py

python - "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import importlib.util,json,sys
from pathlib import Path
manifest=Path(sys.argv[1]); prod=Path(sys.argv[2]); dev=Path(sys.argv[3])
spec=importlib.util.spec_from_file_location('stage1250','glulx/player-ingenuity/stage.py')
mod=importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
m=json.loads(manifest.read_text())
actual={'production':mod.source_identity(prod),'dev':mod.source_identity(dev)}
expected=m.get('base_source_sha256',{})
for k,v in actual.items():
    assert expected[k] == v, (k,expected[k],v)
PY

python glulx/player-ingenuity/stage.py \
  --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/player-ingenuity/stage.py \
  --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"

python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path
b=Path('glulx/build/player-ingenuity-systemic-workarounds-1250')
s=b/'src'; d=b/'dev-src'; base=Path('glulx/build/underground-sensory-physicality-1249/src')
stage=json.loads((s/'STAGING-RECEIPT.json').read_text())
dev=json.loads((d/'STAGING-RECEIPT.json').read_text())
smell=json.loads((b/'smell-report.json').read_text())
dev_smell=json.loads((b/'dev-smell-report.json').read_text())
assert stage['release']==1250 and stage['base']['release']==1249
assert stage['base']['artifact_sha256']=='b36d4a17ab9682af64c94263fee317065aeacf9072d24cdc9392016ecd32a7a6'
assert stage['changed_paths']==sorted(['1actions.zil','gverbs.zil','material_consequences.zil','zork1.zil'])
assert stage['dev_mode'] is False and dev['dev_mode'] is True
assert not smell['errors'] and not dev_smell['errors']
material=(s/'material_consequences.zil').read_text()
base_material=(base/'material_consequences.zil').read_text()
actions=(s/'1actions.zil').read_text(); verbs=(s/'gverbs.zil').read_text(); zork=(s/'zork1.zil').read_text()
assert material.count('<GLOBAL ') == base_material.count('<GLOBAL ')
assert '<OBJECT EARMUFFS' in material
assert '(IN ATTIC)' in material
assert '<ROUTINE PLAYER-INGENUITY-EARMUFFS-WORN? ()' in material
assert '<ROUTINE PLAYER-INGENUITY-WEDGE-TRAP-DOOR ()' in material
assert '<ROUTINE PLAYER-INGENUITY-SACK-BUNDLED? ()' in material
assert '<PLAYER-INGENUITY-HOOK> <RTRUE>' in material
assert '(ACTION PLAYER-INGENUITY-FIELD-STONE-F)' in material
assert '<PLAYER-INGENUITY-WEDGE-TRAP-DOOR>' in verbs
assert 'You lift the hearing protectors away from your ears.' in verbs
assert '<ROUTINE PLAYER-INGENUITY-LOUD-ECHO-SOLVE ()' in actions
assert 'The battered hearing protectors take the murderous edge off it' in actions
assert 'strikes the field-stone wedge' in actions
assert 'Bundling the smaller gear inside the brown sack' in actions
assert '<CONSTANT RELEASEID 1250>' in zork
assert 'PLAYER INGENUITY SYSTEMIC WORKAROUNDS GLULX' in zork
PY

IFS=$'\t' read -r SERIAL STORY_FILE LOCKED < <(python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text())
print('\t'.join((m['serial'],m['expected_artifact']['file'],str(m['expected_artifact'].get('locked',False)).lower())))
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
DEV_STORY="$BUILD/zork1-glulx-player-ingenuity-systemic-workarounds-dev.ulx"
compile_story "$SRC" "$BUILD/player-ingenuity.asm" "$STORY" production
compile_story "$DEV_SRC" "$BUILD/player-ingenuity-dev.asm" "$DEV_STORY" dev
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
python glulx/tools/verify_ulx.py "$DEV_STORY" --json "$BUILD/dev-story-report.json"

GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"

cat > "$BUILD/ingenuity-natural.txt" <<'EOF_PLAY'
take rock
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
take earmuffs
wear earmuffs
down
remove earmuffs
open sack
put earmuffs in sack
west
move rug
open trap door
put rock under trap door
down
up
down
south
east
north
up
take earmuffs from sack
wear earmuffs
west
take sword
down
north
attack troll with sword
attack troll with sword
attack troll with sword
east
east
east
look
listen to air
echo
look
up
listen to air
remove earmuffs
listen to air
quit
yes
EOF_PLAY
timeout 70s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/ingenuity-natural.txt" > "$BUILD/ingenuity-natural-transcript.txt" 2>&1 || true
OUT="$BUILD/ingenuity-natural-transcript.txt"
grep -F 'battered pair of industrial hearing protectors' "$OUT"
grep -F 'You settle the battered cups over your ears.' "$OUT"
grep -F 'the door can no longer fall flush with the floor' "$OUT"
grep -F 'strikes the field-stone wedge with a solid knock' "$OUT"
grep -F 'The stair back to the Living Room is still usable.' "$OUT"
grep -F 'Bundling the smaller gear inside the brown sack keeps the chimney problem to two manageable packages.' "$OUT"
grep -F 'The rushing sound presses hard against the hearing protectors' "$OUT"
grep -F 'The padded cups turn the room' "$OUT"
grep -F 'The acoustics of the room change subtly.' "$OUT"
grep -F 'The earmuffs blunt the canyon' "$OUT" || grep -F 'most quiet detail is flattened into a padded murmur' "$OUT"
grep -F 'You lift the hearing protectors away from your ears.' "$OUT"
grep -F 'Flowing water can be heard below' "$OUT" || grep -F 'Water roars below' "$OUT"

cat > "$BUILD/wedge-reversible.txt" <<'EOF_WEDGE'
take rock
south
east
open window
enter
west
move rug
open trap door
put rock under trap door
take rock
down
quit
yes
EOF_WEDGE
timeout 35s "$GLULXE_BIN" --rngseed 1250002 "$STORY" \
  < "$BUILD/wedge-reversible.txt" > "$BUILD/wedge-reversible-transcript.txt" 2>&1 || true
WEDGE="$BUILD/wedge-reversible-transcript.txt"
grep -F 'You pull the field stone out from under the trap door.' "$WEDGE"
grep -F 'The trap door crashes shut, and you hear someone barring it.' "$WEDGE"

cat > "$BUILD/canonical-echo.txt" <<'EOF_ECHO'
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
north
attack troll with sword
attack troll with sword
attack troll with sword
east
east
east
echo
look
quit
yes
EOF_ECHO
timeout 55s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/canonical-echo.txt" > "$BUILD/canonical-echo-transcript.txt" 2>&1 || true
ECHO="$BUILD/canonical-echo-transcript.txt"
grep -F 'The acoustics of the room change subtly.' "$ECHO"
grep -F 'The room is eerie in its quietness.' "$ECHO"

python - "$STORY" "$DEV_STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); dev=Path(sys.argv[2]); manifest=json.loads(Path(sys.argv[3]).read_text())
b=Path('glulx/build/player-ingenuity-systemic-workarounds-1250')
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
    print('RELEASE_1250_ARTIFACT_IDENTITY='+json.dumps(identity,sort_keys=True))
    raise SystemExit(4)
for key in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    assert expected[key] == identity[key], (key,expected[key],identity[key])
receipt={
  'release':1250,
  'serial':manifest['serial'],
  'artifact_identity_locked':True,
  'production':{**identity,'report':report},
  'dev':{
    'file':dev.name,
    'size_bytes':dev.stat().st_size,
    'sha256':hashlib.sha256(dev.read_bytes()).hexdigest(),
    'report':dev_report,
  },
  'base_release':1249,
  'base_artifact_sha256':manifest['base_artifact_sha256'],
  'natural_play':'ingenuity-natural-transcript.txt',
  'canonical_echo':'canonical-echo-transcript.txt',
  'wedge_reversible':'wedge-reversible-transcript.txt',
}
(b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(receipt,indent=2,sort_keys=True)+'\n')
print(json.dumps(receipt,indent=2,sort_keys=True))
PY

echo "Release 1250 Player Ingenuity / Systemic Workarounds qualified."
