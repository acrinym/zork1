"Release 1257 authored world-fire authority."

<CONSTANT FS-TIMBER-STAGE 0>
<CONSTANT FS-TIMBER-TIMER 1>
<CONSTANT FIRE-STRUCTURAL-STATE <TABLE 0 0>>

<CONSTANT FIRE-TIMBER-COLD 0>
<CONSTANT FIRE-TIMBER-SMOLDER 1>
<CONSTANT FIRE-TIMBER-BURNING 2>
<CONSTANT FIRE-TIMBER-COLLAPSED-HOT 3>
<CONSTANT FIRE-TIMBER-CHARRED 4>
<CONSTANT FIRE-TIMBER-DOUSED 5>

<ROUTINE FIRE-STRUCTURAL-GET (SLOT)
    <GET ,FIRE-STRUCTURAL-STATE .SLOT>>

<ROUTINE FIRE-STRUCTURAL-PUT (SLOT VALUE)
    <PUT ,FIRE-STRUCTURAL-STATE .SLOT .VALUE>>

<ROUTINE FIRE-STRUCTURAL-STAGE ()
    <FIRE-STRUCTURAL-GET ,FS-TIMBER-STAGE>>

<ROUTINE FIRE-STRUCTURAL-SET-STAGE (STAGE)
    <FIRE-STRUCTURAL-PUT ,FS-TIMBER-STAGE .STAGE>
    <COND (<EQUAL? .STAGE ,FIRE-TIMBER-SMOLDER>
           <FSET ,TIMBERS ,ONBIT>
           <FCLEAR ,TIMBERS ,FLAMEBIT>)
          (<EQUAL? .STAGE ,FIRE-TIMBER-BURNING>
           <FSET ,TIMBERS ,ONBIT>
           <FSET ,TIMBERS ,FLAMEBIT>)
          (T
           <FCLEAR ,TIMBERS ,ONBIT>
           <FCLEAR ,TIMBERS ,FLAMEBIT>)>
    <COND (<EQUAL? .STAGE ,FIRE-TIMBER-COLLAPSED-HOT ,FIRE-TIMBER-CHARRED ,FIRE-TIMBER-DOUSED>
           <FSET ,TIMBERS ,RMUNGBIT>)>
    <RTRUE>>

<ROUTINE FIRE-STRUCTURAL-ACTIVE? ("AUX" STAGE)
    <SET STAGE <FIRE-STRUCTURAL-STAGE>>
    <COND (<EQUAL? .STAGE ,FIRE-TIMBER-SMOLDER ,FIRE-TIMBER-BURNING ,FIRE-TIMBER-COLLAPSED-HOT>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE FIRE-STRUCTURAL-STOP-ACTION? ()
    <COND (<AND <OR <VERB? SHADOW-USE-ON POUR-ON>>
                <EQUAL? ,PRSI ,TIMBERS>
                <EQUAL? ,PRSO ,WATER ,BOTTLE>>
           <RTRUE>)
          (<AND <VERB? LAMP-OFF>
                <EQUAL? ,PRSO ,TIMBERS>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE FIRE-STRUCTURAL-ADVANCE ("AUX" STAGE TIMER)
    <SET STAGE <FIRE-STRUCTURAL-STAGE>>
    <COND (<OR <EQUAL? .STAGE ,FIRE-TIMBER-COLD ,FIRE-TIMBER-CHARRED ,FIRE-TIMBER-DOUSED>
               <FIRE-STRUCTURAL-STOP-ACTION?>>
           <RFALSE>)
          (<EQUAL? .STAGE ,FIRE-TIMBER-SMOLDER>
           <FIRE-STRUCTURAL-SET-STAGE ,FIRE-TIMBER-BURNING>
           <FIRE-STRUCTURAL-PUT ,FS-TIMBER-TIMER 3>
           <COND (<EQUAL? ,HERE ,TIMBER-ROOM>
                  <TELL "The smoldering timber catches properly. Flame runs along the dry grain and the strong westward draft lays a dirty ceiling of smoke across the narrow passage. The wide way east is still clear." CR>)
                 (<EQUAL? ,HERE ,LADDER-BOTTOM ,LOWER-SHAFT>
                  <TELL "A dirty ribbon of wood smoke reaches you from the Timber Room." CR>)>
           <RFALSE>)
          (<EQUAL? .STAGE ,FIRE-TIMBER-BURNING>
           <SET TIMER <FIRE-STRUCTURAL-GET ,FS-TIMBER-TIMER>>
           <COND (<G? .TIMER 1>
                  <FIRE-STRUCTURAL-PUT ,FS-TIMBER-TIMER <- .TIMER 1>>
                  <COND (<EQUAL? ,HERE ,TIMBER-ROOM>
                         <TELL "Smoke thickens under the low stone while the draft pulls the flames west. Somewhere above the clutter, an old timber brace begins to crack." CR>)
                        (<EQUAL? ,HERE ,LADDER-BOTTOM ,LOWER-SHAFT>
                         <TELL "The smoke from the Timber Room grows thicker, carrying the sharp smell of hot old wood." CR>)>
                  <RFALSE>)
                 (T
                  <FIRE-STRUCTURAL-SET-STAGE ,FIRE-TIMBER-COLLAPSED-HOT>
                  <FIRE-STRUCTURAL-PUT ,FS-TIMBER-TIMER 2>
                  <COND (<EQUAL? ,HERE ,TIMBER-ROOM>
                         <TELL "The warning crack becomes a report. One old brace drops into the burning clutter, kicking sparks and black smoke across the room. The roof settles rather than following it, but the fallen wood is now part of the wreckage." CR>)
                        (<EQUAL? ,HERE ,LADDER-BOTTOM ,LOWER-SHAFT>
                         <TELL "A heavy wooden crack echoes from the Timber Room, followed by a fresh push of smoke." CR>)>
                  <RFALSE>)>)
          (<EQUAL? .STAGE ,FIRE-TIMBER-COLLAPSED-HOT>
           <SET TIMER <FIRE-STRUCTURAL-GET ,FS-TIMBER-TIMER>>
           <COND (<G? .TIMER 1>
                  <FIRE-STRUCTURAL-PUT ,FS-TIMBER-TIMER <- .TIMER 1>>
                  <COND (<EQUAL? ,HERE ,TIMBER-ROOM>
                         <TELL "The fallen brace hisses and pops among the coals. The smoke is thinning, but the narrow westward crawl is still a very poor place to put your face." CR>)>
                  <RFALSE>)
                 (T
                  <FIRE-STRUCTURAL-SET-STAGE ,FIRE-TIMBER-CHARRED>
                  <FIRE-STRUCTURAL-PUT ,FS-TIMBER-TIMER 0>
                  <COND (<EQUAL? ,HERE ,TIMBER-ROOM>
                         <TELL "The last open glow dies in the collapsed timbers. Smoke pulls away with the draft, leaving a blackened brace and a permanent heap of charred wood without changing the mine's narrow route." CR>)>
                  <RFALSE>)>)>
    <RFALSE>>

<ROUTINE FIRE-STRUCTURAL-RESET ()
    <FIRE-STRUCTURAL-PUT ,FS-TIMBER-TIMER 0>
    <FIRE-STRUCTURAL-SET-STAGE ,FIRE-TIMBER-COLD>
    <FCLEAR ,TIMBERS ,RMUNGBIT>
    <RTRUE>>

<ROUTINE FIRE-STRUCTURAL-IGNITE ()
    <COND (<NOT <EQUAL? ,HERE ,TIMBER-ROOM>> <RFALSE>)>
    <COND (<NOT ,PRSI> <RFALSE>)
          (<NOT <SHADOW-FLAME? ,PRSI>> <RFALSE>)>
    <COND (<EQUAL? <FIRE-STRUCTURAL-STAGE> ,FIRE-TIMBER-COLD>
           <FIRE-STRUCTURAL-SET-STAGE ,FIRE-TIMBER-SMOLDER>
           <FIRE-STRUCTURAL-PUT ,FS-TIMBER-TIMER 0>
           <TELL "The live flame takes at one feathered edge of the old timber. It does not explode into theatrical fire; first it smolders, sending a thin brown thread into the strong westward draft. You have time to stamp it out or use water before this becomes a room problem." CR>)
          (<EQUAL? <FIRE-STRUCTURAL-STAGE> ,FIRE-TIMBER-SMOLDER ,FIRE-TIMBER-BURNING>
           <TELL "The broken timbers are already committed to the fire experiment." CR>)
          (<EQUAL? <FIRE-STRUCTURAL-STAGE> ,FIRE-TIMBER-COLLAPSED-HOT>
           <TELL "The fallen brace and broken timbers are already hot, smoking wreckage. More flame would add enthusiasm, not information." CR>)
          (<EQUAL? <FIRE-STRUCTURAL-STAGE> ,FIRE-TIMBER-DOUSED>
           <TELL "The scorched timbers are wet through the places that were burning. They refuse this immediate attempt to restart the fire." CR>)
          (T
           <TELL "The useful dry edges are gone. What remains is a blackened structural consequence, not fresh kindling." CR>)>
    <RTRUE>>

<ROUTINE FIRE-STRUCTURAL-DOUSE ("AUX" STAGE)
    <SET STAGE <FIRE-STRUCTURAL-STAGE>>
    <COND (<NOT <EQUAL? .STAGE ,FIRE-TIMBER-SMOLDER ,FIRE-TIMBER-BURNING ,FIRE-TIMBER-COLLAPSED-HOT>>
           <RFALSE>)
          (<NOT <SHADOW-HAS-BOTTLED-WATER?>>
           <TELL "The open bottle must contain the real water before it can put out a timber fire." CR>)
          (T
           <MATERIAL-CONSUME-BOTTLED-WATER>
           <FIRE-STRUCTURAL-SET-STAGE ,FIRE-TIMBER-DOUSED>
           <FIRE-STRUCTURAL-PUT ,FS-TIMBER-TIMER 0>
           <TELL "You commit the bottled water to the hottest wood. Steam and dirty runoff replace the smoke; the flame dies. The timbers remain scorched">
           <COND (<EQUAL? .STAGE ,FIRE-TIMBER-COLLAPSED-HOT>
                  <TELL ", and the fallen brace remains exactly where gravity put it">)>
           <TELL "." CR>)>
    <RTRUE>>

<ROUTINE FIRE-TIMBERS-FCN ("AUX" STAGE)
    <SET STAGE <FIRE-STRUCTURAL-STAGE>>
    <COND (<VERB? EXAMINE>
           <COND (<EQUAL? .STAGE ,FIRE-TIMBER-COLD>
                  <TELL "The broken timbers are old, dry, and splintered. A few pieces lie beneath an equally old brace near the low westward throat. The draft is strong enough to make open flame here an environmental decision." CR>)
                 (<EQUAL? .STAGE ,FIRE-TIMBER-SMOLDER>
                  <TELL "One splintered edge is smoldering. Thin smoke is already choosing the westward draft." CR>)
                 (<EQUAL? .STAGE ,FIRE-TIMBER-BURNING>
                  <TELL "Open flame is moving along the dry broken wood. Smoke lies low under the stone, and the old brace above the clutter is beginning to object audibly." CR>)
                 (<EQUAL? .STAGE ,FIRE-TIMBER-COLLAPSED-HOT>
                  <TELL "A blackened brace has fallen into the hot broken timbers. Smoke still leaks from the heap, but the surrounding roof has settled and the canonical narrow passage remains a narrow passage." CR>)
                 (<EQUAL? .STAGE ,FIRE-TIMBER-DOUSED>
                  <TELL "The timbers are scorched and cold enough to approach. The fire is out; any brace that already fell remains fallen." CR>)
                 (T
                  <TELL "The timber pile is permanently blackened. One old brace lies collapsed into it, while the mine roof above has found a new and apparently stable argument with gravity." CR>)>
           <RTRUE>)
          (<VERB? SMELL>
           <COND (<EQUAL? .STAGE ,FIRE-TIMBER-SMOLDER ,FIRE-TIMBER-BURNING ,FIRE-TIMBER-COLLAPSED-HOT>
                  <TELL "Hot resin, dry wood smoke, coal dust, and old mine air make a combination your lungs decline to recommend." CR>)
                 (<EQUAL? .STAGE ,FIRE-TIMBER-CHARRED ,FIRE-TIMBER-DOUSED>
                  <TELL "The wood smells of soot, wet ash, and the permanent aftertaste of a preventable decision." CR>)
                 (T <TELL "The old wood smells dry, dusty, and ready to demonstrate why mines dislike casual fire." CR>)>
           <RTRUE>)
          (<VERB? LISTEN>
           <COND (<EQUAL? .STAGE ,FIRE-TIMBER-SMOLDER>
                  <TELL "A few hidden fibers tick and hiss while the draft worries at the smoke." CR>)
                 (<EQUAL? .STAGE ,FIRE-TIMBER-BURNING>
                  <TELL "The fire crackles close by. Above it, one slower wooden creak matters much more." CR>)
                 (<EQUAL? .STAGE ,FIRE-TIMBER-COLLAPSED-HOT>
                  <TELL "The fallen brace gives small cooling cracks beneath the fading hiss of hot wood." CR>)
                 (T <TELL "The timbers are quiet except for the strong draft moving around them." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE FIRE-TIMBER-ROOM-FCN (RARG "AUX" STAGE)
    <SET STAGE <FIRE-STRUCTURAL-STAGE>>
    <COND (<EQUAL? .RARG ,M-BEG>
           <NO-OBJS ,M-BEG>
           <RFALSE>)
          (<EQUAL? .RARG ,M-LOOK>
           <COND (<EQUAL? .STAGE ,FIRE-TIMBER-COLD>
                  <TELL "This is a long, narrow mine passage cluttered with broken timbers. The wide passage east leads toward the ladder, while the west end tightens into a very narrow crawl. A strong draft comes from the west." CR>)
                 (<EQUAL? .STAGE ,FIRE-TIMBER-SMOLDER>
                  <TELL "The Timber Room is beginning to fill with a thin layer of smoke from the smoldering pile. The wide eastern passage is clear; the westward draft is pulling smoke toward the narrow crawl." CR>)
                 (<EQUAL? .STAGE ,FIRE-TIMBER-BURNING>
                  <TELL "Broken timbers are burning in the long passage. Smoke is banked under the stone and being dragged west through the narrow crawl. The wide passage east remains the obvious clean escape." CR>)
                 (<EQUAL? .STAGE ,FIRE-TIMBER-COLLAPSED-HOT>
                  <TELL "A blackened brace has fallen into the hot timber pile. Smoke still follows the westward draft, though the roof above the fallen piece has settled. The wide passage east remains clear." CR>)
                 (<EQUAL? .STAGE ,FIRE-TIMBER-DOUSED>
                  <TELL "The long passage smells of ash. Its broken timbers are scorched and the fire is out; any structural damage already done remains visible. The wide route east and narrow route west are otherwise unchanged." CR>)
                 (T
                  <TELL "The long passage is marked by a permanent heap of charred timber and one fallen brace. The roof has settled, the smoke is gone, and the wide eastern route and narrow western crawl remain physically what they were." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE FIRE-STRUCTURAL-HOOK ("AUX" STAGE)
    <SET STAGE <FIRE-STRUCTURAL-STAGE>>
    <COND (<AND <VERB? BURN>
                <EQUAL? ,PRSO ,TIMBERS>>
           <FIRE-STRUCTURAL-IGNITE>
           <RTRUE>)
          (<AND <OR <AND <VERB? SHADOW-USE-ON> <EQUAL? ,PRSO ,WATER ,BOTTLE>>
                    <AND <VERB? POUR-ON> <EQUAL? ,PRSO ,WATER>>>
                <EQUAL? ,PRSI ,TIMBERS>
                <FIRE-STRUCTURAL-ACTIVE?>>
           <FIRE-STRUCTURAL-DOUSE>
           <RTRUE>)
          (<AND <VERB? LAMP-OFF>
                <EQUAL? ,PRSO ,TIMBERS>
                <FIRE-STRUCTURAL-ACTIVE?>>
           <COND (<EQUAL? .STAGE ,FIRE-TIMBER-SMOLDER>
                  <FIRE-STRUCTURAL-SET-STAGE ,FIRE-TIMBER-DOUSED>
                  <FIRE-STRUCTURAL-PUT ,FS-TIMBER-TIMER 0>
                  <TELL "You grind the small smoldering edge out under a boot before it earns open flame. The wood remains lightly scorched." CR>)
                 (T
                  <TELL "The fire has progressed past something you can extinguish by commanding it sternly. Real water can still end it; the wide passage east can end your participation." CR>)>
           <RTRUE>)
          (<AND <EQUAL? ,HERE ,TIMBER-ROOM>
                <EQUAL? .STAGE ,FIRE-TIMBER-BURNING ,FIRE-TIMBER-COLLAPSED-HOT>
                <VERB? WALK>
                <EQUAL? ,PRSO ,P?WEST>>
           <TELL "The narrow westward crawl is exactly where the draft is concentrating smoke from the timber fire. Crawling into that throat now would trade a clear eastern escape for a lungful of bad planning." CR>
           <RTRUE>)
          (<AND <EQUAL? ,HERE ,LOWER-SHAFT>
                <EQUAL? .STAGE ,FIRE-TIMBER-BURNING ,FIRE-TIMBER-COLLAPSED-HOT>
                <VERB? WALK>
                <EQUAL? ,PRSO ,P?EAST>>
           <TELL "Smoke is being pulled through the narrow crawl from the Timber Room. The passage will still exist when the air stops trying to occupy your lungs first." CR>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,TIMBERS>
                <EQUAL? .STAGE ,FIRE-TIMBER-SMOLDER ,FIRE-TIMBER-BURNING ,FIRE-TIMBER-COLLAPSED-HOT>
                <VERB? TAKE MOVE PUSH PULL>>
           <TELL "The hot timber pile is not something to rearrange while it is producing smoke and structural noises. Extinguish it or get clear." CR>
           <RTRUE>)>
    <RFALSE>>

