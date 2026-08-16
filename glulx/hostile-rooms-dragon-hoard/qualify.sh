#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-anticipation-protective-initiative-1261"
BUILD="$ROOT/glulx/build/hostile-rooms-dragon-hoard-1262"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/hostile-rooms-dragon-hoard/patch-series.json"

rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

# Release 1262 is qualified only over the exact locked Release 1261 predecessor.
bash glulx/mara-anticipation/qualify.sh
python -m py_compile glulx/hostile-rooms-dragon-hoard/stage.py

python - "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import importlib.util, json, sys
from pathlib import Path
spec = importlib.util.spec_from_file_location("stage1262", "glulx/hostile-rooms-dragon-hoard/stage.py")
mod = importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
manifest = json.loads(Path(sys.argv[1]).read_text())
actual = {
    "production": mod.source_identity(Path(sys.argv[2])),
    "dev": mod.source_identity(Path(sys.argv[3])),
}
print("RELEASE_1262_BASE_SOURCE_IDENTITIES=" + json.dumps(actual, sort_keys=True))
pins = manifest.get("base_source_sha256") or {}
if pins:
    for profile, identity in actual.items():
        if pins.get(profile) != identity:
            raise SystemExit(
                f"Release 1261 {profile} source identity drift: expected {pins.get(profile)}, got {identity}"
            )
PY

python glulx/hostile-rooms-dragon-hoard/stage.py \
  --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/hostile-rooms-dragon-hoard/stage.py \
  --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY'
import json
from pathlib import Path

def require(condition, message):
    if not condition:
        raise SystemExit(message)

b = Path("glulx/build/hostile-rooms-dragon-hoard-1262")
s = b / "src"; d = b / "dev-src"
base = Path("glulx/build/mara-anticipation-protective-initiative-1261/src")
stage = json.loads((s / "STAGING-RECEIPT.json").read_text())
dev = json.loads((d / "STAGING-RECEIPT.json").read_text())
smell = json.loads((b / "smell-report.json").read_text())
dev_smell = json.loads((b / "dev-smell-report.json").read_text())
manifest = json.loads(Path("glulx/hostile-rooms-dragon-hoard/patch-series.json").read_text())
expected = sorted(manifest["expected_changed_paths"])
require(stage["release"] == 1262 and stage["base"]["release"] == 1261,
        "Release 1262 staging receipt/base mismatch")
require(stage["base"]["artifact_sha256"] ==
        "bc6f86c43803994143e5e188b8256d5ac681b51f1ab7711aeed27bbd4c6208a4",
        "Release 1262 predecessor artifact drift")
require(stage["changed_paths"] == expected and dev["changed_paths"] == expected,
        "Release 1262 changed-path receipt mismatch")
require(stage["dev_mode"] is False and dev["dev_mode"] is True,
        "Release 1262 production/dev staging profile mismatch")
require(not smell["errors"] and not dev_smell["errors"],
        "Release 1262 smell check reported errors")

dragon = (s / "dragon_hoard.zil").read_text()
dungeon = (s / "1dungeon.zil").read_text()
fire = (s / "fire_structural.zil").read_text()
zork = (s / "zork1.zil").read_text()
for token in (
    "<ROOM DRAGON-APPROACH", "<ROOM DRAGON-GALLERY", "<ROOM DRAGON-HOARD-VAULT",
    "<OBJECT HOARD-DRAGON", "<OBJECT DRAGON-CHAIN", "<OBJECT DRAGON-GRILLE",
    "<OBJECT ASHEN-CIRCLET", "<OBJECT STAR-GLASS",
    "<ROUTINE DRAGON-ACCEPT-TOLL", "<ROUTINE DRAGON-LURE", "<ROUTINE DRAGON-PULL-CHAIN",
    "<ROUTINE DRAGON-SMOKE-COVER?", "<FIRE-STRUCTURAL-STAGE>",
    "physically occupied, not parser-locked", "one thing from the hoard",
):
    require(token in dragon, f"missing Release 1262 dragon token: {token}")
for forbidden in (
    "DRAGON_HP", "DRAGON-HP", "HIT-POINT", "COMBAT-INITIATIVE", "HOSTILITY-METER",
    "GENERIC-ENEMY", "RANDOM-ATTACK",
):
    require(forbidden not in dragon,
            f"Release 1262 crossed generic-threat boundary: {forbidden}")
require("(NORTH TO DRAGON-APPROACH)" in dungeon,
        "Timber Room does not expose the dragon approach")
require("A soot-dark cleft in the north wall climbs toward hotter basalt." in fire,
        "dynamic Timber Room descriptions do not reveal the new north route")
require((s / "gverbs.zil").read_bytes() == (base / "gverbs.zil").read_bytes(),
        "Release 1262 changed canonical parser verb authority")
require((s / "1actions.zil").read_bytes() == (base / "1actions.zil").read_bytes(),
        "Release 1262 changed canonical action authority")
require("<CONSTANT RELEASEID 1262>" in zork and
        "HOSTILE ROOMS AND REACTIVE THREATS GLULX" in zork,
        "Release 1262 identity missing")
require('<INSERT-FILE "dragon_hoard" T>' in zork,
        "Release 1262 production module is not included")
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
compile_story "$SRC" "$BUILD/hostile-rooms-dragon-hoard.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"
cp -a "$DEV_SRC" "$TEST_SRC"
cp glulx/hostile-rooms-dragon-hoard/tests/dragon_hoard_test.zil "$TEST_SRC/dragon_hoard_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0, str(Path("glulx/tools").resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path("glulx/hostile-rooms-dragon-hoard/tests/001-include-dragon-test.json").resolve(),
    Path("glulx/build/hostile-rooms-dragon-hoard-1262/test-src").resolve(),
)
PY
TEST_STORY="$BUILD/dragon-hoard-test.ulx"
compile_story "$TEST_SRC" "$BUILD/dragon-hoard-test.asm" "$TEST_STORY" test
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

cat > "$BUILD/bargain.txt" <<'EOF1'
dragonprep
give chalice to dragon
east
take ashen circlet
west
dragonstatus
quit
yes
EOF1
run_case bargain
B="$BUILD/bargain-transcript.txt"
grep -F 'A bargain has occurred' "$B"
grep -F 'passage, and one thing from the hoard' "$B"
grep -F 'ashen silver circlet' "$B"
grep -F 'toll=1' "$B"
grep -F 'hoard-taken=1' "$B"

cat > "$BUILD/containment.txt" <<'EOF2'
dragonprep
drop chalice
pull chain
east
take ashen circlet
take star-glass
west
dragonstatus
quit
yes
EOF2
run_case containment
C="$BUILD/containment-transcript.txt"
grep -F 'Greed wins a very small argument with vigilance' "$C"
grep -F 'physically contained' "$C"
grep -F 'ashen silver circlet' "$C"
grep -F 'piece of star-glass' "$C"
grep -F 'contained=1' "$C"

cat > "$BUILD/smoke-leverage.txt" <<'EOF3'
dragonfireprep
burn timbers with torch
look
north
north
east
take star-glass
dragonstatus
quit
yes
EOF3
run_case smoke-leverage
S="$BUILD/smoke-leverage-transcript.txt"
grep -F 'Flame runs along the dry grain' "$S"
grep -F 'Smoke from the Timber Room is now pouring through the old ventilation seam' "$S"
grep -F 'piece of star-glass' "$S"
grep -F 'fire-stage=2' "$S"

cat > "$BUILD/ignored-warning.txt" <<'EOF4'
dragonprep
examine dragon
listen to dragon
no
quit
yes
EOF4
run_case ignored-warning
I="$BUILD/ignored-warning-transcript.txt"
grep -F 'spent one opportunity in a room containing a live territorial animal' "$I"
grep -F 'The first wash of fire turns the air white' "$I"

cat > "$BUILD/retreat.txt" <<'EOF5'
dragonprep
south
south
look
quit
yes
EOF5
run_case retreat
R="$BUILD/retreat-transcript.txt"
grep -F 'Scorched Cleft' "$R"
grep -F 'Timber Room' "$R"
if grep -Fq 'The first wash of fire turns the air white' "$R"; then
  echo 'Release 1262 retreat path incorrectly triggered dragon breath' >&2
  exit 1
fi

python - "$STORY" "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import hashlib, importlib.util, json, sys
from pathlib import Path
story = Path(sys.argv[1]); manifest_path = Path(sys.argv[2])
base_src = Path(sys.argv[3]); base_dev_src = Path(sys.argv[4])
manifest = json.loads(manifest_path.read_text())
b = Path("glulx/build/hostile-rooms-dragon-hoard-1262")
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
    raise SystemExit("Release 1262 artifact checksum is invalid")
(b / "CANDIDATE-IDENTITY.json").write_text(json.dumps(identity, indent=2, sort_keys=True) + "\n")
spec = importlib.util.spec_from_file_location("stage1262", "glulx/hostile-rooms-dragon-hoard/stage.py")
mod = importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
base_identities = {
    "production": mod.source_identity(base_src),
    "dev": mod.source_identity(base_dev_src),
}
(b / "BASE-SOURCE-IDENTITIES.json").write_text(json.dumps(base_identities, indent=2, sort_keys=True) + "\n")
expected = manifest["expected_artifact"]
pins = manifest.get("base_source_sha256") or {}
if not pins or expected.get("locked") is not True:
    print("RELEASE_1262_BASE_SOURCE_IDENTITIES=" + json.dumps(base_identities, sort_keys=True))
    print("RELEASE_1262_ARTIFACT_IDENTITY=" + json.dumps(identity, sort_keys=True))
    raise SystemExit(4)
for profile, value in base_identities.items():
    if pins.get(profile) != value:
        raise SystemExit(f"Release 1262 base source {profile} mismatch")
for key in ("file", "version_hex", "size_bytes", "checksum_hex", "sha256"):
    if expected.get(key) != identity.get(key):
        raise SystemExit(
            f"Release 1262 artifact {key} mismatch: expected {expected.get(key)}, got {identity.get(key)}"
        )
receipt = {
    "release": 1262,
    "serial": manifest["serial"],
    "artifact_identity_locked": True,
    "production": {**identity, "report": report},
    "base_release": 1261,
    "base_artifact_sha256": manifest["base_artifact_sha256"],
    "base_source_sha256": base_identities,
    "bargain": "bargain-transcript.txt",
    "containment": "containment-transcript.txt",
    "smoke_leverage": "smoke-leverage-transcript.txt",
    "ignored_warning": "ignored-warning-transcript.txt",
    "retreat": "retreat-transcript.txt",
}
(b / "QUALIFICATION-RECEIPT.json").write_text(json.dumps(receipt, indent=2, sort_keys=True) + "\n")
print(json.dumps(receipt, indent=2, sort_keys=True))
PY

echo "Release 1262 Hostile Rooms & Reactive Threats qualified."
