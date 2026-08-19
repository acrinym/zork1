"RELEASE 1271 CYCLOPS APPETITE ROUTE"

;"One explicit temporary physical fact: after the dropped hot-pepper lunch,
  the cyclops is away from the stair eating it. Hunger/thirst/agitation and
  sleeping remain canonical CYCLOWRATH/CYCLOPS-FLAG state. The scheduled
  recovery interrupt is the sole authority for this brief positional window."

<ROUTINE CREATURE-CYCLOPS-FOOD-DISTRACTED? ("AUX" CINT)
    <SET CINT <INT I-CREATURE-CYCLOPS-FOOD-RECOVER>>
    <AND <NOT <0? <GET .CINT ,C-ENABLED?>>>
         <G? <GET .CINT ,C-TICK> 0>>>

<ROUTINE CREATURE-CYCLOPS-DROP-LUNCH ()
    <COND (,CYCLOPS-FLAG <RFALSE>)>
    <COND (<CREATURE-CYCLOPS-FOOD-DISTRACTED?>
           <TELL "The cyclops is already crouched over the food and away from the stair. The opportunity is physical and brief." CR>
           <RTRUE>)>
    <REMOVE-CAREFULLY ,LUNCH>
    <SETG CYCLOWRATH <MIN -1 <- ,CYCLOWRATH>>>
    <ENABLE <QUEUE I-CYCLOPS -1>>
    <ENABLE <QUEUE I-CREATURE-CYCLOPS-FOOD-RECOVER 2>>
    <TELL "You drop the hot-pepper lunch short of the stair. Hunger wins immediately: the cyclops lunges into the corner, scoops it up, and begins eating with his back half-turned. The stairs are physically clear for one brief opportunity. His watering eye and first furious breath make another fact equally plain: the peppers are already making him thirsty." CR>
    <RTRUE>>

<ROUTINE I-CREATURE-CYCLOPS-FOOD-RECOVER ()
    <DISABLE <INT I-CREATURE-CYCLOPS-FOOD-RECOVER>>
    <COND (<EQUAL? ,HERE ,CYCLOPS-ROOM>
           <TELL "The cyclops finishes the last peppery mouthful, wipes his burning tongue with one forearm, and plants himself near the stair again. He is no longer hungry. He is very definitely thirsty." CR>)>>

<ROUTINE CREATURE-CYCLOPS-UP-EXIT ()
    <COND (,CYCLOPS-FLAG ,TREASURE-ROOM)
          (<CREATURE-CYCLOPS-FOOD-DISTRACTED?>
           <DISABLE <INT I-CREATURE-CYCLOPS-FOOD-RECOVER>>
           <TELL "The cyclops is still occupied with the peppers in the corner. You take the stairs while his body is somewhere other than the route he normally guards. Behind you comes a strangled, thirsty growl; this did not put him to sleep." CR>
           ,TREASURE-ROOM)
          (T
           <TELL "The cyclops doesn't look like he'll let you past. His body still occupies the foot of the stairs." CR>
           <RFALSE>)>>

<ROUTINE CREATURE-CYCLOPS-ROOM-BEGIN ()
    <COND (<AND <VERB? DROP>
                <EQUAL? ,PRSO ,LUNCH>
                <IN? ,LUNCH ,WINNER>
                <NOT ,CYCLOPS-FLAG>>
           <CREATURE-CYCLOPS-DROP-LUNCH>
           <RTRUE>)>
    <RFALSE>>
