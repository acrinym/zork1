#!/usr/bin/env bash
set -euo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/mara-field-guidance-1276"
OUT="$ROOT/glulx/build/product-playtest-gauntlet/new-areas"
STORY="$BASE_BUILD/zork1-glulx-mara-field-guidance-earned-clues.ulx"
SCENARIO_SOURCE="$ROOT/glulx/product-playtest-gauntlet/new-areas-full-system.json"
SCENARIO="$OUT/new-areas-full-system-effective.json"
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
    raise SystemExit(f"new-area playtest unexpectedly short: {len(commands)} commands")
for forbidden in (
    "maraprep", "maraload", "mararestprep", "marainjured", "marafield",
    "maracanyon", "mfgprep", "mfg", "teleport", "goto ", "psetup",
    "pobserve", "pready", "preport", "pstate", "pmutate",
):
    if any(cmd.lower().startswith(forbidden) for cmd in commands):
        raise SystemExit(f"New-area product playtest contains forbidden setup/teleport command: {forbidden}")
PY_SCENARIO

SAVE_FILE="$OUT/new-areas-full-system.sav"
TRANSCRIPT="$OUT/new-areas-full-system-transcript.txt"

python "$ROOT/glulx/tools/run_interactive_story.py" \
  --scenario "$SCENARIO" \
  --transcript "$TRANSCRIPT" \
  --var NEW_AREAS_SAVE_FILE="$SAVE_FILE" \
  -- "$GLULXE_BIN" --rngseed 123456 "$STORY"

test -s "$SAVE_FILE"
cp "$SCENARIO_SOURCE" "$OUT/new-areas-full-system-commands.json"
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
    "The stormfall still seals the obvious southward route",
    "exposing two old footholds and a narrow shelf descending south behind the roots",
    "West Court",
    "old forester's machete",
    "FOCUS the ring only after the three-star notch is visible",
    "The eastern wall is still blocked by the surviving archive shelf",
    "The whole narrow case pivots east on a stone pin",
    "The west wall still presents only soot-dark masonry",
    "The wall does not reward random masonry abuse with secret architecture",
    "one narrow pale bar across the southern wall",
    "This is a fitted maintenance panel, not a crack",
    "a cold maintenance crawl opens beyond",
    "a short bronze rod appears",
    "The main spill now drops through a lower channel",
    "The first pane bows under your carried load",
    "too much mass on old glass",
    "Ashglass Vault",
    "small bronze star-wheel",
    "middle notch is polished",
    "The vault lift is open without the chain becoming a flail",
    "The east stair exists; the living animal is the reason you do not currently own it",
    "Dense western undergrowth still closes the way",
    "The route exists because you made a route",
    "Brush Gate",
    "Hemlock Swale",
    "Beaver Meadow",
    "entirely unimpressed by your status as protagonist",
    "reach the cold-spring bank",
    "Fox Run",
    "not yet found a human-usable line through it",
    "shorter route to the warm-air notch",
    "Warmwind Notch",
    "Basin Overlook",
    "Warmrain Canopy Edge",
    "Leafcutter Ridge",
    "not yet learned where the ground actually holds",
    "evidence of dry connected footing",
    "Fallen Giant",
    "Caiman Ford",
    "large hunting reptile currently owning its middle",
    "Warmrain Hot Spring",
    "Glass Frog Pool",
    "Vine Colonnade",
    "The vine curtain still binds the buttress gap",
    "The machete chops through dead cable-vines first",
    "Deep Warmrain Basin",
]
for marker in required:
    if marker not in t:
        raise SystemExit(f"missing new-area full-system marker: {marker}")

if t.count("Deep Warmrain Basin") < 3:
    raise SystemExit("new-area journey did not prove Deep Warmrain route across native save/restore")
if t.count("Taken.") < 4:
    raise SystemExit("new-area journey did not prove physical custody of required regional objects")
for forbidden in (
    "you have died",
    "you are dead",
    "no veteran expedition is active",
    'i don\'t know the word "machete"',
    'i don\'t know the word "focus"',
    'i don\'t know the word "leafcutters"',
    'i don\'t know the word "caiman"',
):
    if forbidden in low:
        raise SystemExit(f"new-area journey regression/death: {forbidden}")

print("NEW_AREAS_FULL_SYSTEM:PASS")
PY_VALIDATE

printf '%s\n' \
  'journey=Ashglass Observatory Western Backcountry Warmrain Basin natural-player traversal' \
  'locked_story=Release 1276 exact qualified artifact' \
  'state_injection=none' \
  'test_setup_commands=none' \
  'teleport_commands=none' \
  'save_restore=native parser commands' \
  'ashglass=physical entry archive mechanism optical vent cistern light load vault counterweight rook boundary' \
  'backcountry=physical brush opening beaver crossing fox-route discovery warm-air gradient' \
  'warmrain=leafcutter route fauna caiman warning hot spring vine opening deep basin' \
  'full_transcript=yes' \
  > "$OUT/PLAYTEST-NOTES.txt"

echo "New-area full-system journey passed; replay evidence: $OUT"

echo "Starting final ordered cross-region expedition gate..."
bash "$ROOT/glulx/product-playtest-gauntlet/run-cross-region-expedition.sh"
CROSS_OUT="$ROOT/glulx/build/product-playtest-gauntlet/cross-region"
test -s "$CROSS_OUT/cross-region-expedition-transcript.txt"
rm -rf "$OUT/cross-region-expedition-evidence"
cp -a "$CROSS_OUT" "$OUT/cross-region-expedition-evidence"
echo "Cross-region expedition gate passed and evidence was attached to the serialized gauntlet artifact."
