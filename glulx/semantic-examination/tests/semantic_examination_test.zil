"TEST-ONLY RELEASE 1267 SEMANTIC-EXAMINATION PRECONDITIONS"

<SYNTAX SXTROLL = V-SEMANTIC-TROLL-TEST>
<SYNTAX SXTIMBER = V-SEMANTIC-TIMBER-TEST>
<SYNTAX SXAPPROACH = V-SEMANTIC-APPROACH-TEST>
<SYNTAX SXGALLERY = V-SEMANTIC-GALLERY-TEST>
<SYNTAX SXSMOKE = V-SEMANTIC-SMOKE-TEST>
<SYNTAX SXSTAT = V-SEMANTIC-STATUS-TEST>

<ROUTINE SEMANTIC-TEST-RESET ()
    <REMOVE-CAREFULLY ,DRAGON-VENT-SEAM>
    <FIRE-STRUCTURAL-RESET>
    <DRAGON-RESET>
    <RTRUE>>

<ROUTINE V-SEMANTIC-TROLL-TEST ()
    <SEMANTIC-TEST-RESET>
    <SETG TROLL-FLAG T>
    <REMOVE-CAREFULLY ,TROLL>
    <GOTO ,TROLL-ROOM>
    <TELL "TEST PRECONDITION: Troll Room quiet enough to inspect; the canonical wall bloodstains and deep scratches remain exactly where the room prose says they are." CR>
    <RTRUE>>

<ROUTINE V-SEMANTIC-TIMBER-TEST ()
    <SEMANTIC-TEST-RESET>
    <GOTO ,TIMBER-ROOM>
    <TELL "TEST PRECONDITION: cold untouched Timber Room with its canonical strong draft and Release 1257 fire authority reset." CR>
    <RTRUE>>

<ROUTINE V-SEMANTIC-APPROACH-TEST ()
    <SEMANTIC-TEST-RESET>
    <GOTO ,DRAGON-APPROACH>
    <TELL "TEST PRECONDITION: untouched Scorched Cleft with its described broad scratches and old white bones." CR>
    <RTRUE>>

<ROUTINE V-SEMANTIC-GALLERY-TEST ()
    <SEMANTIC-TEST-RESET>
    <DRAGON-PUT ,DS-CONTAINED 1>
    <GOTO ,DRAGON-GALLERY>
    <TELL "TEST PRECONDITION: dragon physically contained so the Gallery's old heat blackening can be inspected without spending the live-threat action window; ventilation seam not yet discovered." CR>
    <RTRUE>>

<ROUTINE V-SEMANTIC-SMOKE-TEST ()
    <SEMANTIC-TEST-RESET>
    <MOVE ,DRAGON-VENT-SEAM ,DRAGON-GALLERY>
    <FIRE-STRUCTURAL-SET-STAGE ,FIRE-TIMBER-BURNING>
    <FIRE-STRUCTURAL-PUT ,FS-TIMBER-TIMER 3>
    <GOTO ,DRAGON-GALLERY>
    <TELL "TEST PRECONDITION: discovered ventilation seam with the existing Release 1257 Timber Room fire in its real burning state." CR>
    <RTRUE>>

<ROUTINE V-SEMANTIC-STATUS-TEST ()
    <TELL "TEST semantic state: seam-discovered=" N <COND (<IN? ,DRAGON-VENT-SEAM ,DRAGON-GALLERY> 1) (T 0)>
          " fire-stage=" N <FIRE-STRUCTURAL-STAGE>
          " smoke-cover=" N <COND (<DRAGON-SMOKE-COVER?> 1) (T 0)>
          " troll-cleared=" N <COND (,TROLL-FLAG 1) (T 0)> CR>
    <RTRUE>>
