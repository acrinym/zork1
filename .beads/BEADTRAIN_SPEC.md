# Beadtrain specification — v1.3

A `.beadtrain` file is TOML describing one continuous execution train.

## Required train fields

```toml
[train]
name = "agent_topic"
title = "Human title"
description = "Purpose and boundary"
created = "YYYY-MM-DD"
status = "planned" # planned | in_progress | complete | blocked
```

## Cars

Each `[[cars]]` row requires:

- `id`: a label unique inside the train;
- `bead`: an issue id present in `.beads/issues.jsonl`;
- `title` and `summary`;
- `parallel_start`: boolean;
- `depends_on`: local car ids only.

Cars become ready when all local dependencies and all inbound coupler gates are satisfied. A train runs continuously until every car is closed unless the user explicitly pauses it or a hard external blocker is reached.

## Couplers

Two trains are joined only through `[[couplers]]`:

```toml
[[couplers]]
id = "unique-join"
from_train = "primary"
from_car = "capstone"
to_train = "secondary"
to_car = "start"
mode = "after" # after | with
note = "Why the trains are joined"
```

`meta.prior_car` is narrative, not a dependency gate. Never place another train's car ids in `depends_on`.

## Metadata

```toml
[meta]
one_liner = "Completion sentence"
couples_with = ["peer_train"]
watch = ["important/path"]
```

## Completion

A train may be marked `complete` only when every referenced bead is closed and its capstone validation has passed. Validate with:

```bash
python .beads/beadtrains/scripts/validate_beadtrain.py .beads/<train>.beadtrain
```
