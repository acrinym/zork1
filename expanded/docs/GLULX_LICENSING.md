# Glulx and upstream Zork licensing

This document records the licensing boundary for the planned Glulx migration. It is an engineering and release-planning record, not legal advice.

## Executive conclusion

The migration has a permissive software path:

- the Zork I source in this repository is MIT licensed;
- Tara McGrew's `taradinoc/zork1` Glulx branch carries the same MIT `LICENSE` file;
- the IF Archive describes Tara's released `zork1-glulx.zip` as released under the same MIT license as the original source;
- the Glulxe reference interpreter is MIT licensed;
- the Glulx virtual machine may be independently implemented.

The important separation is that the **Glulx specification document** is licensed differently from implementations of the VM, and the Zork source-code release does **not** grant trademark or branding rights.

## Component matrix

| Component | Confirmed status | Project consequence |
|---|---|---|
| Zork I source in `acrinym/zork1` | MIT License, copyright Microsoft (2025) | May be used, modified, merged, published, distributed, sublicensed, and sold subject to retaining the copyright and permission notice in copies or substantial portions |
| `taradinoc/zork1` branch `glulx` | Same MIT `LICENSE` file as the upstream Zork repository | Tara's source changes may be used as the technical upstream while retaining the MIT notice |
| IF Archive `zork1-glulx.zip` | Archive entry says it is released under the same MIT license as the original source | The released `.ulx` baseline is usable for qualification and comparison under that stated license |
| Glulx VM design | The specification states that the described VM is an idea and anyone may write programs, compilers, interpreters, and debuggers for it | We may implement a compatible runtime or tooling without copying the specification text as product documentation |
| Glulx specification text, version 3.1.3 | CC BY-NC-SA 4.0 | Do not copy or adapt substantial portions of the specification into commercial documentation without satisfying that license; link to it and describe our implementation in original words |
| Glulxe reference interpreter | MIT License | May be embedded, modified, or redistributed while preserving its MIT notice |
| Zork trademarks, brands, packaging, and marketing assets | Not granted by the source-code release | Do not imply official Microsoft, Activision, Xbox, or Infocom endorsement; keep the expanded edition clearly labeled unofficial and repository-local |

## Repository policy for the migration

1. Preserve the repository-root `LICENSE` unchanged.
2. Keep notices from Tara's branch and any incorporated upstream components.
3. Record the exact upstream repository, branch, commit, and imported paths in a provenance manifest before copying code.
4. Keep story-derived ZIL and Glulx-port source under the inherited MIT notice for clarity.
5. Keep any separately developed runtime, UI, service, artwork, sound, and documentation components in clearly separated directories with their own explicit licenses.
6. Do not copy specification prose into project documentation. Link to the specification and write implementation notes independently.
7. Avoid official-looking Zork product branding. Describe artifacts as unofficial builds based on the MIT-licensed source unless separate branding permission is obtained.
8. Re-run a dependency and asset license audit before any public binary bundle or commercial release.

## Required attribution and provenance record

The Glulx train must add a machine-readable or Markdown provenance record containing at least:

- original source: `historicalsource/zork1` or its exact Microsoft-released upstream lineage;
- local repository and base commit;
- Tara upstream: `taradinoc/zork1`, branch `glulx`, exact commit;
- ZILF version and commit;
- Glazer version and commit;
- Glulxe or other interpreter version and commit used in CI;
- license file paths and checksums where practical;
- imported files and local modifications.

## Sources checked on 2026-07-19

- Local Zork I MIT license: [`../../LICENSE`](../../LICENSE)
- Tara's Glulx branch: <https://github.com/taradinoc/zork1/tree/glulx>
- Tara branch license: <https://github.com/taradinoc/zork1/blob/glulx/LICENSE>
- Tara's Zork I Glulx announcement and source comparison: <https://intfiction.org/t/zork-i-for-glulx/78103>
- IF Archive Glulx index entry for `zork1-glulx.zip`: <https://ifarchive.org/indexes/if-archive/games/glulx/>
- Glulx specification 3.1.3 and its license notice: <https://eblong.com/zarf/glulx/Glulx-Spec.html>
- Glulxe reference interpreter and MIT license: <https://github.com/erkyrath/glulxe>
- Microsoft source-release branding boundary: <https://opensource.microsoft.com/blog/2025/11/20/preserving-code-that-shaped-generations-zork-i-ii-and-iii-go-open-source/>

## Release gate

No Glulx artifact should be presented as release-ready until its provenance manifest exists, all inherited notices are bundled where required, and product naming has passed a separate trademark/branding review.
