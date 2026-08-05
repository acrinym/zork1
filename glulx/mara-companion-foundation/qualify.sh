#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/mara-companion-foundation"
SRC="$BUILD/src"
MANIFEST="$ROOT/glulx/mara-companion-foundation/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

IFS=$'\t' read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY_META'
import json, sys
from pathlib import Path
m = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
print('\t'.join((m['serial'], m['expected_artifact']['file'])))
PY_META
)

python -m unittest discover -s tests -p 'test_mara_companion_foundation.py' -v
python -m py_compile glulx/mara-companion-foundation/stage.py tests/test_mara_companion_foundation.py
python glulx/mara-companion-foundation/stage.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path
s = Path('glulx/build/mara-companion-foundation/src')
stage = json.loads((s / 'STAGING-RECEIPT.json').read_text(encoding='utf-8'))
smell = json.loads(Path('glulx/build/mara-companion-foundation/smell-report.json').read_text(encoding='utf-8'))
assert stage['base']['release'] == 1242
assert stage['base']['artifact_sha256'] == '1e6b61f68a32289e6085e784493518f0662083907390bdba900557548a53f173'
assert stage['changed_paths'] == sorted([
    'dam_mechanisms.zil', 'gverbs.zil', 'mara_companion.zil',
    'mara_companion_state.zil', 'mara_companion_movement.zil',
    'mara_companion_actions.zil', 'mara_companion_actor.zil',
    'museum_ecology_dam_fishing.zil', 'shadow_logic.zil', 'zork1.zil'
])
assert not smell['errors']
module = '\n'.join(path.read_text(encoding='utf-8') for path in sorted(s.glob('mara_companion*.zil')))
for token in (
    '<OBJECT MARA\n    (IN DAM-BASE)',
    '<ROUTINE MARA-AFTER-PLAYER-MOVE (FROM TO)',
    '<ROUTINE MARA-DAM-AFTER-BOLT (BEFORE)',
    '<ROUTINE MARA-DAM-AFTER-BUTTON (BUTTON BEFORE)',
    '<ROUTINE V-MARA-SURVEY ()',
    '<MOVE ,MARA-DAM-SURVEY-SHEET ,MARA>',
    '<MOVE ,MARA ,DAM-LOBBY>',
    'The boundary is calm and complete.',
):
    assert token in module
assert '<MARA-ADVANCE>' in (s / 'shadow_logic.zil').read_text(encoding='utf-8')
assert '<MARA-AFTER-PLAYER-MOVE .OHERE .RM>' in (s / 'gverbs.zil').read_text(encoding='utf-8')
assert '<MARA-DAM-AFTER-BOLT .BEFORE>' in (s / 'dam_mechanisms.zil').read_text(encoding='utf-8')
assert '<MARA-WITNESS-FISH .VARIETY>' in (s / 'museum_ecology_dam_fishing.zil').read_text(encoding='utf-8')
production = '\n'.join(p.read_text(encoding='utf-8', errors='ignore') for p in s.glob('*.zil'))
for forbidden in ('MARATELEPORT', 'MARAAPPROVAL', 'MARAROMANCE', 'MARAGODMODE', 'MARAQUESTLOG'):
    assert forbidden not in production
PY_STATIC

GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit 2>/dev/null || true)"
if [[ -z "$GLULX_ZILF_DLL" ]]; then
  pushd .tooling/zilf-glulx
  dotnet restore Zilf.sln --nologo 2>&1 | tee "$BUILD/zilf-restore.log"
  dotnet build Zilf.sln --configuration Release --property:PortableTarget=true --no-restore --nologo \
    2>&1 | tee "$BUILD/zilf-build.log"
  popd
  GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)"
fi
GLULX_ZILF_DLL="$(realpath "$GLULX_ZILF_DLL")"
GLAZER_BIN="$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)"
GLAZER_BIN="$(realpath "$GLAZER_BIN")"
ASSEMBLY="$BUILD/mara-companion-foundation.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" \
  2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" --serial "$SERIAL" \
  --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$STORY_FILE" 2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/$STORY_FILE" --json "$BUILD/story-report.json"

make -C .tooling/cheapglk 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C .tooling/glulxe GLKDIR="$ROOT/.tooling/cheapglk" \
  GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" 2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"

cat > "$BUILD/mara-commands.txt" <<'EOF_COMMANDS'
south
east
open window
enter
west
take lantern
take sword
take fishing rod
take field jar
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
north
ne
east
down
look
talk to mara
ask mara about survey
mara, follow me
up
examine control panel
north
north
take wrench
take tube
open tube
take putty
mara, push yellow button
mara, follow me
south
south
mara, brace control panel
turn bolt with wrench
survey control panel with mara
thank mara
thank mara
mara, wait
north
south
mara, follow me
ask mara about company
kiss mara
north
north
mara, push blue button
push blue button
south
apologize to mara
north
use putty on leak
south
apologize to mara
mara, follow me
south
down
fish
release silverfin
ask mara about waters
ask mara about museum
quit
yes
EOF_COMMANDS
"$GLULXE_BIN" --rngseed 123456 "$BUILD/$STORY_FILE" < "$BUILD/mara-commands.txt" \
  2>&1 | tee "$BUILD/mara-transcript.txt"

grep -F 'Mara Tallow is here with a waxed survey book' "$BUILD/mara-transcript.txt"
grep -F 'I am reconstructing the Last Honest Survey of the Great Underground Empire' "$BUILD/mara-transcript.txt"
grep -F 'As far as the Dam survey takes us' "$BUILD/mara-transcript.txt"
grep -F 'Mara plants one boot against the stone curb and braces the control panel' "$BUILD/mara-transcript.txt"
grep -F 'Mara keeps both hands against the shuddering panel while the bolt turns' "$BUILD/mara-transcript.txt"
grep -F 'The first shared entry in the Last Honest Survey now exists as a physical document' "$BUILD/mara-transcript.txt"
grep -F 'Repetition does not turn gratitude into currency' "$BUILD/mara-transcript.txt"
grep -F 'I will wait here, she says, not everywhere and not forever' "$BUILD/mara-transcript.txt"
grep -F 'For the routes we have actually agreed to share, yes' "$BUILD/mara-transcript.txt"
grep -F 'The boundary is calm and complete' "$BUILD/mara-transcript.txt"
grep -F 'you may not issue it as hers' "$BUILD/mara-transcript.txt"
grep -F 'do not call the result unforeseeable' "$BUILD/mara-transcript.txt"
grep -F 'She retreats to the lobby' "$BUILD/mara-transcript.txt"
grep -F 'An apology that leaves the water running is merely another sound in the room' "$BUILD/mara-transcript.txt"
grep -F 'Repair first; interpretation afterward' "$BUILD/mara-transcript.txt"
grep -F 'That is a beginning, she says' "$BUILD/mara-transcript.txt"
grep -F 'Evidence observed, animal alive, custody closed' "$BUILD/mara-transcript.txt"
grep -F 'she is not its curator' "$BUILD/mara-transcript.txt"

python - <<'PY_TRANSCRIPT'
from pathlib import Path
t = Path('glulx/build/mara-companion-foundation/mara-transcript.txt').read_text(encoding='utf-8')
assert 'Release 1243 / Serial number 260805' in t
assert 'Mara sits near the museum displays' not in t
assert t.count('The first shared entry in the Last Honest Survey now exists as a physical document') == 1
assert t.index('Repetition does not turn gratitude into currency') < t.index('I will wait here, she says, not everywhere and not forever')
assert t.index('I will wait here, she says, not everywhere and not forever') < t.index('For the routes we have actually agreed to share, yes')
assert t.index('do not call the result unforeseeable') < t.index('She retreats to the lobby')
assert t.index('An apology that leaves the water running') < t.index('That is a beginning, she says')
assert t.index('narrow silver fish comes up fighting') < t.index('Evidence observed, animal alive, custody closed')
for word in ('mara', 'brace', 'survey', 'thank', 'apologize'):
    assert f'I don\'t know the word "{word}"' not in t
assert 'You may know how to do that, but I don\'t.' not in t
assert "You're nuts!" not in t
PY_TRANSCRIPT

python - "$SERIAL" "$MANIFEST" <<'PY_RECEIPT'
import json, sys
from pathlib import Path
serial, manifest_path = sys.argv[1:]
manifest = json.loads(Path(manifest_path).read_text(encoding='utf-8'))
expected = manifest['expected_artifact']
story = json.loads(Path('glulx/build/mara-companion-foundation/story-report.json').read_text(encoding='utf-8'))
assert story['format'] == expected['format']
assert story['version_hex'] == expected['version_hex']
assert story['checksum_valid'] is True
if expected.get('locked', False):
    assert story['size_bytes'] == expected['size_bytes']
    assert story['checksum_hex'] == expected['checksum_hex']
    assert story['sha256'] == expected['sha256']
receipt = {
    'release': 1243,
    'serial': serial,
    'artifact': story,
    'artifact_identity_locked': expected.get('locked', False),
    'gameplay': {
        'dam_first_presence': 'passed',
        'last_honest_survey_goal': 'passed',
        'direct_address_follow_wait': 'passed',
        'physical_authored_movement': 'passed',
        'joint_canonical_gate_cycle': 'passed',
        'physical_joint_survey_sheet': 'passed',
        'non_grindable_gratitude': 'passed',
        'warning_refusal_retreat': 'passed',
        'repair_and_specific_apology': 'passed',
        'witnessed_silverfin_release': 'passed',
        'consent_boundary': 'passed'
    },
    'generic_follower_framework': False,
    'party_system': False,
    'approval_meter': False,
    'dating_simulator': False,
    'omniscient_knowledge': False,
    'canonical_puzzle_bypass': False
}
Path('glulx/build/mara-companion-foundation/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n', encoding='utf-8'
)
PY_RECEIPT
cat "$BUILD/story-report.json"
