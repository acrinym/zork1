"TEST-ONLY MARA ANTICIPATION PRECONDITIONS"

<SYNTAX MARAANTICIPATE = V-MARA-ANTICIPATE-TEST>
<SYNTAX MARAOVERRIDE = V-MARA-OVERRIDE-TEST>
<SYNTAX MARARUPTUREWARN = V-MARA-RUPTURE-WARN-TEST>
<SYNTAX MARAANTSTATUS = V-MARA-ANTICIPATION-STATUS-TEST>

<OBJECT MARA-ANTICIPATION-TEST-BALLAST
    (IN GLOBAL-OBJECTS)
    (SYNONYM BALLAST WEIGHT)
    (ADJECTIVE ANTICIPATION TEST HEAVY IRON)
    (DESC "anticipation-test ballast")
    (FLAGS TAKEBIT NDESCBIT)
    (SIZE 200)>

<ROUTINE MARA-ANTICIPATION-TEST-BASE ()
    <MARA-RESET-STATE>
    <MARA-PUT ,MARA-SLOT-MET 1>
    <MARA-PUT ,MARA-SLOT-DAM-SURVEY 1>
    <MARA-PUT ,MARA-SLOT-HOUSE-STAY 1>
    <MARA-PUT ,MARA-SLOT-BIO-IGNORED-WARNING 1>
    <MARA-PUT ,MARA-SLOT-BIO-RESCUED-MARA 1>
    <MARA-PUT ,MARA-SLOT-BIO-ROPE-RETURNED 1>
    <MARA-PUT ,MARA-SLOT-BIO-MARA-RESCUED-YOU 1>
    <MARA-PUT ,MARA-SLOT-KNOWN-RISK-INJURY 1>
    <MARA-PUT ,MARA-SLOT-AIDED-RECKLESS-INJURY 1>
    <MARA-PUT ,MARA-SLOT-RECKLESSNESS-ANGER 1>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-FOLLOWING>
    <MOVE ,MARA-FIELD-ROPE ,MARA>
    ;"Reservoir South is dark. Give the test player the real brass lantern and
       turn it on so qualification cannot be randomly eaten by a grue before
       the real EAST movement that is under test."
    <MOVE ,LAMP ,ADVENTURER>
    <FSET ,LAMP ,ONBIT>
    <MOVE ,MARA-ANTICIPATION-TEST-BALLAST ,ADVENTURER>
    <MOVE ,MARA ,RESERVOIR-SOUTH>
    <SETG GATES-OPEN T>
    <GOTO ,RESERVOIR-SOUTH>
    <RTRUE>>

<ROUTINE V-MARA-ANTICIPATE-TEST ()
    <MARA-ANTICIPATION-TEST-BASE>
    <TELL "TEST PRECONDITION: Mara remembers the prior Dam injury and is following from Reservoir South. The player carries the same unsafe load. EAST is a real movement into the live Dam danger; the later load change and descent remain real player actions." CR>
    <RTRUE>>

<ROUTINE V-MARA-OVERRIDE-TEST ()
    <MARA-ANTICIPATION-TEST-BASE>
    <TELL "TEST PRECONDITION: the same remembered Dam danger is live. EAST must let Mara warn before the player reaches for the ladder; an unchanged overloaded descent is then the player's real choice." CR>
    <RTRUE>>

<ROUTINE V-MARA-RUPTURE-WARN-TEST ()
    <MARA-ANTICIPATION-TEST-BASE>
    <MARA-PUT ,MARA-SLOT-INTENTIONAL-HARM 1>
    <MARA-PUT ,MARA-SLOT-HARM-BETRAYAL 1>
    <MARA-PUT ,MARA-SLOT-RUPTURE-OPEN 1>
    <MARA-PUT ,MARA-SLOT-APOLOGY-ACKNOWLEDGED 1>
    <MARA-PUT ,MARA-SLOT-BOUNDARY-RESPECTED 1>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-INDEPENDENT>
    ;"The base fixture already placed the player at Reservoir South. Move only
       Mara to the Dam; a second GOTO into the dark room would create an extra
       darkness/grue check unrelated to the behavior being qualified."
    <MOVE ,MARA ,DAM-ROOM>
    <TELL "TEST PRECONDITION: the same remembered Dam danger exists during an unresolved rupture. Mara is already at the Dam and keeps physical distance. EAST is the player's real arrival; concern must not silently restore close-contact cooperation." CR>
    <RTRUE>>

<ROUTINE V-MARA-ANTICIPATION-STATUS-TEST ()
    <TELL "TEST Mara anticipation: anticipated=" N <MARA-GET ,MARA-SLOT-ANTICIPATED-KNOWN-RISK>
          " initiative=" N <MARA-GET ,MARA-SLOT-PROTECTIVE-INITIATIVE>
          " worry=" N <MARA-GET ,MARA-SLOT-WORRY-SPOKEN>
          " prepared=" N <MARA-GET ,MARA-SLOT-PROTECTIVE-PREPARATION>
          " heeded=" N <MARA-GET ,MARA-SLOT-WARNING-HEEDED>
          " overridden=" N <MARA-GET ,MARA-SLOT-WARNING-OVERRIDDEN>
          " relief=" N <MARA-GET ,MARA-SLOT-RELIEF-AFTER-HEEDED> "." CR>
    <TELL "TEST Mara rupture-open=" N <MARA-GET ,MARA-SLOT-RUPTURE-OPEN>
          " repaired=" N <MARA-GET ,MARA-SLOT-RUPTURE-REPAIRED>
          " mode=" N <MARA-GET ,MARA-SLOT-MODE> "." CR>
    <RTRUE>>
