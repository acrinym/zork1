"MARA ARRIVAL AND EVIDENCE MEMORY for Release 1234"

;"Mara is a specific person, not a generic companion engine. Her first
  relationship state is grounded in direct conversation and canonical objects
  the player physically shows her. The table is dynamic save-state without
  consuming another scarce global."

<SYNTAX SHOW OBJECT (HELD CARRIED HAVE) TO OBJECT (FIND ACTORBIT) (IN-ROOM)
    = V-MARA-SHOW>
<SYNONYM SHOW PRESENT>

<CONSTANT MARA-SCHEMA 1>
<CONSTANT MARA-SLOT-MET 1>
<CONSTANT MARA-SLOT-TRUST 2>
<CONSTANT MARA-SLOT-LAST-EVIDENCE 3>
<CONSTANT MARA-STATE <TABLE MARA-SCHEMA 0 0 0>>

<ROUTINE MARA-GET (SLOT)
    <GET ,MARA-STATE .SLOT>>

<ROUTINE MARA-PUT (SLOT VALUE)
    <PUT ,MARA-STATE .SLOT .VALUE>>

<ROUTINE MARA-MEET ()
    <COND (<ZERO? <MARA-GET ,MARA-SLOT-MET>>
           <MARA-PUT ,MARA-SLOT-MET 1>
           <TELL '"Mara," she says, giving the room one careful look before meeting your eyes. "Show me what matters, not merely what glitters."' CR>)
          (<MARA-GET ,MARA-SLOT-LAST-EVIDENCE>
           <TELL '"I remember the ' D <MARA-GET ,MARA-SLOT-LAST-EVIDENCE> '," Mara says. "You put it in my hands as evidence, not as a story."' CR>)
          (T
           <TELL '"I am still listening," Mara says. "Bring me something real from the expedition."' CR>)>>

<ROUTINE MARA-ABOUT (TOPIC)
    <COND (<EQUAL? .TOPIC ,MUSEUM-CATALOG-OBJECT>
           <COND (<MARA-GET ,MARA-SLOT-LAST-EVIDENCE>
                  <TELL '"The museum means more now," Mara says. "I have handled one of its pieces myself."' CR>)
                 (T
                  <TELL '"A room full of trophies can still lie," Mara says. "Let me see one object and the history attached to it."' CR>)>)
          (<AND .TOPIC
                <EQUAL? .TOPIC <MARA-GET ,MARA-SLOT-LAST-EVIDENCE>>>
           <TELL '"That one I know," Mara says. "It was '>
           <MUSEUM-PROVENANCE .TOPIC>
           <TELL '."' CR>)
          (T
           <TELL '"I cannot honestly claim that history yet," Mara says. "Show me the evidence first."' CR>)>>

<ROUTINE MARA-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "Mara studies the room with patient attention. She looks ready to remember concrete evidence, but not to pretend knowledge she has not earned." CR>)
          (<VERB? TELL>
           <COND (,PRSI <MARA-ABOUT ,PRSI>)
                 (T <MARA-MEET>)>)
          (<VERB? TAKE MOVE MUNG ATTACK>
           <TELL "Mara steps clear before the action can become force." CR>)
          (T <RFALSE>)>>

<ROUTINE V-MARA-SHOW ()
    <COND (<NOT <EQUAL? ,PRSI ,MARA>>
           <TELL "That person shows no interest in becoming part of this evidence record." CR>)
          (<NOT <HELD? ,PRSO>>
           <TELL "You need to be holding the object before Mara can examine it." CR>)
          (T
           <MARA-PUT ,MARA-SLOT-MET 1>
           <MARA-PUT ,MARA-SLOT-LAST-EVIDENCE ,PRSO>
           <COND (<L? <MARA-GET ,MARA-SLOT-TRUST> 3>
                  <MARA-PUT ,MARA-SLOT-TRUST
                            <+ <MARA-GET ,MARA-SLOT-TRUST> 1>>)>
           <TELL "Mara takes enough time to examine the " D ,PRSO
                 ", then returns it to you. ">
           <TELL '"I will remember this one," she says. "It was '>
           <MUSEUM-PROVENANCE ,PRSO>
           <TELL '."' CR>)>>

<OBJECT MARA
    (IN LIVING-ROOM)
    (SYNONYM MARA WOMAN COMPANION)
    (ADJECTIVE DARK HAIRED WATCHFUL)
    (DESC "Mara")
    (LDESC "Mara sits near the museum displays, watching the room rather than the treasure.")
    (FLAGS NDESCBIT ACTORBIT TRYTAKEBIT)
    (ACTION MARA-FCN)>
