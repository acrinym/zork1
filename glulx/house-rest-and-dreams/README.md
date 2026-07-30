# House Rest and Dreams — Release 1228

## Qualified identity

- edition: `Unofficial House Rest and Dreams Glulx`;
- release: `1228`;
- serial: `260730`;
- output: `zork1-glulx-house-rest-and-dreams.ulx`;
- size: `316,160` bytes;
- checksum: `0x3505b8ad`;
- SHA-256: `8993684cb8cb6e613dffc6e294c4d5edd15da22ab3a340ba4dc2d572f2f084e5`.

Exact qualified Release `1227` base SHA-256:

`6146311cd1fab20c5fde50f12a569c3ea9b34fd0f42038448f44f3740b9936f0`

## Product boundary

Release `1228` extends qualified Attic Playback Release `1227` with one reachable Bedroom above the canonical Living Room and an optional bounded sleep mechanic.

The original `WAIT` / `Z` command remains unchanged. It still prints `Time passes...` and advances the canonical clock through the original `V-WAIT` route.

The Bedroom adds:

- `SLEEP`, `REST`, `NAP`, `DOZE`, and `LIE DOWN`;
- a physical four-poster bed;
- a cloth-bound dream notebook;
- a carbon-copy overnight report filed through the Attic archive;
- authored interruption, recovery, dream, and overnight-house behavior.

## A real Bedroom

The qualified lineage previously had no Bedroom. Release `1228` adds one deliberate upper-floor room:

- Living Room `UP` leads to Bedroom;
- Bedroom `DOWN` returns to Living Room;
- no exterior route or existing canonical route is replaced;
- the room is part of the white house and uses the existing evolving-house substrate.

## Rest versus waiting

`WAIT` remains ordinary canonical waiting anywhere.

A full sleep:

1. is allowed only in the Bedroom;
2. refuses active clothing fire, tied legs, or a hostile actor in the room;
3. advances the real `CLOCKER` one step at a time;
4. stops immediately if a live clock event or authored warning demands waking;
5. applies at most bounded temporary recovery;
6. chooses one deterministic dream from newly earned expedition evidence;
7. applies deterministic physical overnight consequences;
8. leaves the player awake in the Bedroom.

Repeated sleep with no newly earned evidence becomes a one-turn shallow doze. It cannot repeatedly heal the player or skip dangerous timers.

## Bounded recovery

A newly qualified full rest may:

- improve a negative temporary player-strength adjustment by one step;
- clear the transient `STAGGERED` condition when it remains present after canonical turn processing;
- clear the lingering garlic scent from prior experimentation.

It cannot resurrect the player, undo permanent consequences, restore lost objects, solve puzzles, open routes, reset villains or mechanisms, or become a repeatable healing farm.

## Discovery-driven dreams

Dreams are selected from evidence this expedition has already earned:

- white-house return and use;
- entered forest territory;
- Dam #3 mechanism evidence;
- Hades ceremony evidence;
- player-specific troll, cyclops, and thief evidence;
- qualified Attic and regional archive evidence;
- recorded mortal follies;
- museum display or existing theft evidence.

Dreams never reveal an unseen command, solution, route, actor outcome, or missing ceremony step. The notebook records only dreams actually produced by sleep.

## Overnight consequences

The overnight report may record canonical mailbox delivery, queued visitors and physical missed notices, existing museum-theft evidence, existing water or damp evidence, existing smoke or fire-folly evidence, and physical movement of letters, notices, or archive records.

Release `1228` does not originate the broader burglary, structural-damage, propagation, intrusion, cursed-object, or repair controllers reserved for Train 11.

## Forced waking

Sleep may end early because of:

- a live canonical clock event;
- a queued visitor;
- existing Cellar intrusion evidence;
- existing museum-theft evidence.

The interruption preserves an escape route, grants no completed-rest recovery, and never traps the player in a persistent sleeping mode.

## Physical archive records

- `REST-DREAM-01` — the Bedroom dream notebook;
- `REST-OVERNIGHT-02` — the bounded rest and overnight report.

Both are real objects with parser-valid reading. The overnight report can be taken, reviewed, cross-referenced, and filed in the canonical Attic. Review is non-turning and verifies location, score, active threat timer, parser pronoun, and record custody.

## Qualification

GitHub Actions run `30547861041` passed the exact Release `1228` product:

- fail-closed Release `1227` base and eight-path staging;
- locked artifact identity;
- production/test isolation;
- original `WAIT` / `Z` production smoke;
- reachable Bedroom and ordinary sleep parser routes;
- queued-visitor forced waking;
- canonical clock advancement;
- bounded temporary recovery;
- repeated-sleep anti-farming;
- House, forest, and Dam dream progression;
- exclusion of unearned Hades, actor, folly, museum, and other dream content;
- exact physical notebook/report review and filing;
- non-turning record integrity;
- native `SAVE`, deliberate state, record, notice, recovery, and custody corruption, and `RESTORE` without repair;
- qualification receipt and artifact publication.

## Program status

Train `onyx_zork_house_rest_and_dreams` is complete. The House of Records program now has 80 of 96 beads closed across Trains 1–10. The next existing train is `onyx_zork_house_vulnerability`.

## Explicit exclusions

No mandatory day-night cycle, hunger, hygiene, stamina bar, generic life simulation, universal dream generator, predictive dream, timer skip, repeated-healing exploit, object resurrection, unseen-solution leak, premature Train 11 controller, sub-bead, or parallel planning hierarchy.
