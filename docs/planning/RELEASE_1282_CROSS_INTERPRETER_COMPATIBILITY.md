# Release 1282 — Cross-Interpreter Compatibility

**Queued after:** Release 1281 — Story-Code Optimization  
**Status:** planned product train

## Purpose

Make the same locked HOE `.ulx` behave correctly across materially different Glulx implementations instead of accidentally depending on one interpreter's quirks.

This is a compatibility product train, not a compatibility-audit framework.

## Product targets

At minimum, qualify representative locked HOE gameplay on:

- the optimized Glulxe line from Release 1278;
- an independent native Glulx interpreter such as Git where the required Glk/capability surface is available;
- a browser/Javascript implementation such as Quixe for a substantially different execution model.

Exact supported versions are implementation-time decisions and must be pinned in the release receipt.

## Product work

1. Run the same locked story, deterministic setup where appropriate, RNG seed where supported, and natural command histories through the target interpreters.
2. Normalize only host/UI differences that are not game semantics.
3. Fix story/compiler/runtime assumptions that cause genuine semantic divergence.
4. Preserve standards-compliant behavior when one interpreter exposes an ambiguity; do not merely special-case the failing implementation unless that is the correct compatibility boundary.
5. Ensure save files and persistent behavior obey the declared Release 1279 runtime contract to the extent the Glulx/Glk specifications permit portability.
6. Produce a clear supported-interpreter compatibility statement for players and later packaging.

## Boundaries

- no permanent giant matrix of every interpreter/version ever published;
- no recursive compatibility-report generator;
- no changing gameplay merely to make textual whitespace identical across frontends;
- no suppressing real semantic divergences behind normalization;
- no forcing Git, Quixe, or another implementation to become a required runtime;
- no interpreter-specific story hacks where a standards-compliant fix is possible.

## Success criteria

Release 1282 succeeds when:

1. the same release artifact completes representative parser, exploration, stateful puzzle, Mara, save/restore, and late-world histories across the declared interpreter set;
2. any discovered semantic divergence is fixed in the appropriate story/compiler/runtime layer;
3. normalized transcripts and key state outcomes agree where the platform contract says they should;
4. known frontend-only differences are documented without being mistaken for gameplay failures;
5. players receive a concrete compatibility statement naming the interpreter/version combinations actually proven to run HOE.
