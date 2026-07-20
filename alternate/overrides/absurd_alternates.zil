"Stateful absurd alternate solutions for project-local Zork I Release 122."

;"These actions cross the line from harmless Adventurer Misconduct into earned
  world-state changes. Ridiculous ideas work only when their objects, timing,
  and preparation make physical sense. Canonical solutions remain available."

<SYNTAX TRICK OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-ALT-TRICK>
<SYNONYM TRICK DISTRACT FOOL DECEIVE>

<GLOBAL ALT-TROLL-DISTRACTED <>>
<GLOBAL ALT-TROLL-TRICK-USED <>>
<GLOBAL ALT-TROLL-BOUND <>>
<GLOBAL ALT-NEST-BURNED <>>
<GLOBAL ALT-EGG-CAUGHT <>>
<GLOBAL ALT-SACK-PREPARED <>>

<ROUTINE ALT-RECAP ()
	<COND (,ALT-TROLL-BOUND
	       <TELL "- The troll remains alive, thoroughly tied, and professionally embarrassed." CR>)>
	<COND (,ALT-NEST-BURNED
	       <COND (,ALT-EGG-CAUGHT
	              <TELL "- The bird's nest burned, but the prepared sack caught the intact jewel-encrusted egg." CR>)
	             (T
	              <TELL "- Burning the bird's nest brought the egg down by the shortest and most destructive route." CR>)>)>>

<ROUTINE V-ALT-TRICK ()
	<COND (<EQUAL? ,PRSO ,TROLL>
	       <ALT-TRICK-TROLL>)
	      (<FSET? ,PRSO ,ACTORBIT>
	       <TELL "You attempt a deception of breathtaking simplicity. The " D ,PRSO " declines the role assigned to it." CR>)
	      (T
	       <TELL "Tricking the " D ,PRSO " would first require it to possess expectations." CR>)>>

<ROUTINE ALT-TRICK-TROLL ()
	<COND (<OR ,ALT-TROLL-BOUND <NOT <IN? ,TROLL ,HERE>>>
	       <TELL "The troll is not presently available for further tactical deception." CR>)
	      (,ALT-TROLL-TRICK-USED
	       <TELL "You point urgently behind the troll. He points just as urgently behind you and keeps watching." CR>)
	      (T
	       <SETG ALT-TROLL-TRICK-USED T>
	       <SETG ALT-TROLL-DISTRACTED T>
	       <FCLEAR ,TROLL ,FIGHTBIT>
	       <SETG CLOCK-WAIT T>
	       <ENABLE <QUEUE I-ALT-TROLL-RECOVER 2>>
	       <TELL "You gasp and point behind the troll. Against experience, training, and several visible facts, he turns to look. You have one very brief opportunity." CR>)>
	<RTRUE>>

<ROUTINE I-ALT-TROLL-RECOVER ()
	<COND (<AND ,ALT-TROLL-DISTRACTED <NOT ,ALT-TROLL-BOUND>>
	       <SETG ALT-TROLL-DISTRACTED <>>
	       <COND (<IN? ,TROLL ,HERE>
	              <FSET ,TROLL ,FIGHTBIT>
	              <TELL "The troll turns back, discovers that reality has not improved, and resumes guarding it." CR>)>)>>

<ROUTINE ALT-BIND-TROLL ()
	<COND (,ALT-TROLL-BOUND
	       <TELL "The troll is already tied beyond the recommendations of the Frobozz Restraint Council." CR>)
	      (<NOT <EQUAL? ,PRSI ,ROPE>>
	       <TELL "The proposed restraint lacks the traditional advantage of being rope." CR>)
	      (<NOT <IN? ,ROPE ,WINNER>>
	       <TELL "You would first need to be holding the rope." CR>)
	      (<NOT <OR ,ALT-TROLL-DISTRACTED
	                <NOT <IN? ,AXE ,TROLL>>
	                <L? <GETP ,TROLL ,P?STRENGTH> 0>>>
	       <SETG CLOCK-WAIT T>
	       <TELL "You approach the alert, armed troll with the rope arranged confidently. He inserts the axe into the negotiation, and you retreat with the original number of limbs." CR>)
	      (T
	       <DISABLE <INT I-ALT-TROLL-RECOVER>>
	       <SETG ALT-TROLL-DISTRACTED <>>
	       <SETG ALT-TROLL-BOUND T>
	       <SETG TROLL-FLAG T>
	       <FCLEAR ,TROLL ,FIGHTBIT>
	       <COND (<IN? ,AXE ,TROLL>
	              <MOVE ,AXE ,HERE>
	              <FCLEAR ,AXE ,NDESCBIT>
	              <FSET ,AXE ,WEAPONBIT>)>
	       <MOVE ,ROPE ,TROLL>
	       <FSET ,ROPE ,NDESCBIT>
	       <PUTP ,TROLL ,P?LDESC
"A nasty-looking troll is tied securely with the rope and wedged resentfully against the wall. All passages are open.">
	       <SETG CLOCK-WAIT T>
	       <TELL "While the troll is still examining the nonexistent emergency behind him, you loop the rope around his arms, knees, and several opinions about personal dignity. His axe clatters to the floor. The bound troll remains alive, furious, and no longer able to block the passages." CR>)>
	<RTRUE>>

<ROUTINE ALT-UNTIE-TROLL ()
	<COND (<NOT ,ALT-TROLL-BOUND>
	       <TELL "The troll is not tied, merely hostile." CR>)
	      (T
	       <SETG ALT-TROLL-BOUND <>>
	       <SETG TROLL-FLAG <>>
	       <MOVE ,ROPE ,HERE>
	       <FCLEAR ,ROPE ,NDESCBIT>
	       <FSET ,TROLL ,FIGHTBIT>
	       <PUTP ,TROLL ,P?LDESC "A nasty-looking troll blocks all passages and is rubbing rope marks from his wrists.">
	       <SETG CLOCK-WAIT T>
	       <TELL "You release the final knot. The troll stands, stretches, and silently promotes you from captor to immediate problem." CR>)>
	<RTRUE>>

<ROUTINE ALT-TROLL-F ("OPTIONAL" (MODE <>))
	<COND (,ALT-TROLL-BOUND
	       <COND (.MODE <RFALSE>)
	             (<VERB? EXAMINE>
	              <TELL <GETP ,TROLL ,P?LDESC> CR>)
	             (<VERB? UNTIE>
	              <ALT-UNTIE-TROLL>)
	             (<VERB? TIE-UP>
	              <ALT-BIND-TROLL>)
	             (<VERB? LISTEN>
	              <TELL "The troll is explaining the knots in a language containing very few vowels and many legal threats." CR>)
	             (<VERB? HELLO>
	              <TELL "The bound troll acknowledges your greeting by attempting to bite the air between you." CR>)
	             (<VERB? ATTACK MUNG ABS-KILL>
	              <TELL "Attacking a helplessly bound troll would convert tactical misconduct into ordinary villainy." CR>)
	             (T
	              <TELL "The bound troll cannot cooperate, although he is developing several detailed future proposals." CR>)>)
	      (<AND <NOT .MODE> <VERB? ALT-TRICK>>
	       <ALT-TRICK-TROLL>)
	      (<AND <NOT .MODE> <VERB? TIE-UP>>
	       <ALT-BIND-TROLL>)
	      (T <ABS-TROLL-F .MODE>)>>

<ROUTINE ALT-PREPARE-SACK ()
	<COND (<NOT <IN? ,SANDWICH-BAG ,WINNER>>
	       <TELL "You would first need to be holding the brown sack." CR>)
	      (<NOT <EQUAL? ,HERE ,PATH ,UP-A-TREE>>
	       <TELL "There is no useful tree-and-ground relationship here to prepare." CR>)
	      (T
	       <MOVE ,SANDWICH-BAG ,PATH>
	       <SETG ALT-SACK-PREPARED T>
	       <TELL "You spread the brown sack beneath the branch like a fragrant, badly underfunded safety net." CR>)>
	<RTRUE>>

<ROUTINE ALT-TREE-F ()
	<COND (<AND <VERB? PUT-UNDER>
	            <EQUAL? ,PRSO ,SANDWICH-BAG>
	            <EQUAL? ,PRSI ,TREE>>
	       <ALT-PREPARE-SACK>)
	      (T <ABS-TREE-F>)>>

<ROUTINE ALT-BURN-NEST ()
	<COND (<NOT <EQUAL? ,PRSI ,TORCH>>
	       <TELL "The nest is dry enough to burn, but this alternate solution specifically requires the controlled flame of the ivory torch." CR>)
	      (<NOT <IN? ,TORCH ,WINNER>>
	       <TELL "You would first need to be holding the torch." CR>)
	      (<NOT <AND <FSET? ,TORCH ,ONBIT> <FSET? ,TORCH ,FLAMEBIT>>>
	       <TELL "The torch is not currently providing the essential fire portion of the plan." CR>)
	      (<NOT <AND <EQUAL? ,HERE ,UP-A-TREE> <IN? ,NEST ,UP-A-TREE>>>
	       <TELL "This plan depends on the nest still being in the tree, with gravity available beneath it." CR>)
	      (T
	       <SETG ALT-NEST-BURNED T>
	       <COND (<IN? ,EGG ,NEST>
	              <COND (<IN? ,SANDWICH-BAG ,PATH>
	                     <SETG ALT-EGG-CAUGHT T>
	                     <MOVE ,EGG ,SANDWICH-BAG>
	                     <ROB ,NEST ,PATH>
	                     <REMOVE-CAREFULLY ,NEST>
	                     <THIS-IS-IT ,EGG>
	                     <TELL "The nest flashes into flame with alarming enthusiasm. The jewel-encrusted egg drops through the smoke and lands in the prepared brown sack. The sack folds around it, while the hot-pepper sandwich contributes the first useful cushioning of its career." CR>)
	                    (T
	                     <SETG ALT-EGG-CAUGHT <>>
	                     <MOVE ,EGG ,PATH>
	                     <ROB ,NEST ,PATH>
	                     <REMOVE-CAREFULLY ,NEST>
	                     <TELL "The nest flashes into flame. The jewel-encrusted egg falls ten feet, strikes the ground, and springs open with an expensive crunch.">
	                     <BAD-EGG>
	                     <THIS-IS-IT ,BROKEN-EGG>
	                     <CRLF>)>)
	             (T
	              <ROB ,NEST ,PATH>
	              <REMOVE-CAREFULLY ,NEST>
	              <TELL "The empty nest burns quickly and falls apart in a brief shower of sparks and administrative regret." CR>)>)>
	<RTRUE>>

<ROUTINE ALT-NEST-F ()
	<COND (<VERB? BURN>
	       <ALT-BURN-NEST>)
	      (T <ABS-NEST-F>)>>
