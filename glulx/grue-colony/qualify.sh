#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/thief-retaliation-sabotage-1255"
BUILD="$ROOT/glulx/build/grue-ecology-colony-reveal-1256"
BASE_SRC="$BASE_BUILD/src"; BASE_DEV_SRC="$BASE_BUILD/dev-src"; SRC="$BUILD/src"; DEV_SRC="$BUILD/dev-src"; TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/grue-colony/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/thief-retaliation/qualify.sh
python -m py_compile glulx/grue-colony/stage.py
python - "$MANIFEST" "$BASE_SRC" "$BASE_DEV_SRC" <<'PY'
import importlib.util,json,sys
from pathlib import Path
spec=importlib.util.spec_from_file_location('stage1256','glulx/grue-colony/stage.py'); mod=importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
m=json.loads(Path(sys.argv[1]).read_text()); actual={'production':mod.source_identity(Path(sys.argv[2])),'dev':mod.source_identity(Path(sys.argv[3]))}
for k,v in actual.items(): assert m['base_source_sha256'][k]==v,(k,m['base_source_sha256'][k],v)
PY
python glulx/grue-colony/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/grue-colony/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"
python - <<'PY'
import json,hashlib
from pathlib import Path
b=Path('glulx/build/grue-ecology-colony-reveal-1256'); s=b/'src'; d=b/'dev-src'; base=Path('glulx/build/thief-retaliation-sabotage-1255/src')
stage=json.loads((s/'STAGING-RECEIPT.json').read_text()); dev=json.loads((d/'STAGING-RECEIPT.json').read_text()); smell=json.loads((b/'smell-report.json').read_text()); dev_smell=json.loads((b/'dev-smell-report.json').read_text())
assert stage['release']==1256 and stage['base']['release']==1255 and stage['base']['artifact_sha256']=='89664ebb9b728257f14b2831f6a9fda45d9de0e6bacb807fba8a1eec7b9b667e'
assert stage['changed_paths']==sorted(['1actions.zil','1dungeon.zil','assistance.zil','gglobals.zil','zork1.zil']); assert stage['dev_mode'] is False and dev['dev_mode'] is True; assert not smell['errors'] and not dev_smell['errors']
# Canonical darkness/grue lethal/noise machinery is byte-for-byte untouched.
assert (s/'gverbs.zil').read_bytes()==(base/'gverbs.zil').read_bytes()
actions=(s/'1actions.zil').read_text(); dungeon=(s/'1dungeon.zil').read_text(); globals_=(s/'gglobals.zil').read_text(); assist=(s/'assistance.zil').read_text(); zork=(s/'zork1.zil').read_text()
for token in ('<ROUTINE GRUE-COLONY-REVEALED?','<ROUTINE GRUE-COLONY-STRONG-LIGHT?','<ROUTINE GRUE-COLONY-REVEAL','<ROUTINE GRUE-COLONY-ROOM-FCN','<ROUTINE GRUE-FISSURES-FCN','Not one shadow but many pull away at once','this dead end borders a grue colony'):
    assert token in actions,token
for token in ('<OBJECT GRUE-FISSURES','(VALUE 0)','(ACTION GRUE-COLONY-ROOM-FCN)','(ACTION GRUE-FISSURES-FCN)'):
    assert token in dungeon,token
assert '<GRUE-COLONY-REVEALED?>' in globals_ and 'many separate shapes retreat through the mine fissures' in globals_
assert 'Bring the flaming ivory torch here.' in assist and '<CONSTANT RELEASEID 1256>' in zork and 'GRUE ECOLOGY AND COLONY REVEAL GLULX' in zork
for forbidden in ('GLOBAL GRUE-COLONY','GRUE-HP','GRUE-HEALTH','GRUE-AGGRO','GRUE-COLONY-COUNT'):
    assert forbidden not in actions and forbidden not in globals_
PY
IFS=$'\t' read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text()); print('\t'.join((m['serial'],m['expected_artifact']['file'])))
PY
)
GLULX_ZILF_DLL="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"; GLAZER_BIN="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
compile_story(){ local source="$1" assembly="$2" output="$3" prefix="$4"; pushd "$source"; dotnet "$GLULX_ZILF_DLL" build --glulx --stop-after-compile zork1.zil "$assembly" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"; popd; python glulx/tools/normalize_serial.py "$assembly" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"; "$GLAZER_BIN" "$assembly" -o "$output" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"; }
STORY="$BUILD/$STORY_FILE"; compile_story "$SRC" "$BUILD/grue-colony.asm" "$STORY" production; python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
rm -rf "$TEST_SRC"; cp -a "$DEV_SRC" "$TEST_SRC"; cp glulx/grue-colony/tests/grue_colony_test.zil "$TEST_SRC/grue_colony_test.zil"
python - <<'PY'
from pathlib import Path
import sys
sys.path.insert(0,str(Path('glulx/tools').resolve())); from stage_release120 import apply_patch
apply_patch(Path('glulx/grue-colony/tests/001-include-grue-colony-test.json').resolve(),Path('glulx/build/grue-ecology-colony-reveal-1256/test-src').resolve())
PY
TEST_STORY="$BUILD/grue-colony-test.ulx"; compile_story "$TEST_SRC" "$BUILD/grue-colony-test.asm" "$TEST_STORY" test
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"

cat > "$BUILD/weak-light.txt" <<'EOF1'
grueweak
gruestatus
quit
yes
EOF1
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/weak-light.txt" > "$BUILD/weak-light-transcript.txt" 2>&1
W="$BUILD/weak-light-transcript.txt"; grep -F 'a scrape from one fissure is answered by a second scrape somewhere else' "$W"; grep -F 'two faint scrapes answer each other from different cracks' "$W"; grep -F 'TEST grue colony reveal: hidden' "$W"

cat > "$BUILD/strong-light.txt" <<'EOF2'
gruestrong
gruestatus
quit
yes
EOF2
timeout 120s "$GLULXE_BIN" --rngseed 123456 "$TEST_STORY" < "$BUILD/strong-light.txt" > "$BUILD/strong-light-transcript.txt" 2>&1
S="$BUILD/strong-light-transcript.txt"; grep -F 'Not one shadow but many pull away at once.' "$S"; grep -F 'this dead end borders a grue colony.' "$S"; grep -F 'many separate shapes retreat through the mine fissures' "$S"; grep -F 'The sounds do not come from one place.' "$S"; grep -F 'TEST grue colony reveal: active' "$S"

python - "$STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); manifest=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/grue-ecology-colony-reveal-1256'); report=json.loads((b/'story-report.json').read_text())
identity={'file':story.name,'format':'Glulx','version_hex':report['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':report['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}; assert report['checksum_valid'] is True; expected=manifest['expected_artifact']
if expected.get('locked') is not True: print('RELEASE_1256_ARTIFACT_IDENTITY='+json.dumps(identity,sort_keys=True)); raise SystemExit(4)
for key in ('file','version_hex','size_bytes','checksum_hex','sha256'): assert expected[key]==identity[key],(key,expected[key],identity[key])
receipt={'release':1256,'serial':manifest['serial'],'artifact_identity_locked':True,'production':{**identity,'report':report},'base_release':1255,'base_artifact_sha256':manifest['base_artifact_sha256'],'weak_light':'weak-light-transcript.txt','strong_light':'strong-light-transcript.txt','canonical_gverbs_unchanged':True}; (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(receipt,indent=2,sort_keys=True)+'\n'); print(json.dumps(receipt,indent=2,sort_keys=True))
PY
echo "Release 1256 Grue Ecology & Colony Reveal qualified."
