"Regional case files and completion dossiers for the repository-local Zork I Glulx lineage."

;"Release 1226 observes player-earned regional evidence and turns it into exact
  physical case files. Every retained statement is backed by one itemized
  observation. Partial files keep explicit gaps and redactions. Complete
  synthesis is retrospective only: it cannot reveal, solve, score, move,
  repair, or otherwise mutate the live world."

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

;"Itemized Dam observations."
<CONSTANT AREA-DAM-VISIT 1>
<CONSTANT AREA-DAM-PANEL 2>
<CONSTANT AREA-DAM-INTERLOCK 4>
<CONSTANT AREA-DAM-BOLT 8>
<CONSTANT AREA-DAM-TOOLS 16>
<CONSTANT AREA-DAM-GATES 32>
<CONSTANT AREA-DAM-LEAK 64>
<CONSTANT AREA-DAM-REPAIR 128>
<CONSTANT AREA-DAM-DOCUMENT 256>

;"Itemized Hades observations."
<CONSTANT AREA-HADES-VISIT 1>
<CONSTANT AREA-HADES-SPIRITS 2>
<CONSTANT AREA-HADES-BOOK 4>
<CONSTANT AREA-HADES-BELL 8>
<CONSTANT AREA-HADES-CANDLES 16>
<CONSTANT AREA-HADES-WRONG 32>
<CONSTANT AREA-HADES-MIRROR 64>
<CONSTANT AREA-HADES-OUTCOME 128>

;"Itemized House observations."
<CONSTANT AREA-HOUSE-USE 1>
<CONSTANT AREA-HOUSE-ATTIC 2>
<CONSTANT AREA-HOUSE-CELLAR 4>
<CONSTANT AREA-HOUSE-RETURN 8>
<CONSTANT AREA-HOUSE-COLLECTION 16>
<CONSTANT AREA-HOUSE-DISTURBANCE 32>
<CONSTANT AREA-HOUSE-DOCUMENT 64>

;"Itemized forest observations."
<CONSTANT AREA-FOREST-ONE 1>
<CONSTANT AREA-FOREST-TWO 2>
<CONSTANT AREA-FOREST-THREE 4>
<CONSTANT AREA-FOREST-CLEARING 8>
<CONSTANT AREA-FOREST-SONGBIRD 16>

;"Itemized underground observations."
<CONSTANT AREA-UNDER-CELLAR 1>
<CONSTANT AREA-UNDER-TROLL 2>
<CONSTANT AREA-UNDER-CYCLOPS 4>
<CONSTANT AREA-UNDER-THIEF 8>
<CONSTANT AREA-UNDER-DAM 16>
<CONSTANT AREA-UNDER-HADES 32>
<CONSTANT AREA-UNDER-RETURN 64>

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

<ROUTINE AREA-MARK-COMPLETE (BIT)
    <AREA-SET ,AREA-SLOT-COMPLETE .BIT>
    <RTRUE>>

<ROUTINE AREA-OBSERVE-DAM ()
    <COND (<OR <FSET? ,DAM-ROOM ,TOUCHBIT>
               <FSET? ,MAINTENANCE-ROOM ,TOUCHBIT>
               ,DAM-MECH-PANEL-DIAGNOSED
               ,DAM-MECH-INTERLOCK-SEEN
               ,DAM-MECH-BOLT-ATTEMPTED
               ,DAM-MECH-TOOL-PROBED
               ,DAM-MECH-GATES-CYCLED
               ,DAM-MECH-LEAK-TRIGGERED
               ,DAM-MECH-LEAK-REPAIRED
               <LOC ,ARCHIVE-DAM-PRINTOUT>
               <LOC ,MAIL-DAM-NOTE>>
           <AREA-MATERIALIZE ,AREA-DAM-CASE ,AREA-BIT-DAM>
           <COND (<OR <FSET? ,DAM-ROOM ,TOUCHBIT>
                      <FSET? ,MAINTENANCE-ROOM ,TOUCHBIT>>
                  <AREA-SET ,AREA-SLOT-DAM ,AREA-DAM-VISIT>)>
           <COND (,DAM-MECH-PANEL-DIAGNOSED
                  <AREA-SET ,AREA-SLOT-DAM ,AREA-DAM-PANEL>)>
           <COND (,DAM-MECH-INTERLOCK-SEEN
                  <AREA-SET ,AREA-SLOT-DAM ,AREA-DAM-INTERLOCK>)>
           <COND (,DAM-MECH-BOLT-ATTEMPTED
                  <AREA-SET ,AREA-SLOT-DAM ,AREA-DAM-BOLT>)>
           <COND (,DAM-MECH-TOOL-PROBED
                  <AREA-SET ,AREA-SLOT-DAM ,AREA-DAM-TOOLS>)>
           <COND (,DAM-MECH-GATES-CYCLED
                  <AREA-SET ,AREA-SLOT-DAM ,AREA-DAM-GATES>)>
           <COND (,DAM-MECH-LEAK-TRIGGERED
                  <AREA-SET ,AREA-SLOT-DAM ,AREA-DAM-LEAK>)>
           <COND (,DAM-MECH-LEAK-REPAIRED
                  <AREA-SET ,AREA-SLOT-DAM ,AREA-DAM-REPAIR>)>
           <COND (<OR <LOC ,ARCHIVE-DAM-PRINTOUT>
                      <LOC ,MAIL-DAM-NOTE>>
                  <AREA-SET ,AREA-SLOT-DAM ,AREA-DAM-DOCUMENT>)>
           <COND (<AND <AREA-HAS? ,AREA-SLOT-DAM ,AREA-DAM-PANEL>
                       <AREA-HAS? ,AREA-SLOT-DAM ,AREA-DAM-INTERLOCK>
                       <AREA-HAS? ,AREA-SLOT-DAM ,AREA-DAM-GATES>
                       <AREA-HAS? ,AREA-SLOT-DAM ,AREA-DAM-LEAK>
                       <AREA-HAS? ,AREA-SLOT-DAM ,AREA-DAM-REPAIR>>
                  <AREA-MARK-COMPLETE ,AREA-BIT-DAM>)>)>
    <RFALSE>>

<ROUTINE AREA-OBSERVE-HADES ()
    <COND (<OR <FSET? ,ENTRANCE-TO-HADES ,TOUCHBIT>
               <FSET? ,NORTH-TEMPLE ,TOUCHBIT>
               <FSET? ,SOUTH-TEMPLE ,TOUCHBIT>
               <FSET? ,GHOSTS ,TOUCHBIT>
               ,RITUAL-CEREMONY-KNOWN
               ,RITUAL-BELL-ANSWERED
               ,RITUAL-CANDLES-ANSWERED
               ,RITUAL-WRONG-ORDER-SEEN
               ,RITUAL-MIRROR-RESONANCE
               ,RITUAL-PRAYER-COMPLETED
               ,LLD-FLAG>
           <AREA-MATERIALIZE ,AREA-HADES-CASE ,AREA-BIT-HADES>
           <COND (<OR <FSET? ,ENTRANCE-TO-HADES ,TOUCHBIT>
                      <FSET? ,NORTH-TEMPLE ,TOUCHBIT>
                      <FSET? ,SOUTH-TEMPLE ,TOUCHBIT>>
                  <AREA-SET ,AREA-SLOT-HADES ,AREA-HADES-VISIT>)>
           <COND (<FSET? ,GHOSTS ,TOUCHBIT>
                  <AREA-SET ,AREA-SLOT-HADES ,AREA-HADES-SPIRITS>)>
           <COND (,RITUAL-CEREMONY-KNOWN
                  <AREA-SET ,AREA-SLOT-HADES ,AREA-HADES-BOOK>)>
           <COND (,RITUAL-BELL-ANSWERED
                  <AREA-SET ,AREA-SLOT-HADES ,AREA-HADES-BELL>)>
           <COND (,RITUAL-CANDLES-ANSWERED
                  <AREA-SET ,AREA-SLOT-HADES ,AREA-HADES-CANDLES>)>
           <COND (,RITUAL-WRONG-ORDER-SEEN
                  <AREA-SET ,AREA-SLOT-HADES ,AREA-HADES-WRONG>)>
           <COND (,RITUAL-MIRROR-RESONANCE
                  <AREA-SET ,AREA-SLOT-HADES ,AREA-HADES-MIRROR>)>
           <COND (<OR ,RITUAL-PRAYER-COMPLETED ,LLD-FLAG>
                  <AREA-SET ,AREA-SLOT-HADES ,AREA-HADES-OUTCOME>)>
           <COND (<AND <AREA-HAS? ,AREA-SLOT-HADES ,AREA-HADES-BOOK>
                       <AREA-HAS? ,AREA-SLOT-HADES ,AREA-HADES-BELL>
                       <AREA-HAS? ,AREA-SLOT-HADES ,AREA-HADES-CANDLES>
                       <AREA-HAS? ,AREA-SLOT-HADES ,AREA-HADES-WRONG>
                       <AREA-HAS? ,AREA-SLOT-HADES ,AREA-HADES-OUTCOME>>
                  <AREA-MARK-COMPLETE ,AREA-BIT-HADES>)>)>
    <RFALSE>>

<ROUTINE AREA-OBSERVE-HOUSE ()
    <HOUSE-STATE-REFRESH>
    <COND (<OR ,HOUSE-EVENT-ENTERED
               ,HOUSE-EVENT-ATTIC
               ,HOUSE-EVENT-CELLAR
               ,HOUSE-EVENT-RETURN
               ,HOUSE-EVENT-COLLECTION
               ,HOUSE-EVENT-DISTURBANCE
               <LOC ,ARCHIVE-THRESHOLD-FOLDER>
               <LOC ,ARCHIVE-DISPLAY-CARD>
               <LOC ,ARCHIVE-CHRONOLOGY-CASSETTE>>
           <AREA-MATERIALIZE ,AREA-HOUSE-CASE ,AREA-BIT-HOUSE>
           <COND (,HOUSE-EVENT-ENTERED
                  <AREA-SET ,AREA-SLOT-HOUSE ,AREA-HOUSE-USE>)>
           <COND (,HOUSE-EVENT-ATTIC
                  <AREA-SET ,AREA-SLOT-HOUSE ,AREA-HOUSE-ATTIC>)>
           <COND (,HOUSE-EVENT-CELLAR
                  <AREA-SET ,AREA-SLOT-HOUSE ,AREA-HOUSE-CELLAR>)>
           <COND (,HOUSE-EVENT-RETURN
                  <AREA-SET ,AREA-SLOT-HOUSE ,AREA-HOUSE-RETURN>)>
           <COND (,HOUSE-EVENT-COLLECTION
                  <AREA-SET ,AREA-SLOT-HOUSE ,AREA-HOUSE-COLLECTION>)>
           <COND (,HOUSE-EVENT-DISTURBANCE
                  <AREA-SET ,AREA-SLOT-HOUSE ,AREA-HOUSE-DISTURBANCE>)>
           <COND (<OR <LOC ,ARCHIVE-THRESHOLD-FOLDER>
                      <LOC ,ARCHIVE-DISPLAY-CARD>
                      <LOC ,ARCHIVE-CHRONOLOGY-CASSETTE>>
                  <AREA-SET ,AREA-SLOT-HOUSE ,AREA-HOUSE-DOCUMENT>)>
           <COND (<AND <AREA-HAS? ,AREA-SLOT-HOUSE ,AREA-HOUSE-USE>
                       <AREA-HAS? ,AREA-SLOT-HOUSE ,AREA-HOUSE-ATTIC>
                       <AREA-HAS? ,AREA-SLOT-HOUSE ,AREA-HOUSE-CELLAR>
                       <AREA-HAS? ,AREA-SLOT-HOUSE ,AREA-HOUSE-RETURN>
                       <AREA-HAS? ,AREA-SLOT-HOUSE ,AREA-HOUSE-COLLECTION>
                       <AREA-HAS? ,AREA-SLOT-HOUSE ,AREA-HOUSE-DISTURBANCE>>
                  <AREA-MARK-COMPLETE ,AREA-BIT-HOUSE>)>)>
    <RFALSE>>

<ROUTINE AREA-OBSERVE-FOREST ()
    <COND (<OR <FSET? ,FOREST-1 ,TOUCHBIT>
               <FSET? ,FOREST-2 ,TOUCHBIT>
               <FSET? ,FOREST-3 ,TOUCHBIT>
               <FSET? ,CLEARING ,TOUCHBIT>
               <FSET? ,SONGBIRD ,TOUCHBIT>>
           <AREA-MATERIALIZE ,AREA-FOREST-CASE ,AREA-BIT-FOREST>
           <COND (<FSET? ,FOREST-1 ,TOUCHBIT>
                  <AREA-SET ,AREA-SLOT-FOREST ,AREA-FOREST-ONE>)>
           <COND (<FSET? ,FOREST-2 ,TOUCHBIT>
                  <AREA-SET ,AREA-SLOT-FOREST ,AREA-FOREST-TWO>)>
           <COND (<FSET? ,FOREST-3 ,TOUCHBIT>
                  <AREA-SET ,AREA-SLOT-FOREST ,AREA-FOREST-THREE>)>
           <COND (<FSET? ,CLEARING ,TOUCHBIT>
                  <AREA-SET ,AREA-SLOT-FOREST ,AREA-FOREST-CLEARING>)>
           <COND (<FSET? ,SONGBIRD ,TOUCHBIT>
                  <AREA-SET ,AREA-SLOT-FOREST ,AREA-FOREST-SONGBIRD>)>
           <COND (<AND <AREA-HAS? ,AREA-SLOT-FOREST ,AREA-FOREST-ONE>
                       <AREA-HAS? ,AREA-SLOT-FOREST ,AREA-FOREST-TWO>
                       <AREA-HAS? ,AREA-SLOT-FOREST ,AREA-FOREST-THREE>
                       <AREA-HAS? ,AREA-SLOT-FOREST ,AREA-FOREST-CLEARING>>
                  <AREA-MARK-COMPLETE ,AREA-BIT-FOREST>)>)>
    <RFALSE>>

<ROUTINE AREA-OBSERVE-UNDERGROUND ()
    <COND (<OR ,HOUSE-EVENT-CELLAR
               <NOT <0? <BAND <NPC-GET ,NS-SEEN> 7>>>
               <AREA-HAS? ,AREA-SLOT-SEEN ,AREA-BIT-DAM>
               <AREA-HAS? ,AREA-SLOT-SEEN ,AREA-BIT-HADES>
               ,HOUSE-EVENT-RETURN>
           <AREA-MATERIALIZE ,AREA-UNDERGROUND-CASE ,AREA-BIT-UNDERGROUND>
           <COND (,HOUSE-EVENT-CELLAR
                  <AREA-SET ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-CELLAR>)>
           <COND (<NPC-HAS? ,NS-SEEN ,NPC-BIT-TROLL>
                  <AREA-SET ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-TROLL>)>
           <COND (<NPC-HAS? ,NS-SEEN ,NPC-BIT-CYCLOPS>
                  <AREA-SET ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-CYCLOPS>)>
           <COND (<NPC-HAS? ,NS-SEEN ,NPC-BIT-THIEF>
                  <AREA-SET ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-THIEF>)>
           <COND (<AREA-HAS? ,AREA-SLOT-COMPLETE ,AREA-BIT-DAM>
                  <AREA-SET ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-DAM>)>
           <COND (<AREA-HAS? ,AREA-SLOT-COMPLETE ,AREA-BIT-HADES>
                  <AREA-SET ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-HADES>)>
           <COND (,HOUSE-EVENT-RETURN
                  <AREA-SET ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-RETURN>)>
           <COND (<AND <AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-CELLAR>
                       <AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-TROLL>
                       <AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-CYCLOPS>
                       <AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-THIEF>
                       <AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-DAM>
                       <AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-HADES>
                       <AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-RETURN>>
                  <AREA-MARK-COMPLETE ,AREA-BIT-UNDERGROUND>)>)>
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

<ROUTINE AREA-PRINT-STATUS (BIT)
    <COND (<AREA-HAS? ,AREA-SLOT-COMPLETE .BIT>
           <TELL "COMPLETE">)
          (T
           <TELL "INCOMPLETE; unresolved sections remain redacted">)>
    <RTRUE>>

<ROUTINE AREA-READ-DAM ()
    <TELL "AREA-DAM-03. Flood Control Dam #3 regional case file." CR>
    <TELL "Status: "><AREA-PRINT-STATUS ,AREA-BIT-DAM><TELL "." CR>
    <COND (<AREA-HAS? ,AREA-SLOT-DAM ,AREA-DAM-VISIT>
           <TELL "- Place evidence: the Dam or maintenance works were directly visited." CR>)
          (T <TELL "- Place evidence: [REDACTED - no verified visit]." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-DAM ,AREA-DAM-PANEL>
           <TELL "- Panel evidence: a diagnostic response was directly observed." CR>)
          (T <TELL "- Panel evidence: [REDACTED - no verified panel diagnosis]." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-DAM ,AREA-DAM-INTERLOCK>
           <TELL "- Interlock evidence: its refusal state was directly observed." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-DAM ,AREA-DAM-BOLT>
           <TELL "- Bolt evidence: a real bolt interaction was attempted and retained." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-DAM ,AREA-DAM-TOOLS>
           <TELL "- Tool evidence: one or more real tool responses were directly observed." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-DAM ,AREA-DAM-GATES>
           <TELL "- Gate outcome: the canonical gates were actually cycled." CR>)
          (T <TELL "- Gate outcome: unresolved; no operating step is inferred." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-DAM ,AREA-DAM-LEAK>
           <TELL "- Leak outcome: the maintenance leak was actually triggered." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-DAM ,AREA-DAM-REPAIR>
           <TELL "- Repair outcome: the leak was actually repaired." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-DAM ,AREA-DAM-DOCUMENT>
           <TELL "- Documents: exact maintenance correspondence or printout is cross-indexed where physically present." CR>)
          (T <TELL "- Documents: missing; the archive creates no replacement paperwork." CR>)>
    <RTRUE>>

<ROUTINE AREA-READ-HADES ()
    <TELL "AREA-HADES-04. Hades ceremony regional case file." CR>
    <TELL "Status: "><AREA-PRINT-STATUS ,AREA-BIT-HADES><TELL "." CR>
    <COND (<AREA-HAS? ,AREA-SLOT-HADES ,AREA-HADES-VISIT>
           <TELL "- Place evidence: one or more Hades or temple locations were directly visited." CR>)
          (T <TELL "- Place evidence: [REDACTED - no verified visit]." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HADES ,AREA-HADES-SPIRITS>
           <TELL "- Actor evidence: the spirits themselves were directly encountered." CR>)
          (T <TELL "- Actor evidence: missing; a room visit is not promoted into a spirit encounter." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HADES ,AREA-HADES-BOOK>
           <TELL "- Document evidence: the damaged-book ceremony record was established." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HADES ,AREA-HADES-BELL>
           <TELL "- Bell evidence: the answering resonance stage was directly observed." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HADES ,AREA-HADES-CANDLES>
           <TELL "- Paired-light evidence: the answering candle stage was directly observed." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HADES ,AREA-HADES-WRONG>
           <TELL "- Variation evidence: a wrong-order consequence was actually seen." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HADES ,AREA-HADES-MIRROR>
           <TELL "- Mirror evidence: a mirror-resonance variation was actually seen." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HADES ,AREA-HADES-OUTCOME>
           <TELL "- Outcome: the canonical spirit-removal state was directly verified." CR>)
          (T <TELL "- Outcome: unresolved; the file predicts nothing." CR>)>
    <RTRUE>>

<ROUTINE AREA-READ-HOUSE ()
    <TELL "AREA-HOUSE-01. White house regional case file." CR>
    <TELL "Status: "><AREA-PRINT-STATUS ,AREA-BIT-HOUSE><TELL "." CR>
    <COND (<AREA-HAS? ,AREA-SLOT-HOUSE ,AREA-HOUSE-USE>
           <TELL "- Use evidence: the white house began functioning as a returned-to place." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HOUSE ,AREA-HOUSE-ATTIC>
           <TELL "- Attic evidence: the canonical Attic was directly visited." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HOUSE ,AREA-HOUSE-CELLAR>
           <TELL "- Threshold evidence: the canonical Cellar threshold was crossed." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HOUSE ,AREA-HOUSE-RETURN>
           <TELL "- Expedition evidence: a return from below to the house was completed." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HOUSE ,AREA-HOUSE-COLLECTION>
           <TELL "- Collection evidence: real trophy-case value changed while canonical scoring remained authoritative." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HOUSE ,AREA-HOUSE-DISTURBANCE>
           <TELL "- Condition evidence: real house disturbance was retained." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-HOUSE ,AREA-HOUSE-DOCUMENT>
           <TELL "- Documentary evidence: exact house folders, display cards, or chronology media are linked where physically present." CR>)
          (T <TELL "- Documentary series: incomplete; no missing record is fabricated." CR>)>
    <RTRUE>>

<ROUTINE AREA-READ-FOREST ()
    <TELL "AREA-FOREST-02. Forest exploration regional case file." CR>
    <TELL "Status: "><AREA-PRINT-STATUS ,AREA-BIT-FOREST><TELL "." CR>
    <COND (<AREA-HAS? ,AREA-SLOT-FOREST ,AREA-FOREST-ONE>
           <TELL "- Coverage: Forest sector one was directly visited." CR>)
          (T <TELL "- Forest sector one: [REDACTED - unvisited]." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-FOREST ,AREA-FOREST-TWO>
           <TELL "- Coverage: Forest sector two was directly visited." CR>)
          (T <TELL "- Forest sector two: [REDACTED - unvisited]." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-FOREST ,AREA-FOREST-THREE>
           <TELL "- Coverage: Forest sector three was directly visited." CR>)
          (T <TELL "- Forest sector three: [REDACTED - unvisited]." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-FOREST ,AREA-FOREST-CLEARING>
           <TELL "- Coverage: the marked clearing was directly visited." CR>)
          (T <TELL "- Clearing: [REDACTED - unvisited]." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-FOREST ,AREA-FOREST-SONGBIRD>
           <TELL "- Living evidence: a direct songbird interaction is retained." CR>)
          (T <TELL "- Living evidence: missing or unobserved." CR>)>
    <RTRUE>>

<ROUTINE AREA-READ-UNDERGROUND ()
    <TELL "AREA-UNDERGROUND-05. Underground expedition regional case file." CR>
    <TELL "Status: "><AREA-PRINT-STATUS ,AREA-BIT-UNDERGROUND><TELL "." CR>
    <COND (<AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-CELLAR>
           <TELL "- Threshold evidence: the Cellar-to-underground boundary was directly crossed." CR>)
          (T <TELL "- Threshold evidence: missing; no underground completion is inferred." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-TROLL>
           <TELL "- Actor link: player-specific troll evidence is present." CR>)
          (T <TELL "- Troll evidence: missing." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-CYCLOPS>
           <TELL "- Actor link: player-specific cyclops evidence is present." CR>)
          (T <TELL "- Cyclops evidence: missing." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-THIEF>
           <TELL "- Actor link: player-specific thief evidence is present." CR>)
          (T <TELL "- Thief evidence: missing." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-DAM>
           <TELL "- Regional link: the Dam case is complete." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-HADES>
           <TELL "- Regional link: the Hades case is complete." CR>)>
    <COND (<AREA-HAS? ,AREA-SLOT-UNDERGROUND ,AREA-UNDER-RETURN>
           <TELL "- Return evidence: the expedition cycle returned to the house." CR>)>
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
           <TELL "Cross-reference: individually visited forest sectors and clearing only; no hidden route or undiscovered map is supplied." CR>)
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
           <TELL "- Regional files retained itemized discoveries, mechanisms, outcomes, documents, actors, and unresolved variations from earned evidence." CR>)>
    <COND (<AREA-GET ,AREA-SLOT-EVENT-PARTIAL>
           <SET SEEN T>
           <TELL "- Incomplete case files retained missing and redacted sections without exposing undiscovered solutions." CR>)>
    <COND (<AREA-GET ,AREA-SLOT-EVENT-SYNTHESIS>
           <SET SEEN T>
           <TELL "- Complete regional synthesis unlocked only after all five case contracts were satisfied and remained retrospective and score-neutral." CR>)>
    <COND (<AREA-GET ,AREA-SLOT-EVENT-CROSS>
           <SET SEEN T>
           <TELL "- Cross-references linked only exact physical records and player-specific evidence already present in this expedition." CR>)>
    <COND (.SEEN <RTRUE>)>
    <RFALSE>>
