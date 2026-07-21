# Unofficial Dam Mechanisms Glulx Release 1215

This directory defines a focused mechanism layer above qualified Absurd Alternate Glulx Release `1214`.

It does not replace the original Flood Control Dam #3 puzzle. It makes the existing machinery easier to understand, experiment with, and deliberately misuse while retaining the canonical buttons, wrench, bolt, leak, reservoir timers, and consequences.

## Identity

- edition: Unofficial Dam Mechanisms Glulx
- release: `1215`
- serial: `260720`
- artifact: `zork1-glulx-dam-mechanisms.ulx`
- Glulx version: `3.1.3` / `0x00030103`
- size: `207,360` bytes
- checksum: `0x3d135bb8`
- SHA-256: `ea23c8ff739348162f32c798ff0ad6f5e8e6a4d310ad3daf5c2da58b86505eed`
- base: qualified Unofficial Absurd Alternate Glulx Release `1214`

The artifact identity is committed in the manifest and enforced fail-closed by the qualification workflow.

## What players can try

### Read the panel physically

`EXAMINE PANEL` or `DIAGNOSE PANEL` now reports:

- whether the yellow turning interlock is armed;
- whether the real sluice gates are open or closed;
- whether the reservoir is high, low, rising, or falling;
- whether the maintenance leak is inactive, flooding, or sealed.

`LISTEN TO PANEL`, `TOUCH PANEL`, and `KNOCK ON PANEL` distinguish the broad panel shell from the mechanically connected bolt.

### Understand the bubble and buttons

The green bubble is treated as the existing interlock indicator rather than decorative scenery.

- the yellow button arms the bolt circuit;
- the brown button disarms it without moving the gates;
- the red button controls maintenance-room lighting only;
- the blue button still activates the original failing pipe circuit and starts the real flood clock.

No button has been repurposed.

### Use the real tools

Reasonable Shadow Logic combinations route into the real mechanisms:

- `USE WRENCH ON BOLT` performs the canonical bolt turn;
- `USE WRENCH ON PANEL` identifies and operates the bolt;
- `USE SCREWDRIVER ON PANEL` discovers sealed riveted construction;
- `USE SCREWDRIVER ON BOLT` explains the incompatible interface;
- `USE GUIDE ON PANEL` exposes the suspicious absence of operating instructions;
- `USE WATER ON PANEL` produces a sealed-panel response without inventing damage.

The wrench, screwdriver, guidebook, bottle, and repair material must actually be carried where their use requires possession. Water experiments require the real open bottle with real water. The bolt still refuses to move while the yellow interlock is disarmed.

### Cause and repair the maintenance leak

The blue button retains its canonical consequence. Water begins rising through the original `I-MAINT-ROOM` interrupt and remains lethal if ignored.

- wrench or screwdriver probing acknowledges the physical problem but cannot repair it;
- both `PUTTY` and the canonical `GUNK` noun identify the real all-purpose material;
- `USE PUTTY ON LEAK` routes into the canonical `PLUG LEAK WITH PUTTY` solution;
- the real `FIX-MAINT-LEAK` state stops the real flood clock.

### Ask MELZAR

After learning `MELZAR`, saying it at the dam now reports interlock, sluice, reservoir, and leak state rather than returning a vague active/incomplete message.

### Persistent recap

`RECAP` records meaningful discoveries and consequences:

- panel diagnosis;
- interlock identification;
- bolt experiments;
- successful sluice cycling;
- maintenance-light verification;
- blue-button leak activation;
- real putty repair;
- tool-interface experiments.

## Canonical preservation

Release `1215` does not replace:

- `BUTTON-F`;
- `BOLT-F`;
- `I-RFILL` or `I-REMPTY`;
- `I-MAINT-ROOM`;
- `FIX-MAINT-LEAK`;
- `GATE-FLAG`, `GATES-OPEN`, `LOW-TIDE`, or `WATER-LEVEL`.

The new handlers wrap those routines and record their real outcomes.

## Layer boundary

The staging tool first reconstructs exact qualified Release `1214`, inventories every staged file, and permits this train to change exactly:

- `1dungeon.zil`
- `assistance.zil`
- `dam_mechanisms.zil`
- `shadow_logic.zil`
- `zork1.zil`

Test-only positioning verbs are injected into a separate qualification story and are rejected if they appear in production.

## Qualification coverage

The native route proves:

- panel, bubble, and button explanations;
- rejection of an unheld wrench;
- canonical open and close gate cycles;
- complete `MELZAR` diagnostics;
- closed-bottle rejection and open bottled-water handling;
- red-button light shutdown and restoration while carrying the canonical lamp;
- the real blue-button leak and rising water clock;
- wrong-tool repair failure;
- real `PUTTY` synonym recognition and canonical repair;
- persistent recap state.

## Explicit exclusions

This train does not add bell or exorcism ceremony expansion, magical dam controls, automatic puzzle completion, broader flood propagation, optional geography, character alternatives, or the Wizard of Frobozz.
