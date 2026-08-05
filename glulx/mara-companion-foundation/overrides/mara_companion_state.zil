<ROUTINE MARA-GET (SLOT)
    <GET ,MARA-STATE .SLOT>>

<ROUTINE MARA-PUT (SLOT VALUE)
    <PUT ,MARA-STATE .SLOT .VALUE>>

<ROUTINE MARA-ENSURE ()
    <COND (<NOT <EQUAL? <GET ,MARA-STATE 0> ,MARA-SCHEMA>>
           <PUT ,MARA-STATE 0 ,MARA-SCHEMA>
           <MARA-PUT ,MARA-SLOT-MET 0>
           <MARA-PUT ,MARA-SLOT-TRUST 0>
           <MARA-PUT ,MARA-SLOT-LAST-EVIDENCE 0>
           <MARA-PUT ,MARA-SLOT-RESPECT 0>
           <MARA-PUT ,MARA-SLOT-SAFETY 0>
           <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-INDEPENDENT>
           <MARA-PUT ,MARA-SLOT-DAM-BRACED 0>
           <MARA-PUT ,MARA-SLOT-DAM-CYCLED 0>
           <MARA-PUT ,MARA-SLOT-DAM-SURVEY 0>
           <MARA-PUT ,MARA-SLOT-LEAK-WARNED 0>
           <MARA-PUT ,MARA-SLOT-LEAK-CAUSED 0>
           <MARA-PUT ,MARA-SLOT-LEAK-REPAIRED 0>
           <MARA-PUT ,MARA-SLOT-APOLOGY 0>
           <MARA-PUT ,MARA-SLOT-THANKED 0>
           <MARA-PUT ,MARA-SLOT-EVIDENCE-SHARED 0>
           <MARA-PUT ,MARA-SLOT-FISH-WITNESSED 0>
           <MARA-PUT ,MARA-SLOT-FISH-RELEASED 0>
           <MARA-PUT ,MARA-SLOT-HOUSE-VISITED 0>)>
    <COND (<NOT <LOC ,MARA-FIELD-ROPE>> <MOVE ,MARA-FIELD-ROPE ,MARA>)>
    <COND (<NOT <LOC ,MARA-FIELD-LANTERN>> <MOVE ,MARA-FIELD-LANTERN ,MARA>)>
    <RFALSE>>

<ROUTINE MARA-INCREASE (SLOT LIMIT "AUX" VALUE)
    <SET VALUE <MARA-GET .SLOT>>
    <COND (<L? .VALUE .LIMIT>
           <MARA-PUT .SLOT <+ .VALUE 1>>)>
    <RTRUE>>

<ROUTINE MARA-DECREASE (SLOT LIMIT "AUX" VALUE)
    <SET VALUE <MARA-GET .SLOT>>
    <COND (<G? .VALUE .LIMIT>
           <MARA-PUT .SLOT <- .VALUE 1>>)>
    <RTRUE>>

<ROUTINE MARA-HERE? ()
    <COND (<EQUAL? <LOC ,MARA> ,HERE> <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-DAM-REGION? (RM)
    <COND (<EQUAL? .RM ,DAM-BASE ,DAM-ROOM ,DAM-LOBBY ,MAINTENANCE-ROOM>
           <RTRUE>)
          (<EQUAL? .RM ,RESERVOIR-SOUTH ,DEEP-CANYON>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-HOUSE-ROUTE? (RM)
    <COND (<EQUAL? .RM ,NS-PASSAGE ,ROUND-ROOM ,EW-PASSAGE ,TROLL-ROOM>
           <RTRUE>)
          (<EQUAL? .RM ,CELLAR ,LIVING-ROOM ,KITCHEN ,ATTIC>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-CAN-ENTER? (RM)
    <COND (<AND <EQUAL? .RM ,MAINTENANCE-ROOM>
                <G? ,WATER-LEVEL 0>>
           <RFALSE>)
          (<AND <EQUAL? .RM ,TROLL-ROOM>
                <IN? ,TROLL ,TROLL-ROOM>>
           <RFALSE>)
          (<MARA-DAM-REGION? .RM> <RTRUE>)
          (<AND <MARA-GET ,MARA-SLOT-DAM-SURVEY>
                <MARA-HOUSE-ROUTE? .RM>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-MEET ()
    <MARA-ENSURE>
    <COND (<ZERO? <MARA-GET ,MARA-SLOT-MET>>
           <MARA-PUT ,MARA-SLOT-MET 1>
           <TELL "The woman closes a waxed survey book around one finger. Mara Tallow, she says. Field surveyor. I am reconstructing the Last Honest Survey of the Great Underground Empire, which means finding where the official maps began lying. This dam is currently giving testimony." CR>)
          (<AND <MARA-GET ,MARA-SLOT-LEAK-CAUSED>
                <ZERO? <MARA-GET ,MARA-SLOT-LEAK-REPAIRED>>>
           <TELL "Mara listens to the water behind the wall. Conversation can wait until the pipe stops trying to become a river." CR>)
          (<MARA-GET ,MARA-SLOT-DAM-SURVEY>
           <TELL "Mara touches the joint survey sheet inside her coat. The Dam entry is honest, she says. That is rarer than it sounds. When our routes overlap, ask me to come; when they do not, I still have work of my own." CR>)
          (<MARA-GET ,MARA-SLOT-DAM-CYCLED>
           <TELL "Mara studies the changed pressure in the stone. We have the mechanism, she says. Now we measure what it actually did." CR>)
          (T
           <TELL "Mara glances from the river to the dam face. Diagnose the mechanism, let me brace the panel, and we can make one trustworthy record between us." CR>)>
    <RTRUE>>

<ROUTINE MARA-ABOUT (TOPIC)
    <MARA-ENSURE>
    <COND (<EQUAL? .TOPIC ,MARA-SURVEY-TOPIC ,MAP>
           <COND (<MARA-GET ,MARA-SLOT-DAM-SURVEY>
                  <TELL "The joint Dam sheet is one surviving piece of the Last Honest Survey, Mara says. The official map records a stable machine. The stone, gates, scars, and water disagree." CR>)
                 (T
                  <TELL "The Last Honest Survey was the final route record made before imperial embarrassment became cartography, Mara says. She needs measurements, witnessed mechanisms, and evidence that cannot be corrected by decree." CR>)>)
          (<EQUAL? .TOPIC ,MARA-COMPANY-TOPIC>
           <COND (<MARA-GET ,MARA-SLOT-DAM-SURVEY>
                  <TELL "We are expedition partners where we have made a plan together, Mara says. That is company, not ownership. Ask me to follow; accept that I may refuse a route." CR>)
                 (T
                  <TELL "Working beside someone once is circumstance, Mara says. Keeping faith through the dangerous part is where company begins." CR>)>)
          (<EQUAL? .TOPIC ,MARA-DAM-TOPIC ,DAM ,CONTROL-PANEL ,BOLT>
           <COND (<MARA-GET ,MARA-SLOT-DAM-SURVEY>
                  <TELL "Flood Control Dam #3 is mechanically functional, structurally neglected, and historically misreported, Mara says. The joint sheet records the gate state we physically witnessed." CR>)
                 (<MARA-GET ,MARA-SLOT-DAM-CYCLED>
                  <TELL "The interlock and bolt are genuine, Mara says. We have changed the gates together; the remaining work is to survey the result instead of merely admiring it." CR>)
                 (T
                  <TELL "The yellow circuit arms the bolt and the brown circuit disarms it, Mara says. She will brace the control panel while you turn the real wrench, but she will not pretend the blue pipe circuit looks trustworthy." CR>)>)
          (<EQUAL? .TOPIC ,MUSEUM-CATALOG-OBJECT>
           <TELL "A museum can preserve evidence or embalm a lie, Mara says. She is willing to document what she personally handles, but she is not its curator and does not surrender her survey merely because a plaque is available." CR>)
          (<EQUAL? .TOPIC ,DAM-SILVERFIN ,MUSEUM-AQUATIC-GALLERY-OBJECT>
           <COND (<MARA-GET ,MARA-SLOT-FISH-RELEASED>
                  <TELL "The silverfin record is stronger because the animal survived it, Mara says. A field note does not require a corpse to become official." CR>)
                 (<MARA-GET ,MARA-SLOT-FISH-WITNESSED>
                  <TELL "The silverfin's body matches the current it came from, Mara says. Observe the tail and flank before deciding whether a display case deserves the living evidence." CR>)
                 (T
                  <TELL "The River Frigid should be observed before it is harvested, Mara says. Water writes changes into living things more honestly than engineers write reports." CR>)>)
          (<EQUAL? .TOPIC ,WHITE-HOUSE>
           <COND (<MARA-GET ,MARA-SLOT-HOUSE-VISITED>
                  <TELL "The House is a base with the alarming habit of becoming a life, Mara says. She noticed the archive, the kitchen, the damage, and the fact that you returned to it rather than merely storing treasure there." CR>)
                 (<MARA-GET ,MARA-SLOT-DAM-SURVEY>
                  <TELL "You have described a House above the old routes, Mara says. Finish this survey honestly and she will consider seeing whether it is a base or another legend with furniture." CR>)
                 (T
                  <TELL "Mara has no earned knowledge of your House yet. She does not promote a claim to geography merely because someone says it confidently." CR>)>)
          (<EQUAL? .TOPIC ,MARA ,ME>
           <TELL "Mara is a route historian by vocation and a field surveyor by necessity. Her work predates meeting you and will continue whenever your routes divide." CR>)
          (<AND .TOPIC
                <EQUAL? .TOPIC <MARA-GET ,MARA-SLOT-LAST-EVIDENCE>>>
           <TELL "That one Mara knows because she held it. It was ">
           <MUSEUM-PROVENANCE .TOPIC>
           <TELL "." CR>)
          (T
           <TELL "Mara cannot honestly claim that history yet. Let her witness it, measure it, read it, or hold the evidence first." CR>)>
    <RTRUE>>
