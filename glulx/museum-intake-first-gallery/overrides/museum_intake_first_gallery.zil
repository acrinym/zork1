"MUSEUM INTAKE AND FIRST GALLERY for Release 1233"

;"The existing Living Room surfaces, trophy case, object locations, scoring,
  active-field warnings, theft, and save state remain authoritative. This
  module selects a canonical destination and delegates the real action."

<SYNTAX EXHIBIT OBJECT (MANY HELD HAVE) = V-MUSEUM-EXHIBIT>
<SYNTAX CATALOG MUSEUM = V-MUSEUM-CATALOG>
<SYNTAX REVIEW MUSEUM = V-MUSEUM-CATALOG>

<ROUTINE MUSEUM-INTAKE-SURFACE (OBJ)
    <COND (<G? <GETP .OBJ ,P?TVALUE> 0>
           <RETURN ,TROPHY-CASE>)
          (<MUSEUM-ACCEPTS? ,MUSEUM-FRAME .OBJ>
           <RETURN ,MUSEUM-FRAME>)
          (<MUSEUM-ACCEPTS? ,MUSEUM-WEAPON-WALL .OBJ>
           <RETURN ,MUSEUM-WEAPON-WALL>)
          (<MUSEUM-ACCEPTS? ,MUSEUM-RECORD-SHELF .OBJ>
           <RETURN ,MUSEUM-RECORD-SHELF>)
          (<MUSEUM-ACCEPTS? ,MUSEUM-RELIC-STAND .OBJ>
           <RETURN ,MUSEUM-RELIC-STAND>)>
    <RFALSE>>

<ROUTINE V-MUSEUM-EXHIBIT ("AUX" SURFACE)
    <COND (<NOT <EQUAL? ,HERE ,LIVING-ROOM>>
           <TELL "There is no museum intake here." CR>)
          (<SET SURFACE <MUSEUM-INTAKE-SURFACE ,PRSO>>
           <COND (<EQUAL? .SURFACE ,TROPHY-CASE>
                  <PERFORM ,V?PUT ,PRSO .SURFACE>)
                 (T
                  <PERFORM ,V?PUT-ON ,PRSO .SURFACE>)>)
          (T
           <PERFORM ,V?PUT-ON ,PRSO ,MUSEUM-RELIC-STAND>)>>

<ROUTINE V-MUSEUM-CATALOG ()
    <COND (<EQUAL? ,HERE ,LIVING-ROOM>
           <MUSEUM-PROJECT>)
          (T
           <TELL "There is no museum intake here." CR>)>>
