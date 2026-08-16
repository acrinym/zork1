"Release 1262 Hostile Rooms & Reactive Threats: Treasure Guardian Dragon & Hoard."

<GLOBAL DRAGON-WATCH 0>
<GLOBAL DRAGON-TOLL-PAID <>>
<GLOBAL DRAGON-LURED <>>
<GLOBAL DRAGON-CONTAINED <>>
<GLOBAL DRAGON-HOARD-TAKEN <>>

<ROUTINE DRAGON-TREASURE? (OBJ)
    <COND (<EQUAL? .OBJ ,CHALICE ,SCEPTRE ,TRIDENT ,ASHEN-CIRCLET ,STAR-GLASS>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE DRAGON-SMOKE-COVER? ()
    <COND (<EQUAL? <FIRE-STRUCTURAL-STAGE>
                   ,FIRE-TIMBER-BURNING ,FIRE-TIMBER-COLLAPSED-HOT>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE DRAGON-RESET ()
    <SETG DRAGON-WATCH 0>
    <SETG DRAGON-TOLL-PAID <>>
    <SETG DRAGON-LURED <>>
    <SETG DRAGON-CONTAINED <>>
    <SETG DRAGON-HOARD-TAKEN <>>
    <MOVE ,HOARD-DRAGON ,DRAGON-GALLERY>
    <MOVE ,ASHEN-CIRCLET ,DRAGON-HOARD-VAULT>
    <MOVE ,STAR-GLASS ,DRAGON-HOARD-VAULT>
    <RTRUE>>

<ROUTINE DRAGON-EAST-EXIT ()
    <COND (,DRAGON-CONTAINED
           ,DRAGON-HOARD-VAULT)
          (<DRAGON-SMOKE-COVER?>
           <TELL "Smoke from the Timber Room is now pouring through the old ventilation seam. The dragon recoils from it, blinking and coughing flame into the stone instead of holding the eastern arch. You have a brief physical opening." CR>
           ,DRAGON-HOARD-VAULT)
          (,DRAGON-TOLL-PAID
           <TELL "The dragon lifts one foreclaw from the eastern arch. The bargain is painfully clear: passage, and one thing from the hoard." CR>
           ,DRAGON-HOARD-VAULT)
          (T
           <TELL "The dragon lowers its head across the eastern arch. Heat gathers behind its teeth. That route is physically occupied, not parser-locked." CR>
           <RFALSE>)>>

<ROUTINE DRAGON-ACCEPT-TOLL (OBJ)
    <COND (<NOT <DRAGON-TREASURE? .OBJ>>
           <TELL "The dragon studies the offer, then you. Whatever arithmetic governs draconic greed, that object does not improve your position." CR>
           <RTRUE>)>
    <MOVE .OBJ ,DRAGON-HOARD-VAULT>
    <SETG DRAGON-TOLL-PAID T>
    <SETG DRAGON-WATCH 0>
    <TELL "The dragon hooks the offered treasure away with one black claw and settles it behind the eastern arch. Its head moves aside by exactly the width of a person. A bargain has occurred without either party insulting it by pretending this is friendship." CR>
    <RTRUE>>

<ROUTINE DRAGON-LURE (OBJ)
    <COND (<NOT <DRAGON-TREASURE? .OBJ>> <RFALSE>)>
    <MOVE .OBJ ,DRAGON-GALLERY>
    <SETG DRAGON-LURED T>
    <SETG DRAGON-WATCH 0>
    <TELL "You put the treasure down on the scorched stone instead of offering it. The dragon's pupils narrow. Greed wins a very small argument with vigilance, and the beast steps beneath the hanging iron grille to hook the prize closer." CR>
    <RTRUE>>

<ROUTINE DRAGON-PULL-CHAIN ()
    <COND (,DRAGON-CONTAINED
           <TELL "The chain is already taut. The iron grille is already down, and the dragon has had quite enough time to form an opinion about engineering." CR>
           <RTRUE>)
          (,DRAGON-LURED
           <SETG DRAGON-CONTAINED T>
           <SETG DRAGON-WATCH 0>
           <TELL "You haul the chain. Counterweights thump inside the wall and the old iron grille drops between two basalt slots with a violence that explains the grooves in the floor. The dragon jerks back too late. It is alive, furious, and physically contained on the western side of the hoard arch." CR>
           <RTRUE>)
          (T
           <JIGS-UP "You pull the trap chain while the dragon is still watching the trap instead of the bait. Its answer is a cone of white-orange fire. The mechanism works perfectly several seconds after you stop needing it.">)>>

<ROUTINE DRAGON-BREATH-DEATH ()
    <JIGS-UP "The dragon has been watching you spend time in its room. Its chest expands once. The first wash of fire turns the air white, and the second makes further tactical reflection unnecessary.">>

<ROUTINE DRAGON-GALLERY-F (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <COND (,DRAGON-CONTAINED
                  <TELL "This basalt gallery is blackened by old heat. An iron grille now stands down across the eastern hoard arch, with the treasure guardian dragon furious on the near side of it. A heavy counterweight chain hangs from the north wall. The south passage returns toward the Timber Room." CR>)
                 (<DRAGON-SMOKE-COVER?>
                  <TELL "This basalt gallery is blackened by old heat. Smoke from the burning Timber Room is curling through a high ventilation seam. The dragon guarding the eastern hoard arch hates the smoke enough to keep giving ground from it. A heavy chain controls an iron grille above the arch; south returns toward the mine." CR>)
                 (T
                  <TELL "This basalt gallery is blackened by old heat. A large copper-black dragon lies across the eastern arch to a visible hoard, watching you rather than waiting politely for combat mode. An old iron grille hangs above the arch, controlled by a heavy chain on the north wall. The south passage remains open behind you." CR>)>
           <RTRUE>)
          (<EQUAL? .RARG ,M-BEG>
           <COND (,DRAGON-CONTAINED <RFALSE>)
                 (<DRAGON-SMOKE-COVER?> <RFALSE>)
                 (<VERB? WALK> <RFALSE>)
                 (<AND <VERB? GIVE>
                       <EQUAL? ,PRSI ,HOARD-DRAGON>
                       <IN? ,PRSO ,WINNER>>
                  <DRAGON-ACCEPT-TOLL ,PRSO>
                  <RTRUE>)
                 (<AND <VERB? DROP>
                       <DRAGON-TREASURE? ,PRSO>
                       <IN? ,PRSO ,WINNER>>
                  <DRAGON-LURE ,PRSO>
                  <RTRUE>)
                 (<AND <VERB? MOVE>
                       <EQUAL? ,PRSO ,DRAGON-CHAIN>>
                  <DRAGON-PULL-CHAIN>
                  <RTRUE>)
                 (<AND <VERB? ATTACK>
                       <EQUAL? ,PRSO ,HOARD-DRAGON>>
                  <JIGS-UP "You choose direct violence while the dragon is unrestrained and already facing you. The sword is still becoming an argument when the room becomes fire.">
                  <RTRUE>)
                 (<ZERO? ,DRAGON-WATCH>
                  <SETG DRAGON-WATCH 1>
                  <TELL "The dragon does not attack merely because you entered. It watches the action you chose instead. Heat leaks between its teeth as a very clear statement that you have spent one opportunity in a room containing a live territorial animal." CR>
                  <RFALSE>)
                 (T
                  <DRAGON-BREATH-DEATH>
                  <RTRUE>)>)>
    <RFALSE>>

<ROUTINE DRAGON-HOARD-VAULT-F (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "The eastern vault is a natural basalt bowl made dazzling by accumulated metal, glass, old coins, and things that were valuable before anyone living learned the word valuable. Two pieces sit clear of the anonymous mass: an ashen silver circlet and a fist-sized piece of star-glass. The gallery is west." CR>
           <RTRUE>)
          (<EQUAL? .RARG ,M-BEG>
           <COND (<VERB? WALK> <RFALSE>)
                 (,DRAGON-CONTAINED <RFALSE>)
                 (<DRAGON-SMOKE-COVER?> <RFALSE>)
                 (<AND ,DRAGON-TOLL-PAID
                       <VERB? TAKE>
                       <DRAGON-TREASURE? ,PRSO>>
                  <COND (<NOT ,DRAGON-HOARD-TAKEN>
                         <SETG DRAGON-HOARD-TAKEN T>
                         <TELL "From the gallery, one claw taps stone once. One thing. The bargain remains a bargain because the dragon is counting too." CR>
                         <RFALSE>)
                        (T
                         <JIGS-UP "You reach for a second piece after buying permission for one. The dragon does not renegotiate. Fire crosses the arch faster than contract law.">
                         <RTRUE>)>)
                 (<AND <VERB? TAKE>
                       <DRAGON-TREASURE? ,PRSO>>
                  <JIGS-UP "You reach into an unguarded-looking hoard while its guardian still owns the doorway. The dragon's fire arrives from the gallery before the treasure leaves the stone.">
                  <RTRUE>)>)>
    <RFALSE>>

<ROUTINE HOARD-DRAGON-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The dragon is broad through the shoulders and old enough to have healed scars under its copper-black scales. Its eyes keep moving between you, your hands, the chain, and the visible treasure. This is not scenery and it is not waiting for turns in a generic combat queue." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "Its breathing is slow, wet, and furnace-deep. Occasionally a scale clicks against stone." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Hot metal, mineral dust, old smoke, and the sulfurous edge of something whose lungs are an environmental hazard." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "There is no useful interpretation of taking the dragon." CR>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE DRAGON-CHAIN-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The iron chain disappears into a counterweight channel above the gallery. Pulling it would drop the slotted grille over the eastern arch. The grooves in the floor suggest this was built for something approximately dragon-shaped." CR>
           <RTRUE>)
          (<VERB? MOVE>
           <DRAGON-PULL-CHAIN>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE DRAGON-GRILLE-F ()
    <COND (<VERB? EXAMINE>
           <COND (,DRAGON-CONTAINED
                  <TELL "The old grille is down in deep basalt slots. The bars glow faintly where the dragon has tested them, but the counterweight and stone are holding." CR>)
                 (T
                  <TELL "A heavy iron grille is suspended above the eastern arch. Its bars align with old slots cut into the basalt floor." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE DRAGON-TREASURE-F ()
    <COND (<VERB? EXAMINE>
           <COND (<EQUAL? ,PRSO ,ASHEN-CIRCLET>
                  <TELL "The silver circlet is smoke-darkened rather than ruined. Tiny mountain shapes are chased around its rim, each peak picked out in black enamel." CR>)
                 (T
                  <TELL "The star-glass is clear at its edges and midnight-blue at its center. Tiny bright inclusions seem fixed at impossible depths inside it." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROOM DRAGON-APPROACH
      (IN ROOMS)
      (DESC "Scorched Cleft")
      (LDESC "A soot-dark cleft leaves the old mine passage and climbs into hotter basalt. Scratches in the stone are too broad for tools, and several old white bones have been pushed deliberately against the wall. South returns to the Timber Room; north enters a larger blackened gallery.")
      (SOUTH TO TIMBER-ROOM)
      (NORTH TO DRAGON-GALLERY)
      (FLAGS RLANDBIT)>

<ROOM DRAGON-GALLERY
      (IN ROOMS)
      (DESC "Dragon Gallery")
      (SOUTH TO DRAGON-APPROACH)
      (EAST PER DRAGON-EAST-EXIT)
      (ACTION DRAGON-GALLERY-F)
      (FLAGS RLANDBIT)>

<ROOM DRAGON-HOARD-VAULT
      (IN ROOMS)
      (DESC "Hoard Vault")
      (WEST TO DRAGON-GALLERY)
      (ACTION DRAGON-HOARD-VAULT-F)
      (FLAGS RLANDBIT)>

<OBJECT HOARD-DRAGON
    (IN DRAGON-GALLERY)
    (SYNONYM DRAGON GUARDIAN BEAST)
    (ADJECTIVE TREASURE COPPER BLACK OLD)
    (DESC "treasure guardian dragon")
    (FLAGS ACTORBIT NDESCBIT TRYTAKEBIT)
    (ACTION HOARD-DRAGON-F)>

<OBJECT DRAGON-CHAIN
    (IN DRAGON-GALLERY)
    (SYNONYM CHAIN COUNTERWEIGHT)
    (ADJECTIVE HEAVY IRON)
    (DESC "heavy iron chain")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION DRAGON-CHAIN-F)>

<OBJECT DRAGON-GRILLE
    (IN DRAGON-GALLERY)
    (SYNONYM GRILLE GRATE BARS)
    (ADJECTIVE IRON OLD HANGING)
    (DESC "iron grille")
    (FLAGS NDESCBIT TRYTAKEBIT)
    (ACTION DRAGON-GRILLE-F)>

<OBJECT ASHEN-CIRCLET
    (IN DRAGON-HOARD-VAULT)
    (SYNONYM CIRCLET CROWN TREASURE SILVER)
    (ADJECTIVE ASHEN SILVER SMOKE DARKENED)
    (DESC "ashen silver circlet")
    (FLAGS TAKEBIT)
    (ACTION DRAGON-TREASURE-F)
    (SIZE 3)>

<OBJECT STAR-GLASS
    (IN DRAGON-HOARD-VAULT)
    (SYNONYM GLASS STARGLASS TREASURE GEM)
    (ADJECTIVE STAR BLUE MIDNIGHT)
    (DESC "piece of star-glass")
    (FLAGS TAKEBIT)
    (ACTION DRAGON-TREASURE-F)
    (SIZE 4)>
