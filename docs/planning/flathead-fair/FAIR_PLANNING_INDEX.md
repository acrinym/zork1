# Flathead Fair planning index

**Status:** DESIGNING  
**Working name:** Flathead Fair  
**Scope:** product planning only; no implementation train is authorized by this packet  
**Base frontier:** `master` at `767364f6b1de5ff45278f8f0d66508524e3f9b19`

## Purpose

This packet defines a recurring, dense, parser-first fair in Highly Extended Zork. The fair is not a Chrono Trigger recreation. Guardia Fair is inspiration only for the idea that a fair can be a small game-world inside the larger game: a place for play, food, commerce, social life, chance, collecting, tiny stories, and repeat visits.

The fair must feel native to Zork and remain optional to canonical progression.

## Decisions already established

- Working name: **Flathead Fair**. The final lore pass may still refine the formal title.
- Ordinary purchases use **zorkmids**.
- A separate prize-ticket currency may exist for midway rewards only; it must not replace ordinary money.
- **Elephant ears are a signature fair staple.**
- Products have concrete identities even when the Adventurer initially knows them only as `large drink`, `red stuff`, `fried thing`, and similar partial descriptions.
- Players can ask vendors, Mara, and other NPCs meaningful questions about products.
- NPC answers are contextual to actual knowledge. No generic response is acceptable when a character reasonably knows the answer.
- Mara has agency. She may buy, suggest, refuse, wander, compete, eat, fish, dance, remember, and initiate.
- Adult romance, dating, affection, privacy, and intimacy are part of fair life, governed by the broader relationship/consent authorities rather than a carnival-specific romance minigame.
- Controlled RNG belongs at the fair, but required progression must never depend on arbitrary random outcomes.
- The fair recurs and changes over time. Records, memories, objects, and some NPC histories can persist.
- Canonical Zork routes and solutions remain authoritative.
- No Gato analogue, no Crono/Marle reenactment, no GUI, no generic carnival framework, and no generated-content soup.

## Authority map

| Document | Status | Owns |
|---|---|---|
| `FAIR_PRODUCT_BIBLE.md` | DESIGNING | North star, boundaries, product definition |
| `FAIR_NAME_AND_LORE.md` | DESIGNING | Name, cultural role, Frobozz/Flathead framing |
| `FAIR_GEOGRAPHY.md` | OPEN | Physical placement and dense room plan |
| `FAIR_TIME_SCHEDULE_AND_SEASON.md` | DESIGNING | Daily and recurring fair lifecycle |
| `FAIR_PRODUCTS_AND_ZORKMID_ECONOMY.md` | DESIGNING | Prices, money, merchandise, purchasing power |
| `FAIR_PRODUCT_KNOWLEDGE_AND_QUESTIONS.md` | DESIGNING | Partial identification and question answering |
| `FAIR_VENDOR_AND_COMMERCE_DESIGN.md` | DESIGNING | Merchants, stalls, stock, expertise |
| `FAIR_ATTRACTIONS_CATALOG.md` | DESIGNING | Rides and destination attractions |
| `FAIR_GAMES_COMPETITIONS_AND_RECORDS.md` | DESIGNING | Midway play, records, contests |
| `FAIR_FISHING.md` | DESIGNING | Fishing hobby and derby |
| `FAIR_RNG_CONTRACT.md` | DESIGNING | Controlled randomness and reproducibility |
| `FAIR_NPC_ROSTER.md` | OPEN | Named population and crowd model |
| `FAIR_DIALOGUE_AND_CONTEXTUAL_KNOWLEDGE.md` | DESIGNING | Who can say what, and why |
| `FAIR_MARA_EXPERIENCE.md` | DESIGNING | Mara-specific agency, preferences, memory |
| `FAIR_ADULT_SOCIAL_ROMANCE_AND_INTIMACY.md` | DESIGNING | Adult social and relationship space |
| `FAIR_FOOD_AND_CONCESSIONS.md` | DESIGNING | Food, drink, sharing, elephant ears |
| `FAIR_MINIQUESTS_INCIDENTS_AND_RUMORS.md` | DESIGNING | Small stories and discovered objectives |
| `FAIR_REWARDS_PRIZES_AND_COLLECTIBLES.md` | DESIGNING | Tickets, prizes, annual objects |
| `FAIR_PERSISTENCE_AND_MEMORY.md` | DESIGNING | What survives visits and years |
| `FAIR_WEATHER_AND_ENVIRONMENT.md` | DESIGNING | Time/weather integration |
| `FAIR_NATURAL_PLAY_ACCEPTANCE.md` | DESIGNING | Future qualification contract |
| `FAIR_OPEN_QUESTIONS.md` | OPEN | Decisions still deliberately unresolved |

## Gate before implementation

Do not create implementation beads/trains until at minimum the Product Bible, Name/Lore, Geography, Products/Economy, Product Knowledge, Mara Experience, Adult Social, RNG, Persistence, and Natural-Play documents have explicit stable decisions. Planning may grow; coding must not outrun authority.
