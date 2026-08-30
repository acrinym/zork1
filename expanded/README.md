# Highly Extended Zork I

**A much larger, more reactive, still-recognizably-Zork version of the original adventure.**

If you have never played Zork, never played interactive fiction, or have no idea what a `.ulx` file is, start here. You do **not** need to understand Infocom history, ZIL, Glulx, release manifests, checksums, or this repository's development process to play.

This project keeps the original Zork I world and canonical puzzle solutions, then builds outward: more concrete things can be examined and manipulated, useful objects retain useful physical meaning, actions carry consequences, creatures and companions can remember meaningful history, and reasonable experiments are increasingly answered by the world instead of disappearing into a generic refusal.

The technical and reproducibility material is intentionally **after** the player guide.

**Current Highly Extended lineage described here:** through Release `1277` — **Mundane Objects, Field Caching & House Spatial Agency** (PR #85). Release 1278 is open as PR #86 and is not merged until all green.  
**Default branch:** `master`  
**Live board:** [`../docs/planning/PRODUCT_KANBAN.md`](../docs/planning/PRODUCT_KANBAN.md)

Release numbers above the original Infocom line are repository-local identities. They are not official Infocom releases.

---

# Start here if you are new to Zork or interactive fiction

## What kind of game is this?

Zork is **interactive fiction**: a game world described primarily in text. The game tells you where you are and what happens; you type short commands describing what you want the Adventurer to attempt.

A tiny example:

```text
> LOOK
> OPEN MAILBOX
> READ LEAFLET
> NORTH
```

The basic loop is simple:

1. **Read the room description.**
2. **Notice objects, exits, sounds, hazards, and odd details.**
3. **Type something you want to try.**
4. **Read what actually happened.**
5. **Use that information to decide what to try next.**

Short commands are usually better than complete English sentences. Instead of “I would like to carefully pick up the lamp,” type:

```text
TAKE LAMP
```

The game is not a chatbot. It is a parser-driven adventure containing authored rooms, objects, people, creatures, rules, puzzles, state, and consequences.

## Useful commands to know

| What you want to do | Example |
|---|---|
| Look around again | `LOOK` |
| Move | `NORTH`, `SOUTH`, `EAST`, `WEST`, `UP`, `DOWN` |
| Examine something | `EXAMINE MAILBOX` |
| Take or drop something | `TAKE LAMP`, `DROP LAMP` |
| See what you carry | `INVENTORY` |
| Open or close something | `OPEN MAILBOX`, `CLOSE DOOR` |
| Read something | `READ LEAFLET` |
| Put something somewhere | `PUT LEAFLET IN MAILBOX` |
| Give something to someone | `GIVE AXE TO TROLL` |
| Use one thing with another | `USE SCREEN ON ME`, where supported |
| Listen | `LISTEN` or `LISTEN TO ...` |
| Check your score | `SCORE` |
| Save or restore | `SAVE`, `RESTORE` |
| End the session | `QUIT` |

Direction abbreviations such as `N`, `S`, `E`, `W`, `U`, and `D` also work in traditional parser-IF style.

### If the parser does not understand you

Do not assume your *idea* is wrong because one phrasing fails. Reduce the sentence to the important verb and noun, or try an equivalent ordinary IF verb:

```text
LOOK AT WINDOW
EXAMINE WINDOW
OPEN WINDOW
HIT WINDOW WITH SWORD
```

A useful mental model is:

> **Tell the Adventurer what action to attempt, not what result the game should award you.**

`HIT BOARD WITH SWORD` is a better command than `MAKE A SECRET DOOR`.

## What am I trying to do?

You begin **West of House**. From there, explore. Find routes. Collect treasures. Learn what objects do. Pay attention to suspicious descriptions. Survive things that would prefer you did not. Zork gradually reveals the larger Great Underground Empire rather than handing you a quest checklist.

For your first few minutes, a perfectly good strategy is to look around, inspect named things, try doors/windows/containers/paths, read anything readable, take portable objects that seem useful, remember where you found things, and **save before doing something gloriously questionable**. 😄

## Habits that make parser IF easier

### Read nouns as possibilities

If prose specifically mentions a mailbox, window, tree, rope, stone, chain, grille, button, crack, screen, or similar concrete thing, try referring to it. Not every noun must be interactive, but this project deliberately pushes toward a stronger described-world rule: important concrete details should increasingly be things the parser can answer questions about.

### Examine before assuming

`EXAMINE` can reveal material, geometry, condition, damage, danger, ownership, or clues. In Highly Extended Zork, those details increasingly matter later.

### Objects are not merely colored keys

A rope is allowed to remain a rope. Water is allowed to remain water. Fire is allowed to matter because something burns. Protection can work because a physical object actually intercepts a hazard. That does **not** mean every object combines with every other object; this is not a universal physics or crafting simulator. It means established authored behavior should stay meaningful when the same physical reasoning genuinely applies.

### Failure is often information

Zork can kill you. Highly Extended Zork can also let you damage things, misjudge a creature, lose an opportunity, or discover that an idea was nearly right but physically incomplete. The goal is increasingly **causal failure**: if something goes wrong, the world should tell you enough to understand why.

### Map if you get lost

Rooms connect spatially and some areas are intentionally confusing. A hand-drawn map or notes containing room names, exits, hazards, important objects, and blocked routes can help enormously. Getting lost is authentic Zork. Staying lost forever is optional.

## Spoiler-light first-play advice

The feature sections below necessarily reveal kinds of interactions that exist. For a first playthrough, you may want to stop reading here and simply remember:

- trust room descriptions;
- examine concrete details;
- experiment with ordinary physical ideas;
- save before danger;
- canonical solutions still work;
- another physically credible approach may sometimes work too;
- a strange command does not need to succeed to be worth trying—the world understanding and honestly rejecting it can itself be useful.

---

# What makes Highly Extended Zork different?

The original Zork I remains the foundation. The project is not trying to replace Zork with another genre wearing its map.

The guiding question is:

> **What if the world behaved more like the place the original prose made players imagine?**

That means preserving the original narrator, score, hazards, objects, treasure hunt, puzzle authorities, and canonical solutions while deepening what can happen around them.

## Product north star

- preserve original Zork authority and canonical solutions;
- make more reasonable experiments understandable;
- let exact objects, materials, and physical state matter;
- let meaningful consequences persist;
- deepen existing places before adding map merely for size;
- reward curiosity, preparation, absurdity, and replay;
- let established tools retain utility where the same reasoning applies;
- make failure informative, funny, causal, or all three;
- build authored situations rather than generic machinery for its own sake.

The project is deliberately **not** becoming a universal crafting game, free-form chatbot adventure, procedural loot treadmill, generic RPG-stat layer, generic creature AI, or universal physics simulator.

## Major modern arcs

### House of Records — Releases 1219–1230

The white house became a persistent expedition archive: physical records, Attic case files, playback, rest/dream history, vulnerability, completed-expedition records, chronology, comparison, deterministic export, and save/corrupt/restore behavior.

### Parser, museum, ecology, field work, and survival — Releases 1231–1242

These trains added deeper parser comprehension, causal warning, museum custody/provenance, Mara's first evidence-aware presence, bounded cuisine/hunger/stamina, prepared canyon survival, a veteran expedition, Cellar recovery, Dam fishing, songbird correspondence, troll provenance, and natural-play repair.

### Mara as one authored person — Releases 1243–1245 and 1258–1261

Mara Tallow is physically located, has her own equipment and field capability, witnesses events, carries meaningful history, has boundaries, can share danger and rescue, and can interpret repeated recklessness, intentional harm, repair, and future danger.

Releases 1258–1261 deepen causal biography, field capability, lived feeling, rupture/repair, anticipation, worry, and protective initiative without turning her into an approval meter, affection score, generic companion engine, omniscient puzzle solver, or party framework.

After 1261, major Mara-only subsystem expansion pauses so the wider world can catch up.

### Material world and player ingenuity — Releases 1246–1257

Environmental damage, narrative physicality, forest consequences, underground sensory detail, rope/cargo state, systemic workarounds, cross-system utility, route mastery, prepared Dam rescue, troll weapon consequences, thief retaliation, grue ecology, and authored fire/smoke/structural consequences increasingly let actions have continuity.

Release 1257's Timber Room fire is especially important because later features reuse its **real existing state** rather than inventing private copies.

## Release 1262 — Treasure Guardian Dragon & Hoard

Release 1262 begins the Shadowgate → Parser IF adaptation program with an original Zork-native hostile-room encounter branching north from the real Timber Room.

The Scorched Cleft telegraphs heat, broad scratches, old bones, and danger before the player enters the Dragon Gallery. The dragon is a specific territorial creature guarding a visible hoard, not a bag of hit points waiting for combat mode.

Credible approaches include:

- **retreating** through the real open route;
- **bargaining** by giving a held real treasure as a toll for passage and one hoard item;
- **baiting and containing** the greedy dragon beneath an old counterweight grille;
- **environmental leverage** by letting the already-authored Release 1257 Timber Room fire produce real smoke that changes the dragon's ability to hold the arch;
- deliberately making a bad choice, including direct violence or ignoring warning behavior, and accepting the causal fire-breath consequence.

The dragon remains alive when physically contained. The encounter adds no boss HP, combat initiative, random attack rolls, hostility meter, or universal enemy framework.

The hoard includes two original physical objects: an ashen silver circlet and a piece of star-glass.

## Release 1263 — Ablative Protection & Equipment Consequence

Release 1263 asks what protection looks like when **the equipment actually bears the consequence it prevented from reaching the player**.

An iron-bound hide fire screen can be carried from the Scorched Cleft and deliberately braced through existing parser grammar such as:

```text
USE SCREEN ON ME
```

A sound screen can take one real dragon-breath blast and become visibly **scorched**. The scorched screen can be knowingly reused once; a second blast leaves it **warped**. The warped object remains portable evidence of what happened, but its geometry no longer honestly supports another protection claim.

There is no armor class, durability percentage, equipment HP, generic `BLOCK` action, random mitigation roll, repair bench, or universal equipment-damage engine. The screen has authored physical history: **sound → scorched → warped**.

## What comes after 1263?

The broader Shadowgate → Parser IF program continues by adapting *design lessons*, not copied content. Planned directions include physically possible bad choices, consumable light and graduated darkness, knowledge/learned magic that expands parser capability in-world, semantic examination and hidden structure, clue chains, structural difficulty, causal failure, richer authored creature encounters, and eventually a substantial original Zork region composed from the proven mechanics.

For live sequencing, use:

- [`../docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md`](../docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md)
- [`../docs/planning/PRODUCT_KANBAN.md`](../docs/planning/PRODUCT_KANBAN.md)
- [`../docs/planning/product-kanban.json`](../docs/planning/product-kanban.json)

---

# Playing the Highly Extended Glulx edition

## What is a `.ulx` file?

The active Highly Extended line targets **Glulx**, a virtual machine used by larger interactive-fiction games. A `.ulx` file is the compiled story/game file. It is not a normal Windows `.exe`; open it with a Glulx-capable interactive-fiction interpreter.

The repository's qualification pipeline uses pinned Glulxe/CheapGlk builds for reproducible automated play, but players may use compatible Glulx interpreters.

## Which edition should I play?

| Edition / lineage | Identity | Purpose |
|---|---:|---|
| Historical | Release 119 / `880429` | Preserved historical repository-root story/source |
| Optimized | Release 120 / `260718` | Conservative bug/portability fixes |
| Early Expanded | Release 121 / `260719` | Early additive `.z3` expansion under `expanded/` |
| Highly Extended Glulx | Releases 1219–1263 | Active large additive lineage described in this README |

If you want the most expanded game, use the newest qualified Highly Extended Glulx artifact. Historical editions remain preserved for comparison and research.

## Save before inspired stupidity

`SAVE` and `RESTORE` are normal parts of parser IF, and they are especially useful here because the world increasingly allows persistent consequences instead of preventing every bad decision on your behalf.

---

# Technical, build, provenance, and reproducibility notes

Everything below this point is for development, preservation, and exact verification. Players can ignore it.

## Release 1263 locked artifact identity

Release 1263's production artifact is pinned as:

- file: `zork1-glulx-ablative-protection-equipment-consequence.ulx`
- format: Glulx
- version: `0x00030103`
- size: `468480` bytes
- checksum: `0xf5898239`
- SHA-256: `a29a94fe607130c6bc2f86c140b6d3a2d7c065c9ceb80263a5dbfb51db3b3997`

Its exact Release 1262 predecessor artifact is SHA-256 `2c0f63695388732af365d0b72b014348c7f1fb438dde0c5b49616ae8fdb81cf9`.

Release 1263 pins Release 1262 staged-source identities:

- production: `0725e2c777b499356b2da6b13d3f3f6e37261abae2d59e780b6ea3d94c769fa2`
- dev: `be8b33560edaadd2af2ea13b6d9545d3daa65beeee8775d066af305b57e0022d`

See [`../glulx/ablative-protection/patch-series.json`](../glulx/ablative-protection/patch-series.json) and [`../glulx/ablative-protection/README.md`](../glulx/ablative-protection/README.md).

## Release 1262 locked artifact identity

- file: `zork1-glulx-hostile-rooms-dragon-hoard.ulx`
- version: `0x00030103`
- size: `466432` bytes
- checksum: `0x8d167131`
- SHA-256: `2c0f63695388732af365d0b72b014348c7f1fb438dde0c5b49616ae8fdb81cf9`

Its final hosted qualification proves real parser-command histories for bargain/custody, bait-and-containment/custody, real Release 1257 smoke leverage, ignored-warning death, and clean retreat.

## How modern releases are built

The active Highly Extended releases live under [`../glulx/`](../glulx/). Each train carries the evidence appropriate to it, normally including:

- a release-specific directory;
- `patch-series.json` with exact predecessor/artifact/source pins;
- explicit allowed changed paths;
- staging logic;
- release-specific qualification scripts;
- real parser-command transcripts or integration routes;
- a locked artifact identity;
- hosted workflow evidence where applicable.

The requirement is stronger than “it compiled once.” A train should be able to show **what exact predecessor source produced what exact artifact, what paths changed, and what player behavior was exercised.**

## Why all the checksums?

Because this is a long additive modification of a historical game. Exact identities answer questions such as: Did a train stage from the correct predecessor? Did a source-only edit unexpectedly change the story? Is the artifact being reviewed the same artifact that was qualified? Can old and new releases be distinguished? Does a review refer to the exact head being merged?

Checksums are evidence, not gameplay mechanics.

## Canonical-authority rule

When Zork already owns a fact, a new train should compose with that fact rather than create a second contradictory truth. Examples include exact journey-critical objects, traversal state, puzzle flags, timers, creature state, save/restore behavior, parser grammar, and canonical solutions.

Release 1262 demonstrates this by reading Release 1257's existing fire state instead of inventing `DRAGON_SMOKE`. Release 1263 demonstrates it by routing through the existing `USE ... ON/WITH ...` action and the exact existing dragon-breath consequence instead of adding a second combat/protection system.

## VM/global budget

The current Glulx source is close to the legacy global-variable ceiling. Modern trains therefore prefer compact mutable tables or existing object state when appropriate rather than casually consuming globals. Release 1262's dragon state and Release 1263's equipment state both follow that discipline.

## Locked toolchain lineage

The modern Glulx qualification lineage uses pinned inputs including:

- upstream Glulx source commit: `1ada70e58ac4933446b907d67949d9cab3119c0e`
- ZILF 1.8 commit: `45c60f1e37651f266ac92d49ae01748bb4909fa5`
- Glazer 1.2.0 source SHA-256: `a45edadb140111b5df44a3f49ca4e2b8ec0550d63a6cdee7c93bec93a79ed482`
- Glulxe: `56ab8743bab565de307bd892c555d8d8897ed517`
- CheapGlk: `14d8aaf6e4150669762bd4646a5368e75c1eeee6`

See [`../glulx/README.md`](../glulx/README.md), [`../glulx/QUALIFICATION.md`](../glulx/QUALIFICATION.md), and release-specific manifests for exact modern authority.

## Early Expanded Release 121 build path

The historical early Expanded `.z3` line under this directory remains supported separately:

```bash
make -C expanded compile ZILF="zilf" ZAPF="zapf"
make -C expanded verify ZILF="zilf" ZAPF="zapf"
make -C expanded smoke ZILF="zilf" ZAPF="zapf" INTERPRETER="dfrotz"
```

Those commands do **not** describe the modern Highly Extended Glulx frontier.

## Permanent product boundaries

- preserve canonical solutions unless an authored compatible alternative is deliberately layered;
- preserve exact journey-critical object identity;
- prefer existing authorities over parallel fake state;
- no universal crafting grid or arbitrary object-pair matrix;
- no generic physics simulator;
- no procedural loot treadmill;
- no universal creature AI brain;
- no generic relationship/affection score;
- no recursive audit machinery;
- no TODO-only slices, stubs, or no-op scaffolding;
- qualify natural player behavior, not merely setup-state assertions.

---

# One-sentence version

**Open the current Highly Extended `.ulx` in a Glulx interpreter, read carefully, type short commands describing what you actually want to attempt, save before especially inspired stupidity, and treat Zork less like a list of puzzle keys and more like a place that increasingly remembers what you did to it.**
