"Focused ritual resonance for the repository-local Zork I Glulx lineage."

;"This layer makes the canonical bell, candle, and black-book ceremony legible
  through physical observation, persistent memory, and safe object combinations.
  It never advances the exorcism except through the original LLD-ROOM state
  machine and its real bell, candles, book, timers, and ghost-removal logic."

<SYNTAX CEREMONY = V-RITUAL-CEREMONY>
<SYNONYM CEREMONY RITE RITUAL>

<GLOBAL RITUAL-CEREMONY-KNOWN <>>
<GLOBAL RITUAL-BELL-RESONANCE-HEARD <>>
<GLOBAL RITUAL-BELL-ANSWERED <>>
<GLOBAL RITUAL-CANDLES-ANSWERED <>>
<GLOBAL RITUAL-PRAYER-COMPLETED <>>
<GLOBAL RITUAL-MIRROR-RESONANCE <>>
<GLOBAL RITUAL-HOT-BELL-COOLED <>>
<GLOBAL RITUAL-WRONG-ORDER-SEEN <>>

<ROUTINE RITUAL-BELL-CONTEXT ()
	<COND (<EQUAL? ,HERE ,NORTH-TEMPLE ,SOUTH-TEMPLE>
	       <TELL "The note hangs between the temple stones longer than ordinary acoustics permit." CR>)
	      (<EQUAL? ,HERE ,MIRROR-ROOM-1 ,MIRROR-ROOM-2>
	       <SETG RITUAL-MIRROR-RESONANCE T>
	       <SETG SHADOW-MIRROR-DIAGNOSED T>
	       <TELL "The mirror returns the bell's note a fraction late. Your reflected hand lowers after yours does." CR>)
	      (<EQUAL? ,HERE ,DAM-ROOM ,MAINTENANCE-ROOM>
	       <TELL "The bell's clear note finds a lower answer in the dam's buried machinery, then fades without operating it." CR>)
	      (T
	       <TELL "The note fades normally, which is almost suspicious after everything else." CR>)>>

<ROUTINE RITUAL-BELL-F ()>
	<COND (<VERB? EXAMINE DIAGNOSE>
	       <TELL "The small brass bell is cool enough to hold. Its rim is worn unevenly, as though one particular note mattered more than all the others." CR>
	       <RTRUE>)
	      (<VERB? LISTEN>
	       <TELL "Unrung, the bell contains only the faint metallic hush of an object waiting for a room with better acoustics." CR>
	       <RTRUE>)
	      (<VERB? RING>
	       <COND (<AND <EQUAL? ,HERE ,ENTRANCE-TO-HADES>
	                   <NOT ,LLD-FLAG>>
	              <RFALSE>)
	             (T
	              <SETG RITUAL-BELL-RESONANCE-HEARD T>
	              <BELL-F>
	              <RITUAL-BELL-CONTEXT>
	              <RTRUE>)>)>
	<BELL-F>>

<ROUTINE RITUAL-HOT-BELL-F ()>
	<COND (<VERB? EXAMINE DIAGNOSE>
	       <TELL "The bell is red hot. Heat shimmers above it, but the metal still carries a faint vibration from the note that began the ceremony." CR>
	       <RTRUE>)
	      (<VERB? LISTEN>
	       <TELL "A thin, almost inaudible ringing persists inside the heated metal." CR>
	       <RTRUE>)>
	<HOT-BELL-F>>

<ROUTINE RITUAL-BLACK-BOOK-F ()>
	<COND (<OR <VERB? TURN>
	           <AND <VERB? READ-PAGE>
	                <EQUAL? ,PRSI ,INTNUM>
	                <NOT <EQUAL? ,P-NUMBER 569>>>>
	       <SETG RITUAL-CEREMONY-KNOWN T>
	       <BLACK-BOOK>
	       <TELL "The surviving marginal marks suggest an order: resonance first, paired light second, spoken prayer last. They do not identify the objects for you." CR>
	       <RTRUE>)
	      (<VERB? EXAMINE>
	       <TELL "The black book is fixed open to page 569. ">
	       <COND (,RITUAL-CEREMONY-KNOWN
	              <TELL "You have also identified a damaged ceremonial page whose sequence is clearer than its vocabulary.">)
	             (T
	              <TELL "Several compressed leaves near the binding suggest that another damaged page may still be legible.">)>
	       <CRLF>
	       <RTRUE>)
	      (<VERB? LISTEN>
	       <TELL "The book is silent, but the cavern seems uncomfortably prepared to repeat anything read aloud." CR>
	       <RTRUE>)>
	<BLACK-BOOK>>

<ROUTINE RITUAL-CANDLES-F ()>
	<COND (<VERB? EXAMINE DIAGNOSE>
	       <TELL "The pair of candles is ">
	       <COND (<FSET? ,CANDLES ,RMUNGBIT>
	              <TELL "spent beyond useful relighting">)
	             (<FSET? ,CANDLES ,ONBIT>
	              <TELL "burning with two separate flames that lean subtly toward one another">)
	             (<FSET? ,CANDLES ,TOUCHBIT>
	              <TELL "dark, shortened, and still marked by prior burning">)
	             (T
	              <TELL "unlit and nearly unused">)>
	       <TELL "." CR>
	       <RTRUE>)
	      (<VERB? LISTEN>
	       <COND (<FSET? ,CANDLES ,ONBIT>
	              <TELL "The two flames make a soft paired hiss." CR>)
	             (T
	              <TELL "Unlit candles are exemplary listeners." CR>)>
	       <RTRUE>)
	      (<VERB? LAMP-ON BURN>
	       <CANDLES-FCN>
	       <COND (<FSET? ,CANDLES ,ONBIT>
	              <TELL "The two flames settle into nearly matching heights." CR>)>
	       <RTRUE>)>
	<CANDLES-FCN>>

<ROUTINE RITUAL-LLD-ROOM (RARG "AUX" BEFORE-XB BEFORE-XC BEFORE-LLD RESULT)
	<SET BEFORE-XB ,XB>
	<SET BEFORE-XC ,XC>
	<SET BEFORE-LLD ,LLD-FLAG>
	<SET RESULT <LLD-ROOM .RARG>>
	<COND (<AND <NOT .BEFORE-XB> ,XB>
	       <SETG RITUAL-BELL-ANSWERED T>
	       <SETG RITUAL-BELL-RESONANCE-HEARD T>
	       <TELL "The bell's note does not vanish. It settles into the gate, the floor, and the listening stone." CR>)>
	<COND (<AND <NOT .BEFORE-XC> ,XC>
	       <SETG RITUAL-CANDLES-ANSWERED T>
	       <TELL "For one breath, each flame throws a shadow toward the other instead of away from itself." CR>)>
	<COND (<AND <NOT .BEFORE-LLD> ,LLD-FLAG>
	       <SETG RITUAL-PRAYER-COMPLETED T>
	       <TELL "The final resonance drains from the cavern, leaving the gate open and the ordinary darkness strangely quiet." CR>)>
	<COND (<AND <EQUAL? .RARG ,M-BEG>
	            <VERB? READ>
	            <EQUAL? ,PRSO ,BOOK>
	            <NOT ,LLD-FLAG>
	            <NOT ,XC>>
	       <SETG RITUAL-WRONG-ORDER-SEEN T>)>
	<RETURN .RESULT>>

<ROUTINE RITUAL-USE-ON ()
	<COND (<AND <EQUAL? ,PRSO ,BELL>
	            <EQUAL? ,PRSI ,MIRROR-1 ,MIRROR-2>>
	       <COND (<NOT <SHADOW-HELD? ,BELL>>
	              <TELL "You would first need to be holding the bell." CR>)
	             (T
	              <SETG RITUAL-MIRROR-RESONANCE T>
	              <SETG RITUAL-BELL-RESONANCE-HEARD T>
	              <SETG SHADOW-MIRROR-DIAGNOSED T>
	              <TELL "You ring the bell toward the mirror. The reflected bell swings in time, but its sound arrives a fraction after the real note." CR>)>
	       <RTRUE>)
	      (<AND <EQUAL? ,PRSO ,CANDLES>
	            <EQUAL? ,PRSI ,MIRROR-1 ,MIRROR-2>>
	       <COND (<NOT <SHADOW-HELD? ,CANDLES>>
	              <TELL "You would first need to be holding the candles." CR>)
	             (<NOT <SHADOW-FLAME? ,CANDLES>>
	              <TELL "Dark candles produce an admirably dark reflection." CR>)
	             (T
	              <SETG RITUAL-MIRROR-RESONANCE T>
	              <SETG SHADOW-MIRROR-DIAGNOSED T>
	              <TELL "The paired flames multiply in the mirror. One reflected flame bends before the real flame moves, then corrects itself." CR>)>
	       <RTRUE>)
	      (<AND <OR <AND <EQUAL? ,PRSO ,BOOK> <EQUAL? ,PRSI ,CANDLES>>
	                <AND <EQUAL? ,PRSO ,CANDLES> <EQUAL? ,PRSI ,BOOK>>>>
	       <COND (<NOT <AND <ACCESSIBLE? ,BOOK> <ACCESSIBLE? ,CANDLES>>>
	              <TELL "The book and candles must both be within reach." CR>)
	             (<NOT <SHADOW-FLAME? ,CANDLES>>
	              <TELL "The unlit candles reveal no reaction in the damaged ceremonial page." CR>)
	             (T
	              <SETG RITUAL-CEREMONY-KNOWN T>
	              <TELL "Held near the damaged page, the paired flames lean away from the final line and toward the notation for a preceding sound. The order matters." CR>)>
	       <RTRUE>)
	      (<AND <EQUAL? ,PRSO ,WATER ,BOTTLE>
	            <EQUAL? ,PRSI ,HOT-BELL>>
	       <COND (<NOT <SHADOW-HAS-BOTTLED-WATER?>>
	              <TELL "The bottle must be open and contain water before it can cool the bell." CR>)
	             (T
	              <SETG RITUAL-HOT-BELL-COOLED T>
	              <SHADOW-PERFORM ,V?POUR-ON ,WATER ,HOT-BELL>)>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE V-RITUAL-CEREMONY ()
	<COND (<AND <NOT ,RITUAL-CEREMONY-KNOWN>
	            <NOT ,RITUAL-BELL-ANSWERED>
	            <NOT ,RITUAL-CANDLES-ANSWERED>>
	       <TELL "You know ceremonies generally involve confidence, props, and consequences. The black book may contain something less general." CR>
	       <RTRUE>)>
	<TELL "Ceremony state:" CR>
	<TELL "- Resonance: ">
	<COND (,LLD-FLAG <TELL "completed and released">)
	      (,XB <TELL "active; the bell has answered and the interval is open">)
	      (,RITUAL-BELL-ANSWERED <TELL "previously established, but no longer active">)
	      (,RITUAL-BELL-RESONANCE-HEARD <TELL "observed outside the full ceremony">)
	      (T <TELL "not established">)>
	<TELL "." CR>
	<TELL "- Paired light: ">
	<COND (,XC <TELL "answered and awaiting the spoken prayer">)
	      (<AND ,XB <FSET? ,CANDLES ,ONBIT> <IN? ,CANDLES ,WINNER>>
	       <TELL "present; allow the flames a moment to answer">)
	      (<FSET? ,CANDLES ,ONBIT> <TELL "burning, but not inside an active resonance">)
	      (T <TELL "not active">)>
	<TELL "." CR>
	<TELL "- Prayer: ">
	<COND (,LLD-FLAG <TELL "completed">)
	      (,XC <TELL "the black book is ready to be read">)
	      (,RITUAL-CEREMONY-KNOWN <TELL "known, but the earlier conditions are incomplete">)
	      (T <TELL "not yet understood">)>
	<TELL "." CR>>

<ROUTINE RITUAL-RECAP ("AUX" (SEEN <>))
	<COND (,RITUAL-CEREMONY-KNOWN
	       <SET SEEN T>
	       <TELL "- You reconstructed the black book's ceremonial order: resonance, paired light, then prayer." CR>)>
	<COND (,RITUAL-MIRROR-RESONANCE
	       <SET SEEN T>
	       <TELL "- Bell or candle resonance exposed another delayed response in the enormous mirrors." CR>)>
	<COND (,RITUAL-BELL-ANSWERED
	       <SET SEEN T>
	       <TELL "- The brass bell once established the exorcism's opening resonance." CR>)>
	<COND (,RITUAL-CANDLES-ANSWERED
	       <SET SEEN T>
	       <TELL "- The paired candle flames answered inside the active ceremony." CR>)>
	<COND (,RITUAL-HOT-BELL-COOLED
	       <SET SEEN T>
	       <TELL "- You deliberately cooled the red-hot ceremonial bell with real bottled water." CR>)>
	<COND (,RITUAL-WRONG-ORDER-SEEN
	       <SET SEEN T>
	       <TELL "- You confirmed that prayer without the preceding resonance and paired light does not banish the spirits." CR>)>
	<COND (,RITUAL-PRAYER-COMPLETED
	       <SET SEEN T>
	       <TELL "- You completed the canonical bell, candle, and black-book exorcism." CR>)>
	<COND (.SEEN <RTRUE>)>
	<RFALSE>>
