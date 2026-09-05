# Flathead Fair planning index

**Status:** DESIGNING  
**Public name:** **Flathead Fair** — LOCKED  
**Scope:** product planning only; no implementation train is authorized by this packet  
**Base frontier:** `master` at `767364f6b1de5ff45278f8f0d66508524e3f9b19`

## Purpose

This packet defines a recurring, dense, parser-first fair in Highly Extended Zork. The fair is not a Chrono Trigger recreation. Guardia Fair is inspiration only for the idea that a fair can be a small game-world inside the larger game: a place for play, food, commerce, social life, chance, collecting, tiny stories, and repeat visits.

The fair must feel native to Zork and remain optional to canonical progression.

## Decisions already established

- Public/common name: **Flathead Fair**.
- Canonical name anchor: the **Flathead Mountains** named from `CANYON-VIEW` in `1dungeon.zil`.
- The event is an **annual regional fair** in world fiction, with real multi-year recurrence deferred until global calendar/aging authority supports it.
- The fair predates modern Frobozz-branded involvement; independent vendors and a regional fair association remain first-class.
- Physical attachment is through a new **northeast spur from canonical `CLEARING`**, preserving every existing exit and explicit forest/canyon barrier.
- Fairgrounds occupy new meadow/field geography beyond the existing forest screen and continue to exist off-season.
- Initial geography targets about **16 dense functional locations**, not dozens of transit rooms.
- **General admission is free.** Walking, talking, public social life, and accompanying Mara are not cash-gated.
- Ordinary purchases use **zorkmids** under a stable Highly Extended everyday purchasing-power scale.
- Original Zork I treasure `VALUE/TVALUE` is not treated as a zorkmid exchange rate.
- Prize tickets are earned midway redemption currency only; they do not replace zorkmids or convert back into money.
- **Elephant ears are a signature fair staple**, with cinnamon-sugar at **5 zm**.
- The first locked partial-identification case is **`large drink` -> pear-lime fizz, 4 zm**.
- Products have concrete identities even when the Adventurer initially knows them only through partial descriptions.
- Players can ask vendors, Mara, and other NPCs meaningful questions about products.
- NPC answers are contextual to actual knowledge. No generic response is acceptable when a character reasonably knows the answer.
- Initial core population now has **12 working named NPCs** with job/knowledge boundaries.
- Mara has agency. She may buy, suggest, refuse, wander, compete, eat, fish, dance, remember, and initiate.
- Adult romance, dating, affection, privacy, and intimacy are part of fair life, governed by broader relationship/consent authorities rather than a carnival-specific romance minigame.
- Controlled RNG belongs at the fair, but required progression must never depend on arbitrary random outcomes.
- The fair recurs and changes over time. Records, memories, objects, and some NPC histories can persist.
- Canonical Zork routes and solutions remain authoritative.
- No Gato analogue, no Crono/Marle reenactment, no GUI, no generic carnival framework, and no generated-content soup.

## Authority map

| Document | Status | Owns |
|---|---|---|
| `FAIR_PRODUCT_BIBLE.md` | DESIGNING | North star, boundaries, product definition |
| `FAIR_NAME_AND_LORE.md` | STABLE FOR PLANNING | Locked public name, regional origin, fair-association/Frobozz relationship |
| `FAIR_SITE_SELECTION.md` | LOCKED FOR PLANNING | Canonical map evidence and selected attachment seam |
| `FAIR_GEOGRAPHY.md` | DESIGNING | Locked attachment plus district/room plan |
| `FAIR_TIME_SCHEDULE_AND_SEASON.md` | DESIGNING | Locked annual recurrence plus daily/event lifecycle |
| `FAIR_PRODUCTS_AND_ZORKMID_ECONOMY.md` | STABLE FOR PLANNING | Zorkmid purchasing power, free admission, commerce laws |
| `FAIR_PRICE_BOOK.md` | DESIGNING | Initial concrete zorkmid prices and redemption bands |
| `FAIR_PRODUCT_KNOWLEDGE_AND_QUESTIONS.md` | STABLE FOR PLANNING | Partial identification, contextual questions, first acceptance case |
| `FAIR_VENDOR_AND_COMMERCE_DESIGN.md` | DESIGNING | Merchants, stalls, stock, expertise |
| `FAIR_ATTRACTIONS_CATALOG.md` | DESIGNING | Rides and destination attractions |
| `FAIR_GAMES_COMPETITIONS_AND_RECORDS.md` | DESIGNING | Midway play, records, contests |
| `FAIR_FISHING.md` | DESIGNING | Fishing hobby and derby |
| `FAIR_RNG_CONTRACT.md` | DESIGNING | Controlled randomness and reproducibility |
| `FAIR_NPC_ROSTER.md` | DESIGNING | Initial 12 named people, roles, knowledge boundaries |
| `FAIR_DIALOGUE_AND_CONTEXTUAL_KNOWLEDGE.md` | DESIGNING | Who can say what, and why |
| `FAIR_MARA_EXPERIENCE.md` | DESIGNING | Mara-specific agency, preferences, memory |
| `FAIR_ADULT_SOCIAL_ROMANCE_AND_INTIMACY.md` | DESIGNING | Adult social and relationship space |
| `FAIR_FOOD_AND_CONCESSIONS.md` | STABLE FOR PLANNING | Food, drink, sharing, elephant ears, pear-lime example |
| `FAIR_MINIQUESTS_INCIDENTS_AND_RUMORS.md` | DESIGNING | Small stories and discovered objectives |
| `FAIR_REWARDS_PRIZES_AND_COLLECTIBLES.md` | DESIGNING | Tickets, prizes, annual objects |
| `FAIR_PERSISTENCE_AND_MEMORY.md` | DESIGNING | What survives visits and years |
| `FAIR_WEATHER_AND_ENVIRONMENT.md` | DESIGNING | Time/weather integration |
| `FAIR_NATURAL_PLAY_ACCEPTANCE.md` | DESIGNING | Future qualification contract |
| `FAIR_OPEN_QUESTIONS.md` | OPEN | Decisions still deliberately unresolved |

## Current planning frontier

The load-bearing identity, site, annual recurrence, everyday money scale, free admission, signature food, first product-identification case, and initial core NPC roster now exist.

The next highest-leverage planning work is **fair operation as a day of play**:

1. lock the detailed 16-location connection graph;
2. assign the core NPCs to those spaces and schedules;
3. lock the initial ride/game roster and operating prices;
4. define the observation wheel, House of Mirrors, and fishing pond deeply enough to qualify as full attractions rather than labels;
5. then build the first miniquest/incident graph through those real people and places.

## Gate before implementation

Do not create implementation beads/trains until at minimum the Product Bible, Name/Lore, Geography, Products/Economy, Product Knowledge, Mara Experience, Adult Social, RNG, Persistence, and Natural-Play documents have explicit stable decisions. Planning may grow; coding must not outrun authority.
