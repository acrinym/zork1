#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/mara-house-company"
SRC="$BUILD/src"
MANIFEST="$ROOT/glulx/mara-house-company/patch-series.json"
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
python -m unittest discover -s tests -p 'test_mara_house_company.py' -v
python -m unittest discover -s tests -p 'test_mara_house_threshold.py' -v
python -m py_compile \
  glulx/mara-house-company/stage.py \
  tests/test_mara_house_company.py \
  tests/test_mara_house_threshold.py

python glulx/mara-house-company/stage.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path
s = Path('glulx/build/mara-house-company/src')
stage = json.loads((s / 'STAGING-RECEIPT.json').read_text(encoding='utf-8'))
smell = json.loads(Path('glulx/build/mara-house-company/smell-report.json').read_text(encoding='utf-8'))
assert stage['base']['release'] == 1243
assert stage['base']['artifact_sha256'] == '8d3f4bf555ba15be82d4d4e849c1501fa61bb3f57630f0a4e91061e89560d629'
assert stage['changed_paths'] == sorted([
    'house_cellar_threshold.zil', 'mara_companion.zil',
    'mara_companion_actions.zil', 'mara_companion_actor.zil',
    'mara_companion_state.zil', 'zork1.zil'
])
assert not smell['errors']
module = '\n'.join(path.read_text(encoding='utf-8') for path in sorted(s.glob('mara_companion*.zil')))
threshold = (s / 'house_cellar_threshold.zil').read_text(encoding='utf-8')
for token in (
    '<CONSTANT MARA-SCHEMA 3>',
    '<CONSTANT MARA-PREVIOUS-SCHEMA 2>',
    '<ROUTINE V-MARA-UNBAR-THRESHOLD ()',
    '<FSET ,TRAP-DOOR ,OPENBIT>',
    '<FSET ,TRAP-DOOR ,TOUCHBIT>',
    '<ROUTINE V-MARA-INVITE-STAY ()',
    '<ROUTINE MARA-PACK-CAMP ()',
    '<MOVE ,MARA-FIELD-PACK ,MARA>',
    '<MOVE ,MARA-FIELD-PACK ,ATTIC>',
    '<ROUTINE V-MARA-SHARE-MEAL',
    '<REMOVE ,LUNCH>',
    'That is friendship with weight in the world',
):
    assert token in module
assert 'TRAPDOOR DOOR HATCH' in threshold
assert threshold.count('<OBJECT CELLAR-THRESHOLD') == 1
production = '\n'.join(p.read_text(encoding='utf-8', errors='ignore') for p in s.glob('*.zil'))
for forbidden in ('MARATELEPORT', 'MARAAPPROVAL', 'MARAROMANCE', 'MARAQUESTLOG', 'MARADEBUG'):
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
ASSEMBLY="$BUILD/mara-house-company.asm"
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

cat > "$BUILD/house-company-commands.txt" <<'EOF_COMMANDS'
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
mara, push yellow button
mara, follow me
south
south
mara, brace control panel
turn bolt with wrench
survey control panel with mara
south
sw
south
west
west
south
examine threshold
unbar trap door with mara
up
ask mara about house
invite mara
down
north
east
east
north
ne
east
down
mara, take pack
examine mara
mara, follow me
up
south
sw
south
west
west
south
up
east
up
invite mara
examine mara
mara, follow me
down
take sack
open sack
take lunch
put lunch on worktop
prepare lunch
share lunch with mara
ask mara about company
ask mara about house
kiss mara
share lunch with mara
quit
yes
EOF_COMMANDS
"$GLULXE_BIN" --rngseed 123456 "$BUILD/$STORY_FILE" < "$BUILD/house-company-commands.txt" \
  2>&1 | tee "$BUILD/house-company-transcript.txt"

grep -F 'The trap door crashes shut, and you hear someone barring it.' "$BUILD/house-company-transcript.txt"
grep -F 'The first shared entry in the Last Honest Survey now exists as a physical document' "$BUILD/house-company-transcript.txt"
grep -F 'Mara uncoils her own measured rope' "$BUILD/house-company-transcript.txt"
grep -F 'The same trap door that locked behind you now stands open above the same stair' "$BUILD/house-company-transcript.txt"
grep -F 'So this is the base, she says.' "$BUILD/house-company-transcript.txt"
grep -F 'my field pack is still at the Dam' "$BUILD/house-company-transcript.txt"
grep -F 'Nothing changes custody: the pack was hers at the Dam and is hers on the road' "$BUILD/house-company-transcript.txt"
grep -F 'Her waxed field pack is on her own shoulder.' "$BUILD/house-company-transcript.txt"
grep -F 'For now, the House contains one more actual life.' "$BUILD/house-company-transcript.txt"
grep -F 'Her field pack remains in the Attic where she chose to set it down.' "$BUILD/house-company-transcript.txt"
grep -F 'one physical meal becomes two eaten portions' "$BUILD/house-company-transcript.txt"
grep -F 'That is friendship with weight in the world.' "$BUILD/house-company-transcript.txt"
grep -F 'not permission to skip the history that has not happened yet' "$BUILD/house-company-transcript.txt"
grep -F 'Repeating a social command cannot recreate the consumed lunch.' "$BUILD/house-company-transcript.txt"

python - <<'PY_TRANSCRIPT'
from pathlib import Path
t = Path('glulx/build/mara-house-company/house-company-transcript.txt').read_text(encoding='utf-8')
assert 'Release 1244 / Serial number 260810' in t
assert t.index('The trap door crashes shut, and you hear someone barring it.') < t.index('Mara uncoils her own measured rope')
assert t.index('Mara uncoils her own measured rope') < t.index('So this is the base, she says.')
assert t.index('my field pack is still at the Dam') < t.index('Nothing changes custody: the pack was hers at the Dam and is hers on the road')
assert t.index('Nothing changes custody: the pack was hers at the Dam and is hers on the road') < t.index('For now, the House contains one more actual life.')
assert t.index('For now, the House contains one more actual life.') < t.index('one physical meal becomes two eaten portions')
assert t.count('one physical meal becomes two eaten portions') == 1
for word in ('mara', 'invite', 'share', 'unbar'):
    assert f'I don\'t know the word "{word}"' not in t
assert 'You may know how to do that, but I don\'t.' not in t
PY_TRANSCRIPT

python - "$SERIAL" "$MANIFEST" <<'PY_RECEIPT'
import json, sys
from pathlib import Path
serial, manifest_path = sys.argv[1:]
manifest = json.loads(Path(manifest_path).read_text(encoding='utf-8'))
expected = manifest['expected_artifact']
story = json.loads(Path('glulx/build/mara-house-company/story-report.json').read_text(encoding='utf-8'))
assert story['format'] == expected['format']
assert story['version_hex'] == expected['version_hex']
assert story['checksum_valid'] is True
if expected.get('locked', False):
    assert story['size_bytes'] == expected['size_bytes']
    assert story['checksum_hex'] == expected['checksum_hex']
    assert story['sha256'] == expected['sha256']
receipt = {
    'release': 1244,
    'serial': serial,
    'artifact': story,
    'artifact_identity_locked': expected.get('locked', False),
    'gameplay': {
        'canonical_first_descent_bar_preserved': 'passed',
        'joint_dam_history_required': 'passed',
        'mara_rope_two_person_unbar': 'passed',
        'real_trap_door_reopened': 'passed',
        'physical_house_arrival': 'passed',
        'invitation_requires_existing_camp': 'passed',
        'physical_dam_return': 'passed',
        'mara_exact_pack_custody': 'passed',
        'attic_residence_by_consent': 'passed',
        'single_real_shared_meal': 'passed',
        'friendship_history_without_romance_reward': 'passed'
    },
    'generic_housing_system': False,
    'generic_follower_framework': False,
    'approval_meter': False,
    'dating_simulator': False,
    'teleported_custody': False,
    'duplicate_trap_door': False,
    'canonical_solo_trap_door_changed': False
}
Path('glulx/build/mara-house-company/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n', encoding='utf-8'
)
PY_RECEIPT
cat "$BUILD/story-report.json"
