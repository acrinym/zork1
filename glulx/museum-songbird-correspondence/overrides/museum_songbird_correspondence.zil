"MUSEUM SONGBIRD CORRESPONDENCE for Release 1240"

;"One authored natural-history expedition extends the canonical clockwork
  canary event. The real brass bauble remains canonical. One physical
  songbird feather falls beside it and may be displayed in the Living Room
  museum or deliberately returned to Zork's real bird's nest."

<OBJECT MUSEUM-FOREST-GALLERY-OBJECT
    (IN GLOBAL-OBJECTS)
    (SYNONYM FOREST SURFACE SONGBIRD BIRD LIFE)
    (ADJECTIVE MUSEUM NATURAL FIELD)
    (DESC "Forest and Surface Life gallery")
    (FLAGS NDESCBIT RMUNGBIT)>

<OBJECT MUSEUM-FOREST-CASE
    (IN LIVING-ROOM)
    (SYNONYM CASE DISPLAY TRAY CABINET)
    (ADJECTIVE FOREST SURFACE LIFE FEATHER MUSEUM)
    (DESC "Forest and Surface Life case")
    (LDESC "A low glass case marked FOREST AND SURFACE LIFE stands beside the flowing Waters display.")
    (FLAGS CONTBIT OPENBIT SEARCHBIT SURFACEBIT TRYTAKEBIT)
    (CAPACITY 20)
    (ACTION MUSEUM-FOREST-CASE-FCN)>

<OBJECT SONGBIRD-PLAQUE
    (IN LIVING-ROOM)
    (SYNONYM PLAQUE LABEL CARD RECORD)
    (ADJECTIVE SONGBIRD FOREST CORRESPONDENCE BRASS)
    (DESC "songbird correspondence plaque")
    (FLAGS NDESCBIT READBIT)
    (ACTION SONGBIRD-PLAQUE-FCN)>

<OBJECT SONGBIRD-FEATHER
    (SYNONYM FEATHER PLUME SPECIMEN TRACE)
    (ADJECTIVE SONGBIRD FLIGHT BLUE-BLACK IRIDESCENT)
    (DESC "blue-black songbird feather")
    (LDESC "A single blue-black flight feather lies here, green at one edge when the light catches it.")
    (FLAGS TAKEBIT)
    (SIZE 1)
    (ACTION SONGBIRD-FEATHER-FCN)>

<ROUTINE MUSEUM-SONGBIRD-OBSERVED ()
    <COND (<NOT <LOC ,SONGBIRD-FEATHER>>
           <MOVE ,SONGBIRD-FEATHER <LOC ,BAUBLE>>
           <TELL "A single blue-black flight feather turns once after the bauble and settles beside it." CR>)>
    <RTRUE>>

<ROUTINE MUSEUM-FOREST-ACCEPTS? (OBJ)
    <COND (<EQUAL? .OBJ ,SONGBIRD-FEATHER> <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-FOREST-PROJECT ()
    <TELL "Forest and Surface Life: ">
    <COND (<NOT ,SING-SONG>
           <TELL "the songbird case is empty. No field observation has yet connected the golden clockwork canary to a living forest bird." CR>)
          (<IN? ,SONGBIRD-FEATHER ,MUSEUM-FOREST-CASE>
           <COND (<IN? ,BAUBLE ,TROPHY-CASE>
                  <TELL "the case holds the real blue-black feather beside a linked record of the brass bauble in the trophy case. Together they document the songbird's bright-object exchange." CR>)
                 (T
                  <TELL "the real blue-black feather is displayed, but the brass bauble that proved the exchange is currently outside museum custody." CR>)>)
          (<IN? ,SONGBIRD-FEATHER ,NEST>
           <COND (<IN? ,BAUBLE ,TROPHY-CASE>
                  <TELL "the real brass bauble is displayed in the trophy case, while the feather has been returned to the bird's nest at Up a Tree. The museum records observation without pretending to own the trace." CR>)
                 (T
                  <TELL "the feather has been returned to the bird's nest at Up a Tree, and the real brass bauble is also outside museum custody. Only the witnessed exchange remains on record." CR>)>)
          (<IN? ,BAUBLE ,TROPHY-CASE>
           <TELL "the real brass bauble is displayed in the trophy case, but the songbird feather is currently outside both the forest case and the bird's nest." CR>)
          (T
           <TELL "the observed exchange is known, but neither the real feather nor the real bauble is in museum custody." CR>)>
    <RTRUE>>

<ROUTINE MUSEUM-FOREST-CASE-FCN ()
    <COND (<AND <EQUAL? ,PRSI ,MUSEUM-FOREST-CASE>
                <VERB? PUT PUT-ON>
                <NOT <MUSEUM-FOREST-ACCEPTS? ,PRSO>>>
           <TELL "This case preserves the songbird trace. Artifacts and treasure belong on the museum's other real displays." CR>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,MUSEUM-FOREST-CASE>
                <VERB? EXAMINE LOOK-INSIDE SEARCH>>
           <MUSEUM-FOREST-PROJECT>)
          (<AND <EQUAL? ,PRSO ,MUSEUM-FOREST-CASE>
                <VERB? TAKE MOVE MUNG>>
           <TELL "The low glass case is fixed to the Living Room floor." CR>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,MUSEUM-FOREST-CASE>
                <VERB? OPEN CLOSE>>
           <TELL "The case lid remains available for ordinary placement and retrieval." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE SONGBIRD-FEATHER-FCN ()
    <COND (<AND <EQUAL? ,PRSO ,SONGBIRD-FEATHER>
                <EQUAL? ,PRSI ,NEST>
                <VERB? PUT PUT-ON>>
           <COND (<NOT <IN? ,SONGBIRD-FEATHER ,WINNER>>
                  <TELL "You must physically have the feather before returning it to the bird's nest." CR>)
                 (T
                  <MOVE ,SONGBIRD-FEATHER ,NEST>
                  <TELL "You work the real feather into the bird's nest beside the jeweled egg. Its blue-black shaft settles among the twigs, restored to the place where the songbird lived rather than copied into a museum case." CR>)>
           <RTRUE>)
          (<AND <VERB? TAKE MOVE MUNG>
                <IN? ,SONGBIRD-FEATHER ,NEST>>
           <TELL "You deliberately restored the feather to the bird's nest. Pulling apart the woven twigs would turn a field decision into vandalism." CR>
           <RTRUE>)
          (<VERB? EXAMINE>
           <COND (<IN? ,SONGBIRD-FEATHER ,NEST>
                  <TELL "The blue-black flight feather is woven into the real bird's nest beside the jeweled egg, green at one edge and physically beyond museum custody." CR>)
                 (<IN? ,SONGBIRD-FEATHER ,MUSEUM-FOREST-CASE>
                  <TELL "The real feather lies beneath the case glass. Its dark vanes flash green near the shaft; no replica stands in for it." CR>)
                 (T
                  <TELL "The single flight feather is blue-black with a narrow green iridescence. It is light enough to have turned once behind the falling brass bauble." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE SONGBIRD-PLAQUE-FCN ()
    <COND (<VERB? READ EXAMINE>
           <COND (<NOT ,SING-SONG>
                  <TELL "SONGBIRD CORRESPONDENCE. The plaque remains blank because the forest exchange has not been witnessed." CR>)
                 (T
                  <TELL "SONGBIRD CORRESPONDENCE. Observed after the real golden clockwork canary was wound in the forest: a living songbird answered, dropped the canonical brass bauble, and left one blue-black flight feather. ">
                  <COND (<IN? ,SONGBIRD-FEATHER ,MUSEUM-FOREST-CASE>
                         <TELL "The real feather is displayed in the Forest and Surface Life case.">)
                        (<IN? ,SONGBIRD-FEATHER ,NEST>
                         <TELL "The real feather was returned to the bird's nest at Up a Tree and is not represented by a substitute.">)
                        (T
                         <TELL "The real feather is currently outside the forest case and bird's nest.">)>
                  <COND (<IN? ,BAUBLE ,TROPHY-CASE>
                         <TELL " The real brass bauble is in museum custody in the trophy case." CR>)
                        (T
                         <TELL " The real brass bauble is currently outside museum custody." CR>)>)>
           <RTRUE>)>
    <RFALSE>>
