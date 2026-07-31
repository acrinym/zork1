"""Command-line interface for the Infocom Corpus Foundation."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import sys

from .core import (
    CorpusError,
    annotate_records,
    artifact_by_id,
    build_style_receipt,
    check_overlap,
    corpus_digest,
    derive_profiles,
    ensure_output_policy,
    extract_player_visible_strings,
    fingerprint_local_artifact,
    load_profiles,
    public_summary_from_records,
    read_json,
    read_jsonl,
    validate_correction_records,
    validate_manifest,
    write_json,
    write_jsonl,
)


def _manifest(path: Path) -> dict:
    """Read and validate one manifest root object."""
    value = read_json(path)
    if not isinstance(value, dict):
        raise CorpusError("manifest root must be an object")
    validate_manifest(value)
    return value


def _read_candidate(path: Path) -> str:
    """Read candidate prose as strict UTF-8 with a normalized CLI error."""
    try:
        return path.read_text(encoding="utf-8", errors="strict")
    except UnicodeDecodeError as exc:
        raise CorpusError(f"candidate is not valid UTF-8: {path}: {exc}") from exc


def command_validate_manifest(args: argparse.Namespace) -> int:
    """Validate and optionally persist a safe manifest summary."""
    summary = validate_manifest(_manifest(args.manifest))
    if args.out:
        write_json(args.out, summary)
    print(json.dumps(summary, indent=2, sort_keys=True))
    return 0


def command_extract(args: argparse.Namespace) -> int:
    """Extract local prose and write a source-text-free public summary."""
    manifest = _manifest(args.manifest)
    selected = manifest["selected_game_source"]
    artifact = artifact_by_id(manifest, selected["artifact_id"])
    ensure_output_policy(args.out, args.repo_root, artifact)
    records, extraction_summary = extract_player_visible_strings(
        args.repo_root,
        selected["entrypoint"],
        selected["artifact_id"],
    )
    write_jsonl(args.out, records)
    public_summary = public_summary_from_records(
        records,
        artifact_id=selected["artifact_id"],
        source_files=extraction_summary["source_files"],
    )
    public_summary["entrypoint"] = selected["entrypoint"]
    public_summary["lineage_file_count"] = extraction_summary["source_file_count"]
    write_json(args.summary_out, public_summary)
    print(
        f"Extracted {len(records)} player-visible strings from "
        f"{extraction_summary['source_file_count']} ZIL files."
    )
    print(f"Local corpus: {args.out}")
    print(f"Safe summary: {args.summary_out}")
    return 0


def command_annotate(args: argparse.Namespace) -> int:
    """Attach fresh linguistic annotations to local corpus records."""
    records = read_jsonl(args.corpus)
    annotated = annotate_records(records)
    write_jsonl(args.out, annotated)
    print(f"Annotated {len(annotated)} corpus records: {args.out}")
    return 0


def command_profile(args: argparse.Namespace) -> int:
    """Derive source-text-free authority statistics."""
    records = read_jsonl(args.corpus)
    contracts = load_profiles(args.profiles)
    digest = args.corpus_digest or corpus_digest(records)
    output = derive_profiles(records, contracts, digest)
    write_json(args.out, output)
    print(f"Derived {output['profile_count']} authority profiles: {args.out}")
    return 0


def command_overlap(args: argparse.Namespace) -> int:
    """Check candidate prose against all protected local corpus records."""
    candidate_text = _read_candidate(args.candidate)
    records = read_jsonl(args.corpus)
    allowed: list[str] = []
    if args.profile_id:
        profiles = load_profiles(args.profiles)
        try:
            allowed = profiles[args.profile_id].get("allowed_phrases", [])
        except KeyError as exc:
            raise CorpusError(f"unknown profile_id: {args.profile_id}") from exc
    result = check_overlap(
        candidate_text,
        records,
        max_allowed_tokens=args.max_allowed_tokens,
        rare_ngram_tokens=args.rare_ngram_tokens,
        allowed_phrases=allowed,
    )
    write_json(args.out, result)
    print(
        f"Overlap validation {'PASSED' if result['passed'] else 'FAILED'}; "
        f"{len(result['threshold_violations'])} threshold violation(s), "
        f"{len(result['rare_phrase_matches'])} rare phrase match(es), "
        f"longest overlap "
        f"{result['longest_overlap']['tokens'] if result['longest_overlap'] else 0} token(s)."
    )
    return 0 if result["passed"] else 3


def command_receipt(args: argparse.Namespace) -> int:
    """Issue a style receipt after a complete passing overlap check."""
    candidate_text = _read_candidate(args.candidate)
    records = read_jsonl(args.corpus)
    profiles = load_profiles(args.profiles)
    try:
        profile = profiles[args.profile_id]
    except KeyError as exc:
        raise CorpusError(f"unknown profile_id: {args.profile_id}") from exc
    overlap = check_overlap(
        candidate_text,
        records,
        max_allowed_tokens=args.max_allowed_tokens,
        rare_ngram_tokens=args.rare_ngram_tokens,
        allowed_phrases=profile.get("allowed_phrases", []),
    )
    overlap_out = args.overlap_out or args.out.with_suffix(".overlap.json")
    write_json(overlap_out, overlap)
    if not overlap["passed"]:
        print(f"Style receipt blocked by overlap failure: {overlap_out}", file=sys.stderr)
        return 3
    receipt = build_style_receipt(
        surface_family=args.surface_family,
        candidate_path=args.candidate.as_posix(),
        candidate_text=candidate_text,
        profile=profile,
        overlap=overlap,
        corpus_digest=args.corpus_digest or corpus_digest(records),
        intentional_departures=args.intentional_departure,
        reviewer=args.reviewer,
    )
    write_json(args.out, receipt)
    print(f"Style receipt written: {args.out}")
    return 0


def command_fingerprint(args: argparse.Namespace) -> int:
    """Fingerprint a protected local copy without exposing its contents."""
    record = fingerprint_local_artifact(
        args.source,
        args.artifact_id,
        repo_root=args.repo_root,
        page_count=args.page_count,
        page_references=args.page_reference,
    )
    if args.out:
        write_json(args.out, record)
    print(json.dumps(record, indent=2, sort_keys=True))
    return 0


def command_validate_corrections(args: argparse.Namespace) -> int:
    """Validate hash-only correction records against artifact rights."""
    manifest = _manifest(args.manifest)
    records = read_jsonl(args.corrections)
    summary = validate_correction_records(records, manifest)
    if args.out:
        write_json(args.out, summary)
    print(json.dumps(summary, indent=2, sort_keys=True))
    return 0


def build_parser() -> argparse.ArgumentParser:
    """Build the complete command-line parser."""
    parser = argparse.ArgumentParser(
        prog="python -m tools.infocom_corpus",
        description=(
            "Extract traceable Zork prose locally, derive non-expressive style "
            "profiles, and issue rights-aware originality receipts."
        ),
    )
    sub = parser.add_subparsers(dest="command", required=True)

    validate = sub.add_parser("validate-manifest", help="validate rights and edition records")
    validate.add_argument("--manifest", type=Path, required=True)
    validate.add_argument("--out", type=Path)
    validate.set_defaults(func=command_validate_manifest)

    extract = sub.add_parser("extract", help="extract player-visible ZIL strings")
    extract.add_argument("--repo-root", type=Path, default=Path("."))
    extract.add_argument("--manifest", type=Path, required=True)
    extract.add_argument("--out", type=Path, required=True)
    extract.add_argument("--summary-out", type=Path, required=True)
    extract.set_defaults(func=command_extract)

    annotate = sub.add_parser("annotate", help="add rule-based linguistic annotations")
    annotate.add_argument("--corpus", type=Path, required=True)
    annotate.add_argument("--out", type=Path, required=True)
    annotate.set_defaults(func=command_annotate)

    profile = sub.add_parser("profile", help="derive non-expressive authority statistics")
    profile.add_argument("--corpus", type=Path, required=True)
    profile.add_argument("--profiles", type=Path, required=True)
    profile.add_argument("--corpus-digest")
    profile.add_argument("--out", type=Path, required=True)
    profile.set_defaults(func=command_profile)

    overlap = sub.add_parser("overlap", help="check candidate prose for source phrase overlap")
    overlap.add_argument("--candidate", type=Path, required=True)
    overlap.add_argument("--corpus", type=Path, required=True)
    overlap.add_argument("--profiles", type=Path)
    overlap.add_argument("--profile-id")
    overlap.add_argument("--max-allowed-tokens", type=int, default=6)
    overlap.add_argument("--rare-ngram-tokens", type=int, default=5)
    overlap.add_argument("--out", type=Path, required=True)
    overlap.set_defaults(func=command_overlap)

    receipt = sub.add_parser("receipt", help="issue a style receipt after overlap validation")
    receipt.add_argument("--candidate", type=Path, required=True)
    receipt.add_argument("--corpus", type=Path, required=True)
    receipt.add_argument("--profiles", type=Path, required=True)
    receipt.add_argument("--profile-id", required=True)
    receipt.add_argument("--surface-family", required=True)
    receipt.add_argument("--reviewer", required=True)
    receipt.add_argument("--intentional-departure", action="append", default=[])
    receipt.add_argument("--corpus-digest")
    receipt.add_argument("--max-allowed-tokens", type=int, default=6)
    receipt.add_argument("--rare-ngram-tokens", type=int, default=5)
    receipt.add_argument("--overlap-out", type=Path)
    receipt.add_argument("--out", type=Path, required=True)
    receipt.set_defaults(func=command_receipt)

    fingerprint = sub.add_parser(
        "fingerprint-local",
        help="record hashes and page references without publishing a protected artifact",
    )
    fingerprint.add_argument("--repo-root", type=Path, default=Path("."))
    fingerprint.add_argument("--artifact-id", required=True)
    fingerprint.add_argument("--source", type=Path, required=True)
    fingerprint.add_argument("--page-count", type=int)
    fingerprint.add_argument("--page-reference", action="append", default=[])
    fingerprint.add_argument("--out", type=Path)
    fingerprint.set_defaults(func=command_fingerprint)

    corrections = sub.add_parser(
        "validate-corrections",
        help="validate hash-only correction records against artifact rights",
    )
    corrections.add_argument("--manifest", type=Path, required=True)
    corrections.add_argument("--corrections", type=Path, required=True)
    corrections.add_argument("--out", type=Path)
    corrections.set_defaults(func=command_validate_corrections)

    return parser


def main(argv: list[str] | None = None) -> int:
    """Run one command and normalize user-input failures to exit code two."""
    parser = build_parser()
    args = parser.parse_args(argv)
    if args.command == "overlap" and args.profile_id and not args.profiles:
        parser.error("--profiles is required when --profile-id is used")
    try:
        return int(args.func(args))
    except CorpusError as exc:
        print(f"infocom-corpus: {exc}", file=sys.stderr)
        return 2
    except UnicodeDecodeError as exc:
        print(f"infocom-corpus: input is not valid UTF-8: {exc}", file=sys.stderr)
        return 2
    except OSError as exc:
        print(f"infocom-corpus: filesystem error: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
