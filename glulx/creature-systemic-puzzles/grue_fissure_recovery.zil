"RELEASE 1271 GRUE FISSURE RECOVERY"

;"A specific object stranded at the known colony's fissure mouths. Its own
  visibility and location are the persistent recovery state; colony behavior
  remains authored by the existing grue/light routines."

<OBJECT GRUE-SURVEY-TUBE
    (IN DEAD-END-5)
    (SYNONYM TUBE CANISTER CASE)
    (ADJECTIVE BRASS SURVEY DENTED LOST)
    (DESC "dented brass survey tube")
    (LDESC "A dented brass survey tube lies crosswise at the mouth of one coal-black fissure.")
    (FLAGS TAKEBIT INVISIBLE)
    (SIZE 4)
    (VALUE 2)
    (ACTION CREATURE-GRUE-SURVEY-TUBE-F)>

<ROUTINE CREATURE-GRUE-RECOVERY-REVEAL ()
    <COND (<FSET? ,GRUE-SURVEY-TUBE ,INVISIBLE>
           <FCLEAR ,GRUE-SURVEY-TUBE ,INVISIBLE>
           <TELL "As the separate shadows retreat from the bright reach, something nonliving remains where they had crowded the cracks: a dented brass survey tube, wedged crosswise at one fissure mouth." CR>)>
    <RTRUE>>

<ROUTINE CREATURE-GRUE-SURVEY-TUBE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The tube is old brass, dented but still capped. Coal scratches show that it has been shifted repeatedly at the fissure mouth rather than carefully stored. It is close enough to take; whether reaching for it is wise depends entirely on how much light controls the cracks." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <COND (<GRUE-COLONY-STRONG-LIGHT?>
                  <TELL "The bright light holds the separate movements deep in the fissures while you reach to the mouth. Nothing can close the distance before your hand does." CR>
                  <RFALSE>)
                 (T
                  <TELL "You reach toward the brass tube. Scrapes answer from two fissures at once and close rapidly toward your hand. Your present light lets you see the danger but does not drive it back far enough to own the reach. You withdraw without the tube." CR>
                  <RTRUE>)>)>
    <RFALSE>>
