#!/usr/bin/env bash
set -euxo pipefail

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/house-cellar-threshold"
SRC="$BUILD/src"
rm -rf "$BUILD"
mkdir -p "$BUILD"

python - <<'PY'
import json, os
from pathlib import Path
layer = json.loads(Path('glulx/house-cellar-threshold/patch-series.json').read_text(encoding='utf-8'))
base = json.loads(Path('glulx/house-kitchen-laboratory/patch-series.json').read_text(encoding='utf-8'))
assert layer['release'] == int(os.environ['CELLAR_RELEASE'])
assert layer['serial'] == os.environ['CELLAR_SERIAL']
assert layer['upstream_commit'] == os.environ['ZORK_GLULX_COMMIT']
assert layer['upstream_tree'] == os.environ['ZORK_GLULX_TREE']
assert layer['base_release'] == int(os.environ['BASE_RELEASE'])
assert layer['base_artifact_sha256'] == os.environ['BASE_ARTIFACT_SHA256']
assert base['release'] == int(os.environ['BASE_RELEASE'])
assert base['expected_artifact']['sha256'] == os.environ['BASE_ARTIFACT_SHA256']
assert layer['expected_changed_paths'] == [
    '1actions.zil', 'assistance.zil', 'house_cellar_threshold.zil',
    'shadow_logic.zil', 'zork1.zil'
]
PY

pushd .tooling/zilf-glulx
dotnet restore Zilf.sln --nologo 2>&1 | tee "$BUILD/zilf-restore.log"
dotnet build Zilf.sln --configuration Release --property:PortableTarget=true --no-restore --nologo \
  2>&1 | tee "$BUILD/zilf-build.log"
popd
GLULX_ZILF_DLL="$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)"
test -n "$GLULX_ZILF_DLL"
GLULX_ZILF_DLL="$(realpath "$GLULX_ZILF_DLL")"

curl --fail --location --silent --show-error "$GLAZER_SOURCE_URL" \
  --output "$BUILD/glazer-source.tar.gz"
echo "$GLAZER_SOURCE_SHA256  $BUILD/glazer-source.tar.gz" | sha256sum --check
rm -rf .tooling/glazer-source
mkdir -p .tooling/glazer-source
tar -xf "$BUILD/glazer-source.tar.gz" --strip-components=1 -C .tooling/glazer-source
make -C .tooling/glazer-source 2>&1 | tee "$BUILD/glazer-build.log"
GLAZER_BIN="$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)"
test -n "$GLAZER_BIN"
GLAZER_BIN="$(realpath "$GLAZER_BIN")"
"$GLAZER_BIN" --version | tee "$BUILD/glazer-version.txt"
grep -Fx "glazer 1.2.0" "$BUILD/glazer-version.txt"

python glulx/tools/stage_house_cellar_threshold.py \
  --upstream .upstream/zork1-glulx \
  --destination "$SRC" \
  --allowed-root "$BUILD" \
  --manifest glulx/house-cellar-threshold/patch-series.json
python optimized/tools/zil_smell_check.py \
  --source "$SRC" \
  --json "$BUILD/smell-report.json"
python - <<'PY'
import json
from pathlib import Path
receipt = json.loads(Path('glulx/build/house-cellar-threshold/src/STAGING-RECEIPT.json').read_text(encoding='utf-8'))
report = json.loads(Path('glulx/build/house-cellar-threshold/smell-report.json').read_text(encoding='utf-8'))
assert receipt['base']['release'] == 1221
assert receipt['base']['artifact_sha256'] == '93cb08f3571df3a63476609b6f1dc4eaeac7dd0255eb1ef1b7d878c8168dc62f'
assert receipt['changed_paths'] == [
    '1actions.zil', 'assistance.zil', 'house_cellar_threshold.zil',
    'shadow_logic.zil', 'zork1.zil'
]
assert not report['errors']
assert not [item for item in report['includes'] if not item['resolved']]
source = Path('glulx/build/house-cellar-threshold/src')
assert (source / 'house_cellar_threshold.zil').is_file()
assert not (source / 'house_cellar_threshold_test.zil').exists()
PY

ASSEMBLY="$BUILD/zork1-glulx-house-cellar-threshold.asm"
pushd "$SRC"
dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$ASSEMBLY" \
  2>&1 | tee "$BUILD/zilf-compile.log"
popd
python glulx/tools/normalize_serial.py "$ASSEMBLY" \
  --serial "$CELLAR_SERIAL" \
  --receipt "$BUILD/SERIAL-NORMALIZATION.json"
"$GLAZER_BIN" "$ASSEMBLY" -o "$BUILD/zork1-glulx-house-cellar-threshold.ulx" \
  2>&1 | tee "$BUILD/glazer-assemble.log"
python glulx/tools/verify_ulx.py "$BUILD/zork1-glulx-house-cellar-threshold.ulx" \
  --json "$BUILD/story-report.json"

python - <<'PY'
import json
from pathlib import Path
story = json.loads(Path('glulx/build/house-cellar-threshold/story-report.json').read_text(encoding='utf-8'))
stage = json.loads(Path('glulx/build/house-cellar-threshold/src/STAGING-RECEIPT.json').read_text(encoding='utf-8'))
receipt = {
    'discovery_status': 'production_compiled',
    'identity': {'release': 1222, 'serial': '260724'},
    'base': stage['base'],
    'changed_paths': stage['changed_paths'],
    'artifact': story,
    'gameplay_and_persistence_qualification': 'pending',
    'production_contains_test_setup': False,
}
Path('glulx/build/house-cellar-threshold/DISCOVERY-RECEIPT.json').write_text(
    json.dumps(receipt, indent=2) + '\n', encoding='utf-8'
)
print(json.dumps(story, indent=2))
PY
