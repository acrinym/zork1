"Release 1263 Ablative Protection & Equipment Consequence."

<CONSTANT APS-CONDITION 0>
<CONSTANT APS-PREPARED 1>
<CONSTANT AP-SOUND 0>
<CONSTANT AP-SCORCHED 1>
<CONSTANT AP-WARPED 2>
<CONSTANT ABLATIVE-STATE <TABLE 0 0>>

<ROUTINE ABLATIVE-GET (SLOT)
    <GET ,ABLATIVE-STATE .SLOT>>

<ROUTINE ABLATIVE-PUT (SLOT VALUE)
    <PUT ,ABLATIVE-STATE .SLOT .VALUE>>

<ROUTINE ABLATIVE-RESET ()
    <ABLATIVE-PUT ,APS-CONDITION ,AP-SOUND>
    <ABLATIVE-PUT ,APS-PREPARED 0>
    <MOVE ,DRAGON-FIRE-SCREEN ,DRAGON-APPROACH>
    <RTRUE>>

<ROUTINE ABLATIVE-PREPARE ()
    <COND (<NOT <IN? ,DRAGON-FIRE-SCREEN ,WINNER>>
           <TELL "You need to be carrying the fire screen before it can be put between you and anything." CR>
           <RTRUE>)
          (<NOT <EQUAL? ,HERE ,DRAGON-APPROACH ,DRAGON-GALLERY>>
           <ABLATIVE-PUT ,APS-PREPARED 0>
           <TELL "You can hold the fire screen here, but bracing behind it has no present physical purpose." CR>
           <RTRUE>)
          (<EQUAL? <ABLATIVE-GET ,APS-CONDITION> ,AP-WARPED>
           <ABLATIVE-PUT ,APS-PREPARED 0>
           <TELL "You try to brace the fire screen again, but the iron rim has warped out of plane and the hide no longer covers the gap between shoulder and hip. It can still be carried. It cannot honestly be trusted as a fire barrier." CR>
           <RTRUE>)
          (<EQUAL? <ABLATIVE-GET ,APS-CONDITION> ,AP-SCORCHED>
           <ABLATIVE-PUT ,APS-PREPARED 1>
           <TELL "The hide has already shrunk and blackened, but the rim is still straight. You set your forearm into the straps and brace the scorched screen between your body and the dragon." CR>
           <RTRUE>)
          (T
           <ABLATIVE-PUT ,APS-PREPARED 1>
           <TELL "You set your forearm into the leather straps and brace the iron-bound hide screen between your body and the dragon. It is equipment, not immunity; if the fire comes, the screen will have to take what you do not." CR>
           <RTRUE>)>>

<ROUTINE ABLATIVE-DRAGON-BREATH? ()
    <COND (<ZERO? <ABLATIVE-GET ,APS-PREPARED>> <RFALSE>)
          (<NOT <IN? ,DRAGON-FIRE-SCREEN ,WINNER>>
           <ABLATIVE-PUT ,APS-PREPARED 0>
           <RFALSE>)>
    <ABLATIVE-PUT ,APS-PREPARED 0>
    <COND (<EQUAL? <ABLATIVE-GET ,APS-CONDITION> ,AP-SOUND>
           <ABLATIVE-PUT ,APS-CONDITION ,AP-SCORCHED>
           <DRAGON-PUT ,DS-WATCH 0>
           <TELL "The dragon's breath hits the braced screen like a door kicked by a furnace. The hide flashes, shrinks, and smokes while the iron rim burns your glove-hot through the straps. The blast rolls around you instead of through you. When the glare clears, you are alive and the once-sound screen is blackened and scorched." CR>
           <RTRUE>)
          (<EQUAL? <ABLATIVE-GET ,APS-CONDITION> ,AP-SCORCHED>
           <ABLATIVE-PUT ,APS-CONDITION ,AP-WARPED>
           <DRAGON-PUT ,DS-WATCH 0>
           <TELL "A second blast catches the already-shrunken hide. You crouch behind what remains while the iron rim glows, buckles, and twists under the heat. It buys you one more survival at the cost of becoming visibly warped. You are alive; the screen is no longer a trustworthy barrier." CR>
           <RTRUE>)
          (T
           <RFALSE>)>>

<ROUTINE ABLATIVE-SCREEN-F ()
    <COND (<VERB? EXAMINE>
           <COND (<EQUAL? <ABLATIVE-GET ,APS-CONDITION> ,AP-SOUND>
                  <TELL "The portable screen is a broad slab of layered hide stretched inside an iron rim, with forearm straps on the protected face. It is heavy, intact, and plainly meant to put sacrificial material between a person and brief extreme heat." CR>)
                 (<EQUAL? <ABLATIVE-GET ,APS-CONDITION> ,AP-SCORCHED>
                  <TELL "The screen's hide is blackened, blistered, and shrunken around the edges. The iron rim is heat-discolored but still straight enough to brace. It looks used, not numerically damaged." CR>)
                 (T
                  <TELL "The screen is badly warped. Its hide has burned tight and cracked, and the iron rim no longer lies in a protective plane. It records exactly what it survived, but it cannot honestly promise the same protection again." CR>)>
           <RTRUE>)>
    <RFALSE>>

<OBJECT DRAGON-FIRE-SCREEN
    (IN DRAGON-APPROACH)
    (SYNONYM SCREEN SHIELD HIDE BARRIER)
    (ADJECTIVE FIRE IRON BOUND HIDE PORTABLE)
    (DESC "iron-bound hide fire screen")
    (FLAGS TAKEBIT)
    (ACTION ABLATIVE-SCREEN-F)
    (SIZE 12)>
