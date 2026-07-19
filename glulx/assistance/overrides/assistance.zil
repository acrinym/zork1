"Optional assistance layer for the repository-local Zork I Glulx lineage."

;"This layer adds parser-facing orientation commands and a state-neutral global
  action hook. It intentionally excludes reactive scenery, optional geography,
  alternate NPC solutions, and Adventurer Misconduct."

<SYNTAX EXITS = V-EXITS>
<SYNTAX RECAP = V-RECAP>
<SYNTAX GOALS = V-GOALS>
<SYNTAX HINT = V-HINT>
<SYNTAX WHY = V-WHY>
<SYNTAX USE OBJECT = V-USE>

<GLOBAL ASSIST-HINT-ROOM <>>
<GLOBAL ASSIST-HINT-LEVEL 0>
<GLOBAL ASSIST-LAST-FAIL 0>
<GLOBAL ASSIST-LAST-ACTION <>>
<GLOBAL ASSIST-LAST-PRSO <>>
<GLOBAL ASSIST-LAST-PRSI <>>

<ROUTINE ASSIST-REMEMBER-FAIL (CODE)
	<SETG ASSIST-LAST-FAIL .CODE>
	<RTRUE>>

<ROUTINE ASSIST-ACTION-HOOK ()
	<COND (<NOT <VERB? GOALS EXITS HINT RECAP WHY USE>>
	       <SETG ASSIST-LAST-ACTION ,PRSA>
	       <SETG ASSIST-LAST-PRSO ,PRSO>
	       <SETG ASSIST-LAST-PRSI ,PRSI>
	       <SETG ASSIST-LAST-FAIL 0>
	       <COND (<AND <EQUAL? ,PRSO ,WHITE-HOUSE>
			   <VERB? CLIMB-UP CLIMB-FOO>>
		      <SETG ASSIST-LAST-FAIL 1>)
		     (<AND <EQUAL? ,PRSO ,BOARD>
			   <VERB? MUNG ATTACK>>
		      <SETG ASSIST-LAST-FAIL 2>)
		     (<AND <EQUAL? ,PRSO ,CONTROL-PANEL>
			   <VERB? PUSH PULL MOVE TURN>>
		      <SETG ASSIST-LAST-FAIL 3>)>)>
	<RFALSE>>

<ROUTINE V-WHY ()
	<COND (<EQUAL? ,ASSIST-LAST-FAIL 1>
	       <TELL
"The roof is not impossible in principle; it is steep, slick, and missing a route that leaves you alive enough to enjoy the view." CR>)
	      (<EQUAL? ,ASSIST-LAST-FAIL 2>
	       <TELL
"The boards are fastened from the far side. Damaging their surface does not remove the structure holding them in place." CR>)
	      (<EQUAL? ,ASSIST-LAST-FAIL 3>
	       <TELL
"The control panel belongs to the dam mechanism, but the panel itself is not the part designed to be turned. Examine the controls and hardware separately." CR>)
	      (T
	       <TELL
"There is no specific explanation pending. Try the action that failed, then ask WHY immediately afterward." CR>)>>

<ROUTINE V-GOALS ()
	<TELL
"Explore the remains of the Great Underground Empire, learn how its mechanisms, creatures, and rituals work, recover valuables, and return worthwhile treasures to the trophy case in the white house. Assistance commands explain possibilities without performing solutions for you." CR>>

<ROUTINE V-RECAP ("AUX" (SEEN <>))
	<TELL "What you currently remember:" CR>
	<COND (,RUG-MOVED
	       <SET SEEN T>
	       <TELL "- The living-room rug concealed a trap door." CR>)>
	<COND (,TROLL-FLAG
	       <SET SEEN T>
	       <TELL "- The troll no longer blocks the underground passages." CR>)>
	<COND (,CYCLOPS-FLAG
	       <SET SEEN T>
	       <TELL "- The cyclops is no longer guarding the stairway." CR>)>
	<COND (,LOW-TIDE
	       <SET SEEN T>
	       <TELL "- The reservoir is presently low." CR>)>
	<COND (,GATES-OPEN
	       <SET SEEN T>
	       <TELL "- The dam's sluice gates are open." CR>)>
	<COND (,LLD-FLAG
	       <SET SEEN T>
	       <TELL "- The spirits at the land of the dead have been driven away." CR>)>
	<COND (,WON-FLAG
	       <SET SEEN T>
	       <TELL "- Your discoveries have opened the final path southwest of the house." CR>)>
	<COND (<NOT .SEEN>
	       <TELL
"- No major persistent change has been established yet. The white house remains the most useful place to begin." CR>)>>

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
	      (T
	       <TELL
"The room description names visible routes. LOOK repeats it; doors, water levels, creatures, and machinery may change which routes are usable." CR>)>>

<ROUTINE ASSIST-HINT-TIER (ONE TWO THREE)
	<COND (<EQUAL? ,ASSIST-HINT-LEVEL 1> <TELL .ONE CR>)
	      (<EQUAL? ,ASSIST-HINT-LEVEL 2> <TELL .TWO CR>)
	      (T <TELL .THREE CR>)>>

<ROUTINE V-HINT ()
	<COND (<NOT <EQUAL? ,ASSIST-HINT-ROOM ,HERE>>
	       <SETG ASSIST-HINT-ROOM ,HERE>
	       <SETG ASSIST-HINT-LEVEL 0>)>
	<SETG ASSIST-HINT-LEVEL <+ ,ASSIST-HINT-LEVEL 1>>
	<COND (<EQUAL? ,HERE ,WEST-OF-HOUSE>
	       <ASSIST-HINT-TIER
"Begin with the things deliberately placed where a visitor would notice them."
"The mailbox is more promising than the official entrance."
"The house has another side, and one window there is not entirely closed.">)
	      (<EQUAL? ,HERE ,LIVING-ROOM>
	       <ASSIST-HINT-TIER
"Large furnishings can conceal architecture."
"The rug is worth moving or looking beneath."
"Move the rug, then open the trap door.">)
	      (<EQUAL? ,HERE ,TROLL-ROOM>
	       <ASSIST-HINT-TIER
"The troll controls the exits because he is armed and attentive."
"A weapon and persistence may be required before the passages become usable."
"Prepare for combat, attack the troll, and watch for chances to recover or disarm his axe.">)
	      (<EQUAL? ,HERE ,CYCLOPS-ROOM>
	       <ASSIST-HINT-TIER
"The cyclops can be changed by appetite or identity."
"Food and drink matter, but so does the name of an old one-eyed traveler."
"Use the pepper sandwich and water, or address him as Ulysses.">)
	      (<EQUAL? ,HERE ,DAM-ROOM>
	       <ASSIST-HINT-TIER
"The dam distinguishes controls from decoration."
"The bubble enables the control system; the bolt performs the mechanical work."
"Activate the control, then turn the bolt with the wrench.">)
	      (<EQUAL? ,HERE ,ENTRANCE-TO-HADES>
	       <ASSIST-HINT-TIER
"This is a ceremony, not a single command."
"The bell, lit candles, and black book must act in sequence."
"Ring the bell, keep the candles burning, then read the book at the proper moment.">)
	      (T
	       <ASSIST-HINT-TIER
"Examine the nouns in the room description and try actions appropriate to their material and purpose."
"Listen to the wording of failures; containers, doors, creatures, and machinery often reveal what condition is missing."
"RECAP reviews established changes; USE an object explains plausible affordances without performing them.">)>>

<ROUTINE V-USE ()
	<COND (<EQUAL? ,PRSO ,ROPE>
	       <TELL "Rope can be tied, lowered, raised, or used where a secure anchor and a vertical problem meet." CR>)
	      (<EQUAL? ,PRSO ,BELL>
	       <TELL "The bell can be rung; in supernatural places, sound may be more than sound." CR>)
	      (<EQUAL? ,PRSO ,CANDLES>
	       <TELL "The candles provide flame and light, and their condition matters during ritual work." CR>)
	      (<EQUAL? ,PRSO ,AXE>
	       <TELL "The axe is a weapon and a crude cutting tool, though architecture may still be fastened more intelligently than you are swinging." CR>)
	      (<EQUAL? ,PRSO ,WATER ,BOTTLE>
	       <TELL "Water may be carried only in a suitable open container, offered, poured, or used where thirst and flame are relevant." CR>)
	      (<EQUAL? ,PRSO ,WRENCH>
	       <TELL "The wrench turns hardware intended to be turned. Examine machinery to distinguish the control from the part that moves." CR>)
	      (<EQUAL? ,PRSO ,SHOVEL>
	       <TELL "The shovel is useful where ground, sand, or a suspiciously buried object invites digging." CR>)
	      (<EQUAL? ,PRSO ,MIRROR-1 ,MIRROR-2>
	       <TELL "The enormous mirror can be examined or struck, though its size makes ordinary carrying impractical." CR>)
	      (T
	       <TELL "Try a concrete verb describing the intended use: TURN, TIE, GIVE, THROW, LIGHT, POUR, CUT, DIG, or EXAMINE." CR>)>>
