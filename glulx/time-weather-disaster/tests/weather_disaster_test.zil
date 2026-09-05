"RELEASE 1307 WEATHER TEST VERBS — test story only"

<SYNTAX WX-CANYON = V-WX-CANYON>
<SYNTAX WX-DAM-OPEN = V-WX-DAM-OPEN>
<SYNTAX WX-DAM-CLOSED = V-WX-DAM-CLOSED>
<SYNTAX WX-CANYON-BOTTOM = V-WX-CANYON-BOTTOM>

<ROUTINE WX-RESET ()
    <WEATHER-DISASTER-PUT ,WD-STAGE ,WEATHER-FAIR>
    <WEATHER-DISASTER-PUT ,WD-TIMER 0>
    <WEATHER-DISASTER-PUT ,WD-TURNS 30>
    <WEATHER-DISASTER-PUT ,WD-SWEPT 0>
    <RTRUE>>

<ROUTINE V-WX-CANYON ()
    <WX-RESET>
    <SETG GATES-OPEN <>>
    <MOVE ,BOTTLE ,CANYON-VIEW>
    <MOVE ,SANDWICH-BAG ,CANYON-VIEW>
    <GOTO ,CANYON-VIEW>
    <TELL "[TEST] Canyon View is fair; bottle and brown sack are loose on exposed ground." CR>>

<ROUTINE V-WX-DAM-OPEN ()
    <WX-RESET>
    <SETG GATES-OPEN T>
    <MOVE ,BOTTLE ,DAM-ROOM>
    <MOVE ,SANDWICH-BAG ,DAM-ROOM>
    <GOTO ,DAM-ROOM>
    <TELL "[TEST] Dam is fair; canonical sluice state is open; bottle and brown sack are loose on top." CR>>

<ROUTINE V-WX-DAM-CLOSED ()
    <WX-RESET>
    <SETG GATES-OPEN <>>
    <MOVE ,BOTTLE ,DAM-ROOM>
    <MOVE ,SANDWICH-BAG ,DAM-ROOM>
    <GOTO ,DAM-ROOM>
    <TELL "[TEST] Dam is fair; canonical sluice state is closed; bottle and brown sack are loose on top." CR>>

<ROUTINE V-WX-CANYON-BOTTOM ()
    <GOTO ,CANYON-BOTTOM>
    <TELL "[TEST] Positioned at Canyon Bottom without changing Release 1307 weather state." CR>>
