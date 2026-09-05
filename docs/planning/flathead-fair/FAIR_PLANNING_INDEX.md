# Flathead Fair planning index

**Status:** DESIGNING  
**Public name:** **Flathead Fair** — LOCKED  
**Scope:** product planning only; no implementation train is authorized by this packet  
**Base frontier:** `master` at `767364f6b1de5ff45278f8f0d66508524e3f9b19`

## Purpose

This packet defines a recurring, dense, parser-first fair in Highly Extended Zork. Guardia Fair is inspiration only for the structural idea that a fair can be a small game-world inside the larger adventure: play, food, commerce, social life, chance, collecting, tiny stories and repeat visits.

The Flathead Fair must feel native to Zork and remain optional to canonical progression.

## Stable decisions so far

- Public/common name: **Flathead Fair**.
- Canonical name anchor: Flathead Mountains at `CANYON-VIEW`.
- Annual regional fair in world fiction; no fake year counter.
- Older regional fair association plus later Frobozz-branded presence; not corporate monoculture.
- New **NE spur from canonical `CLEARING`**; every existing canonical exit/barrier remains.
- Fairground is real persistent meadow/field geography.
- **16 major fair locations** with a locked mesh connection graph.
- General admission is free.
- Ordinary commerce uses **zorkmids** under an authored everyday purchasing-power scale.
- Original Zork I `VALUE/TVALUE` is not a money conversion.
- Prize tickets are earned midway redemption currency only.
- Cinnamon-sugar elephant ear baseline: **5 zm**.
- First product-identification case: `large drink` -> **pear-lime fizz, 4 zm**.
- Product identity and player knowledge are separate world state.
- NPC answers derive from actual knowledge; no generic answer where specific knowledge should exist.
- Initial core roster: **12 named NPCs**, bound to real fair locations and daily schedules.
- Secondary roster: **8 additional named NPCs**, bringing the planning roster to **20 substantial named people**.
- Secondary cast identities are locked for planning: **Kester Vane**, **Hettie Bramm**, **Sella Birch**, **Pella Wren**, **Tobin Wren**, **Lysa Marr**, **Tavin Roe**, and **Cassa Reed**.
- Kester Vane's initial cheating mechanism is physical and inspectable: a tack-wax cup/pea state rather than hidden author-side answer changing.
- No dedicated fair constable is required in the initial named roster; add one only if a real authority gap appears.
- Daily operation uses nine semantic phases from PREOPEN through AFTER-HOURS.
- Closing is sequential: queues stop, active rides finish, redemption remains available, visitors drain naturally, staff continue cleanup.
- Back Lane is the real service/staff seam.
- Core attractions have first full planning passes: Observation Wheel, Carousel, Flying Chairs, Scenic GUE ride and five-node House of Mirrors.
- Games Row has eight mechanically distinct initial activities rather than one RNG roll reskinned.
- Fishing has a full optional hobby/derby planning loop with positions, bait/gear, real catches, junk, records and Mara competition.
- First story web contains nine interconnected miniquests/incidents.
- **Mara's fair-specific character authority is stable for planning**: authored attraction/game/fishing/food preferences, phase-sensitive initiative, refusal/annoyance behavior, competition and semantic repeat-fair memory are defined in `FAIR_MARA_EXPERIENCE.md`.
- Mara's strongest attraction preference is the Observation Wheel at dusk/evening; dragon is her baseline carousel mount; fishing is a genuine low-intensity preference; she favors the apple-topped elephant ear, pear-lime fizz by day and hot spiced cider in cooler evening conditions.
- Mara can beat the Adventurer and Cassa Reed, refuse repetitive or suspect play, and remember prior fair experiences without a fair-specific relationship meter.
- **Adult evening venue:** **The Lantern Table**, an evening supper-and-drink service zone inside the existing Dance Pavilion rather than a seventeenth room.
- **Tomas Quince** shifts from Food Row to The Lantern Table at DUSK and operates its evening service; this focused authority supersedes his older all-evening Food Row placeholder until `FAIR_DAILY_OPERATIONS.md` is consolidated before implementation.
- Lantern Table ordinary access is free, with no drink minimum; its initial menu reuses existing fair products/prices and does not require alcohol/intoxication mechanics.
- Dance Pavilion privacy remains contextual: counter/music side is highly public, communal tables are social/public, edge tables are quieter public, and real privacy comes from actual geography such as the wheel carriage or Pond Path.
- Lysa Marr and Tavin Roe give the venue adult continuity independent of Mara and the Adventurer.
- **No duplicate fair historical archive.** The existing upstairs/Attic Hall/House of Records remains the durable documentary authority.
- Fairground location #15 is **Fair Office & Prize Hall**, not `Prize & Records Hall`.
- Ada Vellum is current fair registrar/office clerk; durable historical records graduate to the existing House of Records.
- Fair records have three layers: current Fair Office paperwork, durable House of Records documentary history, and personal lived memory.
- Existing archive provenance/confidence/verification/contradiction/redaction semantics should be reused for fair history where applicable.
- Private Mara/Adventurer memories are not automatically institutional records.
- Controlled RNG is welcome for optional fair play, never required canonical progression.
- Canonical Zork routes and solutions remain authoritative.
- No Gato analogue, no Crono/Marle reenactment, no GUI, no generic carnival framework, no generated-content soup.

## Authority map

| Document | Status | Owns |
|---|---|---|
| `FAIR_PRODUCT_BIBLE.md` | DESIGNING | North star, product identity, boundaries |
| `FAIR_NAME_AND_LORE.md` | STABLE FOR PLANNING | Public name, regional origin, governance/Frobozz relationship |
| `FAIR_SITE_SELECTION.md` | LOCKED FOR PLANNING | Canonical map evidence and attachment seam |
| `FAIR_GEOGRAPHY.md` | STABLE FOR PLANNING | 16-location graph, Fair Office & Prize Hall, movement/privacy/service topology |
| `FAIR_DAILY_OPERATIONS.md` | STABLE FOR PLANNING | phase-by-phase operation, core NPC schedule, current-office closeout, closing/after-hours |
| `FAIR_TIME_SCHEDULE_AND_SEASON.md` | STABLE FOR PLANNING | annual recurrence and semantic daily lifecycle |
| `FAIR_PRODUCTS_AND_ZORKMID_ECONOMY.md` | STABLE FOR PLANNING | purchasing power, free admission, commerce laws |
| `FAIR_PRICE_BOOK.md` | DESIGNING | concrete initial prices and redemption bands |
| `FAIR_PRODUCT_KNOWLEDGE_AND_QUESTIONS.md` | STABLE FOR PLANNING | partial identification and contextual questions |
| `FAIR_VENDOR_AND_COMMERCE_DESIGN.md` | DESIGNING | merchant seams, stock, payment/refund behavior |
| `FAIR_ATTRACTIONS_CATALOG.md` | DESIGNING | rides and destination attractions |
| `FAIR_GAMES_COMPETITIONS_AND_RECORDS.md` | DESIGNING | midway play, records, contests |
| `FAIR_FISHING.md` | DESIGNING | fishing hobby and derby |
| `FAIR_RNG_CONTRACT.md` | DESIGNING | controlled randomness and reproducibility |
| `FAIR_NPC_ROSTER.md` | STABLE FOR INITIAL CORE PLANNING | 12-person core people, Ada/Fair Office boundary, roles/locations/knowledge |
| `FAIR_SECONDARY_CAST.md` | STABLE FOR PLANNING | 8-person secondary roster, named story/system bindings, secondary schedules and knowledge boundaries |
| `FAIR_DIALOGUE_AND_CONTEXTUAL_KNOWLEDGE.md` | DESIGNING | who can say what, and why |
| `FAIR_MARA_EXPERIENCE.md` | STABLE FOR PLANNING | Mara-specific attraction/game/fishing/food preferences, initiative, refusal, competition and memory |
| `FAIR_ADULT_SOCIAL_ROMANCE_AND_INTIMACY.md` | STABLE FOR PLANNING | Lantern Table identity/service, adult-social topology, dancing/affection context and privacy boundaries |
| `FAIR_FOOD_AND_CONCESSIONS.md` | STABLE FOR PLANNING | food, drink, elephant ears, pear-lime example |
| `FAIR_MINIQUESTS_INCIDENTS_AND_RUMORS.md` | STABLE FOR FIRST STORY-WEB PLANNING | nine small stories, evidence/provenance seams |
| `FAIR_REWARDS_PRIZES_AND_COLLECTIBLES.md` | DESIGNING | tickets, prizes, annual objects |
| `FAIR_PERSISTENCE_AND_MEMORY.md` | STABLE FOR PLANNING | current vs documentary vs personal persistence |
| `FAIR_HALL_OF_RECORDS_INTEGRATION.md` | STABLE FOR PLANNING | reuse of existing attic/House of Records, archival graduation/provenance/privacy |
| `FAIR_WEATHER_AND_ENVIRONMENT.md` | DESIGNING | time/weather integration |
| `FAIR_NATURAL_PLAY_ACCEPTANCE.md` | DESIGNING | future qualification contract |
| `FAIR_OPEN_QUESTIONS.md` | OPEN | intentionally unresolved decisions |

## Existing archive authority consumed by the fair

The fair must compose rather than duplicate these live product organs:

- `glulx/attic-archive-core/`;
- `glulx/attic-area-case-files/`;
- `glulx/attic-npc-dossiers/` where appropriate;
- `glulx/attic-playback/` where supported;
- `glulx/completed-expedition-archive/`, explicitly the House of Records capstone.

`FAIR_HALL_OF_RECORDS_INTEGRATION.md` owns this seam.

## Current planning frontier

The fair now has identity, map attachment, economy, products, a named **20-person core+secondary cast**, full operating geography/day, first deep attractions/games/fishing, a first story web, a clean House-of-Records integration, concrete Mara authority, and a locked adult evening venue/service model.

The next highest-leverage work is **RNG and save/restore semantics**:

1. inspect the actual ZIL/interpreter random/save/restore mechanics used by this repository before locking fair seeding rules;
2. determine which fair outcomes are day/event commitments versus action-time draws;
3. ensure save/restore reproduces world state rather than becoming an exploit-driven reroll contract by accident;
4. tighten prize/record/archive graduation details around actual contest outputs without duplicating the House of Records;
5. consolidate the Tomas DUSK/EVENING schedule cell into `FAIR_DAILY_OPERATIONS.md` before any future implementation decomposition;
6. re-evaluate the implementation gate only after these authorities are coherent.

## Gate before implementation

Do not create implementation beads/trains until at minimum the Product Bible, Name/Lore, Geography, Products/Economy, Product Knowledge, Mara Experience, Adult Social, RNG, Persistence, Hall-of-Records integration and Natural-Play documents have explicit stable decisions. Planning may grow; coding must not outrun authority.
