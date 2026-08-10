<ROUTINE V-MARA-BRACE ()
    <MARA-ENSURE>
    <COND (<NOT <EQUAL? ,PRSO ,CONTROL-PANEL>>
           <TELL "The useful two-person brace here applies to the Dam control panel." CR>)
          (<NOT <EQUAL? ,HERE ,DAM-ROOM>>
           <TELL "The mechanical control panel is on the top of Flood Control Dam #3." CR>)
          (<NOT <MARA-HERE?>>
           <TELL "Mara must be physically present to hold the other side." CR>)
          (<NOT <EQUAL? ,WINNER ,MARA>>
           <TELL "You can brace the panel or turn the wrench, but not honestly claim to do both. Address Mara directly: MARA, BRACE PANEL." CR>)
          (<NOT ,DAM-MECH-PANEL-DIAGNOSED>
           <TELL "Mara refuses to brace an undiagnosed machine. Examine the control panel and establish what is actually connected first." CR>)
          (T
           <MARA-PUT ,MARA-SLOT-MET 1>
           <MARA-PUT ,MARA-SLOT-DAM-BRACED 1>
           <TELL "Mara plants one boot against the stone curb and braces the control panel at its load-bearing edge. Turn the bolt with the wrench, she says. If the yellow interlock is armed, I can keep the panel from walking while the gates take the force." CR>)>
    <RTRUE>>

<ROUTINE V-MARA-SURVEY ()
    <MARA-ENSURE>
    <COND (<NOT <EQUAL? ,PRSI ,MARA>>
           <TELL "A joint field survey requires Mara, not an interchangeable second noun." CR>)
          (<NOT <EQUAL? ,HERE ,DAM-ROOM>>
           <TELL "The joint Dam survey is made at the control face where the mechanism, stone, and reservoir state can be compared." CR>)
          (<NOT <MARA-HERE?>>
           <TELL "Mara is not physically present to make the second set of observations." CR>)
          (<NOT <EQUAL? ,PRSO ,DAM ,CONTROL-PANEL ,BOLT ,MARA-DAM-TOPIC>>
           <TELL "This authored joint survey currently covers Flood Control Dam #3 and its control mechanism." CR>)
          (<NOT ,DAM-MECH-PANEL-DIAGNOSED>
           <TELL "First diagnose the control panel. A survey begins with observed state, not ceremonial paperwork." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-DAM-CYCLED>>
           <TELL "Mara has measurements but no jointly witnessed load change. Arm the interlock, have her brace the panel, and cycle the real gates before filing a conclusion." CR>)
          (<MARA-GET ,MARA-SLOT-DAM-SURVEY>
           <TELL "The joint Dam survey already exists as one physical waxed sheet in Mara's custody. Repeating the command cannot manufacture a second discovery." CR>)
          (T
           <MARA-PUT ,MARA-SLOT-DAM-SURVEY 1>
           <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-FOLLOWING>
           <MARA-INCREASE ,MARA-SLOT-TRUST 3>
           <MARA-INCREASE ,MARA-SLOT-RESPECT 3>
           <MOVE ,MARA-DAM-SURVEY-SHEET ,MARA>
           <TELL "You compare the armed circuit, bolt travel, gate state, reservoir trend, vibration delay, and old pressure scars. Mara records her measurements beside yours, crosses out the official claim of independent controls, and folds one waxed sheet into her coat. The first shared entry in the Last Honest Survey now exists as a physical document. Functional alliance has become chosen company within the routes you have actually earned together." CR>)>
    <RTRUE>>

<ROUTINE V-MARA-SHOW ()
    <MARA-ENSURE>
    <COND (<NOT <EQUAL? ,PRSI ,MARA>>
           <TELL "That person shows no interest in becoming part of this evidence record." CR>)
          (<NOT <HELD? ,PRSO>>
           <TELL "You need to be holding the object before Mara can examine it." CR>)
          (T
           <MARA-PUT ,MARA-SLOT-MET 1>
           <MARA-PUT ,MARA-SLOT-LAST-EVIDENCE ,PRSO>
           <COND (<ZERO? <MARA-GET ,MARA-SLOT-EVIDENCE-SHARED>>
                  <MARA-PUT ,MARA-SLOT-EVIDENCE-SHARED 1>
                  <MARA-INCREASE ,MARA-SLOT-TRUST 3>)>
           <TELL "Mara takes enough time to examine the " D ,PRSO
                 ", then returns it to you. She remembers an actual object, not a gift transaction: it was ">
           <MUSEUM-PROVENANCE ,PRSO>
           <TELL "." CR>)>
    <RTRUE>>

<ROUTINE V-MARA-THANK ()
    <MARA-ENSURE>
    <COND (<NOT <EQUAL? ,PRSO ,MARA>>
           <TELL "Your gratitude does not appear to have reached a person." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-DAM-CYCLED>>
           <TELL "Mara inclines her head. Save the serious thanks for after the machinery has given us a reason, she says." CR>)
          (<MARA-GET ,MARA-SLOT-THANKED>
           <TELL "Mara has already heard you. Repetition does not turn gratitude into currency." CR>)
          (T
           <MARA-PUT ,MARA-SLOT-THANKED 1>
           <MARA-INCREASE ,MARA-SLOT-TRUST 3>
           <TELL "Mara accepts the thanks without waving it away. You held your side of the mechanism, she says. So did I. That is worth saying plainly once." CR>)>
    <RTRUE>>

<ROUTINE V-MARA-APOLOGIZE ()
    <MARA-ENSURE>
    <COND (<NOT <EQUAL? ,PRSO ,MARA>>
           <TELL "The apology requires a person and a specific harm." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-LEAK-CAUSED>>
           <TELL "Mara waits for the missing noun. Apologize for what, exactly?" CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-LEAK-REPAIRED>>
           <TELL "Seal the pipe first, Mara says. An apology that leaves the water running is merely another sound in the room." CR>)
          (<MARA-GET ,MARA-SLOT-APOLOGY>
           <TELL "Mara remembers the apology. She is watching the behavior that follows it, not requesting another performance." CR>)
          (T
           <MARA-PUT ,MARA-SLOT-APOLOGY 1>
           <MARA-INCREASE ,MARA-SLOT-TRUST 3>
           <MARA-INCREASE ,MARA-SLOT-SAFETY 2>
           <TELL "You name the warning you ignored and the danger you caused. Mara does not erase it. She does acknowledge that you repaired the damage before asking to be forgiven. That is a beginning, she says." CR>)>
    <RTRUE>>

<ROUTINE V-MARA-INVITE-STAY ()
    <MARA-ENSURE>
    <COND (<NOT <EQUAL? ,PRSO ,MARA>>
           <TELL "The invitation needs to be made to Mara herself." CR>)
          (<NOT <MARA-HERE?>>
           <TELL "Mara is not here to accept or refuse the invitation." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-DAM-SURVEY>>
           <TELL "Mara considers you for a moment. We have not even finished one honest field entry together, she says. A permanent-sounding invitation would be theater." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-HOUSE-VISITED>>
           <TELL "Mara has not seen the House. She will not agree to live inside a description." CR>)
          (<MARA-GET ,MARA-SLOT-HOUSE-STAY>
           <TELL "Mara already chose to use the House as a base. Her pack remains where she placed it in the Attic; repeating the invitation does not make the choice more binding." CR>)
          (<NOT <EQUAL? ,HERE ,LIVING-ROOM ,ATTIC>>
           <TELL "Make that invitation at the House, where Mara can judge the place being offered rather than the idea of it." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-PACK-RETRIEVED>>
           <MARA-PUT ,MARA-SLOT-HOUSE-INVITED 1>
           <TELL "Mara does not answer immediately. Then: I would consider using the House as a base. But my field pack is still at the Dam. We do not make a new life by pretending the old one teleported. Come back with me; at the Dam Base, ask me to take my pack." CR>)
          (<NOT <IN? ,MARA-FIELD-PACK ,MARA>>
           <TELL "Mara looks toward her pack. If I am going to choose a place for it, I need to be carrying it there myself." CR>)
          (<NOT <EQUAL? ,HERE ,ATTIC>>
           <TELL "Mara keeps the pack on her shoulder. The Living Room is shared traffic, not private camp. Show me the Attic, she says. If it is sound, ask again there." CR>)
          (T
           <MARA-PUT ,MARA-SLOT-HOUSE-STAY 1>
           <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
           <MOVE ,MARA-FIELD-PACK ,ATTIC>
           <TELL "Mara tests the Attic floorboards, the roofline, the windowless angles, and the distance to the stair before setting down her own field pack. This will do, she says. I am choosing to use the House as a base. The pack stays mine, the room stays yours, and either of us may change the arrangement by saying so. For now, the House contains one more actual life." CR>)>
    <RTRUE>>

<ROUTINE MARA-PACK-CAMP ()
    <MARA-ENSURE>
    <COND (<NOT <MARA-HERE?>>
           <TELL "Mara is not here to take custody of her pack." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-HOUSE-INVITED>>
           <TELL "Mara leaves the pack where it is. I still have field work based here, she says. Give me a reason to move camp before turning it into luggage." CR>)
          (<NOT <EQUAL? ,HERE ,DAM-BASE>>
           <TELL "Mara's field camp is at the Dam Base. She cannot pack a camp from a different room." CR>)
          (<IN? ,MARA-FIELD-PACK ,MARA>
           <TELL "Mara already has the pack on her own shoulder." CR>)
          (<NOT <IN? ,MARA-FIELD-PACK ,DAM-BASE>>
           <TELL "The field pack is no longer resting at the Dam Base, so there is nothing here for Mara to retrieve." CR>)
          (T
           <MOVE ,MARA-FIELD-PACK ,MARA>
           <MARA-PUT ,MARA-SLOT-PACK-RETRIEVED 1>
           <TELL "Mara kneels at the waxed pack, checks the notebook seal, coils the loose camp cord, and shoulders the weight herself. Nothing changes custody: the pack was hers at the Dam and is hers on the road. All right, she says. Now we can see whether your House can hold a second route without swallowing it." CR>)>
    <RTRUE>>

<ROUTINE V-MARA-SHARE-MEAL ("AUX" LEVEL)
    <MARA-ENSURE>
    <COND (<NOT <EQUAL? ,PRSI ,MARA>>
           <TELL "The shared meal in this chapter is specifically between you and Mara." CR>)
          (<NOT <EQUAL? ,PRSO ,LUNCH>>
           <TELL "The House currently has one authored meal suitable for sharing: the real prepared lunch." CR>)
          (<NOT <EQUAL? ,HERE ,KITCHEN>>
           <TELL "Share the meal in the white-house Kitchen, where it can be prepared and divided physically." CR>)
          (<NOT <MARA-HERE?>>
           <TELL "Mara must be physically present to share the meal." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-HOUSE-STAY>>
           <TELL "Mara declines to turn food into a shortcut around the unfinished invitation. Settle the question of whether she is actually using the House first." CR>)
          (<MARA-GET ,MARA-SLOT-MEAL-SHARED>
           <TELL "That first shared House meal already happened. Repeating a social command cannot recreate the consumed lunch." CR>)
          (<NOT <IN? ,LUNCH ,KITCHEN-WORKTOP>>
           <TELL "Put the real lunch on the Kitchen worktop before dividing it." CR>)
          (<ZERO? <KITCHEN-GET ,KS-LUNCH-PREPARED>>
           <TELL "Prepare the lunch before offering half of it as an actual meal." CR>)
          (T
           <SET LEVEL <CUISINE-MEAL-LEVEL>>
           <COND (<G? .LEVEL 1> <SET LEVEL <- .LEVEL 1>>)
                 (<ZERO? .LEVEL> <SET LEVEL 1>)>
           <REMOVE ,LUNCH>
           <CUISINE-PUT ,CUISINE-SLOT-STRAIN 0>
           <CUISINE-PUT ,CUISINE-SLOT-HUNGER 0>
           <CUISINE-PUT ,CUISINE-SLOT-SATIATION .LEVEL>
           <CUISINE-PUT ,CUISINE-SLOT-MEALS
                        <+ <CUISINE-GET ,CUISINE-SLOT-MEALS> 1>>
           <MARA-PUT ,MARA-SLOT-MEAL-SHARED 1>
           <TELL "You divide the real prepared lunch on the wooden worktop. Mara takes one half and you take the other. There is no conjured second plate and no duplicate sandwich; one physical meal becomes two eaten portions. She eats in companionable silence for a while, then says, A base is partly where someone can be hungry without performing it. The shared meal clears your accumulated strain, though splitting it leaves a smaller reserve than eating the whole thing alone." CR>)>
    <RTRUE>>
