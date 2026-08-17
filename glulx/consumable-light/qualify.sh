#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/perilous-affordances-1264"
BUILD="$ROOT/glulx/build/consumable-light-1265"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/consumable-light/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

# A stacked train still proves its immediate gameplay predecessor from scratch.
# Release 1264 remains unmerged, so qualification must trust its locked artifact
# and staged-source receipts rather than the branch relationship alone.
bash glulx/perilous-affordances/qualify.sh
python -m py_compile glulx/consumable-light/stage.py

python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" <<'PY_BASE_IDS'
import hashlib
import json
import sys
from pathlib import Path


def identity(root: str) -> str:
    root_path = Path(root)
    files = {
        p.relative_to(root_path).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest()
        for p in sorted(root_path.rglob("*"))
        if p.is_file() and p.name != "STAGING-RECEIPT.json"
    }
    return hashlib.sha256(
        json.dumps(files, sort_keys=True, separators=(",", ":")).encode()
    ).hexdigest()


manifest = json.loads(Path(sys.argv[3]).read_text())
ids = {"production": identity(sys.argv[1]), "dev": identity(sys.argv[2])}
print("RELEASE_1265_BASE_SOURCE_IDENTITIES=" + json.dumps(ids, sort_keys=True))
if ids != manifest["base_source_sha256"]:
    raise SystemExit(
        "Release 1265 predecessor source pins drift: "
        f"expected {manifest['base_source_sha256']}, got {ids}"
    )
PY_BASE_IDS

python glulx/consumable-light/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/consumable-light/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path


def require(condition, message):
    if not condition:
        raise SystemExit(message)


build = Path("glulx/build/consumable-light-1265")
source = build / "src"
base = Path("glulx/build/perilous-affordances-1264/src")
manifest = json.loads(Path("glulx/consumable-light/patch-series.json").read_text())
receipt = json.loads((source / "STAGING-RECEIPT.json").read_text())

require(
    receipt["release"] == 1265 and receipt["base"]["release"] == 1264,
    "Release 1265 staging/base mismatch",
)
require(
    receipt["changed_paths"] == sorted(manifest["expected_changed_paths"]),
    "Release 1265 changed-path mismatch",
)
require(
    not json.loads((build / "smell-report.json").read_text())["errors"],
    "Release 1265 production smell errors",
)
require(
    not json.loads((build / "dev-smell-report.json").read_text())["errors"],
    "Release 1265 dev smell errors",
)

actions = (source / "1actions.zil").read_text()
lights = (source / "consumable_light.zil").read_text()
shadow = (source / "shadow_logic.zil").read_text()
ritual = (source / "ritual_resonance.zil").read_text()
globals_src = (source / "gglobals.zil").read_text()
zork = (source / "zork1.zil").read_text()

# Canonical countdowns remain the resource authority. Release 1265 only observes
# their existing milestones and gives those milestones authored physical meaning.
for token in (
    "<GLOBAL LAMP-TABLE",
    '"The lamp appears a bit dimmer."',
    '"The lamp is definitely dimmer now."',
    '"The lamp is nearly out."',
    "<GLOBAL CANDLE-TABLE",
    '"The candles grow shorter."',
    '"The candles are becoming quite short."',
    '"The candles won\'t last long now."',
):
    require(token in actions, f"canonical light countdown authority missing: {token}")
require(
    "<CONSUMABLE-NOTE-LAMP-TICK .TICK>" in actions,
    "lamp countdown is not routed into qualitative light state",
)
require(
    "<CONSUMABLE-NOTE-CANDLE-TICK .TICK>" in actions,
    "candle countdown is not routed into qualitative light state",
)

for token in (
    "<CONSTANT LIGHT-DARK 0>",
    "<CONSTANT LIGHT-EMBER 1>",
    "<CONSTANT LIGHT-WEAK 2>",
    "<CONSTANT LIGHT-BRIGHT 3>",
    "<ROUTINE CONSUMABLE-CURRENT-LIGHT-LEVEL",
    "<ROUTINE CONSUMABLE-WET-CANDLES",
    "<ROUTINE CONSUMABLE-SNUFF-EMBER-CANDLES",
):
    require(token in lights, f"missing Release 1265 qualitative light token: {token}")
require(
    "<GLOBAL" not in lights,
    "Release 1265 consumed a legacy VM global instead of compact table state",
)
for forbidden in (
    "LUX",
    "LIGHT-POINTS",
    "FUEL-POINTS",
    "GENERIC-LIGHT-ENGINE",
    "ROOM-BRIGHTNESS-MAP",
    "UNIVERSAL-FUEL",
):
    require(
        forbidden not in lights,
        f"Release 1265 crossed generic light-system boundary: {forbidden}",
    )

require(
    "<CONSUMABLE-CANDLES-HOOK>" in ritual,
    "ritual candle authority does not compose with Release 1265",
)
require(
    "<CONSUMABLE-LIGHT-ADVANCE>" in shadow,
    "Release 1265 per-turn material light consequences are not integrated",
)
require(
    "<CONSUMABLE-WET-CANDLES>" in shadow,
    "bottled-water candle interaction did not reuse existing USE authority",
)
require(
    "<CONSUMABLE-DESCRIBE-LIGHTS>" in shadow,
    "existing LIGHTS command is not reporting qualitative light",
)
require(
    "Strong light proved only that" in globals_src,
    "grue evidence still hard-codes the ivory torch",
)
require(
    "<EQUAL? <CONSUMABLE-CURRENT-LIGHT-LEVEL> ,LIGHT-BRIGHT>" in actions,
    "grue-colony strong-light authority is not driven by qualitative light",
)

# Release 1265 does not rewrite binary parser visibility, generic verb authority,
# or the canonical fire model.
for name in ("gparser.zil", "gsyntax.zil", "gverbs.zil", "fire_structural.zil"):
    require(
        (source / name).read_bytes() == (base / name).read_bytes(),
        f"Release 1265 unexpectedly changed canonical authority: {name}",
    )

require(
    "<CONSTANT RELEASEID 1265>" in zork
    and '<INSERT-FILE "consumable_light" T>' in zork,
    "Release 1265 identity/include missing",
)
PY_STATIC

IFS=$'\t' read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY_MANIFEST'
import json
import sys
from pathlib import Path

m = json.loads(Path(sys.argv[1]).read_text())
print("\t".join((m["serial"], m["expected_artifact"]["file"])))
PY_MANIFEST
)

GLULX_ZILF_DLL="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"
GLAZER_BIN="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"

compile_story() {
    local source="$1" assembly="$2" output="$3" prefix="$4"
    pushd "$source"
    dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$assembly" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"
    popd
    python "$ROOT/glulx/tools/normalize_serial.py" "$assembly" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"
    "$GLAZER_BIN" "$assembly" -o "$output" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"
}

STORY="$BUILD/$STORY_FILE"
compile_story "$SRC" "$BUILD/consumable-light.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"
cp -a "$DEV_SRC" "$TEST_SRC"
cp glulx/consumable-light/tests/consumable_light_test.zil "$TEST_SRC/consumable_light_test.zil"
python - <<'PY_TEST_PATCH'
from pathlib import Path
import sys

sys.path.insert(0, str(Path("glulx/tools").resolve()))
from stage_release120 import apply_patch

apply_patch(
    Path("glulx/consumable-light/tests/001-include-consumable-test.json").resolve(),
    Path("glulx/build/consumable-light-1265/test-src").resolve(),
)
PY_TEST_PATCH

TEST_STORY="$BUILD/consumable-light-test.ulx"
compile_story "$TEST_SRC" "$BUILD/consumable-light-test.asm" "$TEST_STORY" test

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
    make -C "$ROOT/.tooling/cheapglk"
    make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

run_case() {
    local name="$1"
    timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/$name.txt" > "$BUILD/$name-transcript.txt" 2>&1
}

cat > "$BUILD/bright-colony.txt" <<'EOF_BRIGHT'
clbright
look
examine lamp
lights
clstat
quit
yes
EOF_BRIGHT
run_case bright-colony
F="$BUILD/bright-colony-transcript.txt"
grep -F 'The strong light drives much farther into the cracks' "$F"
grep -F 'throws a broad, steady electric glow' "$F"
grep -F 'current-level=3' "$F"
grep -F 'grue-revealed=1' "$F"

cat > "$BUILD/weak-colony.txt" <<'EOF_WEAK'
clweak
look
examine lamp
lights
clstat
quit
yes
EOF_WEAK
run_case weak-colony
F="$BUILD/weak-colony-transcript.txt"
grep -F 'The weaker light reaches the mouths of the fissures' "$F"
grep -F 'is visibly dimmer now' "$F"
grep -F 'current-level=2' "$F"
grep -F 'grue-revealed=0' "$F"

cat > "$BUILD/ember-emergency.txt" <<'EOF_EMBER'
clember
turn off lamp
light match
lights
clstat
turn on lamp
look
clstat
quit
yes
EOF_EMBER
run_case ember-emergency
F="$BUILD/ember-emergency-transcript.txt"
grep -F "It's pitch black in here" "$F"
grep -F 'Your tiny failing light buys only a close circle around you' "$F"
grep -F 'One match gives a tiny, brief ember-scale circle of light' "$F"
grep -F 'current-level=1' "$F"
grep -F 'grue-revealed=1' "$F"

cat > "$BUILD/wet-candles.txt" <<'EOF_WET'
clwet
use water on candles
examine candles
light match
use match on candles
look
look
light match
use match on candles
examine candles
clstat
quit
yes
EOF_WET
run_case wet-candles
F="$BUILD/wet-candles-transcript.txt"
grep -F 'The flames are gone, and the visibly saturated wicks will need time to dry' "$F"
grep -F 'The wet wicks hiss at the offered flame but refuse to catch' "$F"
grep -F 'The candle wicks have dried from waterlogged to merely waxy' "$F"
grep -F 'The candles are lit.' "$F"
grep -F 'candle-wet=0' "$F"
grep -F 'candles-on=1' "$F"

cat > "$BUILD/smoke-ember.txt" <<'EOF_SMOKE'
clsmoke
look
clstat
quit
yes
EOF_SMOKE
run_case smoke-ember
F="$BUILD/smoke-ember-transcript.txt"
grep -F "The two tiny candle flames cannot survive the Timber Room's hot smoke and hard westward draft" "$F"
grep -F 'candles-on=0' "$F"
grep -F 'fire-stage=2' "$F"

cat > "$BUILD/canonical-torch.txt" <<'EOF_TORCH'
cltorch
look
examine torch
lights
clstat
quit
yes
EOF_TORCH
run_case canonical-torch
F="$BUILD/canonical-torch-transcript.txt"
grep -F 'The strong light drives much farther into the cracks' "$F"
grep -F 'The torch is burning.' "$F"
grep -F 'The ivory torch remains a bright, unwavering open flame.' "$F"
grep -F 'current-level=3' "$F"
grep -F 'grue-revealed=1' "$F"

python - "$STORY" "$MANIFEST" <<'PY_IDENTITY'
import hashlib
import json
import sys
from pathlib import Path

story = Path(sys.argv[1])
manifest_path = Path(sys.argv[2])
manifest = json.loads(manifest_path.read_text())
build = Path("glulx/build/consumable-light-1265")
report = json.loads((build / "story-report.json").read_text())
identity = {
    "file": story.name,
    "format": "Glulx",
    "version_hex": report["version_hex"],
    "size_bytes": story.stat().st_size,
    "checksum_hex": report["checksum_hex"],
    "sha256": hashlib.sha256(story.read_bytes()).hexdigest(),
}
(build / "CANDIDATE-IDENTITY.json").write_text(
    json.dumps(identity, indent=2, sort_keys=True) + "\n"
)
print("RELEASE_1265_ARTIFACT_IDENTITY=" + json.dumps(identity, sort_keys=True))
expected = manifest["expected_artifact"]
if expected.get("locked") is not True:
    (build / "QUALIFICATION-RECEIPT.json").write_text(
        json.dumps(
            {
                "release": 1265,
                "serial": manifest["serial"],
                "artifact_identity_locked": False,
                "candidate": identity,
                "base_release": 1264,
                "base_artifact_sha256": manifest["base_artifact_sha256"],
                "base_source_sha256": manifest["base_source_sha256"],
            },
            indent=2,
            sort_keys=True,
        )
        + "\n"
    )
    raise SystemExit(
        "Release 1265 candidate completed gameplay qualification; "
        "lock the exact artifact identity and rerun."
    )

for key in ("file", "version_hex", "size_bytes", "checksum_hex", "sha256"):
    if expected.get(key) != identity.get(key):
        raise SystemExit(
            f"Release 1265 artifact {key} mismatch: "
            f"expected {expected.get(key)}, got {identity.get(key)}"
        )

receipt = {
    "release": 1265,
    "serial": manifest["serial"],
    "artifact_identity_locked": True,
    "production": {**identity, "report": report},
    "base_release": 1264,
    "base_artifact_sha256": manifest["base_artifact_sha256"],
    "base_source_sha256": manifest["base_source_sha256"],
    "bright_colony": "bright-colony-transcript.txt",
    "weak_colony": "weak-colony-transcript.txt",
    "ember_emergency": "ember-emergency-transcript.txt",
    "wet_candles": "wet-candles-transcript.txt",
    "smoke_ember": "smoke-ember-transcript.txt",
    "canonical_torch": "canonical-torch-transcript.txt",
}
(build / "QUALIFICATION-RECEIPT.json").write_text(
    json.dumps(receipt, indent=2, sort_keys=True) + "\n"
)
print(json.dumps(receipt, indent=2, sort_keys=True))
PY_IDENTITY

echo 'Release 1265 Consumable Light & Graduated Darkness qualified.'
