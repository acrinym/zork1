"Shadow Logic foundation for the repository-local Zork I Glulx lineage."

;"This layer brings Shadowgate-style dangerous object experimentation into
  Zork's parser without copying Shadowgate content or interface. It adds
  self-targeted USE, material responses, a qualitative light inventory,
  one learned maintenance word, telegraphed personal-fire danger, and a
  mortal-folly ledger. Canonical puzzle actions remain authoritative."

<SYNTAX USE OBJECT ON OBJECT = V-SHADOW-USE-ON>
<SYNTAX USE OBJECT WITH OBJECT = V-SHADOW-USE-ON>
<SYNTAX LIGHTS = V-SHADOW-LIGHTS>
<SYNTAX FOLLIES = V-SHADOW-FOLLIES>
<SYNTAX MORTAL FOLLIES = V-SHADOW-FOLLIES>
<SYNTAX DEATHS = V-SHADOW-FOLLIES>
<SYNTAX WORDS = V-SHADOW-WORDS>
<SYNTAX MELZAR = V-SHADOW-MELZAR>
<SYNTAX SAY MELZAR = V-SHADOW-MELZAR>

<CONSTANT SHADOW-MAT-NONE 0>
<CONSTANT SHADOW-MAT-PAPER 1>
<CONSTANT SHADOW-MAT-WOOD 2>
<CONSTANT SHADOW-MAT-METAL 3>
<CONSTANT SHADOW-MAT-GLASS 4>
<CONSTANT SHADOW-MAT-FIBER 5>

<GLOBAL SHADOW-INTERNAL-ACTION <>>
<GLOBAL SHADOW-SELF-FIRE 0>
<GLOBAL SHADOW-SELF-TIED <>>
<GLOBAL SHADOW-GARLIC-SCENT <>>
<GLOBAL SHADOW-MELZAR-KNOWN <>>
<GLOBAL SHADOW-MIRROR-DIAGNOSED <>>

<GLOBAL SHADOW-FOLLY-TORCH <>>
<GLOBAL SHADOW-FOLLY-WEAPON <>>
<GLOBAL SHADOW-FOLLY-ROPE <>>
<GLOBAL SHADOW-FOLLY-CARRIED-FIRE <>>

<ROUTINE SHADOW-PERFORM (ACTION OBJ "OPTIONAL" (IOBJ <>))
	<SETG SHADOW-INTERNAL-ACTION T>
	<COND (.IOBJ <PERFORM .ACTION .OBJ .IOBJ>)
	      (T <PERFORM .ACTION .OBJ>)>
	<SETG SHADOW-INTERNAL-ACTION <>>
	<RTRUE>>

<ROUTINE SHADOW-FLAME? (OBJ)
	<COND (<AND .OBJ <FSET? .OBJ ,ONBIT> <FSET? .OBJ ,FLAMEBIT>>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE SHADOW-MATERIAL-OF (OBJ)
	<COND (<EQUAL? .OBJ ,ADVERTISEMENT ,GUIDE ,OWNERS-MANUAL>
	       <RETURN ,SHADOW-MAT-PAPER>)
	      (<EQUAL? .OBJ ,FROBOZZ-SLIP ,MAP ,BOAT-LABEL>
	       <RETURN ,SHADOW-MAT-PAPER>)
	      (<EQUAL? .OBJ ,HOUSE-SPLINTER ,NEST ,RAILING>
	       <RETURN ,SHADOW-MAT-WOOD>)
	      (<EQUAL? .OBJ ,LADDER ,WOODEN-DOOR>
	       <RETURN ,SHADOW-MAT-WOOD>)
	      (<EQUAL? .OBJ ,WRENCH ,SWORD ,AXE>
	       <RETURN ,SHADOW-MAT-METAL>)
	      (<EQUAL? .OBJ ,KNIFE ,RUSTY-KNIFE ,SCREWDRIVER>
	       <RETURN ,SHADOW-MAT-METAL>)
	      (<EQUAL? .OBJ ,BOTTLE ,MIRROR-1 ,MIRROR-2>
	       <RETURN ,SHADOW-MAT-GLASS>)
	      (<EQUAL? .OBJ ,KITCHEN-WINDOW ,BOARDED-WINDOW>
	       <RETURN ,SHADOW-MAT-GLASS>)
	      (<EQUAL? .OBJ ,ROPE ,SANDWICH-BAG>
	       <RETURN ,SHADOW-MAT-FIBER>)>
	<RETURN ,SHADOW-MAT-NONE>>

<ROUTINE SHADOW-MATERIAL-HOOK ("AUX" MAT)
	<SET MAT <SHADOW-MATERIAL-OF ,PRSO>>
	<COND (<EQUAL? .MAT ,SHADOW-MAT-NONE> <RFALSE>)
	      (<VERB? TOUCH>
	       <COND (<EQUAL? .MAT ,SHADOW-MAT-PAPER>
	              <TELL "The material is dry, flexible, and distressingly eager to crease." CR>)
	             (<EQUAL? .MAT ,SHADOW-MAT-WOOD>
	              <TELL "The grain is dry and uneven beneath your fingers." CR>)
	             (<EQUAL? .MAT ,SHADOW-MAT-METAL>
	              <TELL "The metal is cool, hard, and more honest about its weight than its purpose." CR>)
	             (<EQUAL? .MAT ,SHADOW-MAT-GLASS>
	              <TELL "The surface is smooth, cold, and one bad decision away from becoming several surfaces." CR>)
	             (T
	              <TELL "The fibers feel rough and capable of remembering knots." CR>)>
	       <RTRUE>)
	      (<AND <VERB? KNOCK STRIKE>
	            <NOT <EQUAL? ,PRSO ,MIRROR-1 ,MIRROR-2 ,KITCHEN-WINDOW>>>
	       <COND (<EQUAL? .MAT ,SHADOW-MAT-PAPER>
	              <TELL "It answers with the private rustle of paperwork refusing responsibility." CR>)
	             (<EQUAL? .MAT ,SHADOW-MAT-WOOD>
	              <TELL "The wood answers with a dry, compact thud." CR>)
	             (<EQUAL? .MAT ,SHADOW-MAT-METAL>
	              <TELL "A clear metallic note rings out and fades into the surrounding stone." CR>)
	             (<EQUAL? .MAT ,SHADOW-MAT-GLASS>
	              <TELL "The glass gives a small, dangerous tick." CR>)
	             (T
	              <TELL "The fibers absorb the blow with almost insulting competence." CR>)>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE SHADOW-NON-TURN-COMMAND? ()
	<COND (<VERB? SAVE RESTORE QUIT VERSION SCORE>
	       <RTRUE>)
	      (<VERB? SHADOW-FOLLIES SHADOW-LIGHTS SHADOW-WORDS>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE SHADOW-EXTINGUISHING-SELF? ()
	<COND (<AND <VERB? SHADOW-USE-ON>
	            <EQUAL? ,PRSI ,ME>
	            <EQUAL? ,PRSO ,WATER ,BOTTLE>>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE SHADOW-ADVANCE-THREATS ()
	<COND (<OR <0? ,SHADOW-SELF-FIRE>
	           <SHADOW-NON-TURN-COMMAND?>
	           <SHADOW-EXTINGUISHING-SELF?>>
	       <RFALSE>)
	      (<EQUAL? ,SHADOW-SELF-FIRE 1>
	       <SETG SHADOW-SELF-FIRE 2>
	       <TELL "The smoke becomes flame. Your sleeve is now burning in a manner that demands water rather than interpretation." CR>
	       <RFALSE>)
	      (T
	       <SETG SHADOW-SELF-FIRE 0>
	       <SETG SHADOW-FOLLY-TORCH T>
	       <JIGS-UP
"Your attempt at personal illumination becomes total. The Great Underground Empire briefly gains one additional torch and loses one adventurer.">)>>

<ROUTINE SHADOW-BLOCKED-BY-ROPE? ()
	<COND (<AND ,SHADOW-SELF-TIED
	            <VERB? WALK WALK-TO WALK-AROUND THROUGH ENTER EXIT
	                   CLIMB-UP CLIMB-DOWN CLIMB-FOO LEAP>>
	       <TELL "The rope around your legs converts travel into a short instructional fall. UNTIE SELF would be the conventional next step." CR>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE SHADOW-ACTION-HOOK ()
	<COND (,SHADOW-INTERNAL-ACTION <RFALSE>)>
	<SHADOW-ADVANCE-THREATS>
	<COND (<SHADOW-BLOCKED-BY-ROPE?> <RTRUE>)
	      (<AND <VERB? UNTIE> <EQUAL? ,PRSO ,ME>>
	       <COND (,SHADOW-SELF-TIED
	              <SETG SHADOW-SELF-TIED <>>
	              <TELL "You work the rope loose and recover the use of your legs, along with a modest portion of your dignity." CR>)
	             (T
	              <TELL "You are not currently tied, however persuasive the evidence of poor judgment may be." CR>)>
	       <RTRUE>)
	      (<AND <VERB? READ> <EQUAL? ,PRSO ,OWNERS-MANUAL>>
	       <SETG SHADOW-MELZAR-KNOWN T>
	       <RFALSE>)
	      (<AND <VERB? EXAMINE> <EQUAL? ,PRSO ,ME>>
	       <TELL "You look like an adventurer who has been given far too many verbs." CR>
	       <COND (,SHADOW-SELF-TIED
	              <TELL " A rope is tied around your legs.">)>
	       <COND (<G? ,SHADOW-SELF-FIRE 0>
	              <TELL " Part of your clothing is actively on fire.">)>
	       <COND (,SHADOW-GARLIC-SCENT
	              <TELL " You smell powerfully of garlic.">)>
	       <CRLF>
	       <RTRUE>)
	      (<AND <VERB? DIAGNOSE>
	            <OR ,SHADOW-SELF-TIED <G? ,SHADOW-SELF-FIRE 0>>>
	       <TELL "You are ">
	       <COND (,SHADOW-SELF-TIED <TELL "tied up">)
	             (T <TELL "mobile">)>
	       <COND (<G? ,SHADOW-SELF-FIRE 0>
	              <TELL " and on fire">)>
	       <TELL ". Neither condition is improved by diagnosis alone." CR>
	       <RTRUE>)
	      (<SHADOW-MATERIAL-HOOK> <RTRUE>)>
	<RFALSE>>

<ROUTINE SHADOW-HELD? (OBJ)
	<COND (<IN? .OBJ ,WINNER> <RTRUE>)>
	<RFALSE>>

<ROUTINE SHADOW-HAS-BOTTLED-WATER? ()
	<COND (<AND <IN? ,BOTTLE ,WINNER>
	            <FSET? ,BOTTLE ,OPENBIT>
	            <IN? ,WATER ,BOTTLE>>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE SHADOW-EXTINGUISH-SELF (SOURCE)
	<COND (<0? ,SHADOW-SELF-FIRE>
	       <TELL "You apply " D .SOURCE " to yourself. The result is dampness without rescue." CR>)
	      (T
	       <SETG SHADOW-SELF-FIRE 0>
	       <COND (<AND <EQUAL? .SOURCE ,BOTTLE> <IN? ,WATER ,BOTTLE>>
	              <REMOVE-CAREFULLY ,WATER>)>
	       <TELL "You drench the burning cloth. Steam rises, the flame dies, and your clothing survives as a strong argument against repetition." CR>)>
	<RTRUE>>

<ROUTINE SHADOW-USE-ON-SELF ()
	<COND (<EQUAL? ,PRSO ,ROPE>
	       <COND (<NOT <SHADOW-HELD? ,ROPE>>
	              <TELL "You would first need to be holding the rope." CR>)
	             (,SHADOW-SELF-TIED
	              <TELL "Additional rope would change this from restraint into upholstery." CR>)
	             (T
	              <SETG SHADOW-SELF-TIED T>
	              <SETG SHADOW-FOLLY-ROPE T>
	              <TELL "You tie the rope around your own legs with admirable craftsmanship and no apparent strategic objective." CR>)>)
	      (<OR <EQUAL? ,PRSO ,TORCH ,CANDLES>
	           <AND <FSET? ,PRSO ,FLAMEBIT> <FSET? ,PRSO ,ONBIT>>>
	       <COND (<NOT <SHADOW-HELD? ,PRSO>>
	              <TELL "You would first need to be holding the flame source." CR>)
	             (<NOT <SHADOW-FLAME? ,PRSO>>
	              <TELL "The " D ,PRSO " is not presently contributing fire to the experiment." CR>)
	             (<G? ,SHADOW-SELF-FIRE 0>
	              <SETG SHADOW-FOLLY-TORCH T>
	              <SETG SHADOW-SELF-FIRE 0>
	              <JIGS-UP
"You improve an existing clothing fire with a second application. The result is decisive, bright, and very brief.">)
	             (T
	              <SETG SHADOW-FOLLY-TORCH T>
	              <SETG SHADOW-SELF-FIRE 1>
	              <TELL "You bring the flame against your sleeve. The cloth begins to smoke. This is the warning stage of the experiment." CR>)>)
	      (<EQUAL? ,PRSO ,WATER>
	       <SHADOW-EXTINGUISH-SELF ,WATER>)
	      (<EQUAL? ,PRSO ,BOTTLE>
	       <COND (<NOT <IN? ,BOTTLE ,WINNER>>
	              <TELL "You would first need to be holding the bottle." CR>)
	             (<NOT <FSET? ,BOTTLE ,OPENBIT>>
	              <TELL "The bottle is closed, which greatly limits its medical usefulness." CR>)
	             (<NOT <IN? ,WATER ,BOTTLE>>
	              <TELL "The empty bottle contributes only a cool glass pressure against your clothing." CR>)
	             (T <SHADOW-EXTINGUISH-SELF ,BOTTLE>)>)
	      (<FSET? ,PRSO ,WEAPONBIT>
	       <COND (<NOT <SHADOW-HELD? ,PRSO>>
	              <TELL "You would first need to be holding the weapon, a requirement that is doing valuable safety work." CR>)
	             (T
	              <SETG SHADOW-FOLLY-WEAPON T>
	              <JIGS-UP
"The weapon performs exactly as designed. Your experiment therefore succeeds in the least useful possible sense.">)>)
	      (<EQUAL? ,PRSO ,GARLIC>
	       <COND (<NOT <SHADOW-HELD? ,GARLIC>>
	              <TELL "You would first need to be holding the garlic." CR>)
	             (T
	              <SETG SHADOW-GARLIC-SCENT T>
	              <TELL "You rub the garlic over your clothing. You are now protected against close conversation." CR>)>)
	      (<EQUAL? ,PRSO ,LAMP>
	       <COND (<AND <FSET? ,LAMP ,ONBIT> <SHADOW-HELD? ,LAMP>>
	              <TELL "You hold the brass lantern close. Its electric warmth is reassuring and notably less combustible than the torch." CR>)
	             (T
	              <TELL "The lantern offers neither warmth nor revelation in its present condition." CR>)>)
	      (T
	       <TELL "You attempt to use the " D ,PRSO " on yourself. Your body declines to expose a compatible interface." CR>)>
	<RTRUE>>

<ROUTINE V-SHADOW-USE-ON ("AUX" MAT)
	<COND (<EQUAL? ,PRSI ,ME>
	       <SHADOW-USE-ON-SELF>)
	      (<AND <EQUAL? ,PRSO ,WATER ,BOTTLE>
	            <EQUAL? ,PRSI ,TORCH ,CANDLES>>
	       <COND (<AND <EQUAL? ,PRSO ,BOTTLE> <NOT <SHADOW-HAS-BOTTLED-WATER?>>>
	              <TELL "The bottle must be open and contain water first." CR>)
	             (T
	              <SHADOW-PERFORM ,V?LAMP-OFF ,PRSI>)>)
	      (<AND <SHADOW-FLAME? ,PRSO>
	            <EQUAL? ,PRSI ,TORCH ,CANDLES>>
	       <COND (<SHADOW-FLAME? ,PRSI>
	              <TELL "Both flame sources are already lit. Introducing them adds drama but no illumination." CR>)
	             (T
	              <SHADOW-PERFORM ,V?LAMP-ON ,PRSI ,PRSO>)>)
	      (<AND <EQUAL? ,PRSO ,TORCH ,LAMP>
	            <EQUAL? ,PRSI ,MIRROR-1 ,MIRROR-2>>
	       <COND (<OR <SHADOW-FLAME? ,TORCH>
	                  <AND <EQUAL? ,PRSO ,LAMP> <FSET? ,LAMP ,ONBIT>>>
	              <SETG SHADOW-MIRROR-DIAGNOSED T>
	              <TELL "The light multiplies across the enormous mirror. For an instant your reflected shadow turns a fraction later than you do." CR>)
	             (T
	              <TELL "The dark light source produces an equally dark reflection." CR>)>)
	      (<AND <SHADOW-FLAME? ,PRSO> <FSET? ,PRSI ,BURNBIT>>
	       <COND (<OR <IN? ,PRSI ,WINNER> <IN? ,WINNER ,PRSI>>
	              <SETG SHADOW-FOLLY-CARRIED-FIRE T>)>
	       <SHADOW-PERFORM ,V?BURN ,PRSI ,PRSO>)
	      (<AND <FSET? ,PRSO ,WEAPONBIT> <FSET? ,PRSI ,BURNBIT>>
	       <SHADOW-PERFORM ,V?CUT ,PRSI ,PRSO>)
	      (<AND <EQUAL? ,PRSO ,WATER ,BOTTLE>
	            <EQUAL? <SET MAT <SHADOW-MATERIAL-OF ,PRSI>> ,SHADOW-MAT-METAL>>
	       <TELL "Water runs over the metal, briefly darkening dust and accomplishing no mechanical reform." CR>)
	      (T
	       <TELL "The " D ,PRSO " and the " D ,PRSI " acknowledge one another without discovering a shared purpose. Try a more specific physical verb." CR>)>
	<RTRUE>>

<ROUTINE V-SHADOW-LIGHTS ("AUX" (SEEN <>))
	<TELL "Visible light sources:" CR>
	<COND (<ACCESSIBLE? ,LAMP>
	       <SET SEEN T>
	       <COND (<FSET? ,LAMP ,ONBIT>
	              <TELL "- The brass lantern gives a steady electric glow." CR>)
	             (T
	              <TELL "- The brass lantern is dark." CR>)>)>
	<COND (<ACCESSIBLE? ,TORCH>
	       <SET SEEN T>
	       <COND (<SHADOW-FLAME? ,TORCH>
	              <TELL "- The ivory torch burns with an open, unwavering flame." CR>)
	             (T
	              <TELL "- The ivory torch is extinguished." CR>)>)>
	<COND (<ACCESSIBLE? ,CANDLES>
	       <SET SEEN T>
	       <COND (<SHADOW-FLAME? ,CANDLES>
	              <TELL "- The candles burn with two small ritual flames." CR>)
	             (T
	              <TELL "- The candles are dark and cooling." CR>)>)>
	<COND (<G? ,SHADOW-SELF-FIRE 0>
	       <SET SEEN T>
	       <TELL "- Your clothing is providing unsafe local illumination." CR>)>
	<COND (<NOT .SEEN>
	       <TELL "- No visible light source is active or within reach." CR>)>>

<ROUTINE V-SHADOW-FOLLIES ("AUX" (COUNT 0))
	<TELL "Mortal follies discovered:" CR>
	<COND (,SHADOW-FOLLY-TORCH
	       <SET COUNT <+ .COUNT 1>>
	       <TELL "- Personal torch maintenance." CR>)>
	<COND (,SHADOW-FOLLY-WEAPON
	       <SET COUNT <+ .COUNT 1>>
	       <TELL "- Weapon performance testing on the operator." CR>)>
	<COND (,SHADOW-FOLLY-ROPE
	       <SET COUNT <+ .COUNT 1>>
	       <TELL "- Improvised self-restraint before travel." CR>)>
	<COND (,SHADOW-FOLLY-CARRIED-FIRE
	       <SET COUNT <+ .COUNT 1>>
	       <TELL "- Burning an object while personally attached to the outcome." CR>)>
	<COND (<0? .COUNT>
	       <TELL "- None yet. This reflects opportunity, not judgment." CR>)
	      (T
	       <TELL "Total discovered: " N .COUNT CR>)>>

<ROUTINE V-SHADOW-WORDS ()
	<TELL "Learned spoken words:" CR>
	<COND (,SHADOW-MELZAR-KNOWN
	       <TELL "- MELZAR: an obsolete Great Underground Empire maintenance diagnostic." CR>)
	      (T
	       <TELL "- None. Written material may contain more than ordinary prose." CR>)>>

<ROUTINE V-SHADOW-MELZAR ()
	<COND (<NOT ,SHADOW-MELZAR-KNOWN>
	       <TELL "The syllables sound impressive but carry no learned structure. Somewhere, a dictionary remains unconvinced." CR>)
	      (<OR <EQUAL? ,HERE ,WEST-OF-HOUSE ,NORTH-OF-HOUSE>
	           <EQUAL? ,HERE ,SOUTH-OF-HOUSE ,EAST-OF-HOUSE>>
	       <TELL "A cold voice reports: PRIMARY ENTRANCE INACCESSIBLE. SECONDARY APERTURE REGISTERED ON EASTERN EXTERIOR." CR>)
	      (<EQUAL? ,HERE ,DAM-ROOM>
	       <TELL "A cold voice reports: CONTROL SYSTEM ">
	       <COND (,GATES-OPEN <TELL "ACTIVE; SLUICE GATES OPEN">)
	             (T <TELL "INACTIVE OR INCOMPLETE; INSPECT CONTROLS AND TURNING HARDWARE">)>
	       <TELL "." CR>)
	      (<EQUAL? ,HERE <LOC ,MIRROR-1> <LOC ,MIRROR-2>>
	       <SETG SHADOW-MIRROR-DIAGNOSED T>
	       <TELL "The mirror clouds from within. Your reflected shadow moves one heartbeat late, then snaps back into obedience." CR>)
	      (<NOT ,LIT>
	       <TELL "A cold geometric flash outlines walls and exits for a single instant. It vanishes before becoming a usable light source." CR>)
	      (T
	       <TELL "A cold voice reports: NO REGISTERED MAINTENANCE FAULT IN THE IMMEDIATE VICINITY." CR>)>>

<ROUTINE SHADOW-RECAP ("AUX" (SEEN <>))
	<COND (,SHADOW-SELF-TIED
	       <SET SEEN T>
	       <TELL "- You have tied your own legs with the rope." CR>)>
	<COND (,SHADOW-MELZAR-KNOWN
	       <SET SEEN T>
	       <TELL "- You learned the maintenance word MELZAR from the owner's manual." CR>)>
	<COND (,SHADOW-MIRROR-DIAGNOSED
	       <SET SEEN T>
	       <TELL "- Light or spoken diagnostics revealed a delayed shadow in the enormous mirrors." CR>)>
	<COND (<G? ,SHADOW-SELF-FIRE 0>
	       <SET SEEN T>
	       <TELL "- Your clothing is currently on fire." CR>)>
	<COND (.SEEN <RTRUE>)>
	<RFALSE>>
