# Release 1280 — Extended Globals / Compiler State Scaling

**Queued after:** Release 1279 — Future-Proof Runtime Contract  
**Status:** planned product train

## Purpose

Remove the legacy global-variable budget as a practical blocker for future Highly Extended Zork development while preserving clear state ownership and ordinary ZIL authoring.

This release is not permission to accumulate bad state. Redundant state should still be eliminated and coherent state should still be grouped honestly. The product outcome is that legitimate new world state no longer requires constant manual global-budget triage.

## Existing foundation

The current line already uses constant-address mutable tables for several modern subsystems, and the active semantic-compression work has identified multiple legacy-global families that can be represented more honestly.

ZILF also contains soft-global machinery capable of moving overflow state into table-backed storage. Release 1280 turns that latent capability into an intentionally supported Glulx authoring path for HOE.

## Product work

1. Finish or incorporate the approved semantic compression required to remove redundant/poorly grouped legacy state before scaling outward.
2. Build explicit compiler fixtures that exceed the traditional hard-global budget with ordinary ZIL declarations.
3. Verify ZILF soft-global lowering under Glulx for reads, writes, initialization, increments/decrements, save/restore, undo, cross-module references, and mixed byte/word state.
4. Identify operations that require a true variable identity or otherwise force hard-global placement.
5. Improve the Glulx compiler/lowering path where necessary so ordinary source-level globals can scale substantially beyond the legacy hard-global count without authors manually rewriting every feature into ad hoc table accesses.
6. Preserve readable symbol/debug information so extended globals remain debuggable.
7. Add explicit diagnostics for genuinely unsupported indirect-variable cases rather than allowing obscure compile/runtime failure.
8. Establish a supported high-water target large enough that foreseeable HOE development is not constrained by the historical budget.

## Authoring contract

Normal code should continue to express legitimate state with clear names. The compiler/runtime representation may be:

- hard global;
- soft/table-backed global;
- byte-backed state;
- word-backed state;
- derived state eliminated at compile/design time.

Call sites should not need to know the physical representation unless variable identity is semantically required.

## Boundaries

- no packing unrelated facts merely because bits are available;
- no duplicate state authority;
- no mass conversion of existing canonical globals without proof of equivalence;
- no custom HOE-only Glulx VM requirement if compiler lowering can solve the problem;
- no arbitrary fixed 'new limit' chosen without stress qualification;
- no global-count audit framework as the release product.

## Success criteria

Release 1280 succeeds when:

1. a story materially exceeding the historical hard-global budget compiles and runs correctly through the supported HOE Glulx toolchain;
2. ordinary source-level reads/writes behave identically regardless of hard/soft placement where semantics permit;
3. save/restore and undo preserve extended state correctly;
4. unsupported hard-global-only patterns fail clearly and are narrowly characterized;
5. production HOE can add substantial legitimate future state without manual global-budget gymnastics;
6. compiler changes, if required, remain general Glulx/ZILF improvements rather than story-specific hacks.
