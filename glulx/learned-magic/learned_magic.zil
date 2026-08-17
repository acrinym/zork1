"Release 1266 learned magic as parser capability."

;"A deliberately small knowledge-to-capability layer. The Adventurer can only
  perform the stilling ward after reconstructing and then studying the damaged
  black-book material. The ward composes with exact authored candle wetness and
  canonical hot-bell cooldown; it is not a spell inventory or generic magic engine."

<SYNTAX STUDY OBJECT (FIND READBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE) = V-LEARNED-STUDY>
<SYNTAX WARD OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-LEARNED-WARD>
<SYNTAX KNOWLEDGE = V-LEARNED-KNOWLEDGE>
<SYNONYM KNOWLEDGE LORE>

<CONSTANT LM-STILLING-KNOWN 0>
<CONSTANT LM-UNTaught-FAIL 1>
<CONSTANT LM-CANDLES-DRIED 2>
<CONSTANT LM-HOT-BELL-COOLED 3>
<CONSTANT LEARNED-MAGIC-STATE <TABLE 0 0 0 0>>

<ROUTINE LEARNED-MAGIC-GET (SLOT)
    <GET ,LEARNED-MAGIC-STATE .SLOT>>

<ROUTINE LEARNED-MAGIC-PUT (SLOT VALUE)
    <PUT ,LEARNED-MAGIC-STATE .SLOT .VALUE>>

<ROUTINE LEARNED-MAGIC-TRUE? (SLOT)
    <COND (<G? <LEARNED-MAGIC-GET .SLOT> 0> <RTRUE>)>
    <RFALSE>>

<ROUTINE V-LEARNED-STUDY ()
    <COND (<NOT <EQUAL? ,PRSO ,BOOK>>
           <TELL "You study the " D ,PRSO " carefully, but it teaches no ritual technique." CR>
           <RTRUE>)
          (<NOT ,RITUAL-CEREMONY-KNOWN>
           <TELL "Page 569 gives you a prayer, not a method. The compressed damaged leaves near the binding need to be reconstructed before their marginal notation means enough to learn." CR>
           <RTRUE>)
          (<LEARNED-MAGIC-TRUE? ,LM-STILLING-KNOWN>
           <TELL "You review the damaged notation. The stilling ward is already yours: a short binding gesture meant to settle one carried condition in one exact object, not a license to improvise arbitrary magic." CR>
           <RTRUE>)>
    <LEARNED-MAGIC-PUT ,LM-STILLING-KNOWN 1>
    <TELL "With the ceremonial order understood, a cramped marginal gloss finally resolves into a separate technique. You trace its short binding gesture, match the written cadence under your breath, and memorize the stilling ward: a bounded way to settle heat in the ceremonial bell or excess water held in the ritual candle wicks. The notation promises nothing broader." CR>
    <RTRUE>>

<ROUTINE V-LEARNED-KNOWLEDGE ()
    <COND (<NOT <LEARNED-MAGIC-TRUE? ,LM-STILLING-KNOWN>>
           <TELL "You have reconstructed ritual sequence, perhaps, but you have not deliberately learned a reusable magical technique. STUDY the damaged black-book material after you understand it." CR>)
          (T
           <TELL "Learned technique: stilling ward. It can settle the authored heat of the red-hot ceremonial bell or dry the real ritual candles when their wicks are waterlogged. It does not light candles, repair spent objects, attack creatures, protect arbitrary rooms, or complete the Hades ceremony for you." CR>)>
    <RTRUE>>

<ROUTINE V-LEARNED-WARD ()
    <COND (<NOT <LEARNED-MAGIC-TRUE? ,LM-STILLING-KNOWN>>
           <LEARNED-MAGIC-PUT ,LM-UNTaught-FAIL 1>
           <TELL "You can make a solemn gesture at the " D ,PRSO ", but solemnity is not technique. You have not learned a ward precise enough to change anything." CR>
           <RTRUE>)
          (<EQUAL? ,PRSO ,CANDLES>
           <COND (<FSET? ,CANDLES ,RMUNGBIT>
                  <TELL "The candles are physically spent. The stilling ward settles a condition; it does not restore consumed wax." CR>)
                 (<CONSUMABLE-CANDLES-WET?>
                  <CONSUMABLE-LIGHT-PUT ,CL-CANDLE-WET 0>
                  <LEARNED-MAGIC-PUT ,LM-CANDLES-DRIED 1>
                  <TELL "You bind the stilling gesture around the paired wicks. The visible water draws out of the fibers in a cold sheen and vanishes into the surrounding air, leaving the wicks dry enough to accept flame again. They remain unlit." CR>)
                 (T
                  <TELL "The candle wicks carry no excess water for the stilling ward to settle. Nothing changes." CR>)>
           <RTRUE>)
          (<EQUAL? ,PRSO ,HOT-BELL>
           <LEARNED-MAGIC-PUT ,LM-HOT-BELL-COOLED 1>
           <TELL "You close the learned gesture over the red-hot bell. Its thin residual ringing drops away first; the shimmer above the brass follows." CR>
           <QUEUE I-XBH 0>
           <I-XBH>
           <RTRUE>)
          (<EQUAL? ,PRSO ,BELL>
           <TELL "The brass bell is already cool. The stilling ward has no authored heat left to settle." CR>
           <RTRUE>)
          (T
           <TELL "Your learned ward is not a generic enchantment. The " D ,PRSO " has no authored heat or waterlogged ritual condition that this technique can affect." CR>
           <RTRUE>)>>
