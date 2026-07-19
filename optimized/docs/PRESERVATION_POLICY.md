# Preservation Policy

## Non-negotiable boundary

The repository-root source is the historical record. Work in this edition must not replace, normalize, reformat, rename, or clean up those files in place.

## Allowed change classes

1. **Build-only fixes** — path casing, output placement, deterministic staging, modern tool invocation, and diagnostics.
2. **Demonstrated defect fixes** — a reproducible command sequence shows behavior inconsistent with the source’s evident intent or with the baseline release.
3. **Safety and portability fixes** — malformed output, interpreter incompatibility, invalid story headers, or undefined behavior that can be corrected without changing play.
4. **Documentation and tests** — explanations, receipts, audits, and executable regression cases.

## Changes requiring exceptional evidence

- parser precedence or object-resolution changes;
- puzzle logic, scoring, timing, randomness, combat, or thief behavior;
- room connections, object locations, capacity, weight, or light rules;
- prose corrections that could affect vocabulary or text compression;
- deletion of apparently unused routines or symbols;
- broad renaming, abstraction, or conversion to another language.

## Proof required for a gameplay change

A gameplay patch should include:

- the exact failing command transcript;
- the expected behavior and why it represents original intent;
- the smallest reasonable source change;
- a passing transcript after the change;
- checks that nearby commands and state transitions still behave correctly;
- a note explaining any binary-size or release-number change.

## Optimization priorities

1. Correctness and historical intent
2. Reproducibility
3. Portability
4. Understandability
5. Binary size and runtime performance
6. Cosmetic cleanliness

A smaller or prettier source file is not an optimization when it makes the historical behavior harder to verify.
