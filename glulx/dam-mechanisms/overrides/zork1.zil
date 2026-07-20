"ZORK1 DAM MECHANISMS GLULX for
  	        Zork I: The Great Underground Empire
  	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved."

;"Repository-local mechanism overlay.
  Release 1215 retains every qualified Release 1214 behavior and adds focused
  Flood Control Dam #3 experimentation around the real panel, interlock, bolt,
  buttons, leak, tools, water state, diagnostics, and recap. It is not presented
  as an official Infocom release."

<VERSION ZIP>

<SETG ZORK-NUMBER 1>

<CONSTANT RELEASEID 1215>

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<VERSION?
	(GLULX <CONSTANT WORD-SIZE 4>)
	(T     <CONSTANT WORD-SIZE 2>)>

<PRINC "Dam Mechanisms Glulx ZORK I: The Great Underground Empire
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
