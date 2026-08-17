#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/learned-magic-1266"
BUILD="$ROOT/glulx/build/semantic-examination-1267"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/semantic-examination/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"

# Re-prove the exact immediate gameplay predecessor before extending it.
bash glulx/learned-magic/qualify.sh
python -m py_compile glulx/semantic-examination/stage.py

python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE_IDS'
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
print("RELEASE_1267_BASE_SOURCE_IDENTITIES=" + json.dumps(ids, sort_keys=True))
Path(sys.argv[4], "BASE-SOURCE-IDENTITIES.json").write_text(
    json.dumps(ids, indent=2, sort_keys=True) + "\n"
)
expected = manifest.get("base_source_sha256") or {}
if expected.get("production") == "UNLOCKED" or expected.get("dev") == "UNLOCKED":
    raise SystemExit(
        "Release 1267 predecessor source identities recovered; pin them in patch-series.json and rerun."
    )
if ids != expected:
    raise SystemExit(
        "Release 1267 predecessor source pins drift: "
        f"expected {expected}, got {ids}"
    )
PY_BASE_IDS

python glulx/semantic-examination/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/semantic-examination/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"

python - <<'PY_STATIC'
import json
import re
from pathlib import Path


def require(condition, message):
    if not condition:
        raise SystemExit(message)

build = Path("glulx/build/semantic-examination-1267")
source = build / "src"
base = Path("glulx/build/learned-magic-1266/src")
manifest = json.loads(Path("glulx/semantic-examination/patch-series.json").read_text())
receipt = json.loads((source / "STAGING-RECEIPT.json").read_text())

require(
    receipt["release"] == 1267 and receipt["base"]["release"] == 1266,
    "Release 1267 staging/base mismatch",
)
require(
    receipt["changed_paths"] == sorted(manifest["expected_changed_paths"]),
    "Release 1267 changed-path mismatch",
)
require(
    not json.loads((build / "smell-report.json").read_text())["errors"],
    "Release 1267 production smell errors",
)
require(
    not json.loads((build / "dev-smell-report.json").read_text())["errors"],
    "Release 1267 dev smell errors",
)

semantic = (source / "semantic_examination.zil").read_text()
zork = (source / "zork1.zil").read_text()
room_density = (source / "room_density.zil").read_text()
for token in (
    "<OBJECT SEMANTIC-TIMBER-DRAFT",
    "<OBJECT SEMANTIC-DRAGON-SCRATCHES",
    "<OBJECT SEMANTIC-DRAGON-BONES",
    "<OBJECT SEMANTIC-DRAGON-BLACKENING",
    "<OBJECT DRAGON-VENT-SEAM",
    "<MOVE ,DRAGON-VENT-SEAM ,DRAGON-GALLERY>",
    "<DRAGON-SMOKE-COVER?>",
    "<FIRE-STRUCTURAL-ACTIVE?>",
):
    require(token in semantic, f"missing Release 1267 semantic token: {token}")
require(
    "SEMANTIC-TROLL" not in semantic,
    "Release 1267 duplicated Troll Room detail authority already owned by Room Density",
)
for inherited in (
    "The old bloodstains have soaked into cracks in the stone.",
    "The scratches are deep, irregular, and mostly at axe height.",
):
    require(inherited in room_density, f"missing inherited Room Density authority: {inherited}")
require(
    re.search(r"(?m)^<GLOBAL\b", semantic) is None,
    "Release 1267 consumed legacy VM globals",
)
require(
    "<OBJECT DRAGON-VENT-SEAM\n    (IN DRAGON-GALLERY)" not in semantic,
    "Release 1267 made the hidden seam guessable before discovery",
)
for name in (
    "1dungeon.zil",
    "room_density.zil",
    "fire_structural.zil",
    "dragon_hoard.zil",
    "learned_magic.zil",
    "gsyntax.zil",
    "gverbs.zil",
):
    require(
        (source / name).read_bytes() == (base / name).read_bytes(),
        f"Release 1267 unexpectedly rewrote existing authority: {name}",
    )
require(
    "<CONSTANT RELEASEID 1267>" in zork
    and '<INSERT-FILE "semantic_examination" T>' in zork,
    "Release 1267 identity/include missing",
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
compile_story "$SRC" "$BUILD/semantic-examination.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"

rm -rf "$TEST_SRC"
cp -a "$DEV_SRC" "$TEST_SRC"
cp glulx/semantic-examination/tests/semantic_examination_test.zil "$TEST_SRC/semantic_examination_test.zil"
python - <<'PY_TEST_PATCH'
from pathlib import Path
import sys
sys.path.insert(0, str(Path("glulx/tools").resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path("glulx/semantic-examination/tests/001-include-semantic-examination-test.json").resolve(),
    Path("glulx/build/semantic-examination-1267/test-src").resolve(),
)
PY_TEST_PATCH

TEST_STORY="$BUILD/semantic-examination-test.ulx"
compile_story "$TEST_SRC" "$BUILD/semantic-examination-test.asm" "$TEST_STORY" test

if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
    make -C "$ROOT/.tooling/cheapglk"
    make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
run_case() {
    local name="$1"
    timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/$name.txt" > "$BUILD/$name-transcript.txt" 2>&1
}

cat > "$BUILD/troll-regression.txt" <<'EOF_TROLL'
sxtroll
examine bloodstains
smell stains
examine scratches
touch scratches
sxstat
quit
yes
EOF_TROLL
run_case troll-regression
F="$BUILD/troll-regression-transcript.txt"
grep -F 'old bloodstains have soaked into cracks in the stone' "$F"
grep -F 'blood is far too old to smell fresh' "$F"
grep -F 'scratches are deep, irregular, and mostly at axe height' "$F"
grep -F 'gouges are rough-edged and deep enough to catch a fingertip' "$F"
grep -F 'troll-cleared=1' "$F"

cat > "$BUILD/timber-draft.txt" <<'EOF_TIMBER'
sxtimber
examine draft
listen to draft
smell draft
sxstat
quit
yes
EOF_TIMBER
run_case timber-draft
F="$BUILD/timber-draft-transcript.txt"
grep -F 'draft is a real current, not atmosphere-by-narrator' "$F"
grep -F 'moving air whistles around splintered timber' "$F"
grep -F 'Cold stone, dry wood, and old mine dust arrive on the moving air.' "$F"
grep -F 'fire-stage=0 smoke-cover=0' "$F"

cat > "$BUILD/approach-evidence.txt" <<'EOF_APPROACH'
sxapproach
examine scratches
touch scratches
examine bones
smell bones
sxstat
quit
yes
EOF_APPROACH
run_case approach-evidence
F="$BUILD/approach-evidence-transcript.txt"
grep -F 'marks dwarf the axe-scars in the Troll Room' "$F"
grep -F 'basalt is chipped inward along each groove' "$F"
grep -F 'bones are old, mixed, and deliberately nosed or kicked against the wall' "$F"
grep -F 'hotter gallery has been occupied for a long time' "$F"

cat > "$BUILD/hidden-seam.txt" <<'EOF_SEAM'
sxgallery
sxstat
examine seam
sxstat
examine blackening
sxstat
examine seam
listen to seam
enter seam
quit
yes
EOF_SEAM
run_case hidden-seam
F="$BUILD/hidden-seam-transcript.txt"
[[ "$(grep -Fc 'seam-discovered=0 fire-stage=0 smoke-cover=0' "$F")" -ge 2 ]]
grep -F "You can't see any seam here!" "$F"
NO_VISIBLE_LINE="$(grep -Fn -m1 "You can't see any seam here!" "$F" | cut -d: -f1)"
REVEAL_LINE="$(grep -Fn -m1 'old ventilation seam cut through the stone' "$F" | cut -d: -f1)"
DISCOVERED_DESCRIPTION_LINE="$(grep -Fn -m1 'The ventilation seam is a narrow engineered break' "$F" | cut -d: -f1)"
[[ "$NO_VISIBLE_LINE" -lt "$REVEAL_LINE" ]]
[[ "$DISCOVERED_DESCRIPTION_LINE" -gt "$REVEAL_LINE" ]]
grep -F 'old ventilation seam cut through the stone' "$F"
grep -F 'seam-discovered=1 fire-stage=0 smoke-cover=0' "$F"
grep -F 'It is an air route, not a person-sized exit and not a new door.' "$F"
grep -F 'air route measured in inches, not an alternate corridor' "$F"

cat > "$BUILD/smoke-seam.txt" <<'EOF_SMOKE'
sxsmoke
examine seam
smell seam
sxstat
quit
yes
EOF_SMOKE
run_case smoke-seam
F="$BUILD/smoke-seam-transcript.txt"
grep -F 'smoke from the Timber Room is curling through the narrow cut' "$F"
grep -F 'existing Timber Room fire' "$F"
grep -F 'seam-discovered=1 fire-stage=2 smoke-cover=1' "$F"

python - "$STORY" "$MANIFEST" <<'PY_IDENTITY'
import hashlib
import json
import sys
from pathlib import Path
story = Path(sys.argv[1])
manifest = json.loads(Path(sys.argv[2]).read_text())
build = Path("glulx/build/semantic-examination-1267")
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
print("RELEASE_1267_ARTIFACT_IDENTITY=" + json.dumps(identity, sort_keys=True))
expected = manifest["expected_artifact"]
receipt = {
    "release": 1267,
    "serial": manifest["serial"],
    "base_release": 1266,
    "base_artifact_sha256": manifest["base_artifact_sha256"],
    "base_source_sha256": manifest["base_source_sha256"],
    "histories": ["troll-regression", "timber-draft", "approach-evidence", "hidden-seam", "smoke-seam"],
}
if expected.get("locked") is not True:
    receipt.update({"artifact_identity_locked": False, "candidate": identity})
    (build / "QUALIFICATION-RECEIPT.json").write_text(
        json.dumps(receipt, indent=2, sort_keys=True) + "\n"
    )
    raise SystemExit(
        "Release 1267 candidate completed gameplay qualification; lock the exact artifact identity and rerun."
    )
for key in ("file", "version_hex", "size_bytes", "checksum_hex", "sha256"):
    if identity.get(key) != expected.get(key):
        raise SystemExit(
            f"Release 1267 artifact drift for {key}: expected {expected.get(key)}, got {identity.get(key)}"
        )
receipt.update({"artifact_identity_locked": True, "artifact": identity})
(build / "QUALIFICATION-RECEIPT.json").write_text(
    json.dumps(receipt, indent=2, sort_keys=True) + "\n"
)
PY_IDENTITY

echo "Release 1267 Semantic Examination qualification passed."
