"RELEASE 1276 MARA FIELD GUIDANCE AND EARNED CLUES"

;"Mara can reason only from geography and evidence she physically knows. This
  module owns a narrow field-notebook memory for selected backcountry visits,
  one independently noticed fox-route clue, one uncertain frontier, one blocked
  attempted route, and the last ordinary cache she personally witnessed. It is
  not a generic hint engine, map database, quest tracker, or companion AI."

<CONSTANT MFG-BRUSH-GATE-SEEN 0>
<CONSTANT MFG-SWALE-SEEN 1>
<CONSTANT MFG-BEAVER-SEEN 2>
<CONSTANT MFG-FOX-RUN-SEEN 3>
<CONSTANT MFG-WARMWIND-SEEN 4>
<CONSTANT MFG-OVERLOOK-SEEN 5>
<CONSTANT MFG-BLOCKED-ROOM 6>
<CONSTANT MFG-UNCERTAIN-ROOM 7>
<CONSTANT MFG-CACHE-OBJECT 8>
<CONSTANT MFG-CACHE-ROOM 9>
<CONSTANT MFG-FOX-DISCOVERED 10>
<CONSTANT MARA-FIELD-GUIDANCE-STATE <TABLE 0 0 0 0 0 0 0 0 0 0 0>>

<ROUTINE MFG-GET (SLOT) <GET ,MARA-FIELD-GUIDANCE-STATE .SLOT>>
<ROUTINE MFG-PUT (SLOT VALUE) <PUT ,MARA-FIELD-GUIDANCE-STATE .SLOT .VALUE>>
<ROUTINE MFG-TRUE? (SLOT) <COND (<G? <MFG-GET .SLOT> 0> <RTRUE>)> <RFALSE>>

<OBJECT MARA-FIELD-MAP-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM MAP MAPPING CARTOGRAPHY ROUTE ROUTES GEOGRAPHY)
    (ADJECTIVE FIELD MARA MARAS HONEST)
    (DESC "Mara's field map")
    (FLAGS NDESCBIT RMUNGBIT)>

<OBJECT MARA-FINDINGS-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM FINDING FINDINGS DISCOVERY DISCOVERIES EVIDENCE)
    (ADJECTIVE FIELD NEW RECENT MARA MARAS)
    (DESC "Mara's field findings")
    (FLAGS NDESCBIT RMUNGBIT)>

<OBJECT MARA-CACHE-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM CACHE CACHES STASH STASHES SUPPLIES)
    (ADJECTIVE FIELD LEFT DROPPED)
    (DESC "a witnessed field cache")
    (FLAGS NDESCBIT RMUNGBIT)>

<OBJECT MARA-BACKCOUNTRY-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM BACKCOUNTRY HEMLOCK MEADOW SPRING RIDGE)
    (ADJECTIVE WEST WESTERN FOREST)
    (DESC "the Western Backcountry")
    (FLAGS NDESCBIT RMUNGBIT)>

<OBJECT MARA-WARMRAIN-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM WARMRAIN BASIN RAINFOREST JUNGLE)
    (ADJECTIVE WARM RAIN GREEN SOUTHERN)
    (DESC "the Warmrain Basin")
    (FLAGS NDESCBIT RMUNGBIT)>

<OBJECT MARA-FOX-FINDING-TOPIC
    (IN GLOBAL-OBJECTS)
    (SYNONYM FOX TRACK TRACKS PRINT PRINTS SHORTCUT)
    (ADJECTIVE SMALL CANINE MUDDY)
    (DESC "Mara's fox-track finding")
    (FLAGS NDESCBIT RMUNGBIT)>

<ROUTINE MARA-FIELD-GUIDANCE-CAN-ENTER? (RM)
    <COND (<ZERO? <MARA-GET ,MARA-SLOT-DAM-SURVEY>> <RFALSE>)
          (<EQUAL? .RM ,FOREST-1
                        ,BACKCOUNTRY-BRUSH-GATE
                        ,BACKCOUNTRY-HEMLOCK-SWALE
                        ,BACKCOUNTRY-BEAVER-MEADOW
                        ,BACKCOUNTRY-COLD-SPRING
                        ,BACKCOUNTRY-FALLEN-CEDAR
                        ,BACKCOUNTRY-FOX-RUN
                        ,BACKCOUNTRY-MOSS-RIDGE
                        ,BACKCOUNTRY-WARMWIND-NOTCH
                        ,BACKCOUNTRY-BASIN-OVERLOOK>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-FIELD-GUIDANCE-SHARE-FOX ()
    <COND (<ZERO? <MFG-GET ,MFG-FOX-DISCOVERED>>
           <TELL "Mara has not found a fox-route fact to share." CR>
           <RTRUE>)>
    <COND (<ZERO? <WILDERNESS-GET ,WB-FOX-TRAIL-SEEN>>
           <WILDERNESS-PUT ,WB-FOX-TRAIL-SEEN 1>)>
    <TELL "The fox tracks leave the muddy run southwest under the huckleberry instead of following the exposed ridge, Mara says. I checked the opening before I marked it. It reaches the warm-air notch. That is an animal route first and our shortcut only because the same ground happens to hold us." CR>
    <RTRUE>>

<ROUTINE MARA-FIELD-GUIDANCE-VISIT (RM)
    <COND (<EQUAL? .RM ,BACKCOUNTRY-BRUSH-GATE>
           <MFG-PUT ,MFG-BRUSH-GATE-SEEN 1>)
          (<EQUAL? .RM ,BACKCOUNTRY-HEMLOCK-SWALE>
           <MFG-PUT ,MFG-SWALE-SEEN 1>)
          (<EQUAL? .RM ,BACKCOUNTRY-BEAVER-MEADOW>
           <MFG-PUT ,MFG-BEAVER-SEEN 1>)
          (<EQUAL? .RM ,BACKCOUNTRY-FOX-RUN>
           <MFG-PUT ,MFG-FOX-RUN-SEEN 1>
           <COND (<ZERO? <MFG-GET ,MFG-FOX-DISCOVERED>>
                  <MFG-PUT ,MFG-FOX-DISCOVERED 1>
                  <COND (<STRUCTURAL-DIFFICULTY-FORGIVING?>
                         <TELL "Mara crouches over the small muddy prints, follows them with her eyes beneath the huckleberry, then checks the opening herself. Fox route southwest, she says. It reaches the warm-air notch and avoids the exposed ridge. I am marking it because I actually traced it, not because a map told me it existed." CR>
                         <COND (<ZERO? <WILDERNESS-GET ,WB-FOX-TRAIL-SEEN>>
                                <WILDERNESS-PUT ,WB-FOX-TRAIL-SEEN 1>)>)
                        (<STRUCTURAL-DIFFICULTY-EXACTING?>
                         <RFALSE>)
                        (T
                         <TELL "Mara pauses over a line of small muddy tracks under the huckleberry, checks something beyond the stems, and adds a short note to her field map. I found a route fact, she says. Ask me what I found if you want the conclusion." CR>)>)>)
          (<EQUAL? .RM ,BACKCOUNTRY-WARMWIND-NOTCH>
           <MFG-PUT ,MFG-WARMWIND-SEEN 1>)
          (<EQUAL? .RM ,BACKCOUNTRY-BASIN-OVERLOOK>
           <MFG-PUT ,MFG-OVERLOOK-SEEN 1>
           <MFG-PUT ,MFG-UNCERTAIN-ROOM ,WARMRAIN-CANOPY-EDGE>)>
    <RFALSE>>

<ROUTINE MARA-FIELD-GUIDANCE-RECORD-BLOCKED (RM)
    <COND (<AND .RM <NOT <MARA-FIELD-GUIDANCE-CAN-ENTER? .RM>>>
           <MFG-PUT ,MFG-BLOCKED-ROOM .RM>)>
    <RFALSE>>

<ROUTINE MARA-FIELD-GUIDANCE-WITNESS-CACHE (OBJ RM)
    <COND (<AND .OBJ .RM <MARA-HERE?>>
           <MFG-PUT ,MFG-CACHE-OBJECT .OBJ>
           <MFG-PUT ,MFG-CACHE-ROOM .RM>)>
    <RFALSE>>

<ROUTINE MARA-FIELD-GUIDANCE-ABOUT-MAP ()
    <COND (<ZERO? <MFG-GET ,MFG-BRUSH-GATE-SEEN>>
           <TELL "I have not personally mapped the western forest beyond the route we already share, Mara says. The Empire knowing a room exists is not the same as me knowing the route." CR>)
          (<MFG-GET ,MFG-OVERLOOK-SEEN>
           <TELL "My field line runs from the cut brush through the hemlock country to the basin overlook, Mara says. I have confirmed the swale, the beaver wetland, the fox-run side route, the warm-air notch, and the overlook by being there. South of the overlook I can see a warm wet descent, but I have not mapped what lies beyond it.">
           <COND (<MFG-GET ,MFG-BLOCKED-ROOM>
                  <TELL " I also have the southern descent marked as a route I did not enter when you did; that is a boundary in my map, not secret knowledge of the far side.">)>
           <CRLF>)
          (<MFG-GET ,MFG-FOX-RUN-SEEN>
           <TELL "I have the brush gate, hemlock swale, beaver meadow, and fox run as confirmed ground, Mara says. Anything beyond my last physical visit is still blank or provisional." CR>)
          (T
           <TELL "I have only the first western backcountry line confirmed so far, Mara says. I mark places after I stand in them, not before." CR>)>
    <RTRUE>>

<ROUTINE MARA-FIELD-GUIDANCE-ABOUT-CACHE ("AUX" OBJ RM)
    <SET OBJ <MFG-GET ,MFG-CACHE-OBJECT>>
    <SET RM <MFG-GET ,MFG-CACHE-ROOM>>
    <COND (<OR <ZERO? .OBJ> <ZERO? .RM>>
           <TELL "I have not witnessed you leave a field cache that I can honestly place, Mara says. I am not an invisible inventory tracker." CR>)
          (<EQUAL? <LOC .OBJ> .RM>
           <TELL "I watched you leave the " D .OBJ " at " D .RM ", Mara says. As far as the evidence I possess goes, that is still where it is." CR>)
          (T
           <TELL "I watched you leave the " D .OBJ " at " D .RM ", Mara says, but it is not there now. I can tell you the last placement I witnessed; I cannot invent who moved it or where it went afterward." CR>)>
    <RTRUE>>

<ROUTINE MARA-FIELD-GUIDANCE-ABOUT (TOPIC)
    <COND (<EQUAL? .TOPIC ,MARA-FIELD-MAP-TOPIC ,MAP>
           <MARA-FIELD-GUIDANCE-ABOUT-MAP>)
          (<EQUAL? .TOPIC ,MARA-CACHE-TOPIC>
           <MARA-FIELD-GUIDANCE-ABOUT-CACHE>)
          (<EQUAL? .TOPIC ,MARA-FINDINGS-TOPIC ,MARA-FOX-FINDING-TOPIC>
           <COND (<MFG-GET ,MFG-FOX-DISCOVERED>
                  <MARA-FIELD-GUIDANCE-SHARE-FOX>)
                 (T
                  <TELL "I do not have a new field finding I can defend yet, Mara says. Give me evidence or ground I have actually worked." CR>)>)
          (<EQUAL? .TOPIC ,MARA-BACKCOUNTRY-TOPIC>
           <COND (<MFG-GET ,MFG-SWALE-SEEN>
                  <TELL "The western backcountry is older hemlock, wet ground, animal routes, and a real warm-air gradient rather than one uniform forest, Mara says. That conclusion comes from the ground I have crossed, not from a regional label." CR>)
                 (T
                  <TELL "I have not crossed enough of the western backcountry to summarize it honestly yet, Mara says." CR>)>)
          (<EQUAL? .TOPIC ,MARA-WARMRAIN-TOPIC>
           <COND (<MFG-GET ,MFG-OVERLOOK-SEEN>
                  <TELL "From the overlook I can confirm a steep warm wet basin below us, steam under broad leaves, and a southward descent, Mara says. I have not entered it. Beyond that first visible geometry, my map is intentionally blank." CR>)
                 (T
                  <TELL "Warmrain is not on any route I have personally confirmed, Mara says. I will not turn a name into geography." CR>)>)
          (T <RFALSE>)>
    <RTRUE>>
