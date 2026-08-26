#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-field-guidance-1276"
OUT="$ROOT/glulx/build/product-playtest-gauntlet/mara"
STORY="$BASE_BUILD/zork1-glulx-mara-field-guidance-earned-clues.ulx"
SCENARIO_SOURCE="$ROOT/glulx/product-playtest-gauntlet/mara-full-system.json"
SCENARIO="$OUT/mara-full-system-effective.json"
GLULXE_BIN="$(realpath "$ROOT/.tooling/glulxe/glulxe")"

rm -rf "$OUT"
mkdir -p "$OUT"
test -s "$STORY"
test -x "$GLULXE_BIN"

# The checked-in journey is deliberately human-scale and source-readable. Keep
# each prompt expectation fast so a bad command exposes the exact seam instead
# of occupying hosted minutes behind a generous whole-journey timeout.
python - "$SCENARIO_SOURCE" "$SCENARIO" <<'PY_SCENARIO'
import json
from pathlib import Path
import sys
src = json.loads(Path(sys.argv[1]).read_text())
src["timeout_seconds"] = 20
Path(sys.argv[2]).write_text(json.dumps(src, indent=2) + "\n")

commands = [step["sendline"] for step in src["steps"] if "sendline" in step]
for forbidden in (
    "maraprep", "maraload", "mararestprep", "marainjured", "marafield",
    "maracanyon", "mfgprep", "mfg", "teleport", "goto ",
):
    if any(cmd.lower().startswith(forbidden) for cmd in commands):
        raise SystemExit(f"Mara product playtest contains forbidden setup/teleport command: {forbidden}")
PY_SCENARIO

SAVE_FILE="$OUT/mara-full-system.sav"
TRANSCRIPT="$OUT/mara-full-system-transcript.txt"

python "$ROOT/glulx/tools/run_interactive_story.py" \
  --scenario "$SCENARIO" \
  --transcript "$TRANSCRIPT" \
  --var MARA_SAVE_FILE="$SAVE_FILE" \
  -- "$GLULXE_BIN" --rngseed 123456 "$STORY"

test -s "$SAVE_FILE"
cp "$SCENARIO_SOURCE" "$OUT/mara-full-system-commands.json"
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
    "Mara Tallow is here with a waxed survey book",
    "I am reconstructing the Last Honest Survey of the Great Underground Empire",
    "She remembers an actual object, not a gift transaction",
    "That one Mara knows because she held it",
    "Mara plants one boot against the stone curb and braces the control panel",
    "Mara keeps both hands against the shuddering panel while the bolt turns",
    "The first shared entry in the Last Honest Survey now exists as a physical document",
    "Repetition does not turn gratitude into currency",
    "The boundary is calm and complete",
    "I watched you leave the museum fishing rod at Dam",
    "but it is not there now",
    "As far as the evidence I possess goes, that is still where it is",
    "you may not issue it as hers",
    "do not call the result unforeseeable",
    "She retreats to the lobby",
    "An apology that leaves the water running is merely another sound in the room",
    "Repair first; interpretation afterward",
    "That is a beginning, she says",
    "Evidence observed, animal alive, custody closed",
    "I'll take the first run",
    "Her field rope lands in your hands",
    "Keep the useful end in your hands and get me back onto the platform first",
    "That was a rescue",
    "Promise kept",
    "Mara's rope goes hard across your chest",
    "without volunteering what caught her attention",
    "old survey punch under the lower retaining bolt",
    "The numbers work, she says. My shoulder does not",
    "Before you can put a hand on the maintenance ladder",
    "The warning is now part of what you chose with knowledge",
    "The anger is the easy part",
    "This time you chose me as the danger's target",
    "Distance is the current answer",
    "I need space",
    "Thank you. You heard the part where I asked for space",
    "You changed the action instead of arguing with the boundary",
    "The same trap door that locked behind you now stands open above the same stair",
    "my field pack is still at the Dam",
    "Nothing changes custody: the pack was hers at the Dam and is hers on the road",
    "For now, the House contains one more actual life",
    "one physical meal becomes two eaten portions",
    "That is friendship with weight in the world",
    "not permission to skip the history that has not happened yet",
    "Recovery is not erasure",
    "The ladder happened, she says. The shoulder healed",
    "I knew the numbers. I did not know I could do that",
    "geometry still works when I am the moving point",
    "I thought I was estimating",
    "I did not know I had trained my ear to measure empty space",
    "Apparently I can do this on purpose",
    "the Loud Room proved the ranging was repeatable",
]
for marker in required:
    if marker not in t:
        raise SystemExit(f"missing Mara full-system marker: {marker}")

if t.count("As far as the evidence I possess goes, that is still where it is") < 2:
    raise SystemExit("Mara cache/save-state placement was not observed both before and after restore")

for forbidden in (
    'i don\'t know the word "mara"',
    'i don\'t know the word "survey"',
    'i don\'t know the word "cache"',
    'i don\'t know the word "promise"',
    'i don\'t know the word "rescue"',
    'i don\'t know the word "rupture"',
    'i don\'t know the word "abilities"',
    'i don\'t know the word "acoustics"',
    'you may know how to do that, but i don\'t.',
):
    if forbidden in low:
        raise SystemExit(f"parser regression in Mara full-system journey: {forbidden}")

if "you have died" in low or "you are dead" in low:
    raise SystemExit("Mara full-system journey died before completing continued play")

print("MARA_FULL_SYSTEM:PASS")
PY_VALIDATE

printf '%s\n' \
  'journey=Mara full-system natural-player traversal' \
  'locked_story=Release 1276 exact qualified artifact' \
  'state_injection=none' \
  'test_setup_commands=none' \
  'teleport_commands=none' \
  'save_restore=native parser commands' \
  'release_1276_field_guidance=witnessed cache memory exercised' \
  'new_area_traversal=deferred to ordered new-area gate' \
  'full_transcript=yes' \
  > "$OUT/PLAYTEST-NOTES.txt"

echo "Mara full-system journey passed; replay evidence: $OUT"
