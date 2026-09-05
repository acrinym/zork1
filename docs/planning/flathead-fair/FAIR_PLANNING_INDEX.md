# Flathead Fair planning index

**Status:** STABLE PRODUCT PLAN / GATE CLOSED  
**Public name:** **Flathead Fair** — LOCKED  
**Scope:** product planning only; no implementation train is authorized by this packet  
**Base frontier at this review:** `master` at `767364f6b1de5ff45278f8f0d66508524e3f9b19`

## Product state

The Flathead Fair is now coherent enough to stop re-litigating its basic identity. It remains a recurring, dense, parser-first recreational world organ that is optional to canonical Zork completion.

Stable planning now includes:

- additive northeast attachment from canonical `CLEARING`;
- persistent 16-location fairground mesh;
- free admission, zorkmid commerce and separate prize-ticket economy;
- parser-real products and partial player knowledge;
- 20 substantial named NPCs with bounded knowledge;
- nine-phase daily operation and sequential closing;
- Observation Wheel, Carousel, Flying Chairs, Scenic GUE ride and five-node House of Mirrors;
- eight mechanically distinct initial Games Row activities;
- full optional fishing/derby organ;
- nine-story initial incident web;
- concrete Mara preferences, initiative, refusals, competition and semantic memory;
- **The Lantern Table** inside Dance Pavilion for adult evening food/drink/social life;
- runtime-grounded Glulx RNG/SAVE contract;
- current Fair Office vs durable House of Records vs personal-memory separation;
- locked archival graduation/correction/privacy policy;
- stable future natural-play acceptance contract.

Hard boundaries remain unchanged: no implementation yet, no duplicate archive, no GUI, no generic fair generator, no generated-content soup, no canonical RNG gates, no romance vending machine, no omniscient NPCs, no automatic private-life archival, no grind treadmill, and no Gato. 🤣

## Authority map

| Document | Status | Owns |
|---|---|---|
| `FAIR_PRODUCT_BIBLE.md` | STABLE FOR PLANNING | North star, identity, boundaries, mature product contract |
| `FAIR_NAME_AND_LORE.md` | STABLE FOR PLANNING | Public name, regional origin, governance/Frobozz relationship |
| `FAIR_SITE_SELECTION.md` | LOCKED FOR PLANNING | Canonical map evidence and attachment seam |
| `FAIR_GEOGRAPHY.md` | STABLE FOR PLANNING | 16-location graph, Fair Office & Prize Hall, movement/privacy/service topology |
| `FAIR_DAILY_OPERATIONS.md` | STABLE FOR PLANNING | phase operation, Tomas/Lantern transition, schedules, closing/after-hours |
| `FAIR_TIME_SCHEDULE_AND_SEASON.md` | STABLE FOR PLANNING | annual-fiction recurrence and semantic daily lifecycle |
| `FAIR_PRODUCTS_AND_ZORKMID_ECONOMY.md` | STABLE FOR PLANNING | free admission, currency/product laws |
| `FAIR_PRICE_BOOK.md` | DESIGNING | concrete prices and redemption bands |
| `FAIR_PRODUCT_KNOWLEDGE_AND_QUESTIONS.md` | STABLE FOR PLANNING | partial identification and contextual questions |
| `FAIR_VENDOR_AND_COMMERCE_DESIGN.md` | DESIGNING | merchant seams and broader money-authority composition |
| `FAIR_ATTRACTIONS_CATALOG.md` | DESIGNING | rides/destinations; final ownership/anomaly details still local blockers |
| `FAIR_GAMES_COMPETITIONS_AND_RECORDS.md` | STABLE FOR INITIAL GAMES PLANNING | mechanically distinct games, current records, contest boundaries |
| `FAIR_FISHING.md` | STABLE FOR INITIAL FISHING PLANNING | hobby, derby, fish/junk/record semantics |
| `FAIR_RNG_CONTRACT.md` | STABLE FOR PLANNING | Glulx SAVE/RNG semantics, commitment boundaries, deterministic qualification |
| `FAIR_NPC_ROSTER.md` | STABLE FOR INITIAL CORE PLANNING | 12 core people |
| `FAIR_SECONDARY_CAST.md` | STABLE FOR PLANNING | 8 secondary people and story/system bindings |
| `FAIR_DIALOGUE_AND_CONTEXTUAL_KNOWLEDGE.md` | DESIGNING | dialogue coverage under already-locked bounded-knowledge law |
| `FAIR_MARA_EXPERIENCE.md` | STABLE FOR PLANNING | Mara preferences, initiative, refusal, competition, memory |
| `FAIR_ADULT_SOCIAL_ROMANCE_AND_INTIMACY.md` | STABLE FOR PLANNING | Lantern Table, adult social topology, contextual privacy |
| `FAIR_FOOD_AND_CONCESSIONS.md` | STABLE FOR PLANNING | food/drink product identity |
| `FAIR_MINIQUESTS_INCIDENTS_AND_RUMORS.md` | STABLE FOR FIRST STORY-WEB PLANNING | nine initial stories/incidents |
| `FAIR_REWARDS_PRIZES_AND_COLLECTIBLES.md` | DESIGNING | concrete initial redemption catalog still needed before Prize Hall code |
| `FAIR_PERSISTENCE_AND_MEMORY.md` | STABLE FOR PLANNING | persistence-layer separation |
| `FAIR_HALL_OF_RECORDS_INTEGRATION.md` | STABLE; GRADUATION LOCKED | existing archive reuse, retention, provenance, corrections, privacy |
| `FAIR_WEATHER_AND_ENVIRONMENT.md` | DESIGNING / DEPENDENCY-BOUND | consumes Release 1307 rather than inventing another weather engine |
| `FAIR_NATURAL_PLAY_ACCEPTANCE.md` | STABLE FOR PLANNING | future natural-play qualification contract |
| `FAIR_IMPLEMENTATION_GATE_REVIEW.md` | GATE CLOSED | blockers/dependencies/details/future-expansion classification |
| `FAIR_OPEN_QUESTIONS.md` | OPEN | only genuinely unresolved planning items |

## Runtime RNG fact consumed by planning

The active Highly Extended Glulx lineage targets Glulx 3.1.3 and pins Glulxe `56ab8743bab565de307bd892c555d8d8897ed517` for native qualification.

Player-managed SAVE/RESTORE does not rewind the interpreter RNG. The fair therefore commits already-real random outcomes into ordinary saveable story state and does not globally reseed production RNG. Deterministic qualification can use pinned Glulxe `--rngseed`.

## House of Records boundary

The fair reuses:

- `glulx/attic-archive-core/`;
- `glulx/attic-area-case-files/`;
- `glulx/attic-npc-dossiers/` only where genuinely justified;
- `glulx/attic-playback/` only where existing documentary authority supports it;
- `glulx/completed-expedition-archive/` / House of Records capstone.

The House of Records preserves historical signal, not every score sheet, purchase or private conversation.

## Implementation gate status

See `FAIR_IMPLEMENTATION_GATE_REVIEW.md`.

Current result:

- **Product planning coherence:** PASS
- **External dependency readiness:** NOT YET
- **Local workstream completeness:** MIXED / explicitly cataloged
- **Justin implementation authorization:** NO
- **Implementation gate:** **CLOSED**

External dependencies include the independent Release 1307 time/weather work, newer Mara wardrobe/property/autonomy authority, honest calendar/aging recurrence and broader money/custody semantics.

## Next planning frontier

If planning continues before those dependencies land, the highest-value local decisions are:

1. **Prize redemption catalog** — concrete initial Prize Hall objects and exact ticket costs;
2. **House of Mirrors anomaly set** — lock the small initial genuine-anomaly roster;
3. **F-04 sanction/adjudication procedure** — exact association responses to proven cheating;
4. **Attraction ownership/provenance** — association vs independent vs Frobozz responsibility;
5. **Conditional multi-day fair count** only if a future first implementation intends to model multiple public days honestly.

These are focused pre-code decisions, not permission to begin source implementation.

## Gate law

Do not create implementation beads/trains, code branches or implementation modules unless Justin explicitly changes the planning-first instruction and live dependency state is re-established first.

Do not merge PR #100 without a fresh explicit Justin merge whistle.
