# Playtest gaps — 1245 session vs breaking trains and honest recap

**Date:** 2026-08-30  
**Playtest artifact:** `expanded/zork1-glulx-creative-natural-play-release-1245.ulx` (Release 1245)  
**Production frontier after PR #85:** Release 1277 on `acrinym/zork1` `master`  
**Never mutate:** `historicalsource/zork1`

This was a live playtest, not a saved game to restore. A **new playthrough** must not recap unearned attic architecture, rug/trap events, garlic slicing, or rest-integrity telemetry.

## Trains that already authored destruction

| Release | Contract | Why the 1245 session missed it |
|---:|---|---|
| 1246 | Field stone; rock/sword/axe mailbox damage; rock/sword through kitchen window | Played 1245, one train **before** 1246 |
| 1264 | `BREAK LANTERN WITH SWORD`, burn/cut rope, burn/cut fire screen, smash star-glass | Not in 1245; four authored seams only |
| 1228 | `LIE DOWN` / `SLEEP` / `REST` in the Bedroom | `REST`/`SLEEP` worked; `LIE DOWN` did not |

## Broke despite a train (fix in Release 1278)

1. **RECAP lies on a fresh-enough house visit.** `HOUSE-EVENT-DISTURBANCE` ORs open kitchen window with moved rug and open trap, then prints all three. Opening the window to enter is enough to claim the rug moved.
2. **ARCHIVE-RECAP dumps House-of-Records architecture** (microfiche, catalog, migration) after mailbox mail syncs attic records, even if the Adventurer never entered the Attic.
3. **KITCHEN-RECAP** says lunch **or** garlic as one fact; garlic was never sliced.
4. **Dream notebook** prints `REST-RECORD-INTEGRITY:PASS/FAIL` into player text. Qualification may keep the check; players must not see it.
5. **`LIE DOWN`** is in the 1228 syntax patch and README; the Bedroom rejected the sentence. Bare `LIE`, `LIE DOWN`, and `LIE ON BED` need to reach `V-HOUSE-SLEEP`. ZILF cannot compile `LIE DOWN ON OBJECT` (MDL0112: two prepositions).
6. **`DRINK FROM SINK`** missed the sink action (`How peculiar!`) even though the sink object includes TAP and handles `DRINK`.
7. **Specimen jar** vs sword: 1264 doctrine, not in the four 1264 objects. Authored shatter with water/fish consequence.

## Intentionally not 1246/1264 bugs

Trophy case, table, cupboard, `PRY`/`GREET`/`WHISTLE`, filing every paper on the record shelf, forest-case rejecting the nest — those trains refused a universal smash/catalog engine.

## Follow-on

Release 1278 stages locked 1277 and repairs honesty + rest syntax + jar smash. Former planning **1278 Glulxe optimization** is now **1279**; the runtime foundation queue in `POST_1277_RUNTIME_FOUNDATION_QUEUE_1278_1284_2026-08-21.md` continues 1280–1285.
