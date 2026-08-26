#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-field-guidance-1276"
OUT="$ROOT/glulx/build/product-playtest-gauntlet/house"
STORY="$BASE_BUILD/zork1-glulx-mara-field-guidance-earned-clues.ulx"
SCENARIO_SOURCE="$ROOT/glulx/product-playtest-gauntlet/house-full-journey.json"
SCENARIO="$OUT/house-full-journey-effective.json"
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

rm -rf "$OUT"
mkdir -p "$OUT"
test -s "$STORY"
test -x "$GLULXE_BIN"

# Local parser output is immediate. A long timeout hides the exact command seam and
# wastes hosted minutes; keep every expectation strict while failing stalled play fast.
python - "$SCENARIO_SOURCE" "$SCENARIO" <<'PY_SCENARIO'
import json
from pathlib import Path
import sys
src = json.loads(Path(sys.argv[1]).read_text())
src["timeout_seconds"] = 20
Path(sys.argv[2]).write_text(json.dumps(src, indent=2) + "\n")
PY_SCENARIO

SAVE_FILE="$OUT/house-full-journey.sav"
TRANSCRIPT="$OUT/house-full-journey-transcript.txt"

python "$ROOT/glulx/tools/run_interactive_story.py" \
  --scenario "$SCENARIO" \
  --transcript "$TRANSCRIPT" \
  --var HOUSE_SAVE_FILE="$SAVE_FILE" \
  -- "$GLULXE_BIN" --rngseed 123456 "$STORY"

test -s "$SAVE_FILE"
cp "$SCENARIO_SOURCE" "$OUT/house-full-journey-commands.json"
cp "$BASE_BUILD/story-report.json" "$OUT/story-report.json"
git -C "$ROOT" rev-parse HEAD > "$OUT/exact-commit-sha.txt"
git -C "$ROOT/.tooling/glulxe" rev-parse HEAD > "$OUT/glulxe-commit.txt"
git -C "$ROOT/.tooling/cheapglk" rev-parse HEAD > "$OUT/cheapglk-commit.txt"
sha256sum "$STORY" > "$OUT/story-sha256.txt"

python - "$TRANSCRIPT" <<'PY'
from pathlib import Path
import sys

t = Path(sys.argv[1]).read_text(encoding="utf-8", errors="replace")
low = t.lower()

required = [
    "Release 1276",
    "West of House",
    "Living Room",
    "Bedroom",
    "Kitchen",
    "Attic",
    "Cellar",
    "Behind House",
    "House vulnerability status:",
    "A broad wooden worktop supports real food, containers, and tools.",
    "A cast iron range can be lit with a real held flame.",
    "You unwrap and arrange the hot-pepper sandwich on the worktop.",
    "It is a bounded late-1970s archive surface.",
    "Completed expedition archive status: no sealed victory record.",
    "The troll is battered into unconsciousness.",
    "The unconscious troll cannot defend himself: He dies.",
    "The tuft is coarse iron-grey fur",
]
for marker in required:
    if marker not in t:
        raise SystemExit(f"missing House journey marker: {marker}")

# We intentionally try a blocked front-door interaction and the barred Cellar return,
# but the parser itself must understand every phrase the game taught the player.
for forbidden in (
    'i don\'t know the word "gallery"',
    'i don\'t know the word "weapon"',
    'i don\'t know the word "record"',
    'i don\'t know the word "relic"',
    'i don\'t know the word "creatures"',
    'i don\'t know the word "broad"',
    'i don\'t know the word "cast"',
    'i don\'t know the word "porcelain"',
    'i don\'t know the word "archive"',
    'i don\'t know the word "compact"',
    'i don\'t know the word "completed"',
    'i don\'t know the word "staging"',
    'i don\'t know the word "quarantine"',
    'i don\'t know the word "threshold"',
):
    if forbidden in low:
        raise SystemExit(f"parser regression in House journey: {forbidden}")

if "you have died" in low or "you are dead" in low:
    raise SystemExit("House journey died before completing its continued-play leg")

if t.count("Cellar") < 2:
    raise SystemExit("House journey did not revisit the Cellar after the troll encounter")

print("HOUSE_FULL_JOURNEY:PASS")
PY

printf '%s\n' \
  'journey=House of Records full real-player traversal' \
  'state_injection=none' \
  'teleport_commands=none' \
  'save_restore=native parser commands' \
  'continued_play_after_house_mechanics=yes' \
  'continued_play_after_troll_success=yes' \
  > "$OUT/PLAYTEST-NOTES.txt"

echo "House full journey passed; replay evidence: $OUT"
