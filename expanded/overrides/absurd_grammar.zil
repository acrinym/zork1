"Fallback grammar for Adventurer Misconduct."

;"Canonical syntax remains defined in gsyntax.zil. The original game already
  provides a global ME object with SELF and MYSELF synonyms. Release 121 reuses
  the lightweight BLESSINGS global object for VOICE and WORDS while preserving
  its original nouns. These fallback entries support natural absurd commands
  without consuming object slots or deleting original vocabulary."

<SYNTAX EAT OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-ABS-EAT>

<SYNTAX KISS OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-ABS-KISS>

<SYNTAX THROW OBJECT (HELD CARRIED ON-GROUND IN-ROOM)
	AT OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-ABS-THROW>
<SYNTAX THROW OBJECT (HELD CARRIED ON-GROUND IN-ROOM)
	WITH OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-ABS-THROW>

<SYNTAX THROW FIT = V-ABS-THROW-FIT>
<SYNTAX THROW TANTRUM = V-ABS-THROW-FIT>
