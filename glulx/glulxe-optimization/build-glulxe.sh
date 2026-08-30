#!/usr/bin/env bash
# Build one Glulxe tree with explicit OPTIONS against a CheapGlk tree.
set -euo pipefail
SRC="$1"
GLKDIR="$2"
OUT_NAME="${3:-glulxe}"
OPTIONS="$4"
make -C "$SRC" clean
make -C "$SRC" \
  GLKINCLUDEDIR="$GLKDIR" \
  GLKLIBDIR="$GLKDIR" \
  GLKMAKEFILE=Make.cheapglk \
  OPTIONS="$OPTIONS"
if [[ ! -x "$SRC/glulxe" ]]; then
  echo "Glulxe binary missing after build in $SRC" >&2
  exit 1
fi
if [[ "$OUT_NAME" != "glulxe" ]]; then
  cp -a "$SRC/glulxe" "$SRC/$OUT_NAME"
fi
