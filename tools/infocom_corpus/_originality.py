"""Originality checks, style receipts, and protected local-copy records."""

from __future__ import annotations

from datetime import date
from difflib import SequenceMatcher
from pathlib import Path
from typing import Any, Mapping, Sequence

from ._base import (
    CorpusError, FUNCTION_WORDS, SAFE_REFERENCE_RE, SHA256_RE,
    _require, _require_id, _sha256_bytes, artifact_by_id, corpus_digest,
    rights_allow_text_export, sha256_file, stable_json_sha,
)
from ._profiles import tokenize_words


def _longest_match(candidate: Sequence[str], source: Sequence[str]) -> tuple[int, int, int]:
    """Return the longest contiguous token match and both start offsets."""
    match = SequenceMatcher(None, candidate, source, autojunk=False).find_longest_match(
        0, len(candidate), 0, len(source)
    )
    return match.size, match.a, match.b


def _normalized_phrase(text: str) -> tuple[str, ...]:
    """Normalize an allowed canonical phrase to lexical tokens."""
    return tuple(tokenize_words(text))


def _phrase_allowed(tokens: Sequence[str], allowed: set[tuple[str, ...]]) -> bool:
    """Return whether a matched token span is an exact allowed phrase."""
    return tuple(tokens) in allowed


def _matching_spans(
    candidate: Sequence[str],
    source: Sequence[str],
    minimum_tokens: int,
) -> list[tuple[int, int, int, int]]:
    """Find every unique maximal shared span at or above a minimum length."""
    if len(candidate) < minimum_tokens or len(source) < minimum_tokens:
        return []
    source_windows: dict[tuple[str, ...], list[int]] = {}
    for source_start in range(len(source) - minimum_tokens + 1):
        window = tuple(source[source_start:source_start + minimum_tokens])
        source_windows.setdefault(window, []).append(source_start)
    spans: set[tuple[int, int, int, int]] = set()
    for candidate_start in range(len(candidate) - minimum_tokens + 1):
        window = tuple(candidate[candidate_start:candidate_start + minimum_tokens])
        for source_start in source_windows.get(window, []):
            c_left, s_left = candidate_start, source_start
            while c_left > 0 and s_left > 0 and candidate[c_left - 1] == source[s_left - 1]:
                c_left -= 1
                s_left -= 1
            c_right = candidate_start + minimum_tokens
            s_right = source_start + minimum_tokens
            while c_right < len(candidate) and s_right < len(source) and candidate[c_right] == source[s_right]:
                c_right += 1
                s_right += 1
            spans.add((c_left, c_right, s_left, s_right))
    return sorted(spans)


def check_overlap(
    candidate_text: str,
    records: Sequence[Mapping[str, Any]],
    *,
    max_allowed_tokens: int = 6,
    rare_ngram_tokens: int = 5,
    allowed_phrases: Sequence[str] = (),
) -> dict[str, Any]:
    """Check every over-threshold source overlap without disclosing source prose."""
    if max_allowed_tokens < 3:
        raise CorpusError("max_allowed_tokens must be at least 3")
    if rare_ngram_tokens < 3:
        raise CorpusError("rare_ngram_tokens must be at least 3")
    candidate = tokenize_words(candidate_text)
    allowed = {_normalized_phrase(item) for item in allowed_phrases if item.strip()}
    longest: dict[str, Any] | None = None
    threshold_violations: list[dict[str, Any]] = []
    corpus_ngram_sources: dict[tuple[str, ...], set[str]] = {}

    for record in records:
        source_text = record.get("text")
        record_id = record.get("record_id")
        if not isinstance(source_text, str) or not isinstance(record_id, str):
            raise CorpusError("overlap corpus records require text and record_id")
        source_tokens = tokenize_words(source_text)
        longest_size, longest_candidate_start, longest_source_start = _longest_match(
            candidate, source_tokens
        )
        if longest_size:
            matched = candidate[
                longest_candidate_start:longest_candidate_start + longest_size
            ]
            longest_for_record = {
                "tokens": longest_size,
                "candidate_token_start": longest_candidate_start,
                "candidate_token_end": longest_candidate_start + longest_size,
                "candidate_span_sha256": stable_json_sha(matched),
                "source_record_id": record_id,
                "source_token_start": longest_source_start,
                "source_span_sha256": stable_json_sha(
                    source_tokens[longest_source_start:longest_source_start + longest_size]
                ),
                "allowed_exact_phrase": _phrase_allowed(matched, allowed),
            }
            if longest is None or longest_size > longest["tokens"]:
                longest = longest_for_record

        spans = _matching_spans(candidate, source_tokens, max_allowed_tokens + 1)
        for candidate_start, candidate_end, source_start, source_end in spans:
            matched = candidate[candidate_start:candidate_end]
            if _phrase_allowed(matched, allowed):
                continue
            threshold_violations.append({
                "tokens": candidate_end - candidate_start,
                "candidate_token_start": candidate_start,
                "candidate_token_end": candidate_end,
                "candidate_span_sha256": stable_json_sha(matched),
                "source_record_id": record_id,
                "source_token_start": source_start,
                "source_span_sha256": stable_json_sha(source_tokens[source_start:source_end]),
                "allowed_exact_phrase": False,
            })

        if len(source_tokens) >= rare_ngram_tokens:
            for index in range(len(source_tokens) - rare_ngram_tokens + 1):
                phrase = tuple(source_tokens[index:index + rare_ngram_tokens])
                corpus_ngram_sources.setdefault(phrase, set()).add(record_id)

    threshold_violations.sort(
        key=lambda item: (-item["tokens"], item["source_record_id"], item["candidate_token_start"])
    )
    rare_matches: list[dict[str, Any]] = []
    if len(candidate) >= rare_ngram_tokens:
        seen: set[tuple[str, ...]] = set()
        for index in range(len(candidate) - rare_ngram_tokens + 1):
            phrase = tuple(candidate[index:index + rare_ngram_tokens])
            if phrase in seen or _phrase_allowed(phrase, allowed):
                continue
            seen.add(phrase)
            source_ids = corpus_ngram_sources.get(phrase)
            if not source_ids:
                continue
            content_count = sum(1 for token in phrase if token not in FUNCTION_WORDS)
            if content_count < 2:
                continue
            rare_matches.append({
                "candidate_token_start": index,
                "candidate_token_end": index + rare_ngram_tokens,
                "span_sha256": stable_json_sha(phrase),
                "source_record_ids": sorted(source_ids),
                "source_count": len(source_ids),
            })

    return {
        "schema_version": "1.0",
        "candidate_sha256": _sha256_bytes(candidate_text.encode("utf-8")),
        "candidate_word_count": len(candidate),
        "corpus_record_count": len(records),
        "thresholds": {
            "max_allowed_tokens": max_allowed_tokens,
            "rare_ngram_tokens": rare_ngram_tokens,
        },
        "longest_overlap": longest,
        "threshold_violations": threshold_violations,
        "rare_phrase_matches": rare_matches,
        "passed": not threshold_violations and not rare_matches,
        "source_text_disclosed": False,
    }


def build_style_receipt(
    *,
    surface_family: str,
    candidate_path: str,
    candidate_text: str,
    profile: Mapping[str, Any],
    overlap: Mapping[str, Any],
    corpus_digest: str,
    intentional_departures: Sequence[str],
    reviewer: str,
) -> dict[str, Any]:
    """Issue a passing style receipt only after complete originality evidence."""
    profile_id = _require_id(profile.get("profile_id"), "profile.profile_id")
    if not surface_family.strip():
        raise CorpusError("surface_family cannot be empty")
    if not reviewer.strip():
        raise CorpusError("reviewer cannot be empty")
    if not SHA256_RE.fullmatch(corpus_digest):
        raise CorpusError("corpus_digest must be a lowercase SHA-256")
    departures = list(intentional_departures)
    if not departures or not all(isinstance(item, str) and item.strip() for item in departures):
        raise CorpusError("intentional_departures must contain at least one non-empty explanation")
    if not overlap.get("passed"):
        raise CorpusError("cannot issue a passing style receipt for failed overlap validation")
    if overlap.get("threshold_violations"):
        raise CorpusError("cannot issue a style receipt with threshold overlap violations")
    for key in ("primary_authorities", "excluded_voices", "retained_traits"):
        values = profile.get(key)
        if not isinstance(values, list) or not values:
            raise CorpusError(f"profile {profile_id} lacks {key}")
    return {
        "schema_version": "1.0",
        "receipt_id": f"{surface_family}-{_sha256_bytes(candidate_text.encode('utf-8'))[:12]}",
        "surface_family": surface_family,
        "candidate": {
            "path": candidate_path,
            "sha256": _sha256_bytes(candidate_text.encode("utf-8")),
            "word_count": len(tokenize_words(candidate_text)),
        },
        "authority_profile": profile_id,
        "primary_authorities": list(profile["primary_authorities"]),
        "secondary_authorities": list(profile.get("secondary_authorities", [])),
        "excluded_voices": list(profile["excluded_voices"]),
        "retained_linguistic_traits": list(profile["retained_traits"]),
        "intentional_departures": departures,
        "originality_check": {
            "corpus_digest": corpus_digest,
            "candidate_sha256": overlap["candidate_sha256"],
            "longest_source_overlap_tokens": (
                overlap["longest_overlap"]["tokens"] if overlap.get("longest_overlap") else 0
            ),
            "threshold_violation_count": len(overlap.get("threshold_violations", [])),
            "rare_phrase_match_count": len(overlap.get("rare_phrase_matches", [])),
            "thresholds": overlap["thresholds"],
            "passed": True,
            "source_text_disclosed": False,
        },
        "reviewed_by": reviewer,
        "reviewed_on": date.today().isoformat(),
    }


def _local_corpus_root(repo_root: Path) -> Path:
    """Return the canonical protected local-study root."""
    return (repo_root.resolve() / ".local" / "infocom-corpus").resolve()


def fingerprint_local_artifact(
    path: Path,
    artifact_id: str,
    *,
    repo_root: Path,
    page_count: int | None = None,
    page_references: Sequence[str] = (),
) -> dict[str, Any]:
    """Fingerprint a protected copy only when it resides in the local-study root."""
    _require_id(artifact_id, "fingerprint.artifact_id")
    resolved_path = path.resolve()
    local_root = _local_corpus_root(repo_root)
    try:
        resolved_path.relative_to(local_root)
    except ValueError as exc:
        raise CorpusError(
            f"local artifact must remain below {local_root.as_posix()}"
        ) from exc
    if not resolved_path.is_file():
        raise CorpusError(f"local artifact does not exist: {resolved_path}")
    if page_count is not None and (isinstance(page_count, bool) or page_count < 1):
        raise CorpusError("page_count must be positive")
    references = list(page_references)
    for reference in references:
        if not isinstance(reference, str) or not SAFE_REFERENCE_RE.fullmatch(reference):
            raise CorpusError(
                f"page_reference must be a structural locator, not quoted text: {reference!r}"
            )
    return {
        "schema_version": "1.0",
        "artifact_id": artifact_id,
        "source_sha256": sha256_file(resolved_path),
        "byte_size": resolved_path.stat().st_size,
        "page_count": page_count,
        "page_references": references,
        "safe_to_commit": True,
        "contains_source_text": False,
    }


def _validate_location(location: Mapping[str, Any], where: str) -> None:
    """Require at least one concrete, typed correction locator."""
    concrete = False
    for key in location:
        if key not in {"page", "surface", "block_id", "line"}:
            raise CorpusError(f"{where}.location contains unsupported key {key}")
    for key in ("page", "line"):
        value = location.get(key)
        if value is not None:
            if isinstance(value, bool) or not isinstance(value, int) or value < 1:
                raise CorpusError(f"{where}.location.{key} must be a positive integer")
            concrete = True
    for key in ("surface", "block_id"):
        value = location.get(key)
        if value is not None:
            if not isinstance(value, str) or not value.strip():
                raise CorpusError(f"{where}.location.{key} must be a non-empty string")
            concrete = True
    if not concrete:
        raise CorpusError(f"{where}.location requires page, surface, block_id, or line")


def validate_correction_records(
    records: Sequence[Mapping[str, Any]],
    manifest: Mapping[str, Any],
) -> dict[str, Any]:
    """Validate hash-only corrections against each artifact rights gate."""
    seen: set[str] = set()
    for index, record in enumerate(records, 1):
        where = f"correction[{index}]"
        correction_id = _require_id(record.get("correction_id"), f"{where}.correction_id")
        if correction_id in seen:
            raise CorpusError(f"duplicate correction_id: {correction_id}")
        seen.add(correction_id)
        artifact_id = _require_id(record.get("artifact_id"), f"{where}.artifact_id")
        artifact = artifact_by_id(manifest, artifact_id)
        location = _require(record, "location", dict, where)
        _validate_location(location, where)
        for key in ("observed_sha256", "corrected_sha256"):
            value = _require(record, key, str, where)
            if not SHA256_RE.fullmatch(value):
                raise CorpusError(f"{where}.{key} must be SHA-256")
        if not _require(record, "reason", str, where):
            raise CorpusError(f"{where}.reason cannot be empty")
        if record.get("confidence") not in {"certain", "probable", "uncertain"}:
            raise CorpusError(f"{where}.confidence is invalid")
        raw_fields = {"observed_text", "corrected_text"}.intersection(record)
        if raw_fields and not rights_allow_text_export(artifact):
            raise CorpusError(
                f"{where}: protected correction record may retain hashes and references, "
                f"not raw text fields {sorted(raw_fields)}"
            )
    return {
        "schema_version": "1.0",
        "correction_count": len(records),
        "correction_digest": stable_json_sha(records),
        "contains_source_text": False,
    }


def public_summary_from_records(
    records: Sequence[Mapping[str, Any]],
    *,
    artifact_id: str,
    source_files: Sequence[Mapping[str, Any]],
) -> dict[str, Any]:
    """Produce a safe, non-expressive public receipt from local records."""
    return {
        "schema_version": "1.0",
        "artifact_id": artifact_id,
        "record_count": len(records),
        "surface_counts": {
            surface: sum(1 for row in records if row.get("surface") == surface)
            for surface in sorted({str(row.get("surface")) for row in records})
        },
        "authority_profile_counts": {
            profile: sum(1 for row in records if row.get("authority_profile") == profile)
            for profile in sorted({str(row.get("authority_profile")) for row in records})
        },
        "source_files": list(source_files),
        "record_receipts": [
            {
                "record_id": row.get("record_id"),
                "text_sha256": row.get("text_sha256"),
                "source": row.get("source"),
                "surface": row.get("surface"),
                "authority_profile": row.get("authority_profile"),
            }
            for row in records
        ],
        "corpus_digest": corpus_digest(records),
        "contains_source_text": False,
    }
