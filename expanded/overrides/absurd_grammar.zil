"Fallback grammar for Adventurer Misconduct."

;"Canonical syntax remains defined in gsyntax.zil. These later entries are
  considered when the original food, weapon, actor, or held-object constraints
  cannot satisfy a deliberately absurd command."

<SYNTAX EAT OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-ABS-EAT>

<SYNTAX KISS OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-ABS-KISS>

<SYNTAX THROW OBJECT (HELD CARRIED ON-GROUND IN-ROOM)
	AT OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-ABS-THROW>
<SYNTAX THROW OBJECT (HELD CARRIED ON-GROUND IN-ROOM)
	WITH OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-ABS-THROW>
