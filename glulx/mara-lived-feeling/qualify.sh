#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-field-capability-discovery-1259"
BUILD="$ROOT/glulx/build/mara-lived-feeling-rupture-repair-1260"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/mara-lived-feeling/patch-series.json"

rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

# Re-qualify the exact locked predecessor. Release 1260 is a stacked release,
# not a free-standing source snapshot.
bash glulx/mara-field-capabilities/qualify.sh
python -m py_compile glulx/mara-lived-feeling/stage.py

python - "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import importlib.util, json, sys
from pathlib import Path
spec = importlib.util.spec_from_file_location("stage1260", "glulx/mara-lived-feeling/stage.py")
mod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)
manifest = json.loads(Path(sys.argv[1]).read_text())
actual = {
    "production": mod.source_identity(Path(sys.argv[2])),
    "dev": mod.source_identity(Path(sys.argv[3])),
}
print("RELEASE_1260_BASE_SOURCE_IDENTITIES=" + json.dumps(actual, sort_keys=True))
pins = manifest.get("base_source_sha256") or {}
if pins:
    for profile, identity in actual.items():
        if pins.get(profile) != identity:
            raise SystemExit(
                f"Release 1259 {profile} source identity drift: expected {pins.get(profile)}, got {identity}"
            )
PY

python glulx/mara-lived-feeling/stage.py \
  --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/mara-lived-feeling/stage.py \
  --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"

python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path

def require(condition, message):
    if not condition:
        raise SystemExit(message)

b = Path("glulx/build/mara-lived-feeling-rupture-repair-1260")
s = b / "src"
d = b / "dev-src"
base = Path("glulx/build/mara-field-capability-discovery-1259/src")
stage = json.loads((s / "STAGING-RECEIPT.json").read_text())
dev = json.loads((d / "STAGING-RECEIPT.json").read_text())
smell = json.loads((b / "smell-report.json").read_text())
dev_smell = json.loads((b / "dev-smell-report.json").read_text())
manifest = json.loads(Path("glulx/mara-lived-feeling/patch-series.json").read_text())

expected = sorted(manifest["expected_changed_paths"])
require(stage["release"] == 1260 and stage["base"]["release"] == 1259,
        "Release 1260 staging receipt/base release mismatch")
require(stage["base"]["artifact_sha256"] ==
        "e3a1adc99a6849b4703a3fe4338310a12c8d38c6d94b1aeab762199bb8e43d77",
        "Release 1260 predecessor artifact drift")
require(stage["changed_paths"] == expected and dev["changed_paths"] == expected,
        "Release 1260 changed-path receipt mismatch")
require(stage["dev_mode"] is False and dev["dev_mode"] is True,
        "Release 1260 production/dev staging profile mismatch")
require(not smell["errors"] and not dev_smell["errors"],
        "Release 1260 smell check reported errors")
require((s / "mara_field_capabilities.zil").read_bytes() ==
        (base / "mara_field_capabilities.zil").read_bytes(),
        "Release 1259 field-capability authority changed instead of being extended")

feeling = (s / "mara_lived_feeling.zil").read_text()
companion = (s / "mara_companion.zil").read_text()
state = (s / "mara_companion_state.zil").read_text()
actions = (s / "mara_companion_actions.zil").read_text()
actor = (s / "mara_companion_actor.zil").read_text()
causal = (s / "mara_causal_biography.zil").read_text()
zork = (s / "zork1.zil").read_text()

for token in (
    "<ROUTINE MARA-ABOUT-RECKLESS-FEELING",
    "<ROUTINE MARA-ABOUT-RUPTURE",
    "<ROUTINE MARA-INTENTIONAL-HARM-ATTEMPT",
    "<ROUTINE MARA-RUPTURE-APOLOGIZE",
    "<ROUTINE MARA-LIVED-AFTER-MOVE",
    "<ROUTINE MARA-COMPLETE-RUPTURE-REPAIR",
    "<ROUTINE MARA-LIVED-DANGER-HOOK",
    "Helping you and being furious with you are not opposites.",
    "This time you chose me as the danger's target.",
    "That is evidence. Not erasure.",
    "reset button",
):
    require(token in feeling, f"missing lived-feeling token: {token}")

for forbidden in (
    "MARA-SLOT-TRUST",
    "MARA-SLOT-RESPECT",
    "MARA-SLOT-SAFETY",
    "AFFECTION",
    "LOVE-METER",
    "EMOTION-VECTOR",
):
    require(forbidden not in feeling,
            f"1260 lived-feeling authority crossed product boundary: {forbidden}")

require("<SYNTAX APOLOGIZE TO OBJECT" not in feeling,
        "Release 1260 duplicated the existing APOLOGIZE parser authority")
require("<MARA-RUPTURE-APOLOGIZE>" in actions,
        "existing Mara apology verb does not delegate to Release 1260 rupture history")
require("Seal the pipe first" in actions and "MARA-SLOT-LEAK-REPAIRED" in actions,
        "older causal apology authority was replaced instead of extended")

for token in (
    "<CONSTANT MARA-SCHEMA 8>",
    "<CONSTANT MARA-PREVIOUS-SCHEMA 7>",
    "<CONSTANT MARA-SLOT-KNOWN-RISK-INJURY 45>",
    "<CONSTANT MARA-SLOT-RECKLESSNESS-ANGER 47>",
    "<CONSTANT MARA-SLOT-INTENTIONAL-HARM 49>",
    "<CONSTANT MARA-SLOT-RUPTURE-OPEN 51>",
    "<CONSTANT MARA-SLOT-BOUNDARY-RESPECTED 53>",
    "<CONSTANT MARA-SLOT-RUPTURE-REPAIRED 55>",
    "<INSERT-FILE \"mara_lived_feeling\" T>",
):
    require(token in companion, f"missing schema/include token: {token}")

require("<MARA-LIVED-FEELING-ABOUT .TOPIC>" in state,
        "lived-feeling topics are not wired into Mara questions")
require("<EQUAL? <GET ,MARA-STATE 0> 7>" in state,
        "schema-7 migration is missing")
require("Release 1259 schema-7 saves retain every causal and capability fact" in state,
        "schema-7 migration semantics are not explicit")
require("<MARA-INTENTIONAL-HARM-ATTEMPT>" in actor,
        "direct violence does not enter 1260 rupture authority")
require("<MARA-RUPTURE-FOLLOW-REFUSAL>" in actor,
        "unresolved rupture does not alter close cooperation")
require("Mara steps clear before the blow can land" in feeling,
        "Release 1245 physical evasion is not preserved")
require("<MARA-LIVED-DANGER-HOOK> <RTRUE>" in causal,
        "lived feeling is not connected to shared danger")
require("<MARA-LIVED-AFTER-MOVE .FROM .TO>" in causal,
        "movement cannot become boundary-respect evidence")
require("<MARA-RUPTURE-OPEN?> <RFALSE>" in causal,
        "open rupture does not revoke close backstop eligibility")
require("<CONSTANT RELEASEID 1260>" in zork,
        "Release 1260 identity missing")
require("MARA LIVED FEELING RUPTURE AND REPAIR GLULX" in zork,
        "Release 1260 banner missing")
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
compile_story "$SRC" "$BUILD/mara-lived-feeling.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"
cp -a "$DEV_SRC" "$TEST_SRC"
cp glulx/mara-lived-feeling/tests/mara_lived_feeling_test.zil "$TEST_SRC/mara_lived_feeling_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path("glulx/tools").resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path("glulx/mara-lived-feeling/tests/001-include-mara-lived-feeling-test.json").resolve(),
    Path("glulx/build/mara-lived-feeling-rupture-repair-1260/test-src").resolve(),
)
PY

TEST_STORY="$BUILD/mara-lived-feeling-test.ulx"
compile_story "$TEST_SRC" "$BUILD/mara-lived-feeling-test.asm" "$TEST_STORY" test
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

cat > "$BUILD/concerned-anger.txt" <<'EOF1'
maraconcern
climb down maintenance ladder
look
ask mara about anger
marafeelstatus
marareturn
climb down maintenance ladder
marafeelstatus
quit
yes
EOF1
run_case concerned-anger
C="$BUILD/concerned-anger-transcript.txt"
grep -F 'You know what this ladder does' "$C"
grep -F 'I am still catching you because you are a person' "$C"
grep -F "Mara's rope goes hard across your chest" "$C"
grep -F 'bruised, soaked, and alive' "$C"
grep -F 'Helping you and being furious with you are not opposites.' "$C"
grep -F 'known-risk-injury=1 aided=1 anger=1 fear-revealed=1' "$C"
grep -F 'I helped when you were hurt' "$C"
grep -F 'reset button' "$C"
test "$(grep -F -c 'bruised, soaked, and alive' "$C")" -eq 1

cat > "$BUILD/intentional-harm.txt" <<'EOF2'
maraharm
attack mara
marafeelstatus
mara, follow
ask mara about attack
apologize to mara
mara, follow
north
marafeelstatus
quit
yes
EOF2
run_case intentional-harm
H="$BUILD/intentional-harm-transcript.txt"
grep -F 'Mara steps clear before the blow can land' "$H"
grep -F "This time you chose me as the danger's target" "$H"
grep -F 'intentional-harm=1 betrayal=1 rupture-open=1' "$H"
grep -F 'Distance is part of what I asked for' "$H"
grep -F 'It does not make me safe with you again by itself' "$H"
grep -F 'Thank you. You heard the part where I asked for space.' "$H"
grep -F 'boundary=1 repair-evidence=0 repaired=0' "$H"

cat > "$BUILD/unresolved-rupture-danger.txt" <<'EOF3'
maraharm
attack mara
apologize to mara
north
marareturn
climb down maintenance ladder
marafeelstatus
quit
yes
EOF3
run_case unresolved-rupture-danger
U="$BUILD/unresolved-rupture-danger-transcript.txt"
grep -F 'I will call for help if you are injured' "$U"
grep -F 'I will not put my body on the other end of a chosen fall' "$U"
grep -F 'intentional-harm=1 betrayal=1 rupture-open=1' "$U"
grep -F 'boundary=1 repair-evidence=0 repaired=0' "$U"
! grep -F 'bruised, soaked, and alive' "$U"

cat > "$BUILD/earned-repair.txt" <<'EOF4'
maraharm
attack mara
apologize to mara
north
mararepair
climb down maintenance ladder
look
ask mara about repair
marafeelstatus
quit
yes
EOF4
run_case earned-repair
R="$BUILD/earned-repair-transcript.txt"
grep -F 'You changed the action instead of arguing with the boundary' "$R"
grep -F 'That is evidence. Not erasure.' "$R"
grep -F 'You tried to hurt me. That remains true' "$R"
grep -F 'I chose to work beside you again' "$R"
grep -F 'intentional-harm=1 betrayal=1 rupture-open=0' "$R"
grep -F 'boundary=1 repair-evidence=1 repaired=1' "$R"

python - "$STORY" "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import hashlib, importlib.util, json, sys
from pathlib import Path
story = Path(sys.argv[1])
manifest_path = Path(sys.argv[2])
base_src = Path(sys.argv[3])
base_dev_src = Path(sys.argv[4])
manifest = json.loads(manifest_path.read_text())
b = Path("glulx/build/mara-lived-feeling-rupture-repair-1260")
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
    raise SystemExit("Release 1260 artifact checksum is invalid")
(b / "CANDIDATE-IDENTITY.json").write_text(json.dumps(identity, indent=2, sort_keys=True) + "\n")

spec = importlib.util.spec_from_file_location("stage1260", "glulx/mara-lived-feeling/stage.py")
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
    print("RELEASE_1260_BASE_SOURCE_IDENTITIES=" + json.dumps(base_identities, sort_keys=True))
    print("RELEASE_1260_ARTIFACT_IDENTITY=" + json.dumps(identity, sort_keys=True))
    raise SystemExit(4)

for profile, value in base_identities.items():
    if pins.get(profile) != value:
        raise SystemExit(
            f"Release 1260 base source {profile} mismatch: expected {pins.get(profile)}, got {value}"
        )
for key in ("file", "version_hex", "size_bytes", "checksum_hex", "sha256"):
    if expected[key] != identity[key]:
        raise SystemExit(f"Release 1260 artifact {key} mismatch: expected {expected[key]}, got {identity[key]}")

receipt = {
    "release": 1260,
    "serial": manifest["serial"],
    "artifact_identity_locked": True,
    "production": {**identity, "report": report},
    "base_release": 1259,
    "base_artifact_sha256": manifest["base_artifact_sha256"],
    "base_source_sha256": base_identities,
    "concerned_anger": "concerned-anger-transcript.txt",
    "intentional_harm": "intentional-harm-transcript.txt",
    "unresolved_rupture_danger": "unresolved-rupture-danger-transcript.txt",
    "earned_repair": "earned-repair-transcript.txt",
    "uses_existing_apology_authority": True,
    "uses_legacy_relationship_scalars": False,
    "preserves_release_1245_physical_evasion": True,
    "repair_deletes_original_harm": False,
}
(b / "QUALIFICATION-RECEIPT.json").write_text(json.dumps(receipt, indent=2, sort_keys=True) + "\n")
print(json.dumps(receipt, indent=2, sort_keys=True))
PY
