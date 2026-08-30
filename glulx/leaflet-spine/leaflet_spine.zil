"RELEASE 1296-1300 LEAFLET-HOUR NOUN HONESTY"

;"Described-world locals for the 1980 first loop. No scenery engine. No GUI."

<OBJECT KITCHEN-CRUMBS
	(IN KITCHEN)
	(SYNONYM CRUMBS PREPARATION)
	(ADJECTIVE FOOD)
	(DESC "crumbs of interrupted cooking")
	(FLAGS NDESCBIT)
	(ACTION KITCHEN-CRUMBS-F)>

<OBJECT TROLL-STAINS
	(IN TROLL-ROOM)
	(SYNONYM BLOODSTAINS STAINS SCRATCHES)
	(ADJECTIVE DEEP)
	(DESC "bloodstains and scratches")
	(FLAGS NDESCBIT)
	(ACTION TROLL-STAINS-F)>

<OBJECT TROLL-HOLE
	(IN TROLL-ROOM)
	(SYNONYM HOLE DOORWAY)
	(ADJECTIVE FORBIDDING WEST)
	(DESC "forbidding west hole")
	(FLAGS NDESCBIT)
	(ACTION TROLL-HOLE-F)>

<OBJECT DAM-WALKWAY
	(IN DAM-ROOM)
	(SYNONYM WALKWAY)
	(ADJECTIVE DAM)
	(DESC "dam walkway")
	(FLAGS NDESCBIT)
	(ACTION DAM-WALKWAY-F)>

<ROUTINE KITCHEN-CRUMBS-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "Someone was cooking here and left in a hurry. The crumbs are leftover work on the table, not a new meal." CR>)
	      (<VERB? TAKE EAT>
	       <TELL "They are stale traces, not food you would choose." CR>)
	      (T <RFALSE>)>>

<ROUTINE TROLL-STAINS-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "The stains and gouges belong to this doorway-room. They are evidence of the axe, not a combat meter." CR>)
	      (T <RFALSE>)>>

<ROUTINE TROLL-HOLE-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "The west opening is a real hole in a wall, the kind a troll can stand in front of. It is a place, not a menu." CR>)
	      (<VERB? ENTER THROUGH WALK>
	       <DO-WALK ,P?WEST>)
	      (T <RFALSE>)>>

<ROUTINE DAM-WALKWAY-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "You are on the walkable crown of Flood Control Dam #3, the only industrial machine of this scale in the empire." CR>)
	      (<VERB? WALK ENTER>
	       <TELL "You are already standing on it." CR>)
	      (T <RFALSE>)>>

<ROUTINE LEAFLET-PANEL-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "The panel is unique to this dam: bolt, bubble, and the gate controls that already work. It is not a generic machine class." CR>)
	      (<VERB? TAKE>
	       <INTEGRAL-PART>)
	      (T <RFALSE>)>>
