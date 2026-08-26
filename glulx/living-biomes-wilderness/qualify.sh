#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/ashglass-observatory-1272"
BUILD="$ROOT/glulx/build/living-biomes-wilderness-1273"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/living-biomes-wilderness/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/ashglass-observatory-region/qualify.sh
python -m py_compile glulx/living-biomes-wilderness/stage.py
python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
    r=Path(root); files={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
    return hashlib.sha256(json.dumps(files,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1273_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True)); Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
if ids!=(m.get('base_source_sha256') or {}): raise SystemExit(f'Release 1273 predecessor source pins drift: expected {m.get("base_source_sha256")}, got {ids}')
PY_BASE
python glulx/living-biomes-wilderness/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/living-biomes-wilderness/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"
python - <<'PY_STATIC'
import json
from pathlib import Path
def req(c,m):
    if not c: raise SystemExit(m)
b=Path('glulx/build/living-biomes-wilderness-1273'); s=b/'src'; p=Path('glulx/build/ashglass-observatory-1272/src'); m=json.loads(Path('glulx/living-biomes-wilderness/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1273 and r['base']['release']==1272,'Release 1273 staging/base mismatch')
req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1273 changed paths mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1273 production smell errors')
req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1273 dev smell errors')
a=(s/'living_biomes_wilderness.zil').read_text(); req(a.count('<ROOM BACKCOUNTRY-')==9,'Release 1273 must ship 9 Western Backcountry rooms'); req(a.count('<ROOM WARMRAIN-')==13,'Release 1273 must ship 13 Warmrain Basin rooms')
for token in ('WILDERNESS-MACHETE','BACKCOUNTRY-BEAVER','BACKCOUNTRY-FOX-TRACKS','WARMRAIN-LEAFCUTTERS','WARMRAIN-GLASS-FROGS','WARMRAIN-FRUIT-BATS','WARMRAIN-CAIMAN','CL-CANDLE-WET','DAM-SILVERFIN','WARMRAIN-VINE-CURTAIN'):
    req(token in a,'Release 1273 missing ecology token: '+token)
for bad in ('BIOME-GENERATOR','CLIMATE-METER','SURVIVAL-STAT','GENERIC-CREATURE','RANDOM-ENCOUNTER','PROCEDURAL-VEGETATION','SCENT-SYSTEM'):
    req(bad not in a,'Release 1273 crossed generic wilderness boundary: '+bad)
for f in ('ashglass_observatory.zil','troll_passage_opportunity.zil','cyclops_appetite_route.zil','grue_fissure_recovery.zil','dragon_hoard.zil','learned_magic.zil'):
    req((s/f).read_bytes()==(p/f).read_bytes(),'Release 1273 unexpectedly rewrote predecessor authority: '+f)
req('(WEST PER WILDERNESS-FOREST-WEST-EXIT)' in (s/'1dungeon.zil').read_text(),'Forest-1 living-biome entry missing')
req('<CONSTANT RELEASEID 1273>' in (s/'zork1.zil').read_text(),'Release 1273 identity missing')
PY_STATIC

read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY_M'
import json,sys; from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text()); print(m['serial'],m['expected_artifact']['file'])
PY_M
)
ZILF="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"
GLAZER="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
compile_story(){ local source="$1" asm="$2" out="$3" prefix="$4"; pushd "$source"; dotnet "$ZILF" build --glulx --stop-after-compile zork1.zil "$asm" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"; popd; python "$ROOT/glulx/tools/normalize_serial.py" "$asm" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"; "$GLAZER" "$asm" -o "$out" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"; }
STORY="$BUILD/$STORY_FILE"; compile_story "$SRC" "$BUILD/living-biomes-wilderness.asm" "$STORY" production; python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
rm -rf "$TEST_SRC"; cp -a "$DEV_SRC" "$TEST_SRC"; cp glulx/living-biomes-wilderness/tests/living_biomes_test.zil "$TEST_SRC/living_biomes_test.zil"
python - <<'PY_TEST'
from pathlib import Path
import sys; sys.path.insert(0,str(Path('glulx/tools').resolve())); from stage_release120 import apply_patch
apply_patch(Path('glulx/living-biomes-wilderness/tests/001-include-biomes-test.json').resolve(),Path('glulx/build/living-biomes-wilderness-1273/test-src').resolve())
PY_TEST
TEST_STORY="$BUILD/living-biomes-test.ulx"; compile_story "$TEST_SRC" "$BUILD/living-biomes-test.asm" "$TEST_STORY" test
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
run_case(){ local n="$1"; timeout 120s "$GLULXE" --rngseed 123456 "$TEST_STORY" < "$BUILD/$n.txt" > "$BUILD/$n-transcript.txt" 2>&1; }

cat > "$BUILD/machete-find.txt" <<'EOF1'
biomegear
look
take machete
examine machete
inventory
quit
yes
EOF1
run_case machete-find; F="$BUILD/machete-find-transcript.txt"; grep -F "old forester's machete" "$F"; grep -F 'made for brush rather than dueling' "$F"

cat > "$BUILD/forest-entry.txt" <<'EOF2'
biomeforest
examine undergrowth
cut undergrowth with machete
west
look
quit
yes
EOF2
run_case forest-entry; F="$BUILD/forest-entry-transcript.txt"; grep -F 'The route exists because you made a route' "$F"; grep -F 'Brush Gate' "$F"

cat > "$BUILD/beaver-wetland.txt" <<'EOF3'
biomebeaver
examine beaver
listen to beaver
examine dam
cross dam
look
quit
yes
EOF3
run_case beaver-wetland; F="$BUILD/beaver-wetland-transcript.txt"; grep -F 'maintaining the wetland' "$F"; grep -F 'animal built your bridge for reasons unrelated to you' "$F"; grep -F 'Cold Spring' "$F"

cat > "$BUILD/fox-shortcut.txt" <<'EOF4'
biomefox
southwest
examine tracks
southwest
look
quit
yes
EOF4
run_case fox-shortcut; F="$BUILD/fox-shortcut-transcript.txt"; grep -F 'not yet found a human-usable line' "$F"; grep -F 'shorter route to the warm-air notch' "$F"; grep -F 'Warmwind Notch' "$F"

cat > "$BUILD/basin-transition.txt" <<'EOF5'
biomebasin
look
south
look
quit
yes
EOF5
run_case basin-transition; F="$BUILD/basin-transition-transcript.txt"; grep -F 'topography and hot springs are doing actual work' "$F"; grep -F 'Warmrain Canopy Edge' "$F"

cat > "$BUILD/canopy-wetness.txt" <<'EOF6'
biomedrip
west
examine candles
quit
yes
EOF6
run_case canopy-wetness; F="$BUILD/canopy-wetness-transcript.txt"; grep -F 'Humidity has become object state, not a percentage on a status screen' "$F"; grep -F 'waterlogged' "$F"

cat > "$BUILD/leafcutter-route.txt" <<'EOF7'
biomeants
east
examine ants
east
look
quit
yes
EOF7
run_case leafcutter-route; F="$BUILD/leafcutter-route-transcript.txt"; grep -F 'Small life is moving through there' "$F"; grep -F 'evidence of dry connected footing' "$F"; grep -F 'Fallen Giant' "$F"

cat > "$BUILD/fauna-targets.txt" <<'EOF8'
biomefauna
examine frogs
listen to frogs
east
examine bats
listen to bats
quit
yes
EOF8
run_case fauna-targets; F="$BUILD/fauna-targets-transcript.txt"; grep -F 'neither treasure nor a coded quest marker' "$F"; grep -F 'fruit bats' "$F"; grep -F 'tiny but unmistakable contempt' "$F"

cat > "$BUILD/caiman-lure.txt" <<'EOF9'
biomecaiman
east
drop silverfin
east
look
quit
yes
EOF9
run_case caiman-lure; F="$BUILD/caiman-lure-transcript.txt"; grep -F 'large hunting reptile currently owning its middle' "$F"; grep -F 'predator has just made it part of the food web' "$F"; grep -F 'Deep Warmrain Basin' "$F"

cat > "$BUILD/caiman-death.txt" <<'EOF10'
biomecaimandeath
east
east
no
quit
yes
EOF10
run_case caiman-death; F="$BUILD/caiman-death-transcript.txt"; grep -F "choosing to wade through the animal's hunting position twice" "$F"

cat > "$BUILD/vine-bypass.txt" <<'EOF11'
biomevines
south
examine vines
cut vines with machete
south
look
quit
yes
EOF11
run_case vine-bypass; F="$BUILD/vine-bypass-transcript.txt"; grep -F 'vine curtain still binds the buttress gap' "$F"; grep -F 'leaves a narrow southward passage' "$F"; grep -F 'Deep Warmrain Basin' "$F"

cat > "$BUILD/hot-spring.txt" <<'EOF12'
biomevines
north
examine spring
drink spring
quit
yes
EOF12
run_case hot-spring; F="$BUILD/hot-spring-transcript.txt"; grep -F 'Clear water wells through black gravel' "$F"; grep -F 'hot enough to make the proposal educational' "$F"

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/living-biomes-wilderness-1273'); r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
if r.get('checksum_valid') is not True: raise SystemExit('Release 1273 artifact checksum invalid')
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n'); print('RELEASE_1273_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
e=m['expected_artifact']; rec={'release':1273,'serial':m['serial'],'base_release':1272,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['machete-find','forest-entry','beaver-wetland','fox-shortcut','basin-transition','canopy-wetness','leafcutter-route','fauna-targets','caiman-lure','caiman-death','vine-bypass','hot-spring']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1273 candidate completed gameplay qualification; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1273 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo 'Release 1273 Living Biomes & Wilderness Expansion qualification passed.'
