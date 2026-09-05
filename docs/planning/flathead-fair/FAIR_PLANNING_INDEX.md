# Flathead Fair planning index

**Status:** DESIGNING  
**Public name:** **Flathead Fair** — LOCKED  
**Scope:** product planning only; no implementation train is authorized by this packet  
**Base frontier:** `master` at `767364f6b1de5ff45278f8f0d66508524e3f9b19`

## Purpose

This packet defines a recurring, dense, parser-first fair in Highly Extended Zork. Guardia Fair is inspiration only for the structural idea that a fair can be a small game-world inside the larger adventure: play, food, commerce, social life, chance, collecting, tiny stories and repeat visits.

The Flathead Fair must feel native to Zork and remain optional to canonical progression.

## Stable decisions so far

- Public/common name: **Flathead Fair**; canonical name anchor: Flathead Mountains at `CANYON-VIEW`.
- Annual regional fair in world fiction; no fake global year counter.
- Older regional institution plus later Frobozz sponsorship/concessions; not corporate monoculture.
- New **NE spur from canonical `CLEARING`**; existing canonical exits/barriers remain intact.
- Persistent meadow/field fairground with **16 major locations** in a dense mesh.
- General admission free; ordinary commerce uses zorkmids; original `VALUE/TVALUE` is not currency conversion; prize tickets are earned redemption currency only.
- Cinnamon-sugar elephant ear baseline **5 zm**; first partial-identification case `large drink` -> pear-lime fizz **4 zm**.
- Product identity and player knowledge remain separate world state.
- Named planning roster: **20 substantial people**, with bounded knowledge and no omniscient NPC database.
- Kester Vane's shell-game cheating uses inspectable tack-wax cup/pea state; hidden author cheating is forbidden.
- Daily operation uses nine semantic phases; closing is sequential; Back Lane remains a real staff/service seam.
- Core ride/destination set: Observation Wheel, Carousel, Flying Chairs, Scenic GUE ride, five-node House of Mirrors.
- Games Row has eight mechanically distinct initial activities; fishing is a full optional hobby/derby organ.
- First story web contains nine interconnected miniquests/incidents.
- Mara's fair-specific preferences, initiative, refusals, competition and semantic repeat-fair memory are stable for planning.
- **The Lantern Table** is the adult-evening supper/drink service inside Dance Pavilion; Tomas Quince transitions there at DUSK; free ordinary access; no drink minimum; no required alcohol/intoxication engine.
- Adult-social privacy is contextual rather than room-flagged.
- **RNG/SAVE contract is stable:** Glulx player SAVE/RESTORE does not save RNG internal state; committed outcomes live in ordinary saveable story state; fair production code does not globally reseed the VM; deterministic qualification may use pinned Glulxe `--rngseed`.
- Pre-commit chance may differ after restore; SAVE is not misconduct and there is no hidden anti-save punishment state.
- Randomness never gates canonical solvability or controls Mara personality/relationship success/generated dialogue/lore.
- **No duplicate fair historical archive.** Fair Office & Prize Hall owns current administration; the existing upstairs House of Records owns durable documentary history; personal memory stays separate.
- **Archive graduation is locked for planning:** the House of Records preserves historical signal, not administrative exhaust.
- Durable baseline includes one official annual/cycle program, meaningful grounds maps, annual public-results summary, standing-record changes, significant attraction/concession changes and formally adjudicated historically meaningful incidents.
- Routine booth attempts, daily score noise, ordinary catches, queue/service paperwork, routine permits, ordinary lost-and-found and private purchases do not automatically graduate.
- Derby winner and verified standing-record fish graduate; ordinary catches and routine weigh-in sheets remain current/personal.
- Shell-game history graduates only through a real evidence/adjudication path with lasting consequence or significant unresolved documentary status.
- Corrections/disqualifications append provenance and supersession; the archive never silently rewrites an earlier result into `it was always this way`.
- Private Mara/Adventurer memories are not automatically institutional records.
- Canonical Zork routes/solutions remain authoritative.
- No Gato analogue, no Chrono Trigger reenactment, no GUI, no generic fair generator, no generated-content soup.

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
| `FAIR_GAMES_COMPETITIONS_AND_RECORDS.md` | STABLE FOR INITIAL GAMES PLANNING | midway mechanics, current records, contest boundaries |
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
| `FAIR_HALL_OF_RECORDS_INTEGRATION.md` | STABLE FOR PLANNING; graduation LOCKED | existing archive reuse, retention/graduation, provenance, corrections, privacy |
| `FAIR_WEATHER_AND_ENVIRONMENT.md` | DESIGNING | time/weather integration |
| `FAIR_NATURAL_PLAY_ACCEPTANCE.md` | DESIGNING | future qualification contract |
| `FAIR_OPEN_QUESTIONS.md` | OPEN | intentionally unresolved decisions |

## Runtime mechanics consumed by the RNG authority

The active Highly Extended edition targets Glulx 3.1.3 and pins Glulxe `56ab8743bab565de307bd892c555d8d8897ed517` for native qualification.

Player SAVE/RESTORE restores ordinary game state but not Glulx RNG internal state. Committed fair facts therefore belong in ordinary story state. Glulxe interpreter-managed autosave RNG restoration is not a portable gameplay promise. Hosted deterministic routes may use the pinned interpreter's `--rngseed` launch option.

## Existing archive authority consumed by the fair

The fair composes rather than duplicates:

- `glulx/attic-archive-core/`;
- `glulx/attic-area-case-files/`;
- `glulx/attic-npc-dossiers/` where genuinely appropriate;
- `glulx/attic-playback/` only where existing documentary authority supports it;
- `glulx/completed-expedition-archive/`, explicitly the House of Records capstone.

`FAIR_HALL_OF_RECORDS_INTEGRATION.md` owns this seam and the locked graduation matrix.

## Current planning frontier

The major handoff-frontier authorities are now coherent: secondary cast, Mara, adult evening venue, RNG/SAVE semantics and archive graduation are all banked.

The next work is **planning consolidation and implementation-gate review, not implementation**:

1. consolidate Tomas Quince's DUSK/EVENING transition into `FAIR_DAILY_OPERATIONS.md`;
2. re-read `FAIR_PRODUCT_BIBLE.md` and `FAIR_NATURAL_PLAY_ACCEPTANCE.md` against the now-stable focused authorities;
3. classify any remaining gate blockers as true product-authority blockers versus implementation-only details;
4. tighten cross-document wording where an older placeholder still conflicts with a newer focused authority;
5. decide whether the planning packet is coherent enough to decompose a future implementation program — without beginning that program unless Justin explicitly changes the planning-first instruction.

## Gate before implementation

Do not create implementation beads/trains until the Product Bible, Name/Lore, Geography, Products/Economy, Product Knowledge, Mara Experience, Adult Social, RNG, Persistence, House-of-Records integration and Natural-Play authorities are coherent together. Planning may grow; coding must not outrun authority.
