#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-field-guidance-1276"
OUT="$ROOT/glulx/build/product-playtest-gauntlet/cross-region"
STORY="$BASE_BUILD/zork1-glulx-mara-field-guidance-earned-clues.ulx"
SCENARIO_SOURCE="$ROOT/glulx/product-playtest-gauntlet/cross-region-expedition.json"
SCENARIO="$OUT/cross-region-expedition-effective.json"
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

rm -rf "$OUT"
mkdir -p "$OUT"
test -s "$STORY"
test -x "$GLULXE_BIN"

python - "$SCENARIO_SOURCE" "$SCENARIO" <<'PY_SCENARIO'
import json
from pathlib import Path
import sys

src = json.loads(Path(sys.argv[1]).read_text())
src["timeout_seconds"] = 20
Path(sys.argv[2]).write_text(json.dumps(src, indent=2) + "\n")

commands = [step["sendline"] for step in src["steps"] if "sendline" in step]
if len(commands) < 120:
    raise SystemExit(f"cross-region expedition unexpectedly short: {len(commands)} commands")

for forbidden in (
    "maraprep", "maraload", "mararestprep", "marainjured", "marafield",
    "maracanyon", "mfgprep", "mfg", "teleport", "goto ", "psetup",
    "pobserve", "pready", "preport", "pstate", "pmutate",
):
    if any(cmd.lower().startswith(forbidden) for cmd in commands):
        raise SystemExit(f"cross-region expedition contains forbidden setup/teleport command: {forbidden}")
PY_SCENARIO

SAVE_FILE="$OUT/cross-region-expedition.sav"
TRANSCRIPT="$OUT/cross-region-expedition-transcript.txt"

python "$ROOT/glulx/tools/run_interactive_story.py" \
  --scenario "$SCENARIO" \
  --transcript "$TRANSCRIPT" \
  --var CROSS_REGION_SAVE_FILE="$SAVE_FILE" \
  -- "$GLULXE_BIN" --rngseed 123456 "$STORY"

test -s "$SAVE_FILE"
cp "$SCENARIO_SOURCE" "$OUT/cross-region-expedition-commands.json"
cp "$BASE_BUILD/story-report.json" "$OUT/story-report.json"
git -C "$ROOT" rev-parse HEAD > "$OUT/exact-commit-sha.txt"
git -C "$ROOT/.tooling/glulxe" rev-parse HEAD > "$OUT/glulxe-commit.txt"
git -C "$ROOT/.tooling/cheapglk" rev-parse HEAD > "$OUT/cheapglk-commit.txt"
sha256sum "$STORY" > "$OUT/story-sha256.txt"

python - "$TRANSCRIPT" <<'PY_VALIDATE'
from pathlib import Path
import sys

t = Path(sys.argv[1]).read_text(encoding="utf-8", errors="replace")
low = t.lower()

required = [
    "Release 1276",
    "West Court",
    "old forester's machete",
    "Mara Tallow is here with a waxed survey book",
    "first shared entry in the Last Honest Survey",
    "The same trap door that locked behind you now stands open above the same stair",
    "The route exists because you made a route",
    "The fox tracks leave the muddy run southwest",
    "Basin Overlook",
    "South of the overlook I can see a warm wet descent",
    "I have not entered it",
    "I watched you leave the wrench at Basin Overlook",
    "Warmrain Canopy Edge",
    "Leafcutter Ridge",
    "Warmrain Hot Spring",
    "Glass Frog Pool",
    "route I did not enter when you did",
    "still where it is",
    "Living Room",
]
for marker in required:
    if marker not in t:
        raise SystemExit(f"missing cross-region expedition marker: {marker}")

if t.count("Basin Overlook") < 3:
    raise SystemExit("cross-region expedition did not leave and physically return to Mara's Warmrain boundary")
if t.count("Living Room") < 3:
    raise SystemExit("cross-region expedition did not prove House departure/underground return/final regional return")
if t.count("Warmrain Hot Spring") < 2:
    raise SystemExit("cross-region expedition did not prove native save/restore in solo Warmrain traversal")

for forbidden in (
    "you have died",
    "you are dead",
    'i don\'t know the word "machete"',
    'i don\'t know the word "leafcutters"',
    'i don\'t know the word "warmrain"',
    "no veteran expedition is active",
):
    if forbidden in low:
        raise SystemExit(f"cross-region expedition regression/death: {forbidden}")

print("CROSS_REGION_EXPEDITION:PASS")
PY_VALIDATE

printf '%s\n' \
  'journey=House underground Mara Ashglass Western Backcountry Warmrain and physical return' \
  'locked_story=Release 1276 exact qualified artifact' \
  'state_injection=none' \
  'test_setup_commands=none' \
  'teleport_commands=none' \
  'save_restore=native parser commands while solo beyond Mara field knowledge' \
  'mara=real Dam survey field guidance fox finding Warmrain boundary witnessed cache reunion' \
  'ashglass=physical machete acquisition from West Court' \
  'backcountry=physical brush opening and ordinary room traversal' \
  'warmrain=solo leafcutter caiman-side hot-spring frog traversal' \
  'return=Warmrain to Mara to Western Backcountry to House' \
  'full_transcript=yes' \
  > "$OUT/PLAYTEST-NOTES.txt"

echo "Cross-region expedition passed; replay evidence: $OUT"
