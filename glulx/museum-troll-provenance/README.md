# Release 1241 — Museum Troll Provenance

Release 1241 gives the canonical troll encounter a lasting physical consequence without replacing combat or turning monsters into a collection checklist.

## Player route

1. Enter the Troll Room through the canonical Cellar route.
2. Resolve the existing troll fight.
3. When the real troll is first rendered unconscious or killed, one coarse iron-grey tuft falls in the room.
4. Recover that physical tuft.
5. Carry it to the Living Room and `EXHIBIT FUR` in the Creatures and Monstrous Zoology case.
6. The Living Room description points to a small provenance plaque beside the case, so `READ TROLL PLAQUE` is discoverable during ordinary play.
7. `CATALOG CREATURES` or `READ TROLL PLAQUE` reports whether the trace came from:
   - a subdued, still-living troll whose unconsciousness opened the passages; or
   - a confirmed kill after the bloody axe fell.
8. Take the tuft back from the case normally. The exhibit immediately admits that the real trace is outside museum custody.

## Consequence

The museum does not flatten every troll encounter into the same trophy story. The canonical combat outcome determines the historical provenance.

Only the first real trace is created. If the troll later revives or suffers another combat transition, the already shed tuft is not duplicated or rewritten into a different history.

## Physical authority

- The original troll remains the only creature and combat actor.
- The original `TROLL-FCN` death and unconscious modes remain outcome authority.
- `TROLL-FLAG` remains passage authority.
- The original axe remains the only axe and retains its normal custody behavior.
- The tuft exists once and falls in the actual Troll Room.
- The Creatures case and plaque read the tuft's real object location.
- One bounded saveable table stores only the historical outcome that produced that same physical trace.

## Natural-play correction

A review found that the provenance plaque worked but was hidden from room listings, leaving ordinary players no reason to try reading it. The Creatures case description now explicitly mentions the nearby plaque. The corrected build was replayed through both subdued and killed troll routes before its artifact identity was relocked.

## Release artifact

- File: `zork1-glulx-museum-troll-provenance.ulx`
- Release: `1241`
- Serial: `260802`
- Format: Glulx
- Version: `0x00030103`
- Size: `366848` bytes
- Checksum: `0xec89dfcd`
- SHA-256: `95f5d3428b366cbae6bf5c83eccb750caeea2fe1d747b83a1112dee18eb3263f`

## Boundaries

- no combat rewrite or replacement fighting routine;
- no generic monster, bestiary, specimen, or trophy engine;
- no monster checklist or procedural creature variants;
- no second troll, axe, corpse, tuft, or substitute specimen;
- no remote donation or abstract collection registry;
- no altered passage, weapon, resurrection, or combat-probability behavior;
- no audit framework or recursive development machinery.
