# Flathead Fair natural-play acceptance

**Status:** DESIGNING  
**Purpose:** future qualification contract; no implementation is authorized yet

## Canonical non-interference

A release that introduces the fair must prove that ordinary canonical Zork play still works when the player never enters the fair.

At minimum:

- existing House/Clearing/Canyon exits remain correct;
- `CLEARING` still leads west/east/north/south exactly as before;
- the new northeast fair spur is additive;
- canonical forest barriers remain intact;
- no required treasure moves into fair geography;
- fair opening/closing cannot block a canonical route;
- weather/fair schedules cannot make a required canonical solution randomly unavailable.

## Fair approach acceptance

Natural play should prove:

1. reach canonical `CLEARING` by an ordinary route;
2. observe a fair cue only when relevant fair state makes one plausible;
3. travel northeast to `FAIR-ROAD` without altering existing exits;
4. enter the fairgrounds without paying general admission;
5. leave again and resume canonical surface play.

## Free-entry acceptance

A player with insufficient or zero spendable zorkmids must still be able to:

- enter the grounds;
- walk public routes;
- talk to NPCs;
- watch ordinary public activity;
- accompany Mara;
- inspect products/menus/signage;
- leave safely.

They may correctly be unable to buy products or paid services.

## Commerce acceptance

At minimum qualification should eventually cover:

- inspect a priced product;
- ask its seller how much it costs;
- buy it with sufficient zorkmids;
- fail contextually with insufficient funds;
- preserve physical object identity after purchase;
- ask a vendor about their own product and receive specific knowledge;
- ask an unrelated NPC and receive only knowledge they plausibly have.

## Product-identification acceptance

The first locked case is the 4-zm pear-lime fizz:

1. encounter it as a `large drink` without exact flavor knowledge;
2. ask Tomas Quince what flavor it is;
3. learn that it is pear-lime fizz;
4. retain the same physical drink object;
5. allow Mara's answer to depend on what she has actually smelled/tasted/heard;
6. prevent unrelated NPCs from receiving omniscient recipe knowledge;
7. support a useful repeated/follow-up answer rather than replaying first-contact prose forever.

## Food acceptance

Elephant-ear qualification eventually covers:

- cinnamon-sugar baseline price of 5 zm;
- Mabel Rusk knowing ingredients/preparation/price;
- eating/carrying/giving/sharing according to food/object authority;
- Mara choosing whether she wants/eats/shares one rather than being forced by the purchase;
- persistence of a meaningful shared-food memory only when broader memory authority supports it.

## NPC acceptance

The initial core named NPCs must not behave as stationary generic terminals.

Qualification should eventually sample:

- job-specific knowledge;
- correct ignorance outside role;
- schedule state;
- closing/weather behavior;
- memory of a prior interaction where persistence is supported;
- character-specific opinion rather than database prose.

Not every NPC needs every test in every release; each promoted organ needs deterministic representative routes.

## Mara acceptance

Mara remains autonomous at the fair.

Tests must include cases where she can:

- accept or refuse a suggestion;
- express a stable product/attraction preference;
- buy or decline something independently when money/inventory authority supports it;
- remember a shared event where memory authority exists;
- avoid relationship behavior not supported by current context/consent/state.

There is no hidden fair-only romance override.

## Fair-life acceptance

Representative natural-play histories should ultimately cover:

- daytime wandering;
- buying/eating an elephant ear;
- the pear-lime product-question path;
- one ride;
- one game;
- fishing;
- a scheduled performance/event;
- dusk/night transition;
- closing/exit;
- Mara agency and refusal/initiative.

A later multi-year history is required only when the broader calendar can honestly support a later fair.

## Time/weather acceptance

When fair time/weather integration lands:

- fair day phases alter only authored schedules/attractions;
- a weather closure has visible cause;
- paid services closed before use follow an authored refund/credit policy;
- no random weather event destroys required fair or canonical progression;
- off-season/closed grounds remain coherent world geography rather than disappearing.

## Save/restore and RNG

Before RNG-dependent fair play ships, qualification must prove the chosen seeding/save contract intentionally.

It must be clear which outcomes are:

- fixed for a fair day;
- rolled at action time;
- persisted after the roll;
- allowed to differ after restore, if any.

Save-scumming behavior should be a known design decision, not an accident.

## Persistence acceptance

Where the broader calendar permits a later fair, prove that selected records, owned prizes, vendor/NPC memories, and Mara memories survive while temporary stock/crowds reset according to their own authority.

## No cheat leakage

Test-only setup verbs/state helpers must never appear in production parser space.

## No completion requirement

Qualification does not require exhausting every prize, fish, NPC, product, or miniquest. The fair is a place to revisit, not a `100%` checklist.
