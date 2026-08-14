"MARA CAUSAL BIOGRAPHY / SHARED DANGER for Release 1258"

; "Release 1258 does not introduce a general relationship score.  The routines
;   below consume named, witnessed propositions from Mara's existing history
;   and from one authored Dam-ladder incident.  Physical object custody and
;   canonical Dam hazard state remain authoritative."

<CONSTANT MARA-PROMISE-NONE 0>
<CONSTANT MARA-PROMISE-ACTIVE 1>
<CONSTANT MARA-PROMISE-KEPT 2>
<CONSTANT MARA-PROMISE-BROKEN 3>

<ROUTINE MARA-REMEMBER-IGNORED-WARNING ()
    <MARA-PUT ,MARA-SLOT-BIO-IGNORED-WARNING 1>
    <RTRUE>>

<ROUTINE MARA-LADDER-ATTEMPT ()
    <MARA-ENSURE>
    <COND (<NOT <MARA-HERE?>>
           <TELL "Mara is not here to attempt that route." CR>)
          (<NOT <EQUAL? ,HERE ,DAM-ROOM>>
           <TELL "Mara looks at the route in front of her. That is not the Dam maintenance ladder." CR>)
          (<MARA-GET ,MARA-SLOT-LADDER-PERIL>
           <TELL "Mara is already hanging just below the ladder lip. Debate can wait; a rescue cannot." CR>)
          (<MARA-GET ,MARA-SLOT-LADDER-INJURY>
           <TELL "Mara flexes the fingers of her scraped hand and shakes her head. Not again on this injury, she says. We plan the next descent instead of repeating the first one." CR>)
          (<NOT <IN? ,MARA-FIELD-ROPE ,MARA>>
           <TELL "Mara checks for her measured field rope and does not find it in her custody. I do not make this descent by pretending equipment is where it is not, she says." CR>)
          (<ZERO? <DAM-SURVIVAL-SEVERITY>>
           <MOVE ,MARA ,DAM-BASE>
           <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
           <TELL "Mara tests the first two rungs, then descends the old iron ladder under the quiet gate state. A minute later she calls up from the landing: clear." CR>)
          (T
           <MARA-PUT ,MARA-SLOT-LADDER-PERIL 1>
           <MARA-PUT ,MARA-SLOT-LADDER-INJURY 1>
           <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
           <MOVE ,MARA-FIELD-ROPE ,ADVENTURER>
           <TELL "Mara starts down the maintenance ladder with her measured rope looped for a handline. Spray slicks a lower rung. Her boot goes, one palm tears across rusted iron, and her shoulder takes the catch hard. She is left hanging just below the lip with one foot searching for purchase." CR>
           <TELL "Her field rope lands in your hands. Hold that, she says through her teeth. Get me back onto the platform. And if you are going to promise anything, promise me my rope comes back before you move." CR>)>
    <RTRUE>>

<ROUTINE V-MARA-PROMISE ()
    <MARA-ENSURE>
    <COND (<NOT <EQUAL? ,PRSO ,MARA>>
           <TELL "A promise needs a person and a specific obligation." CR>)
          (<MARA-GET ,MARA-SLOT-BIO-BROKE-PROMISE>
           <TELL "Mara looks at the rope history rather than the word. You already made this promise once and walked with my rope, she says. Another sentence does not erase the first one." CR>)
          (<AND <IN? ,MARA-FIELD-ROPE ,ADVENTURER>
                <ZERO? <MARA-GET ,MARA-SLOT-BIO-ROPE-RETURNED>>>
           <MARA-PUT ,MARA-SLOT-ROPE-PROMISE ,MARA-PROMISE-ACTIVE>
           <TELL "Mara nods once. Good. My field rope comes back to me before you leave this platform. That is the promise; not a mood, not a general declaration." CR>)
          (T
           <TELL "Mara waits. Name a promise that exists in the world, she says. There is no open rope custody to settle right now." CR>)>
    <RTRUE>>

<ROUTINE V-MARA-RESCUE ()
    <MARA-ENSURE>
    <COND (<NOT <EQUAL? ,PRSO ,MARA>>
           <TELL "That is not the person currently asking for your help." CR>)
          (<ZERO? <MARA-GET ,MARA-SLOT-LADDER-PERIL>>
           <TELL "Mara is standing under her own power. She does not require rescuing merely because the verb is available." CR>)
          (<NOT <EQUAL? ,HERE ,DAM-ROOM>>
           <TELL "You cannot rescue Mara from the Dam ladder from somewhere else." CR>)
          (<NOT <IN? ,MARA-FIELD-ROPE ,ADVENTURER>>
           <TELL "The useful end of Mara's field rope is not in your hands." CR>)
          (T
           <MARA-PUT ,MARA-SLOT-LADDER-PERIL 0>
           <MARA-PUT ,MARA-SLOT-BIO-RESCUED-MARA 1>
           <TELL "You brace against the maintenance-ladder stanchion, take Mara's field rope around your forearm, and haul while she finds a rung. She comes over the lip on one knee, breathing hard, with one palm scraped raw and her shoulder already stiffening." CR>
           <TELL "Mara looks at the rope still in your hands. That was a rescue, she says. The next fact is whether the entrusted thing comes back." CR>)>
    <RTRUE>>

<ROUTINE MARA-RETURN-ENTRUSTED-ROPE ()
    <MARA-ENSURE>
    <COND (<NOT <IN? ,MARA-FIELD-ROPE ,ADVENTURER>>
           <TELL "You are not holding Mara's field rope." CR>)
          (T
           <MOVE ,MARA-FIELD-ROPE ,MARA>
           <MARA-PUT ,MARA-SLOT-BIO-ROPE-RETURNED 1>
           <COND (<EQUAL? <MARA-GET ,MARA-SLOT-ROPE-PROMISE> ,MARA-PROMISE-ACTIVE>
                  <MARA-PUT ,MARA-SLOT-ROPE-PROMISE ,MARA-PROMISE-KEPT>
                  <TELL "You give Mara her measured field rope back before moving on. She recoils it one-handed, tests the waxed braid, and nods. Promise kept, she says. Small sentence; useful fact." CR>)
                 (<MARA-GET ,MARA-SLOT-BIO-BROKE-PROMISE>
                  <TELL "You return Mara's field rope. She takes it and checks every measured mark. Custody repaired, she says. The broken promise is still part of what happened." CR>)
                 (T
                  <TELL "You return Mara's measured field rope. She takes it without ceremony, checks the wet braid, and coils it back onto her own shoulder." CR>)>)>
    <RTRUE>>

<ROUTINE MARA-LADDER-BACKSTOP-EARNED? ()
    <COND (<MARA-GET ,MARA-SLOT-BIO-ABANDONED-PERIL> <RFALSE>)
          (<MARA-GET ,MARA-SLOT-BIO-BROKE-PROMISE> <RFALSE>)
          (<MARA-GET ,MARA-SLOT-RESTRAINT-ATTEMPTED> <RFALSE>)
          (<AND <MARA-GET ,MARA-SLOT-BIO-RESCUED-MARA>
                <MARA-GET ,MARA-SLOT-BIO-ROPE-RETURNED>
                <IN? ,MARA-FIELD-ROPE ,MARA>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-LADDER-BLOCK-REASON ()
    <COND (<MARA-GET ,MARA-SLOT-BIO-ABANDONED-PERIL>
           <TELL "Mara steps between you and the ladder. No. You walked away while I was hanging below this lip. Reduce the load or rig the real handline; I am not staking another body on your memory of that decision." CR>)
          (<MARA-GET ,MARA-SLOT-BIO-BROKE-PROMISE>
           <TELL "Mara puts one hand on the ladder rail. No. You promised my rope back before moving, then moved with it. Reduce the load or rig the real handline. I will not pretend that fact did not happen." CR>)
          (<MARA-GET ,MARA-SLOT-BIO-IGNORED-WARNING>
           <TELL "Mara catches your sleeve before you commit the overloaded descent. No. I warned you about the blue circuit and you pressed it anyway. We already know what warned-and-ignored looks like. Reduce the load or rig the real handline." CR>)
          (T
           <TELL "Mara studies the load, the spray, and the unprepared ladder. No. We have not earned improvisation at this scale. Reduce the load or rig the real handline." CR>)>
    <RTRUE>>

<ROUTINE MARA-SHARED-DANGER-HOOK ()
    <MARA-ENSURE>
    <COND (<AND <EQUAL? ,WINNER ,ADVENTURER>
                <MARA-HERE?>
                <EQUAL? ,HERE ,DAM-ROOM>
                <EQUAL? ,PRSO ,DAM-MAINTENANCE-LADDER>
                <VERB? CLIMB-DOWN CLIMB-FOO>
                <EQUAL? <DAM-SURVIVAL-SEVERITY> 2>
                <DAM-SURVIVAL-OVERBURDENED?>
                <NOT <DAM-SURVIVAL-ROPE-PREPARED?>>>
           <COND (<MARA-LADDER-BACKSTOP-EARNED?>
                  <MARA-PUT ,MARA-SLOT-BIO-MARA-RESCUED-YOU 1>
                  <MARA-PUT ,MARA-SLOT-REUNION-PENDING 1>
                  <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
                  <COND (<MARA-GET ,MARA-SLOT-BIO-IGNORED-WARNING>
                         <TELL "Mara looks from the spray to your load. I remember the blue circuit, she says. I also remember you pulling me back onto this platform and returning the exact rope I trusted to you. Go. I have the other end." CR>)
                        (T
                         <TELL "Mara tests her measured rope and plants herself behind the stanchion. You returned the other end when it mattered, she says. Go. I have this one." CR>)>
                  <TELL "You start down overloaded. A sheet of sluice spray takes one boot off the rung. Mara's rope goes hard across your chest before the fall can gather distance. She gives line only when you have iron under both feet again, and you reach the landing bruised, soaked, and alive." CR CR>
                  <GOTO ,DAM-BASE>
                  <RTRUE>)
                 (T
                  <MARA-LADDER-BLOCK-REASON>
                  <RTRUE>)>)>
    <RFALSE>>

<ROUTINE MARA-CAUSAL-AFTER-MOVE (FROM TO)
    ;"A promise can be broken by movement, and abandoning a person in active
      peril remains a separate fact even when no promise was made."
    <COND (<AND <NOT <EQUAL? .FROM .TO>>
                <EQUAL? <LOC ,MARA> .FROM>
                <IN? ,MARA-FIELD-ROPE ,ADVENTURER>>
           <COND (<MARA-GET ,MARA-SLOT-LADDER-PERIL>
                  <MARA-PUT ,MARA-SLOT-LADDER-PERIL 0>
                  <MARA-PUT ,MARA-SLOT-BIO-ABANDONED-PERIL 1>
                  <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
                  <TELL "Behind you, iron rings against iron. Mara has to drag herself back over the ladder lip without the rope now leaving in your hands. She says nothing after that." CR>)>
           <COND (<EQUAL? <MARA-GET ,MARA-SLOT-ROPE-PROMISE> ,MARA-PROMISE-ACTIVE>
                  <MARA-PUT ,MARA-SLOT-ROPE-PROMISE ,MARA-PROMISE-BROKEN>
                  <MARA-PUT ,MARA-SLOT-BIO-BROKE-PROMISE 1>
                  <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-WAITING>
                  <TELL "Mara's voice follows you from the platform. That was the promise, she says. The rope was supposed to come back before you moved." CR>)>)>
    <RFALSE>>

<ROUTINE MARA-CAUSAL-ADVANCE ()
    <COND (<AND <MARA-GET ,MARA-SLOT-REUNION-PENDING>
                <EQUAL? <LOC ,MARA> ,DAM-ROOM>
                <EQUAL? ,HERE ,DAM-BASE>>
           <MARA-PUT ,MARA-SLOT-REUNION-PENDING 0>
           <MARA-PUT ,MARA-SLOT-PRIVATE-LADDER-DISCOVERY 1>
           <MOVE ,MARA ,DAM-BASE>
           <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-FOLLOWING>
           <TELL "A measured tug passes through Mara's rope above. A little later she comes down the maintenance ladder under her own control. Halfway down she stops at one lower retaining bolt, studies something for several breaths, and continues. She steps onto the landing beside you without volunteering what caught her attention." CR>)>
    <RFALSE>>

<ROUTINE MARA-ABOUT-LADDER ()
    <COND (<EQUAL? <MARA-GET ,MARA-SLOT-PRIVATE-LADDER-DISCOVERY> 1>
           <MARA-PUT ,MARA-SLOT-PRIVATE-LADDER-DISCOVERY 2>
           <TELL "On the way down after I caught you, I found an old survey punch under the lower retaining bolt, Mara says. It predates the replacement iron but postdates the official map's claim that this access was abandoned. Someone maintained this route after the record said it was dead. I wanted to check the mark before turning a glimpse into testimony." CR>)
          (<EQUAL? <MARA-GET ,MARA-SLOT-PRIVATE-LADDER-DISCOVERY> 2>
           <TELL "The lower retaining bolt still carries that old survey punch, Mara says. It is evidence that somebody maintained the Dam access after the official route record says they stopped." CR>)
          (<MARA-GET ,MARA-SLOT-BIO-MARA-RESCUED-YOU>
           <TELL "The ladder is old iron, wet under discharge, and now part of our history in both directions, Mara says. You pulled me back once. I caught you once. Neither fact makes the next descent automatically safe." CR>)
          (<MARA-GET ,MARA-SLOT-BIO-RESCUED-MARA>
           <TELL "Mara flexes her injured hand. The ladder has already collected one bad assumption from me, she says. The useful fact is that you pulled me back instead of treating the slip as scenery." CR>)
          (T
           <TELL "Mara studies the maintenance ladder as structure rather than invitation. Old bolts, wet iron, poor redundancy, she says. Preparation first." CR>)>
    <RTRUE>>
