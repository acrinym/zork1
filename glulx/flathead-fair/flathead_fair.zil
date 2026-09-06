"FLATHEAD FAIR GEOGRAPHY AND CLOCK for Release 1310"

;"Sixteen-location mesh plus mirror sub-map and wheel carriage. Additive NE
  from CLEARING. Fair-local phases; not a second global weather engine.
  Canonical House/Canyon exits remain the authority they already were."

<CONSTANT FAIR-PREOPEN 0>
<CONSTANT FAIR-OPENING 1>
<CONSTANT FAIR-LATE 2>
<CONSTANT FAIR-MIDDAY 3>
<CONSTANT FAIR-AFTERNOON 4>
<CONSTANT FAIR-DUSK 5>
<CONSTANT FAIR-EVENING 6>
<CONSTANT FAIR-CLOSING 7>
<CONSTANT FAIR-AFTER 8>

<CONSTANT FAIR-SLOT-PHASE 0>
<CONSTANT FAIR-SLOT-TURN 1>
<CONSTANT FAIR-SLOT-ZORKMIDS 2>
<CONSTANT FAIR-SLOT-TICKETS 3>
<CONSTANT FAIR-SLOT-WIND 4>
<CONSTANT FAIR-SLOT-GALLERY 5>
<CONSTANT FAIR-SLOT-SHOE-LAST 6>
<CONSTANT FAIR-SLOT-RACE-WIN 7>
<CONSTANT FAIR-SLOT-CATCH 8>
<CONSTANT FAIR-SLOT-PEA 9>
<CONSTANT FAIR-SLOT-KESTER-WARN 10>
<CONSTANT FAIR-SLOT-KESTER-CLOSED 11>
<CONSTANT FAIR-SLOT-CRATE 12>
<CONSTANT FAIR-SLOT-PURSE 13>
<CONSTANT FAIR-SLOT-SHEET 14>
<CONSTANT FAIR-SLOT-LATE-MIRROR 15>
<CONSTANT FAIR-SLOT-DRINK-KNOWN 16>
<CONSTANT FAIR-SLOT-MARA-REFUSE 17>
<CONSTANT FAIR-SLOT-WHEEL-PAID 18>
<CONSTANT FAIR-SLOT-RING-WINS 19>
<CONSTANT FAIR-SLOT-PELLA 20>
<CONSTANT FAIR-SLOT-DERBY 21>
<CONSTANT FAIR-SLOT-RECORD-FISH 22>
<CONSTANT FAIR-SLOT-ADA-INCIDENT 23>
<CONSTANT FAIR-SLOT-TOKEN 24>
<CONSTANT FAIR-SLOT-STRIP 25>
<CONSTANT FAIR-SLOT-MISSING 26>
<CONSTANT FAIR-SLOT-BELL-BEST 27>

<CONSTANT FAIR-STATE <TABLE 1 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 39 0 0 0 0 0 0 0>>

<ROUTINE FAIR-GET (SLOT)
    <GET ,FAIR-STATE .SLOT>>

<ROUTINE FAIR-PUT (SLOT VALUE)
    <PUT ,FAIR-STATE .SLOT .VALUE>>

<OBJECT MIRROR-GLASS
    (IN LOCAL-GLOBALS)
    (SYNONYM MIRROR GLASS REFLECTION)
    (DESC "mirror")
    (FLAGS NDESCBIT)
    (ACTION MIRROR-GLASS-FCN)>

<OBJECT FAIR-FOOD-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM FOOD RECIPE OIL SUGAR)
    (DESC "fair food")
    (FLAGS NDESCBIT)>

<OBJECT FAIR-RECORD-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM RECORDS ARCHIVE FILES PROGRAM)
    (ADJECTIVE HOUSE)
    (DESC "records")
    (FLAGS NDESCBIT)>

<ROUTINE FAIR-HERE? ()
    <COND (<EQUAL? ,HERE ,FAIR-ROAD ,FAIR-ENTRANCE ,CENTRAL-MIDWAY
                        ,FOOD-ROW ,GAMES-ROW ,MARKET-ROW
                        ,GRAND-PAVILION ,DANCE-PAVILION ,RIDE-COURT
                        ,OBSERVATION-WHEEL ,HOUSE-OF-MIRRORS ,FISHING-POND
                        ,POND-PATH ,EXHIBITION-YARD ,FAIR-OFFICE-PRIZE-HALL
                        ,BACK-LANE ,WHEEL-CARRIAGE
                        ,MIRROR-FOYER ,CROOKED-GALLERY ,REPEATING-PASSAGE
                        ,CROSSED-REFLECTIONS ,EXIT-GALLERY>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE FAIR-OPEN? ()
    <COND (<AND <G=? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-OPENING>
                <L=? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-CLOSING>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE FAIR-PUBLIC? ()
    <COND (<L? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-AFTER> <RTRUE>)>
    <RFALSE>>

<ROUTINE FAIR-PAY (N)
    <COND (<L? <FAIR-GET ,FAIR-SLOT-ZORKMIDS> .N>
           <TELL "You haven't enough zorkmids. The price is " N .N " zm." CR>
           <RFALSE>)>
    <FAIR-PUT ,FAIR-SLOT-ZORKMIDS <- <FAIR-GET ,FAIR-SLOT-ZORKMIDS> .N>>
    <RTRUE>>

<ROUTINE FAIR-PHASE-NAME ()
    <COND (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-PREOPEN> <TELL "before opening">)
          (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-OPENING> <TELL "opening">)
          (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-LATE> <TELL "late morning">)
          (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-MIDDAY> <TELL "midday">)
          (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-AFTERNOON> <TELL "afternoon">)
          (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-DUSK> <TELL "dusk">)
          (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-EVENING> <TELL "evening">)
          (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-CLOSING> <TELL "closing">)
          (T <TELL "after hours">)>>

<ROUTINE FAIR-ON-PHASE ()
    <FAIR-PLACE-CAST>
    <COND (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-DUSK>
           <MOVE ,TOMAS-QUINCE ,DANCE-PAVILION>
           <MOVE ,ORIN-BELL ,DANCE-PAVILION>)>
    <COND (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-EVENING>
           <MOVE ,TOMAS-QUINCE ,DANCE-PAVILION>
           <MOVE ,ORIN-BELL ,DANCE-PAVILION>)>
    <COND (<AND <EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-AFTERNOON>
                <ZERO? <FAIR-GET ,FAIR-SLOT-WIND>>>
           <FAIR-PUT ,FAIR-SLOT-WIND 0>)>
    <RTRUE>>

<ROUTINE I-FAIR ()
    <COND (<NOT <FAIR-HERE?>> <RFALSE>)>
    <FAIR-PUT ,FAIR-SLOT-TURN <+ <FAIR-GET ,FAIR-SLOT-TURN> 1>>
    <COND (<EQUAL? ,HERE ,GAMES-ROW>
           <FAIR-PUT ,FAIR-SLOT-GALLERY <+ <FAIR-GET ,FAIR-SLOT-GALLERY> 1>>
           <COND (<G? <FAIR-GET ,FAIR-SLOT-GALLERY> 3> <FAIR-PUT ,FAIR-SLOT-GALLERY 0>)>)>
    <COND (<G? <FAIR-GET ,FAIR-SLOT-TURN> 8>
           <FAIR-PUT ,FAIR-SLOT-TURN 0>
           <COND (<L? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-AFTER>
                  <FAIR-PUT ,FAIR-SLOT-PHASE <+ <FAIR-GET ,FAIR-SLOT-PHASE> 1>>
                  <FAIR-ON-PHASE>
                  <TELL CR "The fair day moves into " >
                  <FAIR-PHASE-NAME>
                  <TELL "." CR>)>)>
    <RFALSE>>

<OBJECT FAIR-POUCH
    (IN CLEARING)
    (SYNONYM POUCH COINS ZORKMIDS)
    (ADJECTIVE WORN COIN ZORKMID)
    (DESC "worn zorkmid pouch")
    (LDESC "A worn coin pouch lies near the northeast road, dropped by someone hurrying toward the meadow.")
    (FLAGS TAKEBIT)
    (SIZE 2)
    (ACTION FAIR-POUCH-FCN)>

<ROUTINE FAIR-POUCH-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "The pouch holds ordinary zorkmids, not prize tickets and not treasure. Twelve coins remain." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <FAIR-PUT ,FAIR-SLOT-ZORKMIDS <+ <FAIR-GET ,FAIR-SLOT-ZORKMIDS> 12>>
           <MOVE ,FAIR-POUCH ,GLOBAL-OBJECTS>
           <TELL "You take the pouch. Twelve zorkmids are now yours to spend at the fair, or to ignore." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM FAIR-ROAD
    (IN ROOMS)
    (DESC "Fair Road")
    (SW TO CLEARING)
    (NORTH TO FAIR-ENTRANCE)
    (SOUTH TO CLEARING)
    (ACTION FAIR-ROAD-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)
    (GLOBAL FOREST)>

<ROUTINE FAIR-ROAD-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "A packed public road leaves the clearing toward a meadow. ">
           <COND (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-PREOPEN>
                  <TELL "Wagons and canvas wait ahead; the grounds are not yet public.">)
                 (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-AFTER>
                  <TELL "Lanterns are out. A few service lamps mark the way back.">)
                 (T
                  <TELL "Music, frying oil, and painted signs reach you from the north. Admission, the nearest bill says, is free.">)>
           <CRLF>
           <RTRUE>)>
    <RFALSE>>

<ROOM FAIR-ENTRANCE
    (IN ROOMS)
    (DESC "Fair Entrance")
    (SOUTH TO FAIR-ROAD)
    (NORTH TO CENTRAL-MIDWAY)
    (NW TO FOOD-ROW)
    (NE TO GAMES-ROW)
    (ACTION FAIR-ENTRANCE-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE FAIR-ENTRANCE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "The Flathead Fair Association charges no general admission. Handbills sit in a crate. Paths lead north to the midway, northwest toward food, and northeast toward games. Berrin Vale treats this as a meeting point, not a toll gate." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM CENTRAL-MIDWAY
    (IN ROOMS)
    (DESC "Central Midway")
    (SOUTH TO FAIR-ENTRANCE)
    (WEST TO FOOD-ROW)
    (EAST TO GAMES-ROW)
    (NORTH TO GRAND-PAVILION)
    (NW TO MARKET-ROW)
    (NE TO FAIR-OFFICE-PRIZE-HALL)
    (ACTION CENTRAL-MIDWAY-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE CENTRAL-MIDWAY-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "The packed center of the grounds. Signs point to food, games, the Grand Pavilion, market stalls, and the Fair Office & Prize Hall. ">
           <COND (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-MIDDAY>
                  <TELL "Crowd density is at its worst and most useful.">)
                 (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-DUSK>
                  <TELL "Lamps are being lit along the guy-ropes.">)
                 (<EQUAL? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-CLOSING>
                  <TELL "Last calls drain people toward the entrance.">)
                 (T
                  <TELL "The crowd has an authored density, not an engine.">)>
           <CRLF>
           <RTRUE>)>
    <RFALSE>>

<ROOM FOOD-ROW
    (IN ROOMS)
    (DESC "Food Row")
    (EAST TO CENTRAL-MIDWAY)
    (NORTH TO MARKET-ROW)
    (SE TO FAIR-ENTRANCE)
    (WEST TO BACK-LANE)
    (NW TO BACK-LANE)
    (ACTION FOOD-ROW-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE FOOD-ROW-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Oil, sugar, and yeast. Mabel Rusk's elephant-ear stall dominates the row. ">
           <COND (<L=? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-AFTERNOON>
                  <TELL "Tomas Quince sells cold drinks from a painted cart.">)
                 (T
                  <TELL "Tomas's cold-drink cart is shuttered; a note points to The Lantern Table in the Dance Pavilion.">)>
           <CRLF>
           <RTRUE>)>
    <RFALSE>>

<ROOM GAMES-ROW
    (IN ROOMS)
    (DESC "Games Row")
    (WEST TO CENTRAL-MIDWAY)
    (NORTH TO FAIR-OFFICE-PRIZE-HALL)
    (NE TO RIDE-COURT)
    (SW TO FAIR-ENTRANCE)
    (ACTION GAMES-ROW-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE GAMES-ROW-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Midway games with different rules, not eight costumes on one roll. Jonas Pell's Ring Stand is honest. Kester Vane's cups are a separate booth. A clockwork gallery ticks through a visible cycle (" N <FAIR-GET ,FAIR-SLOT-GALLERY> ")." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM MARKET-ROW
    (IN ROOMS)
    (DESC "Market Row")
    (SOUTH TO FOOD-ROW)
    (EAST TO GRAND-PAVILION)
    (WEST TO BACK-LANE)
    (NE TO EXHIBITION-YARD)
    (ACTION MARKET-ROW-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE MARKET-ROW-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Vera Tallow sells curiosities with provenance she will not swear to. Sella Birch sells current craft she will swear to. Prices are zorkmids." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM GRAND-PAVILION
    (IN ROOMS)
    (DESC "Grand Pavilion")
    (SOUTH TO CENTRAL-MIDWAY)
    (WEST TO MARKET-ROW)
    (EAST TO FAIR-OFFICE-PRIZE-HALL)
    (NW TO EXHIBITION-YARD)
    (NE TO DANCE-PAVILION)
    (NORTH TO FISHING-POND)
    (ACTION GRAND-PAVILION-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE GRAND-PAVILION-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "A covered civic barn for announcements, judging, and weather fallback. Association property, not a second archive." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM DANCE-PAVILION
    (IN ROOMS)
    (DESC "Dance Pavilion")
    (SW TO GRAND-PAVILION)
    (SOUTH TO FAIR-OFFICE-PRIZE-HALL)
    (NORTH TO OBSERVATION-WHEEL)
    (EAST TO HOUSE-OF-MIRRORS)
    (ACTION DANCE-PAVILION-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE DANCE-PAVILION-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "A boarded floor and a low stage. Ordinary entry is free. ">
           <COND (<G=? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-DUSK>
                  <COND (<L? <FAIR-GET ,FAIR-SLOT-PHASE> ,FAIR-AFTER>
                         <TELL "The Lantern Table is in service: supper, hot drinks, and conversation without a drink minimum. Orin Bell has the band.">)
                        (T
                         <TELL "The Lantern Table is closed. Cleanup lamps only.">)>)
                 (T
                  <TELL "By day this is seating and rehearsal, not nightlife.">)>
           <CRLF>
           <RTRUE>)>
    <RFALSE>>

<ROOM RIDE-COURT
    (IN ROOMS)
    (DESC "Ride Court")
    (WEST TO FAIR-OFFICE-PRIZE-HALL)
    (SW TO GAMES-ROW)
    (NORTH TO HOUSE-OF-MIRRORS)
    (ACTION RIDE-COURT-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE RIDE-COURT-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Tilda Fen's court: a Zork-native carousel, flying chairs, and a Scenic GUE ride whose plaques congratulate Frobozz. Association permits, independent machinery except the scenic concession." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM OBSERVATION-WHEEL
    (IN ROOMS)
    (DESC "Observation Wheel")
    (WEST TO FISHING-POND)
    (SOUTH TO DANCE-PAVILION)
    (EAST TO HOUSE-OF-MIRRORS)
    (SE TO HOUSE-OF-MIRRORS)
    (ACTION OBSERVATION-WHEEL-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE OBSERVATION-WHEEL-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Association wheel. Emery Wicks will not board anyone in unsafe wind. Fare is 3 zm. Dusk is the honest time to see both land and lamps." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM WHEEL-CARRIAGE
    (IN ROOMS)
    (DESC "Wheel Carriage")
    (OUT TO OBSERVATION-WHEEL)
    (DOWN TO OBSERVATION-WHEEL)
    (ACTION WHEEL-CARRIAGE-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE WHEEL-CARRIAGE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "A latched carriage. You can see forest, the Flathead Mountains if you know them from Canyon View, and the fair itself. Emery cannot hear private talk from here merely because he operates the wheel." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM HOUSE-OF-MIRRORS
    (IN ROOMS)
    (DESC "House of Mirrors")
    (SOUTH TO RIDE-COURT)
    (WEST TO DANCE-PAVILION)
    (SW TO DANCE-PAVILION)
    (NW TO OBSERVATION-WHEEL)
    (IN TO MIRROR-FOYER)
    (ACTION HOUSE-OF-MIRRORS-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)
    (GLOBAL MIRROR-GLASS)>

<ROUTINE HOUSE-OF-MIRRORS-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Association installation. Three zorkmids at the foyer. Most glass is mundane. A small authored anomaly set exists; it is not a generator." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM MIRROR-FOYER
    (IN ROOMS)
    (DESC "Mirror Foyer")
    (OUT TO HOUSE-OF-MIRRORS)
    (NORTH TO CROOKED-GALLERY)
    (ACTION MIRROR-FOYER-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)
    (GLOBAL MIRROR-GLASS)>

<ROUTINE MIRROR-FOYER-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Ordinary mirrors establish a baseline: you look like yourself, slightly cleaner. North enters the crooked gallery." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM CROOKED-GALLERY
    (IN ROOMS)
    (DESC "Crooked Gallery")
    (SOUTH TO MIRROR-FOYER)
    (EAST TO REPEATING-PASSAGE)
    (ACTION CROOKED-GALLERY-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)
    (GLOBAL MIRROR-GLASS)>

<ROUTINE CROOKED-GALLERY-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Convex and concave glass. Apparent openings terminate at frames. A brass screw on the east frame is a physical mark, not a random maze." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM REPEATING-PASSAGE
    (IN ROOMS)
    (DESC "Repeating Passage")
    (WEST TO CROOKED-GALLERY)
    (NORTH TO CROSSED-REFLECTIONS)
    (ACTION REPEATING-PASSAGE-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)
    (GLOBAL MIRROR-GLASS)>

<ROUTINE REPEATING-PASSAGE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Parallel mirrors invent a corridor that does not continue. Draft from the north is real; the infinite east is not." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM CROSSED-REFLECTIONS
    (IN ROOMS)
    (DESC "Crossed Reflections")
    (SOUTH TO REPEATING-PASSAGE)
    (EAST TO EXIT-GALLERY)
    (ACTION CROSSED-REFLECTIONS-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)
    (GLOBAL MIRROR-GLASS)>

<ROUTINE CROSSED-REFLECTIONS-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Sightlines cross. You may see someone around a corner before you meet them. ">
           <COND (<EQUAL? <FAIR-GET ,FAIR-SLOT-LATE-MIRROR> 1>
                  <TELL "One reflection is still finishing a previous movement.">)
                 (T
                  <TELL "Tonight the glass is only clever.">)>
           <CRLF>
           <RTRUE>)>
    <RFALSE>>

<ROOM EXIT-GALLERY
    (IN ROOMS)
    (DESC "Exit Gallery")
    (WEST TO CROSSED-REFLECTIONS)
    (SOUTH TO HOUSE-OF-MIRRORS)
    (OUT TO HOUSE-OF-MIRRORS)
    (ACTION EXIT-GALLERY-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)
    (GLOBAL MIRROR-GLASS)>

<ROUTINE EXIT-GALLERY-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Ordinary exit glass. Closing never traps anyone inside; the south door remains a door." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM FISHING-POND
    (IN ROOMS)
    (DESC "Fishing Pond")
    (SOUTH TO GRAND-PAVILION)
    (WEST TO POND-PATH)
    (EAST TO OBSERVATION-WHEEL)
    (ACTION FISHING-POND-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE FISHING-POND-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "A working pond, not a spawn table. Silas Dace rents rods and verifies derby fish. Cassa Reed fishes to win. Mara likes the shaded bank." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM POND-PATH
    (IN ROOMS)
    (DESC "Pond Path")
    (EAST TO FISHING-POND)
    (SOUTH TO EXHIBITION-YARD)
    (SE TO GRAND-PAVILION)
    (ACTION POND-PATH-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE POND-PATH-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "A quieter public walk. Privacy here is crowd density, not a romance flag. Alternate fishing water lies along the bend." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM EXHIBITION-YARD
    (IN ROOMS)
    (DESC "Exhibition Yard")
    (EAST TO GRAND-PAVILION)
    (SE TO GRAND-PAVILION)
    (NORTH TO POND-PATH)
    (WEST TO BACK-LANE)
    (SW TO BACK-LANE)
    (SOUTH TO MARKET-ROW)
    (ACTION EXHIBITION-YARD-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE EXHIBITION-YARD-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Craft, mechanical, and agricultural exhibits. Misdelivered crates sometimes sit here until someone reads the marks." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM FAIR-OFFICE-PRIZE-HALL
    (IN ROOMS)
    (DESC "Fair Office & Prize Hall")
    (SOUTH TO GAMES-ROW)
    (WEST TO GRAND-PAVILION)
    (EAST TO RIDE-COURT)
    (NORTH TO DANCE-PAVILION)
    (SW TO CENTRAL-MIDWAY)
    (ACTION FAIR-OFFICE-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE FAIR-OFFICE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Current administration only. Ada Vellum keeps this fair's program, permits, entries, lost-and-found, and incident intake. Nell Harrow redeems prize tickets. Older programs live upstairs in the existing House of Records, not in a duplicate fair archive." CR>
           <RTRUE>)>
    <RFALSE>>

<ROOM BACK-LANE
    (IN ROOMS)
    (DESC "Back Lane")
    (EAST TO MARKET-ROW)
    (NE TO EXHIBITION-YARD)
    (SE TO FOOD-ROW)
    (ACTION BACK-LANE-FCN)
    (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROUTINE BACK-LANE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Deliveries, repairs, refuse, and after-hours work. Public access is contextual; cages and stores stay closed." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT FAIR-HANDBILL
    (IN FAIR-ENTRANCE)
    (SYNONYM HANDBILL BILL PROGRAM SHEET)
    (ADJECTIVE FREE EVENT)
    (DESC "fair handbill")
    (FLAGS TAKEBIT READBIT)
    (SIZE 1)
    (TEXT "Flathead Fair. Free admission. Zorkmids for food, rides, and games. Prize tickets are not money. Current office: Ada Vellum. Durable history: House of Records upstairs.")
    (ACTION FAIR-HANDBILL-FCN)>

<ROUTINE FAIR-HANDBILL-FCN ()
    <COND (<VERB? EXAMINE READ>
           <TELL <GETP ,FAIR-HANDBILL ,P?TEXT> CR>
           <RTRUE>)>
    <RFALSE>>
