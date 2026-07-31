"MUSEUM INTAKE AND FIRST GALLERY for Release 1234"

;"Release 1234 preserves the physical museum contract while correcting intake
  precedence discovered by Mara's real custody test: explicit display classes
  outrank generic treasure value, while ordinary treasure still uses the
  canonical trophy case."

<SYNTAX EXHIBIT OBJECT (MANY HELD HAVE) = V-MUSEUM-EXHIBIT>
<SYNTAX CATALOG OBJECT (FIND RMUNGBIT) = V-MUSEUM-CATALOG>
<SYNTAX REVIEW OBJECT (FIND RMUNGBIT) = V-MUSEUM-CATALOG>

<OBJECT MUSEUM-CATALOG-OBJECT
    (IN GLOBAL-OBJECTS)
    (SYNONYM MUSEUM GALLERY COLLECTION)
    (ADJECTIVE LIVING ROOM PRIVATE)
    (DESC "museum collection")
    (FLAGS NDESCBIT RMUNGBIT)>

<ROUTINE MUSEUM-INTAKE-SURFACE (OBJ)
    <COND (<MUSEUM-ACCEPTS? ,MUSEUM-FRAME .OBJ>
           <RETURN ,MUSEUM-FRAME>)
          (<MUSEUM-ACCEPTS? ,MUSEUM-WEAPON-WALL .OBJ>
           <RETURN ,MUSEUM-WEAPON-WALL>)
          (<MUSEUM-ACCEPTS? ,MUSEUM-RECORD-SHELF .OBJ>
           <RETURN ,MUSEUM-RECORD-SHELF>)
          (<G? <GETP .OBJ ,P?TVALUE> 0>
           <RETURN ,TROPHY-CASE>)
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
