# Flathead Fair ↔ Hall of Records integration

**Status:** STABLE FOR PLANNING  
**Decision:** the Flathead Fair reuses the existing upstairs/Attic House of Records authority instead of creating a second historical archive.

## Existing authority

Highly Extended Zork already has a substantial archive organ under `glulx/`:

- `attic-archive-core/` — parser-visible physical archive surface;
- `attic-area-case-files/` — physical case files with provenance, verification/confidence, contradiction and redaction semantics;
- `attic-npc-dossiers/` — durable NPC-oriented documentary records;
- `attic-playback/` — playback/review authority where a record supports it;
- `completed-expedition-archive/` — explicitly the House of Records capstone for durable completed-expedition evidence.

The fair must compose those authorities. It must not invent a competing `FairHistoryDatabase`, detached archive menu, or omniscient records NPC.

## Three record layers

### 1. Fair Office: current operational records

The fair's local office handles **current-event administration**, including:

- current fair schedule/program;
- current-year concession list and permits;
- contest/derby entries and current results;
- current prize/redemption procedures;
- current lost-and-found intake;
- current incident/complaint intake;
- current grounds maps and handbills;
- current weather/closure notices;
- current staff-facing paperwork.

These records are useful now. They do not make the Fair Office the master historical archive.

### 2. House of Records upstairs: durable documentary history

Selected records can graduate into the existing House of Records when they become historically/documentarily meaningful.

Candidate archival materials include:

- annual fair programs;
- historical grounds maps;
- fishing-derby registers and major records;
- major contest/competition ledgers;
- ribbons/trophy/record evidence where existing archive semantics support it;
- concession rolls and historically meaningful permits;
- adjudicated/significant incident reports;
- attraction retirement/replacement records;
- notable vendor or association records;
- annual results;
- historically useful menus, price sheets, advertisements and handbills.

These should become physical folders/cards/records using the existing archive conventions rather than invisible flags or a universal history UI.

### 3. Personal memory: lived history

Personal memories remain distinct from institutional records.

Examples:

- Mara remembering a wheel ride;
- the Adventurer and Mara arguing about who ate most of an elephant ear;
- a vendor remembering a repeat customer;
- Ephraim remembering how the fair used to look;
- private conversations, affection or arguments.

Those facts do **not** automatically become House of Records material.

A private relationship event only enters documentary history if an independent public/documentary fact genuinely exists, and even then the record stores that documentary fact rather than mind-reading the participants.

## Provenance law

The archive must preserve **who or what claims a fact**.

The following may disagree without the game flattening them into one magic truth:

- a current official fair pamphlet;
- an old archived program;
- Ada Vellum's current ledger;
- Ephraim Peake's memory;
- a Frobozz promotional history;
- a witness statement;
- a physical token/sign/object;
- an adjudicated association report.

Use the existing House of Records provenance, confidence/verification, contradiction and redaction semantics where they fit.

`THE ARCHIVE SAYS X` is not enough when the actual state is `an archived program printed X, while another source claims Y`.

## Ada Vellum's institutional seam

Ada is the **current fair registrar / office clerk**, not the keeper of all fair history.

She handles:

- current entries/results;
- current permits and concession paperwork;
- current lost-and-found;
- current incident intake;
- current programs/maps;
- authorized extracts/copies of current office records;
- transfer/filing preparation for records that are destined for the House of Records.

Ada may know that an older record exists upstairs and can direct the Adventurer there. She does not remotely summon the old file or replace the physical archive.

Her dry precision remains useful: she can notice that a current Frobozz pamphlet conflicts with older wording without pretending she personally remembers the historical event.

## Fair Office room identity

The fairground location formerly called **Prize & Records Hall** is renamed:

**Fair Office & Prize Hall**

It combines two current-service functions:

- **Ada Vellum:** current administration, records intake, lost-and-found, entries/results, complaints;
- **Nell Harrow:** current prize-ticket redemption and prize stock.

The name deliberately avoids colliding with the upstairs Hall/House of Records.

## Story integration

### F-03 — historical-date dispute

This becomes a first-class archive/provenance story:

1. Ephraim claims the current fair-history date is wrong.
2. Ada can show/explain what the **current fair office copy** says.
3. An older physical program, map or case file may exist upstairs in the House of Records.
4. Frobozz material may use a different date.
5. The player can compare sources rather than ask Ada for omniscient truth.

Possible result: the discrepancy is resolved, partially explained, or remains a documented contradiction.

### F-09 — old pond token

The physical token can be cross-referenced against:

- archived site maps;
- old programs;
- concession rolls;
- earlier fair records;
- Ephraim's memory;
- Vera's material/provenance opinion.

The House of Records supplies documentary context, not magical item identification.

### F-04 — shell-game cheating

A current complaint/evidence trail begins at the Fair Office. If the association adjudicates a meaningful incident, the resulting report can later become a durable House of Records receipt.

### Retired/replaced attractions

Old grounds maps, programs and association records can establish that an attraction formerly stood somewhere else, changed ownership, was rebuilt, or disappeared.

This gives later annual fairs historical depth without procedural lore generation.

## Archive graduation law

Not every piece of fair paperwork deserves permanent archival status.

Candidate rules:

1. **Routine and temporary** material can expire/reset according to ordinary fair administration.
2. **Official annual summaries/results** are strong archive candidates.
3. **Historically significant incidents/changes** are strong archive candidates.
4. **Private memories** do not graduate automatically.
5. **Physical evidence** keeps its provenance; filing a description of an object does not replace the object itself.
6. **Contradictory evidence** remains contradictory until supported evidence actually resolves it.

The exact transfer timing can remain implementation-dependent, but the institutional boundary is stable.

## Parser/use boundary

The fair should benefit from existing archive interaction concepts such as physical records, `FILE`, `REVIEW`, `SHOW`, `CROSSREF` and indexed retrieval where those authorities already support them.

Do not duplicate those verbs or invent a fair-only records language.

The Fair Office may create/intake current material. The House of Records is where durable historical research happens.

## Privacy boundary

The archive is not surveillance.

It does not automatically record:

- private Mara/Adventurer conversations;
- kisses/affection;
- private arguments;
- unreported thoughts/preferences;
- every purchase simply because it happened;
- every NPC movement.

A public contest result, permit, report or purchased commemorative item may have documentary evidence. A private lived moment remains memory.

## Qualification implications

Future natural-play qualification should eventually prove:

- Ada answers a current-year/current-fair records question locally;
- an older historical question points to the upstairs archive instead of being answered magically;
- a physical archived record can be reviewed/cross-referenced through existing archive authority;
- conflicting sources preserve provenance;
- a significant current fair incident can produce a later durable record only through an authored filing/adjudication path;
- Mara's private memories do not leak into institutional records.

## Boundary

This integration is planning only. It authorizes reuse/composition of the existing Hall/House of Records when the fair is eventually implemented; it does not authorize a fair implementation train or a new archive train.
