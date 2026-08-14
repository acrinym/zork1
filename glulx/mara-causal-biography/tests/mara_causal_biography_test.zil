"TEST-ONLY MARA CAUSAL BIOGRAPHY PRECONDITIONS"

<SYNTAX MARAPREP = V-MARA-PREP-TEST>
<SYNTAX MARANEGATIVE = V-MARA-NEGATIVE-TEST>
<SYNTAX MARALOAD = V-MARA-LOAD-TEST>
<SYNTAX MARASTATUS = V-MARA-STATUS-TEST>

<OBJECT MARA-TEST-BALLAST
    (IN GLOBAL-OBJECTS)
    (SYNONYM BALLAST WEIGHT)
    (ADJECTIVE TEST HEAVY IRON)
    (DESC "test ballast")
    (FLAGS TAKEBIT NDESCBIT)
    (SIZE 200)>

<ROUTINE MARA-TEST-RESET ()
    <MARA-RESET-STATE>
    <MARA-PUT ,MARA-SLOT-MET 1>
    <MARA-PUT ,MARA-SLOT-DAM-SURVEY 1>
    <MARA-PUT ,MARA-SLOT-HOUSE-STAY 1>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
    <MARA-PUT ,MARA-SLOT-BIO-IGNORED-WARNING 1>
    <MOVE ,MARA ,DAM-ROOM>
    <MOVE ,MARA-FIELD-ROPE ,MARA>
    <MOVE ,MARA-TEST-BALLAST ,GLOBAL-OBJECTS>
    <SETG GATES-OPEN T>
    <GOTO ,DAM-ROOM>
    <RTRUE>>

<ROUTINE V-MARA-PREP-TEST ()
    <MARA-TEST-RESET>
    <SETG DEBUG T>
    <TELL "TEST PRECONDITION: Mara and her exact field rope at the dangerous Dam ladder; ignored-warning history is present." CR>
    <RTRUE>>

<ROUTINE V-MARA-NEGATIVE-TEST ()
    <MARA-TEST-RESET>
    <MOVE ,MARA-TEST-BALLAST ,ADVENTURER>
    <TELL "TEST PRECONDITION: same overloaded open-sluice ladder, ignored-warning history only." CR>
    <RTRUE>>

<ROUTINE V-MARA-LOAD-TEST ()
    <MOVE ,MARA-TEST-BALLAST ,ADVENTURER>
    <TELL "TEST PRECONDITION: player now carries heavy test ballast for the same open-sluice ladder hazard." CR>
    <RTRUE>>

<ROUTINE V-MARA-STATUS-TEST ()
    <TELL "TEST Mara biography: ignored=" N <MARA-GET ,MARA-SLOT-BIO-IGNORED-WARNING>
          " rescued-mara=" N <MARA-GET ,MARA-SLOT-BIO-RESCUED-MARA>
          " rope-returned=" N <MARA-GET ,MARA-SLOT-BIO-ROPE-RETURNED>
          " promise=" N <MARA-GET ,MARA-SLOT-ROPE-PROMISE>
          " broken=" N <MARA-GET ,MARA-SLOT-BIO-BROKE-PROMISE>
          " abandoned=" N <MARA-GET ,MARA-SLOT-BIO-ABANDONED-PERIL>
          " mara-rescued-you=" N <MARA-GET ,MARA-SLOT-BIO-MARA-RESCUED-YOU>
          " injury=" N <MARA-GET ,MARA-SLOT-LADDER-INJURY>
          " private=" N <MARA-GET ,MARA-SLOT-PRIVATE-LADDER-DISCOVERY> "." CR>
    <COND (<IN? ,MARA-FIELD-ROPE ,MARA>
           <TELL "TEST rope custody: Mara." CR>)
          (<IN? ,MARA-FIELD-ROPE ,ADVENTURER>
           <TELL "TEST rope custody: player." CR>)
          (T
           <TELL "TEST rope custody: elsewhere." CR>)>
    <RTRUE>>
