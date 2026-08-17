"TEST-ONLY RELEASE 1268 CLUE-CHAIN PRECONDITIONS"

<SYNTAX CKTEMPLE = V-CLUE-TEMPLE-TEST>
<SYNTAX CKENGRAVINGS = V-CLUE-ENGRAVINGS-TEST>
<SYNTAX CKGALLERY = V-CLUE-GALLERY-TEST>
<SYNTAX CKFRESHGALLERY = V-CLUE-FRESH-GALLERY-TEST>
<SYNTAX CKSTAT = V-CLUE-STATUS-TEST>

<ROUTINE CLUE-TEST-CLEAR-KNOWLEDGE ()
    <CLUE-KNOWLEDGE-PUT ,CK-ANCIENT-SCRIPT 0>
    <CLUE-KNOWLEDGE-PUT ,CK-AIR-PASSAGE-MOTIF 0>
    <CLUE-KNOWLEDGE-PUT ,CK-VENT-MARK-INTERPRETED 0>
    <RTRUE>>

<ROUTINE CLUE-TEST-COMMON ()
    <SETG ALWAYS-LIT T>
    <DRAGON-RESET>
    <DRAGON-PUT ,DS-CONTAINED 1>
    <RTRUE>>

<ROUTINE V-CLUE-TEMPLE-TEST ()
    <CLUE-TEST-CLEAR-KNOWLEDGE>
    <REMOVE-CAREFULLY ,DRAGON-VENT-SEAM>
    <CLUE-TEST-COMMON>
    <GOTO ,NORTH-TEMPLE>
    <TELL "TEST PRECONDITION: lit North Temple with the fixed canonical ancient prayer in place; clue knowledge cleared." CR>
    <RTRUE>>

<ROUTINE V-CLUE-ENGRAVINGS-TEST ()
    <SETG ALWAYS-LIT T>
    <GOTO ,ENGRAVINGS-CAVE>
    <TELL "TEST TRANSIT: moved to the canonical Engravings Cave without changing remembered clue knowledge or moving either source inscription." CR>
    <RTRUE>>

<ROUTINE V-CLUE-GALLERY-TEST ()
    <CLUE-TEST-COMMON>
    <GOTO ,DRAGON-GALLERY>
    <TELL "TEST TRANSIT: moved to the lit Dragon Gallery with the dragon contained, preserving remembered clue knowledge and current seam discovery state." CR>
    <RTRUE>>

<ROUTINE V-CLUE-FRESH-GALLERY-TEST ()
    <CLUE-TEST-CLEAR-KNOWLEDGE>
    <REMOVE-CAREFULLY ,DRAGON-VENT-SEAM>
    <CLUE-TEST-COMMON>
    <GOTO ,DRAGON-GALLERY>
    <TELL "TEST PRECONDITION: lit Dragon Gallery with clue knowledge cleared and Release 1267 ventilation seam undiscovered." CR>
    <RTRUE>>

<ROUTINE V-CLUE-STATUS-TEST ()
    <TELL "TEST clue state: script=" N <CLUE-KNOWLEDGE-GET ,CK-ANCIENT-SCRIPT>
          " air-motif=" N <CLUE-KNOWLEDGE-GET ,CK-AIR-PASSAGE-MOTIF>
          " field-mark=" N <CLUE-KNOWLEDGE-GET ,CK-VENT-MARK-INTERPRETED>
          " seam-discovered=" N <COND (<IN? ,DRAGON-VENT-SEAM ,DRAGON-GALLERY> 1) (T 0)>
          " prayer-fixed=" N <COND (<IN? ,PRAYER ,NORTH-TEMPLE> 1) (T 0)>
          " engravings-fixed=" N <COND (<IN? ,ENGRAVINGS ,ENGRAVINGS-CAVE> 1) (T 0)> CR>
    <RTRUE>>
