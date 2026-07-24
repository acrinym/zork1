"Kitchen preparation and grounded laboratory for the repository-local Zork I Glulx lineage."

;"Release 1221 turns the canonical Kitchen into a bounded preparation room.
  The real bottle, water, food, tools, and puzzle objects remain authoritative.
  Fixed fixtures support selected washing, drying, warming, storage, and food
  preparation without crafting, hunger, universal chemistry, or object copies."

<SYNTAX FILL OBJECT FROM OBJECT = V-KITCHEN-FILL-FROM>
<SYNTAX WASH OBJECT IN OBJECT = V-KITCHEN-WASH-IN>
<SYNTAX RINSE OBJECT IN OBJECT = V-KITCHEN-WASH-IN>
<SYNTAX DRY OBJECT = V-KITCHEN-DRY>
<SYNTAX WARM OBJECT ON OBJECT = V-KITCHEN-WARM-ON>
<SYNTAX HEAT OBJECT ON OBJECT = V-KITCHEN-WARM-ON>
<SYNTAX COOL OBJECT = V-KITCHEN-COOL>
<SYNTAX PREPARE OBJECT = V-KITCHEN-PREPARE>
<SYNTAX SLICE OBJECT WITH OBJECT = V-KITCHEN-CUT-WITH>
<SYNTAX CHOP OBJECT WITH OBJECT = V-KITCHEN-CUT-WITH>
<SYNTAX LIGHT OBJECT WITH OBJECT = V-KITCHEN-LIGHT-WITH>

<CONSTANT KITCHEN-SCHEMA 1>

<GLOBAL KITCHEN-VERSION 1>
<GLOBAL KITCHEN-STOVE-HEAT 0>
<GLOBAL KITCHEN-LUNCH-WARM 0>
<GLOBAL KITCHEN-WATER-WARM 0>
<GLOBAL KITCHEN-GARLIC-WARM 0>

<GLOBAL KITCHEN-SHOVEL-WET 0>
<GLOBAL KITCHEN-WRENCH-WET 0>
<GLOBAL KITCHEN-SCREWDRIVER-WET 0>
<GLOBAL KITCHEN-AXE-WET 0>
<GLOBAL KITCHEN-KNIFE-WET 0>
<GLOBAL KITCHEN-BOTTLE-WET 0>
<GLOBAL KITCHEN-WORKTOP-WET 0>

<GLOBAL KITCHEN-KNIFE-CLEANED <>>
<GLOBAL KITCHEN-BOTTLE-CLEANED <>>
<GLOBAL KITCHEN-LUNCH-PREPARED <>>
<GLOBAL KITCHEN-GARLIC-SLICED <>>
<GLOBAL KITCHEN-WORKTOP-RESIDUE <>>

<GLOBAL KITCHEN-EVENT-WATER <>>
<GLOBAL KITCHEN-EVENT-CLEANING <>>
<GLOBAL KITCHEN-EVENT-HEAT <>>
<GLOBAL KITCHEN-EVENT-FOOD <>>
<GLOBAL KITCHEN-EVENT-EXPERIMENT <>>
<GLOBAL KITCHEN-EVENT-STORAGE <>>
<GLOBAL KITCHEN-EVENT-OFFERING <>>

<OBJECT KITCHEN-SINK
    (IN KITCHEN)
    (SYNONYM SINK BASIN TAP FAUCET)
    (ADJECTIVE KITCHEN DEEP PORCELAIN)
    (DESC "porcelain sink")
    (FLAGS NDESCBIT CONTBIT OPENBIT TRYTAKEBIT)
    (ACTION KITCHEN-FIXTURE-FCN)
    (CAPACITY 25)>

<OBJECT KITCHEN-WORKTOP
    (IN KITCHEN)
    (SYNONYM COUNTER WORKTOP COUNTERTOP SURFACE)
    (ADJECTIVE KITCHEN WOODEN WORK)
    (DESC "wooden worktop")
    (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT TRYTAKEBIT)
    (ACTION KITCHEN-FIXTURE-FCN)
    (CAPACITY 80)>

<OBJECT KITCHEN-CUPBOARD
    (IN KITCHEN)
    (SYNONYM CUPBOARD CABINET STORAGE)
    (ADJECTIVE KITCHEN PLAIN WOODEN)
    (DESC "wooden cupboard")
    (FLAGS NDESCBIT CONTBIT SEARCHBIT TRYTAKEBIT)
    (ACTION KITCHEN-FIXTURE-FCN)
    (CAPACITY 80)>

<OBJECT KITCHEN-RANGE
    (IN KITCHEN)
    (SYNONYM RANGE STOVE PLATE BURNER)
    (ADJECTIVE KITCHEN IRON)
    (DESC "cast-iron range")
    (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT TRYTAKEBIT)
    (ACTION KITCHEN-FIXTURE-FCN)
    (CAPACITY 40)>

<ROUTINE KITCHEN-HERE? ()
    <COND (<EQUAL? ,HERE ,KITCHEN> <RTRUE>)>
    <RFALSE>>

<ROUTINE KITCHEN-HELD? (OBJ)
    <COND (<IN? .OBJ ,WINNER> <RTRUE>)>
    <RFALSE>>

<ROUTINE KITCHEN-ACTIVE-FIELD-OBJECT? (OBJ)
    <COND (<MUSEUM-ACTIVE-FIELD-OBJECT? .OBJ> <RTRUE>)
          (<EQUAL? .OBJ ,BOTTLE ,WATER ,GARLIC ,WRENCH ,SCREWDRIVER ,PUTTY>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE KITCHEN-WASHABLE? (OBJ)
    <COND (<EQUAL? .OBJ ,SHOVEL ,WRENCH ,SCREWDRIVER ,AXE
                        ,RUSTY-KNIFE ,KNIFE ,BOTTLE>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE KITCHEN-RANGE-ACCEPTS? (OBJ)
    <COND (<EQUAL? .OBJ ,LUNCH ,GARLIC ,BOTTLE ,SHOVEL ,WRENCH
                        ,SCREWDRIVER ,AXE ,RUSTY-KNIFE ,KNIFE>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE KITCHEN-SINK-ACCEPTS? (OBJ)
    <COND (<KITCHEN-WASHABLE? .OBJ> <RTRUE>)>
    <RFALSE>>

<ROUTINE KITCHEN-SET-WET (OBJ N)
    <COND (<EQUAL? .OBJ ,SHOVEL> <SETG KITCHEN-SHOVEL-WET .N>)
          (<EQUAL? .OBJ ,WRENCH> <SETG KITCHEN-WRENCH-WET .N>)
          (<EQUAL? .OBJ ,SCREWDRIVER> <SETG KITCHEN-SCREWDRIVER-WET .N>)
          (<EQUAL? .OBJ ,AXE> <SETG KITCHEN-AXE-WET .N>)
          (<EQUAL? .OBJ ,KNIFE ,RUSTY-KNIFE> <SETG KITCHEN-KNIFE-WET .N>)
          (<EQUAL? .OBJ ,BOTTLE> <SETG KITCHEN-BOTTLE-WET .N>)
          (<EQUAL? .OBJ ,KITCHEN-WORKTOP> <SETG KITCHEN-WORKTOP-WET .N>)>
    <RTRUE>>

<ROUTINE KITCHEN-WET? (OBJ)
    <COND (<AND <EQUAL? .OBJ ,SHOVEL> <G? ,KITCHEN-SHOVEL-WET 0>> <RTRUE>)
          (<AND <EQUAL? .OBJ ,WRENCH> <G? ,KITCHEN-WRENCH-WET 0>> <RTRUE>)
          (<AND <EQUAL? .OBJ ,SCREWDRIVER> <G? ,KITCHEN-SCREWDRIVER-WET 0>> <RTRUE>)
          (<AND <EQUAL? .OBJ ,AXE> <G? ,KITCHEN-AXE-WET 0>> <RTRUE>)
          (<AND <EQUAL? .OBJ ,KNIFE ,RUSTY-KNIFE> <G? ,KITCHEN-KNIFE-WET 0>> <RTRUE>)
          (<AND <EQUAL? .OBJ ,BOTTLE> <G? ,KITCHEN-BOTTLE-WET 0>> <RTRUE>)
          (<AND <EQUAL? .OBJ ,KITCHEN-WORKTOP> <G? ,KITCHEN-WORKTOP-WET 0>> <RTRUE>)>
    <RFALSE>>

<ROUTINE KITCHEN-DEC-WET ()
    <COND (<G? ,KITCHEN-SHOVEL-WET 0>
           <SETG KITCHEN-SHOVEL-WET <- ,KITCHEN-SHOVEL-WET 1>>)>
    <COND (<G? ,KITCHEN-WRENCH-WET 0>
           <SETG KITCHEN-WRENCH-WET <- ,KITCHEN-WRENCH-WET 1>>)>
    <COND (<G? ,KITCHEN-SCREWDRIVER-WET 0>
           <SETG KITCHEN-SCREWDRIVER-WET <- ,KITCHEN-SCREWDRIVER-WET 1>>)>
    <COND (<G? ,KITCHEN-AXE-WET 0>
           <SETG KITCHEN-AXE-WET <- ,KITCHEN-AXE-WET 1>>)>
    <COND (<G? ,KITCHEN-KNIFE-WET 0>
           <SETG KITCHEN-KNIFE-WET <- ,KITCHEN-KNIFE-WET 1>>)>
    <COND (<G? ,KITCHEN-BOTTLE-WET 0>
           <SETG KITCHEN-BOTTLE-WET <- ,KITCHEN-BOTTLE-WET 1>>)>
    <COND (<G? ,KITCHEN-WORKTOP-WET 0>
           <SETG KITCHEN-WORKTOP-WET <- ,KITCHEN-WORKTOP-WET 1>>)>
    <RFALSE>>

<ROUTINE KITCHEN-ADVANCE ()
    <COND (<SHADOW-NON-TURN-COMMAND?> <RFALSE>)>
    <KITCHEN-DEC-WET>
    <COND (<G? ,KITCHEN-STOVE-HEAT 0>
           <SETG KITCHEN-STOVE-HEAT <- ,KITCHEN-STOVE-HEAT 1>>
           <COND (<AND <0? ,KITCHEN-STOVE-HEAT> <KITCHEN-HERE?>>
                  <TELL "The last heat fades from the cast-iron range." CR>)>)>
    <COND (<G? ,KITCHEN-LUNCH-WARM 0>
           <SETG KITCHEN-LUNCH-WARM <- ,KITCHEN-LUNCH-WARM 1>>)>
    <COND (<G? ,KITCHEN-WATER-WARM 0>
           <SETG KITCHEN-WATER-WARM <- ,KITCHEN-WATER-WARM 1>>)>
    <COND (<G? ,KITCHEN-GARLIC-WARM 0>
           <SETG KITCHEN-GARLIC-WARM <- ,KITCHEN-GARLIC-WARM 1>>)>
    <COND (<NOT <IN? ,WATER ,BOTTLE>> <SETG KITCHEN-WATER-WARM 0>)>
    <RFALSE>>

<ROUTINE KITCHEN-CONTENTS (OBJ "AUX" ITEM)
    <SET ITEM <FIRST? .OBJ>>
    <COND (<NOT .ITEM>
           <TELL " It is empty.">)
          (T
           <TELL " It currently holds ">
           <REPEAT ()
               <TELL D .ITEM>
               <SET ITEM <NEXT? .ITEM>>
               <COND (<NOT .ITEM> <RETURN>)
                     (T <TELL ", ">)>>
           <TELL ".">)>
    <RTRUE>>

<ROUTINE KITCHEN-DESCRIBE-FIXTURE (OBJ)
    <COND (<EQUAL? .OBJ ,KITCHEN-SINK>
           <TELL "A deep porcelain sink has a working cold-water tap. Its cold tap can refill the glass bottle only when the available quantity of portable water is not already committed elsewhere.">
           <KITCHEN-CONTENTS .OBJ>)
          (<EQUAL? .OBJ ,KITCHEN-WORKTOP>
           <TELL "A broad wooden worktop supports real food, containers, and tools.">
           <COND (,KITCHEN-WORKTOP-RESIDUE
                  <TELL " Pepper crumbs and garlic oil mark the grain.">)>
           <COND (<G? ,KITCHEN-WORKTOP-WET 0>
                  <TELL " The surface is wet.">)>
           <KITCHEN-CONTENTS .OBJ>)
          (<EQUAL? .OBJ ,KITCHEN-CUPBOARD>
           <TELL "A plain wooden cupboard provides deliberate storage rather than an automatic equipment locker.">
           <COND (<FSET? .OBJ ,OPENBIT>
                  <KITCHEN-CONTENTS .OBJ>)
                 (T <TELL " It is closed.">)>)
          (T
           <TELL "A cast-iron range can be lit with a real held flame. Its heat is temporary and deliberately limited.">
           <COND (<G? ,KITCHEN-STOVE-HEAT 0>
                  <TELL " The iron is currently hot.">)
                 (T <TELL " The iron is cold.">)>
           <KITCHEN-CONTENTS .OBJ>)>
    <CRLF>
    <RTRUE>>

<ROUTINE KITCHEN-FIXTURE-FCN ("AUX" OBJ)
    <COND (<EQUAL? ,PRSO ,KITCHEN-SINK ,KITCHEN-WORKTOP ,KITCHEN-CUPBOARD ,KITCHEN-RANGE>
           <SET OBJ ,PRSO>)
          (<EQUAL? ,PRSI ,KITCHEN-SINK ,KITCHEN-WORKTOP ,KITCHEN-CUPBOARD ,KITCHEN-RANGE>
           <SET OBJ ,PRSI>)>
    <COND (<AND .OBJ <VERB? EXAMINE LOOK-INSIDE SEARCH>>
           <KITCHEN-DESCRIBE-FIXTURE .OBJ>)
          (<AND .OBJ <VERB? TAKE MOVE MUNG>
                <EQUAL? ,PRSO .OBJ>>
           <TELL "The fixture is built into the Kitchen and is not portable." CR>
           <RTRUE>)
          (<AND <EQUAL? .OBJ ,KITCHEN-SINK ,KITCHEN-WORKTOP ,KITCHEN-RANGE>
                <VERB? OPEN CLOSE>>
           <TELL "That fixture has no useful lid or door." CR>
           <RTRUE>)
          (<AND <EQUAL? .OBJ ,KITCHEN-SINK>
                <VERB? DRINK>>
           <SETG KITCHEN-EVENT-WATER T>
           <TELL "You drink from the cold tap. The sink supplies a drink, not a second portable water object." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE KITCHEN-PROJECT ()
    <KITCHEN-ENSURE>
    <TELL " The room now contains a porcelain sink, a broad worktop, a wooden cupboard, and a cast-iron range.">
    <COND (<G? ,KITCHEN-STOVE-HEAT 0> <TELL " The range radiates a controlled heat.">)>
    <COND (,KITCHEN-LUNCH-PREPARED
           <TELL " The lunch has been deliberately prepared rather than merely carried.">)>
    <COND (,KITCHEN-GARLIC-SLICED
           <TELL " Cut garlic gives the room a decisive smell.">)>
    <COND (,KITCHEN-WORKTOP-RESIDUE
           <TELL " Food preparation has left visible residue on the worktop.">)>
    <CRLF>
    <RTRUE>>

<ROUTINE KITCHEN-BEGIN ()
    <COND (<AND <VERB? PUT PUT-ON>
                <EQUAL? ,PRSI ,KITCHEN-SINK>
                <NOT <KITCHEN-SINK-ACCEPTS? ,PRSO>>>
           <TELL "The sink is for the selected washable bottle and tools, not a universal disposal pit." CR>
           <RTRUE>)
          (<AND <VERB? PUT PUT-ON>
                <EQUAL? ,PRSI ,KITCHEN-RANGE>
                <NOT <KITCHEN-RANGE-ACCEPTS? ,PRSO>>>
           <TELL "The range accepts only the selected food, bottle, and metal-tool experiments." CR>
           <RTRUE>)
          (<AND <VERB? PUT PUT-ON>
                <EQUAL? ,PRSI ,KITCHEN-RANGE>
                <G? ,KITCHEN-STOVE-HEAT 0>
                <EQUAL? ,PRSO ,BOTTLE>
                <IN? ,WATER ,BOTTLE>
                <NOT <FSET? ,BOTTLE ,OPENBIT>>>
           <TELL "Heating a sealed bottle full of water is pressure-vessel work, not food preparation. Open it first." CR>
           <RTRUE>)
          (<AND <VERB? PUT PUT-ON>
                <EQUAL? ,PRSI ,KITCHEN-CUPBOARD>
                <SHADOW-FLAME? ,PRSO>>
           <TELL "The cupboard refuses to become a firebox. Extinguish the object before storing it." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE KITCHEN-END ()
    <KITCHEN-ENSURE>
    <COND (<AND <VERB? PUT PUT-ON> ,PRSO ,PRSI <IN? ,PRSO ,PRSI>>
           <COND (<EQUAL? ,PRSI ,KITCHEN-CUPBOARD ,KITCHEN-WORKTOP
                                ,KITCHEN-SINK ,KITCHEN-RANGE>
                  <SETG KITCHEN-EVENT-STORAGE T>
                  <COND (<KITCHEN-ACTIVE-FIELD-OBJECT? ,PRSO>
                         <TELL "This is deliberate storage, not retirement. The " D ,PRSO " remains real and may still be required by the adventure." CR>)>)>)>
    <RFALSE>>

<ROUTINE V-KITCHEN-FILL-FROM ()
    <COND (<NOT <KITCHEN-HERE?>>
           <TELL "That bounded water source exists only in the white-house Kitchen." CR>)
          (<NOT <EQUAL? ,PRSO ,BOTTLE>>
           <TELL "The Kitchen source is qualified only for the glass bottle." CR>)
          (<NOT <EQUAL? ,PRSI ,KITCHEN-SINK>>
           <TELL "The Kitchen's portable-water route is the sink into the glass bottle." CR>)
          (<NOT <ACCESSIBLE? ,BOTTLE>>
           <TELL "The bottle is not within reach." CR>)
          (<NOT <FSET? ,BOTTLE ,OPENBIT>>
           <TELL "The bottle is closed." CR>)
          (<IN? ,WATER ,BOTTLE>
           <TELL "The bottle is already full of water." CR>)
          (<LOC ,WATER>
           <TELL "A usable quantity of water already exists elsewhere. The sink does not clone it." CR>)
          (T
           <MOVE ,WATER ,BOTTLE>
           <SETG KITCHEN-WATER-WARM 0>
           <SETG KITCHEN-EVENT-WATER T>
           <TELL "Cold water runs into the real glass bottle. No second water object is created." CR>)>
    <RTRUE>>

<ROUTINE KITCHEN-WASH-OBJECT (OBJ)
    <COND (<NOT <KITCHEN-WASHABLE? .OBJ>>
           <COND (<EQUAL? .OBJ ,MAP ,GUIDE ,OWNERS-MANUAL ,ADVERTISEMENT
                               ,BOAT-LABEL ,BOOK>
                  <TELL "The sink is not permitted to convert evidence into pulp." CR>)
                 (<EQUAL? .OBJ ,LUNCH ,GARLIC>
                  <TELL "Washing the food would create sogginess, not preparation." CR>)
                 (T <TELL "That object has no authored Kitchen washing state." CR>)>)
          (<EQUAL? .OBJ ,RUSTY-KNIFE>
           <SETG MATERIAL-RUST-WET 3>
           <KITCHEN-SET-WET .OBJ 3>
           <SETG KITCHEN-EVENT-CLEANING T>
           <TELL "The sink removes loose rust but leaves water in every pit. Dry the knife promptly or the existing corrosion consequence will advance." CR>)
          (<EQUAL? .OBJ ,SHOVEL ,WRENCH ,SCREWDRIVER ,AXE>
           <MATERIAL-MARK-TOOL-CLEAN .OBJ>
           <KITCHEN-SET-WET .OBJ 3>
           <SETG KITCHEN-EVENT-CLEANING T>
           <TELL "Cold water removes the visible grime from the " D .OBJ ". Its real working surfaces are exposed, and it is now wet." CR>)
          (<EQUAL? .OBJ ,KNIFE>
           <SETG KITCHEN-KNIFE-CLEANED T>
           <KITCHEN-SET-WET .OBJ 3>
           <SETG KITCHEN-EVENT-CLEANING T>
           <TELL "You wash the nasty knife until its blade is clean enough for deliberate food preparation. It remains a nasty knife." CR>)
          (<EQUAL? .OBJ ,BOTTLE>
           <SETG KITCHEN-BOTTLE-CLEANED T>
           <KITCHEN-SET-WET .OBJ 2>
           <SETG KITCHEN-EVENT-CLEANING T>
           <TELL "You rinse the glass bottle. It is clean, wet, and still the same canonical container." CR>)
          (T
           <TELL "That object has no authored Kitchen washing state." CR>)>
    <RTRUE>>

<ROUTINE V-KITCHEN-WASH-IN ()
    <COND (<NOT <KITCHEN-HERE?>>
           <TELL "The grounded washing station is in the white-house Kitchen." CR>)
          (<NOT <EQUAL? ,PRSI ,KITCHEN-SINK>>
           <TELL "Use the porcelain sink for this bounded washing action." CR>)
          (<NOT <ACCESSIBLE? ,PRSO>>
           <TELL "The object is not within reach." CR>)
          (T <KITCHEN-WASH-OBJECT ,PRSO>)>
    <RTRUE>>

<ROUTINE V-KITCHEN-DRY ()
    <COND (<NOT <KITCHEN-WET? ,PRSO>>
           <TELL "The " D ,PRSO " is not presently wet in the Kitchen state." CR>)
          (T
           <KITCHEN-SET-WET ,PRSO 0>
           <COND (<EQUAL? ,PRSO ,RUSTY-KNIFE> <SETG MATERIAL-RUST-WET 0>)>
           <SETG KITCHEN-EVENT-CLEANING T>
           <TELL "You dry the " D ,PRSO " thoroughly. No new object, bonus, or repair is created." CR>)>
    <RTRUE>>

<ROUTINE V-KITCHEN-LIGHT-WITH ()
    <COND (<NOT <KITCHEN-HERE?>>
           <TELL "The cast-iron range is in the white-house Kitchen." CR>)
          (<NOT <EQUAL? ,PRSO ,KITCHEN-RANGE>>
           <TELL "This bounded lighting action applies only to the Kitchen range." CR>)
          (<NOT <KITCHEN-HELD? ,PRSI>>
           <TELL "You would first need to be holding the flame source." CR>)
          (<NOT <SHADOW-FLAME? ,PRSI>>
           <TELL "The " D ,PRSI " is not presently a live flame." CR>)
          (T
           <SETG KITCHEN-STOVE-HEAT 10>
           <SETG KITCHEN-EVENT-HEAT T>
           <TELL "You transfer flame to the range. The iron warms for a bounded interval; no fuel economy or permanent fire begins." CR>)>
    <RTRUE>>

<ROUTINE V-KITCHEN-WARM-ON ()
    <COND (<NOT <KITCHEN-HERE?>>
           <TELL "The Kitchen range is not here." CR>)
          (<NOT <EQUAL? ,PRSI ,KITCHEN-RANGE>>
           <TELL "The authored warming surface is the cast-iron Kitchen range." CR>)
          (<NOT <G? ,KITCHEN-STOVE-HEAT 0>>
           <TELL "The range is cold. Light it with a real held flame first." CR>)
          (<NOT <IN? ,PRSO ,KITCHEN-RANGE>>
           <TELL "Place the " D ,PRSO " on the range before warming it." CR>)
          (<EQUAL? ,PRSO ,LUNCH>
           <SETG KITCHEN-LUNCH-WARM 4>
           <SETG KITCHEN-EVENT-HEAT T>
           <TELL "The prepared pepper sandwich warms without becoming a recipe or a new food object." CR>)
          (<EQUAL? ,PRSO ,GARLIC>
           <SETG KITCHEN-GARLIC-WARM 4>
           <SETG KITCHEN-EVENT-HEAT T>
           <TELL "The garlic warms and releases a stronger scent. It remains the same real clove." CR>)
          (<EQUAL? ,PRSO ,BOTTLE>
           <COND (<NOT <IN? ,WATER ,BOTTLE>>
                  <TELL "Heating an empty glass bottle would be a poor and unauthored experiment." CR>)
                 (<NOT <FSET? ,BOTTLE ,OPENBIT>>
                  <TELL "Open the water-filled bottle before applying heat." CR>)
                 (T
                  <SETG KITCHEN-WATER-WARM 4>
                  <SETG KITCHEN-EVENT-HEAT T>
                  <TELL "The water becomes warm but does not boil, multiply, or become a potion." CR>)>)
          (<EQUAL? ,PRSO ,SHOVEL ,WRENCH ,SCREWDRIVER ,AXE ,KNIFE ,RUSTY-KNIFE>
           <KITCHEN-SET-WET ,PRSO 0>
           <COND (<EQUAL? ,PRSO ,RUSTY-KNIFE> <SETG MATERIAL-RUST-WET 0>)>
           <SETG KITCHEN-EVENT-EXPERIMENT T>
           <TELL "The controlled heat dries the " D ,PRSO ". It grants no sharper edge, stronger attack, or puzzle bypass." CR>)
          (T
           <TELL "That object has no authored warming reaction." CR>)>
    <RTRUE>>

<ROUTINE V-KITCHEN-COOL ()
    <COND (<EQUAL? ,PRSO ,KITCHEN-RANGE>
           <COND (<G? ,KITCHEN-STOVE-HEAT 0>
                  <SETG KITCHEN-STOVE-HEAT 0>
                  <SETG KITCHEN-EVENT-EXPERIMENT T>
                  <TELL "You let the range cool completely." CR>)
                 (T <TELL "The range is already cold." CR>)>)
          (<AND <EQUAL? ,PRSO ,LUNCH> <G? ,KITCHEN-LUNCH-WARM 0>>
           <SETG KITCHEN-LUNCH-WARM 0>
           <TELL "The lunch cools to room temperature." CR>)
          (<AND <EQUAL? ,PRSO ,GARLIC> <G? ,KITCHEN-GARLIC-WARM 0>>
           <SETG KITCHEN-GARLIC-WARM 0>
           <TELL "The garlic cools, though its scent remains." CR>)
          (<AND <EQUAL? ,PRSO ,BOTTLE ,WATER> <G? ,KITCHEN-WATER-WARM 0>>
           <SETG KITCHEN-WATER-WARM 0>
           <TELL "The water cools without changing identity." CR>)
          (T <TELL "There is no authored Kitchen heat to remove from that object." CR>)>
    <RTRUE>>

<ROUTINE V-KITCHEN-PREPARE ()
    <COND (<NOT <KITCHEN-HERE?>>
           <TELL "Food preparation belongs at the white-house Kitchen worktop." CR>)
          (<NOT <EQUAL? ,PRSO ,LUNCH>>
           <TELL "The bounded preparation action currently applies only to the real lunch." CR>)
          (<NOT <IN? ,LUNCH ,KITCHEN-WORKTOP>>
           <TELL "Put the lunch on the worktop before preparing it." CR>)
          (,KITCHEN-LUNCH-PREPARED
           <TELL "The lunch is already deliberately arranged for serving." CR>)
          (T
           <SETG KITCHEN-LUNCH-PREPARED T>
           <SETG KITCHEN-WORKTOP-RESIDUE T>
           <SETG KITCHEN-EVENT-FOOD T>
           <TELL "You unwrap and arrange the hot-pepper sandwich on the worktop. It remains the real lunch and carries no hunger score." CR>)>
    <RTRUE>>

<ROUTINE V-KITCHEN-CUT-WITH ()
    <COND (<NOT <KITCHEN-HERE?>>
           <TELL "The authored cutting surface is the Kitchen worktop." CR>)
          (<NOT <EQUAL? ,PRSO ,GARLIC>>
           <TELL "The bounded slicing action applies only to the real clove of garlic." CR>)
          (<NOT <EQUAL? ,PRSI ,KNIFE>>
           <TELL "Use the real nasty knife for this selected preparation." CR>)
          (<NOT <KITCHEN-HELD? ,KNIFE>>
           <TELL "You would first need to be holding the knife." CR>)
          (<NOT ,KITCHEN-KNIFE-CLEANED>
           <TELL "The nasty knife should be washed in the sink before it touches food." CR>)
          (<KITCHEN-WET? ,KNIFE>
           <TELL "Dry the knife before slicing the garlic." CR>)
          (<NOT <IN? ,GARLIC ,KITCHEN-WORKTOP>>
           <TELL "Put the garlic on the worktop before slicing it." CR>)
          (,KITCHEN-GARLIC-SLICED
           <TELL "The garlic is already sliced." CR>)
          (T
           <SETG KITCHEN-GARLIC-SLICED T>
           <SETG KITCHEN-WORKTOP-RESIDUE T>
           <SETG KITCHEN-EVENT-FOOD T>
           <TELL "You slice the real clove. Garlic oil marks the worktop, and the same canonical garlic becomes much more fragrant." CR>)>
    <RTRUE>>

<ROUTINE KITCHEN-WATER-APPLIED? (TARGET)
    <COND (<AND <VERB? SHADOW-USE-ON>
                <EQUAL? ,PRSI .TARGET>
                <EQUAL? ,PRSO ,WATER ,BOTTLE>>
           <RTRUE>)
          (<AND <VERB? POUR-ON>
                <EQUAL? ,PRSI .TARGET>
                <EQUAL? ,PRSO ,WATER>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE KITCHEN-WATER-EXPERIMENT ()
    <COND (<KITCHEN-WATER-APPLIED? ,KITCHEN-RANGE>
           <COND (<NOT <SHADOW-HAS-BOTTLED-WATER?>>
                  <TELL "The open bottle must contain the real water before it can cool the range." CR>)
                 (<0? ,KITCHEN-STOVE-HEAT>
                  <TELL "Water runs across cold iron and contributes only cleanup." CR>)
                 (T
                  <MATERIAL-CONSUME-BOTTLED-WATER>
                  <SETG KITCHEN-STOVE-HEAT 0>
                  <SETG KITCHEN-EVENT-EXPERIMENT T>
                  <TELL "Water flashes into steam across the hot iron and kills the bounded heat. The real water is consumed; no duplicate remains." CR>)>
           <RTRUE>)
          (<KITCHEN-WATER-APPLIED? ,KITCHEN-WORKTOP>
           <COND (<NOT <SHADOW-HAS-BOTTLED-WATER?>>
                  <TELL "The open bottle must contain water before it can rinse the worktop." CR>)
                 (T
                  <MATERIAL-CONSUME-BOTTLED-WATER>
                  <SETG KITCHEN-WORKTOP-RESIDUE <>>
                  <KITCHEN-SET-WET ,KITCHEN-WORKTOP 3>
                  <SETG KITCHEN-EVENT-CLEANING T>
                  <TELL "The real bottled water carries food residue from the worktop and leaves the wood wet." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE KITCHEN-OFFERING-HOOK ()
    <COND (<AND <VERB? GIVE>
                <EQUAL? ,PRSO ,GARLIC>
                <EQUAL? ,PRSI ,BAT>
                ,KITCHEN-GARLIC-SLICED>
           <SETG KITCHEN-EVENT-OFFERING T>
           <TELL "The bat recoils from the concentrated garlic scent and refuses the offering. The garlic remains yours; no new bat solution is created." CR>
           <RTRUE>)
          (<AND <VERB? GIVE>
                <EQUAL? ,PRSO ,LUNCH>
                <EQUAL? ,PRSI ,CYCLOPS>
                ,KITCHEN-LUNCH-PREPARED>
           <SETG KITCHEN-EVENT-OFFERING T>
           <TELL "The prepared pepper scent reaches the cyclops before the offering does." CR>
           <RFALSE>)>
    <RFALSE>>

<ROUTINE KITCHEN-FOOD-EXAMINE ()
    <COND (<AND <VERB? EXAMINE> <EQUAL? ,PRSO ,LUNCH>>
           <TELL "It is the real hot-pepper lunch">
           <COND (,KITCHEN-LUNCH-PREPARED <TELL ", deliberately prepared">)>
           <COND (<G? ,KITCHEN-LUNCH-WARM 0> <TELL " and still warm">)>
           <TELL "." CR>
           <RTRUE>)
          (<AND <VERB? EXAMINE> <EQUAL? ,PRSO ,GARLIC>>
           <TELL "It is the real clove of garlic">
           <COND (,KITCHEN-GARLIC-SLICED <TELL ", sliced and strongly fragrant">)>
           <COND (<G? ,KITCHEN-GARLIC-WARM 0> <TELL ", warmed enough to strengthen its scent">)>
           <TELL "." CR>
           <RTRUE>)
          (<AND <VERB? EXAMINE> <EQUAL? ,PRSO ,BOTTLE>
                <G? ,KITCHEN-WATER-WARM 0>
                <IN? ,WATER ,BOTTLE>>
           <TELL "The glass bottle contains warm water. It remains ordinary water." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE KITCHEN-ACTION-HOOK ()
    <COND (<KITCHEN-WATER-EXPERIMENT> <RTRUE>)
          (<KITCHEN-OFFERING-HOOK> <RTRUE>)
          (<KITCHEN-FOOD-EXAMINE> <RTRUE>)
          (<AND <VERB? SHADOW-USE-ON>
                <EQUAL? ,PRSI ,KITCHEN-RANGE>
                <KITCHEN-HERE?>>
           <COND (<AND <KITCHEN-HELD? ,PRSO> <SHADOW-FLAME? ,PRSO>>
                  <SETG KITCHEN-STOVE-HEAT 10>
                  <SETG KITCHEN-EVENT-HEAT T>
                  <TELL "You light the cast-iron range with the real flame. Its heat is temporary and bounded." CR>)
                 (T <TELL "That source does not provide a held live flame for the range." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE KITCHEN-ENSURE ()
    <COND (<NOT <EQUAL? ,KITCHEN-VERSION ,KITCHEN-SCHEMA>>
           <SETG KITCHEN-VERSION ,KITCHEN-SCHEMA>
           <COND (<FIRST? ,KITCHEN-CUPBOARD> <SETG KITCHEN-EVENT-STORAGE T>)>
           <COND (,KITCHEN-LUNCH-PREPARED <SETG KITCHEN-EVENT-FOOD T>)>
           <COND (<OR ,KITCHEN-KNIFE-CLEANED ,KITCHEN-BOTTLE-CLEANED
                      ,MATERIAL-SHOVEL-CLEANED ,MATERIAL-WRENCH-CLEANED
                      ,MATERIAL-SCREWDRIVER-CLEANED ,MATERIAL-AXE-CLEANED>
                  <SETG KITCHEN-EVENT-CLEANING T>)>)>
    <COND (<NOT <IN? ,WATER ,BOTTLE>> <SETG KITCHEN-WATER-WARM 0>)>
    <RFALSE>>

<ROUTINE KITCHEN-RECAP ("AUX" (SEEN <>))
    <COND (,KITCHEN-EVENT-WATER
           <SET SEEN T>
           <TELL "- You used the Kitchen sink without cloning the canonical portable water." CR>)>
    <COND (,KITCHEN-EVENT-CLEANING
           <SET SEEN T>
           <TELL "- You washed or dried real tools, the bottle, or the worktop, preserving existing material consequences." CR>)>
    <COND (,KITCHEN-EVENT-HEAT
           <SET SEEN T>
           <TELL "- You lit the cast-iron range with a real flame and used bounded temporary heat." CR>)>
    <COND (,KITCHEN-EVENT-FOOD
           <SET SEEN T>
           <TELL "- You prepared the real lunch or sliced the real garlic without creating a recipe economy." CR>)>
    <COND (,KITCHEN-EVENT-EXPERIMENT
           <SET SEEN T>
           <TELL "- You completed a selected Kitchen heat, water, or utensil experiment without a universal chemistry system." CR>)>
    <COND (,KITCHEN-EVENT-STORAGE
           <SET SEEN T>
           <TELL "- You used the Kitchen's real cupboard or work surfaces as deliberate object-tree storage." CR>)>
    <COND (,KITCHEN-EVENT-OFFERING
           <SET SEEN T>
           <TELL "- Prepared food changed an authored creature interaction without replacing canonical puzzle solutions." CR>)>
    <COND (.SEEN <RTRUE>)>
    <RFALSE>>
