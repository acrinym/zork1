# Release 1244 — Mara House Company

Release 1244 carries Mara Tallow beyond her first Dam chapter and lets the relationship accumulate real history inside the existing extended Zork world.

## Player-facing chapter

After completing the joint Dam survey, the adventurer can physically bring Mara through the old passages toward the white House.

The original game correctly fights that plan at the Cellar: after the first descent, the canonical trap door has crashed shut and been barred from above. Release 1244 preserves that canonical solo behavior.

The earned two-person exception is physical rather than magical. With Mara present after the Dam survey, the player can use `UNBAR TRAP DOOR WITH MARA`. Mara threads her own measured survey rope through the seam while the adventurer lifts from below; together they draw the real upper bar. The action sets the existing trap door open and preserves its existing first-descent history. No second door or exit is created.

The House still does not automatically become Mara's home.

The player can:

- bring Mara through the real Dam → Deep Canyon → North-South Passage → Round Room → East-West Passage → Troll Room → Cellar route;
- target the existing Cellar-side threshold naturally as `TRAP DOOR`, `DOOR`, `HATCH`, or `THRESHOLD`;
- `UNBAR TRAP DOOR WITH MARA` only after the partnership has earned enough shared competence to make the two-person operation credible;
- walk up the real reopened stair into the Living Room, with Mara following physically;
- `ASK MARA ABOUT HOUSE` after she has actually crossed the threshold;
- `INVITE MARA`, which creates a concrete problem rather than an instant relationship state: her field camp still exists at the Dam;
- return physically with Mara to the Dam Base through the same world;
- use `MARA, TAKE PACK` for the one authored case where Mara retrieves her own field pack;
- carry that same pack back inside Mara's actual custody;
- show Mara the Attic through the canonical Kitchen stair and `INVITE MARA` again there;
- let Mara inspect the room and choose to set her own pack there as a temporary base;
- prepare the canonical lunch on the real Kitchen worktop;
- `SHARE LUNCH WITH MARA`, consuming the single real meal once and splitting its benefit rather than duplicating food.

The shared-meal reserve is strictly lower than the reserve from eating that same whole meal alone. This includes the minimal unwarmed prepared lunch: sharing it still clears existing strain, but half of that smallest meal leaves no extra exertion reserve.

If the player immediately tries `SHARE LUNCH WITH MARA` again, the ordinary parser reports that there is no lunch present. The one physical meal has already been eaten and is no longer in scope.

## Why this matters

The relationship now contains events that have physical cost and history:

- a joint dangerous Dam operation;
- a completed field record;
- a second two-person operation that solves a canonical physical obstruction rather than deleting it;
- a round trip between two real bases;
- exact custody of Mara's camp;
- a residence decision made by consent;
- one meal that cannot be repeated because the food is gone.

Mara's later House, company, and intimacy dialogue reads those events directly. No exposed affection score exists.

## Preserved boundaries

Release 1244 does not create:

- a second trap door or alternate Cellar exit;
- a general trap-door unlocking power for Mara;
- a generic housing system;
- a party inventory;
- a follower/pathfinding framework;
- a companion approval meter;
- a romance reward;
- free food or duplicated equipment;
- teleportation of Mara or her belongings.

A solo adventurer encountering the barred trap door still gets canonical Zork behavior. The authored exception exists only because Mara is physically present, the Dam partnership already happened, and two people perform the work together.

The canonical Dam, troll, House, Kitchen, cuisine, museum, fishing, and ordinary solo-game behavior remain authoritative.

## Locked candidate artifact

The fully qualified Release 1244 candidate is locked to:

- file: `zork1-glulx-mara-house-company.ulx`
- serial: `260810`
- size: `386560` bytes
- checksum: `0x098863ac`
- SHA-256: `e02b4b7c5809179d11a326987dc9f6cdcf94f2aa7aa3709763b6f7cfcb7e1e1d`
- Glulx version: `0x00030103`

The release remains a branch/PR candidate until explicitly merged.
