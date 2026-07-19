"Reactive surface-world layer for the repository-local Zork I Glulx lineage."

;"Release 1212 ports only visible surface behavior around the white house,
  mailbox, kitchen window, boards, ordinary forest nouns, and the songbird.
  It adds no rooms, optional geography, alternate NPC solutions, or comedy."

<GLOBAL SURFACE-HOUSE-KNOCKS 0>
<GLOBAL SURFACE-BOARDS-SCARRED <>>
<GLOBAL SURFACE-MAIL-SLIP-FOUND <>>

<OBJECT HOUSE-SPLINTER
	(SYNONYM SPLINTER WOOD)
	(ADJECTIVE WHITE PAINTED)
	(DESC "painted splinter")
	(FLAGS TAKEBIT BURNBIT)
	(LDESC "A long splinter of white-painted wood lies here.")
	(SIZE 1)>

<OBJECT FROBOZZ-SLIP
	(SYNONYM SLIP NOTICE RECEIPT PAPER)
	(ADJECTIVE FOLDED MAINTENANCE)
	(DESC "folded maintenance slip")
	(FLAGS TAKEBIT READBIT BURNBIT)
	(LDESC "A folded maintenance slip is here.")
	(TEXT
"FROBOZZ DOMESTIC PORTALS, WINDOWS & INCONVENIENT OPENINGS DIVISION| |Service request: front entrance inaccessible.|Disposition: functioning as designed.|Recommended customer action: locate a less official entrance.| |This document constitutes proof that someone was paid to inspect the problem.")
	(SIZE 1)>

<ROUTINE SURFACE-RECAP ("AUX" (SEEN <>))
	<COND (,SURFACE-BOARDS-SCARRED
	       <SET SEEN T>
	       <TELL "- The boarded entrance now bears your damage, but remains secured from inside." CR>)>
	<COND (,SURFACE-MAIL-SLIP-FOUND
	       <SET SEEN T>
	       <TELL "- The mailbox concealed a maintenance slip about the inaccessible front entrance." CR>)>
	<COND (<G? ,SURFACE-HOUSE-KNOCKS 1>
	       <SET SEEN T>
	       <TELL "- Repeated knocking confirmed that the house does not receive visitors officially." CR>)>
	<COND (.SEEN <RTRUE>)>
	<RFALSE>>

<ROUTINE SURFACE-WHITE-HOUSE-F ()
	<COND (<VERB? KNOCK>
	       <SETG SURFACE-HOUSE-KNOCKS <+ ,SURFACE-HOUSE-KNOCKS 1>>
	       <COND (<EQUAL? ,SURFACE-HOUSE-KNOCKS 1>
	              <TELL "Your knock travels through the house. Somewhere inside, something small falls over." CR>)
	             (<EQUAL? ,SURFACE-HOUSE-KNOCKS 2>
	              <TELL "A hollow knock answers from within. It may be an echo, a resident, or a very conscientious woodpecker." CR>)
	             (T
	              <TELL "The house continues its policy of not receiving visitors through official channels." CR>)>)
	      (<VERB? LISTEN>
	       <COND (<EQUAL? ,HERE ,EAST-OF-HOUSE>
	              <TELL "From beyond the window comes the faint tick of a mechanism somewhere in the house." CR>)
	             (T
	              <TELL "The old house settles with the slow creaks of expensive construction avoiding responsibility." CR>)>)
	      (<VERB? CLIMB-UP CLIMB-FOO>
	       <ASSIST-REMEMBER-FAIL 1>
	       <TELL "You test several footholds. The roof is reachable only by a route whose final step appears to be a coroner's form." CR>)
	      (<VERB? PUSH MOVE>
	       <TELL "The house is attached to the ground with unusual thoroughness." CR>)
	      (T <WHITE-HOUSE-F>)>>

<ROUTINE SURFACE-FRONT-DOOR-F ()
	<COND (<VERB? KNOCK>
	       <PERFORM ,V?KNOCK ,WHITE-HOUSE>
	       <RTRUE>)
	      (<VERB? LISTEN>
	       <TELL "With your ear against the door, you hear silence and the faint complaint of old hinges on the other side." CR>)
	      (T <FRONT-DOOR-FCN>)>>

<ROUTINE SURFACE-BOARDED-WINDOW-F ()
	<COND (<VERB? KNOCK>
	       <TELL "The boards answer with a flat report. The window behind them contributes nothing." CR>)
	      (<VERB? LOOK-INSIDE>
	       <TELL "A narrow seam admits darkness, dust, and no useful view of the room beyond." CR>)
	      (<VERB? MUNG ATTACK>
	       <ASSIST-REMEMBER-FAIL 2>
	       <COND (<AND ,PRSI <EQUAL? ,PRSI ,AXE ,SWORD ,KNIFE>>
	              <COND (<NOT ,SURFACE-BOARDS-SCARRED>
	                     <SETG SURFACE-BOARDS-SCARRED T>
	                     <MOVE ,HOUSE-SPLINTER ,HERE>
	                     <TELL "Your blow tears away a painted splinter, but reveals that the boards are bolted from inside. The window is now uglier and no more open." CR>)
	                    (T
	                     <TELL "You enlarge the existing scars without improving the window's opinion of being boarded." CR>)>)
	             (T
	              <TELL "The boards are more insulted than damaged." CR>)>)
	      (T <BOARDED-WINDOW-FCN>)>>

<ROUTINE SURFACE-BOARD-F ()
	<COND (<VERB? KNOCK>
	       <TELL "The board produces the confident sound of wood supported by hardware you cannot reach." CR>)
	      (<VERB? LISTEN>
	       <TELL "The board says nothing, having retained counsel." CR>)
	      (<VERB? MUNG ATTACK>
	       <ASSIST-REMEMBER-FAIL 2>
	       <COND (<AND ,PRSI <EQUAL? ,PRSI ,AXE ,SWORD ,KNIFE>>
	              <COND (<NOT ,SURFACE-BOARDS-SCARRED>
	                     <SETG SURFACE-BOARDS-SCARRED T>
	                     <MOVE ,HOUSE-SPLINTER ,HERE>
	                     <TELL "A painted splinter breaks free. The remaining board is still secured from the other side." CR>)
	                    (T
	                     <TELL "The board has acquired character, but not an opening." CR>)>)
	             (T
	              <TELL "The board remains firmly attached and privately amused." CR>)>)
	      (T <BOARD-F>)>>

<ROUTINE SURFACE-KITCHEN-WINDOW-F ()
	<COND (<VERB? KNOCK>
	       <TELL "The pane rattles. Nothing inside volunteers to open it for you." CR>)
	      (<VERB? LISTEN>
	       <TELL "You hear the faint indoor hush of a house waiting for someone to enter improperly." CR>)
	      (T <KITCHEN-WINDOW-F>)>>

<ROUTINE SURFACE-MAILBOX-F ()
	<COND (<VERB? KNOCK>
	       <TELL "The mailbox is empty enough to sound official." CR>)
	      (<VERB? LISTEN>
	       <TELL "There is either paper inside or a very small bureaucrat holding its breath." CR>)
	      (<AND <VERB? LOOK-INSIDE>
	            <FSET? ,MAILBOX ,OPENBIT>
	            <NOT <IN? ,ADVERTISEMENT ,MAILBOX>>
	            <NOT ,SURFACE-MAIL-SLIP-FOUND>>
	       <SETG SURFACE-MAIL-SLIP-FOUND T>
	       <MOVE ,FROBOZZ-SLIP ,MAILBOX>
	       <TELL "Behind a bent inner lip you discover a folded maintenance slip that the leaflet had concealed." CR>)
	      (T <MAILBOX-F>)>>

<ROUTINE SURFACE-FOREST-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "Pines and hemlocks crowd together in every direction, making individual trees easier to identify than useful destinations." CR>)
	      (T <FOREST-F>)>>

<ROUTINE SURFACE-TREE-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "The tree is old, deeply rooted, and entirely committed to remaining part of the forest." CR>)
	      (<VERB? LISTEN>
	       <TELL "Branches shift overhead while the trunk contributes the patient silence of wood." CR>)
	      (T <RFALSE>)>>

<ROUTINE SURFACE-SONGBIRD-F ()
	<COND (<VERB? LISTEN>
	       <TELL "The songbird's call moves among the trees in four bright notes, pauses, and begins again." CR>)
	      (<VERB? HELLO>
	       <TELL "The songbird tilts its head, having heard greetings of greater musical merit." CR>)
	      (T <SONGBIRD-F>)>>
