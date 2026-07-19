"Player-facing expansion layer for the project-local Zork I Release 121."

;"The expanded edition keeps every original solution and route. New behavior is
  additive: richer reactions, optional discoveries, remembered actions,
  alternate social solutions, contextual assistance, and more specific failure
  responses."

<SYNTAX EXITS = V-EXITS>
<SYNTAX RECAP = V-RECAP>
<SYNTAX GOALS = V-GOALS>
<SYNTAX HINT = V-HINT>
<SYNTAX WHY = V-WHY>
<SYNTAX LULLABY = V-LULLABY>
<SYNTAX BARGAIN = V-BARGAIN>
<SYNTAX USE OBJECT = V-USE>

<GLOBAL EXP-HOUSE-KNOCKS 0>
<GLOBAL EXP-BOARDS-SCARRED <>>
<GLOBAL EXP-SONGBIRD-FOLLOWED <>>
<GLOBAL EXP-MAIL-SLIP-FOUND <>>
<GLOBAL EXP-TROLL-BRIBED <>>
<GLOBAL EXP-CYCLOPS-SONG 0>
<GLOBAL EXP-THIEF-BARGAINED <>>
<GLOBAL EXP-BOOK-PAGE 0>
<GLOBAL EXP-HINT-ROOM <>>
<GLOBAL EXP-HINT-LEVEL 0>
<GLOBAL EXP-LAST-FAIL 0>

<OBJECT HOUSE-SPLINTER
	(SYNONYM SPLINTER WOOD)
	(ADJECTIVE WHITE PAINTED)
	(DESC "painted splinter")
	(FLAGS TAKEBIT BURNBIT)
	(LDESC "A long splinter of white-painted wood lies here.")
	(SIZE 1)>

<OBJECT BRASS-FEATHER
	(SYNONYM FEATHER QUILL)
	(ADJECTIVE BRASS TINY)
	(DESC "tiny brass feather")
	(FLAGS TAKEBIT)
	(LDESC "A tiny brass feather gleams among the roots.")
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

<OBJECT THIEF-NOTE
	(SYNONYM NOTE PAPER MESSAGE)
	(ADJECTIVE CRUMPLED THIEFS)
	(DESC "crumpled note")
	(FLAGS TAKEBIT READBIT BURNBIT)
	(LDESC "A crumpled note has been dropped here.")
	(TEXT
"A professional never hides treasure in a maze. A professional lets the maze hide itself. — T")
	(SIZE 1)>

<ROOM SONGBIRD-GLADE
	(IN ROOMS)
	(DESC "Hidden Glade")
	(LDESC
"This tiny glade is almost perfectly enclosed by old hemlocks. Their roots have grown around a weathered stone bearing the obsolete seal of the Frobozz Department of Ornithological Navigation. A narrow animal path leads east toward a more ordinary clearing.")
	(EAST TO CLEARING)
	(OUT TO CLEARING)
	(FLAGS RLANDBIT ONBIT SACREDBIT)
	(GLOBAL SONGBIRD FOREST TREE)>

<ROUTINE EXP-REMEMBER-FAIL (CODE)
	<SETG EXP-LAST-FAIL .CODE>
	<RTRUE>>

<ROUTINE V-WHY ()
	<COND (<EQUAL? ,EXP-LAST-FAIL 1>
	       <TELL
"The roof is not impossible in principle; it is simply steep, slick, and missing any route that would leave you alive enough to enjoy the view." CR>)
	      (<EQUAL? ,EXP-LAST-FAIL 2>
	       <TELL
"The boards can be damaged, but they are fastened from the far side. Brute force is changing the boards more quickly than it is changing the doorway." CR>)
	      (<EQUAL? ,EXP-LAST-FAIL 3>
	       <TELL
"The cyclops is listening, but not yet relaxing. A lullaby is traditionally longer than one line, especially when the audience is considering eating the singer." CR>)
	      (<EQUAL? ,EXP-LAST-FAIL 4>
	       <TELL
"The control panel is part of the dam, and the dam has been built on the assumption that visitors should touch only the one part clearly designed to be turned." CR>)
	      (T
	       <TELL
"There is no expanded-edition explanation pending. When a specific experiment fails, WHY may explain what the world objected to." CR>)>>

<ROUTINE V-GOALS ()
	<TELL
"You are exploring the remains of the Great Underground Empire. Discover how its mechanisms, creatures, and rituals work; recover valuables; and return worthwhile treasures to the trophy case in the white house. The expanded edition preserves that purpose while accepting more reasonable experiments along the way." CR>>

<ROUTINE V-RECAP ()
	<TELL "What you currently remember:" CR>
	<COND (,RUG-MOVED
	       <TELL "- The living-room rug concealed a trap door." CR>)
	      (T
	       <TELL "- The white house still contains more structure than its front entrance suggests." CR>)>
	<COND (,EXP-SONGBIRD-FOLLOWED
	       <TELL "- Following the songbird revealed a hidden glade." CR>)>
	<COND (,EXP-TROLL-BRIBED
	       <TELL "- The troll valued portable wealth more than professional pride." CR>)
	      (,TROLL-FLAG
	       <TELL "- The troll no longer blocks the underground passages." CR>)>
	<COND (,CYCLOPS-FLAG
	       <TELL "- The cyclops is no longer guarding the stairway." CR>)
	      (<G? ,EXP-CYCLOPS-SONG 0>
	       <TELL "- Repetition appears to make the cyclops drowsy." CR>)>
	<COND (,LOW-TIDE
	       <TELL "- The reservoir is presently low." CR>)>
	<COND (,GATES-OPEN
	       <TELL "- The dam's sluice gates are open." CR>)>
	<COND (,LLD-FLAG
	       <TELL "- The spirits at the land of the dead have been driven away." CR>)>
	<COND (,EXP-THIEF-BARGAINED
	       <TELL "- The thief accepted one negotiated payment and left a note." CR>)>
	<COND (,WON-FLAG
	       <TELL "- Your discoveries have opened the final path southwest of the house." CR>)>>

<ROUTINE V-EXITS ()
	<COND (<EQUAL? ,HERE ,WEST-OF-HOUSE>
	       <TELL "Visible routes lead north, south, west, and around the house. The boarded entrance is east." CR>)
	      (<EQUAL? ,HERE ,EAST-OF-HOUSE>
	       <TELL "Visible routes lead north, south, and east. The kitchen window may provide a route west." CR>)
	      (<EQUAL? ,HERE ,LIVING-ROOM>
	       <TELL "Visible routes lead east, west, and up. Other routes depend on what has been uncovered or opened." CR>)
	      (<EQUAL? ,HERE ,CELLAR>
	       <TELL "Passages lead north and south. The ramp rises west, though not in a cooperative fashion." CR>)
	      (<EQUAL? ,HERE ,TROLL-ROOM>
	       <TELL "Passages leave the room, but the troll decides whether they are currently usable." CR>)
	      (<EQUAL? ,HERE ,CYCLOPS-ROOM>
	       <TELL "A route leads northwest and stairs lead up. The cyclops has opinions about the stairs." CR>)
	      (<EQUAL? ,HERE ,DAM-ROOM>
	       <TELL "Paths lead north, south, and west, with a scramble downward." CR>)
	      (<EQUAL? ,HERE ,SONGBIRD-GLADE>
	       <TELL "A narrow path leads east, or OUT, toward the clearing." CR>)
	      (T
	       <TELL
"The room description names visible routes. LOOK repeats it; doors, water levels, creatures, and machinery may change which routes are usable." CR>)>>

<ROUTINE EXP-HINT-TIER (ONE TWO THREE)
	<COND (<EQUAL? ,EXP-HINT-LEVEL 1> <TELL .ONE CR>)
	      (<EQUAL? ,EXP-HINT-LEVEL 2> <TELL .TWO CR>)
	      (T <TELL .THREE CR>)>>

<ROUTINE V-HINT ()
	<COND (<NOT <EQUAL? ,EXP-HINT-ROOM ,HERE>>
	       <SETG EXP-HINT-ROOM ,HERE>
	       <SETG EXP-HINT-LEVEL 0>)>
	<SETG EXP-HINT-LEVEL <+ ,EXP-HINT-LEVEL 1>>
	<COND (<EQUAL? ,HERE ,WEST-OF-HOUSE>
	       <EXP-HINT-TIER
"Begin with the things deliberately placed where a visitor would notice them."
"The mailbox is more promising than the official entrance."
"The house has another side, and one window there is not entirely closed.">)
	      (<EQUAL? ,HERE ,LIVING-ROOM>
	       <EXP-HINT-TIER
"Large furnishings can conceal architecture."
"The rug is worth moving or looking beneath."
"Move the rug, then open the trap door.">)
	      (<EQUAL? ,HERE ,TROLL-ROOM>
	       <EXP-HINT-TIER
"The troll is dangerous, but not principled."
"Treasure can sometimes purchase what steel must otherwise win."
"GIVE a carried treasure to the troll for a noncombat route.">)
	      (<EQUAL? ,HERE ,CYCLOPS-ROOM>
	       <EXP-HINT-TIER
"The cyclops can be changed by appetite, identity, or patience."
"A repeated calming song is now an additional risky option."
"Try LULLABY three times before his patience runs out.">)
	      (<EQUAL? ,HERE ,DAM-ROOM>
	       <EXP-HINT-TIER
"The dam distinguishes controls from decoration."
"The bubble enables the control system; the bolt performs the mechanical work."
"Activate the control, then turn the bolt with the wrench.">)
	      (<EQUAL? ,HERE ,ENTRANCE-TO-HADES>
	       <EXP-HINT-TIER
"This is a ceremony, not a single command."
"The bell, lit candles, and black book must act in sequence."
"Ring the bell, keep the candles burning, then read the book at the proper moment.">)
	      (T
	       <EXP-HINT-TIER
"Examine the nouns in the room description and try actions appropriate to their material and purpose."
"Several expanded interactions reward listening, knocking, following, bargaining, and reusing tools."
"RECAP reviews known changes; USE an object explains plausible affordances without performing them.">)>>

<ROUTINE V-USE ()
	<COND (<EQUAL? ,PRSO ,ROPE>
	       <TELL "Rope can be tied, lowered, raised, or used where a secure anchor and a vertical problem meet." CR>)
	      (<EQUAL? ,PRSO ,BELL>
	       <TELL "The bell can be rung; in supernatural places, sound may be more than sound." CR>)
	      (<EQUAL? ,PRSO ,CANDLES>
	       <TELL "The candles provide flame and light, and their condition matters during ritual work." CR>)
	      (<EQUAL? ,PRSO ,AXE>
	       <TELL "The axe is a weapon and a crude cutting or prying tool, though architecture may still be fastened more intelligently than you are swinging." CR>)
	      (<EQUAL? ,PRSO ,WATER ,BOTTLE>
	       <TELL "Water may be carried only in a suitable open container, offered, poured, or used where thirst and flame are relevant." CR>)
	      (<EQUAL? ,PRSO ,WRENCH>
	       <TELL "The wrench turns hardware intended to be turned. It is less persuasive with masonry, monsters, and corporate policy." CR>)
	      (<EQUAL? ,PRSO ,SHOVEL>
	       <TELL "The shovel is useful where the ground, sand, or a suspiciously buried object invites digging." CR>)
	      (<EQUAL? ,PRSO ,MIRROR-1 ,MIRROR-2>
	       <TELL "The enormous mirror can be examined, struck, or used to learn whether the adventure has improved your appearance. It has not." CR>)
	      (T
	       <TELL "Try a concrete verb describing the intended use: TURN, TIE, GIVE, THROW, LIGHT, POUR, CUT, DIG, or EXAMINE." CR>)>>

<ROUTINE EXP-WHITE-HOUSE-F ()
	<COND (<VERB? KNOCK>
	       <SETG EXP-HOUSE-KNOCKS <+ ,EXP-HOUSE-KNOCKS 1>>
	       <COND (<EQUAL? ,EXP-HOUSE-KNOCKS 1>
	              <TELL "Your knock travels through the house. Somewhere inside, something small falls over." CR>)
	             (<EQUAL? ,EXP-HOUSE-KNOCKS 2>
	              <TELL "A hollow knock answers from within. It may be an echo, a resident, or a very conscientious woodpecker." CR>)
	             (T
	              <TELL "The house continues its policy of not receiving visitors through official channels." CR>)>)
	      (<VERB? LISTEN>
	       <COND (<EQUAL? ,HERE ,EAST-OF-HOUSE>
	              <TELL "From beyond the window comes the faint tick of a mechanism somewhere in the house." CR>)
	             (T
	              <TELL "The old house settles with the slow creaks of expensive construction avoiding responsibility." CR>)>)
	      (<VERB? CLIMB-UP CLIMB-FOO>
	       <EXP-REMEMBER-FAIL 1>
	       <TELL "You test several footholds. The roof is reachable only by a route whose final step appears to be a coroner's form." CR>)
	      (<VERB? PUSH PULL MOVE>
	       <TELL "The house is attached to the ground with unusual thoroughness." CR>)
	      (T <WHITE-HOUSE-F>)>>

<ROUTINE EXP-FRONT-DOOR-F ()
	<COND (<VERB? KNOCK>
	       <PERFORM ,V?KNOCK ,WHITE-HOUSE>
	       <RTRUE>)
	      (<VERB? LISTEN>
	       <TELL "With your ear against the door, you hear silence and the faint complaint of old hinges on the other side." CR>)
	      (T <FRONT-DOOR-FCN>)>>

<ROUTINE EXP-BOARDED-WINDOW-F ()
	<COND (<VERB? KNOCK>
	       <TELL "The boards answer with a flat report. The window behind them contributes nothing." CR>)
	      (<VERB? LOOK-INSIDE>
	       <TELL "A narrow seam admits darkness, dust, and no useful view of the room beyond." CR>)
	      (<VERB? MUNG ATTACK>
	       <EXP-REMEMBER-FAIL 2>
	       <COND (<AND ,PRSI <EQUAL? ,PRSI ,AXE ,SWORD ,KNIFE>>
	              <COND (<NOT ,EXP-BOARDS-SCARRED>
	                     <SETG EXP-BOARDS-SCARRED T>
	                     <MOVE ,HOUSE-SPLINTER ,HERE>
	                     <TELL "Your blow tears away a painted splinter, but reveals that the boards are bolted from inside. The window is now uglier and no more open." CR>)
	                    (T
	                     <TELL "You enlarge the existing scars without improving the window's opinion of being boarded." CR>)>)
	             (T
	              <TELL "The boards are more insulted than damaged." CR>)>)
	      (T <BOARDED-WINDOW-FCN>)>>

<ROUTINE EXP-BOARD-F ()
	<COND (<VERB? KNOCK>
	       <TELL "The board produces the confident sound of wood supported by hardware you cannot reach." CR>)
	      (<VERB? LISTEN>
	       <TELL "The board says nothing, having retained counsel." CR>)
	      (<VERB? MUNG ATTACK>
	       <EXP-REMEMBER-FAIL 2>
	       <COND (<AND ,PRSI <EQUAL? ,PRSI ,AXE ,SWORD ,KNIFE>>
	              <COND (<NOT ,EXP-BOARDS-SCARRED>
	                     <SETG EXP-BOARDS-SCARRED T>
	                     <MOVE ,HOUSE-SPLINTER ,HERE>
	                     <TELL "A painted splinter breaks free. The remaining board is still secured from the other side." CR>)
	                    (T
	                     <TELL "The board has acquired character, but not an opening." CR>)>)
	             (T
	              <TELL "The board remains firmly attached and privately amused." CR>)>)
	      (T <BOARD-F>)>>

<ROUTINE EXP-KITCHEN-WINDOW-F ()
	<COND (<VERB? KNOCK>
	       <TELL "The pane rattles. Nothing inside volunteers to open it for you." CR>)
	      (<VERB? LISTEN>
	       <TELL "You hear the faint indoor hush of a house waiting for someone to enter improperly." CR>)
	      (T <KITCHEN-WINDOW-F>)>>

<ROUTINE EXP-SONGBIRD-F ()
	<COND (<VERB? FOLLOW>
	       <COND (<EQUAL? ,HERE ,SONGBIRD-GLADE>
	              <TELL "The songbird hops through the hemlocks and returns to the same branch, having demonstrated a complete tour." CR>)
	             (T
	              <COND (<NOT ,EXP-SONGBIRD-FOLLOWED>
	                     <SETG EXP-SONGBIRD-FOLLOWED T>
	                     <MOVE ,BRASS-FEATHER ,SONGBIRD-GLADE>)>
	              <TELL "The bird darts from branch to branch, always just visible enough to follow. The ordinary forest gives way to a hidden glade." CR CR>
	              <GOTO ,SONGBIRD-GLADE>)>)
	      (<VERB? LISTEN>
	       <COND (,EXP-SONGBIRD-FOLLOWED
	              <TELL "Its song repeats four bright notes, pauses, and then seems to ask whether you have forgotten the way." CR>)
	             (T
	              <TELL "The songbird's call moves westward through the trees, pauses, and repeats as though intended for a follower." CR>)>)
	      (<VERB? HELLO>
	       <TELL "The songbird tilts its head, having heard greetings of greater musical merit." CR>)
	      (T <SONGBIRD-F>)>>

<ROUTINE EXP-MAILBOX-F ()
	<COND (<VERB? KNOCK>
	       <TELL "The mailbox is empty enough to sound official." CR>)
	      (<VERB? LISTEN>
	       <TELL "There is either paper inside or a very small bureaucrat holding its breath." CR>)
	      (<AND <VERB? LOOK-INSIDE>
	            <FSET? ,MAILBOX ,OPENBIT>
	            <NOT <IN? ,ADVERTISEMENT ,MAILBOX>>
	            <NOT ,EXP-MAIL-SLIP-FOUND>>
	       <SETG EXP-MAIL-SLIP-FOUND T>
	       <MOVE ,FROBOZZ-SLIP ,MAILBOX>
	       <TELL "Behind a bent inner lip you discover a folded maintenance slip that the leaflet had concealed." CR>)
	      (T <MAILBOX-F>)>>

<ROUTINE EXP-TROLL-F ("OPTIONAL" (MODE <>))
	<COND (<AND <NOT .MODE>
	            <OR <VERB? GIVE> <VERB? THROW>>
	            <EQUAL? ,PRSI ,TROLL>
	            ,PRSO
	            <G? <GETP ,PRSO ,P?VALUE> 0>>
	       <REMOVE-CAREFULLY ,PRSO>
	       <COND (<IN? ,AXE ,TROLL>
	              <MOVE ,AXE ,HERE>
	              <FCLEAR ,AXE ,NDESCBIT>
	              <FSET ,AXE ,WEAPONBIT>)>
	       <SETG EXP-TROLL-BRIBED T>
	       <SETG TROLL-FLAG T>
	       <REMOVE-CAREFULLY ,TROLL>
	       <TELL "The troll weighs the treasure in one hairy hand, decides that guarding passages is a profession for creatures without capital, and departs. His axe clatters to the floor after him." CR>)
	      (<AND <NOT .MODE> <VERB? HELLO>>
	       <TELL "The troll taps his axe against his palm and says, in surprisingly clear speech, 'Greetings are not legal tender.'" CR>)
	      (T <TROLL-FCN .MODE>)>>

<ROUTINE EXP-CYCLOPS-F ()
	<COND (<VERB? HELLO>
	       <COND (,CYCLOPS-FLAG
	              <TELL "The sleeping cyclops replies with a snore substantial enough to have punctuation." CR>)
	             (T
	              <TELL "The cyclops says, 'Hello, dinner,' and appears pleased with his conversational progress." CR>)>)
	      (<VERB? KISS>
	       <TELL "The cyclops has only one eye, but it is sufficient to express complete rejection of this proposal." CR>)
	      (<AND <VERB? GIVE>
	            <EQUAL? ,PRSI ,CYCLOPS>
	            <FSET? ,PRSO ,FOODBIT>
	            <NOT <EQUAL? ,PRSO ,LUNCH ,GARLIC>>>
	       <REMOVE-CAREFULLY ,PRSO>
	       <SETG CYCLOWRATH 0>
	       <TELL "The cyclops eats the offering, pronounces it inadequate but not insulting, and postpones eating you while he considers the aftertaste." CR>)
	      (<VERB? ATTACK MUNG KICK>
	       <SETG EXP-CYCLOPS-SONG 0>
	       <CYCLOPS-FCN>)
	      (T <CYCLOPS-FCN>)>>

<ROUTINE V-LULLABY ()
	<COND (<AND <EQUAL? ,HERE ,CYCLOPS-ROOM>
	            <IN? ,CYCLOPS ,HERE>
	            <NOT ,CYCLOPS-FLAG>>
	       <SETG EXP-CYCLOPS-SONG <+ ,EXP-CYCLOPS-SONG 1>>
	       <COND (<EQUAL? ,EXP-CYCLOPS-SONG 1>
	              <EXP-REMEMBER-FAIL 3>
	              <TELL "You begin a slow, repetitive lullaby. The cyclops looks offended, then uncertain, and finally yawns despite himself." CR>)
	             (<EQUAL? ,EXP-CYCLOPS-SONG 2>
	              <EXP-REMEMBER-FAIL 3>
	              <TELL "You repeat the melody. The cyclops sways slightly and struggles to keep his enormous eyelid open." CR>)
	             (T
	              <SETG CYCLOPS-FLAG T>
	              <FCLEAR ,CYCLOPS ,FIGHTBIT>
	              <DISABLE <INT I-CYCLOPS>>
	              <TELL "By the third repetition the cyclops is snoring at the foot of the stairs. Your performance will not be reviewed, which is probably for the best." CR>)>)
	      (<AND <EQUAL? ,HERE ,CYCLOPS-ROOM> ,CYCLOPS-FLAG>
	       <TELL "The cyclops is already asleep. Further singing risks changing that." CR>)
	      (T
	       <TELL "You perform a lullaby for an audience composed chiefly of architecture." CR>)>>

<ROUTINE EXP-FIRST-TREASURE ("AUX" OBJ)
	<SET OBJ <FIRST? ,WINNER>>
	<REPEAT ()
		<COND (<NOT .OBJ> <RFALSE>)
		      (<G? <GETP .OBJ ,P?VALUE> 0> <RETURN .OBJ>)>
		<SET OBJ <NEXT? .OBJ>>>>

<ROUTINE V-BARGAIN ("AUX" OFFER)
	<COND (<NOT <IN? ,THIEF ,HERE>>
	       <TELL "No one here appears professionally interested in negotiation." CR>)
	      (,EXP-THIEF-BARGAINED
	       <TELL "The thief smiles and taps the side of his nose. Apparently his one-time introductory bargaining rate has expired." CR>)
	      (<NOT <SET OFFER <EXP-FIRST-TREASURE>>>
	       <TELL "The thief inspects your possessions and explains that bargaining normally begins with your having something he wants." CR>)
	      (T
	       <SETG EXP-THIEF-BARGAINED T>
	       <REMOVE-CAREFULLY .OFFER>
	       <MOVE ,THIEF-NOTE ,HERE>
	       <TELL "The thief accepts the " D .OFFER ", pockets it with insulting speed, and drops a crumpled note. 'A professional courtesy,' he says." CR>)>>

<ROUTINE EXP-BLACK-BOOK-F ()
	<COND (<VERB? TURN>
	       <SETG EXP-BOOK-PAGE <+ ,EXP-BOOK-PAGE 1>>
	       <COND (<EQUAL? ,EXP-BOOK-PAGE 1>
	              <TELL "You turn to Commandment #12593, which forbids the storage of sacred relics in containers labeled 'miscellaneous.' The prescribed punishment is an audit." CR>)
	             (<EQUAL? ,EXP-BOOK-PAGE 2>
	              <TELL "The next page contains a hymn whose musical notation consists entirely of legal disclaimers." CR>)
	             (T
	              <SETG EXP-BOOK-PAGE 0>
	              <TELL "Several pages have been removed and replaced by a notice stating that revelation is temporarily unavailable." CR>)>)
	      (<VERB? LISTEN>
	       <COND (<EQUAL? ,HERE ,ENTRANCE-TO-HADES>
	              <TELL "The closed pages seem to whisper at the edge of hearing, though none agrees with the others." CR>)
	             (T
	              <TELL "The book is silent in the manner of an authority waiting to be quoted incorrectly." CR>)>)
	      (T <BLACK-BOOK>)>>

<ROUTINE EXP-BELL-F ()
	<COND (<VERB? LISTEN>
	       <TELL "Even motionless, the bell carries a faint metallic resonance, as though remembering a sound not yet made." CR>)
	      (<VERB? KNOCK>
	       <TELL "A fingertip produces a tiny, pure note. Somewhere far below, something answers one pitch lower." CR>)
	      (T <BELL-F>)>>

<ROUTINE EXP-CANDLES-F ()
	<COND (<VERB? EXAMINE>
	       <COND (<FSET? ,CANDLES ,ONBIT>
	              <TELL "The two altar candles burn with steady flames despite the underground drafts. Their wax has pooled into shapes uncomfortably like small faces." CR>)
	             (T
	              <TELL "The two altar candles are dark. Thin threads of smoke and softened wax show that they have burned recently." CR>)>)
	      (<VERB? LISTEN>
	       <COND (<FSET? ,CANDLES ,ONBIT>
	              <TELL "The flames make a faint dry flutter, briefly falling into the rhythm of breathing." CR>)
	             (T
	              <TELL "Unlit candles are among the quieter religious authorities." CR>)>)
	      (T <CANDLES-FCN>)>>

<ROUTINE EXP-ROPE-F ()
	<COND (<VERB? EXAMINE>
	       <COND (,DOME-FLAG
	              <TELL "The rope is coarse, strong, and presently arranged to make the dome less terminal." CR>)
	             (T
	              <TELL "The rope is a heavy coil of hemp, long enough to be useful if you first locate something trustworthy to tie it to." CR>)>)
	      (<VERB? KNOCK>
	       <TELL "The rope absorbs the blow, thereby winning a contest you should not have started." CR>)
	      (T <ROPE-FUNCTION>)>>

<ROUTINE EXP-MIRROR-F ()
	<COND (<VERB? KNOCK>
	       <COND (,MIRROR-MUNG
	              <TELL "The broken pieces answer with several small, disagreeing taps." CR>)
	             (T
	              <TELL "The enormous mirror returns a deep glassy note. Your reflection looks briefly concerned." CR>)>)
	      (<VERB? LISTEN>
	       <TELL "The mirror says nothing, but your reflection appears to be listening to you." CR>)
	      (<VERB? KISS>
	       <TELL "The reflection meets you halfway. This does not improve the relationship." CR>)
	      (T <MIRROR-MIRROR>)>>

<ROUTINE EXP-DAM-F ()
	<COND (<VERB? LISTEN>
	       <COND (,GATES-OPEN
	              <TELL "Water hammers through the open sluices with the sustained roar of an empire flushing an expense report." CR>)
	             (T
	              <TELL "Behind the dam, the reservoir presses against the concrete with a patient, enormous hush." CR>)>)
	      (<VERB? EXAMINE>
	       <TELL "The dam is a monumental concrete structure whose designers expected water, tourists, and absolutely no unscheduled maintenance." CR>)
	      (T <DAM-FUNCTION>)>>

<ROUTINE EXP-CONTROL-PANEL-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "The panel consists chiefly of a large bolt and a green bubble indicator. This is either elegant engineering or the surviving portion of a much larger budget." CR>)
	      (<VERB? LISTEN>
	       <COND (,GATE-FLAG
	              <TELL "A quiet electrical hum comes from behind the panel." CR>)
	             (T
	              <TELL "The panel is silent." CR>)>)
	      (<VERB? PUSH PULL MOVE>
	       <EXP-REMEMBER-FAIL 4>
	       <TELL "The panel is integral to the dam. The bolt, by contrast, appears designed for deliberate mechanical persuasion." CR>)>>
