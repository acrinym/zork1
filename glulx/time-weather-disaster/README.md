# Release 1307 — Authored Time, Weather & Disaster Arc

Release 1307 adds one deterministic environmental lifecycle over the existing Zork world. It is not a climate engine, random-weather system, or generic simulation layer.

## Product arc

The ordinary game begins in fair weather. Entering the existing canyon/dam country arms an authored sequence:

1. fair weather,
2. a visible building cloud shelf and steadying wind,
3. first rain and an explicit preparation warning,
4. hard rain and sustained wind,
5. a runoff surge through the real canyon and Flood Control Dam #3 geography,
6. persistent aftermath.

The warning phases precede any object movement. The lifecycle never rolls random weather.

## Existing world authority reused

Release 1307 composes with facts already present in the game instead of replacing them:

- `CANYON-VIEW`, `CANYON-BOTTOM`, `DEEP-CANYON`, `DAM-ROOM`, and `DAM-BASE` are the authored disaster geography.
- `FOREST-ROOM?` supplies existing forest membership for exposed-weather description.
- `GATES-OPEN` remains the canonical sluice authority. Open gates mitigate the dam-top surge; closed gates permit loose-object movement there.
- `BOTTLE` and `SANDWICH-BAG` are real, recoverable world objects used to prove physical movement. Only objects directly loose in an affected room can move. Carried or nested objects are not stolen.
- Release 1257's established consequence clock remains ahead of this organ in the turn spine: `MATERIAL-ADVANCE` → `FIRE-STRUCTURAL-ADVANCE` → `WEATHER-DISASTER-ADVANCE`.

## Parser-real weather and time

`SKY`, `WEATHER`, `CLOUDS`, `STORM`, `WIND`, `RAIN`, and `DAYLIGHT` resolve to the Release 1307 environmental object. `EXAMINE SKY`, `LISTEN`, and `SMELL` report the authored state. Time-of-day language is derived from expedition turn count; it does not create a second clock or calendar subsystem.

## Fair-weather compatibility

The storm is not armed during the opening or ordinary fair-weather exploration. Release 1307 does not delete routes, alter treasure values, award weather score, or require a weather solution for canonical puzzles. Its destructive act is deliberately narrow and recoverable: a surge can move selected loose objects downhill while leaving carried possessions and canonical traversal intact.

## Qualification

`qualify.sh` first inherits the exact locked Release 1306 qualification, then proves Release 1307 through four histories:

- fair-weather production opening,
- canyon warning → storm → surge → aftermath, including a carried object surviving while a loose object moves to Canyon Bottom,
- open-sluice dam mitigation using canonical `GATES-OPEN`,
- closed-sluice movement to recoverable Dam Base.

Test-only positioning verbs exist only in the dedicated test story. The production qualification fails if any of those helpers leak into the shipped source.

The release remains intentionally artifact-unlocked until GitHub Actions compiles the exact candidate and emits its deterministic Glulx identity. That identity is then locked into `patch-series.json` and the full qualification is rerun.
