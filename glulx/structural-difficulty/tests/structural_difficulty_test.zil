"TEST-ONLY RELEASE 1269 STRUCTURAL DIFFICULTY PRECONDITIONS"

<SYNTAX SDRESET = V-SD-RESET-TEST>
<SYNTAX SDAPPROACH = V-SD-APPROACH-TEST>
<SYNTAX SDGALLERY = V-SD-GALLERY-TEST>
<SYNTAX SDSTAT = V-SD-STATUS-TEST>

<ROUTINE SD-TEST-RESET-COMMON ()
    <SETG ALWAYS-LIT T>
    <STRUCTURAL-DIFFICULTY-RESET>
    <DRAGON-RESET>
    <ABLATIVE-RESET>
    <FIRE-STRUCTURAL-RESET>
    <COND (<IN? ,CHALICE ,WINNER> <REMOVE-CAREFULLY ,CHALICE>)>
    <MOVE ,CHALICE ,WINNER>
    <RTRUE>>

<ROUTINE V-SD-RESET-TEST ()
    <SD-TEST-RESET-COMMON>
    <GOTO ,WEST-OF-HOUSE>
    <TELL "TEST PRECONDITION: Release 1269 reset to unlocked Classic structure with the canonical dragon, fire screen, and chalice restored." CR>
    <RTRUE>>

<ROUTINE V-SD-APPROACH-TEST ()
    <GOTO ,DRAGON-APPROACH>
    <TELL "TEST TRANSIT: entered the canonical Scorched Cleft; structural difficulty is now committed." CR>
    <RTRUE>>

<ROUTINE V-SD-GALLERY-TEST ()
    <GOTO ,DRAGON-GALLERY>
    <TELL "TEST TRANSIT: entered the canonical Dragon Gallery with its existing threat and routes active." CR>
    <RTRUE>>

<ROUTINE V-SD-STATUS-TEST ()
    <TELL "TEST structural state: mode=" N <STRUCTURAL-DIFFICULTY-GET ,SD-MODE>
          " locked=" N <STRUCTURAL-DIFFICULTY-GET ,SD-LOCKED>
          " recovery-used=" N <STRUCTURAL-DIFFICULTY-GET ,SD-RECOVERY-USED>
          " dragon-initialized=" N <STRUCTURAL-DIFFICULTY-GET ,SD-DRAGON-INITIALIZED>
          " watch=" N <DRAGON-GET ,DS-WATCH>
          " screen-condition=" N <ABLATIVE-GET ,APS-CONDITION>
          " here-approach=" N <COND (<EQUAL? ,HERE ,DRAGON-APPROACH> 1) (T 0)>
          " toll=" N <DRAGON-GET ,DS-TOLL-PAID>
          " contained=" N <DRAGON-GET ,DS-CONTAINED> CR>
    <RTRUE>>
