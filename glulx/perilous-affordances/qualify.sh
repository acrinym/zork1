#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/ablative-protection-1263"
BUILD="$ROOT/glulx/build/perilous-affordances-1264"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/perilous-affordances/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

# The predecessor is not trusted because it once passed. Re-run the exact locked
# Release 1263 qualification and stage only over the source trees it just proved.
bash glulx/ablative-protection/qualify.sh
python -m py_compile glulx/perilous-affordances/stage.py

python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" <<'PY_BASE_IDS'
import hashlib, json, sys
from pathlib import Path

def identity(root: str) -> str:
    root_path = Path(root)
    files = {
        p.relative_to(root_path).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest()
        for p in sorted(root_path.rglob("*"))
        if p.is_file() and p.name != "STAGING-RECEIPT.json"
    }
    return hashlib.sha256(json.dumps(files, sort_keys=True, separators=(",", ":")).encode()).hexdigest()

manifest = json.loads(Path(sys.argv[3]).read_text())
ids = {"production": identity(sys.argv[1]), "dev": identity(sys.argv[2])}
print("RELEASE_1264_BASE_SOURCE_IDENTITIES=" + json.dumps(ids, sort_keys=True))
if ids != manifest["base_source_sha256"]:
    raise SystemExit(f"Release 1264 predecessor source pins drift: expected {manifest['base_source_sha256']}, got {ids}")
PY_BASE_IDS

python glulx/perilous-affordances/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/perilous-affordances/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path

def require(condition, message):
    if not condition:
        raise SystemExit(message)

build = Path("glulx/build/perilous-affordances-1264")
source = build / "src"
base = Path("glulx/build/ablative-protection-1263/src")
manifest = json.loads(Path("glulx/perilous-affordances/patch-series.json").read_text())
receipt = json.loads((source / "STAGING-RECEIPT.json").read_text())
require(receipt["release"] == 1264 and receipt["base"]["release"] == 1263, "Release 1264 staging/base mismatch")
require(receipt["changed_paths"] == sorted(manifest["expected_changed_paths"]), "Release 1264 changed-path mismatch")
require(not json.loads((build / "smell-report.json").read_text())["errors"], "Release 1264 production smell errors")
require(not json.loads((build / "dev-smell-report.json").read_text())["errors"], "Release 1264 dev smell errors")

ablative = (source / "ablative_protection.zil").read_text()
dragons = (source / "dragon_hoard.zil").read_text()
actions = (source / "1actions.zil").read_text()
dungeon = (source / "1dungeon.zil").read_text()
perilous = (source / "perilous_affordances.zil").read_text()
zork = (source / "zork1.zil").read_text()
for token in ("PERILOUS-BREAK-LAMP", "PERILOUS-DESTROY-ROPE"):
    require(token in actions, f"missing Release 1264 action route: {token}")
require("(FLAGS TAKEBIT SACREDBIT TRYTAKEBIT BURNBIT)" in dungeon, "canonical rope is not discoverable by existing BURN grammar")
for token in ("AP-RUINED", "PERILOUS-SCREEN-ACTION", "TAKEBIT BURNBIT"):
    require(token in ablative, f"missing Release 1264 screen token: {token}")
require("PERILOUS-BREAK-STAR-GLASS" in dragons, "missing star-glass destructive route")
for token in ("<ROUTINE PERILOUS-BREAK-LAMP", "<ROUTINE PERILOUS-DESTROY-ROPE", "<ROUTINE PERILOUS-SCREEN-ACTION", "<ROUTINE PERILOUS-BREAK-STAR-GLASS"):
    require(token in perilous, f"missing authored perilous routine: {token}")
for forbidden in ("DURABILITY", "ARMOR-CLASS", "HIT-POINT", "CRAFTING-REGISTRY", "MATERIAL-TYPE-REGISTRY", "BAD-CHOICE-COUNTER"):
    require(forbidden not in perilous, f"Release 1264 crossed generic-system boundary: {forbidden}")
require((source / "gsyntax.zil").read_bytes() == (base / "gsyntax.zil").read_bytes(), "Release 1264 changed parser grammar")
require((source / "gverbs.zil").read_bytes() == (base / "gverbs.zil").read_bytes(), "Release 1264 changed generic verb authority")
require("<CONSTANT RELEASEID 1264>" in zork and '<INSERT-FILE "perilous_affordances" T>' in zork, "Release 1264 identity/include missing")
PY_STATIC

IFS=$'\t' read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY_MANIFEST'
import json, sys
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
compile_story "$SRC" "$BUILD/perilous-affordances.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"
cp -a "$DEV_SRC" "$TEST_SRC"
cp glulx/perilous-affordances/tests/perilous_affordances_test.zil "$TEST_SRC/perilous_affordances_test.zil"
python - <<'PY_TEST_PATCH'
from pathlib import Path
import sys
sys.path.insert(0, str(Path("glulx/tools").resolve()))
from stage_release120 import apply_patch
apply_patch(Path("glulx/perilous-affordances/tests/001-include-perilous-test.json").resolve(), Path("glulx/build/perilous-affordances-1264/test-src").resolve())
PY_TEST_PATCH
TEST_STORY="$BUILD/perilous-affordances-test.ulx"
compile_story "$TEST_SRC" "$BUILD/perilous-affordances-test.asm" "$TEST_STORY" test

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
    make -C "$ROOT/.tooling/cheapglk"
    make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
run_case() {
    local name="$1"
    timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/$name.txt" > "$BUILD/$name-transcript.txt" 2>&1
}

cat > "$BUILD/lamp-break.txt" <<'EOF_LAMP'
palamp
turn on lamp
break lamp with sword
take broken lantern
inventory
pastat
quit
yes
EOF_LAMP
run_case lamp-break
F="$BUILD/lamp-break-transcript.txt"
grep -F 'The same broken lantern left by a hard throw' "$F"
grep -F 'lamp-live=0' "$F"
grep -F 'broken-lamp=1' "$F"

cat > "$BUILD/rope-recovery.txt" <<'EOF_ROPE'
parope
use rope on me
burn rope with torch
use water on me
diagnose
pastat
quit
yes
EOF_ROPE
run_case rope-recovery
F="$BUILD/rope-recovery-transcript.txt"
grep -F 'The hemp around your legs catches exactly as hemp should' "$F"
grep -F 'You drench the burning cloth' "$F"
grep -F 'rope-live=0 self-tied=0 self-fire=0' "$F"

cat > "$BUILD/screen-cost.txt" <<'EOF_SCREEN'
pascrn
burn screen with torch
examine screen
north
use screen on me
examine dragon
pastat
quit
yes
EOF_SCREEN
run_case screen-cost
F="$BUILD/screen-cost-transcript.txt"
grep -F 'spent in advance the first layer of material' "$F"
grep -F 'A second blast catches the already-shrunken hide' "$F"
grep -F 'screen-condition=2' "$F"

cat > "$BUILD/star-substitute.txt" <<'EOF_STAR'
pastar
break glass with sword
north
give chalice to dragon
east
take circlet
inventory
pastat
quit
yes
EOF_STAR
run_case star-substitute
F="$BUILD/star-substitute-transcript.txt"
grep -F 'It fractures with a bright crystalline snap' "$F"
grep -F 'A bargain has occurred' "$F"
grep -F 'star-live=0' "$F"
grep -F 'circlet-held=1' "$F"

cat > "$BUILD/normal-lamp-rope.txt" <<'EOF_NORMAL_ROPE'
panorm
turn on lamp
tie rope to railing
climb down rope
look
pastat
quit
yes
EOF_NORMAL_ROPE
run_case normal-lamp-rope
F="$BUILD/normal-lamp-rope-transcript.txt"
grep -F 'The rope drops over the side and comes within ten feet of the floor' "$F"
grep -F 'Torch Room' "$F"
grep -F 'rope-live=1' "$F"

cat > "$BUILD/normal-star.txt" <<'EOF_NORMAL_STAR'
panstr
north
give glass to dragon
east
pastat
quit
yes
EOF_NORMAL_STAR
run_case normal-star
F="$BUILD/normal-star-transcript.txt"
grep -F 'A bargain has occurred' "$F"
grep -F 'Hoard Vault' "$F"
grep -F 'star-live=1' "$F"

python - "$STORY" "$MANIFEST" <<'PY_IDENTITY'
import hashlib, json, sys
from pathlib import Path
story = Path(sys.argv[1])
manifest_path = Path(sys.argv[2])
manifest = json.loads(manifest_path.read_text())
build = Path("glulx/build/perilous-affordances-1264")
report = json.loads((build / "story-report.json").read_text())
identity = {
    "file": story.name,
    "format": "Glulx",
    "version_hex": report["version_hex"],
    "size_bytes": story.stat().st_size,
    "checksum_hex": report["checksum_hex"],
    "sha256": hashlib.sha256(story.read_bytes()).hexdigest(),
}
(build / "CANDIDATE-IDENTITY.json").write_text(json.dumps(identity, indent=2, sort_keys=True) + "\n")
print("RELEASE_1264_ARTIFACT_IDENTITY=" + json.dumps(identity, sort_keys=True))
expected = manifest["expected_artifact"]
if expected.get("locked") is not True:
    (build / "QUALIFICATION-RECEIPT.json").write_text(json.dumps({
        "release": 1264,
        "serial": manifest["serial"],
        "artifact_identity_locked": False,
        "candidate": identity,
        "base_release": 1263,
        "base_artifact_sha256": manifest["base_artifact_sha256"],
        "base_source_sha256": manifest["base_source_sha256"],
    }, indent=2, sort_keys=True) + "\n")
    raise SystemExit("Release 1264 candidate completed gameplay qualification; lock the exact artifact identity and rerun.")
for key in ("file", "version_hex", "size_bytes", "checksum_hex", "sha256"):
    if expected.get(key) != identity.get(key):
        raise SystemExit(f"Release 1264 artifact {key} mismatch: expected {expected.get(key)}, got {identity.get(key)}")
receipt = {
    "release": 1264,
    "serial": manifest["serial"],
    "artifact_identity_locked": True,
    "production": {**identity, "report": report},
    "base_release": 1263,
    "base_artifact_sha256": manifest["base_artifact_sha256"],
    "base_source_sha256": manifest["base_source_sha256"],
    "lamp_break": "lamp-break-transcript.txt",
    "rope_recovery": "rope-recovery-transcript.txt",
    "screen_cost": "screen-cost-transcript.txt",
    "star_substitute": "star-substitute-transcript.txt",
    "normal_lamp_rope": "normal-lamp-rope-transcript.txt",
    "normal_star": "normal-star-transcript.txt",
}
(build / "QUALIFICATION-RECEIPT.json").write_text(json.dumps(receipt, indent=2, sort_keys=True) + "\n")
print(json.dumps(receipt, indent=2, sort_keys=True))
PY_IDENTITY

echo 'Release 1264 Perilous Affordances / Let the Player Be Wrong qualified.'
