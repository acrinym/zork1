# Release 1284 — Portable Runtime Bundle

**Live release number (2026-08-30):** 1285  
**This filename keeps 1284 so existing links resolve.**  
**Queued after (live):** Release 1284 — Large-World Scaling  

**Status:** planned product train

## Purpose

Turn the proven story/runtime/compiler work from Releases 1278–1283 into a practical player distribution while preserving the `.ulx` as an independently usable Glulx story.

## Product shape

Produce a versioned HOE runtime bundle containing, as appropriate for each supported platform:

- the locked Highly Extended Zork `.ulx` artifact;
- the optimized pinned Glulxe runtime from Release 1278;
- the runtime/capability manifest from Release 1279;
- checksums and exact version/provenance information;
- simple launcher/start instructions;
- player-facing save/config locations and portability notes;
- licenses/notices required by bundled components.

The bundle should be reproducible from repository-authored sources and pins.

## Player experience

A player should be able to obtain the appropriate bundle, launch Highly Extended Zork without assembling a compiler/interpreter toolchain, and still retain the option to take the `.ulx` to another conforming interpreter covered by the declared compatibility contract.

## Product work

- package supported Windows, Linux, and macOS runtime forms where the Release 1279 host contract permits;
- provide deterministic story identity verification before launch or in diagnostics;
- select sane runtime defaults without hiding interpreter options from advanced users;
- preserve ordinary save/restore and user data across bundle upgrades where compatible;
- include concise local diagnostics for runtime/story identity and failures;
- make release construction reproducible and pin every bundled executable/source input;
- verify the packaged product against the compatibility and scaling guarantees already earned by prior releases.

## Boundaries

- no installer/platform framework that becomes larger than the game product;
- no mandatory online service, account, telemetry backend, or launcher lock-in;
- no custom container format that traps the `.ulx` inside the bundle;
- no auto-updater required for basic use;
- no runtime-only gameplay behavior absent from the standalone story;
- no packaging audit machinery as the release product.

## Success criteria

Release 1284 succeeds when:

1. a clean supported machine can launch and play the locked HOE story from the bundle without a development environment;
2. bundled story/runtime identities are verifiable and reproducible;
3. saves and normal player data behave correctly across the packaged runtime;
4. the `.ulx` can be extracted/used directly in another compatible interpreter without loss of core gameplay;
5. the bundle contains the concrete performance, portability, global-scaling, story-optimization, compatibility, and large-world work of Releases 1278–1283 rather than replacing those products with another wrapper layer.
