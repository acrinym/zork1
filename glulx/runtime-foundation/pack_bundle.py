#!/usr/bin/env python3
"""Build the Release 1285 portable bundle (ulx + interpreter + contract + checksums)."""
from __future__ import annotations
import argparse, hashlib, json, shutil, stat
from pathlib import Path

def digest(p: Path) -> str:
    return hashlib.sha256(p.read_bytes()).hexdigest()

def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--story", type=Path, required=True)
    parser.add_argument("--glulxe", type=Path, required=True)
    parser.add_argument("--contract", type=Path, required=True)
    parser.add_argument("--destination", type=Path, required=True)
    args = parser.parse_args()
    dest = args.destination
    if dest.exists():
        shutil.rmtree(dest)
    dest.mkdir(parents=True)
    story_name = args.story.name
    shutil.copy2(args.story, dest / story_name)
    bin_name = "glulxe" if args.glulxe.name != "glulxe.exe" else "glulxe.exe"
    shutil.copy2(args.glulxe, dest / bin_name)
    (dest / bin_name).chmod((dest / bin_name).stat().st_mode | stat.S_IEXEC)
    shutil.copy2(args.contract, dest / "hoe-glulx-contract.json")
    play = """Highly Extended Zork — portable runtime bundle (Release 1285)

Launch (Linux/macOS):
  ./glulxe --rngseed 123456 %s

Launch (Windows, after building Glulxe for that host):
  glulxe.exe --rngseed 123456 %s

The .ulx is ordinary Glulx. You may take it to another conforming interpreter.
Saves are written next to the story file by CheapGlk. No account, no network.
""" % (story_name, story_name)
    (dest / "PLAY.txt").write_text(play, encoding="utf-8")
    sums = []
    for p in sorted(dest.iterdir()):
        if p.is_file():
            sums.append(f"{digest(p)}  {p.name}")
    (dest / "SHA256SUMS").write_text("\n".join(sums) + "\n", encoding="utf-8")
    receipt = {
        "live_release": 1285,
        "story": story_name,
        "story_sha256": digest(dest / story_name),
        "glulxe_sha256": digest(dest / bin_name),
        "files": sorted(q.name for q in dest.iterdir() if q.is_file()),
    }
    (dest / "BUNDLE-RECEIPT.json").write_text(json.dumps(receipt, indent=2) + "\n", encoding="utf-8")
    print("RELEASE_1285_BUNDLE=" + str(dest))
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
