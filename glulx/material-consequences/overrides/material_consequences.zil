"Focused non-dam material consequences for the repository-local Zork I Glulx lineage."

;"This layer deepens a small set of real objects and visible surfaces without
  granting universal crafting or physics. Rope can be committed to an anchor,
  the brown sack can be cinched, water changes nest and tool state, and the
  boarded entrance responds differently to real hand tools. Canonical puzzle
  routines remain authoritative once temporary material conditions permit them."

<GLOBAL MATERIAL-ROPE-ANCHOR <>>
<GLOBAL MATERIAL-SACK-CINCHED <>>
<GLOBAL MATERIAL-NEST-WET 0>
<GLOBAL MATERIAL-SHOVEL-CLEANED <>>
<GLOBAL MATERIAL-WRENCH-CLEANED <>>
<GLOBAL MATERIAL-SCREWDRIVER-CLEANED <>>
<GLOBAL MATERIAL-AXE-CLEANED <>>
<GLOBAL MATERIAL-RUST-WET 0>
<GLOBAL MATERIAL-RUST-WORSE <>>
<GLOBAL MATERIAL-BOARDS-PRIED <>>
<GLOBAL MATERIAL-BOARDS-HARDWARE-KNOWN <>>

<ROUTINE MATERIAL-FIXED-ROPE-ANCHOR? ()
	<COND (<AND ,MATERIAL-ROPE-ANCHOR
	            <NOT <EQUAL? ,MATERIAL-ROPE-ANCHOR ,SANDWICH-BAG>>>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE MATERIAL-CONSUME-BOTTLED-WATER ()
	<REMOVE-CAREFULLY ,WATER>
	<RTRUE>>

<ROUTINE MATERIAL-ADVANCE ()
	<COND (<SHADOW-NON-TURN-COMMAND?> <RFALSE>)>
	<COND (<G? ,MATERIAL-NEST-WET 0>
	       <SETG MATERIAL-NEST-WET <- ,MATERIAL-NEST-WET 1>>
	       <COND (<AND <0? ,MATERIAL-NEST-WET> <ACCESSIBLE? ,NEST>>
	              <TELL "The soaked nest has finally dried enough to become dangerously flammable again." CR>)>)>
	<COND (<G? ,MATERIAL-RUST-WET 0>
	       <SETG MATERIAL-RUST-WET <- ,MATERIAL-RUST-WET 1>>
	       <COND (<0? ,MATERIAL-RUST-WET>
	              <SETG MATERIAL-RUST-WORSE T>
	              <COND (<ACCESSIBLE? ,RUSTY-KNIFE>
	                     <TELL "Moisture settles into the rusty knife. A fresh orange bloom spreads along the blade." CR>)>)>)>
	<RFALSE>>

<ROUTINE MATERIAL-ROPE-USE-ON ()
	<COND (<NOT <EQUAL? ,PRSO ,ROPE>> <RFALSE>)
	      (<NOT <EQUAL? ,PRSI ,RAILING ,LADDER ,WOODEN-DOOR ,SANDWICH-BAG>>
	       <RFALSE>)
	      (<NOT <SHADOW-HELD? ,ROPE>>
	       <TELL "You would first need to be holding the rope." CR>)
	      (,MATERIAL-ROPE-ANCHOR
	       <TELL "One end of the rope is already committed to the " D ,MATERIAL-ROPE-ANCHOR ". Untie it before inventing a second geometry." CR>)
	      (<NOT <ACCESSIBLE? ,PRSI>>
	       <TELL "The proposed anchor is not within reach." CR>)
	      (<AND <EQUAL? ,PRSI ,SANDWICH-BAG> ,GLULX-ALT-SACK-PREPARED>
	       <TELL "The sack is spread beneath the tree as a catcher. Cinching it now would convert preparation into sabotage." CR>)
	      (<EQUAL? ,PRSI ,SANDWICH-BAG>
	       <SETG MATERIAL-ROPE-ANCHOR ,SANDWICH-BAG>
	       <SETG MATERIAL-SACK-CINCHED T>
	       <FCLEAR ,SANDWICH-BAG ,OPENBIT>
	       <TELL "You wrap the rope around the mouth of the brown sack and cinch it tight. The sack is now secure, portable, and impossible to open without undoing your work." CR>)
	      (T
	       <SETG MATERIAL-ROPE-ANCHOR ,PRSI>
	       <TELL "You tie one end of the rope securely to the " D ,PRSI ". The remaining coil stays with you, but it now has a definite and inconvenient opinion about distance." CR>)>
	<RTRUE>>

<ROUTINE MATERIAL-UNTIE-ROPE ()
	<COND (<NOT ,MATERIAL-ROPE-ANCHOR> <RFALSE>)
	      (<NOT <OR <EQUAL? ,PRSO ,ROPE>
	                <EQUAL? ,PRSO ,MATERIAL-ROPE-ANCHOR>>>
	       <RFALSE>)>
	<TELL "You undo the knot around the " D ,MATERIAL-ROPE-ANCHOR ". The rope is fully available again." CR>
	<SETG MATERIAL-ROPE-ANCHOR <>>
	<SETG MATERIAL-SACK-CINCHED <>>
	<RTRUE>>

<ROUTINE MATERIAL-ROPE-HOOK ()
	<COND (<AND <VERB? SHADOW-USE-ON> <MATERIAL-ROPE-USE-ON>>
	       <RTRUE>)
	      (<AND <VERB? UNTIE> <MATERIAL-UNTIE-ROPE>>
	       <RTRUE>)
	      (<AND ,MATERIAL-SACK-CINCHED
	            <VERB? OPEN>
	            <EQUAL? ,PRSO ,SANDWICH-BAG>>
	       <TELL "The rope is cinched around the sack's mouth. Untie the sack before trying to open it." CR>
	       <RTRUE>)
	      (<AND ,MATERIAL-ROPE-ANCHOR
	            <VERB? DROP GIVE>
	            <EQUAL? ,PRSO ,ROPE>>
	       <TELL "The rope cannot be surrendered while one end remains tied to the " D ,MATERIAL-ROPE-ANCHOR "." CR>
	       <RTRUE>)
	      (<AND ,MATERIAL-ROPE-ANCHOR
	            <VERB? EXAMINE>
	            <EQUAL? ,PRSO ,ROPE>>
	       <TELL "The rope is sound. One end is tied to the " D ,MATERIAL-ROPE-ANCHOR ", while the remaining coil is still under your control." CR>
	       <RTRUE>)
	      (<AND ,MATERIAL-ROPE-ANCHOR
	            <VERB? MOVE>
	            <EQUAL? ,PRSO ,ROPE>>
	       <TELL "The rope draws taut against the " D ,MATERIAL-ROPE-ANCHOR ". The knot holds." CR>
	       <RTRUE>)
	      (<AND <MATERIAL-FIXED-ROPE-ANCHOR?>
	            <ACCESSIBLE? ,MATERIAL-ROPE-ANCHOR>
	            <VERB? WALK WALK-TO WALK-AROUND THROUGH ENTER EXIT
	                   CLIMB-UP CLIMB-DOWN CLIMB-FOO LEAP>>
	       <TELL "The anchored rope reaches its useful limit and checks your movement. Untie it or remain on this side of the experiment." CR>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE MATERIAL-TOOL-CLEAN? (OBJ)
	<COND (<EQUAL? .OBJ ,SHOVEL> <RETURN ,MATERIAL-SHOVEL-CLEANED>)
	      (<EQUAL? .OBJ ,WRENCH> <RETURN ,MATERIAL-WRENCH-CLEANED>)
	      (<EQUAL? .OBJ ,SCREWDRIVER> <RETURN ,MATERIAL-SCREWDRIVER-CLEANED>)
	      (<EQUAL? .OBJ ,AXE> <RETURN ,MATERIAL-AXE-CLEANED>)>
	<RFALSE>>

<ROUTINE MATERIAL-MARK-TOOL-CLEAN (OBJ)
	<COND (<EQUAL? .OBJ ,SHOVEL> <SETG MATERIAL-SHOVEL-CLEANED T>)
	      (<EQUAL? .OBJ ,WRENCH> <SETG MATERIAL-WRENCH-CLEANED T>)
	      (<EQUAL? .OBJ ,SCREWDRIVER> <SETG MATERIAL-SCREWDRIVER-CLEANED T>)
	      (<EQUAL? .OBJ ,AXE> <SETG MATERIAL-AXE-CLEANED T>)>
	<RTRUE>>

<ROUTINE MATERIAL-WATER-APPLIED? ()
	<COND (<AND <VERB? SHADOW-USE-ON>
	            <EQUAL? ,PRSO ,WATER ,BOTTLE>>
	       <RTRUE>)
	      (<AND <VERB? POUR-ON> <EQUAL? ,PRSO ,WATER>>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE MATERIAL-WASH-TOOL ()
	<COND (<NOT <MATERIAL-WATER-APPLIED?>> <RFALSE>)
	      (<NOT <EQUAL? ,PRSI ,SHOVEL ,WRENCH ,SCREWDRIVER ,AXE ,RUSTY-KNIFE>>
	       <RFALSE>)
	      (<NOT <SHADOW-HAS-BOTTLED-WATER?>>
	       <TELL "The bottle must be open and contain water before it can wash anything." CR>)
	      (<EQUAL? ,PRSI ,RUSTY-KNIFE>
	       <MATERIAL-CONSUME-BOTTLED-WATER>
	       <SETG MATERIAL-RUST-WET 3>
	       <TELL "Water carries loose orange rust from the knife, then settles into every pit the corrosion has made. This may be cleaner, but it is not maintenance." CR>)
	      (<MATERIAL-TOOL-CLEAN? ,PRSI>
	       <TELL "The " D ,PRSI " is already as clean as water alone can make it." CR>)
	      (T
	       <MATERIAL-CONSUME-BOTTLED-WATER>
	       <MATERIAL-MARK-TOOL-CLEAN ,PRSI>
	       <COND (<EQUAL? ,PRSI ,SHOVEL>
	              <TELL "You rinse packed soil from the shovel blade. Its edge and weight are easier to judge now." CR>)
	             (<EQUAL? ,PRSI ,WRENCH>
	              <TELL "Water cuts through the wrench's surface grime and exposes clean flats around the jaws." CR>)
	             (<EQUAL? ,PRSI ,SCREWDRIVER>
	              <TELL "You wash grease from the screwdriver's tip. It remains small, but no longer disguises its condition." CR>)
	             (T
	              <TELL "You rinse dirt from the axe head. The edge is unchanged, but the metal is plainly visible again." CR>)>)>
	<RTRUE>>

<ROUTINE MATERIAL-SOAK-NEST ()
	<COND (<NOT <MATERIAL-WATER-APPLIED?>> <RFALSE>)
	      (<NOT <EQUAL? ,PRSI ,NEST>> <RFALSE>)
	      (<NOT <SHADOW-HAS-BOTTLED-WATER?>>
	       <TELL "The bottle must be open and contain water before the nest can be soaked." CR>)
	      (<G? ,MATERIAL-NEST-WET 0>
	       <TELL "The nest is already saturated. Additional water would mostly improve the branch below it." CR>)
	      (T
	       <MATERIAL-CONSUME-BOTTLED-WATER>
	       <SETG MATERIAL-NEST-WET 4>
	       <TELL "You soak the woven nest. Water darkens the twigs, drips through the branch, and temporarily removes fire from the list of immediate outcomes." CR>)>
	<RTRUE>>

<ROUTINE MATERIAL-NEST-HOOK ()
	<COND (<MATERIAL-SOAK-NEST> <RTRUE>)
	      (<AND <G? ,MATERIAL-NEST-WET 0>
	            <OR <AND <VERB? BURN> <EQUAL? ,PRSO ,NEST>>
	                <AND <VERB? SHADOW-USE-ON>
	                     <EQUAL? ,PRSO ,TORCH>
	                     <EQUAL? ,PRSI ,NEST>>>>
	       <TELL "The torch chars a few damp fibers, produces an offended hiss, and fails to establish flame. The nest needs time to dry." CR>
	       <RTRUE>)
	      (<AND <G? ,MATERIAL-NEST-WET 0>
	            <VERB? EXAMINE>
	            <EQUAL? ,PRSO ,NEST>>
	       <TELL "The nest is dark with water. Its woven twigs are intact, heavy, and presently resistant to ignition." CR>
	       <RTRUE>)
	      (<AND <G? ,MATERIAL-NEST-WET 0>
	            <VERB? RUB>
	            <EQUAL? ,PRSO ,NEST>>
	       <TELL "The nest is cold, soaked, and flexible beneath your fingers." CR>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE MATERIAL-BOARD-USE-ON ()
	<COND (<NOT <VERB? SHADOW-USE-ON>> <RFALSE>)
	      (<NOT <EQUAL? ,PRSI ,BOARD ,BOARDED-WINDOW>> <RFALSE>)
	      (<NOT <EQUAL? ,PRSO ,SHOVEL ,SCREWDRIVER ,WRENCH>> <RFALSE>)
	      (<NOT <SHADOW-HELD? ,PRSO>>
	       <TELL "You would first need to be holding the " D ,PRSO "." CR>)
	      (<EQUAL? ,PRSO ,SHOVEL>
	       <SETG MATERIAL-BOARDS-PRIED T>
	       <COND (<NOT ,SURFACE-BOARDS-SCARRED>
	              <SETG SURFACE-BOARDS-SCARRED T>
	              <MOVE ,HOUSE-SPLINTER ,HERE>
	              <TELL "You work the shovel blade into the narrow seam and lean on the handle. The board flexes enough to tear loose a painted splinter, then the hidden interior bolts stop the experiment cold." CR>)
	             (T
	              <TELL "The shovel widens the scarred seam by a fraction. The board flexes; the unreachable interior hardware does not." CR>)>)
	      (<EQUAL? ,PRSO ,SCREWDRIVER>
	       <SETG MATERIAL-BOARDS-HARDWARE-KNOWN T>
	       <TELL "The screwdriver traces every visible seam and finds no screw head. The fasteners are driven from the inside, where tool access is currently represented by darkness." CR>)
	      (T
	       <SETG MATERIAL-BOARDS-HARDWARE-KNOWN T>
	       <TELL "The wrench finds no exposed nut or bolt. Whatever secures the boards presents its working surfaces to the room beyond the window." CR>)>
	<RTRUE>>

<ROUTINE MATERIAL-TOOL-STATE-HOOK ()
	<COND (<MATERIAL-WASH-TOOL> <RTRUE>)
	      (<MATERIAL-BOARD-USE-ON> <RTRUE>)
	      (<AND <VERB? RUB> <EQUAL? ,PRSO ,RUSTY-KNIFE> <G? ,MATERIAL-RUST-WET 0>>
	       <SETG MATERIAL-RUST-WET 0>
	       <TELL "You rub the water from the rusty knife before it can settle further. The old corrosion remains, but you prevent this particular mistake from ripening." CR>
	       <RTRUE>)
	      (<AND <VERB? RUB> <EQUAL? ,PRSO ,RUSTY-KNIFE> ,MATERIAL-RUST-WORSE>
	       <TELL "Fresh rust flakes away under your fingers. The blade is no sharper, only more honestly damaged." CR>
	       <RTRUE>)
	      (<AND <VERB? RUB>
	            <EQUAL? ,PRSO ,SHOVEL ,WRENCH ,SCREWDRIVER ,AXE>
	            <MATERIAL-TOOL-CLEAN? ,PRSO>>
	       <TELL "The cleaned metal is cool and free of the grime that previously hid its working surfaces." CR>
	       <RTRUE>)
	      (<AND <VERB? EXAMINE DIAGNOSE>
	            <EQUAL? ,PRSO ,RUSTY-KNIFE>
	            ,MATERIAL-RUST-WORSE>
	       <TELL "The rusty knife now bears a fresh orange bloom where water sat in the pits. It remains a weapon chiefly against confidence." CR>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE MATERIAL-ACTION-HOOK ()
	<COND (,SHADOW-INTERNAL-ACTION <RFALSE>)>
	<MATERIAL-ADVANCE>
	<COND (<MATERIAL-ROPE-HOOK> <RTRUE>)
	      (<MATERIAL-NEST-HOOK> <RTRUE>)
	      (<MATERIAL-TOOL-STATE-HOOK> <RTRUE>)>
	<RFALSE>>

<ROUTINE MATERIAL-RECAP ("AUX" (SEEN <>))
	<COND (,MATERIAL-ROPE-ANCHOR
	       <SET SEEN T>
	       <COND (,MATERIAL-SACK-CINCHED
	              <TELL "- You cinched the brown sack shut with the rope." CR>)
	             (T
	              <TELL "- You tied one end of the rope to the " D ,MATERIAL-ROPE-ANCHOR "." CR>)>)>
	<COND (,MATERIAL-BOARDS-PRIED
	       <SET SEEN T>
	       <TELL "- You used the shovel as a pry bar and confirmed that the boarded entrance is secured by unreachable interior hardware." CR>)>
	<COND (,MATERIAL-BOARDS-HARDWARE-KNOWN
	       <SET SEEN T>
	       <TELL "- Screwdriver or wrench probing confirmed that the boarded entrance exposes no exterior fastener." CR>)>
	<COND (<OR ,MATERIAL-SHOVEL-CLEANED ,MATERIAL-WRENCH-CLEANED
	           ,MATERIAL-SCREWDRIVER-CLEANED ,MATERIAL-AXE-CLEANED>
	       <SET SEEN T>
	       <TELL "- You used real water to expose the working surfaces of one or more tools." CR>)>
	<COND (,MATERIAL-RUST-WORSE
	       <SET SEEN T>
	       <TELL "- You confirmed that washing a rusty knife and leaving it wet produces more rust, not restoration." CR>)>
	<COND (<G? ,MATERIAL-NEST-WET 0>
	       <SET SEEN T>
	       <TELL "- The bird's nest is temporarily soaked and resistant to the ivory torch." CR>)>
	<COND (.SEEN <RTRUE>)>
	<RFALSE>>
