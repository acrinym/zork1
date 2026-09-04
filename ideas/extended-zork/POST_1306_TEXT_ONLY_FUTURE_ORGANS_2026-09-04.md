# Highly Extended Zork — Post-1306 text-only future organs

**Captured:** September 4, 2026  
**Status:** concept catalog, unsequenced  
**Live frontier at capture:** `acrinym/zork1` `master` — Release **1306** Mara Earned Romance locked (`76871675af153c55440ee472fde4aec25408c3f160a33f963e32ad2cf4e466c5`)

These are **product organs, not release numbers**. Nothing here is CURRENT, a bead train, or merge authorization. Sequence later. Parser-native only.

**Hard boundary:** no GUI, no graphics, no illustrated frontend, no DRAW, no portrait system, no clickable map, no love meter, no scenery engine, no recursive audits.

Adjacent catalogs: `POST_1305_FUTURE_PRODUCT_ORGANS_CATALOG_2026-09-03.md` (body/wardrobe already queued as 1309), `narrative-perspective-and-storybook-experiments.md` (storybook / CYOA presentation).

---

# 1. Choose-your-own-adventure playthrough mode

A **presentation** of the live Highly Extended game, not a second plot.

The world stays one Glulx state: objects, custody, light, troll, Dam, Mara partnership facts, score, death. Numbered lines are **real commands the parser already understands**, authored as currently obvious physical options. They do not invent a branching novella that ignores the object tree.

Example, still West of House:

```text
The field west of the house is quiet. Boards cross the front door. A small mailbox leans by the road. The grass has gone a little wild.

What do you do?

1. Open the mailbox.
2. Walk north around the house.
3. Walk south around the house.
4. Examine the boards.
5. Something else...
```

Choosing `1` executes `OPEN MAILBOX` in the same state as typing it. `5` returns the ordinary parser prompt. SAVE / RESTORE / UNDO remain the same files.

## Why this is cool in HE, not only vanilla

After 1306, a passage can honestly include:

- ask Mara to stay, or refuse, when history makes that question timely;
- light the lamp before the cellar, because partners named the dark;
- leave a garment on the (future) clothesline because it is wet.

Choices must **not** list hidden puzzle solutions merely because they are legal verbs. Obvious affordances and already-learned facts only. The maze does not become a numbered answer key.

## Mode, not default

Default Highly Extended remains a blank parser prompt. Storybook / CYOA is an optional edition or a command like `READ ALOUD` / `STORY MODE` that can be turned off. It must not silently rewrite `master` play. See the blocked narrative-perspective train: side edition, not a mute of Zork.

## Not this organ

- HTML / Twine / ChoiceScript export as the product
- A separate dumbed-down Zork
- Pictures beside the numbered list
- Auto-playing cutscenes

Community wish already noted the Infocom-era Zork CYOA *books* revisiting house, nest, troll, dam (`community-wishes-and-lost-ideas.md`). This organ is the **game** speaking that way, with HE rooms included.

---

# 2. The Last Honest Recap (diegetic, not a debug dump)

A physical sheet or Mara's notebook page that restates **what this expedition has actually witnessed**, in surveyor's prose: gates moved, jar smashed, partnership postponed, lamp fuel low. Reading it is `READ SHEET`, not a stats screen. Lies on the imperial map can still contradict it. No quest-log UI.

---

# 3. Echo and rumor as rooms, not a gossip engine

Some HE spaces already answer. Push further as **local** behavior:

- a cistern that repeats the last shouted word once, then stills;
- Dam tourists (if authored) who misreport the gate state you just set;
- the troll, once bound, who has one true sentence and several insults.

Not a social-network simulation. Named speakers, named rooms.

---

# 4. Night in the House as parser time, not a rest button

If 1307 weather/time lands, night should change **this** house: which windows show lamp-glow, whether Mara is waiting or sleeping in a real room, whether the mailbox is reachable in dark. `SLEEP` remains a location. Dreams, if any, stay authored passages tied to the day's facts (ladder, rupture, meal), not a random event table.

---

# 5. Correspondence you can lose

Letters and notes already exist in the House of Records lane. Future play can let a letter **fail to arrive**, get wet in the basin, or be filed in the wrong drawer. The player learns that by looking, not by a mail app. Mara does not become a chatbot who summarizes your inbox.

---

# 6. Score as an object that can be wrong

The trophy case already refuses to be a score panel. A later organ: an imperial brass plate that **claims** a score. `EXAMINE PLATE` quotes the lie. Putting treasures in the case still does the canonical work. The plate is scenery with a parser, not a HUD.

---

# 7. InvisiClues as an unreliable pamphlet in the House

A found pamphlet of questions, not answers in a sidebar. Some questions match this HE world. Some are for a different edition. `READ PAMPHLET` never executes a walkthrough. Using it is diegetic reading.

---

# 8. Two voices, one keyboard (optional edition)

A **letter-passing** or `TELL MARA ...` / `THEN I ...` cadence where the player can mark which sentences are the adventurer's log vs commands. Still one parser. Not multiplayer netcode. Not a GUI transcript highlighter — maybe `"` quotes in the log object.

---

# 9. What stays out

Anything that needs a canvas, portrait, minimap, inventory grid, romance hearts, or a thousand audit organs. Wardrobe and the second HE census remain the **queued product trains**, not this catalog.
