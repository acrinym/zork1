# Expansion frontier

Release 121 establishes the architecture and first broad implementation wave. The unchanged upstream and conservative Release 120 Glulx layers are now reproducible and qualified. The controlling next train is Release 121 action hooks and optional assistance.

Gameplay-deepening trains remain valid, but must follow layered Release 121 Glulx parity rather than increasing the version 3 migration burden first.

## 0. Glulx upstream reconciliation train — complete

The first Glulx train provides:

- exact reconciliation of Tara McGrew's `glulx` branch with current upstream;
- a complete seven-file upstream diff;
- pinned ZILF 1.8, Glazer 1.2.0, Glulxe, and CheapGlk;
- source-tarball, license, archive, and story checksums;
- deterministic normalization of ZILF's wall-clock Glulx serial metadata;
- a fail-closed repository artifact;
- inspection and native execution of `zork1-glulx.zip`;
- native identity and opening routes for both stories;
- independent preservation of all historical and `.z3` project editions.

## 0.1 Release 120 Glulx port — complete

The conservative optimized layer now provides:

- an exact staging boundary rooted at Tara's pinned tree;
- fail-closed changes to only `1actions.zil`, `1dungeon.zil`, `gverbs.zil`, and `zork1.zil`;
- recursive-containment protection;
- printed-character portability corrections;
- a Glulx-specific fully dynamic candle room description;
- exact lowercase include paths;
- unofficial Release `1201` / serial `260719` identity;
- a locked 180,992-byte artifact with valid checksum and SHA-256;
- native opening, recursive-containment, and extinguished-candle routes;
- continued independent qualification of Historical 119, Optimized 120 `.z3`, and Expanded 121 `.z3`.

Controlling qualification records:

- [`../../glulx/README.md`](../../glulx/README.md)
- [`../../glulx/QUALIFICATION.md`](../../glulx/QUALIFICATION.md)
- [`../../glulx/optimized/README.md`](../../glulx/optimized/README.md)
- [`GLULX_UPSTREAM_MIGRATION.md`](GLULX_UPSTREAM_MIGRATION.md)
- [`GLULX_LICENSING.md`](GLULX_LICENSING.md)

## 0.2 Release 121 Glulx action and assistance layer — controlling next train

Port only the foundation needed for optional player orientation:

1. Release 121 action-hook architecture;
2. `GOALS`;
3. `EXITS`;
4. tiered `HINT`;
5. `RECAP`;
6. contextual `WHY`;
7. `USE <object>` affordance guidance.

The train must:

- stage from the qualified Release 1201 Glulx layer;
- apply Release 121 hooks and assistance through exact, reviewable patches and overlays;
- assign a new clearly unofficial Glulx identity;
- retain both the unchanged baseline and Release 1201 as separately reproducible artifacts;
- add semantic `.z3` versus `.ulx` routes for opening navigation and each assistance command;
- compare rooms, exits, score, moves where stable, state changes, and required prose markers rather than whitespace-identical transcripts;
- prove all historical and `.z3` gates still pass;
- document the exact reactive-scenery layer without including it here.

Do not port reactive scenery, songbird and Hidden Glade, troll/cyclops/thief alternatives, Adventurer Misconduct, `FOLLY`, or troll bemusement in this train.

## 0.3 Release 121 reactive scenery and world-state layer

After assistance parity:

- port house, boards, doors, windows, mailbox, forest, dam, ritual, rope, mirror, water, and tool reactions;
- preserve persistent expanded state;
- add focused semantic parity routes after each group;
- leave optional geography and NPC alternatives for later isolated layers.

## 0.4 Optional geography and living-character layers

Port in this order:

1. songbird and Hidden Glade;
2. troll bribe;
3. cyclops lullaby;
4. thief bargain;
5. Adventurer Misconduct actions;
6. `FOLLY` and troll bemusement;
7. removal of version 3 object-slot workarounds from the Glulx edition.

## 1. Long-form verification train

Script deterministic routes for:

- cyclops lullaby timing;
- thief bargaining;
- the complete exorcism ceremony;
- dam high/low water states;
- save and restore after new persistent changes;
- recursive-container and candle regressions inherited from Release 120.

The troll treasure bribe already has broad transcript coverage, but should receive an isolated semantic parity route during the Glulx migration.

## 2. Room-density train

Audit every room for its visible nouns and add meaningful support for the most plausible actions:

- examine;
- search;
- listen;
- smell;
- touch;
- look under or behind;
- push, pull, knock, climb, cut, pour, or burn where material suggests it.

The goal is not a unique response to nonsense. It is to stop important scenery from feeling painted on.

## 3. Character-memory train

Deepen the troll, cyclops, and thief with compact state machines:

- remember gifts, threats, mercy, and deception;
- vary later dialogue and tactics;
- allow consequences to survive leaving and returning;
- avoid making them infinitely conversational chatbots.

## 4. Alternate-solutions train

Review each major puzzle under the design charter. Add only routes that use visible information, object affordances, character motives, or mechanism state. Preserve difficulty and all canonical routes.

## 5. Great Underground Empire history train

Add optional environmental storytelling through maintenance records, inscriptions, employee areas, and artifact descriptions. Lore should reward exploration without becoming mandatory exposition.

## 6. Optional geography train

After room density is strong, add a small number of coherent side locations:

- a dam maintenance office or crawlspace;
- a temple crypt;
- a temporary thief cache;
- architectural remnants near existing major mechanisms.

Each location must justify its place through story, puzzle logic, or world reactivity—not merely increase the room count.

## 7. Parser-kindness train

Expand synonyms and intention routing, improve ambiguity messages, and make pronoun and container behavior more predictable. Preserve the command-line identity of Zork rather than replacing it with menus.
