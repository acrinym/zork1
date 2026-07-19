"ZORK1 ASSISTED GLULX for
 	        Zork I: The Great Underground Empire
 	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved."

;"Repository-local Release 121 assistance overlay.
  Release 1211 contains only action-hook infrastructure and optional orientation
  commands. It is not presented as an official Infocom release."

<VERSION ZIP>

<SETG ZORK-NUMBER 1>

<CONSTANT RELEASEID 1211>

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<VERSION?
	(GLULX <CONSTANT WORD-SIZE 4>)
	(T     <CONSTANT WORD-SIZE 2>)>

<PRINC "Assisted ZORK I: The Great Underground Empire
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
