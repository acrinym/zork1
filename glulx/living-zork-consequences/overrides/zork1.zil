"ZORK1 LIVING ZORK CONSEQUENCES GLULX for
  Zork I: The Great Underground Empire
  (c) Copyright 1983 Infocom, Inc. All Rights Reserved."

;"Repository-local post-House gameplay train. Release 1236 retains every
  qualified Release 1235 behavior and gives the Great Canyon fall visible
  cause, deliberate rope preparation, physical rescue, and preserved death."

<VERSION ZIP>

<SETG ZORK-NUMBER 1>

<CONSTANT RELEASEID 1236>

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<VERSION?
    (GLULX <CONSTANT WORD-SIZE 4>)
    (T     <CONSTANT WORD-SIZE 2>)>

<PRINC "Living Zork Consequences Glulx ZORK I: The Great Underground Empire
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
<INSERT-FILE "house_vulnerability" T>
<INSERT-FILE "house_vulnerability_actions" T>
<INSERT-FILE "house_vulnerability_records" T>
<INSERT-FILE "house_vulnerability_integration" T>
<INSERT-FILE "completed_expedition_archive" T>
<INSERT-FILE "corpus_causal_warning" T>
<INSERT-FILE "museum_intake_first_gallery" T>
<INSERT-FILE "mara_companion" T>
<INSERT-FILE "cuisine_hunger_stamina" T>
<INSERT-FILE "living_zork_consequences" T>
