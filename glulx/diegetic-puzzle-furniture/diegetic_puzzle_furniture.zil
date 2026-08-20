"RELEASE 1274 ENVIRONMENTAL MECHANISMS AND DIEGETIC PUZZLE FURNITURE"

;"Four authored Ashglass mechanisms. Each owns only its own persistent physical
  state. No universal switch, furniture, secret-door, or object-pair engine."

<CONSTANT DF-SCRIPTORIUM-SHELF-OPEN 0>
<CONSTANT DF-VAULT-COMPARTMENT-OPEN 1>
<CONSTANT DF-CLOCK-HAND-ALIGNED 2>
<CONSTANT DF-CLOCK-RECESS-OPEN 3>
<CONSTANT DF-CISTERN-BRICK-OPEN 4>
<CONSTANT DF-CISTERN-DIVERTED 5>
<CONSTANT DIEGETIC-FURNITURE-STATE <TABLE 0 0 0 0 0 0>>

<ROUTINE DIEGETIC-GET (SLOT) <GET ,DIEGETIC-FURNITURE-STATE .SLOT>>
<ROUTINE DIEGETIC-PUT (SLOT VALUE) <PUT ,DIEGETIC-FURNITURE-STATE .SLOT .VALUE>>
<ROUTINE DIEGETIC-TRUE? (SLOT) <COND (<G? <DIEGETIC-GET .SLOT> 0> <RTRUE>)> <RFALSE>>

;"SCRIPTORIUM: a captive index volume is the lever for one surviving shelf."
<ROUTINE DIEGETIC-SCRIPTORIUM-EAST-EXIT ()
    <COND (<DIEGETIC-TRUE? ,DF-SCRIPTORIUM-SHELF-OPEN> ,ASHGLASS-BROKEN-GALLERY)
          (T
           <TELL "The eastern wall is still blocked by the surviving archive shelf. One black index volume sits strangely clean among the collapsed shelving, but no route exists until the furniture itself changes." CR>
           <RFALSE>)>>

<ROUTINE DIEGETIC-INDEX-VOLUME-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The black index volume is real but suspiciously captive. Dust lies on every neighboring surface except a crescent behind its spine, and a polished brass tongue disappears through the shelf board beneath it. The book can move a little farther than a book should need to." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "The volume slides outward barely an inch and stops against something mechanical. It is not glued down; the brass tongue under its spine is deliberately retaining it." CR>
           <RTRUE>)
          (<VERB? PUSH>
           <TELL "Pushing seats the volume flush and produces one small click, followed by nothing. Whatever the book controls wants travel in the other direction." CR>
           <RTRUE>)
          (<VERB? MOVE>
           <COND (<DIEGETIC-TRUE? ,DF-SCRIPTORIUM-SHELF-OPEN>
                  <TELL "The index volume remains pulled forward in its brass slot. The archive shelf is already pivoted clear." CR>
                  <RTRUE>)>
           <DIEGETIC-PUT ,DF-SCRIPTORIUM-SHELF-OPEN 1>
           <TELL "You pull the captive volume until the brass tongue reaches the end of its slot. A latch releases inside the upright shelf. The whole narrow case pivots east on a stone pin, exposing a dusty body-width passage into the broken gallery. The book never leaves the mechanism because it was the handle." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT DIEGETIC-INDEX-VOLUME
    (IN ASHGLASS-SCRIPTORIUM)
    (SYNONYM BOOK VOLUME INDEX CODEX)
    (ADJECTIVE BLACK CLEAN CAPTIVE ARCHIVE)
    (DESC "black index volume")
    (FLAGS TRYTAKEBIT)
    (ACTION DIEGETIC-INDEX-VOLUME-F)>

<ROUTINE DIEGETIC-ARCHIVE-SHELF-F ()
    <COND (<VERB? EXAMINE>
           <COND (<DIEGETIC-TRUE? ,DF-SCRIPTORIUM-SHELF-OPEN>
                  <TELL "The narrow archive shelf stands pivoted away from the east wall on a stone floor pin. The black index volume remains connected to the latch linkage." CR>)
                 (T
                  <TELL "Unlike the collapsed shelving around it, this narrow case is still vertical. Its base meets the floor at one round stone pin rather than a continuous plinth, and the black index volume is mounted at hand height." CR>)>
           <RTRUE>)
          (<VERB? LOOK-BEHIND>
           <COND (<DIEGETIC-TRUE? ,DF-SCRIPTORIUM-SHELF-OPEN>
                  <TELL "Behind the pivoted shelf is the now-open dusty passage east." CR>)
                 (T
                  <TELL "A finger-width gap behind the shelf reveals empty dark space and a metal latch edge, but the case is too heavy to swing by brute force." CR>)>
           <RTRUE>)
          (<VERB? PUSH MOVE>
           <COND (<DIEGETIC-TRUE? ,DF-SCRIPTORIUM-SHELF-OPEN>
                  <TELL "The shelf is already resting against its open stop." CR>)
                 (T
                  <TELL "The case rocks less than a fraction of an inch. The floor pin is a pivot, but some hidden latch is still holding the weight." CR>)>
           <RTRUE>)>
    <RFALSE>>

<OBJECT DIEGETIC-ARCHIVE-SHELF
    (IN ASHGLASS-SCRIPTORIUM)
    (SYNONYM SHELF SHELVES BOOKCASE CASE)
    (ADJECTIVE ARCHIVE UPRIGHT NARROW SURVIVING)
    (DESC "upright archive shelf")
    (FLAGS TRYTAKEBIT)
    (ACTION DIEGETIC-ARCHIVE-SHELF-F)>

;"VAULT: a proud sample tray is a mechanical false back, not a magic shelf."
<ROUTINE DIEGETIC-VAULT-TRAY-F ()
    <COND (<VERB? EXAMINE>
           <COND (<DIEGETIC-TRUE? ,DF-VAULT-COMPARTMENT-OPEN>
                  <TELL "The lower mineral tray is pushed fully home. Behind the shelf line, the shallow compartment it released remains open." CR>)
                 (T
                  <TELL "The lower mineral tray sits a finger-width proud of the other trays. Straight scrape marks continue behind it, while the side rails show no matching wear from being pulled outward." CR>)>
           <RTRUE>)
          (<VERB? TAKE MOVE>
           <TELL "The tray draws outward only to its ordinary stop. The scrape pattern runs the wrong direction for removal; whatever unusual travel it has is deeper into the shelf." CR>
           <RTRUE>)
          (<VERB? PUSH>
           <COND (<DIEGETIC-TRUE? ,DF-VAULT-COMPARTMENT-OPEN>
                  <TELL "The tray is already seated at the deeper stop that released the false back." CR>
                  <RTRUE>)>
           <DIEGETIC-PUT ,DF-VAULT-COMPARTMENT-OPEN 1>
           <FCLEAR ,DIEGETIC-BRONZE-STAR-WHEEL ,INVISIBLE>
           <TELL "You press the proud tray past the line of its neighbors. It travels another inch on hidden rails and a thin shelf back drops flat with a dry metal sigh. A shallow compartment remains open behind the samples. Inside lies a small bronze star-wheel, apparently stored there because observatory staff owned drawers and not because destiny required one." CR>
           <RTRUE>)
          (<VERB? LOOK-BEHIND>
           <COND (<DIEGETIC-TRUE? ,DF-VAULT-COMPARTMENT-OPEN>
                  <TELL "The dropped false back exposes a shallow metal-lined compartment behind the mineral shelf." CR>)
                 (T
                  <TELL "The shelf back looks continuous from here. The proud lower tray and its straight scrape marks are the only concrete irregularity." CR>)>
           <RTRUE>)>
    <RFALSE>>

<OBJECT DIEGETIC-VAULT-TRAY
    (IN ASHGLASS-VAULT)
    (SYNONYM TRAY SHELF SAMPLE SAMPLES)
    (ADJECTIVE LOWER MINERAL PROUD METAL)
    (DESC "proud lower sample tray")
    (FLAGS TRYTAKEBIT)
    (ACTION DIEGETIC-VAULT-TRAY-F)>

<ROUTINE DIEGETIC-BRONZE-STAR-WHEEL-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The palm-sized bronze wheel has seven blunt star points and an off-center square hole. It is plainly a removed instrument part. Nothing on it promises that carrying it will eventually become important." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT DIEGETIC-BRONZE-STAR-WHEEL
    (IN ASHGLASS-VAULT)
    (SYNONYM WHEEL STAR GEAR PART)
    (ADJECTIVE BRONZE SMALL SEVEN POINTED)
    (DESC "small bronze star-wheel")
    (FDESC "A small bronze star-wheel rests in the open shelf compartment.")
    (FLAGS TAKEBIT INVISIBLE)
    (SIZE 3)
    (VALUE 0)
    (ACTION DIEGETIC-BRONZE-STAR-WHEEL-F)>

;"BELL TOWER: align one physical hand with its clean stop, then pull the chain."
<ROUTINE DIEGETIC-CLOCK-HAND-F ()
    <COND (<VERB? EXAMINE>
           <COND (<DIEGETIC-TRUE? ,DF-CLOCK-HAND-ALIGNED>
                  <TELL "The single brass hand now rests in the clean index notch. The winding chain below it has taken up a little slack." CR>)
                 (T
                  <TELL "The single brass hand is stopped short of a narrow index notch. Dust fills every other mark on the dial, but that notch is clean and polished on one edge. The hand itself turns under firm pressure." CR>)>
           <RTRUE>)
          (<VERB? TURN>
           <COND (<DIEGETIC-TRUE? ,DF-CLOCK-HAND-ALIGNED>
                  <TELL "The hand is already seated in the only clean mechanical stop." CR>
                  <RTRUE>)>
           <DIEGETIC-PUT ,DF-CLOCK-HAND-ALIGNED 1>
           <TELL "You rotate the hand into the clean notch. It settles with a distinct spring-loaded click, and the slack winding chain below rises half an inch." CR>
           <RTRUE>)
          (<VERB? PUSH MOVE>
           <TELL "The hand resists sideways force but turns normally around its axle. Its useful motion is rotation, not bending." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT DIEGETIC-CLOCK-HAND
    (IN ASHGLASS-BELL-TOWER)
    (SYNONYM HAND POINTER NEEDLE)
    (ADJECTIVE CLOCK BRASS SINGLE STOPPED)
    (DESC "stopped brass clock hand")
    (FLAGS TURNBIT TRYTAKEBIT)
    (ACTION DIEGETIC-CLOCK-HAND-F)>

<ROUTINE DIEGETIC-CLOCK-CHAIN-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A narrow winding chain descends from the bottom of the weather clock. It is intact but slack, with a thumb loop at the end." CR>
           <RTRUE>)
          (<VERB? MOVE>
           <COND (<NOT <DIEGETIC-TRUE? ,DF-CLOCK-HAND-ALIGNED>>
                  <TELL "The chain moves an inch and locks solid. The clock hand twitches toward the one clean notch but cannot reach it under chain tension. The alignment is wrong before the pull." CR>
                  <RTRUE>)
                 (<DIEGETIC-TRUE? ,DF-CLOCK-RECESS-OPEN>
                  <TELL "The chain is already down against its stop and the clock case remains pivoted open." CR>
                  <RTRUE>)>
           <DIEGETIC-PUT ,DF-CLOCK-RECESS-OPEN 1>
           <FCLEAR ,DIEGETIC-CLOCK-RECESS ,INVISIBLE>
           <TELL "With the hand seated in its clean stop, the chain now travels freely. A hidden cam turns behind the dial and the lower half of the weather clock pivots away from the wall, exposing a shallow maintenance recess. No secret door appears; the clock simply contains the service space its wear marks implied." CR>
           <RTRUE>)
          (<VERB? PUSH>
           <TELL "Pushing slack chain upward accomplishes the rare mechanical feat of making slack chain less organized." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT DIEGETIC-CLOCK-CHAIN
    (IN ASHGLASS-BELL-TOWER)
    (SYNONYM CHAIN LOOP WINDER)
    (ADJECTIVE CLOCK WINDING NARROW SLACK)
    (DESC "slack clock chain")
    (FLAGS TRYTAKEBIT)
    (ACTION DIEGETIC-CLOCK-CHAIN-F)>

<ROUTINE DIEGETIC-WEATHER-CLOCK-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The wall clock is an observatory weather regulator rather than a timepiece. Its single brass hand is stopped near one unusually clean index notch, and a narrow winding chain hangs below the case. A fine vertical seam around the lower half of the case is too regular to be a crack." CR>
           <RTRUE>)
          (<VERB? OPEN>
           <COND (<DIEGETIC-TRUE? ,DF-CLOCK-RECESS-OPEN>
                  <TELL "The lower clock case is already pivoted open." CR>)
                 (T
                  <TELL "The clock case has no handle or ordinary door edge. The hand, clean stop, chain, and lower-case seam are the moving details it actually offers." CR>)>
           <RTRUE>)
          (<VERB? LOOK-BEHIND>
           <COND (<DIEGETIC-TRUE? ,DF-CLOCK-RECESS-OPEN>
                  <TELL "Behind the pivoted lower clock case is the shallow maintenance recess." CR>)
                 (T
                  <TELL "The clock sits nearly flush to the stone. The only visible separation is the precise seam around its lower case." CR>)>
           <RTRUE>)>
    <RFALSE>>

<OBJECT DIEGETIC-WEATHER-CLOCK
    (IN ASHGLASS-BELL-TOWER)
    (SYNONYM CLOCK REGULATOR DIAL CASE)
    (ADJECTIVE WEATHER WALL BRONZE OBSERVATORY)
    (DESC "weather regulator clock")
    (FLAGS TRYTAKEBIT)
    (ACTION DIEGETIC-WEATHER-CLOCK-F)>

<ROUTINE DIEGETIC-CLOCK-RECESS-F ()
    <COND (<VERB? EXAMINE LOOK-INSIDE>
           <TELL "The shallow recess contains dried grease, two empty screw holes, and a stamped maintenance date. Whatever tool once lived here is gone. The useful discovery is architectural: the compartment is real, open, and remains open." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT DIEGETIC-CLOCK-RECESS
    (IN ASHGLASS-BELL-TOWER)
    (SYNONYM RECESS COMPARTMENT CAVITY NICHE)
    (ADJECTIVE CLOCK MAINTENANCE SHALLOW OPEN)
    (DESC "open clock maintenance recess")
    (FLAGS INVISIBLE TRYTAKEBIT)
    (ACTION DIEGETIC-CLOCK-RECESS-F)>

;"CISTERN: a clean brick exposes a pull rod that diverts the spillway. The
  alternate dry ledge bypasses spray without rewriting candle wetness state."
<ROUTINE DIEGETIC-CISTERN-BRICK-F ()
    <COND (<VERB? EXAMINE>
           <COND (<DIEGETIC-TRUE? ,DF-CISTERN-BRICK-OPEN>
                  <TELL "The pale brick is recessed several inches into the wall. In the opening beside it, the bronze drain rod remains exposed." CR>)
                 (T
                  <TELL "Every nearby brick is wet and dark with mineral stain except this pale rectangular one. Its upper edge is clean, its mortar line is too wide, and one corner will accept a fingertip." CR>)>
           <RTRUE>)
          (<VERB? PUSH>
           <COND (<DIEGETIC-TRUE? ,DF-CISTERN-BRICK-OPEN>
                  <TELL "The brick is already pushed back to its internal stop." CR>
                  <RTRUE>)>
           <DIEGETIC-PUT ,DF-CISTERN-BRICK-OPEN 1>
           <FCLEAR ,DIEGETIC-DRAIN-ROD ,INVISIBLE>
           <TELL "The pale brick slides inward instead of resisting like masonry. Behind its widened edge a short bronze rod appears, connected through the wall toward the spillway. The brick was a cover, not the control itself." CR>
           <RTRUE>)
          (<VERB? MOVE TAKE>
           <TELL "The brick has no useful outward travel. Its clean upper edge and deep mortar gap suggest pressure into the wall, not extraction." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT DIEGETIC-CISTERN-BRICK
    (IN ASHGLASS-LOW-CISTERN)
    (SYNONYM BRICK BLOCK MASONRY STONE)
    (ADJECTIVE PALE CLEAN DRY RECTANGULAR)
    (DESC "oddly pale brick")
    (FLAGS TRYTAKEBIT)
    (ACTION DIEGETIC-CISTERN-BRICK-F)>

<ROUTINE DIEGETIC-DRAIN-ROD-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The short bronze rod passes through a sealed collar toward the spillway wall. A worn pull ring on its end is large enough for two fingers." CR>
           <RTRUE>)
          (<VERB? MOVE>
           <COND (<DIEGETIC-TRUE? ,DF-CISTERN-DIVERTED>
                  <TELL "The drain rod is already pulled fully outward. Water continues through the lower diversion channel." CR>
                  <RTRUE>)>
           <DIEGETIC-PUT ,DF-CISTERN-DIVERTED 1>
           <TELL "You pull the bronze rod. Something heavy shifts behind the cistern wall, followed by a change in the water's pitch. The main spill now drops through a lower channel, uncovering a narrow stone ledge along the south wall where the cold spray had been crossing the passage." CR>
           <RTRUE>)
          (<VERB? PUSH>
           <TELL "The exposed rod is already seated inward; its worn ring exists for pulling." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT DIEGETIC-DRAIN-ROD
    (IN ASHGLASS-LOW-CISTERN)
    (SYNONYM ROD RING CONTROL)
    (ADJECTIVE BRONZE DRAIN SHORT PULL)
    (DESC "bronze drain rod")
    (FLAGS INVISIBLE TRYTAKEBIT)
    (ACTION DIEGETIC-DRAIN-ROD-F)>

<ROUTINE DIEGETIC-CISTERN-SOUTH-EXIT ()
    <COND (<DIEGETIC-TRUE? ,DF-CISTERN-DIVERTED>
           <TELL "With the main spill diverted below, you follow the newly dry stone ledge south. The candles, if you are carrying them, never enter the sheet of spray." CR>
           ,ASHGLASS-CISTERN-WALK)
          (T <ASHGLASS-CISTERN-EAST-EXIT>)>>
