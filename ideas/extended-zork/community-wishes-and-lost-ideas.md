# Zork Community Wishes and Lost-Idea Archaeology

**Research date:** July 30, 2026  
**Status:** Evidence-backed future-design research. This document does not create a train, bead, release, or implementation promise.

## Purpose

This document gathers recurring wishes, complaints, memories, fan-project proposals, and abandoned directions from Zork-specific and interactive-fiction communities.

The goal is not to let a forum vote design Highly Extended Zork. The goal is to identify what people have repeatedly felt was missing, what they most want preserved, and which older possibilities were left behind by platform limits, commercial history, or unfinished fan work.

## Evidence labels

Every finding below is labeled so community evidence is not confused with our own design work.

- **DIRECT WISH** — someone explicitly asked for the feature, format, story, or capability.
- **RECURRING PREFERENCE** — several people independently praised or rejected the same direction.
- **PAIN-POINT INFERENCE** — people complained about a limitation; the proposed response is our interpretation.
- **HISTORICAL GAP** — material, structure, or interaction existed in another Zork form or was discussed as missing.
- **OUR EXTENSION** — a Highly Extended Zork idea that is compatible with the evidence but was not directly requested by the sources.

## Source map

The strongest sources found were:

1. **The Zork Library Forum** — old dedicated Zork discussions, including future formats, remakes, fan games, and playable missing stories.
2. **r/Zork** — newer fan wishes, lore interests, revival discussions, parser modernization, and memories of the larger franchise.
3. **The Interactive Fiction Community Forum** — modern parser, interpreter, accessibility, and reimagining discussion.
4. **IFDB reviews of Zork I** — concentrated evidence about what modern and returning players still love or find hostile.
5. **Old Usenet archives** — memories of the unified mainframe Dungeon/Zork, changed geography, omitted material, and decades of replay discussion.
6. **Historical design writing** — useful context for systems such as Return to Zork's object-, photograph-, map-, and recording-based conversations.

A source ledger appears at the end of this document.

---

# Community findings

## 1. Preserve parser play, puzzles, atmosphere, and Zork humor

**Evidence:** RECURRING PREFERENCE

The clearest recurring request is not “replace Zork with a modern genre.” Fans repeatedly want another true adventure game built around exploration, puzzles, discovery, odd logic, and the Great Underground Empire's humor.

In the Zork Library discussion about future formats, some preferred plain text, some preferred Zork Zero-style illustrated text, and others preferred full graphical adventures. Despite format disagreement, they converged on several values:

- real puzzle solving;
- interaction with the world rather than repetitive clicking;
- challenge that requires thought;
- strange places and atmosphere;
- Zork-specific humor and lore;
- no generic MMO grind.

One participant explicitly rejected “click the button” simplicity and asked to be made to think. Another favored graphical support because it could make the world easier to understand without discarding adventure-game interaction.

**Design consequence for us:**

Highly Extended Zork should remain an authored parser adventure. Optional Glulx windows, maps, gallery layouts, illustrations, sound, and controls may help the player, but the parser and world model remain complete and authoritative.

**Source:** [Best Zork Format For Future Games? — The Zork Library Forum](https://www.thezorklibrary.com/forum/viewtopic.php?t=315)

## 2. Make more of the described world genuinely interactable

**Evidence:** PAIN-POINT INFERENCE

A widely cited modern criticism of Zork I is not that it lacks graphics. It is that room descriptions name things the parser does not recognize, while many recognized objects provide little or no specific response.

That creates a broken promise: prose suggests a tangible world, but reasonable examination and manipulation fall through to generic parser failures.

This is one of the strongest justifications for the current House work and for Highly Extended Zork generally.

**Candidate responses:**

- recognize important nouns used in descriptions;
- provide authored examinations for visible structures and materials;
- support reasonable verbs where the world implies them;
- allow objects to react to fire, water, force, containment, ownership, damage, magic, and location;
- remember consequential interactions rather than resetting objects to generic descriptions;
- let seemingly decorative details become evidence, resources, hazards, jokes, or later puzzle components.

This does **not** mean implementing every imaginable verb against every noun. It means closing the most obvious promise gaps between prose and world behavior.

**Source:** [IFDB review: “Sic Transit...”](https://ifdb.org/viewgame?id=0dbnusxunq7fw5ro&review=2506)

## 3. Improve comprehension without replacing authored logic

**Evidence:** DIRECT WISH and RECURRING PREFERENCE

A r/Zork discussion asking what fans would want in a new adventure included a direct request for better word comprehension. Modern IF discussions also note that old games lack now-standard abbreviations and conveniences unless the game itself is modified.

A separate modern reimagining project proposed using a language layer to smooth narration and interpret player language while preserving original plot and game logic.

**Candidate responses:**

- modern abbreviations such as `X`, `G`, and `Z`;
- broader verb and noun synonyms;
- correction of likely misspellings;
- clarification when several objects match;
- gentle suggestions after a reasonable but unsupported command;
- command history and editable input;
- optional clickable verbs or object lists that issue normal parser commands;
- an intent-normalization layer that never invents successful world actions.

**Boundary:**

Better comprehension must not become generative improvisation that fabricates rooms, objects, solutions, dialogue, or consequences outside canonical state.

**Sources:**

- [What Would You Like To See In A New, Fan-Made Zork Adventure? — r/Zork](https://www.reddit.com/r/zork/comments/ityg9p)
- [Best modern way to play old Infocom games? — IntFiction](https://intfiction.org/t/best-modern-way-to-play-old-infocom-games/49511)
- [ReZORK — ZORK Reimagined — IntFiction](https://intfiction.org/t/rezork-zork-reimagined/72394)

## 4. Keep challenge, remove arbitrary hostility

**Evidence:** PAIN-POINT INFERENCE and RECURRING PREFERENCE

Positive reviews still praise Zork's exploration, evocative prose, mystery, and parser strength. Critical reviews repeatedly object to:

- arbitrary or poorly clued failure;
- unwinnable states that may not be recognized until much later;
- random combat;
- mazes that consume time without producing meaningful understanding;
- finite-light pressure before the player understands the world;
- having to guess an exact verb after already understanding the intended action.

The community does not consistently ask for an easy game. It asks, implicitly and sometimes explicitly, for difficulty based on thought rather than interface combat or hidden irreversible damage.

**Candidate responses:**

- preserve hard puzzles but improve environmental clues;
- preserve consequences but surface physical evidence of approaching failure;
- avoid silently destroying the possibility of completion;
- make alternate solutions arise from real world state;
- make combat more deterministic, readable, and avoidable where appropriate;
- convert maze knowledge into landmarks, records, maps, or learned navigation without making discovery automatic;
- provide optional progressive hints that reveal no more than the player requests.

**Sources:**

- [IFDB review: “Perfectly Balanced”](https://ifdb.org/viewgame?id=0dbnusxunq7fw5ro&review=1533)
- [IFDB review: “I'm grateful for Zork and never want to play it again”](https://ifdb.org/viewgame?id=0dbnusxunq7fw5ro&reviews=)
- [RPGnet discussion of verb guessing](https://forum.rpg.net/index.php?threads/ive-wondered-how-do-you-win-at-zork-i.499612/)

## 5. Reconnect the Great Underground Empire as a coherent place

**Evidence:** HISTORICAL GAP and DIRECT WISH

Players who remembered the mainframe Dungeon repeatedly asked how to play the original world as one connected game rather than three commercial installments. Discussions note that the commercial games changed geography, altered puzzle solutions, and added material while not simply reconstituting the original unified map.

The emotional request beneath those threads is important: some players remember the GUE not as three product files but as one enormous place.

**Candidate future direction:**

- identify original Dungeon geography and content absent or changed in commercial Zork I–III;
- document contradictions rather than silently choosing one version;
- consider restored routes, ruins, archival reconstructions, or alternate historical layers;
- let the museum, Attic, maps, and scholars explain why records disagree;
- build new connective tissue only where it respects canonical objects, actors, and puzzle consequences.

A literal merger is not automatically the best answer. A world that recognizes its own conflicting editions may be more Zork-like and more honest.

**Sources:**

- [Zork Trilogy — rec.games.int-fiction](https://groups.google.com/g/rec.games.int-fiction/c/0YstuJbLY1o)
- [Complete Original Zork Dungeon? — rec.games.int-fiction](https://groups.google.com/g/rec.games.int-fiction/c/qbxXZqAG8mA)
- [Original Zork (Dungeon Adventure) — The Zork Library Forum](https://www.thezorklibrary.com/forum/viewtopic.php?t=93)

## 6. Turn remembered events, legends, and off-screen actions into playable stories

**Evidence:** DIRECT WISH

A Zork Library fan-game discussion proposed three particularly useful categories:

1. fill in events witnessed or mentioned but never played;
2. turn hidden stories and legends into playable episodes;
3. adapt existing fan fiction into small games.

Specific proposals included:

- playing as the Thief;
- playing as the Troll;
- following Antheria Jack while he retrieves confiscated property and enables an escape;
- using transcripts of canonical encounters to keep a side story consistent with known events.

This is unusually compatible with the systems already developed for the House: chronology, evidence, actor dossiers, custody, deterministic playback, and multiple perspectives on one event.

**Candidate future products:**

- **The Thief's Route** — the same expedition seen through custody, theft, concealment, and escape;
- **The Troll's Bridge** — a short actor-centered story with a different understanding of the Adventurer;
- **Antheria Jack's Prison Run** — a compact stealth-and-recovery episode;
- **Attic Reconstruction Episodes** — playable but explicitly bounded reconstructions built from archived evidence;
- **Legends of the GUE** — small complete stories based on lore that was previously only described.

These should be complete authored products, not disposable minigames or sub-beads.

**Source:** [Bite-sized fan games — The Zork Library Forum](https://www.thezorklibrary.com/forum/viewtopic.php?t=164)

## 7. Deepen forgotten characters, cultures, and unresolved lore

**Evidence:** DIRECT WISH

When r/Zork users were asked what a new fan-made adventure should explore, suggestions included:

- the Thief's origins;
- Entharion's blade, Grueslayer;
- the origins of grues;
- the ancient Mythicans;
- more Boos Miller;
- a final project involving original Infocom creators.

A later fan post about Zork Grand Inquisitor emphasized the magic, humor, memorable spaces, characters, and sense that every discovery mattered.

**Candidate response:**

Build lore through things the player can do:

- recover contradictory records;
- inspect objects tied to a character's life;
- revisit changed locations;
- receive correspondence from witnesses and scholars;
- see museum interpretations revised;
- play bounded historical reconstructions;
- encounter living consequences of old factions and cultures.

Avoid encyclopedia dumping. Lore should enter through objects, places, testimony, records, and consequences.

**Sources:**

- [What Would You Like To See In A New, Fan-Made Zork Adventure? — r/Zork](https://www.reddit.com/r/zork/comments/ityg9p)
- [Zork Grand Inquisitor — best game of all time — r/Zork](https://www.reddit.com/r/zork/comments/1cnv9gc/zork_grand_inquisitor_best_game_of_all_time/)

## 8. Preserve the imagination of text while adding optional visual orientation

**Evidence:** RECURRING PREFERENCE

There is no consensus that Zork should become fully graphical. There **is** recurring interest in hybrid forms:

- plain parser text;
- Zork Zero-like text with illustrations or interface support;
- maps and clearer inventory presentation;
- graphical versions that preserve original rooms, puzzles, and descriptions;
- modern point-and-click interpretations;
- first-person graphical exploration for newcomers.

Some fans value text precisely because imagination fills the space. Others find tracking objects, rooms, and puzzle relationships too much work without visual help.

**Design consequence for Glulx:**

Offer presentation layers without making them separate games:

- room or region map panes;
- museum floor and exhibit layouts;
- object cards, silhouettes, or sketches;
- transcript, correspondence, and dossier browsers;
- contextual action controls that issue parser commands;
- audio and illustration as atmosphere, never required evidence;
- a text-only mode with complete parity.

**Sources:**

- [Best Zork Format For Future Games? — The Zork Library Forum](https://www.thezorklibrary.com/forum/viewtopic.php?t=315)
- [New Zork Remake in Development — The Zork Library Forum](https://www.thezorklibrary.com/phpbb/viewtopic.php?p=1585)
- [Graphical Remakes? — r/Zork](https://www.reddit.com/r/zork/comments/jiqrt2)
- [Zork Revisited — Question 1 — r/Zork](https://www.reddit.com/r/zork/comments/hikrkf)

## 9. Do not turn Zork into repetitive grind

**Evidence:** DIRECT REJECTION

Zork fans discussing future formats repeatedly rejected designs centered on repetitive clicking, trivial quests, and MMO-like grind. They valued puzzles, authored story, and active thought.

This is directly relevant to our possible future food, fishing, stamina, and museum systems.

**Guardrails:**

- fishing cannot become repeated command farming for rarity percentages;
- hunger cannot demand bread every twenty turns;
- museum growth cannot be a checklist detached from story;
- cooking cannot require endless ingredient harvesting;
- stamina cannot block ordinary movement merely to extend play time;
- daily quests, generic respawns, and economy inflation do not belong by default;
- repeated actions should produce new knowledge, changed circumstances, social consequences, or meaningful resources.

**Source:** [Best Zork Format For Future Games? — The Zork Library Forum](https://www.thezorklibrary.com/forum/viewtopic.php?t=315)

## 10. Players value tangible records and artifacts around the fiction

**Evidence:** DIRECT WISH and HISTORICAL PRECEDENT

A recent r/Zork discussion asked which physical “feelies” fans wish had existed. Responses favored artifacts that look as if they came from the world: a Zorkmid coin, the mailbox leaflet, a mechanical singing bird, stock certificates, and correspondence.

Return to Zork also demonstrated a useful interactive principle: conversations could be driven by showing inventory objects, photographs, map locations, and recorded prior conversations.

Our current House direction already internalizes this desire digitally through physical records, letters, transcripts, case files, receipts, and provenance-aware museum objects.

**Candidate extensions:**

- printable or exportable museum catalog pages;
- in-game facsimiles of letters, permits, certificates, maps, tickets, labels, and field notes;
- player-created photographs, sketches, rubbings, and recordings as conversation evidence;
- curator and NPC responses to particular objects and their histories;
- Glulx windows that present these records visually while retaining parser access.

**Sources:**

- [Wishful Feelies — r/Zork](https://www.reddit.com/r/zork/comments/1uqyplf/wishful_feelies/)
- [The Digital Antiquarian on Return to Zork's conversation interface](https://www.filfre.net/2019/05/)

## 11. Let familiar places accumulate more story

**Evidence:** DIRECT APPRECIATION and OUR EXTENSION

A reader discussing the Zork choose-your-own-adventure books praised how they revisited the white house, sword, nest, troll, maze, dam, coal mine, and other familiar material while adding story around those places.

That supports a principle already demonstrated by the House trains: extension does not require abandoning the canonical map. A small famous place can sustain much deeper memory, history, visitors, records, ecology, and consequence.

**Candidate response:**

- deepen existing rooms before multiplying empty new rooms;
- add histories, object behavior, actors, and changing conditions around canonical places;
- let later systems reveal new uses for familiar features without invalidating original solutions;
- preserve the recognition pleasure of returning to the dam, forest, maze, mine, Hades, and house.

**Source:** [Zork BOOK (choose your own adventure) — r/Zork](https://www.reddit.com/r/zork/comments/noji4d)

## 12. Fan projects repeatedly fail from scope, not lack of love

**Evidence:** HISTORICAL PATTERN

The Zork Library contains several ambitious remake and revival discussions. Some produced demos or partial engines; many did not reach the intended complete game.

The most useful lesson is not “make everything small.” It is:

- define a complete product;
- preserve a truthful boundary;
- build working player-facing behavior;
- avoid depending on enormous art production before interaction exists;
- do not confuse an engine demonstration with a finished Zork experience;
- preserve provenance and handoff information so the work can continue.

Our train-and-bead method is valuable precisely because it converts enthusiasm into bounded, qualified product growth without pretending the final vision must be tiny.

**Sources:**

- [New Zork Remake in Development — The Zork Library Forum](https://www.thezorklibrary.com/phpbb/viewtopic.php?p=1585)
- [Welcome & The Future of Zork Game — The Zork Library Forum](https://www.thezorklibrary.com/forum/viewtopic.php?t=553)
- [A revival? — r/Zork](https://www.reddit.com/r/zork/comments/rgqnj2)

---

# Lost and underused directions worth investigating

These are not all missing from every version of Zork. They are historical or design seams that deserve source-level and lore-level research before any implementation decision.

## A. The unified Dungeon geography

Research questions:

- Which rooms, routes, and puzzle relationships changed when Dungeon became Zork I–III?
- Which original connections made the GUE feel more spatially coherent?
- Which commercial additions would conflict with a literal reunification?
- Could contradictory maps become an intentional historical mystery?

## B. Material omitted, relocated, or transformed

Usenet participants recalled puzzles or structures that appeared differently in Dungeon and later Infocom works. This needs exact source comparison rather than forum-memory acceptance.

Potential output:

- a source-grounded `DUNGEON_TO_ZORK_DIFFERENCE_LEDGER`;
- classifications for restored, relocated, transformed, contradicted, and already-reused material;
- no implementation until provenance is clear.

## C. Side-character chronology

The Thief, Troll, Antheria Jack, Boos Miller, historical rulers, scholars, and minor witnesses could each have event timelines assembled from:

- source behavior;
- canonical dialogue;
- game transcripts;
- manuals and feelies;
- later franchise references;
- contradictions between versions.

This would feed dossiers, museum interpretation, correspondence, visits, and future playable perspectives.

## D. Object-centered conversation

Return to Zork's photos, map references, inventory presentation, and recordings suggest a path that parser IF can deepen:

```text
> SHOW TROLL FUR TO CURATOR
> ASK THIEF ABOUT PAINTING
> PLAY DAM RECORDING FOR WURBISH
> SHOW MAP OF HADES TO SAILOR
> COMPARE SILVERFIN WITH MUSEUM SPECIMEN
```

The object and its provenance become the topic, not a detached dialogue-tree keyword.

## E. World-derived records and feelies

The current House records can become the digital equivalent of Infocom feelies:

- certificates;
- museum plaques;
- correspondence;
- expedition permits;
- specimen labels;
- damaged maps;
- receipts;
- transcripts;
- field notebooks;
- wanted notices;
- visitor cards;
- research disagreements.

These should be produced by real events, not unlocked by arbitrary completion percentages.

---

# What the research supports in our current idea lane

## Strongly supported

The community evidence strongly supports:

- deeper noun and object implementation;
- improved parser comprehension;
- clearer feedback and fairer consequences;
- preservation of puzzles and challenge;
- richer Zork lore and character history;
- playable versions of previously off-screen stories;
- optional visual and audio presentation around authoritative text;
- coherent world geography and records;
- more meaningful use of familiar locations;
- avoiding grind and generic modern-game systems.

## Compatible but not directly requested

These are **our extensions**, supported by the principles above but not directly demanded by the surveyed communities:

- the Great Underground Empire museum;
- multiple fish species and circumstance-driven varieties;
- ecological changes caused by dam, weather, magic, and player actions;
- provenance-aware specimen plaques;
- cooking combinations;
- hunger, satiation, and stamina;
- the House as a living record system;
- dream records based on earned discoveries.

We should describe these honestly as new design, not recovered fan consensus.

## Not supported as defaults

The research gives little support for:

- repetitive resource grinding;
- mandatory daily systems;
- survival meters that interrupt ordinary exploration;
- generic crafting detached from Zork fiction;
- trivial quest markers replacing observation;
- full procedural generation of lore or solutions;
- conversion into a combat-first RPG or MMO;
- graphics that remove the parser rather than support it.

---

# Candidate Highly Extended Zork products suggested by the research

These are product candidates, not a train order.

## 1. The World Answers Back

A complete implementation-depth product focused on:

- described nouns;
- reasonable examinations;
- physical material responses;
- object-to-object interactions;
- specific failure messages;
- remembered consequences.

## 2. The Lost Dungeon Ledger

A complete research and in-world archive product comparing mainframe Dungeon, commercial Zork, and later reuse without silently merging incompatible history.

## 3. Stories Between the Commands

A set of complete playable perspectives or reconstructions centered on events the player previously only heard about.

## 4. Evidence-Based Conversation

NPC dialogue driven by objects, records, locations, photographs, specimens, and transcripts rather than isolated keyword menus.

## 5. The Great Underground Museum

The already documented museum, ecology, and fishing direction, explicitly framed as our new design response to the community's desire for deeper interaction, lore, records, and meaningful familiar places.

## 6. Glulx Orientation and Accessibility

A parser-complete product adding optional maps, history, object views, command help, modern abbreviations, transcript navigation, and visual records.

## 7. Community Archaeology Intake

A maintained research file that records future community findings with:

- exact source;
- date;
- direct request versus inference;
- Zork compatibility;
- conflict with existing systems;
- candidate destination;
- reason for rejection when unsuitable.

This should remain research, not become a second Kanban or shadow bead system.

---

# Source ledger

| Source | Date | Evidence extracted | Classification |
|---|---:|---|---|
| [Best Zork Format For Future Games?](https://www.thezorklibrary.com/forum/viewtopic.php?t=315) | 2009 | Text, hybrid graphics, full graphics, newcomer orientation, puzzle challenge, anti-grind | Direct wishes and recurring preferences |
| [New Zork Remake in Development](https://www.thezorklibrary.com/phpbb/viewtopic.php?p=1585) | 2008–2019 | Preserve original rooms, puzzles, descriptions, and interaction; graphical remake ambition; scope/legal concerns | Direct project proposal and historical pattern |
| [Welcome & The Future of Zork Game](https://www.thezorklibrary.com/forum/viewtopic.php?t=553) | 2012–2013 | New Zork atmosphere, puzzles, humor, graphics-heavy demo, unfinished ambition | Direct project proposal and scope lesson |
| [Bite-sized fan games](https://www.thezorklibrary.com/forum/viewtopic.php?t=164) | 2007 | Play missing events, legends, Thief/Troll perspectives, transcript consistency | Direct wishes |
| [Original Zork (Dungeon Adventure)](https://www.thezorklibrary.com/forum/viewtopic.php?t=93) | 2005 | Desire to revisit unified mainframe Dungeon | Historical gap |
| [What Would You Like To See In A New, Fan-Made Zork Adventure?](https://www.reddit.com/r/zork/comments/ityg9p) | 2020 | Thief origins, cultures, grues, Grueslayer, Boos Miller, better comprehension, legal caution | Direct wishes |
| [Graphical Remakes?](https://www.reddit.com/r/zork/comments/jiqrt2) | 2020 | Graphical reconstruction or reimagining while retaining puzzles and recognizable world | Direct wish |
| [A revival?](https://www.reddit.com/r/zork/comments/rgqnj2) | 2021 | Desire for rights availability and a fan-developed revival | Direct wish and historical context |
| [Zork BOOK](https://www.reddit.com/r/zork/comments/noji4d) | 2021 | Appreciation for adding story around familiar Zork I places and objects | Direct appreciation |
| [Zork Grand Inquisitor — best game of all time](https://www.reddit.com/r/zork/comments/1cnv9gc/zork_grand_inquisitor_best_game_of_all_time/) | 2024 | Desire for another magical, humorous, discovery-rich Zork adventure | Direct wish |
| [Wishful Feelies](https://www.reddit.com/r/zork/comments/1uqyplf/wishful_feelies/) | 2026 | Desire for world-like physical artifacts: leaflet, coin, mechanical bird | Direct wishes |
| [Best modern way to play old Infocom games?](https://intfiction.org/t/best-modern-way-to-play-old-infocom-games/49511) | 2021 | Modern abbreviations and interpreter/game distinction | Accessibility evidence |
| [ReZORK — ZORK Reimagined](https://intfiction.org/t/rezork-zork-reimagined/72394) | 2024 | Smoother input/narration while preserving logic | Modern reimagining proposal |
| [IFDB: Perfectly Balanced](https://ifdb.org/viewgame?id=0dbnusxunq7fw5ro&review=1533) | 2007 | Exploration, prose, challenge, parser, mystery | Positive design evidence |
| [IFDB: Sic Transit...](https://ifdb.org/viewgame?id=0dbnusxunq7fw5ro&review=2506) | 2008 | Unrecognized described nouns and shallow object implementation | Pain point |
| [IFDB Zork I reviews](https://ifdb.org/viewgame?id=0dbnusxunq7fw5ro&reviews=) | ongoing | Mazes, random combat, unwinnable states, weak clueing, finite-light frustration | Pain points |
| [Zork Trilogy — Usenet](https://groups.google.com/g/rec.games.int-fiction/c/0YstuJbLY1o) | 1998 | Unified Dungeon memory, geography changes, transformed puzzles | Historical gap |
| [Complete Original Zork Dungeon? — Usenet](https://groups.google.com/g/rec.games.int-fiction/c/qbxXZqAG8mA) | 2001 | Emotional desire to replay the connected mainframe world | Direct wish and historical gap |
| [Digital Antiquarian: Return to Zork](https://www.filfre.net/2019/05/) | 2019 | Objects, photos, map locations, and recordings used as conversation subjects | Historical design precedent |

## Research limitations

- Forum posts represent self-selected enthusiasts, not every Zork player.
- Old links and fan-project files are sometimes dead or incomplete.
- Memories of Dungeon versus commercial Zork may be inaccurate until checked against source and executable behavior.
- Search indexing favors surviving public pages and may omit deleted, private, or unarchived discussions.
- A complaint can support several possible solutions; proposed responses are ours unless labeled as a direct wish.
- Community enthusiasm does not resolve copyright, trademark, or release-policy questions.

## Promotion rule

Before using any finding as an implementation requirement:

1. verify historical claims against source, shipped game behavior, or primary documentation;
2. state whether the feature is restoration, reinterpretation, or original extension;
3. preserve canonical authority and current custody/state systems;
4. define a complete player-facing product and qualification journey;
5. do not create sub-beads or a shadow roadmap from this research file.
