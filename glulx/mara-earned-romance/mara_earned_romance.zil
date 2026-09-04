"MARA EARNED ROMANCE AND PARTNERSHIP for Release 1306"

; "Named witnessed events decide whether two people may choose each other.
   MARA-SLOT-TRUST / RESPECT / SAFETY are never read here. Friendship without
   romance remains complete. Refusal is honored. No meter, dating sim, or
   gift grind."

<SYNTAX ASK OBJECT TO STAY = V-MARA-ASK-STAY>
<SYNTAX ASK OBJECT TO REMAIN = V-MARA-ASK-STAY>
<SYNTAX ASK OBJECT TO PARTNER = V-MARA-ASK-STAY>
<SYNTAX STAY = V-MARA-ASK-STAY>
<SYNTAX REMAIN = V-MARA-ASK-STAY>
<SYNTAX REFUSE OBJECT = V-MARA-PLAYER-REFUSE>
<SYNONYM PARTNER PARTNERSHIP>

<OBJECT MARA-ROMANCE-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM ROMANCE LOVE COURTSHIP AFFECTION)
    (ADJECTIVE MUTUAL CHOSEN EARNED)
    (DESC "romance")
    (FLAGS NDESCBIT RMUNGBIT)>

<ROUTINE MARA-EARNED-HISTORY? ()
    <COND (<MARA-RUPTURE-OPEN?> <RFALSE>)>
    <COND (<OR <MARA-GET ,MARA-SLOT-MEAL-SHARED>
               <MARA-GET ,MARA-SLOT-DAM-SURVEY>
               <MARA-RECIPROCAL-DANGER-HISTORY?>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-PARTNERSHIP-ON? ()
    <COND (<MARA-GET ,MARA-SLOT-PARTNERSHIP-ACCEPTED> <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-PLACE-FOR-CHOICE? ()
    <COND (<EQUAL? ,HERE ,WEST-OF-HOUSE ,NORTH-OF-HOUSE ,SOUTH-OF-HOUSE
                        ,EAST-OF-HOUSE ,BEHIND-HOUSE ,LIVING-ROOM
                        ,KITCHEN ,ATTIC ,DAM-ROOM ,DAM-BASE ,DAM-LOBBY>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-ABOUT-PARTNERSHIP ()
    <COND (<MARA-RUPTURE-OPEN?>
           <TELL "Mara's voice stays even. Distance is still the current fact. Partnership is not a way around that." CR>)
          (<MARA-GET ,MARA-SLOT-PARTNERSHIP-REFUSED>
           <TELL "I already answered, Mara says. Friendship, if you keep it honest, is still available. Romance is not." CR>)
          (<MARA-PARTNERSHIP-ON?>
           <TELL "We chose this, Mara says. That does not erase the ladder, the rope, the meal, or the times I was angry. It means I am still here on purpose." CR>)
          (<MARA-GET ,MARA-SLOT-PARTNERSHIP-POSTPONED>
           <TELL "Not no forever, Mara says. Not yes tonight. Keep working. I will say when the question is timely." CR>)
          (<MARA-EARNED-HISTORY?>
           <TELL "We have a history that is not a score, Mara says. If you ask, I will answer as myself, not as a reward." CR>)
          (T
           <TELL "We have not yet done the work that would make that question honest, Mara says." CR>)>
    <RTRUE>>

<ROUTINE MARA-EARNED-ROMANCE-FCN ()
    <MARA-ENSURE>
    <COND (<NOT <EQUAL? ,PRSO ,MARA>> <RFALSE>)>
    <COND (<VERB? EXAMINE>
           <MARA-EXAMINE-PERSON>
           <RTRUE>)
          (<VERB? KISS RUB>
           <MARA-PHYSICAL-OFFER>
           <RTRUE>)
          (<VERB? HELLO>
           <TELL "Mara answers in her own time. She is not a prompt waiting to be filled." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-EXAMINE-PERSON ("AUX" N)
    <SET N <+ <MARA-GET ,MARA-SLOT-EXAMINE-COUNT> 1>>
    <MARA-PUT ,MARA-SLOT-EXAMINE-COUNT .N>
    <COND (<MARA-RUPTURE-OPEN?>
           <TELL "Mara keeps her distance. You can see she is unhurt only in the sense that she will not let you close enough to check." CR>)
          (<L? .N 2>
           <TELL "Mara is a specific person: travel-worn, watchful, with a surveyor's patience and a mouth that has already told you the truth once today. She is not scenery." CR>)
          (<AND <EQUAL? .N 3>
                <MARA-EARNED-HISTORY?>
                <ZERO? <MARA-GET ,MARA-SLOT-PARTNERSHIP-REFUSED>>
                <ZERO? <MARA-GET ,MARA-SLOT-PARTNERSHIP-ACCEPTED>>
                <ZERO? <MARA-GET ,MARA-SLOT-MARA-OFFERED>>>
           <MARA-PUT ,MARA-SLOT-MARA-OFFERED 1>
           <TELL "Mara speaks first. If you want a partner and not a convenient witness, she says, you will have to say so. I will not invent a yes you never asked for, and I will not pretend I cannot ask." CR>)
          (T
           <TELL "Mara turns her shoulder a fraction. That is enough looking, she says. I will look back when I choose to, not when you rehearse it." CR>
           <MARA-PUT ,MARA-SLOT-LOOKED-BACK 1>)>
    <COND (<AND <G? .N 1> <MARA-HERE?> <ZERO? <MARA-GET ,MARA-SLOT-MARA-LOOKED>>>
           <MARA-PUT ,MARA-SLOT-MARA-LOOKED 1>
           <TELL "She studies your hands and the dirt on your sleeves the way she studies a route. I remember what you did with them, she says." CR>)>
    <RTRUE>>

<ROUTINE MARA-PHYSICAL-OFFER ()
    <MARA-PUT ,MARA-SLOT-PLAYER-OFFERED 1>
    <COND (<MARA-RUPTURE-OPEN?>
           <TELL "Mara steps out of reach. You do not get to rewrite an attack as affection." CR>)
          (<MARA-GET ,MARA-SLOT-PARTNERSHIP-REFUSED>
           <TELL "No, Mara says, without heat. I already chose not to. Do not make me spend the word twice." CR>)
          (<NOT <MARA-EARNED-HISTORY?>>
           <TELL "Mara's hand does not rise to meet yours. We have not yet earned that kind of closeness, she says. Work first." CR>)
          (<MARA-GET ,MARA-SLOT-PARTNERSHIP-POSTPONED>
           <TELL "She lets the attempt pass without insult. Not yet, she says. That is still the answer." CR>)
          (<MARA-PARTNERSHIP-ON?>
           <TELL "Mara answers in kind, briefly, then looks past your shoulder at the room. That remains a choice, she says, not a habit that deletes the rest of the empire." CR>)
          (T
           <TELL "Mara does not flinch, and she does not automatically agree. If you are asking, ask in words I can refuse." CR>)>
    <RTRUE>>

<ROUTINE V-MARA-ASK-STAY ()
    <COND (<AND <NOT ,PRSO> <MARA-HERE?>>
           <SETG PRSO ,MARA>)>
    <COND (<NOT <EQUAL? ,PRSO ,MARA>>
           <TELL "That person is not Mara, and this is not a roster." CR>
           <RFATAL>)>
    <MARA-ENSURE>
    <MARA-PUT ,MARA-SLOT-PLAYER-OFFERED 1>
    <COND (<MARA-RUPTURE-OPEN?>
           <TELL "Stay is not available while I am keeping distance from you, Mara says." CR>)
          (<MARA-GET ,MARA-SLOT-PARTNERSHIP-REFUSED>
           <TELL "I refused the partnership. I did not refuse to remain a colleague when the work is real." CR>)
          (<NOT <MARA-EARNED-HISTORY?>>
           <TELL "Ask me after we have a history that is more than proximity, Mara says." CR>)
          (<MARA-PARTNERSHIP-ON?>
           <TELL "I already said yes. Repeating the ceremony does not make the empire safer." CR>)
          (<MARA-PLACE-FOR-CHOICE?>
           <MARA-ACCEPT-OR-WEIGH>)
          (T
           <TELL "Not in this room, Mara says. If we are going to choose each other, it will not be as a puzzle skip." CR>)>
    <RFATAL>>

<ROUTINE V-MARA-PLAYER-REFUSE ()
    <COND (<NOT <OR <EQUAL? ,PRSO ,MARA> <EQUAL? ,PRSO ,MARA-ROMANCE-TOPIC> <EQUAL? ,PRSO ,MARA-COMPANY-TOPIC>>>
           <TELL "Refuse that some other way. This word is for the partnership question." CR>
           <RFATAL>)>
    <MARA-ENSURE>
    <MARA-PUT ,MARA-SLOT-PLAYER-OFFERED 1>
    <COND (<MARA-PARTNERSHIP-ON?>
           <TELL "You already chose. Ending that is a later conversation, not a parser undo." CR>)
          (T
           <MARA-REFUSE-PARTNERSHIP>)>
    <RFATAL>>

<ROUTINE MARA-ACCEPT-OR-WEIGH ()
    <COND (<AND <MARA-RECIPROCAL-DANGER-HISTORY?>
                <MARA-GET ,MARA-SLOT-MEAL-SHARED>>
           <MARA-ACCEPT-PARTNERSHIP>)
          (<MARA-EARNED-HISTORY?>
           <MARA-PUT ,MARA-SLOT-PARTNERSHIP-POSTPONED 1>
           <TELL "Mara looks at the work still unfinished. Not tonight, she says. I am not a prize for surviving one chapter. Ask again when we are both still choosing the same expedition." CR>)
          (T
           <TELL "No, Mara says. That is the whole sentence." CR>
           <MARA-PUT ,MARA-SLOT-PARTNERSHIP-REFUSED 1>)>
    <RTRUE>>

<ROUTINE MARA-ACCEPT-PARTNERSHIP ()
    <MARA-PUT ,MARA-SLOT-PARTNERSHIP-ACCEPTED 1>
    <MARA-PUT ,MARA-SLOT-PARTNERSHIP-POSTPONED 0>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-FOLLOWING>
    <TELL "Yes, Mara says, as if the word had weight. Not because a hidden number filled up. Because we have already carried rope, meals, and the truth of getting hurt for each other. I will travel as your partner. I can still refuse a stupid descent." CR>
    <COND (<AND <IN? ,MARA-FIELD-PACK ,WINNER>
                <NOT <IN? ,MARA-FIELD-PACK ,MARA>>>
           <TELL "She glances at her pack in your hands. If we are partners, that still belongs to me unless I handed it over." CR>)>
    <RTRUE>>

<ROUTINE MARA-REFUSE-PARTNERSHIP ()
    <MARA-PUT ,MARA-SLOT-PARTNERSHIP-REFUSED 1>
    <MARA-PUT ,MARA-SLOT-PLAYER-OFFERED 1>
    <TELL "No, Mara says. I will still survey. I will still tell you when the ladder is lying. I will not become your romance because you asked on schedule." CR>
    <RTRUE>>

<ROUTINE MARA-PARTNERSHIP-DANGER-HOOK ()
    <COND (<AND <MARA-PARTNERSHIP-ON?>
                <MARA-HERE?>
                <EQUAL? ,HERE ,CELLAR>
                <NOT <FSET? ,HERE ,ONBIT>>
                <NOT <FSET? ,LAMP ,ONBIT>>>
           <TELL "Mara's hand finds the damp stone. Partners do not pretend the dark is cosmetic, she says. Light, or we go back." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-EARNED-ROMANCE-ABOUT (TOPIC)
    <COND (<EQUAL? .TOPIC ,MARA-ROMANCE-TOPIC>
           <MARA-ABOUT-PARTNERSHIP>
           <RTRUE>)
          (<AND <EQUAL? .TOPIC ,MARA-COMPANY-TOPIC>
                <OR <MARA-EARNED-HISTORY?>
                    <MARA-PARTNERSHIP-ON?>
                    <MARA-GET ,MARA-SLOT-PARTNERSHIP-REFUSED>
                    <MARA-GET ,MARA-SLOT-PARTNERSHIP-POSTPONED>
                    <MARA-GET ,MARA-SLOT-MARA-OFFERED>
                    <MARA-GET ,MARA-SLOT-PLAYER-OFFERED>>>
           <MARA-ABOUT-PARTNERSHIP>
           <RTRUE>)>
    <RFALSE>>
