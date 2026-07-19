# Zork I Glulx upstream baseline

This directory defines the additive, unofficial Glulx lineage for this repository.

The baseline builds Tara McGrew's unchanged `taradinoc/zork1` `glulx` source at commit `1ada70e58ac4933446b907d67949d9cab3119c0e`. It does not contain Release 120 fixes or Release 121 gameplay changes.

## Identity

- upstream source identity: Release 1 / serial `251203`
- repository output: `zork1-glulx-upstream.ulx`
- status: unofficial repository-local baseline
- relationship to existing editions: additive only

Historical Release 119, Optimized Release 120, and Expanded Release 121 remain supported `.z3` editions and are not replaced or relabeled.

## Locked repository artifact

- Glulx version: `3.1.3` / `0x00030103`
- size: `180,736` bytes
- checksum: `0xad5a809b`, valid
- SHA-256: `15dd2b654693e4f1c63e09a2308de1f366913c13be080baa33af3f76c5679ac8`

The repository artifact is not expected to be byte-identical to Tara's archived December 2025 binary because it is rebuilt with the current pinned ZILF 1.8 toolchain. Both artifacts are independently verified and run through the same pinned native interpreter.

## Archived reference

The IF Archive `zork1-glulx.zip` is inspected as an external reference:

- ZIP size: `83,407` bytes
- ZIP SHA-256: `6e9879f36d7d15ddebee1333244be016a9f3a40756718292264815e8881c51ad`
- story member: `zork1.ulx`
- story size: `167,424` bytes
- story checksum: `0xde2ebee4`, valid
- story SHA-256: `42b74ce1ce32e9f483418409642b1be425e66e93c7741961e90917e2bb30b129`

Both stories identify themselves as Release 1 / serial `251203`, open at West of House, and run successfully with pinned Glulxe and CheapGlk.

## Reproducibility contract

`provenance.json` pins:

- Tara's exact Glulx source commit, default-branch commit, merge base, and seven-file branch diff;
- ZILF 1.8;
- Glazer 1.2.0, including its GitLab commit, source URL, and source tarball SHA-256;
- Glulxe;
- CheapGlk;
- the repository artifact checksum and SHA-256;
- the archived ZIP and archived story checksums;
- licensing and branding boundaries.

CI obtains every pinned input, verifies the downloaded hashes, compiles the unchanged source, verifies the Glulx header and checksum, runs both the repository and archived artifacts natively, records license-file hashes, and uploads the complete qualification bundle.

## Deterministic serial normalization

Pinned ZILF 1.8 currently emits Glulx metadata serial using `DateTime.Now`. That would make the same unchanged source identify itself differently on every build date.

The pipeline therefore:

1. compiles Tara's unchanged ZIL source to Glazer assembly;
2. replaces exactly one generated `metadata_serial` value with the published upstream serial `251203`;
3. assembles the normalized output with pinned Glazer 1.2.0;
4. fails if the replacement count or final artifact SHA-256 changes.

No upstream ZIL source is modified by this normalization.

## Next porting boundary: Release 120 only

The next layer ports only the conservative optimized-edition work:

1. recursive-containment protection;
2. candle description corrections;
3. unsafe printed-character corrections;
4. case-sensitive include and portability auditing;
5. deterministic identity and verification behavior.

No Release 121 action hooks, assistance, scenery, optional geography, NPC alternatives, or comedy reactions belong in that layer.

See [`QUALIFICATION.md`](QUALIFICATION.md) for the baseline gate and exact next-layer acceptance criteria.
