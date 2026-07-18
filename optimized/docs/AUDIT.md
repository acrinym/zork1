# Code, Behavior, and Build Audit

## Scope

This audit covers the repository’s Release 119 / serial 880429 final-development snapshot, its historical build records, and the isolated project-local Release 120 optimized edition. It does not assume Release 119 is identical to the commonly distributed Release 88.

## Confirmed findings

### 1. Historical and generated material are mixed at the repository root

Source, compiler records, frequency data, intermediate output, and compiled story files sit together. A modern build could easily overwrite historical evidence.

**Treatment:** optimized staging and generated output are confined to `optimized/build`. The repository-root files are verified and copied, never edited in place.

### 2. Include casing is not portable

The historical entrypoint requests uppercase include names while the repository files are lowercase. Case-sensitive environments are not required to resolve those names as the same files.

**Treatment:** the isolated overlay uses the exact lowercase filenames. Game logic is unchanged.

### 3. Historical inputs lacked a reproducible receipt

Without integrity checks, a build can accidentally combine files from different revisions.

**Treatment:** `source-manifest.json` records the source commit and Git blob identity of every staged input. Staging stops on drift and writes a receipt listing every override and exact patch.

### 4. Generic `PUT` permits recursive containment

`V-PUT` checks direct self-containment and duplicate placement, then calls `MOVE`. It did not determine whether the destination was already below the moved object in the parent chain. A successful cyclic move violates the object-tree invariant and can make objects disappear from normal traversal.

**Treatment:** `Z1-BUG-001` adds an ancestry guard without changing legitimate nesting, capacity, weight, scoring, parser behavior, or prose beyond reusing the existing impossible-action response.

**Proof:** exact patch application, structural validation, full compilation, valid Release 120 story, and passing opening smoke. A dedicated containment transcript remains pending.

### 5. Candle state and candle description disagree

The candle routine clears `ONBIT`, but the object’s static first-description always says the candles are burning.

**Treatment:** `Z1-BUG-002` adds a state-aware description callback. It preserves the original sentence while lit and removes only `burning` while extinguished.

**Proof:** exact patch application, structural validation, full compilation, valid Release 120 story, and passing opening smoke. A dedicated temple transcript remains pending.

### 6. Two printed tab characters are unsafe for Z-machine version 3

Modern ZILF identified literal tabs in the Flood Control Dam guidebook heading and All-Purpose Gunk label. Version 3 cannot reliably encode them as printed ZSCII characters.

**Treatment:** `Z1-PORT-001` replaces those two characters with spaces while preserving the words.

**Proof:** the exact replacements apply once, and CI fails if modern ZILF emits the corresponding `ZIL0410` warning. The validated build passes.

### 7. The compiler report’s unused symbols are not safe deletion targets

The historical report names `UNTIE-FROM`, `BREATHE`, `CYCLOPS-MELEE`, `TROLL-MELEE`, `P-DIRECTION`, `DEF2A`, `DEF3C`, and `THIEF-MELEE` as unused. In this source family, unused can mean dormant, conditional, generated, compatibility-oriented, or genuinely dead.

**Treatment:** report, do not delete. Each symbol requires call-site, build-size, and behavior evidence.

### 8. Duplicate globals are composition seams, not automatic defects

The structural audit finds duplicate definitions of `LUCKY` and `WON-FLAG` across generic and game-specific source layers. The entrypoint enables redefinition, and modern ZILF builds the complete game successfully.

**Treatment:** retain them as visible warnings. Do not delete or suppress them until their exact generic-versus-game-specific role is proven.

### 9. The clock scheduler has a fixed implicit capacity

`C-TABLELEN` is 180 words and each entry is 6 words, yielding 30 interrupt slots. Allocation works backward through the table and has no obvious player-facing diagnostic for exhaustion.

**Treatment:** report the capacity. Do not increase it without a reachable exhaustion case and memory-layout analysis.

### 10. Global state and magic values are part of the original architecture

The parser, action dispatcher, object model, clock, and world logic communicate through globals, bit flags, table offsets, and numeric return conventions. Replacing this architecture wholesale would create a new engine instead of optimizing Zork I.

**Treatment:** surround the architecture with receipts, names, reports, and regression tests rather than translating it into a different design.

### 11. Exact transcript comparison is unsafe for every route

Combat, random messages, timed events, and thief behavior can vary. Interpreter banners and formatting also differ.

**Treatment:** deterministic routes assert meaningful fragments. Randomized systems need state-aware or bounded tests rather than globally normalized transcripts that could conceal regressions.

## Validated build

The pinned modern toolchain successfully produced and ran the optimized edition:

- ZILF/ZAPF 1.9 from commit `d3b79f348b692647ab7ee3b13e5ac7c99b70f471`
- Z-machine version 3
- Release 120 / serial 260718
- 87,012 bytes
- valid checksum 41,234
- Frotz opening route passed

The original Release 119 / serial 880429 story also passes independent header, length, address, and checksum verification.

## Deliberately not changed

- parser grammar and object resolution;
- puzzle requirements and room graph;
- object starting locations, weights, capacities, and treasure values;
- scoring and maximum score;
- thief, troll, cyclops, and combat behavior;
- clock timing and randomness;
- historical root files;
- classic prose except state-correcting removal of `burning` and replacement of two nonportable tab characters with spaces.

## Next evidence-driven investigations

1. targeted recursive-container transcript and post-rejection save/restore checks;
2. lit-versus-extinguished candle transcript in South Temple;
3. Release 88 versus Release 119 behavior map;
4. reachable clock-slot pressure analysis;
5. call-site and conditional-build classification of historical unused symbols;
6. parser pronoun state across nested `PERFORM` calls.
