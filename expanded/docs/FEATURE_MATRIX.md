# Zork I project-edition feature matrix

## Edition and format status

| Edition | Format | Identity | Status |
|---|---|---:|---|
| Historical | `.z3` | Release 119 / `880429` | Preserved and verified |
| Optimized | `.z3` | Release 120 / `260718` | Qualified |
| Expanded | `.z3` | Release 121 / `260719` | Qualified reactive world, assistance, alternate characters, and misconduct |
| Absurd Alternate | `.z3` | Release 122 / `260720` | Qualified earned troll-restraint and nest-fire outcomes |
| Unchanged upstream Glulx | `.ulx` | Release 1 / `251203` | Qualified against Tara McGrew's exact source and archived reference |
| Unofficial Optimized Glulx | `.ulx` | Release 1201 / `260719` | Qualified conservative corrections and native regressions |
| Unofficial Assisted Glulx | `.ulx` | Release 1211 / `260719` | Qualified action hooks and assistance parity |
| Unofficial Reactive Surface Glulx | `.ulx` | Release 1212 / `260719` | Qualified proximity-safe white-house surface reactions |
| Deeper Reactive Glulx | `.ulx` | not assigned | Dam, ritual, and object feedback remains the next Glulx layer |
| Absurd Alternate Glulx | `.ulx` | not assigned | Release 122 parity remains a later isolated layer |

## Release 121 interaction foundation

| Area | Expanded behavior | Canonical behavior retained |
|---|---|---|
| Player orientation | `GOALS`, `EXITS`, tiered `HINT`, `RECAP`, `WHY`, and `USE <object>` | Traditional parser play remains available; assistance is optional |
| White house | Repeated knocking, listening, roof-climb explanation, structural responses | Original entry route, navigation, and proximity rules |
| Boards and windows | Tool-sensitive scarring, painted splinter, sound and visibility responses | Boards remain secured; kitchen-window traversal remains canonical |
| Mailbox | Hidden maintenance slip after leaflet removal | Original leaflet and mailbox sequence |
| Forest songbird | Followable trail, Hidden Glade, brass feather, remembered discovery | Original forest graph and egg/canary puzzle |
| Troll | Genuine-treasure bribe as a noncombat route | Original combat, disarming, gifts, and weapons |
| Cyclops | Repeated lullaby route and richer feedback | Original pepper/water and Odysseus solutions |
| Thief | One-time bargain consuming real treasure | Existing roaming, theft, combat, and treasure behavior |
| Dam and ritual | State-aware mechanism and ceremony feedback | Original dam and exorcism solutions |
| Adventurer Misconduct | Absurd physical/social actions, `FOLLY`, and one-turn troll bemusement | Canonical combat, containers, NPC roles, and scoring |

## Release 122 earned absurd outcomes

Release 122 distinguishes harmless folly from ridiculous actions that can alter the world.

### Troll restraint

- Alert `TIE UP TROLL WITH ROPE` fails.
- `TRICK TROLL` creates a one-use immediate opportunity.
- Immediate rope restraint leaves the troll alive, drops the real axe, consumes the real rope into the restraint, and opens the passages through `TROLL-FLAG`.
- `UNTIE TROLL` restores the rope and troll danger.
- Leaving instead of tying him wastes the opportunity; returning proves he attacks and rejects the rope as alert and armed.

### Burning the nest

- `PUT SACK UNDER TREE` spreads the real brown sack beneath the branch.
- `BURN NEST WITH TORCH` requires the held, lit ivory torch and the nest still in the tree.
- With preparation, the real jewel-encrusted egg lands intact in the real sack.
- Without preparation, the real egg invokes canonical `BAD-EGG`, producing the existing broken egg and broken canary values.
- Ordinary burning with another valid flame continues through canonical `V-BURN`.
- No treasure or puzzle object is duplicated.

### Explicit boundary

- The Wizard of Frobozz is not imported into Zork I; Wizard gifts, restraint, and beard ignition belong to a future Zork II train.
- Release 122 adds no room, treasure, universal actor trick, or automatic puzzle completion.
- Release 121 remains independently reproducible.

## Glulx parity reached

### Release 1211

Ports and proves the state-neutral action hook, goals, exits, three hint levels, canonical-state recap, contextual failure explanations, and object affordance guidance.

### Release 1212

Adds and proves:

- adjacent white-house and front-door reactions;
- rejection of remote house knocking, listening, and climbing;
- board and window responses;
- persistent board scarring and painted splinter;
- mailbox and maintenance-slip behavior;
- ordinary forest, tree, and songbird reactions;
- canonical `FOLLOW SONGBIRD` refusal and Hidden Glade exclusion.

Release 1212 does not yet include optional geography, deeper mechanisms, alternate NPC solutions, Adventurer Misconduct, or Release 122's earned alternates.

## Validation coverage

| Coverage | Method |
|---|---|
| Historical source identity | Git-blob manifest verification before staging |
| Release 121 | Exact staging, pinned ZILF/ZAPF build, story verification, and deterministic Frotz routes |
| Release 122 staging | Complete Release 121 stage followed by an exact five-path changed-set gate |
| Release 122 artifact | Fail-closed 107,880-byte `.z3`, checksum `0xf13d`, and SHA-256 `98320cd2c11a963b3f23c9a36782f31887279798c26958942ef48ba6ff939a28` |
| Troll alternate | Real-map rope acquisition, alert failure, trick, restraint, axe drop, passage travel, description, and recap |
| Prepared nest alternate | Test-only setup story exercises production mechanics and proves intact accessible egg and corrected prose |
| Destructive nest alternate | Canonical `BAD-EGG` produces the existing ruined egg and broken canary |
| Preservation fallbacks | Canonical non-torch nest burning and restored troll hostility after leaving and returning |
| Production/test isolation | Production source and artifact contain no qualification setup verbs or setup module |
| Glulx lineage | Separate pinned artifact and semantic-route gates for Releases 1, 1201, 1211, and 1212 |
| Beadtrain integrity | Completed trains validate against canonical and sharded issue ledgers |

## Still requiring dedicated work

- Release 122 Glulx parity;
- deeper Glulx dam, ritual, rope, mirror, water, and tool reactions;
- dedicated cyclops-lullaby and thief-bargain long routes;
- save/restore after expanded persistent-state changes;
- additional earned alternate solutions that use real objects, preparation, risk, and canonical consequences.
