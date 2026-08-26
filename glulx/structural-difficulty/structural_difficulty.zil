"RELEASE 1269 STRUCTURAL DIFFICULTY MODES"

;"Three authored structures for the existing dragon encounter. Difficulty is
  not a global combat scalar: it changes evidence redundancy, a live-threat
  consequence window, one recoverable failure, and the condition of one real
  protective resource while keeping the same rooms, dragon, routes, parser
  language, and predecessor authorities. Classic is the compatibility default."

<SYNTAX DIFFICULTY = V-STRUCTURAL-DIFFICULTY>
<SYNTAX DIFFICULTY OBJECT (FIND RMUNGBIT) = V-STRUCTURAL-DIFFICULTY>
<SYNONYM DIFFICULTY CHALLENGE>

<CONSTANT SD-MODE 0>
<CONSTANT SD-LOCKED 1>
<CONSTANT SD-RECOVERY-USED 2>
<CONSTANT SD-DRAGON-INITIALIZED 3>
<CONSTANT SD-FORGIVING 1>
<CONSTANT SD-CLASSIC 2>
<CONSTANT SD-EXACTING 3>
<CONSTANT STRUCTURAL-DIFFICULTY-STATE <TABLE SD-CLASSIC 0 0 0>>

<OBJECT SD-FORGIVING-MODE
    (IN GLOBAL-OBJECTS)
    (SYNONYM FORGIVING GENTLE EASIER)
    (ADJECTIVE LOWER RECOVERABLE)
    (DESC "Forgiving structural difficulty")
    (FLAGS NDESCBIT RMUNGBIT)>

<OBJECT SD-CLASSIC-MODE
    (IN GLOBAL-OBJECTS)
    (SYNONYM CLASSIC STANDARD NORMAL)
    (ADJECTIVE ORIGINAL DEFAULT)
    (DESC "Classic structural difficulty")
    (FLAGS NDESCBIT RMUNGBIT)>

<OBJECT SD-EXACTING-MODE
    (IN GLOBAL-OBJECTS)
    (SYNONYM EXACTING HARD HARDER SEVERE)
    (ADJECTIVE HIGHER TIGHTER)
    (DESC "Exacting structural difficulty")
    (FLAGS NDESCBIT RMUNGBIT)>

<ROUTINE STRUCTURAL-DIFFICULTY-GET (SLOT)
    <GET ,STRUCTURAL-DIFFICULTY-STATE .SLOT>>

<ROUTINE STRUCTURAL-DIFFICULTY-PUT (SLOT VALUE)
    <PUT ,STRUCTURAL-DIFFICULTY-STATE .SLOT .VALUE>>

<ROUTINE STRUCTURAL-DIFFICULTY-FORGIVING? ()
    <COND (<EQUAL? <STRUCTURAL-DIFFICULTY-GET ,SD-MODE> ,SD-FORGIVING> <RTRUE>)>
    <RFALSE>>

<ROUTINE STRUCTURAL-DIFFICULTY-EXACTING? ()
    <COND (<EQUAL? <STRUCTURAL-DIFFICULTY-GET ,SD-MODE> ,SD-EXACTING> <RTRUE>)>
    <RFALSE>>

<ROUTINE STRUCTURAL-DIFFICULTY-RESET ()
    <STRUCTURAL-DIFFICULTY-PUT ,SD-MODE ,SD-CLASSIC>
    <STRUCTURAL-DIFFICULTY-PUT ,SD-LOCKED 0>
    <STRUCTURAL-DIFFICULTY-PUT ,SD-RECOVERY-USED 0>
    <STRUCTURAL-DIFFICULTY-PUT ,SD-DRAGON-INITIALIZED 0>
    <RTRUE>>

<ROUTINE STRUCTURAL-DIFFICULTY-PRINT-MODE ()
    <COND (<STRUCTURAL-DIFFICULTY-FORGIVING?> <TELL "Forgiving">)
          (<STRUCTURAL-DIFFICULTY-EXACTING?> <TELL "Exacting">)
          (T <TELL "Classic">)>
    <RTRUE>>

<ROUTINE STRUCTURAL-DIFFICULTY-DESCRIBE ()
    <TELL "Structural difficulty is ">
    <STRUCTURAL-DIFFICULTY-PRINT-MODE>
    <TELL ". ">
    <COND (<STRUCTURAL-DIFFICULTY-FORGIVING?>
           <TELL "The dragon situation supplies one redundant physical cue, one additional watched action before breath, and one recoverable line-of-fire retreat if hesitation still goes too far. The existing fire screen begins sound.">)
          (<STRUCTURAL-DIFFICULTY-EXACTING?>
           <TELL "The dragon keeps the same fair evidence, commands, routes, and watch window as Classic, but the existing fire screen begins already scorched, leaving one fewer protective survival.">)
          (T
           <TELL "This preserves the Release 1268 world structure exactly: the existing evidence, dragon watch window, fire-screen condition, routes, and consequences remain unchanged.">)>
    <COND (<STRUCTURAL-DIFFICULTY-GET ,SD-LOCKED>
           <TELL " The structure is now committed because you have entered the dragon approach.">)
          (T
           <TELL " You may change it until you enter the dragon approach; after that, the world will not rewrite itself around you.">)>
    <CRLF>
    <RTRUE>>

<ROUTINE STRUCTURAL-DIFFICULTY-SET (MODE)
    <COND (<STRUCTURAL-DIFFICULTY-GET ,SD-LOCKED>
           <TELL "The dragon situation is already physically committed. Changing difficulty now would rewrite evidence and equipment history behind your back, so the current structure remains ">
           <STRUCTURAL-DIFFICULTY-PRINT-MODE>
           <TELL "." CR>
           <RTRUE>)>
    <STRUCTURAL-DIFFICULTY-PUT ,SD-MODE .MODE>
    <STRUCTURAL-DIFFICULTY-PUT ,SD-RECOVERY-USED 0>
    <TELL "Structural difficulty set to ">
    <STRUCTURAL-DIFFICULTY-PRINT-MODE>
    <TELL "." CR>
    <STRUCTURAL-DIFFICULTY-DESCRIBE>
    <RTRUE>>

<ROUTINE V-STRUCTURAL-DIFFICULTY ()
    <COND (<ZERO? ,PRSO>
           <STRUCTURAL-DIFFICULTY-DESCRIBE>)
          (<EQUAL? ,PRSO ,SD-FORGIVING-MODE>
           <STRUCTURAL-DIFFICULTY-SET ,SD-FORGIVING>)
          (<EQUAL? ,PRSO ,SD-CLASSIC-MODE>
           <STRUCTURAL-DIFFICULTY-SET ,SD-CLASSIC>)
          (<EQUAL? ,PRSO ,SD-EXACTING-MODE>
           <STRUCTURAL-DIFFICULTY-SET ,SD-EXACTING>)
          (T
           <TELL "Difficulty is an authored world structure here, not a property of the " D ,PRSO ". Choose FORGIVING, CLASSIC, or EXACTING." CR>
           <RTRUE>)>>

<ROUTINE STRUCTURAL-DIFFICULTY-COMMIT-DRAGON ()
    <STRUCTURAL-DIFFICULTY-PUT ,SD-LOCKED 1>
    <COND (<ZERO? <STRUCTURAL-DIFFICULTY-GET ,SD-DRAGON-INITIALIZED>>
           <STRUCTURAL-DIFFICULTY-PUT ,SD-DRAGON-INITIALIZED 1>
           <ABLATIVE-APPLY-STRUCTURAL-DIFFICULTY>)>
    <RTRUE>>

<ROUTINE STRUCTURAL-DIFFICULTY-WATCH-LIMIT ()
    <COND (<STRUCTURAL-DIFFICULTY-FORGIVING?> 2)
          (T 1)>>

<ROUTINE STRUCTURAL-DIFFICULTY-WATCH-WARNING (COUNT)
    <COND (<AND <STRUCTURAL-DIFFICULTY-FORGIVING?> <EQUAL? .COUNT 2>>
           <TELL "The dragon's patience visibly narrows rather than vanishing without evidence. Its foreclaws spread for purchase, its chest begins to swell, and the south bend remains open behind you. You have spent the wider margin this structure gives you; another delay will put you in the line of fire." CR>)
          (T
           <TELL "The dragon does not attack merely because you entered. It watches the action you chose instead. Heat leaks between its teeth as a very clear statement that you have spent one opportunity in a room containing a live territorial animal." CR>)>
    <RTRUE>>

<ROUTINE STRUCTURAL-DIFFICULTY-FORGIVING-RETREAT? ()
    <COND (<NOT <STRUCTURAL-DIFFICULTY-FORGIVING?>> <RFALSE>)
          (<STRUCTURAL-DIFFICULTY-GET ,SD-RECOVERY-USED> <RFALSE>)>
    <STRUCTURAL-DIFFICULTY-PUT ,SD-RECOVERY-USED 1>
    <DRAGON-PUT ,DS-WATCH 0>
    <TELL "The dragon finally commits to the breath you were warned about. Because the cleft's bend was made unusually legible, you throw yourself south as the first sheet of fire crosses the gallery. Heat catches your back and the stone beside you flashes orange, but the bend breaks the line of fire before the second wash arrives. You survive in the Scorched Cleft. That recoverable hesitation is spent." CR>
    <GOTO ,DRAGON-APPROACH>
    <RTRUE>>

<ROUTINE STRUCTURAL-DIFFICULTY-DRAGON-APPROACH-F (RARG)
    <COND (<EQUAL? .RARG ,M-ENTER>
           <STRUCTURAL-DIFFICULTY-COMMIT-DRAGON>
           <RFALSE>)
          (<EQUAL? .RARG ,M-LOOK>
           <TELL "A soot-dark cleft leaves the old mine passage and climbs into hotter basalt. Scratches in the stone are too broad for tools, and several old white bones have been pushed deliberately against the wall. South returns to the Timber Room; north enters a larger blackened gallery.">
           <COND (<STRUCTURAL-DIFFICULTY-FORGIVING?>
                  <TELL " Looking closer, the bones are blackest on the sides that faced north, while the bend back toward the mine is comparatively unscorched. The stone records a second, redundant fact: retreat around that bend can break a line of fire.">)>
           <CRLF>
           <RTRUE>)>
    <RFALSE>>
