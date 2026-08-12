#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/earned-sequence-breaks-route-mastery-1252"
BUILD="$ROOT/glulx/build/dam-survival-prepared-rescue-1253"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
MANIFEST="$ROOT/glulx/dam-survival/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

# Release 1253 composes over the exact qualified Release 1252 production/dev trees.
bash glulx/route-mastery/qualify.sh
python -m py_compile glulx/dam-survival/stage.py

python - "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import importlib.util,json,sys
from pathlib import Path
manifest=Path(sys.argv[1]); prod=Path(sys.argv[2]); dev=Path(sys.argv[3])
spec=importlib.util.spec_from_file_location('stage1253','glulx/dam-survival/stage.py')
mod=importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
m=json.loads(manifest.read_text())
actual={'production':mod.source_identity(prod),'dev':mod.source_identity(dev)}
expected=m.get('base_source_sha256',{})
for k,v in actual.items():
    assert expected[k] == v, (k,expected[k],v)
PY

python glulx/dam-survival/stage.py \
  --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/dam-survival/stage.py \
  --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"

python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path
b=Path('glulx/build/dam-survival-prepared-rescue-1253')
s=b/'src'; d=b/'dev-src'
stage=json.loads((s/'STAGING-RECEIPT.json').read_text())
dev=json.loads((d/'STAGING-RECEIPT.json').read_text())
smell=json.loads((b/'smell-report.json').read_text())
dev_smell=json.loads((b/'dev-smell-report.json').read_text())
assert stage['release']==1253 and stage['base']['release']==1252
assert stage['base']['artifact_sha256']=='b376808be57262d3cec9c43d9bd2e8972e64362864bbe6a9bab682a0cc3334b6'
assert stage['changed_paths']==sorted(['1actions.zil','1dungeon.zil','material_consequences.zil','shadow_logic.zil','zork1.zil'])
assert stage['dev_mode'] is False and dev['dev_mode'] is True
assert not smell['errors'] and not dev_smell['errors']
actions=(s/'1actions.zil').read_text()
dungeon=(s/'1dungeon.zil').read_text()
material=(s/'material_consequences.zil').read_text()
shadow=(s/'shadow_logic.zil').read_text()
zork=(s/'zork1.zil').read_text()
assert '<OBJECT DAM-MAINTENANCE-LADDER' in dungeon
assert '(GLOBAL GLOBAL-WATER RIVER DAM-MAINTENANCE-LADDER)>' in dungeon
assert '<ROUTINE DAM-SURVIVAL-LADDER-MOVE' in actions
assert '<ROUTINE DAM-SURVIVAL-WATER-ENTRY' in actions
assert '<* <WEIGHT ,WINNER> 2>' in actions
assert '<EQUAL? ,MATERIAL-ROPE-ANCHOR ,DAM-MAINTENANCE-LADDER>' in actions
assert 'The river below completes the lesson in prepared rescue.' in actions
assert ',LIVING-CANYON-EDGE ,DAM-MAINTENANCE-LADDER>>' in material
assert '(<SHADOW-BLOCKED-BY-ROPE?> <RTRUE>)\n\t      (<DAM-SURVIVAL-HOOK> <RTRUE>)' in shadow
assert '<CONSTANT RELEASEID 1253>' in zork
assert 'DAM SURVIVAL AND PREPARED RESCUE GLULX' in zork
assert 'DAM-SURVIVAL-GATES' not in actions
assert 'DAM-SURVIVAL-WATER-LEVEL' not in actions
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
DEV_STORY="$BUILD/zork1-glulx-dam-survival-prepared-rescue-dev.ulx"
compile_story "$SRC" "$BUILD/dam-survival.asm" "$STORY" production
compile_story "$DEV_SRC" "$BUILD/dam-survival-dev.asm" "$DEV_STORY" dev
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
python glulx/tools/verify_ulx.py "$DEV_STORY" --json "$BUILD/dev-story-report.json"

GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
# Reuse the already-qualified Release 1252 natural-play troll seed, but take the
# direct Round Room -> North-South Passage -> Deep Canyon route so the real rope
# remains in hand for the dam instead of being consumed by the Dome descent.
DAM_APPROACH=$(cat <<'EOF_ROUTE'
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
north
ne
east
EOF_ROUTE
)

{
  printf '%s\n' "$DAM_APPROACH"
  cat <<'EOF_LOSS'
look
examine ladder
climb down ladder
take sword
climb ladder
quit
yes
EOF_LOSS
} > "$BUILD/dam-overflow-gear-loss.txt"
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/dam-overflow-gear-loss.txt" > "$BUILD/dam-overflow-gear-loss-transcript.txt" 2>&1
LOSS="$BUILD/dam-overflow-gear-loss-transcript.txt"
grep -F 'Overflow keeps the lower rungs wet. A heavy load could turn one slip into lost gear.' "$LOSS"
grep -F 'The sword tears free and clatters onto the landing below, where it can be recovered.' "$LOSS"
grep -F 'Taken.' "$LOSS"
grep -F 'You climb the iron maintenance ladder' "$LOSS"

{
  printf '%s\n' "$DAM_APPROACH"
  cat <<'EOF_FATAL'
north
north
take wrench
push yellow button
south
south
turn bolt with wrench
examine ladder
climb down ladder
quit
yes
EOF_FATAL
} > "$BUILD/dam-open-sluice-unprepared.txt"
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/dam-open-sluice-unprepared.txt" > "$BUILD/dam-open-sluice-unprepared-transcript.txt" 2>&1
FATAL="$BUILD/dam-open-sluice-unprepared-transcript.txt"
grep -F 'Sluice discharge throws spray across the lower rungs. A heavy descent without a fixed handline would be reckless.' "$FATAL"
grep -F 'With no anchored handline and too much weight committed to the descent, your grip goes with your footing.' "$FATAL"
grep -F 'The river below completes the lesson in prepared rescue.' "$FATAL"

{
  printf '%s\n' "$DAM_APPROACH"
  cat <<'EOF_RESCUE'
north
north
take wrench
push yellow button
south
south
turn bolt with wrench
tie rope to ladder
examine ladder
climb down ladder
look
swim
examine rope
untie rope from ladder
quit
yes
EOF_RESCUE
} > "$BUILD/dam-prepared-rescue.txt"
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$STORY" \
  < "$BUILD/dam-prepared-rescue.txt" > "$BUILD/dam-prepared-rescue-transcript.txt" 2>&1
RESCUE="$BUILD/dam-prepared-rescue-transcript.txt"
grep -F 'You tie one end of the rope securely to the maintenance ladder.' "$RESCUE"
grep -F 'One end of your rope is tied securely to the ladder, leaving the coil as a prepared handline.' "$RESCUE"
grep -F 'the anchored handline checks the slip before the dam can turn it into a fall.' "$RESCUE"
grep -F 'Dam Base' "$RESCUE"
grep -F 'the maintenance-ladder knot holds.' "$RESCUE"
grep -F 'You undo the knot around the maintenance ladder. The rope is fully available again.' "$RESCUE"

python - "$STORY" "$DEV_STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); dev=Path(sys.argv[2]); manifest=json.loads(Path(sys.argv[3]).read_text())
b=Path('glulx/build/dam-survival-prepared-rescue-1253')
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
    print('RELEASE_1253_ARTIFACT_IDENTITY='+json.dumps(identity,sort_keys=True))
    raise SystemExit(4)
for key in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    assert expected[key] == identity[key], (key,expected[key],identity[key])
receipt={
  'release':1253,
  'serial':manifest['serial'],
  'artifact_identity_locked':True,
  'production':{**identity,'report':report},
  'dev':{
    'file':dev.name,
    'size_bytes':dev.stat().st_size,
    'sha256':hashlib.sha256(dev.read_bytes()).hexdigest(),
    'report':dev_report,
  },
  'base_release':1252,
  'base_artifact_sha256':manifest['base_artifact_sha256'],
  'overflow_gear_loss':'dam-overflow-gear-loss-transcript.txt',
  'open_sluice_unprepared':'dam-open-sluice-unprepared-transcript.txt',
  'prepared_rescue':'dam-prepared-rescue-transcript.txt',
}
(b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(receipt,indent=2,sort_keys=True)+'\n')
print(json.dumps(receipt,indent=2,sort_keys=True))
PY

echo "Release 1253 Dam Survival & Prepared Rescue qualified."
