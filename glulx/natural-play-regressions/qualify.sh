#!/usr/bin/env bash
set -euxo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/natural-play-regressions"
SRC="$BUILD/src"
MANIFEST="$ROOT/glulx/natural-play-regressions/patch-series.json"
rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$ROOT"
IFS=$'\t' read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY_META'
import json, sys
from pathlib import Path
m = json.loads(Path(sys.argv[1]).read_text())
print('\t'.join((m['serial'], m['expected_artifact']['file'])))
PY_META
)
python -m unittest discover -s tests -p 'test_natural_play_regressions.py' -v
python -m py_compile glulx/natural-play-regressions/stage.py tests/test_natural_play_regressions.py
python glulx/natural-play-regressions/stage.py --upstream .upstream/zork1-glulx --destination "$SRC" --allowed-root "$BUILD" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python - <<'PY_STATIC'
import json
from pathlib import Path
s = Path('glulx/build/natural-play-regressions/src')
stage = json.loads((s / 'STAGING-RECEIPT.json').read_text())
smell = json.loads(Path('glulx/build/natural-play-regressions/smell-report.json').read_text())
assert stage['base']['release'] == 1241
assert stage['base']['artifact_sha256'] == '95f5d3428b366cbae6bf5c83eccb750caeea2fe1d747b83a1112dee18eb3263f'
assert stage['changed_paths'] == sorted(['attic_archive_core.zil','cellar_recovery_locker.zil','completed_expedition_archive.zil','cuisine_hunger_stamina.zil','house_kitchen_laboratory.zil','museum_troll_provenance.zil','reactive_surface.zil','zork1.zil'])
assert not smell['errors']
production = '\n'.join(p.read_text(errors='ignore') for p in s.glob('*.zil'))
for forbidden in ('TROLLSUBDUE','TROLLKILL','MUSEUMHOME','GOHOME','ANGLER','TIDEUP'):
    assert forbidden not in production
module = (s / 'museum_troll_provenance.zil').read_text()
assert module.count('<OBJECT TROLL-FUR') == 1
assert '<PUT ,TROLL-TRACE-STATE 0 ,TROLL-OUTCOME-KILLED>' in module
assert '<V-KITCHEN-PREPARE>' in (s / 'cellar_recovery_locker.zil').read_text()
assert '<V-HOUSE-RISK-STATUS>' in (s / 'completed_expedition_archive.zil').read_text()
assert '<V-HOUSE-RISK-STATUS>' in (s / 'cuisine_hunger_stamina.zil').read_text()
PY_STATIC
GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit 2>/dev/null || true)"
if [[ -z "$GLULX_ZILF_DLL" ]]; then
  pushd .tooling/zilf-glulx
  dotnet restore Zilf.sln --nologo
  dotnet build Zilf.sln --configuration Release --property:PortableTarget=true --no-restore --nologo
  popd
  GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)"
fi
GLULX_ZILF_DLL="$(realpath "$GLULX_ZILF_DLL")"
GLAZER_BIN="$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)"
GLAZER_BIN="$(realpath "$GLAZER_BIN")"
ASSEMBLY="$BUILD/natural-play-regressions.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" 2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" --serial "$SERIAL" --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/$STORY_FILE" 2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/$STORY_FILE" --json "$BUILD/story-report.json"
make -C .tooling/cheapglk 2>&1 | tee "$BUILD/cheapglk-build.log"
make -C .tooling/glulxe GLKDIR="$ROOT/.tooling/cheapglk" GLKLIB="$ROOT/.tooling/cheapglk/libcheapglk.a" 2>&1 | tee "$BUILD/glulxe-build.log"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
source "$ROOT/glulx/natural-play-regressions/qualification/house.sh"
source "$ROOT/glulx/natural-play-regressions/qualification/troll.sh"
source "$ROOT/glulx/natural-play-regressions/qualification/receipt.sh"
