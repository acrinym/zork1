# Playtest — locked Release 1278 (2026-08-30)

**Story played:** `zork1-glulx-honest-playthrough-perilous-house.ulx`  
**SHA-256:** `d1d5e7487a792079135e014dcdcfa0af73219307c12fbab2ef41d6af2b5f53f1`  
**Interpreter:** CheapGlk `14d8aaf6` + Glulxe `56ab8743` built locally for Windows  
**Never mutate:** `historicalsource/zork1`

This was a live play of locked 1278, not a restore of an old save.

## What already works

- Mailbox smash with the field stone (Release 1246) still works.
- Kitchen entry is Behind House: `south`, `east`, `open window`, `enter`. West of House has no kitchen window; `open window` there correctly says you can't see any window.
- After entering, `RECAP` names the open kitchen window and using the house as a place (1278 split).
- `DRINK FROM SINK` reaches the cold tap.
- `LIE DOWN` in the forest is refused: real sleep belongs to the Bedroom upstairs.
- The living-room museum, field jar, fishing rod, sword, and lantern are present.
- Kitchen east is the window; living room is west. That is geography, not a parser bug.

## Breakage fixed in Release 1293

A fresh `RECAP` still dumped House-of-Records architecture:

- Versioned dossier state and exact physical custody remained native-save persistent.
- Actor memory normalized first contact, hostility, gifts…
- Regional files retained itemized discoveries…
- Playback retained unique consequential events…
- Real fire, water, routes, actors, ritual objects…
- Thief, creature, water, smoke… threshold evidence
- Meaningful house and expedition events queued correspondence

Root causes: NPC schema init set a restore event; house entry captured playback and regional files; an open window activated generic house-risk conditions; cellar and mail recap printed architecture without those rooms being visited.

Release 1293 gates those dumps on actual Attic or Cellar visits and removes the generic house-risk architecture line. Window, lunch/garlic, rug/trap, and rest-integrity honesty from 1278 are preserved.

## Obvious issues recorded, not 1293

- `EXAMINE TREE` at North of House: “You can't see any tree here!” while the room prose mentions trees. Forest Path has a climbable tree. This is **Forest That Answers Back** (live 1294): described wilderness nouns become stateful objects. No GUI. No AI.
- Mara was not in the living room on first look after a short kitchen visit. She remains one authored person; do not invent an LLM companion to fill the gap.

## Follow-on trains (no GUI, no AI)

See `.beads/cursor_zork_honest_playtest_followon.beadtrain`. Live numbers skip 1280–1292.

1. **1293 Honest System Recap** — this document's breakage.
2. **1294 Forest That Answers Back** — trees and other named wilderness nouns where prose already claims them.
3. **1295 West-of-House nouns that the opening already describes** — grass, boards, silence as examinable locals without a scenery engine.
