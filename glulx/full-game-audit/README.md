# Full-game adversarial runner

This harness makes GitHub play Zork I from the opening field through the 350-point completion and into the Stone Barrow, then audits the entire transcript for breakage instead of stopping at the first odd response.

The canonical command spine comes from the verified ZWalker Zork I 350/350 solve, pinned in the workflow to commit `63327e700b1436c835645c6bbc8ba846df5be073`. `prepare_commands.py` strips commentary and appends the six final commands that enter the Stone Barrow so the run checks the actual Zork I ending, not only the maximum score.

The workflow runs the deterministic golden seed `3` plus exploratory seeds `1`, `2`, `4`, and `5`. Seed 3 must reach all of these markers: 350/350, Master Adventurer, Inside the Barrow, and the mastered-Zork ending. Exploratory seeds are evidence gathering: divergence is reported but does not stop later seeds from running.

`analyze_transcript.py` classifies evidence rather than pretending every refusal is a bug. Runtime/interpreter failures are critical. Parser failures are warnings. State/custody/route mismatches are notices because some repeated commands in the verified route are intentionally defensive. Every run writes the raw transcript, exact command file, JSON findings, and Markdown summary to the workflow artifact and the GitHub job summary.

The job is intentionally adversarial. It keeps playing after suspicious output, captures the surrounding evidence, and fails only after evidence has been preserved. That gives us a durable regression record instead of a CI job that dies at the first symptom.
