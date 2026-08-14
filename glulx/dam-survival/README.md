# Release 1253 — Dam Survival & Prepared Rescue

Release 1253 turns Flood Control Dam #3 into a deterministic physical hazard without inventing a second water simulation.

## Product behavior

- The existing `GATES-OPEN` and `LOW-TIDE` state remains authoritative.
- A real iron maintenance ladder now connects the dam top and Dam Base.
- The ladder's risk changes with canonical dam state and the adventurer's actual carried weight.
- Closed/high overflow can make an overloaded, unprepared descent cost the heaviest loose non-sacred item; the item lands at Dam Base and is recoverable.
- Open sluices make the same overloaded, unprepared ladder descent lethal.
- The existing rope can be tied to the maintenance ladder through the established material-rope authority. The remaining coil becomes a fixed handline that changes the dangerous descent into a survivable rescue.
- At Dam Base, deliberately entering open-sluice discharge without a prepared fixed line is lethal; the prepared handline lets the adventurer test the current and recover to shore.
- The canonical inflatable/magic boat remains the authored river-travel solution. Release 1253 does not replace `RBOAT-FUNCTION`, river geography, or gate timing.
- Normal authored exits between the dam top and base remain safe. Release 1253 does not add random falls or unavoidable damage.

## Staging contract

Release 1253 stages directly over the exact qualified Release 1252 production and dev trees. The Release 1252 artifact and both staged-source identities are pinned in `patch-series.json`.

The production artifact identity is intentionally discovered once, then locked in the manifest before the train is considered qualified.
