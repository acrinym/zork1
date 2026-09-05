# Flathead Fair products and zorkmid economy

**Status:** STABLE FOR PLANNING

## Currency law

Normal fair commerce uses **zorkmids (`zm`)**. Midway prize tickets may exist as a separate earned reward currency, but tickets never replace ordinary money for food, rides, normal merchandise, services, or ordinary vendor purchases.

The Flathead Fair is the first strong practical purchasing-power reference for the broader Highly Extended Zork economy without becoming a full economic simulation.

## Source boundary

The original Zork I source gives us real money language but not a numeric everyday price table:

- the GUE Tech advertisement says successful graduates can make "really big Zorkmids";
- the Maze contains a real `BAG-OF-COINS`;
- treasure objects have `VALUE` / `TVALUE`, but those fields belong to the game's score/treasure system and are **not** a canonical zorkmid exchange rate.

Therefore the numeric purchasing-power scale below is explicit **Highly Extended authored economy**, not a claim about an original Infocom price list.

Do not convert treasure score values into zorkmids unless a later authority gives an actual in-world exchange mechanism.

## Admission decision

**General entry to the Flathead Fair grounds is free.**

Reasoning:

- the fair is a civic/social place, not a paid dungeon;
- a broke Adventurer can still walk, talk, watch, smell food, meet people, accompany Mara, and experience the grounds;
- individual commerce remains meaningful because rides, games, food, merchandise, rentals, and selected premium events cost money;
- free entry prevents romance/social/world content from being silently gated behind cash.

The fair may charge zorkmids for specific attractions or reserved/premium events. It does not charge a universal gate fee.

## Locked everyday purchasing-power bands

These bands establish relative meaning, not a real-world currency conversion:

- `1 zm`: tiny everyday purchase, cheap consumable, simple game chance, refill, bait;
- `2–4 zm`: ordinary snack, drink, small ride, common midway game;
- `5–10 zm`: substantial fair food, small souvenir, program/book, multi-use small purchase;
- `11–25 zm`: meaningful souvenir, basic clothing, toy, basic fishing gear, modest gift;
- `26–75 zm`: good clothing, durable gear, artisan item, significant gift;
- `76–250 zm`: expensive specialty/artisan purchase, fine jewelry, premium equipment;
- `251–499 zm`: exceptional fair-market purchase, serious luxury, rare specialist stock;
- `500+ zm`: major wealth expenditure, not routine fair spending.

A character can reasonably complain about 35 zm without 35 zm being life-changing wealth.

## Price laws

1. **No videogame inflation.** A snack does not cost hundreds merely because the player may later possess treasure.
2. **Price and affection are separate.** A 3-zm trinket may matter more to Mara than a 200-zm necklace.
3. **Vendors may differ.** Similar goods can have different prices based on quality, reputation, scarcity, or opportunism.
4. **Prices are speakable facts.** A vendor should be able to answer `HOW MUCH`, explain a special, or complain about a competitor.
5. **The player may be unable to afford things.** The fair does not guarantee acquisition of every item in one visit.
6. **No automatic treasure liquidation.** Valuable Zork treasure does not become pocket cash merely because commerce now exists.
7. **Money is physical/world state where practical.** Payment and change should compose whatever broader money-container authority exists rather than being a hidden fair score.

## Prize tickets

Prize tickets are **earned**, not the ordinary currency of the grounds.

Planning rules:

- games/contests may award tickets;
- tickets redeem only at designated prize counters;
- tickets do not buy food, drinks, vendor merchandise, or rides;
- tickets do not convert back into zorkmids;
- direct ticket-to-zorkmid exchange is intentionally undefined to prevent an arbitrage economy;
- major contest ribbons/trophies may be awarded directly rather than priced in tickets.

The prize catalog owns exact ticket costs.

## Product families

### Food and drink

Elephant ears, candy apples, roasted nuts, pies, pastries, fried food, savory hand foods, fruit, sweets, cider/lemonade/fizz, souvenir cups, specialty regional foods.

### Clothing and wearable souvenirs

Ribbons, caps, scarves, shirts, festival clothing, artisan pieces, annual commemorative items. These compose wardrobe authority rather than creating fair-only clothing logic.

### Toys and souvenirs

Stuffed grues, carved creatures, miniature landmarks, wind-up nonsense, toy lamps/mailboxes, whistles, fair ribbons, commemorative pieces.

### Crafts

Pottery, glass, woodwork, textiles, leather goods, metalwork, art, candles, jewelry, baskets, tools.

### Books and paper goods

Fair guide, programs, local histories, maps, cookbooks, fishing guides, songbooks, propaganda, pamphlets, used books.

### Fishing goods

Bait, hooks, lures, line, rod rental, rods, containers and derby supplies.

### Agricultural / market goods

Produce, preserves, honey, spices, flowers, seeds, crafts, and other products supported by fair lore.

### Curiosities

Puzzle boxes, old coins, strange mechanisms, dubious magical objects, fossils/minerals, unidentified junk, unusual keys, lenses, and items whose significance may emerge much later.

## Commerce agency

Mara and NPCs may spend their own money and buy things for themselves or others. The Adventurer is not the sole purchasing authority in the world.

`FAIR_PRICE_BOOK.md` owns the initial concrete planning prices.
