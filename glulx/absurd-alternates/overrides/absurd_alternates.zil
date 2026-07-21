"Earned absurd alternate solutions for the repository-local Zork I Glulx lineage."

;"This isolated layer ports Release 122 outcomes semantically rather than
  mechanically. Ridiculous actions work only with the real objects, preparation,
  timing, location, and vulnerability that make them physically coherent.
  Canonical troll combat, nest handling, burning, and treasure consequences
  remain authoritative everywhere outside the qualified alternate routes."

<SYNTAX TRICK OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-GLULX-ALT-TRICK>
<SYNONYM TRICK DISTRACT FOOL DECEIVE>

<GLOBAL GLULX-ALT-TROLL-DISTRACTED <>>
<GLOBAL GLULX-ALT-TROLL-TRICK-USED <>>
<GLOBAL GLULX-ALT-TROLL-BOUND <>>
<GLOBAL GLULX-ALT-NEST-BURNED <>>
<GLOBAL GLULX-ALT-EGG-CAUGHT <>>
<GLOBAL GLULX-ALT-SACK-PREPARED <>>

<ROUTINE GLULX-ALT-RECAP ("AUX" (SEEN <>))
	<COND (,GLULX-ALT-TROLL-BOUND
	       <SET SEEN T>
	       <TELL "- The troll remains alive, thoroughly tied, and professionally embarrassed." CR>)
	      (,GLULX-ALT-TROLL-DISTRACTED
	       <SET SEEN T>
	       <TELL "- The troll is looking the wrong way, but only for one very brief opportunity." CR>)
	      (,GLULX-ALT-TROLL-TRICK-USED
	       <SET SEEN T>
	       <TELL "- The troll has learned not to investigate your imaginary emergencies." CR>)>
	<COND (<AND ,GLULX-ALT-SACK-PREPARED <NOT ,GLULX-ALT-NEST-BURNED>>
	       <SET SEEN T>
	       <TELL "- The brown sack is spread beneath the tree as a deliberately prepared catcher." CR>)>
	<COND (,GLULX-ALT-NEST-BURNED
	       <SET SEEN T>
	       <COND (,GLULX-ALT-EGG-CAUGHT
	              <TELL "- The bird's nest burned, but the prepared sack caught the intact jewel-encrusted egg." CR>)
	             (T
	              <TELL "- Burning the bird's nest brought the egg down by the shortest and most destructive route." CR>)>)>
	<COND (.SEEN <RTRUE>)>
	<RFALSE>>

<ROUTINE V-GLULX-ALT-TRICK ()
	<COND (<EQUAL? ,PRSO ,TROLL>
	       <GLULX-ALT-TRICK-TROLL>)
	      (<FSET? ,PRSO ,ACTORBIT>
	       <TELL "You attempt a deception of breathtaking simplicity. The " D ,PRSO " declines the role assigned to it." CR>)
	      (T
	       <TELL "Tricking the " D ,PRSO " would first require it to possess expectations." CR>)>>

<ROUTINE GLULX-ALT-TRICK-TROLL ()
	<COND (<OR ,GLULX-ALT-TROLL-BOUND <NOT <IN? ,TROLL ,HERE>>>
	       <TELL "The troll is not presently available for further tactical deception." CR>)
	      (,GLULX-ALT-TROLL-TRICK-USED
	       <TELL "You point urgently behind the troll. He points just as urgently behind you and keeps watching." CR>)
	      (T
	       <SETG GLULX-ALT-TROLL-TRICK-USED T>
	       <SETG GLULX-ALT-TROLL-DISTRACTED T>
	       <FCLEAR ,TROLL ,FIGHTBIT>
	       <SETG CLOCK-WAIT T>
	       <ENABLE <QUEUE I-GLULX-ALT-TROLL-RECOVER 2>>
	       <TELL "You gasp and point behind the troll. Against experience, training, and several visible facts, he turns to look. You have one very brief opportunity." CR>)>
	<RTRUE>>

<ROUTINE I-GLULX-ALT-TROLL-RECOVER ()
	<COND (<AND ,GLULX-ALT-TROLL-DISTRACTED <NOT ,GLULX-ALT-TROLL-BOUND>>
	       <SETG GLULX-ALT-TROLL-DISTRACTED <>>
	       <FSET ,TROLL ,FIGHTBIT>
	       <COND (<IN? ,TROLL ,HERE>
	              <TELL "The troll turns back, discovers that reality has not improved, and resumes guarding it." CR>)>)>>

<ROUTINE GLULX-ALT-BIND-TROLL ()
	<COND (,GLULX-ALT-TROLL-BOUND
	       <TELL "The troll is already tied beyond the recommendations of the Frobozz Restraint Council." CR>)
	      (<NOT <EQUAL? ,PRSI ,ROPE>>
	       <TELL "The proposed restraint lacks the traditional advantage of being rope." CR>)
	      (<NOT <IN? ,ROPE ,WINNER>>
	       <TELL "You would first need to be holding the rope." CR>)
	      (<NOT <OR ,GLULX-ALT-TROLL-DISTRACTED
	                <NOT <IN? ,AXE ,TROLL>>
	                <L? <GETP ,TROLL ,P?STRENGTH> 0>>>
	       <SETG CLOCK-WAIT T>
	       <TELL "You approach the alert, armed troll with the rope arranged confidently. He inserts the axe into the negotiation, and you retreat with the original number of limbs." CR>)
	      (T
	       <DISABLE <INT I-GLULX-ALT-TROLL-RECOVER>>
	       <COND (,GLULX-ALT-TROLL-DISTRACTED
	              <TELL "While the troll is still examining the nonexistent emergency behind him, you loop the rope ">)
	             (T
	              <TELL "You seize the troll's present disadvantage and loop the rope ">)>
	       <TELL "around his arms, knees, and several opinions about personal dignity.">
	       <SETG GLULX-ALT-TROLL-DISTRACTED <>>
	       <SETG GLULX-ALT-TROLL-BOUND T>
	       <SETG TROLL-FLAG T>
	       <FCLEAR ,TROLL ,FIGHTBIT>
	       <COND (<IN? ,AXE ,TROLL>
	              <MOVE ,AXE ,HERE>
	              <FCLEAR ,AXE ,NDESCBIT>
	              <FSET ,AXE ,WEAPONBIT>
	              <TELL " His axe clatters to the floor.">)>
	       <MOVE ,ROPE ,TROLL>
	       <FSET ,ROPE ,NDESCBIT>
	       <PUTP ,TROLL ,P?LDESC
"A nasty-looking troll is tied securely with the rope and wedged resentfully against the wall. All passages are open.">
	       <SETG CLOCK-WAIT T>
	       <TELL " The bound troll remains alive, furious, and no longer able to block the passages." CR>)>
	<RTRUE>>

<ROUTINE GLULX-ALT-UNTIE-TROLL ()
	<COND (<NOT ,GLULX-ALT-TROLL-BOUND>
	       <TELL "The troll is not tied, merely hostile." CR>)
	      (T
	       <SETG GLULX-ALT-TROLL-BOUND <>>
	       <SETG TROLL-FLAG <>>
	       <MOVE ,ROPE ,HERE>
	       <FCLEAR ,ROPE ,NDESCBIT>
	       <FSET ,TROLL ,FIGHTBIT>
	       <PUTP ,TROLL ,P?LDESC "A nasty-looking troll blocks all passages and is rubbing rope marks from his wrists.">
	       <SETG CLOCK-WAIT T>
	       <TELL "You release the final knot. The troll stands, stretches, and silently promotes you from captor to immediate problem." CR>)>
	<RTRUE>>

<ROUTINE GLULX-ALT-TROLL-F ("OPTIONAL" (MODE <>))
	<COND (,GLULX-ALT-TROLL-BOUND
	       <COND (.MODE <RFALSE>)
	             (<VERB? EXAMINE>
	              <TELL <GETP ,TROLL ,P?LDESC> CR>)
	             (<VERB? UNTIE>
	              <GLULX-ALT-UNTIE-TROLL>)
	             (<VERB? TIE-UP>
	              <GLULX-ALT-BIND-TROLL>)
	             (<VERB? GLULX-ALT-TRICK>
	              <GLULX-ALT-TRICK-TROLL>)
	             (<VERB? LISTEN>
	              <TELL "The troll is explaining the knots in a language containing very few vowels and many legal threats." CR>)
	             (<VERB? HELLO>
	              <TELL "The bound troll acknowledges your greeting by attempting to bite the air between you." CR>)
	             (<VERB? ATTACK MUNG>
	              <TELL "Attacking a helplessly bound troll would convert tactical misconduct into ordinary villainy." CR>)
	             (T
	              <TELL "The bound troll cannot cooperate, although he is developing several detailed future proposals." CR>)>)
	      (<AND <NOT .MODE> <VERB? GLULX-ALT-TRICK>>
	       <GLULX-ALT-TRICK-TROLL>)
	      (<AND <NOT .MODE> <VERB? TIE-UP>>
	       <GLULX-ALT-BIND-TROLL>)
	      (T <TROLL-FCN .MODE>)>>

<ROUTINE GLULX-ALT-PREPARE-SACK ()
	<COND (<NOT <IN? ,SANDWICH-BAG ,WINNER>>
	       <TELL "You would first need to be holding the brown sack." CR>)
	      (<NOT <EQUAL? ,HERE ,PATH ,UP-A-TREE>>
	       <TELL "There is no useful tree-and-ground relationship here to prepare." CR>)
	      (T
	       <MOVE ,SANDWICH-BAG ,PATH>
	       <FSET ,SANDWICH-BAG ,OPENBIT>
	       <FSET ,SANDWICH-BAG ,SEARCHBIT>
	       <SETG GLULX-ALT-SACK-PREPARED T>
	       <TELL "You spread the brown sack beneath the branch like a fragrant, badly underfunded safety net." CR>)>
	<RTRUE>>

<ROUTINE GLULX-ALT-TREE-F ()
	<COND (<AND <VERB? PUT-UNDER>
	            <EQUAL? ,PRSO ,SANDWICH-BAG>
	            <EQUAL? ,PRSI ,TREE>>
	       <GLULX-ALT-PREPARE-SACK>)
	      (T <SURFACE-TREE-F>)>>

<ROUTINE GLULX-ALT-BURN-NEST ()
	<COND (<NOT <EQUAL? ,PRSI ,TORCH>>
	       <TELL "The nest is dry enough to burn, but this alternate solution specifically requires the controlled flame of the ivory torch." CR>)
	      (<NOT <IN? ,TORCH ,WINNER>>
	       <TELL "You would first need to be holding the torch." CR>)
	      (<NOT <AND <FSET? ,TORCH ,ONBIT> <FSET? ,TORCH ,FLAMEBIT>>>
	       <TELL "The torch is not currently providing the essential fire portion of the plan." CR>)
	      (<NOT <AND <EQUAL? ,HERE ,UP-A-TREE> <IN? ,NEST ,UP-A-TREE>>>
	       <TELL "This plan depends on the nest still being in the tree, with gravity available beneath it." CR>)
	      (T
	       <SETG GLULX-ALT-NEST-BURNED T>
	       <COND (<IN? ,EGG ,NEST>
	              <COND (<AND ,GLULX-ALT-SACK-PREPARED
	                           <IN? ,SANDWICH-BAG ,PATH>>
	                     <SETG GLULX-ALT-EGG-CAUGHT T>
	                     <MOVE ,EGG ,SANDWICH-BAG>
	                     <PUTP ,EGG ,P?FDESC
"A large jewel-encrusted egg rests here, intact despite its recent descent.">
	                     <ROB ,NEST ,PATH>
	                     <REMOVE-CAREFULLY ,NEST>
	                     <THIS-IS-IT ,EGG>
	                     <TELL "The nest flashes into flame with alarming enthusiasm. The jewel-encrusted egg drops through the smoke and lands in the prepared brown sack. The sack folds around it">
	                     <COND (<IN? ,LUNCH ,SANDWICH-BAG>
	                            <TELL ", while the hot-pepper sandwich contributes the first useful cushioning of its career">)
	                           (T
	                            <TELL ", relying entirely on canvas, luck, and questionable preparation">)>
	                     <TELL "." CR>)
	                    (T
	                     <SETG GLULX-ALT-EGG-CAUGHT <>>
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

<ROUTINE GLULX-ALT-NEST-F ("OPTIONAL" (MODE <>))
	<COND (<AND <NOT .MODE>
	            <VERB? BURN>
	            <EQUAL? ,PRSI ,TORCH>
	            <EQUAL? ,HERE ,UP-A-TREE>
	            <IN? ,NEST ,UP-A-TREE>>
	       <GLULX-ALT-BURN-NEST>)
	      (T <RFALSE>)>>
