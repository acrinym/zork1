"TEST-ONLY RELEASE 1262 DRAGON PRECONDITIONS AND STATUS"

<SYNTAX DRAGONPREP = V-DRAGON-PREP-TEST>
<SYNTAX DRAGONFIREPREP = V-DRAGON-FIRE-PREP-TEST>
<SYNTAX DRAGONSTATUS = V-DRAGON-STATUS-TEST>

<ROUTINE DRAGON-TEST-BASE ()
    <DRAGON-RESET>
    <FIRE-STRUCTURAL-RESET>
    <MOVE ,LAMP ,WINNER>
    <FSET ,LAMP ,ONBIT>
    <MOVE ,CHALICE ,WINNER>
    <MOVE ,SCEPTRE ,WINNER>
    <MOVE ,TRIDENT ,WINNER>
    <RTRUE>>

<ROUTINE V-DRAGON-PREP-TEST ()
    <DRAGON-TEST-BASE>
    <GOTO ,DRAGON-GALLERY>
    <TELL "TEST PRECONDITION: lit brass lantern, live dragon, three offerable canonical treasures, cold Timber Room fire." CR>
    <RTRUE>>

<ROUTINE V-DRAGON-FIRE-PREP-TEST ()
    <DRAGON-TEST-BASE>
    <MOVE ,TORCH ,WINNER>
    <FSET ,TORCH ,ONBIT>
    <FSET ,TORCH ,FLAMEBIT>
    <GOTO ,TIMBER-ROOM>
    <TELL "TEST PRECONDITION: Timber Room, live brass lantern, live ivory torch, live dragon beyond north cleft." CR>
    <RTRUE>>

<ROUTINE V-DRAGON-STATUS-TEST ()
    <TELL "TEST dragon state: watch=" N <DRAGON-GET ,DS-WATCH>
          " toll=" N <DRAGON-GET ,DS-TOLL-PAID>
          " lured=" N <DRAGON-GET ,DS-LURED>
          " contained=" N <DRAGON-GET ,DS-CONTAINED>
          " hoard-taken=" N <DRAGON-GET ,DS-HOARD-TAKEN>
          " circlet-held=" N <COND (<IN? ,ASHEN-CIRCLET ,WINNER> 1) (T 0)>
          " star-held=" N <COND (<IN? ,STAR-GLASS ,WINNER> 1) (T 0)>
          " fire-stage=" N <FIRE-STRUCTURAL-STAGE> CR>
    <RTRUE>>
