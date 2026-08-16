# Highly Extended Zork I

**A much larger, more reactive, still-recognizably-Zork version of the original adventure.**

If you have never played Zork, never played interactive fiction, or have no idea what a `.ulx` file is, start here. You do **not** need to know the history of Infocom, ZIL, Glulx, release manifests, checksums, or this repository's development process to play the game.

This project keeps the original Zork I world and its canonical puzzle solutions, then builds outward: more things can be examined and manipulated, physical actions have more believable consequences, useful objects stay useful in more than one situation, creatures and companions remember meaningful events, and the world increasingly reacts to what you actually tried to do.

The technical and reproducibility material is intentionally **after** the player guide.

**Current merged production frontier:** Release `1257` — **Fire, Smoke & Structural Consequences**  
**Latest merged PR:** #62  
**Default branch:** `master`

Release numbers above the original Infocom line are repository-local identities. They are not official Infocom releases.

---

# Start here if you are new to Zork or interactive fiction

## What kind of game is this?

Zork is **interactive fiction**: a game world described primarily in text.

There is no character to steer with a controller and no screen full of clickable hotspots. The game describes where you are, what is nearby, and what happens. You respond by typing commands for the Adventurer to attempt.

A tiny example looks like this:

```text
> LOOK

> OPEN MAILBOX

> READ LEAFLET

> NORTH
```

You are having a conversation with a world model through short commands.

The basic loop is:

1. **Read the room description.**
2. **Notice objects, exits, sounds, hazards, and suspicious details.**
3. **Type something you want to try.**
4. **Read what actually happened.**
5. **Use that information to decide what to do next.**

You do not need to write complete English sentences. In fact, short commands are usually better.

Instead of:

```text
I would like to carefully pick up the lamp from the floor.
```

try:

```text
TAKE LAMP
```

Instead of:

```text
Could I perhaps investigate the mailbox more closely?
```

try:

```text
EXAMINE MAILBOX
```

The game is not a chatbot. It is a parser-driven adventure with authored objects, rooms, rules, puzzles, state, and consequences.

## Useful commands to know

These are enough to begin playing without learning a command manual.

| What you want to do | Example |
|---|---|
| Look around again | `LOOK` |
| Move | `NORTH`, `SOUTH`, `EAST`, `WEST`, `UP`, `DOWN` |
| Examine something | `EXAMINE MAILBOX` |
| Take something | `TAKE LAMP` |
| Drop something | `DROP LAMP` |
| See what you carry | `INVENTORY` |
| Open something | `OPEN MAILBOX` |
| Close something | `CLOSE DOOR` |
| Read something | `READ LEAFLET` |
| Put an object somewhere | `PUT LEAFLET IN MAILBOX` |
| Give something to someone | `GIVE AXE TO TROLL` |
| Listen | `LISTEN` or, where supported, `LISTEN TO ...` |
| Check your score | `SCORE` |
| Save your game | `SAVE` |
| Restore a save | `RESTORE` |
| End the session | `QUIT` |

Traditional direction abbreviations such as `N`, `S`, `E`, `W`, `U`, and `D` are convenient, but full words are perfectly fine and are the safest choice while learning.

### If the game does not understand you

Do not assume your *idea* is wrong just because one phrasing fails.

Try reducing the command to its important verb and noun:

```text
LOOK AT WINDOW
EXAMINE WINDOW
OPEN WINDOW
HIT WINDOW WITH SWORD
```

The Highly Extended line deliberately improves natural-play comprehension, but it is still a parser. It understands authored vocabulary and grammar rather than arbitrary prose.

A useful mental model is:

> **Tell the Adventurer what action to attempt, not what result the game should award you.**

So `HIT BOARD WITH SWORD` is better than `MAKE A SECRET DOOR`.

## What am I actually trying to do?

At the beginning, you are an Adventurer standing **West of House** in a strange world containing an apparently ordinary white house and, eventually, a much larger underground empire.

You explore. You collect treasures. You discover routes. You learn what objects do. You survive things that would prefer you did not. You solve puzzles by paying attention to descriptions and by experimenting with the world.

You do **not** need to understand the entire goal before you begin.

For your first few minutes, a perfectly good approach is:

- look around;
- inspect things that are explicitly mentioned;
- try doors, windows, containers, and paths;
- read anything readable;
- take portable objects that seem useful;
- remember where you found things;
- save before doing something gloriously questionable.

That last one becomes increasingly important in this edition. 😄

## Parser-IF habits that make the game much easier

### Read nouns as possibilities

If a description specifically mentions a **mailbox**, **window**, **tree**, **rope**, **stone**, **button**, or **crack**, there is a good chance it is worth referring to directly.

Not every noun is interactive, and not every interactive noun solves a puzzle. But this project is deliberately pushing toward a stronger rule:

> **If the prose makes a concrete detail seem important, the parser should increasingly let you ask the world about it.**

### Examine before assuming

`EXAMINE` is not fluff. It can tell you about condition, material, geometry, damage, danger, ownership, or a clue that was not obvious from the room description.

### Objects are not merely keys

In many adventure games, an object exists for one predetermined puzzle. Highly Extended Zork increasingly rejects that limitation.

A rope is a rope. Water is water. A cutting tool cuts things that can reasonably be cut. A source of flame may ignite things that can reasonably burn. Protection that works for one physical reason may remain useful when that same reason appears somewhere else.

That does **not** mean every object works on every other object. The game is not a universal physics simulator. It means established useful behavior should remain useful when the same authored logic genuinely applies.

### Failure can be information

Zork can kill you. It can also let you make bad decisions, damage things, lose opportunities, or discover that a clever idea was only *almost* clever enough.

That is part of the game.

The project tries to make failures increasingly **causal**: the response should help you understand what physically or logically went wrong instead of merely saying no.

Save often if you enjoy experimenting without consequences carrying forever.

### Map if you get lost

Zork's world is spatial. Rooms connect through directions, and some areas are intentionally confusing.

A hand-drawn map, text notes, or any personal mapping method can help enormously. Record:

- room names;
- exits;
- locked or blocked routes;
- important objects;
- hazards;
- places you want to revisit.

Getting lost is an authentic Zork experience. Staying lost forever is optional.

## Spoiler-light advice for a first playthrough

If you have never played Zork before, try not to read the release-by-release technical material as a puzzle guide. Many feature descriptions necessarily reveal what kinds of interactions exist.

A good first-play rule is:

- trust the room descriptions;
- experiment with obvious physical ideas;
- use `SAVE` before dangerous experiments;
- do not assume the original intended solution is the only reasonable solution this edition may recognize;
- do not assume every bizarre action *will* work either.

The ideal Highly Extended Zork response to a strange but sensible command is not always success.

Sometimes the reward is simply that **the world understood what you meant and answered honestly.**

---

# What makes this version different?

The original Zork I is still the foundation.

This project is not trying to replace Zork with a different game wearing its map. The original world, score, narrator, dangers, treasure hunt, characters, puzzle authorities, and canonical solutions remain important.

The expansion asks a different question:

> **What if the world behaved more like the place the original prose made players imagine?**

That means adding depth around the original game rather than bulldozing it.

## The product north star

Build the Zork I that players remember imagining:

- preserve the original world, narrator, score, danger, and canonical solutions;
- make far more reasonable experiments understandable;
- let physical state and exact object identity matter;
- let the world remember meaningful consequences;
- deepen existing rooms before adding large amounts of map;
- reward curiosity, preparation, absurdity, and replay;
- let useful tools remain useful where the same physical logic applies;
- let clever preparation reduce friction rather than create another inventory chore;
- keep failure informative, funny, causal, or all three.

The project is deliberately **not** becoming a universal crafting game, procedural sandbox, generic RPG stat system, or chatbot adventure.

## A more physical world

The expanded game increasingly tracks what actually happened to real objects and places.

Examples now present in the merged lineage include:

- breakable and damageable parts of the House environment;
- persistent scars and aftermath instead of instant world resets;
- materially distinct stone, damp, dust, air, cracks, chasms, acoustics, and surfaces underground;
- rope anchoring and cargo consequences;
- useful objects interacting across more than one authored puzzle;
- earned alternate routes and sequence breaks;
- preparation affecting dangerous traversal;
- fire that can smolder, establish, make smoke, damage structure, and leave charred aftermath.

The important point is not that Zork now has a checklist of simulations.

It is that **actions increasingly have continuity**.

## Player ingenuity matters more

Releases 1250–1252 deliberately pushed the game toward a central doctrine:

> **Canonical puzzles describe reliable intended solutions. They do not necessarily define the only physically valid solution.**

If an existing object and an existing hazard have a believable interaction, the game should be willing to recognize it when doing so does not break canonical state.

That includes:

- systemic workarounds;
- objects retaining utility across multiple locations;
- preparation changing later danger;
- physically earned sequence breaks;
- route mastery reducing repeated busywork.

The goal is not to make every puzzle trivial. The goal is to reward a player who actually understands the world.

## Creatures have consequences too

The troll, thief, grues, wildlife, and other beings are increasingly treated as specific authored creatures rather than interchangeable combat obstacles.

Recent merged work includes:

- troll disarm and stolen-weapon consequences;
- thief retaliation and sabotage;
- expanded grue ecology and colony revelation;
- ecology and museum provenance tied to actual field play.

Future trains continue this direction: living threats should have motives, capacities, territory, possessions, and specific responses rather than becoming generic hit-point bags.

## Mara Tallow

Mara is an authored human companion who exists physically in the world rather than as a menu assistant or follower stat block.

The merged lineage already establishes her arrival, evidence-aware presence, field capability, House company, travel, shared food, equipment, boundaries, witnessed knowledge, and remembered history.

The active development stack beyond the merged frontier continues her causal biography, shared danger, lived feeling, rupture and repair, anticipation, worry, and protective initiative.

The design boundary is important:

- no approval meter;
- no generic affection number;
- no omniscient companion AI;
- no party-framework abstraction replacing her personhood.

A future **Mara Earned Romance & Partnership** arc is explicitly planned. If that relationship develops, it is intended to grow from mutual attraction, lived history, explicit choice, closeness, disagreement, boundaries, repair, and partnership — not from filling a love bar.

## The House remembers expeditions

The House of Records program turned the white house into more than a static starting location.

Across Releases 1219–1230 it gained a persistent expedition-history role including physical records, archive/case-file behavior, playback, rest and dream history, vulnerability, completed-expedition records, chronology, comparison, deterministic export, and save/corrupt/restore qualification.

Later museum and ecology work extended the same idea: what the Adventurer discovers in the field can become an object with custody, provenance, and later meaning.

## Hunger, preparation, injury, and danger

The game includes bounded hunger, satiation, exertion, food, survival, rescue, and recovery behavior where those systems improve authored situations.

These are **not** meant to turn Zork into a survival-management spreadsheet.

Their purpose is to make preparation, injury, physical effort, and recovery matter when the adventure gives them a reason to matter.

## Fire, smoke, and structural consequence — current merged frontier

Release 1257 gives the canonical Timber Room one persistent authored fire lifecycle.

A real flame can begin a recoverable smolder. A limited amount of real bottled water can stop that fresh smolder. Once open flame is established through the dry timbers, however, the same bottle is no fire hose: it hisses into steam while the fire continues.

Ignored fire produces draft-driven smoke, structural warning, a fallen brace, and eventual charred aftermath. The canonical narrow-route authority remains intact rather than being rewritten around the new mechanic.

This is the model for future expansion: **add a real consequence that composes with Zork instead of replacing Zork with a generic subsystem.**

## Where development goes next

The current development stack extends Mara through Release 1261. After that, major Mara-only subsystem expansion pauses while the wider game catches up.

The next planned program is a deliberate **Shadowgate → Parser IF Adaptation Program**. Shadowgate is used as a design lens, not copied content. The program asks what useful interaction principles from that style of adventure become when rebuilt from scratch for a parser-driven Zork world.

The ordered planned arc begins with:

- hostile rooms and reactive threats, showcased through an original treasure-guardian dragon and hoard;
- equipment that physically carries damage it protected you from;
- allowing physically possible bad choices instead of protecting the player with meta-game refusals;
- consumable light and graduated darkness;
- learned magic that expands parser capability through in-world knowledge;
- semantic examination and hidden structure;
- knowledge-driven clue chains;
- structural difficulty modes;
- causal death and failure feedback;
- creature encounters as authored systemic puzzles;
- a substantial original Zork region that composes the preceding ideas.

For the live queue, do not rely on this README's prose snapshot. See:

- [`../docs/planning/PRODUCT_KANBAN.md`](../docs/planning/PRODUCT_KANBAN.md)
- [`../docs/planning/product-kanban.json`](../docs/planning/product-kanban.json)
- [`../docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md`](../docs/planning/SHADOWGATE_TO_PARSER_IF_TRAIN_PROGRAM_2026-08-15.md)
- [`../docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md`](../docs/planning/POST_1249_PRODUCT_ROADMAP_2026-08-11.md)

---

# Playing the Highly Extended Glulx edition

## What is a `.ulx` file?

The active Highly Extended lineage targets **Glulx**, a virtual machine commonly used for larger interactive-fiction games.

A `.ulx` file is the compiled story/game file. It is not a normal Windows `.exe` or Linux binary. You open it with a **Glulx-capable interactive-fiction interpreter**.

The repository's qualification system uses pinned Glulxe/CheapGlk builds for reproducible automated play. A player can use any compatible Glulx interpreter that correctly runs the story.

## Which edition should I play?

This repository contains several distinct historical and experimental lineages.

If your goal is **the actively developed, most expanded Zork**, you want the latest **Highly Extended Glulx** production release from the merged frontier.

If your goal is historical comparison, preservation, or older compatibility work, the repository also retains the original and earlier editions described below.

### Edition map

| Edition / lineage | Identity | Purpose |
|---|---:|---|
| Historical | Release 119 / `880429` | Original repository-root source and compiled historical story |
| Optimized | Release 120 / `260718` | Narrow bug and portability fixes without deliberate gameplay expansion |
| Early Expanded | Release 121 / `260719` | First additive reactivity, optional discoveries, contextual assistance, and comedy work under `expanded/` |
| Highly Extended Glulx | Releases 1219 onward | Active product lineage: persistent history, parser depth, physical consequences, museum/ecology expeditions, food and hazards, Mara, player ingenuity, route mastery, creature consequences, and continuing authored expansion |

The early Expanded Release 121 remains supported, but it is **not** the current Highly Extended production frontier.

## Saving is part of healthy experimentation

The game supports normal interactive-fiction save/restore behavior.

Use:

```text
SAVE
```

before a decision you might want to revisit, and:

```text
RESTORE
```

to return to a save.

This is especially useful in Highly Extended Zork because the project intentionally permits more persistent consequences instead of silently preventing every bad idea.

---

# For returning Zork and IF players

If you already know classic Zork, the shortest description is:

**The original game is still authoritative, but the space around its intended solutions is much wider.**

You should expect more of the following:

- parser recognition of ordinary, reasonable IF phrasing;
- meaningful scenery being targetable more often;
- materials and physical state carrying forward;
- canonical objects retaining exact identity;
- tools being reusable when the same physical logic recurs;
- alternate approaches that are earned rather than granted by a universal crafting system;
- world-state consequences that persist;
- more causal warnings and failure narration;
- creatures whose prior encounters can affect later encounters;
- expeditions producing records and physical provenance;
- Mara behaving as one specific person with witnessed history and boundaries.

You should **not** expect:

- a free-form language model pretending every sentence succeeded;
- arbitrary crafting recipes;
- a generic physics engine;
- procedural loot progression;
- a universal relationship score;
- a universal creature-AI framework;
- canonical solutions being deleted merely because an alternative was added.

The project's recurring test is not "can we add another system?"

It is:

> **Does this make natural play in Zork richer without lying about what the world is?**

---

# Technical, build, provenance, and reproducibility notes

Everything below this point is for developers, maintainers, preservation work, and anyone who wants to verify exactly what the active product is built from.

## Repository lineage

This repository contains:

- preserved historical Zork I source;
- a conservative optimized edition;
- the early repository-local Expanded Release 121 line;
- the actively developed **Highly Extended Zork I Glulx lineage** under `glulx/`.

The old description of `expanded/` as merely Release 121 is therefore historical. This README is the player-facing entry point for the expanded project as a whole, while the active production implementation lives primarily under `glulx/`.

## Current merged artifact identity

Release `1257` — **Fire, Smoke & Structural Consequences** — is the current merged production frontier represented on `master` at the time of this README update.

Locked production artifact:

- file: `zork1-glulx-fire-smoke-structural-consequences.ulx`
- format: Glulx
- Glulx version: `0x00030103`
- size: `438784` bytes
- checksum: `0x73c14bad`
- SHA-256: `d5080468723731018db587bcb5320cb88bb0a0b7585ee1c83156497dfb7fc444`

Exact qualified staged-source identities recorded for the merged Release 1257 train:

- production source SHA-256: `f73099921f56be8e496aab560e81c5fcf4722b6b9c45c97750597140d8d25ff6`
- dev source SHA-256: `e99fd0e5331edbb4bc0a8faea0961f200e8fa356c84e9ac608c4df738814071c`

Final locked qualification run recorded by the product board: `31741847431`.

The release manifest is:

- [`../glulx/fire-smoke-structural/patch-series.json`](../glulx/fire-smoke-structural/patch-series.json)

The release-specific design/behavior record is:

- [`../glulx/fire-smoke-structural/README.md`](../glulx/fire-smoke-structural/README.md)

## Important note about active unmerged development

Open stacked development PRs may contain Releases 1258–1261 or later work, but an open PR is **not** silently treated as the merged production frontier.

The repository's product board distinguishes:

- merged/immutable proof;
- qualified but unmerged trains;
- in-progress trains;
- future planned trains.

For current state, use [`../docs/planning/PRODUCT_KANBAN.md`](../docs/planning/PRODUCT_KANBAN.md) rather than inferring production status from the largest release number visible in a branch or manifest.

## Glulx staging model

The active Highly Extended releases live under `glulx/`.

Each release train is expected to carry the evidence appropriate to that train, typically including:

- a release-specific directory;
- a staging manifest such as `patch-series.json`;
- exact base-release and source/artifact identities;
- explicit changed-path boundaries;
- staging logic;
- qualification scripts;
- natural command transcripts or integration routes;
- a locked production artifact identity once qualification is final;
- GitHub Actions workflow evidence where applicable.

The goal is not merely "the source compiled once." The release should be reconstructible enough to show **what exact source lineage produced what exact story artifact and what player behavior was actually exercised.**

## Active Glulx toolchain history

The Glulx lineage is based on pinned upstream source/toolchain inputs rather than an unrecorded local compiler state.

The repository's Glulx qualification record documents pins for ZILF, Glazer, Glulxe, CheapGlk, upstream source identity, artifact checksums, and cross-VM routes:

- [`../glulx/QUALIFICATION.md`](../glulx/QUALIFICATION.md)
- [`../glulx/README.md`](../glulx/README.md)
- [`../glulx/provenance.json`](../glulx/provenance.json)

Older qualification documents describe the point in the lineage when they were written; later release-specific manifests and qualification scripts are authoritative for their own trains.

## Early Expanded Release 121 build path

The early Release 121 overlay under this directory still uses the historical `expanded/Makefile` path and remains a supported lineage:

```bash
make -C expanded compile ZILF="zilf" ZAPF="zapf"
make -C expanded verify ZILF="zilf" ZAPF="zapf"
make -C expanded smoke ZILF="zilf" ZAPF="zapf" INTERPRETER="dfrotz"
```

Those commands build/test the early `.z3` Expanded lineage. They do **not** mean Release 121 is the current product frontier.

## Release-specific Glulx qualification

The active Glulx line does not use one giant mutable "latest build" script as its only source of truth. Each train carries release-specific staging and qualification.

For example, the merged Release 1257 implementation lives under:

```text
glulx/fire-smoke-structural/
```

with its own:

```text
README.md
patch-series.json
stage.py
qualify.sh
tests/
```

This keeps the base lineage, permitted source changes, player-facing contract, and expected artifact identity reviewable together.

## Why all the checksums?

Because this project modifies a historical game through a long additive lineage.

Checksums and exact source identities help answer questions that become otherwise surprisingly difficult:

- Which upstream source did this release actually begin from?
- Did a later train accidentally rebuild from the wrong predecessor?
- Is the artifact being tested the same artifact being described?
- Did a source-only change alter the compiled story unexpectedly?
- Is a claimed qualification tied to the exact head under review?
- Can an older release still be distinguished from a newer one?

The checksums are evidence, not gameplay mechanics. A player can happily ignore them.

## Canonical-authority rule

A major technical/design rule is to avoid creating parallel fake state when canonical Zork already owns the thing being changed.

Examples of authorities that trains must preserve or deliberately compose with include:

- exact journey-critical object identity;
- existing room/object ownership;
- canonical traversal state;
- canonical timers;
- canonical puzzle flags;
- canonical creature behavior where it remains authoritative;
- existing save/restore semantics;
- historical solutions and score-bearing routes.

New behavior should observe, extend, or carefully hook existing authority rather than creating a second contradictory truth.

## Permanent product boundaries

These are not temporary implementation preferences:

- preserve canonical solutions unless a train explicitly layers a compatible alternative;
- preserve exact journey-critical object identity;
- prefer existing authorities over parallel replacements;
- no universal crafting grid;
- no arbitrary object-pair matrix;
- no generic physics simulator;
- no procedural loot treadmill;
- no generic companion/relationship score engine;
- no universal creature AI brain;
- no recursive audit machinery;
- no TODO-only slices, stubs, or no-op scaffolding;
- natural player behavior should drive repair and qualification.

## Release history at a glance

The full lineage is larger than is useful to reproduce in this README, but the major modern arcs are:

### House of Records — Releases 1219–1230

Persistent expedition history, physical records, Attic case files, playback, rest/dream history, vulnerability, completed-expedition records, chronology, cross-run comparison, deterministic export, and save/corrupt/restore behavior.

### Corpus, parser, museum, and field systems — Releases 1231–1242

Causal warning, deeper parser comprehension, museum custody/provenance, Mara's first evidence-aware presence, cuisine/hunger/stamina, Great Canyon survival, Veteran Survey Expedition, Cellar recovery, Dam fishing, songbird correspondence, troll provenance, and natural-play regression repair.

### Mara and creative natural play — Releases 1243–1245

Mara companion expedition foundation, House company, consent-based residence/travel/shared food, boundaries, actor/personhood routing, hostile-command handling, and witnessed-death repair.

### Material and narrative physicality — Releases 1246–1249

Environmental destruction, richer physical prose and responses, Forest consequences, rope/cargo state, underground sensory physicality, persistent scars, acoustics, geometry, and canonical-state preservation.

### Player ingenuity and living consequences — Releases 1250–1257

- **1250 — Player Ingenuity / Systemic Workarounds**
- **1251 — Cross-System Utility Mesh**
- **1252 — Earned Sequence Breaks & Route Mastery**
- **1253 — Dam Survival & Prepared Rescue**
- **1254 — Troll Disarm & Stolen Weapons**
- **1255 — Thief Retaliation & Sabotage**
- **1256 — Grue Ecology & Colony Reveal**
- **1257 — Fire, Smoke & Structural Consequences**

These are merged production history, not merely future intentions.

## Historical design documents

The original Expanded Release 121 documents remain useful for early design lineage:

- [`docs/DESIGN_CHARTER.md`](docs/DESIGN_CHARTER.md)
- [`docs/FEATURE_MATRIX.md`](docs/FEATURE_MATRIX.md)
- [`docs/ADVENTURER_MISCONDUCT.md`](docs/ADVENTURER_MISCONDUCT.md)
- [`docs/VALIDATION.md`](docs/VALIDATION.md)
- [`docs/GLULX_UPSTREAM_MIGRATION.md`](docs/GLULX_UPSTREAM_MIGRATION.md)
- [`docs/GLULX_LICENSING.md`](docs/GLULX_LICENSING.md)

For current development sequencing, prefer the repository-level planning documents linked above.

---

# One-sentence version

**If you are here to play:** open the current Highly Extended `.ulx` story in a Glulx-capable interpreter, read what the world tells you, type short commands describing what you want to attempt, save before especially inspired stupidity, and treat Zork less like a list of puzzle keys and more like a place that increasingly remembers what you did to it.
