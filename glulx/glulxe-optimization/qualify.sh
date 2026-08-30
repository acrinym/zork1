#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/glulxe-optimization-1279"
MANIFEST="$ROOT/glulx/glulxe-optimization/runtime-manifest.json"
STORY_SRC="$ROOT/glulx/build/honest-playthrough-perilous-house-1278"
cd "$ROOT"
rm -rf "$BUILD"
mkdir -p "$BUILD/workloads" "$BUILD/run" "$BUILD/pgo-data"

bash glulx/honest-playthrough-perilous-house/qualify.sh
python -m py_compile glulx/glulxe-optimization/measure.py

python - "$MANIFEST" "$STORY_SRC" "$BUILD" <<'PY_STORY'
import hashlib, json, sys
from pathlib import Path
m = json.loads(Path(sys.argv[1]).read_text())
src = Path(sys.argv[2])
story = src / m['base_story_file']
if not story.is_file():
    raise SystemExit('Release 1279 missing locked Release 1278 story')
digest = hashlib.sha256(story.read_bytes()).hexdigest()
print('RELEASE_1279_BASE_STORY_SHA256=' + digest)
if digest != m['base_story_sha256']:
    raise SystemExit(f'Release 1279 predecessor story drift: expected {m["base_story_sha256"]}, got {digest}')
dest = Path(sys.argv[3])
(dest / story.name).write_bytes(story.read_bytes())
PY_STORY

cp glulx/glulxe-optimization/workloads/*.txt "$BUILD/workloads/"
python - "$BUILD/workloads/clock-stress.txt" <<'PY_CLOCK'
from pathlib import Path
import sys
p = Path(sys.argv[1])
lines = ['look'] + ['wait'] * 240 + ['quit', 'yes']
p.write_text('\n'.join(lines) + '\n', encoding='utf-8')
PY_CLOCK

python - "$MANIFEST" <<'PY_PIN'
import json, os, subprocess, sys
from pathlib import Path
m = json.loads(Path(sys.argv[1]).read_text())
root = Path(os.environ.get('GITHUB_WORKSPACE') or subprocess.check_output(['git','rev-parse','--show-toplevel'], text=True).strip())
def rev(path):
    return subprocess.check_output(['git','-C', str(path), 'rev-parse', 'HEAD'], text=True).strip()
got = {'glulxe': rev(root/'.tooling/glulxe'), 'cheapglk': rev(root/'.tooling/cheapglk')}
exp = {'glulxe': m['glulxe_commit'], 'cheapglk': m['cheapglk_commit']}
print('RELEASE_1279_RUNTIME_SOURCE=' + json.dumps(got, sort_keys=True))
if got != exp:
    raise SystemExit(f'Release 1279 runtime source pin drift: expected {exp}, got {got}')
PY_PIN

REF_SRC="$BUILD/glulxe-reference"
OPT_SRC="$BUILD/glulxe-optimized"
PROF_SRC="$BUILD/glulxe-profile"
GLK_OPT="$BUILD/cheapglk-optimized"
rm -rf "$REF_SRC" "$OPT_SRC" "$PROF_SRC" "$GLK_OPT"
cp -a "$ROOT/.tooling/glulxe" "$REF_SRC"
cp -a "$ROOT/.tooling/glulxe" "$OPT_SRC"
cp -a "$ROOT/.tooling/glulxe" "$PROF_SRC"
cp -a "$ROOT/.tooling/cheapglk" "$GLK_OPT"
# Fresh copies; Glulxe clean is done inside build-glulxe.sh with GLKINCLUDEDIR.
make -C "$GLK_OPT" clean

python - "$MANIFEST" "$BUILD/flags.env" "$BUILD/pgo-data" <<'PY_OPTS'
import json, sys
from pathlib import Path
m = json.loads(Path(sys.argv[1]).read_text())
pgo = Path(sys.argv[3]).resolve()
lines = [
    "REF_OPTS=" + json.dumps(m['reference_glulxe_options']),
    "GEN_OPTS=" + json.dumps(m['optimized_glulxe_generate_options'] + f' -fprofile-dir={pgo}'),
    "USE_OPTS=" + json.dumps(m['optimized_glulxe_use_options'] + f' -fprofile-dir={pgo}'),
    "PROF_OPTS=" + json.dumps(m['profile_glulxe_options']),
    "GLK_CFLAGS=" + json.dumps(m['optimized_cheapglk_cflags']),
    "MAX_RATIO=" + json.dumps(str(m['max_optimized_over_reference_ratio'])),
    "RUNS=" + json.dumps(str(m['timing_runs'])),
    "SEED=" + json.dumps(str(m['rng_seed'])),
]
Path(sys.argv[2]).write_text('\n'.join(lines) + '\n', encoding='utf-8')
PY_OPTS
# shellcheck disable=SC1091
source "$BUILD/flags.env"

make -C "$GLK_OPT" OPTIONS="$GLK_CFLAGS"

bash glulx/glulxe-optimization/build-glulxe.sh "$REF_SRC" "$ROOT/.tooling/cheapglk" glulxe "$REF_OPTS"
bash glulx/glulxe-optimization/build-glulxe.sh "$PROF_SRC" "$ROOT/.tooling/cheapglk" glulxe "$PROF_OPTS"
timeout 180s "$PROF_SRC/glulxe" --rngseed "$SEED" --profile "$BUILD/profile-raw" "$BUILD/zork1-glulx-honest-playthrough-perilous-house.ulx" \
  < "$BUILD/workloads/parser-heavy.txt" > "$BUILD/profile-transcript.txt" 2>&1 || true
if [[ ! -s "$BUILD/profile-raw" ]]; then
  echo 'Release 1279 profiler produced no profile-raw evidence' >&2
  exit 1
fi

bash glulx/glulxe-optimization/build-glulxe.sh "$OPT_SRC" "$GLK_OPT" glulxe "$GEN_OPTS"
run_all_workloads() {
  local bin="$1"
  local script
  for script in "$BUILD/workloads/"*.txt; do
    timeout 180s "$bin" --rngseed "$SEED" --undo 16 "$BUILD/zork1-glulx-honest-playthrough-perilous-house.ulx" \
      < "$script" > /dev/null 2>&1 || true
  done
}
run_all_workloads "$OPT_SRC/glulxe"
bash glulx/glulxe-optimization/build-glulxe.sh "$OPT_SRC" "$GLK_OPT" glulxe "$USE_OPTS"

cp -a "$REF_SRC/glulxe" "$BUILD/glulxe-reference-bin"
cp -a "$OPT_SRC/glulxe" "$BUILD/glulxe-optimized-bin"

python glulx/glulxe-optimization/measure.py \
  --story "$BUILD/zork1-glulx-honest-playthrough-perilous-house.ulx" \
  --reference "$BUILD/glulxe-reference-bin" \
  --optimized "$BUILD/glulxe-optimized-bin" \
  --workloads "$BUILD/workloads" \
  --cwd "$BUILD/run" \
  --out "$BUILD/MEASUREMENT.json" \
  --seed "$SEED" \
  --runs "$RUNS" \
  --max-ratio "$MAX_RATIO"

python - "$BUILD" "$MANIFEST" "$SEED" <<'PY_SAVE'
import hashlib, json, os, subprocess, sys
from pathlib import Path
build = Path(sys.argv[1])
m = json.loads(Path(sys.argv[2]).read_text())
seed = sys.argv[3]
story = build / m['base_story_file']
# CheapGlk writes the save next to the story file, not an arbitrary cwd.
cwd = build
ref = build / 'glulxe-reference-bin'
opt = build / 'glulxe-optimized-bin'
def play(bin_path, script):
    proc = subprocess.run(
        [str(bin_path), '--rngseed', seed, '--undo', '16', str(story)],
        input=script.read_bytes(),
        cwd=cwd,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )
    return proc.stdout
save_script = Path('glulx/glulxe-optimization/workloads/save-restore/save-setup.txt')
restore_script = Path('glulx/glulxe-optimization/workloads/save-restore/restore-check.txt')
ref_save = play(ref, save_script)
opt_save = play(opt, save_script)
if ref_save != opt_save:
    raise SystemExit('Release 1279 save transcripts diverge')
if not (build / 'r1279.sav').is_file():
    raise SystemExit('Release 1279 did not write a save file')
ref_rest = play(ref, restore_script)
opt_rest = play(opt, restore_script)
if ref_rest != opt_rest:
    raise SystemExit('Release 1279 restore transcripts diverge')
if b'West of House' not in ref_rest:
    raise SystemExit('Release 1279 restore did not return to West of House')
(build / 'save-restore-reference.txt').write_bytes(ref_rest)
print('RELEASE_1279_SAVE_RESTORE=ok')
PY_SAVE

python - "$BUILD" "$MANIFEST" <<'PY_ID'
import hashlib, json, os, subprocess, sys
from pathlib import Path
build = Path(sys.argv[1])
m = json.loads(Path(sys.argv[2]).read_text())
meas = json.loads((build / 'MEASUREMENT.json').read_text())
gcc = subprocess.check_output(['gcc', '-dumpfullversion', '-dumpversion'], text=True).strip().splitlines()[-1]
ident = {
    'release': 1279,
    'kind': 'runtime',
    'base_release': 1278,
    'base_story_file': m['base_story_file'],
    'base_story_sha256': m['base_story_sha256'],
    'glulxe_commit': m['glulxe_commit'],
    'cheapglk_commit': m['cheapglk_commit'],
    'gcc_dumpversion': gcc,
    'reference_glulxe_options': m['reference_glulxe_options'],
    'optimized_glulxe_use_options': m['optimized_glulxe_use_options'],
    'reference_binary_sha256': hashlib.sha256((build / 'glulxe-reference-bin').read_bytes()).hexdigest(),
    'optimized_binary_sha256': hashlib.sha256((build / 'glulxe-optimized-bin').read_bytes()).hexdigest(),
    'optimized_over_reference_ratio': meas['optimized_over_reference_ratio'],
    'profile_raw_sha256': hashlib.sha256((build / 'profile-raw').read_bytes()).hexdigest(),
}
print('RELEASE_1279_RUNTIME_IDENTITY=' + json.dumps(ident, sort_keys=True))
(build / 'RUNTIME-IDENTITY.json').write_text(json.dumps(ident, indent=2, sort_keys=True) + '\n')
rec = {
    'release': 1279,
    'serial_note': 'runtime train; story serial remains Release 1278',
    'base_release': 1278,
    'artifact_identity_locked': True,
    'runtime': ident,
    'measurement': meas,
    'histories': [h['workload'] for h in meas['histories']],
}
(build / 'QUALIFICATION-RECEIPT.json').write_text(json.dumps(rec, indent=2, sort_keys=True) + '\n')
PY_ID

echo 'Release 1279 Glulxe Optimization qualification passed.'
