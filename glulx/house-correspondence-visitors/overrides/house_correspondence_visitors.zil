"Correspondence, canonical mailbox delivery, bounded replies, and visitors for the repository-local Zork I Glulx lineage."

;"Release 1223 extends the real West of House mailbox with a small authored
  correspondence queue and two bounded visitors. Every letter, reply, notice,
  receipt, and visitor is a single real object. The canonical leaflet remains
  untouched. There is no free-form composition, generic scheduler, duplicate
  mail, automatic door opening, or parallel archive."

<SYNTAX REPLY TO OBJECT = V-MAIL-REPLY>
<SYNTAX ANSWER DOOR = V-MAIL-ANSWER>
<SYNTAX ADMIT OBJECT = V-MAIL-ADMIT>
<SYNTAX REFUSE OBJECT = V-MAIL-REFUSE>

<CONSTANT MAIL-SCHEMA 1>

<CONSTANT MS-VERSION 0>
<CONSTANT MS-QUEUED 1>
<CONSTANT MS-DELIVERED 2>
<CONSTANT MS-READ 3>
<CONSTANT MS-REPLIED 4>
<CONSTANT MS-SENT 5>
<CONSTANT MS-REPLY-TARGET 6>
<CONSTANT MS-VISITOR-QUEUED 7>
<CONSTANT MS-VISITOR-ACTIVE 8>
<CONSTANT MS-VISITOR-MISSED 9>
<CONSTANT MS-VISITOR-REFUSED 10>
<CONSTANT MS-VISITOR-COMPLETE 11>
<CONSTANT MS-EVENT-QUEUE 12>
<CONSTANT MS-EVENT-PROVENANCE 13>
<CONSTANT MS-EVENT-MAILBOX 14>
<CONSTANT MS-EVENT-REPLY 15>
<CONSTANT MS-EVENT-VISITOR 16>
<CONSTANT MS-EVENT-MISSED 17>
<CONSTANT MS-LAST-DELIVERY 18>

<CONSTANT MAIL-BIT-CELLAR 1>
<CONSTANT MAIL-BIT-MUSEUM 2>
<CONSTANT MAIL-BIT-DAM 4>

<CONSTANT MAIL-VISITOR-COURIER 1>
<CONSTANT MAIL-VISITOR-SURVEYOR 2>

<GLOBAL MAIL-STATE <TABLE 1 0 0 0 0 0 0 0 0 0 0 0 <> <> <> <> <> <> 0>>

<ROUTINE MAIL-GET (SLOT)
    <GET ,MAIL-STATE .SLOT>>

<ROUTINE MAIL-PUT (SLOT VALUE)
    <PUT ,MAIL-STATE .SLOT .VALUE>>

<ROUTINE MAIL-HAS-BIT? (SLOT BIT)
    <COND (<NOT <0? <BAND <MAIL-GET .SLOT> .BIT>>> <RTRUE>)>
    <RFALSE>>

<ROUTINE MAIL-SET-BIT (SLOT BIT)
    <MAIL-PUT .SLOT <BOR <MAIL-GET .SLOT> .BIT>>
    <RTRUE>>

<ROUTINE MAIL-CLEAR-BIT (SLOT BIT)
    <MAIL-PUT .SLOT <BAND <MAIL-GET .SLOT> <XORB .BIT -1>>>
    <RTRUE>>

<OBJECT MAIL-CELLAR-NOTE
    (SYNONYM LETTER NOTE MAIL WARNING NOTICE)
    (ADJECTIVE CELLAR THRESHOLD INSURANCE GRAY)
    (DESC "gray threshold warning")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (ACTION MAIL-NOTE-FCN)
    (SIZE 1)>

<OBJECT MAIL-MUSEUM-NOTE
    (SYNONYM LETTER NOTE MAIL WARNING APPRAISAL)
    (ADJECTIVE MUSEUM DISPLAY ANONYMOUS CREAM)
    (DESC "cream appraisal warning")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (ACTION MAIL-NOTE-FCN)
    (SIZE 1)>

<OBJECT MAIL-DAM-NOTE
    (SYNONYM LETTER NOTE MAIL ACKNOWLEDGMENT RECEIPT)
    (ADJECTIVE DAM MAINTENANCE OFFICIAL BLUE)
    (DESC "blue maintenance acknowledgment")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (ACTION MAIL-NOTE-FCN)
    (SIZE 1)>

<OBJECT MAIL-REPLY-CARD
    (SYNONYM CARD REPLY RESPONSE MAIL POSTCARD)
    (ADJECTIVE OUTGOING WHITE STAMPED)
    (DESC "stamped reply card")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (ACTION MAIL-REPLY-CARD-FCN)
    (SIZE 1)>

<OBJECT MAIL-COURIER-NOTICE
    (SYNONYM NOTICE SLIP CARD MAIL)
    (ADJECTIVE COURIER MISSED YELLOW)
    (DESC "yellow courier notice")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (ACTION MAIL-RECORD-FCN)
    (SIZE 1)>

<OBJECT MAIL-SURVEYOR-NOTICE
    (SYNONYM NOTICE CARD MAIL CALLING)
    (ADJECTIVE SURVEYOR MISSED GREEN)
    (DESC "green surveyor calling card")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (ACTION MAIL-RECORD-FCN)
    (SIZE 1)>

<OBJECT MAIL-RETURN-RECEIPT
    (SYNONYM RECEIPT STUB RECORD MAIL)
    (ADJECTIVE COURIER SIGNED RETURN)
    (DESC "signed courier receipt")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (ACTION MAIL-RECORD-FCN)
    (SIZE 1)>

<OBJECT MAIL-SURVEY-TAG
    (SYNONYM TAG RECORD CARD MAIL)
    (ADJECTIVE SURVEY THRESHOLD NUMBERED)
    (DESC "numbered survey tag")
    (FLAGS READBIT TAKEBIT BURNBIT)
    (ACTION MAIL-RECORD-FCN)
    (SIZE 1)>

<OBJECT MAIL-COURIER
    (SYNONYM COURIER MESSENGER VISITOR PERSON)
    (ADJECTIVE UNIFORMED PATIENT)
    (DESC "uniformed courier")
    (FLAGS ACTORBIT TRYTAKEBIT)
    (ACTION MAIL-VISITOR-FCN)>

<OBJECT MAIL-SURVEYOR
    (SYNONYM SURVEYOR VISITOR PERSON INSPECTOR)
    (ADJECTIVE MUD SPATTERED QUIET)
    (DESC "mud-spattered surveyor")
    (FLAGS ACTORBIT TRYTAKEBIT)
    (ACTION MAIL-VISITOR-FCN)>

<ROUTINE MAIL-NOTE-BIT (OBJ)
    <COND (<EQUAL? .OBJ ,MAIL-CELLAR-NOTE> <RETURN ,MAIL-BIT-CELLAR>)
          (<EQUAL? .OBJ ,MAIL-MUSEUM-NOTE> <RETURN ,MAIL-BIT-MUSEUM>)
          (<EQUAL? .OBJ ,MAIL-DAM-NOTE> <RETURN ,MAIL-BIT-DAM>)>
    <RETURN 0>>

<ROUTINE MAIL-NOTE-FOR-BIT (BIT)
    <COND (<EQUAL? .BIT ,MAIL-BIT-CELLAR> <RETURN ,MAIL-CELLAR-NOTE>)
          (<EQUAL? .BIT ,MAIL-BIT-MUSEUM> <RETURN ,MAIL-MUSEUM-NOTE>)
          (<EQUAL? .BIT ,MAIL-BIT-DAM> <RETURN ,MAIL-DAM-NOTE>)>
    <RFALSE>>

<ROUTINE MAIL-VISITOR-FOR-BIT (BIT)
    <COND (<EQUAL? .BIT ,MAIL-VISITOR-COURIER> <RETURN ,MAIL-COURIER>)
          (<EQUAL? .BIT ,MAIL-VISITOR-SURVEYOR> <RETURN ,MAIL-SURVEYOR>)>
    <RFALSE>>

<ROUTINE MAIL-NOTICE-FOR-VISITOR (BIT)
    <COND (<EQUAL? .BIT ,MAIL-VISITOR-COURIER> <RETURN ,MAIL-COURIER-NOTICE>)
          (<EQUAL? .BIT ,MAIL-VISITOR-SURVEYOR> <RETURN ,MAIL-SURVEYOR-NOTICE>)>
    <RFALSE>>

<ROUTINE MAIL-DERIVE-QUEUE ()
    <COND (<CELLAR-GET ,CS-EVENT-INTRUSION>
           <MAIL-SET-BIT ,MS-QUEUED ,MAIL-BIT-CELLAR>)>
    <COND (,MUSEUM-THEFT-OCCURRED
           <MAIL-SET-BIT ,MS-QUEUED ,MAIL-BIT-MUSEUM>)>
    <COND (<EQUAL? ,WATER-LEVEL -1>
           <MAIL-SET-BIT ,MS-QUEUED ,MAIL-BIT-DAM>)>
    <COND (<NOT <0? <MAIL-GET ,MS-QUEUED>>>
           <MAIL-PUT ,MS-EVENT-QUEUE T>)>
    <RFALSE>>

<ROUTINE MAIL-NEXT-UNDELIVERED ("AUX" BIT)
    <SET BIT ,MAIL-BIT-CELLAR>
    <REPEAT ()
        <COND (<G? .BIT ,MAIL-BIT-DAM> <RFALSE>)
              (<AND <MAIL-HAS-BIT? ,MS-QUEUED .BIT>
                    <NOT <MAIL-HAS-BIT? ,MS-DELIVERED .BIT>>>
               <RETURN .BIT>)>
        <SET BIT <* .BIT 2>>>>

<ROUTINE MAIL-DELIVER-NEXT ("AUX" BIT OBJ)
    <SET BIT <MAIL-NEXT-UNDELIVERED>>
    <COND (<NOT .BIT> <RFALSE>)>
    <SET OBJ <MAIL-NOTE-FOR-BIT .BIT>>
    <COND (<LOC .OBJ>
           <MAIL-SET-BIT ,MS-DELIVERED .BIT>
           <RFALSE>)>
    <MOVE .OBJ ,MAILBOX>
    <MAIL-SET-BIT ,MS-DELIVERED .BIT>
    <MAIL-PUT ,MS-LAST-DELIVERY .BIT>
    <MAIL-PUT ,MS-EVENT-MAILBOX T>
    <COND (<EQUAL? ,HERE ,WEST-OF-HOUSE>
           <TELL "A small internal flap clicks inside the anchored mailbox; one real piece of correspondence has arrived." CR>)>
    <RTRUE>>

<ROUTINE MAIL-QUEUE-VISITOR (BIT)
    <COND (<NOT <MAIL-HAS-BIT? ,MS-VISITOR-COMPLETE .BIT>>
           <MAIL-SET-BIT ,MS-VISITOR-QUEUED .BIT>)>
    <RTRUE>>

<ROUTINE MAIL-NEXT-VISITOR ("AUX" BIT)
    <SET BIT ,MAIL-VISITOR-COURIER>
    <REPEAT ()
        <COND (<G? .BIT ,MAIL-VISITOR-SURVEYOR> <RFALSE>)
              (<AND <MAIL-HAS-BIT? ,MS-VISITOR-QUEUED .BIT>
                    <NOT <MAIL-HAS-BIT? ,MS-VISITOR-COMPLETE .BIT>>>
               <RETURN .BIT>)>
        <SET BIT <* .BIT 2>>>>

<ROUTINE MAIL-LEAVE-MISSED-NOTICE (BIT "AUX" OBJ)
    <SET OBJ <MAIL-NOTICE-FOR-VISITOR .BIT>>
    <COND (<NOT <LOC .OBJ>> <MOVE .OBJ ,MAILBOX>)>
    <MAIL-SET-BIT ,MS-VISITOR-MISSED .BIT>
    <MAIL-PUT ,MS-EVENT-MISSED T>
    <RTRUE>>

<ROUTINE MAIL-VISITOR-ARRIVE ("AUX" BIT OBJ)
    <COND (<NOT <0? <MAIL-GET ,MS-VISITOR-ACTIVE>>> <RFALSE>)>
    <SET BIT <MAIL-NEXT-VISITOR>>
    <COND (<NOT .BIT> <RFALSE>)>
    <COND (<NOT <EQUAL? ,HERE ,WEST-OF-HOUSE>>
           <MAIL-LEAVE-MISSED-NOTICE .BIT>
           <RFALSE>)>
    <SET OBJ <MAIL-VISITOR-FOR-BIT .BIT>>
    <MOVE .OBJ ,WEST-OF-HOUSE>
    <FCLEAR .OBJ ,INVISIBLE>
    <MAIL-PUT ,MS-VISITOR-ACTIVE .BIT>
    <MAIL-PUT ,MS-EVENT-VISITOR T>
    <COND (<EQUAL? .BIT ,MAIL-VISITOR-COURIER>
           <TELL "A uniformed courier waits beside the mailbox and knocks on the boarded front door with professional optimism." CR>)
          (T
           <TELL "A mud-spattered surveyor waits beside the mailbox, studying the house and its threshold marks without touching either." CR>)>
    <RTRUE>>

<ROUTINE MAIL-DISPATCH-REPLY ()
    <COND (<NOT <IN? ,MAIL-REPLY-CARD ,WINNER>>
           <TELL "You would first need to be holding the reply card." CR>)
          (<0? <MAIL-GET ,MS-REPLY-TARGET>>
           <TELL "The blank reply card has not been prepared for any authored letter." CR>)
          (T
           <REMOVE-CAREFULLY ,MAIL-REPLY-CARD>
           <MAIL-SET-BIT ,MS-SENT <MAIL-GET ,MS-REPLY-TARGET>>
           <COND (<EQUAL? <MAIL-GET ,MS-REPLY-TARGET> ,MAIL-BIT-CELLAR>
                  <MAIL-QUEUE-VISITOR ,MAIL-VISITOR-SURVEYOR>)
                 (T
                  <MAIL-QUEUE-VISITOR ,MAIL-VISITOR-COURIER>)>
           <MAIL-PUT ,MS-REPLY-TARGET 0>
           <MAIL-PUT ,MS-EVENT-REPLY T>
           <MAIL-PUT ,MS-EVENT-MAILBOX T>
           <TELL "You slide the fixed-text card into the mailbox's narrow outgoing clip. Its spring takes the card into a locked lower compartment; no duplicate remains in your hand." CR>)>
    <RTRUE>>

<ROUTINE MAIL-MAILBOX-HOOK ()
    <COND (<AND <VERB? PUT>
                <EQUAL? ,PRSI ,MAILBOX>
                <EQUAL? ,PRSO ,MAIL-REPLY-CARD>>
           <MAIL-DISPATCH-REPLY>)
          (<AND <VERB? EXAMINE LOOK-INSIDE SEARCH>
                <EQUAL? ,PRSO ,MAILBOX>>
           <MAIL-PUT ,MS-EVENT-MAILBOX T>
           <RFALSE>)>
    <RFALSE>>

<ROUTINE MAIL-PROVENANCE (OBJ)
    <MAIL-PUT ,MS-EVENT-PROVENANCE T>
    <COND (<EQUAL? .OBJ ,MAIL-CELLAR-NOTE>
           <TELL "Sender: West of House Mutual Assurance Society. Trigger: physical intrusion evidence at the Cellar threshold. Delivery: canonical mailbox. Authenticity: signed and internally consistent. Filing code: HOUSE-THRESHOLD-01.">)
          (<EQUAL? .OBJ ,MAIL-MUSEUM-NOTE>
           <TELL "Sender: an unnamed appraiser. Trigger: an unsecured display theft. Delivery: canonical mailbox. Authenticity: plausible but deliberately unsigned. Filing code: HOUSE-DISPLAY-02.">)
          (<EQUAL? .OBJ ,MAIL-DAM-NOTE>
           <TELL "Sender: Flood Control Dam #3 Maintenance Office. Trigger: the repaired dam state. Delivery: canonical mailbox. Authenticity: official stamped stock. Filing code: FCD3-MAINT-03.">)
          (<EQUAL? .OBJ ,MAIL-COURIER-NOTICE>
           <TELL "Sender: the uniformed courier. Trigger: a missed attempted visit. Authenticity: machine-numbered yellow stock. Filing code: VISIT-COURIER-01.">)
          (<EQUAL? .OBJ ,MAIL-SURVEYOR-NOTICE>
           <TELL "Sender: the threshold surveyor. Trigger: a missed attempted visit. Authenticity: handwritten green stock. Filing code: VISIT-SURVEY-01.">)
          (<EQUAL? .OBJ ,MAIL-RETURN-RECEIPT>
           <TELL "Source: the uniformed courier. Trigger: accepted doorstep exchange. Authenticity: signed and time-stamped. Filing code: VISIT-COURIER-RECEIPT.">)
          (T
           <TELL "Source: the threshold surveyor. Trigger: accepted doorstep inspection. Authenticity: numbered field tag. Filing code: VISIT-SURVEY-TAG.">)>
    <RTRUE>>

<ROUTINE MAIL-NOTE-FCN ("AUX" BIT)
    <SET BIT <MAIL-NOTE-BIT ,PRSO>>
    <COND (<VERB? READ EXAMINE>
           <MAIL-SET-BIT ,MS-READ .BIT>
           <COND (<EQUAL? ,PRSO ,MAIL-CELLAR-NOTE>
                  <TELL "To the occupant: repeated threshold marks may indicate that insured household boundaries have become narratively porous. We recommend observation, not panic, and specifically decline coverage for self-created supernatural residue." CR>)
                 (<EQUAL? ,PRSO ,MAIL-MUSEUM-NOTE>
                  <TELL "Your display has attracted professional attention and at least one unprofessional visitor. Open shelves are not security. The enclosed warning awards no score and restores no stolen property." CR>)
                 (T
                  <TELL "Flood Control Dam #3 acknowledges the return of meaningful mechanical function. This notice is not a warranty, a refund, or permission to turn the bolt without the real wrench." CR>)>
           <MAIL-PROVENANCE ,PRSO>
           <CRLF>
           <COND (<EQUAL? .BIT ,MAIL-BIT-DAM>
                  <MAIL-QUEUE-VISITOR ,MAIL-VISITOR-SURVEYOR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MAIL-RECORD-FCN ()
    <COND (<VERB? READ EXAMINE>
           <COND (<EQUAL? ,PRSO ,MAIL-COURIER-NOTICE>
                  <TELL "Attempted delivery. The courier will return when the occupant is again at the west side of the house." CR>)
                 (<EQUAL? ,PRSO ,MAIL-SURVEYOR-NOTICE>
                  <TELL "Called regarding threshold conditions. No entry was attempted. The surveyor will revisit." CR>)
                 (<EQUAL? ,PRSO ,MAIL-RETURN-RECEIPT>
                  <TELL "One bounded reply was collected from the canonical mailbox and delivered without duplication." CR>)
                 (T
                  <TELL "The tag records an exterior threshold inspection. The boarded door remained closed and no route was created." CR>)>
           <MAIL-PROVENANCE ,PRSO>
           <CRLF>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE MAIL-REPLY-CARD-FCN ()
    <COND (<VERB? READ EXAMINE>
           <COND (<0? <MAIL-GET ,MS-REPLY-TARGET>>
                  <TELL "It is a blank stamped card reserved for one of the authored correspondence choices." CR>)
                 (<EQUAL? <MAIL-GET ,MS-REPLY-TARGET> ,MAIL-BIT-CELLAR>
                  <TELL "The fixed response requests an exterior threshold survey and authorizes no entry into the house." CR>)
                 (<EQUAL? <MAIL-GET ,MS-REPLY-TARGET> ,MAIL-BIT-MUSEUM>
                  <TELL "The fixed response acknowledges the security warning and requests a signed collection receipt." CR>)
                 (T
                  <TELL "The fixed response acknowledges the dam notice and requests a stamped maintenance receipt." CR>)>
           <RTRUE>)>
    <RFALSE>>

<ROUTINE V-MAIL-REPLY ("AUX" BIT)
    <SET BIT <MAIL-NOTE-BIT ,PRSO>>
    <COND (<0? .BIT>
           <TELL "Only the three authored letters accept bounded replies." CR>)
          (<NOT <MAIL-HAS-BIT? ,MS-READ .BIT>>
           <TELL "Read the letter before selecting its fixed response." CR>)
          (<MAIL-HAS-BIT? ,MS-REPLIED .BIT>
           <TELL "A response to that letter has already been prepared." CR>)
          (<LOC ,MAIL-REPLY-CARD>
           <TELL "The single reply card is already in use. Post or discard it before preparing another." CR>)
          (T
           <MAIL-SET-BIT ,MS-REPLIED .BIT>
           <MAIL-PUT ,MS-REPLY-TARGET .BIT>
           <MOVE ,MAIL-REPLY-CARD ,WINNER>
           <MAIL-PUT ,MS-EVENT-REPLY T>
           <TELL "You prepare the one fixed response appropriate to this letter. The stamped reply card is now in your hand; put it in the real mailbox to send it." CR>)>
    <RTRUE>>

<ROUTINE V-MAIL-ANSWER ("AUX" BIT)
    <SET BIT <MAIL-GET ,MS-VISITOR-ACTIVE>>
    <COND (<0? .BIT>
           <TELL "No one is presently waiting at the boarded front door." CR>)
          (<EQUAL? .BIT ,MAIL-VISITOR-COURIER>
           <TELL "The courier identifies the reply by its fixed filing code and asks whether you will accept a signed doorstep receipt. The boarded door remains closed." CR>)
          (T
           <TELL "The surveyor requests permission to inspect the exterior mailbox and threshold evidence. No request is made to bypass the boarded door." CR>)>
    <MAIL-PUT ,MS-EVENT-VISITOR T>
    <RTRUE>>

<ROUTINE MAIL-COMPLETE-VISITOR (BIT "AUX" OBJ RECORD)
    <SET OBJ <MAIL-VISITOR-FOR-BIT .BIT>>
    <COND (<EQUAL? .BIT ,MAIL-VISITOR-COURIER>
           <SET RECORD ,MAIL-RETURN-RECEIPT>)
          (T <SET RECORD ,MAIL-SURVEY-TAG>)>
    <REMOVE-CAREFULLY .OBJ>
    <MAIL-CLEAR-BIT ,MS-VISITOR-QUEUED .BIT>
    <MAIL-SET-BIT ,MS-VISITOR-COMPLETE .BIT>
    <MAIL-PUT ,MS-VISITOR-ACTIVE 0>
    <COND (<NOT <LOC .RECORD>> <MOVE .RECORD ,MAILBOX>)>
    <MAIL-PUT ,MS-EVENT-VISITOR T>
    <RTRUE>>

<ROUTINE V-MAIL-ADMIT ("AUX" BIT OBJ)
    <SET BIT <MAIL-GET ,MS-VISITOR-ACTIVE>>
    <SET OBJ <MAIL-VISITOR-FOR-BIT .BIT>>
    <COND (<OR <0? .BIT> <NOT <EQUAL? ,PRSO .OBJ>>>
           <TELL "That visitor is not presently waiting at the west side of the house." CR>)
          (<EQUAL? .BIT ,MAIL-VISITOR-COURIER>
           <TELL "Because the canonical front door is still boarded, you admit the courier only to a formal exchange at the doorstep. A signed receipt is placed in the mailbox; no interior route opens." CR>
           <MAIL-COMPLETE-VISITOR .BIT>)
          (T
           <TELL "You admit the surveyor to an exterior inspection of the mailbox and threshold. The boarded door remains closed. A numbered survey tag is left in the mailbox." CR>
           <MAIL-COMPLETE-VISITOR .BIT>)>
    <RTRUE>>

<ROUTINE V-MAIL-REFUSE ("AUX" BIT OBJ)
    <SET BIT <MAIL-GET ,MS-VISITOR-ACTIVE>>
    <SET OBJ <MAIL-VISITOR-FOR-BIT .BIT>>
    <COND (<OR <0? .BIT> <NOT <EQUAL? ,PRSO .OBJ>>>
           <TELL "That visitor is not presently waiting here." CR>)
          (<MAIL-HAS-BIT? ,MS-VISITOR-REFUSED .BIT>
           <TELL "You refuse the visitor a second time. The visit is closed without entry, exchange, or route change." CR>
           <MAIL-COMPLETE-VISITOR .BIT>)
          (T
           <REMOVE-CAREFULLY .OBJ>
           <MAIL-PUT ,MS-VISITOR-ACTIVE 0>
           <MAIL-SET-BIT ,MS-VISITOR-REFUSED .BIT>
           <MAIL-LEAVE-MISSED-NOTICE .BIT>
           <TELL "You refuse the visit. A physical notice remains in the mailbox, and one bounded return attempt remains possible." CR>)>
    <RTRUE>>

<ROUTINE MAIL-VISITOR-FCN ()
    <COND (<VERB? EXAMINE>
           <COND (<EQUAL? ,PRSO ,MAIL-COURIER>
                  <TELL "The courier carries no parcel for free-form exchange, only a numbered receipt tied to your posted reply." CR>)
                 (T
                  <TELL "The surveyor carries a clipboard and numbered tags, but no authority to enter or alter the house." CR>)>)
          (<VERB? TELL>
           <SETG P-CONT <>>
           <V-MAIL-ANSWER>)
          (<VERB? TAKE ATTACK MUNG>
           <TELL "The visitor steps out of reach. This is a bounded house call, not a new combat encounter." CR>)>
    <RTRUE>>

<ROUTINE MAIL-WEST-PROJECT ()
    <MAIL-ENSURE>
    <COND (<NOT <0? <MAIL-GET ,MS-VISITOR-ACTIVE>>>
           <TELL " A visitor is waiting beside the anchored mailbox.">)>
    <COND (<OR <LOC ,MAIL-COURIER-NOTICE> <LOC ,MAIL-SURVEYOR-NOTICE>>
           <TELL " A missed-visit record exists as a real piece of mail.">)>
    <COND (<NOT <0? <MAIL-NEXT-UNDELIVERED>>>
           <TELL " Additional authored correspondence remains queued, but only one physical item is delivered at a time.">)>
    <CRLF>
    <RTRUE>>

<ROUTINE MAIL-WEST-ENTER ()
    <MAIL-ENSURE>
    <MAIL-DERIVE-QUEUE>
    <MAIL-DELIVER-NEXT>
    <MAIL-VISITOR-ARRIVE>
    <RFALSE>>

<ROUTINE MAIL-ACTION-HOOK ()
    <COND (<AND <VERB? EXAMINE LOOK-INSIDE SEARCH>
                <EQUAL? ,PRSO ,MAILBOX>>
           <MAIL-PUT ,MS-EVENT-MAILBOX T>
           <RFALSE>)>
    <RFALSE>>

<ROUTINE MAIL-ADVANCE ()
    <COND (<SHADOW-NON-TURN-COMMAND?> <RFALSE>)>
    <MAIL-ENSURE>
    <MAIL-DERIVE-QUEUE>
    <MAIL-DELIVER-NEXT>
    <MAIL-VISITOR-ARRIVE>
    <RFALSE>>

<ROUTINE MAIL-ENSURE ()
    <COND (<NOT <EQUAL? <MAIL-GET ,MS-VERSION> ,MAIL-SCHEMA>>
           <MAIL-PUT ,MS-VERSION ,MAIL-SCHEMA>
           <COND (<LOC ,MAIL-CELLAR-NOTE>
                  <MAIL-SET-BIT ,MS-DELIVERED ,MAIL-BIT-CELLAR>)>
           <COND (<LOC ,MAIL-MUSEUM-NOTE>
                  <MAIL-SET-BIT ,MS-DELIVERED ,MAIL-BIT-MUSEUM>)>
           <COND (<LOC ,MAIL-DAM-NOTE>
                  <MAIL-SET-BIT ,MS-DELIVERED ,MAIL-BIT-DAM>)>
           <COND (<LOC ,MAIL-COURIER-NOTICE>
                  <MAIL-SET-BIT ,MS-VISITOR-MISSED ,MAIL-VISITOR-COURIER>)>
           <COND (<LOC ,MAIL-SURVEYOR-NOTICE>
                  <MAIL-SET-BIT ,MS-VISITOR-MISSED ,MAIL-VISITOR-SURVEYOR>)>)>
    <RFALSE>>

<ROUTINE MAIL-RECAP ("AUX" (SEEN <>))
    <COND (<MAIL-GET ,MS-EVENT-QUEUE>
           <SET SEEN T>
           <TELL "- Meaningful house and expedition events queued a small deterministic set of authored correspondence." CR>)>
    <COND (<MAIL-GET ,MS-EVENT-PROVENANCE>
           <SET SEEN T>
           <TELL "- Physical letters and visit records retained sender, trigger, authenticity, delivery location, and filing codes." CR>)>
    <COND (<MAIL-GET ,MS-EVENT-MAILBOX>
           <SET SEEN T>
           <TELL "- The canonical mailbox and original leaflet remained authoritative while unique mail moved through the real object tree." CR>)>
    <COND (<MAIL-GET ,MS-EVENT-REPLY>
           <SET SEEN T>
           <TELL "- You used a bounded fixed-text reply card rather than a free-form correspondence system." CR>)>
    <COND (<MAIL-GET ,MS-EVENT-VISITOR>
           <SET SEEN T>
           <TELL "- Courier and surveyor visits allowed answer, refusal, return, and exterior acceptance without opening the canonical boarded door." CR>)>
    <COND (<MAIL-GET ,MS-EVENT-MISSED>
           <SET SEEN T>
           <TELL "- Missed visits left unique physical notices and a bounded revisit opportunity." CR>)>
    <COND (.SEEN <RTRUE>)>
    <RFALSE>>
