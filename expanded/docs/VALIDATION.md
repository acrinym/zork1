# Expanded-edition validation

## Required identity

The runnable expanded story must report:

- Z-machine version 3;
- Release 121;
- serial `260719`;
- a declared length matching the file;
- a valid stored checksum.

Release 121 is a project-local expanded identity, not an official Infocom release number.

## Continuous-integration gates

The shared workflow must pass these stages in order:

1. test the modernization and audit tools;
2. validate both coupled v1.3 beadtrains;
3. verify and audit the historical staging inputs;
4. verify the preserved Release 119 story;
5. compile and verify optimized Release 120;
6. compile and verify expanded Release 121;
7. run the optimized opening transcript;
8. run the expanded interaction transcript;
9. upload independent artifacts for Releases 120 and 121.

A failure in Release 121 must not be hidden by the success of Release 120. Conversely, expansion work must not weaken the preservation or optimized gates.

## Expanded opening transcript

The deterministic opening route exercises:

- `GOALS`;
- `EXITS`;
- knocking on the white house;
- opening and emptying the mailbox;
- discovering and reading the hidden maintenance slip;
- entering the forest;
- following the songbird;
- entering the hidden glade;
- taking the brass feather;
- seeing the discovery in `RECAP`;
- returning to the established map and quitting normally.

## Evidence policy

Documentation distinguishes among:

- **compiled behavior** — present in a successfully built complete story;
- **transcript-proven behavior** — executed through a deterministic interpreter route;
- **planned verification** — implemented or proposed but still awaiting a dedicated journey.

No feature should be described as transcript-proven merely because the compiler accepted its routine.
