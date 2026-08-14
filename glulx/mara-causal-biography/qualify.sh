#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/fire-smoke-structural-consequences-1257"
BUILD="$ROOT/glulx/build/mara-causal-biography-shared-danger-1258"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/mara-causal-biography/patch-series.json"

rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

bash glulx/fire-smoke-structural/qualify.sh
python -m py_compile glulx/mara-causal-biography/stage.py

python - "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import importlib.util, json, sys
from pathlib import Path
spec = importlib.util.spec_from_file_location("stage1258", "glulx/mara-causal-biography/stage.py")
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
            f"Release 1257 {profile} source identity drift: "
            f"expected {m['base_source_sha256'][profile]}, got {identity}"
        )
PY

python glulx/mara-causal-biography/stage.py \
  --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/mara-causal-biography/stage.py \
  --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"

python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path

def require(condition, message):
    if not condition:
        raise SystemExit(message)

b = Path("glulx/build/mara-causal-biography-shared-danger-1258")
s = b / "src"
d = b / "dev-src"
base = Path("glulx/build/fire-smoke-structural-consequences-1257/src")
stage = json.loads((s / "STAGING-RECEIPT.json").read_text())
dev = json.loads((d / "STAGING-RECEIPT.json").read_text())
smell = json.loads((b / "smell-report.json").read_text())
dev_smell = json.loads((b / "dev-smell-report.json").read_text())

expected = sorted([
    "1actions.zil",
    "mara_causal_biography.zil",
    "mara_companion.zil",
    "mara_companion_actor.zil",
    "mara_companion_movement.zil",
    "mara_companion_state.zil",
    "zork1.zil",
])
require(
    stage["release"] == 1258
    and stage["base"]["release"] == 1257
    and stage["base"]["artifact_sha256"]
        == "d5080468723731018db587bcb5320cb88bb0a0b7585ee1c83156497dfb7fc444",
    "Release 1258 staging receipt/base artifact mismatch",
)
require(
    stage["changed_paths"] == expected
    and stage["dev_mode"] is False
    and dev["dev_mode"] is True,
    "Release 1258 staged changed paths or profile mismatch",
)
require(not smell["errors"] and not dev_smell["errors"], "Release 1258 smell check reported errors")

require(
    (s / "fire_structural.zil").read_bytes() == (base / "fire_structural.zil").read_bytes(),
    "Release 1257 fire authority changed",
)

causal = (s / "mara_causal_biography.zil").read_text()
actor = (s / "mara_companion_actor.zil").read_text()
movement = (s / "mara_companion_movement.zil").read_text()
dam = (s / "1actions.zil").read_text()
zork = (s / "zork1.zil").read_text()

for token in (
    "<ROUTINE MARA-LADDER-ATTEMPT",
    "<ROUTINE V-MARA-PROMISE",
    "<ROUTINE V-MARA-RESCUE",
    "<ROUTINE MARA-RETURN-ENTRUSTED-ROPE",
    "<ROUTINE MARA-LADDER-BACKSTOP-EARNED?",
    "<ROUTINE MARA-SHARED-DANGER-HOOK",
    "<ROUTINE MARA-CAUSAL-AFTER-MOVE",
    "<ROUTINE MARA-CAUSAL-ADVANCE",
    "<ROUTINE MARA-ABOUT-LADDER",
    "That was a rescue",
    "Promise kept",
    "I remember the blue circuit",
    "without volunteering what caught her attention",
    "Keep the useful end in your hands",
):
    require(token in causal, f"missing causal biography token: {token}")

for forbidden in ("MARA-SLOT-TRUST", "MARA-SLOT-RESPECT", "MARA-SLOT-SAFETY"):
    require(forbidden not in causal, f"1258 causal decision consulted legacy scalar: {forbidden}")

for token in (
    "<CONSTANT MARA-SCHEMA 6>",
    "<CONSTANT MARA-SLOT-BIO-IGNORED-WARNING 28>",
    "<CONSTANT MARA-SLOT-BIO-MARA-RESCUED-YOU 33>",
    "<CONSTANT MARA-SLOT-LADDER-INJURY 35>",
    "<CONSTANT MARA-SLOT-PRIVATE-LADDER-DISCOVERY 37>",
):
    require(token in (s / "mara_companion.zil").read_text(), f"missing schema token: {token}")

require("<MARA-REMEMBER-IGNORED-WARNING>" in movement, "blue-circuit event does not create explicit biography")
require("One palm is scraped raw from the Dam ladder" in actor, "persistent injury is not player-visible")
require("The wet measured coil is currently in your hands" in actor, "temporary rope custody is not player-visible")
require("<MARA-SHARED-DANGER-HOOK> <RTRUE>" in dam, "Mara shared-danger hook missing from canonical dam authority")
require("<ROUTINE DAM-SURVIVAL-LADDER-MOVE" in dam, "Release 1253 ladder authority missing")
require("<ROUTINE DAM-SURVIVAL-OVERBURDENED?" in dam, "Release 1253 load authority missing")
require("<CONSTANT RELEASEID 1258>" in zork, "Release 1258 identity missing")
require(
    "MARA CAUSAL BIOGRAPHY AND SHARED DANGER GLULX" in zork,
    "Release 1258 banner missing",
)
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
compile_story "$SRC" "$BUILD/mara-causal-biography.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"
cp -a "$DEV_SRC" "$TEST_SRC"
cp glulx/mara-causal-biography/tests/mara_causal_biography_test.zil \
  "$TEST_SRC/mara_causal_biography_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path("glulx/tools").resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path("glulx/mara-causal-biography/tests/001-include-mara-causal-biography-test.json").resolve(),
    Path("glulx/build/mara-causal-biography-shared-danger-1258/test-src").resolve(),
)
PY

TEST_STORY="$BUILD/mara-causal-biography-test.ulx"
compile_story "$TEST_SRC" "$BUILD/mara-causal-biography-test.asm" "$TEST_STORY" test
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
  echo "Rebuilding pinned CheapGlk/Glulxe interpreter for Release 1258 gameplay qualification."
  make -C "$ROOT/.tooling/cheapglk"
  make -C "$ROOT/.tooling/glulxe" \
    OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

cat > "$BUILD/earned-reciprocity.txt" <<'EOF1'
maraprep
mara, climb down maintenance ladder
promise mara
give field rope to mara
examine field rope
rescue mara
give field rope to mara
maraload
climb down maintenance ladder
look
ask mara about ladder
marastatus
quit
yes
EOF1
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" \
  < "$BUILD/earned-reciprocity.txt" > "$BUILD/earned-reciprocity-transcript.txt" 2>&1
E="$BUILD/earned-reciprocity-transcript.txt"
grep -F 'Her field rope lands in your hands' "$E"
grep -F 'Keep the useful end in your hands and get me back onto the platform first' "$E"
grep -F 'The wet measured coil is currently in your hands' "$E"
grep -F 'That was a rescue' "$E"
grep -F 'Promise kept' "$E"
grep -F 'I remember the blue circuit' "$E"
grep -F "Mara's rope goes hard across your chest" "$E"
grep -F 'without volunteering what caught her attention' "$E"
grep -F 'old survey punch under the lower retaining bolt' "$E"
grep -F 'mara-rescued-you=1' "$E"
grep -F 'injury=1' "$E"
grep -F 'private=2' "$E"
grep -F 'TEST rope custody: Mara.' "$E"

cat > "$BUILD/blocked-precedent.txt" <<'EOF2'
maranegative
climb down maintenance ladder
marastatus
quit
yes
EOF2
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" \
  < "$BUILD/blocked-precedent.txt" > "$BUILD/blocked-precedent-transcript.txt" 2>&1
N="$BUILD/blocked-precedent-transcript.txt"
grep -F 'I warned you about the blue circuit and you pressed it anyway' "$N"
grep -F 'mara-rescued-you=0' "$N"
grep -F 'rescued-mara=0' "$N"

cat > "$BUILD/broken-promise.txt" <<'EOF3'
maraprep
mara, climb down maintenance ladder
promise mara
rescue mara
west
marastatus
quit
yes
EOF3
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" \
  < "$BUILD/broken-promise.txt" > "$BUILD/broken-promise-transcript.txt" 2>&1
P="$BUILD/broken-promise-transcript.txt"
grep -F 'The rope was supposed to come back before you moved' "$P"
grep -F 'broken=1' "$P"
grep -F 'promise=3' "$P"
grep -F 'TEST rope custody: player.' "$P"

cat > "$BUILD/abandonment.txt" <<'EOF4'
maraprep
mara, climb down maintenance ladder
west
marastatus
quit
yes
EOF4
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" \
  < "$BUILD/abandonment.txt" > "$BUILD/abandonment-transcript.txt" 2>&1
A="$BUILD/abandonment-transcript.txt"
grep -F 'drag herself back over the ladder lip without the rope now leaving in your hands' "$A"
grep -F 'abandoned=1' "$A"
grep -F 'injury=1' "$A"
grep -F 'TEST rope custody: player.' "$A"

python - "$STORY" "$MANIFEST" <<'PY'
import hashlib, json, sys
from pathlib import Path

story = Path(sys.argv[1])
manifest_path = Path(sys.argv[2])
manifest = json.loads(manifest_path.read_text())
b = Path("glulx/build/mara-causal-biography-shared-danger-1258")
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
    raise SystemExit("Release 1258 artifact checksum is invalid")

(b / "CANDIDATE-IDENTITY.json").write_text(
    json.dumps(identity, indent=2, sort_keys=True) + "\n"
)

expected = manifest["expected_artifact"]
if expected.get("locked") is not True:
    print("RELEASE_1258_ARTIFACT_IDENTITY=" + json.dumps(identity, sort_keys=True))
    raise SystemExit(4)

for key in ("file", "version_hex", "size_bytes", "checksum_hex", "sha256"):
    if expected[key] != identity[key]:
        raise SystemExit(
            f"Release 1258 artifact {key} mismatch: expected {expected[key]}, got {identity[key]}"
        )

receipt = {
    "release": 1258,
    "serial": manifest["serial"],
    "artifact_identity_locked": True,
    "production": {**identity, "report": report},
    "base_release": 1257,
    "base_artifact_sha256": manifest["base_artifact_sha256"],
    "earned_reciprocity": "earned-reciprocity-transcript.txt",
    "blocked_precedent": "blocked-precedent-transcript.txt",
    "broken_promise": "broken-promise-transcript.txt",
    "abandonment": "abandonment-transcript.txt",
    "active_peril_rope_return_refused": True,
    "new_ladder_decision_uses_legacy_relationship_scalars": False,
}
(b / "QUALIFICATION-RECEIPT.json").write_text(
    json.dumps(receipt, indent=2, sort_keys=True) + "\n"
)
print(json.dumps(receipt, indent=2, sort_keys=True))
PY

echo "Release 1258 Mara Causal Biography & Shared Danger qualified."
