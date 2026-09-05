# Flathead Fair vendor and commerce design

**Status:** DESIGNING

## Commerce law

Fair commerce happens through actual people, stalls, products, prices, stock, and opening states. Avoid one universal `SHOP` menu that erases geography and character.

General grounds admission is free. Food, drinks, rides, games, rentals, merchandise, curiosities, and selected premium services use zorkmids. Prize tickets are a separate earned redemption currency.

## Initial named commerce anchors

The first core roster now establishes these concrete seller/operator seams:

- **Mabel Rusk** — elephant-ear concession;
- **Tomas Quince** — cold drinks / pear-lime fizz / souvenir mugs;
- **Nell Harrow** — prize redemption;
- **Silas Dace** — fishing rental/derby intake and advice where appropriate;
- **Emery Wicks** — observation-wheel fares/boarding;
- **Tilda Fen** — Ride Court fares/operation;
- **Jonas Pell** — honest skill-game operator;
- **Vera Tallow** — curiosity merchant;
- **Ada Vellum** — official programs, records, contest paperwork, lost-and-found rather than ordinary retail;
- **Berrin Vale** — concession/rule authority rather than cashier for the whole fair.

## Vendor expertise

A vendor should know the things their job reasonably requires:

- exact current prices;
- products they personally sell;
- ingredients/materials they personally use or have been told;
- stock and sold-out states;
- how payment works;
- refunds/credits they are authorized to issue;
- their own recommendations/opinions;
- neighboring stalls they commonly direct people toward.

They should not automatically know:

- another vendor's secret recipe;
- every fair record;
- hidden object provenance;
- Mara's private preferences;
- mechanical details outside their role;
- facts they have never observed or been told.

## Buying interaction

Parser-first commerce should support reasonable forms such as:

- `BUY ELEPHANT EAR`
- `BUY CINNAMON ELEPHANT EAR`
- `HOW MUCH IS THE LARGE DRINK?`
- `ASK TOMAS ABOUT THE DRINK`
- `ASK MABEL WHAT IS IN THE HONEY-NUT EAR`
- `SHOW MUG TO TOMAS`
- `REFILL MUG`

Ambiguous money/ticket language should clarify rather than silently choosing the wrong currency.

## Stock

Stock should be authored and bounded.

Possible states:

- plentiful/common;
- limited daily batch;
- nearly sold out;
- sold out;
- held for a contest/event;
- special annual item;
- weather-withdrawn product;
- damaged/unavailable stock.

Do not simulate every individual cinnamon grain. Track stock only when scarcity or persistence creates useful play.

## Price variation

`FAIR_PRICE_BOOK.md` sets the normal fair scale. Individual vendors may differ for authored reasons:

- craftsmanship;
- limited stock;
- annual edition;
- late-closing discount;
- damaged goods;
- friendship/reputation discount;
- blatant tourist markup;
- haggling where the specific merchant supports it.

There is no global `CHARISMA DISCOUNT` system.

## Payment failure

If the Adventurer cannot afford an item, the response should come from the transaction context rather than a generic parser failure.

The player may:

- leave;
- choose something cheaper;
- earn/spend money elsewhere if broader money authority allows;
- win a similar item at a prize booth where applicable;
- receive a contextual gift from another person only when that person independently chooses to do so.

Mara is not an automatic wallet bailout.

## Refunds and closures

If the fair itself prevents a paid service after accepting payment, the operator should have an authored refund/credit policy.

Examples:

- wheel closes for wind before boarding: refund or valid ride credit;
- attraction breaks mid-experience: operator response depends on severity and policy;
- player voluntarily abandons a game: no automatic refund unless rules say otherwise.

World-caused failure should not become invisible author theft.

## Vendor relationships

Vendors can know and react to each other.

Examples:

- Mabel may know Tomas is two stalls down without knowing his exact recipe;
- Tomas can send someone seeking food toward Mabel;
- Berrin knows who holds a concession;
- Ada knows the registered business name on paperwork;
- Vera may complain about association restrictions;
- a returning customer can be recognized by a vendor who actually interacted with them before.

## Mara commerce agency

Mara may:

- buy her own food;
- decline an offered purchase;
- ask the Adventurer if they want something;
- buy a gift;
- compare prices;
- think a price is ridiculous;
- remember a vendor;
- carry and use her own purchased objects.

The player does not remotely authorize all of her purchases.

## Merchant diversity still required

The core roster does not yet exhaust the market. Later named additions should include at least:

- artisan/craft seller;
- suspicious or dubious game operator;
- specialist repair/maintenance figure;
- transient merchant whose annual presence is not guaranteed.

## Boundary

This is not a merchant simulator, auction engine, dynamic market model, or universal bargaining framework. Commerce is authored world interaction with enough state to make prices, stock, products, and people believable.
