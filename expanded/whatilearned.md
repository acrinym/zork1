# Highly Extended Zork — what I learned

Breaks found in play, and the fix that closed them. This is not an audit of audits.

## 2026-09-04

- **PRs go only to `acrinym/zork1` `master`.** `historicalsource/zork1` is never a merge target. Confirmed PRs #94, #95, #96 already used that base; they were merged there.
- **Source Control ~1900 files** were a nested scrap dump `glulx/build/_1303-art/`, not product. Wiping it was the fix. Do not commit qualify copies.
- **World Truth is a full-map probe engine, not extra product organs.** Do not grow a thousand new audit layers around it. Play and qualify remain the bug catcher.
- **Mara Earned Romance (`cursor_zork_mara_earned_romance`, Release 1306)** already existed as a beadtrain. Implementing it means parser-real yes/no/postpone from named history, never `MARA-SLOT-TRUST` as a love bar.
- **Wardrobe** is the next coupled train (`cursor_zork_adventurer_body_wardrobe`). Do not start its cars before the romance capstone.
- **Walking the entire Highly Extended map** is `cursor_zork_described_world_second_census` (1308), after wardrobe. Original Zork rooms alone are not the walk.

### Breaks / fixes this session

| Break | Fix |
|---|---|
| Nested `_1303-art` qualify tree flooded the working copy | Deleted the directory; kept it out of git |
| Romance train looked missing | It was `.beads/cursor_zork_mara_earned_romance.beadtrain` on master after #94 |
| OpenHands / PRs pointed at wrong remote | All open PRs already targeted `acrinym/zork1` `master`; merged #96, #95, #94 there |
| ASK MARA TO STAY refused at West of House | Choice rooms are House ring + Dam, not dungeon skips |
| EXAMINE/KISS never hit the romance hook | Intercept at the top of `MARA-FCN` |
| PARTNER synonym collision | Romance topic is LOVE/ROMANCE; company topic after history |
| Postpone blocked later yes | Accept when meal + reciprocal danger are true |
| Schema migrate would wipe anticipation | Schema 9 zeros only romance slots |
