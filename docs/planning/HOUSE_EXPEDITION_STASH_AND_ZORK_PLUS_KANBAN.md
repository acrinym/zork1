# House Expedition Stash and Zork Plus Kanban

**Status:** pre-BEADS addendum  
**Captured:** 2026-07-23  
**Related program:** `expanded/docs/HOUSE_OF_RECORDS_PROGRAM.md`  
**Related idea board:** `docs/planning/LIVING_ZORK_FUTURE_IDEAS_KANBAN.md`

## Correction to the house model

The white house is not only an archive, museum, and witness. It is also an operational expedition base.

The player should be able to return home, put dangerous or valuable objects somewhere dependable, replenish a bounded set of ordinary supplies, prepare a deliberate loadout, and leave again without carrying the entire Great Underground Empire on his back.

After a legitimate victory, a separate postgame mode may allow a new expedition to begin with selected previously unlocked equipment. `Zork Plus` is the working product name; an in-world presentation could call it a **Second Expedition**, **Veteran Expedition**, or another period-appropriate term.

These ideas extend the existing Kitchen preparation, Cellar expedition-threshold, and postgame expedition-archive trains. They are not beads yet and must not silently alter the existing ninety-six-bead House of Records roadmap.

## Product thesis

> Home should let the adventurer prepare intelligently without making preparation into chores or erasing the danger of leaving home.

The house loop should become:

1. return with real objects, evidence, injuries, and consequences;
2. archive, display, repair, clean, replenish, store, or deliberately carry them onward;
3. choose an expedition loadout rather than automatically hauling everything;
4. accept the physical and social consequences of that loadout;
5. return, die, lose equipment, recover it, or leave a new history for the house to record.

## Persistence layers that must remain distinct

### 1. Ordinary save-state persistence

`SAVE` and `RESTORE` preserve the exact current world, including locker contents, container contents, fuel, water, food, armor state, carried equipment, timers, and object locations.

### 2. Same-expedition death persistence

If Zork's death or reincarnation flow continues the same expedition, the rules must state what happens to:

- objects safely deposited at the house;
- objects carried at death;
- objects dropped at the death location;
- objects destroyed by the fatal event;
- objects taken by the thief, troll, water, machinery, fire, or another actor;
- and unique puzzle objects required to keep the expedition completable.

The safe stash should protect what was actually deposited. It must not magically recover everything the player neglected to store.

### 3. Completed-expedition archive persistence

A completed run records its final house, locker, carried inventory, lost objects, destroyed objects, loadout, deaths, and world state in its own expedition box.

### 4. Post-victory Zork Plus persistence

A new expedition may unlock a bounded preparation mode based on legitimate prior completion. This is not the same thing as restoring the old world or merging contradictory expeditions.

## Core boundaries

1. The first expedition remains canonical in its starting conditions unless the player explicitly selects a noncanonical mode.
2. The original score remains authoritative; storage and supplies do not manufacture treasure or score.
3. Every portable object retains exact identity. A selected sword, rope, bottle, or tool cannot also remain duplicated at its canonical map location.
4. Food, water, and fuel create useful choices but no hunger, thirst, or daily-upkeep meters.
5. Armor provides protection only with meaningful weight, noise, heat, mobility, swimming, climbing, social, or theft consequences.
6. The stash is physical and locatable. It is not an unexplained menu floating outside the fiction.
7. A house stash may be secure without being absolutely invulnerable; later house-intrusion work may create authored threats and evidence.
8. New Game Plus equipment should create alternate reasoning and new risk, not simply delete every puzzle.
9. Cross-run unlocks must never reveal unseen solution text automatically.
10. Save, death, new-run, and archive semantics must be separately qualified.

---

# READY TO SHAPE

## Epic HST — physical house stash

| ID | Card | Intended result | Boundary / dependency |
|---|---|---|---|
| HST-001 | Expedition locker | Add a physical cabinet, trunk, equipment cage, or strongbox in the house or Cellar for depositing real portable objects. | Exact containment and capacity rules; no magical menu inventory. |
| HST-002 | Deposit and withdrawal grammar | Support reasonable `PUT`, `STORE`, `DEPOSIT`, `PACK`, `TAKE`, `REMOVE`, and `WITHDRAW` intent through canonical actions where possible. | Do not invent a second object system beside ZIL containment. |
| HST-003 | Persistent object tree | Preserve nested sacks, bottles, tools, food, armor, and other containers exactly while stored. | Prevent containment cycles and duplicate objects. |
| HST-004 | Stash inventory report | Let the player inspect what is stored, what is packed inside what, and what condition it is in. | In-world list or labels, not a modern cloud inventory. |
| HST-005 | Safe-on-death contract | Objects physically inside the secured stash survive ordinary same-expedition death handling. | Safety applies only to deposited objects and must fit reincarnation rules. |
| HST-006 | Carried-item death fate | Define dropped, damaged, destroyed, displaced, stolen, or recoverable outcomes for equipment carried at death. | Death cause and location remain authoritative. |
| HST-007 | Recovery expedition | Permit surviving or reincarnated players to return for equipment left at a death site when the world state allows it. | No automatic return-to-house teleport. |
| HST-008 | Actor interference | Let the thief, intruders, smoke, water, creatures, or supernatural effects threaten poorly secured storage only in authored later trains. | Initial locker may be secure; vulnerability is explicit scope. |
| HST-009 | Unique-object safety | Prevent permanent accidental deletion of indispensable unique objects without making all loss consequence-free. | Recovery route, alternate canonical route, or explicit irreversible outcome required. |
| HST-010 | Stash qualification | Prove nested storage, save/restore, deliberate corruption, death continuity, withdrawal, and anti-duplication. | Must test real production objects. |

## Epic SUP — house supply and replenishment surfaces

| ID | Card | Intended result | Boundary / dependency |
|---|---|---|---|
| SUP-001 | Bottle-filling station | Fill real empty, open bottles with real house water. | Bottles remain finite, exact objects; water does not appear in closed or absent bottles. |
| SUP-002 | Water-source behavior | Make sink, pump, cistern, tap, or other period-appropriate source inspectable and physically credible. | No universal fluid simulator. |
| SUP-003 | Lighter refueling | Refill a real lighter from a real fuel container at the house. | Fuel state is bounded and saveable; refilling is not a repetitive chore every few rooms. |
| SUP-004 | Fuel inspection | Report empty, low, adequate, full, leaking, wet, or unsafe fuel states in Zork's voice. | Avoid numerical HUD percentages unless needed internally. |
| SUP-005 | Pantry food | Store and pack selected real food into a sack or other suitable container. | No hunger meter, farming, recipe economy, or infinite item duplication. |
| SUP-006 | Sack provisioning | Deliberately prepare the real sack with food, cushioning, tools, or supplies while preserving existing nest-catch and rope-cinch states. | Existing sack mechanics remain authoritative. |
| SUP-007 | Supply replenishment policy | Define what is renewable, when it replenishes, and whether replenishment differs before and after victory. | Prevent infinite score, treasure, fuel exploits, and busywork. |
| SUP-008 | Condition-aware preparation | Cleaning, drying, cooling, warming, filling, and packing must preserve object condition and consequences. | Build above material-state architecture. |
| SUP-009 | Preparation receipt | Record what the adventurer deliberately packed, refilled, wore, and left behind before departure. | Feeds Attic archive without logging every container shuffle. |
| SUP-010 | Supply qualification | Prove finite containers, consumption, replenishment boundaries, save/restore, and no manufactured puzzle objects. | Separate first-run and postgame behavior. |

## Epic ARM — armor and protective equipment

| ID | Card | Intended result | Boundary / dependency |
|---|---|---|---|
| ARM-001 | Wearable armor foundation | Support a small authored set of protective garments or equipment. | No generalized equipment-stat spreadsheet. |
| ARM-002 | Damage-family protection | Armor may reduce selected cutting, impact, heat, bite, scrape, or machinery outcomes. | It cannot grant universal immunity. |
| ARM-003 | Encumbrance cost | Armor and heavy loadouts affect climbing, falls, swimming, narrow passages, exhaustion, and recovery. | Use coarse authored classes rather than continuous physics. |
| ARM-004 | Noise cost | Metal, loose gear, and poorly packed tools may announce the player to the thief, troll, grues, or other creatures. | Sound propagation must be location- and actor-aware. |
| ARM-005 | Heat and fire cost | Protective clothing may resist one hazard while retaining heat, catching fire, or making extinguishing harder. | Integrate with existing clothing-fire logic. |
| ARM-006 | Social recognition | Characters notice an armored, armed, burdened, or strangely equipped adventurer and react according to motive. | No cosmetic-only armor if prose claims visible consequences. |
| ARM-007 | Armor maintenance | Permit bounded cleaning, drying, repair, or replacement without creating repetitive durability chores. | Important damage persists; ordinary upkeep stays abstract. |
| ARM-008 | Armor qualification | Prove one protected outcome, one worsened outcome, one mobility consequence, actor reaction, and persistence. | Every benefit needs an authored cost or boundary. |

## Epic ZP — Zork Plus / Veteran Expedition

| ID | Card | Intended result | Boundary / dependency |
|---|---|---|---|
| ZP-001 | Victory unlock | Unlock the mode only after a legitimate completed expedition is recorded. | Debug completion and partial runs do not qualify. |
| ZP-002 | Explicit mode selection | Let the player choose canonical first expedition or postgame expedition without silently changing the opening. | Historical and preserved editions remain untouched. |
| ZP-003 | Expedition loadout room | Use the Kitchen, Cellar, or a dedicated house surface to select equipment before leaving. | Selection remains in-world and inspectable. |
| ZP-004 | Loadout allowance | Limit starting choices by slots, weight class, kits, or another authored allowance. | Do not permit “take everything” as the default. |
| ZP-005 | Real-object relocation | If a canonical unique object is selected, remove or replace its canonical map placement correctly rather than duplicating it. | Original puzzle and score logic must remain coherent. |
| ZP-006 | Supply-only starting items | Permit safe renewable supplies such as filled water, food, lighter fuel, or selected protective gear where appropriate. | Supplies cannot be converted into duplicate treasures. |
| ZP-007 | Unlock provenance | Tie available equipment to discoveries, recovered objects, displays, completed areas, or prior expedition outcomes. | No solution spoilers from locked entries. |
| ZP-008 | Start near the house | Begin the new field expedition at or near the white house after preparation, with the chosen real inventory. | The house remains spatially connected to the world. |
| ZP-009 | Alternate-route recognition | Allow prior equipment to support new authored approaches while canonical solutions remain valid. | Carry-in items must not automatically complete puzzles. |
| ZP-010 | Loadout consequences | Heavier, brighter, noisier, better-armed, or better-supplied starts alter NPCs, hazards, drowning, climbing, theft, and death possibilities. | Benefits and risks remain causal. |
| ZP-011 | Challenge presets | Optionally support no-kill, lightly equipped, mechanic, ritual, reckless, archivist, or other self-directed expeditions. | Descriptive presets, not arbitrary RPG classes. |
| ZP-012 | Expedition comparison | Record chosen loadout, supplies used, items lost, items recovered, deaths, discoveries, and final state in the run's archive box. | Separate expedition histories remain separate. |
| ZP-013 | Zork Plus qualification | Prove unlock, canonical-mode isolation, loadout selection, real-object relocation, anti-duplication, save/restore, and completed-run archival separation. | Requires mature House foundation and expedition archive. |

---

# SHAPING

## Epic CCH — Resident-Evil-style chest semantics

The useful part of the Resident Evil chest is not necessarily magical item teleportation. It is the ability to make deliberate inventory decisions without permanently losing every object the player does not carry.

| ID | Card | Open design question |
|---|---|---|
| CCH-001 | One safe home chest | Is a single house or Cellar locker enough when the map gains better shortcuts and return routes? |
| CCH-002 | Local field caches | Should selected maintenance lockers, camps, or secure rooms hold local persistent deposits without sharing contents globally? |
| CCH-003 | Linked Imperial lockers | Could Great Underground Empire freight or maintenance infrastructure justify a limited linked-storage network? |
| CCH-004 | Transfer delay | If lockers are linked, should objects move only after time, bureaucracy, fees, risk, or a completed delivery event? |
| CCH-005 | Thief interaction | Can the thief discover, mark, pick, relocate, or deliberately avoid particular caches? |
| CCH-006 | Death-site container | Should a special container remain where the adventurer died, holding recoverable possessions that survived? |
| CCH-007 | Reincarnation inventory | What does the player retain personally after death, and what returns only through physical recovery? |
| CCH-008 | House vulnerability | When may invasion, water, smoke, or supernatural events compromise storage without making the system feel pointless? |

**Preferred first implementation:** one physical, secure house/Cellar stash. Consider local field caches later. Do not begin with an unexplained omnipresent chest network.

## Epic BAL — postgame balance and canonical integrity

| ID | Card | Open design question |
|---|---|---|
| BAL-001 | First-run purity | Which supplies belong in the expanded first run, and which should remain post-victory only? |
| BAL-002 | Puzzle-critical carry-in | Which unique objects may be selected without collapsing puzzle sequencing or causing impossible object states? |
| BAL-003 | Score handling | How should alternate early access affect canonical points, treasure placement, and final scoring? |
| BAL-004 | Renewable versus unique | Which food, water, and fuel resources can renew while all treasures and named tools remain singular? |
| BAL-005 | Armor usefulness | How often must armor matter to justify its complexity without turning every hazard into a damage calculation? |
| BAL-006 | Return friction | How easy should it be to return to the house so storage is useful without trivializing expedition planning? |
| BAL-007 | Death severity | Which deaths leave recoverable gear, which destroy it, and which place it under actor or environmental control? |
| BAL-008 | Mode labeling | Should the player-facing name be `ZORK PLUS`, `SECOND EXPEDITION`, `VETERAN EXPEDITION`, or something else? |

---

# BLOCKED / DEPENDENT

| ID | Card | Blocker |
|---|---|---|
| DEP-HST-001 | Cross-run equipment unlocks | House state foundation and expedition ID model. |
| DEP-HST-002 | Archive of loadout choices | Attic archive core and curated event rules. |
| DEP-HST-003 | Death-safe versus death-lost inventory | Causal death record and same-expedition death contract. |
| DEP-HST-004 | Armor drowning consequences | Carried-weight classes and dam survival model. |
| DEP-HST-005 | Armor actor reactions | Focused troll, cyclops, thief, and later creature memory. |
| DEP-HST-006 | Stash burglary | House vulnerability and thief escalation. |
| DEP-HST-007 | Linked field lockers | Optional geography and Great Underground Empire infrastructure fiction. |
| DEP-HST-008 | New Game Plus final comparison | Completed expedition archive and separate run boxes. |

---

# DO NOT BUILD AS STATED

| Shortcut | Why it is rejected |
|---|---|
| Give the player every prior item at the opening | It removes expedition planning, duplicates unique objects, and collapses puzzles. |
| Make the chest an unexplained global menu | It breaks the physical fiction that makes object identity meaningful. |
| Return all carried items to the chest automatically after every death | It erases object loss, death-site recovery, thief behavior, and causal consequences. |
| Add hunger, thirst, armor durability, and fuel chores merely because supplies exist | Preparation should create adventure choices, not routine maintenance. |
| Let armor prevent every death | Protection without tradeoffs destroys the new causal death architecture. |
| Duplicate canonical tools at home for convenience | Real-object provenance and canonical map state must remain trustworthy. |
| Merge inventories from contradictory completed worlds | Each expedition remains its own history and object state. |
| Let Zork Plus knowledge or items auto-solve the game | Postgame advantages may open new reasoning, not replace play. |

---

# Suggested promotion order — still not beads

1. Define exact same-expedition death and object-fate semantics.
2. Add one physical house/Cellar expedition locker with exact object persistence.
3. Connect Kitchen bottle filling, lighter fuel, food packing, and bounded replenishment.
4. Add expedition preparation receipts for the House and Attic.
5. Introduce a small armor pilot with one clear benefit and multiple real costs.
6. Finish the ordinary House of Records and completed-expedition archive contracts.
7. Add explicit post-victory mode selection and a tightly limited starting loadout.
8. Prove real-object relocation and puzzle integrity across a complete Zork Plus run.
9. Consider local field caches only after the home stash is valuable and return routes are understood.

# Definition of success

The system succeeds when a player can stand in the house and make an intelligible expedition decision:

- refill the real bottle;
- refuel the real lighter;
- pack real food into the real sack;
- wear protection while understanding its costs;
- deposit objects that should remain safe;
- choose what danger to carry back underground;
- recover or permanently lose equipment according to what actually happened;
- and, after victory, begin a genuinely different expedition whose advantages and mistakes become part of another recorded history.

The house then becomes more than a checkpoint. It becomes the place where the adventurer decides what kind of expedition comes next.
