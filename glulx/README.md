# Zork I Glulx upstream baseline

This directory defines the additive, unofficial Glulx lineage for this repository.

The first baseline deliberately builds Tara McGrew's unchanged `taradinoc/zork1` `glulx` branch at commit `1ada70e58ac4933446b907d67949d9cab3119c0e`. It does not yet contain Release 120 fixes or Release 121 gameplay changes.

## Identity

- upstream source identity: Release 1 / serial `251203`
- output: `zork1-glulx-upstream.ulx`
- status: unofficial repository-local baseline
- relationship to existing editions: additive only

Historical Release 119, Optimized Release 120, and Expanded Release 121 remain supported `.z3` editions and are not replaced or relabeled.

## Reproducibility contract

`provenance.json` pins:

- Tara's exact Glulx source commit and merge base;
- ZILF 1.8 and its in-tree Glazer assembler;
- Glulxe;
- CheapGlk;
- licensing and branding boundaries.

CI checks out each upstream at the pinned commit, builds the unchanged source with `zilf build --glulx`, verifies the Glulx header and immutable artifact metadata, runs a deterministic native Glulxe transcript, and uploads the story, logs, receipt, report, and transcript.

## Porting boundary

The next layer is Release 120 only:

1. recursive-containment protection;
2. candle description corrections;
3. unsafe printed-character corrections;
4. case-sensitive include and portability auditing;
5. deterministic identity and verification behavior.

No Release 121 action hooks, assistance, scenery, optional geography, NPC alternatives, or comedy reactions belong in that layer.

## Local build shape

The CI workflow is the canonical reference because it obtains the exact pinned upstream trees. A local equivalent must provide ZILF and Glazer from the pinned ZILF checkout and invoke:

```text
zilf build --glulx zork1.zil zork1-glulx-upstream.ulx
```

Run the result through a standard Glulxe build linked to the pinned CheapGlk implementation.
