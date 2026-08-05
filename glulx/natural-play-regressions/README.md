# Release 1242 — Natural Play Regressions

Release 1242 fixes integration failures found by launching the actual Release 1241 story and playing from West of House with ordinary commands. It adds no audit framework and no replacement gameplay system.

## What natural play exposed

- The canonical troll can be battered unconscious, shed the one physical tuft, and then be killed on the next attack. Release 1241 retained the earlier “no confirmed kill” provenance even after death.
- Later broad grammar for the completed-expedition archive, cuisine state, and recovery locker intercepted `STATUS HOUSE`, `CHECK HOUSE`, and `PREPARE LUNCH`.
- `INSPECT HOUSE` followed the original `EXAMINE` synonym instead of the intended house-status route.
- Several phrases printed directly in the Living Room, Kitchen, and Attic were not accepted when typed back by the player.

## Repairs

- The existing physical tuft is never duplicated. A later canonical kill upgrades its provenance from subdued to killed.
- Broad later handlers delegate by the real parsed object: house commands return to house vulnerability, lunch returns to Kitchen preparation, and appetite/expedition commands keep their meanings.
- Inspecting the house from within the authored house reports its vulnerability state while exterior examination remains canonical.
- Printed vocabulary now accepts `CREATURES CASE`, `MONSTROUS ... CASE`, `ARCHIVE CABINET`, `COMPACT VIEWER`, `BROAD WORKTOP`, `CAST-IRON RANGE`, and completed expedition box wording. The Attic now prints the four-word box name the parser can accept rather than an unusable five-word variant.

## Runtime qualification

Qualification compiles the production story and performs two ordinary play routes:

1. enter the house, exercise house/appetite/expedition command ownership, prepare the real lunch, and type printed fixture names;
2. descend normally, use a fixed interpreter random seed to knock the canonical troll unconscious and then kill him, and inspect the single physical tuft.

No teleport verbs, precondition controls, copied actors, or test-only production objects are used.
