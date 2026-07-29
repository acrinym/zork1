"Bounded archival transcript and playback for the repository-local Zork I Glulx lineage."

;"Release 1227 captures a bounded sequence of consequential events already
  established by canonical state. It renders period-authentic paper, cassette,
  and index records without storing a universal command log or mutating the
  live adventure during review."

<CONSTANT PLAYBACK-SCHEMA 1>
<CONSTANT PLAYBACK-MAX-EVENTS 12>

<CONSTANT PB-SLOT-VERSION 0>
<CONSTANT PB-SLOT-CAPTURED 1>
<CONSTANT PB-SLOT-COUNT 2>
<CONSTANT PB-SLOT-FILED 3>
<CONSTANT PB-SLOT-EVENT-CAPTURE 4>
<CONSTANT PB-SLOT-EVENT-PRINTER 5>
<CONSTANT PB-SLOT-EVENT-CASSETTE 6>
<CONSTANT PB-SLOT-EVENT-SCENE 7>
<CONSTANT PB-SLOT-EVENT-FORENSIC 8>
<CONSTANT PB-SLOT-EVENT-RESTORE 9>
<CONSTANT PB-SLOT-LAST 10>
<CONSTANT PB-SLOT-PRIOR-IT 11>

<CONSTANT PB-REC-PRINTOUT 1>
<CONSTANT PB-REC-CASSETTE 2>
<CONSTANT PB-REC-INCIDENT 4>
<CONSTANT PB-REC-ACTOR 8>
<CONSTANT PB-REC-PLACE 16>
<CONSTANT PB-REC-CHRONOLOGY 32>
<CONSTANT PB-REC-FORENSIC 64>

<CONSTANT PB-EVT-HOUSE 1>
<CONSTANT PB-EVT-FOREST 2>
<CONSTANT PB-EVT-DAM-DIAG 4>
<CONSTANT PB-EVT-DAM-FAIL 8>
<CONSTANT PB-EVT-DAM-REPAIR 16>
<CONSTANT PB-EVT-HADES-BELL 32>
<CONSTANT PB-EVT-HADES-WRONG 64>
<CONSTANT PB-EVT-HADES-COMPLETE 128>
<CONSTANT PB-EVT-TROLL 256>
<CONSTANT PB-EVT-CYCLOPS 512>
<CONSTANT PB-EVT-THIEF 1024>
<CONSTANT PB-EVT-SYNTHESIS 2048>

<CONSTANT PLAYBACK-STATE <TABLE 0 0 0 0 <> <> <> <> <> <> 0 <>>>
<CONSTANT PLAYBACK-SEQUENCE <TABLE 0 0 0 0 0 0 0 0 0 0 0 0>>

<OBJECT PLAYBACK-PRINTOUT
    (SYNONYM PRINTOUT TRANSCRIPT PAPER FEED)
    (ADJECTIVE CONTINUOUS LINE PRINTER CURATED)
    (DESC "continuous-feed expedition transcript")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 3)
    (ACTION PLAYBACK-RECORD-FCN)>

<OBJECT PLAYBACK-CASSETTE
    (SYNONYM CASSETTE TAPE RECORDING PLAYBACK)
    (ADJECTIVE EXPEDITION TEXTUAL ARCHIVAL)
    (DESC "expedition playback cassette")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 2)
    (ACTION PLAYBACK-RECORD-FCN)>

<OBJECT PLAYBACK-INCIDENT-CARD
    (SYNONYM CARD INDEX SCENE INCIDENT)
    (ADJECTIVE INCIDENT BLUE PLAYBACK)
    (DESC "blue incident scene card")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 1)
    (ACTION PLAYBACK-RECORD-FCN)>

<OBJECT PLAYBACK-ACTOR-CARD
    (SYNONYM CARD INDEX SCENE ACTOR)
    (ADJECTIVE ACTOR YELLOW PLAYBACK)
    (DESC "yellow actor scene card")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 1)
    (ACTION PLAYBACK-RECORD-FCN)>

<OBJECT PLAYBACK-PLACE-CARD
    (SYNONYM CARD INDEX SCENE PLACE)
    (ADJECTIVE PLACE GREEN PLAYBACK)
    (DESC "green place scene card")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 1)
    (ACTION PLAYBACK-RECORD-FCN)>

<OBJECT PLAYBACK-CHRONOLOGY-CARD
    (SYNONYM CARD INDEX SCENE CHRONOLOGY)
    (ADJECTIVE CHRONOLOGY CREAM PLAYBACK)
    (DESC "cream chronology scene card")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 1)
    (ACTION PLAYBACK-RECORD-FCN)>

<OBJECT PLAYBACK-FORENSIC-STRIP
    (SYNONYM STRIP LOG TRANSCRIPT PAPER)
    (ADJECTIVE FORENSIC BOUNDED MACHINE)
    (DESC "bounded forensic printer strip")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 2)
    (ACTION PLAYBACK-RECORD-FCN)>

<ROUTINE PLAYBACK-GET (SLOT)
    <GET ,PLAYBACK-STATE .SLOT>>

<ROUTINE PLAYBACK-PUT (SLOT VALUE)
    <PUT ,PLAYBACK-STATE .SLOT .VALUE>>

<ROUTINE PLAYBACK-HAS? (SLOT BIT)
    <COND (<NOT <0? <BAND <PLAYBACK-GET .SLOT> .BIT>>> <RTRUE>)>
    <RFALSE>>

<ROUTINE PLAYBACK-SET (SLOT BIT)
    <PLAYBACK-PUT .SLOT <BOR <PLAYBACK-GET .SLOT> .BIT>>
    <RTRUE>>

<ROUTINE PLAYBACK-RECORD-BIT (OBJ)
    <COND (<EQUAL? .OBJ ,PLAYBACK-PRINTOUT> <RETURN ,PB-REC-PRINTOUT>)
          (<EQUAL? .OBJ ,PLAYBACK-CASSETTE> <RETURN ,PB-REC-CASSETTE>)
          (<EQUAL? .OBJ ,PLAYBACK-INCIDENT-CARD> <RETURN ,PB-REC-INCIDENT>)
          (<EQUAL? .OBJ ,PLAYBACK-ACTOR-CARD> <RETURN ,PB-REC-ACTOR>)
          (<EQUAL? .OBJ ,PLAYBACK-PLACE-CARD> <RETURN ,PB-REC-PLACE>)
          (<EQUAL? .OBJ ,PLAYBACK-CHRONOLOGY-CARD> <RETURN ,PB-REC-CHRONOLOGY>)
          (<EQUAL? .OBJ ,PLAYBACK-FORENSIC-STRIP> <RETURN ,PB-REC-FORENSIC>)>
    <RETURN 0>>

<ROUTINE PLAYBACK-RECORD? (OBJ)
    <COND (<NOT <0? <PLAYBACK-RECORD-BIT .OBJ>>> <RTRUE>)>
    <RFALSE>>

<ROUTINE PLAYBACK-MATERIALIZE-ONE (OBJ BIT)
    <COND (<NOT <LOC .OBJ>> <MOVE .OBJ ,ARCHIVE-CABINET>)>
    <ARCHIVE-SET-BIT ,AS-INDEXED <* .BIT 32768>>
    <PLAYBACK-PUT ,PB-SLOT-LAST .BIT>
    <RTRUE>>

<ROUTINE PLAYBACK-MATERIALIZE ()
    <PLAYBACK-MATERIALIZE-ONE ,PLAYBACK-PRINTOUT ,PB-REC-PRINTOUT>
    <PLAYBACK-MATERIALIZE-ONE ,PLAYBACK-CASSETTE ,PB-REC-CASSETTE>
    <PLAYBACK-MATERIALIZE-ONE ,PLAYBACK-INCIDENT-CARD ,PB-REC-INCIDENT>
    <PLAYBACK-MATERIALIZE-ONE ,PLAYBACK-ACTOR-CARD ,PB-REC-ACTOR>
    <PLAYBACK-MATERIALIZE-ONE ,PLAYBACK-PLACE-CARD ,PB-REC-PLACE>
    <PLAYBACK-MATERIALIZE-ONE ,PLAYBACK-CHRONOLOGY-CARD ,PB-REC-CHRONOLOGY>
    <COND (<G? <PLAYBACK-GET ,PB-SLOT-COUNT> 3>
           <PLAYBACK-MATERIALIZE-ONE ,PLAYBACK-FORENSIC-STRIP ,PB-REC-FORENSIC>)>
    <RTRUE>>

<ROUTINE PLAYBACK-CAPTURE (BIT "AUX" COUNT)
    <COND (<PLAYBACK-HAS? ,PB-SLOT-CAPTURED .BIT> <RFALSE>)>
    <PLAYBACK-SET ,PB-SLOT-CAPTURED .BIT>
    <SET COUNT <PLAYBACK-GET ,PB-SLOT-COUNT>>
    <COND (<L? .COUNT ,PLAYBACK-MAX-EVENTS>
           <PUT ,PLAYBACK-SEQUENCE .COUNT .BIT>
           <PLAYBACK-PUT ,PB-SLOT-COUNT <+ .COUNT 1>>
           <PLAYBACK-PUT ,PB-SLOT-EVENT-CAPTURE T>
           <PLAYBACK-MATERIALIZE>
           <RTRUE>)
          (T
           <PLAYBACK-PUT ,PB-SLOT-EVENT-FORENSIC T>
           <RFALSE>)>>

<ROUTINE PLAYBACK-OBSERVE ()
    <COND (<OR ,HOUSE-EVENT-ENTERED ,HOUSE-EVENT-ATTIC ,HOUSE-EVENT-RETURN>
           <PLAYBACK-CAPTURE ,PB-EVT-HOUSE>)>
    <COND (<NOT <0? <AREA-GET ,AREA-SLOT-FOREST>>>
           <PLAYBACK-CAPTURE ,PB-EVT-FOREST>)>
    <COND (,DAM-MECH-PANEL-DIAGNOSED
           <PLAYBACK-CAPTURE ,PB-EVT-DAM-DIAG>)>
    <COND (<OR ,DAM-MECH-INTERLOCK-SEEN
               ,DAM-MECH-BOLT-ATTEMPTED
               ,DAM-MECH-TOOL-PROBED>
           <PLAYBACK-CAPTURE ,PB-EVT-DAM-FAIL>)>
    <COND (,DAM-MECH-LEAK-REPAIRED
           <PLAYBACK-CAPTURE ,PB-EVT-DAM-REPAIR>)>
    <COND (<OR ,RITUAL-BELL-ANSWERED ,RITUAL-CANDLES-ANSWERED>
           <PLAYBACK-CAPTURE ,PB-EVT-HADES-BELL>)>
    <COND (,RITUAL-WRONG-ORDER-SEEN
           <PLAYBACK-CAPTURE ,PB-EVT-HADES-WRONG>)>
    <COND (<OR ,RITUAL-PRAYER-COMPLETED ,LLD-FLAG>
           <PLAYBACK-CAPTURE ,PB-EVT-HADES-COMPLETE>)>
    <COND (<NPC-HAS? ,NS-SEEN ,NPC-BIT-TROLL>
           <PLAYBACK-CAPTURE ,PB-EVT-TROLL>)>
    <COND (<NPC-HAS? ,NS-SEEN ,NPC-BIT-CYCLOPS>
           <PLAYBACK-CAPTURE ,PB-EVT-CYCLOPS>)>
    <COND (<NPC-HAS? ,NS-SEEN ,NPC-BIT-THIEF>
           <PLAYBACK-CAPTURE ,PB-EVT-THIEF>)>
    <COND (<AREA-HAS? ,AREA-SLOT-COMPLETE ,AREA-BIT-SYNTHESIS>
           <PLAYBACK-CAPTURE ,PB-EVT-SYNTHESIS>)>
    <RFALSE>>

<ROUTINE PLAYBACK-PRINT-TRANSCRIPT-EVENT (CODE)
    <COND (<EQUAL? .CODE ,PB-EVT-HOUSE>
           <TELL "> [CURATED ACTION] RETURN TO THE WHITE HOUSE" CR
                 "  RESULT: the house became a verified expedition anchor." CR>)
          (<EQUAL? .CODE ,PB-EVT-FOREST>
           <TELL "> [CURATED ACTION] ENTER A FOREST SECTOR" CR
                 "  RESULT: one or more exact exploration locations were retained." CR>)
          (<EQUAL? .CODE ,PB-EVT-DAM-DIAG>
           <TELL "> [CURATED ACTION] EXAMINE THE DAM CONTROL PANEL" CR
                 "  RESULT: a diagnostic response was observed." CR>)
          (<EQUAL? .CODE ,PB-EVT-DAM-FAIL>
           <TELL "> [CURATED ACTION] TEST A DAM CONTROL OR TOOL" CR
                 "  RESULT: a refusal, bolt, or tool response was retained without inventing success." CR>)
          (<EQUAL? .CODE ,PB-EVT-DAM-REPAIR>
           <TELL "> [CURATED ACTION] COMPLETE THE DAM REPAIR" CR
                 "  RESULT: the canonical maintenance leak reached its repaired state." CR>)
          (<EQUAL? .CODE ,PB-EVT-HADES-BELL>
           <TELL "> [CURATED ACTION] ADVANCE THE HADES CEREMONY" CR
                 "  RESULT: an answered bell or paired-light stage was observed." CR>)
          (<EQUAL? .CODE ,PB-EVT-HADES-WRONG>
           <TELL "> [CURATED ACTION] ATTEMPT A WRONG CEREMONY ORDER" CR
                 "  RESULT: the actual failure cue was retained." CR>)
          (<EQUAL? .CODE ,PB-EVT-HADES-COMPLETE>
           <TELL "> [CURATED ACTION] COMPLETE THE HADES OUTCOME" CR
                 "  RESULT: the canonical spirit-removal state was verified." CR>)
          (<EQUAL? .CODE ,PB-EVT-TROLL>
           <TELL "> [CURATED ACTION] ENCOUNTER THE TROLL" CR
                 "  RESULT: player-specific troll evidence entered the archive." CR>)
          (<EQUAL? .CODE ,PB-EVT-CYCLOPS>
           <TELL "> [CURATED ACTION] ENCOUNTER THE CYCLOPS" CR
                 "  RESULT: player-specific cyclops evidence entered the archive." CR>)
          (<EQUAL? .CODE ,PB-EVT-THIEF>
           <TELL "> [CURATED ACTION] ENCOUNTER THE THIEF" CR
                 "  RESULT: player-specific thief evidence entered the archive." CR>)
          (T
           <TELL "> [CURATED ACTION] COMPLETE REGIONAL SYNTHESIS" CR
                 "  RESULT: five earned regional contracts became retrospective history." CR>)>
    <RTRUE>>

<ROUTINE PLAYBACK-PRINT-CASSETTE-EVENT (CODE)
    <COND (<EQUAL? .CODE ,PB-EVT-HOUSE>
           <TELL "[TAPE HISS] [NARRATOR] Floorboards, mail, and returning footsteps mark the house as lived history." CR>)
          (<EQUAL? .CODE ,PB-EVT-FOREST>
           <TELL "[WIND IN BRANCHES] [NARRATOR] The forest record names only sectors actually entered." CR>)
          (<EQUAL? .CODE ,PB-EVT-DAM-DIAG>
           <TELL "[RELAY CLICK] [CONTROL PANEL] A diagnostic response is reconstructed from verified mechanism state." CR>)
          (<EQUAL? .CODE ,PB-EVT-DAM-FAIL>
           <TELL "[METAL CLACK] [NARRATOR] The retained attempt did not become an invented success." CR>)
          (<EQUAL? .CODE ,PB-EVT-DAM-REPAIR>
           <TELL "[WATER SUBSIDES] [NARRATOR] The maintenance sequence ends at the repair actually achieved." CR>)
          (<EQUAL? .CODE ,PB-EVT-HADES-BELL>
           <TELL "[BELL DECAY] [CEREMONY RECORD] An answered stage is replayed without supplying the next one." CR>)
          (<EQUAL? .CODE ,PB-EVT-HADES-WRONG>
           <TELL "[ABRUPT SILENCE] [CEREMONY RECORD] A wrong-order consequence is retained as failure, not instruction." CR>)
          (<EQUAL? .CODE ,PB-EVT-HADES-COMPLETE>
           <TELL "[DISTANT VOICES FADE] [NARRATOR] The verified outcome is complete; no hidden step is added." CR>)
          (<EQUAL? .CODE ,PB-EVT-TROLL>
           <TELL "[STONE ECHO] [TROLL - CONTEXTUAL PARAPHRASE] Hostility or restraint is summarized only where this run established it." CR>)
          (<EQUAL? .CODE ,PB-EVT-CYCLOPS>
           <TELL "[HEAVY BREATHING] [CYCLOPS - CONTEXTUAL PARAPHRASE] Impatience and outcome remain bounded to observed evidence." CR>)
          (<EQUAL? .CODE ,PB-EVT-THIEF>
           <TELL "[SOFT FOOTSTEP] [THIEF - CONTEXTUAL PARAPHRASE] Presence, bargain, attack, or missing property is never reconstructed beyond evidence." CR>)
          (T
           <TELL "[PRINTER MOTOR STOPS] [ARCHIVIST] Regional synthesis is retrospective and cannot alter the present." CR>)>
    <RTRUE>>

<ROUTINE PLAYBACK-PRINT-FORENSIC-EVENT (CODE)
    <TELL "EVENT ">
    <PRINTN .CODE>
    <TELL ": normalized consequential-state token; deduplicated and bounded." CR>
    <RTRUE>>

<ROUTINE PLAYBACK-EACH (MODE "AUX" (I 0) CODE COUNT)
    <SET COUNT <PLAYBACK-GET ,PB-SLOT-COUNT>>
    <REPEAT ()
        <COND (<NOT <L? .I .COUNT>> <RETURN>)>
        <SET CODE <GET ,PLAYBACK-SEQUENCE .I>>
        <COND (<EQUAL? .MODE 1> <PLAYBACK-PRINT-TRANSCRIPT-EVENT .CODE>)
              (<EQUAL? .MODE 2> <PLAYBACK-PRINT-CASSETTE-EVENT .CODE>)
              (T <PLAYBACK-PRINT-FORENSIC-EVENT .CODE>)>
        <SET I <+ .I 1>>>
    <RTRUE>>

<ROUTINE PLAYBACK-READ-PRINTOUT ()
    <TELL "PLAYBACK-PRINTER-01. Continuous-feed curated expedition transcript." CR>
    <TELL "The echoed actions are normalized labels, not a verbatim command history. Duplicate observations are suppressed." CR>
    <PLAYBACK-EACH 1>
    <PLAYBACK-PUT ,PB-SLOT-EVENT-PRINTER T>
    <RTRUE>>

<ROUTINE PLAYBACK-PLAY-CASSETTE ()
    <TELL "PLAYBACK-CASSETTE-02. The recorder clicks. Tape hiss." CR>
    <PLAYBACK-EACH 2>
    <TELL "[END OF CURATED TAPE] No actor, object, timer, score, pronoun, or location was changed." CR>
    <PLAYBACK-PUT ,PB-SLOT-EVENT-CASSETTE T>
    <RTRUE>>

<ROUTINE PLAYBACK-READ-INCIDENT ()
    <TELL "PLAYBACK-INCIDENT-03. Incident index." CR>
    <COND (<PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-DAM-DIAG>
           <TELL "- Dam diagnosis incident." CR>)>
    <COND (<PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-DAM-FAIL>
           <TELL "- Dam refusal or failed-control incident." CR>)>
    <COND (<PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-DAM-REPAIR>
           <TELL "- Dam repair incident." CR>)>
    <COND (<PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-HADES-WRONG>
           <TELL "- Hades wrong-order incident." CR>)>
    <COND (<PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-HADES-COMPLETE>
           <TELL "- Hades completion incident." CR>)>
    <PLAYBACK-PUT ,PB-SLOT-EVENT-SCENE T>
    <RTRUE>>

<ROUTINE PLAYBACK-READ-ACTOR ()
    <TELL "PLAYBACK-ACTOR-04. Actor index." CR>
    <COND (<PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-TROLL>
           <TELL "- Troll scene: player-specific evidence only." CR>)>
    <COND (<PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-CYCLOPS>
           <TELL "- Cyclops scene: player-specific evidence only." CR>)>
    <COND (<PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-THIEF>
           <TELL "- Thief scene: player-specific evidence only." CR>)>
    <COND (<AND <NOT <PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-TROLL>>
                <NOT <PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-CYCLOPS>>
                <NOT <PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-THIEF>>>
           <TELL "- No actor scene has been earned." CR>)>
    <PLAYBACK-PUT ,PB-SLOT-EVENT-SCENE T>
    <RTRUE>>

<ROUTINE PLAYBACK-READ-PLACE ()
    <TELL "PLAYBACK-PLACE-05. Place index." CR>
    <COND (<PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-HOUSE>
           <TELL "- White house." CR>)>
    <COND (<PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-FOREST>
           <TELL "- Individually observed forest territory." CR>)>
    <COND (<OR <PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-DAM-DIAG>
               <PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-DAM-REPAIR>>
           <TELL "- Flood Control Dam #3." CR>)>
    <COND (<OR <PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-HADES-BELL>
               <PLAYBACK-HAS? ,PB-SLOT-CAPTURED ,PB-EVT-HADES-COMPLETE>>
           <TELL "- Hades ceremony territory." CR>)>
    <PLAYBACK-PUT ,PB-SLOT-EVENT-SCENE T>
    <RTRUE>>

<ROUTINE PLAYBACK-READ-CHRONOLOGY ()
    <TELL "PLAYBACK-CHRONOLOGY-06. Deterministic scene order." CR>
    <TELL "The cards follow first verified capture, not hidden world chronology or a reconstructed raw session." CR>
    <PLAYBACK-EACH 3>
    <PLAYBACK-PUT ,PB-SLOT-EVENT-SCENE T>
    <RTRUE>>

<ROUTINE PLAYBACK-READ-FORENSIC ()
    <TELL "PLAYBACK-FORENSIC-07. Bounded forensic strip." CR>
    <TELL "Capacity: 12 unique consequential events. It stores no ordinary movement, typo, parser chatter, or duplicate observation." CR>
    <PLAYBACK-EACH 3>
    <PLAYBACK-PUT ,PB-SLOT-EVENT-FORENSIC T>
    <RTRUE>>

<ROUTINE PLAYBACK-READ (OBJ)
    <COND (<EQUAL? .OBJ ,PLAYBACK-PRINTOUT> <PLAYBACK-READ-PRINTOUT>)
          (<EQUAL? .OBJ ,PLAYBACK-CASSETTE> <PLAYBACK-PLAY-CASSETTE>)
          (<EQUAL? .OBJ ,PLAYBACK-INCIDENT-CARD> <PLAYBACK-READ-INCIDENT>)
          (<EQUAL? .OBJ ,PLAYBACK-ACTOR-CARD> <PLAYBACK-READ-ACTOR>)
          (<EQUAL? .OBJ ,PLAYBACK-PLACE-CARD> <PLAYBACK-READ-PLACE>)
          (<EQUAL? .OBJ ,PLAYBACK-CHRONOLOGY-CARD> <PLAYBACK-READ-CHRONOLOGY>)
          (T <PLAYBACK-READ-FORENSIC>)>
    <RTRUE>>

<ROUTINE PLAYBACK-FILE ()
    <COND (<NOT <EQUAL? ,HERE ,ATTIC>>
           <TELL "Playback records can be filed only in the canonical Attic." CR>)
          (<NOT <IN? ,PRSO ,WINNER>>
           <TELL "You must hold the exact physical playback record before filing it." CR>)
          (T
           <MOVE ,PRSO ,ARCHIVE-CABINET>
           <PLAYBACK-SET ,PB-SLOT-FILED <PLAYBACK-RECORD-BIT ,PRSO>>
           <ARCHIVE-PUT ,AS-EVENT-FILING T>
           <TELL "You file the exact playback record. No duplicate scene, command history, or altered present is created." CR>)>
    <RTRUE>>

<ROUTINE PLAYBACK-GUARDED-READ (OBJ "AUX" OLD-IT OLD-HERE OLD-SCORE OLD-TIMER
                                         TLOC CLOC THLOC RLOC OK)
    <SET OLD-IT <PLAYBACK-GET ,PB-SLOT-PRIOR-IT>>
    <SET OLD-HERE ,HERE>
    <SET OLD-SCORE ,SCORE>
    <SET OLD-TIMER ,SHADOW-SELF-FIRE>
    <SET TLOC <LOC ,TROLL>>
    <SET CLOC <LOC ,CYCLOPS>>
    <SET THLOC <LOC ,THIEF>>
    <SET RLOC <LOC .OBJ>>
    <PLAYBACK-READ .OBJ>
    <SETG P-IT-OBJECT .OLD-IT>
    <SETG CLOCK-WAIT T>
    <SET OK T>
    <COND (<NOT <EQUAL? ,HERE .OLD-HERE>> <SET OK <>>)> 
    <COND (<NOT <EQUAL? ,SCORE .OLD-SCORE>> <SET OK <>>)> 
    <COND (<NOT <EQUAL? ,P-IT-OBJECT .OLD-IT>> <SET OK <>>)> 
    <COND (<NOT <EQUAL? ,SHADOW-SELF-FIRE .OLD-TIMER>> <SET OK <>>)> 
    <COND (<NOT <EQUAL? <LOC ,TROLL> .TLOC>> <SET OK <>>)> 
    <COND (<NOT <EQUAL? <LOC ,CYCLOPS> .CLOC>> <SET OK <>>)> 
    <COND (<NOT <EQUAL? <LOC ,THIEF> .THLOC>> <SET OK <>>)> 
    <COND (<NOT <EQUAL? <LOC .OBJ> .RLOC>> <SET OK <>>)> 
    <COND (.OK
           <TELL "PLAYBACK-INTEGRITY:PASS (location, score, timer, actors, pronoun, and record custody unchanged)." CR>)
          (T
           <TELL "PLAYBACK-INTEGRITY:FAIL." CR>)>
    <RTRUE>>

<ROUTINE PLAYBACK-RECORD-FCN ()
    <COND (<VERB? READ EXAMINE PLAY>
           <PLAYBACK-GUARDED-READ ,PRSO>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE PLAYBACK-ACTION-HOOK ()
    <COND (<AND <VERB? ARCHIVE-FILE> <PLAYBACK-RECORD? ,PRSO>>
           <PLAYBACK-FILE>
           <RTRUE>)
          (<AND <VERB? ARCHIVE-REVIEW ARCHIVE-SHOW>
                <PLAYBACK-RECORD? ,PRSO>>
           <PLAYBACK-GUARDED-READ ,PRSO>
           <RTRUE>)
          (<AND <VERB? ARCHIVE-CROSS> <PLAYBACK-RECORD? ,PRSO>>
           <PLAYBACK-GUARDED-READ ,PRSO>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE PLAYBACK-ADVANCE ()
    <COND (<SHADOW-NON-TURN-COMMAND?> <RFALSE>)>
    <PLAYBACK-ENSURE>
    <PLAYBACK-PUT ,PB-SLOT-PRIOR-IT ,P-IT-OBJECT>
    <PLAYBACK-OBSERVE>
    <RFALSE>>

<ROUTINE PLAYBACK-ENSURE ()
    <COND (<NOT <EQUAL? <PLAYBACK-GET ,PB-SLOT-VERSION> ,PLAYBACK-SCHEMA>>
           <PLAYBACK-PUT ,PB-SLOT-VERSION ,PLAYBACK-SCHEMA>
           <COND (<LOC ,PLAYBACK-PRINTOUT>
                  <PLAYBACK-MATERIALIZE>)>)>
    <RFALSE>>

<ROUTINE PLAYBACK-CATALOG-LIST ()
    <COND (<LOC ,PLAYBACK-PRINTOUT>
           <TELL "- PLAYBACK-PRINTER-01: curated continuous-feed event transcript." CR>)>
    <COND (<LOC ,PLAYBACK-CASSETTE>
           <TELL "- PLAYBACK-CASSETTE-02: voices, pauses, cues, and environmental playback." CR>)>
    <COND (<LOC ,PLAYBACK-INCIDENT-CARD>
           <TELL "- PLAYBACK-INCIDENT-03: incident scenes." CR>)>
    <COND (<LOC ,PLAYBACK-ACTOR-CARD>
           <TELL "- PLAYBACK-ACTOR-04: actor scenes." CR>)>
    <COND (<LOC ,PLAYBACK-PLACE-CARD>
           <TELL "- PLAYBACK-PLACE-05: place scenes." CR>)>
    <COND (<LOC ,PLAYBACK-CHRONOLOGY-CARD>
           <TELL "- PLAYBACK-CHRONOLOGY-06: deterministic capture order." CR>)>
    <COND (<LOC ,PLAYBACK-FORENSIC-STRIP>
           <TELL "- PLAYBACK-FORENSIC-07: bounded unique-event strip." CR>)>
    <RFALSE>>

<ROUTINE PLAYBACK-RECAP ("AUX" (SEEN <>))
    <COND (<PLAYBACK-GET ,PB-SLOT-EVENT-CAPTURE>
           <SET SEEN T>
           <TELL "- Playback retained unique consequential events and suppressed ordinary or duplicate parser traffic." CR>)>
    <COND (<PLAYBACK-GET ,PB-SLOT-EVENT-PRINTER>
           <SET SEEN T>
           <TELL "- A continuous-feed transcript rendered normalized action echoes and verified outcomes." CR>)>
    <COND (<PLAYBACK-GET ,PB-SLOT-EVENT-CASSETTE>
           <SET SEEN T>
           <TELL "- Cassette playback supplied labels, pauses, hiss, and cues without changing live state." CR>)>
    <COND (<PLAYBACK-GET ,PB-SLOT-EVENT-SCENE>
           <SET SEEN T>
           <TELL "- Scene cards indexed earned incidents, actors, places, and chronology." CR>)>
    <COND (<PLAYBACK-GET ,PB-SLOT-EVENT-FORENSIC>
           <SET SEEN T>
           <TELL "- The forensic strip remained deduplicated and bounded to twelve consequential events." CR>)>
    <COND (.SEEN <RTRUE>)>
    <RFALSE>>
