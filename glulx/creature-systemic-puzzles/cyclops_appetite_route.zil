"RELEASE 1271 CYCLOPS APPETITE ROUTE"

;"One explicit temporary physical fact: after the dropped hot-pepper lunch,
  the cyclops is away from the stair eating it. Hunger/thirst/agitation and
  sleeping remain canonical CYCLOWRATH/CYCLOPS-FLAG state. The existing
  I-CYCLOPS interrupt handles recovery when CYCLOWRATH transitions from
  negative (eating) back to zero (recovered)."

;"Food distraction is detected by CYCLOWRATH being negative (the eating state)."
<ROUTINE CREATURE-CYCLOPS-FOOD-DISTRACTED? ()
    <L? ,CYCLOWRATH 0>>

<ROUTINE CREATURE-CYCLOPS-DROP-LUNCH ()
    <COND (,CYCLOPS-FLAG <RFALSE>)>
    <COND (<CREATURE-CYCLOPS-FOOD-DISTRACTED?>
           <TELL "The cyclops is already crouched over the food and away from the stair. The opportunity is physical and brief." CR>
           <RTRUE>)>
    <REMOVE-CAREFULLY ,LUNCH>
    <SETG CYCLOWRATH <MIN -1 <- ,CYCLOWRATH>>>
    <ENABLE <QUEUE I-CYCLOPS -1>>
    <TELL "You drop the hot-pepper lunch short of the stair. Hunger wins immediately: the cyclops lunges into the corner, scoops it up, and begins eating with his back half-turned. The stairs are physically clear for one brief opportunity. His watering eye and first furious breath make another fact equally plain: the peppers are already making him thirsty." CR>
    <RTRUE>>

;"The recovery message is handled by I-CYCLOPS in 1actions.zil when CYCLOWRATH
  reaches zero from a negative value. This avoids adding a new interrupt global."

<ROUTINE CREATURE-CYCLOPS-UP-EXIT ()
    <COND (,CYCLOPS-FLAG ,TREASURE-ROOM)
          (<CREATURE-CYCLOPS-FOOD-DISTRACTED?>
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
