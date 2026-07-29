# House Correspondence and Visitors — Release 1223 Contract

## Authority

Train: `onyx_zork_house_correspondence_visitors`

Qualified artifact:

- Release `1223` / serial `260724`;
- 271,872 bytes;
- checksum `0x4cbcc561`;
- SHA-256 `362b5567e2ee705dc382256fe3420b9e729486acbcdf68b91a8ccdda0c893816`.

Exact base: Release `1222` SHA-256 `1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912`.

## Message contract

| Trigger | Physical message | Provenance | Bounded result |
|---|---|---|---|
| Cellar threshold intrusion receipt | gray threshold warning | West of House Mutual Assurance Society; signed; `HOUSE-THRESHOLD-01` | fixed response requests an exterior threshold survey |
| Living Room display theft | cream appraisal warning | unnamed appraiser; unsigned/plausible; `HOUSE-DISPLAY-02` | fixed response requests a signed collection receipt |
| repaired Flood Control Dam #3 | blue maintenance acknowledgment | official maintenance office; stamped; `FCD3-MAINT-03` | fixed response requests a stamped maintenance receipt |

Queue order is deterministic: Cellar, museum, dam. Each trigger queues one exact object at most once. Only one new authored letter is delivered to the canonical mailbox at a time.

## Canonical mailbox contract

- `MAILBOX` remains the original anchored container at West of House.
- `ADVERTISEMENT` remains the original leaflet.
- New correspondence enters the ordinary object tree.
- No parallel inbox or hidden mail inventory exists.
- Removed, burned, or otherwise destroyed correspondence is not regenerated.
- The mailbox awards no new score.

## Reply contract

- A letter must be read before it can receive a response.
- `RESPOND TO <LETTER>` prepares one authored fixed-text response.
- Exactly one reusable physical stamped card exists.
- The valid posting command is `PUT STAMPED CARD IN MAILBOX`.
- Posting consumes that exact card into the mailbox's locked outgoing compartment; it does not leave or clone a copy.
- There is no free-form writing or arbitrary recipient selection.

## Visitor contract

| Visitor | Trigger | Engagement | Acceptance record |
|---|---|---|---|
| threshold surveyor | threshold reply or dam acknowledgment context | ordinary `TELL SURVEYOR`; bounded `REFUSE SURVEYOR` or `ADMIT SURVEYOR` | numbered survey tag |
| uniformed courier | museum or dam reply context | ordinary `TELL COURIER`; bounded `REFUSE COURIER` or `ADMIT COURIER` | signed courier receipt |

`ADMIT` does not open the canonical boarded front door. It means a doorstep exchange or exterior inspection only.

## Missed and return behavior

- A visitor is not created during the same command that posts a response.
- A visitor is not created while the player is leaving West of House.
- If the player is absent, one unique missed-visit notice is placed in the canonical mailbox.
- Refusal also leaves one physical notice and permits one bounded return.
- After the second refusal or accepted visit, that visitor is complete and cannot be farmed.

## Persistent state

One mutable packed table records:

- queued, delivered, read, replied, and sent letter bits;
- current reply target;
- queued, active, missed, refused, and completed visitor bits;
- event receipts;
- last delivery identity.

The table is addressed through a constant symbol to avoid consuming another Glulx global pointer while remaining in native save memory.

Native `SAVE` and `RESTORE` preserve the table and all physical object custody. Deliberate corruption removes the three live triggers before asserting a zero queue, then restore must recover the exact final state without a repair pass.

## Attic inputs

Train 6 may consume these stable fields as archive inputs:

- message identity;
- sender/source;
- triggering event;
- delivery location;
- authenticity/truth status;
- filing code;
- read/replied/sent status;
- missed/refused/completed visit status;
- physical notice, receipt, or tag identity.

The Attic must index these records without moving, recreating, or repairing live correspondence state.

## Explicit exclusions

No free-form composition, open-ended dialogue, generic scheduler, duplicate or regenerated mail, automatic door opening, fabricated route, unlimited visits, visitor combat, parallel score, automatic puzzle completion, or premature archive implementation.
