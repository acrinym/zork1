# Playtest — locked Release 1293 (2026-08-30)

**Story played:** `zork1-glulx-honest-system-recap.ulx`  
**SHA-256:** `79196c07694bda604c283ae2b1da19dfad77aaef5b72b035ff4a99f2f237d641`  
**Checksum:** `0xb8e24a15`  
**Size:** 548864  
**Interpreter:** CheapGlk `14d8aaf6` + Glulxe `56ab8743` built locally for Windows  
**Hosted qualify:** `33304925760`  
**Never mutate:** `historicalsource/zork1`

This was a live play of the locked 1293 artifact downloaded from PR #88, not a restore of an old save.

## What 1293 fixed

- Fresh `LOOK` / `RECAP` at West of House: “No major persistent change has been established yet.” No dossier, regional-file, playback, house-risk, cellar, or correspondence architecture.
- Behind House `south` / `east` / `open window` / `enter` / `RECAP` names the open kitchen window and using the house as a place. Still no House-of-Records architecture.

## Still open, recorded as 1294

- `EXAMINE TREE` at North of House: “You can't see any tree here!”
- `EXAMINE TREES` already reaches the FOREST local-global (“Pines and hemlocks crowd together…”). Singular TREE was missing from that room’s GLOBAL list.
- Behind House prose names old foundation stone; that noun is 1294, not 1293.
- West of House already describes wild grass, weathered boards, and settled silence; those nouns are 1295.

## Not in scope

- No GUI, DRAW, or illustrated frontend.
- No LLM-in-game. Mara stays one authored person.
- Do not steal 1280–1292.
