# Completed Expedition Archive — Qualified Release 1230

Train 12 is the House of Records capstone. It turns a genuinely completed Zork I run into a bounded physical archive without changing the live adventure into telemetry, a raw command log, or a modern database.

## Player-facing commands

- `ARCHIVE EXPEDITION` or `SEAL EXPEDITION`
- `REVIEW EXPEDITION`
- `STATUS EXPEDITION`
- `COMPARE EXPEDITIONS`
- `EXPORT EXPEDITION`

## Genuine completion gate

The master record is created only when canonical `WON-FLAG` is true. Before victory, all previously earned correspondence, dossiers, area files, playback, dreams, overnight reports, vulnerability files, and repair logs remain independently available. The archive does not call an unfinished run complete.

## Physical completed histories

Each sealed history receives its own Attic banker box containing:

- a master expedition file;
- a bounded chronology roll copied from the existing consequential playback sequence;
- a final world-and-house summary containing score, deaths, observed outcomes, house incident history, completed repairs, and security state.

Two boxes remain separate. Neither is overwritten, merged, or retroactively corrected by the other.

## Cross-run comparison

When two completed histories are physically present, `COMPARE EXPEDITIONS` compares only their sealed receipts: score, deaths, actor and area encounters, object and house outcomes, chronology, correspondence, repairs, and security. Missing evidence remains missing.

The comparison never prints an unseen command, hidden route, ceremony order, solution text, or outcome not established by one of the sealed histories.

## Export and compatibility

`EXPORT EXPEDITION` materializes `EXPEDITION-EXPORT-01`, a deterministic human-readable schema-versioned receipt. Schema migration rematerializes exact records conservatively from native saved state.

## Persistence

Native `SAVE` and `RESTORE` preserve both boxes, their separate chronology sequences, final snapshots, comparison card, export receipt, schema version, and event history. Qualification deliberately removes and corrupts those values before restoring them exactly.

## Qualification

GitHub Actions run `30577224174` passed:

- exact Release 1229 ancestry;
- fail-closed four-path production staging;
- zero smell errors and no test controls in production;
- no pre-victory master record;
- canonical victory gating;
- bounded chronology, deaths, final state, and unseen-alternative language;
- two separate physical boxes;
- non-merging comparison;
- versioned export;
- native save, deliberate corruption, and exact restore.

## Locked artifact identity

- Release: `1230`
- Serial: `260730`
- Size: `337,408` bytes
- Glulx checksum: `0x7febe444`
- SHA-256: `b446e12ebffc570c0058347583bacc768f6a51f5f5166634da91898004d68c71`
