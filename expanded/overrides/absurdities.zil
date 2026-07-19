"Adventurer Misconduct layer for project-local Zork I Release 121."

;"These responses reward ridiculous but understandable commands. They do not
  replace canonical puzzle solutions, manufacture treasure, remove enemies, or
  turn jokes into secret requirements. The player may behave foolishly without
  the game behaving carelessly."

<SYNTAX FOLLY = V-FOLLY>
<SYNONYM FOLLY NONSENSE MISCHIEF>

<SYNTAX THROW OBJECT = V-ABS-THROW>

<SYNTAX HUG OBJECT = V-ABS-HUG>
<SYNONYM HUG EMBRACE CUDDLE>

<SYNTAX LICK OBJECT = V-ABS-LICK>
<SYNONYM LICK LAP>

<SYNTAX RIDE OBJECT = V-ABS-RIDE>
<SYNONYM RIDE MOUNT>

<SYNTAX MARRY OBJECT = V-ABS-MARRY>
<SYNONYM MARRY WED>

<SYNTAX APOLOGIZE = V-ABS-APOLOGIZE>
<SYNTAX APOLOGIZE TO OBJECT = V-ABS-APOLOGIZE>
<SYNONYM APOLOGIZE APOLOGISE>

<SYNTAX INSULT OBJECT = V-ABS-INSULT>
<SYNONYM INSULT MOCK>

<SYNTAX COMPLIMENT OBJECT = V-ABS-COMPLIMENT>
<SYNONYM COMPLIMENT PRAISE FLATTER>

<SYNTAX DANCE = V-ABS-DANCE>
<SYNTAX DANCE WITH OBJECT = V-ABS-DANCE>

<SYNTAX JUGGLE OBJECT = V-ABS-JUGGLE>

<SYNTAX HEADBUTT OBJECT = V-ABS-HEADBUTT>
<SYNONYM HEADBUTT HEAD-BUTT BUTT>

<SYNTAX SACK OBJECT = V-ABS-SACK>
<SYNONYM SACK BAG>

<SYNTAX CUT DOWN OBJECT WITH OBJECT = V-ABS-CUT-DOWN>
<SYNTAX CHOP OBJECT WITH OBJECT = V-ABS-CUT-DOWN>
<SYNTAX CHOP DOWN OBJECT WITH OBJECT = V-ABS-CUT-DOWN>
<SYNTAX FELL OBJECT WITH OBJECT = V-ABS-CUT-DOWN>

<SYNTAX SLEEP = V-ABS-SLEEP>
<SYNTAX SLEEP IN OBJECT = V-ABS-SLEEP>
<SYNONYM SLEEP NAP>

<SYNTAX YELL AT OBJECT = V-ABS-YELL>

<GLOBAL ABS-THREW-SELF <>>
<GLOBAL ABS-THREW-TROLL <>>
<GLOBAL ABS-THREW-VOICE <>>
<GLOBAL ABS-THREW-FIT <>>
<GLOBAL ABS-SACKED-TROLL <>>
<GLOBAL ABS-KILLED-WITH-SELF <>>
<GLOBAL ABS-ATE-NEST <>>
<GLOBAL ABS-WORE-NEST <>>
<GLOBAL ABS-CHOPPED-TREE <>>
<GLOBAL ABS-MARRIED-SCENERY <>>
<GLOBAL ABS-TREE-CHOPS 0>
<GLOBAL ABS-TROLL-SACKS 0>

<OBJECT ABS-SELF
	(IN GLOBAL-OBJECTS)
	(SYNONYM SELF MYSELF ME)
	(DESC "yourself")
	(FLAGS ACTORBIT NDESCBIT)
	(ACTION ABS-SELF-F)>

<OBJECT ABS-VOICE
	(IN GLOBAL-OBJECTS)
	(SYNONYM VOICE WORDS)
	(DESC "your voice")
	(FLAGS NDESCBIT)
	(ACTION ABS-VOICE-F)>

<OBJECT ABS-FIT
	(IN GLOBAL-OBJECTS)
	(SYNONYM FIT TANTRUM)
	(ADJECTIVE TEMPER)
	(DESC "fit of temper")
	(FLAGS NDESCBIT)
	(ACTION ABS-FIT-F)>

<ROUTINE ABS-HAS-FOLLY? ()
	<COND (<OR ,ABS-THREW-SELF ,ABS-THREW-TROLL ,ABS-THREW-VOICE
	           ,ABS-THREW-FIT ,ABS-SACKED-TROLL ,ABS-KILLED-WITH-SELF
	           ,ABS-ATE-NEST ,ABS-WORE-NEST ,ABS-CHOPPED-TREE
	           ,ABS-MARRIED-SCENERY>
	       <RTRUE>)
	      (T <RFALSE>)>>

<ROUTINE V-FOLLY ()
	<TELL "FROBOZZ OFFICE OF ADVENTURER MISCONDUCT" CR
	      "Provisional record of unnecessary acts:" CR>
	<COND (<NOT <ABS-HAS-FOLLY?>>
	       <TELL "- No certifiable misconduct has yet survived inspection." CR>)
	      (T
	       <COND (,ABS-THREW-SELF
	              <TELL "- Attempted to use yourself as self-propelled ammunition." CR>)>
	       <COND (,ABS-THREW-TROLL
	              <TELL "- Investigated the troll's suitability as siege ordnance." CR>)>
	       <COND (,ABS-THREW-VOICE
	              <TELL "- Threw your voice without obtaining a permit for ventriloquism." CR>)>
	       <COND (,ABS-THREW-FIT
	              <TELL "- Threw a fit and failed to recover it." CR>)>
	       <COND (,ABS-SACKED-TROLL
	              <TELL "- Attempted bulk troll storage in a lunch container." CR>)>
	       <COND (,ABS-KILLED-WITH-SELF
	              <TELL "- Proposed yourself as an offensive weapon." CR>)>
	       <COND (,ABS-ATE-NEST
	              <TELL "- Sampled avian real estate as cuisine." CR>)>
	       <COND (,ABS-WORE-NEST
	              <TELL "- Submitted a bird's nest for consideration as formal headwear." CR>)>
	       <COND (,ABS-CHOPPED-TREE
	              <TELL "- Commenced unauthorized forestry with negligible progress." CR>)>
	       <COND (,ABS-MARRIED-SCENERY
	              <TELL "- Entered negotiations for a structurally complicated marriage." CR>)>)>
	<TELL "All findings remain subject to appeal, ridicule, and processing fees." CR>>

<ROUTINE ABS-THROW-SELF ()
	<SETG ABS-THREW-SELF T>
	<COND (<NOT ,PRSI>
	       <TELL "You crouch, seize yourself firmly by the imagination, and attempt to throw. Gravity rejects the paperwork before launch." CR>)
	      (<EQUAL? ,PRSI ,TROLL>
	       <TELL "You hurl yourself at the troll. He catches you by the shoulders, turns you around, and returns you to sender with insulting efficiency." CR>)
	      (<EQUAL? ,PRSI ,CYCLOPS>
	       <TELL "You launch yourself at the cyclops. His single eye tracks the entire experiment and awards it no points for trajectory." CR>)
	      (<EQUAL? ,PRSI ,TREE ,FOREST>
	       <TELL "You throw yourself at the tree. The tree has several centuries of experience with objects arriving unexpectedly and remains undefeated." CR>)
	      (<EQUAL? ,PRSI ,WHITE-HOUSE ,FRONT-DOOR ,BOARDED-WINDOW>
	       <TELL "You fling yourself at the house. Colonial architecture wins on mass, preparation, and zoning approval." CR>)
	      (<EQUAL? ,PRSI ,MIRROR-1 ,MIRROR-2>
	       <TELL "You throw yourself at the mirror. Your reflection appears to do the same, creating a tactical stalemate at the glass." CR>)
	      (T
	       <TELL "You attempt to throw yourself at the " D ,PRSI ". The problem is not enthusiasm but the absence of a useful place from which to stand while throwing yourself." CR>)>>

<ROUTINE ABS-SELF-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "You look like an adventurer who has begun asking whether the inventory system can contain the inventory owner." CR>)
	      (<VERB? TAKE>
	       <TELL "You already possess yourself, although title remains disputed in several philosophical jurisdictions." CR>)
	      (<VERB? DROP>
	       <TELL "You cannot drop yourself without first becoming someone else's problem." CR>)
	      (<VERB? ABS-THROW>
	       <ABS-THROW-SELF>)
	      (<VERB? ABS-EAT>
	       <TELL "You are not recursive cuisine." CR>)
	      (<VERB? ABS-WEAR>
	       <TELL "You are already wearing yourself, inside out from the universe's point of view." CR>)
	      (<VERB? ABS-HUG>
	       <TELL "You give yourself an encouraging hug. It is emotionally sound and mechanically unproductive." CR>)
	      (<VERB? ABS-KISS>
	       <TELL "You attempt this with dignity. Dignity declines to participate." CR>)
	      (<VERB? ABS-MARRY>
	       <TELL "The ceremony would simplify the guest list but complicate every legal form." CR>)
	      (<VERB? ABS-HEADBUTT>
	       <TELL "The resulting motion resembles determined nodding." CR>)
	      (<VERB? ABS-KILL ATTACK MUNG>
	       <TELL "You decline to confuse adventuring with self-erasure. There are monsters available for that sort of administrative error." CR>)
	      (T <RFALSE>)>>

<ROUTINE ABS-VOICE-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "Your voice is invisible, portable, and considerably braver than the rest of you." CR>)
	      (<VERB? TAKE>
	       <TELL "You clear your throat and confirm that your voice is already in inventory, though not itemized." CR>)
	      (<VERB? DROP>
	       <TELL "You lower your voice. It remains attached." CR>)
	      (<VERB? RAISE>
	       <TELL "You raise your voice. Nearby acoustics file a complaint." CR>)
	      (<VERB? LOWER>
	       <TELL "You lower your voice until it is almost respectable." CR>)
	      (<VERB? LISTEN>
	       <TELL "You listen to your own voice and discover why other characters keep conversations brief." CR>)
	      (<VERB? ABS-THROW>
	       <SETG ABS-THREW-VOICE T>
	       <COND (,PRSI
	              <TELL "You throw your voice toward the " D ,PRSI ". It lands several feet to the left and pretends this was intentional." CR>)
	             (T
	              <TELL "You throw your voice. It returns shortly afterward, having found no one willing to keep it." CR>)>)
	      (<VERB? ABS-EAT>
	       <TELL "You eat your words. They are dry, heavily seasoned with regret, and difficult to swallow." CR>)
	      (<VERB? ABS-WEAR>
	       <TELL "You put on a different voice. It fits badly around the vowels." CR>)
	      (T <RFALSE>)>>

<ROUTINE ABS-FIT-F ()
	<COND (<VERB? ABS-THROW>
	       <SETG ABS-THREW-FIT T>
	       <TELL "You throw a magnificent fit. It bounces once, frightens no one, and is immediately assessed a littering fee." CR>)
	      (<VERB? TAKE>
	       <TELL "You already appear to have one available." CR>)
	      (<VERB? EXAMINE>
	       <TELL "It is a compact tantrum with room for considerable expansion." CR>)
	      (T <RFALSE>)>>

<ROUTINE V-ABS-THROW ()
	<COND (<EQUAL? ,PRSO ,ABS-SELF>
	       <ABS-THROW-SELF>)
	      (<EQUAL? ,PRSO ,ABS-VOICE>
	       <ABS-VOICE-F>)
	      (<EQUAL? ,PRSO ,ABS-FIT>
	       <ABS-FIT-F>)
	      (<EQUAL? ,PRSO ,TROLL>
	       <SETG ABS-THREW-TROLL T>
	       <COND (,PRSI
	              <TELL "You search for a grip on the troll suitable for throwing him at the " D ,PRSI ". The troll assists by remaining troll-shaped, hostile, and several hundred pounds beyond optimism." CR>)
	             (T
	              <TELL "You attempt to throw the troll. He watches you calculate leverage and begins laughing before you touch him." CR>)>)
	      (<NOT <IN? ,PRSO ,WINNER>>
	       <TELL "You would first need to be holding the " D ,PRSO ". Metaphor is not a recognized lifting aid." CR>)
	      (<NOT ,PRSI>
	       <TELL "You throw the " D ,PRSO " straight up and catch it again. This proves gravity and very little else." CR>)
	      (<FSET? ,PRSI ,ACTORBIT>
	       <PERFORM ,V?THROW ,PRSO ,PRSI>)
	      (T
	       <MOVE ,PRSO ,HERE>
	       <TELL "The " D ,PRSO " strikes the " D ,PRSI " with a noise suggesting that neither object was consulted. It falls nearby." CR>)>>

<ROUTINE V-ABS-EAT ()
	<COND (<FSET? ,PRSO ,FOODBIT>
	       <PERFORM ,V?EAT ,PRSO>)
	      (<EQUAL? ,PRSO ,ABS-SELF>
	       <TELL "You are not recursive cuisine." CR>)
	      (<EQUAL? ,PRSO ,ABS-VOICE>
	       <ABS-VOICE-F>)
	      (<EQUAL? ,PRSO ,TROLL>
	       <TELL "There is too much troll, too little seasoning, and no known table capable of supporting the proposal." CR>)
	      (<EQUAL? ,PRSO ,WHITE-HOUSE>
	       <TELL "The white house is colonial architecture, not a colonial breakfast." CR>)
	      (T
	       <TELL "You take an experimental bite of the " D ,PRSO ". It tastes exactly as much like " D ,PRSO " as it looks, and considerably more permanent." CR>)>>

<ROUTINE V-ABS-KILL ()
	<COND (<EQUAL? ,PRSO ,ABS-SELF>
	       <TELL "You decline to become both assailant and paperwork." CR>)
	      (<EQUAL? ,PRSI ,ABS-SELF>
	       <SETG ABS-KILLED-WITH-SELF T>
	       <COND (<EQUAL? ,PRSO ,TROLL>
	              <TELL "You present yourself as the weapon. The troll tests your balance, finds you poorly weighted, and returns you to the armory." CR>)
	             (T
	              <TELL "Using yourself as a weapon creates serious difficulties involving grip, range, and who is expected to swing whom." CR>)>)
	      (<EQUAL? ,PRSI ,ABS-VOICE>
	       <TELL "You attack the " D ,PRSO " with your voice. The assault causes no injury but establishes motive." CR>)
	      (<NOT ,PRSI>
	       <TELL "With what? Your personality has not been rated for combat." CR>)
	      (<NOT <FSET? ,PRSI ,WEAPONBIT>>
	       <TELL "The " D ,PRSI " has many possible uses. Being a credible weapon is not among the advertised ones." CR>)
	      (<NOT <IN? ,PRSI ,WINNER>>
	       <TELL "You would first need to be holding the " D ,PRSI "." CR>)
	      (T
	       <PERFORM ,V?ATTACK ,PRSO ,PRSI>)>>

<ROUTINE V-ABS-PUT ()
	<COND (<AND <EQUAL? ,PRSO ,TROLL> <EQUAL? ,PRSI ,SANDWICH-BAG>>
	       <SETG ABS-SACKED-TROLL T>
	       <SETG ABS-TROLL-SACKS <+ ,ABS-TROLL-SACKS 1>>
	       <COND (<EQUAL? ,ABS-TROLL-SACKS 1>
	              <TELL "You open the brown sack and attempt to insert the troll. The sack can accommodate lunch. The troll can accommodate a sack, several lunches, and the person holding them." CR>)
	             (T
	              <TELL "The troll recognizes the sack and asks whether you have obtained a larger troll since the previous attempt." CR>)>)
	      (<AND <EQUAL? ,PRSO ,ABS-SELF> <EQUAL? ,PRSI ,SANDWICH-BAG>>
	       <TELL "You begin with your head. The sack immediately files a capacity objection and smells more strongly of peppers." CR>)
	      (<AND <EQUAL? ,PRSO ,ABS-VOICE> <EQUAL? ,PRSI ,BOTTLE>>
	       <TELL "You whisper into the bottle and close your mouth expectantly. The bottle contains no measurable voice, but now knows a secret." CR>)
	      (<NOT <IN? ,PRSO ,WINNER>>
	       <TELL "You must first be holding the " D ,PRSO ". Possession remains regrettably literal." CR>)
	      (T
	       <PERFORM ,V?PUT ,PRSO ,PRSI>)>>

<ROUTINE V-ABS-HUG ()
	<COND (<EQUAL? ,PRSO ,TROLL>
	       <TELL "You advance with open arms. The troll raises the axe, clarifying the current boundary policy." CR>)
	      (<EQUAL? ,PRSO ,CYCLOPS>
	       <TELL "The cyclops is approximately one eye more receptive than the troll and several tons less approachable." CR>)
	      (<EQUAL? ,PRSO ,TREE ,FOREST>
	       <TELL "You embrace the tree. It is sturdy, reserved, and unwilling to define the relationship." CR>)
	      (<EQUAL? ,PRSO ,WHITE-HOUSE>
	       <TELL "You hug the house. The house remains emotionally boarded." CR>)
	      (<EQUAL? ,PRSO ,ABS-SELF>
	       <ABS-SELF-F>)
	      (T
	       <TELL "You hug the " D ,PRSO ". The gesture is accepted as evidence, not affection." CR>)>>

<ROUTINE V-ABS-LICK ()
	<COND (<EQUAL? ,PRSO ,TROLL>
	       <TELL "The troll withdraws half a step, which is the first tactical success this idea has produced." CR>)
	      (<EQUAL? ,PRSO ,TREE ,FOREST>
	       <TELL "The bark tastes of rain, insects, and an immediate reconsideration of your methods." CR>)
	      (<EQUAL? ,PRSO ,MIRROR-1 ,MIRROR-2>
	       <TELL "The mirror records the event perfectly and threatens to retain it forever." CR>)
	      (<EQUAL? ,PRSO ,WHITE-HOUSE>
	       <TELL "The paint tastes old enough to have opinions about your upbringing." CR>)
	      (T
	       <TELL "You lick the " D ,PRSO ". The experiment produces data no responsible scholar requested." CR>)>>

<ROUTINE V-ABS-WEAR ()
	<COND (<EQUAL? ,PRSO ,NEST>
	       <SETG ABS-WORE-NEST T>
	       <TELL "You balance the nest on your head. It is rustic, unstable, and already zoned for a different species." CR>)
	      (<EQUAL? ,PRSO ,SANDWICH-BAG>
	       <TELL "You pull the brown sack over your head. The world becomes dark and smells decisively of lunch." CR>)
	      (<EQUAL? ,PRSO ,TROLL>
	       <TELL "The troll is not available in your size, temperament, or price range." CR>)
	      (<EQUAL? ,PRSO ,TREE ,FOREST>
	       <TELL "The tree would wear you more convincingly than you could wear it." CR>)
	      (<EQUAL? ,PRSO ,ABS-VOICE>
	       <ABS-VOICE-F>)
	      (<EQUAL? ,PRSO ,ABS-SELF>
	       <ABS-SELF-F>)
	      (T
	       <PERFORM ,V?WEAR ,PRSO>)>>

<ROUTINE V-ABS-RIDE ()
	<COND (<EQUAL? ,PRSO ,TROLL>
	       <TELL "You attempt to mount the troll. He is neither surprised nor cooperative, suggesting previous adventurers were also idiots." CR>)
	      (<EQUAL? ,PRSO ,CYCLOPS>
	       <TELL "The cyclops has no saddle, no patience, and one excellent view of your approach." CR>)
	      (<EQUAL? ,PRSO ,TREE ,FOREST>
	       <TELL "The tree is stationary transportation with excellent fuel economy and disappointing range." CR>)
	      (<FSET? ,PRSO ,VEHBIT>
	       <PERFORM ,V?BOARD ,PRSO>)
	      (T
	       <TELL "The " D ,PRSO " lacks the customary controls, seating, and consent." CR>)>>

<ROUTINE V-ABS-MARRY ()
	<COND (<EQUAL? ,PRSO ,TROLL>
	       <TELL "The troll requests a dowry, three references, and proof that you understand what the axe is for." CR>)
	      (<EQUAL? ,PRSO ,CYCLOPS>
	       <TELL "The cyclops says he has only eye for you. Unfortunately, that eye is evaluating you as dinner." CR>)
	      (<EQUAL? ,PRSO ,TREE ,FOREST>
	       <SETG ABS-MARRIED-SCENERY T>
	       <TELL "You propose to the tree. It asks for time, by which it appears to mean several decades." CR>)
	      (<EQUAL? ,PRSO ,WHITE-HOUSE>
	       <SETG ABS-MARRIED-SCENERY T>
	       <TELL "The house is attractive, established, and emotionally unavailable behind boards." CR>)
	      (<EQUAL? ,PRSO ,ABS-SELF>
	       <ABS-SELF-F>)
	      (T
	       <TELL "The " D ,PRSO " declines on grounds of incompatible object classes." CR>)>>

<ROUTINE V-ABS-APOLOGIZE ()
	<COND (<NOT ,PRSO>
	       <TELL "You apologize generally. The dungeon accepts this as a promising beginning." CR>)
	      (<EQUAL? ,PRSO ,TROLL>
	       <TELL "The troll accepts your apology but not your continued presence." CR>)
	      (<EQUAL? ,PRSO ,TREE ,FOREST>
	       <TELL "The tree has heard worse from weather and better from woodpeckers." CR>)
	      (<EQUAL? ,PRSO ,WHITE-HOUSE>
	       <TELL "You apologize to the house. A shutter would slam meaningfully if any were operational." CR>)
	      (T
	       <TELL "You apologize to the " D ,PRSO ". It reserves judgment." CR>)>>

<ROUTINE V-ABS-INSULT ()
	<COND (<EQUAL? ,PRSO ,TROLL>
	       <TELL "You criticize the troll's grooming. He examines the axe, apparently selecting a rebuttal." CR>)
	      (<EQUAL? ,PRSO ,CYCLOPS>
	       <TELL "You make a pointed remark about depth perception. The cyclops makes a broader remark about lunch." CR>)
	      (<EQUAL? ,PRSO ,TREE ,FOREST>
	       <TELL "You call the tree wooden. The attack is accurate but lacks penetration." CR>)
	      (T
	       <TELL "You insult the " D ,PRSO ". The silence that follows is extremely well composed." CR>)>>

<ROUTINE V-ABS-COMPLIMENT ()
	<COND (<EQUAL? ,PRSO ,TROLL>
	       <TELL "You compliment the troll's axe. He agrees, which does not improve your position." CR>)
	      (<EQUAL? ,PRSO ,CYCLOPS>
	       <TELL "You praise the cyclops's eye. He says it has been in the family for years." CR>)
	      (<EQUAL? ,PRSO ,TREE ,FOREST>
	       <TELL "You compliment the tree's branching structure. It accepts this with professional reserve." CR>)
	      (<EQUAL? ,PRSO ,WHITE-HOUSE>
	       <TELL "You praise the house's proportions. It remains boarded but seems slightly more colonial." CR>)
	      (T
	       <TELL "You compliment the " D ,PRSO ". It appears exactly as pleased as before." CR>)>>

<ROUTINE V-ABS-DANCE ()
	<COND (<NOT ,PRSO>
	       <TELL "You perform several steps unsupported by music, tradition, or balance." CR>)
	      (<EQUAL? ,PRSO ,TROLL>
	       <TELL "You invite the troll to dance. He demonstrates an axe movement from a school with very short recitals." CR>)
	      (<EQUAL? ,PRSO ,CYCLOPS>
	       <TELL "The cyclops knows only one step, but it covers most of the room." CR>)
	      (<EQUAL? ,PRSO ,TREE ,FOREST>
	       <TELL "You dance with the tree. It leads slowly and refuses to travel." CR>)
	      (T
	       <TELL "You dance with the " D ,PRSO ". Critics praise the object's restraint." CR>)>>

<ROUTINE V-ABS-JUGGLE ()
	<COND (<EQUAL? ,PRSO ,TROLL>
	       <TELL "The troll is too heavy for juggling and too armed for rehearsal." CR>)
	      (<EQUAL? ,PRSO ,TREE ,FOREST>
	       <TELL "You cannot juggle something whose root system has seniority." CR>)
	      (<EQUAL? ,PRSO ,ABS-SELF>
	       <TELL "You manage a brief hop and decide that self-juggling requires additional selves." CR>)
	      (<NOT <IN? ,PRSO ,WINNER>>
	       <TELL "You would need to be holding the " D ,PRSO " before dropping it artistically." CR>)
	      (T
	       <TELL "You toss the " D ,PRSO " from hand to hand. With only one object, this is less juggling than indecision." CR>)>>

<ROUTINE V-ABS-HEADBUTT ()
	<COND (<EQUAL? ,PRSO ,TROLL>
	       <TELL "Your head meets the troll. The troll treats the event as a weather report." CR>)
	      (<EQUAL? ,PRSO ,TREE ,FOREST>
	       <TELL "You headbutt the tree. The tree refers the matter to the trunk." CR>)
	      (<EQUAL? ,PRSO ,WHITE-HOUSE ,FRONT-DOOR>
	       <TELL "You strike the house forehead-first. The house has foundations; you have learned why." CR>)
	      (<EQUAL? ,PRSO ,MIRROR-1 ,MIRROR-2>
	       <TELL "Your reflection objects at exactly the same moment and with equal force." CR>)
	      (<EQUAL? ,PRSO ,ABS-SELF>
	       <ABS-SELF-F>)
	      (T
	       <TELL "You headbutt the " D ,PRSO ". A useful result fails to emerge from either participant." CR>)>>

<ROUTINE V-ABS-SACK ()
	<COND (<EQUAL? ,PRSO ,TROLL>
	       <SETG ABS-SACKED-TROLL T>
	       <SETG ABS-TROLL-SACKS <+ ,ABS-TROLL-SACKS 1>>
	       <COND (<IN? ,SANDWICH-BAG ,WINNER>
	              <TELL "You flourish the brown sack and attempt to bag the troll. He compares its capacity with his left boot and finds the proposal underfunded." CR>)
	             (T
	              <TELL "You announce your intention to sack the troll. The troll points out that you have neither a sack nor managerial authority." CR>)>)
	      (<EQUAL? ,PRSO ,CYCLOPS>
	       <TELL "The cyclops would require a sack classified as civil engineering." CR>)
	      (<EQUAL? ,PRSO ,THIEF>
	       <TELL "The thief approves of the verb but objects to being its direct object." CR>)
	      (<EQUAL? ,PRSO ,ABS-SELF>
	       <TELL "You attempt to sack yourself. Human resources requests that you first identify the employer." CR>)
	      (T
	       <TELL "The " D ,PRSO " is not currently employed and therefore cannot be sacked." CR>)>>

<ROUTINE ABS-CHOP-TREE ()
	<SETG ABS-CHOPPED-TREE T>
	<SETG ABS-TREE-CHOPS <+ ,ABS-TREE-CHOPS 1>>
	<COND (<NOT ,PRSI>
	       <TELL "You attack the tree with an unspecified cutting implement. The tree wins by default." CR>)
	      (<NOT <EQUAL? ,PRSI ,AXE ,SWORD ,KNIFE ,RUSTY-KNIFE>>
	       <TELL "The " D ,PRSI " is poorly suited to forestry and appears relieved that you asked first." CR>)
	      (<EQUAL? ,ABS-TREE-CHOPS 1>
	       <TELL "You cut a pale notch in the trunk. The tree responds by revealing a much larger quantity of tree behind it." CR>)
	      (<EQUAL? ,ABS-TREE-CHOPS 2>
	       <TELL "A second series of blows produces wood chips, fatigue, and no measurable change in the local horizon." CR>)
	      (T
	       <TELL "You continue the private logging operation. At the present rate, the tree will fall shortly after the Great Underground Empire rises again." CR>)>>

<ROUTINE V-ABS-CUT-DOWN ()
	<COND (<EQUAL? ,PRSO ,TREE ,FOREST>
	       <ABS-CHOP-TREE>)
	      (<AND ,PRSI <FSET? ,PRSI ,WEAPONBIT>>
	       <PERFORM ,V?CUT ,PRSO ,PRSI>)
	      (T
	       <TELL "Cutting down the " D ,PRSO " requires a sharper plan and, traditionally, a sharper object." CR>)>>

<ROUTINE V-ABS-SLEEP ()
	<COND (<NOT ,PRSO>
	       <TELL "You close your eyes briefly. The dungeon uses the opportunity to remain dangerous." CR>)
	      (<EQUAL? ,PRSO ,NEST>
	       <TELL "You attempt to curl up in the nest. It was built for a songbird, not an adventurer with inventory." CR>)
	      (<EQUAL? ,PRSO ,SANDWICH-BAG>
	       <TELL "The sack is too small for sleeping and too fragrant for dreaming." CR>)
	      (<EQUAL? ,PRSO ,TROLL>
	       <TELL "The troll is not bedding, though he may soon arrange for you to lie down." CR>)
	      (T
	       <TELL "The " D ,PRSO " offers no recognized sleeping surface and no complimentary breakfast." CR>)>>

<ROUTINE V-ABS-YELL ()
	<COND (<EQUAL? ,PRSO ,TROLL>
	       <TELL "You yell at the troll. He waits for the useful part, then concludes there was none." CR>)
	      (<EQUAL? ,PRSO ,CYCLOPS>
	       <TELL "You yell at the cyclops. His eye narrows, proving volume is not camouflage." CR>)
	      (<EQUAL? ,PRSO ,WHITE-HOUSE>
	       <TELL "You shout at the house. A faint echo returns marked OCCUPANT UNKNOWN." CR>)
	      (<EQUAL? ,PRSO ,MIRROR-1 ,MIRROR-2>
	       <TELL "You yell at the mirror. Your reflection appears equally forceful and substantially quieter." CR>)
	      (T
	       <TELL "You yell at the " D ,PRSO ". The acoustics are impressed; the object is not." CR>)>>

<ROUTINE V-ABS-KISS ()
	<COND (<EQUAL? ,PRSO ,TROLL>
	       <TELL "The troll places the axe between you with the tact of an experienced chaperone." CR>)
	      (<EQUAL? ,PRSO ,CYCLOPS>
	       <TELL "The cyclops's one eye is sufficient to reject this proposal in full." CR>)
	      (<EQUAL? ,PRSO ,TREE ,FOREST>
	       <TELL "You kiss the bark. The tree does not call, write, or alter its rings." CR>)
	      (<EQUAL? ,PRSO ,NEST>
	       <TELL "You kiss the nest. Somewhere nearby, a bird revises its opinion of mammals." CR>)
	      (<EQUAL? ,PRSO ,WHITE-HOUSE>
	       <TELL "You kiss the house. The paint is cold and the relationship remains one-sided." CR>)
	      (<EQUAL? ,PRSO ,ABS-SELF>
	       <ABS-SELF-F>)
	      (<FSET? ,PRSO ,ACTORBIT>
	       <PERFORM ,V?KISS ,PRSO>)
	      (T
	       <TELL "You kiss the " D ,PRSO ". It offers no encouragement and, mercifully, no witnesses." CR>)>>

<ROUTINE ABS-NEST-F ()
	<COND (<VERB? ABS-EAT>
	       <SETG ABS-ATE-NEST T>
	       <COND (<IN? ,EGG ,NEST>
	              <TELL "The nest is mostly twigs, lint, and occupied avian real estate. Even you hesitate to eat furnished housing." CR>)
	             (T
	              <TELL "You chew one experimental twig. The nest tastes of bark, feathers, and losing an argument with a bird." CR>)>)
	      (<VERB? ABS-WEAR>
	       <SETG ABS-WORE-NEST T>
	       <TELL "You place the nest on your head. It is an ambitious hat and a disappointing nest." CR>)
	      (<VERB? ABS-SLEEP>
	       <TELL "You test the nest for sleeping. It accommodates approximately one elbow and none of your plans." CR>)
	      (<VERB? ABS-LICK>
	       <TELL "The nest tastes exactly like several outdoor materials that should not be tasted together." CR>)
	      (<VERB? ABS-HUG>
	       <TELL "You hug the nest carefully. The nest has survived weather but was not designed for affection at this scale." CR>)
	      (<VERB? ABS-JUGGLE>
	       <TELL "You decline to juggle a structure whose contents may include both treasure and parenthood." CR>)
	      (<VERB? SHAKE KICK MUNG ATTACK>
	       <TELL "The nest shifts alarmingly. Whatever your objective, upsetting a songbird's home is an unnecessarily villainous route to it." CR>)
	      (T <RFALSE>)>>

<ROUTINE ABS-TREE-F ()
	<COND (<VERB? ABS-CUT-DOWN CUT ATTACK MUNG>
	       <ABS-CHOP-TREE>)
	      (<VERB? ABS-EAT>
	       <TELL "You bite the tree. The tree contains more bark than expected and exactly as much as deserved." CR>)
	      (<VERB? ABS-HUG>
	       <TELL "You hug the tree. It is sturdy, reserved, and unwilling to discuss where this is going." CR>)
	      (<VERB? ABS-LICK>
	       <TELL "You lick the bark and immediately gain a deeper respect for cooked food." CR>)
	      (<VERB? ABS-RIDE>
	       <TELL "The tree offers stationary transportation and unlimited waiting." CR>)
	      (<VERB? ABS-MARRY>
	       <SETG ABS-MARRIED-SCENERY T>
	       <TELL "You propose to the tree. It requests a longer courtship, measured in rings." CR>)
	      (<VERB? ABS-HEADBUTT>
	       <TELL "You headbutt the trunk. The tree refers the complaint to its roots." CR>)
	      (<VERB? SHAKE>
	       <TELL "You shake the tree. The upper branches discuss the matter among themselves and drop nothing useful." CR>)
	      (<VERB? KNOCK>
	       <TELL "The trunk answers with a solid wooden report. No one appears to be home, which is botanically encouraging." CR>)
	      (<VERB? TAKE>
	       <TELL "The tree is rooted in place by a system more effective than inventory management." CR>)
	      (T <RFALSE>)>>

<ROUTINE ABS-SACK-F ()
	<COND (<VERB? ABS-EAT>
	       <TELL "The sack tastes of paper, peppers, and prior lunches. None improves the others." CR>)
	      (<VERB? ABS-WEAR>
	       <TELL "You pull the sack over your head. It is dark, aromatic, and strategically unsound." CR>)
	      (<VERB? ABS-SLEEP>
	       <TELL "The sack is sleeping-bag-shaped only to a highly optimistic insect." CR>)
	      (<VERB? ABS-LICK>
	       <TELL "The sack has absorbed enough pepper to make this a self-correcting mistake." CR>)
	      (<VERB? ABS-HEADBUTT>
	       <TELL "The sack yields completely, thereby defeating your technique." CR>)
	      (<VERB? ABS-JUGGLE>
	       <TELL "The sack flops from hand to hand with all the grace of packaged lunch." CR>)
	      (T <SANDWICH-BAG-FCN>)>>

;"Let the custom verbs reach their handlers instead of being consumed by the
  original actor routines. Existing bribe, food, combat, and canonical behavior
  remain exactly as in the expanded layer."

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
	      (<AND <NOT .MODE>
	            <VERB? ABS-THROW ABS-KILL ABS-PUT ABS-HUG ABS-LICK ABS-WEAR
	                   ABS-RIDE ABS-MARRY ABS-APOLOGIZE ABS-INSULT
	                   ABS-COMPLIMENT ABS-DANCE ABS-JUGGLE ABS-HEADBUTT
	                   ABS-SACK ABS-SLEEP ABS-YELL ABS-KISS ABS-EAT>>
	       <RFALSE>)
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
	      (<VERB? ABS-THROW ABS-KILL ABS-PUT ABS-HUG ABS-LICK ABS-WEAR
	              ABS-RIDE ABS-MARRY ABS-APOLOGIZE ABS-INSULT
	              ABS-COMPLIMENT ABS-DANCE ABS-JUGGLE ABS-HEADBUTT
	              ABS-SACK ABS-SLEEP ABS-YELL ABS-KISS ABS-EAT>
	       <RFALSE>)
	      (T <CYCLOPS-FCN>)>>
