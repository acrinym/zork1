"""Run HOE Glulxe workloads, compare transcripts, and measure wall time."""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import statistics
import subprocess
import sys
import time
from pathlib import Path


def run_once(binary: Path, story: Path, script: Path, seed: int, cwd: Path, extra: list[str]) -> tuple[bytes, float]:
    cmd = [str(binary), "--rngseed", str(seed), "--undo", "16", *extra, str(story)]
    started = time.perf_counter()
    proc = subprocess.run(
        cmd,
        input=script.read_bytes(),
        cwd=cwd,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )
    elapsed = time.perf_counter() - started
    if proc.returncode not in (0, 1):
        raise SystemExit(
            f"{binary.name} exited {proc.returncode} on {script.name}: {proc.stderr.decode('utf-8', 'replace')[:800]}"
        )
    return proc.stdout, elapsed


def median_time(times: list[float]) -> float:
    return float(statistics.median(times))


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--story", required=True, type=Path)
    parser.add_argument("--reference", required=True, type=Path)
    parser.add_argument("--optimized", required=True, type=Path)
    parser.add_argument("--workloads", required=True, type=Path)
    parser.add_argument("--cwd", required=True, type=Path)
    parser.add_argument("--out", required=True, type=Path)
    parser.add_argument("--seed", type=int, required=True)
    parser.add_argument("--runs", type=int, required=True)
    parser.add_argument("--max-ratio", type=float, required=True)
    args = parser.parse_args()
    args.cwd.mkdir(parents=True, exist_ok=True)
    scripts = sorted(p for p in args.workloads.glob("*.txt") if p.is_file())
    if not scripts:
        raise SystemExit("Release 1279 has no workload scripts")
    histories = []
    ref_total = []
    opt_total = []
    for script in scripts:
        ref_out = opt_out = None
        ref_times = []
        opt_times = []
        for _ in range(args.runs):
            rout, rt = run_once(args.reference, args.story, script, args.seed, args.cwd, [])
            oout, ot = run_once(args.optimized, args.story, script, args.seed, args.cwd, [])
            if ref_out is None:
                ref_out = rout
                opt_out = oout
            elif rout != ref_out or oout != opt_out:
                raise SystemExit(f"Release 1279 non-deterministic transcript on {script.name}")
            ref_times.append(rt)
            opt_times.append(ot)
        if ref_out != opt_out:
            ref_path = args.cwd / f"{script.stem}-reference.txt"
            opt_path = args.cwd / f"{script.stem}-optimized.txt"
            ref_path.write_bytes(ref_out)
            opt_path.write_bytes(opt_out)
            raise SystemExit(f"Release 1279 transcript divergence on {script.name}")
        (args.cwd / f"{script.stem}-transcript.txt").write_bytes(ref_out)
        ref_med = median_time(ref_times)
        opt_med = median_time(opt_times)
        ref_total.append(ref_med)
        opt_total.append(opt_med)
        histories.append(
            {
                "workload": script.name,
                "sha256": hashlib.sha256(ref_out).hexdigest(),
                "reference_median_s": ref_med,
                "optimized_median_s": opt_med,
                "ratio": (opt_med / ref_med) if ref_med else None,
            }
        )
    ref_sum = sum(ref_total)
    opt_sum = sum(opt_total)
    ratio = opt_sum / ref_sum if ref_sum else None
    receipt = {
        "release": 1279,
        "story": args.story.name,
        "runs": args.runs,
        "reference_total_median_s": ref_sum,
        "optimized_total_median_s": opt_sum,
        "optimized_over_reference_ratio": ratio,
        "max_optimized_over_reference_ratio": args.max_ratio,
        "histories": histories,
    }
    args.out.write_text(json.dumps(receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print("RELEASE_1279_MEASUREMENT=" + json.dumps(receipt, sort_keys=True))
    if ratio is None or ratio > args.max_ratio:
        raise SystemExit(
            f"Release 1279 optimized Glulxe is not materially faster: ratio {ratio}, required <= {args.max_ratio}"
        )
    return 0


if __name__ == "__main__":
    os.environ.setdefault("PYTHONUTF8", "1")
    sys.exit(main())
