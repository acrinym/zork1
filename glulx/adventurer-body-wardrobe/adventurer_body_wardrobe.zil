"ADVENTURER BODY, CLOTHING, AND HOUSE WARDROBE for Release 1309"

; "Clothes are objects. The House is where you change them. No clothing RPG,
   no paper-doll UI, no cleanliness percentage. Mara dresses Mara."

<SYNTAX CHANGE CLOTHES = V-ADV-CHANGE>
<SYNTAX CHANGE OBJECT = V-ADV-CHANGE>
<SYNTAX SCRUB OBJECT = V-ADV-SCRUB>
<SYNTAX WRING OBJECT = V-ADV-WRING>
<SYNTAX HANG OBJECT ON OBJECT = V-ADV-HANG>
<SYNTAX ROLL UP OBJECT = V-ADV-ROLL-SLEEVE>
<SYNONYM WRING SQUEEZE>

<GLOBAL ADV-SHIRT-WET 0>
<GLOBAL ADV-SHIRT-MUD 0>
<GLOBAL ADV-SHIRT-TEAR 0>
<GLOBAL ADV-COAT-WET 0>
<GLOBAL ADV-COAT-MUD 0>
<GLOBAL ADV-COAT-SCORCH 0>
<GLOBAL ADV-BOOTS-MUD 0>
<GLOBAL ADV-TROUSERS-MUD 0>
<GLOBAL ADV-TROUSERS-WET 0>
<GLOBAL ADV-SLEEVE-ROLLED 0>
<GLOBAL HOUSE-BASIN-WATER 0>
<GLOBAL HOUSE-BASIN-SOAP 0>

<OBJECT ADV-HANDS
    (IN GLOBAL-OBJECTS)
    (SYNONYM HANDS HAND PALM FINGERS)
    (ADJECTIVE MY LEFT RIGHT)
    (DESC "your hands")
    (FLAGS NDESCBIT)
    (ACTION ADV-HANDS-F)>

<OBJECT ADV-FACE
    (IN GLOBAL-OBJECTS)
    (SYNONYM FACE EYES)
    (ADJECTIVE MY)
    (DESC "your face")
    (FLAGS NDESCBIT)
    (ACTION ADV-FACE-F)>

<OBJECT ADV-HAIR
    (IN GLOBAL-OBJECTS)
    (SYNONYM HAIR)
    (ADJECTIVE MY)
    (DESC "your hair")
    (FLAGS NDESCBIT)
    (ACTION ADV-HAIR-F)>

<OBJECT ADV-TRAVEL-COAT
    (IN ADVENTURER)
    (SYNONYM COAT JACKET)
    (ADJECTIVE TRAVEL WORN MY)
    (DESC "travel-worn coat")
    (FLAGS TAKEBIT WEARBIT)
    (SIZE 8)
    (ACTION ADV-COAT-F)>

<OBJECT ADV-SHIRT
    (IN ADVENTURER)
    (SYNONYM SHIRT)
    (ADJECTIVE TRAVEL GREEN MY)
    (DESC "plain travel shirt")
    (FLAGS TAKEBIT WEARBIT)
    (SIZE 4)
    (ACTION ADV-SHIRT-F)>

<OBJECT ADV-TROUSERS
    (IN ADVENTURER)
    (SYNONYM TROUSERS PANTS)
    (ADJECTIVE TRAVEL MY)
    (DESC "travel trousers")
    (FLAGS TAKEBIT WEARBIT)
    (SIZE 5)
    (ACTION ADV-TROUSERS-F)>

<OBJECT ADV-BOOTS
    (IN ADVENTURER)
    (SYNONYM BOOTS BOOT)
    (ADJECTIVE TRAVEL MY)
    (DESC "scuffed travel boots")
    (FLAGS TAKEBIT WEARBIT)
    (SIZE 6)
    (ACTION ADV-BOOTS-F)>

<OBJECT HOUSE-WARDROBE
    (IN LIVING-ROOM)
    (SYNONYM WARDROBE ARMOIRE)
    (ADJECTIVE TALL WOODEN)
    (DESC "tall wooden wardrobe")
    (FLAGS CONTBIT SEARCHBIT OPENBIT)
    (CAPACITY 40)
    (FDESC "A tall wooden wardrobe stands against the living-room wall, built to hold real garments rather than an appearance menu.")
    (ACTION HOUSE-WARDROBE-F)>

<OBJECT HOUSE-MIRROR
    (IN LIVING-ROOM)
    (SYNONYM MIRROR)
    (ADJECTIVE STANDING WALL)
    (DESC "standing mirror")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION HOUSE-MIRROR-F)>

<OBJECT HOUSE-DRESSER
    (IN ATTIC)
    (SYNONYM DRESSER BUREAU)
    (ADJECTIVE WOODEN ATTIC)
    (DESC "attic dresser")
    (FLAGS CONTBIT SEARCHBIT)
    (CAPACITY 25)
    (FDESC "A wooden dresser with real drawers sits under the attic slope. It is furniture, not a character sheet.")
    (ACTION HOUSE-DRESSER-F)>

<OBJECT HOUSE-TOP-DRAWER
    (IN HOUSE-DRESSER)
    (SYNONYM DRAWER DRAWERS)
    (ADJECTIVE TOP UPPER)
    (DESC "top drawer")
    (FLAGS CONTBIT SEARCHBIT NDESCBIT)
    (CAPACITY 10)
    (ACTION HOUSE-DRAWER-F)>

<OBJECT HOUSE-LAUNDRY-BASKET
    (IN ATTIC)
    (SYNONYM BASKET)
    (ADJECTIVE LAUNDRY DIRTY CLOTHES)
    (DESC "laundry basket")
    (FLAGS CONTBIT SEARCHBIT TAKEBIT)
    (CAPACITY 20)
    (FDESC "A wicker laundry basket waits for actual dirty clothes.")>

<OBJECT HOUSE-WASH-BASIN
    (IN KITCHEN)
    (SYNONYM BASIN TUB)
    (ADJECTIVE WASH STONE DEEP)
    (DESC "deep stone wash basin")
    (FLAGS CONTBIT OPENBIT SEARCHBIT TRYTAKEBIT)
    (CAPACITY 15)
    (FDESC "A deep stone basin stands near the kitchen pump, meant for washing cloth rather than cooking.")
    (ACTION HOUSE-BASIN-F)>

<OBJECT HOUSE-WASHROOT
    (IN KITCHEN)
    (SYNONYM WASHROOT ROOT SOAP)
    (ADJECTIVE PALE FIBROUS)
    (DESC "bundle of washroot")
    (FLAGS TAKEBIT)
    (SIZE 2)
    (FDESC "A pale fibrous root bundle sits by the basin. Bruised in water it makes a thin soap.")
    (ACTION HOUSE-WASHROOT-F)>

<OBJECT HOUSE-CLOTHESLINE
    (IN EAST-OF-HOUSE)
    (SYNONYM CLOTHESLINE LINE)
    (ADJECTIVE CLOTHES WASHING)
    (DESC "clothesline")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION HOUSE-LINE-F)>

<OBJECT MARA-TRAVEL-COAT
    (IN MARA)
    (SYNONYM COAT)
    (ADJECTIVE MARA MARAS FIELD WEATHERED)
    (DESC "Mara's weathered field coat")
    (FLAGS TAKEBIT WEARBIT TRYTAKEBIT)
    (SIZE 8)
    (ACTION MARA-COAT-F)>

<ROUTINE ADV-EXAMINE-SELF ()
    <TELL "You are an unnamed adventurer of ordinary height and weather, with working hands">
    <COND (<G? ,ADV-SLEEVE-ROLLED 0>
           <TELL ", sleeves rolled">)>
    <TELL ". ">
    <COND (<IN? ,ADV-TRAVEL-COAT ,ADVENTURER>
           <TELL "You are wearing the travel-worn coat">
           <COND (<G? ,ADV-COAT-MUD 0> <TELL ", muddied">)>
           <COND (<G? ,ADV-COAT-WET 0> <TELL ", still damp">)>
           <COND (<G? ,ADV-COAT-SCORCH 0> <TELL ", scorched along one hem">)>
           <TELL ". ">)>
    <COND (<IN? ,ADV-SHIRT ,ADVENTURER>
           <TELL "The shirt underneath is">
           <COND (<G? ,ADV-SHIRT-TEAR 0> <TELL " torn">)>
           <COND (<G? ,ADV-SHIRT-MUD 0> <TELL " muddy">)>
           <COND (<G? ,ADV-SHIRT-WET 0> <TELL " wet">)>
           <COND (<AND <ZERO? ,ADV-SHIRT-TEAR> <ZERO? ,ADV-SHIRT-MUD> <ZERO? ,ADV-SHIRT-WET>>
                  <TELL " merely travel-used">)>
           <TELL ". ">)>
    <TELL "Nothing here is a stat block." CR>
    <RTRUE>>

<ROUTINE ADV-HANDS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Your hands are a worker's: nicked, dirt in the creases, competent. They record what you have actually done, not a character-creation slider." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE ADV-FACE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Without a mirror you get only the usual incomplete sense of your own face: tired around the eyes, unmarked by a named scar until one is earned." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE ADV-HAIR-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Your hair is ordinary, cut for travel rather than display, and currently as clean as the last weather allowed." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE ADV-CLOTH-EXAMINE (WET MUD TEAR SCORCH)
    <TELL "The " D ,PRSO " is a real garment.">
    <COND (<G? .WET 0> <TELL " It is wet.">)>
    <COND (<G? .MUD 0> <TELL " Mud clings to it.">)>
    <COND (<G? .TEAR 0> <TELL " It is torn. Washing will not sew it.">)>
    <COND (<G? .SCORCH 0> <TELL " Scorch has marked it permanently.">)>
    <CRLF>
    <RTRUE>>

<ROUTINE ADV-COAT-F ()
    <COND (<VERB? EXAMINE> <ADV-CLOTH-EXAMINE ,ADV-COAT-WET ,ADV-COAT-MUD 0 ,ADV-COAT-SCORCH>)>
    <RFALSE>>

<ROUTINE ADV-SHIRT-F ()
    <COND (<VERB? EXAMINE> <ADV-CLOTH-EXAMINE ,ADV-SHIRT-WET ,ADV-SHIRT-MUD ,ADV-SHIRT-TEAR 0>)>
    <RFALSE>>

<ROUTINE ADV-TROUSERS-F ()
    <COND (<VERB? EXAMINE> <ADV-CLOTH-EXAMINE ,ADV-TROUSERS-WET ,ADV-TROUSERS-MUD 0 0>)>
    <RFALSE>>

<ROUTINE ADV-BOOTS-F ()
    <COND (<VERB? EXAMINE> <ADV-CLOTH-EXAMINE 0 ,ADV-BOOTS-MUD 0 0>)>
    <RFALSE>>

<ROUTINE HOUSE-WARDROBE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The wardrobe is heavy, hinged, and empty of magic. Garments that live here have location." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE HOUSE-MIRROR-F ()
    <COND (<VERB? EXAMINE LOOK-INSIDE>
           <TELL "The glass shows you as you are in this room: ">
           <ADV-EXAMINE-SELF>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "The standing mirror is House furniture. It is not loot." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE HOUSE-DRESSER-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The dresser has a top drawer that opens. It stores cloth, not attributes." CR>
           <RTRUE>)
          (<VERB? OPEN>
           <COND (<NOT <FSET? ,HOUSE-TOP-DRAWER ,OPENBIT>>
                  <FSET ,HOUSE-TOP-DRAWER ,OPENBIT>
                  <TELL "The top drawer slides open." CR>
                  <RTRUE>)>)>
    <RFALSE>>

<ROUTINE HOUSE-DRAWER-F ()
    <COND (<VERB? EXAMINE LOOK-INSIDE>
           <TELL "The top drawer is an ordinary sliding box." CR>
           <COND (<FIRST? ,HOUSE-TOP-DRAWER>
                  <TELL "It is not empty." CR>)
                 (T <TELL "It is empty." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE HOUSE-BASIN-F ()
    <COND (<VERB? EXAMINE LOOK-INSIDE>
           <TELL "The basin is stone and deep.">
           <COND (<G? ,HOUSE-BASIN-WATER 0> <TELL " It holds wash water.">)
                 (T <TELL " It is dry until you fill it.">)>
           <COND (<G? ,HOUSE-BASIN-SOAP 0> <TELL " Washroot foam clouds the surface.">)>
           <CRLF>
           <RTRUE>)
          (<VERB? FILL>
           <SETG HOUSE-BASIN-WATER 1>
           <TELL "You fill the basin from the kitchen's ordinary water. There is no washing-machine here." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE HOUSE-WASHROOT-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Washroot is a pale GUE cleanser: bruise it in water and it foams. It is not detergent branded from another century." CR>
           <RTRUE>)
          (<AND <VERB? PUT> <EQUAL? ,PRSI ,HOUSE-WASH-BASIN>>
           <COND (<ZERO? ,HOUSE-BASIN-WATER>
                  <TELL "The basin is dry. Fill it first." CR>)
                 (T
                  <SETG HOUSE-BASIN-SOAP 1>
                  <TELL "The root bruises and the water takes a thin soap." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE HOUSE-LINE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A clothesline is strung east of the house, in weather, for wet cloth to dry. Fire is not a dryer." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-COAT-F ()
    <COND (<AND <VERB? TAKE REMOVE> <IN? ,MARA-TRAVEL-COAT ,MARA>>
           <COND (<MARA-PARTNERSHIP-ON?>
                  <TELL "Mara's hand closes on the coat first. Partnership is not a license to undress me, she says." CR>)
                 (T
                  <TELL "Mara steps back and keeps the coat. That is mine, she says. She turns toward another room rather than becoming a doll." CR>
                  <COND (<AND <MARA-HERE?> <NOT <EQUAL? ,HERE ,KITCHEN>>>
                         <MOVE ,MARA ,KITCHEN>
                         <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
                         <TELL "She leaves for the Kitchen, and her location is the Kitchen." CR>)>)>
           <RTRUE>)
          (<VERB? EXAMINE>
           <TELL "Mara's field coat is weathered, hers, and currently in her custody unless she moved it." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE V-ADV-CHANGE ()
    <COND (<NOT <EQUAL? ,HERE ,LIVING-ROOM ,ATTIC ,KITCHEN>>
           <TELL "Change clothes where there is room and furniture, not in a puzzle corridor as a costume skip." CR>
           <RFATAL>)
          (<AND <MARA-HERE?> <NOT <MARA-PARTNERSHIP-ON?>>>
           <TELL "Mara turns away and goes to the doorway. I will give you the room, she says." CR>
           <MOVE ,MARA ,KITCHEN>
           <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>)>
    <TELL "You change using the actual garments in reach. Nothing is conjured from a menu." CR>
    <RFATAL>>

<ROUTINE V-ADV-SCRUB ()
    <COND (<NOT <EQUAL? ,PRSO ,ADV-SHIRT ,ADV-TRAVEL-COAT ,ADV-TROUSERS>>
           <TELL "That is not a washable garment in this basin." CR>
           <RFATAL>)
          (<NOT <EQUAL? ,HERE ,KITCHEN>>
           <TELL "The stone basin is in the Kitchen." CR>
           <RFATAL>)
          (<ZERO? ,HOUSE-BASIN-WATER>
           <TELL "Fill the basin first." CR>
           <RFATAL>)>
    <COND (<EQUAL? ,PRSO ,ADV-SHIRT>
           <SETG ADV-SHIRT-MUD 0>
           <SETG ADV-SHIRT-WET 1>)
          (<EQUAL? ,PRSO ,ADV-TRAVEL-COAT>
           <SETG ADV-COAT-MUD 0>
           <SETG ADV-COAT-WET 1>)
          (T
           <SETG ADV-TROUSERS-MUD 0>
           <SETG ADV-TROUSERS-WET 1>)>
    <TELL "You scrub. Mud leaves; tears and scorch do not. The cloth is wet." CR>
    <RFATAL>>

<ROUTINE V-ADV-WRING ()
    <COND (<EQUAL? ,PRSO ,ADV-SHIRT> <SETG ADV-SHIRT-WET 1>)
          (<EQUAL? ,PRSO ,ADV-TRAVEL-COAT> <SETG ADV-COAT-WET 1>)
          (<EQUAL? ,PRSO ,ADV-TROUSERS> <SETG ADV-TROUSERS-WET 1>)
          (T
           <TELL "Wring cloth, not the empire." CR>
           <RFATAL>)>
    <TELL "Water runs out. The garment is still damp until it hangs in air." CR>
    <RFATAL>>

<ROUTINE V-ADV-HANG ()
    <COND (<NOT <EQUAL? ,PRSI ,HOUSE-CLOTHESLINE>>
           <TELL "Hang washing on the clothesline east of the house." CR>
           <RFATAL>)
          (<NOT <EQUAL? ,HERE ,EAST-OF-HOUSE>>
           <TELL "The clothesline is east of the house." CR>
           <RFATAL>)>
    <MOVE ,PRSO ,EAST-OF-HOUSE>
    <COND (<EQUAL? ,PRSO ,ADV-SHIRT> <SETG ADV-SHIRT-WET 0>)
          (<EQUAL? ,PRSO ,ADV-TRAVEL-COAT> <SETG ADV-COAT-WET 0>)
          (<EQUAL? ,PRSO ,ADV-TROUSERS> <SETG ADV-TROUSERS-WET 0>)>
    <TELL "You hang the " D ,PRSO " on the line. Weather will dry it. The garment remains exactly here." CR>
    <RFATAL>>

<ROUTINE V-ADV-ROLL-SLEEVE ()
    <COND (<NOT <EQUAL? ,PRSO ,ADV-SHIRT ,ADV-TRAVEL-COAT ,ADV-HANDS>>
           <TELL "Roll a sleeve, not the landscape." CR>
           <RFATAL>)>
    <SETG ADV-SLEEVE-ROLLED 1>
    <TELL "You roll a sleeve. Forearm and any later mark would be visible; nothing is hidden by a GUI slot." CR>
    <RFATAL>>
