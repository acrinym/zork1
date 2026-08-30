"RELEASE 1277 HOUSE FURNITURE / PROMISE LIFECYCLE"

;"Bounded extension for Release 1277.  Furniture location remains the real
  object tree.  HAUL moves only selected freestanding House objects through
  explicitly authored one-room routes.  Mara help changes feasibility but
  never route geometry."

<SYNTAX HAUL OBJECT (ON-GROUND IN-ROOM) WEST = V-R1277-HAUL-WEST>
<SYNTAX HAUL OBJECT (ON-GROUND IN-ROOM) EAST = V-R1277-HAUL-EAST>
<SYNTAX HAUL OBJECT (ON-GROUND IN-ROOM) UP = V-R1277-HAUL-UP>
<SYNTAX HAUL OBJECT (ON-GROUND IN-ROOM) DOWN = V-R1277-HAUL-DOWN>
<SYNTAX HAUL OBJECT (ON-GROUND IN-ROOM) OUT = V-R1277-HAUL-OUT>
<SYNONYM HAUL DRAG>

<CONSTANT R1277-HS-PROMISE-NOTED 0>
<CONSTANT R1277-HOUSE-STATE <TABLE 0>>

<ROUTINE R1277-HOUSE-GET (SLOT) <GET ,R1277-HOUSE-STATE .SLOT>>
<ROUTINE R1277-HOUSE-PUT (SLOT VALUE) <PUT ,R1277-HOUSE-STATE .SLOT .VALUE>>

<OBJECT R1277-KITCHEN-CHAIR
    (IN KITCHEN)
    (SYNONYM CHAIR SEAT)
    (ADJECTIVE KITCHEN WOODEN PLAIN)
    (DESC "plain wooden kitchen chair")
    (FLAGS TAKEBIT)
    (SIZE 5)
    (FDESC "A plain wooden chair stands near the kitchen table, light enough to move without pretending it is architecture.")>

<ROUTINE R1277-REQUESTABLE-OBJECT? (OBJ)
    <COND (<EQUAL? .OBJ ,RUG ,KITCHEN-TABLE ,ATTIC-TABLE> <RTRUE>)
          (<EQUAL? .OBJ ,ARCHIVE-CABINET> <RTRUE>)>
    <RFALSE>>

<ROUTINE R1277-FURNITURE? (OBJ)
    <COND (<EQUAL? .OBJ ,KITCHEN-TABLE ,ATTIC-TABLE ,ARCHIVE-CABINET> <RTRUE>)>
    <RFALSE>>

<ROUTINE R1277-FURNITURE-HAS-CONTENTS? (OBJ)
    <COND (<FIRST? .OBJ> <RTRUE>)>
    <RFALSE>>

<ROUTINE R1277-FURNITURE-FCN ()
    <COND (<VERB? MOVE PUSH PULL TAKE>
           <TELL "The " D ,PRSO " is freestanding but too awkward to turn into an ordinary inventory object. HAUL it one real House route at a time -- for example, HAUL " D ,PRSO " WEST -- and the route itself decides whether it fits." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE R1277-ARCHIVE-CABINET-FCN ()
    <COND (<R1277-FURNITURE-FCN> <RTRUE>)>
    <ARCHIVE-SURFACE-FCN>>

<ROUTINE R1277-HAUL-NO-ROUTE (OBJ DIR)
    <COND (<EQUAL? ,HERE ,ATTIC>
           <TELL "The Attic offers one usable furniture route: the stair down. Rafters and roof are not alternate freight doors." CR>)
          (<EQUAL? ,HERE ,KITCHEN>
           <COND (<EQUAL? .DIR 2 5>
                  <TELL "The kitchen window is a human opening, not a furniture door. The " D .OBJ " will not pass through that frame without becoming a different object." CR>)
                 (<EQUAL? .DIR 4>
                  <TELL "The chimney is not a furniture route. Even Santa Claus would object to this interpretation." CR>)
                 (T
                  <TELL "There is no usable furniture route that way from the Kitchen." CR>)>)
          (<EQUAL? ,HERE ,LIVING-ROOM>
           <COND (<EQUAL? .DIR 1>
                  <TELL "The west door is still nailed shut; furniture does not gain a supernatural exemption from the same barrier." CR>)
                 (<EQUAL? .DIR 4>
                  <TELL "The Cellar opening and turn below are too tight for the " D .OBJ ". The trap door being open does not make the object narrower." CR>)
                 (T
                  <TELL "There is no House doorway for the " D .OBJ " in that direction." CR>)>)
          (T
           <TELL "This Release 1277 hauling authority is deliberately bounded to the real House routes around the selected furniture." CR>)>
    <RTRUE>>

<ROUTINE R1277-HAUL-COMMON (DIR "AUX" DEST HELP CONTENTS)
    <COND (<NOT <R1277-FURNITURE? ,PRSO>>
           <TELL "That is not one of the selected freestanding furnishings with authored hauling geometry." CR>
           <RTRUE>)
          (<NOT <EQUAL? <LOC ,PRSO> ,HERE>>
           <TELL "The real " D ,PRSO " is not in this room, so there is nothing here to haul." CR>
           <RTRUE>)>
    <SET DEST <>>
    <COND (<AND <EQUAL? ,HERE ,ATTIC> <EQUAL? .DIR 4>> <SET DEST ,KITCHEN>)
          (<AND <EQUAL? ,HERE ,KITCHEN> <EQUAL? .DIR 3>> <SET DEST ,ATTIC>)
          (<AND <EQUAL? ,HERE ,KITCHEN> <EQUAL? .DIR 1>> <SET DEST ,LIVING-ROOM>)
          (<AND <EQUAL? ,HERE ,LIVING-ROOM> <EQUAL? .DIR 2>> <SET DEST ,KITCHEN>)>
    <COND (<NOT .DEST> <R1277-HAUL-NO-ROUTE ,PRSO .DIR> <RTRUE>)>
    <SET HELP <EQUAL? <R1277-GET ,R1277-SLOT-MARA-HELPING> ,PRSO>>
    <SET CONTENTS <R1277-FURNITURE-HAS-CONTENTS? ,PRSO>>
    <COND (<AND <EQUAL? ,PRSO ,KITCHEN-TABLE> <EQUAL? .DEST ,ATTIC>>
           <TELL "The broad kitchen table reaches the stair turn and jams between wall and rail. Tilting it farther would require dismantling it; intact, it does not fit." CR>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,ATTIC-TABLE>
                <OR <EQUAL? ,HERE ,ATTIC> <EQUAL? .DEST ,ATTIC>>
                .CONTENTS>
           <TELL "The Attic table can make the stair only tilted sharply, and its current contents would simply be dumped down the steps. Empty the real surface first." CR>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,ARCHIVE-CABINET>
                <OR <EQUAL? ,HERE ,ATTIC> <EQUAL? .DEST ,ATTIC>>
                .CONTENTS>
           <TELL "The loaded filing cabinet reaches the stair turn and jams solidly between wall and banister. The files are real weight. Empty it before trying the stair." CR>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,ARCHIVE-CABINET>
                <OR <EQUAL? ,HERE ,ATTIC> <EQUAL? .DEST ,ATTIC>>
                <NOT .HELP>>
           <TELL "Empty, the steel cabinet can make the turn, but not safely under one person's control. Ask Mara to help with the cabinet if she is willing and able." CR>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,ARCHIVE-CABINET> .CONTENTS <NOT .HELP>>
           <TELL "On level floor the loaded cabinet will roll and scrape, but its mass is too much to control alone without spilling or crushing something. A willing second pair of hands would change that." CR>
           <RTRUE>)>
    <MOVE ,PRSO .DEST>
    <COND (.HELP
           <R1277-PUT ,R1277-SLOT-MARA-HELPING 0>
           <TELL "Mara keeps the opposite corner under control while you haul the real " D ,PRSO " into " D .DEST ". Its contents, if any, move only because they remain in the same physical furnishing." CR>)
          (T
           <TELL "You haul the " D ,PRSO " into " D .DEST ". The object itself changes rooms; no second furniture-position table is involved." CR>)>
    <RTRUE>>

<ROUTINE V-R1277-HAUL-WEST () <R1277-HAUL-COMMON 1>>
<ROUTINE V-R1277-HAUL-EAST () <R1277-HAUL-COMMON 2>>
<ROUTINE V-R1277-HAUL-UP () <R1277-HAUL-COMMON 3>>
<ROUTINE V-R1277-HAUL-DOWN () <R1277-HAUL-COMMON 4>>
<ROUTINE V-R1277-HAUL-OUT () <R1277-HAUL-COMMON 5>>

<ROUTINE R1277-PROMISE-TICK ("AUX" OBJ)
    <SET OBJ <R1277-GET ,R1277-SLOT-MARA-PROMISE>>
    <COND (<ZERO? .OBJ> <RFALSE>)
          (<AND <MARA-HERE?> <EQUAL? <LOC .OBJ> ,HERE>>
           <COND (<R1277-MARA-CAN-COOPERATE?>
                  <R1277-PUT ,R1277-SLOT-MARA-PROMISE 0>
                  <R1277-PUT ,R1277-SLOT-MARA-HELPING .OBJ>
                  <R1277-HOUSE-PUT ,R1277-HS-PROMISE-NOTED 0>
                  <TELL "Mara touches the " D .OBJ " and looks back at you. I said I would revisit this when we were both with the actual thing. I meant it. If you still want to move it, I have the other side." CR>
                  <RTRUE>)
                 (<MARA-GET ,MARA-SLOT-LADDER-PERIL>
                  <COND (<ZERO? <R1277-HOUSE-GET ,R1277-HS-PROMISE-NOTED>>
                         <R1277-HOUSE-PUT ,R1277-HS-PROMISE-NOTED 1>
                         <TELL "Mara glances at the promised " D .OBJ ". I have not forgotten. Not while this immediate danger is active. The promise stays pending." CR>)>
                  <RFALSE>)
                 (<AND <MARA-GET ,MARA-SLOT-LADDER-INJURY>
                       <ZERO? <MARA-GET ,MARA-SLOT-LADDER-RECOVERED>>>
                  <COND (<ZERO? <R1277-HOUSE-GET ,R1277-HS-PROMISE-NOTED>>
                         <R1277-HOUSE-PUT ,R1277-HS-PROMISE-NOTED 1>
                         <TELL "Mara studies the promised " D .OBJ " and flexes the injured shoulder once. I remember what I promised. I cannot honestly take that load yet; when the shoulder is ready, ask me to revisit it. The commitment has not evaporated." CR>)>
                  <RFALSE>)
                 (<MARA-GET ,MARA-SLOT-BIO-BROKE-PROMISE>
                  <R1277-PUT ,R1277-SLOT-MARA-PROMISE 0>
                  <R1277-HOUSE-PUT ,R1277-HS-PROMISE-NOTED 0>
                  <TELL "Mara faces the promised " D .OBJ " without pretending the relationship state stayed the same. I made that commitment before the rupture. I am releasing this optional hauling promise explicitly rather than letting it disappear in silence." CR>
                  <RTRUE>)>)>
    <RFALSE>>

<ROUTINE R1277-HOUSE-ARRANGEMENT ()
    <COND (<EQUAL? ,HERE ,KITCHEN>
           <COND (<NOT <EQUAL? <LOC ,KITCHEN-TABLE> ,KITCHEN>>
                  <TELL " The Kitchen is noticeably barer without its broad work table.">)>
           <COND (<EQUAL? <LOC ,ARCHIVE-CABINET> ,KITCHEN>
                  <TELL " A gray steel filing cabinet now occupies domestic floor space it was never designed to improve.">)>)
          (<EQUAL? ,HERE ,LIVING-ROOM>
           <COND (<EQUAL? <LOC ,KITCHEN-TABLE> ,LIVING-ROOM>
                  <TELL " The kitchen table has migrated into the Living Room, turning part of the room into a stubbornly practical work area.">)>
           <COND (<EQUAL? <LOC ,ATTIC-TABLE> ,LIVING-ROOM>
                  <TELL " The Attic table now sits downstairs, visibly imported from a different purpose.">)>
           <COND (<EQUAL? <LOC ,ARCHIVE-CABINET> ,LIVING-ROOM>
                  <TELL " The gray filing cabinet against the wall makes the Living Room look as though domestic life has lost an argument with the archive.">)>
           <COND (<EQUAL? <LOC ,R1277-KITCHEN-CHAIR> ,LIVING-ROOM>
                  <TELL " A plain kitchen chair has been deliberately recruited into the Living Room arrangement.">)>)
          (<EQUAL? ,HERE ,ATTIC>
           <COND (<NOT <EQUAL? <LOC ,ATTIC-TABLE> ,ATTIC>>
                  <TELL " The space where the old Attic table stood is conspicuously open.">)>
           <COND (<NOT <EQUAL? <LOC ,ARCHIVE-CABINET> ,ATTIC>>
                  <TELL " The driest archive wall has a cabinet-shaped absence.">)>)>
    <RFALSE>>
