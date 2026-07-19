"ZORK1 for
 	        Zork I: The Great Underground Empire
 	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved."

;"Repository-local optimized Glulx overlay.
  Includes match lowercase tracked filenames exactly.
  RELEASEID 1201 identifies the Glulx port of project Release 120 and is not
  presented as an official Infocom release."

<VERSION ZIP>

<SETG ZORK-NUMBER 1>

<CONSTANT RELEASEID 1201>

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<VERSION?
	(GLULX <CONSTANT WORD-SIZE 4>)
	(T     <CONSTANT WORD-SIZE 2>)>

<PRINC "Renovated ZORK I: The Great Underground Empire
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
