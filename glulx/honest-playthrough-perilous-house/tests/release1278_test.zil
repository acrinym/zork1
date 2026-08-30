"TEST-ONLY RELEASE 1278 HONEST PLAYTHROUGH AND HOUSE-JAR PRECONDITIONS"

<SYNTAX HPLIE = V-R1278-LIE-TEST>
<SYNTAX HPDRK = V-R1278-DRINK-TEST>
<SYNTAX HPJAR = V-R1278-JAR-TEST>
<SYNTAX HPLMP = V-R1278-LAMP-TEST>
<SYNTAX HPNTB = V-R1278-NOTEBOOK-TEST>
<SYNTAX HPWIN = V-R1278-WINDOW-TEST>

<ROUTINE R1278-TEST-LIGHT ()
    <SETG ALWAYS-LIT T>
    <MOVE ,LAMP ,WINNER>
    <FSET ,LAMP ,ONBIT>
    <RTRUE>>

<ROUTINE V-R1278-WINDOW-TEST ()
    <R1278-TEST-LIGHT>
    <SETG RUG-MOVED <>>
    <FCLEAR ,TRAP-DOOR ,OPENBIT>
    <FSET ,TRAP-DOOR ,INVISIBLE>
    <FSET ,KITCHEN-WINDOW ,OPENBIT>
    <GOTO ,KITCHEN>
    <FSET ,KITCHEN ,TOUCHBIT>
    <TELL "TEST PRECONDITION: Adventurer entered the Kitchen through the open window; the living-room rug and trap door are untouched." CR>
    <RTRUE>>

<ROUTINE V-R1278-LIE-TEST ()
    <R1278-TEST-LIGHT>
    <GOTO ,BEDROOM>
    <TELL "TEST PRECONDITION: Adventurer stands in the Bedroom beside the four-poster bed." CR>
    <RTRUE>>

<ROUTINE V-R1278-DRINK-TEST ()
    <R1278-TEST-LIGHT>
    <GOTO ,KITCHEN>
    <TELL "TEST PRECONDITION: Adventurer stands at the Kitchen sink and tap." CR>
    <RTRUE>>

<ROUTINE V-R1278-JAR-TEST ()
    <R1278-TEST-LIGHT>
    <GOTO ,LIVING-ROOM>
    <MOVE ,SWORD ,WINNER>
    <MOVE ,MUSEUM-FIELD-JAR ,LIVING-ROOM>
    <TELL "TEST PRECONDITION: Adventurer holds the elvish sword in the Living Room with the water-filled field jar present." CR>
    <RTRUE>>

<ROUTINE V-R1278-LAMP-TEST ()
    <REMOVE-CAREFULLY ,BROKEN-LAMP>
    <MOVE ,LAMP ,WINNER>
    <FCLEAR ,LAMP ,ONBIT>
    <MOVE ,SWORD ,WINNER>
    <GOTO ,LIVING-ROOM>
    <SETG ALWAYS-LIT T>
    <TELL "TEST PRECONDITION: working brass lantern and real sword in the lit Living Room." CR>
    <RTRUE>>

<ROUTINE V-R1278-NOTEBOOK-TEST ()
    <R1278-TEST-LIGHT>
    <GOTO ,BEDROOM>
    <TELL "TEST PRECONDITION: Adventurer stands in the Bedroom with the dream notebook available after rest." CR>
    <RTRUE>>
