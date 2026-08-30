"RELEASE 1277 MUNDANE OBJECTS / HOUSE SPATIAL AGENCY / MARA REQUESTS"

;"Release 1277 gives ordinary objects persistent physical presence without
  promising puzzle destiny.  It also extends the real House/rug authority,
  adds bounded physical instant photographs, and treats Mara's labor as a
  request she evaluates rather than a command channel."

<SYNTAX SNAPSHOT = V-R1277-SNAPSHOT>
<SYNTAX ASK OBJECT (FIND ACTORBIT) TO MOVE OBJECT (FIND) = V-R1277-ASK-MOVE>
<SYNTAX ASK OBJECT (FIND ACTORBIT) TO CARRY OBJECT (FIND) = V-R1277-ASK-MOVE>
<SYNTAX ASK OBJECT (FIND ACTORBIT) TO HELP WITH OBJECT (FIND) = V-R1277-ASK-MOVE>

<CONSTANT R1277-SLOT-EXPOSURES 0>
<CONSTANT R1277-SLOT-RUG-CUT 1>
<CONSTANT R1277-SLOT-MARA-HELPING 2>
<CONSTANT R1277-SLOT-MARA-PROMISE 3>
<CONSTANT R1277-SLOT-MARA-HELPED-CARPET 4>
<CONSTANT R1277-STATE <TABLE 0 0 0 0 0>>

;"Each photograph owns four frozen fields: room, Mara-visible, whole-rug
  location, and rug-damaged-at-shutter.  These are save-state table values;
  examining a photograph never asks the live room what it looks like now."
<CONSTANT R1277-PHOTO-STATE <TABLE 0 0 0 0  0 0 0 0  0 0 0 0>>

<ROUTINE R1277-GET (SLOT) <GET ,R1277-STATE .SLOT>>
<ROUTINE R1277-PUT (SLOT VALUE) <PUT ,R1277-STATE .SLOT .VALUE>>

<ROUTINE R1277-COFFEE-HOT? ()
    <COND (<L? ,MOVES 12> <RTRUE>)>
    <RFALSE>>

<ROUTINE R1277-COFFEE-FCN ()
    <COND (<VERB? EXAMINE>
           <COND (<R1277-COFFEE-HOT?>
                  <TELL "Steam still lifts from the coffee. It smells freshly made, which is considerably stranger than the cup itself." CR>)
                 (T
                  <TELL "The coffee has gone cool. The cup still smells faintly roasted, but whatever impossible freshness it had is over." CR>)>
           <RTRUE>)
          (<VERB? DRINK>
           <COND (<R1277-COFFEE-HOT?>
                  <TELL "The coffee is genuinely hot. You manage a careful sip without solving the question of who made it." CR>)
                 (T
                  <TELL "You take a sip of cold coffee. It is ordinary enough to make its location seem even less reasonable." CR>)>
           <RTRUE>)
          (<VERB? PUT>
           <TELL "The cup is open and full enough that packing it like a sealed bottle would simply move the coffee onto everything else." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE R1277-GLASSES-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "The spectacles have temples, bridge, rims, and tiny screws, but no lenses. Worn as they are, they alter nothing about your sight." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE R1277-BEEHIVE-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "The hive is a living colony built into sheltering wood. Bees cross the entrance in a steady working stream; wax and warm honey scent the air around it." CR>
           <RTRUE>)
          (<VERB? TAKE MOVE ATTACK MUNG>
           <TELL "The hive is not a box waiting to become inventory. Disturbing the colony brings an immediate defensive boil of bees around your hands and face, and you retreat before persistence becomes injury." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE R1277-WIRE-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "It is two feet of bare small-gauge copper wire: conductive and easy to bend into a loop or crude hook, but far too weak to trust with a person's weight." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE R1277-INCENSE-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "The little patchouli cones are made to smolder rather than blaze. Burned honestly they would produce scent, smoke, a weak ember, and ash -- useful facts, not a universal ritual key." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT R1277-LARGE-THUMBTACK
    (IN DAM-ROOM)
    (SYNONYM THUMBTACK TACK PIN)
    (ADJECTIVE LARGE METAL)
    (DESC "large thumbtack")
    (FLAGS TAKEBIT)
    (SIZE 1)
    (FDESC "A large thumbtack sits on the industrial floor with no apparent claim to the Dam.")>

<OBJECT R1277-SEAT-CUSHION
    (IN BACKCOUNTRY-BASIN-OVERLOOK)
    (SYNONYM CUSHION PAD SEAT)
    (ADJECTIVE SEAT BULKY)
    (DESC "seat cushion")
    (FLAGS TAKEBIT)
    (SIZE 4)
    (FDESC "A seat cushion rests at the overlook as though somebody expected a chair to follow.")>

<OBJECT R1277-LUXURIOUS-PILLOW
    (IN FOREST-1)
    (SYNONYM PILLOW CUSHION)
    (ADJECTIVE LUXURIOUS SOFT DRY)
    (DESC "luxurious pillow")
    (FLAGS TAKEBIT)
    (SIZE 4)
    (FDESC "An absurdly luxurious pillow lies dry among the forest litter.")>

<OBJECT R1277-HOT-COFFEE
    (IN DEEP-CANYON)
    (SYNONYM COFFEE CUP MUG)
    (ADJECTIVE HOT CERAMIC FRESH)
    (DESC "cup of coffee")
    (FLAGS TAKEBIT)
    (SIZE 2)
    (FDESC "A ceramic cup of coffee sits where fresh coffee has no defensible reason to be.")
    (ACTION R1277-COFFEE-FCN)>

<OBJECT R1277-BENDY-STRAW
    (IN BACKCOUNTRY-COLD-SPRING)
    (SYNONYM STRAW TUBE)
    (ADJECTIVE BENDY FLEXIBLE HOLLOW)
    (DESC "bendy straw")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-OATMEAL-BOX
    (IN KITCHEN)
    (SYNONYM BOX OATMEAL OATS)
    (ADJECTIVE INSTANT VARIETY)
    (DESC "instant oatmeal variety box")
    (FLAGS TAKEBIT CONTBIT OPENBIT)
    (CAPACITY 5)
    (SIZE 3)>

<OBJECT R1277-OATMEAL-CHOCOLATE
    (IN R1277-OATMEAL-BOX)
    (SYNONYM PACKET OATMEAL OATS)
    (ADJECTIVE ZORKIAN CHOCOLATE)
    (DESC "Zorkian Chocolate oatmeal packet")
    (FLAGS TAKEBIT FOODBIT)
    (SIZE 1)>

<OBJECT R1277-OATMEAL-BANANA
    (IN R1277-OATMEAL-BOX)
    (SYNONYM PACKET OATMEAL OATS)
    (ADJECTIVE JUNGLE BANANA)
    (DESC "Jungle Banana oatmeal packet")
    (FLAGS TAKEBIT FOODBIT)
    (SIZE 1)>

<OBJECT R1277-OATMEAL-GRUEBERRY
    (IN R1277-OATMEAL-BOX)
    (SYNONYM PACKET OATMEAL OATS)
    (ADJECTIVE GRUEBERRY)
    (DESC "Grueberry oatmeal packet")
    (FLAGS TAKEBIT FOODBIT)
    (SIZE 1)>

<OBJECT R1277-OATMEAL-PLAIN
    (IN R1277-OATMEAL-BOX)
    (SYNONYM PACKET OATMEAL OATS)
    (ADJECTIVE PLAIN)
    (DESC "Plain oatmeal packet")
    (FLAGS TAKEBIT FOODBIT)
    (SIZE 1)>

<OBJECT R1277-KETCHUP-PACKET
    (IN DAM-BASE)
    (SYNONYM KETCHUP PACKET CONDIMENT)
    (ADJECTIVE RED SEALED FLEXIBLE)
    (DESC "ketchup packet")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-GLASSES-FRAME
    (IN BACKCOUNTRY-HEMLOCK-SWALE)
    (SYNONYM GLASSES SPECTACLES FRAME EYEGLASSES)
    (ADJECTIVE LENSLESS EMPTY)
    (DESC "lensless glasses")
    (FLAGS TAKEBIT CONTBIT OPENBIT)
    (CAPACITY 2)
    (SIZE 1)
    (FDESC "A pair of lensless glasses sits neatly where the hemlocks shed needles around it.")
    (ACTION R1277-GLASSES-FCN)>

<OBJECT R1277-LEFT-LENS
    (IN ATTIC)
    (SYNONYM LENS GLASS)
    (ADJECTIVE LEFT SPECTACLE OPTICAL)
    (DESC "left spectacle lens")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-RIGHT-LENS
    (IN BACKCOUNTRY-WARMWIND-NOTCH)
    (SYNONYM LENS GLASS)
    (ADJECTIVE RIGHT SPECTACLE OPTICAL)
    (DESC "right spectacle lens")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-BEEHIVE
    (IN BACKCOUNTRY-BEAVER-MEADOW)
    (SYNONYM BEEHIVE HIVE COLONY BEES)
    (ADJECTIVE BEE LIVING WILD)
    (DESC "living beehive")
    (FLAGS TRYTAKEBIT)
    (FDESC "A working beehive occupies a protected break in the wood beside the meadow.")
    (ACTION R1277-BEEHIVE-FCN)>

<OBJECT R1277-COPPER-WIRE
    (IN BACKCOUNTRY-FALLEN-CEDAR)
    (SYNONYM WIRE COPPER)
    (ADJECTIVE BARE SMALL GAUGE TWO FOOT)
    (DESC "two feet of copper wire")
    (FLAGS TAKEBIT)
    (SIZE 1)
    (ACTION R1277-WIRE-FCN)>

<OBJECT R1277-INCENSE-CONES
    (IN LIVING-ROOM)
    (SYNONYM INCENSE CONES CONE PATCHOULI)
    (ADJECTIVE ZORK PATCHOULI)
    (DESC "Zork patchouli incense cones")
    (FLAGS TAKEBIT)
    (SIZE 1)
    (ACTION R1277-INCENSE-FCN)>

<OBJECT R1277-LEFT-GLOVE
    (IN BACKCOUNTRY-BRUSH-GATE)
    (SYNONYM GLOVE)
    (ADJECTIVE LEFT LONE)
    (DESC "one left glove")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-PURPLE-STONE
    (IN BACKCOUNTRY-MOSS-RIDGE)
    (SYNONYM STONE ROCK PEBBLE)
    (ADJECTIVE SMOOTH PURPLE)
    (DESC "smooth purple stone")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-SALT-SHAKER
    (IN KITCHEN)
    (SYNONYM SHAKER SALT)
    (ADJECTIVE EMPTY GLASS)
    (DESC "empty salt shaker")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-CLOTHESPIN
    (IN WARMRAIN-CANOPY-EDGE)
    (SYNONYM CLOTHESPIN PEG CLIP)
    (ADJECTIVE WOODEN)
    (DESC "wooden clothespin")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-SHOELACE
    (IN BACKCOUNTRY-FOX-RUN)
    (SYNONYM SHOELACE LACE STRING)
    (ADJECTIVE SINGLE)
    (DESC "single shoelace")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-GROCERY-RECEIPT
    (IN ATTIC)
    (SYNONYM RECEIPT PAPER SLIP BILL)
    (ADJECTIVE GUE GROCERY OLD CENTURY)
    (DESC "century-old GUE grocery receipt")
    (FLAGS TAKEBIT READBIT)
    (SIZE 1)
    (TEXT "GUE PROVISIONS COOPERATIVE, SOUTH MARKET ARCADE. Oat flour, lamp oil, onions, soap, two apples, boot thread. Paid in full. The ink date is a little over a century old; nothing on it resembles a treasure map.")>

<OBJECT R1277-RUBBER-DUCK
    (IN DEEP-CANYON)
    (SYNONYM DUCK DUCKY TOY)
    (ADJECTIVE TINY RUBBER YELLOW)
    (DESC "tiny rubber duck")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-CRACKED-COMB
    (IN DAM-ROOM)
    (SYNONYM COMB)
    (ADJECTIVE CRACKED POCKET)
    (DESC "cracked comb")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-MARBLE
    (IN BACKCOUNTRY-FOX-RUN)
    (SYNONYM MARBLE BALL)
    (ADJECTIVE SINGLE GLASS)
    (DESC "one marble")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-CORK-COASTER
    (IN LIVING-ROOM)
    (SYNONYM COASTER CORK)
    (ADJECTIVE CORK ROUND)
    (DESC "cork coaster")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-BUTTON-ONE
    (IN ATTIC)
    (SYNONYM BUTTON)
    (ADJECTIVE WOODEN MISMATCHED FIRST)
    (DESC "wooden mismatched button")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-BUTTON-TWO
    (IN BACKCOUNTRY-BRUSH-GATE)
    (SYNONYM BUTTON)
    (ADJECTIVE BRASS MISMATCHED SECOND)
    (DESC "brass mismatched button")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-BUTTON-THREE
    (IN DAM-BASE)
    (SYNONYM BUTTON)
    (ADJECTIVE BONE MISMATCHED THIRD)
    (DESC "bone mismatched button")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<OBJECT R1277-PINECONE
    (IN BACKCOUNTRY-HEMLOCK-SWALE)
    (SYNONYM PINECONE CONE)
    (ADJECTIVE PINE ORDINARY COMPLETELY)
    (DESC "completely ordinary pinecone")
    (FLAGS TAKEBIT)
    (SIZE 1)
    (FDESC "A completely ordinary pinecone lies conspicuously enough to make ordinariness feel accusatory.")>

;"The canonical RUG remains the only whole carpet authority.  These fragments
  do not exist in the world until the real rug is cut."
<OBJECT R1277-RUG-PIECE-ONE
    (SYNONYM PIECE FRAGMENT CARPET RUG)
    (ADJECTIVE ORIENTAL LARGE CUT)
    (DESC "large oriental carpet piece")
    (FLAGS TAKEBIT)
    (SIZE 3)>
<OBJECT R1277-RUG-PIECE-TWO
    (SYNONYM PIECE FRAGMENT CARPET RUG)
    (ADJECTIVE ORIENTAL NARROW CUT)
    (DESC "narrow oriental carpet piece")
    (FLAGS TAKEBIT)
    (SIZE 2)>
<OBJECT R1277-RUG-PIECE-THREE
    (SYNONYM PIECE FRAGMENT CARPET RUG)
    (ADJECTIVE ORIENTAL SMALL CUT)
    (DESC "small oriental carpet piece")
    (FLAGS TAKEBIT)
    (SIZE 1)>

<ROUTINE R1277-REVEAL-UNDER-RUG ()
    <COND (<ZERO? ,RUG-MOVED>
           <FCLEAR ,TRAP-DOOR ,INVISIBLE>
           <SETG RUG-MOVED T>)>
    <RTRUE>>

<ROUTINE R1277-TAKE-RUG ()
    <COND (<R1277-GET ,R1277-SLOT-RUG-CUT>
           <TELL "There is no whole carpet left to take; the cut pieces have their own locations now." CR>)
          (<IN? ,RUG ,ADVENTURER>
           <TELL "You are already carrying the rolled, thoroughly inconvenient carpet." CR>)
          (T
           <R1277-REVEAL-UNDER-RUG>
           <MOVE ,RUG ,ADVENTURER>
           <COND (<R1277-GET ,R1277-SLOT-MARA-HELPING>
                  <R1277-PUT ,R1277-SLOT-MARA-HELPING 0>
                  <R1277-PUT ,R1277-SLOT-MARA-HELPED-CARPET 1>
                  <TELL "Mara takes one end while you roll and lift the real oriental carpet. Together you get the awkward bundle under control without pretending it weighs nothing." CR>)
                 (T
                  <TELL "You roll the carpet tightly, wrestle it upright, and take it as an awkward burden. Heavy turns out not to mean cosmically attached to the floor." CR>)>)>
    <RTRUE>>

<ROUTINE R1277-CUT-RUG ()
    <COND (<R1277-GET ,R1277-SLOT-RUG-CUT>
           <TELL "The carpet is already divided into real pieces." CR>)
          (T
           <R1277-REVEAL-UNDER-RUG>
           <R1277-PUT ,R1277-SLOT-RUG-CUT 1>
           <FSET ,RUG ,RMUNGBIT>
           <REMOVE ,RUG>
           <MOVE ,R1277-RUG-PIECE-ONE ,HERE>
           <MOVE ,R1277-RUG-PIECE-TWO ,HERE>
           <MOVE ,R1277-RUG-PIECE-THREE ,HERE>
           <TELL "The cut finally passes through backing as well as pile. The one canonical oriental carpet ceases to be a whole object; three worn carpet pieces remain here, independently movable, while the uncovered trap door remains physically uncovered." CR>)>
    <RTRUE>>

<ROUTINE R1277-WEST-HOUSE-ARRANGEMENT ()
    <COND (<EQUAL? <LOC ,RUG> ,WEST-OF-HOUSE>
           <TELL " A large oriental carpet lies inexplicably before the boarded entrance, trying very hard to serve as a welcome mat despite the lack of porch, patio, or architectural excuse.">
           <RTRUE>)
          (<OR <EQUAL? <LOC ,R1277-RUG-PIECE-ONE> ,WEST-OF-HOUSE>
               <EQUAL? <LOC ,R1277-RUG-PIECE-TWO> ,WEST-OF-HOUSE>
               <EQUAL? <LOC ,R1277-RUG-PIECE-THREE> ,WEST-OF-HOUSE>>
           <TELL " A cut fragment of the House's oriental carpet has been left here as an even less convincing welcome mat.">
           <RTRUE>)>
    <RFALSE>>

<OBJECT R1277-INSTANT-CAMERA
    (IN ATTIC)
    (SYNONYM CAMERA CAMERA PICTURE)
    (ADJECTIVE INSTANT PERIOD)
    (DESC "instant camera")
    (FLAGS TAKEBIT)
    (SIZE 2)
    (FDESC "A period instant camera rests with the House records. Its film pack has exactly three unused exposures.")>

<OBJECT R1277-PHOTO-ONE
    (SYNONYM PHOTO PHOTOGRAPH PICTURE SNAPSHOT)
    (ADJECTIVE INSTANT FIRST)
    (DESC "first instant photograph")
    (FLAGS TAKEBIT)
    (SIZE 1)
    (ACTION R1277-PHOTO-FCN)>
<OBJECT R1277-PHOTO-TWO
    (SYNONYM PHOTO PHOTOGRAPH PICTURE SNAPSHOT)
    (ADJECTIVE INSTANT SECOND)
    (DESC "second instant photograph")
    (FLAGS TAKEBIT)
    (SIZE 1)
    (ACTION R1277-PHOTO-FCN)>
<OBJECT R1277-PHOTO-THREE
    (SYNONYM PHOTO PHOTOGRAPH PICTURE SNAPSHOT)
    (ADJECTIVE INSTANT THIRD)
    (DESC "third instant photograph")
    (FLAGS TAKEBIT)
    (SIZE 1)
    (ACTION R1277-PHOTO-FCN)>

<ROUTINE R1277-STORE-PHOTO (IDX RM MARA-SEEN RUG-LOC RUG-DAMAGED)
    <COND (<EQUAL? .IDX 1>
           <PUT ,R1277-PHOTO-STATE 0 .RM>
           <PUT ,R1277-PHOTO-STATE 1 .MARA-SEEN>
           <PUT ,R1277-PHOTO-STATE 2 .RUG-LOC>
           <PUT ,R1277-PHOTO-STATE 3 .RUG-DAMAGED>)
          (<EQUAL? .IDX 2>
           <PUT ,R1277-PHOTO-STATE 4 .RM>
           <PUT ,R1277-PHOTO-STATE 5 .MARA-SEEN>
           <PUT ,R1277-PHOTO-STATE 6 .RUG-LOC>
           <PUT ,R1277-PHOTO-STATE 7 .RUG-DAMAGED>)
          (T
           <PUT ,R1277-PHOTO-STATE 8 .RM>
           <PUT ,R1277-PHOTO-STATE 9 .MARA-SEEN>
           <PUT ,R1277-PHOTO-STATE 10 .RUG-LOC>
           <PUT ,R1277-PHOTO-STATE 11 .RUG-DAMAGED>)>
    <RTRUE>>

<ROUTINE R1277-PHOTO-FIELDS (OBJ "AUX" IDX RM MS RL RD)
    <COND (<EQUAL? .OBJ ,R1277-PHOTO-ONE> <SET IDX 1>)
          (<EQUAL? .OBJ ,R1277-PHOTO-TWO> <SET IDX 2>)
          (T <SET IDX 3>)>
    <COND (<EQUAL? .IDX 1>
           <SET RM <GET ,R1277-PHOTO-STATE 0>>
           <SET MS <GET ,R1277-PHOTO-STATE 1>>
           <SET RL <GET ,R1277-PHOTO-STATE 2>>
           <SET RD <GET ,R1277-PHOTO-STATE 3>>)
          (<EQUAL? .IDX 2>
           <SET RM <GET ,R1277-PHOTO-STATE 4>>
           <SET MS <GET ,R1277-PHOTO-STATE 5>>
           <SET RL <GET ,R1277-PHOTO-STATE 6>>
           <SET RD <GET ,R1277-PHOTO-STATE 7>>)
          (T
           <SET RM <GET ,R1277-PHOTO-STATE 8>>
           <SET MS <GET ,R1277-PHOTO-STATE 9>>
           <SET RL <GET ,R1277-PHOTO-STATE 10>>
           <SET RD <GET ,R1277-PHOTO-STATE 11>>)>
    <TELL "The instant photograph preserves " D .RM " as it was when the shutter fired.">
    <COND (.MS <TELL " Mara is visibly present in the captured moment.">)>
    <COND (<EQUAL? .RL .RM>
           <TELL " The whole oriental carpet is visibly part of that old arrangement">
           <COND (.RD <TELL ", already worn or damaged">)>
           <TELL ".">)>
    <TELL " Nothing in the photograph changes merely because the live room has changed since then." CR>
    <RTRUE>>

<ROUTINE R1277-PHOTO-FCN ()
    <COND (<VERB? EXAMINE> <R1277-PHOTO-FIELDS ,PRSO>)>
    <RFALSE>>

<ROUTINE V-R1277-SNAPSHOT ("AUX" USED IDX PHOTO MS RD)
    <COND (<NOT <HELD? ,R1277-INSTANT-CAMERA>>
           <TELL "You need to be holding the instant camera to take a physical photograph." CR>
           <RTRUE>)>
    <SET USED <R1277-GET ,R1277-SLOT-EXPOSURES>>
    <COND (<G? .USED 2>
           <TELL "The camera's three-exposure film pack is empty." CR>
           <RTRUE>)>
    <SET IDX <+ .USED 1>>
    <COND (<EQUAL? .IDX 1> <SET PHOTO ,R1277-PHOTO-ONE>)
          (<EQUAL? .IDX 2> <SET PHOTO ,R1277-PHOTO-TWO>)
          (T <SET PHOTO ,R1277-PHOTO-THREE>)>
    <SET MS 0>
    <COND (<MARA-HERE?> <SET MS 1>)>
    <SET RD 0>
    <COND (<FSET? ,RUG ,RMUNGBIT> <SET RD 1>)>
    <R1277-STORE-PHOTO .IDX ,HERE .MS <LOC ,RUG> .RD>
    <MOVE .PHOTO ,ADVENTURER>
    <R1277-PUT ,R1277-SLOT-EXPOSURES .IDX>
    <TELL "The instant camera snaps. A square photograph feeds into your hand and begins to develop. Whatever happens next, this physical print belongs to the scene that existed at this shutter press." CR>
    <RTRUE>>

<ROUTINE R1277-MARA-CAN-COOPERATE? ()
    <COND (<NOT <MARA-HERE?>> <RFALSE>)
          (<MARA-GET ,MARA-SLOT-LADDER-PERIL> <RFALSE>)
          (<AND <MARA-GET ,MARA-SLOT-LADDER-INJURY>
                <ZERO? <MARA-GET ,MARA-SLOT-LADDER-RECOVERED>>>
           <RFALSE>)
          (<MARA-GET ,MARA-SLOT-BIO-BROKE-PROMISE> <RFALSE>)>
    <RTRUE>>

<ROUTINE V-R1277-ASK-MOVE ()
    <COND (<NOT <EQUAL? ,PRSO ,MARA>>
           <TELL "That request grammar is reserved for an autonomous companion who can answer it." CR>)
          (<NOT <EQUAL? ,PRSI ,RUG>>
           <TELL "Mara looks at the requested object. That is not one of the bounded cooperative moves she and you have actually worked out." CR>)
          (<NOT <MARA-HERE?>>
           <TELL "Mara is not here to hear or evaluate the request." CR>)
          (<MARA-GET ,MARA-SLOT-LADDER-PERIL>
           <TELL "Not now, Mara says. Immediate danger outranks rearranging the House." CR>)
          (<AND <MARA-GET ,MARA-SLOT-LADDER-INJURY>
                <ZERO? <MARA-GET ,MARA-SLOT-LADDER-RECOVERED>>>
           <TELL "Mara tests the injured shoulder and stops. No, she says. I can help plan the route, but I am not putting that load through this shoulder before it heals." CR>)
          (<MARA-GET ,MARA-SLOT-BIO-BROKE-PROMISE>
           <TELL "Mara looks at you, then the carpet. If somebody is trapped under it, I help. Optional close hauling after the rope promise? No. Not yet." CR>)
          (<NOT <EQUAL? <LOC ,RUG> ,HERE>>
           <R1277-PUT ,R1277-SLOT-MARA-PROMISE ,RUG>
           <TELL "Mara considers the carpet's last known place. I will help when we are both with the actual thing, she says. That is a promise to revisit the lift, not permission to teleport it here." CR>)
          (T
           <R1277-PUT ,R1277-SLOT-MARA-HELPING 1>
           <COND (<EQUAL? ,HERE ,WEST-OF-HOUSE>
                  <TELL "Mara looks from the oriental carpet to the boarded entrance. There isn't even a porch, she says. Then she takes the other end. Fine. Your imaginary welcome mat." CR>)
                 (T
                  <TELL "Mara checks the carpet, the route, and her own footing. All right, she says. You take that end. She is agreeing to this move, not surrendering judgment over every command that can be typed." CR>)>)>
    <RTRUE>>
