"Player-specific troll, cyclops, and thief dossiers for the repository-local Zork I Glulx lineage."

;"Release 1225 observes exact canonical actor state and player actions. It
  records bounded encounter evidence without altering actors, combat, timers,
  randomness, puzzle authority, property custody, or score."

<CONSTANT NPC-SCHEMA 1>

<CONSTANT NS-VERSION 0>
<CONSTANT NS-SEEN 1>
<CONSTANT NS-TROLL 2>
<CONSTANT NS-CYCLOPS 3>
<CONSTANT NS-THIEF 4>
<CONSTANT NS-FILED 5>
<CONSTANT NS-QUOTES 6>
<CONSTANT NS-EVENTS 7>
<CONSTANT NS-EVENT-DOSSIER 8>
<CONSTANT NS-EVENT-QUOTE 9>
<CONSTANT NS-EVENT-COMPLETE 10>
<CONSTANT NS-EVENT-RESTORE 11>

<CONSTANT NPC-BIT-TROLL 1>
<CONSTANT NPC-BIT-CYCLOPS 2>
<CONSTANT NPC-BIT-THIEF 4>
<CONSTANT NPC-BIT-TIMELINE 8>

<CONSTANT NPC-FIRST 1>
<CONSTANT NPC-HOSTILE 2>
<CONSTANT NPC-GIFT 4>
<CONSTANT NPC-ATTACK 8>
<CONSTANT NPC-RESTRAINT 16>
<CONSTANT NPC-BARGAIN 32>
<CONSTANT NPC-OUTCOME 64>
<CONSTANT NPC-MISSING 128>
<CONSTANT NPC-RECOVERY 256>

<CONSTANT NPC-STATE <TABLE 0 0 0 0 0 0 0 0 <> <> <> <>>>

<ROUTINE NPC-GET (SLOT)
    <GET ,NPC-STATE .SLOT>>

<ROUTINE NPC-PUT (SLOT VALUE)
    <PUT ,NPC-STATE .SLOT .VALUE>>

<ROUTINE NPC-HAS? (SLOT BIT)
    <COND (<NOT <0? <BAND <NPC-GET .SLOT> .BIT>>> <RTRUE>)>
    <RFALSE>>

<ROUTINE NPC-SET (SLOT BIT)
    <NPC-PUT .SLOT <BOR <NPC-GET .SLOT> .BIT>>
    <RTRUE>>

<OBJECT NPC-TROLL-DOSSIER
    (SYNONYM DOSSIER FOLDER FILE RECORD)
    (ADJECTIVE TROLL GREEN)
    (DESC "green troll dossier")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 2)
    (ACTION NPC-DOSSIER-FCN)>

<OBJECT NPC-CYCLOPS-DOSSIER
    (SYNONYM DOSSIER FOLDER FILE RECORD)
    (ADJECTIVE CYCLOPS YELLOW)
    (DESC "yellow cyclops dossier")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 2)
    (ACTION NPC-DOSSIER-FCN)>

<OBJECT NPC-THIEF-DOSSIER
    (SYNONYM DOSSIER FOLDER FILE RECORD)
    (ADJECTIVE THIEF BLACK PROPERTY)
    (DESC "black thief property dossier")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 2)
    (ACTION NPC-DOSSIER-FCN)>

<OBJECT NPC-TIMELINE-CASSETTE
    (SYNONYM CASSETTE TAPE TIMELINE RECORD)
    (ADJECTIVE ENCOUNTER ACTOR QUOTE)
    (DESC "encounter timeline cassette")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (SIZE 2)
    (ACTION NPC-DOSSIER-FCN)>

<ROUTINE NPC-DOSSIER-BIT (OBJ)
    <COND (<EQUAL? .OBJ ,NPC-TROLL-DOSSIER> <RETURN ,NPC-BIT-TROLL>)
          (<EQUAL? .OBJ ,NPC-CYCLOPS-DOSSIER> <RETURN ,NPC-BIT-CYCLOPS>)
          (<EQUAL? .OBJ ,NPC-THIEF-DOSSIER> <RETURN ,NPC-BIT-THIEF>)
          (<EQUAL? .OBJ ,NPC-TIMELINE-CASSETTE> <RETURN ,NPC-BIT-TIMELINE>)>
    <RETURN 0>>

<ROUTINE NPC-DOSSIER? (OBJ)
    <COND (<NOT <0? <NPC-DOSSIER-BIT .OBJ>>> <RTRUE>)>
    <RFALSE>>

<ROUTINE NPC-MATERIALIZE (OBJ BIT)
    <COND (<NOT <LOC .OBJ>> <MOVE .OBJ ,ARCHIVE-CABINET>)>
    <NPC-SET ,NS-SEEN .BIT>
    <ARCHIVE-SET-BIT ,AS-INDEXED <* .BIT 32>>
    <NPC-PUT ,NS-EVENT-DOSSIER T>
    <RTRUE>>

<ROUTINE NPC-ENSURE-TIMELINE ()
    <COND (<NOT <0? <NPC-GET ,NS-SEEN>>>
           <NPC-MATERIALIZE ,NPC-TIMELINE-CASSETTE ,NPC-BIT-TIMELINE>)>
    <RFALSE>>

<ROUTINE NPC-OBSERVE-TROLL ()
    <COND (<EQUAL? ,HERE ,TROLL-ROOM>
           <NPC-MATERIALIZE ,NPC-TROLL-DOSSIER ,NPC-BIT-TROLL>
           <NPC-SET ,NS-TROLL ,NPC-FIRST>
           <COND (<FSET? ,TROLL ,FIGHTBIT>
                  <NPC-SET ,NS-TROLL ,NPC-HOSTILE>)>
           <COND (,TROLL-FLAG
                  <NPC-SET ,NS-TROLL ,NPC-OUTCOME>)>
           <COND (<EQUAL? <LOC ,AXE> ,TROLL>
                  <NPC-SET ,NS-TROLL ,NPC-RECOVERY>)>
           <COND (<NOT <LOC ,TROLL>>
                  <NPC-SET ,NS-TROLL ,NPC-MISSING>)>)>
    <RFALSE>>

<ROUTINE NPC-OBSERVE-CYCLOPS ()
    <COND (<EQUAL? ,HERE ,CYCLOPS-ROOM>
           <NPC-MATERIALIZE ,NPC-CYCLOPS-DOSSIER ,NPC-BIT-CYCLOPS>
           <NPC-SET ,NS-CYCLOPS ,NPC-FIRST>
           <COND (<FSET? ,CYCLOPS ,FIGHTBIT>
                  <NPC-SET ,NS-CYCLOPS ,NPC-HOSTILE>)>
           <COND (<L? ,CYCLOWRATH 0>
                  <NPC-SET ,NS-CYCLOPS ,NPC-GIFT>)>
           <COND (<G? ,CYCLOWRATH 0>
                  <NPC-SET ,NS-CYCLOPS ,NPC-ATTACK>)>
           <COND (,CYCLOPS-FLAG
                  <NPC-SET ,NS-CYCLOPS ,NPC-OUTCOME>)>
           <COND (,MAGIC-FLAG
                  <NPC-SET ,NS-CYCLOPS ,NPC-RECOVERY>)>)>
    <RFALSE>>

<ROUTINE NPC-OBSERVE-THIEF ()
    <COND (<OR ,THIEF-HERE ,MUSEUM-THEFT-OCCURRED>
           <NPC-MATERIALIZE ,NPC-THIEF-DOSSIER ,NPC-BIT-THIEF>
           <NPC-SET ,NS-THIEF ,NPC-FIRST>
           <COND (<FSET? ,THIEF ,FIGHTBIT>
                  <NPC-SET ,NS-THIEF ,NPC-HOSTILE>)>
           <COND (,MUSEUM-THEFT-OCCURRED
                  <NPC-SET ,NS-THIEF ,NPC-OUTCOME>)>
           <COND (<FSET? ,THIEF ,INVISIBLE>
                  <NPC-SET ,NS-THIEF ,NPC-MISSING>)>
           <COND (,THIEF-ENGROSSED
                  <NPC-SET ,NS-THIEF ,NPC-BARGAIN>)>
           <COND (<OR <EQUAL? <LOC ,STILETTO> ,THIEF>
                      <EQUAL? <LOC ,LARGE-BAG> ,THIEF>>
                  <NPC-SET ,NS-THIEF ,NPC-RECOVERY>)>)>
    <RFALSE>>

<ROUTINE NPC-OBSERVE-WORLD ()
    <NPC-OBSERVE-TROLL>
    <NPC-OBSERVE-CYCLOPS>
    <NPC-OBSERVE-THIEF>
    <NPC-ENSURE-TIMELINE>
    <RFALSE>>

<ROUTINE NPC-ACTOR-INVOLVED? (ACTOR)
    <COND (<EQUAL? ,PRSO .ACTOR> <RTRUE>)
          (<AND ,PRSI <EQUAL? ,PRSI .ACTOR>> <RTRUE>)>
    <RFALSE>>

<ROUTINE NPC-OBSERVE-ACTION ()
    <COND (<NPC-ACTOR-INVOLVED? ,TROLL>
           <NPC-MATERIALIZE ,NPC-TROLL-DOSSIER ,NPC-BIT-TROLL>
           <NPC-SET ,NS-TROLL ,NPC-FIRST>
           <COND (<VERB? ATTACK MUNG KICK>
                  <NPC-SET ,NS-TROLL ,NPC-ATTACK>
                  <NPC-SET ,NS-TROLL ,NPC-HOSTILE>)
                 (<VERB? GIVE THROW>
                  <NPC-SET ,NS-TROLL ,NPC-GIFT>)
                 (<VERB? TIE UNTIE>
                  <NPC-SET ,NS-TROLL ,NPC-RESTRAINT>)>)
          (<NPC-ACTOR-INVOLVED? ,CYCLOPS>
           <NPC-MATERIALIZE ,NPC-CYCLOPS-DOSSIER ,NPC-BIT-CYCLOPS>
           <NPC-SET ,NS-CYCLOPS ,NPC-FIRST>
           <COND (<VERB? ATTACK MUNG KICK THROW>
                  <NPC-SET ,NS-CYCLOPS ,NPC-ATTACK>
                  <NPC-SET ,NS-CYCLOPS ,NPC-HOSTILE>)
                 (<VERB? GIVE>
                  <NPC-SET ,NS-CYCLOPS ,NPC-GIFT>)
                 (<VERB? TIE>
                  <NPC-SET ,NS-CYCLOPS ,NPC-RESTRAINT>)>)
          (<NPC-ACTOR-INVOLVED? ,THIEF>
           <NPC-MATERIALIZE ,NPC-THIEF-DOSSIER ,NPC-BIT-THIEF>
           <NPC-SET ,NS-THIEF ,NPC-FIRST>
           <COND (<VERB? ATTACK MUNG KICK>
                  <NPC-SET ,NS-THIEF ,NPC-ATTACK>
                  <NPC-SET ,NS-THIEF ,NPC-HOSTILE>)
                 (<VERB? GIVE THROW>
                  <NPC-SET ,NS-THIEF ,NPC-GIFT>
                  <NPC-SET ,NS-THIEF ,NPC-BARGAIN>)
                 (<VERB? TIE>
                  <NPC-SET ,NS-THIEF ,NPC-RESTRAINT>)>)
          (<AND <EQUAL? ,HERE ,CYCLOPS-ROOM> <VERB? ODYSSEUS>>
           <NPC-MATERIALIZE ,NPC-CYCLOPS-DOSSIER ,NPC-BIT-CYCLOPS>
           <NPC-SET ,NS-CYCLOPS ,NPC-BARGAIN>
           <NPC-SET ,NS-QUOTES ,NPC-BIT-CYCLOPS>)>
    <COND (<OR <VERB? TELL ASK GIVE THROW ATTACK MUNG KICK TIE UNTIE ODYSSEUS>
               <NPC-PUT ,NS-EVENTS T>)>
    <NPC-ENSURE-TIMELINE>
    <RFALSE>>

<ROUTINE NPC-TELL-YES-NO (VALUE YES NO)
    <COND (.VALUE <TELL .YES>) (T <TELL .NO>)>
    <RTRUE>>

<ROUTINE NPC-READ-TROLL ()
    <TELL "NPC-TROLL-01. Player-specific encounter dossier." CR>
    <COND (<NPC-HAS? ,NS-TROLL ,NPC-FIRST>
           <TELL "- First contact: observed in the Troll Room or through a direct player action." CR>)>
    <COND (<NPC-HAS? ,NS-TROLL ,NPC-HOSTILE>
           <TELL "- Hostility: observed or directly provoked; the file does not predict the next combat roll." CR>)
          (T <TELL "- Hostility: not established by retained evidence." CR>)>
    <COND (<NPC-HAS? ,NS-TROLL ,NPC-GIFT>
           <TELL "- Gift or thrown-object attempt: retained without claiming acceptance." CR>)>
    <COND (<NPC-HAS? ,NS-TROLL ,NPC-ATTACK>
           <TELL "- Combat: the player attempted violence; exact damage remains canonical combat state." CR>)>
    <COND (<NPC-HAS? ,NS-TROLL ,NPC-RESTRAINT>
           <TELL "- Restraint: a tie or untie attempt was observed; success is not inferred." CR>)>
    <COND (<NPC-HAS? ,NS-TROLL ,NPC-OUTCOME>
           <TELL "- Passage status: later evidence shows the troll no longer actively bars the passages." CR>)
          (T <TELL "- Passage status: unresolved or missing from this expedition record." CR>)>
    <COND (<NPC-HAS? ,NS-TROLL ,NPC-RECOVERY>
           <TELL "- Axe custody: the canonical axe was observed with the troll at a recorded point." CR>)>
    <NPC-PUT ,NS-EVENT-COMPLETE T>
    <RTRUE>>

<ROUTINE NPC-READ-CYCLOPS ()
    <TELL "NPC-CYCLOPS-02. Player-specific impatience and offer dossier." CR>
    <COND (<NPC-HAS? ,NS-CYCLOPS ,NPC-FIRST>
           <TELL "- First contact: observed at the foot of the Cyclops Room stairs." CR>)>
    <COND (<NPC-HAS? ,NS-CYCLOPS ,NPC-HOSTILE>
           <TELL "- Mood: active hostility was observed." CR>)
          (T <TELL "- Mood: hostility is not established by retained evidence." CR>)>
    <COND (<NPC-HAS? ,NS-CYCLOPS ,NPC-GIFT>
           <TELL "- Offer history: food or drink was offered; peppered and water outcomes remain distinguished by live state." CR>)>
    <COND (<L? ,CYCLOWRATH 0>
           <TELL "- Current verified state: peppered, thirsty, and increasingly impatient." CR>)
          (<G? ,CYCLOWRATH 0>
           <TELL "- Current verified state: agitated and increasingly dangerous." CR>)
          (T <TELL "- Current verified state: no directional wrath evidence is retained." CR>)>
    <COND (<NPC-HAS? ,NS-CYCLOPS ,NPC-BARGAIN>
           <TELL "- Statement history: the Odysseus exchange was attempted or heard in context." CR>)>
    <COND (<NPC-HAS? ,NS-CYCLOPS ,NPC-OUTCOME>
           <TELL "- Sleep outcome: canonical sleep state was observed; this dossier does not wake or preserve it artificially." CR>)>
    <COND (<NPC-HAS? ,NS-CYCLOPS ,NPC-RECOVERY>
           <TELL "- Route outcome: the canonical cyclops-sized opening exists in live world state." CR>)>
    <NPC-PUT ,NS-EVENT-COMPLETE T>
    <RTRUE>>

<ROUTINE NPC-READ-THIEF ()
    <TELL "NPC-THIEF-03. Player-specific encounter and property dossier." CR>
    <COND (<NPC-HAS? ,NS-THIEF ,NPC-FIRST>
           <TELL "- Contact: the thief was present, addressed, fought, bargained with, or evidenced through a real theft." CR>)>
    <COND (<NPC-HAS? ,NS-THIEF ,NPC-HOSTILE>
           <TELL "- Hostility: live combat posture was observed." CR>)
          (T <TELL "- Hostility: not established by retained evidence." CR>)>
    <COND (<NPC-HAS? ,NS-THIEF ,NPC-GIFT>
           <TELL "- Exchange: a gift or thrown treasure was offered; acceptance is recorded only when canonical state supports it." CR>)>
    <COND (<NPC-HAS? ,NS-THIEF ,NPC-BARGAIN>
           <TELL "- Bargain/engrossment: retained as an encounter condition, not a promise of safety." CR>)>
    <COND (<NPC-HAS? ,NS-THIEF ,NPC-OUTCOME>
           <TELL "- Property event: exact museum theft evidence exists in this run." CR>)
          (T <TELL "- Property event: no verified museum theft is retained." CR>)>
    <COND (<NPC-HAS? ,NS-THIEF ,NPC-MISSING>
           <TELL "- Visibility: the thief was absent or invisible at an observed point; current location is not inferred." CR>)>
    <COND (<NPC-HAS? ,NS-THIEF ,NPC-RECOVERY>
           <TELL "- Property custody: the canonical stiletto or large bag was observed with the thief." CR>)>
    <NPC-PUT ,NS-EVENT-COMPLETE T>
    <RTRUE>>

<ROUTINE NPC-PLAY-TIMELINE ()
    <TELL "The cassette clicks into a curated encounter timeline." CR>
    <COND (<NPC-HAS? ,NS-SEEN ,NPC-BIT-TROLL>
           <TELL "First: troll contact, followed only by the attempts and outcomes actually retained in NPC-TROLL-01." CR>)>
    <COND (<NPC-HAS? ,NS-SEEN ,NPC-BIT-CYCLOPS>
           <TELL "Next: cyclops contact, with offers, impatience, sleep, and route outcomes only where evidence exists." CR>)>
    <COND (<NPC-HAS? ,NS-SEEN ,NPC-BIT-THIEF>
           <TELL "Next: thief contact or property evidence, without reconstructing missing movements or stolen items." CR>)>
    <TELL "The tape stops. No raw transcript, random roll, hidden route, future action, or live actor state was replayed." CR>
    <NPC-PUT ,NS-EVENT-QUOTE T>
    <RTRUE>>

<ROUTINE NPC-READ (OBJ)
    <COND (<EQUAL? .OBJ ,NPC-TROLL-DOSSIER> <NPC-READ-TROLL>)
          (<EQUAL? .OBJ ,NPC-CYCLOPS-DOSSIER> <NPC-READ-CYCLOPS>)
          (<EQUAL? .OBJ ,NPC-THIEF-DOSSIER> <NPC-READ-THIEF>)
          (T <NPC-PLAY-TIMELINE>)>
    <RTRUE>>

<ROUTINE NPC-CROSS (OBJ)
    <COND (<EQUAL? .OBJ ,NPC-TROLL-DOSSIER>
           <TELL "Cross-reference: NPC-TROLL-01 to HOUSE-THRESHOLD-01 only when the player carried troll evidence home." CR>)
          (<EQUAL? .OBJ ,NPC-CYCLOPS-DOSSIER>
           <TELL "Cross-reference: NPC-CYCLOPS-02 to the house chronology; no food, water, or Odysseus solution is supplied unless already observed." CR>)
          (<EQUAL? .OBJ ,NPC-THIEF-DOSSIER>
           <TELL "Cross-reference: NPC-THIEF-03 to HOUSE-DISPLAY-02 and exact property custody; missing objects remain missing." CR>)
          (T
           <TELL "Cross-reference: the three actor files in observed encounter order, with absent files explicitly absent." CR>)>
    <NPC-PUT ,NS-EVENT-COMPLETE T>
    <RTRUE>>

<ROUTINE NPC-FILE ()
    <COND (<NOT <EQUAL? ,HERE ,ATTIC>>
           <TELL "NPC dossiers can be filed only in the canonical Attic." CR>)
          (<NOT <IN? ,PRSO ,WINNER>>
           <TELL "You must hold the exact physical dossier before filing it." CR>)
          (T
           <MOVE ,PRSO ,ARCHIVE-CABINET>
           <NPC-SET ,NS-FILED <NPC-DOSSIER-BIT ,PRSO>>
           <ARCHIVE-PUT ,AS-EVENT-FILING T>
           <TELL "You file the exact dossier in the steel cabinet. No replacement, duplicate, or reconstructed property record is created." CR>)>
    <RTRUE>>

<ROUTINE NPC-DOSSIER-FCN ()
    <COND (<VERB? READ EXAMINE>
           <NPC-READ ,PRSO>
           <RTRUE>)
          (<VERB? PLAY>
           <COND (<EQUAL? ,PRSO ,NPC-TIMELINE-CASSETTE>
                  <NPC-PLAY-TIMELINE>)
                 (T <TELL "That dossier is read rather than played." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE NPC-ACTION-HOOK ()
    <NPC-OBSERVE-ACTION>
    <COND (<AND <VERB? ARCHIVE-FILE> <NPC-DOSSIER? ,PRSO>>
           <NPC-FILE>
           <RTRUE>)
          (<AND <VERB? ARCHIVE-REVIEW ARCHIVE-SHOW>
                <NPC-DOSSIER? ,PRSO>>
           <NPC-READ ,PRSO>
           <RTRUE>)
          (<AND <VERB? ARCHIVE-CROSS> <NPC-DOSSIER? ,PRSO>>
           <NPC-CROSS ,PRSO>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE NPC-ADVANCE ()
    <COND (<SHADOW-NON-TURN-COMMAND?> <RFALSE>)>
    <NPC-ENSURE>
    <NPC-OBSERVE-WORLD>
    <RFALSE>>

<ROUTINE NPC-ENSURE ()
    <COND (<NOT <EQUAL? <NPC-GET ,NS-VERSION> ,NPC-SCHEMA>>
           <NPC-PUT ,NS-VERSION ,NPC-SCHEMA>
           <NPC-PUT ,NS-EVENT-RESTORE T>
           <COND (<LOC ,NPC-TROLL-DOSSIER>
                  <NPC-SET ,NS-SEEN ,NPC-BIT-TROLL>)>
           <COND (<LOC ,NPC-CYCLOPS-DOSSIER>
                  <NPC-SET ,NS-SEEN ,NPC-BIT-CYCLOPS>)>
           <COND (<LOC ,NPC-THIEF-DOSSIER>
                  <NPC-SET ,NS-SEEN ,NPC-BIT-THIEF>)>
           <COND (<LOC ,NPC-TIMELINE-CASSETTE>
                  <NPC-SET ,NS-SEEN ,NPC-BIT-TIMELINE>)>)>
    <RFALSE>>

<ROUTINE NPC-CATALOG-LIST ()
    <COND (<NPC-HAS? ,NS-SEEN ,NPC-BIT-TROLL>
           <TELL "- NPC-TROLL-01: person / encounter / restraint / passage status." CR>)>
    <COND (<NPC-HAS? ,NS-SEEN ,NPC-BIT-CYCLOPS>
           <TELL "- NPC-CYCLOPS-02: person / offers / impatience / route outcome." CR>)>
    <COND (<NPC-HAS? ,NS-SEEN ,NPC-BIT-THIEF>
           <TELL "- NPC-THIEF-03: person / property / bargain / missing evidence." CR>)>
    <COND (<NPC-HAS? ,NS-SEEN ,NPC-BIT-TIMELINE>
           <TELL "- NPC-TIMELINE: curated quotations and encounter chronology cassette." CR>)>
    <RFALSE>>

<ROUTINE NPC-RECAP ("AUX" (SEEN <>))
    <COND (<NPC-GET ,NS-EVENTS>
           <SET SEEN T>
           <TELL "- Actor memory normalized first contact, hostility, gifts, attacks, restraint, bargains, outcomes, recovery, and missing evidence without changing canonical behavior." CR>)>
    <COND (<NPC-GET ,NS-EVENT-DOSSIER>
           <SET SEEN T>
           <TELL "- Exact troll, cyclops, thief, and timeline records materialized only after player-specific evidence existed." CR>)>
    <COND (<NPC-GET ,NS-EVENT-QUOTE>
           <SET SEEN T>
           <TELL "- Curated quotations and encounter chronology remained contextual records rather than raw logs." CR>)>
    <COND (<NPC-GET ,NS-EVENT-COMPLETE>
           <SET SEEN T>
           <TELL "- Dossier review exposed partial, contradictory, verified, and missing evidence without hidden-solution leakage." CR>)>
    <COND (<NPC-GET ,NS-EVENT-RESTORE>
           <SET SEEN T>
           <TELL "- Versioned dossier state and exact physical custody remained native-save persistent." CR>)>
    <COND (.SEEN <RTRUE>)>
    <RFALSE>>
