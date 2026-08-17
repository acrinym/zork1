#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/consumable-light-1265"
BUILD="$ROOT/glulx/build/learned-magic-1266"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/learned-magic/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

# A stacked train proves the immediate gameplay predecessor from scratch.
bash glulx/consumable-light/qualify.sh
python -m py_compile glulx/learned-magic/stage.py

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
print("RELEASE_1266_BASE_SOURCE_IDENTITIES=" + json.dumps(ids, sort_keys=True))
if ids != manifest["base_source_sha256"]:
    raise SystemExit(
        "Release 1266 predecessor source pins drift: "
        f"expected {manifest['base_source_sha256']}, got {ids}"
    )
PY_BASE_IDS

python glulx/learned-magic/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/learned-magic/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
from pathlib import Path


def require(condition, message):
    if not condition:
        raise SystemExit(message)

build = Path("glulx/build/learned-magic-1266")
source = build / "src"
base = Path("glulx/build/consumable-light-1265/src")
manifest = json.loads(Path("glulx/learned-magic/patch-series.json").read_text())
receipt = json.loads((source / "STAGING-RECEIPT.json").read_text())

require(
    receipt["release"] == 1266 and receipt["base"]["release"] == 1265,
    "Release 1266 staging/base mismatch",
)
require(
    receipt["changed_paths"] == sorted(manifest["expected_changed_paths"]),
    "Release 1266 changed-path mismatch",
)
require(
    not json.loads((build / "smell-report.json").read_text())["errors"],
    "Release 1266 production smell errors",
)
require(
    not json.loads((build / "dev-smell-report.json").read_text())["errors"],
    "Release 1266 dev smell errors",
)

magic = (source / "learned_magic.zil").read_text()
zork = (source / "zork1.zil").read_text()
for token in (
    "<SYNTAX STUDY OBJECT",
    "<SYNTAX WARD OBJECT",
    "<SYNTAX KNOWLEDGE = V-LEARNED-KNOWLEDGE>",
    "<GLOBAL LEARNED-STILLING-WARD <>>",
    "<ROUTINE V-LEARNED-STUDY",
    "<ROUTINE V-LEARNED-WARD",
    "<CONSUMABLE-CANDLES-WET?>",
    "<CONSUMABLE-LIGHT-PUT ,CL-CANDLE-WET 0>",
    "<QUEUE I-XBH 0>",
    "<I-XBH>",
):
    require(token in magic, f"missing Release 1266 learned-magic token: {token}")
require(
    "<NOT ,RITUAL-CEREMONY-KNOWN>" in magic,
    "stilling capability can be learned without first reconstructing ritual knowledge",
)
require(
    "<NOT ,LEARNED-STILLING-WARD>" in magic,
    "ward capability is not gated on learned knowledge",
)
for forbidden in (
    "MANA",
    "MAGIC-POINTS",
    "SPELL-SLOTS",
    "SPELLBOOK",
    "GENERIC-SPELL",
    "ENCHANTMENT-REGISTRY",
    "UNIVERSAL-MAGIC",
):
    require(forbidden not in magic, f"Release 1266 crossed generic magic-system boundary: {forbidden}")

# The train composes with exact authorities instead of rewriting them.
for name in (
    "gsyntax.zil",
    "gverbs.zil",
    "ritual_resonance.zil",
    "consumable_light.zil",
    "house_vulnerability.zil",
    "house_vulnerability_actions.zil",
):
    require(
        (source / name).read_bytes() == (base / name).read_bytes(),
        f"Release 1266 unexpectedly rewrote existing authority: {name}",
    )
require(
    "<SYNTAX WARD OBJECT WITH OBJECT = V-HOUSE-RISK-WARD>" in (source / "house_vulnerability.zil").read_text(),
    "existing bounded house ward grammar disappeared",
)
require(
    "<CONSTANT RELEASEID 1266>" in zork and '<INSERT-FILE "learned_magic" T>' in zork,
    "Release 1266 identity/include missing",
)
PY_STATIC

MANIFEST_OUTPUT=$(python - "$MANIFEST" <<'PY_MANIFEST'
import json
import sys
from pathlib import Path
m = json.loads(Path(sys.argv[1]).read_text())
print("\t".join((m["serial"], m["expected_artifact"]["file"])))
PY_MANIFEST
)
IFS=$'\t' read -r SERIAL STORY_FILE <<< "$MANIFEST_OUTPUT"
if [[ -z "$SERIAL" || -z "$STORY_FILE" ]]; then
    echo "ERROR: manifest missing serial or artifact filename" >&2
    exit 1
fi

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
compile_story "$SRC" "$BUILD/learned-magic.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"
cp -a "$DEV_SRC" "$TEST_SRC"
cp glulx/learned-magic/tests/learned_magic_test.zil "$TEST_SRC/learned_magic_test.zil"
python - <<'PY_TEST_PATCH'
from pathlib import Path
import sys
sys.path.insert(0, str(Path("glulx/tools").resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path("glulx/learned-magic/tests/001-include-learned-magic-test.json").resolve(),
    Path("glulx/build/learned-magic-1266/test-src").resolve(),
)
PY_TEST_PATCH

TEST_STORY="$BUILD/learned-magic-test.ulx"
compile_story "$TEST_SRC" "$BUILD/learned-magic-test.asm" "$TEST_STORY" test

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
    make -C "$ROOT/.tooling/cheapglk"
    make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
run_case() {
    local name="$1"
    timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/$name.txt" > "$BUILD/$name-transcript.txt" 2>&1
}

cat > "$BUILD/learning.txt" <<'EOF_LEARNING'
lmbase
ward candles
study book
turn book
study book
knowledge
ward lamp
lmstat
quit
yes
EOF_LEARNING
run_case learning
F="$BUILD/learning-transcript.txt"
grep -F 'solemnity is not technique' "$F"
grep -F 'need to be reconstructed before their marginal notation means enough to learn' "$F"
grep -F 'surviving marginal marks suggest an order: resonance first, paired light second, spoken prayer last' "$F"
grep -F 'memorize the stilling ward' "$F"
grep -F 'Learned technique: stilling ward' "$F"
grep -F 'not a generic enchantment' "$F"
grep -F 'known=1 untaught-fail=1' "$F"

cat > "$BUILD/wet-ward.txt" <<'EOF_WET'
lmwet
ward candles
examine candles
lmstat
quit
yes
EOF_WET
run_case wet-ward
F="$BUILD/wet-ward-transcript.txt"
grep -F 'leaving the wicks dry enough to accept flame again. They remain unlit.' "$F"
grep -F 'candle-wet=0 candles-on=0' "$F"
grep -F 'candles-dried=1' "$F"

cat > "$BUILD/hot-bell-ward.txt" <<'EOF_BELL'
lmritual
ring bell
ward bell
lmstat
quit
yes
EOF_BELL
run_case hot-bell-ward
F="$BUILD/hot-bell-ward-transcript.txt"
grep -F 'The bell suddenly becomes red hot and falls to the ground.' "$F"
grep -F 'You close the learned gesture over the red-hot bell.' "$F"
grep -F 'The bell appears to have cooled down.' "$F"
grep -F 'bell-cooled=1' "$F"
grep -F 'bell-present=1 hot-bell-present=0 xb=1' "$F"

cat > "$BUILD/house-ward-grammar.txt" <<'EOF_HOUSE'
lmhouse
ward house with garlic
lmstat
quit
yes
EOF_HOUSE
run_case house-ward-grammar
F="$BUILD/house-ward-grammar-transcript.txt"
grep -F 'No active supernatural house disturbance requires a ward.' "$F"
grep -F 'known=1' "$F"

python - "$STORY" "$MANIFEST" <<'PY_IDENTITY'
import hashlib
import json
import sys
from pathlib import Path
story = Path(sys.argv[1])
manifest = json.loads(Path(sys.argv[2]).read_text())
build = Path("glulx/build/learned-magic-1266")
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
print("RELEASE_1266_ARTIFACT_IDENTITY=" + json.dumps(identity, sort_keys=True))
expected = manifest["expected_artifact"]
if expected.get("locked") is not True:
    (build / "QUALIFICATION-RECEIPT.json").write_text(
        json.dumps({
            "release": 1266,
            "serial": manifest["serial"],
            "artifact_identity_locked": False,
            "candidate": identity,
            "base_release": 1265,
            "base_artifact_sha256": manifest["base_artifact_sha256"],
            "base_source_sha256": manifest["base_source_sha256"],
            "histories": ["learning", "wet-ward", "hot-bell-ward", "house-ward-grammar"],
        }, indent=2, sort_keys=True) + "\n"
    )
    raise SystemExit(
        "Release 1266 candidate completed gameplay qualification; lock the exact artifact identity and rerun."
    )
for key in ("file", "version_hex", "size_bytes", "checksum_hex", "sha256"):
    if identity.get(key) != expected.get(key):
        raise SystemExit(f"Release 1266 artifact drift for {key}: expected {expected.get(key)}, got {identity.get(key)}")
(build / "QUALIFICATION-RECEIPT.json").write_text(
    json.dumps({
        "release": 1266,
        "serial": manifest["serial"],
        "artifact_identity_locked": True,
        "artifact": identity,
        "base_release": 1265,
        "base_artifact_sha256": manifest["base_artifact_sha256"],
        "base_source_sha256": manifest["base_source_sha256"],
        "histories": ["learning", "wet-ward", "hot-bell-ward", "house-ward-grammar"],
    }, indent=2, sort_keys=True) + "\n"
)
PY_IDENTITY

echo "Release 1266 Learned Magic qualification passed."
