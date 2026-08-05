<ROUTINE MARA-PLAYER-FOLLOW ()
    <MARA-ENSURE>
    <COND (<ZERO? <MARA-GET ,MARA-SLOT-DAM-SURVEY>>
           <TELL "Mara is not leading a sightseeing tour. Complete the shared Dam work before assuming her route is yours." CR>)
          (<EQUAL? ,HERE ,DAM-BASE>
           <TELL "Mara points up toward the control face. Her current work leads north and up to the Dam, but she waits for you to choose the movement yourself." CR>)
          (<EQUAL? ,HERE ,DAM-ROOM>
           <TELL "Mara's next route depends on the evidence: west to compare reservoir state, north to the maintenance controls, or south toward the older passages. She will not choose your investigation for you." CR>)
          (T
           <TELL "Mara is here as company, not a replacement command prompt. Ask what she thinks or choose a route and ask her to follow." CR>)>
    <RTRUE>>

<ROUTINE MARA-FIELD-PACK-FCN ()
    <MARA-ENSURE>
    <COND (<VERB? EXAMINE>
           <TELL "The waxed canvas pack contains Mara's private notebook, route tools, spare cord, and field supplies arranged for her work rather than your inventory. The locking hitch is practical, visible, and deliberately not an invitation.">
           <COND (<MARA-GET ,MARA-SLOT-DAM-SURVEY>
                  <TELL " The joint Dam sheet is not here; Mara carries the working original herself.">)>
           <CRLF>
           <RTRUE>)
          (<VERB? TAKE OPEN CLOSE LOOK-INSIDE SEARCH MUNG CUT>
           <TELL "The pack is Mara's property. Its surveyor's hitch and waxed flaps remain physically closed to you; companionship does not convert privacy into loot." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-PRIVATE-EQUIPMENT-FCN ()
    <COND (<VERB? EXAMINE>
           <COND (<EQUAL? ,PRSO ,MARA-NOTEBOOK>
                  <TELL "A waxed field notebook in Mara's pack contains measurements and conclusions she has chosen not to publish or surrender." CR>)
                 (<EQUAL? ,PRSO ,MARA-FIELD-ROPE>
                  <TELL "Mara's rope is waxed against water, marked at measured intervals, and coiled for use rather than decoration." CR>)
                 (T
                  <TELL "The hooded field lantern belongs to Mara. Its small reserve of fuel is kept for her own route decisions; it is not a free second solution to every dark room." CR>)>
           <RTRUE>)
          (<VERB? TAKE GIVE MOVE MUNG>
           <TELL "Mara keeps custody of her own field equipment. Ask for help with a real task rather than treating her as an equipment locker." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-DAM-SURVEY-SHEET-FCN ()
    <COND (<VERB? READ EXAMINE>
           <TELL "The waxed sheet records two sets of measurements from Flood Control Dam #3: interlock state, bolt travel, gate motion, reservoir trend, vibration delay, pressure scars, and the explicit correction that the official controls were not independent. Mara's name and yours appear beside separate observations rather than a fictional single voice." CR>
           <RTRUE>)
          (<VERB? TAKE GIVE MOVE>
           <TELL "Mara retains the working original. She will share what it says, but exact custody remains hers until she chooses otherwise." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-FCN ()
    <MARA-ENSURE>
    <COND (<AND <EQUAL? ,WINNER ,MARA> <VERB? FOLLOW>>
           <MARA-REQUEST-FOLLOW>)
          (<AND <EQUAL? ,WINNER ,MARA> <VERB? WAIT>>
           <MARA-WAIT-HERE>)
          (<AND <EQUAL? ,WINNER ,MARA> <VERB? MARA-BRACE>>
           <V-MARA-BRACE>)
          (<AND <EQUAL? ,WINNER ,MARA> <VERB? PUSH>
                <EQUAL? ,PRSO ,BLUE-BUTTON>>
           <TELL "Mara refuses. That circuit is scarred, pressurized, and unsupported by a relief path. You may make your own bad decision; you may not issue it as hers." CR>
           <RTRUE>)
          (<AND <EQUAL? ,WINNER ,MARA> <VERB? WALK>>
           <TELL "Mara chooses her own footing. Ask her to follow, wait, or help with the actual mechanism rather than steering her by compass point." CR>
           <RTRUE>)
          (<AND <EQUAL? ,WINNER ,MARA> <VERB? TAKE DROP GIVE PUT PUT-ON>>
           <TELL "Mara declines to become a remote inventory hand. Name the shared physical task or keep custody yourself." CR>
           <RTRUE>)
          (<VERB? EXAMINE>
           <TELL "Mara Tallow is a dark-haired field surveyor in a weathered coat, with a measured rope and hooded lantern carried as her own equipment. She watches routes, load-bearing stone, water marks, and people with the same patient suspicion.">
           <COND (<MARA-GET ,MARA-SLOT-DAM-SURVEY>
                  <TELL " A folded joint Dam survey rests inside her coat.">)>
           <COND (<EQUAL? <MARA-GET ,MARA-SLOT-MODE> ,MARA-MODE-WAITING>
                  <TELL " She is waiting here by explicit agreement.">)>
           <CRLF>
           <RTRUE>)
          (<VERB? TELL>
           <COND (,PRSI <MARA-ABOUT ,PRSI>)
                 (T <MARA-MEET>)>)
          (<AND <VERB? GIVE> <EQUAL? ,PRSI ,MARA>>
           <TELL "Mara does not accept permanent custody merely because an object was offered. SHOW it to her if the point is evidence; keep it if the point is ownership." CR>
           <RTRUE>)
          (<VERB? FOLLOW>
           <MARA-PLAYER-FOLLOW>)
          (<VERB? MARA-THANK>
           <V-MARA-THANK>)
          (<VERB? MARA-APOLOGIZE>
           <V-MARA-APOLOGIZE>)
          (<VERB? KISS>
           <COND (<MARA-GET ,MARA-SLOT-DAM-SURVEY>
                  <TELL "Mara does not flinch, but she does not meet you halfway. Not at a working dam, not as payment for competence, and not before we know what this is, she says. The boundary is calm and complete." CR>)
                 (T
                  <TELL "Mara steps back. You have mistaken a shared location for a shared history, she says." CR>)>
           <RTRUE>)
          (<VERB? TAKE MOVE MUNG ATTACK>
           <TELL "Mara steps clear before the action can become force. She is another adventurer, not an obtainable object." CR>
           <RTRUE>)
          (T <RFALSE>)>>

<OBJECT MARA
    (IN DAM-BASE)
    (SYNONYM MARA TALLOW WOMAN SURVEYOR COMPANION PARTNER)
    (ADJECTIVE DARK HAIRED WATCHFUL FIELD HUMAN)
    (DESC "Mara Tallow")
    (LDESC "Mara Tallow is here with a waxed survey book, watching the route rather than waiting to be assigned one.")
    (FLAGS ACTORBIT TRYTAKEBIT)
    (ACTION MARA-FCN)>
