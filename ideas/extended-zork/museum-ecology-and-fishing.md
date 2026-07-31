# Museum Ecology and Fishing

## Vision

Create a real Great Underground Empire museum that grows from the player's discoveries.

The museum should combine the emotional reward of donating to the museum in Animal Crossing with Zork's stronger parser interaction, object history, world consequences, humor, and Glulx presentation options.

Fishing is the first deep natural-history system because it can produce many meaningful discoveries from different places and circumstances without requiring every specimen to be a completely unrelated hand-authored object.

The target feeling is closer to discovering varied life across No Man's Sky than catching the same three generic fish everywhere—but with authored Zork logic, readable ecology, and memorable provenance instead of arbitrary procedural names.

## The museum loop

1. Discover a specimen, artifact, trace, or record.
2. Recover, catch, collect, document, or witness it through real play.
3. Bring the evidence to the museum or contact its staff.
4. Donate, loan, register, compare, or submit it for research.
5. Watch the museum physically and textually change.
6. Revisit the exhibit and read what is currently known.
7. Find related specimens, unusual variants, or contradictory evidence.
8. Unlock research questions, correspondence, visitors, expeditions, and museum events.

## Contribution types

### Donation

The museum receives and keeps the real object or preserved specimen.

### Loan

The museum displays the real object temporarily. The player may reclaim it through an authored process, and the exhibit records that it is currently absent or represented by a substitute.

### Registration

The museum documents an item without taking it. Useful for essential tools, unique treasures, dangerous objects, living creatures, or objects whose custody must remain elsewhere.

Registration may create:

- a drawing;
- a rubbing;
- measurements;
- a cast;
- a photograph or magical image;
- a witness statement;
- a replica;
- a residue sample;
- a field-note transcript.

### Comparative submission

A second specimen may improve or complicate an existing exhibit rather than being rejected as a useless duplicate.

## Aquatic ecology model

A catch is not determined by location alone. It is produced from several authored dimensions.

### Water body

Examples:

- Flood Control Dam #3 reservoir;
- river below the dam;
- water above the dam;
- forest stream;
- underground river;
- stagnant mine pool;
- cellar seep or temporary floodwater;
- Hades-adjacent water;
- rainbow-touched runoff;
- a restored fountain, canal, well, or future regional waterway.

Each water body has its own base ecology and may change after player actions.

### Local conditions

- depth;
- current speed;
- water temperature;
- clarity or turbidity;
- time of day;
- rain, drought, flood, or recent storm;
- dam gate position;
- nearby light or darkness;
- season or long-running game chronology;
- bait, lure, hook, net, trap, or hand collection method.

### World-state conditions

- the dam has been opened, closed, repaired, or disturbed;
- upstream objects or substances entered the water;
- a magical event altered the area;
- a creature migrated, died, or was removed;
- a route to an underground habitat opened;
- fire, ash, blood, oil, vegetation, treasure, or ritual residue contaminated the water;
- the player previously overfished or restored a habitat;
- a major regional event changed temperature, light, current, or access.

### Specimen condition

- juvenile, adult, ancient, spawning, injured, diseased, parasitized, or recently fed;
- ordinary, unusually large, unusually small, pale, dark, translucent, metallic, rainbow-touched, Hades-warmed, cave-adapted, flood-carried, or scarred;
- alive, dead, preserved, cooked, damaged, contaminated, or only observed;
- caught cleanly, netted, stranded, found in another creature, purchased, stolen, gifted, or recovered from a historical container.

## Species families and varieties

The game should use authored species families with understandable varieties.

A family defines the creature's identity, behavior, habitat range, base description, and museum relationship. A variety reflects the conditions under which that individual developed or was found.

Example families:

| Species family | Typical habitat | Distinguishing behavior |
|---|---|---|
| Dam silverfin | reservoir and spillway | flashes near moving machinery and avoids still water |
| Blind cave minnow | underground river and mine pools | follows vibration rather than light |
| Floodgate eel | deep dam channels | appears when gates or currents change |
| Forest glassperch | clear shaded streams | nearly transparent except after feeding |
| Sootbelly carp | ash-contaminated or fire-affected water | survives poor water and accumulates dark residue |
| Royal mudskipper | banks, drains, and exposed mud | leaves water and steals small bright objects |
| Styx emberfish | Hades-adjacent water | remains warm after removal and reacts to ceremony evidence |
| Rainbow scale | magically altered runoff | changes color according to nearby light and carried objects |

Example varieties:

- spillway silverfin;
- deep-reservoir silverfin;
- post-flood silverfin;
- lantern-pale cave minnow;
- iron-water cave minnow;
- gate-scarred floodgate eel;
- soot-blackened glassperch;
- rainbow-touched mudskipper;
- Hades-warmed eel;
- trophy-sized royal mudskipper carrying a stolen coin.

A variety should have a reason the player can eventually understand. The museum may initially misclassify it, argue about it, or revise the plaque when better evidence arrives.

## Catching and observing

Fishing should support more than a single `FISH` command.

Possible actions:

- examine water;
- listen near water;
- test depth;
- use bait on hook;
- cast toward reeds, current, shadow, deep water, or machinery;
- wait briefly or abandon the attempt;
- use a net, trap, jar, bucket, line, improvised tool, or bare hands where plausible;
- release a specimen;
- keep it alive;
- preserve it;
- sketch or register it without capture;
- compare tracks, scales, eggs, nests, bite marks, or remains.

The parser should accept natural intentions without demanding simulationist micromanagement. Equipment and circumstances matter, but fishing must not become a repetitive maintenance minigame.

## Discovery and knowledge stages

A museum record can grow through stages:

1. **Reported** — rumor, witness account, old text, or curator suspicion.
2. **Observed** — the player has actually seen the creature or trace.
3. **Registered** — a credible description, sketch, measurement, or sample exists.
4. **Acquired** — a real specimen or sufficient physical evidence is in museum custody.
5. **Compared** — multiple specimens establish variation or challenge the classification.
6. **Researched** — behavior, habitat, and relationships are supported by evidence.
7. **Living exhibit or complete study** — the museum can present the species in a richer habitat display or authoritative exhibit.

The game should never mark a species fully understood merely because one generic specimen was donated.

## Provenance-aware plaques

Each exhibit should remember the real specimen history.

Example:

> **SPILLWAY SILVERFIN**  
> Donated by the Adventurer.  
> Caught below Flood Control Dam #3 after the western gate was opened. The specimen carries a healed lateral scar and traces of brass filings. Its unusually broad tail may be an adaptation to the accelerated current, though Professor Wurbish disputes this.

Another player or another playthrough may produce:

> **RESERVOIR SILVERFIN**  
> Registered from a live specimen and released. Observed before the floodgates were disturbed. The museum displays a scale cast, field sketch, and water sample rather than the animal itself.

The plaque is generated from authored evidence fields, not invented prose detached from game state.

## Museum galleries

Possible sections:

- Waters of the Empire;
- Forest and Surface Life;
- Creatures and Monstrous Zoology;
- Geology, Metals, and Subterranean Formations;
- Artifacts of the Great Underground Empire;
- Hades and Ceremonial Evidence;
- Anomalies and Unexplained Phenomena;
- Expedition History;
- Temporary and Disputed Exhibits.

The aquatic gallery may begin as jars and labeled trays, then expand into tanks, habitat cases, flowing channels, maps, and living exhibits.

## TUI and Glulx 2D presentation

The museum remains navigable through parser rooms and commands, but Glulx can add a persistent visual layer.

Example compact gallery view:

```text
┌────────────────────────────────────────────────────────────┐
│ WATERS OF THE GREAT UNDERGROUND EMPIRE                     │
├──────────────────┬──────────────────┬──────────────────────┤
│ Dam Silverfin    │ Blind Cave       │ Floodgate Eel        │
│ 3 varieties     │ Minnow           │ observed only        │
│ COMPLETE? NO     │ 2 specimens      │ no specimen          │
├──────────────────┼──────────────────┼──────────────────────┤
│ Forest Glassperch│ Unknown Trace    │ Royal Mudskipper     │
│ live exhibit     │ lower spillway   │ carrying coin        │
└──────────────────┴──────────────────┴──────────────────────┘
```

A 2D interpreter may show:

- tanks, cases, shelves, silhouettes, and habitat backdrops;
- donated specimens and unresolved empty spaces;
- icons for observed, registered, acquired, compared, and researched status;
- selectable specimens and plaques;
- region maps linking catches to water bodies;
- visual differences between varieties;
- museum growth over time.

Text commands remain complete equivalents:

- `VIEW AQUATIC GALLERY`;
- `READ SILVERFIN PLAQUE`;
- `COMPARE THE TWO MINNOWS`;
- `ASK CURATOR ABOUT THE SPILLWAY TRACE`;
- `CHECK MISSING DAM RESEARCH`;
- `REGISTER THE EEL SKETCH`;
- `DONATE TROLL FUR`;
- `LOAN THE SCEPTER`.

## Rewards and consequences

Museum progress may produce:

- revised encyclopedia entries;
- curator dialogue and scholarly disputes;
- correspondence from specialists and collectors;
- maps, permits, equipment, containers, preservation tools, or research access;
- invitations to investigate related habitats;
- visitors attracted by a specific exhibit;
- theft, fraud, misidentification, damage, escape, or containment incidents;
- new museum rooms and public reputation;
- clues that emerge only after several exhibits are compared.

Rewards should deepen exploration rather than reduce the museum to a currency dispenser.

## Avoiding checklist design

The museum should preserve mystery.

Early display:

> Three aquatic specimens are documented from the dam region. The curator believes at least one deep-water animal remains unaccounted for.

Later, after research:

> Evidence suggests an elongated predator enters the western channel only when the lower gate remains open after dark.

The game reveals increasingly useful categories based on earned knowledge. It does not expose a complete global shopping list at the beginning.

## Duplicate value

Additional specimens may:

- establish sex, age, growth, or habitat differences;
- reveal a new variety;
- improve a poor or damaged display;
- contradict the current plaque;
- support a living breeding or observation program;
- be exchanged with another institution;
- be returned to the environment;
- expose contamination, disease, migration, or a world-state change.

A second fish is not automatically valuable, but it is not automatically trash.

## Relationship to House memory

The museum is the public, curated face of discovery.

- The House remembers what crossed its threshold.
- The Attic preserves physical records and evidence.
- The Bedroom processes actual discoveries through dreams.
- The museum displays what can be documented and interpreted.
- Correspondence brings outside claims.
- Regional case files preserve expedition context.

These systems may disagree without any one of them inventing false canonical state.

## First future complete product candidate

When this idea is eventually promoted, a complete first museum product could include:

- one accessible museum building or expanded House collection;
- one curator with real dialogue and state;
- donation, loan, registration, and comparison actions;
- several non-aquatic specimens already available in the canonical world;
- a complete Flood Control Dam #3 aquatic collection with multiple species families and condition-driven varieties;
- provenance-aware plaques;
- parser-complete gallery navigation;
- an optional Glulx TUI gallery;
- museum persistence through native save and restore;
- at least one research question and one museum event caused by actual player discoveries.

That would be a full player-facing system, not a disposable prototype and not a hidden sub-bead attached to the House train.