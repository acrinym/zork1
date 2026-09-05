# Flathead Fair persistence and memory

**Status:** STABLE FOR PLANNING  
**Archive seam:** existing upstairs Hall/House of Records remains the durable documentary authority

## Persistence layers

### Same visit

Purchases, eaten food, won prizes, broken records, conversations, fish catches, ride state, current office paperwork and incidents remain coherent through the visit.

### Same fair

Daily records, vendor familiarity, contest outcomes, stock depletion where meaningful, current lost-and-found, incident intake and unresolved mini-stories may carry across fair days.

### Later fair

Selected long-term facts can persist:

- important competition/derby records;
- trophies/ribbons/prizes still owned;
- gifts given to Mara;
- recurring vendor relationships;
- notable public incidents;
- Mara shared memories;
- prior winners;
- collectible-year items;
- NPC life changes;
- replaced/retired attractions where authored.

Long-term persistence is not one storage bucket. Documentary history and lived memory remain distinct.

## Three persistence authorities

### Fair Office: current operational state

The Fair Office & Prize Hall handles current-event records such as:

- schedules/programs;
- current permits and concession rolls;
- current contest/derby entries and results;
- current lost-and-found;
- current incident/complaint intake;
- current grounds maps/notices.

This state may remain live through the fair and can be closed out afterward. It is not the durable historical archive.

### House of Records upstairs: documentary history

Historically meaningful fair material composes the existing archive organ under:

- `glulx/attic-archive-core/`;
- `glulx/attic-area-case-files/`;
- `glulx/attic-npc-dossiers/` where appropriate;
- `glulx/attic-playback/` where supported;
- `glulx/completed-expedition-archive/` / House of Records capstone.

Archive candidates include annual programs, historical maps, major results, fishing/competition registers, historically meaningful concession records, attraction changes and significant adjudicated incident reports.

The archive retains physical/provenance-bearing records rather than reducing history to a detached `PAST FAIR` menu.

### Personal memory: lived continuity

Mara, the Adventurer and NPCs can remember semantic lived events:

- first fair together;
- elephant-ear dispute;
- a wheel ride;
- a dance/song;
- a ridiculous game failure;
- a fish/record;
- a vendor interaction;
- a storm or closing-night memory.

Those memories are not automatically documentary records.

`Mara remembers the elephant-ear dispute` is legitimate semantic memory. `The House of Records contains a transcript of their private conversation` is not legitimate unless an independent authored recording/documentary fact actually exists.

## Provenance and contradiction

Fair history can have multiple evidence sources:

- current fair-office copy;
- old archived program;
- physical token/sign/object;
- Frobozz promotional history;
- Ephraim's lived memory;
- witness statement;
- association incident report.

Persistence preserves the **source of the claim**.

If two sources disagree, the contradiction persists until actual evidence resolves or explains it. Do not silently rewrite both into one `TRUE DATE` flag.

Use the existing archive provenance, confidence/verification, contradiction and redaction semantics where they fit.

## Archive graduation

Not all fair paperwork is permanent.

Working classification:

### Usually temporary/current
- ordinary daily handbills;
- routine stock sheets;
- mundane cleanup notes;
- disposable queue/service paperwork;
- minor complaints with no later significance.

### Strong durable candidates
- annual official program/summary;
- major contest/derby results and standing records;
- historical grounds maps;
- attraction opening/retirement/replacement records;
- significant concession/history changes;
- adjudicated meaningful incidents;
- unusual documentary evidence tied to a lasting fair-history question.

Exact transfer timing is implementation-dependent, but the institutional boundary is stable.

## Physical object continuity

Archive records do not replace the things they describe.

Examples:

- an old pond token remains the physical token even if a file documents its markings;
- a stuffed grue remains the actual prize/gift object;
- a ribbon/trophy remains physical property even when a result ledger records the win;
- a historical program is itself a physical source, not merely a flag saying it once existed.

## Memory quality

Persistence must refer to semantic events, not raw transcript strings.

Good:

- `MARA_REMEMBERS_FIRST_WHEEL_RIDE`
- `MABEL_RECOGNIZES_REPEAT_CUSTOMER`
- `FAIR_RECORD_FISH_WEIGHT_HELD_BY_X`
- provenance-bearing archived program dated/claimed by a particular source

Bad:

- storing every line spoken at Food Row as memory;
- making the archive a transcript of private life;
- reducing contradictory history to an unexplained boolean.

## Change over time

The fair can become emotionally meaningful because it returns while people, records and objects change.

A vendor may retire. A child may be older. A ride may be replaced. A record may still stand. An old map upstairs may show a booth or attraction that no longer exists. Ephraim may remember the change differently from the paperwork.

That tension is a feature when provenance is preserved.

## Privacy law

Institutional persistence does not imply surveillance.

Do not automatically archive:

- private Mara/Adventurer affection;
- private conversations;
- unreported arguments;
- internal preferences/thoughts;
- every purchase;
- every NPC movement;
- every incidental fair interaction.

Public results, permits, reports and documentary artifacts may persist institutionally. Personal experience persists through personal memory authority.

## Reset boundaries

Not everything persists. Disposable stock, crowd composition, minor incidents, ordinary food, temporary decoration and routine administrative noise can reset according to fair lifecycle.

The persistence plan must explicitly classify each system before implementation.

See `FAIR_HALL_OF_RECORDS_INTEGRATION.md` for the institutional archive boundary.
