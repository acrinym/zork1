"TEST-ONLY MARA LIVED FEELING PRECONDITIONS"

<SYNTAX MARACONCERN = V-MARA-CONCERN-TEST>
<SYNTAX MARARETURN = V-MARA-RETURN-TEST>
<SYNTAX MARAHARM = V-MARA-HARM-TEST>
<SYNTAX MARAREPAIR = V-MARA-REPAIR-TEST>
<SYNTAX MARAFEELSTATUS = V-MARA-FEEL-STATUS-TEST>

<OBJECT MARA-FEELING-TEST-BALLAST
    (IN GLOBAL-OBJECTS)
    (SYNONYM BALLAST WEIGHT)
    (ADJECTIVE FEELING TEST HEAVY IRON)
    (DESC "feeling-test ballast")
    (FLAGS TAKEBIT NDESCBIT)
    (SIZE 200)>

<ROUTINE MARA-FEELING-TEST-BASE ()
    <MARA-RESET-STATE>
    <MARA-PUT ,MARA-SLOT-MET 1>
    <MARA-PUT ,MARA-SLOT-DAM-SURVEY 1>
    <MARA-PUT ,MARA-SLOT-HOUSE-STAY 1>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
    <MOVE ,MARA-FIELD-ROPE ,MARA>
    <MOVE ,MARA-FEELING-TEST-BALLAST ,GLOBAL-OBJECTS>
    <SETG GATES-OPEN T>
    <RTRUE>>

<ROUTINE V-MARA-CONCERN-TEST ()
    <MARA-FEELING-TEST-BASE>
    <MARA-PUT ,MARA-SLOT-BIO-IGNORED-WARNING 1>
    <MARA-PUT ,MARA-SLOT-BIO-RESCUED-MARA 1>
    <MARA-PUT ,MARA-SLOT-BIO-ROPE-RETURNED 1>
    <MARA-PUT ,MARA-SLOT-BIO-MARA-RESCUED-YOU 1>
    <MOVE ,MARA ,DAM-ROOM>
    <MOVE ,MARA-FEELING-TEST-BALLAST ,ADVENTURER>
    <GOTO ,DAM-ROOM>
    <TELL "TEST PRECONDITION: the Adventurer and Mara have reciprocal Dam rescue history; Mara has already caught this exact overloaded descent once, and the player again carries the same dangerous load." CR>
    <RTRUE>>

<ROUTINE V-MARA-RETURN-TEST ()
    <MOVE ,MARA ,DAM-ROOM>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
    <MOVE ,MARA-FEELING-TEST-BALLAST ,ADVENTURER>
    <SETG GATES-OPEN T>
    <GOTO ,DAM-ROOM>
    <TELL "TEST PRECONDITION: return to the same open-sluice ladder with the same unsafe load; lived history is preserved." CR>
    <RTRUE>>

<ROUTINE V-MARA-HARM-TEST ()
    <MARA-FEELING-TEST-BASE>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-FOLLOWING>
    <MOVE ,MARA ,WEST-OF-HOUSE>
    <GOTO ,WEST-OF-HOUSE>
    <TELL "TEST PRECONDITION: Mara and the Adventurer are together west of the House with no rupture preloaded. The next attack, apology, and movement are real player actions." CR>
    <RTRUE>>

<ROUTINE V-MARA-REPAIR-TEST ()
    <MOVE ,MARA ,DAM-ROOM>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
    <MOVE ,MARA-FEELING-TEST-BALLAST ,GLOBAL-OBJECTS>
    <SETG GATES-OPEN T>
    <GOTO ,DAM-ROOM>
    <TELL "TEST PRECONDITION: the unresolved rupture history is preserved at the same live Dam danger, but the player is no longer overburdened. The next descent is the player's real safer choice." CR>
    <RTRUE>>

<ROUTINE V-MARA-FEEL-STATUS-TEST ()
    <TELL "TEST Mara lived feeling: known-risk-injury=" N <MARA-GET ,MARA-SLOT-KNOWN-RISK-INJURY>
          " aided=" N <MARA-GET ,MARA-SLOT-AIDED-RECKLESS-INJURY>
          " anger=" N <MARA-GET ,MARA-SLOT-RECKLESSNESS-ANGER>
          " fear-revealed=" N <MARA-GET ,MARA-SLOT-FEAR-REVEALED>
          " intentional-harm=" N <MARA-GET ,MARA-SLOT-INTENTIONAL-HARM>
          " betrayal=" N <MARA-GET ,MARA-SLOT-HARM-BETRAYAL>
          " rupture-open=" N <MARA-GET ,MARA-SLOT-RUPTURE-OPEN>
          " apology=" N <MARA-GET ,MARA-SLOT-APOLOGY-ACKNOWLEDGED>
          " boundary=" N <MARA-GET ,MARA-SLOT-BOUNDARY-RESPECTED>
          " repair-evidence=" N <MARA-GET ,MARA-SLOT-REPAIR-EVIDENCE>
          " repaired=" N <MARA-GET ,MARA-SLOT-RUPTURE-REPAIRED> "." CR>
    <TELL "TEST Mara mode=" N <MARA-GET ,MARA-SLOT-MODE> "; location is " D <LOC ,MARA> "." CR>
    <RTRUE>>
