# Edition validation

## Required identities

### Expanded compatibility edition

The runnable expanded `.z3` story must report:

- Z-machine version 3;
- Release 121;
- serial `260719`;
- a declared length matching the file;
- a valid stored checksum.

### Unchanged upstream Glulx

The baseline `.ulx` must report:

- Glulx version 3.1.3;
- Release 1;
- serial `251203`;
- valid memory-map ordering;
- a valid Glulx checksum;
- the committed file size and SHA-256.

### Unofficial Optimized Glulx

The conservative port must report:

- Glulx version 3.1.3;
- Release 1201;
- serial `260719`;
- valid memory-map ordering;
- checksum `0xaa478295`;
- size 180,992 bytes;
- SHA-256 `f2f64b0696e91f325602f6d4f1a91182a940bfd28105576662bd54bdeb37d051`.

Releases 120, 121, and 1201 are project-local identities, not official Infocom release numbers.

## Independent continuous-integration boundaries

Three workflows must remain independently green.

### Z-machine preservation and project editions

The shared `.z3` workflow must:

1. test modernization and audit tools;
2. validate all five completed v1.3 beadtrains against 50 closed live beads;
3. verify and audit historical staging inputs;
4. verify preserved Release 119;
5. compile and verify optimized Release 120;
6. compile and verify expanded Release 121;
7. run the optimized Frotz transcript;
8. run the expanded interaction and misconduct transcript;
9. upload independent Release 120 and Release 121 artifacts.

### Unchanged upstream Glulx

The baseline workflow must:

1. verify immutable Tara, ZILF, Glazer, Glulxe, and CheapGlk pins;
2. verify the Glazer source tarball hash;
3. inspect the pinned IF Archive ZIP and member hashes;
4. compile Tara's unchanged source;
5. normalize exactly one generated metadata serial without changing ZIL;
6. verify the fail-closed baseline artifact;
7. build native Glulxe with CheapGlk;
8. run identity and opening routes against repository and archived stories;
9. write licensing and build receipts;
10. upload the complete qualification bundle.

### Optimized Glulx Release 120

The conservative port workflow must:

1. verify the committed upstream tree, four-path boundary, identity, and artifact pins;
2. stage Tara's exact source and apply exact patches and overlay;
3. run structural and case-sensitive include auditing;
4. compile and normalize Release 1201 identity;
5. fail closed on Glulx header, checksum, size, and SHA-256;
6. build native Glulxe with CheapGlk;
7. run the opening and identity route;
8. run the real recursive-containment route;
9. build an isolated test-only South Temple artifact;
10. prove extinguished candles are not described as burning;
11. write the qualified build receipt;
12. upload source, assembly, artifact, audit, receipt, logs, and transcripts.

No workflow may compensate for another edition's failure.

## Expanded opening transcript

The deterministic Release 121 `.z3` route exercises:

- `GOALS`;
- `EXITS`;
- knocking on the white house;
- opening and emptying the mailbox;
- discovering and reading the hidden maintenance slip;
- entering the forest;
- following the songbird;
- entering the Hidden Glade;
- taking the brass feather;
- seeing the discovery in `RECAP`;
- returning to the established map and quitting normally.

## Optimized Glulx focused transcripts

### Recursive containment

The route must:

- enter the kitchen;
- empty the open sack;
- open the bottle;
- place the bottle in the sack;
- attempt to put the containing sack into that bottle;
- receive `How can you do that?`;
- remain live with the valid bottle-inside-sack state intact.

### Extinguished candles

A test-only startup patch must:

- begin at South Temple;
- clear candle `ONBIT` and `FLAMEBIT` before first description;
- print `On the two ends of the altar are candles.`;
- never print the static burning sentence;
- remain excluded from the production artifact.

## Evidence policy

Documentation distinguishes among:

- **compiled behavior** — present in a successfully built complete story;
- **artifact-locked behavior** — compiled into an artifact matching committed checksum and SHA-256;
- **transcript-proven behavior** — executed through a deterministic native or Z-machine interpreter route;
- **semantic-parity behavior** — equivalent milestones proved across `.z3` and `.ulx` despite presentation differences;
- **planned verification** — implemented or proposed but still awaiting a dedicated route.

No feature should be described as transcript-proven merely because the compiler accepted its routine.
