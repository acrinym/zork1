"TEST-ONLY MARA FIELD CAPABILITY PRECONDITIONS"

<SYNTAX MARARESTPREP = V-MARA-REST-PREP-TEST>
<SYNTAX MARAINJURED = V-MARA-INJURED-TEST>
<SYNTAX MARAFIELD = V-MARA-FIELD-TEST>
<SYNTAX MARACANYON = V-MARA-CANYON-TEST>
<SYNTAX MARACAPSTATUS = V-MARA-CAP-STATUS-TEST>

<ROUTINE MARA-CAP-TEST-RESET ()
    <MARA-RESET-STATE>
    <MARA-PUT ,MARA-SLOT-MET 1>
    <MARA-PUT ,MARA-SLOT-DAM-SURVEY 1>
    <MARA-PUT ,MARA-SLOT-HOUSE-STAY 1>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
    <MOVE ,MARA-FIELD-ROPE ,MARA>
    <MOVE ,MARA-SURVEY-PLUMMET ,GLOBAL-OBJECTS>
    <SETG GATES-OPEN <>>
    <SETG LOW-TIDE T>
    <RTRUE>>

<ROUTINE V-MARA-REST-PREP-TEST ()
    <MARA-CAP-TEST-RESET>
    <MARA-PUT ,MARA-SLOT-LADDER-INJURY 1>
    <MOVE ,MARA ,ATTIC>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
    <REST-PUT ,RS-CYCLES 0>
    <REST-PUT ,RS-LAST-SIGNATURE 0>
    <GOTO ,BEDROOM>
    <TELL "TEST PRECONDITION: Mara is resting in the Attic with the persistent Dam injury; the Adventurer is in the Bedroom before a full House sleep." CR>
    <RTRUE>>

<ROUTINE V-MARA-INJURED-TEST ()
    <MARA-CAP-TEST-RESET>
    <MARA-PUT ,MARA-SLOT-LADDER-INJURY 1>
    <MARA-PUT ,MARA-SLOT-LADDER-RECOVERED 0>
    <MOVE ,MARA ,DAM-BASE>
    <GOTO ,DAM-BASE>
    <TELL "TEST PRECONDITION: Mara sees the River Frigid geometry while her Dam shoulder is still injured." CR>
    <RTRUE>>

<ROUTINE V-MARA-FIELD-TEST ()
    <MARA-CAP-TEST-RESET>
    <MARA-PUT ,MARA-SLOT-LADDER-INJURY 1>
    <MARA-PUT ,MARA-SLOT-LADDER-RECOVERED 1>
    <MOVE ,MARA ,DAM-BASE>
    <GOTO ,DAM-BASE>
    <TELL "TEST PRECONDITION: Mara's shoulder is recovered, her exact measured rope is in her custody, and the Frigid service-pipe geometry is present." CR>
    <RTRUE>>

<ROUTINE V-MARA-CANYON-TEST ()
    <MARA-CAP-TEST-RESET>
    <MARA-PUT ,MARA-SLOT-LADDER-INJURY 1>
    <MARA-PUT ,MARA-SLOT-LADDER-RECOVERED 1>
    <MARA-PUT ,MARA-SLOT-PENDULUM-DISCOVERED 1>
    <MARA-PUT ,MARA-SLOT-PLUMMET-RECOVERED 1>
    <MOVE ,MARA-SURVEY-PLUMMET ,MARA>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-FOLLOWING>
    <MOVE ,MARA ,DEEP-CANYON>
    <SETG LOUD-FLAG T>
    <GOTO ,DEEP-CANYON>
    <TELL "TEST PRECONDITION: Mara already lived through the Frigid swing, has the recovered brass plummet, and the canonical Loud Room has already been made safe." CR>
    <RTRUE>>

<ROUTINE V-MARA-CAP-STATUS-TEST ()
    <TELL "TEST Mara capabilities: injury=" N <MARA-GET ,MARA-SLOT-LADDER-INJURY>
          " recovered=" N <MARA-GET ,MARA-SLOT-LADDER-RECOVERED>
          " pendulum-discovered=" N <MARA-GET ,MARA-SLOT-PENDULUM-DISCOVERED>
          " pendulum-reused=" N <MARA-GET ,MARA-SLOT-PENDULUM-REUSED>
          " acoustic-discovered=" N <MARA-GET ,MARA-SLOT-ACOUSTIC-DISCOVERED>
          " acoustic-reused=" N <MARA-GET ,MARA-SLOT-ACOUSTIC-REUSED>
          " plummet=" N <MARA-GET ,MARA-SLOT-PLUMMET-RECOVERED> "." CR>
    <COND (<IN? ,MARA-SURVEY-PLUMMET ,MARA>
           <TELL "TEST plummet custody: Mara." CR>)
          (<IN? ,MARA-SURVEY-PLUMMET ,ADVENTURER>
           <TELL "TEST plummet custody: player." CR>)
          (T
           <TELL "TEST plummet custody: elsewhere." CR>)>
    <TELL "TEST Mara location: " D <LOC ,MARA> "." CR>
    <RTRUE>>
