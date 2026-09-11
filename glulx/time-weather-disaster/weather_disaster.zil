"Release 1307 authored time, weather, and disaster authority."

<CONSTANT WD-STAGE 0>
<CONSTANT WD-TIMER 1>
<CONSTANT WD-TURNS 2>
<CONSTANT WD-SWEPT 3>
<CONSTANT WEATHER-DISASTER-STATE <TABLE 0 0 0 0>>

<CONSTANT WEATHER-FAIR 0>
<CONSTANT WEATHER-BUILDING 1>
<CONSTANT WEATHER-WARNING 2>
<CONSTANT WEATHER-STORM 3>
<CONSTANT WEATHER-SURGE 4>
<CONSTANT WEATHER-AFTERMATH 5>

<OBJECT WEATHER-SKY
    (IN GLOBAL-OBJECTS)
    (SYNONYM SKY WEATHER CLOUD CLOUDS STORM WIND RAIN DAYLIGHT)
    (ADJECTIVE DARK LOW HEAVY STORM)
    (DESC "sky")
    (FLAGS NDESCBIT)
    (ACTION WEATHER-SKY-FCN)>

<ROUTINE WEATHER-DISASTER-GET (SLOT)
    <GET ,WEATHER-DISASTER-STATE .SLOT>>

<ROUTINE WEATHER-DISASTER-PUT (SLOT VALUE)
    <PUT ,WEATHER-DISASTER-STATE .SLOT .VALUE>>

<ROUTINE WEATHER-DISASTER-STAGE ()
    <WEATHER-DISASTER-GET ,WD-STAGE>>

<ROUTINE WEATHER-DISASTER-SET-STAGE (STAGE TIMER)
    <WEATHER-DISASTER-PUT ,WD-STAGE .STAGE>
    <WEATHER-DISASTER-PUT ,WD-TIMER .TIMER>
    <RTRUE>>

<ROUTINE WEATHER-DISASTER-ARM-ROOM? ()
    <COND (<EQUAL? ,HERE ,CANYON-VIEW ,DAM-ROOM ,DEEP-CANYON>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE WEATHER-DISASTER-EXPOSED? ()
    <COND (<FOREST-ROOM?> <RTRUE>)
          (<EQUAL? ,HERE ,WEST-OF-HOUSE ,NORTH-OF-HOUSE ,SOUTH-OF-HOUSE>
           <RTRUE>)
          (<EQUAL? ,HERE ,EAST-OF-HOUSE ,CLEARING ,PATH>
           <RTRUE>)
          (<EQUAL? ,HERE ,CANYON-VIEW ,CANYON-BOTTOM ,DEEP-CANYON>
           <RTRUE>)
          (<EQUAL? ,HERE ,DAM-ROOM ,DAM-BASE ,RESERVOIR-SOUTH ,RESERVOIR-NORTH>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE WEATHER-DISASTER-TELL-TIME ("AUX" TURN)
    <SET TURN <WEATHER-DISASTER-GET ,WD-TURNS>>
    <COND (<L? .TURN 20>
           <TELL "The light still has the clear slant of morning. ">)
          (<L? .TURN 45>
           <TELL "The expedition has moved into late morning. ">)
          (<L? .TURN 75>
           <TELL "The light has the flatter cast of afternoon. ">)
          (T
           <TELL "The day has worn into late afternoon light. ">)>
    <RTRUE>>

<ROUTINE WEATHER-DISASTER-TELL-CONDITION ("AUX" STAGE)
    <SET STAGE <WEATHER-DISASTER-STAGE>>
    <COND (<EQUAL? .STAGE ,WEATHER-FAIR>
           <TELL "The weather is fair enough to be background rather than a puzzle.">)
          (<EQUAL? .STAGE ,WEATHER-BUILDING>
           <TELL "A dark shelf of cloud is assembling beyond the canyon country, and the wind has begun to hold one direction.">)
          (<EQUAL? .STAGE ,WEATHER-WARNING>
           <TELL "The cloud shelf has closed overhead. Cold drops arrive far apart, and every exposed branch is showing the same hardening wind.">)
          (<EQUAL? .STAGE ,WEATHER-STORM>
           <TELL "Hard rain is driving across the exposed country in sheets, with gusts strong enough to worry anything left loose.">)
          (<EQUAL? .STAGE ,WEATHER-SURGE>
           <COND (,GATES-OPEN
                  <TELL "The storm runoff is at its peak, but Flood Control Dam #3 is already passing water through its open sluice gates.">)
                 (T
                  <TELL "The storm runoff is at its peak. With Flood Control Dam #3 shut, water is hammering hard against every low route and drainage line.">)>)
          (T
           <TELL "The hard rain has passed. Wet stone, stripped needles, fresh runoff marks, and anything the surge moved remain as evidence.">)>
    <RTRUE>>

<ROUTINE WEATHER-SKY-FCN ()
    <COND (<VERB? EXAMINE LOOK-INSIDE>
           <COND (<WEATHER-DISASTER-EXPOSED?>
                  <WEATHER-DISASTER-TELL-TIME>
                  <WEATHER-DISASTER-TELL-CONDITION>
                  <CRLF>)
                 (T
                  <TELL "There is no useful view of the sky from here. ">
                  <COND (<G? <WEATHER-DISASTER-STAGE> ,WEATHER-WARNING>
                         <TELL "The weather outside is nevertheless making itself heard.">)
                        (T
                         <TELL "Whatever the weather is doing, stone and timber are keeping it outside the room's immediate business.">)>
                  <CRLF>)>
           <RTRUE>)
          (<VERB? LISTEN>
           <COND (<EQUAL? <WEATHER-DISASTER-STAGE> ,WEATHER-STORM ,WEATHER-SURGE>
                  <COND (<WEATHER-DISASTER-EXPOSED?>
                         <TELL "Rain drums on leaves, stone, and old works while gusts move through the country in long audible pushes." CR>)
                        (T
                         <TELL "The storm reaches this enclosed place as a low continuous rush with occasional harder reports from outside." CR>)>)
                 (<EQUAL? <WEATHER-DISASTER-STAGE> ,WEATHER-WARNING>
                  <TELL "The wind is becoming a continuous sound rather than an occasional one." CR>)
                 (T
                  <TELL "Nothing in the weather is presently louder than the country around you." CR>)>
           <RTRUE>)
          (<VERB? SMELL>
           <COND (<EQUAL? <WEATHER-DISASTER-STAGE> ,WEATHER-WARNING ,WEATHER-STORM ,WEATHER-SURGE>
                  <TELL "The air smells of wet stone, cold rain, resin, and disturbed earth." CR>)
                 (<EQUAL? <WEATHER-DISASTER-STAGE> ,WEATHER-AFTERMATH>
                  <TELL "The air smells washed clean except where fresh mud, bark, and wet stone have been exposed." CR>)
                 (T
                  <TELL "The fair air carries whatever local earth, leaves, stone, or water happen to be nearest." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE WEATHER-DISASTER-MOVE-LOOSE (OBJ FROM TO)
    <COND (<NOT <IN? .OBJ .FROM>> <RFALSE>)>
    <MOVE .OBJ .TO>
    <COND (<EQUAL? ,HERE .FROM>
           <TELL "Runoff gets under the " D .OBJ " before you do. It skitters away downslope and disappears toward lower ground." CR>)
          (<EQUAL? ,HERE .TO>
           <TELL "A " D .OBJ " arrives from higher ground in a rush of dirty water and comes to rest nearby." CR>)>
    <RTRUE>>

<ROUTINE WEATHER-DISASTER-SWEEP-LOOSE ()
    <COND (<WEATHER-DISASTER-GET ,WD-SWEPT> <RFALSE>)>
    <WEATHER-DISASTER-PUT ,WD-SWEPT 1>
    <WEATHER-DISASTER-MOVE-LOOSE ,BOTTLE ,CANYON-VIEW ,CANYON-BOTTOM>
    <WEATHER-DISASTER-MOVE-LOOSE ,SANDWICH-BAG ,CANYON-VIEW ,CANYON-BOTTOM>
    <COND (<NOT ,GATES-OPEN>
           <WEATHER-DISASTER-MOVE-LOOSE ,BOTTLE ,DAM-ROOM ,DAM-BASE>
           <WEATHER-DISASTER-MOVE-LOOSE ,SANDWICH-BAG ,DAM-ROOM ,DAM-BASE>)>
    <RTRUE>>

<ROUTINE WEATHER-DISASTER-ANNOUNCE (STAGE)
    <COND (<NOT <WEATHER-DISASTER-EXPOSED?>> <RFALSE>)>
    <COND (<EQUAL? .STAGE ,WEATHER-BUILDING>
           <TELL "The fair sky finally changes its mind. A dark shelf is forming over the canyon country, and the breeze settles into a colder, steadier push." CR>)
          (<EQUAL? .STAGE ,WEATHER-WARNING>
           <TELL "The first widely spaced drops strike dust and stone. Branches turn their pale undersides to the wind. This is enough warning to pick up anything you do not want weather to decide for you." CR>)
          (<EQUAL? .STAGE ,WEATHER-STORM>
           <TELL "The storm arrives without randomness or ceremony: hard rain, sustained wind, and runoff beginning to find every downhill line." CR>)
          (<EQUAL? .STAGE ,WEATHER-SURGE>
           <COND (,GATES-OPEN
                  <TELL "The runoff surge reaches Flood Control Dam #3. Because the sluice gates are already open, the dam answers with a tremendous controlled roar instead of holding the whole pulse behind it." CR>)
                 (T
                  <TELL "The runoff surge reaches Flood Control Dam #3 with the sluice gates shut. Water piles hard behind the works while canyon runoff becomes fast enough to carry loose things toward lower ground." CR>)>)
          (<EQUAL? .STAGE ,WEATHER-AFTERMATH>
           <TELL "The hard rain breaks apart. Water still runs from every ledge and root, but the dangerous pulse is passing. The country does not put moved objects back where they started." CR>)>
    <RTRUE>>

<ROUTINE WEATHER-DISASTER-ADVANCE ("AUX" STAGE TIMER TURN)
    <SET TURN <+ <WEATHER-DISASTER-GET ,WD-TURNS> 1>>
    <WEATHER-DISASTER-PUT ,WD-TURNS .TURN>
    <SET STAGE <WEATHER-DISASTER-STAGE>>
    <COND (<EQUAL? .STAGE ,WEATHER-FAIR>
           <COND (<WEATHER-DISASTER-ARM-ROOM?>
                  <WEATHER-DISASTER-SET-STAGE ,WEATHER-BUILDING 4>
                  <WEATHER-DISASTER-ANNOUNCE ,WEATHER-BUILDING>)>
           <RFALSE>)
          (<EQUAL? .STAGE ,WEATHER-AFTERMATH>
           <RFALSE>)>
    <SET TIMER <WEATHER-DISASTER-GET ,WD-TIMER>>
    <COND (<G? .TIMER 1>
           <WEATHER-DISASTER-PUT ,WD-TIMER <- .TIMER 1>>
           <RFALSE>)>
    <COND (<EQUAL? .STAGE ,WEATHER-BUILDING>
           <WEATHER-DISASTER-SET-STAGE ,WEATHER-WARNING 3>
           <WEATHER-DISASTER-ANNOUNCE ,WEATHER-WARNING>)
          (<EQUAL? .STAGE ,WEATHER-WARNING>
           <WEATHER-DISASTER-SET-STAGE ,WEATHER-STORM 3>
           <WEATHER-DISASTER-ANNOUNCE ,WEATHER-STORM>)
          (<EQUAL? .STAGE ,WEATHER-STORM>
           <WEATHER-DISASTER-SET-STAGE ,WEATHER-SURGE 3>
           <WEATHER-DISASTER-SWEEP-LOOSE>
           <WEATHER-DISASTER-ANNOUNCE ,WEATHER-SURGE>)
          (<EQUAL? .STAGE ,WEATHER-SURGE>
           <WEATHER-DISASTER-SET-STAGE ,WEATHER-AFTERMATH 0>
           <WEATHER-DISASTER-ANNOUNCE ,WEATHER-AFTERMATH>)>
    <RFALSE>>
