# Zork I Highly Extended Glulx lineage

This directory contains the repository's additive, unofficial Glulx lineage. It begins from a pinned upstream Glulx port and grows through individually staged, individually qualified release trains rather than one mutable “latest” source tree with no provenance.

If you are here to **play** and are new to Zork or parser interactive fiction, start with [`../expanded/README.md`](../expanded/README.md). This README is the technical map of the Glulx line.

Historical Release 119, repository Optimized Release 120, early Expanded Release 121, and other preserved `.z3` editions are not replaced or relabeled by these Glulx release numbers.

## Current lineage

The Highly Extended line described by the current release manifests extends through:

**Release 1263 — Ablative Protection & Equipment Consequence**

Its locked production artifact is:

- `zork1-glulx-ablative-protection-equipment-consequence.ulx`
- Glulx `0x00030103`
- size `468480` bytes
- checksum `0xf5898239`
- SHA-256 `a29a94fe607130c6bc2f86c140b6d3a2d7c065c9ceb80263a5dbfb51db3b3997`

Release 1263 derives from locked Release 1262 artifact SHA-256 `2c0f63695388732af365d0b72b014348c7f1fb438dde0c5b49616ae8fdb81cf9` and pins the exact staged Release 1262 source identities:

- production: `0725e2c777b499356b2da6b13d3f3f6e37261abae2d59e780b6ea3d94c769fa2`
- dev: `be8b33560edaadd2af2ea13b6d9545d3daa65beeee8775d066af305b57e0022d`

See [`ablative-protection/`](ablative-protection/) for the release-specific manifest, implementation, player contract, tests, staging logic, and qualification script.

## What “release train” means here

A modern train normally contains:

- one substantial player-facing change;
- a `patch-series.json` manifest naming its exact predecessor;
- exact base artifact and staged-source identities once locked;
- an explicit set of production paths the train is allowed to change;
- a staging script which refuses predecessor or changed-path drift;
- release-specific production source or patches;
- test-only setup/status controls kept out of production;
- parser-command or integration qualification routes;
- a compiled Glulx artifact with validated header checksum;
- a locked size/checksum/SHA-256 identity;
- hosted evidence on the exact head being reviewed when applicable.

The intent is to make the claim “Release N behaves this way” reproducible and reviewable rather than anecdotal.

## Major lineage arcs

The directory still contains the early Glulx porting history—upstream, optimized, assistance, reactive surface, shadow logic, absurd alternates, Dam mechanisms, ritual resonance, material consequences, room density, and persistence work. Release-specific READMEs preserve that detail.

The modern Highly Extended program then grew through these larger arcs:

| Releases | Arc | Purpose |
|---|---|---|
| 1219–1230 | House of Records | Persistent expedition history, physical records, case files, playback, rest/dream history, vulnerability, chronology, comparison, export, save/corrupt/restore |
| 1231–1242 | Parser / museum / ecology / field systems | Causal warning, parser depth, evidence custody, Mara's first presence, cuisine/hunger/stamina, canyon survival, veteran expedition, Cellar recovery, fishing and ecology provenance |
| 1243–1245 | Mara / natural play | Physical companion foundation, House company, consent/boundaries, actor/personhood routing, creative-play repair |
| 1246–1249 | Material and narrative physicality | Environmental destruction, richer physical prose, forest consequence, rope/cargo behavior, underground material/sensory detail |
| 1250–1257 | Player ingenuity and living consequences | Systemic workarounds, cross-system utility, route mastery, Dam survival/rescue, troll weapons, thief retaliation, grue ecology, authored fire/smoke/structure |
| 1258–1261 | Mara causal history | Shared danger, field capability, lived feeling, rupture/repair, anticipation, worry, protective initiative |
| 1262 | Hostile Rooms & Reactive Threats | Original treasure-guardian dragon and hoard; retreat, bargain, bait/containment, real-fire smoke leverage, causal lethal mistakes |
| 1263 | Ablative Protection & Equipment Consequence | Physical fire screen that survives by taking the dragon's consequence and carries sound → scorched → warped material history |

Major Mara-only subsystem expansion pauses after Release 1261 while the rest of Zork receives comparable authored depth.

## Release 1262 — Dragon & Hoard

[`hostile-rooms-dragon-hoard/`](hostile-rooms-dragon-hoard/) adds a Scorched Cleft, Dragon Gallery, and Hoard Vault branching from the real Timber Room.

The guardian dragon is encounter-specific. There is no HP pool, initiative system, random attack loop, generic hostility meter, or universal enemy framework. The player can physically retreat, bargain with a held real treasure, bait the dragon under a real grille and pull the canonical `MOVE`-mapped `PULL CHAIN` action, or exploit smoke produced by Release 1257's existing Timber Room fire authority.

Locked artifact:

- `zork1-glulx-hostile-rooms-dragon-hoard.ulx`
- size `466432`
- checksum `0x8d167131`
- SHA-256 `2c0f63695388732af365d0b72b014348c7f1fb438dde0c5b49616ae8fdb81cf9`

The final qualifier proves actual hoard custody, not merely matching room prose: bargain ends with exactly one new hoard item held, containment permits both, real fire/smoke permits the intended environmental opening, ignored warnings remain lethal, and retreat remains safe.

## Release 1263 — Ablative Protection

[`ablative-protection/`](ablative-protection/) composes with two existing authorities instead of replacing them:

1. the established `USE <object> ON/WITH <object>` action path; and
2. Release 1262's exact `DRAGON-BREATH-DEATH` hazard routine.

A held, deliberately braced iron-bound hide screen takes the actual dragon-breath consequence. One blast leaves it scorched; a second leaves it warped; the warped geometry no longer honestly supports another protection claim. The same object therefore becomes physical evidence of the danger it prevented.

There is no armor class, equipment HP, durability percentage, generic block verb, mitigation roll, repair economy, or universal equipment-damage system.

Mutable screen state is held in a compact table rather than consuming additional VM globals.

## Canonical-authority rule

When original or earlier Zork code already owns a fact, later trains should observe or compose with that authority rather than invent a parallel truth.

This applies especially to:

- exact journey-critical object identity;
- map exits and traversal state;
- canonical puzzle flags and timers;
- parser grammar and internal verb actions;
- creature state;
- existing physical authorities such as Release 1257 fire;
- save/restore semantics;
- canonical solutions and score-bearing routes.

The rule is not “never add behavior.” It is “do not lie about who owns the state.”

## VM/global budget

The Glulx port is close to its legacy global-variable limit. New trains must not casually consume globals merely because a feature has state. Compact mutable tables, flags on real objects, and existing authorities are preferred when they represent the state honestly.

Release 1262 initially exposed this limit during qualification; its dragon state was moved into a compact table. Release 1263 follows that model from the start.

## Locked toolchain

Modern qualification uses pinned toolchain/source inputs including:

| Component | Pin |
|---|---|
| Upstream Zork Glulx source | `1ada70e58ac4933446b907d67949d9cab3119c0e` |
| ZILF 1.8 | `45c60f1e37651f266ac92d49ae01748bb4909fa5` |
| Glazer source | v1.2.0, SHA-256 `a45edadb140111b5df44a3f49ca4e2b8ec0550d63a6cdee7c93bec93a79ed482` |
| Glulxe | `56ab8743bab565de307bd892c555d8d8897ed517` |
| CheapGlk | `14d8aaf6e4150669762bd4646a5368e75c1eeee6` |

See [`QUALIFICATION.md`](QUALIFICATION.md) and [`provenance.json`](provenance.json) for early toolchain/provenance history; later release-specific manifests and qualification scripts are authoritative for their own trains.

## Serial normalization

Pinned ZILF can emit build-date metadata. Production pipelines compile to assembly, normalize exactly the committed serial, and then assemble the `.ulx`. The normalization receipt, Glulx header checksum, size, and SHA-256 all participate in fail-closed qualification.

## Production versus test controls

Many release qualifiers need deterministic setup so they can exercise a late-game situation without replaying the entire game for every scenario. Those setup/status verbs live in test-only source injected only into qualification stories.

Production qualification specifically checks that the shipped staged tree does not contain those controls and that real player actions invoke the production behavior being claimed.

## Design boundaries

The active line deliberately avoids turning every successful authored feature into a universal framework. In particular:

- no universal crafting grid;
- no arbitrary object-pair matrix;
- no generic physics simulator;
- no generic creature AI brain;
- no generic companion/relationship score;
- no procedural loot treadmill;
- no generic armor/durability engine;
- no recursive audit machinery;
- no TODO-only release slices or no-op scaffolding.

A reusable abstraction should be earned by multiple real authored cases, not created preemptively because abstraction is fashionable.

## Planning

Current product sequencing lives under [`../docs/planning/`](../docs/planning/), especially:

- [`../docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md`](../docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md)
- [`../docs/planning/PRODUCT_KANBAN.md`](../docs/planning/PRODUCT_KANBAN.md)
- [`../docs/planning/product-kanban.json`](../docs/planning/product-kanban.json)

For player-facing orientation, return to [`../expanded/README.md`](../expanded/README.md).
