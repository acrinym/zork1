#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/mara-companion"
SRC="$BUILD/src"
MANIFEST="$ROOT/glulx/mara-companion/patch-series.json"
CANDIDATE="$ROOT/glulx/mara-companion/prose/mara-prose.txt"
CORPUS_LOCAL="$ROOT/.upstream/zork1-glulx/.local/infocom-corpus/mara-companion"
cd "$ROOT"
rm -rf "$BUILD" "$CORPUS_LOCAL"
mkdir -p "$BUILD/corpus" "$CORPUS_LOCAL"

IFS=$'\t' read -r MARA_SERIAL MARA_FILE < <(
  python - "$MANIFEST" <<'PY'
import json
from pathlib import Path
import sys
manifest = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
print('\t'.join((manifest['serial'], manifest['expected_artifact']['file'])))
PY
)

python -m unittest discover -s tests -p 'test_mara_companion*.py' -v
python -m py_compile \
  glulx/mara-companion/stage.py \
  tests/test_mara_companion*.py

python glulx/mara-companion/stage.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py \
  --source "$SRC" \
  --json "$BUILD/smell-report.json"

python -m tools.infocom_corpus validate-manifest \
  --manifest reference/infocom-corpus/manifest/infocom-corpus.json
python -m tools.infocom_corpus extract \
  --repo-root .upstream/zork1-glulx \
  --manifest reference/infocom-corpus/manifest/infocom-corpus.json \
  --out "$CORPUS_LOCAL/player-visible.jsonl" \
  --summary-out "$BUILD/corpus/public-summary.json"
python -m tools.infocom_corpus annotate \
  --corpus "$CORPUS_LOCAL/player-visible.jsonl" \
  --out "$CORPUS_LOCAL/annotated.jsonl"
python -m tools.infocom_corpus overlap \
  --candidate "$CANDIDATE" \
  --corpus "$CORPUS_LOCAL/annotated.jsonl" \
  --profiles reference/infocom-corpus/profiles/authority-profiles.json \
  --profile-id zork1-actor-dialogue \
  --out "$BUILD/mara-prose.overlap.json"
python -m tools.infocom_corpus receipt \
  --candidate "$CANDIDATE" \
  --corpus "$CORPUS_LOCAL/annotated.jsonl" \
  --profiles reference/infocom-corpus/profiles/authority-profiles.json \
  --profile-id zork1-actor-dialogue \
  --surface-family mara-arrival-evidence-memory \
  --reviewer Justin \
  --intentional-departure 'Mara speaks from witnessed evidence and may name repository-local museum custody without becoming omniscient.' \
  --out "$BUILD/mara-prose.style-receipt.json"

python - <<'PY'
import json
from pathlib import Path
source = Path('glulx/build/mara-companion/src')
stage = json.loads((source / 'STAGING-RECEIPT.json').read_text())
smell = json.loads(Path('glulx/build/mara-companion/smell-report.json').read_text())
overlap = json.loads(Path('glulx/build/mara-companion/mara-prose.overlap.json').read_text())
receipt = json.loads(Path('glulx/build/mara-companion/mara-prose.style-receipt.json').read_text())
assert stage['base']['release'] == 1233
assert stage['base']['artifact_sha256'] == '4ac789f379231cbc7a871f6d092f824f8098607ee60239936f57aa39585c5244'
assert stage['changed_paths'] == [
    'mara_companion.zil',
    'museum_intake_first_gallery.zil',
    'zork1.zil',
]
assert not smell['errors']
assert not [item for item in smell['includes'] if not item['resolved']]
assert overlap['passed'] is True
assert overlap['source_text_disclosed'] is False
assert overlap['threshold_violations'] == []
assert overlap['rare_phrase_matches'] == []
assert receipt['authority_profile'] == 'zork1-actor-dialogue'
originality = receipt['originality_check']
assert originality['passed'] is True
assert originality['source_text_disclosed'] is False
assert originality['threshold_violation_count'] == 0
assert originality['rare_phrase_match_count'] == 0
module = (source / 'mara_companion.zil').read_text()
museum = (source / 'museum_intake_first_gallery.zil').read_text()
for required in (
    '<SYNTAX SHOW OBJECT (HELD CARRIED HAVE) TO OBJECT (FIND ACTORBIT) (IN-ROOM)',
    '<CONSTANT MARA-STATE <TABLE MARA-SCHEMA 0 0 0>>',
    '<MARA-PUT ,MARA-SLOT-LAST-EVIDENCE ,PRSO>',
    '<OBJECT MARA',
    '(IN LIVING-ROOM)',
    '(FLAGS ACTORBIT TRYTAKEBIT)',
):
    assert module.count(required) == 1
for forbidden in ('<GLOBAL', '<MOVE ,PRSO', '<REMOVE ,PRSO', 'FOLLOWER-ENGINE', 'CHATBOT'):
    assert forbidden not in module
assert museum.index('<MUSEUM-ACCEPTS? ,MUSEUM-WEAPON-WALL .OBJ>') < museum.index('<G? <GETP .OBJ ,P?TVALUE> 0>')
PY

if ! command -v dotnet >/dev/null 2>&1; then
  echo "dotnet is required for Release 1234 qualification." >&2
  exit 4
fi

GLULX_ZILF_DLL="${GLULX_ZILF_DLL:-$(find "$ROOT/.tooling/zilf-glulx" -path '*/bin/Release/*/zilf.dll' -print -quit 2>/dev/null || true)}"
if [[ -z "$GLULX_ZILF_DLL" && -f "$ROOT/.tooling/zilf-glulx/Zilf.sln" ]]; then
  pushd "$ROOT/.tooling/zilf-glulx"
  dotnet restore Zilf.sln --nologo 2>&1 | tee "$BUILD/zilf-restore.log"
  dotnet build Zilf.sln --configuration Release --property:PortableTarget=true --no-restore --nologo \
    2>&1 | tee "$BUILD/zilf-build.log"
  popd
  GLULX_ZILF_DLL="$(find "$ROOT/.tooling/zilf-glulx" -path '*/bin/Release/*/zilf.dll' -print -quit)"
fi
if [[ -z "$GLULX_ZILF_DLL" || ! -f "$GLULX_ZILF_DLL" ]]; then
  echo "A local ZILF checkout or GLULX_ZILF_DLL is required." >&2
  exit 4
fi
GLULX_ZILF_DLL="$(realpath "$GLULX_ZILF_DLL")"

GLAZER_BIN="${GLAZER_BIN:-$(find "$ROOT/.tooling/glazer-source" -type f -name glazer -perm -111 -print -quit 2>/dev/null || true)}"
if [[ -z "$GLAZER_BIN" && -f "$ROOT/.tooling/glazer-source/Makefile" ]]; then
  make -C "$ROOT/.tooling/glazer-source" 2>&1 | tee "$BUILD/glazer-build.log"
  GLAZER_BIN="$(find "$ROOT/.tooling/glazer-source" -type f -name glazer -perm -111 -print -quit)"
fi
if [[ -z "$GLAZER_BIN" ]] && command -v glazer >/dev/null 2>&1; then
  GLAZER_BIN="$(command -v glazer)"
fi
if [[ -z "$GLAZER_BIN" || ! -x "$GLAZER_BIN" ]]; then
  echo "A local Glazer build or GLAZER_BIN is required." >&2
  exit 4
fi
GLAZER_BIN="$(realpath "$GLAZER_BIN")"
"$GLAZER_BIN" --version | tee "$BUILD/glazer-version.txt"

ASSEMBLY="$BUILD/zork1-glulx-mara-arrival-evidence-memory.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" \
  2>&1 | tee "$BUILD/zilf-compile.log"
popd
python "$ROOT/glulx/tools/normalize_serial.py" \
  "$ASSEMBLY" \
  --serial "$MARA_SERIAL" \
  --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$MARA_FILE" \
  2>&1 | tee "$BUILD/glazer-assemble.log"
python "$ROOT/glulx/tools/verify_ulx.py" \
  "$BUILD/$MARA_FILE" \
  --json "$BUILD/story-report.json"

make -C "$ROOT/.tooling/cheapglk" 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C "$ROOT/.tooling/glulxe" \
  GLKDIR="$ROOT/.tooling/cheapglk" \
  GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" \
  2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
test -x "$GLULXE_BIN"

cat > "$BUILD/commands.txt" <<'EOF_COMMANDS'
north
east
open window
west
west
talk to mara
ask mara about museum
take sword
show sword to mara
ask mara about museum
ask mara about sword
exhibit sword
catalog museum
take sword
talk to mara
quit
yes
EOF_COMMANDS
"$GLULXE_BIN" "$BUILD/$MARA_FILE" < "$BUILD/commands.txt" \
  2>&1 | tee "$BUILD/mara-transcript.txt"

grep -F 'Mara sits near the museum displays' "$BUILD/mara-transcript.txt"
grep -F 'Mara gives the room one careful look before meeting your eyes.' "$BUILD/mara-transcript.txt"
grep -F 'A room full of trophies can still lie' "$BUILD/mara-transcript.txt"
grep -F 'Mara takes enough time to examine the sword' "$BUILD/mara-transcript.txt"
grep -F 'The museum means more now' "$BUILD/mara-transcript.txt"
grep -F 'That one Mara knows. It was found already hanging above the white house' "$BUILD/mara-transcript.txt"
grep -F 'The weapon wall holds a sword.' "$BUILD/mara-transcript.txt"
grep -F 'Mara remembers the sword.' "$BUILD/mara-transcript.txt"
test "$(grep -Fc 'Taken.' "$BUILD/mara-transcript.txt")" -ge 2
for word in mara show present; do
  if grep -Fi "I don't know the word \"$word\"" "$BUILD/mara-transcript.txt"; then
    echo "Mara command vocabulary was not recognized: $word" >&2
    exit 1
  fi
done

python - "$MARA_SERIAL" "$MANIFEST" <<'PY'
import json
from pathlib import Path
import sys
serial, manifest_path = sys.argv[1:]
manifest = json.loads(Path(manifest_path).read_text())
expected = manifest['expected_artifact']
story = json.loads(Path('glulx/build/mara-companion/story-report.json').read_text())
stage = json.loads(Path('glulx/build/mara-companion/src/STAGING-RECEIPT.json').read_text())
assert story['format'] == expected['format']
assert story['version_hex'] == expected['version_hex']
assert story['checksum_valid'] is True
assert story['size_bytes'] > 0
if expected.get('locked', False):
    assert story['size_bytes'] == expected['size_bytes']
    assert story['checksum_hex'] == expected['checksum_hex']
    assert story['sha256'] == expected['sha256']
receipt = {
    'qualification_status': 'source-corpus-artifact-and-runtime-passed',
    'identity': {'release': 1234, 'serial': serial},
    'base': {
        'release': stage['base']['release'],
        'artifact_sha256': stage['base']['artifact_sha256'],
    },
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'artifact_identity_locked': expected.get('locked', False),
    'routes': {
        'direct_mara_tests': 'passed',
        'exact_release_1233_staging': 'passed',
        'zil_source_smell_check': 'passed',
        'mara_prose_originality': 'passed',
        'zilf_glulx_compile': 'passed',
        'glazer_assemble': 'passed',
        'ulx_checksum_verification': 'passed',
        'mara_arrival_runtime': 'passed',
        'unwitnessed_knowledge_runtime': 'passed',
        'evidence_memory_runtime': 'passed',
        'museum_class_precedence_runtime': 'passed',
        'retained_object_custody_runtime': 'passed',
    },
    'memory_authority': 'canonical-object-identity',
    'new_global_variable': False,
    'generic_companion_engine': False,
    'generated_dialogue': False,
    'duplicate_evidence_object': False,
    'sub_beads': False,
}
Path('glulx/build/mara-companion/QUALIFICATION-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n'
)
PY

rm -rf "$CORPUS_LOCAL"
cat "$BUILD/story-report.json"
cat "$BUILD/QUALIFICATION-RECEIPT.json"
