"RELEASE 1268 CLUE CHAINS AND KNOWLEDGE-GATED INTERPRETATION"

;"A deliberately bounded chain of remembered interpretation. Fixed canonical
  inscriptions teach two exact pieces of ancient-Zorker reading knowledge; a
  later field marking can then reveal Release 1267's existing ventilation seam.
  This is not a clue registry, notebook, or generic symbol engine."

<SYNTAX INTERPRET OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-CLUE-INTERPRET>
<SYNONYM INTERPRET DECIPHER>

<CONSTANT CK-ANCIENT-SCRIPT 0>
<CONSTANT CK-AIR-PASSAGE-MOTIF 1>
<CONSTANT CK-VENT-MARK-INTERPRETED 2>
<CONSTANT CLUE-KNOWLEDGE-STATE <TABLE 0 0 0>>

<ROUTINE CLUE-KNOWLEDGE-GET (SLOT)
    <GET ,CLUE-KNOWLEDGE-STATE .SLOT>>

<ROUTINE CLUE-KNOWLEDGE-PUT (SLOT VALUE)
    <PUT ,CLUE-KNOWLEDGE-STATE .SLOT .VALUE>>

<ROUTINE CLUE-KNOWLEDGE-TRUE? (SLOT)
    <COND (<G? <CLUE-KNOWLEDGE-GET .SLOT> 0> <RTRUE>)>
    <RFALSE>>

<ROUTINE CLUE-DRAGON-VENT-MARK-F ()
    <COND (<VERB? EXAMINE>
           <COND (<CLUE-KNOWLEDGE-TRUE? ,CK-AIR-PASSAGE-MOTIF>
                  <TELL "With the Engravings Cave motif in memory, the old geometric cuts are no longer decorative noise. The paired angles frame three rising strokes in the same grammar: a bounded opening meant to carry breath or moving air. The mark identifies a kind of structure; it does not itself tell you where the opening is." CR>)
                 (T
                  <TELL "The cuts are deliberate and much older than the dragon's recent occupancy: paired angles around three short rising strokes. You can see the pattern clearly, but without a matching context it remains an unfamiliar old notation." CR>)>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The shallow cuts are part of the basalt. Dust leaves their grooves, but the geometry does not change." CR>
           <RTRUE>)
          (<VERB? TAKE MOVE>
           <TELL "The marking is incised into the gallery wall. It is evidence you can understand, not an object you can carry away." CR>
           <RTRUE>)>
    <RFALSE>>

<OBJECT CLUE-DRAGON-VENT-MARK
    (IN DRAGON-GALLERY)
    (SYNONYM MARK MARKING GLYPH GLYPHS SYMBOL CUTS)
    (ADJECTIVE OLD ANCIENT GEOMETRIC ANGULAR BASALT)
    (DESC "old geometric marking")
    (LDESC "High on the eastern basalt, a few old geometric cuts interrupt the heat-darkened stone.")
    (FLAGS TRYTAKEBIT)
    (ACTION CLUE-DRAGON-VENT-MARK-F)>

<ROUTINE V-CLUE-INTERPRET ()
    <COND (<EQUAL? ,PRSO ,PRAYER>
           <COND (<CLUE-KNOWLEDGE-TRUE? ,CK-ANCIENT-SCRIPT>
                  <TELL "You compare the ancient prayer's repeated forms again. The useful result is already in memory: enough of its old grammatical structure to recognize the same surviving notation elsewhere." CR>)
                 (T
                  <CLUE-KNOWLEDGE-PUT ,CK-ANCIENT-SCRIPT 1>
                  <TELL "The prayer already yields a rough paraphrase, so you stop treating its old script as one opaque block and compare the repeated forms against the meaning you can recover. Several endings and determinatives repeat consistently enough to learn a small piece of the script's grammar. You memorize the pattern rather than the wall: this is reading knowledge, not a portable key." CR>)>
           <RTRUE>)
          (<EQUAL? ,PRSO ,ENGRAVINGS>
           <COND (<NOT <CLUE-KNOWLEDGE-TRUE? ,CK-ANCIENT-SCRIPT>>
                  <TELL "The symbolic reliefs and surviving excerpts clearly belong to the same ancient culture, but the later excisions leave too little context for you to separate decoration from notation with confidence. Another readable sample of the old script would give you something to compare." CR>
                  <RTRUE>)
                 (<CLUE-KNOWLEDGE-TRUE? ,CK-AIR-PASSAGE-MOTIF>
                  <TELL "Using the Temple prayer's grammar, you can still pick out the surviving practical sign among the damaged religious reliefs: paired angles around three rising strokes denote a bounded opening that carries breath or moving air. The excised doctrine remains lost; the small architectural notation is already learned." CR>
                  <RTRUE>)>
           <CLUE-KNOWLEDGE-PUT ,CK-AIR-PASSAGE-MOTIF 1>
           <TELL "With the Temple prayer's grammar in memory, one repeated element of the damaged engravings finally separates itself from the surrounding theology. Paired angles around three rising strokes recur where the surviving text describes breath moving through a bounded opening. You cannot restore the excised doctrine, but you can now recognize that practical air-passage motif elsewhere." CR>
           <RTRUE>)
          (<EQUAL? ,PRSO ,CLUE-DRAGON-VENT-MARK>
           <COND (<NOT <CLUE-KNOWLEDGE-TRUE? ,CK-AIR-PASSAGE-MOTIF>>
                  <TELL "You can tell that the old cuts are intentional, but you do not yet know what their geometry means. Guessing a secret mechanism from an unfamiliar symbol would be invention, not interpretation." CR>
                  <RTRUE>)>
           <CLUE-KNOWLEDGE-PUT ,CK-VENT-MARK-INTERPRETED 1>
           <COND (<IN? ,DRAGON-VENT-SEAM ,DRAGON-GALLERY>
                  <TELL "You recognize the old air-passage motif and follow its alignment into the heat-darkened stone. It points to the ventilation seam you have already discovered. The remembered sign explains what that structure was for; it creates no second opening and changes no existing air or smoke authority." CR>)
                 (T
                  <MOVE ,DRAGON-VENT-SEAM ,DRAGON-GALLERY>
                  <TELL "You recognize the cuts as the Engravings Cave's air-passage motif. Their angles are not a map, but their axis points into the uneven soot above the eastern arch. Following that line makes the high break resolve into a real ventilation seam in the basalt. The remembered meaning has helped you identify existing structure; it has not opened a secret door." CR>)>
           <RTRUE>)
          (<EQUAL? ,PRSO ,SEMANTIC-DRAGON-BLACKENING>
           <COND (<CLUE-KNOWLEDGE-TRUE? ,CK-AIR-PASSAGE-MOTIF>
                  <TELL "The blackening is physical evidence rather than writing. Still, with the old air-passage motif in mind, the soot's narrow upward convergence looks less accidental: it is exactly the sort of trace a high vent would accumulate. EXAMINE the blackening if you want to follow the physical evidence itself." CR>)
                 (T
                  <TELL "The blackening is heat history, not a script you know how to interpret as language. Its physical pattern can still be examined on its own terms." CR>)>
           <RTRUE>)
          (T
           <TELL "You examine the " D ,PRSO " for learned meaning, but you have no authored interpretive chain that makes it signify something beyond what ordinary examination already shows." CR>
           <RTRUE>)>>
