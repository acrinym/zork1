#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-field-guidance-1276"
OUT="$ROOT/glulx/build/product-playtest-gauntlet/upstairs"
STORY="$BASE_BUILD/zork1-glulx-mara-field-guidance-earned-clues.ulx"
SCENARIO_SOURCE="$ROOT/glulx/product-playtest-gauntlet/upstairs-full-system.json"
SCENARIO="$OUT/upstairs-full-system-effective.json"
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
for forbidden in (
    "maraprep", "maraload", "mararestprep", "marainjured", "marafield",
    "maracanyon", "mfgprep", "mfg", "teleport", "goto ", "psetup",
    "pobserve", "pready", "preport", "pstate", "pmutate",
):
    if any(cmd.lower().startswith(forbidden) for cmd in commands):
        raise SystemExit(f"Upstairs product playtest contains forbidden setup/teleport command: {forbidden}")
PY_SCENARIO

SAVE_FILE="$OUT/upstairs-full-system.sav"
TRANSCRIPT="$OUT/upstairs-full-system-transcript.txt"

python "$ROOT/glulx/tools/run_interactive_story.py" \
  --scenario "$SCENARIO" \
  --transcript "$TRANSCRIPT" \
  --var UPSTAIRS_SAVE_FILE="$SAVE_FILE" \
  -- "$GLULXE_BIN" --rngseed 123456 "$STORY"

test -s "$SAVE_FILE"
cp "$SCENARIO_SOURCE" "$OUT/upstairs-full-system-commands.json"
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
    "real sleep belongs to the Bedroom upstairs",
    "The four-poster bed is old but sound",
    "REST-DREAM-01",
    "Every page is blank",
    "You dream of a white house with one more stair than you remember",
    "House stair and return dream",
    "You doze briefly, but the house has accumulated no new expedition evidence",
    "AREA-HOUSE-01",
    "PLAYBACK-PRINTER-01",
    "PLAYBACK-CASSETTE-02",
    "PLAYBACK-ACTOR-04",
    "PLAYBACK-PLACE-05",
    "PLAYBACK-CHRONOLOGY-06",
    "REST-OVERNIGHT-02",
    "The terminal is only an index",
    "It is a bounded late-1970s archive surface",
    "[CURATED ACTION] RETURN TO THE WHITE HOUSE",
    "[END OF CURATED TAPE] No actor, object, timer, score, pronoun, or location was changed.",
    "No actor scene has been earned",
    "INCOMPLETE; unresolved sections remain redacted",
    "Cross-reference: HOUSE-THRESHOLD-01, HOUSE-DISPLAY-02, VISIT series, and house chronology where earned.",
    "You file the exact regional record in the steel cabinet",
    "Successful full rests: 1",
    "Completed expedition archive status: no sealed victory record",
    "Nothing is exported before genuine victory and a sealed physical expedition box.",
]
for marker in required:
    if marker not in t:
        raise SystemExit(f"missing upstairs full-system marker: {marker}")
if t.count("PLAYBACK-INTEGRITY:PASS") < 6:
    raise SystemExit("upstairs journey did not prove enough non-mutating playback surfaces")
if t.count("REST-RECORD-INTEGRITY:PASS") < 4:
    raise SystemExit("upstairs journey did not prove Bedroom record integrity across review surfaces")
if t.count("You file the exact playback record") < 6:
    raise SystemExit("upstairs journey did not exercise physical playback filing and restored custody")
for forbidden in (
    "[CURATED ACTION] EXAMINE THE DAM CONTROL PANEL",
    "[CURATED ACTION] ADVANCE THE HADES CEREMONY",
    "[CURATED ACTION] ENCOUNTER THE TROLL",
    "Troll scene: player-specific evidence only",
    "PLAYBACK-FORENSIC-07",
    'i don\'t know the word "catalog"',
    'i don\'t know the word "playback"',
    'i don\'t know the word "crossref"',
):
    if forbidden.lower() in low:
        raise SystemExit(f"upstairs evidence leak/parser regression: {forbidden}")
if "you have died" in low or "you are dead" in low:
    raise SystemExit("upstairs full-system journey died before completion")
print("UPSTAIRS_FULL_SYSTEM:PASS")
PY_VALIDATE

printf '%s\n' \
  'journey=Bedroom and Attic full-system natural-player traversal' \
  'locked_story=Release 1276 exact qualified artifact' \
  'state_injection=none' \
  'test_setup_commands=none' \
  'teleport_commands=none' \
  'save_restore=native parser commands' \
  'bedroom=refusal full-rest dream anti-farming records' \
  'attic=physical catalog playback case-files filing and pre-victory boundary' \
  'unearned_evidence=explicitly remains absent/redacted' \
  'full_transcript=yes' \
  > "$OUT/PLAYTEST-NOTES.txt"

echo "Upstairs full-system journey passed; replay evidence: $OUT"
