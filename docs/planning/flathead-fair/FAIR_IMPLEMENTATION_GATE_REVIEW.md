# Flathead Fair implementation gate review

**Status:** GATE CLOSED — PLANNING COHERENT, IMPLEMENTATION NOT AUTHORIZED  
**Review basis:** planning branch after secondary cast, Mara, Lantern Table, Glulx RNG/SAVE semantics, archive graduation and daily-operations consolidation  
**Purpose:** distinguish true remaining product blockers from external dependencies, implementation details and future expansion

## Result

The Flathead Fair planning packet is now coherent enough to define the product and to support a **future implementation-decomposition discussion**.

That is not the same thing as permission to code.

The implementation gate remains **CLOSED** for two independent reasons:

1. Justin's current instruction is explicitly planning-first and does not authorize an implementation train.
2. Important broader Highly Extended Zork dependencies are still outside current `master` / unresolved at this planning frontier.

No implementation beads, code modules, source files or implementation PR stack are authorized by this review.

## What is no longer a global blocker

The following load-bearing product questions are now answered well enough for planning:

- product identity/north star;
- canonical attachment and 16-location geography;
- free admission and zorkmid/ticket boundaries;
- core product identification semantics;
- 20-person named cast shape and knowledge boundaries;
- daily phase/closing model;
- major attraction/game/fishing identity;
- first story web;
- concrete Mara fair preferences/initiative/refusal/competition/memory;
- adult-evening venue/service model;
- contextual privacy model;
- Glulx RNG and player SAVE/RESTORE product contract;
- deterministic qualification direction;
- current Fair Office versus durable House of Records versus personal-memory split;
- archive graduation/retention policy;
- provenance/correction/privacy law;
- canonical non-interference and natural-play acceptance shape.

The plan is therefore no longer in `what even is this fair?` territory.

## A. External dependency blockers

These are not reasons to invent substitute systems inside the fair.

### A1. Release 1307 time/weather authority

At this review frontier, PR #99 remains an independent draft planning/implementation line and is not part of `master`.

The fair already defines **how** authored weather should affect rides, fishing, crowds, food demand, pavilions and NPC/Mara behavior, but it must consume the shipped broader time/weather authority rather than create another engine.

**Gate classification:** DEPENDENCY BLOCKER for full weather/time composition.

### A2. Mara boundary / wardrobe / property authority

At this review frontier, PR #98 remains an independent draft line and is not part of `master`.

The fair has enough character authority to know what Mara likes and how she may initiate/refuse. Exact composition for clothing/weather consequences, independent property/custody behavior and the newest rupture/boundary continuity must consume the broader shipped authority rather than fork it.

**Gate classification:** DEPENDENCY BLOCKER for full Mara/material integration.

### A3. Calendar / aging / true later-fair recurrence

The fair is annual in fiction, but a fake year counter is forbidden.

A later fair should become visible only when broader calendar/aging/world-time authority can honestly make it later.

**Gate classification:** DEPENDENCY BLOCKER for true annual recurrence. It does not invalidate the authored one-day operating model.

### A4. Money-container / custody semantics

Zorkmid prices and ticket/ride-strip boundaries are designed. Exact possession/custody/payment mechanics for the Adventurer, Mara and physical money must use whatever broader money/property authority is ultimately shipped.

**Gate classification:** DEPENDENCY BLOCKER for final transaction implementation, not a reason to redesign fair prices.

## B. Local pre-code product decisions

These questions are small enough that they do not make the fair incoherent, but the affected workstream must resolve them **before its code is written**.

### B1. Final prize redemption catalog

Ticket bands and anti-grind philosophy exist, but `FAIR_REWARDS_PRIZES_AND_COLLECTIBLES.md` is still deliberately thin.

Before Prize Hall implementation, planning must lock:

- an initial concrete redemption catalog;
- exact ticket costs for that catalog;
- which items are also cash-purchasable variants versus prize-only;
- one-time/annual/premium boundaries;
- object identity/persistence expectations for each promoted prize.

**Classification:** LOCAL PRE-CODE BLOCKER — REWARDS/PRIZE HALL.

### B2. Final House of Mirrors anomaly set

The five-node topology and mundane-optics-first rule are stable, and the one-action-late reflection is a valid authored case. The complete initial genuine-anomaly set is not yet locked.

Before House of Mirrors code, decide the small authored list and physical/knowledge consequences.

**Classification:** LOCAL PRE-CODE BLOCKER — HOUSE OF MIRRORS.

### B3. F-04 association adjudication/sanction procedure

The cheating mechanism, evidence path, Kester's role, Berrin/Ada seam and archive-graduation rule are stable. The exact association response after evidence is accepted remains open.

Before F-04 story implementation, lock the possible authored outcomes: warning, booth closure, refund/restitution, permit sanction, equipment seizure/inspection, unresolved appeal, or another bounded procedure.

**Classification:** LOCAL PRE-CODE BLOCKER — F-04 STORY.

### B4. Attraction ownership/operator provenance

Current operators and operating behavior are clear, but final association/Frobozz/independent ownership of every major attraction is not fully assigned.

This matters for permits, dialogue, historical records and responsibility when something closes or fails.

**Classification:** LOCAL PRE-CODE BLOCKER for attraction provenance/records, not for basic geography.

### B5. Multi-day fair count if first implementation promises multiple public days

The nine-phase operating day is stable. The exact number of public days per annual fair is not.

If a future first implementation program intends to simulate more than one public fair day, planning must lock that count and what resets/carries between days.

If broader calendar authority makes multi-day progression impossible or dishonest at that time, do not fake it.

**Classification:** CONDITIONAL LOCAL/DEPENDENCY BLOCKER.

## C. Implementation details — not product blockers

These should be decided inside a future authorized implementation program without reopening product behavior:

- exact ZIL globals/tables/object layouts for committed RNG outcomes;
- exact helper routine names;
- exact parser syntax aliases beyond already-required natural intents;
- exact archival transfer tick after legitimate closeout;
- exact storage layout for current office records;
- exact movement/path representation for NPC transitions;
- exact wheel carriage count unless a mechanic truly needs the number;
- exact clock-hour mapping of semantic phases;
- exact deterministic fixture seed values;
- exact qualification transcript files and artifact hashes;
- exact code-module boundaries.

Do not convert ordinary implementation detail into another months-long product-design loop.

## D. Future expansion — explicitly not required to open the first implementation program

These may be authored later unless a specific implementation organ proves it needs them:

- pompous formal fair title;
- additional opening/closing traditions;
- extra rides beyond the locked initial roster;
- extra House of Mirrors anomalies beyond the final small initial set;
- transient vendor/performer identities;
- dedicated constable/safety NPC absent a real authority gap;
- additional signature foods/yearly limited products;
- premium special performances;
- deep long-horizon Lysa/Tavin relationship arc;
- large annual collectible catalogs;
- universal fishing/economy/carnival engines, which remain out of scope anyway.

## E. Documents now mature enough for the global planning gate

The following load-bearing authorities can be treated as stable enough for **planning coherence**:

- `FAIR_PRODUCT_BIBLE.md`;
- `FAIR_NAME_AND_LORE.md`;
- `FAIR_SITE_SELECTION.md`;
- `FAIR_GEOGRAPHY.md`;
- `FAIR_DAILY_OPERATIONS.md`;
- `FAIR_PRODUCTS_AND_ZORKMID_ECONOMY.md`;
- `FAIR_PRODUCT_KNOWLEDGE_AND_QUESTIONS.md`;
- `FAIR_NPC_ROSTER.md` + `FAIR_SECONDARY_CAST.md`;
- `FAIR_MARA_EXPERIENCE.md`;
- `FAIR_ADULT_SOCIAL_ROMANCE_AND_INTIMACY.md`;
- `FAIR_RNG_CONTRACT.md`;
- `FAIR_PERSISTENCE_AND_MEMORY.md`;
- `FAIR_HALL_OF_RECORDS_INTEGRATION.md`;
- `FAIR_NATURAL_PLAY_ACCEPTANCE.md`.

`STABLE FOR PLANNING` means the product rule is defined well enough not to keep redesigning it casually. It does not claim the source code exists or that dependencies have landed.

## F. Documents that remain legitimately designing

These can remain designing without invalidating the global product definition, provided their local blockers are respected:

- `FAIR_PRICE_BOOK.md` — most prices are concrete; remaining adjustments/catalog coupling are local;
- `FAIR_REWARDS_PRIZES_AND_COLLECTIBLES.md` — requires concrete initial catalog before Prize Hall code;
- `FAIR_ATTRACTIONS_CATALOG.md` — final ownership/anomaly details remain local;
- `FAIR_VENDOR_AND_COMMERCE_DESIGN.md` — final merchant edge cases compose broader money authority;
- `FAIR_WEATHER_AND_ENVIRONMENT.md` — waits on Release 1307 rather than building another weather system;
- `FAIR_DIALOGUE_AND_CONTEXTUAL_KNOWLEDGE.md` — prose/coverage can deepen without changing bounded-knowledge law.

## Future implementation-decomposition shape — NOT STARTED

When Justin explicitly authorizes moving beyond planning and the relevant dependencies have landed, the fair is large enough that it should be decomposed into product organs rather than one mega-commit.

This review intentionally does **not** create those trains/beads, branch names or code ownership maps yet.

That restraint is part of the gate.

## Gate reopening conditions

The implementation gate can be reviewed again when:

1. Justin explicitly authorizes moving from planning into implementation preparation or implementation;
2. live GitHub is re-queried first;
3. required dependency state on `master` is re-established rather than assumed from this document;
4. the affected local pre-code blocker is resolved before that workstream begins;
5. no fair branch is stacked accidentally on independent #98/#99 history unless their work has legitimately merged to the chosen base.

## Final gate statement

**Product planning coherence:** PASS  
**External dependency readiness:** NOT YET  
**Local workstream planning completeness:** MIXED / EXPLICITLY CATALOGED  
**Justin implementation authorization:** NO  
**Implementation gate:** **CLOSED**

That is a successful planning result. The fair is now bounded enough to stop endlessly re-litigating its identity while still refusing to code ahead of its dependencies and unresolved local product decisions.
