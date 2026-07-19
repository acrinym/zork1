# Glulx and upstream Zork licensing

This document records the licensing boundary for the qualified Glulx lineage. It is an engineering and release-planning record, not legal advice.

## Executive conclusion

The story-source and interpreter path is usable with explicit license separation:

- the Zork I source in this repository is MIT licensed;
- Tara McGrew's `taradinoc/zork1` Glulx branch carries the same MIT `LICENSE` file;
- the IF Archive describes Tara's released `zork1-glulx.zip` as released under the same MIT license as the original source;
- Glulxe and CheapGlk are MIT licensed;
- ZILF is GPL-3.0-or-later;
- pinned Glazer 1.2.0 is GPL-2.0-or-later;
- the Glulx virtual machine may be independently implemented.

ZILF and Glazer are build tools. They are not embedded in the generated `.ulx` story artifacts. Any distribution of those tools or modified tool binaries must satisfy their own GPL obligations independently of the MIT-licensed story source and artifacts.

The Glulx specification document is licensed differently from implementations of the VM, and the Zork source-code release does not grant trademark or branding rights.

## Qualified component matrix

| Component | Qualified pin | License status | Project consequence |
|---|---|---|---|
| Zork I source in `acrinym/zork1` | repository-root source | MIT, copyright Microsoft (2025) | Retain the copyright and permission notice in copies or substantial portions |
| Tara Zork Glulx source | `1ada70e58ac4933446b907d67949d9cab3119c0e` | Same MIT `LICENSE` | Tara's seven-file compatibility delta may be used while retaining the MIT notice |
| IF Archive `zork1-glulx.zip` | ZIP SHA-256 `6e9879f36d7d15ddebee1333244be016a9f3a40756718292264815e8881c51ad` | Archive includes the MIT license | The archived `.ulx` is used as an independently hashed qualification reference |
| ZILF | 1.8 / `45c60f1e37651f266ac92d49ae01748bb4909fa5` | GPL-3.0-or-later | Build-only dependency; redistribution or modification of the tool must follow the GPL |
| Glazer | 1.2.0 / `1cc80bcdefb4b4125185e1170eb1ee178e97ff5a` | GPL-2.0-or-later | Build-only dependency; source tarball and license hashes are captured in CI |
| Glulxe | `56ab8743bab565de307bd892c555d8d8897ed517` | MIT | Native qualification interpreter; retain its notice if redistributed |
| CheapGlk | `14d8aaf6e4150669762bd4646a5368e75c1eeee6` | MIT | Native Glk implementation; retain its notice if redistributed |
| Glulx VM design | standard Glulx 3.1.3 target | The VM design may be independently implemented | Standard interpreters and compilers may target the VM without a proprietary runtime |
| Glulx specification text | version 3.1.3 | CC BY-NC-SA 4.0 | Do not copy or adapt substantial specification prose into commercial documentation without satisfying that license |
| Zork trademarks, brands, packaging, and marketing assets | not granted | Separate rights | Do not imply official Microsoft, Activision, Xbox, or Infocom endorsement |

## Repository policy

1. Preserve the repository-root `LICENSE` unchanged.
2. Retain notices from Tara's branch and every incorporated or redistributed upstream component.
3. Record exact repositories, commits, source archive hashes, license paths, and local modifications before qualification.
4. Keep story-derived ZIL and project Glulx-port source under the inherited MIT notice for clarity.
5. Keep compiler, assembler, interpreter, UI, service, artwork, sound, and documentation components clearly separated with their own licenses.
6. Do not copy Glulx specification prose into project documentation. Link to it and write implementation notes independently.
7. Avoid official-looking Zork product branding. Describe project artifacts as unofficial repository-local builds based on the MIT-licensed source.
8. Re-run a dependency and asset license audit before any public binary bundle or commercial release.
9. Do not assume that distributing an `.ulx` artifact also distributes or imposes the licenses of build-only compiler tools; evaluate each distributed component separately.
10. Bundle the applicable story-source MIT notice and any separately distributed interpreter notices with release packages.

## Committed provenance and receipts

The qualified lineage records:

- original Zork source lineage and repository license;
- Tara upstream repository, branch, commit, tree, merge base, and complete changed-path list;
- ZILF version and commit;
- Glazer release, commit, source URL, source SHA-256, and license-file hashes;
- Glulxe and CheapGlk commits and license-file hashes;
- archived ZIP and member checksums;
- imported or staged paths;
- exact local patches and overlays;
- whether source or generated assembly was modified;
- story artifact checksums and SHA-256 values.

Primary records:

- [`../../glulx/provenance.json`](../../glulx/provenance.json)
- [`../../glulx/QUALIFICATION.md`](../../glulx/QUALIFICATION.md)
- [`../../glulx/optimized/patch-series.json`](../../glulx/optimized/patch-series.json)
- CI-generated `LICENSE-MANIFEST.json` and `BUILD-RECEIPT.json` artifacts

## Sources checked on 2026-07-19

- Local Zork I MIT license: [`../../LICENSE`](../../LICENSE)
- Tara's Glulx source and license: <https://github.com/taradinoc/zork1/tree/glulx>
- Tara's Zork I Glulx announcement: <https://intfiction.org/t/zork-i-for-glulx/78103>
- IF Archive Glulx index and archive: <https://ifarchive.org/indexes/if-archive/games/glulx/>
- ZILF: <https://github.com/taradinoc/zilf>
- Glazer: <https://gitlab.com/andwj/glazer>
- Glulx specification 3.1.3 and license notice: <https://eblong.com/zarf/glulx/Glulx-Spec.html>
- Glulxe: <https://github.com/erkyrath/glulxe>
- CheapGlk: <https://github.com/erkyrath/cheapglk>
- Microsoft source-release branding boundary: <https://opensource.microsoft.com/blog/2025/11/20/preserving-code-that-shaped-generations-zork-i-ii-and-iii-go-open-source/>

## Release gate

No Glulx artifact should be presented as release-ready until:

- its provenance and build receipts exist;
- every downloaded source archive matches its committed hash;
- every distributed component's required notices are bundled;
- the story artifact matches its committed checksum and SHA-256;
- product naming has passed a separate trademark and branding review.
