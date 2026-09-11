#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-earned-romance-1306"
BUILD="$ROOT/glulx/build/time-weather-disaster-1307"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/time-weather-disaster/patch-series.json"
cd "$ROOT"

# Inherit the exact green Release 1306 product before adding environmental authority.
bash glulx/mara-earned-romance/qualify.sh
rm -rf "$BUILD"
mkdir -p "$BUILD"
python -m py_compile glulx/time-weather-disaster/stage.py
python glulx/time-weather-disaster/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/time-weather-disaster/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path

def req(cond, msg):
    if not cond:
        raise SystemExit(msg)

b = Path('glulx/build/time-weather-disaster-1307')
s = b / 'src'
m = json.loads(Path('glulx/time-weather-disaster/patch-series.json').read_text())
r = json.loads((s / 'STAGING-RECEIPT.json').read_text())
req(r['release'] == 1307 and r['base']['release'] == 1306, 'Release 1307 staging mismatch')
req(r['changed_paths'] == sorted(m['expected_changed_paths']), 'Release 1307 changed paths mismatch')
req(not json.loads((b / 'smell-report.json').read_text())['errors'], '1307 production smell errors')
req(not json.loads((b / 'dev-smell-report.json').read_text())['errors'], '1307 dev smell errors')
z = (s / 'zork1.zil').read_text()
shadow = (s / 'shadow_logic.zil').read_text()
weather = (s / 'weather_disaster.zil').read_text()
req('<CONSTANT RELEASEID 1307>' in z, '1307 identity missing')
req('<INSERT-FILE "weather_disaster" T>' in z, 'weather authority include missing')
req(shadow.count('<WEATHER-DISASTER-ADVANCE>') == 1, 'weather turn hook missing or duplicated')
req('<GLOBAL ' not in weather, 'Release 1307 must not add weather globals')
req('<TABLE 0 0 0 0>' in weather, 'Release 1307 compact weather state table missing')
for bad in ('RANDOM', 'PROB', 'PERCENT', 'CLIMATE', 'FORECAST-ENGINE'):
    req(bad not in weather, 'procedural/random weather machinery leaked into Release 1307: ' + bad)
for fact in ('GATES-OPEN', 'CANYON-VIEW', 'CANYON-BOTTOM', 'DAM-ROOM', 'DAM-BASE', 'FOREST-ROOM?'):
    req(fact in weather, 'Release 1307 is not composed over required world fact: ' + fact)
prod = '\n'.join(p.read_text(errors='ignore') for p in s.glob('*.zil'))
for cheat in ('WXCANYON', 'WXDAMOPEN', 'WXDAMCLOSED', 'WXLOW', 'WXBASE'):
    req(cheat not in prod, 'production test-helper leak: ' + cheat)
PY

read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY'
import json, sys
from pathlib import Path
m = json.loads(Path(sys.argv[1]).read_text())
print(m['serial'], m['expected_artifact']['file'])
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
compile_story "$SRC" "$BUILD/release1307.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"
cp -a "$SRC" "$TEST_SRC"
cp glulx/time-weather-disaster/tests/weather_disaster_test.zil "$TEST_SRC/weather_disaster_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(Path('glulx/time-weather-disaster/tests/001-include-weather-test.json').resolve(), Path('glulx/build/time-weather-disaster-1307/test-src').resolve())
PY
compile_story "$TEST_SRC" "$BUILD/release1307-test.asm" "$BUILD/release1307-test.ulx" test

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
    make -C "$ROOT/.tooling/cheapglk"
    make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

# Fair-weather production route: ordinary opening play must stay ordinary.
cat > "$BUILD/fair-weather.txt" <<'EOF'
look
examine sky
north
examine weather
south
look
quit
yes
EOF
timeout 120s "$GLULXE" --rngseed 123456 "$STORY" < "$BUILD/fair-weather.txt" > "$BUILD/fair-weather-transcript.txt" 2>&1
F="$BUILD/fair-weather-transcript.txt"
grep -F 'West of House' "$F"
grep -F 'Release 1307' "$F"
grep -F 'weather is fair enough to be background rather than a puzzle' "$F"
if grep -Fq 'dark shelf is forming over the canyon country' "$F"; then
    echo '1307 storm armed during canonical opening play' >&2
    cat "$F" >&2
    exit 1
fi

# Canyon arc: retain a carried object, move a real loose object, and leave aftermath persistent.
{
    echo wxcanyon
    echo 'examine sky'
    echo 'take bottle'
    for _ in $(seq 1 13); do echo wait; done
    echo 'examine sky'
    echo inventory
    echo wxlow
    echo 'examine sack'
    echo inventory
    echo quit
    echo yes
} > "$BUILD/canyon-weather.txt"
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$BUILD/release1307-test.ulx" < "$BUILD/canyon-weather.txt" > "$BUILD/canyon-weather-transcript.txt" 2>&1
C="$BUILD/canyon-weather-transcript.txt"
dump_canyon(){ echo '--- canyon weather test ---' >&2; cat "$C" >&2; }
grep -F 'dark shelf is forming over the canyon country' "$C" || { dump_canyon; exit 1; }
grep -F 'enough warning to pick up anything you do not want weather to decide for you' "$C" || { dump_canyon; exit 1; }
grep -F 'The storm arrives without randomness or ceremony' "$C" || { dump_canyon; exit 1; }
grep -F 'Runoff gets under the brown sack before you do' "$C" || { dump_canyon; exit 1; }
grep -F 'The hard rain breaks apart' "$C" || { dump_canyon; exit 1; }
grep -F 'brown sack' "$C" || { dump_canyon; exit 1; }
grep -F 'glass bottle' "$C" || grep -F 'bottle' "$C" || { dump_canyon; exit 1; }

# Open sluices: canonical GATES-OPEN state mitigates the dam-top sweep.
{
    echo wxdamopen
    for _ in $(seq 1 10); do echo wait; done
    echo 'examine bottle'
    echo 'examine sky'
    echo quit
    echo yes
} > "$BUILD/dam-open-weather.txt"
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$BUILD/release1307-test.ulx" < "$BUILD/dam-open-weather.txt" > "$BUILD/dam-open-weather-transcript.txt" 2>&1
O="$BUILD/dam-open-weather-transcript.txt"
dump_open(){ echo '--- dam open weather test ---' >&2; cat "$O" >&2; }
grep -F 'sluice gates are already open' "$O" || { dump_open; exit 1; }
grep -F 'controlled roar' "$O" || { dump_open; exit 1; }
grep -F 'bottle' "$O" || { dump_open; exit 1; }
if grep -Fq 'disappears toward lower ground' "$O"; then
    echo 'open sluices incorrectly swept a dam-top object' >&2
    dump_open
    exit 1
fi

# Closed sluices: the same storm can move the same real loose objects to recoverable Dam Base.
{
    echo wxdamclosed
    for _ in $(seq 1 10); do echo wait; done
    echo wxbase
    echo 'examine bottle'
    echo 'examine sack'
    echo quit
    echo yes
} > "$BUILD/dam-closed-weather.txt"
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$BUILD/release1307-test.ulx" < "$BUILD/dam-closed-weather.txt" > "$BUILD/dam-closed-weather-transcript.txt" 2>&1
D="$BUILD/dam-closed-weather-transcript.txt"
dump_closed(){ echo '--- dam closed weather test ---' >&2; cat "$D" >&2; }
grep -F 'sluice gates shut' "$D" || { dump_closed; exit 1; }
grep -F 'disappears toward lower ground' "$D" || { dump_closed; exit 1; }
grep -F 'Dam Base' "$D" || { dump_closed; exit 1; }
grep -F 'bottle' "$D" || { dump_closed; exit 1; }
grep -F 'brown sack' "$D" || { dump_closed; exit 1; }

python - "$STORY" "$MANIFEST" <<'PY'
import hashlib, json, sys
from pathlib import Path
story = Path(sys.argv[1])
m = json.loads(Path(sys.argv[2]).read_text())
b = Path('glulx/build/time-weather-disaster-1307')
r = json.loads((b / 'story-report.json').read_text())
ident = {
    'file': story.name,
    'format': 'Glulx',
    'version_hex': r['version_hex'],
    'size_bytes': story.stat().st_size,
    'checksum_hex': r['checksum_hex'],
    'sha256': hashlib.sha256(story.read_bytes()).hexdigest(),
}
print('RELEASE_1307_ARTIFACT_IDENTITY=' + json.dumps(ident, sort_keys=True))
(b / 'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident, indent=2, sort_keys=True) + '\n')
e = m['expected_artifact']
receipt = {
    'release': 1307,
    'serial': m['serial'],
    'base_release': 1306,
    'histories': ['fair-weather', 'canyon-weather', 'dam-open-weather', 'dam-closed-weather'],
    'inherited_release_1306_qualification': True,
}
if e.get('locked') is not True:
    receipt.update({'artifact_identity_locked': False, 'candidate': ident})
    (b / 'QUALIFICATION-RECEIPT.json').write_text(json.dumps(receipt, indent=2, sort_keys=True) + '\n')
    raise SystemExit('Release 1307 candidate completed product gameplay; lock exact artifact identity and rerun.')
for key in ('file', 'version_hex', 'size_bytes', 'checksum_hex', 'sha256'):
    if ident.get(key) != e.get(key):
        raise SystemExit(f'Release 1307 artifact drift for {key}')
receipt.update({'artifact_identity_locked': True, 'artifact': ident})
(b / 'QUALIFICATION-RECEIPT.json').write_text(json.dumps(receipt, indent=2, sort_keys=True) + '\n')
PY

echo 'Release 1307 authored time, weather, and disaster qualification passed.'
