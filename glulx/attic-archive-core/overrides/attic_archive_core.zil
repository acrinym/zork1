"Period-authentic Attic archive substrate for the repository-local Zork I Glulx lineage."

;"Release 1224 turns the canonical Attic into a bounded physical archive of
  records already earned by this run. It consumes stable filing codes and
  observed state, never moves live correspondence, reveals unseen solutions,
  or creates a modern filesystem."

<SYNTAX FILE OBJECT = V-ARCHIVE-FILE>
<SYNTAX REVIEW OBJECT = V-ARCHIVE-REVIEW>
<SYNTAX SHOW OBJECT = V-ARCHIVE-SHOW>
<SYNTAX CROSS-REFERENCE OBJECT = V-ARCHIVE-CROSS>
<SYNTAX CROSSREF OBJECT = V-ARCHIVE-CROSS>

<CONSTANT ARCHIVE-SCHEMA 1>

<CONSTANT AS-VERSION 0>
<CONSTANT AS-INDEXED 1>
<CONSTANT AS-FILED 2>
<CONSTANT AS-ANNOTATED 3>
<CONSTANT AS-EVENT-SCHEMA 4>
<CONSTANT AS-EVENT-MEDIA 5>
<CONSTANT AS-EVENT-CATALOG 6>
<CONSTANT AS-EVENT-FILING 7>
<CONSTANT AS-EVENT-RETRIEVAL 8>
<CONSTANT AS-EVENT-PROVENANCE 9>
<CONSTANT AS-EVENT-MIGRATION 10>
<CONSTANT AS-LAST-RECORD 11>

<CONSTANT ARCHIVE-BIT-THRESHOLD 1>
<CONSTANT ARCHIVE-BIT-DISPLAY 2>
<CONSTANT ARCHIVE-BIT-DAM 4>
<CONSTANT ARCHIVE-BIT-VISITOR 8>
<CONSTANT ARCHIVE-BIT-CHRONOLOGY 16>

<CONSTANT ARCHIVE-STATE <TABLE 0 0 0 0 <> <> <> <> <> <> <> 0>>

<ROUTINE ARCHIVE-GET (SLOT)
    <GET ,ARCHIVE-STATE .SLOT>>

<ROUTINE ARCHIVE-PUT (SLOT VALUE)
    <PUT ,ARCHIVE-STATE .SLOT .VALUE>>

<ROUTINE ARCHIVE-HAS-BIT? (SLOT BIT)
    <COND (<NOT <0? <BAND <ARCHIVE-GET .SLOT> .BIT>>> <RTRUE>)>
    <RFALSE>>

<ROUTINE ARCHIVE-SET-BIT (SLOT BIT)
    <ARCHIVE-PUT .SLOT <BOR <ARCHIVE-GET .SLOT> .BIT>>
    <RTRUE>>

<OBJECT ARCHIVE-CATALOG
    (IN ATTIC)
    (SYNONYM CATALOG INDEX CARDS DRAWERS)
    (ADJECTIVE CARD OAK WOODEN)
    (DESC "oak card catalog")
    (LDESC "An oak card catalog stands beneath the rafters, its brass labels arranged by person, place, object, incident, chronology, and expedition.")
    (FLAGS TRYTAKEBIT CONTBIT OPENBIT SEARCHBIT)
    (CAPACITY 20)
    (ACTION ARCHIVE-CATALOG-FCN)>

<OBJECT ARCHIVE-CABINET
    (IN ATTIC)
    (SYNONYM CABINET DRAWER FILE FILES)
    (ADJECTIVE STEEL FILING GRAY)
    (DESC "gray steel filing cabinet")
    (LDESC "A gray steel filing cabinet occupies the driest wall of the Attic.")
    (FLAGS TRYTAKEBIT CONTBIT OPENBIT SEARCHBIT)
    (CAPACITY 60)
    (ACTION ARCHIVE-SURFACE-FCN)>

<OBJECT ARCHIVE-BANKER-BOX
    (IN ATTIC)
    (SYNONYM BOX CARTON ARCHIVE)
    (ADJECTIVE BANKER EXPEDITION CARDBOARD)
    (DESC "banker box")
    (LDESC "A labeled banker box waits for records belonging to a separate expedition history.")
    (FLAGS TRYTAKEBIT CONTBIT OPENBIT SEARCHBIT)
    (CAPACITY 30)
    (ACTION ARCHIVE-SURFACE-FCN)>

<OBJECT ARCHIVE-TERMINAL
    (IN ATTIC)
    (SYNONYM TERMINAL CONSOLE KEYBOARD SCREEN)
    (ADJECTIVE GREEN PHOSPHOR INDEX)
    (DESC "green-phosphor index terminal")
    (LDESC "A green-phosphor terminal can locate physical records but stores none of them.")
    (FLAGS TRYTAKEBIT)
    (ACTION ARCHIVE-TERMINAL-FCN)>

<OBJECT ARCHIVE-RECORDER
    (IN ATTIC)
    (SYNONYM RECORDER PLAYER DECK MACHINE)
    (ADJECTIVE CASSETTE TAPE PORTABLE)
    (DESC "portable cassette recorder")
    (LDESC "A portable cassette recorder rests beside the catalog for bounded textual playback.")
    (FLAGS TRYTAKEBIT)
    (ACTION ARCHIVE-SURFACE-FCN)>

<OBJECT ARCHIVE-PROJECTOR
    (IN ATTIC)
    (SYNONYM PROJECTOR VIEWER MACHINE)
    (ADJECTIVE FILM SLIDE MICROFICHE)
    (DESC "film and microfiche viewer")
    (LDESC "A compact viewer handles film, slides, and microfiche without altering the events they depict.")
    (FLAGS TRYTAKEBIT)
    (ACTION ARCHIVE-SURFACE-FCN)>

<OBJECT ARCHIVE-CORKBOARD
    (IN ATTIC)
    (SYNONYM BOARD MAP MAPS CORKBOARD)
    (ADJECTIVE CORK CROSS REFERENCE)
    (DESC "cross-reference corkboard")
    (LDESC "A corkboard holds maps and cross-reference strings between physical filing codes.")
    (FLAGS TRYTAKEBIT)
    (ACTION ARCHIVE-SURFACE-FCN)>

<OBJECT ARCHIVE-THRESHOLD-FOLDER
    (SYNONYM FOLDER FILE RECORD DOSSIER)
    (ADJECTIVE THRESHOLD HOUSE GRAY)
    (DESC "HOUSE-THRESHOLD-01 folder")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 2)
    (ACTION ARCHIVE-RECORD-FCN)>

<OBJECT ARCHIVE-DISPLAY-CARD
    (SYNONYM CARD RECORD INDEX APPRAISAL)
    (ADJECTIVE DISPLAY HOUSE CREAM)
    (DESC "HOUSE-DISPLAY-02 index card")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 1)
    (ACTION ARCHIVE-RECORD-FCN)>

<OBJECT ARCHIVE-DAM-PRINTOUT
    (SYNONYM PRINTOUT PAPER RECORD FILE)
    (ADJECTIVE DAM FCD3 CONTINUOUS MAINTENANCE)
    (DESC "FCD3-MAINT-03 printout")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 2)
    (ACTION ARCHIVE-RECORD-FCN)>

<OBJECT ARCHIVE-VISITOR-FICHE
    (SYNONYM FICHE MICROFICHE RECORD VISITS)
    (ADJECTIVE VISITOR COURIER SURVEY)
    (DESC "visitor microfiche jacket")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 1)
    (ACTION ARCHIVE-RECORD-FCN)>

<OBJECT ARCHIVE-CHRONOLOGY-CASSETTE
    (SYNONYM CASSETTE TAPE RECORD CHRONOLOGY)
    (ADJECTIVE HOUSE EXPEDITION CHRONOLOGY)
    (DESC "house chronology cassette")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 2)
    (ACTION ARCHIVE-RECORD-FCN)>

<ROUTINE ARCHIVE-RECORD-BIT (OBJ)
    <COND (<EQUAL? .OBJ ,ARCHIVE-THRESHOLD-FOLDER> <RETURN ,ARCHIVE-BIT-THRESHOLD>)
          (<EQUAL? .OBJ ,ARCHIVE-DISPLAY-CARD> <RETURN ,ARCHIVE-BIT-DISPLAY>)
          (<EQUAL? .OBJ ,ARCHIVE-DAM-PRINTOUT> <RETURN ,ARCHIVE-BIT-DAM>)
          (<EQUAL? .OBJ ,ARCHIVE-VISITOR-FICHE> <RETURN ,ARCHIVE-BIT-VISITOR>)
          (<EQUAL? .OBJ ,ARCHIVE-CHRONOLOGY-CASSETTE> <RETURN ,ARCHIVE-BIT-CHRONOLOGY>)>
    <RETURN 0>>

<ROUTINE ARCHIVE-IS-RECORD? (OBJ)
    <COND (<NOT <0? <ARCHIVE-RECORD-BIT .OBJ>>> <RTRUE>)>
    <RFALSE>>

<ROUTINE ARCHIVE-REGISTER (OBJ BIT)
    <COND (<NOT <LOC .OBJ>> <MOVE .OBJ ,ARCHIVE-CABINET>)>
    <ARCHIVE-SET-BIT ,AS-INDEXED .BIT>
    <ARCHIVE-PUT ,AS-LAST-RECORD .BIT>
    <ARCHIVE-PUT ,AS-EVENT-SCHEMA T>
    <ARCHIVE-PUT ,AS-EVENT-CATALOG T>
    <RTRUE>>

<ROUTINE ARCHIVE-SYNC ("AUX" ANY)
    <MAIL-ENSURE>
    <COND (<OR <MAIL-HAS-BIT? ,MS-DELIVERED ,MAIL-BIT-CELLAR>
               <LOC ,MAIL-CELLAR-NOTE>>
           <ARCHIVE-REGISTER ,ARCHIVE-THRESHOLD-FOLDER ,ARCHIVE-BIT-THRESHOLD>
           <SET ANY T>)>
    <COND (<OR <MAIL-HAS-BIT? ,MS-DELIVERED ,MAIL-BIT-MUSEUM>
               <LOC ,MAIL-MUSEUM-NOTE>>
           <ARCHIVE-REGISTER ,ARCHIVE-DISPLAY-CARD ,ARCHIVE-BIT-DISPLAY>
           <SET ANY T>)>
    <COND (<OR <MAIL-HAS-BIT? ,MS-DELIVERED ,MAIL-BIT-DAM>
               <LOC ,MAIL-DAM-NOTE>>
           <ARCHIVE-REGISTER ,ARCHIVE-DAM-PRINTOUT ,ARCHIVE-BIT-DAM>
           <SET ANY T>)>
    <COND (<OR <LOC ,MAIL-COURIER-NOTICE>
               <LOC ,MAIL-SURVEYOR-NOTICE>
               <LOC ,MAIL-RETURN-RECEIPT>
               <LOC ,MAIL-SURVEY-TAG>>
           <ARCHIVE-REGISTER ,ARCHIVE-VISITOR-FICHE ,ARCHIVE-BIT-VISITOR>
           <SET ANY T>)>
    <COND (.ANY
           <ARCHIVE-REGISTER ,ARCHIVE-CHRONOLOGY-CASSETTE ,ARCHIVE-BIT-CHRONOLOGY>
           <ARCHIVE-PUT ,AS-EVENT-MEDIA T>)>
    <RFALSE>>

<ROUTINE ARCHIVE-STATUS (OBJ "AUX" BIT)
    <SET BIT <ARCHIVE-RECORD-BIT .OBJ>>
    <COND (<0? .BIT>
           <TELL "No canonical archive record is attached to that object." CR>)
          (T
           <TELL "Index status: registered. Physical custody: ">
           <COND (<IN? .OBJ ,ARCHIVE-CABINET> <TELL "steel filing cabinet">)
                 (<IN? .OBJ ,ARCHIVE-BANKER-BOX> <TELL "separate expedition box">)
                 (<IN? .OBJ ,WINNER> <TELL "carried by you">)
                 (T <TELL "elsewhere in the real object tree">)>
           <TELL ". Truth status: ">
           <COND (<EQUAL? .OBJ ,ARCHIVE-DISPLAY-CARD>
                  <TELL "plausible but unsigned; contradiction flag retained">)
                 (<EQUAL? .OBJ ,ARCHIVE-VISITOR-FICHE>
                  <TELL "mixed primary notices and verified signed or numbered evidence">)
                 (T <TELL "verified against an exact physical source record">)>
           <TELL "." CR>
           <ARCHIVE-PUT ,AS-EVENT-PROVENANCE T>)>
    <RTRUE>>

<ROUTINE ARCHIVE-READ-RECORD (OBJ)
    <COND (<EQUAL? .OBJ ,ARCHIVE-THRESHOLD-FOLDER>
           <TELL "HOUSE-THRESHOLD-01. Person/place: house occupant and Cellar threshold. Incident: physical intrusion evidence. Source: signed gray warning delivered through the canonical mailbox. Confidence: verified source, bounded interpretation. No unseen route or remedy is disclosed." CR>)
          (<EQUAL? .OBJ ,ARCHIVE-DISPLAY-CARD>
           <TELL "HOUSE-DISPLAY-02. Object/place: museum display and unsecured theft. Source: cream appraisal warning. Confidence: plausible but unsigned. Annotation: the archive distinguishes the warning from live custody and never restores missing property." CR>)
          (<EQUAL? .OBJ ,ARCHIVE-DAM-PRINTOUT>
           <TELL "FCD3-MAINT-03. Place/incident: Flood Control Dam #3 after meaningful repair. Source: official blue maintenance acknowledgment. Confidence: verified document. Annotation: it grants no score and reveals no unearned mechanism state." CR>)
          (<EQUAL? .OBJ ,ARCHIVE-VISITOR-FICHE>
           <TELL "VISIT series. People: courier and threshold surveyor. Media: notices, signed receipt, and numbered field tag. Truth status varies by exact source; missing items remain explicitly missing rather than synthesized." CR>)
          (T
           <TELL "HOUSE-CHRONOLOGY. A curated cassette index names only correspondence and visits already recorded in this run. It is not a raw session log and cannot change the present." CR>)>
    <ARCHIVE-PUT ,AS-EVENT-RETRIEVAL T>
    <ARCHIVE-PUT ,AS-LAST-RECORD <ARCHIVE-RECORD-BIT .OBJ>>
    <RTRUE>>

<ROUTINE ARCHIVE-CROSS-RECORD (OBJ)
    <COND (<EQUAL? .OBJ ,ARCHIVE-THRESHOLD-FOLDER>
           <TELL "Cross-reference: VISIT-SURVEY-01 and VISIT-SURVEY-TAG when those exact records exist." CR>)
          (<EQUAL? .OBJ ,ARCHIVE-DISPLAY-CARD>
           <TELL "Cross-reference: the Living Room display provenance and any exact theft evidence already earned by this run." CR>)
          (<EQUAL? .OBJ ,ARCHIVE-DAM-PRINTOUT>
           <TELL "Cross-reference: FCD3 repair state and the house chronology cassette. No unobserved dam solution is printed." CR>)
          (<EQUAL? .OBJ ,ARCHIVE-VISITOR-FICHE>
           <TELL "Cross-reference: HOUSE-THRESHOLD-01, posted reply status, missed notices, signed receipt, and numbered survey tag, each only when physically present." CR>)
          (T
           <TELL "Cross-reference: the currently registered filing codes in deterministic event order, never a raw transcript." CR>)>
    <ARCHIVE-PUT ,AS-ANNOTATED T>
    <ARCHIVE-PUT ,AS-EVENT-PROVENANCE T>
    <RTRUE>>

<ROUTINE ARCHIVE-RECORD-FCN ()
    <COND (<VERB? READ EXAMINE REVIEW SHOW>
           <ARCHIVE-READ-RECORD ,PRSO>
           <ARCHIVE-STATUS ,PRSO>)
          (<VERB? FIND>
           <ARCHIVE-STATUS ,PRSO>)
          (<VERB? PLAY>
           <COND (<EQUAL? ,PRSO ,ARCHIVE-CHRONOLOGY-CASSETTE>
                  <TELL "The recorder clicks. Tape hiss. A measured voice reads the filing codes already present, pauses where evidence is missing, and stops without changing any live object, actor, timer, score, pronoun, or location." CR>
                  <ARCHIVE-PUT ,AS-EVENT-RETRIEVAL T>)
                 (T <TELL "That physical record is read or viewed, not played." CR>)>)>
    <RTRUE>>

<ROUTINE ARCHIVE-CATALOG-LIST ()
    <ARCHIVE-SYNC>
    <TELL "The deterministic card catalog contains:">
    <COND (<0? <ARCHIVE-GET ,AS-INDEXED>>
           <TELL " no earned archive cards yet." CR>)
          (T
           <CRLF>
           <COND (<ARCHIVE-HAS-BIT? ,AS-INDEXED ,ARCHIVE-BIT-THRESHOLD>
                  <TELL "- HOUSE-THRESHOLD-01: place / incident / chronology." CR>)>
           <COND (<ARCHIVE-HAS-BIT? ,AS-INDEXED ,ARCHIVE-BIT-DISPLAY>
                  <TELL "- HOUSE-DISPLAY-02: object / incident / provenance." CR>)>
           <COND (<ARCHIVE-HAS-BIT? ,AS-INDEXED ,ARCHIVE-BIT-DAM>
                  <TELL "- FCD3-MAINT-03: place / mechanism outcome / chronology." CR>)>
           <COND (<ARCHIVE-HAS-BIT? ,AS-INDEXED ,ARCHIVE-BIT-VISITOR>
                  <TELL "- VISIT series: person / message / incident." CR>)>
           <COND (<ARCHIVE-HAS-BIT? ,AS-INDEXED ,ARCHIVE-BIT-CHRONOLOGY>
                  <TELL "- HOUSE-CHRONOLOGY: expedition / chronology / cassette." CR>)>)>
    <ARCHIVE-PUT ,AS-EVENT-CATALOG T>
    <RTRUE>>

<ROUTINE ARCHIVE-CATALOG-FCN ()
    <COND (<VERB? EXAMINE READ SEARCH LOOK-INSIDE>
           <ARCHIVE-CATALOG-LIST>)
          (<VERB? TAKE>
           <TELL "The oak catalog is part of the Attic. Individual physical records may be taken and filed." CR>)>
    <RTRUE>>

<ROUTINE ARCHIVE-SURFACE-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "It is a bounded late-1970s archive surface. Capacity is physical, records remain exact objects, and separate expedition histories are not merged." CR>
           <ARCHIVE-PUT ,AS-EVENT-MEDIA T>)
          (<VERB? TAKE>
           <TELL "It is fixed in the Attic; use the physical records it contains." CR>)
          (<VERB? PLAY>
           <TELL "The machine requires a registered physical cassette or film record; it cannot replay the live world." CR>)>
    <RTRUE>>

<ROUTINE ARCHIVE-TERMINAL-FCN ()
    <COND (<VERB? EXAMINE READ SEARCH LOOK-INSIDE>
           <TELL "The terminal is only an index. It locates physical filing codes by person, place, object, incident, chronology, or expedition and stores no record itself." CR>
           <ARCHIVE-CATALOG-LIST>)
          (<VERB? TAKE>
           <TELL "The terminal is wired into the Attic wall." CR>)>
    <RTRUE>>

<ROUTINE V-ARCHIVE-FILE ()
    <COND (<NOT <EQUAL? ,HERE ,ATTIC>>
           <TELL "Physical archive filing is available only in the canonical Attic." CR>)
          (<NOT <ARCHIVE-IS-RECORD? ,PRSO>>
           <TELL "That is not one of the bounded archive records." CR>)
          (<NOT <IN? ,PRSO ,WINNER>>
           <TELL "You must be holding the exact physical record before filing it." CR>)
          (T
           <MOVE ,PRSO ,ARCHIVE-CABINET>
           <ARCHIVE-SET-BIT ,AS-FILED <ARCHIVE-RECORD-BIT ,PRSO>>
           <ARCHIVE-PUT ,AS-EVENT-FILING T>
           <TELL "You file the exact physical record in the steel cabinet. The catalog points to its custody; no copy is created." CR>)>
    <RTRUE>>

<ROUTINE V-ARCHIVE-REVIEW ()
    <COND (<ARCHIVE-IS-RECORD? ,PRSO>
           <ARCHIVE-READ-RECORD ,PRSO>
           <ARCHIVE-STATUS ,PRSO>)
          (T <TELL "The archive can review only an earned physical record." CR>)>
    <RTRUE>>

<ROUTINE V-ARCHIVE-SHOW ()
    <V-ARCHIVE-REVIEW>>

<ROUTINE V-ARCHIVE-CROSS ()
    <COND (<ARCHIVE-IS-RECORD? ,PRSO>
           <ARCHIVE-CROSS-RECORD ,PRSO>)
          (T <TELL "No bounded archive cross-reference exists for that object." CR>)>
    <RTRUE>>

<ROUTINE ARCHIVE-ACTION-HOOK ()
    <RFALSE>>

<ROUTINE ARCHIVE-ADVANCE ()
    <COND (<SHADOW-NON-TURN-COMMAND?> <RFALSE>)>
    <ARCHIVE-ENSURE>
    <ARCHIVE-SYNC>
    <RFALSE>>

<ROUTINE ARCHIVE-ENSURE ()
    <COND (<NOT <EQUAL? <ARCHIVE-GET ,AS-VERSION> ,ARCHIVE-SCHEMA>>
           <ARCHIVE-PUT ,AS-VERSION ,ARCHIVE-SCHEMA>
           <ARCHIVE-PUT ,AS-EVENT-MIGRATION T>
           <COND (<LOC ,ARCHIVE-THRESHOLD-FOLDER>
                  <ARCHIVE-SET-BIT ,AS-INDEXED ,ARCHIVE-BIT-THRESHOLD>)>
           <COND (<LOC ,ARCHIVE-DISPLAY-CARD>
                  <ARCHIVE-SET-BIT ,AS-INDEXED ,ARCHIVE-BIT-DISPLAY>)>
           <COND (<LOC ,ARCHIVE-DAM-PRINTOUT>
                  <ARCHIVE-SET-BIT ,AS-INDEXED ,ARCHIVE-BIT-DAM>)>
           <COND (<LOC ,ARCHIVE-VISITOR-FICHE>
                  <ARCHIVE-SET-BIT ,AS-INDEXED ,ARCHIVE-BIT-VISITOR>)>
           <COND (<LOC ,ARCHIVE-CHRONOLOGY-CASSETTE>
                  <ARCHIVE-SET-BIT ,AS-INDEXED ,ARCHIVE-BIT-CHRONOLOGY>)>)>
    <RFALSE>>

<ROUTINE ARCHIVE-RECAP ("AUX" (SEEN <>))
    <COND (<ARCHIVE-GET ,AS-EVENT-SCHEMA>
           <SET SEEN T>
           <TELL "- The Attic registered bounded people, places, objects, messages, incidents, chronology, outcomes, and links as exact physical records." CR>)>
    <COND (<ARCHIVE-GET ,AS-EVENT-MEDIA>
           <SET SEEN T>
           <TELL "- Late-1970s folders, cards, printouts, microfiche, cassette, cabinets, boxes, viewer, recorder, and terminal remained physical media rather than a modern filesystem." CR>)>
    <COND (<ARCHIVE-GET ,AS-EVENT-CATALOG>
           <SET SEEN T>
           <TELL "- The card catalog indexed only earned records by person, place, object, incident, chronology, and expedition." CR>)>
    <COND (<ARCHIVE-GET ,AS-EVENT-FILING>
           <SET SEEN T>
           <TELL "- Filing moved one exact record through the canonical object tree without cloning it." CR>)>
    <COND (<ARCHIVE-GET ,AS-EVENT-RETRIEVAL>
           <SET SEEN T>
           <TELL "- Reading, finding, reviewing, showing, cross-referencing, and bounded playback retrieved records without mutating live state." CR>)>
    <COND (<ARCHIVE-GET ,AS-EVENT-PROVENANCE>
           <SET SEEN T>
           <TELL "- Provenance retained source, confidence, contradiction, verification, redaction, and missing-evidence status without solution leakage." CR>)>
    <COND (<ARCHIVE-GET ,AS-EVENT-MIGRATION>
           <SET SEEN T>
           <TELL "- Versioned archive state rebuilt conservative indices from exact object custody and remained native-save persistent." CR>)>
    <COND (.SEEN <RTRUE>)>
    <RFALSE>>