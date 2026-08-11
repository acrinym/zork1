"Qualification-only completion positioning for Release 1246."

;"This file is copied only into dedicated qualification stories. It is never
  loaded by the production or dev/test Release 1246 artifacts. Its sole purpose
  is to reach the canonical Stone Barrow completion path without replaying the
  entire game while preserving whatever Release 1246 environmental state the
  preceding ordinary commands created."

<SYNTAX EDWIN = V-ENVIRONMENTAL-DESTRUCTION-TEST-WIN>

<ROUTINE V-ENVIRONMENTAL-DESTRUCTION-TEST-WIN ()
    <SETG WON-FLAG T>
    <SETG SCORE 350>
    <MOVE ,WINNER ,STONE-BARROW>
    <SETG HERE ,STONE-BARROW>
    <SETG LIT T>
    <TELL "[Release 1246 completion fixture armed at the canonical Stone Barrow.]" CR>
    <RTRUE>>
