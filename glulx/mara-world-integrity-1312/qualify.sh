#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BASE_BUILD="$ROOT/glulx/build/natural-play-fidelity-1311"
BUILD="$ROOT/glulx/build/mara-world-integrity-1312"
BASE_SRC="$BASE_BUILD/src"
BASE_DEV_SRC="$BASE_BUILD/dev-src"
SRC="$BUILD/src"
DEV_SRC="$BUILD/dev-src"
MANIFEST="$ROOT/glulx/mara-world-integrity-1312/patch-series.json"
TRAIN="$ROOT/.beads/onyx_zork_mara_world_integrity_1312.beadtrain"
QDIR="$ROOT/glulx/mara-world-integrity-1312/qualification"
cd "$ROOT"
bash glulx/natural-play-fidelity-1311/qualify.sh
rm -rf "$BUILD"
mkdir -p "$BUILD"
python -m py_compile glulx/mara-world-integrity-1312/stage.py
python .beads/beadtrains/scripts/validate_beadtrain.py "$TRAIN"
python glulx/mara-world-integrity-1312/stage.py --base-source "$BASE_SRC" --destination "$SRC" --manifest "$MANIFEST"
python glulx/mara-world-integrity-1312/stage.py --base-source "$BASE_DEV_SRC" --destination "$DEV_SRC" --manifest "$MANIFEST"
python optimized/tools/zil_smell_check.py --source "$SRC" --json "$BUILD/smell-report.json"
python optimized/tools/zil_smell_check.py --source "$DEV_SRC" --json "$BUILD/dev-smell-report.json"
python - <<'PY'
import json
from pathlib import Path
def req(c, m):
    if not c: raise SystemExit(m)
b = Path('glulx/build/mara-world-integrity-1312')
s = b / 'src'
m = json.loads(Path('glulx/mara-world-integrity-1312/patch-series.json').read_text())
r = json.loads((s / 'STAGING-RECEIPT.json').read_text())
req(r['release'] == 1312 and r['base']['release'] == 1311, 'Release 1312 staging mismatch')
req(r['changed_paths'] == sorted(m['expected_changed_paths']), 'Release 1312 changed paths mismatch')
req(not json.loads((b / 'smell-report.json').read_text())['errors'], '1312 production smell errors')
req(not json.loads((b / 'dev-smell-report.json').read_text())['errors'], '1312 dev smell errors')
req('<CONSTANT RELEASEID 1312>' in (s / 'zork1.zil').read_text(), '1312 identity missing')
parser = (s / 'gparser.zil').read_text()
req('<NOT <AND .ANDFLG' in parser and '<WT? .WRD ,PS?VERB' in parser, 'directed homonym CLAUSE guard missing')
movement = (s / 'mara_companion_movement.zil').read_text()
req('MARA-GRUE-COLONY-DEATH' in movement, 'Mara grue death path missing')
req('MARA-MINE-ROUTE?' in (s / 'mara_companion_state.zil').read_text(), 'Mara mine route missing')
actions = (s / '1actions.zil').read_text()
req(actions.count('<MOVE-ALL ,INFLATED-BOAT ,HERE>') >= 2, 'boat occupant evacuation missing')
syntax = (s / 'gsyntax.zil').read_text()
req('<SYNONYM INFLAT INFLATE>' in syntax, 'full INFLATE vocabulary missing')
verbs = (s / 'gverbs.zil').read_text()
req('<EQUAL? ,PRSO ,INFLATED-BOAT>' in verbs and '<RBOAT-FUNCTION>' in verbs, 'LAUNCH boat dispatch missing')
actor = (s / 'mara_companion_actor.zil').read_text()
req('<EQUAL? ,PRSI ,MARA> <VERB? THROW>' in actor, 'thrown-object Mara intent dispatch missing')
prod = '\n'.join(p.read_text(errors='ignore') for p in s.glob('*.zil'))
for bad in ('SURVEYKILL','SURVEYREWIND','ALTSAFE','ALTTROLL','FAIRHERE','FAIRBANK','FAIRDUSK','FAIRWIND','FAIRWATCH','FAIRFISH'):
    req(bad not in prod, 'production leak ' + bad)
PY
read -r SERIAL STORY_FILE < <(python - "$MANIFEST" <<'PY'
import json,sys
from pathlib import Path
m=json.loads(Path(sys.argv[1]).read_text()); print(m['serial'], m['expected_artifact']['file'])
PY
)
ZILF="$(realpath "$(find .tooling/zilf-glulx -path '*/bin/Release/*/zilf.dll' -print -quit)")"
GLAZER="$(realpath "$(find .tooling/glazer-source -type f -name glazer -perm -111 -print -quit)")"
compile_story(){
  local source="$1" asm="$2" out="$3" prefix="$4"
  pushd "$source"
  dotnet "$ZILF" build --glulx --stop-after-compile zork1.zil "$asm" 2>&1 | tee "$BUILD/$prefix-zilf-compile.log"
  popd
  python "$ROOT/glulx/tools/normalize_serial.py" "$asm" --serial "$SERIAL" --receipt "$BUILD/$prefix-SERIAL-NORMALIZATION.json"
  "$GLAZER" "$asm" -o "$out" 2>&1 | tee "$BUILD/$prefix-glazer-assemble.log"
}
STORY="$BUILD/$STORY_FILE"
compile_story "$SRC" "$BUILD/release1312.asm" "$STORY" production
python glulx/tools/verify_ulx.py "$STORY" --json "$BUILD/story-report.json"
compile_story "$DEV_SRC" "$BUILD/release1312-dev.asm" "$BUILD/release1312-dev.ulx" dev
python glulx/tools/verify_ulx.py "$BUILD/release1312-dev.ulx" --json "$BUILD/dev-story-report.json"
if [[ ! -x "$ROOT/.tooling/glulxe/glulxe" ]]; then
  make -C "$ROOT/.tooling/cheapglk"
  make -C "$ROOT/.tooling/glulxe" OPTIONS="-O2 -Wall -Wmissing-prototypes -Wno-unused -DOS_UNIX -DUNIX_RAND_GETRANDOM"
fi
GLULXE="$(realpath "$ROOT/.tooling/glulxe/glulxe")"
run_case(){
  local name="$1" input="$2"; shift 2
  local transcript="$BUILD/$name-transcript.txt"
  timeout 180s "$GLULXE" --rngseed 123456 --undo 16 "$STORY" < "$input" > "$transcript" 2>&1
  for needle in "$@"; do
    grep -F "$needle" "$transcript" >/dev/null || { echo "--- $name ---" >&2; cat "$transcript" >&2; exit 1; }
  done
}
run_case boat-natural "$QDIR/boat-natural.txt" \
  'Release 1312' \
  'The boat inflates and appears seaworthy.' \
  'Mara Tallow steps into the magic boat.' \
  'You are now in the magic boat.' \
  'Frigid River, in the magic boat'
! grep -F 'There was no verb in that sentence!' "$BUILD/boat-natural-transcript.txt" || exit 1
run_case canyon-natural "$QDIR/canyon-natural.txt" \
  'Real object, yes, she says. Field evidence, no.' \
  'The first shared entry in the Last Honest Survey now exists as a physical document.' \
  'Trust is not a substitute for rope.' \
  'Fine. One experiment.' \
  'We already have that measurement'
run_case grue-natural "$QDIR/grue-natural.txt" \
  'this dead end borders a grue colony.' \
  'I will wait here, she says, not everywhere and not forever.' \
  'Mara Tallow has been eaten by a grue.' \
  "You can't see any mara here!"
run_case boat-sharp-puncture "$QDIR/boat-sharp-puncture-natural.txt" \
  'Oops! Something sharp seems to have slipped and punctured the boat.' \
  'There is a punctured boat here.' \
  'There is a tan label here.' \
  'Mara Tallow is here with a waxed survey book'
run_case harm-natural "$QDIR/harm-natural.txt" \
  "This time you chose me as the danger's target." \
  'Distance is part of what I asked for.'
run_case ladder-natural "$QDIR/ladder-natural.txt" \
  'Mara starts down the maintenance ladder with her measured rope looped for a handline.' \
  'Her field rope lands in your hands.'
python - "$STORY" "$MANIFEST" <<'PY'
import hashlib,json,sys
from pathlib import Path
story=Path(sys.argv[1]); m=json.loads(Path(sys.argv[2]).read_text())
b=Path('glulx/build/mara-world-integrity-1312')
r=json.loads((b/'story-report.json').read_text())
ident={'file':story.name,'format':'Glulx','version_hex':r['version_hex'],'size_bytes':story.stat().st_size,'checksum_hex':r['checksum_hex'],'sha256':hashlib.sha256(story.read_bytes()).hexdigest()}
print('RELEASE_1312_ARTIFACT_IDENTITY='+json.dumps(ident,sort_keys=True))
(b/'CANDIDATE-IDENTITY.json').write_text(json.dumps(ident,indent=2,sort_keys=True)+'\n')
e=m['expected_artifact']
rec={'release':1312,'serial':m['serial'],'base_release':1311,'histories':['boat-natural','canyon-natural','grue-natural','boat-sharp-puncture','harm-natural','ladder-natural']}
if e.get('locked') is not True:
    rec.update({'artifact_identity_locked':False,'candidate':ident})
    (b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
    raise SystemExit('Release 1312 product gameplay passed; lock exact artifact identity and rerun.')
for k in ('file','version_hex','size_bytes','checksum_hex','sha256'):
    if ident.get(k) != e.get(k):
        raise SystemExit(f'Release 1312 artifact drift for {k}: expected {e.get(k)}, got {ident.get(k)}')
rec.update({'artifact_identity_locked':True,'artifact':ident})
(b/'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec,indent=2,sort_keys=True)+'\n')
PY
echo 'Release 1312 Mara World Integrity qualification passed.'
