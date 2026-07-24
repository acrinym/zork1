"ZORK1 HOUSE STATE FOUNDATION GLULX for
  Zork I: The Great Underground Empire
  (c) Copyright 1983 Infocom, Inc. All Rights Reserved."

;"Repository-local evolving-house foundation overlay.
  Release 1219 retains every qualified Release 1218 behavior and adds only a
  compact event-driven state substrate and bounded description projection for
  the canonical white-house rooms. It is not an official Infocom release."

<VERSION ZIP>

<SETG ZORK-NUMBER 1>

<CONSTANT RELEASEID 1219>

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !" !,WBREAKS>>>

<VERSION?
    (GLULX <CONSTANT WORD-SIZE 4>)
    (T     <CONSTANT WORD-SIZE 2>)>

<PRINC "House State Foundation Glulx ZORK I: The Great Underground Empire
 ">

<FREQUENT-WORDS?>

<INSERT-FILE "gmacros" T>
<INSERT-FILE "gsyntax" T>
<INSERT-FILE "1dungeon" T>
<INSERT-FILE "gglobals" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
<PROPDEF VALUE 0>
<PROPDEF TVALUE 0>

<INSERT-FILE "gclock" T>
<INSERT-FILE "gmain" T>
<INSERT-FILE "gparser" T>
<INSERT-FILE "gverbs" T>
<INSERT-FILE "1actions" T>
<INSERT-FILE "assistance" T>
<INSERT-FILE "reactive_surface" T>
<INSERT-FILE "shadow_logic" T>
<INSERT-FILE "absurd_alternates" T>
<INSERT-FILE "dam_mechanisms" T>
<INSERT-FILE "ritual_resonance" T>
<INSERT-FILE "material_consequences" T>
<INSERT-FILE "room_density" T>
<INSERT-FILE "house_state_foundation" T>
