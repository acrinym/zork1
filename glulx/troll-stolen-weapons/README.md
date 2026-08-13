# Release 1254 — Troll Disarm & Stolen Weapons

Release 1254 deepens the canonical Troll Room fight without replacing its combat engine.

- A weapon lost to the troll can become his actual physical possession instead of automatically landing on the floor.
- The troll prefers a captured player weapon while he has it, so subsequent combat can turn the same sword or knife back on its owner.
- The captured object remains the one canonical object: no duplicate weapon, ownership token, or shadow inventory exists.
- Disarming the troll can knock the captured weapon loose; unconsciousness or death also drops real held weapons.
- Trying to take a captured weapon directly is blocked by the troll's existing physical weapon-custody behavior.
- Food can be traded for the exact captured weapon, but the bargain does not pacify the troll or open the exits.
- Examine, listen, and greeting responses acknowledge the theft so the consequence stays visible.

Canonical `VILLAIN-BLOW`, `HERO-BLOW`, troll strength, axe recovery, unconsciousness, death, and exit gating remain authoritative. No generic NPC inventory framework, duplicate weapons, hidden hostility meter, ownership meter, or random theft outside authored combat loss.
