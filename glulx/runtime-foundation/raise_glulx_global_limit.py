#!/usr/bin/env python3
"""Release 1281: lift ZILF's Z-machine hard-global cap for native Glulx."""
from __future__ import annotations

import subprocess
import sys
from pathlib import Path

OLD = """                if (Context.ZEnvironment.Globals.Count > 240 - reservedGlobals.Length)
                {
                    Context.HandleError(new CompilerError(
                        CompilerMessages.Too_Many_0_1_Defined_Only_2_Allowed,
                        "globals",
                        Context.ZEnvironment.Globals.Count,
                        240 - reservedGlobals.Length));
                }"""

NEW = """                // Native Glulx globals are ordinary RAM words; the 240 cap is Z-machine only.
                var maxHardGlobals = (Context.IsGlulx && !Context.IsGlulx16)
                    ? 65535
                    : 240 - reservedGlobals.Length;
                if (Context.ZEnvironment.Globals.Count > maxHardGlobals)
                {
                    Context.HandleError(new CompilerError(
                        CompilerMessages.Too_Many_0_1_Defined_Only_2_Allowed,
                        "globals",
                        Context.ZEnvironment.Globals.Count,
                        maxHardGlobals));
                }"""

MARKER = "Native Glulx globals are ordinary RAM words"


def main() -> int:
    root = Path(sys.argv[1] if len(sys.argv) > 1 else ".")
    src = root / ".tooling" / "zilf-glulx" / "src" / "Zilf" / "Compiler" / "Compilation.Compile.cs"
    if not src.is_file():
        raise SystemExit(f"ZILF compile surface missing: {src}")
    text = src.read_text(encoding="utf-8")
    rebuilt = False
    if MARKER in text:
        print("RELEASE_1281_GLULX_GLOBAL_LIMIT already present")
    elif OLD not in text:
        raise SystemExit("ZILF global-limit surface drifted; cannot apply Release 1281")
    else:
        src.write_text(text.replace(OLD, NEW, 1), encoding="utf-8")
        print("RELEASE_1281_PATCHED_ZILF_GLOBAL_LIMIT")
        rebuilt = True
    sln = root / ".tooling" / "zilf-glulx"
    if rebuilt or not list(sln.glob("**/bin/Release/*/zilf.dll")):
        subprocess.check_call(
            [
                "dotnet",
                "build",
                "Zilf.sln",
                "--configuration",
                "Release",
                "--property:PortableTarget=true",
                "--nologo",
            ],
            cwd=sln,
        )
    print("RELEASE_1281_ZILF_HARD_GLOBALS_GLULX_65535")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
