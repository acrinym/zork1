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
- Ordinary commerce uses **zorkmids**; original Zork I `VALUE/TVALUE` is not a money conversion.
- Prize tickets are earned midway redemption currency only.
- Cinnamon-sugar elephant ear baseline: **5 zm**.
- First product-identification case: `large drink` -> **pear-lime fizz, 4 zm**.
- Product identity and player knowledge are separate world state.
- Named planning roster: **20 substantial people** — 12 core plus Kester Vane, Hettie Bramm, Sella Birch, Pella Wren, Tobin Wren, Lysa Marr, Tavin Roe and Cassa Reed.
- Kester Vane's initial cheating mechanism is physical/inspectable tack-wax cup/pea state, never hidden author-side answer changing.
- No dedicated fair constable is required until a real authority gap appears.
- Daily operation uses nine semantic phases from PREOPEN through AFTER-HOURS; closing is sequential and Back Lane remains a real staff/service seam.
- Core attractions: Observation Wheel, Carousel, Flying Chairs, Scenic GUE ride and five-node House of Mirrors.
- Games Row has eight mechanically distinct initial activities rather than one RNG roll reskinned.
- Fishing has a full optional hobby/derby loop with positions, bait/gear, real catches, junk, records and Mara competition.
- First story web contains nine interconnected miniquests/incidents.
- Mara's fair-specific character authority is stable: concrete attraction/game/fishing/food preferences, phase initiative, refusals, competition and semantic repeat-fair memory.
- Mara's strongest attraction preference is the Observation Wheel at dusk/evening; dragon is her baseline carousel mount; fishing is a genuine low-intensity preference; she favors the apple-topped elephant ear, pear-lime fizz by day and hot spiced cider in cooler evening conditions.
- **The Lantern Table** is the locked adult-evening supper/drink service inside the existing Dance Pavilion, not a seventeenth room.
- Tomas Quince shifts from Food Row to The Lantern Table at DUSK; ordinary access remains free, there is no drink minimum and the venue does not require an alcohol/intoxication system.
- Dance Pavilion privacy is contextual: counter/music side highly public, communal tables public/social, edge tables quieter public; more privacy comes from actual geography such as the wheel carriage or Pond Path.
- **RNG/save contract is stable for planning:** the active Highly Extended Glulx line does not save VM RNG internal state in player-managed SAVE/RESTORE; once a random fair fact becomes world truth it must be committed into ordinary saveable story state.
- Fair production play does **not** globally reseed the VM RNG. Pre-commit chance may differ after restore; the fair does not punish save use or maintain hidden anti-save state.
- Deterministic qualification can use the exact pinned Glulxe runtime's `--rngseed` process argument; no new fair seed verb is required.
- Randomness remains optional-world variation only: never canonical solvability, required exits/items/NPCs, Mara personality, relationship success, generated dialogue or generated lore.
- **No duplicate fair historical archive.** The existing upstairs/Attic Hall/House of Records remains the durable documentary authority.
- Fairground location #15 is **Fair Office & Prize Hall**; Ada Vellum handles current-fair administration, not master historical archiving.
- Fair records remain three layers: current Fair Office paperwork, durable House of Records documentary history, and personal lived memory.
- Existing archive provenance/confidence/verification/contradiction/redaction semantics should be reused where applicable.
- Private Mara/Adventurer memories are not automatically institutional records.
- Canonical Zork routes and solutions remain authoritative.
- No Gato analogue, no Chrono Trigger reenactment, no GUI, no generic carnival framework, no generated-content soup.

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
| `FAIR_RNG_CONTRACT.md` | STABLE FOR PLANNING | Glulx SAVE/RNG semantics, commitment timing, controlled randomness, deterministic qualification |
| `FAIR_NPC_ROSTER.md` | STABLE FOR INITIAL CORE PLANNING | 12-person core people, roles/locations/knowledge |
| `FAIR_SECONDARY_CAST.md` | STABLE FOR PLANNING | 8-person secondary roster, story/system bindings, schedules/knowledge boundaries |
| `FAIR_DIALOGUE_AND_CONTEXTUAL_KNOWLEDGE.md` | DESIGNING | who can say what, and why |
| `FAIR_MARA_EXPERIENCE.md` | STABLE FOR PLANNING | Mara preferences, initiative, refusal, competition and memory |
| `FAIR_ADULT_SOCIAL_ROMANCE_AND_INTIMACY.md` | STABLE FOR PLANNING | Lantern Table, adult-social topology, dancing/affection context and privacy |
| `FAIR_FOOD_AND_CONCESSIONS.md` | STABLE FOR PLANNING | food, drink, elephant ears, pear-lime example |
| `FAIR_MINIQUESTS_INCIDENTS_AND_RUMORS.md` | STABLE FOR FIRST STORY-WEB PLANNING | nine small stories, evidence/provenance seams |
| `FAIR_REWARDS_PRIZES_AND_COLLECTIBLES.md` | DESIGNING | tickets, prizes, annual objects |
| `FAIR_PERSISTENCE_AND_MEMORY.md` | STABLE FOR PLANNING | current vs documentary vs personal persistence |
| `FAIR_HALL_OF_RECORDS_INTEGRATION.md` | STABLE FOR PLANNING | reuse of existing attic/House of Records, archival graduation/provenance/privacy |
| `FAIR_WEATHER_AND_ENVIRONMENT.md` | DESIGNING | time/weather integration |
| `FAIR_NATURAL_PLAY_ACCEPTANCE.md` | DESIGNING | future qualification contract |
| `FAIR_OPEN_QUESTIONS.md` | OPEN | intentionally unresolved decisions |

## Runtime mechanics consumed by the RNG authority

The active Highly Extended edition targets Glulx 3.1.3 and the repository pins Glulxe `56ab8743bab565de307bd892c555d8d8897ed517` for native qualification.

Product-level consequence:

- player SAVE/RESTORE restores ordinary game state but not Glulx RNG internal state;
- committed fair facts therefore belong in ordinary story state;
- Glulxe interpreter-managed autosave RNG restoration is not a portable gameplay promise;
- hosted deterministic routes may use the pinned interpreter's `--rngseed` launch option.

See `FAIR_RNG_CONTRACT.md` for the full boundary.

## Existing archive authority consumed by the fair

The fair must compose rather than duplicate:

- `glulx/attic-archive-core/`;
- `glulx/attic-area-case-files/`;
- `glulx/attic-npc-dossiers/` where appropriate;
- `glulx/attic-playback/` where supported;
- `glulx/completed-expedition-archive/`, explicitly the House of Records capstone.

`FAIR_HALL_OF_RECORDS_INTEGRATION.md` owns this seam.

## Current planning frontier

The fair now has identity, map attachment, economy/products, a named 20-person cast, full operating geography/day, deep attractions/games/fishing, a first story web, concrete Mara authority, a locked adult evening venue, and a runtime-grounded RNG/SAVE contract.

The next highest-leverage work is **archive graduation and implementation-gate tightening**:

1. lock which game/fishing/exhibition/current-office results remain routine paperwork versus become durable House of Records history;
2. define annual-summary/adjudicated-incident graduation without duplicating the existing archive;
3. consolidate Tomas Quince's DUSK/EVENING movement into `FAIR_DAILY_OPERATIONS.md`;
4. re-read the Natural-Play acceptance and Product Bible authorities against the now-stable Mara/Adult/RNG passes;
5. re-evaluate the implementation gate only after those planning seams are coherent.

## Gate before implementation

Do not create implementation beads/trains until at minimum the Product Bible, Name/Lore, Geography, Products/Economy, Product Knowledge, Mara Experience, Adult Social, RNG, Persistence, Hall-of-Records integration and Natural-Play documents have explicit stable decisions. Planning may grow; coding must not outrun authority.
