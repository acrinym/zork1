"Cellar expedition threshold for the repository-local Zork I Glulx lineage."

;"Release 1222 makes the canonical Cellar a deliberate boundary between the
  white house and the underground. Real lights, tools, rope, containers,
  hazards, actors, trap-door state, and object custody remain authoritative.
  The layer adds bounded staging, sensing, screening, containment, evidence,
  and persistence without loadout automation or broad hazard simulation."

<SYNTAX READINESS = V-CELLAR-READINESS>

<CONSTANT CELLAR-SCHEMA 1>

<CONSTANT CS-VERSION 0>
<CONSTANT CS-DESCENTS 1>
<CONSTANT CS-RETURNS 2>
<CONSTANT CS-SENSE-BITS 3>
<CONSTANT CS-HAZARD-BITS 4>
<CONSTANT CS-INTRUSION-BITS 5>
<CONSTANT CS-EVENT-STAGING 6>
<CONSTANT CS-EVENT-TRAPDOOR 7>
<CONSTANT CS-EVENT-SENSING 8>
<CONSTANT CS-EVENT-HAZARD 9>
<CONSTANT CS-EVENT-CONTAINMENT 10>
<CONSTANT CS-EVENT-INTRUSION 11>
<CONSTANT CS-EVENT-READINESS 12>

<CONSTANT CELLAR-SENSE-BIT-SOUND 1>
<CONSTANT CELLAR-SENSE-BIT-DRAFT 2>
<CONSTANT CELLAR-SENSE-BIT-DAMP 4>
<CONSTANT CELLAR-SENSE-BIT-ROUTE 8>

<CONSTANT CELLAR-HAZARD-DARK 1>
<CONSTANT CELLAR-HAZARD-FLAME 2>
<CONSTANT CELLAR-HAZARD-WATER 4>
<CONSTANT CELLAR-HAZARD-WET-METAL 8>
<CONSTANT CELLAR-HAZARD-SUPERNATURAL 16>
<CONSTANT CELLAR-HAZARD-LIVING 32>
<CONSTANT CELLAR-HAZARD-UNSTABLE 64>

<CONSTANT CELLAR-INTRUSION-THIEF 1>
<CONSTANT CELLAR-INTRUSION-CREATURE 2>
<CONSTANT CELLAR-INTRUSION-WATER 4>
<CONSTANT CELLAR-INTRUSION-SMOKE 8>
<CONSTANT CELLAR-INTRUSION-SUPERNATURAL 16>

<GLOBAL CELLAR-STATE <TABLE 1 0 0 0 0 0 <> <> <> <> <> <> <>>>

<ROUTINE CELLAR-GET (SLOT)
    <GET ,CELLAR-STATE .SLOT>>

<ROUTINE CELLAR-PUT (SLOT VALUE)
    <PUT ,CELLAR-STATE .SLOT .VALUE>>

<ROUTINE CELLAR-HAS-BIT? (SLOT BIT)
    <COND (<NOT <0? <BAND <CELLAR-GET .SLOT> .BIT>>> <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-SET-BIT (SLOT BIT)
    <CELLAR-PUT .SLOT <BOR <CELLAR-GET .SLOT> .BIT>>
    <RTRUE>>

<OBJECT CELLAR-STAGING-BENCH
    (IN CELLAR)
    (SYNONYM BENCH TABLE WORKBENCH SURFACE)
    (ADJECTIVE CELLAR STONE STAGING EXPEDITION)
    (DESC "stone staging bench")
    (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT TRYTAKEBIT)
    (ACTION CELLAR-FIXTURE-FCN)
    (CAPACITY 120)>

<OBJECT CELLAR-GEAR-HOOKS
    (IN CELLAR)
    (SYNONYM HOOK HOOKS PEG PEGS RACK)
    (ADJECTIVE CELLAR IRON GEAR WALL)
    (DESC "iron gear hooks")
    (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT TRYTAKEBIT)
    (ACTION CELLAR-FIXTURE-FCN)
    (CAPACITY 60)>

<OBJECT CELLAR-QUARANTINE-NICHE
    (IN CELLAR)
    (SYNONYM NICHE CUBBY COMPARTMENT QUARANTINE)
    (ADJECTIVE CELLAR STONE DEEP)
    (DESC "stone quarantine niche")
    (FLAGS NDESCBIT CONTBIT SEARCHBIT TRYTAKEBIT)
    (ACTION CELLAR-FIXTURE-FCN)
    (CAPACITY 80)>

<OBJECT CELLAR-TRAP-DOOR-UNDERSIDE
    (IN CELLAR)
    (SYNONYM TRAP DOOR HATCH UNDERSIDE)
    (ADJECTIVE CELLAR WOODEN BARRED)
    (DESC "underside of the trap door")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION CELLAR-TRAP-DOOR-UNDERSIDE-FCN)>

<ROUTINE CELLAR-TRAP-DOOR-UNDERSIDE-FCN ()
    <CELLAR-PUT ,CS-EVENT-TRAPDOOR T>
    <COND (<VERB? EXAMINE LISTEN SMELL>
           <COND (<FSET? ,TRAP-DOOR ,OPENBIT>
                  <TELL "The open trap door exposes the real stair into the Living Room." CR>)
                 (<FSET? ,TRAP-DOOR ,TOUCHBIT>
                  <TELL "The trap door is shut and barred from above. Observation does not unlock it." CR>)
                 (T
                  <TELL "The real trap door is closed above the stair. Its route and lock remain canonical." CR>)>)
          (<VERB? OPEN CLOSE RAISE MOVE PUSH>
           <COND (<FSET? ,TRAP-DOOR ,TOUCHBIT>
                  <TELL "The bar is on the Living Room side. The underside cannot manufacture an unlocking action." CR>)
                 (T
                  <TELL "The underside is only the Cellar face of the real trap door; use its canonical route when it is actually open." CR>)>)
          (T
           <TELL "The underside reflects the real trap door's current state and creates no second route." CR>)>
    <RTRUE>>

<OBJECT CELLAR-THRESHOLD
    (IN CELLAR)
    (SYNONYM THRESHOLD BOUNDARY CROSSING TRAPDOOR DOOR HATCH)
    (ADJECTIVE CELLAR EXPEDITION HOUSE TRAP BARRED)
    (DESC "cellar threshold")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION CELLAR-THRESHOLD-FCN)>

<OBJECT CELLAR-DRAFTS
    (IN CELLAR)
    (SYNONYM DRAFT DRAFTS AIR BREEZE)
    (ADJECTIVE COLD CELLAR FAINT)
    (DESC "cellar draft")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION CELLAR-SENSE-FCN)>

<OBJECT CELLAR-SOUNDS
    (IN CELLAR)
    (SYNONYM SOUND SOUNDS NOISE NOISES ECHO ECHOES)
    (ADJECTIVE CELLAR UNDERGROUND FAINT)
    (DESC "underground sounds")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION CELLAR-SENSE-FCN)>

<OBJECT CELLAR-DAMPNESS
    (IN CELLAR)
    (SYNONYM DAMP DAMPNESS MOISTURE WETNESS)
    (ADJECTIVE CELLAR COLD OLD)
    (DESC "cellar dampness")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION CELLAR-SENSE-FCN)>

<OBJECT CELLAR-THRESHOLD-MARKS
    (IN CELLAR)
    (SYNONYM MARK MARKS EVIDENCE THREAD SCUFF TRACK SOOT ASH)
    (ADJECTIVE CELLAR THRESHOLD BLACK WET COLD)
    (DESC "threshold evidence")
    (FLAGS NDESCBIT INVISIBLE TRYTAKEBIT)
    (ACTION CELLAR-MARKS-FCN)>

<ROUTINE CELLAR-WITHIN? (OBJ CONTAINER "AUX" PLACE)
    <SET PLACE <LOC .OBJ>>
    <REPEAT ()
        <COND (<NOT .PLACE> <RFALSE>)
              (<EQUAL? .PLACE .CONTAINER> <RTRUE>)>
        <SET PLACE <LOC .PLACE>>>>

<ROUTINE CELLAR-CARRIED? (OBJ)
    <CELLAR-WITHIN? .OBJ ,WINNER>>

<ROUTINE CELLAR-IN-CELLAR? (OBJ)
    <CELLAR-WITHIN? .OBJ ,CELLAR>>

<ROUTINE CELLAR-STAGING-ACCEPTS? (OBJ)
    <COND (<EQUAL? .OBJ ,ROPE ,LAMP ,TORCH ,CANDLES ,BOTTLE
                        ,SANDWICH-BAG ,TUBE ,SHOVEL ,WRENCH
                        ,SCREWDRIVER ,AXE ,SWORD ,KNIFE ,RUSTY-KNIFE
                        ,GUIDE ,MAP>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-HOOKS-ACCEPTS? (OBJ)
    <COND (<EQUAL? .OBJ ,ROPE ,LAMP ,TORCH ,CANDLES> <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-QUARANTINE-ACCEPTS? (OBJ)
    <COND (<EQUAL? .OBJ ,BOTTLE ,TORCH ,CANDLES ,BELL ,HOT-BELL
                        ,BOOK ,SKULL ,NEST ,EGG ,BROKEN-EGG
                        ,CANARY ,BROKEN-CANARY ,TUBE ,PUTTY
                        ,RUSTY-KNIFE>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-ACTIVE-FIELD-OBJECT? (OBJ)
    <COND (<KITCHEN-ACTIVE-FIELD-OBJECT? .OBJ> <RTRUE>)
          (<EQUAL? .OBJ ,LAMP ,ROPE ,TORCH ,CANDLES ,BOOK ,SKULL
                        ,EGG ,CANARY ,RUSTY-KNIFE>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-CONTENTS-HAS-FLAME? (OBJ "AUX" ITEM)
    <SET ITEM <FIRST? .OBJ>>
    <REPEAT ()
        <COND (<NOT .ITEM> <RFALSE>)
              (<SHADOW-FLAME? .ITEM> <RTRUE>)
              (<AND <FIRST? .ITEM> <CELLAR-CONTENTS-HAS-FLAME? .ITEM>>
               <RTRUE>)>
        <SET ITEM <NEXT? .ITEM>>>>

<ROUTINE CELLAR-SAFELY-CONTAINED? (OBJ)
    <COND (<AND <CELLAR-WITHIN? .OBJ ,CELLAR-QUARANTINE-NICHE>
                <NOT <FSET? ,CELLAR-QUARANTINE-NICHE ,OPENBIT>>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-READY-LIGHT? ()
    <COND (<AND <CELLAR-CARRIED? ,LAMP> <FSET? ,LAMP ,ONBIT>> <RTRUE>)
          (<AND <CELLAR-CARRIED? ,TORCH> <SHADOW-FLAME? ,TORCH>> <RTRUE>)
          (<AND <CELLAR-CARRIED? ,CANDLES> <SHADOW-FLAME? ,CANDLES>> <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-STAGED-LIGHT? ()
    <COND (<OR <CELLAR-WITHIN? ,LAMP ,CELLAR-STAGING-BENCH>
               <CELLAR-WITHIN? ,LAMP ,CELLAR-GEAR-HOOKS>
               <CELLAR-WITHIN? ,TORCH ,CELLAR-STAGING-BENCH>
               <CELLAR-WITHIN? ,TORCH ,CELLAR-GEAR-HOOKS>
               <CELLAR-WITHIN? ,CANDLES ,CELLAR-STAGING-BENCH>
               <CELLAR-WITHIN? ,CANDLES ,CELLAR-GEAR-HOOKS>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-READY-TOOL? ()
    <COND (<OR <CELLAR-CARRIED? ,ROPE>
               <CELLAR-CARRIED? ,SHOVEL>
               <CELLAR-CARRIED? ,WRENCH>
               <CELLAR-CARRIED? ,SCREWDRIVER>
               <CELLAR-CARRIED? ,AXE>
               <CELLAR-CARRIED? ,SWORD>
               <CELLAR-CARRIED? ,KNIFE>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-OPEN-WATER-CARRIED? ()
    <COND (<AND <CELLAR-CARRIED? ,BOTTLE>
                <FSET? ,BOTTLE ,OPENBIT>
                <IN? ,WATER ,BOTTLE>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-WET-METAL-CARRIED? ()
    <COND (<AND <CELLAR-CARRIED? ,SHOVEL> <KITCHEN-WET? ,SHOVEL>> <RTRUE>)
          (<AND <CELLAR-CARRIED? ,WRENCH> <KITCHEN-WET? ,WRENCH>> <RTRUE>)
          (<AND <CELLAR-CARRIED? ,SCREWDRIVER> <KITCHEN-WET? ,SCREWDRIVER>> <RTRUE>)
          (<AND <CELLAR-CARRIED? ,AXE> <KITCHEN-WET? ,AXE>> <RTRUE>)
          (<AND <CELLAR-CARRIED? ,KNIFE> <KITCHEN-WET? ,KNIFE>> <RTRUE>)
          (<AND <CELLAR-CARRIED? ,RUSTY-KNIFE>
                <OR <KITCHEN-WET? ,RUSTY-KNIFE> <G? ,MATERIAL-RUST-WET 0>>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-LIVE-FLAME-CARRIED? ()
    <COND (<AND <CELLAR-CARRIED? ,TORCH> <SHADOW-FLAME? ,TORCH>> <RTRUE>)
          (<AND <CELLAR-CARRIED? ,CANDLES> <SHADOW-FLAME? ,CANDLES>> <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-SUPERNATURAL-CARRIED? ()
    <COND (<OR <CELLAR-CARRIED? ,BOOK>
               <CELLAR-CARRIED? ,SKULL>
               <CELLAR-CARRIED? ,HOT-BELL>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-LIVING-CARRIED? ()
    <COND (<OR <CELLAR-CARRIED? ,NEST>
               <CELLAR-CARRIED? ,EGG>
               <CELLAR-CARRIED? ,CANARY>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-UNSTABLE-CARRIED? ()
    <COND (<OR <CELLAR-CARRIED? ,HOT-BELL>
               <CELLAR-CARRIED? ,BROKEN-EGG>
               <CELLAR-CARRIED? ,TUBE>
               <AND <CELLAR-CARRIED? ,RUSTY-KNIFE>
                    <G? ,MATERIAL-RUST-WET 0>>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-CONTENTS (OBJ "AUX" ITEM)
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

<ROUTINE CELLAR-DESCRIBE-FIXTURE (OBJ)
    <COND (<EQUAL? .OBJ ,CELLAR-STAGING-BENCH>
           <TELL "The broad stone bench is for deliberate expedition staging: real lights, rope, tools, containers, and records remain exactly where you place them.">
           <CELLAR-CONTENTS .OBJ>)
          (<EQUAL? .OBJ ,CELLAR-GEAR-HOOKS>
           <TELL "Four iron hooks are fixed into the wall for real rope and light sources. They are storage, not a loadout system.">
           <CELLAR-CONTENTS .OBJ>)
          (T
           <TELL "The deep stone niche can isolate a selected dangerous or delicate object. It cannot safely be sealed around a live flame.">
           <COND (<FSET? .OBJ ,OPENBIT>
                  <CELLAR-CONTENTS .OBJ>)
                 (T <TELL " It is closed.">)>)>
    <CRLF>
    <RTRUE>>

<ROUTINE CELLAR-FIXTURE-FCN ("AUX" OBJ)
    <COND (<EQUAL? ,PRSO ,CELLAR-STAGING-BENCH ,CELLAR-GEAR-HOOKS
                         ,CELLAR-QUARANTINE-NICHE>
           <SET OBJ ,PRSO>)
          (<EQUAL? ,PRSI ,CELLAR-STAGING-BENCH ,CELLAR-GEAR-HOOKS
                         ,CELLAR-QUARANTINE-NICHE>
           <SET OBJ ,PRSI>)>
    <COND (<AND .OBJ <VERB? EXAMINE LOOK-INSIDE SEARCH>>
           <CELLAR-DESCRIBE-FIXTURE .OBJ>)
          (<AND .OBJ <VERB? TAKE MOVE MUNG>
                <EQUAL? ,PRSO .OBJ>>
           <TELL "The fixture is built into the Cellar and is not portable." CR>
           <RTRUE>)
          (<AND <EQUAL? .OBJ ,CELLAR-STAGING-BENCH ,CELLAR-GEAR-HOOKS>
                <VERB? OPEN CLOSE>>
           <TELL "That staging fixture has no useful door or lid." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-SENSE-SOUND ()
    <CELLAR-SET-BIT ,CS-SENSE-BITS ,CELLAR-SENSE-BIT-SOUND>
    <CELLAR-PUT ,CS-EVENT-SENSING T>
    <COND (<CELLAR-IN-CELLAR? ,THIEF>
           <TELL "A soft shoe scuffs stone, then becomes still with professional speed." CR>)
          (<CELLAR-IN-CELLAR? ,BAT>
           <TELL "A dry flutter brushes the air above the ordinary cellar echoes." CR>)
          (<NOT ,TROLL-FLAG>
           <TELL "From the north comes an irregular scrape of metal and a low breath too heavy to be a draft." CR>)
          (T
           <TELL "The north and south passages return small damp echoes. Nothing approaches clearly enough to identify." CR>)>
    <RTRUE>>

<ROUTINE CELLAR-SENSE-DRAFT ()
    <CELLAR-SET-BIT ,CS-SENSE-BITS ,CELLAR-SENSE-BIT-DRAFT>
    <CELLAR-PUT ,CS-EVENT-SENSING T>
    <COND (<FSET? ,TRAP-DOOR ,OPENBIT>
           <TELL "Warmer house air descends through the open trap door while colder air moves between the northern passage and southern crawlway." CR>)
          (T
           <TELL "With the trap door shut, the cross-draft belongs entirely to the underground passages. The north is broader; the south is lower and damper." CR>)>
    <RTRUE>>

<ROUTINE CELLAR-SENSE-DAMP ()
    <CELLAR-SET-BIT ,CS-SENSE-BITS ,CELLAR-SENSE-BIT-DAMP>
    <CELLAR-PUT ,CS-EVENT-SENSING T>
    <COND (<CELLAR-HAS-BIT? ,CS-INTRUSION-BITS ,CELLAR-INTRUSION-WATER>
           <TELL "Old cellar damp is joined by a fresher wet track across the threshold stone." CR>)
          (T
           <TELL "The damp is old, cold, and strongest toward the southern crawlway. It is evidence of the underground climate, not a new water source." CR>)>
    <RTRUE>>

<ROUTINE CELLAR-SENSE-FCN ()
    <COND (<EQUAL? ,PRSO ,CELLAR-SOUNDS> <CELLAR-SENSE-SOUND>)
          (<EQUAL? ,PRSO ,CELLAR-DRAFTS> <CELLAR-SENSE-DRAFT>)
          (<EQUAL? ,PRSO ,CELLAR-DAMPNESS> <CELLAR-SENSE-DAMP>)>
    <RTRUE>>

<ROUTINE CELLAR-THRESHOLD-FCN ()
    <COND (<VERB? MARA-UNBAR-THRESHOLD>
           <V-MARA-UNBAR-THRESHOLD>)
          (<VERB? EXAMINE SEARCH RUB>
           <CELLAR-SET-BIT ,CS-SENSE-BITS ,CELLAR-SENSE-BIT-ROUTE>
           <CELLAR-PUT ,CS-EVENT-SENSING T>
           <TELL "The threshold is not a new exit. It is the exact junction of the real trap-door stair, northern passage, southern crawlway, and the objects you deliberately leave here." CR>)
          (<VERB? TAKE MOVE PUSH>
           <TELL "The threshold is a relationship among the existing routes, not a portable object." CR>)
          (T
           <TELL "The Cellar remains the house's practical boundary with the underground." CR>)>
    <RTRUE>>

<ROUTINE CELLAR-MARKS-FCN ()
    <COND (<VERB? EXAMINE SEARCH>
           <TELL "The threshold stone records">
           <COND (<CELLAR-HAS-BIT? ,CS-INTRUSION-BITS ,CELLAR-INTRUSION-THIEF>
                  <TELL " a black thread and careful heel scuff;">)>
           <COND (<CELLAR-HAS-BIT? ,CS-INTRUSION-BITS ,CELLAR-INTRUSION-CREATURE>
                  <TELL " clawed or dragging marks;">)>
           <COND (<CELLAR-HAS-BIT? ,CS-INTRUSION-BITS ,CELLAR-INTRUSION-WATER>
                  <TELL " a fresh damp track;">)>
           <COND (<CELLAR-HAS-BIT? ,CS-INTRUSION-BITS ,CELLAR-INTRUSION-SMOKE>
                  <TELL " a thin soot fan;">)>
           <COND (<CELLAR-HAS-BIT? ,CS-INTRUSION-BITS ,CELLAR-INTRUSION-SUPERNATURAL>
                  <TELL " and a cold gray residue that is not ordinary dust;">)>
           <TELL " none of it creates or identifies an unseen solution." CR>)
          (<VERB? TAKE MOVE PUSH>
           <TELL "The evidence is impressed into stone or caught in its cracks." CR>)
          (<VERB? RUB>
           <TELL "The newest marks smear slightly, but remain legible as threshold evidence." CR>)
          (T
           <TELL "The marks record what crossed here; they do not perform another action." CR>)>
    <RTRUE>>

<ROUTINE CELLAR-TRAP-DOOR-HOOK ()
    <COND (<AND <VERB? EXAMINE LISTEN SMELL>
                <EQUAL? ,PRSO ,TRAP-DOOR>>
           <CELLAR-PUT ,CS-EVENT-TRAPDOOR T>
           <COND (<EQUAL? ,HERE ,LIVING-ROOM>
                  <TELL "The real trap door is ">
                  <COND (<FSET? ,TRAP-DOOR ,OPENBIT>
                         <TELL "open, exposing the rickety stair and the colder air below.">)
                        (,RUG-MOVED
                         <TELL "closed and exposed beside the moved rug.">)
                        (T
                         <TELL "closed beneath the rug's original position.">)>
                  <CRLF>)
                 (<EQUAL? ,HERE ,CELLAR>
                  <COND (<FSET? ,TRAP-DOOR ,OPENBIT>
                         <TELL "The open trap door gives a real upward route into the Living Room." CR>)
                        (<FSET? ,TRAP-DOOR ,TOUCHBIT>
                         <TELL "The trap door is shut and barred from above. Observation does not unlock it." CR>)
                        (T
                         <TELL "The closed trap door is above the stair. Its lock and route remain canonical." CR>)>)
                 (T <RFALSE>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-REPORT-READINESS ()
    <CELLAR-PUT ,CS-EVENT-READINESS T>
    <TELL "Threshold readiness:" CR>
    <COND (<CELLAR-READY-LIGHT?>
           <TELL "- an active light is in hand;" CR>)
          (<CELLAR-STAGED-LIGHT?>
           <TELL "- a light is staged in the Cellar, but not in hand for the descent;" CR>)
          (T
           <TELL "- no active light is in hand or staged at the threshold;" CR>)>
    <COND (<CELLAR-READY-TOOL?>
           <TELL "- at least one real rope, hand tool, or weapon is carried;" CR>)
          (T
           <TELL "- no selected expedition tool is carried;" CR>)>
    <COND (<CELLAR-OPEN-WATER-CARRIED?>
           <TELL "- the open bottle contains the real portable water and may spill;" CR>)
          (<CELLAR-CARRIED? ,BOTTLE>
           <TELL "- the real bottle is carried without exposed water;" CR>)
          (T
           <TELL "- the real bottle is not carried;" CR>)>
    <COND (<OR <FIRST? ,CELLAR-STAGING-BENCH> <FIRST? ,CELLAR-GEAR-HOOKS>>
           <TELL "- deliberately staged objects remain in the canonical Cellar object tree." CR>)
          (T
           <TELL "- nothing is currently staged on the bench or hooks." CR>)>
    <RTRUE>>

<ROUTINE V-CELLAR-READINESS ()
    <CELLAR-ENSURE>
    <CELLAR-REPORT-READINESS>>

<ROUTINE CELLAR-SCREEN-HAZARDS (HOMEWARD "AUX" (SEEN <>))
    <CELLAR-PUT ,CS-EVENT-READINESS T>
    <COND (<AND <NOT .HOMEWARD> <NOT <CELLAR-READY-LIGHT?>>>
           <SET SEEN T>
           <CELLAR-SET-BIT ,CS-HAZARD-BITS ,CELLAR-HAZARD-DARK>
           <TELL "No active light is in hand. The canonical Cellar is dark, and the threshold will not supply one." CR>)>
    <COND (<CELLAR-LIVE-FLAME-CARRIED?>
           <SET SEEN T>
           <CELLAR-SET-BIT ,CS-HAZARD-BITS ,CELLAR-HAZARD-FLAME>
           <TELL "A live flame is useful below but remains real fire crossing a wooden trap-door stair." CR>)>
    <COND (<CELLAR-OPEN-WATER-CARRIED?>
           <SET SEEN T>
           <CELLAR-SET-BIT ,CS-HAZARD-BITS ,CELLAR-HAZARD-WATER>
           <TELL "The open bottle carries the one real portable water quantity; a steep stair is a poor place to spill it." CR>)>
    <COND (<CELLAR-WET-METAL-CARRIED?>
           <SET SEEN T>
           <CELLAR-SET-BIT ,CS-HAZARD-BITS ,CELLAR-HAZARD-WET-METAL>
           <TELL "Wet metal is crossing the threshold. Existing rust and drying consequences remain active." CR>)>
    <COND (<CELLAR-SUPERNATURAL-CARRIED?>
           <SET SEEN T>
           <CELLAR-SET-BIT ,CS-HAZARD-BITS ,CELLAR-HAZARD-SUPERNATURAL>
           <TELL "A ritual, funerary, or unnaturally hot object is crossing between the underground and the house." CR>)>
    <COND (<CELLAR-LIVING-CARRIED?>
           <SET SEEN T>
           <CELLAR-SET-BIT ,CS-HAZARD-BITS ,CELLAR-HAZARD-LIVING>
           <TELL "A nest, egg, or canary is crossing the stair. Its real nesting and fragility state is not suspended." CR>)>
    <COND (<CELLAR-UNSTABLE-CARRIED?>
           <SET SEEN T>
           <CELLAR-SET-BIT ,CS-HAZARD-BITS ,CELLAR-HAZARD-UNSTABLE>
           <TELL "At least one carried object is hot, broken, pressurized, corrosive, or otherwise poor threshold cargo." CR>)>
    <COND (.SEEN
           <CELLAR-PUT ,CS-EVENT-HAZARD T>)
          (T
           <TELL "No selected carried hazard requires a threshold warning." CR>)>
    <RFALSE>>

<ROUTINE CELLAR-DESCENT-CHECK ()
    <CELLAR-ENSURE>
    <TELL "At the exposed trap-door threshold, you take stock before descending." CR>
    <CELLAR-SCREEN-HAZARDS <>>
    <RFALSE>>

<ROUTINE CELLAR-HOMEWARD-CHECK ()
    <CELLAR-ENSURE>
    <TELL "Before carrying the expedition back into the Living Room, the threshold records what is coming home." CR>
    <CELLAR-SCREEN-HAZARDS T>
    <CELLAR-PUT ,CS-RETURNS <+ <CELLAR-GET ,CS-RETURNS> 1>>
    <RFALSE>>

<ROUTINE CELLAR-REGISTER-INTRUSION (BIT)
    <COND (<CELLAR-HAS-BIT? ,CS-INTRUSION-BITS .BIT> <RTRUE>)>
    <CELLAR-SET-BIT ,CS-INTRUSION-BITS .BIT>
    <CELLAR-PUT ,CS-EVENT-INTRUSION T>
    <FCLEAR ,CELLAR-THRESHOLD-MARKS ,INVISIBLE>
    <COND (<NOT <EQUAL? ,HERE ,CELLAR>> <RTRUE>)>
    <COND (<EQUAL? .BIT ,CELLAR-INTRUSION-THIEF>
           <TELL "A black thread catches in a crack beside a careful heel scuff." CR>)
          (<EQUAL? .BIT ,CELLAR-INTRUSION-CREATURE>
           <TELL "A fresh clawed or dragging mark appears across the threshold dust." CR>)
          (<EQUAL? .BIT ,CELLAR-INTRUSION-WATER>
           <TELL "A fresh damp track crosses the older cellar moisture." CR>)
          (<EQUAL? .BIT ,CELLAR-INTRUSION-SMOKE>
           <TELL "A thin soot fan records that live flame crossed or lingered at the boundary." CR>)
          (T
           <TELL "Cold gray residue settles in the threshold cracks around an object that does not belong to ordinary housekeeping." CR>)>
    <RTRUE>>

<ROUTINE CELLAR-INTRUSION-SCAN ()
    <COND (<CELLAR-IN-CELLAR? ,THIEF>
           <CELLAR-REGISTER-INTRUSION ,CELLAR-INTRUSION-THIEF>)>
    <COND (<OR <CELLAR-IN-CELLAR? ,BAT> <CELLAR-IN-CELLAR? ,TROLL>>
           <CELLAR-REGISTER-INTRUSION ,CELLAR-INTRUSION-CREATURE>)>
    <COND (<AND <CELLAR-IN-CELLAR? ,WATER>
                <NOT <CELLAR-WITHIN? ,WATER ,BOTTLE>>>
           <CELLAR-REGISTER-INTRUSION ,CELLAR-INTRUSION-WATER>)>
    <COND (<OR <AND <CELLAR-IN-CELLAR? ,TORCH>
                     <SHADOW-FLAME? ,TORCH>
                     <NOT <CELLAR-SAFELY-CONTAINED? ,TORCH>>>
               <AND <CELLAR-IN-CELLAR? ,CANDLES>
                     <SHADOW-FLAME? ,CANDLES>
                     <NOT <CELLAR-SAFELY-CONTAINED? ,CANDLES>>>>
           <CELLAR-REGISTER-INTRUSION ,CELLAR-INTRUSION-SMOKE>)>
    <COND (<OR <AND <CELLAR-IN-CELLAR? ,BOOK>
                     <NOT <CELLAR-SAFELY-CONTAINED? ,BOOK>>>
               <AND <CELLAR-IN-CELLAR? ,SKULL>
                     <NOT <CELLAR-SAFELY-CONTAINED? ,SKULL>>>
               <AND <CELLAR-IN-CELLAR? ,HOT-BELL>
                     <NOT <CELLAR-SAFELY-CONTAINED? ,HOT-BELL>>>>
           <CELLAR-REGISTER-INTRUSION ,CELLAR-INTRUSION-SUPERNATURAL>)>
    <RFALSE>>

<ROUTINE CELLAR-CLEAN-MARKS ()
    <COND (<NOT <SHADOW-HAS-BOTTLED-WATER?>>
           <TELL "The open bottle must contain the real water before the threshold can be rinsed." CR>)
          (<0? <CELLAR-GET ,CS-INTRUSION-BITS>>
           <TELL "There are no recorded threshold marks to rinse away." CR>)
          (T
           <MATERIAL-CONSUME-BOTTLED-WATER>
           <CELLAR-PUT ,CS-INTRUSION-BITS 0>
           <FSET ,CELLAR-THRESHOLD-MARKS ,INVISIBLE>
           <TELL "The real bottled water carries thread, soot, damp grit, and cold residue from the threshold. The historical intrusion receipt remains, but the physical marks are gone." CR>)>
    <RTRUE>>

<ROUTINE CELLAR-ACTION-HOOK ()
    <COND (<AND <OR <VERB? SHADOW-USE-ON> <VERB? POUR-ON>>
                <EQUAL? ,PRSI ,CELLAR-THRESHOLD-MARKS>
                <EQUAL? ,PRSO ,WATER ,BOTTLE>>
           <CELLAR-CLEAN-MARKS>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-BEGIN ()
    <COND (<AND <VERB? PUT PUT-ON>
                <EQUAL? ,PRSI ,CELLAR-STAGING-BENCH>
                <NOT <CELLAR-STAGING-ACCEPTS? ,PRSO>>>
           <TELL "The staging bench is deliberately limited to real expedition lights, rope, tools, containers, and records." CR>
           <RTRUE>)
          (<AND <VERB? PUT PUT-ON>
                <EQUAL? ,PRSI ,CELLAR-GEAR-HOOKS>
                <NOT <CELLAR-HOOKS-ACCEPTS? ,PRSO>>>
           <TELL "The iron hooks accept the real rope and selected real light sources, not every portable object." CR>
           <RTRUE>)
          (<AND <VERB? PUT PUT-ON>
                <EQUAL? ,PRSI ,CELLAR-QUARANTINE-NICHE>
                <NOT <CELLAR-QUARANTINE-ACCEPTS? ,PRSO>>>
           <TELL "The quarantine niche accepts only the selected dangerous, delicate, ritual, or unstable objects authored for it." CR>
           <RTRUE>)
          (<AND <VERB? CLOSE>
                <EQUAL? ,PRSO ,CELLAR-QUARANTINE-NICHE>
                <CELLAR-CONTENTS-HAS-FLAME? ,CELLAR-QUARANTINE-NICHE>>
           <TELL "Sealing a live flame in the niche would create smoke and pressure, not containment. Remove or extinguish it first." CR>
           <RTRUE>)
          (<AND <FSET? ,TRAP-DOOR ,OPENBIT>
                <OR <AND <VERB? WALK> <EQUAL? ,PRSO ,P?UP>>
                    <AND <VERB? CLIMB-UP> <EQUAL? ,PRSO ,STAIRS>>>>
           <CELLAR-HOMEWARD-CHECK>
           <RFALSE>)
          (<AND <VERB? LISTEN> <NOT ,PRSO>>
           <CELLAR-SENSE-SOUND>
           <RTRUE>)
          (<AND <VERB? SMELL> <NOT ,PRSO>>
           <CELLAR-SENSE-DAMP>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CELLAR-END ()
    <CELLAR-ENSURE>
    <COND (<AND <VERB? PUT PUT-ON> ,PRSO ,PRSI <IN? ,PRSO ,PRSI>>
           <COND (<EQUAL? ,PRSI ,CELLAR-STAGING-BENCH ,CELLAR-GEAR-HOOKS>
                  <CELLAR-PUT ,CS-EVENT-STAGING T>
                  <COND (<CELLAR-ACTIVE-FIELD-OBJECT? ,PRSO>
                         <TELL "This is deliberate staging, not retirement. The " D ,PRSO " remains real and may still be required below." CR>)>)
                 (<EQUAL? ,PRSI ,CELLAR-QUARANTINE-NICHE>
                  <CELLAR-PUT ,CS-EVENT-CONTAINMENT T>
                  <TELL "The " D ,PRSO " is physically in the niche, not removed from the adventure." CR>)>)>
    <COND (<AND <VERB? CLOSE>
                <EQUAL? ,PRSO ,CELLAR-QUARANTINE-NICHE>
                <NOT <FSET? ,CELLAR-QUARANTINE-NICHE ,OPENBIT>>
                <FIRST? ,CELLAR-QUARANTINE-NICHE>>
           <CELLAR-PUT ,CS-EVENT-CONTAINMENT T>)>
    <COND (<AND <VERB? OPEN CLOSE> <EQUAL? ,PRSO ,TRAP-DOOR>>
           <CELLAR-PUT ,CS-EVENT-TRAPDOOR T>)>
    <CELLAR-INTRUSION-SCAN>
    <RFALSE>>

<ROUTINE CELLAR-ENTER ()
    <CELLAR-ENSURE>
    <CELLAR-PUT ,CS-DESCENTS <+ <CELLAR-GET ,CS-DESCENTS> 1>>
    <CELLAR-PUT ,CS-EVENT-TRAPDOOR T>
    <HOUSE-STATE-REFRESH>
    <CELLAR-INTRUSION-SCAN>
    <RFALSE>>

<ROUTINE CELLAR-ADVANCE ()
    <COND (<SHADOW-NON-TURN-COMMAND?> <RFALSE>)>
    <CELLAR-ENSURE>
    <CELLAR-INTRUSION-SCAN>
    <RFALSE>>

<ROUTINE CELLAR-PROJECT ()
    <CELLAR-ENSURE>
    <CELLAR-INTRUSION-SCAN>
    <TELL " A broad stone staging bench, iron gear hooks, and a closable quarantine niche occupy the house side of the room.">
    <COND (<FSET? ,TRAP-DOOR ,OPENBIT>
           <TELL " The open trap door preserves the real upward route.">)
          (<FSET? ,TRAP-DOOR ,TOUCHBIT>
           <TELL " The trap door is shut and barred from above.">)
          (T
           <TELL " The trap-door stair is closed above.">)>
    <COND (<OR <FIRST? ,CELLAR-STAGING-BENCH> <FIRST? ,CELLAR-GEAR-HOOKS>>
           <TELL " Deliberately staged gear waits where it was placed.">)>
    <COND (<AND <FIRST? ,CELLAR-QUARANTINE-NICHE>
                <NOT <FSET? ,CELLAR-QUARANTINE-NICHE ,OPENBIT>>>
           <TELL " The quarantine niche is sealed around its real contents.">)>
    <COND (<NOT <FSET? ,CELLAR-THRESHOLD-MARKS ,INVISIBLE>>
           <TELL " Persistent marks record that something crossed or lingered here.">)>
    <CRLF>
    <RTRUE>>

<ROUTINE CELLAR-ENSURE ()
    <COND (<NOT <EQUAL? <CELLAR-GET ,CS-VERSION> ,CELLAR-SCHEMA>>
           <CELLAR-PUT ,CS-VERSION ,CELLAR-SCHEMA>
           <COND (<FSET? ,CELLAR ,TOUCHBIT> <CELLAR-PUT ,CS-DESCENTS 1>)>
           <COND (<OR ,RUG-MOVED <FSET? ,TRAP-DOOR ,TOUCHBIT>>
                  <CELLAR-PUT ,CS-EVENT-TRAPDOOR T>)>
           <COND (<OR <FIRST? ,CELLAR-STAGING-BENCH> <FIRST? ,CELLAR-GEAR-HOOKS>>
                  <CELLAR-PUT ,CS-EVENT-STAGING T>)>
           <COND (<AND <FIRST? ,CELLAR-QUARANTINE-NICHE>
                       <NOT <FSET? ,CELLAR-QUARANTINE-NICHE ,OPENBIT>>>
                  <CELLAR-PUT ,CS-EVENT-CONTAINMENT T>)>
           <COND (<NOT <FSET? ,CELLAR-THRESHOLD-MARKS ,INVISIBLE>>
                  <CELLAR-PUT ,CS-EVENT-INTRUSION T>)>)>
    <RFALSE>>

<ROUTINE CELLAR-RECAP ("AUX" (SEEN <>))
    <COND (<CELLAR-GET ,CS-EVENT-STAGING>
           <SET SEEN T>
           <TELL "- You used the Cellar's real bench or hooks for deliberate expedition staging without creating an automatic loadout." CR>)>
    <COND (<CELLAR-GET ,CS-EVENT-TRAPDOOR>
           <SET SEEN T>
           <TELL "- You observed or crossed the canonical rug, trap door, stair, and locking route as the house's true underground boundary." CR>)>
    <COND (<CELLAR-GET ,CS-EVENT-SENSING>
           <SET SEEN T>
           <TELL "- You read bounded sounds, drafts, dampness, and route evidence without revealing an unseen solution." CR>)>
    <COND (<CELLAR-GET ,CS-EVENT-HAZARD>
           <SET SEEN T>
           <TELL "- The threshold warned about real darkness, flame, water, wet metal, fragile life, supernatural cargo, or unstable objects without changing their consequences." CR>)>
    <COND (<CELLAR-GET ,CS-EVENT-CONTAINMENT>
           <SET SEEN T>
           <TELL "- You placed selected real objects in recoverable physical quarantine rather than deleting or abstracting them." CR>)>
    <COND (<CELLAR-GET ,CS-EVENT-INTRUSION>
           <SET SEEN T>
           <TELL "- Thief, creature, water, smoke, or supernatural hooks left bounded physical threshold evidence." CR>)>
    <COND (<CELLAR-GET ,CS-EVENT-READINESS>
           <SET SEEN T>
           <TELL "- You checked actual carried and staged readiness without inventory automation." CR>)>
    <COND (.SEEN <RTRUE>)>
    <RFALSE>>
