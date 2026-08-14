#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-causal-biography-shared-danger-1258"
BUILD="$ROOT/glulx/build/mara-field-capability-discovery-1259"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/mara-field-capabilities/patch-series.json"

rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

bash glulx/mara-causal-biography/qualify.sh
python -m py_compile glulx/mara-field-capabilities/stage.py

python - "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import importlib.util, json, sys
from pathlib import Path
spec = importlib.util.spec_from_file_location("stage1259", "glulx/mara-field-capabilities/stage.py")
mod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)
m = json.loads(Path(sys.argv[1]).read_text())
actual = {
    "production": mod.source_identity(Path(sys.argv[2])),
    "dev": mod.source_identity(Path(sys.argv[3])),
}
for profile, identity in actual.items():
    if m["base_source_sha256"][profile] != identity:
        raise SystemExit(
            f"Release 1258 {profile} source identity drift: "
            f"expected {m['base_source_sha256'][profile]}, got {identity}"
        )
PY

python glulx/mara-field-capabilities/stage.py \
  --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/mara-field-capabilities/stage.py \
  --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"

python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path

def require(condition, message):
    if not condition:
        raise SystemExit(message)

b = Path("glulx/build/mara-field-capability-discovery-1259")
s = b / "src"
d = b / "dev-src"
base = Path("glulx/build/mara-causal-biography-shared-danger-1258/src")
stage = json.loads((s / "STAGING-RECEIPT.json").read_text())
dev = json.loads((d / "STAGING-RECEIPT.json").read_text())
smell = json.loads((b / "smell-report.json").read_text())
dev_smell = json.loads((b / "dev-smell-report.json").read_text())

expected = sorted([
    "1actions.zil",
    "house_rest_and_dreams.zil",
    "mara_companion.zil",
    "mara_companion_actor.zil",
    "mara_companion_state.zil",
    "mara_field_capabilities.zil",
    "zork1.zil",
])
require(
    stage["release"] == 1259
    and stage["base"]["release"] == 1258
    and stage["base"]["artifact_sha256"]
        == "cfbe0e05ea2b70101aee2103bf07b80993ba479a41a905ad882102e6415d7263",
    "Release 1259 staging receipt/base artifact mismatch",
)
require(
    stage["changed_paths"] == expected
    and stage["dev_mode"] is False
    and dev["dev_mode"] is True,
    "Release 1259 staged changed paths or profile mismatch",
)
require(not smell["errors"] and not dev_smell["errors"], "Release 1259 smell check reported errors")
require(
    (s / "mara_causal_biography.zil").read_bytes()
        == (base / "mara_causal_biography.zil").read_bytes(),
    "Release 1258 causal-biography authority changed instead of being extended",
)

cap = (s / "mara_field_capabilities.zil").read_text()
state = (s / "mara_companion_state.zil").read_text()
actor = (s / "mara_companion_actor.zil").read_text()
world = (s / "1actions.zil").read_text()
house = (s / "house_rest_and_dreams.zil").read_text()
companion = (s / "mara_companion.zil").read_text()
zork = (s / "zork1.zil").read_text()

for token in (
    "<ROUTINE MARA-RECOVER-AFTER-HOUSE-REST",
    "<ROUTINE MARA-FRIGID-PENDULUM",
    "<ROUTINE MARA-DEEP-CANYON-RANGING",
    "<ROUTINE MARA-LOUD-RANGING",
    "I knew the numbers. I did not know I could do that.",
    "I thought I was estimating",
    "Apparently I can do this on purpose",
    "The numbers work, she says. My shoulder does not.",
):
    require(token in cap, f"missing capability-biography token: {token}")

for forbidden in (
    "MARA-SLOT-TRUST",
    "MARA-SLOT-RESPECT",
    "MARA-SLOT-SAFETY",
    "SETG LOUD-FLAG",
    "PLAYER-INGENUITY-LOUD-ECHO-SOLVE",
):
    require(forbidden not in cap, f"1259 capability authority crossed a product boundary: {forbidden}")

for token in (
    "<CONSTANT MARA-SCHEMA 7>",
    "<CONSTANT MARA-PREVIOUS-SCHEMA 6>",
    "<CONSTANT MARA-SLOT-LADDER-RECOVERED 39>",
    "<CONSTANT MARA-SLOT-PENDULUM-DISCOVERED 40>",
    "<CONSTANT MARA-SLOT-ACOUSTIC-DISCOVERED 42>",
    "<CONSTANT MARA-SLOT-ACOUSTIC-REUSED 43>",
    "<CONSTANT MARA-SLOT-PLUMMET-RECOVERED 44>",
    "<INSERT-FILE \"mara_field_capabilities\" T>",
):
    require(token in companion, f"missing schema/include token: {token}")

require("<MARA-FIELD-CAPABILITY-ABOUT .TOPIC>" in state, "capability topics are not wired into Mara questions")
require("<EQUAL? .RM ,LOUD-ROOM>" in state and "<MARA-LOUD-ROOM-SAFE?>" in state, "safe Loud Room movement boundary missing")
require("pale rough scar of the Dam ladder" in actor, "recovered injury is not visible on Mara")
require("<MARA-RECOVER-AFTER-HOUSE-REST>" in house, "House full-rest recovery does not call Mara recovery")
require("old fixed service pipe crosses above a narrow side channel" in world, "Frigid physical anchor missing from room description")
require("old iron ringbolt is driven into sound stone" in world, "Deep Canyon physical anchor missing from room description")
require("<CONSTANT RELEASEID 1259>" in zork, "Release 1259 identity missing")
require("Mara Field Capability Discovery Glulx" in zork, "Release 1259 banner missing")
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
compile_story "$SRC" "$BUILD/mara-field-capabilities.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"
cp -a "$DEV_SRC" "$TEST_SRC"
cp glulx/mara-field-capabilities/tests/mara_field_capabilities_test.zil \
  "$TEST_SRC/mara_field_capabilities_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path("glulx/tools").resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path("glulx/mara-field-capabilities/tests/001-include-mara-field-capabilities-test.json").resolve(),
    Path("glulx/build/mara-field-capability-discovery-1259/test-src").resolve(),
)
PY

TEST_STORY="$BUILD/mara-field-capabilities-test.ulx"
compile_story "$TEST_SRC" "$BUILD/mara-field-capabilities-test.asm" "$TEST_STORY" test
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
  make -C "$ROOT/.tooling/cheapglk"
  make -C "$ROOT/.tooling/glulxe" \
    OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

cat > "$BUILD/house-recovery.txt" <<'EOF1'
mararestprep
sleep
down
east
up
examine mara
ask mara about injury
maracapstatus
quit
yes
EOF1
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" \
  < "$BUILD/house-recovery.txt" > "$BUILD/house-recovery-transcript.txt" 2>&1
R="$BUILD/house-recovery-transcript.txt"
grep -F 'The scar remains; the stiffness does not. Recovery is not erasure.' "$R"
grep -F 'pale rough scar of the Dam ladder' "$R"
grep -F 'The ladder happened' "$R"
grep -F 'injury=1 recovered=1' "$R"
grep -F 'TEST Mara location: Attic.' "$R"

cat > "$BUILD/injury-boundary.txt" <<'EOF2'
marainjured
ask mara about river
maracapstatus
quit
yes
EOF2
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" \
  < "$BUILD/injury-boundary.txt" > "$BUILD/injury-boundary-transcript.txt" 2>&1
I="$BUILD/injury-boundary-transcript.txt"
grep -F 'The numbers work' "$I"
grep -F 'My shoulder does not' "$I"
grep -F 'pendulum-discovered=0' "$I"
grep -F 'plummet=0' "$I"

cat > "$BUILD/frigid-discovery.txt" <<'EOF3'
marafield
look
examine overhead service pipe
ask mara about river
ask mara about abilities
examine old brass survey plummet
maracapstatus
quit
yes
EOF3
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" \
  < "$BUILD/frigid-discovery.txt" > "$BUILD/frigid-discovery-transcript.txt" 2>&1
F="$BUILD/frigid-discovery-transcript.txt"
grep -F 'old fixed service pipe crosses above a narrow side channel' "$F"
grep -F 'I knew the numbers. I did not know I could do that.' "$F"
grep -F 'geometry still works when I am the moving point' "$F"
grep -F 'old brass plummet is a dense teardrop of metal' "$F"
grep -F 'pendulum-discovered=1' "$F"
grep -F 'plummet=1' "$F"
grep -F 'TEST plummet custody: Mara.' "$F"

cat > "$BUILD/reuse-chain.txt" <<'EOF4'
maracanyon
look
ask mara about acoustics
maracapstatus
down
look
ask mara about acoustics
ask mara about abilities
maracapstatus
quit
yes
EOF4
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" \
  < "$BUILD/reuse-chain.txt" > "$BUILD/reuse-chain-transcript.txt" 2>&1
C="$BUILD/reuse-chain-transcript.txt"
grep -F 'old iron ringbolt is driven into sound stone' "$C"
grep -F 'This part I know now' "$C"
grep -F 'I thought I was estimating' "$C"
grep -F 'pendulum-reused=1 acoustic-discovered=1' "$C"
grep -F 'Loud Room' "$C"
grep -F 'Apparently I can do this on purpose' "$C"
grep -F 'acoustic-reused=1' "$C"
grep -F 'TEST Mara location: Loud Room.' "$C"

python - "$STORY" "$MANIFEST" <<'PY'
import hashlib, json, sys
from pathlib import Path
story = Path(sys.argv[1])
manifest = json.loads(Path(sys.argv[2]).read_text())
b = Path("glulx/build/mara-field-capability-discovery-1259")
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
    raise SystemExit("Release 1259 artifact checksum is invalid")
(b / "CANDIDATE-IDENTITY.json").write_text(json.dumps(identity, indent=2, sort_keys=True) + "\n")
expected = manifest["expected_artifact"]
if expected.get("locked") is not True:
    print("RELEASE_1259_ARTIFACT_IDENTITY=" + json.dumps(identity, sort_keys=True))
    raise SystemExit(4)
for key in ("file", "version_hex", "size_bytes", "checksum_hex", "sha256"):
    if expected[key] != identity[key]:
        raise SystemExit(f"Release 1259 artifact {key} mismatch: expected {expected[key]}, got {identity[key]}")
receipt = {
    "release": 1259,
    "serial": manifest["serial"],
    "artifact_identity_locked": True,
    "production": {**identity, "report": report},
    "base_release": 1258,
    "base_artifact_sha256": manifest["base_artifact_sha256"],
    "house_recovery": "house-recovery-transcript.txt",
    "injury_boundary": "injury-boundary-transcript.txt",
    "frigid_discovery": "frigid-discovery-transcript.txt",
    "reuse_chain": "reuse-chain-transcript.txt",
    "sets_canonical_loud_solution": False,
    "uses_legacy_relationship_scalars": False,
}
(b / "QUALIFICATION-RECEIPT.json").write_text(json.dumps(receipt, indent=2, sort_keys=True) + "\n")
print(json.dumps(receipt, indent=2, sort_keys=True))
PY
