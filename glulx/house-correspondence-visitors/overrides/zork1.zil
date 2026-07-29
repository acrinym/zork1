"ZORK1 HOUSE CORRESPONDENCE AND VISITORS GLULX for
  Zork I: The Great Underground Empire
  (c) Copyright 1983 Infocom, Inc. All Rights Reserved."

;"Repository-local correspondence and visitors overlay.
  Release 1223 retains every qualified Release 1222 behavior and adds a
  deterministic physical-mail queue, bounded replies, missed notices, and two
  exterior visitors around the canonical mailbox and boarded front door. It is
  not an official Infocom release."

<VERSION ZIP>

<SETG ZORK-NUMBER 1>

<CONSTANT RELEASEID 1223>

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<VERSION?
    (GLULX <CONSTANT WORD-SIZE 4>)
    (T     <CONSTANT WORD-SIZE 2>)>

<PRINC "Correspondence and Visitors Glulx ZORK I: The Great Underground Empire
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
<INSERT-FILE "living_room_museum" T>
<INSERT-FILE "house_kitchen_laboratory" T>
<INSERT-FILE "house_cellar_threshold" T>
<INSERT-FILE "house_correspondence_visitors" T>
