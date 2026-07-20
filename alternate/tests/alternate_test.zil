"Test-only setup verbs for Release 122 nest-fire qualification."

<SYNTAX ALTSAFE = V-ALT-SAFE>
<SYNTAX ALTBREAK = V-ALT-BREAK>

<ROUTINE ALT-TEST-NEST-BASE ()
	<MOVE ,TORCH ,WINNER>
	<FSET ,TORCH ,ONBIT>
	<FSET ,TORCH ,FLAMEBIT>
	<MOVE ,NEST ,UP-A-TREE>
	<MOVE ,EGG ,NEST>
	<MOVE ,CANARY ,EGG>
	<GOTO ,PATH>
	<RTRUE>>

<ROUTINE V-ALT-SAFE ()
	<ALT-TEST-NEST-BASE>
	<MOVE ,SANDWICH-BAG ,WINNER>
	<TELL "[Test-only prepared-catcher scenario.]" CR>>

<ROUTINE V-ALT-BREAK ()
	<ALT-TEST-NEST-BASE>
	<MOVE ,SANDWICH-BAG ,KITCHEN-TABLE>
	<TELL "[Test-only unprepared-fall scenario.]" CR>>
