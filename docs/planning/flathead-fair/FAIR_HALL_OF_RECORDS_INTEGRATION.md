# Flathead Fair ↔ Hall of Records integration

**Status:** STABLE FOR PLANNING  
**Decision:** the Flathead Fair reuses the existing upstairs/Attic House of Records authority instead of creating a second historical archive.  
**Graduation policy:** LOCKED FOR PLANNING

## Existing authority

Highly Extended Zork already has a substantial archive organ under `glulx/`:

- `attic-archive-core/` — parser-visible physical archive surface;
- `attic-area-case-files/` — physical case files with provenance, verification/confidence, contradiction and redaction semantics;
- `attic-npc-dossiers/` — durable NPC-oriented documentary records;
- `attic-playback/` — playback/review authority where a record supports it;
- `completed-expedition-archive/` — explicitly the House of Records capstone for durable completed-expedition evidence.

The fair composes those authorities. It does not invent a `FairHistoryDatabase`, detached archive menu, second records hall, omniscient records NPC or private-life surveillance feed.

## Three record layers

### 1. Fair Office: current operational records

The Fair Office & Prize Hall handles current-fair administration:

- current program/schedule;
- current concession roll and permits;
- contest/derby entries and results;
- prize/redemption procedures;
- lost-and-found intake;
- complaint/incident intake;
- grounds maps and handbills;
- weather/closure notices;
- staff-facing working paperwork.

This layer is allowed to be messy, provisional, corrected and temporary. It is the desk where the current fair is actually administered.

### 2. House of Records upstairs: durable documentary history

Selected records graduate only after they become historically/documentarily meaningful.

The durable layer preserves evidence about what the fair **was**, what officially happened, what materially changed and which claims remain disputed.

### 3. Personal memory: lived history

Mara, the Adventurer and NPCs may remember semantic lived experience.

Examples:

- a wheel ride;
- an elephant-ear dispute;
- who won a private challenge;
- a dance/song;
- a conversation after the derby;
- Ephraim's recollection of an older fair.

Personal memory is not automatically an institutional record.

## Graduation principle

**The House of Records preserves historical signal, not administrative exhaust.**

A record graduates because at least one of these is true:

1. it is the official annual/cycle summary of a public institution or competition;
2. it establishes or changes a standing public record;
3. it documents a material change to fair geography, attraction identity, ownership, association rules or concession history;
4. it is a formally adjudicated incident with lasting consequence, precedent or unresolved documentary significance;
5. it bears important provenance for an object/place/story already significant to fair history;
6. it preserves a historically useful issued artifact such as an official program or grounds map.

`It existed on Ada's desk` is not sufficient reason for permanent archival status.

## Closeout and transfer lifecycle

The planning-level lifecycle is now locked:

### During the fair

Current material remains under Fair Office authority.

Ada may correct, annotate, receive statements, verify results and prepare likely archival candidates, but the active working file remains current-office material.

### At fair closeout

After public operation ends and the relevant results/incidents have reached their official current status, Ada prepares a **closeout transfer packet** containing only archival candidates.

This does not require the transfer to happen at one magic CLOSING tick. Staff can complete closeout during legitimate post-public administrative time.

### After adjudication where required

A disputed result or incident does not graduate as settled truth merely because the fair ended.

If adjudication remains open:

- the current file can remain pending;
- a durable file may later preserve the dispute as unresolved if the unresolved dispute itself becomes historically significant;
- any later ruling is appended with provenance rather than silently rewriting earlier evidence.

### House of Records intake

The existing House of Records receives the durable material through its own filing/review authority.

The fair does not need to simulate courier logistics or invent a global year counter. The product requirement is simply that durable history appears only after a legitimate closeout/filing path, not instant omniscient synchronization.

## Graduation matrix

### Official annual program — DURABLE

Preserve one issued/final official program for each authored fair cycle that becomes historically accessible.

Materially different corrected editions may both survive when the difference itself matters. Tiny typo-only working drafts need not.

### Historical grounds map — DURABLE

Preserve an official map when it documents the fair's actual layout for that cycle or a meaningful geography change.

This is especially important when attractions later move, retire, expand or disappear.

### Annual public results summary — DURABLE

Preserve a concise official summary of the fair's meaningful public competition/exhibition results.

This summary may include:

- derby winner;
- featured contest winners;
- exhibition/judging winners;
- standing-record changes;
- notable race-series result if the race board has an official annual championship/history role.

It should **not** contain every paid booth attempt.

### Ring Stand ordinary attempts — CURRENT/TEMPORARY

Routine throws and ordinary ticket awards remain booth/current-office state.

A clean sweep may enter the current results board. It graduates only if it becomes a featured annual result or changes a standing fair record.

### Bottle Knockdown — USUALLY TEMPORARY

Ordinary clears and efficient clears do not need durable history.

A specifically authored championship/standing-record case may graduate through the annual results summary.

### Bell Striker — STANDING-RECORD CHANGES DURABLE

The current fair can track best results.

Durable history records:

- the annual featured winner where officially recognized;
- a new standing fair record;
- later correction/overturn of that standing record.

It does not preserve every strike.

### Clockwork Target Gallery — STANDING-RECORD CHANGES DURABLE

Daily/current high scores remain Fair Office/current attraction state.

Annual winner and any new standing record can graduate.

### Horseshoes / Ringed Stakes — FEATURED MATCHES DURABLE

Casual paid rounds are temporary.

Named/scheduled featured matches, annual finals and standing records can enter the annual public-results summary.

### What's Missing? — USUALLY TEMPORARY

Ordinary memory-table rounds are ephemeral fair play.

Only a specifically authored featured championship/perfect annual result needs durable treatment.

### Shell / Cup Game — INCIDENT-DRIVEN

Ordinary rounds are not historical records.

F-04 can graduate only through a real current incident/adjudication path.

A durable case is warranted when the adjudication has lasting significance, for example:

- sanction/suspension of Kester Vane's booth;
- a permit consequence;
- documented restitution/refund policy;
- rule/equipment standard change;
- significant unresolved contradiction preserved as a case.

A single unsupported complaint is not automatically a permanent case file.

### Clockwork Critter Race — OFFICIAL SERIES RESULTS DURABLE, ROUTINE HEATS CURRENT

Individual ordinary heats may remain current/routine unless the race board itself treats them as part of an official series.

Durable material should prefer:

- annual series/championship result;
- standing record or unusual officially recognized result;
- adjudicated race incident if historically significant.

Betting slips, if broader gambling authority ever exists, are not automatically historical records.

## Fishing graduation

### Ordinary catch — PERSONAL/CURRENT

A normal fish caught for recreation is not House of Records material.

Silas may know or verify it in current context, and the Adventurer/Mara/Cassa may remember it.

### Derby entry/weigh-in sheet — CURRENT

Routine entry and weigh-in paperwork remains Fair Office/current derby administration during the fair.

### Derby winner — DURABLE

The official derby winner belongs in the annual public-results summary.

### Standing-record fish — DURABLE

A verified specimen that sets a standing species/overall fair record graduates with:

- species;
- verified measurement(s) actually used by fair authority;
- angler identity if public under the contest rules;
- Silas's verification/current result provenance;
- correction history if later overturned.

The record does not replace the physical fish, trophy, ribbon or personal memory.

### Record-class specimen that does not win — CONDITIONAL

If the fair officially recognizes species records or exceptional verified specimens, that result may graduate even without overall derby victory.

If it is merely `a very large fish somebody caught`, personal memory/current paperwork is enough.

## Exhibition graduation

Durable annual history may include:

- judged class winners;
- best-of-fair/featured award;
- new standing exhibition record where such a category exists;
- a historically significant object/provenance case.

Routine entry forms, losing entries and ordinary judging notes remain current unless later evidence makes a specific item historically important.

## Concessions and commerce

### Annual concession roll — DURABLE

A concise official list of participating concessions/vendors is historically useful because it documents who was present and how the institution changed.

### Routine individual permit paperwork — CURRENT

Do not archive every duplicate form and renewal merely because paper existed.

A permit becomes durable when it documents a meaningful first/last year, ownership transfer, sanction, unusual concession right or other historical change.

### Menus and price sheets — SELECTIVE DURABLE SAMPLES

Historically useful official/menu artifacts may be preserved when they establish meaningful price/product history or a story/provenance question.

Do not archive every daily stock sheet, correction scrap or sold-out note.

### Purchases — PRIVATE/TRANSIENT BY DEFAULT

The House of Records does not contain a ledger of everything the Adventurer, Mara or ordinary visitors bought.

## Attraction history

The following are strong durable candidates:

- opening/introduction of a major attraction;
- relocation on the grounds;
- major rebuild;
- retirement/removal;
- ownership/operator transfer when institutionally meaningful;
- safety-related permanent modification after adjudicated evidence;
- historically important closure/reopening.

Routine ride cycles, queue counts and temporary maintenance notes do not graduate.

Hettie Bramm's maintenance finding becomes durable only when it bears on a lasting attraction-history or significant incident file.

## Weather and closures

Routine weather notices are current operational material.

Durable annual history may mention weather when it materially changed the fair, for example:

- a major wind closure of a signature attraction;
- significant rain relocation affecting the program;
- a closure that caused lasting schedule/grounds/attraction consequences.

`It rained for an hour` does not require a permanent case file.

## Lost and found

Ordinary lost-and-found intake expires/returns under current-office authority.

It does not graduate merely because an item was lost.

A lost object may become a historical/provenance case only when the **object itself** proves significant for a separate reason, and privacy-sensitive owner information should not be preserved beyond what the documentary purpose actually requires.

## Incident graduation

A complaint is not the same thing as a finding.

Durable case files should preserve the evidence chain:

1. complaint/intake provenance;
2. physical evidence or witness statements actually supplied;
3. operator/association response;
4. verification/confidence status;
5. contradiction/redaction where applicable;
6. adjudication or explicit unresolved status;
7. lasting consequence if one occurred.

Strong durable candidates include:

- F-04 if cheating is formally established/sanctioned or remains a significant unresolved dispute;
- a major attraction safety incident that causes lasting operational change;
- a provenance dispute central to fair history;
- significant fraud, ownership or rules controversy.

Minor complaints, queue arguments and ordinary customer dissatisfaction remain current/routine.

## Corrections, reversals and contested records

The archive never silently rewrites history.

If a result is corrected, disqualified, overturned or remeasured:

- retain the original claim/result with its source;
- attach the correcting authority/evidence;
- mark the prior result as superseded, disqualified, disputed or corrected as appropriate;
- make `CROSSREF`/review capable of exposing the relationship where existing archive authority supports it.

Example:

`Ada's closing result sheet listed X; the later adjudication disqualified X after equipment evidence; the official annual summary lists Y.`

That is better than mutating one boolean into `Y WAS ALWAYS THE WINNER`.

## F-03 — Ephraim says the date is wrong

The story remains a first-class provenance conflict:

1. Ephraim makes a lived-memory claim.
2. Ada exposes the current office wording/source.
3. an older physical program/map/file may exist upstairs;
4. Frobozz promotional material may make another claim;
5. the player compares evidence rather than querying an omniscient truth service.

The result may resolve the discrepancy, explain why sources use different dates, or preserve a documented contradiction.

## F-09 — the pond gives back something old

The old stamped token can be cross-referenced against:

- historical maps;
- annual programs;
- concession rolls;
- old price/product material;
- Ephraim's memory;
- Vera/Sella material observations;
- other physical provenance evidence.

The House of Records supplies documentary context, not magical item identification.

## Ada Vellum's institutional seam

Ada handles:

- current entries/results;
- permits/concession paperwork;
- lost-and-found;
- incident intake;
- current programs/maps;
- authorized extracts/copies;
- closeout preparation and transfer candidate labeling.

She can say an older file exists upstairs and direct the Adventurer there. She does not remotely summon old documents or become the master historian.

## Existing archive verbs/concepts

Reuse existing authority where appropriate:

- physical records;
- `FILE`;
- `REVIEW`;
- `SHOW`;
- `CROSSREF`;
- provenance;
- confidence/verification;
- contradiction;
- redaction.

Do not create fair-only equivalents.

## Attic playback boundary

`attic-playback` is reused only where its existing authority genuinely supports a documentary record.

Do not use playback to reconstruct:

- private Mara conversations;
- unrecorded kisses/arguments;
- every game attempt;
- every NPC movement;
- guessed events from a result sheet.

A document proving `Mara won the derby` does not imply a surveillance replay of what she said afterward.

## NPC-dossier boundary

Fair attendance alone does not cause a permanent dossier.

A durable NPC-oriented record is justified only when existing dossier authority and actual documentary significance support it, such as a notable official role, adjudicated case or historically important association record.

Pella Wren winning a prize does not automatically create `PELLA WREN DOSSIER`.

## Physical evidence law

A file about an object does not replace the object.

- old pond token remains physical;
- ribbon/trophy remains property;
- historical program is itself a physical source;
- sanction report can describe the tack-wax cup but does not make the cup cease to matter as evidence.

## Privacy boundary

Do not automatically archive:

- private Mara/Adventurer conversations;
- affection;
- private arguments;
- thoughts/preferences;
- every purchase;
- every visitor movement;
- private meaning attached to a public result.

A public result can be documented. The lived experience around it remains personal memory.

## Qualification implications

Future natural-play qualification should eventually prove:

- Ada answers a current-fair question locally;
- an older historical question points upstairs rather than being answered magically;
- a routine booth attempt remains routine and does not create permanent history;
- a standing record/annual winner can graduate through closeout;
- a significant adjudicated incident can produce a durable case;
- corrections preserve old and new claims with provenance;
- a physical archived record can be reviewed/cross-referenced through existing authority;
- Mara's private memories do not leak into records.

## Boundary

This is planning authority only. It authorizes reuse/composition of the existing House of Records when the fair is eventually implemented. It does **not** authorize a fair implementation train or a new archive train.
