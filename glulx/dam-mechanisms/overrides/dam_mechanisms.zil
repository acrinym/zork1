"Focused Flood Control Dam #3 mechanisms for the repository-local Glulx lineage."

;"This layer makes the existing dam machinery legible and experimentally useful
  without bypassing the canonical button, bolt, leak, reservoir, and timing logic.
  It routes reasonable USE commands into real actions, records meaningful state,
  and adds observation around consequences that were already present."

<GLOBAL DAM-MECH-PANEL-DIAGNOSED <>>
<GLOBAL DAM-MECH-INTERLOCK-SEEN <>>
<GLOBAL DAM-MECH-BOLT-ATTEMPTED <>>
<GLOBAL DAM-MECH-GATES-CYCLED <>>
<GLOBAL DAM-MECH-LIGHTS-TOGGLED <>>
<GLOBAL DAM-MECH-LEAK-TRIGGERED <>>
<GLOBAL DAM-MECH-LEAK-REPAIRED <>>
<GLOBAL DAM-MECH-TOOL-PROBED <>>

<ROUTINE DAM-MECH-RESERVOIR-TREND ()
	<COND (,GATES-OPEN
	       <COND (,LOW-TIDE <TELL "low and remaining drained">)
	             (T <TELL "high but falling">)>)
	      (T
	       <COND (,LOW-TIDE <TELL "low but rising">)
	             (T <TELL "high and held behind the closed gates">)>)>>

<ROUTINE DAM-MECH-PANEL-STATUS ()
	<SETG DAM-MECH-PANEL-DIAGNOSED T>
	<TELL "The control panel reports no words, but its physical state is readable:" CR>
	<TELL "- The yellow interlock circuit is ">
	<COND (,GATE-FLAG <TELL "armed">)
	      (T <TELL "disarmed">)>
	<TELL "." CR>
	<TELL "- The sluice gates are ">
	<COND (,GATES-OPEN <TELL "open">)
	      (T <TELL "closed">)>
	<TELL "." CR>
	<TELL "- The reservoir is ">
	<DAM-MECH-RESERVOIR-TREND>
	<TELL "." CR>
	<TELL "- The maintenance-room leak circuit is ">
	<COND (<G? ,WATER-LEVEL 0> <TELL "active and flooding">)
	      (<L? ,WATER-LEVEL 0> <TELL "sealed with all-purpose gunk">)
	      (T <TELL "inactive">)>
	<TELL "." CR>
	<RTRUE>>

<ROUTINE DAM-MECH-BOLT-F ("AUX" BEFORE)
	<COND (<VERB? EXAMINE DIAGNOSE>
	       <SETG DAM-MECH-BOLT-ATTEMPTED T>
	       <TELL "The large metal bolt is the panel's actual mechanical actuator. It will turn only with the wrench while the yellow interlock is armed." CR>
	       <RTRUE>)
	      (<VERB? TOUCH>
	       <TELL "The bolt is cold, slightly corroded, and connected to machinery substantial enough to resent improvisation." CR>
	       <RTRUE>)
	      (<VERB? KNOCK STRIKE LISTEN>
	       <TELL "The bolt answers with a deep metallic note. Somewhere inside the dam, a heavier mechanism gives a delayed sympathetic clunk." CR>
	       <RTRUE>)
	      (<VERB? TURN>
	       <SETG DAM-MECH-BOLT-ATTEMPTED T>
	       <SET BEFORE ,GATES-OPEN>
	       <BOLT-F>
	       <COND (<NOT <EQUAL? .BEFORE ,GATES-OPEN>>
	              <SETG DAM-MECH-GATES-CYCLED T>)>
	       <RTRUE>)
	      (<VERB? TAKE OIL>
	       <BOLT-F>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE DAM-MECH-BUBBLE-F ()
	<COND (<VERB? EXAMINE DIAGNOSE>
	       <SETG DAM-MECH-INTERLOCK-SEEN T>
	       <TELL "The green plastic bubble is a crude interlock indicator. It is ">
	       <COND (,GATE-FLAG <TELL "glowing because the yellow circuit is armed">)
	             (T <TELL "dark because the turning circuit is disarmed">)>
	       <TELL "." CR>
	       <RTRUE>)
	      (<VERB? TOUCH>
	       <TELL "The bubble is smooth plastic. ">
	       <COND (,GATE-FLAG <TELL "A faint vibration accompanies the glow.">)
	             (T <TELL "It is inert and cool.">)>
	       <CRLF>
	       <RTRUE>)
	      (<VERB? KNOCK STRIKE>
	       <TELL "The bubble gives a hollow tick and wisely remains attached to the panel." CR>
	       <RTRUE>)
	      (<VERB? TAKE>
	       <BUBBLE-F>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE DAM-MECH-PANEL-F ()
	<COND (<VERB? EXAMINE DIAGNOSE SEARCH LOOK-INSIDE>
	       <DAM-MECH-PANEL-STATUS>)
	      (<VERB? LISTEN>
	       <TELL "Behind the panel, gears hold a patient mechanical tension. ">
	       <COND (,GATES-OPEN <TELL "The open sluices add a continuous low vibration.">)
	             (T <TELL "The closed sluices leave only the reservoir's distant pressure.">)>
	       <CRLF>
	       <RTRUE>)
	      (<VERB? TOUCH RUB>
	       <TELL "The panel is cold metal with a faint vibration near the bolt and none near the decorative parts." CR>
	       <RTRUE>)
	      (<VERB? KNOCK STRIKE>
	       <TELL "The panel rings broadly; the bolt answers at a lower pitch, identifying itself as the part connected to something serious." CR>
	       <RTRUE>)
	      (<VERB? TAKE MOVE PULL>
	       <INTEGRAL-PART>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE DAM-MECH-BUTTON-F ("AUX" BEFORE)
	<COND (<VERB? EXAMINE DIAGNOSE>
	       <COND (<EQUAL? ,PRSO ,YELLOW-BUTTON>
	              <TELL "The yellow button arms the remote turning interlock; the green bubble above the dam bolt shows the result." CR>)
	             (<EQUAL? ,PRSO ,BROWN-BUTTON>
	              <TELL "The brown button disarms the turning interlock without moving the gates." CR>)
	             (<EQUAL? ,PRSO ,RED-BUTTON>
	              <TELL "The red button controls only the maintenance-room lights." CR>)
	             (T
	              <TELL "The blue button energizes a pipe circuit whose continued reliability is not supported by the surrounding rust." CR>)>
	       <RTRUE>)
	      (<VERB? PUSH>
	       <SET BEFORE ,WATER-LEVEL>
	       <BUTTON-F>
	       <COND (<EQUAL? ,PRSO ,YELLOW-BUTTON>
	              <SETG DAM-MECH-INTERLOCK-SEEN T>)
	             (<EQUAL? ,PRSO ,BROWN-BUTTON>
	              <SETG DAM-MECH-INTERLOCK-SEEN T>)
	             (<EQUAL? ,PRSO ,RED-BUTTON>
	              <SETG DAM-MECH-LIGHTS-TOGGLED T>)
	             (<AND <EQUAL? ,PRSO ,BLUE-BUTTON>
	                   <EQUAL? .BEFORE 0>
	                   <G? ,WATER-LEVEL 0>>
	              <SETG DAM-MECH-LEAK-TRIGGERED T>)>
	       <RTRUE>)
	      (<VERB? READ>
	       <BUTTON-F>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE DAM-MECH-USE-ON ()
	<COND (<AND <EQUAL? ,PRSI ,BOLT> <EQUAL? ,PRSO ,WRENCH>>
	       <SETG DAM-MECH-TOOL-PROBED T>
	       <SHADOW-PERFORM ,V?TURN ,BOLT ,WRENCH>
	       <RTRUE>)
	      (<AND <EQUAL? ,PRSI ,BOLT> <EQUAL? ,PRSO ,SCREWDRIVER>>
	       <SETG DAM-MECH-TOOL-PROBED T>
	       <TELL "The screwdriver fits neither the bolt nor the scale of the mechanism. The wrench is the mechanically honest choice." CR>
	       <RTRUE>)
	      (<AND <EQUAL? ,PRSI ,CONTROL-PANEL> <EQUAL? ,PRSO ,WRENCH>>
	       <SETG DAM-MECH-TOOL-PROBED T>
	       <COND (<NOT <SHADOW-HELD? ,WRENCH>>
	              <TELL "You would first need to be holding the wrench." CR>)
	             (T
	              <TELL "The wrench finds only one credible purchase on the panel: the large bolt." CR>
	              <SHADOW-PERFORM ,V?TURN ,BOLT ,WRENCH>)>
	       <RTRUE>)
	      (<AND <EQUAL? ,PRSI ,CONTROL-PANEL> <EQUAL? ,PRSO ,SCREWDRIVER>>
	       <SETG DAM-MECH-TOOL-PROBED T>
	       <COND (<NOT <SHADOW-HELD? ,SCREWDRIVER>>
	              <TELL "You would first need to be holding the screwdriver." CR>)
	             (T
	              <TELL "The visible seams are riveted and sealed. The screwdriver confirms that this panel was designed by engineers who distrusted future engineers." CR>)>
	       <RTRUE>)
	      (<AND <EQUAL? ,PRSI ,CONTROL-PANEL> <EQUAL? ,PRSO ,GUIDE>>
	       <TELL "The tour guidebook describes the dam's grandeur, workforce, and funding, then becomes mysteriously unhelpful at the point where operating instructions would begin." CR>
	       <RTRUE>)
	      (<AND <EQUAL? ,PRSI ,CONTROL-PANEL> <EQUAL? ,PRSO ,WATER ,BOTTLE>>
	       <COND (<AND <EQUAL? ,PRSO ,BOTTLE> <NOT <SHADOW-HAS-BOTTLED-WATER?>>>
	              <TELL "The bottle must be open and contain water before it can participate in this bad idea." CR>)
	             (T
	              <TELL "Water beads across the sealed metal and runs away. The panel remains functional and your maintenance credentials remain theoretical." CR>)>
	       <RTRUE>)
	      (<AND <EQUAL? ,PRSI ,LEAK> <EQUAL? ,PRSO ,PUTTY>>
	       <COND (<NOT <SHADOW-HELD? ,PUTTY>>
	              <TELL "You would first need to be holding the all-purpose gunk." CR>)
	             (<NOT <G? ,WATER-LEVEL 0>>
	              <TELL "There is no active leak to seal." CR>)
	             (T
	              <SHADOW-PERFORM ,V?PLUG ,LEAK ,PUTTY>
	              <COND (<L? ,WATER-LEVEL 0>
	                     <SETG DAM-MECH-LEAK-REPAIRED T>)>)>
	       <RTRUE>)
	      (<AND <EQUAL? ,PRSI ,LEAK>
	            <EQUAL? ,PRSO ,WRENCH ,SCREWDRIVER>>
	       <SETG DAM-MECH-TOOL-PROBED T>
	       <TELL "The tool can interrogate the pipe, but it cannot replace the missing material. Something that seals rather than turns is required." CR>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE DAM-MECH-MELZAR ()
	<SETG DAM-MECH-PANEL-DIAGNOSED T>
	<TELL "A cold voice reports: FLOOD CONTROL DAM NUMBER THREE." CR>
	<TELL "TURNING INTERLOCK: ">
	<COND (,GATE-FLAG <TELL "ARMED">)
	      (T <TELL "DISARMED">)>
	<TELL ". SLUICE GATES: ">
	<COND (,GATES-OPEN <TELL "OPEN">)
	      (T <TELL "CLOSED">)>
	<TELL ". RESERVOIR: ">
	<DAM-MECH-RESERVOIR-TREND>
	<TELL "." CR>
	<TELL "MAINTENANCE LEAK: ">
	<COND (<G? ,WATER-LEVEL 0> <TELL "ACTIVE">)
	      (<L? ,WATER-LEVEL 0> <TELL "SEALED">)
	      (T <TELL "NONE DETECTED">)>
	<TELL "." CR>
	<RTRUE>>

<ROUTINE DAM-MECH-RECAP ("AUX" (SEEN <>))
	<COND (,DAM-MECH-PANEL-DIAGNOSED
	       <SET SEEN T>
	       <TELL "- You diagnosed Flood Control Dam #3's interlock, sluice, reservoir, and leak state." CR>)>
	<COND (,DAM-MECH-INTERLOCK-SEEN
	       <SET SEEN T>
	       <TELL "- You identified the yellow and brown buttons as the turning-interlock controls." CR>)>
	<COND (,DAM-MECH-BOLT-ATTEMPTED
	       <SET SEEN T>
	       <TELL "- You tested the dam's large mechanical bolt with real tools and real interlock state." CR>)>
	<COND (,DAM-MECH-GATES-CYCLED
	       <SET SEEN T>
	       <TELL "- You cycled the real sluice gates through the canonical wrench-and-bolt mechanism." CR>)>
	<COND (,DAM-MECH-LIGHTS-TOGGLED
	       <SET SEEN T>
	       <TELL "- You verified that the red maintenance button controls the room lights, not the dam." CR>)>
	<COND (,DAM-MECH-LEAK-TRIGGERED
	       <SET SEEN T>
	       <TELL "- You activated the blue pipe circuit and discovered why it was abandoned." CR>)>
	<COND (,DAM-MECH-LEAK-REPAIRED
	       <SET SEEN T>
	       <TELL "- You sealed the active maintenance leak with the real all-purpose gunk." CR>)>
	<COND (,DAM-MECH-TOOL-PROBED
	       <SET SEEN T>
	       <TELL "- You compared the wrench and screwdriver against the dam's actual mechanical interfaces." CR>)>
	<COND (.SEEN <RTRUE>)>
	<RFALSE>>
