"ZORK1 HOUSE REST AND DREAMS GLULX for
  Zork I: The Great Underground Empire
  (c) Copyright 1983 Infocom, Inc. All Rights Reserved."

;"Repository-local Bedroom rest overlay. Release 1228 retains every qualified
  Release 1227 behavior and adds optional bounded sleep, discovery-driven
  dreams, delayed house consequences, and physical archive records."

<VERSION ZIP>

<SETG ZORK-NUMBER 1>

<CONSTANT RELEASEID 1228>

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<VERSION?
    (GLULX <CONSTANT WORD-SIZE 4>)
    (T     <CONSTANT WORD-SIZE 2>)>

<PRINC "House Rest and Dreams Glulx ZORK I: The Great Underground Empire
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
<INSERT-FILE "attic_archive_core" T>
<INSERT-FILE "attic_npc_dossiers" T>
<INSERT-FILE "attic_area_case_files" T>
<INSERT-FILE "attic_playback" T>
<INSERT-FILE "house_rest_and_dreams" T>