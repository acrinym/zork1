"CORPUS-COUPLED CAUSAL WARNING for Release 1231"

;"This module adds no parallel flood controller. WATER-LEVEL, I-MAINT-ROOM,
  LEAK, PUTTY, the canonical exits, and JIGS-UP remain authoritative."

<GLOBAL MAINT-FLOOD-WARNING-STAGE 0>

<ROUTINE CORPUS-MAINT-FLOOD-START ()
    <SETG MAINT-FLOOD-WARNING-STAGE 0>
    <TELL
"The stream spreads across the floor faster than it drains. The west and
south doorways remain clear -- for now." CR>
    <RTRUE>>

<ROUTINE CORPUS-MAINT-FLOOD-TICK (HERE?)
    <COND (<NOT .HERE?> <RFALSE>)
          (<AND <G? ,WATER-LEVEL 10>
                <L? ,MAINT-FLOOD-WARNING-STAGE 3>>
           <SETG MAINT-FLOOD-WARNING-STAGE 3>
           <TELL
"The current is pulling hard across the room. Remaining here is becoming
an experiment with one result." CR>)
          (<AND <G? ,WATER-LEVEL 4>
                <L? ,MAINT-FLOOD-WARNING-STAGE 2>>
           <SETG MAINT-FLOOD-WARNING-STAGE 2>
           <TELL
"The water reaches your knees. Loose debris begins to drift toward the
control panel." CR>)
          (<AND <G? ,WATER-LEVEL 2>
                <L? ,MAINT-FLOOD-WARNING-STAGE 1>>
           <SETG MAINT-FLOOD-WARNING-STAGE 1>
           <TELL
"Cold water closes around your ankles. The break in the east-wall pipe is
widening." CR>)>
    <RTRUE>>

<ROUTINE CORPUS-MAINT-FLOOD-EXAMINE ()
    <TELL
"The break is in the east-wall pipe. The stream is under pressure, but the
opening is still small enough to seal." CR>
    <RTRUE>>

<ROUTINE CORPUS-MAINT-FLOOD-DROWN ()
    <JIGS-UP
"The water reaches the ceiling before you reach either doorway. The
maintenance room keeps the evidence; you do not.">>

<ROUTINE CORPUS-MAINT-FLOOD-REPAIRED ()
    <SETG MAINT-FLOOD-WARNING-STAGE 0>
    <TELL
"The pipe shudders once. The remaining water begins to drain through the
floor grating." CR>
    <RTRUE>>