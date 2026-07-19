# Expansion frontier

Release 121 establishes the architecture and first broad implementation wave. The unchanged upstream Glulx baseline is now reproducible and qualified. The controlling next train is the conservative Release 120 port onto that baseline.

Gameplay-deepening trains remain valid, but must follow Release 120 and Release 121 Glulx parity rather than increasing the version 3 migration burden first.

## 0. Glulx upstream reconciliation train — complete

The first Glulx train now provides:

- exact reconciliation of Tara McGrew's `glulx` branch with current upstream;
- a complete seven-file upstream diff;
- pinned ZILF 1.8, Glazer 1.2.0, Glulxe, and CheapGlk;
- source-tarball, license, archive, and story checksums;
- deterministic normalization of ZILF's wall-clock Glulx serial metadata;
- a fail-closed repository artifact;
- inspection and native execution of `zork1-glulx.zip`;
- native identity and opening smoke routes for both stories;
- independent preservation of all historical and `.z3` project editions.

Controlling qualification records:

- [`../../glulx/README.md`](../../glulx/README.md)
- [`../../glulx/QUALIFICATION.md`](../../glulx/QUALIFICATION.md)
- [`GLULX_UPSTREAM_MIGRATION.md`](GLULX_UPSTREAM_MIGRATION.md)
- [`GLULX_LICENSING.md`](GLULX_LICENSING.md)

## 0.1 Release 120 Glulx port — controlling next train

Create a new Glulx staging layer from the qualified unchanged baseline and port only the conservative optimized-edition corrections:

1. recursive-containment protection;
2. candle object and description-routine corrections;
3. unsafe printed-character replacements;
4. case-sensitive include and portability auditing;
5. deterministic repository-local identity and artifact verification.

The train must:

- preserve Tara's seven Glulx compatibility changes exactly;
- apply each Release 120 change through an exact, fail-closed patch or override;
- assign a clearly unofficial Glulx identity distinct from Tara's Release 1 baseline and the `.z3` Release 120 artifact;
- retain the qualified unchanged baseline as a separately buildable artifact;
- run native regression routes for recursive containment and extinguished candles;
- prove the historical Release 119, optimized Release 120 `.z3`, and expanded Release 121 `.z3` gates still pass;
- document the next Release 121 action-hook layer without implementing expanded gameplay in the same train.

No assistance commands, reactive scenery, optional geography, NPC alternatives, or Adventurer Misconduct code enters this train.

## 0.2 Release 121 Glulx action and assistance layer

After the conservative Release 120 port is qualified:

- port the action-hook architecture;
- port `GOALS`, `EXITS`, `HINT`, `RECAP`, `WHY`, and `USE`;
- add semantic `.z3` versus `.ulx` routes for opening navigation and assistance;
- keep scenery, optional geography, alternate NPC solutions, and comedy reactions for later isolated layers.

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
