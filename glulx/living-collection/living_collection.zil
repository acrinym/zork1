"LIVING COLLECTION AND COMPANIONSHIP for Release 1304"

;"Renumbered POST_1286 program (planning ids 1287-1292). Parser-native only.
  One authored reservoir species, Mara's witnessed knowledge, the Waters case as
  a real vessel, house stewardship as decisions, exact-object custody, and
  agreed Dam errands. No GUI, no aquarium engine, no quest log.
  Parser SYNTAX lives in living_collection_syntax.zil (inserted before Mara)."

<CONSTANT LC-SCHEMA 1>
<CONSTANT LC-SLOT-VERSION 0>
<CONSTANT LC-SLOT-CHAR-OBS 1>
<CONSTANT LC-SLOT-CHAR-REL 2>
<CONSTANT LC-SLOT-JAR-DEAD 3>
<CONSTANT LC-SLOT-ERRAND 4>
<CONSTANT LC-SLOT-TOLD-SILVER 5>
<CONSTANT LC-SLOT-TOLD-CHAR 6>
<CONSTANT LC-SLOT-SAW-EXHIBIT 7>
<CONSTANT LC-SLOT-CHAR-VAR 8>
<CONSTANT LC-STATE <TABLE LC-SCHEMA 0 0 0 0 0 0 0 0 0>>

<OBJECT LC-HOUSE-FILE
    (IN GLOBAL-OBJECTS)
    (SYNONYM FILE FILING)
    (DESC "filing")
    (FLAGS NDESCBIT)>

<OBJECT LC-HOUSE-PREPARE
    (IN GLOBAL-OBJECTS)
    (SYNONYM SUPPER STEW MEAL)
    (DESC "kitchen work")
    (FLAGS NDESCBIT)>

<OBJECT LC-HOUSE-REST
    (IN GLOBAL-OBJECTS)
    (SYNONYM REPOSE BEDREST)
    (DESC "rest")
    (FLAGS NDESCBIT)>

<CONSTANT CHAR-QUIET 1>

<OBJECT RESERVOIR-CHAR
    (SYNONYM CHAR FISH SPECIMEN)
    (ADJECTIVE RESERVOIR QUIET WATER DEEP)
    (DESC "reservoir char")
    (LDESC "A quiet-water reservoir char hangs in the available water.")
    (FLAGS TAKEBIT)
    (SIZE 4)
    (ACTION RESERVOIR-CHAR-FCN)>

<OBJECT CHAR-PLAQUE
    (IN LIVING-ROOM)
    (SYNONYM PLAQUE LABEL CARD RECORD)
    (ADJECTIVE CHAR RESERVOIR BRASS)
    (DESC "reservoir char plaque")
    (FLAGS NDESCBIT READBIT)
    (ACTION CHAR-PLAQUE-FCN)>

<ROUTINE LC-GET (SLOT)
    <GET ,LC-STATE .SLOT>>

<ROUTINE LC-PUT (SLOT VALUE)
    <PUT ,LC-STATE .SLOT .VALUE>>

<ROUTINE LC-ENSURE ()
    <COND (<NOT <EQUAL? <LC-GET ,LC-SLOT-VERSION> ,LC-SCHEMA>>
           <LC-PUT ,LC-SLOT-VERSION ,LC-SCHEMA>
           <LC-PUT ,LC-SLOT-CHAR-OBS 0>
           <LC-PUT ,LC-SLOT-CHAR-REL 0>
           <LC-PUT ,LC-SLOT-JAR-DEAD 0>
           <LC-PUT ,LC-SLOT-ERRAND 0>
           <LC-PUT ,LC-SLOT-TOLD-SILVER 0>
           <LC-PUT ,LC-SLOT-TOLD-CHAR 0>
           <LC-PUT ,LC-SLOT-SAW-EXHIBIT 0>
           <LC-PUT ,LC-SLOT-CHAR-VAR 0>)>
    <RFALSE>>

<ROUTINE LC-RESERVOIR-BANK? ()
    <COND (<EQUAL? ,HERE ,RESERVOIR-SOUTH> <RTRUE>)
          (<EQUAL? ,HERE ,RESERVOIR-NORTH> <RTRUE>)>
    <RFALSE>>

<ROUTINE LC-JAR-OCCUPIED? ()
    <COND (<IN? ,DAM-SILVERFIN ,MUSEUM-FIELD-JAR> <RTRUE>)
          (<IN? ,RESERVOIR-CHAR ,MUSEUM-FIELD-JAR> <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-AQUATIC-ACCEPTS? (OBJ)
    <COND (<EQUAL? .OBJ ,DAM-SILVERFIN> <RTRUE>)
          (<EQUAL? .OBJ ,RESERVOIR-CHAR> <RTRUE>)>
    <RFALSE>>

<ROUTINE MUSEUM-FISH-CARRIED? ("AUX" HOLDER)
    <COND (<IN? ,DAM-SILVERFIN ,WINNER> <RTRUE>)
          (<IN? ,RESERVOIR-CHAR ,WINNER> <RTRUE>)>
    <SET HOLDER <LOC ,DAM-SILVERFIN>>
    <COND (<AND .HOLDER <IN? .HOLDER ,WINNER>> <RTRUE>)>
    <SET HOLDER <LOC ,RESERVOIR-CHAR>>
    <COND (<AND .HOLDER <IN? .HOLDER ,WINNER>> <RTRUE>)>
    <RFALSE>>

<ROUTINE LC-CASE-FEED-LINE ()
    <LC-ENSURE>
    <COND (<LC-GET ,LC-SLOT-JAR-DEAD>
           <TELL " The field jar that once carried living water is gone; only a stagnant film remains.">)
          (,LOW-TIDE
           <TELL " The reservoir feed has fallen with the gates; the case no longer circulates.">)
          (T
           <TELL " Dam water still moves through the shallow case.">)>
    <RTRUE>>

<ROUTINE MUSEUM-AQUATIC-PROJECT ()
    <AQUATIC-ENSURE>
    <LC-ENSURE>
    <TELL "Waters of the Empire:">
    <LC-CASE-FEED-LINE>
    <TELL CR>
    <COND (<IN? ,DAM-SILVERFIN ,MUSEUM-WATERS-CASE>
           <TELL "The case holds a living ">
           <MUSEUM-SILVERFIN-NAME>
           <TELL ", ">
           <MUSEUM-SILVERFIN-PROVENANCE>
           <TELL "." CR>)
          (<AQUATIC-GET ,AQUATIC-SLOT-RELEASED>
           <TELL "A field record documents a ">
           <MUSEUM-SILVERFIN-NAME>
           <TELL " returned alive to the River Frigid. The plaque marks absence, not a copy." CR>)
          (<AQUATIC-GET ,AQUATIC-SLOT-OBSERVED>
           <TELL "The silverfin record is established, but the real specimen is currently absent from the case." CR>)
          (T
           <TELL "No dam silverfin occupies the case." CR>)>
    <COND (<IN? ,RESERVOIR-CHAR ,MUSEUM-WATERS-CASE>
           <TELL "A quiet-water reservoir char occupies the vessel." CR>)
          (<LC-GET ,LC-SLOT-CHAR-REL>
           <TELL "A field card records a reservoir char returned to still water. No replacement fish was invented." CR>)
          (<LC-GET ,LC-SLOT-CHAR-OBS>
           <TELL "The char was documented; the animal itself is not in the case." CR>)
          (T
           <TELL "The reservoir niche is empty." CR>)>
    <RTRUE>>

<ROUTINE MUSEUM-FIELD-JAR-FCN ()
    <LC-ENSURE>
    <COND (<OR <AND <VERB? MUNG ATTACK CUT>
                    <EQUAL? ,PRSO ,MUSEUM-FIELD-JAR>
                    <EQUAL? ,PRSI ,SWORD ,AXE>>
               <AND <VERB? THROW>
                    <EQUAL? ,PRSI ,MUSEUM-FIELD-JAR>
                    <EQUAL? ,PRSO ,SWORD ,AXE>>>
           <TELL "The blow reaches the glass. Water and leather slap the floor; the jar is no longer a vessel, only wet fragments." CR>
           <COND (<IN? ,DAM-SILVERFIN ,MUSEUM-FIELD-JAR>
                  <MOVE ,DAM-SILVERFIN ,HERE>
                  <TELL "The silverfin thrashes once in the spill and lies in open air." CR>)>
           <COND (<IN? ,RESERVOIR-CHAR ,MUSEUM-FIELD-JAR>
                  <MOVE ,RESERVOIR-CHAR ,HERE>
                  <TELL "The reservoir char gasps in the spill." CR>)>
           <LC-PUT ,LC-SLOT-JAR-DEAD 1>
           <REMOVE-CAREFULLY ,MUSEUM-FIELD-JAR>
           <COND (<AND <MARA-HERE?>
                       <EQUAL? ,HERE ,LIVING-ROOM ,KITCHEN>>
                  <TELL "Mara looks at the wet fragments. That was a vessel, she says, not a gesture." CR>)>
           <RTRUE>)
          (<VERB? EXAMINE>
           <TELL "The broad glass jar is filled with fresh water and covered by pierced leather. It is meant to carry one small living specimen from the field.">
           <COND (<IN? ,DAM-SILVERFIN ,MUSEUM-FIELD-JAR>
                  <TELL " A dam silverfin is alive inside.">)
                 (<IN? ,RESERVOIR-CHAR ,MUSEUM-FIELD-JAR>
                  <TELL " A reservoir char is alive inside.">)>
           <CRLF>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE RESERVOIR-CHAR-FCN ()
    <COND (<VERB? UNTIE>
           <V-MUSEUM-RELEASE>
           <RTRUE>)
          (<VERB? EXAMINE>
           <TELL "The char is thick-bodied for still reservoir water, darker along the back, with no spillway scar. It is a different animal from the River Frigid silverfin." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CHAR-PLAQUE-FCN ()
    <LC-ENSURE>
    <COND (<VERB? READ EXAMINE>
           <COND (<ZERO? <LC-GET ,LC-SLOT-CHAR-OBS>>
                  <TELL "RESERVOIR CHAR. The remaining lines are blank; the museum has no still-water evidence yet." CR>)
                 (<IN? ,RESERVOIR-CHAR ,MUSEUM-WATERS-CASE>
                  <TELL "Quiet-water reservoir char. Donated by the Adventurer from Flood Control Dam #3's reservoir while the pool still held. The animal in the case is that catch, not a copy." CR>)
                 (<LC-GET ,LC-SLOT-CHAR-REL>
                  <TELL "Quiet-water reservoir char. Registered from a live specimen and returned to reservoir water. The plaque records absence." CR>)
                 (T
                  <TELL "The museum record identifies a reservoir char, but the real specimen is presently outside the case." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE LC-WITNESS-CHAR ()
    <MARA-ENSURE>
    <COND (<MARA-HERE?>
           <COND (<ZERO? <MARA-GET ,MARA-SLOT-MET>> <MARA-MEET>)>
           <MARA-PUT ,MARA-SLOT-LAST-EVIDENCE ,RESERVOIR-CHAR>
           <TELL "Mara watches the still-water char settle in the jar. Different body, different current, she says. Do not file it as another silverfin." CR>)>
    <RFALSE>>

<ROUTINE LC-NOTE-SHOW (OBJ)
    <LC-ENSURE>
    <COND (<EQUAL? .OBJ ,DAM-SILVERFIN>
           <LC-PUT ,LC-SLOT-TOLD-SILVER 1>)
          (<EQUAL? .OBJ ,RESERVOIR-CHAR>
           <LC-PUT ,LC-SLOT-TOLD-CHAR 1>)>
    <RFALSE>>

<ROUTINE V-MUSEUM-FISH ("AUX" VARIETY)
    <AQUATIC-ENSURE>
    <LC-ENSURE>
    <COND (<AND ,PRSO <NOT <EQUAL? ,PRSO ,MUSEUM-FISHING-ROD>>>
           <TELL "That is not the museum fishing rod." CR>)
          (<NOT <IN? ,MUSEUM-FISHING-ROD ,WINNER>>
           <TELL "You need the physical museum fishing rod, not merely an intention to fish." CR>)
          (<LC-GET ,LC-SLOT-JAR-DEAD>
           <TELL "The field jar is gone. There is no honest vessel for a living catch." CR>)
          (<NOT <IN? ,MUSEUM-FIELD-JAR ,WINNER>>
           <TELL "Bring the water-filled field jar before catching a living museum specimen." CR>)
          (<LC-JAR-OCCUPIED?>
           <TELL "The jar already holds one living specimen. It is not a market basket." CR>)
          (<EQUAL? ,HERE ,DAM-BASE>
           <COND (<LOC ,DAM-SILVERFIN>
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
                         <TELL "You cast into the cold, steady run beside the dam. The green line draws tight and a narrow silver fish comes up fighting the River Frigid. You transfer the living dam silverfin to the water-filled field jar." CR>)>
                  <MARA-WITNESS-FISH .VARIETY>)>)
          (<LC-RESERVOIR-BANK?>
           <COND (,LOW-TIDE
                  <TELL "The reservoir is drawn down to mud and stranded weed. There is no water here deep enough for a living catch." CR>)
                 (<LOC ,RESERVOIR-CHAR>
                  <TELL "The one known reservoir char is already in the world. A second catch would be a copy, not evidence." CR>)
                 (T
                  <LC-PUT ,LC-SLOT-CHAR-VAR ,CHAR-QUIET>
                  <LC-PUT ,LC-SLOT-CHAR-OBS 1>
                  <LC-PUT ,LC-SLOT-CHAR-REL 0>
                  <FSET ,MUSEUM-FIELD-JAR ,OPENBIT>
                  <MOVE ,RESERVOIR-CHAR ,MUSEUM-FIELD-JAR>
                  <TELL "You cast into the still reservoir. The line draws a thick-bodied char from quiet water, not from the River Frigid. You transfer the living reservoir char to the field jar." CR>
                  <LC-WITNESS-CHAR>)>)
          (T
           <TELL "The museum rod needs reachable water. The River Frigid at the dam base, or the reservoir banks while they still hold water, are the documented field sites." CR>)>
    <RTRUE>>

<ROUTINE V-MUSEUM-RELEASE ()
    <AQUATIC-ENSURE>
    <LC-ENSURE>
    <COND (<EQUAL? ,PRSO ,DAM-SILVERFIN>
           <COND (<NOT <EQUAL? ,HERE ,DAM-BASE>>
                  <TELL "Release the silverfin where it was caught, at the River Frigid below the dam." CR>)
                 (<NOT <OR <IN? ,DAM-SILVERFIN ,WINNER>
                           <IN? ,DAM-SILVERFIN ,MUSEUM-FIELD-JAR>>>
                  <TELL "You must physically have the specimen before releasing it." CR>)
                 (T
                  <REMOVE ,DAM-SILVERFIN>
                  <AQUATIC-PUT ,AQUATIC-SLOT-OBSERVED 1>
                  <AQUATIC-PUT ,AQUATIC-SLOT-RELEASED 1>
                  <TELL "You lower the ">
                  <MUSEUM-SILVERFIN-NAME>
                  <TELL " into the River Frigid. It holds against the current for a moment, then disappears beneath the dam's shadow. The museum keeps the earned field record, not a fictional replacement specimen." CR>
                  <MARA-WITNESS-RELEASE>)>)
          (<EQUAL? ,PRSO ,RESERVOIR-CHAR>
           <COND (<NOT <LC-RESERVOIR-BANK?>>
                  <TELL "Release the char into reservoir water, not into a convenient other room." CR>)
                 (,LOW-TIDE
                  <TELL "The reservoir is mud. Returning a living char here would be a death, not a release." CR>)
                 (<NOT <OR <IN? ,RESERVOIR-CHAR ,WINNER>
                           <IN? ,RESERVOIR-CHAR ,MUSEUM-FIELD-JAR>>>
                  <TELL "You must physically have the specimen before releasing it." CR>)
                 (T
                  <REMOVE ,RESERVOIR-CHAR>
                  <LC-PUT ,LC-SLOT-CHAR-OBS 1>
                  <LC-PUT ,LC-SLOT-CHAR-REL 1>
                  <TELL "You lower the reservoir char into still water. It hangs a moment, then takes the pool. The plaque will record absence, not a clone." CR>
                  <COND (<MARA-HERE?>
                         <TELL "Mara watches the char recover the reservoir. Custody closed where the animal actually lives, she says." CR>)>)>)
          (T
           <TELL "This field release is defined for the documented dam silverfin or reservoir char." CR>)>
    <RTRUE>>

<ROUTINE V-LC-TAKE-TO ()
    <LC-ENSURE>
    <COND (<NOT <EQUAL? ,WINNER ,MARA>>
           <TELL "You can carry the jar yourself. An errand is a request Mara can accept or refuse." CR>)
          (<NOT <EQUAL? ,PRSO ,MUSEUM-FIELD-JAR>>
           <TELL "The authored Dam errand is for the water-filled field jar, not a general delivery service." CR>)
          (<NOT <EQUAL? ,PRSI ,DAM ,MARA-DAM-TOPIC ,DAM-BASE ,DAM-ROOM>>
           <TELL "Mara will not treat an unnamed destination as a route. Name the Dam." CR>)
          (T
           <V-LC-MARA-JAR-ERRAND>)>
    <RTRUE>>

<ROUTINE V-LC-MARA-JAR-ERRAND ()
    <MARA-ENSURE>
    <LC-ENSURE>
    <COND (<NOT <MARA-HERE?>>
           <TELL "Mara is not here to hear the errand." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-DAM-SURVEY>>
           <TELL "I do not know that route as a surveyed fact, Mara says. I will not walk the Dam on a rumor with your jar." CR>)
          (<LC-GET ,LC-SLOT-JAR-DEAD>
           <TELL "The jar is already fragments. There is nothing to take to the Dam." CR>)
          (<NOT <EQUAL? <LOC ,MUSEUM-FIELD-JAR> ,HERE ,WINNER ,MARA>>
           <TELL "The field jar is not here to take." CR>)
          (<LC-GET ,LC-SLOT-ERRAND>
           <TELL "Mara already has that Dam errand. She will not stack a second invisible job behind it." CR>)
          (T
           <MOVE ,MUSEUM-FIELD-JAR ,MARA>
           <LC-PUT ,LC-SLOT-ERRAND 1>
           <COND (<MARA-DAM-REGION? ,HERE>
                  <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-INDEPENDENT>
                  <TELL "Mara takes the field jar. I know this water, she says. I will take it to the river below the dam. That is a purpose, not a quest marker." CR>)
                 (T
                  <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-FOLLOWING>
                  <TELL "Mara takes the field jar. I know the Dam, she says, but I will not vanish through stone I have not agreed to walk alone. Lead the shared house route; I have the jar." CR>)>)>
    <RTRUE>>

<ROUTINE LC-ERRAND-PULSE ("AUX" RM)
    <LC-ENSURE>
    <COND (<ZERO? <LC-GET ,LC-SLOT-ERRAND>>
           <RFALSE>)>
    <SET RM <LOC ,MARA>>
    <COND (<EQUAL? .RM ,DAM-BASE>
           <COND (<IN? ,MUSEUM-FIELD-JAR ,MARA>
                  <MOVE ,MUSEUM-FIELD-JAR ,DAM-BASE>)>
           <LC-PUT ,LC-SLOT-ERRAND 0>
           <COND (<EQUAL? ,HERE ,DAM-BASE>
                  <TELL "Mara sets the field jar on the wet stone at the river. Errand closed, she says. The object is here, not reported from elsewhere." CR>)>
           <RFALSE>)
          (<NOT <EQUAL? <MARA-GET ,MARA-SLOT-MODE> ,MARA-MODE-INDEPENDENT>>
           <RFALSE>)
          (<EQUAL? .RM ,DAM-ROOM ,DAM-LOBBY>
           <MOVE ,MARA ,DAM-BASE>
           <COND (<IN? ,MUSEUM-FIELD-JAR ,MARA>
                  <MOVE ,MUSEUM-FIELD-JAR ,MARA>)>
           <COND (<EQUAL? ,HERE ,DAM-BASE>
                  <TELL "Mara arrives from the dam works, jar still in hand." CR>)>
           <RFALSE>)
          (<EQUAL? .RM ,RESERVOIR-SOUTH ,RESERVOIR-NORTH ,DEEP-CANYON>
           <MOVE ,MARA ,DAM-BASE>
           <COND (<EQUAL? ,HERE ,DAM-BASE>
                  <TELL "Mara comes down from the reservoir bank with the field jar." CR>)>
           <RFALSE>)>
    <RFALSE>>

<ROUTINE V-LC-ASK-TO ()
    <COND (<EQUAL? ,PRSI ,LC-HOUSE-FILE>
           <V-LC-ASK-FILE>)
          (<EQUAL? ,PRSI ,LC-HOUSE-PREPARE>
           <V-LC-ASK-PREPARE>)
          (<EQUAL? ,PRSI ,LC-HOUSE-REST>
           <V-LC-ASK-REST>)
          (T
           <TELL "Mara does not treat that as a house request she can honor from those words." CR>)>
    <RTRUE>>

<ROUTINE V-LC-ASK-PREPARE ()
    <COND (<NOT <EQUAL? ,PRSO ,MARA>>
           <TELL "That request is for Mara, not a generic kitchen spirit." CR>)
          (T
           <V-LC-MARA-PREPARE>)>
    <RTRUE>>

<ROUTINE V-LC-ASK-REST ()
    <COND (<NOT <EQUAL? ,PRSO ,MARA>>
           <TELL "That rest request needs a person who lives here." CR>)
          (T
           <V-LC-MARA-REST>)>
    <RTRUE>>

<ROUTINE V-LC-ASK-FILE ()
    <COND (<NOT <EQUAL? ,PRSO ,MARA>>
           <TELL "Filing here is a person deciding to use the archive, not a command to furniture." CR>)
          (T
           <V-LC-MARA-FILE>)>
    <RTRUE>>

<ROUTINE V-LC-MARA-PREPARE ()
    <MARA-ENSURE>
    <COND (<NOT <MARA-HERE?>>
           <TELL "Mara is not here to cook." CR>)
          (<NOT <EQUAL? ,HERE ,KITCHEN>>
           <TELL "I live in this house, Mara says, but I cook at the stove, not by remote instruction." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-HOUSE-VISITED>>
           <TELL "Mara has not made this House her base yet. She will not play maid in a room she has not chosen." CR>)
          (T
           <TELL "Mara checks the real stove, sink, and whatever food is actually here. She prepares what exists; she will not invent a meal because a verb asked nicely." CR>)>
    <RTRUE>>

<ROUTINE V-LC-MARA-REST ()
    <MARA-ENSURE>
    <COND (<NOT <MARA-HERE?>>
           <TELL "Mara is not here to rest." CR>)
          (<NOT <EQUAL? ,HERE ,BEDROOM>>
           <TELL "I sleep in the bedroom, Mara says, when I choose to. This is not a rest command you issue from any room." CR>)
          (T
           <TELL "Mara sits on the four-poster and closes her notebook. She is resting because she lives here, not because you scheduled her." CR>)>
    <RTRUE>>

<ROUTINE V-LC-MARA-FILE ()
    <MARA-ENSURE>
    <COND (<NOT <MARA-HERE?>>
           <TELL "Mara is not here to file anything." CR>)
          (<AND <NOT <EQUAL? ,HERE ,ATTIC>>
                <NOT <EQUAL? ,HERE ,LIVING-ROOM>>>
           <TELL "I file notes in the attic archive or at the museum case, Mara says. Not as a portable clerk." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-DAM-SURVEY>>
           <TELL "She has no joint Dam sheet to file. She will not invent paperwork." CR>)
          (T
           <TELL "Mara copies what she actually witnessed into the House record and stops. She is not emptying the museum onto a checklist." CR>
           <COND (<AND <EQUAL? ,HERE ,LIVING-ROOM>
                       <LC-GET ,LC-SLOT-JAR-DEAD>>
                  <TELL " She adds one line about the smashed jar, because she saw the fragments." CR>)>)>
    <RTRUE>>
