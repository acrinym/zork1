# Release 1305 — Highly Extended Absurd Alternates (lock receipt)

**PR:** [#94](https://github.com/acrinym/zork1/pull/94) (`agent/1305-absurd-on-1303`)  
**Base:** locked Release **1303** Empire Noun Honesty  
**Merge:** not on `master` until a fresh Justin whistle  
**Hosted qualify (locked rerun):** `33352160781`

## What this release is

Locked **1303** already loads `absurd_alternates.zil` from the Glulx **1214** stack (Release **122** Z3 lives in `alternate/`). 1305 advances `RELEASEID` to 1305 and qualifies those routes on the HE story. It does not re-hook troll/nest/tree in `1dungeon.zil`.

Player file is Glulx, not `alternate/*.z3`.

## Locked production artifact

| Field | Value |
|---|---|
| File | `zork1-glulx-he-absurd-alternates.ulx` |
| SHA-256 | `fbdb8232c2cd219ba1640cd3bd4f65e9162f3ec4f6f38a449b065745636a3dd9` |
| Checksum | `0x9087f92d` |
| Size | 563968 |
| Format / version | Glulx `0x00030103` |
| Serial | `260830` |

## Player routes qualified

- Natural: `TRICK TROLL` then `TIE UP TROLL WITH ROPE` binds the living troll.
- Prepared: sack under tree + torch on nest catches the intact egg.
- Unprepared nest fire still runs canonical `BAD-EGG` / expensive crunch.
- Production story has no `ALTSAFE` / `SURVEYKILL` (255-action ceiling: nest/troll test verbs and survey flags compile as **two** test stories).

## Described-world census on this story

1305 re-walked the **1302** ledger on the survey test compile. Hosted `RELEASE_1305_CENSUS_LIES=[]`.

`EXAMINE GATE` belongs at **Entrance to Hades** (`GATE-PSEUDO`). Land of the Living Dead names souls, not a gate. That is not a missing object.

Museum / kitchen-lab / Mara remaining nouns stay **1308**.

## Not this PR

World-truth extraction, parser-vocabulary audit, contradiction scanners, and CI report packs are a **separate Codex sidebar**. They are not Release 1305 and must not land on this PR.
