"Release 1267 semantic examination and hidden structure."

;"Selected concrete details already promised by room prose become honest parser
  targets. One described heat/soot pattern can reveal the existing Dragon Gallery
  ventilation seam; discovery is represented by the seam object's real location,
  not a generic noun promoter or clue counter."

<ROUTINE SEMANTIC-TROLL-BLOOD-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The bloodstains are old enough to have gone brown-black at the edges. They overlap at several heights and continue toward the passages rather than forming one neat pool. Whatever happened here involved movement, not a ceremonial decoration somebody forgot to explain." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Dust, stone, and the faint iron smell of very old blood. Nothing about it is fresh enough to identify a current wound." CR>
           <RTRUE>)
          (<VERB? TAKE MOVE>
           <TELL "The stains are in the stone's surface history, not lying on it as an object you can collect." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE SEMANTIC-TROLL-SCRATCHES-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The deepest scratches are broad, overlapping arcs with chipped stone at their ends. They are consistent with repeated axe blows made in anger or defense, not with mining, sharpening, or a single accidental scrape." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The cuts are rough under your fingers. Several edges have weathered smooth enough to prove the marks are older than your arrival." CR>
           <RTRUE>)
          (<VERB? TAKE MOVE>
           <TELL "You cannot take scratches out of a wall without first developing a much more ambitious relationship with masonry." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE SEMANTIC-TIMBER-DRAFT-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The draft is a real current, not atmosphere-by-narrator: air enters hard from the narrow westward throat and combs through the broken timbers before spilling across the room. Smoke, loose ash, or a small flame here will be pushed by that same moving air rather than choosing a dramatic direction for convenience." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "The moving air whistles around splintered timber and the narrow western stone. The pitch rises whenever the passage constricts." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <COND (<FIRE-STRUCTURAL-ACTIVE?>
                  <TELL "The draft is carrying the sharp smell of the real Timber Room fire along with mine dust." CR>)
                 (T
                  <TELL "Cold stone, dry wood, and old mine dust arrive on the moving air." CR>)>
           <RTRUE>)
          (<VERB? TAKE MOVE>
           <TELL "You can stand in the current, but there is no portable quantity of draft to pick up." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE SEMANTIC-DRAGON-SCRATCHES-F ()
    <COND (<VERB? EXAMINE>
           <TELL "These marks dwarf the axe-scars in the Troll Room. Four roughly parallel gouges repeat at shoulder height, then climb toward the blackened gallery. The spacing is anatomical rather than mechanical: something large with several claws has used this cleft often." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The basalt is chipped inward along each groove. These were cut by pressure against stone, not painted on as a warning." CR>
           <RTRUE>)
          (<VERB? TAKE MOVE>
           <TELL "The gouges are missing pieces of basalt. Collecting the absence would be an advanced museum practice." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE SEMANTIC-DRAGON-BONES-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The white bones are old, mixed, and deliberately nosed or kicked against the wall rather than scattered by a collapse. Several ends are heat-darkened. They do not tell you exactly what died here; they do tell you the hotter gallery has been occupied for a long time." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Dust and old mineral heat. Whatever flesh once made these bones interesting to scavengers is long gone." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You could disturb the warning pile, but none of these anonymous old fragments is useful enough to justify confusing evidence with loot." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE SEMANTIC-DRAGON-BLACKENING-F ()
    <COND (<VERB? EXAMINE>
           <COND (<NOT <IN? ,DRAGON-VENT-SEAM ,DRAGON-GALLERY>>
                  <MOVE ,DRAGON-VENT-SEAM ,DRAGON-GALLERY>
                  <TELL "The gallery's blackening is uneven. Most old heat blooms outward from floor level, but a narrow soot track climbs toward a high break in the basalt above the eastern arch. Looking along that track resolves what the room description did not name: an old ventilation seam cut through the stone. You have found a real piece of structure, not opened a secret passage." CR>)
                 (T
                  <TELL "The old heat marks still converge on the high ventilation seam above the eastern arch. The pattern explains where hot air and smoke repeatedly found a route; it does not make the seam large enough to travel through." CR>)>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The blackening is baked into the basalt in overlapping old layers. The stone itself is solid." CR>
           <RTRUE>)
          (<VERB? TAKE MOVE>
           <TELL "The heat marks are part of the gallery's history, not a detachable black object." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE SEMANTIC-DRAGON-SEAM-F ()
    <COND (<VERB? EXAMINE>
           <COND (<DRAGON-SMOKE-COVER?>
                  <TELL "The discovered ventilation seam is now doing exactly what its soot history predicted: smoke from the Timber Room is curling through the narrow cut and spreading high across the gallery. It remains far too small for passage, but it is physically changing the dragon's air." CR>)
                 (T
                  <TELL "The ventilation seam is a narrow engineered break high in the basalt above the eastern arch. Old soot feathers outward from it, and a faint current can be felt at its edge. It is an air route, not a person-sized exit and not a new door." CR>)>
           <RTRUE>)
          (<VERB? LISTEN>
           <COND (<DRAGON-SMOKE-COVER?>
                  <TELL "Air and smoke hiss softly through the narrow stone seam." CR>)
                 (T
                  <TELL "A thin moving-air whisper comes from the seam when the gallery is otherwise quiet enough to hear it." CR>)>
           <RTRUE>)
          (<VERB? SMELL>
           <COND (<DRAGON-SMOKE-COVER?>
                  <TELL "The seam is carrying the unmistakable smell of the existing Timber Room fire." CR>)
                 (T
                  <TELL "Old soot and mineral dust cling around the seam. There is no current fire to invent smoke from." CR>)>
           <RTRUE>)
          (<VERB? THROUGH>
           <TELL "The ventilation seam is an air route measured in inches, not an alternate corridor. Knowing it exists does not enlarge it." CR>
           <RTRUE>)
          (<VERB? TAKE MOVE>
           <TELL "The seam is a narrow opening in a basalt wall. Moving the wall would be a different release train entirely." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT SEMANTIC-TROLL-BLOODSTAINS
    (IN TROLL-ROOM)
    (SYNONYM BLOODSTAIN BLOODSTAINS STAIN STAINS BLOOD)
    (ADJECTIVE OLD DARK WALL)
    (DESC "old bloodstains")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION SEMANTIC-TROLL-BLOOD-F)>

<OBJECT SEMANTIC-TROLL-SCRATCHES
    (IN TROLL-ROOM)
    (SYNONYM SCRATCH SCRATCHES GOUGE GOUGES MARKS)
    (ADJECTIVE DEEP AXE WALL)
    (DESC "deep wall scratches")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION SEMANTIC-TROLL-SCRATCHES-F)>

<OBJECT SEMANTIC-TIMBER-DRAFT
    (IN TIMBER-ROOM)
    (SYNONYM DRAFT WIND AIR CURRENT)
    (ADJECTIVE STRONG WEST WESTERN MOVING)
    (DESC "strong westward draft")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION SEMANTIC-TIMBER-DRAFT-F)>

<OBJECT SEMANTIC-DRAGON-SCRATCHES
    (IN DRAGON-APPROACH)
    (SYNONYM SCRATCH SCRATCHES GOUGE GOUGES MARKS)
    (ADJECTIVE BROAD DEEP CLAW STONE)
    (DESC "broad stone scratches")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION SEMANTIC-DRAGON-SCRATCHES-F)>

<OBJECT SEMANTIC-DRAGON-BONES
    (IN DRAGON-APPROACH)
    (SYNONYM BONE BONES PILE REMAINS)
    (ADJECTIVE OLD WHITE HEAT DARKENED)
    (DESC "old white bones")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION SEMANTIC-DRAGON-BONES-F)>

<OBJECT SEMANTIC-DRAGON-BLACKENING
    (IN DRAGON-GALLERY)
    (SYNONYM BLACKENING SCORCH SCORCHES SOOT MARKS)
    (ADJECTIVE OLD HEAT BLACKENED BASALT)
    (DESC "old heat blackening")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION SEMANTIC-DRAGON-BLACKENING-F)>

<OBJECT DRAGON-VENT-SEAM
    (SYNONYM SEAM VENT VENTILATION CREVICE)
    (ADJECTIVE HIGH OLD NARROW BASALT)
    (DESC "high ventilation seam")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION SEMANTIC-DRAGON-SEAM-F)>
