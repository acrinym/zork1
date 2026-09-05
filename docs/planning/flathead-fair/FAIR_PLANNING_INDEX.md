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
- **16 major fair locations**, now with a locked planning connection graph.
- Graph is a mesh with multiple pedestrian loops, not hub-and-dead-end spokes.
- **General admission is free.**
- Ordinary commerce uses **zorkmids** under an authored everyday purchasing-power scale.
- Original Zork I `VALUE/TVALUE` is not a money conversion.
- Prize tickets are earned midway redemption currency only.
- Cinnamon-sugar elephant ear baseline: **5 zm**.
- First product-identification case: `large drink` -> **pear-lime fizz, 4 zm**.
- Product identity and player knowledge are separate world state.
- NPC answers derive from actual knowledge; no generic answer where specific knowledge should exist.
- Initial core roster: **12 named NPCs**, now bound to real fair locations and daily schedules.
- Daily operation uses nine semantic phases from PREOPEN through AFTER-HOURS.
- Closing is sequential: queues stop, active rides finish, redemption remains available, visitors drain naturally, staff continue cleanup.
- Back Lane is the real service/staff seam.
- Mara has independent fair agency and is not assigned a fixed NPC-worker schedule.
- Adult social/romantic/intimate life is first-class while broader consent/autonomy authority remains sovereign.
- Controlled RNG is welcome for optional fair play, never required canonical progression.
- Canonical Zork routes and solutions remain authoritative.
- No Gato analogue, no Crono/Marle reenactment, no GUI, no generic carnival framework, no generated-content soup.

## Authority map

| Document | Status | Owns |
|---|---|---|
| `FAIR_PRODUCT_BIBLE.md` | DESIGNING | North star, product identity, boundaries |
| `FAIR_NAME_AND_LORE.md` | STABLE FOR PLANNING | Public name, regional origin, governance/Frobozz relationship |
| `FAIR_SITE_SELECTION.md` | LOCKED FOR PLANNING | Canonical map evidence and attachment seam |
| `FAIR_GEOGRAPHY.md` | STABLE FOR PLANNING | 16-location graph, movement/privacy/service topology |
| `FAIR_DAILY_OPERATIONS.md` | STABLE FOR PLANNING | phase-by-phase room operation, NPC schedule, closing/after-hours |
| `FAIR_TIME_SCHEDULE_AND_SEASON.md` | STABLE FOR PLANNING | annual recurrence and semantic daily lifecycle |
| `FAIR_PRODUCTS_AND_ZORKMID_ECONOMY.md` | STABLE FOR PLANNING | purchasing power, free admission, commerce laws |
| `FAIR_PRICE_BOOK.md` | DESIGNING | concrete initial prices and redemption bands |
| `FAIR_PRODUCT_KNOWLEDGE_AND_QUESTIONS.md` | STABLE FOR PLANNING | partial identification and contextual questions |
| `FAIR_VENDOR_AND_COMMERCE_DESIGN.md` | DESIGNING | merchant seams, stock, payment/refund behavior |
| `FAIR_ATTRACTIONS_CATALOG.md` | DESIGNING | rides and destination attractions |
| `FAIR_GAMES_COMPETITIONS_AND_RECORDS.md` | DESIGNING | midway play, records, contests |
| `FAIR_FISHING.md` | DESIGNING | fishing hobby and derby |
| `FAIR_RNG_CONTRACT.md` | DESIGNING | controlled randomness and reproducibility |
| `FAIR_NPC_ROSTER.md` | STABLE FOR INITIAL CORE PLANNING | 12 named people, roles, locations, knowledge boundaries |
| `FAIR_DIALOGUE_AND_CONTEXTUAL_KNOWLEDGE.md` | DESIGNING | who can say what, and why |
| `FAIR_MARA_EXPERIENCE.md` | DESIGNING | Mara-specific agency, preferences, memory |
| `FAIR_ADULT_SOCIAL_ROMANCE_AND_INTIMACY.md` | DESIGNING | adult social and relationship space |
| `FAIR_FOOD_AND_CONCESSIONS.md` | STABLE FOR PLANNING | food, drink, elephant ears, pear-lime example |
| `FAIR_MINIQUESTS_INCIDENTS_AND_RUMORS.md` | DESIGNING | small stories and discovered objectives |
| `FAIR_REWARDS_PRIZES_AND_COLLECTIBLES.md` | DESIGNING | tickets, prizes, annual objects |
| `FAIR_PERSISTENCE_AND_MEMORY.md` | DESIGNING | what survives visits and years |
| `FAIR_WEATHER_AND_ENVIRONMENT.md` | DESIGNING | time/weather integration |
| `FAIR_NATURAL_PLAY_ACCEPTANCE.md` | DESIGNING | future qualification contract |
| `FAIR_OPEN_QUESTIONS.md` | OPEN | intentionally unresolved decisions |

## Current planning frontier

The fair now has identity, map attachment, economy, products, core people, a full 16-location graph and an operating day.

The next highest-leverage work is **make the attractions and stories real enough to live in**:

1. deepen the Observation Wheel, Ride Court, House of Mirrors and scenic ride into complete parser attractions;
2. lock an initial Games Row roster with genuinely different mechanics and ticket/record behavior;
3. deepen Fishing Pond into a complete hobby/derby loop;
4. weave the first miniquests/incidents through the real NPC schedules and geography;
5. then tighten Mara/adult-social/persistence/RNG authorities against those concrete activities.

## Gate before implementation

Do not create implementation beads/trains until at minimum the Product Bible, Name/Lore, Geography, Products/Economy, Product Knowledge, Mara Experience, Adult Social, RNG, Persistence and Natural-Play documents have explicit stable decisions. Planning may grow; coding must not outrun authority.
