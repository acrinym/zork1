<ROUTINE MARA-REQUEST-FOLLOW ()
    <MARA-ENSURE>
    <COND (<NOT <MARA-HERE?>>
           <TELL "Mara is not here to make that decision." CR>)
          (T
           <COND (<ZERO? <MARA-GET ,MARA-SLOT-MET>> <MARA-MEET>)>
           <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-FOLLOWING>
           <COND (<MARA-GET ,MARA-SLOT-DAM-SURVEY>
                  <TELL "Mara settles the survey rope across her shoulder. For the routes we have actually agreed to share, yes." CR>)
                 (T
                  <TELL "Mara closes her notebook. As far as the Dam survey takes us, she says. Do not mistake that for an oath to follow you into every hole in the Empire." CR>)>)>
    <RTRUE>>

<ROUTINE MARA-WAIT-HERE ()
    <MARA-ENSURE>
    <COND (<AND <EQUAL? ,HERE ,MAINTENANCE-ROOM>
                <G? ,WATER-LEVEL 0>>
           <MOVE ,MARA ,DAM-LOBBY>
           <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
           <TELL "Mara refuses to wait inside a flooding maintenance room. She retreats through the doorway to the Dam Lobby and waits where the architecture is making fewer threats." CR>)
          (T
           <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
           <TELL "Mara marks the location in her notebook. I will wait here, she says, not everywhere and not forever." CR>)>
    <RTRUE>>

<ROUTINE MARA-AFTER-PLAYER-MOVE (FROM TO)
    <MARA-ENSURE>
    <COND (<AND <EQUAL? <MARA-GET ,MARA-SLOT-MODE> ,MARA-MODE-FOLLOWING>
                <EQUAL? <LOC ,MARA> .FROM>>
           <COND (<MARA-CAN-ENTER? .TO>
                  <MOVE ,MARA .TO>
                  <COND (<AND <EQUAL? .TO ,LIVING-ROOM>
                              <ZERO? <MARA-GET ,MARA-SLOT-HOUSE-VISITED>>>
                         <MARA-PUT ,MARA-SLOT-HOUSE-VISITED 1>
                         <TELL "Mara crosses the threshold, then stops—not at the treasure, but at the signs that the House has been repaired, damaged, used, and returned to. So this is the base, she says." CR>)>)
                 (T
                  <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
                  <COND (<AND <EQUAL? .TO ,MAINTENANCE-ROOM>
                              <G? ,WATER-LEVEL 0>>
                         <TELL "Mara remains outside the flooding maintenance room. Seal it or come back out, she calls." CR>)
                        (<AND <EQUAL? .TO ,TROLL-ROOM>
                              <IN? ,TROLL ,TROLL-ROOM>>
                         <TELL "Mara stops short of the Troll Room. I do not enter an occupied killing ground merely because you walked first, she says." CR>)
                        (T
                         <TELL "Mara stays behind. That route is outside the plan you made together; her location remains exactly where you left her." CR>)>)>)>
    <RFALSE>>

<ROUTINE MARA-ACTION-HOOK ()
    <MARA-ENSURE>
    <COND (<AND <EQUAL? ,WINNER ,ADVENTURER>
                <MARA-HERE?>
                <VERB? PUSH>
                <EQUAL? ,PRSO ,BLUE-BUTTON>
                <ZERO? ,WATER-LEVEL>>
           <COND (<ZERO? <MARA-GET ,MARA-SLOT-LEAK-WARNED>>
                  <MARA-PUT ,MARA-SLOT-LEAK-WARNED 1>
                  <TELL "Mara studies the rust around the blue pipe circuit. That line has pressure scars and no credible relief path, she says. Press it if you must, but do not call the result unforeseeable." CR>)>
           <RFALSE>)>
    <RFALSE>>

<ROUTINE MARA-ADVANCE ()
    <MARA-ENSURE>
    <COND (<AND <MARA-GET ,MARA-SLOT-LEAK-CAUSED>
                <ZERO? <MARA-GET ,MARA-SLOT-LEAK-REPAIRED>>
                <L? ,WATER-LEVEL 0>>
           <MARA-PUT ,MARA-SLOT-LEAK-REPAIRED 1>
           <COND (<OR <MARA-HERE?>
                      <AND <EQUAL? <LOC ,MARA> ,DAM-LOBBY>
                           <EQUAL? ,HERE ,MAINTENANCE-ROOM>>>
                  <TELL "The hard rush in the pipe collapses to a sealed hiss. From the doorway, Mara says, Good. Repair first; interpretation afterward." CR>)>)>
    <COND (<AND <MARA-GET ,MARA-SLOT-DAM-BRACED>
                <NOT <EQUAL? <LOC ,MARA> ,DAM-ROOM>>>
           <MARA-PUT ,MARA-SLOT-DAM-BRACED 0>)>
    <RFALSE>>

<ROUTINE MARA-DAM-AFTER-BUTTON (BUTTON BEFORE)
    <MARA-ENSURE>
    <COND (<AND <EQUAL? .BUTTON ,BLUE-BUTTON>
                <EQUAL? ,WINNER ,ADVENTURER>
                <MARA-HERE?>
                <EQUAL? .BEFORE 0>
                <G? ,WATER-LEVEL 0>>
           <MARA-PUT ,MARA-SLOT-LEAK-CAUSED 1>
           <MARA-DECREASE ,MARA-SLOT-SAFETY -3>
           <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
           <MOVE ,MARA ,DAM-LOBBY>
           <TELL "The pipe answers with a violent crack. Mara is already moving before the water reaches the floor. She retreats to the lobby, taking her body and her field notes out of the experiment you were warned about." CR>)>
    <RFALSE>>

<ROUTINE MARA-DAM-AFTER-BOLT (BEFORE)
    <MARA-ENSURE>
    <COND (<AND <EQUAL? ,WINNER ,ADVENTURER>
                <MARA-HERE?>
                <NOT <EQUAL? .BEFORE ,GATES-OPEN>>>
           <COND (<MARA-GET ,MARA-SLOT-DAM-BRACED>
                  <MARA-PUT ,MARA-SLOT-DAM-BRACED 0>
                  <COND (<ZERO? <MARA-GET ,MARA-SLOT-DAM-CYCLED>>
                         <MARA-PUT ,MARA-SLOT-DAM-CYCLED 1>
                         <MARA-INCREASE ,MARA-SLOT-TRUST 3>
                         <MARA-INCREASE ,MARA-SLOT-RESPECT 3>)>
                  <TELL "Mara keeps both hands against the shuddering panel while the bolt turns. When the deeper machinery takes the load, she does not celebrate; she watches the stone, counts the delay, and says, Again, but now we know which part of the map was lying." CR>)
                 (T
                  <TELL "Mara watches the gate state change. The mechanism works, she says, but a witnessed operation is not yet a joint survey." CR>)>)
          (<AND <EQUAL? ,WINNER ,ADVENTURER>
                <MARA-HERE?>
                <MARA-GET ,MARA-SLOT-DAM-BRACED>>
           <TELL "Mara holds the panel steady, but the bolt does not transfer force. Check the yellow interlock before trying to persuade the wrench." CR>)>
    <RFALSE>>

<ROUTINE MARA-WITNESS-FISH (VARIETY)
    <MARA-ENSURE>
    <COND (<MARA-HERE?>
           <COND (<ZERO? <MARA-GET ,MARA-SLOT-MET>> <MARA-MEET>)>
           <COND (<ZERO? <MARA-GET ,MARA-SLOT-FISH-WITNESSED>>
                  <MARA-PUT ,MARA-SLOT-FISH-WITNESSED 1>
                  <MARA-INCREASE ,MARA-SLOT-RESPECT 3>)>
           <MARA-PUT ,MARA-SLOT-LAST-EVIDENCE ,DAM-SILVERFIN>
           <COND (<EQUAL? .VARIETY ,SILVERFIN-SPILLWAY>
                  <TELL "Mara crouches beside the jar without touching it. Broad tail, pale impact line, faster-water body, she says. The lowered reservoir changed more than the view." CR>)
                 (T
                  <TELL "Mara studies the narrow silver body in the jar. River form, steady-current musculature, no fresh gate scar, she says. Record the water state with the animal or the record is decoration." CR>)>)>
    <RFALSE>>

<ROUTINE MARA-WITNESS-RELEASE ()
    <MARA-ENSURE>
    <COND (<MARA-HERE?>
           <COND (<ZERO? <MARA-GET ,MARA-SLOT-FISH-RELEASED>>
                  <MARA-PUT ,MARA-SLOT-FISH-RELEASED 1>
                  <MARA-INCREASE ,MARA-SLOT-TRUST 3>
                  <MARA-INCREASE ,MARA-SLOT-RESPECT 3>)>
           <TELL "Mara watches the silverfin recover its place in the current. Evidence observed, animal alive, custody closed, she says. That is an unusually clean ending." CR>)>
    <RFALSE>>
