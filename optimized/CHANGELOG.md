# Changelog

## Release 120 — 2026-07-18

Project-local optimized edition based on the preserved Release 119 / serial 880429 source. Release 120 is not presented as an official Infocom release.

### Fixed

- Prevented recursive container placement from creating cycles in the Z-machine object tree (`Z1-BUG-001`).
- Made the temple candle room description reflect whether the candles are actually lit (`Z1-BUG-002`).
- Replaced two unsafe printed tab characters with equivalent spaces for Z-machine version 3 (`Z1-PORT-001`).
- Made optimized include names match the lowercase repository filenames on case-sensitive systems.
- Prevented modern builds from overwriting historical root artifacts.
- Made source drift and patch-anchor drift fail closed instead of silently mixing or partially modifying revisions.
- Corrected the structural checker to understand semicolon-suppressed forms, single atoms, character literals, splice forms, escaped token characters, and active include strings.
- Stopped names such as `HACK-HACK` from being mislabeled as unfinished-work markers.

### Added

- Explicit Release 120 / serial 260718 build identity.
- Deterministic two-stage ZILF-to-ZAPF build with explicit release and serial arguments.
- Verified historical source staging with Git blob receipts.
- Exact-match behavioral and portability patch layer with build receipts.
- Conservative ZIL structural and smell audit.
- Z-machine header, identity, address, length, and checksum verification.
- Tool unit tests covering reader syntax, identity validation, patch application, and patch drift rejection.
- Deterministic opening smoke route executed through Frotz.
- Pinned CI build of ZILF and ZAPF from source.
- Preservation policy, architecture audit, bug ledger, and validation record.

### Validated result

- Story: `zork1-optimized.z3`
- Z-machine: version 3
- Release / serial: 120 / 260718
- Size: 87,012 bytes
- Checksum: 41,234, valid
- Structural audit: 0 errors, 2 retained redefinition warnings
- Runtime smoke: passed

### Intentionally unchanged

- Parser grammar, puzzle design, world layout, scoring, timing, randomness, combat, and classic prose outside the two narrowly documented state/portability corrections.
