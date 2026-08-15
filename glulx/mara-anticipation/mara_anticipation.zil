"MARA ANTICIPATION / WORRY / PROTECTIVE INITIATIVE for Release 1261"

; "Release 1261 adds prospective meaning, not a generic worry meter. Mara can
;   recognize a specific danger from shared history before the Adventurer
;   repeats it, speak concern without waiting for injury, prepare what she can
;   truthfully prepare, and remember whether the warning changed later action."

<OBJECT MARA-ANTICIPATION-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM WORRY WORRIED WARNING WARNINGS ANTICIPATION CONCERN)
    (ADJECTIVE PROTECTIVE PROACTIVE FUTURE)
    (DESC "Mara's anticipation of known danger")
    (FLAGS NDESCBIT RMUNGBIT)>

<ROUTINE MARA-KNOWN-DAM-RISK? ()
    <COND (<OR <MARA-GET ,MARA-SLOT-KNOWN-RISK-INJURY>
               <MARA-GET ,MARA-SLOT-BIO-MARA-RESCUED-YOU>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-PROACTIVE-DAM-WARNING ()
    <MARA-ENSURE>
    <COND (<OR <ZERO? <MARA-KNOWN-DAM-RISK?>>
               <MARA-GET ,MARA-SLOT-ANTICIPATED-KNOWN-RISK>>
           <RFALSE>)>
    <MARA-PUT ,MARA-SLOT-ANTICIPATED-KNOWN-RISK 1>
    <MARA-PUT ,MARA-SLOT-PROTECTIVE-INITIATIVE 1>
    <MARA-PUT ,MARA-SLOT-WORRY-SPOKEN 1>
    <COND (<IN? ,MARA-FIELD-ROPE ,MARA>
           <MARA-PUT ,MARA-SLOT-PROTECTIVE-PREPARATION 1>)>
    <COND (<MARA-RUPTURE-OPEN?>
           <TELL "Before you can put a hand on the maintenance ladder, Mara speaks from the distance she has kept. I remember what happened here. I am not waiting until you are falling to say this: reduce the load or make the descent genuinely safe. I can care whether you fall without volunteering my body as your safety system." CR>)
          (<MARA-GET ,MARA-SLOT-RUPTURE-REPAIRED>
           <TELL "Before you can put a hand on the maintenance ladder, Mara checks the wet iron, the load, and the measured rope on her shoulder. I remember what happened here, she says. You changed the action last time. I am still checking before you commit, because repair did not make the ladder forget how to hurt you." CR>)
          (T
           <TELL "Before you can put a hand on the maintenance ladder, Mara checks the wet iron, your load, and the measured rope on her shoulder. I remember what happened here, she says. I am not waiting until you are falling to say it. Reduce the load or prepare the descent before you commit." CR>)>
    <RTRUE>>

<ROUTINE MARA-ANTICIPATION-AFTER-MOVE (FROM TO)
    <MARA-ENSURE>
    <COND (<AND <NOT <EQUAL? .FROM .TO>>
                <EQUAL? .TO ,DAM-ROOM>
                <EQUAL? <DAM-SURVIVAL-SEVERITY> 2>
                <MARA-KNOWN-DAM-RISK?>
                <ZERO? <MARA-GET ,MARA-SLOT-ANTICIPATED-KNOWN-RISK>>
                <OR <EQUAL? <LOC ,MARA> .TO>
                    <AND <EQUAL? <LOC ,MARA> .FROM>
                         <EQUAL? <MARA-GET ,MARA-SLOT-MODE> ,MARA-MODE-FOLLOWING>>>>
           <MARA-PROACTIVE-DAM-WARNING>)>
    <RFALSE>>

<ROUTINE MARA-ANTICIPATION-DANGER-HOOK ()
    <MARA-ENSURE>
    <COND (<AND <EQUAL? ,WINNER ,ADVENTURER>
                <MARA-HERE?>
                <EQUAL? ,HERE ,DAM-ROOM>
                <EQUAL? ,PRSO ,DAM-MAINTENANCE-LADDER>
                <VERB? CLIMB-DOWN CLIMB-FOO>
                <EQUAL? <DAM-SURVIVAL-SEVERITY> 2>
                <MARA-GET ,MARA-SLOT-WORRY-SPOKEN>>
           <COND (<AND <DAM-SURVIVAL-OVERBURDENED?>
                       <NOT <DAM-SURVIVAL-ROPE-PREPARED?>>>
                  <COND (<ZERO? <MARA-GET ,MARA-SLOT-WARNING-OVERRIDDEN>>
                         <MARA-PUT ,MARA-SLOT-WARNING-OVERRIDDEN 1>
                         <TELL "Mara sees the unchanged load move toward the first rung. That is the exact choice I warned you about before you touched the ladder, she says. The warning is now part of what you chose with knowledge, not something I can pretend happened too late." CR>)>
                  <RFALSE>)
                 (<ZERO? <MARA-GET ,MARA-SLOT-WARNING-HEEDED>>
                  <MARA-PUT ,MARA-SLOT-WARNING-HEEDED 1>
                  <MARA-PUT ,MARA-SLOT-RELIEF-AFTER-HEEDED 1>
                  <TELL "Mara sees the changed descent before you commit to it. Good, she says, and some of the tension leaves her shoulders. You heard the warning early enough to make it unnecessary as a rescue." CR>
                  <RFALSE>)>)>
    <RFALSE>>

<ROUTINE MARA-ANTICIPATION-ABOUT (TOPIC)
    <COND (<NOT <EQUAL? .TOPIC ,MARA-ANTICIPATION-TOPIC>> <RFALSE>)>
    <COND (<ZERO? <MARA-GET ,MARA-SLOT-ANTICIPATED-KNOWN-RISK>>
           <TELL "Mara has no specific anticipated danger from shared history to name yet. She refuses to manufacture worry merely because a topic exists." CR>)
          (<MARA-GET ,MARA-SLOT-WARNING-OVERRIDDEN>
           <TELL "I warned you before the action because I remembered the previous injury, Mara says. You reached for the same unsafe choice anyway. That matters differently from danger neither of us saw coming." CR>)
          (<MARA-GET ,MARA-SLOT-WARNING-HEEDED>
           <TELL "I worried before you moved because I knew what this place had already done to you, Mara says. You changed the action while there was still time. The relief is partly that I did not have to become the rescue again." CR>)
          (T
           <TELL "I am worried because this is not an abstract ladder anymore, Mara says. We have history here. Saying it before you move is me trying to let that history change the future instead of merely narrating another injury afterward." CR>)>
    <RTRUE>>
