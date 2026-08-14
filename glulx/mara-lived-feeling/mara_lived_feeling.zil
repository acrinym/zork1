"MARA LIVED FEELING / RUPTURE / REPAIR for Release 1260"

; "Release 1260 does not model a universal mood. It records a small set of
;   authored propositions: what Mara concluded from a repeated known danger,
;   what intentional violence meant to her, and which later actions count as
;   evidence that lets her choose proximity again. Old events remain true."

<OBJECT MARA-LIVED-FEELING-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM ANGER ANGRY FEAR AFRAID RELIEF FEELING FEELINGS EMOTION EMOTIONS)
    (ADJECTIVE CURRENT HIDDEN PRIVATE)
    (DESC "Mara's feelings about what happened")
    (FLAGS NDESCBIT RMUNGBIT)>

<OBJECT MARA-RUPTURE-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM ATTACK VIOLENCE BETRAYAL RUPTURE APOLOGY REPAIR BOUNDARY BOUNDARIES)
    (ADJECTIVE INTENTIONAL PHYSICAL BROKEN REPAIRED)
    (DESC "the rupture with Mara")
    (FLAGS NDESCBIT RMUNGBIT)>

<ROUTINE MARA-RUPTURE-OPEN? ()
    <COND (<MARA-GET ,MARA-SLOT-RUPTURE-OPEN> <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-RECIPROCAL-DANGER-HISTORY? ()
    <COND (<AND <MARA-GET ,MARA-SLOT-BIO-RESCUED-MARA>
                <MARA-GET ,MARA-SLOT-BIO-ROPE-RETURNED>
                <MARA-GET ,MARA-SLOT-BIO-MARA-RESCUED-YOU>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-ABOUT-RECKLESS-FEELING ()
    <COND (<ZERO? <MARA-GET ,MARA-SLOT-RECKLESSNESS-ANGER>>
           <TELL "Mara considers the question. There is no remembered injury here that she has interpreted as knowingly repeated danger." CR>)
          (<AND <MARA-RECIPROCAL-DANGER-HISTORY?>
                <ZERO? <MARA-GET ,MARA-SLOT-FEAR-REVEALED>>>
           <MARA-PUT ,MARA-SLOT-FEAR-REVEALED 1>
           <TELL "The anger is the easy part, Mara says. You knew what that ladder could do because I had already caught you on it once. I was relieved you were standing. I was afraid I might be watching the line take your weight for the last time. Helping you and being furious with you are not opposites." CR>)
          (<MARA-RECIPROCAL-DANGER-HISTORY?>
           <TELL "Mara folds her arms. I was angry because you knowingly repeated the risk, she says. I was afraid because by then losing you was not an abstract possibility. I helped because you were hurt. None of those facts cancels another." CR>)
          (T
           <TELL "Mara's expression stays flat. I can help an injured person without volunteering to become the mechanism that makes chosen recklessness consequence-free, she says." CR>)>
    <RTRUE>>

<ROUTINE MARA-ABOUT-RUPTURE ()
    <COND (<ZERO? <MARA-GET ,MARA-SLOT-INTENTIONAL-HARM>>
           <TELL "Mara shakes her head. There is no deliberate attack by you in the history between us." CR>)
          (<MARA-RUPTURE-OPEN?>
           <COND (<ZERO? <MARA-GET ,MARA-SLOT-APOLOGY-ACKNOWLEDGED>>
                  <TELL "Danger happened around us before, Mara says. This time you chose me as the target. I am not going to make the person who attacked me responsible for soothing me about being attacked. Distance is the current answer." CR>)
                 (<ZERO? <MARA-GET ,MARA-SLOT-BOUNDARY-RESPECTED>>
                  <TELL "I heard the apology, Mara says. Hearing it is not the same as feeling safe beside you. I asked for space. What you do with that boundary is the next fact." CR>)
                 (T
                  <TELL "You apologized, and when I asked for distance you actually gave it, Mara says. That matters. It is evidence, not yet a conclusion that everything is restored." CR>)>)
          (<MARA-GET ,MARA-SLOT-RUPTURE-REPAIRED>
           <TELL "You tried to hurt me. That remains true, Mara says. You acknowledged it, gave me the distance I asked for, and later changed what you did when a dangerous choice came back. I chose to work beside you again. None of those facts erases another." CR>)
          (T
           <TELL "Mara studies you for a moment. The attack remains part of the record even if the immediate distance has changed." CR>)>
    <RTRUE>>

<ROUTINE MARA-LIVED-FEELING-ABOUT (TOPIC)
    <COND (<EQUAL? .TOPIC ,MARA-LIVED-FEELING-TOPIC>
           <MARA-ABOUT-RECKLESS-FEELING>)
          (<EQUAL? .TOPIC ,MARA-RUPTURE-TOPIC>
           <MARA-ABOUT-RUPTURE>)
          (T <RFALSE>)>
    <RTRUE>>

<ROUTINE MARA-INTENTIONAL-HARM-ATTEMPT ()
    <MARA-ENSURE>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-INDEPENDENT>
    <COND (<MARA-RUPTURE-OPEN?>
           <TELL "Mara is already outside the line of the attack before it can land. Her eyes do not leave your hands. You already answered the question of whether you might choose me as the target, she says. I am not standing close enough to let you rehearse it." CR>)
          (T
           <MARA-PUT ,MARA-SLOT-INTENTIONAL-HARM 1>
           <MARA-PUT ,MARA-SLOT-HARM-BETRAYAL 1>
           <MARA-PUT ,MARA-SLOT-RUPTURE-OPEN 1>
           <MARA-PUT ,MARA-SLOT-APOLOGY-ACKNOWLEDGED 0>
           <MARA-PUT ,MARA-SLOT-BOUNDARY-RESPECTED 0>
           <TELL "Mara steps clear before the blow can land, the same hard practical evasion that has always kept her personhood out of your inventory. What changes is her face. Danger has happened around us before, she says. This time you chose me as the danger's target. She backs beyond your reach and does not resume following." CR>)>
    <RTRUE>>

<ROUTINE MARA-RUPTURE-FOLLOW-REFUSAL ()
    <COND (<ZERO? <MARA-GET ,MARA-SLOT-BOUNDARY-RESPECTED>>
           <TELL "No, Mara says. Distance is part of what I asked for. You do not repair that by ordering me back into reach." CR>)
          (T
           <TELL "Mara stays where she is. You gave me space when I asked, she says. Keep meaning it. I am not following yet." CR>)>
    <RTRUE>>

<ROUTINE MARA-RUPTURE-APOLOGIZE ()
    <MARA-ENSURE>
    <COND (<MARA-RUPTURE-OPEN?>
           <COND (<ZERO? <MARA-GET ,MARA-SLOT-APOLOGY-ACKNOWLEDGED>>
                  <MARA-PUT ,MARA-SLOT-APOLOGY-ACKNOWLEDGED 1>
                  <TELL "Mara lets the apology exist without rescuing you from it. I heard you, she says. That sentence matters because you named what you did. It does not make me safe with you again by itself. I need space, and then I need to see what you do when a boundary costs you something." CR>)
                 (T
                  <TELL "I heard the apology the first time, Mara says. Repeating it is not the next step. Behavior is." CR>)>
           <RTRUE>)
          (<MARA-GET ,MARA-SLOT-RUPTURE-REPAIRED>
           <TELL "Mara nods once. You already apologized, and later evidence mattered more than repetition would. The attack is remembered; so is the repair." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-LIVED-AFTER-MOVE (FROM TO)
    <COND (<AND <NOT <EQUAL? .FROM .TO>>
                <MARA-RUPTURE-OPEN?>
                <MARA-GET ,MARA-SLOT-APOLOGY-ACKNOWLEDGED>
                <ZERO? <MARA-GET ,MARA-SLOT-BOUNDARY-RESPECTED>>
                <EQUAL? <LOC ,MARA> .FROM>>
           <MARA-PUT ,MARA-SLOT-BOUNDARY-RESPECTED 1>
           <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-INDEPENDENT>
           <TELL "Mara does not follow. After a moment her voice reaches you from behind: Thank you. You heard the part where I asked for space. That is a thing you did, not another sentence." CR>)>
    <RFALSE>>

<ROUTINE MARA-COMPLETE-RUPTURE-REPAIR ()
    <MARA-PUT ,MARA-SLOT-REPAIR-EVIDENCE 1>
    <MARA-PUT ,MARA-SLOT-RUPTURE-OPEN 0>
    <MARA-PUT ,MARA-SLOT-RUPTURE-REPAIRED 1>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-FOLLOWING>
    <TELL "Mara studies the safer ladder setup, then you. You changed the action instead of arguing with the boundary, she says. That is evidence. Not erasure. After a beat she steps back within ordinary working distance." CR>
    <RTRUE>>

<ROUTINE MARA-LIVED-DANGER-HOOK ()
    <COND (<AND <EQUAL? ,WINNER ,ADVENTURER>
                <MARA-HERE?>
                <EQUAL? ,HERE ,DAM-ROOM>
                <EQUAL? ,PRSO ,DAM-MAINTENANCE-LADDER>
                <VERB? CLIMB-DOWN CLIMB-FOO>
                <EQUAL? <DAM-SURVIVAL-SEVERITY> 2>>
           <COND (<AND <MARA-RUPTURE-OPEN?>
                       <MARA-GET ,MARA-SLOT-APOLOGY-ACKNOWLEDGED>
                       <MARA-GET ,MARA-SLOT-BOUNDARY-RESPECTED>
                       <OR <NOT <DAM-SURVIVAL-OVERBURDENED?>>
                           <DAM-SURVIVAL-ROPE-PREPARED?>>>
                  <MARA-COMPLETE-RUPTURE-REPAIR>
                  <RFALSE>)
                 (<AND <MARA-RUPTURE-OPEN?>
                       <DAM-SURVIVAL-OVERBURDENED?>
                       <NOT <DAM-SURVIVAL-ROPE-PREPARED?>>>
                  <TELL "Mara does not take the close backstop position. No, she says. I will call for help if you are injured. I will not put my body on the other end of a chosen fall while I still do not know whether I am safe beside you. Reduce the load or rig a real line." CR>
                  <RTRUE>)
                 (<AND <MARA-GET ,MARA-SLOT-RECKLESSNESS-ANGER>
                       <DAM-SURVIVAL-OVERBURDENED?>
                       <NOT <DAM-SURVIVAL-ROPE-PREPARED?>>>
                  <TELL "Mara plants herself between you and the wet iron. No. I helped when you were hurt, she says. That did not make the same choice safe, and it did not make me the reset button for it. Reduce the load or prepare the descent properly." CR>
                  <RTRUE>)
                 (<AND <MARA-GET ,MARA-SLOT-BIO-MARA-RESCUED-YOU>
                       <MARA-LADDER-BACKSTOP-EARNED?>
                       <DAM-SURVIVAL-OVERBURDENED?>
                       <NOT <DAM-SURVIVAL-ROPE-PREPARED?>>>
                  <MARA-PUT ,MARA-SLOT-KNOWN-RISK-INJURY 1>
                  <MARA-PUT ,MARA-SLOT-AIDED-RECKLESS-INJURY 1>
                  <MARA-PUT ,MARA-SLOT-RECKLESSNESS-ANGER 1>
                  <TELL "Mara sees you shoulder the same overloaded descent she already had to catch once. You know what this ladder does, she says, anger arriving before you move. I am still catching you because you are a person and because I am not going to watch you break yourself to prove a point. Do not confuse that with permission." CR>
                  <RFALSE>)>)>
    <RFALSE>>
