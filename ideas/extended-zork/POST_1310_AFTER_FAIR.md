# After the Flathead Fair — complete next organs

**Captured:** September 7, 2026  
**Status:** concept and sequencing. Not merge authorization.  
**Live rule:** Highly Extended only. Writable repo `acrinym/zork1`. Fair is Release **1310**, merged through PR #101 (`20dab719f253c682f6ca7dd48e6400e61c89a246`); current capstone closure is `1903437d5591b48f27bd362c5c6b7ed78884b742`.

1310 is now identity-locked and merged. Do not treat completion/catalog work as merge authorization. Do not stack the fair on 1307/1309.

Each item below is a **whole player-facing organ** (implementation, parser-honest play, hosted qualify, docs, capstone). Not a slice, not an MVP.

## Already-trained, still independent of 1310

1. **Time, weather, and disaster (1307)** — `.beads/cursor_zork_time_weather_disaster.beadtrain`  
   Authored conditions on real rooms (house ring, forest, dam, canyon, underground). Fair-local 9-phase clock and authored wheel-wind stay fair-owned until 1307 exists; then one public day, no second climate engine.

2. **Adventurer body and wardrobe (1309)** — `.beads/cursor_zork_adventurer_body_wardrobe.beadtrain`  
   Worn clothes as objects with weight, wetness, and social consequence. Not a dress-up GUI.

Open PRs for those trains must re-lock on their own hosted identity. They are not Fair blockers and Fair is not their base.

## Whole organs to train next (unnumbered)

3. **Storybook / CYOA presentation edition** — `POST_1306_TEXT_ONLY_FUTURE_ORGANS_2026-09-04.md` §1  
   Numbered obvious affordances execute the same parser. Default `master` stays a blank prompt. Side edition or an off-switchable mode. No Twine export as the product.

4. **Last Honest Recap** — same catalog §2  
   A physical sheet or Mara notebook of witnessed facts. `READ SHEET`, not a quest log.

5. **Echo and rumor as rooms** — same catalog §3  
   Named speakers, named rooms. No gossip engine.

6. **Night in the House as parser time** — same catalog §4  
   Couples with 1307 rather than inventing a second clock. One public day.

7. **West-of-house noun honesty / forest answers** — existing trains `cursor_zork_west_of_house_nouns` and `cursor_zork_forest_answers_back` if still open; finish those as whole parser-world contracts, not new geography dumps.

8. **Mara's Fair stuffed-animal keepsake and the Adventurer's proper name**  
   A stuffed animal is a real physical Fair object. Mara may win one through an authored Fair path, and/or the Adventurer may win or acquire one and offer it with `GIVE STUFFED ANIMAL TO MARA`. If it enters Mara's custody, it is hers; acceptance, refusal, later storage, and any relationship meaning must come from authored context. No generic gift economy or approval meter.  
   The Adventurer should no longer be permanently nameless. This pass records the requirement only: the naming source and exact name remain unresolved, so no name is hard-coded yet. Zork remains the parser/interface, ordinary narration remains second-person, and Mara addresses the Adventurer, not Zork.

## Hard boundary

No GUI. No scenery engine. No DATE MODE. No historicalsource mutations. Canonical puzzles remain the authority.
