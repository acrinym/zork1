"Release 1265 authored qualitative light authority."

<CONSTANT CL-LAMP-STAGE 0>
<CONSTANT CL-CANDLE-STAGE 1>
<CONSTANT CL-CANDLE-WET 2>
<CONSTANT CONSUMABLE-LIGHT-STATE <TABLE 3 2 0>>

<CONSTANT LIGHT-DARK 0>
<CONSTANT LIGHT-EMBER 1>
<CONSTANT LIGHT-WEAK 2>
<CONSTANT LIGHT-BRIGHT 3>

<ROUTINE CONSUMABLE-LIGHT-GET (SLOT)
    <GET ,CONSUMABLE-LIGHT-STATE .SLOT>>

<ROUTINE CONSUMABLE-LIGHT-PUT (SLOT VALUE)
    <PUT ,CONSUMABLE-LIGHT-STATE .SLOT .VALUE>>

<ROUTINE CONSUMABLE-LIGHT-RESET ()
    <CONSUMABLE-LIGHT-PUT ,CL-LAMP-STAGE ,LIGHT-BRIGHT>
    <CONSUMABLE-LIGHT-PUT ,CL-CANDLE-STAGE ,LIGHT-WEAK>
    <CONSUMABLE-LIGHT-PUT ,CL-CANDLE-WET 0>
    <RTRUE>>

<ROUTINE CONSUMABLE-NOTE-LAMP-TICK (TICK)
    <COND (<0? .TICK>
           <CONSUMABLE-LIGHT-PUT ,CL-LAMP-STAGE ,LIGHT-DARK>)
          (<L? .TICK 70>
           <CONSUMABLE-LIGHT-PUT ,CL-LAMP-STAGE ,LIGHT-EMBER>)
          (<L? .TICK 100>
           <CONSUMABLE-LIGHT-PUT ,CL-LAMP-STAGE ,LIGHT-WEAK>)
          (T
           <CONSUMABLE-LIGHT-PUT ,CL-LAMP-STAGE ,LIGHT-BRIGHT>)>
    <RFALSE>>

<ROUTINE CONSUMABLE-NOTE-CANDLE-TICK (TICK)
    <COND (<0? .TICK>
           <CONSUMABLE-LIGHT-PUT ,CL-CANDLE-STAGE ,LIGHT-DARK>)
          (<L? .TICK 10>
           <CONSUMABLE-LIGHT-PUT ,CL-CANDLE-STAGE ,LIGHT-EMBER>)
          (T
           <CONSUMABLE-LIGHT-PUT ,CL-CANDLE-STAGE ,LIGHT-WEAK>)>
    <RFALSE>>

<ROUTINE CONSUMABLE-CANDLES-WET? ()
    <COND (<G? <CONSUMABLE-LIGHT-GET ,CL-CANDLE-WET> 0> <RTRUE>)>
    <RFALSE>>

<ROUTINE CONSUMABLE-OBJECT-LIGHT-LEVEL (OBJ)
    <COND (<NOT <EQUAL? <META-LOC .OBJ> ,HERE>> ,LIGHT-DARK)
          (<EQUAL? .OBJ ,TORCH>
           <COND (<FSET? ,TORCH ,ONBIT> ,LIGHT-BRIGHT)
                 (T ,LIGHT-DARK)>)
          (<EQUAL? .OBJ ,LAMP>
           <COND (<AND <FSET? ,LAMP ,ONBIT>
                       <NOT <FSET? ,LAMP ,RMUNGBIT>>>
                  <CONSUMABLE-LIGHT-GET ,CL-LAMP-STAGE>)
                 (T ,LIGHT-DARK)>)
          (<EQUAL? .OBJ ,CANDLES>
           <COND (<AND <FSET? ,CANDLES ,ONBIT>
                       <NOT <CONSUMABLE-CANDLES-WET?>>>
                  <CONSUMABLE-LIGHT-GET ,CL-CANDLE-STAGE>)
                 (T ,LIGHT-DARK)>)
          (<EQUAL? .OBJ ,MATCH>
           <COND (<FSET? ,MATCH ,ONBIT> ,LIGHT-EMBER)
                 (T ,LIGHT-DARK)>)
          (T ,LIGHT-DARK)>>

<ROUTINE CONSUMABLE-CURRENT-LIGHT-LEVEL ("AUX" LEVEL CANDIDATE)
    <SET LEVEL ,LIGHT-DARK>
    <SET CANDIDATE <CONSUMABLE-OBJECT-LIGHT-LEVEL ,TORCH>>
    <COND (<G? .CANDIDATE .LEVEL> <SET LEVEL .CANDIDATE>)>
    <SET CANDIDATE <CONSUMABLE-OBJECT-LIGHT-LEVEL ,LAMP>>
    <COND (<G? .CANDIDATE .LEVEL> <SET LEVEL .CANDIDATE>)>
    <SET CANDIDATE <CONSUMABLE-OBJECT-LIGHT-LEVEL ,CANDLES>>
    <COND (<G? .CANDIDATE .LEVEL> <SET LEVEL .CANDIDATE>)>
    <SET CANDIDATE <CONSUMABLE-OBJECT-LIGHT-LEVEL ,MATCH>>
    <COND (<G? .CANDIDATE .LEVEL> <SET LEVEL .CANDIDATE>)>
    .LEVEL>

<ROUTINE CONSUMABLE-LAMP-EXAMINE ("AUX" LEVEL)
    <SET LEVEL <CONSUMABLE-LIGHT-GET ,CL-LAMP-STAGE>>
    <TELL "The brass lantern ">
    <COND (<FSET? ,LAMP ,RMUNGBIT>
           <TELL "is burned out; its battery has nothing useful left to give.">)
          (<NOT <FSET? ,LAMP ,ONBIT>>
           <COND (<EQUAL? .LEVEL ,LIGHT-EMBER>
                  <TELL "is off, but its exhausted battery would offer only a failing amber glow if asked again.">)
                 (<EQUAL? .LEVEL ,LIGHT-WEAK>
                  <TELL "is off. The battery has already spent enough charge that its next light will be visibly weak.">)
                 (T
                  <TELL "is turned off, with substantial charge still behind the switch.">)>)
          (<EQUAL? .LEVEL ,LIGHT-BRIGHT>
           <TELL "throws a broad, steady electric glow.">)
          (<EQUAL? .LEVEL ,LIGHT-WEAK>
           <TELL "is visibly dimmer now. Its useful circle has contracted, though it still provides ordinary working light.">)
          (T
           <TELL "is nearly spent. A thin amber glow survives around the filament, enough to see immediately nearby but no longer to command a dark space.">)>
    <CRLF>
    <RTRUE>>

<ROUTINE CONSUMABLE-CANDLES-EXAMINE ("AUX" LEVEL)
    <SET LEVEL <CONSUMABLE-LIGHT-GET ,CL-CANDLE-STAGE>>
    <TELL "The pair of candles is ">
    <COND (<FSET? ,CANDLES ,RMUNGBIT>
           <TELL "spent down beyond useful relighting">)
          (<CONSUMABLE-CANDLES-WET?>
           <TELL "dark and waterlogged; the wicks are visibly soaked and need time to dry">)
          (<FSET? ,CANDLES ,ONBIT>
           <COND (<EQUAL? .LEVEL ,LIGHT-EMBER>
                  <TELL "burning at two tiny, unsteady ember-like points near the ends of the wicks">)
                 (T
                  <TELL "burning with two small ritual flames, useful but much less forceful than the lantern or ivory torch">)>)
          (<EQUAL? .LEVEL ,LIGHT-EMBER>
           <TELL "dark and very short, with only a little useful wax left">)
          (<FSET? ,CANDLES ,TOUCHBIT>
           <TELL "dark, shortened, and marked by prior burning">)
          (T
           <TELL "unlit and nearly unused">)>
    <TELL "." CR>
    <RTRUE>>

<ROUTINE CONSUMABLE-WET-CANDLES ()
    <COND (<NOT <SHADOW-HAS-BOTTLED-WATER?>>
           <TELL "The bottle must be open and contain water before you can soak the candles." CR>
           <RTRUE>)
          (<CONSUMABLE-CANDLES-WET?>
           <TELL "The candle wicks are already saturated. More water would mostly improve the floor." CR>
           <RTRUE>)>
    <MATERIAL-CONSUME-BOTTLED-WATER>
    <DISABLE <INT I-CANDLES>>
    <FCLEAR ,CANDLES ,ONBIT>
    <FSET ,CANDLES ,TOUCHBIT>
    <CONSUMABLE-LIGHT-PUT ,CL-CANDLE-WET 4>
    <SETG LIT <LIT? ,HERE>>
    <TELL "Water soaks into the candle wicks and pools in the softened wax. The flames are gone, and the visibly saturated wicks will need time to dry before they can take flame again." CR>
    <RTRUE>>

<ROUTINE CONSUMABLE-CANDLES-HOOK ()
    <COND (<AND <VERB? EXAMINE DIAGNOSE>
                <EQUAL? ,PRSO ,CANDLES>>
           <CONSUMABLE-CANDLES-EXAMINE>)
          (<AND <VERB? LAMP-ON BURN>
                <EQUAL? ,PRSO ,CANDLES>
                <CONSUMABLE-CANDLES-WET?>>
           <TELL "The wet wicks hiss at the offered flame but refuse to catch. They need time to dry." CR>
           <RTRUE>)
          (<AND <VERB? POUR-ON>
                <EQUAL? ,PRSO ,WATER>
                <EQUAL? ,PRSI ,CANDLES>>
           <CONSUMABLE-WET-CANDLES>)
          (T <RFALSE>)>>

<ROUTINE CONSUMABLE-SNUFF-EMBER-CANDLES ("AUX" STAGE)
    <SET STAGE <FIRE-STRUCTURAL-STAGE>>
    <COND (<AND <EQUAL? ,HERE ,TIMBER-ROOM>
                <EQUAL? .STAGE ,FIRE-TIMBER-BURNING ,FIRE-TIMBER-COLLAPSED-HOT>
                <IN? ,CANDLES ,WINNER>
                <FSET? ,CANDLES ,ONBIT>
                <EQUAL? <CONSUMABLE-LIGHT-GET ,CL-CANDLE-STAGE> ,LIGHT-EMBER>>
           <DISABLE <INT I-CANDLES>>
           <FCLEAR ,CANDLES ,ONBIT>
           <FSET ,CANDLES ,TOUCHBIT>
           <SETG LIT <LIT? ,HERE>>
           <TELL "The two tiny candle flames cannot survive the Timber Room's hot smoke and hard westward draft. They gutter flat and vanish, leaving the existing mine fire entirely in charge of the air." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE CONSUMABLE-LIGHT-ADVANCE ("AUX" WET)
    <COND (<SHADOW-NON-TURN-COMMAND?> <RFALSE>)>
    <SET WET <CONSUMABLE-LIGHT-GET ,CL-CANDLE-WET>>
    <COND (<G? .WET 0>
           <SET WET <- .WET 1>>
           <CONSUMABLE-LIGHT-PUT ,CL-CANDLE-WET .WET>
           <COND (<AND <0? .WET> <ACCESSIBLE? ,CANDLES>>
                  <TELL "The candle wicks have dried from waterlogged to merely waxy. They can take flame again." CR>)>)>
    <CONSUMABLE-SNUFF-EMBER-CANDLES>
    <RFALSE>>

<ROUTINE CONSUMABLE-DESCRIBE-LIGHTS ("AUX" (SEEN <>) LEVEL)
    <TELL "Visible light sources:" CR>
    <COND (<ACCESSIBLE? ,LAMP>
           <SET SEEN T>
           <SET LEVEL <CONSUMABLE-OBJECT-LIGHT-LEVEL ,LAMP>>
           <COND (<EQUAL? .LEVEL ,LIGHT-BRIGHT>
                  <TELL "- The brass lantern is bright and broad-reaching." CR>)
                 (<EQUAL? .LEVEL ,LIGHT-WEAK>
                  <TELL "- The brass lantern is weak but still useful for ordinary work." CR>)
                 (<EQUAL? .LEVEL ,LIGHT-EMBER>
                  <TELL "- The brass lantern is at a failing amber ember-glow." CR>)
                 (T
                  <TELL "- The brass lantern is dark." CR>)>)>
    <COND (<ACCESSIBLE? ,TORCH>
           <SET SEEN T>
           <COND (<FSET? ,TORCH ,ONBIT>
                  <TELL "- The ivory torch remains a bright, unwavering open flame." CR>)
                 (T
                  <TELL "- The ivory torch is dark, an unusual state for this particular treasure." CR>)>)>
    <COND (<ACCESSIBLE? ,CANDLES>
           <SET SEEN T>
           <SET LEVEL <CONSUMABLE-OBJECT-LIGHT-LEVEL ,CANDLES>>
           <COND (<CONSUMABLE-CANDLES-WET?>
                  <TELL "- The candle wicks are waterlogged and cannot presently hold flame." CR>)
                 (<EQUAL? .LEVEL ,LIGHT-WEAK>
                  <TELL "- The candles provide two small, weak flames." CR>)
                 (<EQUAL? .LEVEL ,LIGHT-EMBER>
                  <TELL "- The candles are down to two tiny ember-like flames." CR>)
                 (T
                  <TELL "- The candles are dark." CR>)>)>
    <COND (<ACCESSIBLE? ,MATCH>
           <SET SEEN T>
           <COND (<FSET? ,MATCH ,ONBIT>
                  <TELL "- One match gives a tiny, brief ember-scale circle of light." CR>)
                 (T
                  <TELL "- The matchbook is not currently burning." CR>)>)>
    <COND (<G? ,SHADOW-SELF-FIRE 0>
           <SET SEEN T>
           <TELL "- Your clothing is providing unsafe local illumination." CR>)>
    <COND (<NOT .SEEN>
           <TELL "- No authored portable light source is active or within reach." CR>)>
    <RTRUE>>
