"MARA FIELD CAPABILITY DISCOVERY for Release 1259"

; "Release 1259 records authored capability biography. Mara does not gain
;   generic skills or levels. Existing survey knowledge becomes physical or
;   perceptual competence only through things she actually does, and later
;   reuse remains a separate historical fact from first discovery."

<OBJECT MARA-CAPABILITY-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM ABILITY ABILITIES CAPABILITY CAPABILITIES SKILL SKILLS TALENT TALENTS)
    (ADJECTIVE FIELD PHYSICAL SURVEY HIDDEN NEW)
    (DESC "Mara's field capabilities")
    (FLAGS NDESCBIT RMUNGBIT)>

<OBJECT MARA-RECOVERY-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM INJURY SHOULDER PALM HAND SCAR RECOVERY HEALING)
    (ADJECTIVE LADDER DAM INJURED HURT HEALED RECOVERED)
    (DESC "Mara's ladder injury")
    (FLAGS NDESCBIT RMUNGBIT)>

<OBJECT MARA-ACOUSTIC-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM ACOUSTICS ACOUSTIC ECHO ECHOES RESONANCE SOUND SOUNDS HEARING)
    (ADJECTIVE RANGE RANGING SONIC LISTENING)
    (DESC "acoustic ranging")
    (FLAGS NDESCBIT RMUNGBIT)>

<OBJECT MARA-SERVICE-PIPE
    (IN DAM-BASE)
    (SYNONYM PIPE CONDUIT BAR IRON)
    (ADJECTIVE OVERHEAD SERVICE OLD FIXED CROSSING)
    (DESC "overhead service pipe")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION MARA-SERVICE-PIPE-FCN)>

<OBJECT MARA-CANYON-RINGBOLT
    (IN DEEP-CANYON)
    (SYNONYM RINGBOLT RING BOLT ANCHOR)
    (ADJECTIVE OLD IRON SURVEY FIXED CANYON)
    (DESC "old canyon ringbolt")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION MARA-CANYON-RINGBOLT-FCN)>

<OBJECT MARA-SURVEY-PLUMMET
    (SYNONYM PLUMMET BOB WEIGHT PLUMB)
    (ADJECTIVE BRASS OLD SURVEY IMPERIAL)
    (DESC "old brass survey plummet")
    (FLAGS TAKEBIT NDESCBIT)
    (SIZE 2)
    (ACTION MARA-SURVEY-PLUMMET-FCN)>

<ROUTINE MARA-SERVICE-PIPE-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "The old iron service pipe is fixed into the Dam masonry above the narrow side channel. Its brackets are ugly but deep-set, and Mara's measured rope marks make the drop and return arc calculable rather than imaginary." CR>)
          (<VERB? TAKE MOVE PUSH MUNG>
           <TELL "The service pipe is part of the Dam. It can be inspected or used as a fixed point; it cannot sensibly be carried away." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-CANYON-RINGBOLT-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "The old ringbolt is driven into sound stone beside the Deep Canyon stair. Rust has taken the surface, not the depth of the iron." CR>)
          (<VERB? TAKE MOVE MUNG>
           <TELL "The ringbolt is fixed into the canyon wall. Removing the anchor would defeat the useful part of finding it." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-SURVEY-PLUMMET-FCN ()
    <COND (<VERB? EXAMINE>
           <TELL "The old brass plummet is a dense teardrop of metal with a worn attachment eye and small imperial survey scratches around the shoulder. It was made to turn gravity into a trustworthy line." CR>
           <RTRUE>)
          (<AND <VERB? TAKE> <IN? ,MARA-SURVEY-PLUMMET ,MARA>>
           <TELL "Mara closes her hand around the plummet before the transfer becomes automatic. I recovered this for the survey, she says. Ask about it; do not silently change custody." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-LOUD-ROOM-SAFE? ()
    <COND (<OR ,LOUD-FLAG
               <AND <NOT ,GATES-OPEN> ,LOW-TIDE>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-RECOVER-AFTER-HOUSE-REST ()
    <MARA-ENSURE>
    <COND (<AND <MARA-GET ,MARA-SLOT-LADDER-INJURY>
                <ZERO? <MARA-GET ,MARA-SLOT-LADDER-RECOVERED>>
                <MARA-GET ,MARA-SLOT-HOUSE-STAY>
                <EQUAL? <LOC ,MARA> ,ATTIC>>
           <MARA-PUT ,MARA-SLOT-LADDER-RECOVERED 1>
           <TELL "By morning Mara has rewrapped the scraped palm herself. When she comes down from the Attic she rolls the injured shoulder through a careful circle, tests it twice, and finally lets the arm hang normally. The scar remains; the stiffness does not. Recovered, she says. Not erased." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-ABOUT-RECOVERY ()
    <COND (<ZERO? <MARA-GET ,MARA-SLOT-LADDER-INJURY>>
           <TELL "Mara flexes both hands. There is no Dam-ladder injury in her history to recover from." CR>)
          (<MARA-GET ,MARA-SLOT-LADDER-RECOVERED>
           <TELL "Mara turns the scarred palm upward, then rolls the once-injured shoulder without guarding it. The ladder happened, she says. The shoulder healed. Those statements are allowed to coexist." CR>)
          (T
           <TELL "Mara tests the stiff shoulder and stops before the motion becomes bravado. It is healing, she says. That is not the same as ready." CR>)>
    <RTRUE>>

<ROUTINE MARA-FRIGID-PENDULUM ()
    <COND (<NOT <EQUAL? ,HERE ,DAM-BASE>>
           <TELL "Mara considers the water and shakes her head. The useful geometry she has in mind belongs to the Dam Base, not every river in the Empire." CR>)
          (<NOT <MARA-HERE?>>
           <TELL "Mara is not here to inspect the crossing." CR>)
          (<MARA-GET ,MARA-SLOT-PENDULUM-DISCOVERED>
           <TELL "Mara glances from the overhead service pipe to the cold side channel. That arc is real now, she says. I have crossed it once; the next question is whether the same principle belongs anywhere else." CR>)
          (<AND <MARA-GET ,MARA-SLOT-LADDER-INJURY>
                <ZERO? <MARA-GET ,MARA-SLOT-LADDER-RECOVERED>>>
           <TELL "Mara measures the height of the service pipe with her eyes, then looks at her stiff shoulder. The numbers work, she says. My shoulder does not. Knowing the arc is not permission to pretend the body is ready for it." CR>)
          (<NOT <IN? ,MARA-FIELD-ROPE ,MARA>>
           <TELL "Mara studies the pipe, then the absence of her measured rope from her own custody. I can calculate a pendulum all day, she says. I cannot swing on an imaginary line." CR>)
          (T
           <MARA-PUT ,MARA-SLOT-PENDULUM-DISCOVERED 1>
           <MARA-PUT ,MARA-SLOT-PLUMMET-RECOVERED 1>
           <MOVE ,MARA-SURVEY-PLUMMET ,MARA>
           <TELL "Mara notices a small brass weight on the old maintenance lip across the narrow side channel. She measures from the landing to the overhead service pipe using the marks on her own rope, feeds a loop over the fixed iron, and tests the bracket with her full weight." CR>
           <TELL "That return arc should clear the water, she says, sounding as though she is discussing somebody else's body." CR>
           <TELL "Then she commits. Mara runs two steps, swings out over the River Frigid with both boots above the black water, lands hard on the opposite lip, snatches the brass survey plummet, and comes back on the return arc. She hits the landing in a crouch, one hand on the stone and the recovered weight clenched in the other." CR>
           <TELL "For several breaths she says nothing. Then: I knew the numbers. I did not know I could do that." CR>)>
    <RTRUE>>

<ROUTINE MARA-DEEP-CANYON-RANGING ()
    <COND (<NOT <EQUAL? ,HERE ,DEEP-CANYON>> <RFALSE>)
          (<NOT <MARA-HERE?>>
           <TELL "Mara is not here to test the canyon." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-PENDULUM-DISCOVERED>>
           <TELL "Mara studies the canyon edge as a survey problem. She has measurements, but no lived reason yet to trust herself as the moving point in them." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-PLUMMET-RECOVERED>>
           <TELL "Mara listens once, then shakes her head. A useful ranging weight would turn that echo into evidence. Right now it is only an impression." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-ACOUSTIC-DISCOVERED>>
           <MARA-PUT ,MARA-SLOT-PENDULUM-REUSED 1>
           <MARA-PUT ,MARA-SLOT-ACOUSTIC-DISCOVERED 1>
           <TELL "Mara checks the old canyon ringbolt, threads her measured rope through it, and looks down toward a lateral shelf below the stair. This part I know now, she says." CR>
           <TELL "There is no experimental pause this time. She steps off, converts the drop into a short sideways pendulum, and lands on the shelf below. From there she lets the recovered brass plummet strike the wall once." CR>
           <TELL "The note comes back twice: one hard return, then a softer answer from farther inside the stone. Mara strikes it again at a different height and goes completely still." CR>
           <TELL "When she swings back up, surprise has moved from her body to her face. I thought I was estimating, she says. I was ranging it. I've been listening to voids and galleries for years. I did not know my ear had learned the distances." CR>)
          (T
           <TELL "Mara taps the brass plummet lightly against the canyon stone and listens. The split return is familiar now. There is solid face close by and a larger hollow beyond it, she says. Useful geometry; not yet a route." CR>)>
    <RTRUE>>

<ROUTINE MARA-LOUD-RANGING ()
    <COND (<NOT <EQUAL? ,HERE ,LOUD-ROOM>> <RFALSE>)
          (<NOT <MARA-HERE?>>
           <TELL "Mara is not here to range the chamber." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-ACOUSTIC-DISCOVERED>>
           <TELL "Mara listens to the chamber but does not pretend ordinary attention is a measurement. She has not yet discovered a repeatable method here." CR>)
          (<NOT <MARA-LOUD-ROOM-SAFE?>>
           <TELL "Mara presses both hands over her ears. There is too much uncontrolled sound to range anything honestly. Make the room survivable first, she says." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-ACOUSTIC-REUSED>>
           <MARA-PUT ,MARA-SLOT-ACOUSTIC-REUSED 1>
           <TELL "Mara suspends the brass plummet from a short measured length and gives the stone one controlled strike. She turns her head rather than her body as the returns move through the now-quiet chamber." CR>
           <TELL "Again, she says, and repeats it from one pace west. This time there is no surprise. The ceiling volume is larger than the floor suggests; the west opening returns sharply and the east passage eats the higher part of the note. She writes both observations down." CR>
           <TELL "Apparently I can do this on purpose, Mara says. That is more useful than discovering it by accident." CR>)
          (T
           <TELL "Mara gives the quiet chamber one measured brass note and listens. Same asymmetry, she says. Broad volume above us; sharper return west, softer loss east. The method is repeatable." CR>)>
    <RTRUE>>

<ROUTINE MARA-ABOUT-CAPABILITY ()
    <COND (<MARA-GET ,MARA-SLOT-ACOUSTIC-REUSED>
           <TELL "Mara considers the question seriously. Survey mathematics became movement at the Frigid; movement became deliberate technique at the canyon; listening became ranging; and the Loud Room proved the ranging was repeatable. I would still call those field methods, she says. I simply had an unnecessarily narrow idea of where the field ended." CR>)
          (<MARA-GET ,MARA-SLOT-ACOUSTIC-DISCOVERED>
           <TELL "Mara touches the brass plummet through her coat. I knew I could measure a route, she says. I did not know I had trained my ear to measure empty space. I want a second controlled room before I call that a method." CR>)
          (<MARA-GET ,MARA-SLOT-PENDULUM-DISCOVERED>
           <TELL "Mara glances at her measured rope. Apparently geometry still works when I am the moving point, she says. I would like to know whether that was one successful absurdity or a reusable field technique." CR>)
          (T
           <TELL "Mara shrugs. I know what I have done, she says. I am less interested in declaring abilities than in finding out what survives contact with an actual route." CR>)>
    <RTRUE>>

<ROUTINE MARA-FIELD-CAPABILITY-ABOUT (TOPIC)
    <COND (<EQUAL? .TOPIC ,MARA-CAPABILITY-TOPIC>
           <MARA-ABOUT-CAPABILITY>
           <RTRUE>)
          (<EQUAL? .TOPIC ,MARA-RECOVERY-TOPIC>
           <MARA-ABOUT-RECOVERY>
           <RTRUE>)
          (<EQUAL? .TOPIC ,MARA-ACOUSTIC-TOPIC ,MARA-CANYON-RINGBOLT>
           <COND (<EQUAL? ,HERE ,LOUD-ROOM> <MARA-LOUD-RANGING>)
                 (<EQUAL? ,HERE ,DEEP-CANYON> <MARA-DEEP-CANYON-RANGING>)
                 (T
                  <TELL "Mara listens to the space around her. Not every echo is a measurement, she says. Give me a bounded room, an anchor, or a repeatable return." CR>)>
           <RTRUE>)
          (<EQUAL? .TOPIC ,RIVER ,GLOBAL-WATER ,MARA-SERVICE-PIPE>
           <MARA-FRIGID-PENDULUM>
           <RTRUE>)
          (<EQUAL? .TOPIC ,MARA-SURVEY-PLUMMET>
           <COND (<MARA-GET ,MARA-SLOT-PLUMMET-RECOVERED>
                  <TELL "Mara turns the old brass plummet in her palm. It was abandoned across the Frigid side channel. Recovering it taught me one thing about movement; striking it against canyon stone taught me another thing about listening." CR>)
                 (T
                  <TELL "Mara has not recovered an old survey plummet in this history." CR>)>
           <RTRUE>)>
    <RFALSE>>
