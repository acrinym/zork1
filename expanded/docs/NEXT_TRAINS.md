# Expansion frontier

Release 121 establishes the architecture and first broad implementation wave. The next controlling train is now the Glulx upstream reconciliation. Gameplay-deepening trains remain valid, but should follow a reproducible Glulx baseline and parity harness rather than increasing the version 3 migration burden first.

## 0. Glulx upstream reconciliation train — controlling next train

Reconcile this project with Tara McGrew's existing Zork I Glulx port and a current pinned ZILF/Glazer toolchain.

The train must:

- resolve the exact live `taradinoc/zork1` `glulx` branch and compare it with current upstream;
- record licensing and provenance before importing code;
- compile the unchanged upstream Glulx baseline first;
- add deterministic native-interpreter smoke testing and artifact verification;
- port Release 120 fixes before Release 121 expansion layers;
- build semantic and required-prose parity routes between `.z3` and `.ulx`;
- retain all historical, optimized, and expanded `.z3` artifacts;
- avoid new gameplay features until the expanded Glulx artifact is reproducible and meaningfully qualified.

Controlling documents:

- [`GLULX_UPSTREAM_MIGRATION.md`](GLULX_UPSTREAM_MIGRATION.md)
- [`GLULX_LICENSING.md`](GLULX_LICENSING.md)
- [`../../docs/planning/ZORK_GLULX_UPSTREAM_CONTINUATION_HANDOFF_2026_07_19.md`](../../docs/planning/ZORK_GLULX_UPSTREAM_CONTINUATION_HANDOFF_2026_07_19.md)

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
