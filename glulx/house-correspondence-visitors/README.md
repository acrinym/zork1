# Glulx Release 1223 — House Correspondence and Visitors

## Status

Qualified House of Records Train 5 implementation above exact House Cellar Threshold Release `1222`.

Train:

`onyx_zork_house_correspondence_visitors`

Current capstone-candidate state is seven closed implementation/qualification beads and one open capstone bead. The House of Records roadmap contains 39 closed beads and 57 open beads. No sub-beads, sub-trains, or parallel planning hierarchy exist.

## Locked identity

- edition: Unofficial House Correspondence and Visitors Glulx;
- release: `1223`;
- serial: `260724`;
- output: `zork1-glulx-house-correspondence-visitors.ulx`;
- Glulx version: `3.1.3` / `0x00030103`;
- size: `271,872` bytes;
- checksum: `0x4cbcc561`;
- SHA-256: `362b5567e2ee705dc382256fe3420b9e729486acbcdf68b91a8ccdda0c893816`.

Exact base Release `1222` SHA-256:

`1635579aed9c3b5ea66548a8120560d4199559c232aa6f35aa40c48352652912`

## Exact production delta

Release `1223` changes exactly:

- `1actions.zil`;
- `assistance.zil`;
- new `house_correspondence_visitors.zil`;
- `shadow_logic.zil`;
- `zork1.zil`.

The stager rejects every other production change. Test-only setup, reporting, cause removal, mutation, and restore controls never enter production.

## Product boundary

The canonical West of House, anchored mailbox, original leaflet, boarded front door, exits, and score remain authoritative.

Release `1223` adds:

- three unique authored letters, triggered by real Cellar intrusion, museum theft, and repaired-dam state;
- sender/source, trigger, delivery location, authenticity, and stable filing codes;
- one reusable physical stamped reply card with fixed authored responses;
- a uniformed courier and a threshold surveyor as bounded exterior visitors;
- unique missed-visit notices;
- one signed courier receipt and one numbered survey tag;
- one bounded return after absence or refusal;
- compact `RECAP` receipts;
- native save, deliberate corruption, and exact restore.

The boarded front door never opens. `ADMIT` means a doorstep exchange or exterior inspection, not entry into the house.

## Parser truth

- `RESPOND TO <LETTER>` is used because canonical parsing claims `REPLY` first.
- The physical reply object is posted as `PUT STAMPED CARD IN MAILBOX`; `REPLY CARD` is not a valid noun phrase because `REPLY` is a verb token.
- Parsed card dispatch runs through the shared mail action hook rather than relying on indirect-container callback order.
- Ordinary `TELL SURVEYOR` or `TELL COURIER` engages a present visitor.
- The visitor object explicitly routes bounded `ADMIT` and `REFUSE` actions instead of swallowing them.
- Visitor arrival defers while posting or departing West of House, allowing a real missed notice before one bounded return.
- Qualification proves the original leaflet through canonical mailbox custody rather than moving it merely for a test.

## Persistent state

The queue, delivery/read/reply/send bits, visitor state, missed/refused/completed state, event receipts, and last-delivery identity live in one mutable packed table addressed through a constant symbol. This avoids consuming another global pointer while remaining native-save persistent.

## Qualification

The permanent pinned route proves:

1. exact Release `1222` base identity;
2. exact five-path production staging;
3. exact Release `1223` size, checksum, and SHA-256;
4. deterministic Cellar → museum → dam delivery order;
5. unique physical letters and no regeneration or duplicates;
6. canonical mailbox and original-leaflet preservation;
7. complete message provenance;
8. one exact fixed-text stamped reply card;
9. real missed notices and one bounded return;
10. ordinary visitor conversation, refusal, and exterior acceptance;
11. unique receipt and survey tag;
12. live-trigger removal during deliberate corruption;
13. exact queue, object custody, notices, records, and visitor completion through native `SAVE` and `RESTORE`;
14. production/test isolation.

## Important corrections retained

- The first compile was one global over the Glulx ZIL limit. The packed state table became constant-addressed instead of removing behavior.
- Nonportable complement-based bit clearing was replaced with subtraction of known-present power-of-two bits.
- Reply and visitor commands were aligned with the canonical parser rather than adding test-only shortcuts.
- Posting now dispatches before canonical `PUT` can move a sent card back into the mailbox.
- Deliberate mutation removes all three live correspondence triggers before asserting zero; otherwise the system correctly re-queues mail.

## Explicit exclusions

No free-form composition, open-ended dialogue, generic message/NPC scheduler, duplicate or regenerated mail, parallel mailbox inventory, automatic front-door opening, fabricated route, unlimited visitors, visitor combat, premature Attic archive, parallel score, or automatic puzzle completion.

## Next existing train

After capstone closure:

`onyx_zork_attic_archive_core`

Train 6 must execute its eight existing beads directly above the exact qualified Release `1223` closure head.
