# Changelog

## Unreleased

### Fixed

- Made the optimized entrypoint’s include names match the lowercase source filenames for case-sensitive build environments.
- Added automatic support for both modern ZILF direct `.z3` output and legacy ZILF plus ZAPF assembly.
- Corrected the smell checker to understand semicolon-suppressed multi-line ZIL forms instead of treating them as line comments.
- Prevented modern builds from overwriting historical root artifacts by isolating all generated output.
- Added source-drift failure instead of silently mixing revisions.

### Added

- Verified source staging with Git blob receipts.
- Conservative ZIL structural and smell checker.
- Z-machine header and checksum verifier.
- Deterministic opening smoke route.
- Unit tests for tooling and ZIL comment parsing.
- Preservation policy and initial audit.

### Intentionally unchanged

- Game rules, parser semantics, puzzles, world data, scoring, timing, randomness, and player-facing prose.
