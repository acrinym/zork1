# Changelog

## Unreleased

### Fixed

- Prevented recursive container placement from creating cycles in the Z-machine object tree (`Z1-BUG-001`); source patch is complete and runtime transcript validation is pending.
- Made the optimized entrypoint’s include names match the lowercase source filenames for case-sensitive build environments.
- Added automatic support for both modern ZILF direct `.z3` output and legacy ZILF plus ZAPF assembly.
- Corrected the smell checker to understand semicolon-suppressed multi-line ZIL forms instead of treating them as line comments.
- Prevented modern builds from overwriting historical root artifacts by isolating all generated output.
- Added source-drift failure instead of silently mixing revisions.
- Corrected the audit workflow’s staging-receipt artifact path.

### Added

- Exact-match behavioral patch layer with fail-closed source anchors and build receipts.
- Verified source staging with Git blob receipts.
- Conservative ZIL structural and smell checker.
- Z-machine header and checksum verifier.
- Deterministic opening smoke route.
- Unit tests for tooling, ZIL comment parsing, patch application, and patch drift rejection.
- Preservation policy, initial audit, and behavioral bug ledger.

### Intentionally unchanged

- Parser grammar, puzzles, world layout, scoring, timing, randomness, combat, and classic player-facing prose.
