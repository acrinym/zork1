"""Command-line interface for extraction, audits, baselines, and runtime probes."""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from tools.infocom_corpus.core import CorpusError

from .audit import audit_summary, audit_world
from .config import load_config
from .extract import extract_world
from .report import load_baseline, write_baseline, write_json, write_markdown
from .runtime import build_probes, load_probe_plan, run_probes, save_probe_plan, write_results


def validate_source_contract(source: Path, model, config) -> None:
    """Fail closed when a product policy is accidentally aimed at historical source."""
    if config.policy.get("required_staging_receipt"):
        receipt = source.resolve() / "STAGING-RECEIPT.json"
        if not receipt.is_file():
            raise ValueError(f"product audit requires qualify staging receipt: {receipt}")
        data = json.loads(receipt.read_text(encoding="utf-8"))
        if not isinstance(data.get("release"), int) or not data.get("edition"):
            raise ValueError("staging receipt must identify edition and numeric release")
    available = {Path(item["path"]).stem.lower() for item in model.source_files}
    required = config.policy.get("required_includes", [])
    if not isinstance(required, list) or not all(isinstance(item, str) for item in required):
        raise ValueError("policy.required_includes must be an array of strings")
    missing = sorted(item for item in required if item.lower() not in available)
    if missing:
        raise ValueError(f"staged source is missing required INSERT-FILE lineage: {', '.join(missing)}")


def parser() -> argparse.ArgumentParser:
    root = argparse.ArgumentParser(prog="world-truth", description="Audit whether a ZIL world's prose, parser, entities, and interactions agree.")
    sub = root.add_subparsers(dest="command", required=True)
    audit = sub.add_parser("audit", help="extract and audit a complete source lineage")
    audit.add_argument("--source", type=Path, default=Path("."))
    audit.add_argument("--entrypoint", default="zork1.zil")
    audit.add_argument("--config", type=Path, default=Path("world-truth.toml"))
    audit.add_argument("--baseline", type=Path)
    audit.add_argument("--json", type=Path)
    audit.add_argument("--markdown", type=Path)
    audit.add_argument("--write-baseline", type=Path)
    audit.add_argument("--probe-plan", type=Path)
    audit.add_argument("--fail-on", action="append", choices=["error", "warning", "candidate", "info"], default=[])
    probes = sub.add_parser("run-probes", help="run a generated plan against an interpreter")
    probes.add_argument("--plan", type=Path, required=True)
    probes.add_argument("--results", type=Path, required=True)
    probes.add_argument("--timeout", type=float, default=30)
    probes.add_argument("--include-transcripts", action="store_true")
    probes.add_argument("interpreter", nargs=argparse.REMAINDER)
    return root


def main(argv: list[str] | None = None) -> int:
    args = parser().parse_args(argv)
    try:
        if args.command == "audit":
            config = load_config(args.config)
            model = extract_world(args.source, args.entrypoint)
            validate_source_contract(args.source, model, config)
            model = audit_world(model, config, load_baseline(args.baseline))
            if args.json:
                write_json(args.json, model)
            if args.markdown:
                write_markdown(args.markdown, model)
            if args.write_baseline:
                write_baseline(args.write_baseline, model)
            if args.probe_plan:
                save_probe_plan(args.probe_plan, build_probes(model, config))
            summary = audit_summary(model)
            print(json.dumps(summary, indent=2, sort_keys=True))
            fail_on = set(args.fail_on)
            return 1 if any(not item.baseline and item.severity in fail_on for item in model.findings) else 0
        plan = load_probe_plan(args.plan)
        interpreter = args.interpreter[1:] if args.interpreter and args.interpreter[0] == "--" else args.interpreter
        if not interpreter:
            raise ValueError("an interpreter command is required after --")
        results = run_probes(plan, interpreter, args.timeout)
        write_results(args.results, results, args.include_transcripts)
        print(json.dumps({"probes": len(results), "passed": sum(item.passed for item in results), "failed": sum(not item.passed for item in results)}, indent=2))
        return 0 if all(item.passed for item in results) else 1
    except (CorpusError, OSError, UnicodeError, ValueError) as exc:
        print(f"world-truth: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
