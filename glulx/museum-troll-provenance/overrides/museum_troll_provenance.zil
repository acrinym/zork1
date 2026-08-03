"MUSEUM TROLL PROVENANCE for Release 1241"

;"One authored monstrous-zoology consequence extends the canonical troll
  fight. The troll remains the original actor and the fight remains native.
  One physical tuft appears only when that real encounter ends in
  unconsciousness or death, and the museum records which outcome actually
  produced it."

<CONSTANT TROLL-OUTCOME-NONE 0>
<CONSTANT TROLL-OUTCOME-SUBDUED 1>
<CONSTANT TROLL-OUTCOME-KILLED 2>
<CONSTANT TROLL-TRACE-STATE <TABLE TROLL-OUTCOME-NONE>>

<OBJECT MUSEUM-MONSTER-GALLERY-OBJECT
    (IN GLOBAL-OBJECTS)
    (SYNONYM CREATURES MONSTERS ZOOLOGY BESTIARY)
    (ADJECTIVE MONSTROUS MUSEUM)
    (DESC "Creatures and Monstrous Zoology gallery")
    (FLAGS NDESCBIT RMUNGBIT)>

<OBJECT MUSEUM-MONSTER-CASE
    (IN LIVING-ROOM)
    (SYNONYM CASE DISPLAY TRAY CABINET)
    (ADJECTIVE CREATURE MONSTER TROLL ZOOLOGY MUSEUM)
    (DESC "Creatures and Monstrous Zoology case")
    (LDESC "A dark-backed case marked CREATURES AND MONSTROUS ZOOLOGY stands beyond the Forest display.")
    (FLAGS CONTBIT OPENBIT SEARCHBIT SURFACEBIT TRYTAKEBIT)
    (CAPACITY 20)
    (ACTION MUSEUM-MONSTER-CASE-FCN)>

<OBJECT TROLL-PLAQUE
    (IN LIVING-ROOM)
    (SYNONYM PLAQUE LABEL CARD RECORD)
    (ADJECTIVE TROLL CREATURE MONSTER PROVENANCE)
    (DESC "troll provenance plaque")
    (FLAGS NDESCBIT READBIT)
    (ACTION TROLL-PLAQUE-FCN)>

<OBJECT TROLL-FUR
    (SYNONYM FUR HAIR TUFT SAMPLE TRACE)
    (ADJECTIVE TROLL COARSE IRON-GREY GRAY)
    (DESC "coarse iron-grey troll fur")
    (LDESC "A coarse tuft of iron-grey troll fur lies here, dark at the roots and stiff as wire.")
    (FLAGS TAKEBIT)
    (SIZE 1)
    (ACTION TROLL-FUR-FCN)>

<ROUTINE TROLL-TRACE-OUTCOME ()
    <GET ,TROLL-TRACE-STATE 0>>

<ROUTINE MUSEUM-TROLL-TRACE (OUTCOME)
    <COND (<NOT <LOC ,TROLL-FUR>>
           <PUT ,TROLL-TRACE-STATE 0 .OUTCOME>
           <MOVE ,TROLL-FUR ,HERE>
           <COND (<EQUAL? .OUTCOME ,TROLL-OUTCOME-KILLED>
                  <TELL "A coarse iron-grey tuft clings briefly to the fallen axe, then drops beside it." CR>)
                 (T
                  <TELL "A coarse iron-grey tuft shakes loose from the sprawled troll and catches against one of the bloodstained wall scratches." CR>)>)>
    <RTRUE>>

<ROUTINE MUSEUM-MONSTER-ACCEPTS? (OBJ)
    <COND (<EQUAL? .OBJ ,TROLL-FUR> <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-TROLL-PROVENANCE ()
    <COND (<EQUAL? <TROLL-TRACE-OUTCOME> ,TROLL-OUTCOME-SUBDUED>
           <TELL "shed when the canonical troll was rendered unconscious and the passages opened without a confirmed kill">)
          (<EQUAL? <TROLL-TRACE-OUTCOME> ,TROLL-OUTCOME-KILLED>
           <TELL "recovered after the canonical troll was killed and its bloody axe fell to the floor">)
          (T
           <TELL "not yet supported by a witnessed troll encounter">)>
    <RTRUE>>

<ROUTINE MUSEUM-MONSTER-PROJECT ()
    <TELL "Creatures and Monstrous Zoology: ">
    <COND (<EQUAL? <TROLL-TRACE-OUTCOME> ,TROLL-OUTCOME-NONE>
           <TELL "the troll case is empty. The museum has no physical trace from the guardian of the western passages." CR>)
          (<IN? ,TROLL-FUR ,MUSEUM-MONSTER-CASE>
           <TELL "the case holds the one real iron-grey troll tuft, ">
           <MUSEUM-TROLL-PROVENANCE>
           <TELL "." CR>)
          (<IN? ,TROLL-FUR ,TROLL-ROOM>
           <TELL "the witnessed trace remains physically in the Troll Room; the museum records the encounter but does not claim custody." CR>)
          (T
           <TELL "the troll encounter is documented, but the real tuft is currently outside museum custody." CR>)>
    <RTRUE>>

<ROUTINE MUSEUM-MONSTER-CASE-FCN ()
    <COND (<AND <EQUAL? ,PRSI ,MUSEUM-MONSTER-CASE>
                <VERB? PUT PUT-ON>
                <NOT <MUSEUM-MONSTER-ACCEPTS? ,PRSO>>>
           <TELL "This case preserves the troll trace. Other evidence belongs on the museum's other real displays." CR>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,MUSEUM-MONSTER-CASE>
                <VERB? EXAMINE LOOK-INSIDE SEARCH>>
           <MUSEUM-MONSTER-PROJECT>)
          (<AND <EQUAL? ,PRSO ,MUSEUM-MONSTER-CASE>
                <VERB? TAKE MOVE MUNG>>
           <TELL "The dark-backed case is fixed to the Living Room floor." CR>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,MUSEUM-MONSTER-CASE>
                <VERB? OPEN CLOSE>>
           <TELL "The case lid remains available for ordinary placement and retrieval." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE TROLL-FUR-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "The tuft is coarse iron-grey fur, dark at the roots and almost wiry enough to remember the wall scratches. It was ">
           <MUSEUM-TROLL-PROVENANCE>
           <COND (<IN? ,TROLL-FUR ,MUSEUM-MONSTER-CASE>
                  <TELL ", and the original trace is now under the museum glass." CR>)
                 (<IN? ,TROLL-FUR ,TROLL-ROOM>
                  <TELL ", and it still lies where the encounter happened." CR>)
                 (T
                  <TELL ", and it is currently outside museum custody." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE TROLL-PLAQUE-FCN ()
    <COND (<VERB? READ EXAMINE>
           <COND (<EQUAL? <TROLL-TRACE-OUTCOME> ,TROLL-OUTCOME-NONE>
                  <TELL "TROLL PROVENANCE. No physical trace has been recovered from the troll guarding the western passages." CR>)
                 (T
                  <TELL "TROLL PROVENANCE. One coarse iron-grey tuft was ">
                  <MUSEUM-TROLL-PROVENANCE>
                  <COND (<IN? ,TROLL-FUR ,MUSEUM-MONSTER-CASE>
                         <TELL ". The actual tuft is displayed in the Creatures and Monstrous Zoology case." CR>)
                        (<IN? ,TROLL-FUR ,TROLL-ROOM>
                         <TELL ". The actual tuft remains at the encounter site in the Troll Room." CR>)
                        (T
                         <TELL ". The actual tuft is currently outside museum custody." CR>)>)>
           <RTRUE>)>
    <RFALSE>>
