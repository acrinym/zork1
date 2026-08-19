"RELEASE 1271 TROLL PASSAGE OPPORTUNITY"

;"The troll already owns attention, deception memory, restraint state, and
  canonical passage-open state elsewhere. These exit routines only let the
  geography honor the brief moment when that same troll is looking away."

<ROUTINE CREATURE-TROLL-EAST-EXIT ()
    <COND (,TROLL-FLAG ,EW-PASSAGE)
          (,GLULX-ALT-TROLL-DISTRACTED
           <TELL "The troll is still staring at the nonexistent emergency behind him. You slip through the eastern passage before attention returns. You have escaped his position, not solved his memory." CR>
           ,EW-PASSAGE)
          (T
           <TELL "The troll fends you off with a menacing gesture. He is watching the eastern passage, not merely occupying a parser lock." CR>
           <RFALSE>)>>

<ROUTINE CREATURE-TROLL-WEST-EXIT ()
    <COND (,TROLL-FLAG ,MAZE-1)
          (,GLULX-ALT-TROLL-DISTRACTED
           <TELL "While the troll is committed to looking the wrong way, you duck through the western hole. He remains alive behind you and remains entirely capable of learning from embarrassment." CR>
           ,MAZE-1)
          (T
           <TELL "The troll fends you off with a menacing gesture. He is guarding the western hole with his actual body." CR>
           <RFALSE>)>>
