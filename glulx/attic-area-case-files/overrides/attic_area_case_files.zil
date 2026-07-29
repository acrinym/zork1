"Regional case files and completion dossiers for the repository-local Zork I Glulx lineage."

;"Release 1226 observes player-earned regional evidence and turns it into exact
  physical case files. Partial files retain explicit gaps and redactions.
  Complete synthesis is retrospective only: it cannot reveal, solve, score,
  move, repair, or otherwise mutate the live world."

<CONSTANT AREA-SCHEMA 1>

<CONSTANT AREA-SLOT-VERSION 0>
<CONSTANT AREA-SLOT-SEEN 1>
<CONSTANT AREA-SLOT-DAM 2>
<CONSTANT AREA-SLOT-HADES 3>
<CONSTANT AREA-SLOT-HOUSE 4>
<CONSTANT AREA-SLOT-FOREST 5>
<CONSTANT AREA-SLOT-UNDERGROUND 6>
<CONSTANT AREA-SLOT-COMPLETE 7>
<CONSTANT AREA-SLOT-FILED 8>
<CONSTANT AREA-SLOT-EVENT-MODEL 9>
<CONSTANT AREA-SLOT-EVENT-PARTIAL 10>
<CONSTANT AREA-SLOT-EVENT-SYNTHESIS 11>
<CONSTANT AREA-SLOT-EVENT-RESTORE 12>
<CONSTANT AREA-SLOT-EVENT-CROSS 13>
<CONSTANT AREA-SLOT-LAST 14>

<CONSTANT AREA-BIT-DAM 1>
<CONSTANT AREA-BIT-HADES 2>
<CONSTANT AREA-BIT-HOUSE 4>
<CONSTANT AREA-BIT-FOREST 8>
<CONSTANT AREA-BIT-UNDERGROUND 16>
<CONSTANT AREA-BIT-SYNTHESIS 32>
<CONSTANT AREA-BIT-REQUIRED 31>

<CONSTANT AREA-EVIDENCE-DISCOVERY 1>
<CONSTANT AREA-EVIDENCE-MECHANISM 2>
<CONSTANT AREA-EVIDENCE-OUTCOME 4>
<CONSTANT AREA-EVIDENCE-DOCUMENT 8>
<CONSTANT AREA-EVIDENCE-ACTOR 16>
<CONSTANT AREA-EVIDENCE-VARIATION 32>
<CONSTANT AREA-EVIDENCE-COMPLETE 64>

<CONSTANT AREA-STATE <TABLE 0 0 0 0 0 0 0 0 0 <> <> <> <> <> 0>>

<OBJECT AREA-DAM-CASE
    (SYNONYM CASE FILE DOSSIER FOLDER)
    (ADJECTIVE DAM FCD3 RED REGIONAL)
    (DESC "red Flood Control Dam case file")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 3)
    (ACTION AREA-CASE-FCN)>

<OBJECT AREA-HADES-CASE
    (SYNONYM CASE FILE DOSSIER FOLDER)
    (ADJECTIVE HADES CEREMONY BLACK REGIONAL)
    (DESC "black Hades ceremony case file")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 3)
    (ACTION AREA-CASE-FCN)>

<OBJECT AREA-HOUSE-CASE
    (SYNONYM CASE FILE DOSSIER FOLDER)
    (ADJECTIVE HOUSE WHITE REGIONAL)
    (DESC "white house case file")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 3)
    (ACTION AREA-CASE-FCN)>

<OBJECT AREA-FOREST-CASE
    (SYNONYM CASE FILE DOSSIER FOLDER)
    (ADJECTIVE FOREST GREEN REGIONAL)
    (DESC "green forest case file")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 3)
    (ACTION AREA-CASE-FCN)>

<OBJECT AREA-UNDERGROUND-CASE
    (SYNONYM CASE FILE DOSSIER FOLDER)
    (ADJECTIVE UNDERGROUND BROWN REGIONAL)
    (DESC "brown underground case file")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 3)
    (ACTION AREA-CASE-FCN)>

<OBJECT AREA-SYNTHESIS-PRINTOUT
    (SYNONYM PRINTOUT REPORT SYNTHESIS RECORD)
    (ADJECTIVE REGIONAL COMPLETE RETROSPECTIVE CREAM)
    (DESC "cream regional synthesis printout")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 2)
    (ACTION AREA-CASE-FCN)>

<ROUTINE AREA-GET (SLOT)
    <GET ,AREA-STATE .SLOT>>

<ROUTINE AREA-PUT (SLOT VALUE)
    <PUT ,AREA-STATE .SLOT .VALUE>>

<ROUTINE AREA-HAS? (SLOT BIT)
    <COND (<NOT <0? <BAND <AREA-GET .SLOT> .BIT>>> <RTRUE>)>
    <RFALSE>>

<ROUTINE AREA-SET (SLOT BIT)
    <AREA-PUT .SLOT <BOR <AREA-GET .SLOT> .BIT>>
    <RTRUE>>

<ROUTINE AREA-CASE-BIT (OBJ)
    <COND (<EQUAL? .OBJ ,AREA-DAM-CASE> <RETURN ,AREA-BIT-DAM>)
          (<EQUAL? .OBJ ,AREA-HADES-CASE> <RETURN ,AREA-BIT-HADES>)
          (<EQUAL? .OBJ ,AREA-HOUSE-CASE> <RETURN ,AREA-BIT-HOUSE>)
          (<EQUAL? .OBJ ,AREA-FOREST-CASE> <RETURN ,AREA-BIT-FOREST>)
          (<EQUAL? .OBJ ,AREA-UNDERGROUND-CASE> <RETURN ,AREA-BIT-UNDERGROUND>)
          (<EQUAL? .OBJ ,AREA-SYNTHESIS-PRINTOUT> <RETURN ,AREA-BIT-SYNTHESIS>)>
    <RETURN 0>>

<ROUTINE AREA-CASE? (OBJ)
    <COND (<NOT <0? <AREA-CASE-BIT .OBJ>>> <RTRUE>)>
    <RFALSE>>

<ROUTINE AREA-MATERIALIZE (OBJ BIT)
    <COND (<NOT <LOC .OBJ>> <MOVE .OBJ ,ARCHIVE-CABINET>)>
    <AREA-SET ,AREA-SLOT-SEEN .BIT>
    <ARCHIVE-SET-BIT ,AS-INDEXED <* .BIT 512>>
    <AREA-PUT ,AREA-SLOT-LAST .BIT>
    <AREA-PUT ,AREA-SLOT-EVENT-MODEL T>
    <RTRUE>>

<ROUTINE AREA-MARK-COMPLETE (SLOT BIT)
    <AREA-SET .SLOT ,AREA-EVIDENCE-COMPLETE>
    <AREA-SET ,AREA-SLOT-COMPLETE .BIT>
    <RTRUE>>

<ROUTINE AREA-OBSERVE-DAM ()
    <COND (<OR <FSET? ,DAM-ROOM ,TOUCHBIT>
               <FSET? ,MAINTENANCE-ROOM ,TOUCHBIT>
               ,DAM-MECH-PANEL-DIAGNOSED
               ,DAM-MECH-INTERLOCK-SEEN
               ,DAM-MECH-BOLT-ATTEMPTED
               ,DAM-MECH-GATES-CYCLED
               ,DAM-MECH-LEAK-TRIGGERED
               ,DAM-MECH-LEAK-REPAIRED>
           <AREA-MATERIALIZE ,AREA-DAM-CASE ,AREA-BIT-DAM>
           <COND (<OR <FSET? ,DAM-ROOM ,TOUCHBIT>
                      <FSET? ,MAINTENANCE-ROOM ,TOUCHBIT>>
                  <AREA-SET ,AREA-SLOT-DAM ,AREA-EVIDENCE-DISCOVERY>)>
           <COND (<OR ,DAM-MECH-PANEL-DIAGNOSED
                      ,DAM-MECH-INTERLOCK-SEEN
                      ,DAM-MECH-BOLT-ATTEMPTED
                      ,DAM-MECH-TOOL-PROBED>
                  <AREA-SET ,AREA-SLOT-DAM ,AREA-EVIDENCE-MECHANISM>)>
           <COND (<OR ,DAM-MECH-GATES-CYCLED
                      ,DAM-MECH-LEAK-TRIGGERED
                      ,DAM-MECH-LEAK-REPAIRED>
                  <AREA-SET ,AREA-SLOT-DAM ,AREA-EVIDENCE-OUTCOME>)>
           <COND (<OR <LOC ,ARCHIVE-DAM-PRINTOUT>
                      <LOC ,MAIL-DAM-NOTE>>
                  <AREA-SET ,AREA-SLOT-DAM ,AREA-EVIDENCE-DOCUMENT>)>
           <COND (<OR ,DAM-MECH-LEAK-TRIGGERED
                      ,DAM-MECH-GATES-CYCLED>
                  <AREA-SET ,AREA-SLOT-DAM ,AREA-EVIDENCE-VARIATION>)>
           <COND (<AND ,DAM-MECH-PANEL-DIAGNOSED
                       ,DAM-MECH-INTERLOCK-SEEN
                       ,DAM-MECH-GATES-CYCLED
                       ,DAM-MECH-LEAK-TRIGGERED
                       ,DAM-MECH-LEAK-REPAIRED>
                  <AREA-MARK-COMPLETE ,AREA-SLOT-DAM ,AREA-BIT-DAM>)>)>
    <RFALSE>>

<ROUTINE AREA-OBSERVE-HADES ()
    <COND (<OR <FSET? ,ENTRANCE-TO-HADES ,TOUCHBIT>
               <FSET? ,NORTH-TEMPLE ,TOUCHBIT>
               <FSET? ,SOUTH-TEMPLE ,TOUCHBIT>
               ,RITUAL-CEREMONY-KNOWN
               ,RITUAL-BELL-RESONANCE-HEARD
               ,RITUAL-BELL-ANSWERED
               ,RITUAL-CANDLES-ANSWERED
               ,RITUAL-WRONG-ORDER-SEEN
               ,RITUAL-PRAYER-COMPLETED>
           <AREA-MATERIALIZE ,AREA-HADES-CASE ,AREA-BIT-HADES>
           <COND (<OR <FSET? ,ENTRANCE-TO-HADES ,TOUCHBIT>
                      <FSET? ,NORTH-TEMPLE ,TOUCHBIT>
                      <FSET? ,SOUTH-TEMPLE ,TOUCHBIT>>
                  <AREA-SET ,AREA-SLOT-HADES ,AREA-EVIDENCE-DISCOVERY>
                  <AREA-SET ,AREA-SLOT-HADES ,AREA-EVIDENCE-ACTOR>)>
           <COND (<OR ,RITUAL-CEREMONY-KNOWN
                      ,RITUAL-BELL-ANSWERED
                      ,RITUAL-CANDLES-ANSWERED>
                  <AREA-SET ,AREA-SLOT-HADES ,AREA-EVIDENCE-MECHANISM>)>
           <COND (,RITUAL-CEREMONY-KNOWN
                  <AREA-SET ,AREA-SLOT-HADES ,AREA-EVIDENCE-DOCUMENT>)>
           <COND (<OR ,RITUAL-PRAYER-COMPLETED ,LLD-FLAG>
                  <AREA-SET ,AREA-SLOT-HADES ,AREA-EVIDENCE-OUTCOME>)>
           <COND (<OR ,RITUAL-WRONG-ORDER-SEEN
                      ,RITUAL-MIRROR-RESONANCE>
                  <AREA-SET ,AREA-SLOT-HADES ,AREA-EVIDENCE-VARIATION>)>
           <COND (<AND ,RITUAL-CEREMONY-KNOWN
                       ,RITUAL-BELL-ANSWERED
                       ,RITUAL-CANDLES-ANSWERED
                       ,RITUAL-WRONG-ORDER-SEEN
                       ,RITUAL-PRAYER-COMPLETED>
                  <AREA-MARK-COMPLETE ,AREA-SLOT-HADES ,AREA-BIT-HADES>)>)>
    <RFALSE>>

<ROUTINE AREA-OBSERVE-HOUSE ()
    <HOUSE-STATE-REFRESH>
    <COND (<OR ,HOUSE-EVENT-ENTERED
               ,HOUSE-EVENT-ATTIC
               ,HOUSE-EVENT-CELLAR
               ,HOUSE-EVENT-RETURN
               ,HOUSE-EVENT-COLLECTION
               ,HOUSE-EVENT-DISTURBANCE>
           <AREA-MATERIALIZE ,AREA-HOUSE-CASE ,AREA-BIT-HOUSE>
           <COND (<OR ,HOUSE-EVENT-ENTERED
                      ,HOUSE-EVENT-ATTIC
                      ,HOUSE-EVENT-CELLAR>
                  <AREA-SET ,AREA-SLOT-HOUSE ,AREA-EVIDENCE-DISCOVERY>)>
           <COND (<OR ,HOUSE-EVENT-RETURN
                      ,HOUSE-EVENT-COLLECTION>
                  <AREA-SET ,AREA-SLOT-HOUSE ,AREA-EVIDENCE-OUTCOME>)>
           <COND (<OR <LOC ,ARCHIVE-THRESHOLD-FOLDER>
                      <LOC ,ARCHIVE-DISPLAY-CARD>
                      <LOC ,ARCHIVE-CHRONOLOGY-CASSETTE>>
                  <AREA-SET ,AREA-SLOT-HOUSE ,AREA-EVIDENCE-DOCUMENT>)>
           <COND (,HOUSE-EVENT-DISTURBANCE
                  <AREA-SET ,AREA-SLOT-HOUSE ,AREA-EVIDENCE-VARIATION>)>
           <COND (<AND ,HOUSE-EVENT-ENTERED
                       ,HOUSE-EVENT-ATTIC
                       ,HOUSE-EVENT-CELLAR
                       ,HOUSE-EVENT-RETURN
                       ,HOUSE-EVENT-COLLECTION
                       ,HOUSE-EVENT-DISTURBANCE>
                  <AREA-MARK-COMPLETE ,AREA-SLOT-HOUSE ,AREA-BIT-HOUSE>)>)>
    <RFALSE>>

<ROUTINE AREA-OBSERVE-FOREST ()
    <COND (<OR <FSET? ,FOREST-1 ,TOUCHBIT>
               <FSET? ,FOREST-2 ,TOUCHBIT>
               <FSET? ,FOREST-3 ,TOUCHBIT>
               <FSET? ,CLEARING ,TOUCHBIT>>
           <AREA-MATERIALIZE ,AREA-FOREST-CASE ,AREA-BIT-FOREST>
           <AREA-SET ,AREA-SLOT-FOREST ,AREA-EVIDENCE-DISCOVERY>
           <COND (<FSET? ,SONGBIRD ,TOUCHBIT>
                  <AREA-SET ,AREA-SLOT-FOREST ,AREA-EVIDENCE-ACTOR>)>
           <COND (<FSET? ,CLEARING ,TOUCHBIT>
                  <AREA-SET ,AREA-SLOT-FOREST ,AREA-EVIDENCE-VARIATION>)>
           <COND (<AND <FSET? ,FOREST-1 ,TOUCHBIT>
                       <FSET? ,FOREST-2 ,TOUCHBIT>
                       <FSET? ,FOREST-3 ,TOUCHBIT>
                       <FSET? ,CLEARING ,TOUCHBIT>>
                  <AREA-MARK-COMPLETE ,AREA-SLOT-FOREST ,AREA-BIT-FOREST>)>)>
    <RFALSE>>

<ROUTINE AREA-OBSERVE-UNDERGROUND ()
    <COND (<OR ,HOUSE-EVENT-CELLAR
               <NOT <0? <BAND <NPC-GET ,NS-SEEN> 7>>>
               <AREA-HAS? ,AREA-SLOT-SEEN ,AREA-BIT-DAM>
               <AREA-HAS? ,AREA-SLOT-SEEN ,AREA-BIT-HADES>>
           <AREA-MATERIALIZE ,AREA-UNDERGROUND-CASE ,AREA-BIT-UNDERGROUND>
           <COND (,HOUSE-EVENT-CELLAR
                  <AREA-SET ,AREA-SLOT-UNDERGROUND ,AREA-EVIDENCE-DISCOVERY>)>
           <COND (<NOT <0? <BAND <NPC-GET ,NS-SEEN> 7>>>
                  <AREA-SET ,AREA-SLOT-UNDERGROUND ,AREA-EVIDENCE-ACTOR>)>
           <COND (<OR <AREA-HAS? ,AREA-SLOT-SEEN ,AREA-BIT-DAM>
                      <AREA-HAS? ,AREA-SLOT-SEEN ,AREA-BIT-HADES>>
                  <AREA-SET ,AREA-SLOT-UNDERGROUND ,AREA-EVIDENCE-MECHANISM>)>
           <COND (<OR <AREA-HAS? ,AREA-SLOT-COMPLETE ,AREA-BIT-DAM>
                      <AREA-HAS? ,AREA-SLOT-COMPLETE ,AREA-BIT-HADES>>
                  <AREA-SET ,AREA-SLOT-UNDERGROUND ,AREA-EVIDENCE-OUTCOME>)>
           <COND (<NOT <EQUAL? <BAND <NPC-GET ,NS-SEEN> 7> 7>>
                  <AREA-SET ,AREA-SLOT-UNDERGROUND ,AREA-EVIDENCE-VARIATION>)>
           <COND (<AND <AREA-HAS? ,AREA-SLOT-COMPLETE ,AREA-BIT-DAM>
                       <AREA-HAS? ,AREA-SLOT-COMPLETE ,AREA-BIT-HADES>
                       <EQUAL? <BAND <NPC-GET ,NS-SEEN> 7> 7>
                       ,HOUSE-EVENT-RETURN>
                  <AREA-MARK-COMPLETE ,AREA-SLOT-UNDERGROUND ,AREA-BIT-UNDERGROUND>)>)>
    <RFALSE>>

<ROUTINE AREA-ENSURE-SYNTHESIS ()
    <COND (<EQUAL? <BAND <AREA-GET ,AREA-SLOT-COMPLETE> ,AREA-BIT-REQUIRED>
                   ,AREA-BIT-REQUIRED>
           <AREA-MATERIALIZE ,AREA-SYNTHESIS-PRINTOUT ,AREA-BIT-SYNTHESIS>
           <AREA-SET ,AREA-SLOT-COMPLETE ,AREA-BIT-SYNTHESIS>
           <AREA-PUT ,AREA-SLOT-EVENT-SYNTHESIS T>)>
    <RFALSE>>

<ROUTINE AREA-OBSERVE-WORLD ()
    <AREA-OBSERVE-DAM>
    <AREA-OBSERVE-HADES>
    <AREA-OBSERVE-HOUSE>
    <AREA-OBSERVE-FOREST>
    <AREA-OBSERVE-UNDERGROUND>
    <AREA-ENSURE-SYNTHESIS>
    <RFALSE>>

<ROUTINE AREA-PRINT-STATUS (SLOT)
    <COND (<AREA-HAS? .SLOT ,AREA-EVIDENCE-COMPLETE>
           <TELL "COMPLETE">)
          (T
           <TELL "INCOMPLETE; unresolved sections remain redacted">)>
    <RTRUE>>

<ROUTINE AREA-READ-DAM ()
    <TELL "AREA-DAM-03. Flood Control Dam #3 regional case file." CR>
    <TELL "Status: "><AREA-PRINT-STATUS ,AREA-SLOT-DAM><TELL "." CR>
    <COND (<AREA-HAS? ,AREA-SLOT-DAM ,AREA-EVIDENCE-DISCOVERY>
           <TELL "- Place evidence: the Dam Room and maintenance works were directly visited." CR>)
          (T <TELL "- Place evidence: [REDACTED - no verified visit]." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-DAM ,AREA-EVIDENCE-MECHANISM>
           <TELL "- Mechanism evidence: observed panel, interlock, bolt, and tool responses are indexed without converting them into operating instructions." CR>)
          (T <TELL "- Mechanism evidence: [REDACTED - no verified interaction]." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-DAM ,AREA-EVIDENCE-OUTCOME>
           <TELL "- Outcome evidence: gate and leak consequences actually produced in this expedition are retained." CR>)
          (T <TELL "- Outcome evidence: unresolved; no final state is inferred." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-DAM ,AREA-EVIDENCE-DOCUMENT>
           <TELL "- Documents: exact maintenance correspondence and printout are cross-indexed where physically present." CR>)
          (T <TELL "- Documents: missing; the archive creates no replacement paperwork." CR>)>
    <RTRUE>>

<ROUTINE AREA-READ-HADES ()
    <TELL "AREA-HADES-04. Hades ceremony regional case file." CR>
    <TELL "Status: "><AREA-PRINT-STATUS ,AREA-SLOT-HADES><TELL "." CR>
    <COND (<AREA-HAS? ,AREA-SLOT-HADES ,AREA-EVIDENCE-DISCOVERY>
           <TELL "- Place and actor evidence: temples, entrance, and encountered spirits are retained only from direct observation." CR>)
          (T <TELL "- Place and actor evidence: [REDACTED - no verified encounter]." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HADES ,AREA-EVIDENCE-MECHANISM>
           <TELL "- Ceremony evidence: bell, paired-light, and prayer stages already observed are indexed without naming an unearned next action." CR>)
          (T <TELL "- Ceremony evidence: [REDACTED - sequence not established]." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HADES ,AREA-EVIDENCE-VARIATION>
           <TELL "- Variations: wrong-order and mirror-resonance evidence remain distinct from successful completion." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HADES ,AREA-EVIDENCE-OUTCOME>
           <TELL "- Outcome: the canonical spirit-removal state was directly verified." CR>)
          (T <TELL "- Outcome: unresolved; the file predicts nothing." CR>)>
    <RTRUE>>

<ROUTINE AREA-READ-HOUSE ()
    <TELL "AREA-HOUSE-01. White house regional case file." CR>
    <TELL "Status: "><AREA-PRINT-STATUS ,AREA-SLOT-HOUSE><TELL "." CR>
    <TELL "- The file records actual use, Attic and Cellar thresholds, return cycles, collection evidence, and disturbance without replacing the canonical trophy-case score." CR>
    <COND (<AREA-HAS? ,AREA-SLOT-HOUSE ,AREA-EVIDENCE-DOCUMENT>
           <TELL "- Exact house folders, display cards, and chronology media are linked where they physically exist." CR>)
          (T <TELL "- Documentary series: incomplete; no missing record is fabricated." CR>)>
    <RTRUE>>

<ROUTINE AREA-READ-FOREST ()
    <TELL "AREA-FOREST-02. Forest exploration regional case file." CR>
    <TELL "Status: "><AREA-PRINT-STATUS ,AREA-SLOT-FOREST><TELL "." CR>
    <TELL "- Coverage is derived from actual visits to the three forest sectors and clearing, not from a map reveal or checklist." CR>
    <COND (<AREA-HAS? ,AREA-SLOT-FOREST ,AREA-EVIDENCE-ACTOR>
           <TELL "- Living evidence: a direct songbird interaction is retained." CR>)
          (T <TELL "- Living evidence: missing or unobserved." CR>)>
    <RTRUE>>

<ROUTINE AREA-READ-UNDERGROUND ()
    <TELL "AREA-UNDERGROUND-05. Underground expedition regional case file." CR>
    <TELL "Status: "><AREA-PRINT-STATUS ,AREA-SLOT-UNDERGROUND><TELL "." CR>
    <TELL "- This file cross-indexes only earned Cellar-threshold, actor-dossier, Dam, and Hades evidence." CR>
    <COND (<AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-EVIDENCE-VARIATION>
           <TELL "- Missing actors or unresolved regional outcomes remain explicit gaps, not hints." CR>)
          (T <TELL "- Required actor and regional evidence is present for retrospective synthesis." CR>)>
    <RTRUE>>

<ROUTINE AREA-READ-SYNTHESIS ()
    <COND (<NOT <AREA-HAS? ,AREA-SLOT-COMPLETE ,AREA-BIT-SYNTHESIS>>
           <TELL "No regional synthesis exists. The archive will not convert missing evidence into a completion checklist." CR>)
          (T
           <TELL "AREA-SYNTHESIS. Retrospective regional explanation." CR>
           <TELL "The House, forest, underground, Dam #3, and Hades files are complete by their own earned-evidence contracts." CR>
           <TELL "The printout explains relationships among already verified discoveries, mechanisms, actors, documents, variations, and outcomes. It grants no score, changes no object, opens no route, advances no timer, and reveals no unseen solution." CR>)>
    <RTRUE>>

<ROUTINE AREA-READ (OBJ)
    <COND (<EQUAL? .OBJ ,AREA-DAM-CASE> <AREA-READ-DAM>)
          (<EQUAL? .OBJ ,AREA-HADES-CASE> <AREA-READ-HADES>)
          (<EQUAL? .OBJ ,AREA-HOUSE-CASE> <AREA-READ-HOUSE>)
          (<EQUAL? .OBJ ,AREA-FOREST-CASE> <AREA-READ-FOREST>)
          (<EQUAL? .OBJ ,AREA-UNDERGROUND-CASE> <AREA-READ-UNDERGROUND>)
          (T <AREA-READ-SYNTHESIS>)>
    <AREA-PUT ,AREA-SLOT-EVENT-PARTIAL T>
    <RTRUE>>

<ROUTINE AREA-CROSS (OBJ)
    <COND (<EQUAL? .OBJ ,AREA-DAM-CASE>
           <TELL "Cross-reference: FCD3-MAINT-03 and exact Dam correspondence when present; no unobserved operating sequence is added." CR>)
          (<EQUAL? .OBJ ,AREA-HADES-CASE>
           <TELL "Cross-reference: ritual receipts, exact bell/candle/book evidence, and verified spirit-removal state only." CR>)
          (<EQUAL? .OBJ ,AREA-HOUSE-CASE>
           <TELL "Cross-reference: HOUSE-THRESHOLD-01, HOUSE-DISPLAY-02, VISIT series, and house chronology where earned." CR>)
          (<EQUAL? .OBJ ,AREA-FOREST-CASE>
           <TELL "Cross-reference: visited forest sectors and clearing only; no hidden route or undiscovered map is supplied." CR>)
          (<EQUAL? .OBJ ,AREA-UNDERGROUND-CASE>
           <TELL "Cross-reference: player-specific troll, cyclops, and thief dossiers plus complete Dam and Hades case files where present." CR>)
          (T
           <TELL "Cross-reference: the five complete regional files. This retrospective index does not merge expeditions or alter the present." CR>)>
    <AREA-PUT ,AREA-SLOT-EVENT-CROSS T>
    <RTRUE>>

<ROUTINE AREA-FILE ()
    <COND (<NOT <EQUAL? ,HERE ,ATTIC>>
           <TELL "Regional case files can be filed only in the canonical Attic." CR>)
          (<NOT <IN? ,PRSO ,WINNER>>
           <TELL "You must hold the exact physical case file before filing it." CR>)
          (T
           <MOVE ,PRSO ,ARCHIVE-CABINET>
           <AREA-SET ,AREA-SLOT-FILED <AREA-CASE-BIT ,PRSO>>
           <ARCHIVE-PUT ,AS-EVENT-FILING T>
           <TELL "You file the exact regional record in the steel cabinet. No duplicate, completion token, or repaired evidence is created." CR>)>
    <RTRUE>>

<ROUTINE AREA-CASE-FCN ()
    <COND (<VERB? READ EXAMINE>
           <AREA-READ ,PRSO>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE AREA-ACTION-HOOK ()
    <COND (<AND <VERB? ARCHIVE-FILE> <AREA-CASE? ,PRSO>>
           <AREA-FILE>
           <RTRUE>)
          (<AND <VERB? ARCHIVE-REVIEW ARCHIVE-SHOW>
                <AREA-CASE? ,PRSO>>
           <AREA-READ ,PRSO>
           <RTRUE>)
          (<AND <VERB? ARCHIVE-CROSS> <AREA-CASE? ,PRSO>>
           <AREA-CROSS ,PRSO>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE AREA-ADVANCE ()
    <COND (<SHADOW-NON-TURN-COMMAND?> <RFALSE>)>
    <AREA-ENSURE>
    <AREA-OBSERVE-WORLD>
    <RFALSE>>

<ROUTINE AREA-ENSURE ()
    <COND (<NOT <EQUAL? <AREA-GET ,AREA-SLOT-VERSION> ,AREA-SCHEMA>>
           <AREA-PUT ,AREA-SLOT-VERSION ,AREA-SCHEMA>
           <AREA-PUT ,AREA-SLOT-EVENT-RESTORE T>
           <COND (<LOC ,AREA-DAM-CASE> <AREA-SET ,AREA-SLOT-SEEN ,AREA-BIT-DAM>)>
           <COND (<LOC ,AREA-HADES-CASE> <AREA-SET ,AREA-SLOT-SEEN ,AREA-BIT-HADES>)>
           <COND (<LOC ,AREA-HOUSE-CASE> <AREA-SET ,AREA-SLOT-SEEN ,AREA-BIT-HOUSE>)>
           <COND (<LOC ,AREA-FOREST-CASE> <AREA-SET ,AREA-SLOT-SEEN ,AREA-BIT-FOREST>)>
           <COND (<LOC ,AREA-UNDERGROUND-CASE> <AREA-SET ,AREA-SLOT-SEEN ,AREA-BIT-UNDERGROUND>)>
           <COND (<LOC ,AREA-SYNTHESIS-PRINTOUT> <AREA-SET ,AREA-SLOT-SEEN ,AREA-BIT-SYNTHESIS>)>)>
    <RFALSE>>

<ROUTINE AREA-CATALOG-LIST ()
    <COND (<AREA-HAS? ,AREA-SLOT-SEEN ,AREA-BIT-HOUSE>
           <TELL "- AREA-HOUSE-01: place / collection / threshold / chronology." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-SEEN ,AREA-BIT-FOREST>
           <TELL "- AREA-FOREST-02: place / exploration / living evidence / variations." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-SEEN ,AREA-BIT-DAM>
           <TELL "- AREA-DAM-03: place / mechanism / maintenance / outcome." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-SEEN ,AREA-BIT-HADES>
           <TELL "- AREA-HADES-04: place / ceremony / actors / outcome." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-SEEN ,AREA-BIT-UNDERGROUND>
           <TELL "- AREA-UNDERGROUND-05: expedition / actors / mechanisms / unresolved evidence." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-SEEN ,AREA-BIT-SYNTHESIS>
           <TELL "- AREA-SYNTHESIS: complete retrospective regional explanation." CR>)>
    <RFALSE>>

<ROUTINE AREA-RECAP ("AUX" (SEEN <>))
    <COND (<AREA-GET ,AREA-SLOT-EVENT-MODEL>
           <SET SEEN T>
           <TELL "- Regional files normalized discoveries, mechanisms, outcomes, documents, actors, and unresolved variations from earned evidence." CR>)>
    <COND (<AREA-GET ,AREA-SLOT-EVENT-PARTIAL>
           <SET SEEN T>
           <TELL "- Incomplete case files retained missing and redacted sections without exposing undiscovered solutions." CR>)>
    <COND (<AREA-GET ,AREA-SLOT-EVENT-SYNTHESIS>
           <SET SEEN T>
           <TELL "- Complete regional synthesis unlocked only after all five case contracts were satisfied and remained retrospective and score-neutral." CR>)>
    <COND (<AREA-GET ,AREA-SLOT-EVENT-CROSS>
           <SET SEEN T>
           <TELL "- Cross-references linked only exact physical records and player-specific evidence already present in this expedition." CR>)>
    <COND (<AREA-GET ,AREA-SLOT-EVENT-RESTORE>
           <SET SEEN T>
           <TELL "- Versioned case state, completion bits, and exact physical custody remained native-save persistent." CR>)>
    <COND (.SEEN <RTRUE>)>
    <RFALSE>>
