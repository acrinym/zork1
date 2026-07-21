# Glulx persistence qualification

This train proves that real Release 1216 world state survives an interpreter SAVE and RESTORE cycle.

The first committed component is `glulx/tools/run_interactive_story.py`, a PTY-backed scenario runner. Ordinary shell pipes cannot reliably answer Glulxe filename prompts, so save/restore qualification must remain interactive and deterministic.

## Planned real-story routes

1. bound troll remains alive and restrained; rope remains committed; passages remain open;
2. prepared intact egg and destructive broken-egg/canary outcomes restore without duplication;
3. dam interlock, sluice direction, reservoir timing, active leak, and repaired leak restore exactly;
4. ritual knowledge, wrong-order memory, completed exorcism, ghost removal, bell identity, candle state, and cooling restore exactly;
5. queued interrupts resume from the saved turn rather than restarting or disappearing;
6. carried, contained, room-local, removed, and transformed objects retain one authoritative location;
7. repeated restore of the same save is deterministic.

## Safety boundary

Test-only positioning may establish a difficult starting situation, but the SAVE and RESTORE commands, save file, production routines, object graph, timers, and post-restore assertions must all be real. No production state may be repaired by the harness after restoration.

## Current checkpoint

The prompt-aware driver and its self-test are implemented. The next car connects it to pinned native Glulxe and Release 1216, then adds one persistence scenario at a time so failures identify the exact state family involved.
