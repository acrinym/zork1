#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-lived-feeling-rupture-repair-1260"
BUILD="$ROOT/glulx/build/mara-anticipation-protective-initiative-1261"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/mara-anticipation/patch-series.json"

rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

# Release 1261 is qualified only over the exact locked Release 1260 predecessor.
bash glulx/mara-lived-feeling/qualify.sh
python -m py_compile glulx/mara-anticipation/stage.py

python - "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import importlib.util, json, sys
from pathlib import Path
spec = importlib.util.spec_from_file_location("stage1261", "glulx/mara-anticipation/stage.py")
mod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)
manifest = json.loads(Path(sys.argv[1]).read_text())
actual = {
    "production": mod.source_identity(Path(sys.argv[2])),
    "dev": mod.source_identity(Path(sys.argv[3])),
}
print("RELEASE_1261_BASE_SOURCE_IDENTITIES=" + json.dumps(actual, sort_keys=True))
pins = manifest.get("base_source_sha256") or {}
if pins:
    for profile, identity in actual.items():
        if pins.get(profile) != identity:
            raise SystemExit(
                f"Release 1260 {profile} source identity drift: expected {pins.get(profile)}, got {identity}"
            )
PY

python glulx/mara-anticipation/stage.py \
  --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/mara-anticipation/stage.py \
  --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"

python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path

def require(condition, message):
    if not condition:
        raise SystemExit(message)

b = Path("glulx/build/mara-anticipation-protective-initiative-1261")
s = b / "src"
d = b / "dev-src"
base = Path("glulx/build/mara-lived-feeling-rupture-repair-1260/src")
stage = json.loads((s / "STAGING-RECEIPT.json").read_text())
dev = json.loads((d / "STAGING-RECEIPT.json").read_text())
smell = json.loads((b / "smell-report.json").read_text())
dev_smell = json.loads((b / "dev-smell-report.json").read_text())
manifest = json.loads(Path("glulx/mara-anticipation/patch-series.json").read_text())

expected = sorted(manifest["expected_changed_paths"])
require(stage["release"] == 1261 and stage["base"]["release"] == 1260,
        "Release 1261 staging receipt/base release mismatch")
require(stage["base"]["artifact_sha256"] ==
        "81f686a1cd792b61f219e167fc0427e890151020d5b02f127cbd83d247c209c2",
        "Release 1261 predecessor artifact drift")
require(stage["changed_paths"] == expected and dev["changed_paths"] == expected,
        "Release 1261 changed-path receipt mismatch")
require(stage["dev_mode"] is False and dev["dev_mode"] is True,
        "Release 1261 production/dev staging profile mismatch")
require(not smell["errors"] and not dev_smell["errors"],
        "Release 1261 smell check reported errors")

anticipation = (s / "mara_anticipation.zil").read_text()
companion = (s / "mara_companion.zil").read_text()
state = (s / "mara_companion_state.zil").read_text()
lived = (s / "mara_lived_feeling.zil").read_text()
zork = (s / "zork1.zil").read_text()

for token in (
    "<ROUTINE MARA-PROACTIVE-DAM-WARNING",
    "<ROUTINE MARA-ANTICIPATION-AFTER-MOVE",
    "<ROUTINE MARA-ANTICIPATION-DANGER-HOOK",
    "<ROUTINE MARA-ANTICIPATION-ABOUT",
    "I am not waiting until you are falling to say it.",
    "The warning is now part of what you chose with knowledge",
    "You heard the warning early enough to make it unnecessary as a rescue.",
    "I can care whether you fall without volunteering my body as your safety system.",
):
    require(token in anticipation, f"missing anticipation token: {token}")

for forbidden in (
    "WORRY-METER", "TRUST-SCORE", "RELATIONSHIP-SCORE",
    "EMOTION-VECTOR", "AUTONOMOUS-PUZZLE",
):
    require(forbidden not in anticipation,
            f"1261 anticipation authority crossed product boundary: {forbidden}")

for token in (
    "<CONSTANT MARA-SCHEMA 9>",
    "<CONSTANT MARA-PREVIOUS-SCHEMA 8>",
    "<CONSTANT MARA-ANTICIPATION-SCHEMA 9>",
    "<CONSTANT MARA-LIVED-FEELING-SCHEMA 8>",
    "<CONSTANT MARA-CAUSAL-SCHEMA 6>",
    "<CONSTANT MARA-SLOT-ANTICIPATED-KNOWN-RISK 56>",
    "<CONSTANT MARA-SLOT-PROTECTIVE-INITIATIVE 57>",
    "<CONSTANT MARA-SLOT-WORRY-SPOKEN 58>",
    "<CONSTANT MARA-SLOT-WARNING-HEEDED 59>",
    "<CONSTANT MARA-SLOT-WARNING-OVERRIDDEN 60>",
    "<CONSTANT MARA-SLOT-RELIEF-AFTER-HEEDED 61>",
    "<CONSTANT MARA-SLOT-PROTECTIVE-PREPARATION 62>",
    "<INSERT-FILE \"mara_anticipation\" T>",
):
    require(token in companion, f"missing schema/include token: {token}")

require("<L? <GET ,MARA-STATE 0> ,MARA-ANTICIPATION-SCHEMA>" in state,
        "fixed Release 1261 anticipation migration boundary is missing")
require("<L? <GET ,MARA-STATE 0> ,MARA-LIVED-FEELING-SCHEMA>" in state,
        "fixed Release 1260 lived-feeling migration boundary was not preserved")
require("<EQUAL? <GET ,MARA-STATE 0> ,MARA-PREVIOUS-SCHEMA>" in state,
        "schema-8 to schema-9 migration is missing")
require("Release 1260 schema-8 saves retain lived feeling, rupture, repair" in state,
        "schema-8 preservation semantics are not explicit")
require("<MARA-ANTICIPATION-ABOUT .TOPIC> <RTRUE>" in lived,
        "anticipation topic is not connected to Mara questions")
require("<MARA-ANTICIPATION-AFTER-MOVE .FROM .TO>" in lived,
        "real movement cannot trigger proactive danger appraisal")
require("<MARA-ANTICIPATION-DANGER-HOOK> <RTRUE>" in lived,
        "later real ladder action cannot become heeded/overridden evidence")
require((s / "mara_causal_biography.zil").read_bytes() ==
        (base / "mara_causal_biography.zil").read_bytes(),
        "1261 replaced causal biography authority instead of extending the 1260 seam")
require("<ROUTINE MARA-COMPLETE-RUPTURE-REPAIR" in lived and
        "That is evidence. Not erasure." in lived,
        "Release 1260 repair authority was not preserved")
require("<CONSTANT RELEASEID 1261>" in zork,
        "Release 1261 identity missing")
require("MARA ANTICIPATION WORRY AND PROTECTIVE INITIATIVE GLULX" in zork,
        "Release 1261 banner missing")
PY

IFS=$'\t' read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY'
import json, sys
from pathlib import Path
m = json.loads(Path(sys.argv[1]).read_text())
print("\t".join((m["serial"], m["expected_artifact"]["file"])))
PY
)

GLULX_ZILF_DLL="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"
GLAZER_BIN="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"

compile_story() {
  local source="$1" assembly="$2" output="$3" prefix="$4"
  pushd "$source"
  dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$assembly" \
    2>&1 | tee "$BUILD/$prefix-zilf-compile.log"
  popd
  python "$ROOT/glulx/tools/normalize_serial.py" "$assembly" --serial "$SERIAL" \
    --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"
  "$GLAZER_BIN" "$assembly" -o "$output" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"
}

STORY="$BUILD/$STORY_FILE"
compile_story "$SRC" "$BUILD/mara-anticipation.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"
cp -a "$DEV_SRC" "$TEST_SRC"
cp glulx/mara-anticipation/tests/mara_anticipation_test.zil "$TEST_SRC/mara_anticipation_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path("glulx/tools").resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path("glulx/mara-anticipation/tests/001-include-mara-anticipation-test.json").resolve(),
    Path("glulx/build/mara-anticipation-protective-initiative-1261/test-src").resolve(),
)
PY

TEST_STORY="$BUILD/mara-anticipation-test.ulx"
compile_story "$TEST_SRC" "$BUILD/mara-anticipation-test.asm" "$TEST_STORY" test
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
  make -C "$ROOT/.tooling/cheapglk"
  make -C "$ROOT/.tooling/glulxe" \
    OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

run_case() {
  local name="$1"
  timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" \
    < "$BUILD/$name.txt" > "$BUILD/$name-transcript.txt" 2>&1
}

cat > "$BUILD/heeded-warning.txt" <<'EOF1'
maraanticipate
east
maraantstatus
drop ballast
climb down maintenance ladder
maraantstatus
ask mara about worry
quit
yes
EOF1
run_case heeded-warning
H="$BUILD/heeded-warning-transcript.txt"
grep -F 'Before you can put a hand on the maintenance ladder' "$H"
grep -F 'I am not waiting until you are falling to say it.' "$H"
grep -F 'anticipated=1 initiative=1 worry=1 prepared=1 heeded=0 overridden=0 relief=0' "$H"
grep -F 'You heard the warning early enough to make it unnecessary as a rescue.' "$H"
grep -F 'anticipated=1 initiative=1 worry=1 prepared=1 heeded=1 overridden=0 relief=1' "$H"
grep -F 'You changed the action while there was still time.' "$H"
test "$(grep -F -c 'I am not waiting until you are falling to say it.' "$H")" -eq 1

cat > "$BUILD/overridden-warning.txt" <<'EOF2'
maraoverride
east
climb down maintenance ladder
maraantstatus
ask mara about worry
quit
yes
EOF2
run_case overridden-warning
O="$BUILD/overridden-warning-transcript.txt"
grep -F 'I am not waiting until you are falling to say it.' "$O"
grep -F 'That is the exact choice I warned you about before you touched the ladder' "$O"
grep -F 'The warning is now part of what you chose with knowledge' "$O"
grep -F 'reset button' "$O"
grep -F 'anticipated=1 initiative=1 worry=1 prepared=1 heeded=0 overridden=1 relief=0' "$O"
grep -F 'That matters differently from danger neither of us saw coming.' "$O"

cat > "$BUILD/rupture-concern.txt" <<'EOF3'
mararupturewarn
east
maraantstatus
climb down maintenance ladder
maraantstatus
quit
yes
EOF3
run_case rupture-concern
R="$BUILD/rupture-concern-transcript.txt"
grep -F 'Mara speaks from the distance she has kept' "$R"
grep -F 'I can care whether you fall without volunteering my body as your safety system.' "$R"
grep -F 'rupture-open=1 repaired=0' "$R"
grep -F 'I will call for help if you are injured' "$R"
grep -F 'I will not put my body on the other end of a chosen fall' "$R"
grep -F 'overridden=1 relief=0' "$R"

python - "$STORY" "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import hashlib, importlib.util, json, sys
from pathlib import Path
story = Path(sys.argv[1])
manifest_path = Path(sys.argv[2])
base_src = Path(sys.argv[3])
base_dev_src = Path(sys.argv[4])
manifest = json.loads(manifest_path.read_text())
b = Path("glulx/build/mara-anticipation-protective-initiative-1261")
report = json.loads((b / "story-report.json").read_text())
identity = {
    "file": story.name,
    "format": "Glulx",
    "version_hex": report["version_hex"],
    "size_bytes": story.stat().st_size,
    "checksum_hex": report["checksum_hex"],
    "sha256": hashlib.sha256(story.read_bytes()).hexdigest(),
}
if report["checksum_valid"] is not True:
    raise SystemExit("Release 1261 artifact checksum is invalid")
(b / "CANDIDATE-IDENTITY.json").write_text(json.dumps(identity, indent=2, sort_keys=True) + "\n")

spec = importlib.util.spec_from_file_location("stage1261", "glulx/mara-anticipation/stage.py")
mod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)
base_identities = {
    "production": mod.source_identity(base_src),
    "dev": mod.source_identity(base_dev_src),
}
(b / "BASE-SOURCE-IDENTITIES.json").write_text(json.dumps(base_identities, indent=2, sort_keys=True) + "\n")

expected = manifest["expected_artifact"]
pins = manifest.get("base_source_sha256") or {}
if not pins or expected.get("locked") is not True:
    print("RELEASE_1261_BASE_SOURCE_IDENTITIES=" + json.dumps(base_identities, sort_keys=True))
    print("RELEASE_1261_ARTIFACT_IDENTITY=" + json.dumps(identity, sort_keys=True))
    raise SystemExit(4)

for profile, value in base_identities.items():
    if pins.get(profile) != value:
        raise SystemExit(
            f"Release 1261 base source {profile} mismatch: expected {pins.get(profile)}, got {value}"
        )
for key in ("file", "version_hex", "size_bytes", "checksum_hex", "sha256"):
    if expected[key] != identity[key]:
        raise SystemExit(f"Release 1261 artifact {key} mismatch: expected {expected[key]}, got {identity[key]}")

receipt = {
    "release": 1261,
    "serial": manifest["serial"],
    "artifact_identity_locked": True,
    "production": {**identity, "report": report},
    "base_release": 1260,
    "base_artifact_sha256": manifest["base_artifact_sha256"],
    "base_source_sha256": base_identities,
    "heeded_warning": "heeded-warning-transcript.txt",
    "overridden_warning": "overridden-warning-transcript.txt",
    "rupture_concern": "rupture-concern-transcript.txt",
    "generic_worry_meter": False,
    "warning_requires_specific_history": True,
    "rupture_concern_restores_close_backstop": False,
}
(b / "QUALIFICATION-RECEIPT.json").write_text(json.dumps(receipt, indent=2, sort_keys=True) + "\n")
print(json.dumps(receipt, indent=2, sort_keys=True))
PY
