"MARA PROPERTY / AUTONOMY BOUNDARY CONTINUITY for Release 1309"

; "This module extends the existing Release 1260 rupture authority. It does not
; create a second relationship system. Ordinary mistakes may draw a warning;
; knowingly repeating a clearly stated property, clothing, or autonomy boundary
; can become the same open rupture already respected by Release 1306 intimacy."

<CONSTANT MARA-BOUNDARY-NONE 0>
<CONSTANT MARA-BOUNDARY-CLOTHING 1>
<CONSTANT MARA-BOUNDARY-FOOD 2>
<CONSTANT MARA-BOUNDARY-AUTONOMY 3>

<GLOBAL MARA-BOUNDARY-RUPTURE-KIND 0>
<GLOBAL MARA-CLOTHING-BOUNDARY-COUNT 0>
<GLOBAL MARA-FOOD-BOUNDARY-COUNT 0>
<GLOBAL MARA-AUTONOMY-BOUNDARY-COUNT 0>
<GLOBAL MARA-RATION-STOLEN 0>
<GLOBAL MARA-RATION-CONSUMED 0>

<OBJECT MARA-FIELD-RATION
    (SYNONYM RATION FOOD LUNCH BISCUIT BISCUITS)
    (ADJECTIVE MARA MARAS FIELD WRAPPED)
    (DESC "Mara's wrapped field ration")
    (FLAGS TAKEBIT FOODBIT)
    (SIZE 2)
    (ACTION MARA-FIELD-RATION-F)>

<ROUTINE MARA-BOUNDARY-RUPTURE? ()
    <COND (<AND <MARA-RUPTURE-OPEN?>
                <NOT <ZERO? ,MARA-BOUNDARY-RUPTURE-KIND>>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-BOUNDARY-COUNT (KIND)
    <COND (<EQUAL? .KIND ,MARA-BOUNDARY-CLOTHING>
           <RETURN ,MARA-CLOTHING-BOUNDARY-COUNT>)
          (<EQUAL? .KIND ,MARA-BOUNDARY-FOOD>
           <RETURN ,MARA-FOOD-BOUNDARY-COUNT>)
          (<EQUAL? .KIND ,MARA-BOUNDARY-AUTONOMY>
           <RETURN ,MARA-AUTONOMY-BOUNDARY-COUNT>)>
    <RETURN 0>>

<ROUTINE MARA-BOUNDARY-INCREASE (KIND "AUX" N)
    <SET N <+ <MARA-BOUNDARY-COUNT .KIND> 1>>
    <COND (<EQUAL? .KIND ,MARA-BOUNDARY-CLOTHING>
           <SETG MARA-CLOTHING-BOUNDARY-COUNT .N>)
          (<EQUAL? .KIND ,MARA-BOUNDARY-FOOD>
           <SETG MARA-FOOD-BOUNDARY-COUNT .N>)
          (<EQUAL? .KIND ,MARA-BOUNDARY-AUTONOMY>
           <SETG MARA-AUTONOMY-BOUNDARY-COUNT .N>)>
    <RETURN .N>>

<ROUTINE MARA-OPEN-BOUNDARY-RUPTURE (KIND)
    <COND (<MARA-RUPTURE-OPEN?>
           <RTRUE>)>
    <SETG MARA-BOUNDARY-RUPTURE-KIND .KIND>
    <MARA-PUT ,MARA-SLOT-RUPTURE-OPEN 1>
    <MARA-PUT ,MARA-SLOT-RUPTURE-REPAIRED 0>
    <MARA-PUT ,MARA-SLOT-APOLOGY-ACKNOWLEDGED 0>
    <MARA-PUT ,MARA-SLOT-BOUNDARY-RESPECTED 0>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-INDEPENDENT>
    <COND (<EQUAL? .KIND ,MARA-BOUNDARY-CLOTHING>
           <TELL "Mara takes one full step away. I already told you my clothes are mine, she says. The second attempt is not curiosity. It is you deciding my no was temporary. I am keeping distance now." CR>)
          (<EQUAL? .KIND ,MARA-BOUNDARY-FOOD>
           <TELL "Mara's expression closes. I told you the ration was mine, she says. You kept treating that as a puzzle response instead of an answer. I am keeping distance now." CR>)
          (T
           <TELL "Mara stops moving and looks directly at you. I told you I was making this choice myself, she says. Repeating the order until my answer changes is not cooperation. I am keeping distance now." CR>)>
    <RTRUE>>

<ROUTINE MARA-BOUNDARY-STRIKE (KIND "AUX" N)
    <COND (<MARA-RUPTURE-OPEN?>
           <TELL "Mara is already keeping distance. Repeating the boundary does not turn it back into a negotiation." CR>
           <RTRUE>)>
    <SET N <MARA-BOUNDARY-INCREASE .KIND>>
    <COND (<G? .N 1>
           <MARA-OPEN-BOUNDARY-RUPTURE .KIND>)
          (<EQUAL? .KIND ,MARA-BOUNDARY-CLOTHING>
           <TELL "Mara keeps hold of the garment. That is mine, she says. You may look at a person without treating her clothes as common inventory. Do not try again." CR>)
          (<EQUAL? .KIND ,MARA-BOUNDARY-FOOD>
           <TELL "Mara puts a hand over the ration. That is my food, she says. Ask if you need something. Do not take it and call the taking a joke." CR>)
          (T
           <TELL "Mara does not obey the interruption. I heard you, she says. I am choosing this for myself. Do not keep issuing the same order until I surrender the choice." CR>)>
    <RTRUE>>

<ROUTINE MARA-BOUNDARY-CLOTHING-ATTEMPT ()
    <MARA-BOUNDARY-STRIKE ,MARA-BOUNDARY-CLOTHING>
    <RTRUE>>

<ROUTINE MARA-FIELD-RATION-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A compact field ration wrapped in waxed cloth. It is Mara's, packed for the stretches of survey work when the House is far away." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <COND (<MARA-HERE?>
                  <MARA-BOUNDARY-STRIKE ,MARA-BOUNDARY-FOOD>
                  <RTRUE>)
                 (T
                  <SETG MARA-RATION-STOLEN 1>
                  <RFALSE>)>)
          (<VERB? EAT>
           <COND (<MARA-HERE?>
                  <MARA-BOUNDARY-STRIKE ,MARA-BOUNDARY-FOOD>
                  <RTRUE>)
                 (T
                  <SETG MARA-RATION-STOLEN 1>
                  <SETG MARA-RATION-CONSUMED 1>
                  <RFALSE>)>)
          (<AND <VERB? GIVE> <EQUAL? ,PRSI ,MARA>>
           <COND (<NOT <HELD? ,MARA-FIELD-RATION>>
                  <TELL "You are not holding Mara's ration." CR>)
                 (T
                  <MOVE ,MARA-FIELD-RATION ,MARA>
                  <SETG MARA-RATION-STOLEN 0>
                  <COND (<MARA-BOUNDARY-RUPTURE?>
                         <TELL "Mara takes the ration back. Returning property is a real action, she says. It is not by itself the same thing as repairing why I had to ask." CR>)
                        (T
                         <TELL "Mara takes the ration back. Thank you, she says. Mine again, where it belongs." CR>)>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-BOUNDARY-PRESENCE-HOOK ()
    <COND (<AND ,MARA-RATION-STOLEN
                <MARA-HERE?>
                <HELD? ,MARA-FIELD-RATION>
                <NOT <AND <VERB? GIVE> <EQUAL? ,PRSO ,MARA-FIELD-RATION>>>
                <NOT <VERB? DROP>>>
           <MARA-BOUNDARY-STRIKE ,MARA-BOUNDARY-FOOD>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-BOUNDARY-AUTONOMY-CONTEXT? ()
    <COND (<AND <NOT <MARA-RUPTURE-OPEN?>>
                <EQUAL? <MARA-GET ,MARA-SLOT-MODE> ,MARA-MODE-INDEPENDENT>>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MARA-BOUNDARY-AUTONOMY-ATTEMPT ()
    <MARA-BOUNDARY-STRIKE ,MARA-BOUNDARY-AUTONOMY>
    <RTRUE>>

<ROUTINE MARA-PHYSICAL-BOUNDARY-REFUSAL ()
    <COND (<EQUAL? ,MARA-BOUNDARY-RUPTURE-KIND ,MARA-BOUNDARY-CLOTHING>
           <TELL "Mara steps out of reach. You do not get to turn ignoring what I said about my body and clothes into affection." CR>)
          (<EQUAL? ,MARA-BOUNDARY-RUPTURE-KIND ,MARA-BOUNDARY-FOOD>
           <TELL "Mara steps out of reach. Food is not the point now, she says. The point is that I said mine and you treated the word as optional. Affection does not overwrite that." CR>)
          (T
           <TELL "Mara steps out of reach. You do not get to keep overruling my choices and then use affection as the reset button." CR>)>
    <RTRUE>>

<ROUTINE MARA-BOUNDARY-REPAIR-READY? ()
    <COND (<NOT <MARA-BOUNDARY-RUPTURE?>> <RFALSE>)
          (<ZERO? <MARA-GET ,MARA-SLOT-APOLOGY-ACKNOWLEDGED>> <RFALSE>)
          (<ZERO? <MARA-GET ,MARA-SLOT-BOUNDARY-RESPECTED>> <RFALSE>)
          (<AND <EQUAL? ,MARA-BOUNDARY-RUPTURE-KIND ,MARA-BOUNDARY-FOOD>
                <HELD? ,MARA-FIELD-RATION>>
           <RFALSE>)>
    <RTRUE>>

<ROUTINE MARA-COMPLETE-BOUNDARY-REPAIR ()
    <MARA-PUT ,MARA-SLOT-RUPTURE-OPEN 0>
    <MARA-PUT ,MARA-SLOT-RUPTURE-REPAIRED 1>
    <MARA-PUT ,MARA-SLOT-MODE ,MARA-MODE-INDEPENDENT>
    <COND (<EQUAL? ,MARA-BOUNDARY-RUPTURE-KIND ,MARA-BOUNDARY-FOOD>
           <COND (,MARA-RATION-CONSUMED
                  <TELL "Mara is quiet for a moment. You could not return what you ate, she says. But you named the taking, gave me the space I asked for, and stopped pretending the boundary was a joke. I am willing to work at ordinary distance again. The loss is still part of what happened." CR>)
                 (T
                  <TELL "Mara nods once. You returned what was mine, apologized without demanding a reset, and actually gave me space. I am willing to work at ordinary distance again. I still remember why the distance happened." CR>)>)
          (<EQUAL? ,MARA-BOUNDARY-RUPTURE-KIND ,MARA-BOUNDARY-CLOTHING>
           <TELL "Mara studies you, then relaxes one degree. You stopped testing the boundary, named what you were doing, and gave me the space I asked for. I am willing to work at ordinary distance again. My clothes are still mine." CR>)
          (T
           <TELL "Mara considers the silence you actually gave her. You stopped issuing the order, apologized, and let my choice cost you something, she says. I am willing to work at ordinary distance again. My choices are still mine." CR>)>
    <RTRUE>>

<ROUTINE MARA-ABOUT-BOUNDARY-RUPTURE ()
    <COND (<MARA-BOUNDARY-REPAIR-READY?>
           <MARA-COMPLETE-BOUNDARY-REPAIR>
           <RTRUE>)
          (<NOT <MARA-RUPTURE-OPEN?>>
           <TELL "Mara does not pretend the old boundary vanished. The rupture is repaired, not deleted from history." CR>
           <RTRUE>)
          (<ZERO? <MARA-GET ,MARA-SLOT-APOLOGY-ACKNOWLEDGED>>
           <COND (<EQUAL? ,MARA-BOUNDARY-RUPTURE-KIND ,MARA-BOUNDARY-CLOTHING>
                  <TELL "I told you my clothes were mine and you tried again, Mara says. I am not calling that an attack, and I am not calling it harmless. Distance is the current answer." CR>)
                 (<EQUAL? ,MARA-BOUNDARY-RUPTURE-KIND ,MARA-BOUNDARY-FOOD>
                  <TELL "You treated my food as yours after I made the ownership plain, Mara says. That is not violence. It is still a fact about whether my no survives inconvenience. Distance is the current answer." CR>)
                 (T
                  <TELL "I told you I was choosing for myself and you kept trying to substitute your order for my answer, Mara says. That is the rupture. Distance is the current answer." CR>)>)
          (<ZERO? <MARA-GET ,MARA-SLOT-BOUNDARY-RESPECTED>>
           <TELL "I heard the apology, Mara says. Hearing it is not the same as repairing it. I asked for space. What you do with that request is the next fact." CR>)
          (<AND <EQUAL? ,MARA-BOUNDARY-RUPTURE-KIND ,MARA-BOUNDARY-FOOD>
                <HELD? ,MARA-FIELD-RATION>>
           <TELL "You apologized and you gave me space, Mara says. You are still holding my food. Put the physical fact right before asking me to call the history repaired." CR>)
          (T
           <TELL "You apologized and gave me actual space, Mara says. That is evidence. Ask me about this again when you are ready for my answer rather than a reset." CR>)>
    <RTRUE>>
