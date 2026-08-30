#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/honesty-playthrough"
STORY_BUILD="$ROOT/glulx/build/west-of-house-nouns-1295"
cd "$ROOT"
mkdir -p "$BUILD"
if [[ ! -f "$STORY_BUILD/zork1-glulx-west-of-house-nouns.ulx" ]]; then
  bash glulx/west-of-house-nouns/qualify.sh
fi
STORY="$STORY_BUILD/zork1-glulx-west-of-house-nouns.ulx"
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
  make -C "$ROOT/.tooling/cheapglk"
  make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
ZILF="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"
GLAZER="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"

cat > "$BUILD/opening-playthrough.txt" <<'EOF'
look
examine grass
examine silence
examine boards
open mailbox
read leaflet
recap
north
examine tree
south
quit
yes
EOF
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$BUILD/opening-playthrough.txt" > "$BUILD/opening-playthrough-transcript.txt" 2>&1
F="$BUILD/opening-playthrough-transcript.txt"
grep -F 'ordinary field grass' "$F"
grep -F 'settled quality of a place left alone too long' "$F"
grep -F 'The boards are securely fastened.' "$F"
grep -F 'WELCOME TO ZORK!' "$F"
grep -F 'Highly Extended Zork' "$F"
grep -F 'North of House' "$F"
if grep -F "You can't see any grass here!" "$F"; then echo 'playthrough: opening grass lie' >&2; exit 1; fi
if grep -F "You can't see any tree here!" "$F"; then echo 'playthrough: north-of-house tree lie' >&2; exit 1; fi

MARA_SRC="$BUILD/mara-src"
rm -rf "$MARA_SRC"
cp -a "$STORY_BUILD/src" "$MARA_SRC"
cp glulx/runtime-foundation/tests/mara_honesty_test.zil "$MARA_SRC/mara_honesty_test.zil"
python - <<'PY_PATCH'
import sys
from pathlib import Path
sys.path.insert(0, str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(
    Path('glulx/runtime-foundation/tests/002-include-mara-honesty.json').resolve(),
    Path('glulx/build/honesty-playthrough/mara-src').resolve(),
)
PY_PATCH
pushd "$MARA_SRC"
dotnet "$ZILF" build --glulx --stop-after-compile zork1.zil "$BUILD/mara-honesty.asm" 2>&1 | tee "$BUILD/mara-zilf.log"
popd
"$GLAZER" "$BUILD/mara-honesty.asm" -o "$BUILD/mara-honesty.ulx" 2>&1 | tee "$BUILD/mara-glazer.log"

cat > "$BUILD/mara-playthrough.txt" <<'EOF'
marasetup
talk to mara
ask mara about survey
ask mara about dam
ask mara about silverfin
ask mara about museum
mara, wait
marasolo
ask mara about silverfin
marahome
ask mara about silverfin
quit
yes
EOF
timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$BUILD/mara-honesty.ulx" < "$BUILD/mara-playthrough.txt" > "$BUILD/mara-playthrough-transcript.txt" 2>&1
M="$BUILD/mara-playthrough-transcript.txt"
grep -F 'Mara Tallow' "$M"
grep -F 'Last Honest Survey' "$M" || grep -F 'joint Dam sheet' "$M" || grep -F 'Flood Control Dam' "$M"
grep -F 'River Frigid should be observed' "$M" || grep -F 'I have not seen that catch' "$M"
if grep -F 'I don'\''t see what you'\''re referring to' "$M"; then echo 'Mara topic vanished' >&2; exit 1; fi
if grep -F 'omniscient' "$M"; then echo 'Mara dumped omniscience' >&2; exit 1; fi
echo 'Honesty playthrough (opening + Mara) passed.'
