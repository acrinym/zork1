"Bedroom rest, discovery-driven dreams, and delayed house consequences for the repository-local Zork I Glulx lineage."

;"Release 1228 adds one authored Bedroom and an optional rest command. Full
  sleep advances the canonical clock one step at a time, stops on interruption,
  grants only bounded nonterminal recovery when new expedition evidence exists,
  and writes physical dream and overnight records. WAIT remains canonical."

<CONSTANT REST-SCHEMA 1>
<CONSTANT REST-CLOCK-STEPS 3>

<CONSTANT RS-VERSION 0>
<CONSTANT RS-CYCLES 1>
<CONSTANT RS-LAST-SIGNATURE 2>
<CONSTANT RS-DREAMED 3>
<CONSTANT RS-OVERNIGHT 4>
<CONSTANT RS-EVENT-RESTED 5>
<CONSTANT RS-EVENT-REFUSED 6>
<CONSTANT RS-EVENT-INTERRUPTED 7>
<CONSTANT RS-EVENT-RECOVERY 8>
<CONSTANT RS-EVENT-DREAM 9>
<CONSTANT RS-EVENT-OVERNIGHT 10>
<CONSTANT RS-EVENT-WAKE 11>
<CONSTANT RS-LAST-DREAM 12>
<CONSTANT RS-FILED 13>
<CONSTANT RS-WAKE-HANDLED 14>
<CONSTANT RS-EVENT-RESTORE 15>

<CONSTANT REST-DREAM-HOUSE 1>
<CONSTANT REST-DREAM-FOREST 2>
<CONSTANT REST-DREAM-DAM 4>
<CONSTANT REST-DREAM-HADES 8>
<CONSTANT REST-DREAM-ACTORS 16>
<CONSTANT REST-DREAM-ARCHIVE 32>
<CONSTANT REST-DREAM-FOLLY 64>
<CONSTANT REST-DREAM-MUSEUM 128>

<CONSTANT REST-OVERNIGHT-MAIL 1>
<CONSTANT REST-OVERNIGHT-VISITOR 2>
<CONSTANT REST-OVERNIGHT-THEFT 4>
<CONSTANT REST-OVERNIGHT-DAMP 8>
<CONSTANT REST-OVERNIGHT-SMOKE 16>
<CONSTANT REST-OVERNIGHT-MOVEMENT 32>
<CONSTANT REST-OVERNIGHT-ARCHIVE 64>

<CONSTANT REST-WAKE-CELLAR 1>
<CONSTANT REST-WAKE-VISITOR 2>
<CONSTANT REST-WAKE-THEFT 4>
<CONSTANT REST-WAKE-CLOCK 8>

<CONSTANT REST-REC-NOTEBOOK 1>
<CONSTANT REST-REC-REPORT 2>

<CONSTANT REST-STATE <TABLE 1 0 0 0 0 <> <> <> <> <> <> <> 0 0 0 <>>>

<OBJECT REST-BED
    (IN BEDROOM)
    (SYNONYM BED BEDSTEAD MATTRESS BLANKETS PILLOW)
    (ADJECTIVE FOUR POSTER OLD CLEAN WHITE)
    (DESC "four-poster bed")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION REST-BED-FCN)>

<OBJECT REST-DREAM-NOTEBOOK
    (IN BEDROOM)
    (SYNONYM NOTEBOOK JOURNAL BOOK RECORD DREAMS)
    (ADJECTIVE DREAM BEDSIDE CLOTH BOUND)
    (DESC "cloth-bound dream notebook")
    (FDESC "A cloth-bound notebook rests on the bedside table, open to a blank page.")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 2)
    (ACTION REST-RECORD-FCN)>

<OBJECT REST-OVERNIGHT-REPORT
    (SYNONYM REPORT RECORD CARBON COPY PAPER)
    (ADJECTIVE OVERNIGHT REST BEDROOM ARCHIVE)
    (DESC "carbon-copy overnight report")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 2)
    (ACTION REST-RECORD-FCN)>

<ROUTINE REST-GET (SLOT)
    <GET ,REST-STATE .SLOT>>

<ROUTINE REST-PUT (SLOT VALUE)
    <PUT ,REST-STATE .SLOT .VALUE>>

<ROUTINE REST-HAS? (SLOT BIT)
    <COND (<NOT <0? <BAND <REST-GET .SLOT> .BIT>>> <RTRUE>)>
    <RFALSE>>

<ROUTINE REST-SET (SLOT BIT)
    <REST-PUT .SLOT <BOR <REST-GET .SLOT> .BIT>>
    <RTRUE>>

<ROUTINE REST-RECORD? (OBJ)
    <COND (<EQUAL? .OBJ ,REST-DREAM-NOTEBOOK ,REST-OVERNIGHT-REPORT>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE REST-RECORD-BIT (OBJ)
    <COND (<EQUAL? .OBJ ,REST-DREAM-NOTEBOOK> <RETURN ,REST-REC-NOTEBOOK>)
          (<EQUAL? .OBJ ,REST-OVERNIGHT-REPORT> <RETURN ,REST-REC-REPORT>)>
    <RETURN 0>>

<ROUTINE REST-ENSURE ()
    <COND (<NOT <EQUAL? <REST-GET ,RS-VERSION> ,REST-SCHEMA>>
           <REST-PUT ,RS-VERSION ,REST-SCHEMA>
           <COND (<G? <REST-GET ,RS-CYCLES> 0>
                  <REST-MATERIALIZE>)>)>
    <RFALSE>>

<ROUTINE REST-MATERIALIZE ()
    <COND (<NOT <LOC ,REST-OVERNIGHT-REPORT>>
           <MOVE ,REST-OVERNIGHT-REPORT ,ARCHIVE-CABINET>)>
    <REST-SET ,RS-OVERNIGHT ,REST-OVERNIGHT-ARCHIVE>
    <REST-PUT ,RS-EVENT-OVERNIGHT T>
    <RTRUE>>

<ROUTINE REST-DREAM-SIGNATURE ("AUX" (SIG ,REST-DREAM-HOUSE))
    <COND (<NOT <0? <AREA-GET ,AREA-SLOT-FOREST>>>
           <SET SIG <BOR .SIG ,REST-DREAM-FOREST>>)>
    <COND (<OR ,DAM-MECH-PANEL-DIAGNOSED
               ,DAM-MECH-INTERLOCK-SEEN
               ,DAM-MECH-LEAK-REPAIRED>
           <SET SIG <BOR .SIG ,REST-DREAM-DAM>>)>
    <COND (<OR ,RITUAL-BELL-ANSWERED
               ,RITUAL-WRONG-ORDER-SEEN
               ,RITUAL-PRAYER-COMPLETED
               ,LLD-FLAG>
           <SET SIG <BOR .SIG ,REST-DREAM-HADES>>)>
    <COND (<NOT <0? <NPC-GET ,NS-SEEN>>>
           <SET SIG <BOR .SIG ,REST-DREAM-ACTORS>>)>
    <COND (<OR <G? <PLAYBACK-GET ,PB-SLOT-COUNT> 0>
               <AREA-HAS? ,AREA-SLOT-COMPLETE ,AREA-BIT-SYNTHESIS>>
           <SET SIG <BOR .SIG ,REST-DREAM-ARCHIVE>>)>
    <COND (<OR ,SHADOW-FOLLY-TORCH
               ,SHADOW-FOLLY-WEAPON
               ,SHADOW-FOLLY-ROPE
               ,SHADOW-FOLLY-CARRIED-FIRE>
           <SET SIG <BOR .SIG ,REST-DREAM-FOLLY>>)>
    <COND (<OR ,MUSEUM-EVENT-DISPLAYED
               ,MUSEUM-EVENT-CASE
               ,MUSEUM-THEFT-OCCURRED>
           <SET SIG <BOR .SIG ,REST-DREAM-MUSEUM>>)>
    <RETURN .SIG>>

<ROUTINE REST-NEXT-DREAM (SIG "AUX" (BIT 1))
    <REPEAT ()
        <COND (<G? .BIT ,REST-DREAM-MUSEUM> <RETURN ,REST-DREAM-HOUSE>)
              (<AND <NOT <0? <BAND .SIG .BIT>>>
                    <NOT <REST-HAS? ,RS-DREAMED .BIT>>>
               <RETURN .BIT>)>
        <SET BIT <* .BIT 2>>>>

<ROUTINE REST-PRINT-DREAM (BIT)
    <COND (<EQUAL? .BIT ,REST-DREAM-HOUSE>
           <TELL "You dream of a white house with one more stair than you remember. The rooms do not demand upkeep; they simply retain the shape of your returns." CR>)
          (<EQUAL? .BIT ,REST-DREAM-FOREST>
           <TELL "You dream of branches arranging themselves into only the paths you actually walked. The unopened forest remains dark and unnamed." CR>)
          (<EQUAL? .BIT ,REST-DREAM-DAM>
           <TELL "You dream of relay clicks, wet concrete, and one maintenance light that refuses to explain a control you never tested." CR>)
          (<EQUAL? .BIT ,REST-DREAM-HADES>
           <TELL "You dream of a bell note crossing black water. The dream remembers consequences, not the missing steps of any ceremony." CR>)
          (<EQUAL? .BIT ,REST-DREAM-ACTORS>
           <TELL "You dream of three silhouettes at separate doors. Each keeps exactly the history you earned with it, and no more." CR>)
          (<EQUAL? .BIT ,REST-DREAM-ARCHIVE>
           <TELL "You dream that the Attic printer runs without paper. Green letters name records already earned, then stop before the first unseen file." CR>)
          (<EQUAL? .BIT ,REST-DREAM-FOLLY>
           <TELL "You dream that a sleeve smolders, a rope knots itself, and a weapon politely declines to become wisdom. You wake with the warning intact." CR>)
          (T
           <TELL "You dream of an empty outline on a museum shelf. The absence remains evidence; the dream does not return the missing object." CR>)>
    <RTRUE>>

<ROUTINE REST-READ-NOTEBOOK ()
    <TELL "REST-DREAM-01. Cloth-bound dream notebook." CR>
    <COND (<0? <REST-GET ,RS-DREAMED>>
           <TELL "Every page is blank. No dream has yet survived waking." CR>)
          (T
           <TELL "The notebook contains only dreams actually produced by rest in this Bedroom:" CR>
           <COND (<REST-HAS? ,RS-DREAMED ,REST-DREAM-HOUSE>
                  <TELL "- House stair and return dream." CR>)>
           <COND (<REST-HAS? ,RS-DREAMED ,REST-DREAM-FOREST>
                  <TELL "- Earned forest-path dream." CR>)>
           <COND (<REST-HAS? ,RS-DREAMED ,REST-DREAM-DAM>
                  <TELL "- Dam relay and wet-concrete dream." CR>)>
           <COND (<REST-HAS? ,RS-DREAMED ,REST-DREAM-HADES>
                  <TELL "- Hades bell-and-water dream." CR>)>
           <COND (<REST-HAS? ,RS-DREAMED ,REST-DREAM-ACTORS>
                  <TELL "- Player-specific actor-door dream." CR>)>
           <COND (<REST-HAS? ,RS-DREAMED ,REST-DREAM-ARCHIVE>
                  <TELL "- Attic printer dream." CR>)>
           <COND (<REST-HAS? ,RS-DREAMED ,REST-DREAM-FOLLY>
                  <TELL "- Retained folly warning dream." CR>)>
           <COND (<REST-HAS? ,RS-DREAMED ,REST-DREAM-MUSEUM>
                  <TELL "- Museum absence dream." CR>)>)>
    <RTRUE>>

<ROUTINE REST-READ-REPORT ()
    <TELL "REST-OVERNIGHT-02. Carbon-copy Bedroom and house report." CR>
    <TELL "Successful full rests: " N <REST-GET ,RS-CYCLES> "." CR>
    <COND (<REST-GET ,RS-EVENT-RECOVERY>
           <TELL "- Bounded recovery occurred: at most one wound step, stagger, or lingering garlic scent per newly earned evidence signature." CR>)>
    <COND (<REST-GET ,RS-EVENT-INTERRUPTED>
           <TELL "- At least one attempted sleep ended early because a live clock event or authored house warning demanded waking." CR>)>
    <COND (<REST-HAS? ,RS-OVERNIGHT ,REST-OVERNIGHT-MAIL>
           <TELL "- Canonical mailbox correspondence advanced overnight." CR>)>
    <COND (<REST-HAS? ,RS-OVERNIGHT ,REST-OVERNIGHT-VISITOR>
           <TELL "- A queued visitor became a knock or physical missed-visitor notice." CR>)>
    <COND (<REST-HAS? ,RS-OVERNIGHT ,REST-OVERNIGHT-THEFT>
           <TELL "- Existing canonical museum-theft evidence was retained; sleep created no replacement object." CR>)>
    <COND (<REST-HAS? ,RS-OVERNIGHT ,REST-OVERNIGHT-DAMP>
           <TELL "- Existing water or damp evidence was carried into the overnight record without inventing house damage." CR>)>
    <COND (<REST-HAS? ,RS-OVERNIGHT ,REST-OVERNIGHT-SMOKE>
           <TELL "- Existing smoke or fire-folly evidence was carried into the overnight record." CR>)>
    <COND (<REST-HAS? ,RS-OVERNIGHT ,REST-OVERNIGHT-MOVEMENT>
           <TELL "- A real letter, notice, or archive record changed physical custody overnight." CR>)>
    <TELL "WAIT and Z remain ordinary canonical waiting. Sleep is optional and never creates a mandatory day cycle." CR>
    <RTRUE>>

<ROUTINE REST-READ (OBJ)
    <COND (<EQUAL? .OBJ ,REST-DREAM-NOTEBOOK> <REST-READ-NOTEBOOK>)
          (T <REST-READ-REPORT>)>
    <RTRUE>>

<ROUTINE REST-GUARDED-READ (OBJ "AUX" OLD-HERE OLD-SCORE OLD-TIMER OLD-IT RLOC)
    <SET OLD-HERE ,HERE>
    <SET OLD-SCORE ,SCORE>
    <SET OLD-TIMER ,SHADOW-SELF-FIRE>
    <SET OLD-IT ,P-IT-OBJECT>
    <SET RLOC <LOC .OBJ>>
    <REST-READ .OBJ>
    <SETG P-IT-OBJECT .OLD-IT>
    <SETG CLOCK-WAIT T>
    <COND (<AND <EQUAL? ,HERE .OLD-HERE>
                <EQUAL? ,SCORE .OLD-SCORE>
                <EQUAL? ,SHADOW-SELF-FIRE .OLD-TIMER>
                <EQUAL? ,P-IT-OBJECT .OLD-IT>
                <EQUAL? <LOC .OBJ> .RLOC>>
           <TELL "REST-RECORD-INTEGRITY:PASS (location, score, timer, pronoun, and custody unchanged)." CR>)
          (T
           <TELL "REST-RECORD-INTEGRITY:FAIL." CR>)>
    <RTRUE>>

<ROUTINE REST-RECORD-FCN ()
    <COND (<VERB? READ EXAMINE>
           <REST-GUARDED-READ ,PRSO>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE REST-BED-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "The four-poster bed is old but sound, made for actual sleep rather than decoration. Its blankets smell faintly of cedar and Attic dust." CR>
           <RTRUE>)
          (<VERB? TAKE MOVE MUNG>
           <TELL "The bed is part of the Bedroom, not portable expedition equipment." CR>
           <RTRUE>)
          (<VERB? BOARD CLIMB-ON>
           <PERFORM ,V?HOUSE-SLEEP ,REST-BED>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE REST-CAN-SLEEP? ()
    <COND (<NOT <EQUAL? ,HERE ,BEDROOM>>
           <REST-PUT ,RS-EVENT-REFUSED T>
           <TELL "You can wait here, but real sleep belongs to the Bedroom upstairs." CR>
           <RFALSE>)
          (<AND ,PRSO <NOT <EQUAL? ,PRSO ,REST-BED ,ROOMS>>>
           <REST-PUT ,RS-EVENT-REFUSED T>
           <TELL "That is not the Bedroom's bed." CR>
           <RFALSE>)
          (<G? ,SHADOW-SELF-FIRE 0>
           <REST-PUT ,RS-EVENT-REFUSED T>
           <TELL "Sleeping while your clothing is burning would shorten the night considerably. Deal with the fire." CR>
           <RFALSE>)
          (,SHADOW-SELF-TIED
           <REST-PUT ,RS-EVENT-REFUSED T>
           <TELL "The rope around your legs makes getting into bed an avoidable engineering problem. Untie yourself first." CR>
           <RFALSE>)
          (<OR <EQUAL? <LOC ,TROLL> ,BEDROOM>
               <EQUAL? <LOC ,CYCLOPS> ,BEDROOM>
               <EQUAL? <LOC ,THIEF> ,BEDROOM>>
           <REST-PUT ,RS-EVENT-REFUSED T>
           <TELL "An active hostile presence in the Bedroom argues persuasively against sleep." CR>
           <RFALSE>)>
    <RTRUE>>

<ROUTINE REST-NEXT-WAKE ("AUX" BIT)
    <MAIL-ENSURE>
    <MAIL-DERIVE-QUEUE>
    <COND (<AND <SET BIT <MAIL-NEXT-VISITOR>>
                <NOT <REST-HAS? ,RS-WAKE-HANDLED ,REST-WAKE-VISITOR>>>
           <RETURN ,REST-WAKE-VISITOR>)>
    <COND (<AND <CELLAR-GET ,CS-EVENT-INTRUSION>
                <NOT <REST-HAS? ,RS-WAKE-HANDLED ,REST-WAKE-CELLAR>>>
           <RETURN ,REST-WAKE-CELLAR>)>
    <COND (<AND ,MUSEUM-THEFT-OCCURRED
                <NOT <REST-HAS? ,RS-WAKE-HANDLED ,REST-WAKE-THEFT>>>
           <RETURN ,REST-WAKE-THEFT>)>
    <RETURN 0>>

<ROUTINE REST-HANDLE-WAKE (WHY)
    <REST-PUT ,RS-EVENT-INTERRUPTED T>
    <REST-PUT ,RS-EVENT-WAKE T>
    <REST-SET ,RS-WAKE-HANDLED .WHY>
    <COND (<EQUAL? .WHY ,REST-WAKE-VISITOR>
           <MAIL-VISITOR-ARRIVE>
           <REST-SET ,RS-OVERNIGHT ,REST-OVERNIGHT-VISITOR>
           <REST-SET ,RS-OVERNIGHT ,REST-OVERNIGHT-MOVEMENT>
           <TELL "A measured knock reaches the upper floor. By the time you are fully awake, the caller has left a physical notice at the mailbox." CR>)
          (<EQUAL? .WHY ,REST-WAKE-CELLAR>
           <TELL "A hard sound rises through the floorboards from the Cellar threshold. You wake before the house can pretend it was settling." CR>)
          (<EQUAL? .WHY ,REST-WAKE-THEFT>
           <REST-SET ,RS-OVERNIGHT ,REST-OVERNIGHT-THEFT>
           <TELL "A small movement downstairs ends in practiced silence. The existing museum-theft evidence, not the dream, tells you what changed." CR>)
          (T
           <TELL "A live clock event snaps you awake before the rest can complete." CR>)>
    <REST-MATERIALIZE>
    <RTRUE>>

<ROUTINE REST-RUN-CLOCKS ("AUX" (I 0) WHY)
    <REPEAT ()
        <COND (<NOT <L? .I ,REST-CLOCK-STEPS>> <RETURN 0>)>
        <COND (<CLOCKER> <RETURN ,REST-WAKE-CLOCK>)>
        <SET I <+ .I 1>>
        <SET WHY <REST-NEXT-WAKE>>
        <COND (<NOT <0? .WHY>> <RETURN .WHY>)>>>

<ROUTINE REST-RECOVER ("AUX" S (SEEN <>))
    <SET S <GETP ,WINNER ,P?STRENGTH>>
    <COND (<L? .S 0>
           <PUTP ,WINNER ,P?STRENGTH <+ .S 1>>
           <SET SEEN T>
           <TELL "The completed rest eases one step of your temporary combat injury; permanent consequences remain." CR>)>
    <COND (<FSET? ,WINNER ,STAGGERED>
           <FCLEAR ,WINNER ,STAGGERED>
           <SET SEEN T>
           <TELL "The last combat stagger finally leaves your balance." CR>)>
    <COND (,SHADOW-GARLIC-SCENT
           <SETG SHADOW-GARLIC-SCENT <>>
           <SET SEEN T>
           <TELL "The aggressive garlic smell fades during the night." CR>)>
    <COND (.SEEN <REST-PUT ,RS-EVENT-RECOVERY T>)>
    <RTRUE>>

<ROUTINE REST-APPLY-OVERNIGHT ()
    <MAIL-ENSURE>
    <MAIL-DERIVE-QUEUE>
    <COND (<MAIL-DELIVER-NEXT>
           <REST-SET ,RS-OVERNIGHT ,REST-OVERNIGHT-MAIL>
           <REST-SET ,RS-OVERNIGHT ,REST-OVERNIGHT-MOVEMENT>)>
    <COND (<MAIL-NEXT-VISITOR>
           <MAIL-VISITOR-ARRIVE>
           <REST-SET ,RS-OVERNIGHT ,REST-OVERNIGHT-VISITOR>
           <REST-SET ,RS-OVERNIGHT ,REST-OVERNIGHT-MOVEMENT>)>
    <COND (,MUSEUM-THEFT-OCCURRED
           <REST-SET ,RS-OVERNIGHT ,REST-OVERNIGHT-THEFT>)>
    <COND (<OR <EQUAL? ,WATER-LEVEL -1>
               ,DAM-MECH-LEAK-REPAIRED>
           <REST-SET ,RS-OVERNIGHT ,REST-OVERNIGHT-DAMP>)>
    <COND (<OR ,SHADOW-FOLLY-TORCH
               ,SHADOW-FOLLY-CARRIED-FIRE>
           <REST-SET ,RS-OVERNIGHT ,REST-OVERNIGHT-SMOKE>)>
    <REST-MATERIALIZE>
    <RTRUE>>

<ROUTINE REST-SHALLOW-DOZE ()
    <TELL "You doze briefly, but the house has accumulated no new expedition evidence since the last full rest." CR>
    <COND (<CLOCKER>
           <REST-HANDLE-WAKE ,REST-WAKE-CLOCK>)>
    <SETG CLOCK-WAIT T>
    <RTRUE>>

<ROUTINE V-HOUSE-SLEEP ("AUX" SIG DREAM WHY)
    <REST-ENSURE>
    <COND (<NOT <REST-CAN-SLEEP?>> <RTRUE>)>
    <SET SIG <REST-DREAM-SIGNATURE>>
    <COND (<AND <G? <REST-GET ,RS-CYCLES> 0>
                <EQUAL? .SIG <REST-GET ,RS-LAST-SIGNATURE>>>
           <REST-SHALLOW-DOZE>
           <RTRUE>)>
    <TELL "You settle into the four-poster bed. The white house creaks around you while the real game clock continues to run." CR>
    <SET WHY <REST-RUN-CLOCKS>>
    <COND (<NOT <0? .WHY>>
           <REST-HANDLE-WAKE .WHY>
           <SETG CLOCK-WAIT T>
           <RTRUE>)>
    <REST-APPLY-OVERNIGHT>
    <REST-RECOVER>
    <SET DREAM <REST-NEXT-DREAM .SIG>>
    <REST-SET ,RS-DREAMED .DREAM>
    <REST-PUT ,RS-LAST-DREAM .DREAM>
    <REST-PUT ,RS-LAST-SIGNATURE .SIG>
    <REST-PUT ,RS-CYCLES <+ <REST-GET ,RS-CYCLES> 1>>
    <REST-PUT ,RS-EVENT-RESTED T>
    <REST-PUT ,RS-EVENT-DREAM T>
    <REST-PRINT-DREAM .DREAM>
    <TELL "You wake in the Bedroom. No puzzle was solved, no route opened, and no unseen event was invented." CR>
    <SETG CLOCK-WAIT T>
    <RTRUE>>

<ROUTINE V-HOUSE-WAKE ()
    <TELL "You are already awake. Sleep in this edition resolves as one bounded command, not a persistent mode." CR>
    <SETG CLOCK-WAIT T>
    <RTRUE>>

<ROUTINE HOUSE-REST-BEDROOM-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-ENTER>
           <HOUSE-STATE-ENTER ,BEDROOM>
           <REST-ENSURE>
           <RFALSE>)
          (<EQUAL? .RARG ,M-LOOK>
           <TELL "This quiet upper room was once a Bedroom. A sound four-poster bed stands beneath the sloped ceiling; a bedside table holds a cloth-bound notebook. Stairs lead down to the Living Room." CR>
           <COND (<G? <REST-GET ,RS-CYCLES> 0>
                  <TELL "The blankets have the orderly disturbance of a bed actually used between expeditions." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE REST-FILE ()
    <COND (<NOT <EQUAL? ,HERE ,ATTIC>>
           <TELL "The overnight report can be filed only in the canonical Attic archive." CR>)
          (<NOT <IN? ,PRSO ,WINNER>>
           <TELL "You must hold the exact physical rest record before filing it." CR>)
          (T
           <MOVE ,PRSO ,ARCHIVE-CABINET>
           <REST-SET ,RS-FILED <REST-RECORD-BIT ,PRSO>>
           <ARCHIVE-PUT ,AS-EVENT-FILING T>
           <TELL "You file the exact Bedroom record. No duplicate dream, recovered object, or altered night is created." CR>)>
    <RTRUE>>

<ROUTINE HOUSE-REST-ACTION-HOOK ()
    <COND (<AND <VERB? ARCHIVE-FILE> <REST-RECORD? ,PRSO>>
           <REST-FILE>
           <RTRUE>)
          (<AND <VERB? ARCHIVE-REVIEW ARCHIVE-SHOW ARCHIVE-CROSS>
                <REST-RECORD? ,PRSO>>
           <REST-GUARDED-READ ,PRSO>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE REST-CATALOG-LIST ()
    <COND (<LOC ,REST-DREAM-NOTEBOOK>
           <TELL "- REST-DREAM-01: Bedroom dream notebook containing only dreams actually produced." CR>)>
    <COND (<LOC ,REST-OVERNIGHT-REPORT>
           <TELL "- REST-OVERNIGHT-02: bounded rest, interruption, recovery, and overnight-house report." CR>)>
    <RFALSE>>

<ROUTINE REST-RECAP ("AUX" (SEEN <>))
    <COND (<REST-GET ,RS-EVENT-RESTED>
           <SET SEEN T>
           <TELL "- You used the new Bedroom for optional full rest while the canonical game clock continued to run." CR>)>
    <COND (<REST-GET ,RS-EVENT-REFUSED>
           <SET SEEN T>
           <TELL "- Unsafe or out-of-room sleep attempts were refused instead of bypassing danger." CR>)>
    <COND (<REST-GET ,RS-EVENT-INTERRUPTED>
           <SET SEEN T>
           <TELL "- A live clock event, visitor, Cellar warning, or existing theft cue forced at least one early waking." CR>)>
    <COND (<REST-GET ,RS-EVENT-RECOVERY>
           <SET SEEN T>
           <TELL "- Newly earned evidence allowed bounded nonterminal recovery without erasing permanent consequences." CR>)>
    <COND (<REST-GET ,RS-EVENT-DREAM>
           <SET SEEN T>
           <TELL "- Discovery-driven dreams recorded only evidence already earned by this expedition." CR>)>
    <COND (<REST-GET ,RS-EVENT-OVERNIGHT>
           <SET SEEN T>
           <TELL "- Mail, notices, existing damage evidence, and the physical overnight report advanced deterministically." CR>)>
    <COND (.SEEN <RTRUE>)>
    <RFALSE>>