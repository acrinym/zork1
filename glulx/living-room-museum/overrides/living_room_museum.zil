"Living-room museum and physical display for the repository-local Zork I Glulx lineage."

;"Release 1220 turns the canonical Living Room into an optional physical
  autobiography. Real objects move onto real surfaces. The trophy case keeps
  canonical score authority. No display creates a copy, retires an object from
  puzzle use, or prevents ordinary retrieval."

<CONSTANT MUSEUM-SCHEMA 1>

<GLOBAL MUSEUM-VERSION 1>
<GLOBAL MUSEUM-EVENT-DISPLAYED <>>
<GLOBAL MUSEUM-EVENT-CASE <>>
<GLOBAL MUSEUM-GROUP-HOUSE <>>
<GLOBAL MUSEUM-GROUP-RITUAL <>>
<GLOBAL MUSEUM-GROUP-DAM <>>
<GLOBAL MUSEUM-GROUP-CONFLICT <>>
<GLOBAL MUSEUM-GROUP-CANARY <>>
<GLOBAL MUSEUM-THEFT-OCCURRED <>>
<GLOBAL MUSEUM-THEFT-OBJECT <>>
<GLOBAL MUSEUM-THEFT-FROM <>>
<GLOBAL MUSEUM-LAST-DISPLAYED <>>

<ROUTINE MUSEUM-SURFACE? (OBJ)
    <COND (<EQUAL? .OBJ ,MUSEUM-FRAME ,MUSEUM-WEAPON-WALL
                        ,MUSEUM-RECORD-SHELF ,MUSEUM-RELIC-STAND>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-ON-DISPLAY? (OBJ "AUX" P)
    <SET P .OBJ>
    <REPEAT ()
        <SET P <LOC .P>>
        <COND (<NOT .P> <RFALSE>)
              (<OR <EQUAL? .P ,TROPHY-CASE>
                   <MUSEUM-SURFACE? .P>>
               <RTRUE>)>>>

<ROUTINE MUSEUM-ACTIVE-FIELD-OBJECT? (OBJ)
    <COND (<AND <EQUAL? .OBJ ,BELL ,CANDLES ,BOOK>
                <NOT ,LLD-FLAG>>
           <RTRUE>)
          (<AND <EQUAL? .OBJ ,EGG ,CANARY>
                <NOT ,EGG-SOLVE>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-ACCEPTS? (SURFACE OBJ)
    <COND (<NOT <FSET? .OBJ ,TAKEBIT>> <RFALSE>)
          (<EQUAL? .SURFACE ,MUSEUM-FRAME>
           <COND (<EQUAL? .OBJ ,PAINTING ,MAP> <RTRUE>)>)
          (<EQUAL? .SURFACE ,MUSEUM-WEAPON-WALL>
           <COND (<OR <FSET? .OBJ ,WEAPONBIT>
                      <EQUAL? .OBJ ,SWORD ,AXE ,KNIFE ,RUSTY-KNIFE ,STILETTO>>
                  <RTRUE>)>)
          (<EQUAL? .SURFACE ,MUSEUM-RECORD-SHELF>
           <COND (<EQUAL? .OBJ ,MAP ,GUIDE ,OWNERS-MANUAL ,ADVERTISEMENT
                               ,BOAT-LABEL ,MATCH ,BOOK>
                  <RTRUE>)>)
          (<EQUAL? .SURFACE ,MUSEUM-RELIC-STAND>
           <COND (<OR <G? <GETP .OBJ ,P?TVALUE> 0>
                      <EQUAL? .OBJ ,BELL ,CANDLES ,TORCH ,WRENCH
                                   ,SCREWDRIVER ,PUTTY ,PUMP ,KEYS ,SHOVEL>>
                  <RTRUE>)>)>
    <RFALSE>>

<ROUTINE MUSEUM-PROVENANCE (OBJ)
    <COND (<EQUAL? .OBJ ,PAINTING>
           <TELL "recovered from the Gallery, where one last masterpiece survived the vandals">)
          (<EQUAL? .OBJ ,SWORD>
           <TELL "found already hanging above the white house's trophy case">)
          (<EQUAL? .OBJ ,MAP>
           <TELL "found in the canonical trophy case, charting the forest and Stone Barrow">)
          (<EQUAL? .OBJ ,AXE>
           <TELL "taken from the troll's violent custody">)
          (<EQUAL? .OBJ ,STILETTO>
           <TELL "separated from the thief who carried it">)
          (<EQUAL? .OBJ ,KNIFE>
           <TELL "recovered from the Attic table">)
          (<EQUAL? .OBJ ,RUSTY-KNIFE>
           <TELL "found beside the dead adventurer in the maze">)
          (<EQUAL? .OBJ ,GUIDE>
           <TELL "issued in the abandoned lobby of Flood Control Dam #3">)
          (<EQUAL? .OBJ ,WRENCH ,SCREWDRIVER ,PUTTY>
           <TELL "recovered from the maintenance works of Flood Control Dam #3">)
          (<EQUAL? .OBJ ,BELL ,CANDLES ,BOOK>
           <TELL "associated with the ceremony at the entrance to Hades">)
          (<EQUAL? .OBJ ,EGG ,CANARY ,BROKEN-EGG ,BROKEN-CANARY>
           <TELL "bound to the forest's jeweled egg and clockwork-bird history">)
          (<EQUAL? .OBJ ,TRIDENT>
           <TELL "recovered from the shore of Atlantis">)
          (<EQUAL? .OBJ ,COFFIN>
           <TELL "removed from the Egypt Room">)
          (<EQUAL? .OBJ ,CHALICE>
           <TELL "recovered from the thief's Treasure Room">)
          (<EQUAL? .OBJ ,BRACELET>
           <TELL "recovered from the Gas Room">)
          (<G? <GETP .OBJ ,P?TVALUE> 0>
           <TELL "recovered as genuine treasure during this expedition">)
          (T
           <TELL "kept as material evidence from this expedition">)>>

<ROUTINE MUSEUM-DESCRIBE-SURFACE (SURFACE "AUX" ITEM)
    <COND (<EQUAL? .SURFACE ,MUSEUM-FRAME>
           <TELL "A deep wooden frame is fixed to the wall for a painting or map.">)
          (<EQUAL? .SURFACE ,MUSEUM-WEAPON-WALL>
           <TELL "Pegs and brackets form a weapon wall without dulling or disarming anything placed there.">)
          (<EQUAL? .SURFACE ,MUSEUM-RECORD-SHELF>
           <TELL "A narrow record shelf holds maps, manuals, labels, and other paper evidence.">)
          (T
           <TELL "A low, broad relic stand supports recovered objects without enclosing them.">)>
    <SET ITEM <FIRST? .SURFACE>>
    <COND (<NOT .ITEM>
           <TELL " It is empty." CR>)
          (T
           <TELL CR "Its current display is:" CR>
           <REPEAT ()
               <COND (<NOT .ITEM> <RETURN>)>
               <TELL "  " D .ITEM " - ">
               <MUSEUM-PROVENANCE .ITEM>
               <COND (<MUSEUM-ACTIVE-FIELD-OBJECT? .ITEM>
                      <TELL "; still active field equipment, not a retired exhibit">)>
               <TELL "." CR>
               <SET ITEM <NEXT? .ITEM>>>)>
    <RTRUE>>

<ROUTINE MUSEUM-SURFACE-FCN ("AUX" SURFACE)
    <COND (<MUSEUM-SURFACE? ,PRSO> <SET SURFACE ,PRSO>)
          (<MUSEUM-SURFACE? ,PRSI> <SET SURFACE ,PRSI>)>
    <COND (<AND .SURFACE <VERB? EXAMINE LOOK-INSIDE SEARCH>>
           <MUSEUM-DESCRIBE-SURFACE .SURFACE>)
          (<AND .SURFACE <VERB? OPEN CLOSE>>
           <TELL "The display surface is deliberately open. Security comes from using the trophy case or securing the house, not from pretending a shelf has a lid." CR>
           <RTRUE>)
          (<AND .SURFACE <VERB? TAKE MOVE MUNG>
                <EQUAL? ,PRSO .SURFACE>>
           <TELL "The display surface is fixed to the Living Room and is not itself an exhibit." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-BEGIN ()
    <COND (<AND <VERB? PUT PUT-ON>
                <MUSEUM-SURFACE? ,PRSI>>
           <COND (<NOT <MUSEUM-ACCEPTS? ,PRSI ,PRSO>>
                  <TELL "That object does not belong on that display surface. The frame accepts the painting or map; the weapon wall accepts weapons; the record shelf accepts paper evidence; and the relic stand accepts treasures, ritual objects, and selected tools." CR>
                  <RTRUE>)>)>
    <RFALSE>>

<ROUTINE MUSEUM-DISPLAY-ROOT? (OBJ)
    <COND (<OR <EQUAL? <LOC .OBJ> ,TROPHY-CASE>
               <MUSEUM-SURFACE? <LOC .OBJ>>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-GROUP-HOUSE? ()
    <COND (<AND <MUSEUM-ON-DISPLAY? ,PAINTING>
                <MUSEUM-ON-DISPLAY? ,SWORD>
                <MUSEUM-ON-DISPLAY? ,MAP>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-GROUP-RITUAL? ()
    <COND (<AND ,LLD-FLAG
                <MUSEUM-ON-DISPLAY? ,BELL>
                <MUSEUM-ON-DISPLAY? ,CANDLES>
                <MUSEUM-ON-DISPLAY? ,BOOK>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-GROUP-DAM? ()
    <COND (<AND <EQUAL? ,WATER-LEVEL -1>
                <MUSEUM-ON-DISPLAY? ,GUIDE>
                <MUSEUM-ON-DISPLAY? ,WRENCH>
                <MUSEUM-ON-DISPLAY? ,SCREWDRIVER>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-GROUP-CONFLICT? ()
    <COND (<AND <MUSEUM-ON-DISPLAY? ,SWORD>
                <MUSEUM-ON-DISPLAY? ,AXE>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-GROUP-CANARY? ()
    <COND (<OR <AND <MUSEUM-ON-DISPLAY? ,EGG>
                    <IN? ,CANARY ,EGG>>
               <AND <MUSEUM-ON-DISPLAY? ,BROKEN-EGG>
                    <IN? ,BROKEN-CANARY ,BROKEN-EGG>>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-REFRESH-GROUPS ()
    <COND (<MUSEUM-GROUP-HOUSE?> <SETG MUSEUM-GROUP-HOUSE T>)>
    <COND (<MUSEUM-GROUP-RITUAL?> <SETG MUSEUM-GROUP-RITUAL T>)>
    <COND (<MUSEUM-GROUP-DAM?> <SETG MUSEUM-GROUP-DAM T>)>
    <COND (<MUSEUM-GROUP-CONFLICT?> <SETG MUSEUM-GROUP-CONFLICT T>)>
    <COND (<MUSEUM-GROUP-CANARY?> <SETG MUSEUM-GROUP-CANARY T>)>
    <RFALSE>>

<ROUTINE MUSEUM-ENSURE ()
    <COND (<NOT <EQUAL? ,MUSEUM-VERSION ,MUSEUM-SCHEMA>>
           <SETG MUSEUM-VERSION ,MUSEUM-SCHEMA>
           <SETG MUSEUM-EVENT-DISPLAYED
                 <OR <FIRST? ,MUSEUM-FRAME>
                     <FIRST? ,MUSEUM-WEAPON-WALL>
                     <FIRST? ,MUSEUM-RECORD-SHELF>
                     <FIRST? ,MUSEUM-RELIC-STAND>>>
           <SETG MUSEUM-EVENT-CASE <FIRST? ,TROPHY-CASE>>
           <COND (,MUSEUM-THEFT-OCCURRED
                  <FCLEAR ,MUSEUM-THEFT-EVIDENCE ,INVISIBLE>)>
           <MUSEUM-REFRESH-GROUPS>)>
    <RFALSE>>

<ROUTINE MUSEUM-LIVING-END ()
    <MUSEUM-ENSURE>
    <COND (<AND <VERB? PUT PUT-ON>
                ,PRSO
                <MUSEUM-DISPLAY-ROOT? ,PRSO>>
           <SETG MUSEUM-LAST-DISPLAYED ,PRSO>
           <COND (<IN? ,PRSO ,TROPHY-CASE>
                  <SETG MUSEUM-EVENT-CASE T>)
                 (T
                  <SETG MUSEUM-EVENT-DISPLAYED T>)>
           <COND (<MUSEUM-ACTIVE-FIELD-OBJECT? ,PRSO>
                  <TELL "The placement is only a display. The " D ,PRSO " remains real, removable, and still required wherever the adventure requires it." CR>)>)>
    <MUSEUM-REFRESH-GROUPS>
    <RFALSE>>

<ROUTINE MUSEUM-VALUABLE-IN (CONTAINER "AUX" ITEM)
    <SET ITEM <FIRST? .CONTAINER>>
    <REPEAT ()
        <COND (<NOT .ITEM> <RFALSE>)
              (<AND <G? <GETP .ITEM ,P?TVALUE> 0>
                    <NOT <FSET? .ITEM ,INVISIBLE>>>
               <RETURN .ITEM>)>
        <SET ITEM <NEXT? .ITEM>>>>

<ROUTINE MUSEUM-UNSECURED-VALUABLE ("AUX" ITEM)
    <COND (<SET ITEM <MUSEUM-VALUABLE-IN ,MUSEUM-FRAME>> <RETURN .ITEM>)
          (<SET ITEM <MUSEUM-VALUABLE-IN ,MUSEUM-WEAPON-WALL>> <RETURN .ITEM>)
          (<SET ITEM <MUSEUM-VALUABLE-IN ,MUSEUM-RECORD-SHELF>> <RETURN .ITEM>)
          (<SET ITEM <MUSEUM-VALUABLE-IN ,MUSEUM-RELIC-STAND>> <RETURN .ITEM>)
          (<AND <FSET? ,TROPHY-CASE ,OPENBIT>
                <SET ITEM <MUSEUM-VALUABLE-IN ,TROPHY-CASE>>>
           <RETURN .ITEM>)>
    <RFALSE>>

<ROUTINE MUSEUM-THIEF-AVAILABLE? ()
    <COND (<AND <G? <GETP ,THIEF ,P?STRENGTH> 0>
                <NOT <EQUAL? <LOC ,THIEF> ,TREASURE-ROOM>>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-ENTER ("AUX" ITEM FROM)
    <MUSEUM-ENSURE>
    <HOUSE-STATE-REFRESH>
    <COND (<AND <NOT ,MUSEUM-THEFT-OCCURRED>
                <G? ,HOUSE-STATE-SECURITY 0>
                <MUSEUM-THIEF-AVAILABLE?>
                <SET ITEM <MUSEUM-UNSECURED-VALUABLE>>>
           <SET FROM <LOC .ITEM>>
           <MOVE .ITEM ,THIEF>
           <FSET .ITEM ,TOUCHBIT>
           <FSET .ITEM ,INVISIBLE>
           <SETG MUSEUM-THEFT-OCCURRED T>
           <SETG MUSEUM-THEFT-OBJECT .ITEM>
           <SETG MUSEUM-THEFT-FROM .FROM>
           <FCLEAR ,MUSEUM-THEFT-EVIDENCE ,INVISIBLE>
           <SETG HOUSE-EVENT-DISTURBANCE T>
           <SETG SCORE <+ ,BASE-SCORE <OTVAL-FROB>>>
           <SCORE-UPD 0>
           <TELL "The Living Room has been disturbed. A precise empty space marks where the " D .ITEM " had been displayed, and a short black thread is caught on the edge of the " D .FROM ". The real object is gone; nothing has been copied or replaced." CR CR>)>
    <MUSEUM-REFRESH-GROUPS>
    <RFALSE>>

<ROUTINE MUSEUM-COMPACT-SURFACE (SURFACE LABEL)
    <COND (<FIRST? .SURFACE>
           <TELL .LABEL " holds ">
           <PRINT-CONTENTS .SURFACE>
           <TELL "." CR>)>
    <RFALSE>>

<ROUTINE MUSEUM-PROJECT ()
    <MUSEUM-ENSURE>
    <MUSEUM-REFRESH-GROUPS>
    <TELL "A deep frame, a bracketed weapon wall, a narrow record shelf, and a low relic stand make the room usable as a small private museum." CR>
    <MUSEUM-COMPACT-SURFACE ,MUSEUM-FRAME "The frame">
    <MUSEUM-COMPACT-SURFACE ,MUSEUM-WEAPON-WALL "The weapon wall">
    <MUSEUM-COMPACT-SURFACE ,MUSEUM-RECORD-SHELF "The record shelf">
    <MUSEUM-COMPACT-SURFACE ,MUSEUM-RELIC-STAND "The relic stand">
    <COND (<MUSEUM-GROUP-HOUSE?>
           <TELL "Together, the painting, sword, and map compress the white house's abandoned past and the beginning of your expedition into one wall." CR>)>
    <COND (<MUSEUM-GROUP-RITUAL?>
           <TELL "The bell, candles, and black book now read as a complete record of the ceremony rather than three disconnected tools." CR>)>
    <COND (<MUSEUM-GROUP-DAM?>
           <TELL "The guidebook and maintenance tools form an accidental bureaucratic monument to the repaired dam." CR>)>
    <COND (<MUSEUM-GROUP-CONFLICT?>
           <TELL "The elvish sword beside the troll's axe turns the weapon wall into a blunt account of one passage that did not open politely." CR>)>
    <COND (<MUSEUM-GROUP-CANARY?>
           <TELL "The jeweled egg and its clockwork inhabitant preserve the forest episode as one nested object history." CR>)>
    <COND (,MUSEUM-THEFT-OCCURRED
           <TELL "Scuffed dust, a cut hanging line, and the black thread preserve evidence of the museum theft." CR>)>
    <RFALSE>>

<ROUTINE MUSEUM-EVIDENCE-FCN ()
    <COND (<VERB? EXAMINE SEARCH READ>
           <TELL "The disturbance is small and practiced: a clean empty outline, a cut support, and a black thread. It records the removal of the ">
           <COND (,MUSEUM-THEFT-OBJECT <TELL D ,MUSEUM-THEFT-OBJECT>)
                 (T <TELL "missing exhibit">)>
           <TELL " from the ">
           <COND (,MUSEUM-THEFT-FROM <TELL D ,MUSEUM-THEFT-FROM>)
                 (T <TELL "display">)>
           <TELL ". The evidence identifies theft, not a magical duplicate or deletion." CR>
           <RTRUE>)
          (<VERB? TAKE MOVE MUNG>
           <TELL "The useful evidence is the pattern left in the room, not a portable black thread collectible." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-RECAP ("AUX" (SEEN <>))
    <MUSEUM-ENSURE>
    <COND (,MUSEUM-EVENT-DISPLAYED
           <SET SEEN T>
           <TELL "- You began arranging real expedition objects on the Living Room's fixed museum surfaces." CR>)>
    <COND (,MUSEUM-EVENT-CASE
           <SET SEEN T>
           <TELL "- The canonical trophy case remained the scoring display while other surfaces remained score-neutral." CR>)>
    <COND (,MUSEUM-GROUP-HOUSE
           <SET SEEN T>
           <TELL "- The painting, sword, and map formed the house-history display group." CR>)>
    <COND (,MUSEUM-GROUP-RITUAL
           <SET SEEN T>
           <TELL "- The completed bell, candles, and black-book ceremony formed a coherent ritual record." CR>)>
    <COND (,MUSEUM-GROUP-DAM
           <SET SEEN T>
           <TELL "- Dam records and maintenance tools formed a coherent repair display." CR>)>
    <COND (,MUSEUM-GROUP-CONFLICT
           <SET SEEN T>
           <TELL "- The sword and troll axe formed a conflict display." CR>)>
    <COND (,MUSEUM-GROUP-CANARY
           <SET SEEN T>
           <TELL "- The jeweled egg preserved its nested canary history on display." CR>)>
    <COND (,MUSEUM-THEFT-OCCURRED
           <SET SEEN T>
           <TELL "- An unsecured valuable was stolen into the real thief's custody, leaving physical evidence and a canonical recovery path." CR>)>
    <COND (.SEEN <RTRUE>)>
    <RFALSE>>

<OBJECT MUSEUM-FRAME
    (IN LIVING-ROOM)
    (SYNONYM FRAME MOUNT)
    (ADJECTIVE DEEP WOODEN PICTURE GALLERY)
    (DESC "gallery frame")
    (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT TRYTAKEBIT)
    (ACTION MUSEUM-SURFACE-FCN)
    (CAPACITY 30)>

<OBJECT MUSEUM-WEAPON-WALL
    (IN LIVING-ROOM)
    (SYNONYM RACK PEGS BRACKETS WALL)
    (ADJECTIVE WEAPON BRACKETED DISPLAY)
    (DESC "weapon wall")
    (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT TRYTAKEBIT)
    (ACTION MUSEUM-SURFACE-FCN)
    (CAPACITY 120)>

<OBJECT MUSEUM-RECORD-SHELF
    (IN LIVING-ROOM)
    (SYNONYM SHELF RECORDS PAPERS)
    (ADJECTIVE RECORD NARROW DISPLAY)
    (DESC "record shelf")
    (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT TRYTAKEBIT)
    (ACTION MUSEUM-SURFACE-FCN)
    (CAPACITY 80)>

<OBJECT MUSEUM-RELIC-STAND
    (IN LIVING-ROOM)
    (SYNONYM STAND PLINTH PEDESTAL)
    (ADJECTIVE RELIC LOW BROAD DISPLAY)
    (DESC "relic stand")
    (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT TRYTAKEBIT)
    (ACTION MUSEUM-SURFACE-FCN)
    (CAPACITY 250)>

<OBJECT MUSEUM-THEFT-EVIDENCE
    (IN LIVING-ROOM)
    (SYNONYM THREAD DUST OUTLINE EVIDENCE MARKS)
    (ADJECTIVE BLACK CUT SCUFFED EMPTY)
    (DESC "museum theft evidence")
    (FLAGS NDESCBIT INVISIBLE TRYTAKEBIT)
    (ACTION MUSEUM-EVIDENCE-FCN)>
