# Glulx Release 1223 — House Correspondence and Visitors

## Status

House of Records Train 5 implementation is in progress above exact House Cellar Threshold Release `1222`.

Train:

`onyx_zork_house_correspondence_visitors`

No sub-beads, sub-trains, or parallel planning hierarchy are introduced.

## Product boundary

The canonical West of House, anchored mailbox, original leaflet, boarded front door, exits, and score remain authoritative.

Release `1223` adds a bounded physical correspondence system:

- three unique authored letters triggered by Cellar intrusion, display theft, and repaired-dam state;
- sender, trigger, delivery, authenticity, and future filing codes;
- one reusable fixed-text reply card;
- two exterior visitors: a courier and a threshold surveyor;
- unique missed-visit notices;
- unique accepted-visit receipt and survey tag;
- one bounded return after refusal or absence;
- native save and restore of queue, custody, replies, visits, and records.

The boarded front door never opens. Accepting a visit means conducting a bounded exchange or inspection at the exterior threshold.

## Exact base

Release `1222` SHA-256:

`1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912`

The Release `1223` artifact identity remains discovery-gated until production compilation, parser gameplay, and native persistence pass.

## Explicit exclusions

No free-form composition, open-ended dialogue, generic message/NPC scheduler, duplicate mail, regenerated destroyed mail, parallel mailbox inventory, automatic door opening, fabricated route, unbounded visitors, visitor combat, premature archive creation, parallel score, or automatic puzzle completion.
