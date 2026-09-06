"FLATHEAD FAIR LIFE for Release 1310"

;"Twenty named people, commerce, eight distinct games, fishing, Mara
  preferences, Lantern Table, and the F-01..F-09 incident web. No carnival
  engine. No DATE MODE. RNG commits into saveable globals."

<ROUTINE FAIR-PLACE-CAST ()
    <COND (<EQUAL? ,FAIR-PHASE ,FAIR-PREOPEN>
           <MOVE ,BERRIN-VALE ,BACK-LANE>
           <MOVE ,ADA-VELLUM ,FAIR-OFFICE-PRIZE-HALL>
           <MOVE ,MABEL-RUSK ,FOOD-ROW>
           <MOVE ,TOMAS-QUINCE ,FOOD-ROW>
           <MOVE ,SILAS-DACE ,FISHING-POND>
           <MOVE ,NELL-HARROW ,FAIR-OFFICE-PRIZE-HALL>
           <MOVE ,EMERY-WICKS ,OBSERVATION-WHEEL>
           <MOVE ,TILDA-FEN ,RIDE-COURT>
           <MOVE ,JONAS-PELL ,GAMES-ROW>
           <MOVE ,VERA-TALLOW ,MARKET-ROW>
           <MOVE ,ORIN-BELL ,GRAND-PAVILION>
           <MOVE ,EPHRAIM-PEAKE ,GLOBAL-OBJECTS>
           <MOVE ,KESTER-VANE ,GAMES-ROW>
           <MOVE ,HETTIE-BRAMM ,BACK-LANE>
           <MOVE ,SELLA-BIRCH ,MARKET-ROW>
           <MOVE ,PELLA-WREN ,GLOBAL-OBJECTS>
           <MOVE ,TOBIN-WREN ,GLOBAL-OBJECTS>
           <MOVE ,LYSA-MARR ,GLOBAL-OBJECTS>
           <MOVE ,TAVIN-ROE ,GLOBAL-OBJECTS>
           <MOVE ,CASSA-REED ,GLOBAL-OBJECTS>)
          (<L=? ,FAIR-PHASE ,FAIR-AFTERNOON>
           <MOVE ,BERRIN-VALE ,CENTRAL-MIDWAY>
           <MOVE ,ADA-VELLUM ,FAIR-OFFICE-PRIZE-HALL>
           <MOVE ,MABEL-RUSK ,FOOD-ROW>
           <MOVE ,TOMAS-QUINCE ,FOOD-ROW>
           <MOVE ,SILAS-DACE ,FISHING-POND>
           <MOVE ,NELL-HARROW ,FAIR-OFFICE-PRIZE-HALL>
           <MOVE ,EMERY-WICKS ,OBSERVATION-WHEEL>
           <MOVE ,TILDA-FEN ,RIDE-COURT>
           <MOVE ,JONAS-PELL ,GAMES-ROW>
           <MOVE ,VERA-TALLOW ,MARKET-ROW>
           <MOVE ,ORIN-BELL ,GRAND-PAVILION>
           <MOVE ,EPHRAIM-PEAKE ,FOOD-ROW>
           <MOVE ,KESTER-VANE ,GAMES-ROW>
           <MOVE ,HETTIE-BRAMM ,RIDE-COURT>
           <MOVE ,SELLA-BIRCH ,MARKET-ROW>
           <MOVE ,PELLA-WREN ,GAMES-ROW>
           <MOVE ,TOBIN-WREN ,GAMES-ROW>
           <MOVE ,LYSA-MARR ,FOOD-ROW>
           <MOVE ,TAVIN-ROE ,FISHING-POND>
           <MOVE ,CASSA-REED ,FISHING-POND>)
          (<EQUAL? ,FAIR-PHASE ,FAIR-DUSK>
           <MOVE ,BERRIN-VALE ,RIDE-COURT>
           <MOVE ,TOMAS-QUINCE ,DANCE-PAVILION>
           <MOVE ,ORIN-BELL ,DANCE-PAVILION>
           <MOVE ,EPHRAIM-PEAKE ,OBSERVATION-WHEEL>
           <MOVE ,LYSA-MARR ,DANCE-PAVILION>
           <MOVE ,TAVIN-ROE ,OBSERVATION-WHEEL>
           <MOVE ,PELLA-WREN ,FAIR-OFFICE-PRIZE-HALL>
           <MOVE ,TOBIN-WREN ,FAIR-OFFICE-PRIZE-HALL>
           <MOVE ,CASSA-REED ,POND-PATH>)
          (<EQUAL? ,FAIR-PHASE ,FAIR-EVENING>
           <MOVE ,BERRIN-VALE ,DANCE-PAVILION>
           <MOVE ,TOMAS-QUINCE ,DANCE-PAVILION>
           <MOVE ,ORIN-BELL ,DANCE-PAVILION>
           <MOVE ,LYSA-MARR ,DANCE-PAVILION>
           <MOVE ,TAVIN-ROE ,DANCE-PAVILION>
           <MOVE ,PELLA-WREN ,GLOBAL-OBJECTS>
           <MOVE ,TOBIN-WREN ,GLOBAL-OBJECTS>
           <MOVE ,CASSA-REED ,GLOBAL-OBJECTS>)
          (T
           <MOVE ,BERRIN-VALE ,FAIR-ENTRANCE>
           <MOVE ,ADA-VELLUM ,FAIR-OFFICE-PRIZE-HALL>
           <MOVE ,NELL-HARROW ,FAIR-OFFICE-PRIZE-HALL>
           <MOVE ,TOMAS-QUINCE ,BACK-LANE>
           <MOVE ,ORIN-BELL ,BACK-LANE>
           <MOVE ,MABEL-RUSK ,BACK-LANE>
           <MOVE ,KESTER-VANE ,GAMES-ROW>)>
    <COND (<NOT <ZERO? ,FAIR-KESTER-CLOSED>>
           <MOVE ,KESTER-VANE ,BACK-LANE>)>
    <RTRUE>>

<OBJECT BERRIN-VALE
    (IN CENTRAL-MIDWAY)
    (SYNONYM BERRIN VALE STEWARD)
    (ADJECTIVE FAIR)
    (DESC "Berrin Vale")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION BERRIN-FCN)>

<ROUTINE BERRIN-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Berrin Vale, fair steward: practical, not ornamental." CR>)
          (<OR <VERB? TELL FAIR-ASK HELLO>>
           <TELL "Free admission, he says. Complaints and ride shutdowns come to him. He does not know Mabel's recipes or Silas's fish tables. Older files live upstairs, not in his pocket." CR>)>
    <RTRUE>>

<OBJECT ADA-VELLUM
    (IN FAIR-OFFICE-PRIZE-HALL)
    (SYNONYM ADA VELLUM CLERK REGISTRAR)
    (DESC "Ada Vellum")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION ADA-FCN)>

<ROUTINE ADA-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Ada Vellum keeps the current fair's paperwork with a dry precision." CR>)
          (T
           <TELL "Current program, current permits, current lost-and-found, current incidents. ">
           <COND (<NOT <ZERO? ,FAIR-ADA-INCIDENT>>
                  <TELL "Kester Vane's booth is on the incident blotter: tack-wax, evidence presented, booth closed.">)
                 (T
                  <TELL "She will not summon House of Records files from this desk. If Ephraim disputes a date, the older program is upstairs.">)>
           <CRLF>)>
    <RTRUE>>

<OBJECT MABEL-RUSK
    (IN FOOD-ROW)
    (SYNONYM MABEL RUSK)
    (DESC "Mabel Rusk")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION MABEL-FCN)>

<ROUTINE MABEL-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Mabel Rusk works hot oil as if it were a civic duty." CR>)
          (T
           <TELL "Cinnamon-sugar elephant ears are 5 zm, apple-topped 6, honey-nut 7, sharing 12. ">
           <COND (<ZERO? ,FAIR-CRATE>
                  <TELL "She is short one marked sugar crate. It went to the wrong load in the Exhibition Yard.">)
                 (T
                  <TELL "The sugar crate is back. She remembers who returned it.">)>
           <CRLF>)>
    <RTRUE>>

<OBJECT TOMAS-QUINCE
    (IN FOOD-ROW)
    (SYNONYM TOMAS QUINCE)
    (DESC "Tomas Quince")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION TOMAS-FCN)>

<ROUTINE TOMAS-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Tomas Quince: drinks by day, Lantern Table at dusk." CR>)
          (T
           <SETG FAIR-DRINK-KNOWN 1>
           <TELL "The large drink is pear-lime fizz. Pear and lime. Mostly pear. Four zorkmids. At dusk he runs The Lantern Table: hot spiced cider at 3 zm, no drink minimum." CR>)>
    <RTRUE>>

<OBJECT SILAS-DACE
    (IN FISHING-POND)
    (SYNONYM SILAS DACE)
    (DESC "Silas Dace")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION SILAS-FCN)>

<ROUTINE SILAS-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Silas Dace, fishing master and the only official weigh-in." CR>)
          (T
           <TELL "Rod rental 3 zm, bait 1 zm, derby entry 5 zm. He will not recite catch tables. Cassa is a rival, not the verifier. Ordinary fish do not graduate to the House of Records." CR>)>
    <RTRUE>>

<OBJECT NELL-HARROW
    (IN FAIR-OFFICE-PRIZE-HALL)
    (SYNONYM NELL HARROW)
    (DESC "Nell Harrow")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION NELL-FCN)>

<ROUTINE NELL-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Nell Harrow is professionally immune to almost-enough tickets." CR>)
          (T
           <TELL "Redemption: prize candy 5 tickets, whistle 12, stuffed grue 40, carved dragon 80. Thirty-nine is not forty. She stays open later than the booths." CR>)>
    <RTRUE>>

<OBJECT EMERY-WICKS
    (IN OBSERVATION-WHEEL)
    (SYNONYM EMERY WICKS)
    (DESC "Emery Wicks")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION EMERY-FCN)>

<ROUTINE EMERY-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Emery Wicks watches wind more carefully than conversation." CR>)
          (<G? ,FAIR-WIND 1>
           <TELL "No boarding. The wind is past his limit. Unused fares are refunded." CR>)
          (T
           <TELL "Three zorkmids. Association wheel. He does not overhear carriage talk." CR>)>
    <RTRUE>>

<OBJECT TILDA-FEN
    (IN RIDE-COURT)
    (SYNONYM TILDA FEN)
    (DESC "Tilda Fen")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION TILDA-FCN)>

<ROUTINE TILDA-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Tilda Fen keeps carousel and chairs as independent machinery under Association permit." CR>)
          (T
           <TELL "Carousel 2 zm. Flying chairs 2 zm, more wind-sensitive. Scenic GUE ride 3 zm is a Frobozz concession and a liar in gilt. Children fight over the grue mount. Mara's dragon is usually free." CR>)>
    <RTRUE>>

<OBJECT JONAS-PELL
    (IN GAMES-ROW)
    (SYNONYM JONAS PELL)
    (DESC "Jonas Pell")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION JONAS-FCN)>

<ROUTINE JONAS-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Jonas Pell runs a ring stand that can be understood." CR>)
          (T
           <TELL "Two zorkmids. Near pegs are honest. Far pegs pay more. He does not alter equipment. Kester's cups are not his booth." CR>)>
    <RTRUE>>

<OBJECT VERA-TALLOW
    (IN MARKET-ROW)
    (SYNONYM VERA TALLOW)
    (DESC "Vera Tallow")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION VERA-FCN)>

<ROUTINE VERA-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Vera Tallow sells things that may be older than her pitch." CR>)
          (T
           <TELL "She distinguishes what she knows, what she suspects, and what a previous owner claimed. A stamped pond token would interest her as metal, not as certified history." CR>)>
    <RTRUE>>

<OBJECT ORIN-BELL
    (IN GRAND-PAVILION)
    (SYNONYM ORIN BELL)
    (DESC "Orin Bell")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION ORIN-FCN)>

<ROUTINE ORIN-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Orin Bell, bandleader. Requests are possible; omniscience is not." CR>)
          (<ZERO? ,FAIR-SHEET>
           <TELL "A set sheet blew toward Pond Path. He can play without it, but the intended order would be better." CR>)
          (T
           <TELL "The sheet came back. The evening program is the one he meant." CR>)>
    <RTRUE>>

<OBJECT EPHRAIM-PEAKE
    (IN FOOD-ROW)
    (SYNONYM EPHRAIM PEAKE)
    (DESC "Ephraim Peake")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION EPHRAIM-FCN)>

<ROUTINE EPHRAIM-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Ephraim Peake remembers earlier fairs at a volume the documents may not match." CR>)
          (T
           <TELL "Elephant ears used to cost two zorkmids, he says. The current program's founding date is wrong. Ada's copy is current office paper. The older program is upstairs. He may be mistaken. That is the point." CR>)>
    <RTRUE>>

<OBJECT KESTER-VANE
    (IN GAMES-ROW)
    (SYNONYM KESTER VANE)
    (DESC "Kester Vane")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION KESTER-FCN)>

<ROUTINE KESTER-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Kester Vane is personable about the difference between difficult and unfair." CR>)
          (<NOT <ZERO? ,FAIR-KESTER-CLOSED>>
           <TELL "The booth is closed pending Association sanction. He calls it a misunderstanding." CR>)
          (T
           <TELL "One zorkmid a round. Watch the pea. He will not volunteer the tack-wax under one cup's lip." CR>)>
    <RTRUE>>

<OBJECT HETTIE-BRAMM
    (IN RIDE-COURT)
    (SYNONYM HETTIE BRAMM)
    (DESC "Hettie Bramm")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION HETTIE-FCN)>

<ROUTINE HETTIE-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Hettie Bramm diagnoses machinery. She is not the boss of Emery or Tilda." CR>)
          (T
           <TELL "If a reflection lagged, she can inspect frame, glass, and lamps. No mechanical cause is a bounded finding, not proof of the impossible." CR>)>
    <RTRUE>>

<OBJECT SELLA-BIRCH
    (IN MARKET-ROW)
    (SYNONYM SELLA BIRCH)
    (DESC "Sella Birch")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION SELLA-FCN)>

<ROUTINE SELLA-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Sella Birch sells current craft, including a small carved dragon." CR>)
          (T
           <TELL "She can speak to tool marks on an old token without certifying its year. Carved dragon, 8 zm. Mara has been seen looking at it." CR>)>
    <RTRUE>>

<OBJECT PELLA-WREN
    (IN GAMES-ROW)
    (SYNONYM PELLA WREN)
    (DESC "Pella Wren")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION PELLA-FCN)>

<ROUTINE PELLA-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Pella Wren holds " N ,PELLA-TICKETS " tickets and a specific opinion about a stuffed grue." CR>)
          (T
           <TELL "The grue is forty tickets. She has thirty-nine. Nell will not round. Pella can change her mind; the count is state, not a speech." CR>)>
    <RTRUE>>

<OBJECT TOBIN-WREN
    (IN GAMES-ROW)
    (SYNONYM TOBIN WREN)
    (DESC "Tobin Wren")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION TOBIN-FCN)>

<ROUTINE TOBIN-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Tobin Wren is Pella's father, tired in a fair-specific way." CR>)
          (T
           <TELL "He will not bully Nell, and he will not buy the problem away unless the world actually offers that sale." CR>)>
    <RTRUE>>

<OBJECT LYSA-MARR
    (IN FOOD-ROW)
    (SYNONYM LYSA MARR)
    (DESC "Lysa Marr")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION LYSA-FCN)>

<ROUTINE LYSA-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Lysa Marr likes dancing and is skeptical of cups." CR>)
          (T
           <TELL "Tavin may be at the wheel or the pond. They are two people, not a COUPLE object." CR>)>
    <RTRUE>>

<OBJECT TAVIN-ROE
    (IN FISHING-POND)
    (SYNONYM TAVIN ROE)
    (DESC "Tavin Roe")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION TAVIN-FCN)>

<ROUTINE TAVIN-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Tavin Roe prefers the wheel and the pond path to crowded dancing, and still dances sometimes." CR>)
          (T
           <TELL "He will not narrate Lysa's private thoughts." CR>)>
    <RTRUE>>

<OBJECT CASSA-REED
    (IN FISHING-POND)
    (SYNONYM CASSA REED)
    (DESC "Cassa Reed")
    (FLAGS ACTORBIT NARTICLEBIT)
    (ACTION CASSA-FCN)>

<ROUTINE CASSA-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Cassa Reed fishes to beat people, including you and Mara." CR>)
          (T
           <TELL "Shaded bank, patience, cheap bait. She cannot verify her own record. Silas remains official." CR>)>
    <RTRUE>>

<OBJECT ELEPHANT-EAR
    (IN FOOD-ROW)
    (SYNONYM EAR EARS)
    (ADJECTIVE ELEPHANT CINNAMON SUGAR)
    (DESC "cinnamon-sugar elephant ear")
    (FLAGS NDESCBIT FOODBIT)
    (ACTION ELEPHANT-EAR-FCN)>

<OBJECT APPLE-EAR
    (IN FOOD-ROW)
    (SYNONYM EAR EARS)
    (ADJECTIVE APPLE TOPPED)
    (DESC "apple-topped elephant ear")
    (FLAGS NDESCBIT FOODBIT)
    (ACTION APPLE-EAR-FCN)>

<OBJECT LARGE-DRINK
    (IN FOOD-ROW)
    (SYNONYM DRINK FIZZ)
    (ADJECTIVE LARGE PEAR LIME)
    (DESC "large drink")
    (FLAGS NDESCBIT)
    (ACTION LARGE-DRINK-FCN)>

<OBJECT HOT-CIDER
    (IN DANCE-PAVILION)
    (SYNONYM CIDER DRINK)
    (ADJECTIVE HOT SPICED)
    (DESC "hot spiced cider")
    (FLAGS NDESCBIT)
    (ACTION HOT-CIDER-FCN)>

<OBJECT CARVED-DRAGON
    (IN MARKET-ROW)
    (SYNONYM DRAGON CARVING)
    (ADJECTIVE CARVED SMALL)
    (DESC "small carved dragon")
    (FLAGS NDESCBIT TAKEBIT)
    (ACTION CARVED-DRAGON-FCN)>

<OBJECT SUGAR-CRATE
    (IN EXHIBITION-YARD)
    (SYNONYM CRATE BOX)
    (ADJECTIVE SUGAR MARKED)
    (DESC "marked sugar crate")
    (LDESC "A crate stenciled for Mabel Rusk sits among exhibition loads.")
    (FLAGS TAKEBIT)
    (SIZE 8)
    (ACTION SUGAR-CRATE-FCN)>

<OBJECT LOST-PURSE
    (IN CENTRAL-MIDWAY)
    (SYNONYM PURSE BAG)
    (ADJECTIVE LOST SMALL)
    (DESC "small lost purse")
    (LDESC "A small purse lies where the midday crowd is worst.")
    (FLAGS TAKEBIT CONTBIT SEARCHBIT OPENBIT)
    (CAPACITY 4)
    (ACTION LOST-PURSE-FCN)>

<OBJECT ORIN-SHEET
    (IN POND-PATH)
    (SYNONYM SHEET MUSIC)
    (ADJECTIVE ORIN SET)
    (DESC "set sheet")
    (FLAGS TAKEBIT)
    (SIZE 1)
    (ACTION ORIN-SHEET-FCN)>

<OBJECT RING-STAND
    (IN GAMES-ROW)
    (SYNONYM STAND RINGS RING)
    (ADJECTIVE RING JONAS)
    (DESC "ring stand")
    (FLAGS NDESCBIT)
    (ACTION RING-STAND-FCN)>

<OBJECT BOTTLE-STACK
    (IN GAMES-ROW)
    (SYNONYM BOTTLES STACK)
    (ADJECTIVE BOTTLE)
    (DESC "bottle stack")
    (FLAGS NDESCBIT)
    (ACTION BOTTLE-STACK-FCN)>

<OBJECT BELL-STRIKER
    (IN GAMES-ROW)
    (SYNONYM BELL STRIKER)
    (ADJECTIVE FLATHEAD)
    (DESC "Flathead bell striker")
    (FLAGS NDESCBIT)
    (ACTION BELL-STRIKER-FCN)>

<OBJECT TARGET-GALLERY
    (IN GAMES-ROW)
    (SYNONYM GALLERY TARGETS)
    (ADJECTIVE CLOCKWORK TARGET)
    (DESC "clockwork target gallery")
    (FLAGS NDESCBIT)
    (ACTION TARGET-GALLERY-FCN)>

<OBJECT HORSESHOE-PIT
    (IN GAMES-ROW)
    (SYNONYM HORSESHOES PIT STAKES)
    (DESC "horseshoe pit")
    (FLAGS NDESCBIT)
    (ACTION HORSESHOE-PIT-FCN)>

<OBJECT MISSING-TABLE
    (IN GAMES-ROW)
    (SYNONYM TABLE TRAY)
    (ADJECTIVE MEMORY MISSING)
    (DESC "memory table")
    (FLAGS NDESCBIT)
    (ACTION MISSING-TABLE-FCN)>

<OBJECT SHELL-BOOTH
    (IN GAMES-ROW)
    (SYNONYM SHELLS CUPS BOOTH)
    (ADJECTIVE SHELL CUP)
    (DESC "shell-and-cup booth")
    (FLAGS NDESCBIT)
    (ACTION SHELL-BOOTH-FCN)>

<OBJECT WAX-CUP
    (IN GAMES-ROW)
    (SYNONYM CUP LIP WAX)
    (ADJECTIVE TACK WAXED)
    (DESC "tack-waxed cup")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION WAX-CUP-FCN)>

<OBJECT CRITTER-BOARD
    (IN GAMES-ROW)
    (SYNONYM BOARD RACE CRITTERS)
    (ADJECTIVE CLOCKWORK RACE)
    (DESC "clockwork critter race board")
    (FLAGS NDESCBIT)
    (ACTION CRITTER-BOARD-FCN)>

<OBJECT CAROUSEL
    (IN RIDE-COURT)
    (SYNONYM CAROUSEL MERRY)
    (DESC "carousel")
    (FLAGS NDESCBIT)
    (ACTION CAROUSEL-FCN)>

<OBJECT FLYING-CHAIRS
    (IN RIDE-COURT)
    (SYNONYM CHAIRS SWINGS)
    (ADJECTIVE FLYING)
    (DESC "flying chairs")
    (FLAGS NDESCBIT)
    (ACTION FLYING-CHAIRS-FCN)>

<OBJECT SCENIC-RIDE
    (IN RIDE-COURT)
    (SYNONYM RIDE EMPIRE)
    (ADJECTIVE SCENIC GUE)
    (DESC "Scenic Great Underground Empire ride")
    (FLAGS NDESCBIT)
    (ACTION SCENIC-RIDE-FCN)>

<OBJECT FAIR-WHEEL
    (IN OBSERVATION-WHEEL)
    (SYNONYM WHEEL)
    (ADJECTIVE OBSERVATION)
    (DESC "observation wheel")
    (FLAGS NDESCBIT)
    (ACTION FAIR-WHEEL-FCN)>

<OBJECT MIRROR-GLASS
    (IN LOCAL-GLOBALS)
    (SYNONYM MIRROR GLASS REFLECTION)
    (DESC "mirror")
    (FLAGS NDESCBIT)
    (ACTION MIRROR-GLASS-FCN)>

<OBJECT RENTAL-ROD
    (IN FISHING-POND)
    (SYNONYM ROD POLE)
    (ADJECTIVE RENTAL)
    (DESC "rental rod")
    (FLAGS NDESCBIT)
    (ACTION RENTAL-ROD-FCN)>

<OBJECT POND-TOKEN
    (SYNONYM TOKEN)
    (ADJECTIVE OLD STAMPED FAIR)
    (DESC "old stamped fair token")
    (FLAGS TAKEBIT)
    (SIZE 1)
    (ACTION POND-TOKEN-FCN)>

<OBJECT STUFFED-GRUE
    (IN FAIR-OFFICE-PRIZE-HALL)
    (SYNONYM GRUE)
    (ADJECTIVE STUFFED PRIZE)
    (DESC "stuffed grue")
    (FLAGS NDESCBIT)
    (ACTION STUFFED-GRUE-FCN)>

<OBJECT PRIZE-WHISTLE
    (IN FAIR-OFFICE-PRIZE-HALL)
    (SYNONYM WHISTLE)
    (ADJECTIVE PRIZE)
    (DESC "prize whistle")
    (FLAGS NDESCBIT)>

<OBJECT PRIZE-CANDY
    (IN FAIR-OFFICE-PRIZE-HALL)
    (SYNONYM CANDY SWEET)
    (ADJECTIVE PRIZE)
    (DESC "prize candy")
    (FLAGS NDESCBIT FOODBIT)>

<ROUTINE ELEPHANT-EAR-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Hot fried dough, cinnamon sugar. Five zorkmids. Signature baseline." CR>)
          (<VERB? BUY FAIR-BUY>
           <COND (<NOT <FAIR-PAY 5>> <RTRUE>)>
           <MOVE ,ELEPHANT-EAR ,WINNER>
           <FCLEAR ,ELEPHANT-EAR ,NDESCBIT>
           <TELL "Mabel wraps a cinnamon-sugar elephant ear. Five zm." CR>)
          (<VERB? EAT>
           <COND (<IN? ,ELEPHANT-EAR ,WINNER>
                  <MOVE ,ELEPHANT-EAR ,FOOD-ROW>
                  <FSET ,ELEPHANT-EAR ,NDESCBIT>
                  <TELL "Sugar, oil, and a fair that does not require this to finish Zork." CR>)
                 (T
                  <TELL "Buy it first." CR>)>)>
    <RTRUE>>

<ROUTINE APPLE-EAR-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Apple-topped, 6 zm. Sticky. Mara's baseline favorite once she has a choice." CR>)
          (<VERB? BUY FAIR-BUY>
           <COND (<NOT <FAIR-PAY 6>> <RTRUE>)>
           <MOVE ,APPLE-EAR ,WINNER>
           <FCLEAR ,APPLE-EAR ,NDESCBIT>
           <TELL "Apple-topped elephant ear. Mara may want this more than you do." CR>)
          (<VERB? EAT>
           <COND (<IN? ,APPLE-EAR ,WINNER>
                  <MOVE ,APPLE-EAR ,FOOD-ROW>
                  <FSET ,APPLE-EAR ,NDESCBIT>
                  <TELL "Sticky. Worth the 6 zm if you meant it." CR>)
                 (T <TELL "Buy it first." CR>)>)>
    <RTRUE>>

<ROUTINE LARGE-DRINK-FCN ()
    <COND (<VERB? EXAMINE>
           <COND (<ZERO? ,FAIR-DRINK-KNOWN>
                  <TELL "A large drink in a waxed cup. Four zorkmids. The flavor is not printed." CR>)
                 (T
                  <TELL "Pear-lime fizz. Pear and lime. Mostly pear. Four zm." CR>)>)
          (<VERB? BUY FAIR-BUY>
           <COND (<NOT <FAIR-PAY 4>> <RTRUE>)>
           <MOVE ,LARGE-DRINK ,WINNER>
           <FCLEAR ,LARGE-DRINK ,NDESCBIT>
           <TELL "You buy the large drink." CR>)
          (<VERB? SMELL TASTE DRINK>
           <SETG FAIR-DRINK-KNOWN 1>
           <TELL "Pear and lime. Mostly pear." CR>)>
    <RTRUE>>

<ROUTINE HOT-CIDER-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Hot spiced cider, 3 zm. Tomas serves it at The Lantern Table from dusk." CR>)
          (<VERB? BUY FAIR-BUY>
           <COND (<L? ,FAIR-PHASE ,FAIR-DUSK>
                  <TELL "The Lantern Table is not yet open." CR>)
                 (<NOT <FAIR-PAY 3>> <RTRUE>)
                 (T
                  <TELL "Tomas pours cider. No drink minimum applied." CR>)>)>
    <RTRUE>>

<ROUTINE CARVED-DRAGON-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Sella's current work. Eight zorkmids. Meaningful if you keep it, not because it is expensive." CR>)
          (<VERB? BUY FAIR-BUY>
           <COND (<NOT <FAIR-PAY 8>> <RTRUE>)>
           <MOVE ,CARVED-DRAGON ,WINNER>
           <FCLEAR ,CARVED-DRAGON ,NDESCBIT>
           <TELL "Sella wraps the carved dragon. She made this one." CR>)>
    <RTRUE>>

<ROUTINE SUGAR-CRATE-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Stenciled for Mabel Rusk, Food Row. Misdelivered, not stolen." CR>)
          (<AND <VERB? GIVE> <EQUAL? ,PRSI ,MABEL-RUSK>>
           <MOVE ,SUGAR-CRATE ,GLOBAL-OBJECTS>
           <SETG FAIR-CRATE 1>
           <TELL "Mabel checks the marks. \"That's mine.\" She sends over a cinnamon-sugar ear without charging you." CR>
           <MOVE ,ELEPHANT-EAR ,WINNER>
           <FCLEAR ,ELEPHANT-EAR ,NDESCBIT>)>
    <RFALSE>>

<ROUTINE LOST-PURSE-FCN ()
    <COND (<VERB? EXAMINE LOOK-INSIDE>
           <TELL "A visiting purse: a handkerchief initialed M.K. and 8 zorkmids. Ada will take it as current lost property. Keeping it is ordinary property consequence, not a morality meter." CR>)
          (<AND <VERB? GIVE> <EQUAL? ,PRSI ,ADA-VELLUM>>
           <MOVE ,LOST-PURSE ,GLOBAL-OBJECTS>
           <SETG FAIR-PURSE 1>
           <TELL "Ada logs current lost property. This will not become a House of Records file." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE ORIN-SHEET-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Orin Bell's intended order, wind-displaced." CR>)
          (<AND <VERB? GIVE> <EQUAL? ,PRSI ,ORIN-BELL>>
           <MOVE ,ORIN-SHEET ,GLOBAL-OBJECTS>
           <SETG FAIR-SHEET 1>
           <TELL "Orin nods. The evening will use the intended piece, not the substitute." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE RING-STAND-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Near pegs and far pegs. Rings that teach how they fall." CR>)
          (<VERB? PLAY FAIR-PLAY THROW>
           <COND (<NOT <FAIR-PAY 2>> <RTRUE>)>
           <SETG FAIR-RING-WINS <+ ,FAIR-RING-WINS 1>>
           <COND (<EQUAL? ,FAIR-RING-WINS 1>
                  <SETG FAIR-TICKETS <+ ,FAIR-TICKETS 2>>
                  <TELL "The near peg takes the ring. Two tickets. Jonas does not hide the lesson." CR>)
                 (T
                  <SETG FAIR-TICKETS <+ ,FAIR-TICKETS 1>>
                  <TELL "Another near hit. Repeat awards diminish. Far pegs still pay more if you earn them." CR>)>)>
    <RTRUE>>

<ROUTINE BOTTLE-STACK-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "The base bottles take the force. Hitting the top first wastes a throw." CR>
           <FSET ,BOTTLE-STACK ,TOUCHBIT>)
          (<VERB? PLAY FAIR-PLAY>
           <COND (<NOT <FAIR-PAY 2>> <RTRUE>)>
           <COND (<FSET? ,BOTTLE-STACK ,TOUCHBIT>
                  <SETG FAIR-TICKETS <+ ,FAIR-TICKETS 5>>
                  <TELL "You take the base. Clean knockdown. Five tickets." CR>)
                 (T
                  <TELL "The top bottles dance and the base stays. Zero tickets. The stack is still readable." CR>)>)>
    <RTRUE>>

<ROUTINE BELL-STRIKER-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "A strength tester with GUE grades instead of carnival cliche. Best today: " N ,FAIR-BELL-BEST "." CR>)
          (<VERB? PLAY FAIR-PLAY>
           <COND (<NOT <FAIR-PAY 2>> <RTRUE>)>
           <SETG FAIR-BELL-BEST 4>
           <SETG FAIR-TICKETS <+ ,FAIR-TICKETS 3>>
           <TELL "The striker reaches provincial-grade. Three tickets. No STR stat is invented for this booth." CR>)>
    <RTRUE>>

<ROUTINE TARGET-GALLERY-FCN ()
    <COND (<VERB? EXAMINE WATCH FAIR-WATCH>
           <TELL "Targets cycle 0-3. Cycle is now " N ,FAIR-GALLERY ". Shoot when it is 2." CR>)
          (<VERB? PLAY FAIR-PLAY>
           <COND (<NOT <FAIR-PAY 3>> <RTRUE>)>
           <COND (<EQUAL? ,FAIR-GALLERY 2>
                  <SETG FAIR-TICKETS <+ ,FAIR-TICKETS 8>>
                  <TELL "The mechanism is where you waited for it. Eight tickets." CR>)
                 (T
                  <TELL "Wrong phase. The gallery is deterministic after you watch it. Two tickets of pity." CR>
                  <SETG FAIR-TICKETS <+ ,FAIR-TICKETS 2>>)>)>
    <RTRUE>>

<ROUTINE HORSESHOE-PIT-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Skill with bounded chance. Last committed result: " N ,FAIR-SHOE-LAST "." CR>)
          (<VERB? PLAY FAIR-PLAY>
           <COND (<NOT <FAIR-PAY 2>> <RTRUE>)>
           <COND (<ZERO? ,FAIR-SHOE-LAST>
                  <SETG FAIR-SHOE-LAST <RANDOM 4>>
                  <COND (<EQUAL? ,FAIR-SHOE-LAST 0> <SETG FAIR-SHOE-LAST 1>)>)>
           <SETG FAIR-TICKETS <+ ,FAIR-TICKETS ,FAIR-SHOE-LAST>>
           <TELL "The shoes land. Result band " N ,FAIR-SHOE-LAST " is now a world fact." CR>)>
    <RTRUE>>

<ROUTINE MISSING-TABLE-FCN ()
    <COND (<VERB? EXAMINE>
           <SETG FAIR-MISSING 1>
           <TELL "Whistle, ribbon, carved beetle, folded handbill, brass button. Then a cloth. After the cloth, the whistle is gone." CR>)
          (<VERB? PLAY FAIR-PLAY>
           <COND (<NOT <FAIR-PAY 2>> <RTRUE>)>
           <COND (<EQUAL? ,FAIR-MISSING 1>
                  <SETG FAIR-TICKETS <+ ,FAIR-TICKETS 3>>
                  <TELL "The whistle. Three tickets. Mara would have beaten you on a second round." CR>)
                 (T
                  <TELL "You did not look. Guessing is not the mechanic." CR>)>)>
    <RTRUE>>

<ROUTINE SHELL-BOOTH-FCN ()
    <COND (<NOT <ZERO? ,FAIR-KESTER-CLOSED>>
           <TELL "The booth is closed under Association sanction." CR>
           <RTRUE>)
          (<VERB? EXAMINE>
           <TELL "Three cups. One has a slightly heavier lip. Kester's hands are faster when money is down." CR>)
          (<VERB? PLAY FAIR-PLAY>
           <COND (<NOT <FAIR-PAY 1>> <RTRUE>)>
           <TELL "You track the pea to the middle cup. Kester lifts the left. Empty. The pea is not on the table; it adhered to tack-wax under a lip. The answer did not move in the author's head. It moved on equipment." CR>
           <SETG FAIR-PEA 0>)>
    <RTRUE>>

<ROUTINE WAX-CUP-FCN ()
    <COND (<VERB? EXAMINE LOOK-INSIDE TOUCH>
           <TELL "A thin tack-wax patch under the inner lip. Residue would match the pea. This is evidence, not a CHEATING flag." CR>
           <RTRUE>)
          (<AND <VERB? GIVE SHOW> <EQUAL? ,PRSI ,BERRIN-VALE ,ADA-VELLUM>>
           <SETG FAIR-KESTER-CLOSED 1>
           <SETG FAIR-ADA-INCIDENT 1>
           <SETG FAIR-ZORKMIDS <+ ,FAIR-ZORKMIDS 1>>
           <MOVE ,KESTER-VANE ,BACK-LANE>
           <TELL "Berrin orders the booth closed. Ada files a current incident. One zm restitution. This blotter does not automatically become House of Records history." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CRITTER-BOARD-FCN ()
    <COND (<VERB? EXAMINE WATCH FAIR-WATCH>
           <COND (<ZERO? ,FAIR-RACE-WIN>
                  <SETG FAIR-RACE-WIN 3>)>
           <TELL "Watching is free. Number 3, the brass newt, is committed as today's winner. Betting is not required for tickets or Zork." CR>)>
    <RTRUE>>

<ROUTINE CAROUSEL-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Carved grue, cyclops, dragon, sea serpent, unicorn, giant songbird, and a dignified pack-beast. Mara's baseline is the dragon." CR>)
          (<VERB? RIDE FAIR-RIDE PLAY>
           <COND (<NOT <FAIR-PAY 2>> <RTRUE>)>
           <TELL "You take a mount. The dragon waits if Mara wants it. No stats are granted." CR>)>
    <RTRUE>>

<ROUTINE FLYING-CHAIRS-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "More wind-sensitive than the carousel." CR>)
          (<VERB? RIDE FAIR-RIDE>
           <COND (<G? ,FAIR-WIND 0>
                  <TELL "Tilda has the chairs closed for wind. The carousel can still run." CR>)
                 (<NOT <FAIR-PAY 2>> <RTRUE>)
                 (T
                  <TELL "Air, motion, the fair turning below." CR>)>)>
    <RTRUE>>

<ROUTINE SCENIC-RIDE-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Frobozz concession. A cleaned-up empire. Dam #3 looks like a civic garden." CR>)
          (<VERB? RIDE FAIR-RIDE>
           <COND (<NOT <FAIR-PAY 3>> <RTRUE>)>
           <TELL "The plaques congratulate Frobozz. If you have seen the Dam, the ride is wrong on purpose." CR>)>
    <RTRUE>>

<ROUTINE FAIR-WHEEL-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Fare 3 zm. Dusk is when Mara prefers it." CR>)
          (<VERB? RIDE FAIR-RIDE BOARD>
           <COND (<G? ,FAIR-WIND 1>
                  <COND (<NOT <ZERO? ,FAIR-WHEEL-PAID>>
                         <SETG FAIR-WHEEL-PAID 0>
                         <SETG FAIR-ZORKMIDS <+ ,FAIR-ZORKMIDS 3>>
                         <TELL "Emery refunds the unused fare. Wind closed the wheel." CR>)
                        (T
                         <TELL "No sale. The wind is already past his limit." CR>)>)
                 (<NOT <FAIR-PAY 3>> <RTRUE>)
                 (T
                  <SETG FAIR-WHEEL-PAID 1>
                  <SETG HERE ,WHEEL-CARRIAGE>
                  <MOVE ,WINNER ,WHEEL-CARRIAGE>
                  <TELL "Emery boards you. The carriage rises." CR>
                  <V-LOOK>)>)>
    <RTRUE>>

<ROUTINE MIRROR-GLASS-FCN ()
    <COND (<NOT <OR <EQUAL? ,HERE ,HOUSE-OF-MIRRORS ,MIRROR-FOYER ,CROOKED-GALLERY>
                    <EQUAL? ,HERE ,REPEATING-PASSAGE ,CROSSED-REFLECTIONS ,EXIT-GALLERY>>>
           <RFALSE>)
          (<VERB? EXAMINE LOOK-INSIDE>
           <COND (<EQUAL? ,HERE ,CROSSED-REFLECTIONS>
                  <SETG FAIR-LATE-MIRROR 1>
                  <TELL "Your reflection finishes the last gesture a beat late, then catches up. Authored, repeatable, not a portal." CR>)
                 (T
                  <TELL "Mundane optics. Distortion is construction." CR>)>)
          (<VERB? MUNG ATTACK>
           <TELL "Breaking glass here is ordinary destruction, not an attraction special case. Mara would object without a real reason." CR>)>
    <RTRUE>>

<ROUTINE RENTAL-ROD-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Silas rents these for 3 zm. Fishing does not require a legendary spawn class." CR>)
          (<VERB? BUY FAIR-BUY TAKE>
           <COND (<NOT <FAIR-PAY 3>> <RTRUE>)>
           <MOVE ,RENTAL-ROD ,WINNER>
           <FCLEAR ,RENTAL-ROD ,NDESCBIT>
           <TELL "Rod rented. Return it by dusk weigh-in." CR>)>
    <RTRUE>>

<ROUTINE POND-TOKEN-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "An old stamped fair token. Physical object. Ada can say what current paper shows. Ephraim will claim a year. Sella can talk about the stamp. The House of Records may hold an older program. None of them replace the token with a flag." CR>)>
    <RTRUE>>

<ROUTINE STUFFED-GRUE-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Forty tickets. Pella wants this one. Purchase versions exist in the price book; this is the prize copy." CR>)
          (<VERB? FAIR-REDEEM>
           <V-FAIR-REDEEM>)>
    <RTRUE>>

<ROUTINE V-FAIR-BUY ()
    <COND (<NOT <FAIR-HERE?>>
           <TELL "There is no fair stall here." CR>)
          (<EQUAL? ,PRSO ,ELEPHANT-EAR> <ELEPHANT-EAR-FCN>)
          (<EQUAL? ,PRSO ,APPLE-EAR> <APPLE-EAR-FCN>)
          (<EQUAL? ,PRSO ,LARGE-DRINK> <LARGE-DRINK-FCN>)
          (<EQUAL? ,PRSO ,HOT-CIDER> <HOT-CIDER-FCN>)
          (<EQUAL? ,PRSO ,CARVED-DRAGON> <CARVED-DRAGON-FCN>)
          (<EQUAL? ,PRSO ,RENTAL-ROD> <RENTAL-ROD-FCN>)
          (T
           <TELL "That is not priced as fair commerce, or the vendor is not selling it now." CR>)>
    <RTRUE>>

<ROUTINE V-FAIR-PLAY ()
    <COND (<EQUAL? ,PRSO ,RING-STAND> <RING-STAND-FCN>)
          (<EQUAL? ,PRSO ,BOTTLE-STACK> <BOTTLE-STACK-FCN>)
          (<EQUAL? ,PRSO ,BELL-STRIKER> <BELL-STRIKER-FCN>)
          (<EQUAL? ,PRSO ,TARGET-GALLERY> <TARGET-GALLERY-FCN>)
          (<EQUAL? ,PRSO ,HORSESHOE-PIT> <HORSESHOE-PIT-FCN>)
          (<EQUAL? ,PRSO ,MISSING-TABLE> <MISSING-TABLE-FCN>)
          (<EQUAL? ,PRSO ,SHELL-BOOTH> <SHELL-BOOTH-FCN>)
          (T <TELL "Play a specific booth." CR>)>
    <RTRUE>>

<ROUTINE V-FAIR-RIDE ()
    <COND (<EQUAL? ,PRSO ,CAROUSEL> <CAROUSEL-FCN>)
          (<EQUAL? ,PRSO ,FLYING-CHAIRS> <FLYING-CHAIRS-FCN>)
          (<EQUAL? ,PRSO ,SCENIC-RIDE> <SCENIC-RIDE-FCN>)
          (<EQUAL? ,PRSO ,FAIR-WHEEL> <FAIR-WHEEL-FCN>)
          (T <TELL "Ride a named attraction." CR>)>
    <RTRUE>>

<ROUTINE V-FAIR-FISH ("AUX" ROLL)
    <COND (<AND <NOT <EQUAL? ,HERE ,FISHING-POND>>
                <NOT <EQUAL? ,HERE ,POND-PATH>>>
           <TELL "There is no fair pond here." CR>
           <RTRUE>)
          (<NOT <IN? ,RENTAL-ROD ,WINNER>>
           <TELL "Silas will rent a rod. Fishing without one is just watching water." CR>
           <RTRUE>)>
    <COND (<ZERO? ,FAIR-CATCH>
           <SET ROLL <RANDOM 6>>
           <COND (<EQUAL? ,HERE ,POND-PATH> <SET ROLL <+ .ROLL 1>>)>
           <COND (<G? .ROLL 5>
                  <SETG FAIR-CATCH 2>
                  <MOVE ,POND-TOKEN ,WINNER>
                  <SETG FAIR-TOKEN 1>
                  <TELL "You snag not a fish but an old stamped fair token. The catch is committed." CR>)
                 (<G? .ROLL 3>
                  <SETG FAIR-CATCH 1>
                  <TELL "A redfin bream. Ordinary, real, and not a legendary class. Committed." CR>)
                 (T
                  <SETG FAIR-CATCH 3>
                  <TELL "A rusted prize whistle, junk fixture of this pond. Committed." CR>)>)
          (T
           <TELL "The last catch remains the last catch until you weigh, release, or keep it. It does not reroll because you looked again." CR>)>
    <RTRUE>>

<ROUTINE V-FAIR-WEIGH ()
    <COND (<NOT <IN? ,SILAS-DACE ,HERE>>
           <TELL "Silas has to be present to verify." CR>)
          (<EQUAL? ,FAIR-CATCH 1>
           <SETG FAIR-RECORD-FISH 1>
           <TELL "Silas records a current-fair ordinary bream. It is not automatic archive material." CR>)
          (<EQUAL? ,FAIR-CATCH 2>
           <TELL "Silas knows tokens have come up before. Current office can look at the stamp. History is upstairs." CR>)
          (T
           <TELL "Nothing derby-eligible is on the line." CR>)>
    <RTRUE>>

<ROUTINE V-FAIR-DANCE ()
    <COND (<NOT <EQUAL? ,HERE ,DANCE-PAVILION>>
           <TELL "The Dance Pavilion is the place." CR>)
          (<L? ,FAIR-PHASE ,FAIR-DUSK>
           <TELL "Orin is not yet running the evening program." CR>)
          (T
           <TELL "Ordinary pavilion access is free. You dance. Mara may accept or refuse according to her own state, not a DATE MODE." CR>
           <FAIR-MARA-DANCE>)>
    <RTRUE>>

<ROUTINE V-FAIR-WATCH ()
    <COND (<EQUAL? ,PRSO ,TARGET-GALLERY> <TARGET-GALLERY-FCN>)
          (<EQUAL? ,PRSO ,CRITTER-BOARD> <CRITTER-BOARD-FCN>)
          (T <TELL "Watch a race or the gallery cycle." CR>)>
    <RTRUE>>

<ROUTINE V-FAIR-ASK ()
    <COND (<EQUAL? ,PRSO ,BERRIN-VALE> <BERRIN-FCN>)
          (<EQUAL? ,PRSO ,ADA-VELLUM> <ADA-FCN>)
          (<EQUAL? ,PRSO ,MABEL-RUSK> <MABEL-FCN>)
          (<EQUAL? ,PRSO ,TOMAS-QUINCE> <TOMAS-FCN>)
          (<EQUAL? ,PRSO ,SILAS-DACE> <SILAS-FCN>)
          (<EQUAL? ,PRSO ,NELL-HARROW> <NELL-FCN>)
          (<EQUAL? ,PRSO ,EMERY-WICKS> <EMERY-FCN>)
          (<EQUAL? ,PRSO ,TILDA-FEN> <TILDA-FCN>)
          (<EQUAL? ,PRSO ,JONAS-PELL> <JONAS-FCN>)
          (<EQUAL? ,PRSO ,VERA-TALLOW> <VERA-FCN>)
          (<EQUAL? ,PRSO ,ORIN-BELL> <ORIN-FCN>)
          (<EQUAL? ,PRSO ,EPHRAIM-PEAKE> <EPHRAIM-FCN>)
          (<EQUAL? ,PRSO ,KESTER-VANE> <KESTER-FCN>)
          (<EQUAL? ,PRSO ,HETTIE-BRAMM> <HETTIE-FCN>)
          (<EQUAL? ,PRSO ,SELLA-BIRCH> <SELLA-FCN>)
          (<EQUAL? ,PRSO ,PELLA-WREN> <PELLA-FCN>)
          (<EQUAL? ,PRSO ,TOBIN-WREN> <TOBIN-FCN>)
          (<EQUAL? ,PRSO ,LYSA-MARR> <LYSA-FCN>)
          (<EQUAL? ,PRSO ,TAVIN-ROE> <TAVIN-FCN>)
          (<EQUAL? ,PRSO ,CASSA-REED> <CASSA-FCN>)
          (<EQUAL? ,PRSO ,MARA>
           <COND (<MARA-EARNED-ROMANCE-ABOUT ,PRSI> <RTRUE>)>
           <FAIR-MARA-ASK>)
          (T <TELL "They do not owe you a database." CR>)>
    <RTRUE>>

<ROUTINE V-FAIR-REDEEM ()
    <COND (<NOT <IN? ,NELL-HARROW ,HERE>>
           <TELL "Nell handles redemption at the Prize Hall." CR>
           <RTRUE>)>
    <COND (<AND <EQUAL? ,PRSO ,STUFFED-GRUE> <G=? ,FAIR-TICKETS 40>>
           <SETG FAIR-TICKETS <- ,FAIR-TICKETS 40>>
           <MOVE ,STUFFED-GRUE ,WINNER>
           <FCLEAR ,STUFFED-GRUE ,NDESCBIT>
           <TELL "Nell counts to forty and stops. The stuffed grue is yours." CR>)
          (<AND <EQUAL? ,PRSO ,PRIZE-WHISTLE> <G=? ,FAIR-TICKETS 12>>
           <SETG FAIR-TICKETS <- ,FAIR-TICKETS 12>>
           <TELL "A whistle. Twelve tickets. 39 would not have been enough for the grue." CR>)
          (<AND <EQUAL? ,PRSO ,PRIZE-CANDY> <G=? ,FAIR-TICKETS 5>>
           <SETG FAIR-TICKETS <- ,FAIR-TICKETS 5>>
           <TELL "Prize candy. Five tickets." CR>)
          (T
           <TELL "Nell does not round. You have " N ,FAIR-TICKETS " tickets." CR>)>
    <RTRUE>>

<ROUTINE FAIR-MARA-ASK ()
    <MARA-ENSURE>
    <COND (<NOT <IN? ,MARA ,HERE>>
           <TELL "Mara is not here." CR>
           <RTRUE>)>
    <COND (<G=? ,FAIR-PHASE ,FAIR-DUSK>
           <TELL "Mara wants the observation wheel while the lamps are coming up, and hot cider if Tomas has the Table open. She is not a DATE MODE." CR>)
          (<EQUAL? ,HERE ,GAMES-ROW>
           <COND (<NOT <ZERO? ,FAIR-KESTER-CLOSED>>
                  <TELL "She will not pay Kester again. The waxed cup was enough." CR>)
                 (T
                  <TELL "She likes What's Missing and Jonas's honest rings. She will beat you if the table is fair." CR>)>)
          (<EQUAL? ,HERE ,RIDE-COURT>
           <TELL "The dragon mount, if it is free. She does not need a children's ride; she likes the specific carving." CR>)
          (<OR <EQUAL? ,HERE ,FISHING-POND> <EQUAL? ,HERE ,POND-PATH>>
           <TELL "Shaded bank, cheap bait, patience. She may release an ordinary fish. Relationship state does not change catch tables." CR>)
          (T
           <TELL "She is at the fair as herself: apple-topped ears if she chooses, crowd recovery after midday, no optimization of closing." CR>)>
    <RTRUE>>

<ROUTINE FAIR-MARA-DANCE ()
    <COND (<IN? ,MARA ,HERE>
           <COND (<MARA-RUPTURE-OPEN?>
                  <TELL "Mara does not dance around an open rupture." CR>)
                 (<G? ,FAIR-MARA-REFUSE 1>
                  <TELL "She already refused. Repeating the same invitation is now ordinary annoyance, not a hidden meter." CR>)
                 (T
                  <TELL "Mara accepts one piece, then looks toward the wheel or the pond path." CR>)>)>
    <RTRUE>>
