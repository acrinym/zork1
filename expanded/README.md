# Highly Extended Zork I

This repository contains the preserved historical Zork I source, a conservative optimized edition, the early repository-local Expanded Release 121 line, and the actively developed **Highly Extended Zork I Glulx lineage**.

The old description of `expanded/` as merely Release `121` is now historical. Active product development has continued through **Release `1249` — Underground Sensory Physicality**.

**Current production frontier:** Release `1249`  
**Latest merged PR:** #53  
**`master` head after Release 1249:** `bacb1a358f0ee126ee6ae629b589c3d3a0269ee9`

Release numbers above the original Infocom line are repository-local identities. They are not presented as official Infocom releases.

## Edition map

| Edition / lineage | Identity | Purpose |
|---|---:|---|
| Historical | Release 119 / `880429` | Original repository-root source and compiled story |
| Optimized | Release 120 / `260718` | Narrow bug and portability fixes without deliberate gameplay expansion |
| Early Expanded | Release 121 / `260719` | First additive reactivity, optional discoveries, contextual assistance, and comedy work under `expanded/` |
| Highly Extended Glulx | Releases 1219–1249 | Active product lineage: persistent House history, richer parser affordances, museum/ecology expeditions, cuisine, hazards, Mara, natural-play repair, destructible environments, and expanding physicality |

The active Glulx train uses pinned upstream source/toolchain inputs, staged release manifests, reproducible artifacts, checksum verification, and natural interpreter play.

## Product north star

Build the Zork I that players remember imagining:

- preserve the original world, narrator, score, danger, and canonical solutions;
- make far more reasonable experiments understandable;
- let physical state and object identity matter;
- let the world remember meaningful consequences;
- deepen existing rooms before adding large amounts of map;
- reward curiosity, preparation, absurdity, and replay;
- keep failure informative, funny, causal, or all three.

The project is deliberately **not** becoming a universal physics sandbox, crafting game, procedural-content generator, or chatbot adventure.

## What the game has become

### House of Records — Releases 1219–1230

The white house became a persistent expedition archive rather than static scenery.

The completed twelve-train program added physical records, Attic case files, playback, rest/dream history, vulnerability, completed-expedition records, chronology, cross-run comparison, deterministic export, and save/corrupt/restore behavior.

### Corpus, parser, museum, and field systems — Releases 1231–1242

The next arc added:

- corpus-coupled causal warning and repair affordances;
- deeper parser comprehension for ordinary IF phrasing;
- museum intake and physical evidence custody;
- Mara's first evidence-aware presence;
- cuisine, hunger, satiation, and bounded exertion;
- prepared Great Canyon survival;
- a postgame Veteran Survey Expedition;
- a physical Cellar recovery locker;
- Dam fishing and silverfin provenance;
- songbird correspondence and physical feather/bauble custody;
- troll provenance exhibits;
- broad natural-play regression repair.

### Mara and creative natural play — Releases 1243–1245

Mara Tallow became a physically located companion with her own field work, equipment, boundaries, witnessed knowledge, and remembered shared history.

Her later House chapter added consent-based residence, real travel, shared food, and earned two-person interactions without an approval meter or dating-sim economy.

Release 1245 then repaired creative natural-play seams, actor/personhood routing, hostile-command handling, and witnessed-death behavior uncovered through ordinary play.

### Material and narrative physicality — Releases 1246–1249

The current arc made the world increasingly willing to behave like a place.

- **1246 — Environmental Destruction:** real field stone, mailbox damage, severed mailbox post, breakable Kitchen window, persistent damage, bounded dev/test reset.
- **1247 — Narrative Physicality:** richer House prose, physical responses to surfaces and objects, sack tearing/spilling, rug and table damage, canonical object-authority repair.
- **1248 — Forest Consequence Physicality:** tree impacts/scars, height consequences, sack cargo impacts, canonical egg/bottle handling, rope anchoring, physical fatal-choice narration.
- **1249 — Underground Sensory Physicality:** materially distinct early-GUE stone, damp, dust, air, acoustics, stairs, cracks, chasm geometry, wall impacts, persistent cosmetic scars, and canonical Loud Room/Chasm preservation.

Release 1249's final locked production artifact:

- file: `zork1-glulx-underground-sensory-physicality.ulx`
- Glulx version: `0x00030103`
- size: `414720` bytes
- checksum: `0xdd1d7ac5`
- SHA-256: `b36d4a17ab9682af64c94263fee317065aeacf9072d24cdc9392016ecd32a7a6`

## Next era: player ingenuity

The next product direction is **authorized exploitation of the world model**.

> **Canonical puzzles describe a reliable intended solution. They do not define the only physically valid solution.**

The player should increasingly be able to notice that established mechanics interact and deliberately use those interactions for advantage.

The first planned showcase is the Loud Room:

- canonical `ECHO` remains valid;
- real hearing protection can provide another physically credible way to deal with the room;
- a reusable solution stays reusable on later crossings;
- wearing hearing protection should have sensible consequences for listening elsewhere;
- the alternate solution should not create a giant fetch quest or crafting economy.

The broader rule is that useful objects should behave like useful objects, not colored keys.

See the current roadmap and ordered queue:

- [`../docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md`](../docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md)
- [`docs/NEXT_TRAINS.md`](docs/NEXT_TRAINS.md)
- [`../docs/planning/PRODUCT_KANBAN.md`](../docs/planning/PRODUCT_KANBAN.md)

## Ordered next trains

1. **Release 1250 — Player Ingenuity / Systemic Workarounds**
2. **Release 1251 — Cross-System Utility Mesh**
3. **Release 1252 — Earned Sequence Breaks & Route Mastery**
4. **Release 1253 — Dam Survival & Prepared Rescue**
5. **Release 1254 — Troll Disarm & Stolen Weapons**
6. **Release 1255 — Thief Retaliation & Sabotage**
7. **Release 1256 — Grue Ecology & Colony Reveal**
8. **Release 1257 — Fire, Smoke & Structural Consequences**
9. **Release 1258 — Mara Reciprocal Rescue & Shared Danger**

This queue is ordered product intent, not a command to build generic frameworks. Each train must remain a substantial human-facing product with natural play and canonical authority.

## Build boundaries

The early Release 121 overlay under this directory still uses the `expanded/Makefile` path and remains a historical supported lineage:

```bash
make -C expanded compile ZILF="zilf" ZAPF="zapf"
make -C expanded verify ZILF="zilf" ZAPF="zapf"
make -C expanded smoke ZILF="zilf" ZAPF="zapf" INTERPRETER="dfrotz"
```

The active Highly Extended Glulx releases live under `glulx/`, with each release carrying its own staging manifest, qualification script, documentation, and GitHub Actions workflow.

Do not treat Release 121's old build identity as the current product frontier.

## Permanent product boundaries

- preserve canonical solutions unless a train explicitly layers a compatible alternative;
- preserve exact journey-critical object identity;
- prefer existing authorities over parallel replacements;
- no universal crafting grid;
- no arbitrary object-pair matrix;
- no generic physics simulator;
- no procedural loot treadmill;
- no recursive audit machinery;
- no TODO-only slices, stubs, or no-op scaffolding;
- natural player behavior should drive repair and qualification.

## Historical design documents

The original Expanded Release 121 documents remain useful for early design lineage:

- [`docs/DESIGN_CHARTER.md`](docs/DESIGN_CHARTER.md)
- [`docs/FEATURE_MATRIX.md`](docs/FEATURE_MATRIX.md)
- [`docs/ADVENTURER_MISCONDUCT.md`](docs/ADVENTURER_MISCONDUCT.md)
- [`docs/VALIDATION.md`](docs/VALIDATION.md)
- [`docs/GLULX_UPSTREAM_MIGRATION.md`](docs/GLULX_UPSTREAM_MIGRATION.md)
- [`docs/GLULX_LICENSING.md`](docs/GLULX_LICENSING.md)

For current development sequencing, prefer the post-1249 roadmap and product Kanban above.
