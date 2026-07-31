# Cuisine, Hunger, Satiation, and Stamina

## Status

Future-design material for the **Highly Extended Zork** lane.

This document does not create implementation beads, retroactively alter the completed House of Records program, or claim product progress. The system should be promoted into a complete player-facing train only after Justin explicitly chooses it for implementation.

## Vision

Food in an expanded Zork should create decisions, discoveries, humor, and stories.

It should not become a generic survival meter, a repetitive command tax, or a reason to interrupt exploration every few turns. Hunger should move slowly. Satiation and stamina should be distinct. Meals should matter because of their ingredients, preparation, provenance, circumstances, and relationship to the world—not because the player is servicing an always-visible bar.

The inspiration partly resembles the experimental cooking freedom of *Breath of the Wild* and *Tears of the Kingdom*, but the result must remain unmistakably Zork:

- parser-first interaction;
- authored consequences;
- strange but understandable ingredient behavior;
- objects with real custody and history;
- recipes discovered through evidence and use;
- memorable failures;
- regional culture and Great Underground Empire lore;
- humor that comes from the world rather than generic item rarity;
- no grinding for stacks of nearly identical meals.

## Core guardrail

> **Food must create decisions, discoveries, humor, and stories—not repetitive eating chores or generic survival meters.**

This rule outranks numerical completeness.

If a mechanic makes the player repeatedly eat ordinary food without producing a meaningful choice, discovery, consequence, or scene, that mechanic should be removed or collapsed into a slower and more legible state change.

## Why food belongs in Highly Extended Zork

The original world already contains kitchens, containers, water, plants, creatures, strange substances, hostile environments, physical exertion, magical effects, and objects whose circumstances matter.

A cuisine system can connect these existing strengths:

- fishing produces specimens that may be released, studied, donated, preserved, sold, or cooked;
- museum research can identify edible species, historic preparations, contaminants, and disputed classifications;
- regional travel introduces local ingredients and customs;
- exertion gives meals situational value without turning the game into constant maintenance;
- provenance changes what a meal means and sometimes what it does;
- correspondence, old books, NPC testimony, and experimentation reveal recipes;
- preparation creates parser interaction and comic failure;
- preserving food makes long expeditions possible without demanding routine micromanagement.

Food is therefore a world-connection system, not a detachable crafting menu.

## Ingredient families

Ingredients should remain real objects or object families with authored properties.

### Fish and aquatic life

Possible sources include rivers, reservoirs, underground waters, mine pools, magical runoff, wells, temporary floodwater, and living museum research.

Relevant traits may include:

- freshwater, brackish, cave-adapted, or magically altered;
- lean, oily, bony, gelatinous, armored, venomous, or heat-retaining;
- clean, muddy, polluted, ash-exposed, Hades-warmed, rainbow-touched, or parasite-bearing;
- fresh, live, dead, spoiled, smoked, salted, dried, pickled, or frozen;
- juvenile, spawning, ancient, unusually large, scarred, diseased, or otherwise exceptional.

A rare specimen should never silently become “one fish ingredient.” Its identity and acquisition history remain available to the cooking system.

### Plants and fungi

Examples may include:

- ordinary herbs, roots, berries, greens, grains, nuts, seeds, fruit, and edible flowers;
- cave mosses and underground tubers;
- mushrooms with culinary, poisonous, medicinal, hallucinatory, magical, or uncertain properties;
- leaves and sap whose effects depend on season or preparation;
- cultivated plants from restored gardens, abandoned settlements, monastery plots, or future regional farms;
- species whose museum classification changes after better evidence appears.

Edibility should be learned through credible evidence, not universal player knowledge.

### Pantry goods

Ordinary food keeps the system grounded:

- flour, meal, bread, biscuits, crackers, rice, oats, beans, lentils, noodles, and preserved grains;
- salt, sugar, honey, vinegar, oil, butter, milk, cheese, eggs, broth, tea, coffee, spices, and dried herbs;
- canned, jarred, smoked, salted, fermented, or pickled goods;
- forgotten royal stores, expedition rations, tavern supplies, House pantry goods, and suspiciously permanent cellar provisions.

Ordinary ingredients may be strategically valuable because they stabilize, dilute, preserve, bind, sweeten, or make stranger materials edible.

### Magical ingredients

Magical ingredients should have authored relationships rather than generic “magic power.”

Examples:

- rainbow-touched scales that react to light and carried treasure;
- Hades-warmed water or fish that retain heat unnaturally;
- dust, residue, nectar, sap, salt, ash, or crystal fragments tied to actual events;
- ingredients affected by ceremony evidence, curses, dreams, portals, time distortion, or impossible geography;
- foods prepared in a particular place, vessel, weather condition, or world state.

Their effects may be beneficial, harmful, ambiguous, symbolic, or purely narrative. Not every magical ingredient should produce a combat advantage.

### Creature-derived materials

Creature-derived food must be handled carefully and specifically.

Possible materials include:

- eggs, milk, shed material, honey-like secretions, discarded fat, edible tissue, shell, marrow, gelatin, or naturally abandoned stores;
- portions taken from creatures already defeated through canonical play;
- materials acquired through trade, gift, scavenging, or historic preservation;
- troll-related, bat-related, subterranean, reptilian, avian, insect, or other regional materials where the fiction supports them.

The system should distinguish between cooking a creature-derived ingredient, preserving it as evidence, donating it, returning it, refusing it, or discovering that it was never edible.

## Ingredient identity and provenance

Every meaningful ingredient should preserve enough history to support later consequences.

Relevant evidence may include:

- species or object identity;
- place and water body of origin;
- date, time, weather, season, and world state;
- who found, caught, grew, purchased, stole, gifted, or prepared it;
- previous custody;
- bait, trap, tool, harvesting method, or preparation method;
- exposure to fire, cold, flood, ash, pollution, magic, Hades, rainbow effects, combat, theft, repair, or ceremony;
- freshness, contamination, damage, disease, parasites, and preservation state;
- whether the item is ordinary, unusual, unique, historically significant, or disputed.

Provenance is not merely decorative text. It may affect flavor, safety, museum value, NPC response, recipe discovery, legal ownership, magical behavior, and whether cooking the item is a regrettable act.

## Preparation and cooking methods

The player should be able to express intentions naturally without performing meaningless kitchen busywork.

### Basic preparation

- wash, rinse, soak, drain, peel, shell, gut, bone, trim, slice, chop, grind, mash, mix, season, stuff, wrap, strain, or portion;
- inspect for spoilage, parasites, contamination, hidden objects, magical residue, or misidentification;
- keep an ingredient whole when its identity or appearance matters;
- prepare one component while leaving another untouched.

### Heat and cooking

- boil, simmer, steam, fry, roast, bake, grill, toast, sear, stew, smoke, or warm;
- cook over an ordinary fire, stove, oven, heated stone, geothermal source, magical flame, or Hades-adjacent heat;
- control broad states such as raw, warmed, cooked through, browned, charred, reduced, or burned without forcing the player to manage exact seconds.

### Preservation

- salt, brine, pickle, ferment, dry, smoke, cure, sugar, jar, cool, freeze, seal, or store in oil;
- preserve a scientific sample separately from the edible portion;
- keep a specimen alive rather than preserve it;
- ruin provenance by careless processing—or preserve it through documented preparation.

### Serving and sharing

- serve a portion, divide a meal, pack it for travel, offer it to an NPC, leave it for a creature, present it ceremonially, submit it to the museum, or keep it as evidence;
- eat immediately or allow a dish to rest, cool, mature, ferment, or become dangerous;
- identify who prepared each stage of a collaborative meal.

The parser should understand complete intentions such as:

- `CLEAN THE SILVERFIN AND SAVE THE SCALES`
- `STEW THE MUSHROOMS WITH ONION AND BROTH`
- `SMOKE HALF THE EEL AND REGISTER THE OTHER HALF`
- `ASK THE CURATOR WHETHER THE PALE CAP IS EDIBLE`
- `PACK TWO BISCUITS AND THE PICKLED ROOTS`
- `SERVE THE HOT STEW TO THE BOATMAN`

## Four distinct body states

The system should avoid collapsing every physical condition into one number.

### Hunger

Hunger represents slow nourishment need.

It should:

- change over long spans, journeys, sleep, and major exertion rather than every few turns;
- begin as subtle descriptive context;
- affect recovery, patience, warmth, concentration, and long-duration performance before causing severe consequences;
- be satisfied by actual nourishment rather than any consumable object;
- remain mostly invisible unless the player checks himself, notices symptoms, discusses food, or enters a context where hunger matters.

Ordinary exploration should not be interrupted by repeated “you are hungry” messages.

### Satiation

Satiation represents how recently and substantially the player has eaten.

It is not the same as nutrition or stamina.

A heavy meal may:

- suppress hunger for a long time;
- make immediate climbing or swimming less comfortable;
- improve warmth and later recovery;
- create social or narrative opportunities;
- cause sleepiness, thirst, or comic overconfidence.

A small but concentrated ration may provide less satiation while remaining useful during travel.

### Stamina

Stamina represents immediate capacity for exertion.

It may fall through:

- swimming against current;
- climbing, hanging, crawling, or repeated jumping;
- rowing, pumping, digging, hauling, or forcing mechanisms;
- carrying excessive weight;
- combat, pursuit, rescue, or retreat;
- cold, heat, smoke, injury, bleeding, illness, radiation-like exposure, or magical strain.

Stamina should recover through rest, safety, warmth, hydration, food where relevant, treatment, and reduced burden.

Eating should not act as an instant universal stamina potion. Some foods help later recovery; some portable foods provide modest immediate support; some meals make exertion temporarily worse.

### Condition

Condition covers injuries, illness, poisoning, contamination, temperature stress, intoxication, and other authored physical states.

Food may interact with condition, but should not erase it through generic bonuses. A broth can help cold and exhaustion; it should not cure a broken limb. A bitter fungus may reduce one poison while causing confusion. A contaminated fish may create a new problem despite being filling.

## Exertion and contextual need

Food matters most when the player has a reason to plan.

Examples:

- pack a dense ration before a long underground expedition;
- choose warm stew before entering a freezing region;
- avoid a huge meal immediately before swimming the river;
- bring salted food but also enough water;
- preserve catches because the return route is long;
- share food with an exhausted NPC instead of consuming it;
- use a sugary or caffeinated item for a brief alertness window followed by an authored consequence;
- recognize that injury, heat, cold, fear, magical strain, and carried weight alter stamina independently of hunger.

These decisions should appear at meaningful thresholds, not as constant optimization.

## Meals and contextual effects

Meals should emerge from understandable ingredient and preparation relationships.

Possible dimensions include:

- nourishment;
- satiation;
- portability;
- hydration or thirst;
- warmth or cooling;
- ease of digestion;
- immediate alertness or later fatigue;
- recovery support;
- contamination risk;
- smell and its effect on creatures or stealth;
- social meaning;
- ritual meaning;
- museum or historical value consumed in the process;
- magical interaction tied to real ingredient history.

Effects should be phrased through the fiction whenever possible.

Instead of:

> +20 cold resistance for five minutes.

Prefer:

> The pepper-root broth leaves a steady heat behind your ribs. The wind still cuts at your face, but your hands stop trembling enough to work the latch.

The underlying system may remain deterministic, but the player encounters it as authored world behavior.

## Combination logic

The system should support experimentation without producing arbitrary sludge from every inventory combination.

A dish can be derived from:

1. a **base form** such as broth, stew, loaf, pie, roast, fry, porridge, pickle, tea, ration, sauce, filling, or wrapped parcel;
2. a **primary ingredient** that defines identity;
3. supporting ingredients that change texture, preservation, flavor, nutrition, or effect;
4. a preparation method;
5. cookware and heat source where materially relevant;
6. ingredient condition and provenance;
7. player knowledge and execution quality;
8. location, weather, time, and world state where authored.

Not all combinations deserve unique names. The game can identify a broad form while preserving notable details:

> a smoky cave-minnow and onion stew

A historically correct, regionally recognized, magically significant, or spectacularly failed dish may earn a proper name.

## Recipe discovery

Recipes should be learned through the world rather than exposed as a complete checklist.

Sources include:

- direct experimentation;
- NPC instruction, demonstration, argument, or correction;
- cookbooks, household notes, expedition journals, monastery records, tavern ledgers, royal menus, graffiti, marginalia, and damaged fragments;
- museum research on species, toxicity, preservation, and historic diets;
- correspondence with scholars, cooks, travelers, fishermen, healers, and eccentrics;
- dreams earned from relevant discoveries;
- observing what creatures eat;
- tasting a dish and identifying only part of it;
- preparing a dish successfully without knowing its formal name;
- reconstructing a regional recipe from several incomplete accounts.

Knowledge may remain uncertain:

- a recipe may omit a step;
- two regions may use the same name for different dishes;
- a royal cookbook may conceal a common origin;
- a poisonous ingredient may become safe only after a specific preparation;
- a museum label may be revised;
- an NPC may confidently be wrong.

## Regional cuisine

Food should help the Great Underground Empire feel geographically and culturally coherent.

Possible traditions include:

- dam-worker stews built from preserved fish, onions, and hard bread;
- forest foods using nuts, berries, mushrooms, herbs, roots, and smoked catches;
- underground miner meals designed for darkness, cold, dust, and long shifts;
- river settlements centered on eels, pickles, reeds, grain, and ferry trade;
- royal cuisine that transforms common ingredients through ceremony, waste, and elaborate naming;
- monastery preserves, medicinal broths, fasting foods, and disputed sacred recipes;
- Hades-adjacent dishes served hot for reasons no living cook fully explains;
- expedition rations that reveal which routes, hazards, and cultures their makers expected.

Regional dishes can reveal migration, trade, class, religion, disaster, occupation, and political history without requiring an exposition dump.

## Memorable failed dishes

Failure should create specific outcomes rather than a generic “bad meal.”

Possible failures include:

- a loaf dense enough to operate a pressure plate;
- a stew whose smell attracts something from several rooms away;
- a fermented jar that becomes evidence in a minor geological event;
- a beautiful pie containing the one mushroom everyone forgot to identify;
- a fish roasted with its stolen coin still inside;
- a royal sauce reconstructed from a damaged recipe that was actually furniture polish;
- a Hades-warmed chowder that refuses to cool and eventually burns through an unsuitable container;
- a rainbow dish whose colors move to whichever diner is lying;
- a meal that is safe, nutritious, and absolutely rejected by every known civilization.

Failed dishes may be edible, useful, dangerous, collectible, weaponizable, museum-worthy, socially catastrophic, or the beginning of a better recipe.

The player should often be able to inspect, salvage, dilute, recook, repurpose, document, or dispose of a failure rather than simply losing ingredients.

## Rare-specimen decisions

A rare catch or ingredient should create a real choice.

The player may:

- release it alive;
- donate it to a living exhibit;
- register and release it;
- preserve it as a specimen;
- provide a small tissue, scale, spore, or residue sample;
- sell or trade it;
- use it as bait;
- research its edibility;
- cook it;
- serve it to someone with cultural or personal knowledge;
- keep it for a future expedition, ritual, cure, or puzzle;
- discover that it contains another object or is evidence of a larger event.

The game should not moralize every decision through a universal meter. Consequences arise through ecology, custody, law, relationships, research, scarcity, and the player's own priorities.

Cooking a unique specimen may permanently close one line of study while opening a culinary, social, magical, or historical line. Registering it first may preserve some evidence but not all. Donating it may create future access without leaving it in the player's inventory.

## Museum relationship

The museum and cuisine systems should exchange evidence without becoming the same system.

The museum may:

- identify species and contaminants;
- preserve samples before cooking;
- document historic cookware and regional meals;
- maintain disputed edibility records;
- sponsor culinary reconstruction from archaeological evidence;
- host temporary exhibits, tastings, lectures, arguments, and disasters;
- revise plaques after the player demonstrates preparation behavior;
- record that a unique specimen was eaten rather than acquired.

The kitchen may reveal evidence the museum could not obtain through static inspection:

- hidden bones, seeds, parasites, objects, layers, pigments, residues, or transformations;
- safe and unsafe preparation thresholds;
- smells that attract or repel creatures;
- historical combinations preserved only in practice;
- magical effects activated by heat, fermentation, sharing, or sequence.

## House relationship

The House can later support cuisine without reopening the completed House of Records program as a food train.

Future possibilities include:

- a pantry with real stock and storage conditions;
- recipes recovered through House correspondence and records;
- meals associated with visitors, repairs, weather, danger, celebrations, or mourning;
- evidence of who cooked, ate, refused, spoiled, stole, or replaced food;
- damage from smoke, pests, damp, broken windows, power loss, or magical intrusion;
- preserved meals that carry House chronology into later expeditions.

These are future integration points only. They should not be backfilled into the completed House lineage unless deliberately promoted through a new post-House product train.

## Parser and presentation

The parser remains authoritative.

Useful commands may include:

- `CHECK HUNGER`
- `CHECK STAMINA`
- `EXAMINE THE STEW`
- `SMELL THE PALE MUSHROOM`
- `ASK MARTHA ABOUT PICKLING EELS`
- `PREPARE THE FISH FOR SMOKING`
- `COOK THE ROOTS WITH BUTTER`
- `SAVE A SCALE SAMPLE`
- `PACK FOOD FOR THE EXPEDITION`
- `OFFER THE BISCUIT TO THE TROLL`
- `READ THE DAM-WORKER RECIPE`
- `COMPARE THIS BROTH WITH THE MUSEUM RECORD`

Optional Glulx windows may show:

- discovered recipe relationships;
- ingredient condition and known risks;
- pantry or travel provisions;
- broad hunger, satiation, stamina, and condition states;
- meal provenance;
- regional cuisine maps;
- museum culinary records.

The same information must remain available through text. The interface should not reveal unknown ingredients, hidden effects, exact timers, or recipes the player has not earned.

## Canonical and product safeguards

The system must not:

- duplicate canonical unique objects as ingredients;
- consume puzzle-critical objects without clear warning and authored consequence;
- fabricate specimens detached from ecology and world state;
- erase custody, theft, score, or provenance history;
- turn every creature into loot;
- make ordinary exploration depend on constant food consumption;
- reduce all meals to interchangeable buff packages;
- expose a complete recipe checklist before discovery;
- reward grinding the same easy ingredient loop;
- let food trivially cure serious injury, poison, magical harm, or environmental danger;
- force the player to choose food systems in order to complete original Zork puzzles unless a future authored expansion explicitly establishes that dependency.

## Candidate first implementation train

When this concept is promoted, the first train should prove a complete small loop rather than build a giant ingredient database.

A credible candidate would include:

1. one working kitchen or camp preparation location;
2. a small set of ordinary pantry goods;
3. two fish or plant families already connected to a real ecology;
4. washing, cutting, heating, combining, eating, packing, and preserving;
5. slow hunger, separate satiation, and exertion-based stamina;
6. one regional recipe discovered from evidence;
7. one improvised successful meal;
8. several specific failure outcomes;
9. museum registration or sample preservation before cooking;
10. provenance-aware meal descriptions;
11. save/restore continuity;
12. parser-complete play without optional visual windows.

The House dependency is already closed in Release `1230`. This cuisine train should be designed only after Justin explicitly promotes Highly Extended Zork from idea lane to product lane and after the museum and ecology systems provide real ingredients, research, and specimen choices.

## Promotion rule

This document records direction, constraints, and possibilities.

It is not a backlog, completion claim, or hidden extension of the House bead hierarchy. Implementation begins only when the concept is selected, dependencies are resolved against the live repository, and a complete product train is deliberately created.