# Living Zork future systems Kanban

**Status:** pre-BEADS idea inventory  
**Captured:** 2026-07-23  
**Scope:** concepts discussed after qualified Glulx Release `1216` that are not yet accepted as implementation beads

This document exists so high-value ideas do not remain trapped in chat history. It is intentionally a Kanban and design inventory, not a promise that every card will ship. Cards should move into BEADS only after their causal model, canonical boundaries, player-facing value, and qualification route are clear.

## North star

Build the Zork I that players remember imagining: the original world, solutions, narrator, danger, and absurd confidence preserved, but with far more things that can be reasonably attempted, remembered, survived, regretted, and replayed.

The expansion should make the existing map deeper before making it much larger. Replayability should come primarily from authored consequences, character memory, physical state, discoveries, warnings, and different histories—not shuffled rooms, generated loot, or arbitrary randomization.

## Existing in-flight foundation — do not duplicate here

A separate large house-memory train is already planned at more than 90 beads. It is expected to make the house an archive that can remember and present:

- stupid and serious deaths, including count and cause;
- distinct playthroughs and how they connect;
- whether knowledge discovered in one playthrough was applied in another;
- which regions and systems were explored per playthrough;
- NPCs met, important statements, and memorable encounters;
- persistent records that make the house a witness to the adventurer rather than static scenery.

This board treats that archive as a future dependency. Cards below may feed it, but must not recreate its storage, chronology, or presentation work.

## Design laws

1. Preserve canonical solutions and state machines.
2. A new outcome must follow from visible information, physical state, character motive, preparation, timing, or risk.
3. Failure should provide comedy, information, a clue, a remembered consequence, or several of these.
4. Death should complete a causal chain rather than fire from an unexplained author switch.
5. The narrator may be merciless, but the game must remain fair enough that the player can understand what happened.
6. Track what the player knew, not only what happened to the player.
7. Use exact object identity. Stolen, broken, committed, dropped, burned, or transformed objects remain the real objects.
8. Prefer hand-authored semantic families over generic procedural prose.
9. Do not turn Zork into a universal crafting grid, unrestricted physics sandbox, infinite chatbot, or random-content generator.
10. New prose must retain dry confidence, bureaucratic absurdity, understated danger, physical comedy, and blunt finality.

## Board lanes

- **READY TO SHAPE:** coherent enough to become a design train after dependencies are checked.
- **SHAPING:** valuable but still needs rules, limits, or interaction design.
- **BLOCKED / DEPENDENT:** should wait for another system, especially the house archive or broader material-state work.
- **HORIZON:** real future direction, not current implementation scope.
- **DO NOT BUILD AS STATED:** seductive shortcuts that would damage the project.

---

# READY TO SHAPE

## Epic DTH — causal death architecture

| ID | Card | Intended result | Key boundary / dependency |
|---|---|---|---|
| DTH-001 | Causal death record | Record immediate cause, enabling conditions, earlier player decisions, responsible actor, involved objects, location, warnings, and current playthrough. | Must remain compact enough to save reliably. |
| DTH-002 | Death-family framework | Define environmental, creature, object, delayed, magical, mechanical, and self-inflicted death families with shared hooks. | Families support authored variants; they do not generate final prose automatically. |
| DTH-003 | Knowledge-aware culpability | Distinguish unknown hazard, visible-but-unread warning, read warning, misunderstood warning, ignored warning, and repeatedly ignored warning. | Requires reliable knowledge flags rather than transcript guessing. |
| DTH-004 | Causal-indictment narrator | Let the death message identify the meaningful mistake, not merely the final damage event. | Avoid scolding where the game gave no fair signal. |
| DTH-005 | Repeated-folly escalation | Change commentary when the same adventurer repeats substantially the same fatal mistake. | Depends on death semantic identity and later house archive integration. |
| DTH-006 | Near-death records | Record hazards survived, narrow escapes, and last-second recoveries separately from deaths. | Must not spam `RECAP`. |
| DTH-007 | Delayed-consequence deaths | Support earlier damage, opened water routes, smoke, sabotage, wounds, or disturbed creatures killing the player later. | Death report must connect the delayed event to its origin. |
| DTH-008 | Exact-object death provenance | Report when the player is killed by an object he brought, lost, gave away, damaged, or enabled. | No duplicated weapons or replacement props. |
| DTH-009 | Death qualification matrix | Require deterministic routes for trigger, warning state, escape route, exact death, restore behavior, and canonical non-trigger behavior. | Becomes mandatory for each promoted death train. |
| DTH-010 | Mercy for unknowable deaths | Permit rare surprise deaths, but explicitly classify them as unforeseeable rather than accusing the player of ignoring information. | Surprise must still reveal useful world information. |

## Epic WRN — warnings, attention, and responsibility

| ID | Card | Intended result | Key boundary / dependency |
|---|---|---|---|
| WRN-001 | Warning-source registry | Give signs, manuals, NPC statements, environmental cues, and prior incidents stable semantic warning IDs. | Avoid tracking every decorative sentence. |
| WRN-002 | Warning attention state | Track seen, examined, read, heard, understood, contradicted, dismissed, and acted-upon states. | Understanding cannot be inferred solely from issuing `READ`. |
| WRN-003 | Corroborated warnings | Let multiple independent clues increase the narrator's confidence that the player was adequately warned. | Do not make repetition a hidden difficulty gate. |
| WRN-004 | NPC warning credibility | Remember who warned the player and whether that NPC had previously lied, exaggerated, or demonstrated expertise. | Supports fair ambiguity rather than universal truth labels. |
| WRN-005 | Haste and interruption | Recognize leaving mid-warning, skipping a report, or acting before a warning finishes. | Must never punish parser timing or accidental input buffering. |
| WRN-006 | Postmortem evidence list | Allow a death report to cite one to three decisive warnings without dumping the entire clue history. | Tone must remain prose, not debug output. |
| WRN-007 | Bureaucratic incident closure | Use Great Underground Empire signage, maintenance records, and formal warnings as part of sarcastic death accounting. | Preserve period-neutral Zork voice. |

## Epic DAM-D — dam hazard and drowning depth

| ID | Card | Intended result | Key boundary / dependency |
|---|---|---|---|
| DAM-D-001 | Dam-edge fall states | Add slip, deliberate jump, forced fall, failed climb, railing misuse, and collapse entry routes. | Do not create random unavoidable falls. |
| DAM-D-002 | Water-state survival model | Survival depends on reservoir level, gate state, current direction, drop location, and active leak/flood conditions. | Reuse canonical dam state rather than parallel water flags. |
| DAM-D-003 | Swimming knowledge | Establish whether the adventurer can swim, has learned a technique, panics, or is too impaired to use it. | Avoid an unexplained permanent character-stat screen. |
| DAM-D-004 | Encumbrance and sinking | Heavy treasure, tools, weapons, wet clothing, and containers may reduce survival unless dropped. | Use coarse authored weight classes, not universal fluid physics. |
| DAM-D-005 | Buoyancy opportunities | Permit plausible debris, sealed containers, rope, or fixed structures to aid survival. | Each aid must be deliberately supported and testable. |
| DAM-D-006 | Intake and machinery deaths | Currents can pin, draw, batter, or trap the player according to real gate and machinery state. | Keep descriptions suggestive rather than gratuitously graphic. |
| DAM-D-007 | Maintenance ladder and rope rescue | Prepared escape routes can convert certain falls into injuries or recoveries. | Preparation must occur before the fall; no magic inventory rescue. |
| DAM-D-008 | Injury-dependent outcome | Existing wounds, exhaustion, fire, restraint, or missing equipment can turn a survivable fall fatal. | Needs a bounded condition model before promotion. |
| DAM-D-009 | Dam warning chain | Connect railings, signs, sounds, reservoir trend, `MELZAR`, and NPC knowledge to culpability. | Depends on WRN registry. |
| DAM-D-010 | Dam death aftermath | Record where objects were lost, carried downstream, lodged, destroyed, or recoverable after restore/reincarnation rules. | Depends on object persistence policy and house archive. |

## Epic NPC-T — troll escalation and stolen weapons

| ID | Card | Intended result | Key boundary / dependency |
|---|---|---|---|
| NPC-T-001 | Troll disarm route | The troll can knock away, seize, or retain a real carried weapon under authored combat conditions. | Preserve canonical combat probabilities and routes unless explicitly layered. |
| NPC-T-002 | Persistent troll inventory | A stolen sword or tool remains with the troll after retreat and is visible in later encounters. | No duplicate weapon on restore or death. |
| NPC-T-003 | Troll learns the sharp end | After observation or experimentation, the troll can wield the stolen weapon badly but dangerously. | Character-limited competence; he does not become a master swordsman. |
| NPC-T-004 | Killed by your own sword | Add a causal death in which previous loss of the real sword enables the fatal encounter. | Death report must cite theft history and missed recovery opportunity. |
| NPC-T-005 | Weapon-specific taunts | The troll recognizes humiliating ownership and mocks the unarmed player in Zork's voice. | Hand-authored by weapon class, not arbitrary object-name templates. |
| NPC-T-006 | De-escalation after theft | Allow bargaining, trickery, alternate arms, retreat, or recovering the weapon without mandatory killing. | New routes must remain earned and preserve canonical options. |

## Epic NPC-H — thief hostility and retaliation

| ID | Card | Intended result | Key boundary / dependency |
|---|---|---|---|
| NPC-H-001 | Thief relationship ladder | Model amused, attentive, irritated, retaliatory, hostile, hunting, and execution-ready states. | State changes must follow visible treatment, not hidden point grinding. |
| NPC-H-002 | Retaliatory theft | The thief preferentially removes items that inconvenience or symbolically punish the player. | Preserve his canonical roaming and treasure behavior. |
| NPC-H-003 | Sabotage before murder | The thief may extinguish, relocate, damage access, plant misleading evidence, or leave a warning. | No unwinnable state without strong telegraphing and recovery. |
| NPC-H-004 | Explicit final warning | Before deliberate execution, provide character-consistent evidence that patience has ended. | Surprise ambush remains possible only when earned by clear prior escalation. |
| NPC-H-005 | Thief ambush route | The thief selects a plausible location based on player route, light, treasure, and recent conflict. | Avoid unrestricted omniscience. |
| NPC-H-006 | Deliberate thief execution | A sufficiently provoked thief can intentionally kill rather than merely fight opportunistically. | Requires escape, repair, appeasement, or avoidance routes. |
| NPC-H-007 | Postmortem relationship indictment | Death prose summarizes the insult, theft, betrayal, or repeated provocation that caused the execution. | Cite decisive events, not a raw hostility score. |

## Epic GRU — grue ecology and the colony reveal

| ID | Card | Intended result | Key boundary / dependency |
|---|---|---|---|
| GRU-001 | Grue colony location | Establish at least one darkness ecosystem where the danger is a colony rather than a lone roaming grue. | Must not rewrite every dark room into a hive. |
| GRU-002 | Lure-a-grue experiments | Support noise, scent, warmth, meat, blood, and movement experiments with location-specific results. | No universal monster-attractor verb. |
| GRU-003 | Inflame / ignite grues | Interpret attempts to light, burn, or inflame grues and route them through real flame, distance, and darkness state. | Clarify `inflame` as setting aflame, not angering. |
| GRU-004 | False victory beat | A nearby grue retreats from flame, briefly making the plan appear successful. | Must be earned by sufficient flame and proximity. |
| GRU-005 | Cavern-ceiling reveal | Illumination reveals an entire clustered population moving above and around the player. | Signature authored scene; do not dilute with random reuse. |
| GRU-006 | Swarm response | The colony can buffet, extinguish weak light, block exits, follow sound, or attack collectively. | Coarse event model, not real-time flock simulation. |
| GRU-007 | The illumination succeeded | Create a death family where the requested lighting action works exactly and reveals why it was catastrophic. | Preserve the famous grue warning's blunt lineage. |
| GRU-008 | Grue research and survival | Permit observation, stronger barriers, controlled light, silence, decoys, or retreat to teach ecology without making grues ordinary combat mobs. | Grues must retain mystery and fear. |

---

# SHAPING

## Epic DTH-X — broader death inventory

| ID | Card | Open design question |
|---|---|---|
| DTH-X-001 | Smoke inhalation | How should room connectivity, ventilation, and delayed symptoms remain readable without a full gas simulator? |
| DTH-X-002 | Fire spread | Which materials and locations justify persistent spread, collapse, or blocked routes while preserving canonical fire behavior? |
| DTH-X-003 | Crushing machinery | Which existing mechanisms can physically trap or crush the player without becoming arbitrary new traps? |
| DTH-X-004 | Structural collapse | How are damaged boards, bridges, masonry, and supports telegraphed across repeated abuse? |
| DTH-X-005 | Suffocation and sealed spaces | Which containers, chambers, flooding routes, or restraint combinations make this fair and escapable? |
| DTH-X-006 | Wound deterioration | Can a bounded injury system create urgency without turning Zork into survival-stat maintenance? |
| DTH-X-007 | Poison and contamination | Which canonical foods, liquids, tools, or environments support this without inventing a generalized chemistry game? |
| DTH-X-008 | Magical discharge | Which artifacts already imply dangerous energy, and how can misuse kill without adding a spell system? |
| DTH-X-009 | Self-restraint catastrophe | Which locations make tying, trapping, or immobilizing oneself amusingly fatal rather than merely inconvenient? |
| DTH-X-010 | Weapon misuse | Which attacks, throws, ricochets, drops, and improvised uses can logically injure or kill the player? |
| DTH-X-011 | Creature attraction | When should food, blood, sound, light, or stolen objects draw an existing creature into a later encounter? |
| DTH-X-012 | Death by rescue attempt | Can an attempted rescue of an NPC or object fail in a way that reveals character and world state? |

## Epic NPC-X — character memory beyond the current layers

| ID | Card | Open design question |
|---|---|---|
| NPC-X-001 | Troll humiliation memory | What actions are meaningful enough for the troll to remember without treating every joke command as relationship state? |
| NPC-X-002 | Troll mercy and uneasy truce | Can restraint, release, gifts, or spared combat create a narrow non-friend relationship? |
| NPC-X-003 | Thief respect | Can cleverness, risk, valuable gifts, or honoring a bargain earn limited professional respect? |
| NPC-X-004 | Thief false bargains | When may the thief deceive the player without invalidating fair negotiation? |
| NPC-X-005 | Cyclops impatience memory | How should repeated songs, failed soothing, mockery, and food/water routes alter later behavior? |
| NPC-X-006 | NPC knowledge as warning | Which characters know about dam hazards, grue colonies, rituals, and unsafe objects—and why? |
| NPC-X-007 | NPC post-death legacy | How can later playthrough records describe who killed the adventurer without NPCs literally remembering a reset? |
| NPC-X-008 | NPC interactions with dropped hazards | Can characters notice, use, avoid, steal, or be harmed by world-state changes the player leaves behind? |

## Epic RPL — authored replayability

| ID | Card | Open design question |
|---|---|---|
| RPL-001 | Conduct profiles | Track broad patterns such as merciful, destructive, curious, hurried, mechanical, ritual-minded, or absurd without assigning a simplistic morality score. |
| RPL-002 | Canonical-score preservation | Keep the original score authoritative while adding separate discoveries, alternate outcomes, repairs, follies, deaths, and relationship records. |
| RPL-003 | Same score, different history | Make two winning 350-point runs produce meaningfully different archive records and world aftermath. |
| RPL-004 | Knowledge-used-later | Define evidence that a later playthrough used knowledge learned previously without requiring the game to read the player's mind. |
| RPL-005 | Exploration signatures | Record regions, mechanisms, noun surfaces, optional scenes, and character states meaningfully explored per run. |
| RPL-006 | Challenge histories | Support self-directed histories such as no killing, no thief combat, maximum repairs, alternate solutions, or maximum folly. |
| RPL-007 | Expiring opportunities | Let hesitation, departure, or incompatible state close some authored opportunities while leaving canonical completion intact. |
| RPL-008 | World aftermath | Define what the final state says about damage, repairs, living enemies, lost objects, unresolved hazards, and learned secrets. |

## Epic VOI — Infocom-lineage voice

| ID | Card | Open design question |
|---|---|---|
| VOI-001 | Death-tone guide | Codify blunt finality, dry confidence, bureaucratic sarcasm, physical precision, and affectionate contempt. |
| VOI-002 | Culpability ladder prose | How does the narrator differ for ignorance, carelessness, deliberate testing, and repeated deliberate testing? |
| VOI-003 | Incident-report voice | Where can Great Underground Empire procedure, signage, liability, and maintenance paperwork strengthen rather than overtake a joke? |
| VOI-004 | Success-as-catastrophe lines | Build authored patterns where the command succeeds exactly and the consequence exposes the bad premise. |
| VOI-005 | No modern wink rule | Review new prose for internet slang, fandom references, memes, and jokes that prove the writer lives after 1983. |
| VOI-006 | Repetition without templates | How many semantic variants are needed before repeated deaths feel remembered rather than mechanically substituted? |
| VOI-007 | Narrator restraint | Define when silence or a blunt one-line death is funnier than a long autopsy. |

## Epic PHY — deeper existing-world affordances

| ID | Card | Open design question |
|---|---|---|
| PHY-001 | Rope beyond current restraint | Which lowering, retrieval, securing, trip, rescue, and climbing uses are worth explicit support? |
| PHY-002 | Water beyond the dam | Which hot, dusty, muddy, burning, reflective, floating, thirsty, and mechanical interactions are coherent? |
| PHY-003 | Weapon ownership consequences | How do sword, axe, knife, and improvised weapon histories alter NPC behavior and death risk? |
| PHY-004 | Carried-weight classes | Can a small number of authored encumbrance states support drowning, climbing, falling, and exhaustion fairly? |
| PHY-005 | Persistent scenery damage | Which scratches, cuts, burns, dents, broken supports, and repairs should remain visible and archived? |
| PHY-006 | Sound propagation | Which knocks, alarms, collapses, songs, and creature noises should affect adjacent rooms or later encounters? |
| PHY-007 | Smell and scent trails | Where can smoke, food, blood, dampness, rot, oil, or creatures provide clues and consequences? |
| PHY-008 | Looking under, behind, above | Audit hiding places and vertical spaces so signature discoveries do not depend on arbitrary parser guessing. |

---

# BLOCKED / DEPENDENT

| ID | Card | Blocker |
|---|---|---|
| ARC-001 | Full death biography in the house | Wait for house archive data model and presentation surface. |
| ARC-002 | Cross-playthrough death comparisons | Wait for stable playthrough identity and lineage. |
| ARC-003 | “You learned from the last run” exhibits | Wait for knowledge provenance and later-use evidence rules. |
| ARC-004 | NPC memorial records | Wait for house archive event schema and character identity policy. |
| ARC-005 | Region-by-region playthrough map | Wait for exploration signatures and house visualization. |
| ARC-006 | Memorable-event curation | Wait for ranking rules that prevent the archive from recording every ordinary action. |
| ARC-007 | Death counts by semantic family | Wait for DTH-001 and DTH-002. |
| ARC-008 | Repeated-stupidity displays | Wait for semantic equivalence across commands and playthroughs. |
| ARC-009 | Final-world-state exhibit | Wait for RPL-008 and stable state snapshots. |
| ARC-010 | Canonical versus alternate route history | Wait for route identity and canonical-delegation annotations. |
| ARC-011 | House commentary on player conduct | Wait for conduct profiles and narrator boundary rules. |
| ARC-012 | Objects with remembered biographies | Wait for exact-object provenance across theft, loss, damage, repair, and death. |
| ARC-013 | Archive export for graphical frontends | Wait for stable machine-readable IDs and schema versioning. |
| ARC-014 | New Game+ knowledge interfaces | Wait until the archive can distinguish player knowledge from adventurer knowledge without breaking fiction. |

---

# HORIZON

## Epic GUI — Shadowgate-style Glulx presentation

| ID | Card | Future direction | Boundary |
|---|---|---|---|
| GUI-001 | Illustrated room window | Use Glk graphics for a current-location image while preserving parser text. | Presentation layer only. |
| GUI-002 | Clickable hotspots | Map doors, objects, characters, and exits to existing parser actions or structured actions. | Hotspots must not expose hidden nouns automatically. |
| GUI-003 | Verb palette | Offer `LOOK`, `OPEN`, `TAKE`, `USE`, `HIT`, `SPEAK`, and movement in a MacVenture-like interface. | Parser remains available and authoritative. |
| GUI-004 | Graphical inventory | Select real inventory objects for two-object actions. | Must reflect exact containment and object state. |
| GUI-005 | Close-up mechanism scenes | Give the dam panel, ritual materials, locks, and other dense systems focused visual views. | Logic remains in ZIL/Glulx. |
| GUI-006 | State-dependent illustrations | Show damage, water, lighting, missing objects, NPC hostility, and ritual state. | Avoid asset explosion until state schema stabilizes. |
| GUI-007 | Sound and atmosphere | Add ambient loops, effects, music, and selective voice while preserving text-first accessibility. | Never make sound the only required clue. |

## Epic 3D — possible future Great Underground Empire renderer

| ID | Card | Future direction | Boundary |
|---|---|---|---|
| 3D-001 | Stable room/object/actor IDs | Give every meaningful entity a machine-readable identity suitable for external rendering. | Useful even if 3D never happens. |
| 3D-002 | Structured action bridge | Translate renderer interactions into parser-compatible or typed world actions. | Glulx remains authoritative during experiments. |
| 3D-003 | Read-only state export | Expose location, visible objects, exits, mechanism state, lighting, hazards, and NPC disposition. | No debug-only state leaks to players. |
| 3D-004 | Event stream | Emit object moves, damage, sound, light, dialogue, timers, and deaths for a renderer. | Versioned schema required. |
| 3D-005 | First-room prototype | Render one dense location, likely the house exterior or dam lobby, without committing to a full 3D game. | Prototype proves architecture, not production scope. |
| 3D-006 | Separate renderer runtime | Evaluate Godot, another engine, or a custom shell consuming the authoritative world state. | Do not force real-time 3D into Glk. |
| 3D-007 | Save-state compatibility | Determine whether visual state can be reconstructed entirely from authoritative game state after restore. | No parallel renderer save truth. |

---

# DO NOT BUILD AS STATED

| Shortcut | Why it is rejected |
|---|---|
| Randomly kill the player to make Zork dangerous | Danger without causality weakens trust and replayability. |
| Add hundreds of generic death templates | Template volume is not authored wit or semantic precision. |
| Give every object universal weight, fire, fluid, and crafting simulation | This would bury Zork's authored puzzle identity under inconsistent pseudo-physics. |
| Make the thief or troll omniscient | Character escalation must follow perception, motive, access, and remembered treatment. |
| Make every dark room contain a grue colony | The reveal becomes ordinary and destroys the famous ambiguity. |
| Turn grues into routine combat enemies | They should remain an ecological terror and boundary of darkness. |
| Replace canonical puzzles with easier alternate clicks | New routes supplement original solutions and require real setup or risk. |
| Add a morality meter | Conduct should be described through history, not reduced to good/evil points. |
| Let cross-playthrough knowledge automatically solve puzzles | The archive may remember; the current adventurer still has to act. |
| Start full 3D production before stable IDs and state export | That would create an expensive frontend for a moving behavioral target. |
| Treat Glulx file capacity as a reason to fill gigabytes | Asset and story size are not substitutes for coherent interaction. |

---

# Seed moments and tone anchors

These are not final prose and should not be copied mechanically. They preserve the design intent discussed in chat.

- A warning source clearly advised against an action; the player read it, hurried onward, and died from the predicted consequence.
- The player illuminates a grue cavern successfully and discovers that the darkness concealed a colony.
- The troll steals the real sword, later learns enough to use it, and kills the player with his own weapon.
- The thief progresses from amusement to warning, sabotage, ambush, and deliberate execution after sustained provocation.
- A dam fall has different outcomes depending on water state, swimming ability, injury, carried weight, preparation, and available rescue surfaces.
- The narrator's final judgment changes according to what the player could reasonably have known.

Tone anchors:

> The illumination succeeded.

> You were warned.

> At this point, the Great Underground Empire considers the paperwork complete.

> You apparently wished to confirm the warning experimentally.

The important effect is not the exact wording. The game understands the plan, permits it, remembers the evidence, and then explains with absolute confidence why the adventurer is now dead.

# Suggested promotion order — still not beads

1. **Causal death record and warning knowledge model** — foundational semantics before adding dozens of deaths.
2. **Dam fall and drowning train** — strongest bounded environmental demonstration using already deep qualified state.
3. **Troll stolen-weapon train** — proves exact-object enemy memory and player-created danger.
4. **Thief escalation train** — proves relationship deterioration, sabotage, warning, and deliberate retaliation.
5. **Grue colony signature train** — one carefully authored ecosystem and reveal, not broad grue expansion.
6. **Broader death-family trains** — smoke, fire, collapse, machinery, delayed hazards, and self-inflicted folly.
7. **Replay and conduct summaries** — once the house archive and causal records can consume them.
8. **Shadowgate-style interface prototype** — only after action/state boundaries are stable.
9. **3D bridge experiment** — far horizon; architecture probe, not a product commitment.

# Card promotion checklist

A card may become a BEADS train only when all answers are clear:

1. What visible information lets a player reasonably conceive or avoid the outcome?
2. Which canonical objects, routines, flags, timers, and characters remain authoritative?
3. What preparation, timing, positioning, motive, or vulnerability makes the outcome earned?
4. What are the success, failure, escape, and recovery routes?
5. What must persist through `SAVE` and `RESTORE`?
6. What does the current adventurer know, and what belongs only to the house's cross-playthrough archive?
7. How will the narrator explain the consequence in Zork's voice?
8. How will deterministic qualification prove the real production behavior?
9. What tempting generalized system is explicitly outside scope?
10. Does the card make the existing world deeper rather than merely larger?

# Definition of success

This Kanban succeeds when ideas can safely wait here without being forgotten, when related ideas can be shaped into coherent trains instead of scattered patches, and when implementation begins from causal design rather than from a funny death line alone.

The destination is not simply “more ways to die.” It is a Zork that knows what happened, what the player knew, what he ignored, what the world remembered, why the consequence followed, and how this playthrough became different from every other one.
