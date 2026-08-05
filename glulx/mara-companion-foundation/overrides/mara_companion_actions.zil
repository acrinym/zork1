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
           <TELL "You compare the armed circuit, bolt travel, gate state, reservoir trend, vibration delay, and old pressure scars. Mara records her measurements beside yours, crosses out the official claim of independent controls, and folds one waxed sheet into her coat. The first shared entry in the Last Honest Survey now exists as a physical document. Functional alliance has become chosen company—within the routes you have actually earned together." CR>)>
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
