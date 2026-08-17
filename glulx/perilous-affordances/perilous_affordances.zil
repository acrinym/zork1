"Release 1264 Perilous Affordances / Let the Player Be Wrong."

;"This is intentionally a short list of authored consequences. It is not a
  material simulator, generic durability layer, or object-damage registry."

<ROUTINE PERILOUS-BREAK-LAMP ()
    <TELL "You commit to the blow. Brass dents, glass snaps, and the battery-powered lantern stops being a light source. The same broken lantern left by a hard throw is now lying where the working one used to be." CR>
    <DISABLE <INT I-LANTERN>>
    <REMOVE-CAREFULLY ,LAMP>
    <MOVE ,BROKEN-LAMP ,HERE>
    <RTRUE>>

<ROUTINE PERILOUS-DESTROY-ROPE ("AUX" ANCHOR SELF-TIED?)
    <SET ANCHOR ,MATERIAL-ROPE-ANCHOR>
    <SET SELF-TIED? ,SHADOW-SELF-TIED>
    <SETG DOME-FLAG <>>
    <FCLEAR ,ROPE ,NDESCBIT>
    <SETG MATERIAL-ROPE-ANCHOR <>>
    <SETG MATERIAL-SACK-CINCHED <>>
    <SETG SHADOW-SELF-TIED <>>
    <REMOVE-CAREFULLY ,ROPE>
    <COND (<VERB? BURN>
           <COND (.SELF-TIED?
                  <SETG SHADOW-SELF-FIRE 1>
                  <TELL "The hemp around your legs catches exactly as hemp should. The line chars through and frees your legs, but the flame has already transferred to your clothing. The rope is gone; your trousers have begun to smoke, and water would be a more useful next experiment than regret." CR>)
                 (.ANCHOR
                  <TELL "Flame runs along the committed hemp until the loaded fibers part. The canonical rope is consumed beyond useful length, its knot to the " D .ANCHOR " ceases to be a route, and the remaining charred scraps are not an inventory item." CR>)
                 (T
                  <TELL "The hemp takes the flame eagerly. In moments the canonical rope is a blackening line of ash and short useless fibers. It is no longer an available tool for any later puzzle that expected an actual rope." CR>)>)
          (T
           <COND (.ANCHOR
                  <TELL "The blade saws through the loaded hemp. The line parts, the knot to the " D .ANCHOR " stops governing anything, and the severed lengths are too short and frayed to remain the canonical rope." CR>)
                 (T
                  <TELL "The blade bites through the hemp until the coil parts into short, frayed lengths. You have successfully converted the canonical rope into material that cannot do the jobs for which a rope was required." CR>)>)>
    <RTRUE>>

<ROUTINE PERILOUS-SCREEN-ACTION ()
    <COND (<VERB? BURN>
           <ABLATIVE-PUT ,APS-PREPARED 0>
           <COND (<EQUAL? <ABLATIVE-GET ,APS-CONDITION> ,AP-SOUND>
                  <ABLATIVE-PUT ,APS-CONDITION ,AP-SCORCHED>
                  <TELL "You deliberately work the flame across the stretched hide. It blackens, blisters, and draws tight around the iron rim. The screen is still straight enough to brace, but you have spent in advance the first layer of material that would otherwise have taken a dragon's breath." CR>)
                 (<EQUAL? <ABLATIVE-GET ,APS-CONDITION> ,AP-SCORCHED>
                  <ABLATIVE-PUT ,APS-CONDITION ,AP-RUINED>
                  <TELL "You keep the flame on hide that was already shrunken by heat. The remaining leather curls away from the rim and opens broad gaps. The iron frame survives; the protective screen does not." CR>)
                 (<EQUAL? <ABLATIVE-GET ,APS-CONDITION> ,AP-WARPED>
                  <ABLATIVE-PUT ,APS-CONDITION ,AP-RUINED>
                  <TELL "You add deliberate fire to a screen already warped by dragon breath. The cracked hide burns through and leaves a twisted frame with holes where protection used to be." CR>)
                 (T
                  <TELL "There is too little continuous hide left on the ruined frame for another application of fire to change its usefulness." CR>)>
           <RTRUE>)
          (<VERB? CUT MUNG>
           <ABLATIVE-PUT ,APS-PREPARED 0>
           <COND (<EQUAL? <ABLATIVE-GET ,APS-CONDITION> ,AP-RUINED>
                  <TELL "You can cut the remaining scraps if destruction itself is the hobby, but the screen is already physically ruined as a barrier." CR>)
                 (T
                  <ABLATIVE-PUT ,APS-CONDITION ,AP-RUINED>
                  <TELL "The weapon opens the stretched hide from rim to rim. Nothing magical stops you. The iron frame remains in your hands, but a barrier with a deliberate body-sized opening is no longer protection." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE PERILOUS-BREAK-STAR-GLASS ()
    <REMOVE-CAREFULLY ,STAR-GLASS>
    <TELL "The blow reaches the midnight-blue glass instead of being vetoed for future usefulness. It fractures with a bright crystalline snap into thin glittering splinters that scatter across the stone. None is large enough to remain the star-glass treasure, and the dragon will not accept an object that no longer exists." CR>
    <RTRUE>>
