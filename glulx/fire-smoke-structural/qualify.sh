#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/grue-ecology-colony-reveal-1256"
BUILD="$ROOT/glulx/build/fire-smoke-structural-consequences-1257"
BASE_SRC="$BASE_BUILD/src"; BASE_DEV_SRC="$BASE_BUILD/dev-src"; SRC="$BUILD/src"; DEV_SRC="$BUILD/dev-src"; TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/fire-smoke-structural/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/grue-colony/qualify.sh
python -m py_compile glulx/fire-smoke-structural/stage.py
python - "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import importlib.util,json,sys
from pathlib import Path
spec=importlib.util.spec_from_file_location('stage1257','glulx/fire-smoke-structural/stage.py'); mod=importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
m=json.loads(Path(sys.argv[1]).read_text()); actual={'production':mod.source_identity(Path(sys.argv[2])),'dev':mod.source_identity(Path(sys.argv[3]))}
for k,v in actual.items(): assert m['base_source_sha256'][k]==v,(k,m['base_source_sha256'][k],v)
PY
python glulx/fire-smoke-structural/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/fire-smoke-structural/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"
python - <<'PY'
import json
from pathlib import Path
b=Path('glulx/build/fire-smoke-structural-consequences-1257'); s=b/'src'; d=b/'dev-src'; base=Path('glulx/build/grue-ecology-colony-reveal-1256/src')
stage=json.loads((s/'STAGING-RECEIPT.json').read_text()); dev=json.loads((d/'STAGING-RECEIPT.json').read_text()); smell=json.loads((b/'smell-report.json').read_text()); dev_smell=json.loads((b/'dev-smell-report.json').read_text())
expected=sorted(['1dungeon.zil','assistance.zil','fire_structural.zil','shadow_logic.zil','zork1.zil'])
assert stage['release']==1257 and stage['base']['release']==1256 and stage['base']['artifact_sha256']=='dbad355f6d18245d48671102bf4d449f227c03bd8e39ec569c9a41d8508c7c4a'
assert stage['changed_paths']==expected and stage['dev_mode'] is False and dev['dev_mode'] is True
assert not smell['errors'] and not dev_smell['errors']
# Canonical fire and Gas Room explosion authority remain untouched.
assert (s/'gverbs.zil').read_bytes()==(base/'gverbs.zil').read_bytes()
assert (s/'1actions.zil').read_bytes()==(base/'1actions.zil').read_bytes()
fire=(s/'fire_structural.zil').read_text(); dungeon=(s/'1dungeon.zil').read_text(); shadow=(s/'shadow_logic.zil').read_text(); assist=(s/'assistance.zil').read_text(); zork=(s/'zork1.zil').read_text()
for token in ('<CONSTANT FIRE-STRUCTURAL-STATE <TABLE 0 0>>','<ROUTINE FIRE-STRUCTURAL-ADVANCE','<ROUTINE FIRE-STRUCTURAL-IGNITE','<ROUTINE FIRE-STRUCTURAL-DOUSE','<ROUTINE FIRE-STRUCTURAL-HOOK','old brace drops into the burning clutter','narrow westward crawl is exactly where the draft is concentrating smoke'):
    assert token in fire,token
assert '<GLOBAL FIRE-' not in fire
for token in ('<OBJECT TIMBERS','(FLAGS TAKEBIT BURNBIT)','(ACTION FIRE-TIMBERS-FCN)','(ACTION FIRE-TIMBER-ROOM-FCN)','IF EMPTY-HANDED'):
    assert token in dungeon,token
# The real coal object remains burnable and movable exactly as the canonical puzzle expects; 1257 does not consume or substitute it.
assert '''<OBJECT COAL
\t(IN DEAD-END-5)
\t(SYNONYM COAL PILE HEAP)
\t(ADJECTIVE SMALL)
\t(DESC "small pile of coal")
\t(FLAGS TAKEBIT BURNBIT)
\t(SIZE 20)>''' in dungeon
assert '<FIRE-STRUCTURAL-HOOK>' in shadow
assert 'The collapse persists, but it will not widen, delete, or brick the canonical narrow route.' in assist
assert '<CONSTANT RELEASEID 1257>' in zork and 'FIRE SMOKE AND STRUCTURAL CONSEQUENCES GLULX' in zork
PY
IFS=$'\t' read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text()); print('\t'.join((m['serial'],m['expected_artifact']['file'])))
PY
)
GLULX_ZILF_DLL="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"; GLAZER_BIN="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
compile_story(){ local source="$1" assembly="$2" output="$3" prefix="$4"; pushd "$source"; dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$assembly" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"; popd; python glulx/tools/normalize_serial.py "$assembly" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"; "$GLAZER_BIN" "$assembly" -o "$output" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"; }
STORY="$BUILD/$STORY_FILE"; compile_story "$SRC" "$BUILD/fire-smoke-structural.asm" "$STORY" production; python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
rm -rf "$TEST_SRC"; cp -a "$DEV_SRC" "$TEST_SRC"; cp glulx/fire-smoke-structural/tests/fire_structural_test.zil "$TEST_SRC/fire_structural_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0,str(Path('glulx/tools').resolve())); from stage_release120 import apply_patch
apply_patch(Path('glulx/fire-smoke-structural/tests/001-include-fire-structural-test.json').resolve(),Path('glulx/build/fire-smoke-structural-consequences-1257/test-src').resolve())
PY
TEST_STORY="$BUILD/fire-structural-test.ulx"; compile_story "$TEST_SRC" "$BUILD/fire-structural-test.asm" "$TEST_STORY" test
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"

cat > "$BUILD/early-stop.txt" <<'EOF1'
fireprep
burn timbers with torch
extinguish timbers
firestatus
examine timbers
quit
yes
EOF1
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/early-stop.txt" > "$BUILD/early-stop-transcript.txt" 2>&1
E="$BUILD/early-stop-transcript.txt"; grep -F 'first it smolders' "$E"; grep -F 'grind the small smoldering edge out under a boot' "$E"; grep -F 'TEST timber fire state: doused' "$E"

cat > "$BUILD/water-stop.txt" <<'EOF2'
fireprep
burn timbers with torch
look
use bottle on timbers
firestatus
examine timbers
quit
yes
EOF2
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/water-stop.txt" > "$BUILD/water-stop-transcript.txt" 2>&1
W="$BUILD/water-stop-transcript.txt"; grep -F 'Flame runs along the dry grain' "$W"; grep -F 'Steam and dirty runoff replace the smoke; the flame dies.' "$W"; grep -F 'TEST timber fire state: doused' "$W"

cat > "$BUILD/smoke-route.txt" <<'EOF3'
fireprep
burn timbers with torch
look
west
east
quit
yes
EOF3
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/smoke-route.txt" > "$BUILD/smoke-route-transcript.txt" 2>&1
R="$BUILD/smoke-route-transcript.txt"; grep -F 'narrow westward crawl is exactly where the draft is concentrating smoke' "$R"; grep -F 'Ladder Bottom' "$R"

cat > "$BUILD/collapse.txt" <<'EOF4'
fireprep
burn timbers with torch
look
smell timbers
listen timbers
look
look
look
firestatus
examine timbers
quit
yes
EOF4
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/collapse.txt" > "$BUILD/collapse-transcript.txt" 2>&1
C="$BUILD/collapse-transcript.txt"; grep -F 'One old brace drops into the burning clutter' "$C"; grep -F 'permanent heap of charred wood without changing the mine' "$C"; grep -F 'TEST timber fire state: charred' "$C"; grep -F 'canonical narrow passage remains a narrow passage' "$C"

python - "$STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); manifest=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/fire-smoke-structural-consequences-1257'); report=json.loads((b/'story-report.json').read_text())
identity={'file':story.name,'format':'Glulx','version_hex':report['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':report['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}; assert report['checksum_valid'] is True; expected=manifest['expected_artifact']
if expected.get('locked') is not True: print('RELEASE_1257_ARTIFACT_IDENTITY='+json.dumps(identity,sort_keys=True)); raise SystemExit(4)
for key in ('file','version_hex','size_bytes','checksum_hex','sha256'): assert expected[key]==identity[key],(key,expected[key],identity[key])
receipt={'release':1257,'serial':manifest['serial'],'artifact_identity_locked':True,'production':{**identity,'report':report},'base_release':1256,'base_artifact_sha256':manifest['base_artifact_sha256'],'early_stop':'early-stop-transcript.txt','water_stop':'water-stop-transcript.txt','smoke_route':'smoke-route-transcript.txt','collapse':'collapse-transcript.txt','canonical_gverbs_unchanged':True,'canonical_gas_room_actions_unchanged':True}; (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(receipt,indent=2,sort_keys=True)+'\n'); print(json.dumps(receipt,indent=2,sort_keys=True))
PY
echo "Release 1257 Fire, Smoke & Structural Consequences qualified."
