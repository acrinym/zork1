# Releases 1280–1286 — Runtime foundation

Live numbers. The locked player story remains Release **1295** (ordinary Glulx `.ulx`), the same pattern as Release 1279.

| Live | Product |
|---:|---|
| 1280 | Machine-checkable Glulx/Glk contract + pinned interpreters |
| 1281 | Native Glulx ZILF hard-global cap lifted (65535); test-only 320 ordinary globals compile and increment |
| 1282 | Same command history on -O2 and -O3 Glulxe (story SHA unchanged) |
| 1283 | Cross-build compatibility of that history |
| 1284 | Test-only 96 extra rooms compile and `SCALEPROBE` |
| 1285 | Portable bundle: ulx + glulxe + contract + SHA256SUMS + PLAY.txt |
| 1286 | Opt-in `--chronicle-output` host; default creates no chronicle file |

`honesty-qualify.sh` then runs a natural opening playthrough and a Mara honesty session (test-only setup verbs, never production).
