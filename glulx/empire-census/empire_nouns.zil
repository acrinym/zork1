"RELEASE 1303 EMPIRE NOUN HONESTY"

;"Remaining described-world locals after 1294-1296. No scenery engine. No GUI."

<OBJECT MAZE-TWISTS
	(IN LOCAL-GLOBALS)
	(SYNONYM PASSAGES PASSAGE MAZE)
	(ADJECTIVE TWISTY LITTLE)
	(DESC "twisty little passages")
	(FLAGS NDESCBIT)
	(ACTION MAZE-TWISTS-F)>

<OBJECT FOREST-SUNLIGHT
	(IN LOCAL-GLOBALS)
	(SYNONYM SUNLIGHT SUN)
	(ADJECTIVE EAST)
	(DESC "sunlight")
	(FLAGS NDESCBIT)
	(ACTION FOREST-SUNLIGHT-F)>

<OBJECT GALLERY-PAINTINGS
	(IN GALLERY)
	(SYNONYM PAINTINGS PAINTING VANDALS HOOKS)
	(ADJECTIVE STOLEN EMPTY)
	(DESC "stolen paintings")
	(FLAGS NDESCBIT)
	(ACTION GALLERY-PAINTINGS-F)>

<OBJECT STUDIO-FIREPLACE
	(IN STUDIO)
	(SYNONYM FIREPLACE HEARTH)
	(ADJECTIVE DARK)
	(DESC "studio fireplace")
	(FLAGS NDESCBIT)
	(ACTION STUDIO-FIREPLACE-F)>

<OBJECT BARROW-DOOR
	(IN STONE-BARROW)
	(SYNONYM DOOR TOMB)
	(ADJECTIVE STONE HUGE)
	(DESC "stone barrow door")
	(FLAGS NDESCBIT)
	(ACTION BARROW-DOOR-F)>

<OBJECT DAM-TOUR-DOORS
	(IN DAM-LOBBY)
	(SYNONYM DOORWAYS DOORWAY PRIVATE)
	(ADJECTIVE OPEN NORTH EAST)
	(DESC "tour doorways")
	(FLAGS NDESCBIT)
	(ACTION DAM-TOUR-DOORS-F)>

<OBJECT MAINT-GEAR
	(IN MAINTENANCE-ROOM)
	(SYNONYM EQUIPMENT GEAR)
	(ADJECTIVE VALUABLE)
	(DESC "ransacked equipment")
	(FLAGS NDESCBIT)
	(ACTION MAINT-GEAR-F)>

<OBJECT TEMPLE-PRAYER
	(IN NORTH-TEMPLE)
	(SYNONYM PRAYER INSCRIPTION LANGUAGE)
	(ADJECTIVE ANCIENT FORGOTTEN)
	(DESC "ancient prayer")
	(FLAGS NDESCBIT READBIT)
	(ACTION TEMPLE-PRAYER-F)>

<OBJECT TEMPLE-PILLARS
	(IN NORTH-TEMPLE)
	(SYNONYM PILLARS PILLAR)
	(ADJECTIVE HUGE MARBLE)
	(DESC "marble pillars")
	(FLAGS NDESCBIT)
	(ACTION TEMPLE-PILLARS-F)>

<OBJECT ALTAR-FLOOR-HOLE
	(IN SOUTH-TEMPLE)
	(SYNONYM HOLE DARKNESS)
	(ADJECTIVE SMALL FLOOR)
	(DESC "altar floor hole")
	(FLAGS NDESCBIT)
	(ACTION ALTAR-FLOOR-HOLE-F)>

<OBJECT ROUND-CAVEINS
	(IN ROUND-ROOM)
	(SYNONYM CAVEINS BLOCKAGE)
	(ADJECTIVE BLOCKED)
	(DESC "cave-ins")
	(FLAGS NDESCBIT)
	(ACTION ROUND-CAVEINS-F)>

<OBJECT CYCLOPS-SIZED-DOOR
	(IN STRANGE-PASSAGE)
	(SYNONYM DOOR OPENING)
	(ADJECTIVE WOODEN OLD LARGE)
	(DESC "cyclops-sized wooden door")
	(FLAGS NDESCBIT)
	(ACTION CYCLOPS-SIZED-DOOR-F)>

<OBJECT STREAM-BEACH
	(IN IN-STREAM)
	(SYNONYM BEACH LANDING)
	(ADJECTIVE NARROW)
	(DESC "narrow beach")
	(FLAGS NDESCBIT)
	(ACTION STREAM-BEACH-F)>

<OBJECT RIVER-ROCKS
	(IN RIVER-2)
	(SYNONYM ROCKS ROCK)
	(ADJECTIVE LARGE WEST)
	(DESC "landing rocks")
	(FLAGS NDESCBIT)
	(ACTION RIVER-ROCKS-F)>

<OBJECT LOST-SOULS
	(IN LAND-OF-LIVING-DEAD)
	(SYNONYM SOULS WEEPING MOANING)
	(ADJECTIVE LOST)
	(DESC "lost souls")
	(FLAGS NDESCBIT)
	(ACTION LOST-SOULS-F)>

<OBJECT CELLAR-CRAWLWAY
	(IN CELLAR)
	(SYNONYM CRAWLWAY PASSAGEWAY)
	(ADJECTIVE NARROW SOUTH NORTH)
	(DESC "cellar crawlway")
	(FLAGS NDESCBIT)
	(ACTION CELLAR-CRAWLWAY-F)>

<ROUTINE MAZE-TWISTS-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "The passages are all alike on purpose. That is the maze, not a menu of distinct hallways." CR>)
	      (T <RFALSE>)>>

<ROUTINE FOREST-SUNLIGHT-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "Eastward the trees thin enough that daylight actually reaches the needles." CR>)
	      (T <RFALSE>)>>

<ROUTINE GALLERY-PAINTINGS-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "The canvases are gone. Empty hooks and cleaner rectangles show where the vandals chose well." CR>)
	      (<VERB? TAKE>
	       <TELL "The vandals already took the paintings." CR>)
	      (T <RFALSE>)>>

<ROUTINE STUDIO-FIREPLACE-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "A dark chimney rises from this fireplace. Paint covers the hearth the way it covers the door." CR>)
	      (<VERB? ENTER CLIMB-FOO CLIMB-UP CLIMB-ON>
	       <DO-WALK ,P?UP>)
	      (T <RFALSE>)>>

<ROUTINE BARROW-DOOR-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "The east face of the barrow is a huge stone door, standing open on a tomb you still cannot see into." CR>)
	      (<VERB? ENTER>
	       <TELL "The dark of the tomb does not become a second map." CR>)
	      (T <RFALSE>)>>

<ROUTINE DAM-TOUR-DOORS-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "The north and east doorways are the old tour route into the private maintenance rooms of Dam #3." CR>)
	      (<VERB? ENTER>
	       <DO-WALK ,P?NORTH>)
	      (T <RFALSE>)>>

<ROUTINE MAINT-GEAR-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "Most of the valuable equipment is gone. The colored buttons remain because they are part of the dam, not loot." CR>)
	      (<VERB? TAKE>
	       <TELL "The ransackers already took what could be carried." CR>)
	      (T <RFALSE>)>>

<ROUTINE TEMPLE-PRAYER-F ()
	<COND (<VERB? EXAMINE READ>
	       <TELL "The inscription is a prayer in a forgotten language. It is writing on this wall, not a spell menu." CR>)
	      (T <RFALSE>)>>

<ROUTINE TEMPLE-PILLARS-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "Huge marble pillars mark the north end of the temple. They are architecture, not a parser hint." CR>)
	      (T <RFALSE>)>>

<ROUTINE ALTAR-FLOOR-HOLE-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "A small hole in the floor leads into darkness. Climbing back up it would be a poor plan." CR>)
	      (<VERB? ENTER>
	       <DO-WALK ,P?DOWN>)
	      (T <RFALSE>)>>

<ROUTINE ROUND-CAVEINS-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "Several passages are blocked by cave-ins. The remaining exits are the ones that still exist." CR>)
	      (T <RFALSE>)>>

<ROUTINE CYCLOPS-SIZED-DOOR-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "An old wooden door with a cyclops-sized opening. It is a real door on this passage, not scenery." CR>)
	      (<VERB? OPEN>
	       <TELL "The opening is already large enough." CR>)
	      (T <RFALSE>)>>

<ROUTINE STREAM-BEACH-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "A narrow beach is the only honest landing from this twisting channel." CR>)
	      (<VERB? ENTER>
	       <DO-WALK ,P?LAND>)
	      (T <RFALSE>)>>

<ROUTINE RIVER-ROCKS-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "Large rocks deny a west landing here. The White Cliffs deny the east." CR>)
	      (T <RFALSE>)>>

<ROUTINE LOST-SOULS-F ()
	<COND (<VERB? EXAMINE LISTEN>
	       <TELL "Thousands of lost souls weep and moan. They are the population of this room, not a soundtrack." CR>)
	      (T <RFALSE>)>>

<ROUTINE CELLAR-CRAWLWAY-F ()
	<COND (<VERB? EXAMINE>
	       <TELL "North is a narrow passageway toward the troll. South is a crawlway toward the chasm." CR>)
	      (<VERB? ENTER>
	       <TELL "North or south is a real choice; the crawlway is not a third map." CR>)
	      (T <RFALSE>)>>
