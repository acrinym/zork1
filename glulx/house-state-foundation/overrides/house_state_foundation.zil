"Persistent evolving-house state for the repository-local Zork I Glulx lineage."

;"Release 1219 establishes only the shared white-house substrate. It records a
  bounded set of meaningful receipts, derives five compact state axes from the
  real world, and appends room prose without replacing canonical topology,
  scoring, puzzle state, or object identity."

<CONSTANT HOUSE-STATE-SCHEMA 1>

<GLOBAL HOUSE-STATE-VERSION 1>
<GLOBAL HOUSE-STATE-CONDITION 0>
<GLOBAL HOUSE-STATE-COLLECTION 0>
<GLOBAL HOUSE-STATE-KNOWLEDGE 0>
<GLOBAL HOUSE-STATE-SECURITY 0>
<GLOBAL HOUSE-STATE-ATMOSPHERE 0>

<GLOBAL HOUSE-EVENT-ENTERED <> >
<GLOBAL HOUSE-EVENT-ATTIC <> >
<GLOBAL HOUSE-EVENT-CELLAR <> >
<GLOBAL HOUSE-EVENT-RETURN <> >
<GLOBAL HOUSE-EVENT-COLLECTION <> >
<GLOBAL HOUSE-EVENT-DISTURBANCE <> >

<ROUTINE HOUSE-STATE-ENSURE ()
    <COND (<NOT <EQUAL? ,HOUSE-STATE-VERSION ,HOUSE-STATE-SCHEMA>>
           <SETG HOUSE-STATE-VERSION ,HOUSE-STATE-SCHEMA>
           <SETG HOUSE-EVENT-ENTERED
                 <OR <FSET? ,KITCHEN ,TOUCHBIT>
                     <FSET? ,LIVING-ROOM ,TOUCHBIT>
                     <FSET? ,ATTIC ,TOUCHBIT>
                     <FSET? ,CELLAR ,TOUCHBIT>>>
           <SETG HOUSE-EVENT-ATTIC <FSET? ,ATTIC ,TOUCHBIT>>
           <SETG HOUSE-EVENT-CELLAR <FSET? ,CELLAR ,TOUCHBIT>>
           <SETG HOUSE-EVENT-RETURN <>>
           <SETG HOUSE-EVENT-COLLECTION <G? <OTVAL-FROB> 0>>
           <SETG HOUSE-EVENT-DISTURBANCE
                 <OR ,RUG-MOVED
                     <FSET? ,TRAP-DOOR ,OPENBIT>
                     <FSET? ,KITCHEN-WINDOW ,OPENBIT>>>)>
    <RFALSE>>

<ROUTINE HOUSE-STATE-REFRESH ("AUX" VALUE)
    <HOUSE-STATE-ENSURE>
    <SET VALUE <OTVAL-FROB>>
    <COND (<G? .VALUE 0> <SETG HOUSE-EVENT-COLLECTION T>)>
    <COND (<OR ,RUG-MOVED
               <FSET? ,TRAP-DOOR ,OPENBIT>
               <FSET? ,KITCHEN-WINDOW ,OPENBIT>>
           <SETG HOUSE-EVENT-DISTURBANCE T>)>

    <COND (,HOUSE-EVENT-DISTURBANCE <SETG HOUSE-STATE-CONDITION 2>)
          (,HOUSE-EVENT-ENTERED <SETG HOUSE-STATE-CONDITION 1>)
          (T <SETG HOUSE-STATE-CONDITION 0>)>

    <COND (<G? .VALUE 49> <SETG HOUSE-STATE-COLLECTION 3>)
          (<G? .VALUE 14> <SETG HOUSE-STATE-COLLECTION 2>)
          (<G? .VALUE 0> <SETG HOUSE-STATE-COLLECTION 1>)
          (T <SETG HOUSE-STATE-COLLECTION 0>)>

    <COND (,HOUSE-EVENT-RETURN <SETG HOUSE-STATE-KNOWLEDGE 2>)
          (<OR ,HOUSE-EVENT-ATTIC ,HOUSE-EVENT-CELLAR
               ,HOUSE-EVENT-ENTERED>
           <SETG HOUSE-STATE-KNOWLEDGE 1>)
          (T <SETG HOUSE-STATE-KNOWLEDGE 0>)>

    <COND (<OR <FSET? ,TRAP-DOOR ,OPENBIT>
               <FSET? ,KITCHEN-WINDOW ,OPENBIT>
               ,MAGIC-FLAG>
           <SETG HOUSE-STATE-SECURITY 2>)
          (,HOUSE-EVENT-DISTURBANCE <SETG HOUSE-STATE-SECURITY 1>)
          (T <SETG HOUSE-STATE-SECURITY 0>)>

    <COND (,HOUSE-EVENT-RETURN <SETG HOUSE-STATE-ATMOSPHERE 2>)
          (,HOUSE-EVENT-ENTERED <SETG HOUSE-STATE-ATMOSPHERE 1>)
          (T <SETG HOUSE-STATE-ATMOSPHERE 0>)>
    <RFALSE>>

<ROUTINE HOUSE-STATE-ENTER (ROOM)
    <HOUSE-STATE-ENSURE>
    <SETG HOUSE-EVENT-ENTERED T>
    <COND (<EQUAL? .ROOM ,ATTIC>
           <SETG HOUSE-EVENT-ATTIC T>)
          (<EQUAL? .ROOM ,CELLAR>
           <SETG HOUSE-EVENT-CELLAR T>)
          (<AND <EQUAL? .ROOM ,LIVING-ROOM>
                ,HOUSE-EVENT-CELLAR>
           <SETG HOUSE-EVENT-RETURN T>)>
    <HOUSE-STATE-REFRESH>
    <RFALSE>>

<ROUTINE HOUSE-STATE-AFTER-LIVING-ACTION ()
    <HOUSE-STATE-REFRESH>
    <RFALSE>>

<ROUTINE HOUSE-STATE-PROJECT (ROOM)
    <HOUSE-STATE-REFRESH>
    <COND (<EQUAL? .ROOM ,LIVING-ROOM>
           <COND (<G? ,HOUSE-STATE-COLLECTION 0>
                  <TELL "The room no longer feels wholly abandoned; the trophy case has begun to look like evidence of an adventurer who intends to return." CR>)
                 (,HOUSE-EVENT-RETURN
                  <TELL "However dusty it remains, the room now has the settled air of a place returned to between expeditions." CR>)
                 (,HOUSE-EVENT-ENTERED
                  <TELL "For all its dust, the room bears the faint first impression of being used again." CR>)>)
          (<EQUAL? .ROOM ,KITCHEN>
           <COND (,HOUSE-EVENT-DISTURBANCE
                  <TELL "The opened routes and recently used table make the kitchen feel less abandoned than merely unattended." CR>)
                 (,HOUSE-EVENT-ENTERED
                  <TELL "The kitchen has the tentative air of a room being considered for practical use." CR>)>)
          (<EQUAL? .ROOM ,ATTIC>
           <COND (,HOUSE-EVENT-ATTIC
                  <TELL "The dust remains, but the attic now feels less like forgotten storage and more like a place waiting to remember." CR>)>)
          (<EQUAL? .ROOM ,CELLAR>
           <COND (,HOUSE-EVENT-RETURN
                  <TELL "The cellar has become a familiar threshold: home above, expedition below." CR>)
                 (,HOUSE-EVENT-CELLAR
                  <TELL "The cellar feels less like another room of the house than the place where the house gives way to the underground." CR>)>)>
    <RFALSE>>

<ROUTINE HOUSE-STATE-ATTIC-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-ENTER>
           <HOUSE-STATE-ENTER ,ATTIC>
           <RFALSE>)
          (<EQUAL? .RARG ,M-LOOK>
           <TELL "This is the attic. The only exit is a stairway leading down." CR>
           <HOUSE-STATE-PROJECT ,ATTIC>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE HOUSE-STATE-RECAP ("AUX" (SEEN <>))
    <HOUSE-STATE-REFRESH>
    <COND (,HOUSE-EVENT-ENTERED
           <SET SEEN T>
           <TELL "- You began using the white house as a place rather than merely passing through it." CR>)>
    <COND (,HOUSE-EVENT-ATTIC
           <SET SEEN T>
           <TELL "- You visited the attic, establishing the first quiet foundation for the house's future memory." CR>)>
    <COND (,HOUSE-EVENT-CELLAR
           <SET SEEN T>
           <TELL "- You crossed the cellar threshold between the house and the underground." CR>)>
    <COND (,HOUSE-EVENT-RETURN
           <SET SEEN T>
           <TELL "- You returned to the living room after entering the underground, giving the house its first completed expedition cycle." CR>)>
    <COND (,HOUSE-EVENT-COLLECTION
           <SET SEEN T>
           <TELL "- The real trophy-case collection began changing how the living room feels without changing canonical score authority." CR>)>
    <COND (,HOUSE-EVENT-DISTURBANCE
           <SET SEEN T>
           <TELL "- Opened routes, the moved rug, or the exposed trap door left visible evidence that the house has been disturbed." CR>)>
    <COND (.SEEN <RTRUE>)>
    <RFALSE>>

;"Release 1218 contains no canonical Bedroom room. This foundation deliberately
  adds no unreachable placeholder or topology change. Future room trains may
  call the same compact state and projection substrate when a Bedroom is
  deliberately authored."
