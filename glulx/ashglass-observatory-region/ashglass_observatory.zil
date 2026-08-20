"RELEASE 1272 ASHGLASS OBSERVATORY REGION"

;"A bounded original Zork region composing the preceding parser-IF systems.
  State belongs only to authored Ashglass geography and mechanisms; there is no
  generic region engine, creature AI, climate simulator, or puzzle registry."

<SYNTAX FOCUS OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-ASHGLASS-FOCUS>
<SYNONYM FOCUS ALIGN>

<CONSTANT AR-FOREST-OPEN 0>
<CONSTANT AR-CANYON-OPEN 1>
<CONSTANT AR-FOCUS-KNOWN 2>
<CONSTANT AR-LENS-ALIGNED 3>
<CONSTANT AR-VENT-READ 4>
<CONSTANT AR-VENT-OPEN 5>
<CONSTANT AR-ROOK-AWAY 6>
<CONSTANT AR-BRAKE-SET 7>
<CONSTANT AR-VAULT-OPEN 8>
<CONSTANT AR-GLASS-WARNED 9>
<CONSTANT AR-CACHE-SEEN 10>
<CONSTANT ASHGLASS-STATE <TABLE 0 0 0 0 0 0 0 0 0 0 0>>

<ROUTINE ASHGLASS-GET (SLOT) <GET ,ASHGLASS-STATE .SLOT>>
<ROUTINE ASHGLASS-PUT (SLOT VALUE) <PUT ,ASHGLASS-STATE .SLOT .VALUE>>
<ROUTINE ASHGLASS-TRUE? (SLOT) <COND (<G? <ASHGLASS-GET .SLOT> 0> <RTRUE>)> <RFALSE>>

<ROUTINE ASHGLASS-FOREST-ENTRY ()
    <COND (<ASHGLASS-TRUE? ,AR-FOREST-OPEN> ,ASHGLASS-WINDTHROW-MARGIN)
          (T
           <TELL "The storm-tossed trunks are not imaginary map blockage. A split hemlock lies under the others like a loaded spring; until that exact trunk is dealt with, there is no safe body-width passage south." CR>
           <RFALSE>)>>

<ROUTINE ASHGLASS-CANYON-ENTRY ()
    <COND (<ASHGLASS-TRUE? ,AR-CANYON-OPEN> ,ASHGLASS-RAIN-SHELF)
          (T
           <TELL "The stormfall still seals the obvious southward route, but an old leaning milestone at the canyon edge does not sit like natural stone. Examining or manipulating it might tell you whether the blockage hides older access." CR>
           <RFALSE>)>>

<ROUTINE ASHGLASS-FOREST-STORMFALL-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Several trees fell together, but one split hemlock carries the tension of the pile. Its trunk is already cracked almost through. Cutting that exact compression point with a real chopping edge would let the upper limbs settle instead of asking you to lift a forest." CR>
           <RTRUE>)
          (<VERB? CUT>
           <COND (<NOT ,PRSI>
                  <TELL "The hemlock is timber, not paper. You need an actual cutting tool." CR>
                  <RTRUE>)
                 (<NOT <EQUAL? ,PRSI ,AXE>>
                  <TELL "The " D ,PRSI " can damage bark, but this loaded trunk wants the broad bite and leverage of the axe, not an improvised edge." CR>
                  <RTRUE>)>
           <ASHGLASS-PUT ,AR-FOREST-OPEN 1>
           <TELL "The axe bites into the split compression point. On the third hard cut the trunk gives with a deep crack; upper limbs settle downhill instead of exploding toward you, leaving a narrow but honest passage south through the windthrow." CR>
           <RTRUE>)
          (<VERB? PUSH MOVE>
           <TELL "The whole pile flexes when you lean on it. The split hemlock is carrying the load; brute force on the wrong piece would merely choose where several hundred pounds of branch land." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE ASHGLASS-MILESTONE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The weathered milestone leans away from the canyon. Its uphill face bears paired angles around three rising strokes, and the roots behind it disappear into a suspiciously straight slot in the earth.">
           <COND (<CLUE-KNOWLEDGE-TRUE? ,CK-AIR-PASSAGE-MOTIF>
                  <TELL " You know that old geometry: a bounded opening carrying air. Here it marks access, not distance. The stone is hiding an old descending shelf-route.">
                  <ASHGLASS-PUT ,AR-CANYON-OPEN 1>)>
           <CRLF>
           <RTRUE>)
          (<VERB? CLUE-INTERPRET>
           <COND (<CLUE-KNOWLEDGE-TRUE? ,CK-AIR-PASSAGE-MOTIF>
                  <ASHGLASS-PUT ,AR-CANYON-OPEN 1>
                  <TELL "The air-passage motif makes the engineering legible. The milestone marks a maintenance descent cut behind the root mat; once you look for an opening rather than a boundary stone, the narrow rain-shelf is obvious." CR>)
                 (T
                  <TELL "The cuts are intentional, but without a matching old-script context you cannot honestly turn them into instructions." CR>)>
           <RTRUE>)
          (<VERB? PUSH MOVE>
           <ASHGLASS-PUT ,AR-CANYON-OPEN 1>
           <TELL "The stone rocks farther than a proper milestone should. Dirt tears loose behind it, exposing two old footholds and a narrow shelf descending south behind the roots. You nearly trade a clue for a falling boulder, but the route is real." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT ASHGLASS-FOREST-STORMFALL
    (IN FOREST-3)
    (SYNONYM STORMFALL TREES HEMLOCK TRUNK LOG)
    (ADJECTIVE STORM TOSSED SPLIT FALLEN LOADED)
    (DESC "loaded stormfall")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION ASHGLASS-FOREST-STORMFALL-F)>

<OBJECT ASHGLASS-CANYON-MILESTONE
    (IN CANYON-VIEW)
    (SYNONYM MILESTONE STONE MARKER MARK)
    (ADJECTIVE OLD LEANING WEATHERED ANGULAR)
    (DESC "leaning old milestone")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION ASHGLASS-MILESTONE-F)>

<ROUTINE ASHGLASS-ARCHIVE-TABLET-F ()
    <COND (<VERB? EXAMINE READ LEARNED-STUDY>
           <ASHGLASS-PUT ,AR-FOCUS-KNOWN 1>
           <TELL "The slate is a maintenance lesson disguised as astronomical devotion. A circular lens symbol is shown deliberately off-axis, then centered on a three-star notch. The surviving imperative is practical: FOCUS the ring only after the three-star notch is visible. You have learned an operation, not collected a magic word." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE V-ASHGLASS-FOCUS ()
    <COND (<NOT <EQUAL? ,PRSO ,ASHGLASS-FOCUS-RING>>
           <TELL "You can focus attention on the " D ,PRSO ", but you have learned no authored focusing operation for it." CR>
           <RTRUE>)
          (<NOT <ASHGLASS-TRUE? ,AR-FOCUS-KNOWN>>
           <TELL "The bronze ring turns, but without knowing what alignment mattered you would only be choosing a position at random. The mechanism gives no reason to pretend guessing is knowledge." CR>
           <RTRUE>)
          (<ASHGLASS-TRUE? ,AR-LENS-ALIGNED>
           <TELL "The ring is already centered on the three-star notch. A hard line of moon-pale light still marks the southern seam." CR>
           <RTRUE>)>
    <ASHGLASS-PUT ,AR-LENS-ALIGNED 1>
    <TELL "You center the bronze ring on the three-star notch exactly as the archive slate described. The suspended ashglass lens catches the shaft of sky-light and throws one narrow pale bar across the southern wall. Dust brightens around a door-seam that had been invisible in flat light." CR>
    <RTRUE>>

<OBJECT ASHGLASS-ARCHIVE-TABLET
    (IN ASHGLASS-SCRIPTORIUM)
    (SYNONYM TABLET SLATE LESSON DIAGRAM)
    (ADJECTIVE BLACK ARCHIVE ASTRONOMICAL)
    (DESC "black archive slate")
    (FLAGS READBIT TRYTAKEBIT)
    (ACTION ASHGLASS-ARCHIVE-TABLET-F)>

<ROUTINE ASHGLASS-FOCUS-RING-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A bronze ring surrounds the suspended lens. Around its track are many meaningless scratches and one deliberate three-star notch. Turning it is easy; knowing where to stop is the problem." CR>
           <RTRUE>)
          (<VERB? TURN MOVE>
           <TELL "The ring rotates smoothly through several old detents. Without a reason to privilege one position, the lens merely smears pale reflections around the hall." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT ASHGLASS-FOCUS-RING
    (IN ASHGLASS-ORRERY-HALL)
    (SYNONYM RING CONTROL WHEEL)
    (ADJECTIVE BRONZE FOCUS THREE STAR)
    (DESC "bronze focusing ring")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION ASHGLASS-FOCUS-RING-F)>

<ROUTINE ASHGLASS-LENS-SOUTH-EXIT ()
    <COND (<ASHGLASS-TRUE? ,AR-LENS-ALIGNED> ,ASHGLASS-ARCHIVE-CROSSING)
          (T
           <TELL "The south wall looks continuous in ordinary light. The lens mechanism is clearly capable of moving, but nothing currently distinguishes a doorway from stone." CR>
           <RFALSE>)>>

<ROUTINE ASHGLASS-VENT-MARK-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Three rising strokes sit between paired angles above a soot-dark seam. The cuts are shallow, old, and architectural rather than decorative.">
           <COND (<CLUE-KNOWLEDGE-TRUE? ,CK-AIR-PASSAGE-MOTIF>
                  <ASHGLASS-PUT ,AR-VENT-READ 1>
                  <TELL " You recognize the same air-passage motif learned elsewhere; the geometry says the wall once carried moving air.">)>
           <CRLF>
           <RTRUE>)
          (<VERB? CLUE-INTERPRET>
           <COND (<CLUE-KNOWLEDGE-TRUE? ,CK-AIR-PASSAGE-MOTIF>
                  <ASHGLASS-PUT ,AR-VENT-READ 1>
                  <TELL "This is the old air-passage motif again. The sign does not open anything, but it tells you the soot-dark seam deserves physical examination as ventilation structure." CR>)
                 (T
                  <TELL "You can see repeated geometry, but you lack enough old architectural notation to translate it honestly." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE ASHGLASS-VENT-SEAM-F ()
    <COND (<VERB? EXAMINE>
           <COND (<OR <ASHGLASS-TRUE? ,AR-VENT-READ>
                      <ASHGLASS-TRUE? ,AR-LENS-ALIGNED>>
                  <TELL "The soot line is broken at finger height by a recessed stone lip. Air is actually moving through it. This is a fitted maintenance panel, not a crack." CR>)
                 (T
                  <TELL "A narrow soot-dark line climbs the wall. A faint draft touches your knuckles, but flat light makes it hard to tell whether the line is a joint or merely staining." CR>)>
           <RTRUE>)
          (<VERB? PUSH MOVE OPEN>
           <COND (<NOT <OR <ASHGLASS-TRUE? ,AR-VENT-READ>
                           <ASHGLASS-TRUE? ,AR-LENS-ALIGNED>>>
                  <TELL "You press at dark stone without a reliable joint to work. The wall does not reward random masonry abuse with secret architecture." CR>
                  <RTRUE>)>
           <ASHGLASS-PUT ,AR-VENT-OPEN 1>
           <TELL "Your fingers find the recessed lip. The narrow panel grinds inward on old stone pivots and a cold maintenance crawl opens beyond, carrying a steady draft toward the lower works." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT ASHGLASS-VENT-MARK
    (IN ASHGLASS-BROKEN-GALLERY)
    (SYNONYM MARK MARKING GLYPH CUTS SYMBOL)
    (ADJECTIVE OLD ANGULAR AIR PASSAGE)
    (DESC "old angular vent marking")
    (FLAGS TRYTAKEBIT)
    (ACTION ASHGLASS-VENT-MARK-F)>

<OBJECT ASHGLASS-VENT-SEAM
    (IN ASHGLASS-BROKEN-GALLERY)
    (SYNONYM SEAM PANEL JOINT LIP)
    (ADJECTIVE SOOT DARK RECESSED STONE)
    (DESC "soot-dark wall seam")
    (FLAGS TRYTAKEBIT)
    (ACTION ASHGLASS-VENT-SEAM-F)>

<ROUTINE ASHGLASS-VENT-EXIT ()
    <COND (<ASHGLASS-TRUE? ,AR-VENT-OPEN> ,ASHGLASS-VENT-CHAMBER)
          (T
           <TELL "The west wall still presents only soot-dark masonry. If there is a service route here, you have not physically opened it." CR>
           <RFALSE>)>>

<ROUTINE ASHGLASS-CISTERN-WET-CANDLES ()
    <COND (<AND <IN? ,CANDLES ,WINNER>
                <NOT <FSET? ,CANDLES ,RMUNGBIT>>>
           <CONSUMABLE-LIGHT-PUT ,CL-CANDLE-WET 1>
           <FCLEAR ,CANDLES ,ONBIT>
           <TELL "A cold sheet of cistern spray catches the carried candles. Their flames die at once and water visibly soaks the paired wicks. The candles still exist; their condition has changed." CR>)>
    <RTRUE>>

<ROUTINE ASHGLASS-CISTERN-EAST-EXIT ()
    <ASHGLASS-CISTERN-WET-CANDLES>
    ,ASHGLASS-CISTERN-WALK>

<ROUTINE ASHGLASS-SHAFT-DOWN-EXIT ()
    <COND (<G? <CONSUMABLE-CURRENT-LIGHT-LEVEL> ,LIGHT-WEAK>
           ,ASHGLASS-STAR-CHAMBER)
          (<EQUAL? <CONSUMABLE-CURRENT-LIGHT-LEVEL> ,LIGHT-WEAK>
           <TELL "Weak light reaches the first iron rung and then dissolves into the shaft. You can see enough to know the ladder continues, not enough to place your feet around the broken middle section. Bright working light would turn this from gambling into climbing." CR>
           <RFALSE>)
          (T
           <TELL "The shaft below is materially black. Descending a damaged iron ladder into unseen depth is not exploration; it is selecting a fall without evidence." CR>
           <RFALSE>)>>

<ROUTINE ASHGLASS-ROOK-SHINY? (OBJ)
    <COND (<EQUAL? .OBJ ,GRUE-SURVEY-TUBE ,CHALICE ,BELL ,STAR-GLASS ,ASHEN-CIRCLET> <RTRUE>)>
    <RFALSE>>

<ROUTINE ASHGLASS-ROOK-ROOM-F (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <COND (<ASHGLASS-TRUE? ,AR-ROOK-AWAY>
                  <TELL "Rain ticks through the broken roof of this high rookery. The black rook is absent for the moment, leaving the east stair and its hanging brake-chain unguarded. Its nest of wire, bone, and stolen shine sags above the north beam." CR>)
                 (T
                  <TELL "Rain ticks through the broken roof of this high rookery. A huge black rook occupies the railing beside the east stair, watching hands and anything reflective with unnerving precision. A hanging brake-chain disappears east into the mechanism rooms." CR>)>
           <RTRUE>)
          (<EQUAL? .RARG ,M-BEG>
           <COND (<AND <VERB? DROP>
                       <IN? ,PRSO ,WINNER>
                       <ASHGLASS-ROOK-SHINY? ,PRSO>>
                  <MOVE ,PRSO ,ASHGLASS-EAST-BALCONY>
                  <ASHGLASS-PUT ,AR-ROOK-AWAY 1>
                  <QUEUE I-ASHGLASS-ROOK-RETURN 4>
                  <COND (<ZERO? <ASHGLASS-GET ,AR-CACHE-SEEN>>
                         <ASHGLASS-PUT ,AR-CACHE-SEEN 1>
                         <FCLEAR ,ASHGLASS-ROOK-TOKEN ,INVISIBLE>)>
                  <TELL "The rook's attention snaps to the falling shine. It launches after the " D ,PRSO ", beats through the east arch, and lands on the balcony to investigate. The stair is unguarded now, but wingbeats and an irritated click make this feel like borrowed time rather than victory." CR>
                  <RTRUE>)>)>
    <RFALSE>>

<ROUTINE I-ASHGLASS-ROOK-RETURN ()
    <COND (<ASHGLASS-TRUE? ,AR-ROOK-AWAY>
           <ASHGLASS-PUT ,AR-ROOK-AWAY 0>
           <COND (<EQUAL? ,HERE ,ASHGLASS-ROOKERY>
                  <TELL "Black wings hammer once through the east arch. The rook returns to the railing, wetter and more suspicious than before, and resumes controlling the stair with its body." CR>)>)>>

<ROUTINE ASHGLASS-ROOK-EAST-EXIT ()
    <COND (<ASHGLASS-TRUE? ,AR-ROOK-AWAY> ,ASHGLASS-COUNTERWEIGHT-ROOM)
          (T
           <TELL "The rook spreads both wings across the stair rail and strikes at your hand with a bill built for leverage. The east stair exists; the living animal is the reason you do not currently own it." CR>
           <RFALSE>)>>

<OBJECT ASHGLASS-ROOK
    (IN ASHGLASS-ROOKERY)
    (SYNONYM ROOK BIRD CORVID)
    (ADJECTIVE BLACK HUGE WATCHFUL)
    (DESC "huge black rook")
    (FLAGS ACTORBIT NDESCBIT TRYTAKEBIT)>

<OBJECT ASHGLASS-ROOK-TOKEN
    (IN ASHGLASS-ROOKERY)
    (SYNONYM TOKEN COIN DISC)
    (ADJECTIVE BRASS OBSERVATORY STAR)
    (DESC "small brass observatory token")
    (FLAGS TAKEBIT INVISIBLE)
    (SIZE 1)
    (VALUE 4)>

<ROUTINE ASHGLASS-BRAKE-LEVER-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The brake lever has three worn notches. The upper and lower notches are gouged and battered; the middle notch is polished by repeated controlled use. A painted warning shows a falling stone block beside a stick figure with exceptionally poor timing." CR>
           <RTRUE>)
          (<VERB? PUSH TURN MOVE>
           <ASHGLASS-PUT ,AR-BRAKE-SET 1>
           <TELL "You seat the lever into the polished middle notch. A pawl drops audibly into the counterweight ratchet. The hanging stone still carries enormous load, but the mechanism is now arrested before you touch the release chain." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE ASHGLASS-BRAKE-CHAIN-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The chain runs over a ceiling sheave to a stone counterweight larger than you are. Pulling it releases the vault lift. The brake lever beside you is the only visible arrest for that mass." CR>
           <RTRUE>)
          (<VERB? MOVE>
           <COND (<NOT <ASHGLASS-TRUE? ,AR-BRAKE-SET>>
                  <JIGS-UP "You pull the release chain with the counterweight unarrested. The mechanism works exactly as built: the stone block drops, the chain whips through the sheave, and the iron sweep crosses the standing space faster than a person can reconsider mechanical advantage. The polished middle brake notch was the missing physical state, not decoration.">
                  <RTRUE>)>
           <ASHGLASS-PUT ,AR-VAULT-OPEN 1>
           <TELL "The arrested counterweight descends one controlled foot at a time. Somewhere below, stone grinds on stone and then stops. The vault lift is open without the chain becoming a flail." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT ASHGLASS-BRAKE-LEVER
    (IN ASHGLASS-COUNTERWEIGHT-ROOM)
    (SYNONYM LEVER BRAKE PAWL)
    (ADJECTIVE IRON MIDDLE POLISHED)
    (DESC "three-notch brake lever")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION ASHGLASS-BRAKE-LEVER-F)>

<OBJECT ASHGLASS-BRAKE-CHAIN
    (IN ASHGLASS-COUNTERWEIGHT-ROOM)
    (SYNONYM CHAIN RELEASE)
    (ADJECTIVE HANGING IRON)
    (DESC "hanging release chain")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION ASHGLASS-BRAKE-CHAIN-F)>

<ROUTINE ASHGLASS-VAULT-DOWN-EXIT ()
    <COND (<ASHGLASS-TRUE? ,AR-VAULT-OPEN> ,ASHGLASS-VAULT-ANTECHAMBER)
          (T
           <TELL "The lift gate remains flush with the floor. The counterweight room above contains the mechanism that actually moves it." CR>
           <RFALSE>)>>

<ROUTINE ASHGLASS-GLASS-EAST-EXIT ()
    <COND (<L? <WEIGHT ,WINNER> 46> ,ASHGLASS-VAULT-ANTECHAMBER)
          (<ZERO? <ASHGLASS-GET ,AR-GLASS-WARNED>>
           <ASHGLASS-PUT ,AR-GLASS-WARNED 1>
           <TELL "The first pane bows under your carried load and answers with a sharp internal tick. A white fracture races a handspan from the frame before you throw your weight back onto stone. The bridge has told you exactly what is wrong: not direction, not wording, but too much mass on old glass." CR>
           <RFALSE>)
          (T
           <JIGS-UP "You put the same excessive carried weight onto the already-whitened pane again. This time the fracture reaches the frame. The ashglass bridge becomes falling shards, and gravity completes the argument you had already been given once.">
           <RFALSE>)>>

<ROUTINE ASHGLASS-SERVICE-SOUTH-EXIT ()
    <COND (<ASHGLASS-TRUE? ,AR-VENT-OPEN> ,ASHGLASS-VAULT-ANTECHAMBER)
          (T <RFALSE>)>>

<ROOM ASHGLASS-WINDTHROW-MARGIN (IN ROOMS) (DESC "Windthrow Margin")
      (LDESC "South of the old forest, stormfall gives way to a narrow upland bench. Broken hemlocks lean north; to the southeast, dressed black stone appears between roots. North returns to the familiar forest. East follows a rain-cut shelf.")
      (NORTH TO FOREST-3) (EAST TO ASHGLASS-SUNKEN-MILESTONE) (SE TO ASHGLASS-WEST-COURT) (FLAGS RLANDBIT ONBIT)>
<ROOM ASHGLASS-RAIN-SHELF (IN ROOMS) (DESC "Rain Shelf")
      (LDESC "A narrow shelf runs behind the canyon root mat. Water beads on old chisel marks. North climbs back to Canyon View; west reaches storm-broken woodland, while south descends on roots toward black masonry.")
      (NORTH TO CANYON-VIEW) (WEST TO ASHGLASS-WINDTHROW-MARGIN) (SOUTH TO ASHGLASS-ROOT-STAIR) (FLAGS RLANDBIT ONBIT)>
<ROOM ASHGLASS-SUNKEN-MILESTONE (IN ROOMS) (DESC "Sunken Milestone")
      (LDESC "A second ancient marker lies half buried beside a rain channel. Its broken face once pointed east toward an observatory court. Windthrow lies west; a root stair drops southeast.")
      (WEST TO ASHGLASS-WINDTHROW-MARGIN) (SE TO ASHGLASS-ROOT-STAIR) (EAST TO ASHGLASS-WEST-COURT) (FLAGS RLANDBIT ONBIT)>
<ROOM ASHGLASS-ROOT-STAIR (IN ROOMS) (DESC "Root Stair")
      (LDESC "Tree roots have invaded an old stair cut into black stone. Rain shelf is north, the sunken marker northwest, and a ruined court opens south.")
      (NORTH TO ASHGLASS-RAIN-SHELF) (NW TO ASHGLASS-SUNKEN-MILESTONE) (SOUTH TO ASHGLASS-WEST-COURT) (FLAGS RLANDBIT ONBIT)>
<ROOM ASHGLASS-WEST-COURT (IN ROOMS) (DESC "West Court")
      (LDESC "An outdoor court of black flagstone slopes deliberately toward drains. Broken plinths stand where instruments once faced the sky. North returns to the approaches; east passes beneath a cracked arch into the observatory yard; south descends toward cistern works.")
      (NORTH TO ASHGLASS-ROOT-STAIR) (NW TO ASHGLASS-WINDTHROW-MARGIN) (EAST TO ASHGLASS-OBSERVATORY-YARD) (SOUTH TO ASHGLASS-LOW-CISTERN) (FLAGS RLANDBIT ONBIT)>
<ROOM ASHGLASS-OBSERVATORY-YARD (IN ROOMS) (DESC "Observatory Yard")
      (LDESC "Three ruined wings surround a weed-grown yard. West returns to the outer court. North enters a round orrery hall, east a broken gallery, and south a low archive wing.")
      (WEST TO ASHGLASS-WEST-COURT) (NORTH TO ASHGLASS-ORRERY-HALL) (EAST TO ASHGLASS-BROKEN-GALLERY) (SOUTH TO ASHGLASS-SCRIPTORIUM) (FLAGS RLANDBIT ONBIT)>
<ROOM ASHGLASS-ORRERY-HALL (IN ROOMS) (DESC "Orrery Hall")
      (LDESC "A skeletal bronze orrery fills the round hall. A suspended ashglass lens hangs above its center and a bronze focusing ring circles the mount. South returns to the yard; east enters the lens chamber.")
      (SOUTH TO ASHGLASS-OBSERVATORY-YARD) (EAST TO ASHGLASS-LENS-CHAMBER) (FLAGS RLANDBIT)>
<ROOM ASHGLASS-LENS-CHAMBER (IN ROOMS) (DESC "Lens Chamber")
      (LDESC "The chamber is lined with dark glass plates and narrow shutters. West returns to the orrery. A perfectly ordinary-looking south wall seam refuses to become a route unless the optical apparatus gives you a reason to see it differently; north climbs toward the rookery.")
      (WEST TO ASHGLASS-ORRERY-HALL) (SOUTH PER ASHGLASS-LENS-SOUTH-EXIT) (NORTH TO ASHGLASS-ROOKERY) (FLAGS RLANDBIT)>
<ROOM ASHGLASS-ARCHIVE-CROSSING (IN ROOMS) (DESC "Archive Crossing")
      (LDESC "A narrow passage behind the lens wall bridges the old archive and mechanism wings. North returns through the optical seam; south reaches the scriptorium; east enters a damaged gallery.")
      (NORTH TO ASHGLASS-LENS-CHAMBER) (SOUTH TO ASHGLASS-SCRIPTORIUM) (EAST TO ASHGLASS-BROKEN-GALLERY) (FLAGS RLANDBIT)>
<ROOM ASHGLASS-SCRIPTORIUM (IN ROOMS) (DESC "Ruined Scriptorium")
      (LDESC "Collapsed shelves leave one stone desk intact beneath a dry arch. A black archive slate rests there. North returns to the yard and west to the cistern. A blocked eastern wall suggests the archive once continued farther, but no usable opening remains on this side.")
      (NORTH TO ASHGLASS-OBSERVATORY-YARD) (WEST TO ASHGLASS-LOW-CISTERN) (FLAGS RLANDBIT)>
<ROOM ASHGLASS-BROKEN-GALLERY (IN ROOMS) (DESC "Broken Gallery")
      (LDESC "One wall has fallen outward, but the west wall remains soot-dark and oddly cool. Old angular cuts sit above a narrow seam. West is not yet a route unless real structure is opened. South returns to the yard; north reaches a bell stair.")
      (SOUTH TO ASHGLASS-OBSERVATORY-YARD) (NORTH TO ASHGLASS-BELL-TOWER) (WEST PER ASHGLASS-VENT-EXIT) (FLAGS RLANDBIT ONBIT)>
<ROOM ASHGLASS-LOW-CISTERN (IN ROOMS) (DESC "Low Cistern")
      (LDESC "A masonry cistern catches rain from the observatory roofs. The west court is north, the scriptorium east, and a narrow spillway passage runs south through cold spray.")
      (NORTH TO ASHGLASS-WEST-COURT) (EAST TO ASHGLASS-SCRIPTORIUM) (SOUTH PER ASHGLASS-CISTERN-EAST-EXIT) (FLAGS RLANDBIT)>
<ROOM ASHGLASS-CISTERN-WALK (IN ROOMS) (DESC "Cistern Walk")
      (LDESC "A slick stone walk follows the cistern spillway. Spray hangs in the air. North returns to the low cistern; east climbs to the vent chamber; south reaches a service tunnel.")
      (NORTH TO ASHGLASS-LOW-CISTERN) (EAST TO ASHGLASS-VENT-CHAMBER) (SOUTH TO ASHGLASS-SERVICE-TUNNEL) (FLAGS RLANDBIT)>
<ROOM ASHGLASS-VENT-CHAMBER (IN ROOMS) (DESC "Vent Chamber")
      (LDESC "Old air channels converge in a narrow stone chamber. East opens to the broken gallery if the panel was moved; west returns to the cistern walk; south descends into the lower shaft.")
      (EAST TO ASHGLASS-BROKEN-GALLERY) (WEST TO ASHGLASS-CISTERN-WALK) (SOUTH TO ASHGLASS-LOWER-SHAFT) (FLAGS RLANDBIT)>
<ROOM ASHGLASS-ROOKERY (IN ROOMS) (DESC "High Rookery")
      (SOUTH TO ASHGLASS-LENS-CHAMBER) (EAST PER ASHGLASS-ROOK-EAST-EXIT) (NORTH TO ASHGLASS-BELL-TOWER) (ACTION ASHGLASS-ROOK-ROOM-F) (FLAGS RLANDBIT ONBIT)>
<ROOM ASHGLASS-BELL-TOWER (IN ROOMS) (DESC "Bell Tower")
      (LDESC "The observatory bell is gone, but its open tower still catches every gust. South is the rookery, east an exposed balcony, and down the broken gallery stair.")
      (SOUTH TO ASHGLASS-ROOKERY) (EAST TO ASHGLASS-EAST-BALCONY) (DOWN TO ASHGLASS-BROKEN-GALLERY) (FLAGS RLANDBIT ONBIT)>
<ROOM ASHGLASS-EAST-BALCONY (IN ROOMS) (DESC "East Balcony")
      (LDESC "A narrow balcony overlooks the canyon and mechanism roof. West returns to the bell tower. Below, a short iron stair reaches the counterweight room.")
      (WEST TO ASHGLASS-BELL-TOWER) (DOWN TO ASHGLASS-COUNTERWEIGHT-ROOM) (FLAGS RLANDBIT ONBIT)>
<ROOM ASHGLASS-COUNTERWEIGHT-ROOM (IN ROOMS) (DESC "Counterweight Room")
      (LDESC "A stone counterweight hangs in a guide frame beside a three-notch brake lever and release chain. West returns to the rookery stair, up reaches the balcony, and down is a flush lift gate controlled here.")
      (WEST TO ASHGLASS-ROOKERY) (UP TO ASHGLASS-EAST-BALCONY) (DOWN PER ASHGLASS-VAULT-DOWN-EXIT) (FLAGS RLANDBIT)>
<ROOM ASHGLASS-LOWER-SHAFT (IN ROOMS) (DESC "Lower Shaft")
      (LDESC "An iron ladder descends through a square shaft. Several middle rungs are broken and the lower landing is invisible without strong working light. North returns to the vent chamber; down continues toward the star chamber.")
      (NORTH TO ASHGLASS-VENT-CHAMBER) (DOWN PER ASHGLASS-SHAFT-DOWN-EXIT) (FLAGS RLANDBIT)>
<ROOM ASHGLASS-STAR-CHAMBER (IN ROOMS) (DESC "Star Chamber")
      (LDESC "Tiny drilled apertures pepper the ceiling above a black floor, throwing pinpoints of daylight like a static night sky. Up returns to the shaft. East leads onto an old ashglass bridge; west enters the service tunnel.")
      (UP TO ASHGLASS-LOWER-SHAFT) (EAST TO ASHGLASS-GLASS-FLOOR) (WEST TO ASHGLASS-SERVICE-TUNNEL) (FLAGS RLANDBIT)>
<ROOM ASHGLASS-GLASS-FLOOR (IN ROOMS) (DESC "Ashglass Bridge")
      (LDESC "Three translucent panes span a dark service void. White stress lines sleep near the iron frames. West is solid stone; east is the vault antechamber.")
      (WEST TO ASHGLASS-STAR-CHAMBER) (EAST PER ASHGLASS-GLASS-EAST-EXIT) (FLAGS RLANDBIT)>
<ROOM ASHGLASS-VAULT-ANTECHAMBER (IN ROOMS) (DESC "Vault Antechamber")
      (LDESC "Three routes converge before a low bronze vault door: the glass bridge west, a service tunnel north, and the counterweight lift above. East enters the vault itself.")
      (WEST TO ASHGLASS-GLASS-FLOOR) (NORTH TO ASHGLASS-SERVICE-TUNNEL) (UP TO ASHGLASS-COUNTERWEIGHT-ROOM) (EAST TO ASHGLASS-VAULT) (FLAGS RLANDBIT)>
<ROOM ASHGLASS-VAULT (IN ROOMS) (DESC "Ashglass Vault")
      (LDESC "The vault is disappointingly small and therefore convincing. Shelves hold broken observation plates, mineral samples, and one intact dark glass prism. West returns to the antechamber. Nothing here claims the universe owes you a quest reward.")
      (WEST TO ASHGLASS-VAULT-ANTECHAMBER) (FLAGS RLANDBIT)>
<ROOM ASHGLASS-SERVICE-TUNNEL (IN ROOMS) (DESC "Service Tunnel")
      (LDESC "A low maintenance tunnel joins the wet cistern works to the star chamber and vault approach. North reaches the cistern walk, east the star chamber, and south the vault antechamber once the opened ventilation network gives you the full route.")
      (NORTH TO ASHGLASS-CISTERN-WALK) (EAST TO ASHGLASS-STAR-CHAMBER) (SOUTH PER ASHGLASS-SERVICE-SOUTH-EXIT) (FLAGS RLANDBIT)>

<OBJECT ASHGLASS-DARK-PRISM
    (IN ASHGLASS-VAULT)
    (SYNONYM PRISM GLASS SAMPLE)
    (ADJECTIVE DARK ASHGLASS INTACT)
    (DESC "intact dark ashglass prism")
    (FLAGS TAKEBIT)
    (SIZE 4)
    (VALUE 6)>
