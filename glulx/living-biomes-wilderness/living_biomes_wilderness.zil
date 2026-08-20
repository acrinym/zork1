"RELEASE 1273 LIVING BIOMES AND WILDERNESS EXPANSION"

;"Two authored wilderness identities: the Western Backcountry and the warm,
  geothermally fed Warmrain Basin. No generic biome/climate/creature engine."

<CONSTANT WB-BRUSH-CLEARED 0>
<CONSTANT WB-FOX-TRAIL-SEEN 1>
<CONSTANT WR-ANT-ROUTE-SEEN 2>
<CONSTANT WR-CAIMAN-AWAY 3>
<CONSTANT WR-CAIMAN-WARNED 4>
<CONSTANT WR-VINES-CUT 5>
<CONSTANT WILDERNESS-STATE <TABLE 0 0 0 0 0 0>>

<ROUTINE WILDERNESS-GET (SLOT) <GET ,WILDERNESS-STATE .SLOT>>
<ROUTINE WILDERNESS-PUT (SLOT VALUE) <PUT ,WILDERNESS-STATE .SLOT .VALUE>>
<ROUTINE WILDERNESS-TRUE? (SLOT) <COND (<G? <WILDERNESS-GET .SLOT> 0> <RTRUE>)> <RFALSE>>

<OBJECT WILDERNESS-MACHETE
    (IN ASHGLASS-WEST-COURT)
    (SYNONYM MACHETE BLADE KNIFE TOOL)
    (ADJECTIVE OLD FORESTER FOREST BRUSH LONG)
    (DESC "old forester's machete")
    (FDESC "An old forester's machete lies half under one broken observatory plinth, its broad blade stained but sound.")
    (FLAGS TAKEBIT WEAPONBIT TOOLBIT)
    (SIZE 12)
    (ACTION WILDERNESS-MACHETE-F)>

<ROUTINE WILDERNESS-MACHETE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The broad single-edged blade was made for brush rather than dueling. The leather grip is cracked, but the edge is sound enough for vines, saplings, and the sort of vegetation that has been telling you to acquire a machete for some time." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT WILDERNESS-WEST-BRUSH
    (IN FOREST-1)
    (SYNONYM UNDERGROWTH BRUSH BRAMBLES TANGLE VINES)
    (ADJECTIVE WEST WESTERN DENSE RANK THORNY)
    (DESC "dense western undergrowth")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION WILDERNESS-WEST-BRUSH-F)>

<ROUTINE WILDERNESS-WEST-BRUSH-F ()
    <COND (<VERB? EXAMINE>
           <COND (<WILDERNESS-TRUE? ,WB-BRUSH-CLEARED>
                  <TELL "The western undergrowth is now a cut corridor through bramble and young hemlock. The severed stems make it obvious that the opening is persistent work, not a temporary parser permission." CR>)
                 (T
                  <TELL "Blackberry cane, young hemlock, and rope-thick vine have knitted into a wall. A broad brush blade could cut a body-width route without pretending the entire forest has become removable scenery." CR>)>
           <RTRUE>)
          (<VERB? CUT>
           <COND (<WILDERNESS-TRUE? ,WB-BRUSH-CLEARED>
                  <TELL "The useful corridor is already cut. Further hacking would mostly improve your relationship with splinters." CR>
                  <RTRUE>)
                 (<NOT <EQUAL? ,PRSI ,WILDERNESS-MACHETE>>
                  <TELL "The vegetation is physically cuttable, but the " D ,PRSI " is not the broad brush blade this particular wall requires. The old forest's earlier assessment about a machete was irritatingly specific and correct." CR>
                  <RTRUE>)>
           <WILDERNESS-PUT ,WB-BRUSH-CLEARED 1>
           <TELL "The machete shears bramble, vine, and wrist-thick saplings in deliberate layers. After several minutes you can see dark ground continuing west between older trunks. The route exists because you made a route, not because the forest politely despawned." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE WILDERNESS-FOREST-WEST-EXIT ()
    <COND (<WILDERNESS-TRUE? ,WB-BRUSH-CLEARED> ,BACKCOUNTRY-BRUSH-GATE)
          (T
           <TELL "Dense western undergrowth still closes the way. The earlier verdict remains physically accurate: you would need a machete to make a useful passage." CR>
           <RFALSE>)>>

<ROUTINE BACKCOUNTRY-BEAVER-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A broad brown beaver floats low beside its lodge, entirely unimpressed by your status as protagonist. Mud on its forepaws and fresh pale tooth marks on the willow explain who has been maintaining the wetland." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "You hear water ticking through sticks, then one flat slap from the pond and several seconds of pointed silence." CR>
           <RTRUE>)
          (<VERB? ATTACK>
           <TELL "The beaver disappears underwater before your attack becomes an ecological policy. The dam, pond, and your poor judgment remain." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT BACKCOUNTRY-BEAVER
    (IN BACKCOUNTRY-BEAVER-MEADOW)
    (SYNONYM BEAVER ANIMAL RODENT)
    (ADJECTIVE BROWN BROAD WET)
    (DESC "broad brown beaver")
    (FLAGS ACTORBIT NDESCBIT TRYTAKEBIT)
    (ACTION BACKCOUNTRY-BEAVER-F)>

<ROUTINE BACKCOUNTRY-BEAVER-DAM-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Willow poles, mud, stones, and chewed branches hold back a shallow pond. Water leaks through hundreds of small gaps rather than one convenient fantasy valve. The top is broad enough to cross if you accept that an animal built your bridge for reasons unrelated to you." CR>
           <RTRUE>)
          (<VERB? CROSS>
           <COND (<EQUAL? ,HERE ,BACKCOUNTRY-BEAVER-MEADOW>
                  <TELL "You cross on the beaver dam one careful step at a time. Several sticks flex, the beaver expresses a legal opinion from the water, and you reach the cold-spring bank without improving the structure." CR>
                  <GOTO ,BACKCOUNTRY-COLD-SPRING>)
                 (T
                  <TELL "You cross back over the beaver dam toward the meadow. Water threads through the willow lattice below your boots; the builder watches from a distance without recognizing any obligation to provide handrails." CR>
                  <GOTO ,BACKCOUNTRY-BEAVER-MEADOW>)>
           <RTRUE>)>
    <RFALSE>>

<OBJECT BACKCOUNTRY-BEAVER-DAM
    (IN LOCAL-GLOBALS)
    (SYNONYM DAM BRIDGE STICKS LODGE)
    (ADJECTIVE BEAVER MUD WILLOW LOW)
    (DESC "beaver dam")
    (FLAGS TRYTAKEBIT)
    (ACTION BACKCOUNTRY-BEAVER-DAM-F)>

<ROUTINE BACKCOUNTRY-FOX-TRACKS-F ()
    <COND (<VERB? EXAMINE>
           <WILDERNESS-PUT ,WB-FOX-TRAIL-SEEN 1>
           <TELL "Small canine prints leave the muddy run, avoid the exposed ridge, and vanish through a shoulder-wide opening under huckleberry stems. The animal has been using a shorter route to the warm-air notch. You can use it too, less elegantly." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT BACKCOUNTRY-FOX-TRACKS
    (IN BACKCOUNTRY-FOX-RUN)
    (SYNONYM TRACK TRACKS PRINT PRINTS TRAIL)
    (ADJECTIVE FOX SMALL CANINE MUDDY)
    (DESC "small fox tracks")
    (FLAGS TRYTAKEBIT)
    (ACTION BACKCOUNTRY-FOX-TRACKS-F)>

<ROUTINE BACKCOUNTRY-FOX-SHORTCUT ()
    <COND (<WILDERNESS-TRUE? ,WB-FOX-TRAIL-SEEN> ,BACKCOUNTRY-WARMWIND-NOTCH)
          (T
           <TELL "Huckleberry and fern close together south of the run. Something small may pass there, but you have not yet found a human-usable line through it." CR>
           <RFALSE>)>>

<ROUTINE WARMRAIN-DRIP-HOLLOW-F (RARG)
    <COND (<EQUAL? .RARG ,M-ENTER>
           <COND (<AND <IN? ,CANDLES ,WINNER>
                       <ZERO? <CONSUMABLE-LIGHT-GET ,CL-CANDLE-WET>>>
                  <CONSUMABLE-LIGHT-PUT ,CL-CANDLE-WET 4>
                  <FCLEAR ,CANDLES ,ONBIT>
                  <TELL "The canopy chooses this hollow for drainage. A warm sheet of water runs off a giant leaf directly over your carried candles; the flames vanish and the paired wicks darken with water. Humidity has become object state, not a percentage on a status screen." CR>)>)>
    <RFALSE>>

<ROUTINE WARMRAIN-LEAFCUTTERS-F ()
    <COND (<VERB? EXAMINE>
           <WILDERNESS-PUT ,WR-ANT-ROUTE-SEEN 1>
           <TELL "The leafcutters are not wandering. Their green procession stays on one raised buttress root above the mud, passes behind the curtain of fern, and continues east without interruption. For creatures this size, it is a highway. For you, it is evidence of dry connected footing." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "At human scale the colony is nearly silent: tiny leaf edges brushing one another and the occasional dry tick of chitin on root." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT WARMRAIN-LEAFCUTTERS
    (IN WARMRAIN-ANT-RIDGE)
    (SYNONYM ANT ANTS LEAFCUTTERS COLONY INSECTS)
    (ADJECTIVE LEAF CUTTING GREEN PROCESSION)
    (DESC "procession of leafcutter ants")
    (FLAGS TRYTAKEBIT)
    (ACTION WARMRAIN-LEAFCUTTERS-F)>

<ROUTINE WARMRAIN-ANT-EAST-EXIT ()
    <COND (<WILDERNESS-TRUE? ,WR-ANT-ROUTE-SEEN> ,WARMRAIN-FALLEN-GIANT)
          (T
           <TELL "Fern and knee-deep mud obscure any useful eastward footing. Small life is moving through there, but you have not yet learned where the ground actually holds." CR>
           <RFALSE>)>>

<ROUTINE WARMRAIN-GLASS-FROGS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Several thumb-sized green frogs cling beneath leaves above the pool. Their bellies are pale enough that shadowed organs show faintly through the skin. They are neither treasure nor a coded quest marker; they are here because warm clean water and insects are here." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "The frogs answer one another in short glassy clicks from three different heights, making the little pool sound much larger than it is." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT WARMRAIN-GLASS-FROGS
    (IN WARMRAIN-FROG-POOL)
    (SYNONYM FROG FROGS AMPHIBIAN AMPHIBIANS)
    (ADJECTIVE GLASS GREEN SMALL TRANSLUCENT)
    (DESC "small glass frogs")
    (FLAGS TRYTAKEBIT)
    (ACTION WARMRAIN-GLASS-FROGS-F)>

<ROUTINE WARMRAIN-FRUIT-BATS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A loose cluster of dark fruit bats hangs under the fallen giant's surviving crown where it lodged against neighboring trees. Several are chewing purple fruit with the concentration of accountants." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "Leather wings rustle overhead. Something spits a fruit pit into the leaves with tiny but unmistakable contempt." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT WARMRAIN-FRUIT-BATS
    (IN WARMRAIN-FALLEN-GIANT)
    (SYNONYM BAT BATS FLYING MAMMALS)
    (ADJECTIVE FRUIT DARK CANOPY)
    (DESC "cluster of fruit bats")
    (FLAGS TRYTAKEBIT)
    (ACTION WARMRAIN-FRUIT-BATS-F)>

<ROUTINE WARMRAIN-HOT-SPRING-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Clear water wells through black gravel and steams faintly in the saturated air. Mineral crust rings the hottest inlet; cooler overflow disappears toward the rootwater flats." CR>
           <RTRUE>)
          (<VERB? DRINK>
           <TELL "The source is hot enough to make the proposal educational before it becomes refreshing. Cooler water exists downstream." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT WARMRAIN-HOT-SPRING-WATER
    (IN WARMRAIN-HOT-SPRING)
    (SYNONYM SPRING WATER POOL)
    (ADJECTIVE HOT GEOTHERMAL CLEAR STEAMING)
    (DESC "hot spring")
    (FLAGS DRINKBIT TRYTAKEBIT)
    (ACTION WARMRAIN-HOT-SPRING-F)>

<ROUTINE WARMRAIN-CAIMAN-F ()
    <COND (<VERB? EXAMINE>
           <COND (<WILDERNESS-TRUE? ,WR-CAIMAN-AWAY>
                  <TELL "The caiman is temporarily out of the ford, thrashing in the backwater after the fish. Long enough to matter is not the same as gone." CR>)
                 (T
                  <TELL "The caiman is almost the color of the warm black water. Only its eyes, nostrils, and armored back interrupt the ford. It is positioned where anything wading east must enter the short reach of its jaws." CR>)>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "Water taps against roots. The large reptile contributes almost nothing, which is considerably worse than growling." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT WARMRAIN-CAIMAN
    (IN WARMRAIN-CAIMAN-FORD)
    (SYNONYM CAIMAN CROCODILE REPTILE PREDATOR)
    (ADJECTIVE LARGE WARM WATER ARMORED BLACK)
    (DESC "large warm-water caiman")
    (FLAGS ACTORBIT NDESCBIT TRYTAKEBIT)
    (ACTION WARMRAIN-CAIMAN-F)>

<ROUTINE WARMRAIN-CAIMAN-FORD-F (RARG)
    <COND (<EQUAL? .RARG ,M-BEG>
           <COND (<AND <VERB? DROP THROW>
                       <EQUAL? ,PRSO ,DAM-SILVERFIN>
                       <IN? ,DAM-SILVERFIN ,WINNER>
                       <NOT <WILDERNESS-TRUE? ,WR-CAIMAN-AWAY>>>
                  <REMOVE-CAREFULLY ,DAM-SILVERFIN>
                  <WILDERNESS-PUT ,WR-CAIMAN-AWAY 1>
                  <WILDERNESS-PUT ,WR-CAIMAN-WARNED 0>
                  <QUEUE I-WARMRAIN-CAIMAN-RETURN 5>
                  <TELL "The living silverfin hits the backwater with one hard flash. The caiman moves with shocking economy: one sweep of tail, a black wake, then a violent boil among the roots where the fish vanished. The exact specimen is no longer in your inventory because a predator has just made it part of the food web. The ford is open for a short while." CR>
                  <RTRUE>)>)>
    <RFALSE>>

<ROUTINE I-WARMRAIN-CAIMAN-RETURN ()
    <COND (<WILDERNESS-TRUE? ,WR-CAIMAN-AWAY>
           <WILDERNESS-PUT ,WR-CAIMAN-AWAY 0>
           <COND (<EQUAL? ,HERE ,WARMRAIN-CAIMAN-FORD>
                  <TELL "A low wake slides out of the backwater. The caiman settles into the ford again with the unhurried confidence of something that has recently been fed and has not therefore become charitable." CR>)>)>>

<ROUTINE WARMRAIN-FORD-EAST-EXIT ()
    <COND (<WILDERNESS-TRUE? ,WR-CAIMAN-AWAY> ,WARMRAIN-DEEP-BASIN)
          (<ZERO? <WILDERNESS-GET ,WR-CAIMAN-WARNED>>
           <WILDERNESS-PUT ,WR-CAIMAN-WARNED 1>
           <TELL "You put one foot into the warm ford. Two ridges in the water become eyes and the entire armored shape slides sideways to intercept the crossing. You step back onto root before its jaws reach you. The route is physically possible; the large hunting reptile currently owning its middle is the problem." CR>
           <RFALSE>)
          (T
           <JIGS-UP "You enter the occupied ford again after watching the caiman intercept the same line once already. Warm water hides the first acceleration; the second thing you understand is why large ambush predators do not need dramatic warning music. Your failed state was not lack of a command. It was choosing to wade through the animal's hunting position twice.">
           <RFALSE>)>>

<ROUTINE WARMRAIN-FORD-WEST-EXIT ()
    <COND (<WILDERNESS-TRUE? ,WR-CAIMAN-AWAY> ,WARMRAIN-CAIMAN-FORD)
          (<ZERO? <WILDERNESS-GET ,WR-CAIMAN-WARNED>>
           <WILDERNESS-PUT ,WR-CAIMAN-WARNED 1>
           <TELL "From the deep-basin bank you start west across the same shallow reach. The armored shape pivots out of the blackwater and takes the crossing line before you do. You retreat to root and stone. Direction has not changed ownership of the ford." CR>
           <RFALSE>)
          (T
           <JIGS-UP "You enter the occupied ford again after already seeing the caiman control its crossing line. The animal does not care which bank you started from. Warm water hides the acceleration until the distance is gone.">
           <RFALSE>)>>

<ROUTINE WARMRAIN-VINE-CURTAIN-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Old woody vines hang between two buttress roots like cables. Several are dead and gray, but enough living stems bind the curtain that forcing through would wrap rather than part it. A broad vegetation blade could make a clean opening." CR>
           <RTRUE>)
          (<VERB? CUT>
           <COND (<NOT <EQUAL? ,PRSI ,WILDERNESS-MACHETE>>
                  <TELL "The " D ,PRSI " can worry one stem at a time. The machete was made for exactly this broad, awkward cut." CR>
                  <RTRUE>)>
           <WILDERNESS-PUT ,WR-VINES-CUT 1>
           <TELL "The machete chops through dead cable-vines first, then the green binders under tension. The curtain slumps into the mud and leaves a narrow southward passage between the buttress roots." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT WARMRAIN-VINE-CURTAIN
    (IN WARMRAIN-VINE-COLONNADE)
    (SYNONYM VINE VINES CURTAIN CABLES TANGLE)
    (ADJECTIVE WOODY DEAD GREEN THICK)
    (DESC "woody vine curtain")
    (FLAGS TRYTAKEBIT)
    (ACTION WARMRAIN-VINE-CURTAIN-F)>

<ROUTINE WARMRAIN-VINE-SOUTH-EXIT ()
    <COND (<WILDERNESS-TRUE? ,WR-VINES-CUT> ,WARMRAIN-DEEP-BASIN)
          (T
           <TELL "The vine curtain still binds the buttress gap. It is vegetation, not a locked door, but it remains physically in the way." CR>
           <RFALSE>)>>

<ROOM BACKCOUNTRY-BRUSH-GATE (IN ROOMS) (DESC "Brush Gate")
      (LDESC "The cut corridor leaves the familiar forest behind. Older hemlocks stand farther apart here, with salal and fern under them instead of wall-to-wall bramble. East returns to Forest-1; west descends into a dark swale.")
      (EAST TO FOREST-1) (WEST TO BACKCOUNTRY-HEMLOCK-SWALE) (FLAGS RLANDBIT ONBIT)>
<ROOM BACKCOUNTRY-HEMLOCK-SWALE (IN ROOMS) (DESC "Hemlock Swale")
      (LDESC "A cool swale gathers needles, moss, and seep water below enormous hemlocks. East returns to the brush gate. North opens toward a flooded meadow; west follows a fallen cedar; south climbs beside clear spring water.")
      (EAST TO BACKCOUNTRY-BRUSH-GATE) (NORTH TO BACKCOUNTRY-BEAVER-MEADOW) (WEST TO BACKCOUNTRY-FALLEN-CEDAR) (SOUTH TO BACKCOUNTRY-COLD-SPRING) (FLAGS RLANDBIT ONBIT)>
<ROOM BACKCOUNTRY-BEAVER-MEADOW (IN ROOMS) (DESC "Beaver Meadow")
      (LDESC "A shallow pond has drowned what was once meadow. Fresh willow stumps ring the water and a low beaver dam carries a narrow path across its southern lip. The hemlock swale is south; a drier animal run begins west.")
      (SOUTH TO BACKCOUNTRY-HEMLOCK-SWALE) (WEST TO BACKCOUNTRY-FOX-RUN) (FLAGS RLANDBIT ONBIT)
      (GLOBAL BACKCOUNTRY-BEAVER-DAM)>
<ROOM BACKCOUNTRY-COLD-SPRING (IN ROOMS) (DESC "Cold Spring")
      (LDESC "Clear cold water emerges below a granite shelf and runs north toward the beaver wetland. The hemlock swale is north; west climbs to a mossy ridge. Air moving from the southwest is strangely warmer than the spring water warrants.")
      (NORTH TO BACKCOUNTRY-HEMLOCK-SWALE) (WEST TO BACKCOUNTRY-MOSS-RIDGE) (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-WATER BACKCOUNTRY-BEAVER-DAM)>
<ROOM BACKCOUNTRY-FALLEN-CEDAR (IN ROOMS) (DESC "Fallen Cedar")
      (LDESC "A cedar large enough to qualify as local geography lies east-west across the slope. Ferns grow from its rotting upper surface. East returns to the swale; north reaches an animal run; west climbs around its root plate toward mossy stone.")
      (EAST TO BACKCOUNTRY-HEMLOCK-SWALE) (NORTH TO BACKCOUNTRY-FOX-RUN) (WEST TO BACKCOUNTRY-MOSS-RIDGE) (FLAGS RLANDBIT ONBIT)>
<ROOM BACKCOUNTRY-FOX-RUN (IN ROOMS) (DESC "Fox Run")
      (LDESC "A narrow muddy run threads between huckleberry stems above the beaver meadow. The meadow lies east, the fallen cedar south, and a less obvious opening may continue southwest if the animal tracks actually go somewhere useful.")
      (EAST TO BACKCOUNTRY-BEAVER-MEADOW) (SOUTH TO BACKCOUNTRY-FALLEN-CEDAR) (SW PER BACKCOUNTRY-FOX-SHORTCUT) (FLAGS RLANDBIT ONBIT)>
<ROOM BACKCOUNTRY-MOSS-RIDGE (IN ROOMS) (DESC "Moss Ridge")
      (LDESC "Granite knobs rise through deep moss along a low ridge. East drops toward cedar and spring; south climbs toward a notch where warm damp air spills uphill through the conifers.")
      (EAST TO BACKCOUNTRY-FALLEN-CEDAR) (SE TO BACKCOUNTRY-COLD-SPRING) (SOUTH TO BACKCOUNTRY-WARMWIND-NOTCH) (FLAGS RLANDBIT ONBIT)>
<ROOM BACKCOUNTRY-WARMWIND-NOTCH (IN ROOMS) (DESC "Warmwind Notch")
      (LDESC "The conifers thin at a saddle in the ridge. Warm wet air rises from the south carrying leaf mold, flowers, and distant water. North returns to moss ridge; northeast is the fox shortcut; south reaches an overlook above a green basin.")
      (NORTH TO BACKCOUNTRY-MOSS-RIDGE) (NE TO BACKCOUNTRY-FOX-RUN) (SOUTH TO BACKCOUNTRY-BASIN-OVERLOOK) (FLAGS RLANDBIT ONBIT)>
<ROOM BACKCOUNTRY-BASIN-OVERLOOK (IN ROOMS) (DESC "Basin Overlook")
      (LDESC "Below the notch lies a steep enclosed basin under its own weather. Steam lifts from dark water and condenses beneath a broadleaf canopy; fern crowns and vines erase most bare ground. The temperature change is abrupt because topography and hot springs are doing actual work. North returns to the notch; south descends into the Warmrain Basin.")
      (NORTH TO BACKCOUNTRY-WARMWIND-NOTCH) (SOUTH TO WARMRAIN-CANOPY-EDGE) (FLAGS RLANDBIT ONBIT)>

<ROOM WARMRAIN-CANOPY-EDGE (IN ROOMS) (DESC "Warmrain Canopy Edge")
      (LDESC "The conifer world ends over several hundred vertical feet instead of at a climate menu. Broad leaves overlap above warm wet soil; vines hang from trees with buttress roots. North climbs to the basin overlook. South enters a fern gallery; east follows a root shelf toward rain-cupping plants.")
      (NORTH TO BACKCOUNTRY-BASIN-OVERLOOK) (SOUTH TO WARMRAIN-FERN-GALLERY) (EAST TO WARMRAIN-BROMELIAD-GROVE) (FLAGS RLANDBIT ONBIT)>
<ROOM WARMRAIN-FERN-GALLERY (IN ROOMS) (DESC "Fern Gallery")
      (LDESC "Tree ferns arch over a dim corridor of black soil. North returns to the canopy edge. West drops into a dripping hollow; south reaches a flooded root flat.")
      (NORTH TO WARMRAIN-CANOPY-EDGE) (WEST TO WARMRAIN-DRIP-HOLLOW) (SOUTH TO WARMRAIN-ROOTWATER) (FLAGS RLANDBIT ONBIT)>
<ROOM WARMRAIN-DRIP-HOLLOW (IN ROOMS) (DESC "Drip Hollow")
      (LDESC "Several giant leaves funnel canopy runoff into this hollow even between showers. Warm water drums steadily from leaf tips. East returns to the fern gallery; south climbs beside steam toward a hot spring.")
      (EAST TO WARMRAIN-FERN-GALLERY) (SOUTH TO WARMRAIN-HOT-SPRING) (ACTION WARMRAIN-DRIP-HOLLOW-F) (FLAGS RLANDBIT ONBIT)>
<ROOM WARMRAIN-BROMELIAD-GROVE (IN ROOMS) (DESC "Bromeliad Grove")
      (LDESC "Large rosettes grow in every fork and fallen branch, each holding a dark cup of rainwater and insect life. West returns to the canopy edge; south follows a raised root toward a green procession of leafcutters.")
      (WEST TO WARMRAIN-CANOPY-EDGE) (SOUTH TO WARMRAIN-ANT-RIDGE) (FLAGS RLANDBIT ONBIT)>
<ROOM WARMRAIN-ANT-RIDGE (IN ROOMS) (DESC "Leafcutter Ridge")
      (LDESC "A buttress root stands above surrounding mud like a narrow causeway. Leafcutter ants carry green fragments along it in both directions. North returns to the bromeliads; south descends to rootwater. East is a wall of fern unless the colony's route tells you otherwise.")
      (NORTH TO WARMRAIN-BROMELIAD-GROVE) (SOUTH TO WARMRAIN-ROOTWATER) (EAST PER WARMRAIN-ANT-EAST-EXIT) (FLAGS RLANDBIT ONBIT)>
<ROOM WARMRAIN-ROOTWATER (IN ROOMS) (DESC "Rootwater Flats")
      (LDESC "Warm ankle-deep water moves among buttress roots over dark mud. North reaches the fern gallery or leafcutter ridge. East rises toward a clear frog pool; south follows the current toward a broader bend.")
      (NORTH TO WARMRAIN-FERN-GALLERY) (NE TO WARMRAIN-ANT-RIDGE) (EAST TO WARMRAIN-FROG-POOL) (SOUTH TO WARMRAIN-MOSSWATER-BEND) (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-WATER)>
<ROOM WARMRAIN-FROG-POOL (IN ROOMS) (DESC "Glass Frog Pool")
      (LDESC "Clear overflow collects below leaves crowded with tiny green frogs. West returns to rootwater; east reaches the root plate of a fallen giant; north climbs toward the leafcutter ridge.")
      (WEST TO WARMRAIN-ROOTWATER) (EAST TO WARMRAIN-FALLEN-GIANT) (NORTH TO WARMRAIN-ANT-RIDGE) (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-WATER)>
<ROOM WARMRAIN-FALLEN-GIANT (IN ROOMS) (DESC "Fallen Giant")
      (LDESC "A massive broadleaf tree fell decades ago but never reached the ground cleanly; its crown lodged in neighboring trunks and now carries a secondary garden overhead. West returns to the frog pool. South descends to the caiman ford, while east follows the trunk toward a wall of old vines.")
      (WEST TO WARMRAIN-FROG-POOL) (SOUTH TO WARMRAIN-CAIMAN-FORD) (EAST TO WARMRAIN-VINE-COLONNADE) (FLAGS RLANDBIT ONBIT)>
<ROOM WARMRAIN-MOSSWATER-BEND (IN ROOMS) (DESC "Mosswater Bend")
      (LDESC "A warm blackwater channel curves between roots and mats of floating moss. North returns to the rootwater flats. East shallows into a ford occupied by something large and armored; west climbs toward the hot spring overflow.")
      (NORTH TO WARMRAIN-ROOTWATER) (EAST TO WARMRAIN-CAIMAN-FORD) (WEST TO WARMRAIN-HOT-SPRING) (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-WATER)>
<ROOM WARMRAIN-CAIMAN-FORD (IN ROOMS) (DESC "Caiman Ford")
      (LDESC "The blackwater narrows over a gravel shelf shallow enough to wade. A large caiman lies almost submerged in the middle reach, where anything crossing east must pass within a body length. West returns to Mosswater Bend, north climbs to the fallen giant, and east is the deeper basin beyond.")
      (WEST TO WARMRAIN-MOSSWATER-BEND) (NORTH TO WARMRAIN-FALLEN-GIANT) (EAST PER WARMRAIN-FORD-EAST-EXIT) (ACTION WARMRAIN-CAIMAN-FORD-F) (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-WATER)>
<ROOM WARMRAIN-VINE-COLONNADE (IN ROOMS) (DESC "Vine Colonnade")
      (LDESC "Buttress roots rise like columns around a curtain of old woody vines. West returns along the fallen giant. North reaches a steaming spring shelf. South continues toward the deep basin only if the vine curtain is physically opened.")
      (WEST TO WARMRAIN-FALLEN-GIANT) (NORTH TO WARMRAIN-HOT-SPRING) (SOUTH PER WARMRAIN-VINE-SOUTH-EXIT) (FLAGS RLANDBIT ONBIT)>
<ROOM WARMRAIN-HOT-SPRING (IN ROOMS) (DESC "Warmrain Hot Spring")
      (LDESC "Clear geothermal water wells through black gravel beneath the canopy. North drops to Drip Hollow, east reaches the vine colonnade, and southeast follows cooler overflow to Mosswater Bend.")
      (NORTH TO WARMRAIN-DRIP-HOLLOW) (EAST TO WARMRAIN-VINE-COLONNADE) (SE TO WARMRAIN-MOSSWATER-BEND) (FLAGS RLANDBIT ONBIT)>
<ROOM WARMRAIN-DEEP-BASIN (IN ROOMS) (DESC "Deep Warmrain Basin")
      (LDESC "The basin floor broadens under immense wet trunks and suspended gardens. West returns through the caiman ford when it is safe; north reaches the opened vine colonnade. Warm rain and spring mist merge here until the distinction stops being useful. Nothing marks this as the end of a quest; it is simply deeper country that now exists.")
      (WEST PER WARMRAIN-FORD-WEST-EXIT) (NORTH TO WARMRAIN-VINE-COLONNADE) (FLAGS RLANDBIT ONBIT)>
