"MUSEUM ECOLOGY AND DAM FISHING for Release 1239"

;"One authored natural-history loop joins Flood Control Dam #3 to the real
  Living Room museum. The rod, jar, fish, case, and plaque are physical
  objects. Existing dam state selects the specimen variety."

<SYNTAX FISH = V-MUSEUM-FISH>
<SYNONYM FISH ANGLE>

<CONSTANT AQUATIC-SCHEMA 1>
<CONSTANT AQUATIC-SLOT-VERSION 0>
<CONSTANT AQUATIC-SLOT-CATCHES 1>
<CONSTANT AQUATIC-SLOT-VARIETY 2>
<CONSTANT AQUATIC-SLOT-OBSERVED 3>
<CONSTANT AQUATIC-SLOT-RELEASED 4>
<CONSTANT AQUATIC-STATE <TABLE AQUATIC-SCHEMA 0 0 0 0>>

<CONSTANT SILVERFIN-RIVER 1>
<CONSTANT SILVERFIN-SPILLWAY 2>

<OBJECT MUSEUM-AQUATIC-GALLERY-OBJECT
    (IN GLOBAL-OBJECTS)
    (SYNONYM WATERS AQUATIC FISHERY ECOLOGY)
    (ADJECTIVE EMPIRE MUSEUM NATURAL HISTORY)
    (DESC "Waters of the Empire gallery")
    (FLAGS NDESCBIT RMUNGBIT)>

<OBJECT MUSEUM-FISHING-ROD
    (IN LIVING-ROOM)
    (SYNONYM ROD POLE REEL LINE)
    (ADJECTIVE FISHING ASH JOINTED MUSEUM FIELD BRASS)
    (DESC "museum fishing rod")
    (LDESC "A jointed ash fishing rod leans beside the museum displays.")
    (FLAGS TAKEBIT)
    (SIZE 12)
    (ACTION MUSEUM-FISHING-ROD-FCN)>

<OBJECT MUSEUM-FIELD-JAR
    (IN LIVING-ROOM)
    (SYNONYM JAR VESSEL LIVEWELL CONTAINER)
    (ADJECTIVE FIELD SPECIMEN WATER WATER-FILLED GLASS)
    (DESC "water-filled field jar")
    (LDESC "A broad water-filled specimen jar stands beside the fishing rod.")
    (FLAGS TAKEBIT TRANSBIT CONTBIT OPENBIT SEARCHBIT)
    (CAPACITY 10)
    (SIZE 8)
    (ACTION MUSEUM-FIELD-JAR-FCN)>

<OBJECT MUSEUM-WATERS-CASE
    (IN LIVING-ROOM)
    (SYNONYM CASE TANK AQUARIUM DISPLAY)
    (ADJECTIVE WATERS AQUATIC FLOWING SHALLOW MUSEUM)
    (DESC "shallow Waters of the Empire case")
    (LDESC "A shallow flowing museum case is built beneath a brass WATERS OF THE EMPIRE heading.")
    (FLAGS CONTBIT OPENBIT SEARCHBIT SURFACEBIT TRYTAKEBIT)
    (CAPACITY 20)
    (ACTION MUSEUM-WATERS-CASE-FCN)>

<OBJECT SILVERFIN-PLAQUE
    (IN LIVING-ROOM)
    (SYNONYM PLAQUE LABEL CARD RECORD)
    (ADJECTIVE SILVERFIN DAM BRASS AQUATIC)
    (DESC "dam silverfin plaque")
    (FLAGS NDESCBIT READBIT)
    (ACTION SILVERFIN-PLAQUE-FCN)>

<OBJECT DAM-SILVERFIN
    (SYNONYM SILVERFIN FISH SPECIMEN)
    (ADJECTIVE DAM RIVER SPILLWAY SILVER GATE-SCARRED)
    (DESC "dam silverfin")
    (LDESC "A living dam silverfin flashes silver in the available water.")
    (FLAGS TAKEBIT)
    (SIZE 4)
    (ACTION DAM-SILVERFIN-FCN)>

<ROUTINE AQUATIC-GET (SLOT)
    <GET ,AQUATIC-STATE .SLOT>>

<ROUTINE AQUATIC-PUT (SLOT VALUE)
    <PUT ,AQUATIC-STATE .SLOT .VALUE>>

<ROUTINE AQUATIC-ENSURE ()
    <COND (<NOT <EQUAL? <AQUATIC-GET ,AQUATIC-SLOT-VERSION>
                        ,AQUATIC-SCHEMA>>
           <AQUATIC-PUT ,AQUATIC-SLOT-VERSION ,AQUATIC-SCHEMA>
           <AQUATIC-PUT ,AQUATIC-SLOT-CATCHES 0>
           <AQUATIC-PUT ,AQUATIC-SLOT-VARIETY 0>
           <AQUATIC-PUT ,AQUATIC-SLOT-OBSERVED 0>
           <AQUATIC-PUT ,AQUATIC-SLOT-RELEASED 0>)>
    <RFALSE>>

<ROUTINE MUSEUM-AQUATIC-ACCEPTS? (OBJ)
    <COND (<EQUAL? .OBJ ,DAM-SILVERFIN> <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-FISH-CARRIED? ("AUX" HOLDER)
    <COND (<IN? ,DAM-SILVERFIN ,WINNER> <RTRUE>)>
    <SET HOLDER <LOC ,DAM-SILVERFIN>>
    <COND (<AND .HOLDER <IN? .HOLDER ,WINNER>> <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-SILVERFIN-NAME ()
    <AQUATIC-ENSURE>
    <COND (<EQUAL? <AQUATIC-GET ,AQUATIC-SLOT-VARIETY>
                   ,SILVERFIN-SPILLWAY>
           <TELL "spillway silverfin">)
          (T
           <TELL "river silverfin">)>
    <RTRUE>>

<ROUTINE MUSEUM-SILVERFIN-PROVENANCE ()
    <AQUATIC-ENSURE>
    <COND (<EQUAL? <AQUATIC-GET ,AQUATIC-SLOT-VARIETY>
                   ,SILVERFIN-SPILLWAY>
           <TELL "caught at the base of Flood Control Dam #3 while the reservoir stood at low tide. Its broad tail and pale gate scar fit the accelerated spillway current">)
          (T
           <TELL "caught in the cold River Frigid at the base of Flood Control Dam #3 before the reservoir was drawn down">)>
    <RTRUE>>

<ROUTINE MUSEUM-AQUATIC-PROJECT ()
    <AQUATIC-ENSURE>
    <TELL "Waters of the Empire: ">
    <COND (<IN? ,DAM-SILVERFIN ,MUSEUM-WATERS-CASE>
           <TELL "the shallow case holds a living ">
           <MUSEUM-SILVERFIN-NAME>
           <TELL ", ">
           <MUSEUM-SILVERFIN-PROVENANCE>
           <TELL "." CR>)
          (<AQUATIC-GET ,AQUATIC-SLOT-RELEASED>
           <TELL "a field record documents a ">
           <MUSEUM-SILVERFIN-NAME>
           <TELL " that was examined and returned alive to the River Frigid." CR>)
          (<AQUATIC-GET ,AQUATIC-SLOT-OBSERVED>
           <TELL "the silverfin record is established, but the real specimen is currently absent from the case." CR>)
          (T
           <TELL "the flowing case is empty. The nearby field rod and specimen jar make the missing evidence a practical expedition, not a checklist entry." CR>)>
    <RTRUE>>

<ROUTINE MUSEUM-FISHING-ROD-FCN ()
    <COND (<VERB? EXORCISE>
           <V-MUSEUM-FISH>)
          (<VERB? EXAMINE>
           <TELL "The rod is jointed ash with a cork grip, a narrow brass reel, and fine green line. A museum tag calls it field equipment. The reel has enough screws to suggest that its maker expected the fish to argue." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-FIELD-JAR-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "The broad glass jar is filled with fresh water and covered by pierced leather. It is meant to carry one small living specimen from the field without turning the museum into a fish market.">
           <COND (<IN? ,DAM-SILVERFIN ,MUSEUM-FIELD-JAR>
                  <TELL " A dam silverfin is alive inside.">)>
           <CRLF>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-WATERS-CASE-FCN ()
    <COND (<AND <EQUAL? ,PRSI ,MUSEUM-WATERS-CASE>
                <VERB? PUT PUT-ON>
                <NOT <MUSEUM-AQUATIC-ACCEPTS? ,PRSO>>>
           <TELL "The flowing case is for documented aquatic life, not a general shelf. The other museum displays remain available for artifacts." CR>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,MUSEUM-WATERS-CASE>
                <VERB? EXAMINE LOOK-INSIDE SEARCH>>
           <MUSEUM-AQUATIC-PROJECT>)
          (<AND <EQUAL? ,PRSO ,MUSEUM-WATERS-CASE>
                <VERB? TAKE MOVE MUNG>>
           <TELL "The circulating case is built into the Living Room wall." CR>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,MUSEUM-WATERS-CASE>
                <VERB? OPEN CLOSE>>
           <TELL "The service lid remains accessible; ordinary placement and retrieval are the intended controls." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE DAM-SILVERFIN-FCN ()
    <COND (<VERB? UNTIE>
           <V-MUSEUM-RELEASE>)
          (<VERB? EXAMINE>
           <AQUATIC-ENSURE>
           <COND (<EQUAL? <AQUATIC-GET ,AQUATIC-SLOT-VARIETY>
                          ,SILVERFIN-SPILLWAY>
                  <TELL "The broad-tailed silverfin bears a pale line along one flank, as though it survived hard contact with a gate or guide rail. Its body is built for faster water than the quiet reservoir." CR>)
                 (T
                  <TELL "The narrow silver fish is cold, alert, and shaped for the steady pull of the River Frigid. Its scales darken toward the tail but show no spillway scar." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE SILVERFIN-PLAQUE-FCN ()
    <COND (<VERB? READ EXAMINE>
           <AQUATIC-ENSURE>
           <COND (<ZERO? <AQUATIC-GET ,AQUATIC-SLOT-OBSERVED>>
                  <TELL "DAM SILVERFIN. The remaining lines are blank; the museum has no field evidence yet." CR>)
                 (<IN? ,DAM-SILVERFIN ,MUSEUM-WATERS-CASE>
                  <TELL "">
                  <MUSEUM-SILVERFIN-NAME>
                  <TELL ". Donated by the Adventurer; ">
                  <MUSEUM-SILVERFIN-PROVENANCE>
                  <TELL ". The classification remains open to comparison with a second specimen." CR>)
                 (<AQUATIC-GET ,AQUATIC-SLOT-RELEASED>
                  <TELL "">
                  <MUSEUM-SILVERFIN-NAME>
                  <TELL ". Registered from a live specimen; ">
                  <MUSEUM-SILVERFIN-PROVENANCE>
                  <TELL ". The animal was released, so the case displays a field card rather than a substitute fish." CR>)
                 (T
                  <TELL "The museum record identifies a ">
                  <MUSEUM-SILVERFIN-NAME>
                  <TELL ", but the real specimen is presently outside the case." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE V-MUSEUM-FISH ("AUX" VARIETY)
    <AQUATIC-ENSURE>
    <COND (<NOT <EQUAL? ,HERE ,DAM-BASE>>
           <TELL "The museum rod needs reachable water. The River Frigid at the base of Flood Control Dam #3 is the documented field site." CR>)
          (<AND ,PRSO <NOT <EQUAL? ,PRSO ,MUSEUM-FISHING-ROD>>>
           <TELL "That is not the museum fishing rod." CR>)
          (<NOT <IN? ,MUSEUM-FISHING-ROD ,WINNER>>
           <TELL "You need the physical museum fishing rod, not merely an intention to fish." CR>)
          (<NOT <IN? ,MUSEUM-FIELD-JAR ,WINNER>>
           <TELL "Bring the water-filled field jar before catching a living museum specimen." CR>)
          (<LOC ,DAM-SILVERFIN>
           <TELL "The one known silverfin specimen is already in the world. Catching a convenient duplicate would make its provenance meaningless." CR>)
          (T
           <SET VARIETY <COND (,LOW-TIDE ,SILVERFIN-SPILLWAY)
                              (T ,SILVERFIN-RIVER)>>
           <AQUATIC-PUT ,AQUATIC-SLOT-VARIETY .VARIETY>
           <AQUATIC-PUT ,AQUATIC-SLOT-OBSERVED 1>
           <AQUATIC-PUT ,AQUATIC-SLOT-RELEASED 0>
           <AQUATIC-PUT ,AQUATIC-SLOT-CATCHES
                        <+ <AQUATIC-GET ,AQUATIC-SLOT-CATCHES> 1>>
           <FSET ,MUSEUM-FIELD-JAR ,OPENBIT>
           <MOVE ,DAM-SILVERFIN ,MUSEUM-FIELD-JAR>
           <COND (<EQUAL? .VARIETY ,SILVERFIN-SPILLWAY>
                  <TELL "You cast beneath the dam into the sharpened spillway current. The ash rod bows, the brass reel chatters, and a broad-tailed silverfin breaks the surface with a pale gate scar along its flank. You transfer the living fish to the water-filled field jar." CR>)
                 (T
                  <TELL "You cast into the cold, steady run beside the dam. The green line draws tight and a narrow silver fish comes up fighting the River Frigid. You transfer the living dam silverfin to the water-filled field jar." CR>)>)>
    <RTRUE>>

<ROUTINE V-MUSEUM-RELEASE ()
    <AQUATIC-ENSURE>
    <COND (<NOT <EQUAL? ,PRSO ,DAM-SILVERFIN>>
           <TELL "This field release is defined for the documented dam silverfin." CR>)
          (<NOT <EQUAL? ,HERE ,DAM-BASE>>
           <TELL "Release the silverfin where it was caught, at the River Frigid below the dam." CR>)
          (<NOT <MUSEUM-FISH-CARRIED?>>
           <TELL "You must physically have the specimen before releasing it." CR>)
          (T
           <REMOVE ,DAM-SILVERFIN>
           <AQUATIC-PUT ,AQUATIC-SLOT-OBSERVED 1>
           <AQUATIC-PUT ,AQUATIC-SLOT-RELEASED 1>
           <TELL "You lower the ">
           <MUSEUM-SILVERFIN-NAME>
           <TELL " into the River Frigid. It holds against the current for a moment, then disappears beneath the dam's shadow. The museum keeps the earned field record, not a fictional replacement specimen." CR>)>
    <RTRUE>>
