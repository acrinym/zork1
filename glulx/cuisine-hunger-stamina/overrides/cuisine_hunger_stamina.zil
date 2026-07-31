"CUISINE, HUNGER, AND STAMINA for Release 1235"

;"Food matters through authored preparation and selected exertion, not through
  a permanent survival clock. Hunger never advances merely because a turn
  passed. The real lunch and garlic remain canonical objects."

<SYNTAX COMBINE OBJECT (HELD CARRIED ON-GROUND IN-ROOM)
    WITH OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-CUISINE-COMBINE>
<SYNONYM COMBINE MIX SEASON>
<SYNTAX REST = V-CUISINE-REST>
<SYNTAX CHECK OBJECT (FIND RMUNGBIT) = V-CUISINE-STATUS>

<CONSTANT CUISINE-SCHEMA 1>
<CONSTANT CS-VERSION 0>
<CONSTANT CS-STRAIN 1>
<CONSTANT CS-HUNGER 2>
<CONSTANT CS-SATIATION 3>
<CONSTANT CS-RECIPE 4>
<CONSTANT CS-MEALS 5>
<CONSTANT CS-BLOCKED 6>
<CONSTANT CUISINE-STATE <TABLE CUISINE-SCHEMA 0 0 0 0 0 0>>

<CONSTANT CUISINE-RECIPE-NONE 0>
<CONSTANT CUISINE-RECIPE-PREPARED 1>
<CONSTANT CUISINE-RECIPE-GARLIC-PEPPER 2>

<OBJECT CUISINE-BODY
    (IN GLOBAL-OBJECTS)
    (SYNONYM APPETITE HUNGER STAMINA ENDURANCE BODY)
    (ADJECTIVE MY PHYSICAL)
    (DESC "appetite and stamina")
    (FLAGS NDESCBIT RMUNGBIT)>

<ROUTINE CUISINE-GET (SLOT)
    <GET ,CUISINE-STATE .SLOT>>

<ROUTINE CUISINE-PUT (SLOT VALUE)
    <PUT ,CUISINE-STATE .SLOT .VALUE>>

<ROUTINE CUISINE-EXERTION? ()
    <COND (<VERB? CLIMB-UP CLIMB-DOWN CLIMB-FOO LEAP>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CUISINE-ENSURE ()
    <COND (<NOT <EQUAL? <CUISINE-GET ,CS-VERSION> ,CUISINE-SCHEMA>>
           <CUISINE-PUT ,CS-VERSION ,CUISINE-SCHEMA>
           <CUISINE-PUT ,CS-STRAIN 0>
           <CUISINE-PUT ,CS-HUNGER 0>
           <CUISINE-PUT ,CS-SATIATION 0>
           <CUISINE-PUT ,CS-RECIPE
                        <COND (<KITCHEN-GET ,KS-LUNCH-PREPARED>
                               ,CUISINE-RECIPE-PREPARED)
                              (T ,CUISINE-RECIPE-NONE)>>
           <CUISINE-PUT ,CS-MEALS 0>
           <CUISINE-PUT ,CS-BLOCKED 0>)>
    <RFALSE>>

<ROUTINE CUISINE-MEAL-LEVEL ()
    <CUISINE-ENSURE>
    <COND (<EQUAL? <CUISINE-GET ,CS-RECIPE>
                   ,CUISINE-RECIPE-GARLIC-PEPPER>
           <COND (<G? <KITCHEN-GET ,KS-LUNCH-WARM> 0> <RETURN 3>)
                 (T <RETURN 2>)>)
          (<EQUAL? <CUISINE-GET ,CS-RECIPE>
                   ,CUISINE-RECIPE-PREPARED>
           <COND (<G? <KITCHEN-GET ,KS-LUNCH-WARM> 0> <RETURN 2>)
                 (T <RETURN 1>)>)>
    <RETURN 0>>

<ROUTINE CUISINE-ACTION-HOOK ()
    <CUISINE-ENSURE>
    <COND (<AND <CUISINE-EXERTION?>
                <G? <CUISINE-GET ,CS-HUNGER> 0>
                <G? <CUISINE-GET ,CS-STRAIN> 2>
                <ZERO? <CUISINE-GET ,CS-SATIATION>>>
           <CUISINE-PUT ,CS-BLOCKED 1>
           <TELL "Your strength is not gone, but this repeated exertion has become clumsy. Rest will recover enough to continue; a prepared meal will recover you fully." CR>
           <RTRUE>)
          (<AND <VERB? EAT>
                <EQUAL? ,PRSO ,LUNCH>
                <G? <CUISINE-MEAL-LEVEL> 0>>
           <CUISINE-EAT-MEAL>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CUISINE-ADVANCE ("AUX" STRAIN)
    <CUISINE-ENSURE>
    <COND (<SHADOW-NON-TURN-COMMAND?> <RFALSE>)>
    <COND (<AND <VERB? KITCHEN-PREPARE>
                <KITCHEN-GET ,KS-LUNCH-PREPARED>
                <ZERO? <CUISINE-GET ,CS-RECIPE>>>
           <CUISINE-PUT ,CS-RECIPE ,CUISINE-RECIPE-PREPARED>)>
    <COND (<CUISINE-GET ,CS-BLOCKED>
           <CUISINE-PUT ,CS-BLOCKED 0>
           <RFALSE>)>
    <COND (<CUISINE-EXERTION?>
           <COND (<G? <CUISINE-GET ,CS-SATIATION> 0>
                  <CUISINE-PUT ,CS-SATIATION
                               <- <CUISINE-GET ,CS-SATIATION> 1>>
                  <COND (<G? <CUISINE-GET ,CS-STRAIN> 0>
                         <CUISINE-PUT ,CS-STRAIN
                                      <- <CUISINE-GET ,CS-STRAIN> 1>>)>)
                 (T
                  <SET STRAIN <+ <CUISINE-GET ,CS-STRAIN> 1>>
                  <COND (<G? .STRAIN 3> <SET STRAIN 3>)>
                  <CUISINE-PUT ,CS-STRAIN .STRAIN>
                  <COND (<EQUAL? .STRAIN 2>
                         <TELL "The exertion leaves your breath short. This is fatigue, not a permanent countdown." CR>)
                        (<EQUAL? .STRAIN 3>
                         <CUISINE-PUT ,CS-HUNGER 1>
                         <TELL "Repeated exertion has made the neglected lunch feel relevant. Rest can steady you; prepared food can restore you." CR>)>)>)>
    <RFALSE>>

<ROUTINE V-CUISINE-COMBINE ()
    <CUISINE-ENSURE>
    <COND (<NOT <EQUAL? ,HERE ,KITCHEN>>
           <TELL "This food combination needs the white-house Kitchen worktop." CR>)
          (<NOT <AND <EQUAL? ,PRSO ,LUNCH>
                     <EQUAL? ,PRSI ,GARLIC>>>
           <TELL "The bounded recipe here is the real hot-pepper lunch seasoned with the real garlic." CR>)
          (<NOT <IN? ,LUNCH ,KITCHEN-WORKTOP>>
           <TELL "Put the lunch on the worktop before combining it." CR>)
          (<NOT <OR <IN? ,GARLIC ,WINNER>
                    <IN? ,GARLIC ,KITCHEN-WORKTOP>>>
           <TELL "Bring the garlic to the worktop or hold it while seasoning the lunch." CR>)
          (<NOT <KITCHEN-GET ,KS-LUNCH-PREPARED>>
           <TELL "Prepare the lunch before seasoning it." CR>)
          (<NOT <KITCHEN-GET ,KS-GARLIC-SLICED>>
           <TELL "Slice the garlic with a real blade before using it as seasoning." CR>)
          (T
           <CUISINE-PUT ,CS-RECIPE ,CUISINE-RECIPE-GARLIC-PEPPER>
           <KITCHEN-PUT ,KS-WORKTOP-RESIDUE T>
           <TELL "You work a small amount of sliced garlic into the prepared hot-pepper sandwich. The real garlic remains available; the lunch now carries the authored garlic-pepper combination." CR>)>
    <RTRUE>>

<ROUTINE CUISINE-EAT-MEAL ("AUX" LEVEL)
    <SET LEVEL <CUISINE-MEAL-LEVEL>>
    <REMOVE ,LUNCH>
    <CUISINE-PUT ,CS-STRAIN 0>
    <CUISINE-PUT ,CS-HUNGER 0>
    <CUISINE-PUT ,CS-SATIATION .LEVEL>
    <CUISINE-PUT ,CS-MEALS <+ <CUISINE-GET ,CS-MEALS> 1>>
    <TELL "You eat the real prepared lunch">
    <COND (<EQUAL? <CUISINE-GET ,CS-RECIPE>
                   ,CUISINE-RECIPE-GARLIC-PEPPER>
           <TELL ", its garlic and hot pepper forming a sharp deliberate meal">)>
    <COND (<G? <KITCHEN-GET ,KS-LUNCH-WARM> 0>
           <TELL ", still warm from the range">)>
    <TELL ". The meal clears accumulated strain and leaves a bounded reserve for later exertion; no permanent hunger clock begins." CR>
    <RTRUE>>

<ROUTINE V-CUISINE-REST ()
    <CUISINE-ENSURE>
    <COND (<ZERO? <CUISINE-GET ,CS-STRAIN>>
           <TELL "You are already physically steady." CR>)
          (<G? <CUISINE-GET ,CS-HUNGER> 0>
           <CUISINE-PUT ,CS-STRAIN 1>
           <TELL "You stop and recover your breath. The immediate fatigue eases, though exertion has still made you hungry." CR>)
          (T
           <CUISINE-PUT ,CS-STRAIN 0>
           <TELL "You stop long enough for the accumulated strain to pass." CR>)>
    <RTRUE>>

<ROUTINE V-CUISINE-STATUS ()
    <CUISINE-ENSURE>
    <TELL "Your appetite is ">
    <COND (<G? <CUISINE-GET ,CS-HUNGER> 0> <TELL "noticeable">)
          (T <TELL "quiet">)>
    <TELL ", and your exertion strain is ">
    <COND (<ZERO? <CUISINE-GET ,CS-STRAIN>> <TELL "clear">)
          (<EQUAL? <CUISINE-GET ,CS-STRAIN> 1> <TELL "light">)
          (<EQUAL? <CUISINE-GET ,CS-STRAIN> 2> <TELL "moderate">)
          (T <TELL "high">)>
    <TELL ".">
    <COND (<G? <CUISINE-GET ,CS-SATIATION> 0>
           <TELL " A prepared meal still supports " N <CUISINE-GET ,CS-SATIATION>
                 " exertion">
           <COND (<NOT <EQUAL? <CUISINE-GET ,CS-SATIATION> 1>>
                  <TELL "s">)>
           <TELL ".">)>
    <CRLF>
    <RTRUE>>
