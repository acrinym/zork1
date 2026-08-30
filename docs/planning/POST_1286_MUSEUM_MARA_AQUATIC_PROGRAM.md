# Post-1286 — Living Collection & Companionship

**Captured:** 2026-08-30  
**Updated:** 2026-08-30  
**Status:** Implemented as Release **1304** (planning ids 1287–1292, one locked story). Runtime numbers **1280–1292 stay reserved** and are not stolen.  
**Train:** `glulx/living-collection/`  
**Writable repo:** `acrinym/zork1` only. Never `historicalsource/zork1`.

This is the player-facing program after the runtime foundation. It deepens the museum, dam waters, and Mara as a person. It is not a GUI, not photographs, not DRAW, and not an illustrated frontend.

Release 1277's instant camera stays as already shipped in-world objects. Do not grow it into a gallery, renderer, or picture UI.

## Why this program exists

Releases 1233, 1239–1241, 1243–1244, and 1258–1261 already made the Living Room a museum and Mara a companion with field knowledge. The 1245 playtest showed players still reach for those systems: fishing, exhibits, asking Mara, breaking the jar. 1278 authors jar shatter. The next product work should answer those same instincts with more world, not a new interface.

## Hard boundaries

- parser commands and Glulx prose only;
- exact object identity; no copied fish, no checklist currency;
- Mara remains one authored human: no quest log, approval meter, maid skill tree, or omniscient hint UI;
- no generic fishing engine, aquarium simulator, or species generator;
- no generic smash/durability engine beyond authored seams;
- each release below is a whole coherent player capability, not a slice.

## Ordered whole trains

### Release 1287 — Second Water / Reservoir Fishery

The River Frigid silverfin remains the 1239 species. This train adds **one** authored second fish from Reservoir water, with variety driven by existing water-level/dam state, caught with the same rod and smashable field jar.

Player outcome: `FISH` at Reservoir produces a different real animal; `RELEASE` vs `EXHIBIT` still moves that exact object; smashing the jar on the way home has the 1278 consequence.

### Release 1288 — Mara as Collection Witness

Mara only knows a catch, release, or exhibit she physically witnessed or was told in-world. `ASK MARA ABOUT SILVERFIN` after a solo catch she did not see is honest ignorance, not a hint dump.

Player outcome: bringing Mara on a fishing trip changes what she can later say, refuse, or help with at the case.

### Release 1289 — Living Waters Husbandry

The circulating case stays a real vessel. Dam state, missing water, a smashed jar, or an absent specimen change the exhibit. This is not an aquarium hunger meter.

Player outcome: the Waters of the Empire case can be healthy, empty, or ruined for authored physical reasons the player can explain.

### Release 1290 — Mara House Stewardship

Mara uses the Kitchen, Bedroom, Attic, and museum as a person who lives there: she may prepare, file, rest, or object to a disturbance she actually saw. She does not become a commandable house-cleaner.

Player outcome: `ASK MARA TO...` in the house is an autonomous decision using 1277 consent, not furniture teleports.

### Release 1291 — Specimen Custody & Return

Real objects move on loan or return the way the songbird feather can return to the nest. A displayed silverfin can be carried back to its water and released; the plaque records absence, not a clone.

Player outcome: custody is geography plus the object tree, never a menu.

### Release 1292 — Mara Agreed Field Errands

Mara can leave on a purpose both people agreed to, using Release 1276 field guidance, and return with real objects or news. No quest markers.

Player outcome: `ASK MARA TO TAKE THE JAR TO THE DAM` is a credible errand only if she knows the route and accepts it.

## Explicitly not this program

- Illustrated Zork, `DRAW`, computer vision, book layout, or any GUI.
- Expanding 1277 photographs into a picture browser.
- Chronicle export (that is Release 1286, runtime-side, opt-in, local).
- Stealing 1280–1286 numbers from the runtime foundation queue.

## Live numbering

Justin authorized building this program before 1286. The six capabilities ship as **Release 1304** so 1280–1292 remain the runtime reservation. Filenames and section headings below keep 1287–1292 so old links resolve.

## Promotion rule

Superseded 2026-08-30: implementation is Release 1304 on `acrinym/zork1`. Do not reuse 1287–1292 as live release ids.
