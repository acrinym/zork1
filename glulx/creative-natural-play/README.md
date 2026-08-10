# Creative Natural Play — Release 1245

This branch deliberately plays the enlarged Zork as a player rather than designing another standalone feature train.

The observation pass starts from merged Release 1244 and combines old and new mechanics in ways their original release qualifications did not necessarily combine: House fixtures and food, rest, correspondence, troll combat and absurd alternates, museum ecology, Dam fishing, Mara travel and House history, and odd parser experiments.

The rule is simple: **observe first, fix only demonstrated failures, then replay.**

No test-only setup verb is added to production. No generic QA framework is introduced. The transcripts are ordinary Glulxe sessions beginning at West of House.

## Mara hostile-interaction repairs

Natural play found two genuine character-integration gaps.

### Physical restraint

Vanilla Zork routes `TIE UP <actor> WITH <tool>` through generic actor-tying prose that hard-codes a masculine pronoun. Mara now owns both natural forms:

- `TIE UP MARA WITH ROPE`
- `TIE MARA WITH ROPE`

The first attempt records durable restraint history, lowers the already-existing hidden trust/respect state once, and ends automatic following. Repeated attempts remember the prior boundary instead of farming more relationship-state damage. No approval meter is exposed.

The final qualification obtains the real canonical rope from the lit Attic before attempting either command. The old `struggles and you cannot tie him up` path must not appear.

### Combat orders

Mara remains an independent expedition partner rather than a controllable combat unit. The player may type the exact natural command:

`SEND MARA AFTER TROLL WITH AXE`

The legacy parser cannot represent that three-noun surface directly, so Release 1245 recognizes the natural command before ordinary two-object syntax resolution and routes the order into Mara's categorical refusal. Addressed actor combat commands such as `MARA, ATTACK TROLL WITH AXE` reach the same remembered boundary.

The final exact-hostile lap does not use a synthetic target. It:

1. takes the real lantern and canonical Attic rope;
2. tricks the real troll;
3. binds that living troll with the real rope;
4. takes the troll's real axe;
5. earns Mara's Dam survey history;
6. physically brings Mara back to the Troll Room;
7. verifies that Mara distinguishes the securely bound troll from an alert killing-ground threat;
8. types `SEND MARA AFTER TROLL WITH AXE`, `SEND MARA AFTER TROLL`, and `MARA, ATTACK TROLL WITH AXE`.

Mara witnesses the bound-troll consequence once and remembers it. The bound troll's object handler no longer swallows an order whose subject is Mara.

## Other Release 1245 natural-play repairs

This same release also retains the earlier demonstrated fixes for ordinary Kitchen `COOK` language, parser-typeable `cast iron range` wording, actor-carried noun scope, truthful repeated Mara pack commands, and the House-threshold Glulx control-glyph regression.

## Locked artifact

- file: `zork1-glulx-creative-natural-play.ulx`
- serial: `260810`
- Glulx version: `0x00030103`
- size: `388352` bytes
- checksum: `0x522a9f0b`
- SHA-256: `483efb2b777cea3df0863382f3c145585fbd223f8d1f05f5a2e3194f54acef48`

## Boundaries

No generic companion combat AI, combat-command framework, actor inventory framework, approval meter, dating simulator, copied troll, copied axe, copied rope, generic cooking engine, test-only production verb, audit hierarchy, TODO, stub, or no-op architecture is introduced.

This train remains intentionally unmerged until Justin gives a later merge whistle.
