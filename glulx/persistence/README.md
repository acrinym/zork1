# Glulx Release 1216 persistence qualification

This directory qualifies ordinary interpreter `SAVE` and `RESTORE` against the exact locked Ritual Resonance Release `1216` artifact and its real production mechanics.

This is a **qualification layer**, not a ninth production edition. It does not alter the Release `1216` source, identity, artifact, world rules, parser surface, or save format.

## Production artifact under test

- edition: Unofficial Ritual Resonance Glulx
- release: `1216`
- serial: `260720`
- artifact: `zork1-glulx-ritual-resonance.ulx`
- Glulx version: `3.1.3` / `0x00030103`
- size: `211,968` bytes
- checksum: `0x3d27d123`
- SHA-256: `4f406e656b892feb5224e4e52afb98768417e1e761918334dfa94595e6091db2`

Every persistence run rebuilds that exact artifact with the pinned ZILF and Glazer toolchain and rejects any identity drift before testing saves.

## Why an interactive driver is required

The existing transcript routes are intentionally line-oriented. Native Glulxe asks for a save-game path interactively, so a shell pipe cannot reliably distinguish game commands from filename prompts.

`glulx/tools/run_interactive_story.py` is a small PTY-backed driver that provides:

- declarative JSON scenarios;
- regex output and prompt assertions;
- explicit `send`, `sendline`, EOF, timeout, and exit-status steps;
- environment and named-variable substitution;
- safe preservation of regex quantifier braces;
- transcript capture;
- child-process cleanup even when transcript creation or an early step fails;
- contextual failure output showing the exact scenario step and recent interpreter text.

A separate fake-story self-test proves the driver can mutate state, write a real file, destroy the in-memory value, restore it, and observe the saved value again.

## Production and test isolation

The workflow stages exact Release `1216` production source and verifies its locked artifact first. It then copies that source into a separate test tree and adds only test positioning, deliberate corruption, and observation commands.

The production stage is rejected if persistence setup verbs appear. Test-only commands cannot enter the shipped story.

After a snapshot is saved, the harness deliberately corrupts the same state family. It does **not** repair anything after `RESTORE`; post-restore reports observe the restored production variables, object tree, and queued interrupts.

## Qualified save families

### Living bound troll and both egg outcomes

The route invokes the real one-turn troll opening and real rope restraint, then saves:

- the living bound troll;
- committed rope ownership;
- the dropped real axe;
- open east/west passages through `TROLL-FLAG`.

The same scenario also proves both real nest-fire outcomes:

- prepared brown sack with the intact real jewel-encrusted egg;
- unprepared canonical `BAD-EGG`, with `BROKEN-EGG` on the path, `BROKEN-CANARY` inside it, and the original `EGG` removed.

Each egg snapshot is deliberately reconstructed into the opposite object topology and restored twice from the same save file. No treasure or canary is duplicated.

### Dam gate and reservoir interrupt

The route uses the real yellow-button interlock and real wrench-and-bolt mechanism, saves open sluices with the canonical reservoir interrupt active, corrupts the gate and queue state, and restores them.

The restored `I-REMPTY` interrupt resumes rather than restarting or disappearing and reaches canonical `LOW-TIDE`. Learned `MELZAR` also remains callable and reports Flood Control Dam #3 immediately after restore.

### Active and repaired maintenance leak

Two independent snapshots are qualified:

1. the real blue-button leak with `I-MAINT-ROOM` active;
2. the real all-purpose-gunk repair with canonical `WATER-LEVEL = -1` and the maintenance interrupt cancelled.

The active snapshot resumes rising water after restore. The repaired snapshot remains sealed after the test creates a fresh valid leak and restores the repaired save.

The visible pipe scenery is intentionally not used as the repair sentinel; canonical state is the negative water level plus the cancelled interrupt.

### Completed ceremony and hot-bell cooldown

The route completes the original bell → carried lit candles → black-book exorcism, then saves:

- `LLD-FLAG` completion;
- learned ceremony order;
- wrong-order memory;
- mirror resonance memory;
- canonical bell and candle answers;
- real ghost removal;
- the transformed red-hot bell;
- the active 20-turn `I-XBH` cooldown.

After deliberate corruption and restore, the game’s own `CEREMONY` report says the prayer is complete and `RECAP` remembers the canonical exorcism. The restored hot-bell interrupt resumes and returns the cool bell after its remaining turns.

## Determinism and evidence

The qualification workflow records:

- one transcript per state family;
- real `.sav` files, including separate intact and broken egg snapshots;
- the exact rebuilt production and test stories;
- production and test serial-normalization receipts;
- compiler, assembler, interpreter, smell-check, and story-verification reports.

Repeated restore from the same troll/egg saves proves deterministic object ownership and containment rather than a one-time lucky reconstruction.

## Explicit boundary

This train does not:

- add a new production release number;
- change Release `1216` serialization semantics;
- invent an autosave or checkpoint UI;
- mutate state after restore to make an assertion pass;
- claim every possible game state has been exhaustively serialized;
- replace the existing gameplay and artifact qualification routes.

It qualifies the highest-risk new persistent states introduced through Releases `1213`–`1216` while keeping ordinary parser play and ordinary interpreter save files authoritative.
