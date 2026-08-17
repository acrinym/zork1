# Zork I Highly Extended Glulx lineage

This directory contains the repository's additive, unofficial Glulx lineage. It begins from a pinned upstream Glulx port and grows through individually staged, individually qualified release trains rather than one mutable “latest” source tree with no provenance.

If you are here to **play** and are new to Zork or parser interactive fiction, start with [`../expanded/README.md`](../expanded/README.md). This README is the technical map of the Glulx line.

Historical Release 119, repository Optimized Release 120, early Expanded Release 121, and other preserved `.z3` editions are not replaced or relabeled by these Glulx release numbers.

## Current lineage

**Merged production frontier:** Release 1266 — Learned Magic as Parser Capability, merged through PR #71 at `4425732bfc2fa28347453d9991513aeb28aaa531`.

**Open stacked predecessor:** Release 1267 — Semantic Examination & Hidden Structure, PR #72, reviewed exact head `4c3522a0cfa8194764f52ce2e91930ef89bda1bf`. Its locked production artifact is:

- `zork1-glulx-semantic-examination-hidden-structure.ulx`
- Glulx `0x00030103`
- size `479744` bytes
- checksum `0x464b20d2`
- SHA-256 `828383a78549cce45d26f888d14eb37838c74ce5b44588423eb8eca036ef77f0`

**Qualified current stacked train:** Release 1268 — Clue Chains & Knowledge-Gated Interpretation, PR #73. Its locked production artifact is:

- `zork1-glulx-clue-chains-knowledge-interpretation.ulx`
- Glulx `0x00030103`
- size `482816` bytes
- checksum `0x53de973e`
- SHA-256 `bd663f335fb1500f809e797c92cc571a7828e5f410aebd2a1878298d65141f16`

Release 1268 derives from locked Release 1267 and pins exact staged Release 1267 source identities:

- production: `8b6e2080f34dce6000ec54377649775ad17953063780345db1ad2ad0f49de4e6`
- development: `d9da3ad47c92abe719c52ea424c17e3066fc6f71253c0117f358325093d34563`

See [`semantic-examination/`](semantic-examination/) and [`clue-chains/`](clue-chains/) for release-specific manifests, implementations, player contracts, tests, staging logic, and qualification scripts.

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

| Releases | Arc | Purpose |
|---|---|---|
| 1219–1230 | House of Records | Persistent expedition history, physical records, case files, playback, rest/dream history, vulnerability, chronology, comparison, export, save/corrupt/restore |
| 1231–1242 | Parser / museum / ecology / field systems | Causal warning, parser depth, evidence custody, Mara's first presence, cuisine/hunger/stamina, canyon survival, veteran expedition, Cellar recovery, fishing and ecology provenance |
| 1243–1245 | Mara / natural play | Physical companion foundation, House company, consent/boundaries, actor/personhood routing, creative-play repair |
| 1246–1249 | Material and narrative physicality | Environmental destruction, richer physical prose, forest consequence, rope/cargo behavior, underground material/sensory detail |
| 1250–1257 | Player ingenuity and living consequences | Systemic workarounds, cross-system utility, route mastery, Dam survival/rescue, troll weapons, thief retaliation, grue ecology, authored fire/smoke/structure |
| 1258–1261 | Mara causal history | Shared danger, field capability, lived feeling, rupture/repair, anticipation, worry, protective initiative |
| 1262–1263 | Hostile rooms and physical protection | Dragon/hoard reactive threat plus ablative fire-screen consequence |
| 1264 | Perilous affordances | Physically possible destruction and misuse stop being parser-protected merely for puzzle utility |
| 1265 | Consumable light | Existing light timers gain authored bright/weak/ember reach, wet ritual candles, and fire/smoke composition |
| 1266 | Learned magic | In-world reconstructed knowledge makes a bounded stilling ward meaningful without a generic spell system |
| 1267 | Semantic examination | Selected prose details become trustworthy parser targets; existing detail authority is preserved; examination can reveal bounded hidden structure |
| 1268 | Clue chains | Named learned meaning persists across fixed source clues and changes later interpretation without a generic clue registry or inventory-key requirement |

Major Mara-only subsystem expansion pauses after Release 1261 while the rest of Zork receives comparable authored depth.

## Releases 1262–1263 — Dragon and protection foundation

Release 1262 adds a Scorched Cleft, Dragon Gallery, and Hoard Vault branching from the real Timber Room. The guardian dragon is encounter-specific: retreat, bargain, containment, and Release 1257 real-fire smoke leverage remain authored alternatives rather than a generic boss system.

Release 1263 adds an iron-bound hide fire screen that physically takes the existing dragon-breath consequence and carries sound → scorched → warped history. There is no armor class, durability percentage, mitigation roll, repair economy, or universal equipment-damage engine.

## Releases 1264–1266 — Agency, light, and learned capability

Release 1264 lets selected physically possible bad ideas occur: the canonical lantern and rope, Release 1263 screen, and Release 1262 star-glass can suffer authored consequences rather than meta-game refusal.

Release 1265 preserves canonical lamp/candle timers and binary `LIT?` while adding authored useful-reach states, real waterlogged ritual candle wicks, and composition with existing fire/smoke/draft authorities.

Release 1266 makes deliberate in-world study meaningful. The original GUE stilling ward can settle Release 1265 candle wetness or canonical hot-bell state only after the Adventurer genuinely learns it. Existing Hades ceremony and house-ward grammar remain authoritative. Learned state uses a compact mutable table rather than new legacy globals.

## Release 1267 — Semantic Examination & Hidden Structure

Release 1267 promotes selected currently-unaddressable prose details into real scoped parser objects: the Timber Room draft, Scorched Cleft scratches/bones, and Dragon Gallery heat blackening.

Examining the existing heat/soot geometry can reveal a real high ventilation seam. The seam starts outside parser scope, so guessing its noun before discovery does not reveal it. Once discovered, its ordinary object location is the knowledge state. It remains too small to traverse and reports Release 1257/1262 fire-smoke truth rather than inventing a second ventilation or dragon model.

Qualification also found that Release 1218 Room Density already owns Troll Room bloodstains/scratches. The initial duplicate 1267 objects were removed and the predecessor module is byte-identity checked, turning that discovery into an authority-preservation regression.

Release 1267 adds zero legacy VM globals.

## Release 1268 — Clue Chains & Knowledge-Gated Interpretation

Release 1268 adds the bounded `INTERPRET`/`DECIPHER` action and one original field marking while preserving the canonical fixed Temple prayer and Engravings Cave inscription byte-for-byte.

Deliberately interpreting the North Temple prayer learns enough of the old script's structure to compare a second source. Interpreting the damaged Engravings Cave material before that knowledge fails safely; afterward, one surviving practical air-passage motif becomes recognizable without reconstructing the deliberately excised doctrine.

That remembered motif changes how the same visible old marking in the Dragon Gallery is understood. Deliberate interpretation can identify Release 1267's existing `DRAGON-VENT-SEAM`; it never creates a second vent, smoke authority, or hidden route. Release 1267's physical `EXAMINE BLACKENING` route remains independently valid with all 1268 clue facts unset.

The prayer and engravings remain in their original rooms throughout qualification. Three exact facts use one compact mutable table; Release 1268 adds zero legacy VM globals and no generic clue registry, notebook, archaeology engine, or automatic hint system.

Candidate qualification `32049638837` passed all five histories and intentionally stopped at the lock gate. Locked run `32050047910` reproduced artifact SHA-256 `bd663f335fb1500f809e797c92cc571a7828e5f410aebd2a1878298d65141f16` on locked implementation head `78a6c0ef6a4202c384deab93accd66f2620b3e4c`.

## Canonical-authority rule

When original or earlier Zork code already owns a fact, later trains should observe or compose with that authority rather than invent a parallel truth.

This applies especially to exact journey-critical object identity, map exits/traversal state, canonical puzzle flags/timers, parser grammar/internal verb actions, creature state, existing physical authorities such as Release 1257 fire, save/restore semantics, canonical solutions, and previously promoted semantic targets.

The rule is not “never add behavior.” It is “do not lie about who owns the state.”

## VM/global budget

The Glulx port is close to its legacy global-variable limit. New trains must not casually consume globals merely because a feature has state. Compact mutable tables, flags on real objects, ordinary object location, and existing authorities are preferred when they represent the state honestly.

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

The active line deliberately avoids turning every successful authored feature into a universal framework. In particular: no universal crafting grid, arbitrary object-pair matrix, generic physics simulator, generic creature AI brain, generic companion/relationship score, procedural loot treadmill, generic armor/durability engine, recursive audit machinery, TODO-only release slices, or no-op scaffolding.

A reusable abstraction should be earned by multiple real authored cases, not created preemptively because abstraction is fashionable.

## Planning

Current product sequencing lives under [`../docs/planning/`](../docs/planning/), especially:

- [`../docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md`](../docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md)
- [`../docs/planning/RELEASE_1274_ENVIRONMENTAL_MECHANISMS_DIEGETIC_PUZZLE_FURNITURE.md`](../docs/planning/RELEASE_1274_ENVIRONMENTAL_MECHANISMS_DIEGETIC_PUZZLE_FURNITURE.md)
- [`../docs/planning/PRODUCT_KANBAN.md`](../docs/planning/PRODUCT_KANBAN.md)
- [`../docs/planning/product-kanban.json`](../docs/planning/product-kanban.json)

For player-facing orientation, return to [`../expanded/README.md`](../expanded/README.md).
