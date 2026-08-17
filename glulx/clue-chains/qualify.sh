#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/semantic-examination-1267"
BUILD="$ROOT/glulx/build/clue-chains-1268"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
TEST_SRC="$BUILD/test-src"
MANIFEST="$ROOT/glulx/clue-chains/patch-series.json"
rm -rf "$BUILD"; mkdir -p "$BUILD"; cd "$ROOT"

bash glulx/semantic-examination/qualify.sh
python -m py_compile glulx/clue-chains/stage.py
python - "$BASE_SRC" "$BASE_DEV_SRC" "$MANIFEST" "$BUILD" <<'PY_BASE'
import hashlib,json,sys
from pathlib import Path
def ident(root):
 r=Path(root); f={p.relative_to(r).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(r.rglob('*')) if p.is_file() and p.name!='STAGING-RECEIPT.json'}
 return hashlib.sha256(json.dumps(f,sort_keys=True,separators=(',',':')).encode()).hexdigest()
m=json.loads(Path(sys.argv[3]).read_text()); ids={'production':ident(sys.argv[1]),'dev':ident(sys.argv[2])}
print('RELEASE_1268_BASE_SOURCE_IDENTITIES='+json.dumps(ids,sort_keys=True)); Path(sys.argv[4],'BASE-SOURCE-IDENTITIES.json').write_text(json.dumps(ids,indent=2,sort_keys=True)+'\n')
if ids!=(m.get('base_source_sha256') or {}): raise SystemExit(f'Release 1268 predecessor source pins drift: expected {m.get("base_source_sha256")}, got {ids}')
PY_BASE

python glulx/clue-chains/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/clue-chains/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"
python - <<'PY_STATIC'
import json,re
from pathlib import Path
def req(x,m):
 if not x: raise SystemExit(m)
b=Path('glulx/build/clue-chains-1268'); s=b/'src'; p=Path('glulx/build/semantic-examination-1267/src'); m=json.loads(Path('glulx/clue-chains/patch-series.json').read_text()); r=json.loads((s/'STAGING-RECEIPT.json').read_text())
req(r['release']==1268 and r['base']['release']==1267,'Release 1268 staging/base mismatch'); req(r['changed_paths']==sorted(m['expected_changed_paths']),'Release 1268 changed-path mismatch')
req(not json.loads((b/'smell-report.json').read_text())['errors'],'Release 1268 production smell errors'); req(not json.loads((b/'dev-smell-report.json').read_text())['errors'],'Release 1268 dev smell errors')
c=(s/'clue_interpretation.zil').read_text(); z=(s/'zork1.zil').read_text()
for t in ('<SYNTAX INTERPRET OBJECT','<CONSTANT CK-ANCIENT-SCRIPT 0>','<CONSTANT CK-AIR-PASSAGE-MOTIF 1>','<OBJECT CLUE-DRAGON-VENT-MARK','<EQUAL? ,PRSO ,PRAYER>','<EQUAL? ,PRSO ,ENGRAVINGS>','<MOVE ,DRAGON-VENT-SEAM ,DRAGON-GALLERY>'): req(t in c,'missing Release 1268 clue token: '+t)
req(re.search(r'(?m)^<GLOBAL\b',c) is None,'Release 1268 consumed legacy VM globals')
for n in ('1dungeon.zil','semantic_examination.zil','dragon_hoard.zil','learned_magic.zil','living_room_museum.zil','attic_archive_core.zil','gsyntax.zil','gverbs.zil'): req((s/n).read_bytes()==(p/n).read_bytes(),'Release 1268 unexpectedly rewrote existing authority: '+n)
req('<CONSTANT RELEASEID 1268>' in z and '<INSERT-FILE "clue_interpretation" T>' in z,'Release 1268 identity/include missing')
PY_STATIC

read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY_MANIFEST'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text()); print(m['serial'],m['expected_artifact']['file'])
PY_MANIFEST
)
[[ -n "$SERIAL" && -n "$STORY_FILE" ]]
ZILF="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"; GLAZER="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
compile_story(){ local source="$1" asm="$2" out="$3" prefix="$4"; pushd "$source"; dotnet "$ZILF" build --glulx --stop-after-compile zork1.zil "$asm" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"; popd; python "$ROOT/glulx/tools/normalize_serial.py" "$asm" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"; "$GLAZER" "$asm" -o "$out" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"; }
STORY="$BUILD/$STORY_FILE"; compile_story "$SRC" "$BUILD/clue-chains.asm" "$STORY" production; python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
rm -rf "$TEST_SRC"; cp -a "$DEV_SRC" "$TEST_SRC"; cp glulx/clue-chains/tests/clue_interpretation_test.zil "$TEST_SRC/clue_interpretation_test.zil"
python - <<'PY_TEST'
from pathlib import Path
import sys
sys.path.insert(0,str(Path('glulx/tools').resolve()))
from stage_release120 import apply_patch
apply_patch(Path('glulx/clue-chains/tests/001-include-clue-interpretation-test.json').resolve(),Path('glulx/build/clue-chains-1268/test-src').resolve())
PY_TEST
TEST_STORY="$BUILD/clue-chains-test.ulx"; compile_story "$TEST_SRC" "$BUILD/clue-chains-test.asm" "$TEST_STORY" test
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then make -C "$ROOT/.tooling/cheapglk"; make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"; fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"; run_case(){ local n="$1"; timeout 120s "$GLULXE" --rngseed 123456 "$TEST_STORY" < "$BUILD/$n.txt" > "$BUILD/$n-transcript.txt" 2>&1; }

cat > "$BUILD/premature-engraving.txt" <<'EOF1'
cktemple
ckengravings
interpret engravings
ckstat
quit
yes
EOF1
run_case premature-engraving; F="$BUILD/premature-engraving-transcript.txt"; grep -F 'Another readable sample of the old script would give you something to compare.' "$F"; grep -F 'script=0 air-motif=0 field-mark=0 seam-discovered=0 prayer-fixed=1 engravings-fixed=1' "$F"

cat > "$BUILD/learn-across-fixed-clues.txt" <<'EOF2'
cktemple
read prayer
interpret prayer
ckstat
ckengravings
read engravings
interpret engravings
ckstat
quit
yes
EOF2
run_case learn-across-fixed-clues; F="$BUILD/learn-across-fixed-clues-transcript.txt"; grep -F 'this is reading knowledge, not a portable key' "$F"; grep -F 'script=1 air-motif=0 field-mark=0 seam-discovered=0 prayer-fixed=1 engravings-fixed=1' "$F"; grep -F 'recognize that practical air-passage motif elsewhere' "$F"; grep -F 'script=1 air-motif=1 field-mark=0 seam-discovered=0 prayer-fixed=1 engravings-fixed=1' "$F"

cat > "$BUILD/unread-field-mark.txt" <<'EOF3'
ckfreshgallery
examine marking
interpret marking
ckstat
quit
yes
EOF3
run_case unread-field-mark; F="$BUILD/unread-field-mark-transcript.txt"; grep -F 'without a matching context it remains an unfamiliar old notation' "$F"; grep -F 'Guessing a secret mechanism from an unfamiliar symbol would be invention, not interpretation.' "$F"; grep -F 'script=0 air-motif=0 field-mark=0 seam-discovered=0 prayer-fixed=1 engravings-fixed=1' "$F"

cat > "$BUILD/full-clue-chain.txt" <<'EOF4'
cktemple
interpret prayer
ckengravings
interpret engravings
ckgallery
examine marking
interpret marking
ckstat
examine seam
quit
yes
EOF4
run_case full-clue-chain; F="$BUILD/full-clue-chain-transcript.txt"; grep -F 'same grammar: a bounded opening meant to carry breath or moving air' "$F"; grep -F 'remembered meaning has helped you identify existing structure; it has not opened a secret door' "$F"; grep -F 'script=1 air-motif=1 field-mark=1 seam-discovered=1 prayer-fixed=1 engravings-fixed=1' "$F"; grep -F 'The ventilation seam is a narrow engineered break high in the basalt' "$F"

cat > "$BUILD/predecessor-blackening.txt" <<'EOF5'
ckfreshgallery
examine blackening
ckstat
interpret marking
ckstat
quit
yes
EOF5
run_case predecessor-blackening; F="$BUILD/predecessor-blackening-transcript.txt"; grep -F 'old ventilation seam cut through the stone' "$F"; [[ "$(grep -Fc 'script=0 air-motif=0 field-mark=0 seam-discovered=1 prayer-fixed=1 engravings-fixed=1' "$F")" -ge 2 ]]; grep -F 'you do not yet know what their geometry means' "$F"

python - "$STORY" "$MANIFEST" <<'PY_ID'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text()); b=Path('glulx/build/clue-chains-1268'); r=json.loads((b/'story-report.json').read_text()); ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}; (b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n'); print('RELEASE_1268_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True)); e=m['expected_artifact']; rec={'release':1268,'serial':m['serial'],'base_release':1267,'base_artifact_sha256':m['base_artifact_sha256'],'base_source_sha256':m['base_source_sha256'],'histories':['premature-engraving','learn-across-fixed-clues','unread-field-mark','full-clue-chain','predecessor-blackening']}
if e.get('locked') is not True:
 rec.update({'artifact_identity_locked':False,'candidate':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n'); raise SystemExit('Release 1268 candidate completed gameplay qualification; lock the exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
 if ident.get(k)!=e.get(k): raise SystemExit(f'Release 1268 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident}); (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY_ID

echo "Release 1268 Clue Chains qualification passed."
