"LIVING ZORK CONSEQUENCES: GREAT CANYON FALL for Release 1236"

;"One canonical danger gains visible cause, deliberate preparation, physical
  rescue, and preserved consequence. This is not a generic hazard engine."

<SYNTAX SECURE OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-LIVING-SECURE>
<SYNONYM SECURE ANCHOR>

<CONSTANT LIVING-CANYON-SCHEMA 1>
<CONSTANT LIVING-CANYON-SLOT-VERSION 0>
<CONSTANT LIVING-CANYON-SLOT-WARNED 1>
<CONSTANT LIVING-CANYON-STATE <TABLE LIVING-CANYON-SCHEMA 0>>

<OBJECT LIVING-CANYON-EDGE
    (IN CANYON-VIEW)
    (SYNONYM EDGE RIM DROP PRECIPICE)
    (ADJECTIVE CANYON GREAT SHEER)
    (DESC "canyon rim")
    (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
    (CAPACITY 20)
    (ACTION LIVING-CANYON-EDGE-F)>

<ROUTINE LIVING-CANYON-GET (SLOT)
    <GET ,LIVING-CANYON-STATE .SLOT>>

<ROUTINE LIVING-CANYON-PUT (SLOT VALUE)
    <PUT ,LIVING-CANYON-STATE .SLOT .VALUE>>

<ROUTINE LIVING-CANYON-ENSURE ()
    <COND (<NOT <EQUAL? <LIVING-CANYON-GET ,LIVING-CANYON-SLOT-VERSION>
                        ,LIVING-CANYON-SCHEMA>>
           <LIVING-CANYON-PUT ,LIVING-CANYON-SLOT-VERSION
                              ,LIVING-CANYON-SCHEMA>
           <LIVING-CANYON-PUT ,LIVING-CANYON-SLOT-WARNED 0>)>
    <RFALSE>>

<ROUTINE LIVING-CANYON-EDGE-F ()
    <LIVING-CANYON-ENSURE>
    <COND (<VERB? EXAMINE>
           <LIVING-CANYON-PUT ,LIVING-CANYON-SLOT-WARNED 1>
           <TELL "Loose shale slides from the canyon rim and vanishes before any impact can be heard. The drop is sheer, and an unprotected leap would not leave room for correction." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE V-LIVING-SECURE ()
    <LIVING-CANYON-ENSURE>
    <COND (<NOT <EQUAL? ,PRSO ,ROPE>>
           <TELL "The useful preparation here is the real rope, not a general safety system." CR>)
          (<NOT <EQUAL? ,HERE ,CANYON-VIEW>>
           <TELL "There is no Great Canyon rim here to prepare." CR>)
          (<IN? ,ROPE ,LIVING-CANYON-EDGE>
           <TELL "The real rope is already secured at the canyon rim." CR>)
          (<NOT <IN? ,ROPE ,WINNER>>
           <TELL "You must be carrying the real rope before you can secure it." CR>)
          (T
           <MOVE ,ROPE ,LIVING-CANYON-EDGE>
           <LIVING-CANYON-PUT ,LIVING-CANYON-SLOT-WARNED 1>
           <TELL "You work the real rope around a solid projection of the west wall and test the knot with your full weight. The rope now lies physically on the canyon rim; nothing imaginary or remote will catch you." CR>)>
    <RTRUE>>

<ROUTINE LIVING-CANYON-INTERCEPT? ()
    <LIVING-CANYON-ENSURE>
    <COND (<IN? ,ROPE ,LIVING-CANYON-EDGE>
           <CUISINE-ENSURE>
           <COND (<ZERO? <CUISINE-GET ,CUISINE-SLOT-STRAIN>>
                  <CUISINE-PUT ,CUISINE-SLOT-STRAIN 1>)>
           <TELL "The shale breaks loose beneath you, but the prepared rope snaps taut against the west wall. You strike the rim, catch it with both hands, and pull yourself back onto solid ground. The rescue was earned by physical preparation, and the exertion remains in your body." CR>
           <RTRUE>)
          (<ZERO? <LIVING-CANYON-GET ,LIVING-CANYON-SLOT-WARNED>>
           <LIVING-CANYON-PUT ,LIVING-CANYON-SLOT-WARNED 1>
           <TELL "Your first shift of weight sends loose shale skittering over the rim. The stone gives you one unmistakable warning: another unprotected step would be a deliberate leap into the canyon." CR>
           <RTRUE>)>
    <RFALSE>>
