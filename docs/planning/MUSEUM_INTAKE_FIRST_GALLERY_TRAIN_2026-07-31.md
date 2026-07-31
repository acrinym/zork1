# Museum Intake and First Gallery — Release 1233

**Repository:** `acrinym/zork1`  
**Base:** Release 1232 merge `ce5be325a0d0f762edaa23362e5227d4788953d6`  
**Branch:** `agent/museum-intake-first-gallery-20260731`  
**Date:** July 31, 2026

## Product seam

The existing Living Room museum already owns physical displays, accepted-object rules, category groupings, active-field warnings, trophy scoring, theft consequences, and save/restore persistence. Release 1233 begins with the missing player action: getting a real object into the right display without learning the internal surface taxonomy.

`EXHIBIT OBJECT` chooses a canonical destination and then delegates the actual action:

| Object family | Existing destination | Existing authority retained |
|---|---|---|
| valuable treasure | trophy case | canonical scoring and treasure custody |
| painting or map | deep frame | museum frame rules |
| weapon | weapon wall | weapon display rules |
| book, document, or record | record shelf | record display rules |
| tool, ritual material, or other accepted relic | relic stand | relic display rules |

Unsupported objects are passed through the existing relic-stand refusal path rather than receiving a parallel acceptance system.

## State boundary

Release 1233 adds no collection global, table, registry, duplicate object, or remote inventory. The actual object location is the collection record. Existing `PUT` and `PUT-ON` behavior remains responsible for the physical outcome.

## First-gallery view

`CATALOG MUSEUM` and `REVIEW MUSEUM` invoke the existing `MUSEUM-PROJECT` view, which reads the real surfaces and earned groupings.

## Product boundaries

- no permanent-donation fiction before physical intake qualifies;
- no reassignment of the existing `DONATE` synonym from `GIVE` in this opening pass;
- no encyclopedia text for objects the player has not displayed;
- no duplicate treasures or trophy-score bypass;
- no automatic remote transfer;
- no House hierarchy reopening;
- no S.T.A.L.K.E.R. coupling;
- no registry/tooling/audit framework.

## Next gates

The current code and six direct tests are committed. The next work on this PR is concrete product qualification: corpus-qualify the one new refusal line, run hosted ZILF/Glazer/Glulxe intake behavior, fix actual review findings, lock Release 1233, and merge only when the physical routes reproduce.
