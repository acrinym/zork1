"ZORK PLUS: VETERAN SURVEY EXPEDITION for Release 1237"

;"A genuinely sealed first expedition unlocks one explicitly selected
  postgame survey. Canonical objects remain singular and physical."

<SYNTAX CHOOSE OBJECT (HELD CARRIED) = V-VETERAN-CHOOSE>
<SYNONYM CHOOSE SELECT DECLARE>
<SYNTAX BEGIN VETERAN = V-VETERAN-BEGIN>
<SYNTAX BEGIN EXPEDITION = V-VETERAN-BEGIN>
<SYNTAX CROSS OBJECT (ON-GROUND IN-ROOM) = V-VETERAN-CROSS>
<SYNONYM CROSS TRAVERSE>
<SYNTAX RECORD OBJECT (ON-GROUND IN-ROOM) = V-VETERAN-RECORD>
<SYNONYM RECORD COPY SURVEY>
<SYNTAX COMPLETE EXPEDITION = V-VETERAN-COMPLETE>
<SYNTAX REVIEW VETERAN = V-VETERAN-STATUS>

<CONSTANT VETERAN-SCHEMA 1>
<CONSTANT VETERAN-SLOT-VERSION 0>
<CONSTANT VETERAN-SLOT-ACTIVE 1>
<CONSTANT VETERAN-SLOT-SELECTED 2>
<CONSTANT VETERAN-SLOT-ROUTE 3>
<CONSTANT VETERAN-SLOT-RECORDED 4>
<CONSTANT VETERAN-SLOT-COMPLETED 5>
<CONSTANT VETERAN-SLOT-RETAINED 6>
<CONSTANT VETERAN-STATE <TABLE VETERAN-SCHEMA 0 0 0 0 0 0>>

<CONSTANT VETERAN-ROUTE-NONE 0>
<CONSTANT VETERAN-ROUTE-LANTERN 1>
<CONSTANT VETERAN-ROUTE-ROPE 2>

<ROOM VETERAN-TRAILHEAD
    (IN ROOMS)
    (DESC "Veteran Survey Trailhead")
    (LDESC "A narrow survey trail begins close to the white house but outside the first expedition's old route. South, an abandoned cut breaks the trail before a dark overlook.")
    (FLAGS RLANDBIT ONBIT)>

<ROOM VETERAN-OVERLOOK
    (IN ROOMS)
    (DESC "Veteran Survey Overlook")
    (LDESC "The far side of the cut opens onto a wind-scoured overlook. An old Imperial boundary marker stands here, beyond the routes recorded by the first expedition.")
    (FLAGS RLANDBIT ONBIT)>

<OBJECT VETERAN-DISPATCH
    (SYNONYM DISPATCH LETTER NOTICE ORDERS)
    (ADJECTIVE VETERAN SURVEY POSTGAME)
    (DESC "veteran survey dispatch")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 1)
    (ACTION VETERAN-DISPATCH-FCN)>

<OBJECT VETERAN-HOLD-TRUNK
    (SYNONYM TRUNK HOLD LOCKER CHEST)
    (ADJECTIVE VETERAN ATTIC FIELD)
    (DESC "veteran hold trunk")
    (LDESC "A stout veteran hold trunk waits beside the completed-expedition boxes.")
    (FLAGS CONTBIT OPENBIT SEARCHBIT TRYTAKEBIT)
    (CAPACITY 200)>

<OBJECT VETERAN-FIELD-CARD
    (SYNONYM CARD MANIFEST RECEIPT RECORD)
    (ADJECTIVE VETERAN FIELD LOADOUT)
    (DESC "veteran expedition field card")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 1)
    (ACTION VETERAN-FIELD-CARD-FCN)>

<OBJECT VETERAN-CUT-NEAR
    (IN VETERAN-TRAILHEAD)
    (SYNONYM CUT GAP SPAN CROSSING)
    (ADJECTIVE SURVEY ABANDONED NEAR)
    (DESC "near side of the abandoned survey cut")
    (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
    (CAPACITY 20)>

<OBJECT VETERAN-CUT-FAR
    (IN VETERAN-OVERLOOK)
    (SYNONYM CUT GAP SPAN CROSSING)
    (ADJECTIVE SURVEY ABANDONED FAR)
    (DESC "far side of the abandoned survey cut")
    (FLAGS NDESCBIT)>

<OBJECT VETERAN-MARKER
    (IN VETERAN-OVERLOOK)
    (SYNONYM MARKER POST MONUMENT BOUNDARY)
    (ADJECTIVE IMPERIAL OLD SURVEY)
    (DESC "old Imperial boundary marker")
    (FLAGS NDESCBIT TRYTAKEBIT READBIT)
    (ACTION VETERAN-MARKER-FCN)>

<ROUTINE VETERAN-GET (SLOT)
    <GET ,VETERAN-STATE .SLOT>>

<ROUTINE VETERAN-PUT (SLOT VALUE)
    <PUT ,VETERAN-STATE .SLOT .VALUE>>

<ROUTINE VETERAN-ENSURE ()
    <COND (<NOT <EQUAL? <VETERAN-GET ,VETERAN-SLOT-VERSION>
                        ,VETERAN-SCHEMA>>
           <VETERAN-PUT ,VETERAN-SLOT-VERSION ,VETERAN-SCHEMA>
           <VETERAN-PUT ,VETERAN-SLOT-ACTIVE 0>
           <VETERAN-PUT ,VETERAN-SLOT-SELECTED 0>
           <VETERAN-PUT ,VETERAN-SLOT-ROUTE ,VETERAN-ROUTE-NONE>
           <VETERAN-PUT ,VETERAN-SLOT-RECORDED 0>
           <VETERAN-PUT ,VETERAN-SLOT-COMPLETED 0>
           <VETERAN-PUT ,VETERAN-SLOT-RETAINED 0>)>
    <RFALSE>>

<ROUTINE VETERAN-UNLOCKED? ()
    <COND (<EXPEDITION-HAS? ,ES-SEALED 1> <RTRUE>)>
    <RFALSE>>

<ROUTINE VETERAN-MATERIALIZE ()
    <VETERAN-ENSURE>
    <COND (<VETERAN-UNLOCKED?>
           <COND (<NOT <LOC ,VETERAN-DISPATCH>>
                  <MOVE ,VETERAN-DISPATCH ,EXPEDITION-BOX-A>)>
           <COND (<NOT <LOC ,VETERAN-HOLD-TRUNK>>
                  <MOVE ,VETERAN-HOLD-TRUNK ,ATTIC>)>)>
    <COND (<AND <VETERAN-GET ,VETERAN-SLOT-COMPLETED>
                <NOT <LOC ,VETERAN-FIELD-CARD>>>
           <MOVE ,VETERAN-FIELD-CARD ,EXPEDITION-BOX-B>)>
    <RFALSE>>

<ROUTINE VETERAN-DISPATCH-FCN ()
    <COND (<VERB? READ EXAMINE>
           <TELL "The dispatch recognizes one sealed completed expedition and offers a separate veteran survey. In the Attic, choose either the real brass lantern or the real rope, then BEGIN VETERAN EXPEDITION. Every other directly carried object will remain in the physical hold trunk." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE VETERAN-MARKER-FCN ()
    <COND (<VERB? READ EXAMINE>
           <TELL "The weathered marker names a survey boundary beyond the first expedition's archived route. Recording it, rather than removing it, is the veteran objective." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE VETERAN-PRINT-ROUTE ()
    <COND (<EQUAL? <VETERAN-GET ,VETERAN-SLOT-ROUTE>
                   ,VETERAN-ROUTE-LANTERN>
           <TELL "lantern route">)
          (<EQUAL? <VETERAN-GET ,VETERAN-SLOT-ROUTE>
                   ,VETERAN-ROUTE-ROPE>
           <TELL "rope route">)
          (T <TELL "no selected route">)>
    <RTRUE>>

<ROUTINE VETERAN-FIELD-CARD-FCN ()
    <COND (<VERB? READ EXAMINE>
           <TELL "The veteran field card records the ">
           <VETERAN-PRINT-ROUTE>
           <TELL ". The boundary marker is ">
           <COND (<VETERAN-GET ,VETERAN-SLOT-RECORDED>
                  <TELL "recorded">)
                 (T <TELL "not yet recorded">)>
           <TELL ".">
           <COND (<VETERAN-GET ,VETERAN-SLOT-COMPLETED>
                  <TELL " The selected canonical item was ">
                  <COND (<VETERAN-GET ,VETERAN-SLOT-RETAINED>
                         <TELL "retained at completion">)
                        (T <TELL "left in the field at completion">)>
                  <TELL ".">)>
           <CRLF>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE V-VETERAN-CHOOSE ()
    <VETERAN-MATERIALIZE>
    <COND (<NOT <EQUAL? ,HERE ,ATTIC>>
           <TELL "Veteran loadout selection belongs beside the sealed expedition boxes and hold trunk in the Attic." CR>)
          (<NOT <VETERAN-UNLOCKED?>>
           <TELL "No veteran dispatch exists until Expedition A records a genuine completed victory." CR>)
          (<EXPEDITION-HAS? ,ES-SEALED 2>
           <TELL "Expedition Box B is already sealed. The bounded veteran survey cannot overwrite it." CR>)
          (<VETERAN-GET ,VETERAN-SLOT-ACTIVE>
           <TELL "The veteran expedition is already active." CR>)
          (<NOT <IN? ,PRSO ,WINNER>>
           <TELL "Carry the exact item you intend to declare." CR>)
          (<EQUAL? ,PRSO ,LAMP>
           <VETERAN-PUT ,VETERAN-SLOT-SELECTED ,LAMP>
           <VETERAN-PUT ,VETERAN-SLOT-ROUTE ,VETERAN-ROUTE-LANTERN>
           <TELL "You declare the real brass lantern as the single veteran field item. Its actual condition and light state will matter." CR>)
          (<EQUAL? ,PRSO ,ROPE>
           <VETERAN-PUT ,VETERAN-SLOT-SELECTED ,ROPE>
           <VETERAN-PUT ,VETERAN-SLOT-ROUTE ,VETERAN-ROUTE-ROPE>
           <TELL "You declare the real rope as the single veteran field item. It will leave your hands when physically secured at the survey cut." CR>)
          (T
           <TELL "This authored survey accepts one of two exact loadouts: the canonical brass lantern or the canonical rope." CR>)>
    <RTRUE>>

<ROUTINE VETERAN-STOW-OTHER-GEAR (SELECTED "AUX" ITEM NEXT)
    <SET ITEM <FIRST? ,WINNER>>
    <REPEAT ()
        <COND (<NOT .ITEM> <RETURN>)>
        <SET NEXT <NEXT? .ITEM>>
        <COND (<NOT <EQUAL? .ITEM .SELECTED>>
               <MOVE .ITEM ,VETERAN-HOLD-TRUNK>)>
        <SET ITEM .NEXT>>
    <RTRUE>>

<ROUTINE V-VETERAN-BEGIN ("AUX" SELECTED)
    <VETERAN-MATERIALIZE>
    <SET SELECTED <VETERAN-GET ,VETERAN-SLOT-SELECTED>>
    <COND (<NOT <EQUAL? ,HERE ,ATTIC>>
           <TELL "Begin the veteran expedition beside its physical dispatch and hold trunk in the Attic." CR>)
          (<NOT <VETERAN-UNLOCKED?>>
           <TELL "A sealed Expedition A is required before any veteran departure." CR>)
          (<EXPEDITION-HAS? ,ES-SEALED 2>
           <TELL "Expedition Box B already contains a separate completed history." CR>)
          (<VETERAN-GET ,VETERAN-SLOT-ACTIVE>
           <TELL "The veteran expedition is already active." CR>)
          (<ZERO? .SELECTED>
           <TELL "Choose the real brass lantern or real rope before departure." CR>)
          (<NOT <IN? .SELECTED ,WINNER>>
           <TELL "The declared canonical item must be directly carried at departure; the archive will not manufacture or remotely retrieve it." CR>)
          (T
           <VETERAN-STOW-OTHER-GEAR .SELECTED>
           <MOVE ,VETERAN-FIELD-CARD ,WINNER>
           <VETERAN-PUT ,VETERAN-SLOT-ACTIVE 1>
           <VETERAN-PUT ,VETERAN-SLOT-RECORDED 0>
           <VETERAN-PUT ,VETERAN-SLOT-COMPLETED 0>
           <VETERAN-PUT ,VETERAN-SLOT-RETAINED 0>
           <MOVE ,WINNER ,VETERAN-TRAILHEAD>
           <TELL "You close the Attic hold trunk on every unselected carried object and descend to the veteran trailhead with one canonical field item and the mission card. Expedition A remains sealed behind you as a separate history." CR>)>
    <RTRUE>>

<ROUTINE VETERAN-CROSS-LANTERN (OUTBOUND)
    <COND (<NOT <IN? ,LAMP ,WINNER>>
           <TELL "The declared brass lantern is no longer in your hands." CR>)
          (<NOT <FSET? ,LAMP ,ONBIT>>
           <TELL "The cut hides its narrow shelf in darkness. Turn on the real lantern before trusting that route." CR>)
          (T
           <COND (.OUTBOUND
                  <MOVE ,WINNER ,VETERAN-OVERLOOK>
                  <CUISINE-ENSURE>
                  <COND (<ZERO? <CUISINE-GET ,CUISINE-SLOT-STRAIN>>
                         <CUISINE-PUT ,CUISINE-SLOT-STRAIN 1>)>
                  <TELL "The lit lantern reveals a narrow shelf under the broken survey edge. You move sideways through the dark, carrying the light and feeling the crossing in your legs, until the overlook opens ahead." CR>)
                 (T
                  <MOVE ,WINNER ,VETERAN-TRAILHEAD>
                  <TELL "The same lit shelf carries you back to the veteran trailhead. The lantern remains the exact object you brought." CR>)>
           <RTRUE>)>
    <RTRUE>>

<ROUTINE VETERAN-CROSS-ROPE (OUTBOUND)
    <COND (.OUTBOUND
           <COND (<IN? ,ROPE ,WINNER>
                  <MOVE ,ROPE ,VETERAN-CUT-NEAR>
                  <MOVE ,WINNER ,VETERAN-OVERLOOK>
                  <TELL "You secure the real rope across the abandoned cut and cross hand over hand. The rope remains physically on the near-side anchor rather than following you as imaginary equipment." CR>)
                 (<IN? ,ROPE ,VETERAN-CUT-NEAR>
                  <MOVE ,WINNER ,VETERAN-OVERLOOK>
                  <TELL "The already secured canonical rope carries you across to the overlook." CR>)
                 (T
                  <TELL "The declared rope is neither in your hands nor secured at the survey cut." CR>)>)
          (T
           <COND (<IN? ,ROPE ,VETERAN-CUT-NEAR>
                  <MOVE ,WINNER ,VETERAN-TRAILHEAD>
                  <TELL "You cross back along the same physically secured rope. It remains on the near-side anchor until you deliberately take it." CR>)
                 (T
                  <TELL "Without the real rope on the near-side anchor, that return route does not exist." CR>)>)>
    <RTRUE>>

<ROUTINE V-VETERAN-CROSS ()
    <VETERAN-ENSURE>
    <COND (<NOT <VETERAN-GET ,VETERAN-SLOT-ACTIVE>>
           <TELL "No veteran expedition is active." CR>)
          (<AND <EQUAL? ,HERE ,VETERAN-TRAILHEAD>
                <EQUAL? ,PRSO ,VETERAN-CUT-NEAR>>
           <COND (<EQUAL? <VETERAN-GET ,VETERAN-SLOT-ROUTE>
                          ,VETERAN-ROUTE-LANTERN>
                  <VETERAN-CROSS-LANTERN T>)
                 (T <VETERAN-CROSS-ROPE T>)>)
          (<AND <EQUAL? ,HERE ,VETERAN-OVERLOOK>
                <EQUAL? ,PRSO ,VETERAN-CUT-FAR>>
           <COND (<EQUAL? <VETERAN-GET ,VETERAN-SLOT-ROUTE>
                          ,VETERAN-ROUTE-LANTERN>
                  <VETERAN-CROSS-LANTERN <>>) 
                 (T <VETERAN-CROSS-ROPE <>>)>)
          (T
           <TELL "The veteran survey cut is not here." CR>)>
    <RTRUE>>

<ROUTINE V-VETERAN-RECORD ()
    <VETERAN-ENSURE>
    <COND (<NOT <VETERAN-GET ,VETERAN-SLOT-ACTIVE>>
           <TELL "No veteran expedition is active." CR>)
          (<NOT <EQUAL? ,HERE ,VETERAN-OVERLOOK>>
           <TELL "The survey objective stands at the veteran overlook." CR>)
          (<NOT <EQUAL? ,PRSO ,VETERAN-MARKER>>
           <TELL "The field card requires the old Imperial boundary marker, not an arbitrary object log." CR>)
          (<VETERAN-GET ,VETERAN-SLOT-RECORDED>
           <TELL "The boundary marker is already recorded on the physical veteran field card." CR>)
          (T
           <VETERAN-PUT ,VETERAN-SLOT-RECORDED 1>
           <TELL "You copy the marker's weathered boundary notation onto the veteran field card. The record names what you actually reached without removing or duplicating the marker." CR>)>
    <RTRUE>>

<ROUTINE V-VETERAN-COMPLETE ("AUX" SELECTED)
    <VETERAN-ENSURE>
    <SET SELECTED <VETERAN-GET ,VETERAN-SLOT-SELECTED>>
    <COND (<NOT <VETERAN-GET ,VETERAN-SLOT-ACTIVE>>
           <TELL "No veteran expedition is active." CR>)
          (<NOT <EQUAL? ,HERE ,VETERAN-TRAILHEAD>>
           <TELL "Return physically to the veteran trailhead before completing the expedition." CR>)
          (<NOT <VETERAN-GET ,VETERAN-SLOT-RECORDED>>
           <TELL "The veteran field card still lacks the overlook boundary marker." CR>)
          (<EXPEDITION-HAS? ,ES-SEALED 2>
           <TELL "Expedition Box B is already sealed and cannot be overwritten." CR>)
          (T
           <COND (<IN? .SELECTED ,WINNER>
                  <VETERAN-PUT ,VETERAN-SLOT-RETAINED 1>)
                 (T <VETERAN-PUT ,VETERAN-SLOT-RETAINED 0>)>
           <VETERAN-PUT ,VETERAN-SLOT-ACTIVE 0>
           <VETERAN-PUT ,VETERAN-SLOT-COMPLETED 1>
           <MOVE ,WINNER ,ATTIC>
           <EXPEDITION-CAPTURE-B>
           <MOVE ,VETERAN-FIELD-CARD ,EXPEDITION-BOX-B>
           <TELL "You return to the Attic and seal the veteran survey as Expedition B. Its field card, selected route, retained-or-lost item outcome, score, deaths, and bounded history remain physically separate from Expedition A." CR>)>
    <RTRUE>>

<ROUTINE V-VETERAN-STATUS ()
    <VETERAN-MATERIALIZE>
    <COND (<NOT <VETERAN-UNLOCKED?>>
           <TELL "Veteran Expedition remains locked until a genuine completed Expedition A is sealed." CR>)
          (T
           <TELL "Veteran Expedition is ">
           <COND (<VETERAN-GET ,VETERAN-SLOT-COMPLETED>
                  <TELL "completed">)
                 (<VETERAN-GET ,VETERAN-SLOT-ACTIVE>
                  <TELL "active">)
                 (T <TELL "available">)>
           <TELL ". Selected route: ">
           <VETERAN-PRINT-ROUTE>
           <TELL ". Marker: ">
           <COND (<VETERAN-GET ,VETERAN-SLOT-RECORDED>
                  <TELL "recorded">)
                 (T <TELL "unrecorded">)>
           <TELL "." CR>)>
    <RTRUE>>
