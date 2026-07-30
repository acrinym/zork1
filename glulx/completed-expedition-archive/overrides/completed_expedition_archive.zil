"Completed expedition archive and House of Records capstone for the repository-local Zork I Glulx lineage."

;"Release 1230 turns a genuinely completed expedition into separate physical
  archive boxes. It reuses bounded playback, archive, house, actor, area, and
  incident evidence; it never invents a raw command log or merges mutually
  exclusive histories."

<SYNTAX ARCHIVE EXPEDITION = V-EXPEDITION-SEAL>
<SYNTAX SEAL EXPEDITION = V-EXPEDITION-SEAL>
<SYNTAX REVIEW EXPEDITION = V-EXPEDITION-REVIEW>
<SYNTAX STATUS EXPEDITION = V-EXPEDITION-STATUS>
<SYNTAX COMPARE EXPEDITIONS = V-EXPEDITION-COMPARE>
<SYNTAX EXPORT EXPEDITION = V-EXPEDITION-EXPORT>

<CONSTANT EXPEDITION-SCHEMA 1>
<CONSTANT EXPEDITION-MAX-EVENTS 12>

<CONSTANT ES-VERSION 0>
<CONSTANT ES-SEALED 1>
<CONSTANT ES-EXPORTED 2>
<CONSTANT ES-LAST-BOX 3>
<CONSTANT ES-A-SCORE 4>
<CONSTANT ES-A-DEATHS 5>
<CONSTANT ES-A-PLAYBACK 6>
<CONSTANT ES-A-RISK 7>
<CONSTANT ES-A-REPAIRED 8>
<CONSTANT ES-A-SECURITY 9>
<CONSTANT ES-B-SCORE 10>
<CONSTANT ES-B-DEATHS 11>
<CONSTANT ES-B-PLAYBACK 12>
<CONSTANT ES-B-RISK 13>
<CONSTANT ES-B-REPAIRED 14>
<CONSTANT ES-B-SECURITY 15>
<CONSTANT ES-EVENT-SEAL 16>
<CONSTANT ES-EVENT-COMPARE 17>
<CONSTANT ES-EVENT-EXPORT 18>
<CONSTANT ES-EVENT-MIGRATION 19>

<CONSTANT EXPEDITION-STATE <TABLE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 <> <> <> <>>>
<CONSTANT EXPEDITION-A-SEQUENCE <TABLE 0 0 0 0 0 0 0 0 0 0 0 0>>
<CONSTANT EXPEDITION-B-SEQUENCE <TABLE 0 0 0 0 0 0 0 0 0 0 0 0>>

<ROUTINE EXPEDITION-GET (SLOT)
    <GET ,EXPEDITION-STATE .SLOT>>

<ROUTINE EXPEDITION-PUT (SLOT VALUE)
    <PUT ,EXPEDITION-STATE .SLOT .VALUE>>

<ROUTINE EXPEDITION-HAS? (SLOT BIT)
    <COND (<NOT <0? <BAND <EXPEDITION-GET .SLOT> .BIT>>> <RTRUE>)>
    <RFALSE>>

<ROUTINE EXPEDITION-SET (SLOT BIT)
    <EXPEDITION-PUT .SLOT <BOR <EXPEDITION-GET .SLOT> .BIT>>
    <RTRUE>>

<OBJECT EXPEDITION-BOX-A
    (IN ATTIC)
    (SYNONYM BOX CARTON ARCHIVE)
    (ADJECTIVE FIRST EXPEDITION BANKER A)
    (DESC "first completed-expedition box")
    (LDESC "A first completed-expedition banker box waits beneath the chronology shelf.")
    (FLAGS TRYTAKEBIT CONTBIT OPENBIT SEARCHBIT)
    (CAPACITY 30)
    (ACTION EXPEDITION-BOX-FCN)>

<OBJECT EXPEDITION-BOX-B
    (IN ATTIC)
    (SYNONYM BOX CARTON ARCHIVE)
    (ADJECTIVE SECOND EXPEDITION BANKER B)
    (DESC "second completed-expedition box")
    (LDESC "A second completed-expedition banker box remains physically separate from the first.")
    (FLAGS TRYTAKEBIT CONTBIT OPENBIT SEARCHBIT)
    (CAPACITY 30)
    (ACTION EXPEDITION-BOX-FCN)>

<OBJECT EXPEDITION-A-MASTER
    (SYNONYM FILE RECORD MASTER EXPEDITION)
    (ADJECTIVE FIRST COMPLETE BLACK A)
    (DESC "EXPEDITION-A-MASTER file")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 3)
    (ACTION EXPEDITION-RECORD-FCN)>

<OBJECT EXPEDITION-A-TIMELINE
    (SYNONYM ROLL TIMELINE CHRONOLOGY RECORD)
    (ADJECTIVE FIRST EXPEDITION CONTINUOUS A)
    (DESC "EXPEDITION-A-TIMELINE roll")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 3)
    (ACTION EXPEDITION-RECORD-FCN)>

<OBJECT EXPEDITION-A-SUMMARY
    (SYNONYM SUMMARY REPORT RECORD STATE)
    (ADJECTIVE FIRST FINAL EXPEDITION A)
    (DESC "EXPEDITION-A-FINAL summary")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 2)
    (ACTION EXPEDITION-RECORD-FCN)>

<OBJECT EXPEDITION-B-MASTER
    (SYNONYM FILE RECORD MASTER EXPEDITION)
    (ADJECTIVE SECOND COMPLETE RED B)
    (DESC "EXPEDITION-B-MASTER file")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 3)
    (ACTION EXPEDITION-RECORD-FCN)>

<OBJECT EXPEDITION-B-TIMELINE
    (SYNONYM ROLL TIMELINE CHRONOLOGY RECORD)
    (ADJECTIVE SECOND EXPEDITION CONTINUOUS B)
    (DESC "EXPEDITION-B-TIMELINE roll")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 3)
    (ACTION EXPEDITION-RECORD-FCN)>

<OBJECT EXPEDITION-B-SUMMARY
    (SYNONYM SUMMARY REPORT RECORD STATE)
    (ADJECTIVE SECOND FINAL EXPEDITION B)
    (DESC "EXPEDITION-B-FINAL summary")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 2)
    (ACTION EXPEDITION-RECORD-FCN)>

<OBJECT EXPEDITION-COMPARISON-CARD
    (SYNONYM CARD COMPARISON DIFFERENCE DIFFERENCES)
    (ADJECTIVE CROSS RUN EXPEDITION CREAM)
    (DESC "EXPEDITION-CROSSRUN comparison card")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 1)
    (ACTION EXPEDITION-RECORD-FCN)>

<OBJECT EXPEDITION-EXPORT-PRINTOUT
    (SYNONYM PRINTOUT EXPORT RECEIPT PAPER)
    (ADJECTIVE EXPEDITION HUMAN READABLE VERSIONED)
    (DESC "EXPEDITION-EXPORT-01 printout")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 3)
    (ACTION EXPEDITION-RECORD-FCN)>

<ROUTINE EXPEDITION-ENSURE ()
    <COND (<NOT <EQUAL? <EXPEDITION-GET ,ES-VERSION> ,EXPEDITION-SCHEMA>>
           <EXPEDITION-PUT ,ES-VERSION ,EXPEDITION-SCHEMA>
           <EXPEDITION-PUT ,ES-EVENT-MIGRATION T>
           <EXPEDITION-MATERIALIZE>)>
    <RFALSE>>

<ROUTINE EXPEDITION-VICTORY? ()
    <COND (,WON-FLAG <RTRUE>)>
    <RFALSE>>

<ROUTINE EXPEDITION-COPY-SEQUENCE (DEST "AUX" (I 0) COUNT)
    <SET COUNT <PLAYBACK-GET ,PB-SLOT-COUNT>>
    <REPEAT ()
        <COND (<G? .I 11> <RETURN>)>
        <COND (<L? .I .COUNT>
               <PUT .DEST .I <GET ,PLAYBACK-SEQUENCE .I>>)
              (T <PUT .DEST .I 0>)>
        <SET I <+ .I 1>>>
    <RTRUE>>

<ROUTINE EXPEDITION-CAPTURE-A ()
    <EXPEDITION-PUT ,ES-A-SCORE ,SCORE>
    <EXPEDITION-PUT ,ES-A-DEATHS ,DEATHS>
    <EXPEDITION-PUT ,ES-A-PLAYBACK <PLAYBACK-GET ,PB-SLOT-CAPTURED>>
    <EXPEDITION-PUT ,ES-A-RISK <HOUSE-RISK-GET ,RV-HISTORY>>
    <EXPEDITION-PUT ,ES-A-REPAIRED <HOUSE-RISK-GET ,RV-REPAIRED>>
    <COND (<HOUSE-RISK-SECURED?>
           <EXPEDITION-PUT ,ES-A-SECURITY 1>)
          (T <EXPEDITION-PUT ,ES-A-SECURITY 0>)>
    <EXPEDITION-COPY-SEQUENCE ,EXPEDITION-A-SEQUENCE>
    <EXPEDITION-SET ,ES-SEALED 1>
    <EXPEDITION-PUT ,ES-LAST-BOX 1>
    <EXPEDITION-MATERIALIZE>
    <RTRUE>>

<ROUTINE EXPEDITION-CAPTURE-B ()
    <EXPEDITION-PUT ,ES-B-SCORE ,SCORE>
    <EXPEDITION-PUT ,ES-B-DEATHS ,DEATHS>
    <EXPEDITION-PUT ,ES-B-PLAYBACK <PLAYBACK-GET ,PB-SLOT-CAPTURED>>
    <EXPEDITION-PUT ,ES-B-RISK <HOUSE-RISK-GET ,RV-HISTORY>>
    <EXPEDITION-PUT ,ES-B-REPAIRED <HOUSE-RISK-GET ,RV-REPAIRED>>
    <COND (<HOUSE-RISK-SECURED?>
           <EXPEDITION-PUT ,ES-B-SECURITY 1>)
          (T <EXPEDITION-PUT ,ES-B-SECURITY 0>)>
    <EXPEDITION-COPY-SEQUENCE ,EXPEDITION-B-SEQUENCE>
    <EXPEDITION-SET ,ES-SEALED 2>
    <EXPEDITION-PUT ,ES-LAST-BOX 2>
    <EXPEDITION-MATERIALIZE>
    <RTRUE>>

<ROUTINE EXPEDITION-MATERIALIZE ()
    <COND (<EXPEDITION-HAS? ,ES-SEALED 1>
           <COND (<NOT <LOC ,EXPEDITION-A-MASTER>>
                  <MOVE ,EXPEDITION-A-MASTER ,EXPEDITION-BOX-A>)>
           <COND (<NOT <LOC ,EXPEDITION-A-TIMELINE>>
                  <MOVE ,EXPEDITION-A-TIMELINE ,EXPEDITION-BOX-A>)>
           <COND (<NOT <LOC ,EXPEDITION-A-SUMMARY>>
                  <MOVE ,EXPEDITION-A-SUMMARY ,EXPEDITION-BOX-A>)>)>
    <COND (<EXPEDITION-HAS? ,ES-SEALED 2>
           <COND (<NOT <LOC ,EXPEDITION-B-MASTER>>
                  <MOVE ,EXPEDITION-B-MASTER ,EXPEDITION-BOX-B>)>
           <COND (<NOT <LOC ,EXPEDITION-B-TIMELINE>>
                  <MOVE ,EXPEDITION-B-TIMELINE ,EXPEDITION-BOX-B>)>
           <COND (<NOT <LOC ,EXPEDITION-B-SUMMARY>>
                  <MOVE ,EXPEDITION-B-SUMMARY ,EXPEDITION-BOX-B>)>
           <COND (<NOT <LOC ,EXPEDITION-COMPARISON-CARD>>
                  <MOVE ,EXPEDITION-COMPARISON-CARD ,ARCHIVE-CABINET>)>)>
    <COND (<NOT <0? <EXPEDITION-GET ,ES-EXPORTED>>>
           <COND (<NOT <LOC ,EXPEDITION-EXPORT-PRINTOUT>>
                  <MOVE ,EXPEDITION-EXPORT-PRINTOUT ,ARCHIVE-CABINET>)>)>
    <RFALSE>>

<ROUTINE V-EXPEDITION-SEAL ()
    <EXPEDITION-ENSURE>
    <COND (<NOT <EQUAL? ,HERE ,ATTIC>>
           <TELL "A completed expedition can be sealed only beside the physical boxes in the Attic." CR>)
          (<NOT <EXPEDITION-VICTORY?>>
           <TELL "The master expedition file remains victory-gated. Partial correspondence, dossiers, case files, playback, dream, and vulnerability records stay available without pretending the expedition is complete." CR>)
          (<NOT <EXPEDITION-HAS? ,ES-SEALED 1>>
           <PLAYBACK-OBSERVE>
           <EXPEDITION-CAPTURE-A>
           <EXPEDITION-PUT ,ES-EVENT-SEAL T>
           <TELL "You seal this genuinely completed history in the first expedition box. Its exact records, chronology, deaths, outcomes, and house state remain separate from any later box." CR>)
          (<NOT <EXPEDITION-HAS? ,ES-SEALED 2>>
           <PLAYBACK-OBSERVE>
           <EXPEDITION-CAPTURE-B>
           <EXPEDITION-PUT ,ES-EVENT-SEAL T>
           <TELL "You seal the current completed history in the second expedition box. The first box is not merged, overwritten, or retroactively corrected." CR>)
          (T
           <TELL "Both bounded expedition boxes are already sealed. Export or compare them; this archive does not silently overwrite a completed history." CR>)>
    <RTRUE>>

<ROUTINE EXPEDITION-PRINT-SEQUENCE (TABLE "AUX" (I 0) CODE (SEEN <>))
    <REPEAT ()
        <COND (<G? .I 11> <RETURN>)>
        <SET CODE <GET .TABLE .I>>
        <COND (<NOT <0? .CODE>>
               <SET SEEN T>
               <PLAYBACK-PRINT-TRANSCRIPT-EVENT .CODE>)>
        <SET I <+ .I 1>>>
    <COND (<NOT .SEEN>
           <TELL "No bounded consequential scene was retained; the archive refuses to invent a route." CR>)>
    <RTRUE>>

<ROUTINE EXPEDITION-PRINT-MASTER (BOX)
    <TELL "HOUSE-OF-RECORDS-EXPEDITION schema " N ,EXPEDITION-SCHEMA ". Box ">
    <COND (<EQUAL? .BOX 1> <TELL "A">) (T <TELL "B">)>
    <TELL " is a sealed completed playthrough, not a live-state controller." CR>
    <COND (<EQUAL? .BOX 1>
           <TELL "Final score: " N <EXPEDITION-GET ,ES-A-SCORE>
                 ". Recorded deaths: " N <EXPEDITION-GET ,ES-A-DEATHS>
                 ". Consequential event mask: " N <EXPEDITION-GET ,ES-A-PLAYBACK> "." CR>)
          (T
           <TELL "Final score: " N <EXPEDITION-GET ,ES-B-SCORE>
                 ". Recorded deaths: " N <EXPEDITION-GET ,ES-B-DEATHS>
                 ". Consequential event mask: " N <EXPEDITION-GET ,ES-B-PLAYBACK> "." CR>)>
    <TELL "Alternative outcomes may exist, but this record names no unseen command, hidden route, ceremony order, or solution text." CR>
    <RTRUE>>

<ROUTINE EXPEDITION-PRINT-SUMMARY (BOX "AUX" RISK REPAIRED SECURITY)
    <COND (<EQUAL? .BOX 1>
           <SET RISK <EXPEDITION-GET ,ES-A-RISK>>
           <SET REPAIRED <EXPEDITION-GET ,ES-A-REPAIRED>>
           <SET SECURITY <EXPEDITION-GET ,ES-A-SECURITY>>)
          (T
           <SET RISK <EXPEDITION-GET ,ES-B-RISK>>
           <SET REPAIRED <EXPEDITION-GET ,ES-B-REPAIRED>>
           <SET SECURITY <EXPEDITION-GET ,ES-B-SECURITY>>)>
    <TELL "Final world and house snapshot. House incident history: " N .RISK
          ". Specific repaired-condition mask: " N .REPAIRED
          ". Special security: ">
    <COND (<1? .SECURITY> <TELL "secured">) (T <TELL "ordinary or open">)>
    <TELL ". Actor, mechanism, treasure, correspondence, archive, and object-fate detail is bounded to the exact dossiers, case files, playback records, physical custody, and chronology sealed with this box." CR>
    <RTRUE>>

<ROUTINE EXPEDITION-PRINT-COMPARE ()
    <COND (<NOT <AND <EXPEDITION-HAS? ,ES-SEALED 1>
                     <EXPEDITION-HAS? ,ES-SEALED 2>>>
           <TELL "Two separately sealed completed histories are required before a cross-run comparison exists." CR>
           <RFALSE>)>
    <TELL "EXPEDITION-CROSSRUN. Boxes remain separate." CR>
    <TELL "Score: A=" N <EXPEDITION-GET ,ES-A-SCORE>
          ", B=" N <EXPEDITION-GET ,ES-B-SCORE> "." CR>
    <TELL "Deaths: A=" N <EXPEDITION-GET ,ES-A-DEATHS>
          ", B=" N <EXPEDITION-GET ,ES-B-DEATHS> "." CR>
    <TELL "Consequential scenes: A=" N <EXPEDITION-GET ,ES-A-PLAYBACK>
          ", B=" N <EXPEDITION-GET ,ES-B-PLAYBACK> "." CR>
    <TELL "House history: A=" N <EXPEDITION-GET ,ES-A-RISK>
          ", B=" N <EXPEDITION-GET ,ES-B-RISK> "." CR>
    <TELL "Repairs: A=" N <EXPEDITION-GET ,ES-A-REPAIRED>
          ", B=" N <EXPEDITION-GET ,ES-B-REPAIRED> "." CR>
    <TELL "Security: A=" N <EXPEDITION-GET ,ES-A-SECURITY>
          ", B=" N <EXPEDITION-GET ,ES-B-SECURITY> "." CR>
    <TELL "The comparison reports observed differences in actor encounters, area resolutions, object fates, chronology, mail, and house evidence only through the two sealed receipts. Missing evidence remains missing; alternative solution text is never supplied." CR>
    <EXPEDITION-PUT ,ES-EVENT-COMPARE T>
    <RTRUE>>

<ROUTINE V-EXPEDITION-REVIEW ()
    <EXPEDITION-ENSURE>
    <COND (<NOT <EXPEDITION-HAS? ,ES-SEALED 1>>
           <TELL "No victory-gated master expedition has been sealed. Partial pre-victory files remain independently reviewable." CR>)
          (T
           <EXPEDITION-PRINT-MASTER 1>
           <TELL "Chronological route and incident roll:" CR>
           <EXPEDITION-PRINT-SEQUENCE ,EXPEDITION-A-SEQUENCE>
           <EXPEDITION-PRINT-SUMMARY 1>)>
    <RTRUE>>

<ROUTINE V-EXPEDITION-STATUS ()
    <EXPEDITION-ENSURE>
    <TELL "Completed expedition archive status: ">
    <COND (<0? <EXPEDITION-GET ,ES-SEALED>>
           <TELL "no sealed victory record">)
          (<EQUAL? <EXPEDITION-GET ,ES-SEALED> 1>
           <TELL "box A sealed; box B empty">)
          (T <TELL "boxes A and B sealed separately">)>
    <TELL ". Export schema: " N ,EXPEDITION-SCHEMA
          ". Exported mask: " N <EXPEDITION-GET ,ES-EXPORTED> "." CR>
    <SETG CLOCK-WAIT T>
    <RTRUE>>

<ROUTINE V-EXPEDITION-COMPARE ()
    <EXPEDITION-ENSURE>
    <EXPEDITION-PRINT-COMPARE>
    <SETG CLOCK-WAIT T>
    <RTRUE>>

<ROUTINE V-EXPEDITION-EXPORT ()
    <EXPEDITION-ENSURE>
    <COND (<0? <EXPEDITION-GET ,ES-SEALED>>
           <TELL "Nothing is exported before genuine victory and a sealed physical expedition box." CR>)
          (T
           <EXPEDITION-PUT ,ES-EXPORTED <EXPEDITION-GET ,ES-SEALED>>
           <EXPEDITION-PUT ,ES-EVENT-EXPORT T>
           <EXPEDITION-MATERIALIZE>
           <TELL "EXPEDITION-EXPORT-01. Human-readable deterministic receipt, schema " N ,EXPEDITION-SCHEMA
                 ", sealed-box mask " N <EXPEDITION-GET ,ES-SEALED>
                 ". It records version, score, deaths, bounded chronology, actor and area evidence, object and house outcomes, and missing-evidence boundaries without embedding commands or mutating the adventure." CR>)>
    <SETG CLOCK-WAIT T>
    <RTRUE>>

<ROUTINE EXPEDITION-RECORD-FCN ()
    <COND (<VERB? READ EXAMINE>
           <COND (<EQUAL? ,PRSO ,EXPEDITION-A-MASTER>
                  <EXPEDITION-PRINT-MASTER 1>)
                 (<EQUAL? ,PRSO ,EXPEDITION-A-TIMELINE>
                  <EXPEDITION-PRINT-SEQUENCE ,EXPEDITION-A-SEQUENCE>)
                 (<EQUAL? ,PRSO ,EXPEDITION-A-SUMMARY>
                  <EXPEDITION-PRINT-SUMMARY 1>)
                 (<EQUAL? ,PRSO ,EXPEDITION-B-MASTER>
                  <EXPEDITION-PRINT-MASTER 2>)
                 (<EQUAL? ,PRSO ,EXPEDITION-B-TIMELINE>
                  <EXPEDITION-PRINT-SEQUENCE ,EXPEDITION-B-SEQUENCE>)
                 (<EQUAL? ,PRSO ,EXPEDITION-B-SUMMARY>
                  <EXPEDITION-PRINT-SUMMARY 2>)
                 (<EQUAL? ,PRSO ,EXPEDITION-COMPARISON-CARD>
                  <EXPEDITION-PRINT-COMPARE>)
                 (T <V-EXPEDITION-EXPORT>)>)
          (<VERB? TAKE>
           <RFALSE>)>
    <RTRUE>>

<ROUTINE EXPEDITION-BOX-FCN ()
    <COND (<VERB? EXAMINE SEARCH LOOK-INSIDE>
           <TELL "This physical banker box holds one completed playthrough's exact master file, chronology roll, and final-state summary. Nothing from the other box is merged into it." CR>)
          (<VERB? TAKE>
           <TELL "The completed-expedition box stays on the Attic shelf; its physical records may be handled separately." CR>)>
    <RTRUE>>

<ROUTINE EXPEDITION-CATALOG-LIST ()
    <COND (<EXPEDITION-HAS? ,ES-SEALED 1>
           <TELL "- EXPEDITION-A: victory-gated master / chronology / final state." CR>)>
    <COND (<EXPEDITION-HAS? ,ES-SEALED 2>
           <TELL "- EXPEDITION-B: separately sealed master / chronology / final state." CR>
           <TELL "- EXPEDITION-CROSSRUN: bounded differences without merged histories." CR>)>
    <COND (<NOT <0? <EXPEDITION-GET ,ES-EXPORTED>>>
           <TELL "- EXPEDITION-EXPORT-01: schema-versioned human-readable receipt." CR>)>
    <RFALSE>>

<ROUTINE EXPEDITION-RECAP ("AUX" (SEEN <>))
    <COND (<EXPEDITION-GET ,ES-EVENT-SEAL>
           <SET SEEN T>
           <TELL "- Genuine victory sealed a completed expedition as physical master, chronology, and final-state records in a separate banker box." CR>)>
    <COND (<EXPEDITION-GET ,ES-EVENT-COMPARE>
           <SET SEEN T>
           <TELL "- Cross-run comparison reported bounded differences without merging mutually exclusive histories or revealing unseen solutions." CR>)>
    <COND (<EXPEDITION-GET ,ES-EVENT-EXPORT>
           <SET SEEN T>
           <TELL "- A deterministic schema-versioned human-readable expedition receipt was produced." CR>)>
    <COND (<EXPEDITION-GET ,ES-EVENT-MIGRATION>
           <SET SEEN T>
           <TELL "- Archive schema migration conservatively rematerialized exact records from sealed state." CR>)>
    <COND (.SEEN <RTRUE>)>
    <RFALSE>>
