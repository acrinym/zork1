"Room-density and parser-kindness responses for the repository-local Zork I Glulx lineage."

;"Release 1218 adds only room-scoped PSEUDO scenery for nouns explicitly named
  by existing descriptions. These routines do not add portable objects, exits,
  scores, puzzle state, or generalized natural-language handling."

<GLOBAL ROOM-DENSITY-TROLL-SEEN <>>
<GLOBAL ROOM-DENSITY-GALLERY-SEEN <>>
<GLOBAL ROOM-DENSITY-STUDIO-SEEN <>>
<GLOBAL ROOM-DENSITY-CHASM-SEEN <>>
<GLOBAL ROOM-DENSITY-PASSAGE-SEEN <>>
<GLOBAL ROOM-DENSITY-TREASURE-SEEN <>>
<GLOBAL ROOM-DENSITY-PATH-SEEN <>>

<ROUTINE ROOM-DENSITY-BLOOD-F ()
    <SETG ROOM-DENSITY-TROLL-SEEN T>
    <COND (<VERB? EXAMINE SEARCH LOOK-ON>
           <TELL "The old bloodstains have soaked into cracks in the stone. Some are broad smears; others are small arcs consistent with a badly handled axe." CR>)
          (<VERB? SMELL>
           <TELL "The blood is far too old to smell fresh. Damp stone and troll remain the dominant atmosphere." CR>)
          (<VERB? RUB>
           <TELL "The darkest stains are dry and fixed in the stone. Your fingers gain dust, not evidence." CR>)
          (<VERB? LISTEN>
           <TELL "The bloodstains make no sound. The room supplies enough menace without help from them." CR>)
          (<VERB? TAKE RAISE MOVE PUSH>
           <TELL "The stains are part of the floor and walls now." CR>)
          (T
           <TELL "The old bloodstains record violence but offer no useful mechanism." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-SCRATCHES-F ()
    <SETG ROOM-DENSITY-TROLL-SEEN T>
    <COND (<VERB? EXAMINE SEARCH>
           <TELL "The scratches are deep, irregular, and mostly at axe height. None forms writing, a map, or a concealed latch." CR>)
          (<VERB? RUB>
           <TELL "The gouges are rough-edged and deep enough to catch a fingertip." CR>)
          (<VERB? KNOCK STRIKE>
           <TELL "Stone answers with a compact thud. The scratched section sounds no hollower than the rest." CR>)
          (<VERB? LOOK-BEHIND LOOK-UNDER>
           <TELL "There is nothing behind the scratches except more stone." CR>)
          (<VERB? MOVE PUSH TAKE>
           <TELL "You cannot move damage independently of the wall that bears it." CR>)
          (T
           <TELL "The scratches are scars in the masonry, not a separate object." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-TROLL-HOLE-F ()
    <SETG ROOM-DENSITY-TROLL-SEEN T>
    <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
           <TELL "The western hole is a low, forbidding opening into the maze. Its edges are worn by repeated passage, not recently excavated." CR>)
          (<VERB? LISTEN>
           <TELL "Air moves faintly through the hole, carrying no reliable clue about the maze beyond." CR>)
          (<VERB? SMELL>
           <TELL "Cold stone, stale air, and troll are all available in approximately that order." CR>)
          (<VERB? THROUGH ENTER>
           <DO-WALK ,P?WEST>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The stone lip is chipped and greasy from long use." CR>)
          (<VERB? PUSH MOVE>
           <TELL "The opening is a lack of wall. Pushing it produces no architectural improvement." CR>)
          (T
           <TELL "The hole leads west into the maze." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-TROLL-PASSAGES-F ()
    <SETG ROOM-DENSITY-TROLL-SEEN T>
    <COND (<VERB? EXAMINE SEARCH>
           <TELL "The east and south passages are ordinary stone corridors. The western opening is lower and considerably less inviting." CR>)
          (<VERB? LISTEN>
           <TELL "The passages return faint echoes, but no footsteps distinct from the troll's movements." CR>)
          (<VERB? SMELL>
           <TELL "The southern passage carries slightly less troll." CR>)
          (<VERB? THROUGH ENTER>
           <TELL "Specify east, south, or west; the troll may still have opinions about your choice." CR>)
          (<VERB? RUB KNOCK STRIKE>
           <TELL "The passage walls are cold, scarred stone." CR>)
          (T
           <TELL "The passages are routes, not portable furnishings." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-GALLERY-PAINTINGS-F ()
    <SETG ROOM-DENSITY-GALLERY-SEEN T>
    <COND (<VERB? EXAMINE SEARCH LOOK-ON>
           <TELL "A few paintings remain, mostly landscapes of places that look healthier without adventurers. Empty hooks and cleaner rectangles mark the stolen works." CR>)
          (<VERB? LOOK-BEHIND LOOK-UNDER>
           <TELL "Behind the remaining canvases is bare wall, dust, and no secret exit." CR>)
          (<VERB? SMELL>
           <TELL "Old varnish and dust survive more strongly than artistic inspiration." CR>)
          (<VERB? RUB>
           <TELL "The nearest surviving canvas is dry, cracked, and firmly mounted." CR>)
          (<VERB? KNOCK STRIKE>
           <TELL "The frame gives a wooden tap; the wall behind it sounds solid." CR>)
          (<VERB? TAKE MOVE PUSH>
           <TELL "The surviving paintings are fixed in place and not counted among the gallery's portable treasures." CR>)
          (T
           <TELL "The paintings provide atmosphere, not loot." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-GALLERY-FRAMES-F ()
    <SETG ROOM-DENSITY-GALLERY-SEEN T>
    <COND (<VERB? EXAMINE SEARCH>
           <TELL "Some frames still hold paintings. Others are only pale outlines, hooks, and splintered corners left by efficient vandals." CR>)
          (<VERB? LOOK-BEHIND>
           <TELL "The frames conceal no switch, safe, or passage." CR>)
          (<VERB? RUB>
           <TELL "The wood is dry and dusty." CR>)
          (<VERB? KNOCK STRIKE>
           <TELL "A frame answers with a small wooden clack." CR>)
          (<VERB? TAKE MOVE PUSH>
           <TELL "The remaining frames are secured to the wall." CR>)
          (T
           <TELL "The frames mostly document what is no longer here." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-GALLERY-VANDALS-F ()
    <SETG ROOM-DENSITY-GALLERY-SEEN T>
    <COND (<VERB? FIND EXAMINE SEARCH>
           <TELL "The vandals are long gone. Their useful contribution is the obvious route of escape: north or west." CR>)
          (<VERB? LISTEN>
           <TELL "No tasteful vandal is currently making enough noise to locate." CR>)
          (<VERB? SMELL>
           <TELL "Whatever scent the vandals possessed has yielded to dust and varnish." CR>)
          (T
           <TELL "You cannot interact with people who have already left the room and the story." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-STUDIO-FLOOR-F ()
    <SETG ROOM-DENSITY-STUDIO-SEEN T>
    <COND (<VERB? EXAMINE SEARCH LOOK-ON LOOK-UNDER>
           <TELL "The floor is layered with old paint spatters, footprints, brush marks, and several colors that probably never had names." CR>)
          (<VERB? RUB>
           <TELL "The paint is dry and uneven. A few raised drops feel like tiny stone beads." CR>)
          (<VERB? SMELL>
           <TELL "The floor smells faintly of old oil paint and chimney soot." CR>)
          (<VERB? KNOCK STRIKE>
           <TELL "The floor answers solidly. No hollow compartment announces itself." CR>)
          (<VERB? MOVE PUSH TAKE>
           <TELL "The floor remains committed to supporting the studio." CR>)
          (T
           <TELL "The painted floor contains no movable discovery." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-FIREPLACE-F ()
    <SETG ROOM-DENSITY-STUDIO-SEEN T>
    <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
           <TELL "The fireplace is cold and soot-darkened. Its flue narrows into the climbable chimney above." CR>)
          (<VERB? LISTEN>
           <TELL "A faint draft moves in the chimney; nothing else answers." CR>)
          (<VERB? SMELL>
           <TELL "Old ash, soot, and damp masonry linger in the hearth." CR>)
          (<VERB? RUB>
           <TELL "Soot blackens your fingers immediately." CR>)
          (<VERB? KNOCK STRIKE>
           <TELL "The masonry gives a solid, ash-muted thump." CR>)
          (<VERB? ENTER THROUGH CLIMB-UP CLIMB-FOO>
           <TELL "The fireplace itself is too cramped; the chimney above is the route you can attempt to climb." CR>)
          (<VERB? TAKE MOVE PUSH>
           <TELL "The fireplace is masonry, not furniture." CR>)
          (T
           <TELL "The cold fireplace serves chiefly as the mouth of the chimney." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-CHASM-PATH-F ()
    <SETG ROOM-DENSITY-CHASM-SEEN T>
    <COND (<VERB? EXAMINE SEARCH>
           <TELL "The path hugs the eastern edge of the chasm. It is narrow but continuous toward the gallery." CR>)
          (<VERB? LOOK-UNDER>
           <TELL "Below the path is the same unseen depth that makes the chasm memorable." CR>)
          (<VERB? LISTEN>
           <TELL "Small echoes fall away from the path and return without useful depth information." CR>)
          (<VERB? RUB>
           <TELL "The path is rough stone with loose grit near the edge." CR>)
          (<VERB? MOVE PUSH TAKE>
           <TELL "Moving the path would require revising the surrounding geology." CR>)
          (T
           <TELL "The path continues east and west along the chasm edge." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-CHASM-PASSAGE-F ()
    <SETG ROOM-DENSITY-CHASM-SEEN T>
    <COND (<VERB? EXAMINE SEARCH LOOK-INSIDE>
           <TELL "The narrow northern passage slopes toward the cellar. It contains no branch or hidden opening before leaving sight." CR>)
          (<VERB? LISTEN>
           <TELL "The passage carries a faint damp echo from the cellar." CR>)
          (<VERB? SMELL>
           <TELL "Cool cellar air drifts from the north." CR>)
          (<VERB? THROUGH ENTER>
           <DO-WALK ,P?NORTH>
           <RTRUE>)
          (<VERB? RUB KNOCK STRIKE>
           <TELL "The passage is cut through ordinary cold stone." CR>)
          (T
           <TELL "The passage is the route north to the cellar." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-PASSAGE-DOOR-F ()
    <SETG ROOM-DENSITY-PASSAGE-SEEN T>
    <COND (<VERB? EXAMINE READ>
           <TELL "The old wooden door stands at the east end of the passage. Its cyclops-sized opening has replaced most of the practical barrier." CR>)
          (<VERB? LOOK-INSIDE LOOK-BEHIND THROUGH>
           <TELL "Through the opening you can see the living room beyond." CR>)
          (<VERB? LISTEN>
           <TELL "The opening carries the quiet of the living room." CR>)
          (<VERB? RUB>
           <TELL "The remaining wood is old, dry, and worn smooth around the opening." CR>)
          (<VERB? KNOCK STRIKE>
           <TELL "The surviving door gives a broad wooden boom through the passage." CR>)
          (<VERB? OPEN CLOSE PUSH MOVE>
           <TELL "The opening has made ordinary door operation largely academic." CR>)
          (<VERB? ENTER>
           <DO-WALK ,P?EAST>
           <RTRUE>)
          (T
           <TELL "The ruined door no longer meaningfully blocks the eastern exit." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-PASSAGE-OPENING-F ()
    <SETG ROOM-DENSITY-PASSAGE-SEEN T>
    <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
           <TELL "The opening is roughly cyclops-shaped and comfortably adventurer-sized. The living room lies immediately beyond." CR>)
          (<VERB? THROUGH ENTER>
           <DO-WALK ,P?EAST>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "Sound passes freely through the opening; nothing noteworthy is happening beyond it." CR>)
          (<VERB? RUB>
           <TELL "The cut edges are splintered in places and polished in others." CR>)
          (<VERB? MOVE PUSH TAKE>
           <TELL "An opening is difficult to relocate without moving everything around it." CR>)
          (T
           <TELL "The opening leads east into the living room." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-CRUMBLING-BAGS-F ()
    <SETG ROOM-DENSITY-TREASURE-SEEN T>
    <COND (<VERB? EXAMINE SEARCH LOOK-INSIDE>
           <TELL "The discarded bags are empty, brittle, and collapsing into flakes. Their useful contents were removed long ago." CR>)
          (<VERB? RUB TAKE MOVE RAISE>
           <TELL "The nearest bag crumbles further at the lightest contact, leaving nothing portable or useful." CR>)
          (<VERB? SMELL>
           <TELL "Dry rot and old dust are all that remain." CR>)
          (<VERB? LOOK-UNDER>
           <TELL "Beneath the bags is bare stone and more fragments of bag." CR>)
          (<VERB? KNOCK STRIKE>
           <TELL "The bags collapse silently rather than answering." CR>)
          (T
           <TELL "The bags are archaeological packaging, not containers anymore." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-TREASURE-FLOOR-F ()
    <SETG ROOM-DENSITY-TREASURE-SEEN T>
    <COND (<VERB? EXAMINE SEARCH LOOK-ON LOOK-UNDER>
           <TELL "The stone floor is littered with dust and fragments from the discarded bags. Nothing valuable is concealed among them." CR>)
          (<VERB? RUB>
           <TELL "The floor is cold, gritty stone." CR>)
          (<VERB? KNOCK STRIKE>
           <TELL "The floor sounds solid." CR>)
          (<VERB? MOVE PUSH TAKE>
           <TELL "The floor is not among the treasures you can carry away." CR>)
          (T
           <TELL "The floor offers support and disappointing debris." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-FOREST-PATH-F ()
    <SETG ROOM-DENSITY-PATH-SEEN T>
    <COND (<VERB? EXAMINE SEARCH>
           <TELL "The path is packed earth marked by old foot traffic. It bends through the trees without offering a hidden branch or dropped treasure." CR>)
          (<VERB? LISTEN>
           <TELL "The path itself is quiet; the forest provides the sound." CR>)
          (<VERB? SMELL>
           <TELL "Damp earth, leaves, and resin rise from the path." CR>)
          (<VERB? RUB>
           <TELL "The surface is compact soil with a scatter of needles and small stones." CR>)
          (<VERB? MOVE PUSH TAKE>
           <TELL "The path is already moving you more effectively than you can move it." CR>)
          (T
           <TELL "The path is a route through the forest, not a separate possession." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-STREAM-PATH-F ()
    <SETG ROOM-DENSITY-PATH-SEEN T>
    <COND (<VERB? EXAMINE SEARCH>
           <TELL "The path follows the stream closely on firm, damp ground. It carries no fresh track distinct enough to follow." CR>)
          (<VERB? LISTEN>
           <TELL "The stream overwhelms any sound made by the path." CR>)
          (<VERB? SMELL>
           <TELL "Wet stone, soil, and cold water dominate here." CR>)
          (<VERB? RUB>
           <TELL "The edge of the path is damp but stable." CR>)
          (<VERB? MOVE PUSH TAKE>
           <TELL "The path remains attached to the bank." CR>)
          (T
           <TELL "The path follows the stream east and west." CR>)>
    <RTRUE>>

<ROUTINE ROOM-DENSITY-RECAP ("AUX" (SEEN <>))
    <COND (,ROOM-DENSITY-TROLL-SEEN
           <SET SEEN T>
           <TELL "- You inspected the Troll Room's bloodstains, scratches, openings, or passages instead of treating its description as decoration." CR>)>
    <COND (,ROOM-DENSITY-GALLERY-SEEN
           <SET SEEN T>
           <TELL "- You examined what remains of the gallery's paintings, frames, and long-departed vandals." CR>)>
    <COND (,ROOM-DENSITY-STUDIO-SEEN
           <SET SEEN T>
           <TELL "- You inspected the studio floor or fireplace as real scenery rather than unreachable prose." CR>)>
    <COND (,ROOM-DENSITY-CHASM-SEEN
           <SET SEEN T>
           <TELL "- You examined the path and northern passage at the east edge of the chasm." CR>)>
    <COND (,ROOM-DENSITY-PASSAGE-SEEN
           <SET SEEN T>
           <TELL "- You inspected the ruined wooden door and cyclops-shaped opening in the strange passage." CR>)>
    <COND (,ROOM-DENSITY-TREASURE-SEEN
           <SET SEEN T>
           <TELL "- You checked the crumbling bags and debris-strewn floor of the treasure room." CR>)>
    <COND (,ROOM-DENSITY-PATH-SEEN
           <SET SEEN T>
           <TELL "- You treated the described forest and streamside paths as targetable scenery." CR>)>
    <COND (.SEEN <RTRUE>)>
    <RFALSE>>
