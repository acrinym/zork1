"CELLAR RECOVERY LOCKER for Release 1238"

;"A post-victory physical cache that protects only the real objects placed
  inside it. Canonical death remains authoritative for carried inventory."

<SYNTAX PREPARE OBJECT = V-RECOVERY-LOCKER-PREPARE>

<CONSTANT RECOVERY-LOCKER-SCHEMA 1>
<CONSTANT RLS-VERSION 0>
<CONSTANT RLS-DEATHS-AT-SEAL 1>
<CONSTANT RLS-RECOVERIES 2>
<CONSTANT RLS-SEALED 3>
<CONSTANT RECOVERY-LOCKER-STATE <TABLE RECOVERY-LOCKER-SCHEMA 0 0 0>>

<OBJECT RECOVERY-LOCKER-AMBER-LAMP
    (SYNONYM LAMP LIGHT BEACON)
    (ADJECTIVE FIXED AMBER RECOVERY CELLAR)
    (DESC "fixed amber recovery lamp")
    (LDESC "A fixed amber lamp glows above the recovery locker.")
    (FLAGS LIGHTBIT ONBIT TRYTAKEBIT)
    (ACTION RECOVERY-LOCKER-AMBER-LAMP-FCN)>

<OBJECT EXPEDITION-RECOVERY-LOCKER
    (SYNONYM LOCKER CACHE STASH CHEST)
    (ADJECTIVE EXPEDITION RECOVERY CELLAR IRON)
    (DESC "iron expedition recovery locker")
    (LDESC "An iron expedition recovery locker is bolted beneath the Cellar staging bench.")
    (FLAGS CONTBIT SEARCHBIT OPENBIT TRYTAKEBIT)
    (CAPACITY 30)
    (ACTION EXPEDITION-RECOVERY-LOCKER-FCN)
    (CONTFCN EXPEDITION-RECOVERY-LOCKER-CONTFCN)>

<ROUTINE RECOVERY-LOCKER-GET (SLOT)
    <GET ,RECOVERY-LOCKER-STATE .SLOT>>

<ROUTINE RECOVERY-LOCKER-PUT (SLOT VALUE)
    <PUT ,RECOVERY-LOCKER-STATE .SLOT .VALUE>>

<ROUTINE RECOVERY-LOCKER-ENSURE ()
    <COND (<NOT <EQUAL? <RECOVERY-LOCKER-GET ,RLS-VERSION>
                        ,RECOVERY-LOCKER-SCHEMA>>
           <RECOVERY-LOCKER-PUT ,RLS-VERSION ,RECOVERY-LOCKER-SCHEMA>
           <RECOVERY-LOCKER-PUT ,RLS-DEATHS-AT-SEAL 0>
           <RECOVERY-LOCKER-PUT ,RLS-RECOVERIES 0>
           <RECOVERY-LOCKER-PUT ,RLS-SEALED 0>)>
    <RFALSE>>

<ROUTINE RECOVERY-LOCKER-UNLOCKED? ()
    <EXPEDITION-ENSURE>
    <COND (<EXPEDITION-HAS? ,ES-SEALED 2> <RTRUE>)>
    <RFALSE>>

<ROUTINE RECOVERY-LOCKER-MATERIALIZE ()
    <RECOVERY-LOCKER-ENSURE>
    <COND (<AND <RECOVERY-LOCKER-UNLOCKED?>
                <NOT <LOC ,EXPEDITION-RECOVERY-LOCKER>>>
           <MOVE ,EXPEDITION-RECOVERY-LOCKER ,CELLAR>)>
    <COND (<AND <RECOVERY-LOCKER-UNLOCKED?>
                <NOT <LOC ,RECOVERY-LOCKER-AMBER-LAMP>>>
           <MOVE ,RECOVERY-LOCKER-AMBER-LAMP ,CELLAR>)>
    <RFALSE>>

<ROUTINE RECOVERY-LOCKER-COUNT ("AUX" ITEM (COUNT 0))
    <SET ITEM <FIRST? ,EXPEDITION-RECOVERY-LOCKER>>
    <REPEAT ()
        <COND (<NOT .ITEM> <RETURN .COUNT>)>
        <SET COUNT <+ .COUNT 1>>
        <SET ITEM <NEXT? .ITEM>>>>

<ROUTINE RECOVERY-LOCKER-LIST ("AUX" ITEM)
    <SET ITEM <FIRST? ,EXPEDITION-RECOVERY-LOCKER>>
    <COND (<NOT .ITEM>
           <TELL " It is empty.">)
          (T
           <TELL " It holds ">
           <REPEAT ()
               <TELL D .ITEM>
               <SET ITEM <NEXT? .ITEM>>
               <COND (<NOT .ITEM> <RETURN>)
                     (T <TELL " and ">)>>
           <TELL ".">)>
    <RTRUE>>

<ROUTINE RECOVERY-LOCKER-AMBER-LAMP-FCN ()
    <COND (<VERB? TAKE MOVE MUNG>
           <TELL "The amber recovery lamp is wired into the Cellar wall." CR>
           <RTRUE>)
          (<VERB? LAMP-OFF>
           <TELL "The recovery lamp has no local switch; it remains lit so a prepared cache can be reached after disaster." CR>
           <RTRUE>)
          (<VERB? LAMP-ON>
           <TELL "The amber recovery lamp is already on." CR>
           <RTRUE>)
          (<VERB? EXAMINE>
           <TELL "Its low amber glow illuminates the Cellar locker without becoming portable expedition gear." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE EXPEDITION-RECOVERY-LOCKER-CONTFCN ()
    <COND (<AND <RECOVERY-LOCKER-GET ,RLS-SEALED>
                <VERB? TAKE>>
           <TELL "The prepared seal must be broken before anything can leave the recovery locker." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE EXPEDITION-RECOVERY-LOCKER-FCN ()
    <RECOVERY-LOCKER-MATERIALIZE>
    <COND (<AND <EQUAL? ,PRSO ,EXPEDITION-RECOVERY-LOCKER>
                <VERB? TAKE MOVE MUNG>>
           <TELL "The iron locker is bolted into the Cellar wall." CR>
           <RTRUE>)
          (<AND <EQUAL? ,PRSI ,EXPEDITION-RECOVERY-LOCKER>
                <VERB? PUT>
                <RECOVERY-LOCKER-GET ,RLS-SEALED>>
           <TELL "The recovery locker is sealed. Break the seal before changing the kit." CR>
           <RTRUE>)
          (<AND <EQUAL? ,PRSI ,EXPEDITION-RECOVERY-LOCKER>
                <VERB? PUT>
                <G? <RECOVERY-LOCKER-COUNT> 1>>
           <TELL "The recovery locker has only two real kit positions. Remove something before adding another object." CR>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,EXPEDITION-RECOVERY-LOCKER>
                <VERB? OPEN>
                <RECOVERY-LOCKER-GET ,RLS-SEALED>>
           <RECOVERY-LOCKER-PUT ,RLS-SEALED 0>
           <FSET ,EXPEDITION-RECOVERY-LOCKER ,OPENBIT>
           <COND (<G? ,DEATHS
                      <RECOVERY-LOCKER-GET ,RLS-DEATHS-AT-SEAL>>
                  <RECOVERY-LOCKER-PUT ,RLS-RECOVERIES
                       <+ <RECOVERY-LOCKER-GET ,RLS-RECOVERIES> 1>>
                  <TELL "The prepared seal breaks. After death scattered what remained on your body, the recovery kit is still exactly where you locked it." CR>)
                 (T
                  <TELL "You break the prepared seal before death makes the cache necessary. The objects remain real and may now be changed or removed." CR>)>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,EXPEDITION-RECOVERY-LOCKER>
                <VERB? EXAMINE LOOK-INSIDE SEARCH>>
           <TELL "The bolted locker accepts two physical objects with a combined size no greater than thirty. ">
           <COND (<RECOVERY-LOCKER-GET ,RLS-SEALED>
                  <TELL "Its prepared seal is intact.">)
                 (T <TELL "It is available for deliberate expedition staging.">)>
           <RECOVERY-LOCKER-LIST>
           <CRLF>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE V-RECOVERY-LOCKER-PREPARE ()
    <RECOVERY-LOCKER-MATERIALIZE>
    <COND (<NOT <EQUAL? ,PRSO ,EXPEDITION-RECOVERY-LOCKER>>
           <TELL "Only the expedition recovery locker accepts this preparation." CR>)
          (<NOT <RECOVERY-LOCKER-UNLOCKED?>>
           <TELL "The recovery locker is not available until Expedition B is sealed." CR>)
          (<NOT <EQUAL? ,HERE ,CELLAR>>
           <TELL "The locker must be prepared physically in the Cellar." CR>)
          (<RECOVERY-LOCKER-GET ,RLS-SEALED>
           <TELL "The recovery locker is already prepared and sealed." CR>)
          (<NOT <FIRST? ,EXPEDITION-RECOVERY-LOCKER>>
           <TELL "An empty locker is not a recovery kit. Place one or two real objects inside first." CR>)
          (T
           <FCLEAR ,EXPEDITION-RECOVERY-LOCKER ,OPENBIT>
           <RECOVERY-LOCKER-PUT ,RLS-SEALED 1>
           <RECOVERY-LOCKER-PUT ,RLS-DEATHS-AT-SEAL ,DEATHS>
           <TELL "You close the iron door and press the numbered expedition seal across it. Whatever remains on your body is still exposed to the Great Underground Empire; only these physical contents are protected here." CR>)>
    <RTRUE>>
