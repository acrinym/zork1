"""Non-expressive linguistic annotation and authority profile derivation."""

from __future__ import annotations

from statistics import mean, median
import re
from pathlib import Path
from typing import Any, Iterable, Mapping, Sequence

from ._base import (
    ANNOTATION_REQUIRED_KEYS, COMEDY_MARKERS, CorpusError, FUNCTION_WORDS,
    PARSER_MARKERS, PUNCTUATION_KEYS, SECOND_PERSON, SENSORY_MARKERS,
    SENTENCE_RE, SHA256_RE, STANCE_MARKERS, SURFACES, WORD_RE,
    _require_id, corpus_digest, read_json,
)


def tokenize_words(text: str) -> list[str]:
    """Return lowercase lexical tokens used by annotations and overlap checks."""
    return [match.group(0).lower() for match in WORD_RE.finditer(text)]


def annotate_text(text: str, surface: str) -> dict[str, Any]:
    """Derive non-expressive linguistic features for one prose surface."""
    words = tokenize_words(text)
    word_set = set(words)
    sentences = [item.strip() for item in SENTENCE_RE.split(text.strip()) if item.strip()]
    sentence_word_counts = [len(tokenize_words(item)) for item in sentences] or [len(words)]
    punctuation = {
        "comma": text.count(","),
        "semicolon": text.count(";"),
        "colon": text.count(":"),
        "dash": text.count("—") + text.count(" - "),
        "parenthetical_open": text.count("("),
        "question": text.count("?"),
        "exclamation": text.count("!"),
        "ellipsis": text.count("..."),
    }
    sensory = [
        channel for channel, markers in SENSORY_MARKERS.items()
        if word_set.intersection(markers)
    ]
    stance = [
        label for label, markers in STANCE_MARKERS.items()
        if word_set.intersection(markers)
    ]
    parser_behavior: list[str] = []
    if surface == "parser-refusal":
        parser_behavior = [
            label for label, markers in PARSER_MARKERS.items()
            if word_set.intersection(markers)
        ] or ["reasonable-but-unsupported-action"]
    comedy = [
        label for label, markers in COMEDY_MARKERS.items()
        if word_set.intersection(markers)
    ]
    second_person_count = sum(1 for word in words if word in SECOND_PERSON)
    function_word_count = sum(1 for word in words if word in FUNCTION_WORDS)
    return {
        "schema_version": "1.0",
        "word_count": len(words),
        "sentence_count": len(sentences) if sentences else (1 if words else 0),
        "sentence_words_mean": round(mean(sentence_word_counts), 3) if sentence_word_counts else 0.0,
        "sentence_words_max": max(sentence_word_counts, default=0),
        "type_token_ratio": round(len(word_set) / len(words), 4) if words else 0.0,
        "function_word_ratio": round(function_word_count / len(words), 4) if words else 0.0,
        "second_person_count": second_person_count,
        "second_person_present": second_person_count > 0,
        "fragment_likely": bool(words and not re.search(r"[.!?]\s*$", text.strip())),
        "punctuation": punctuation,
        "sensory_channels": sensory,
        "narrator_stance_markers": stance,
        "parser_behavior": parser_behavior,
        "comedy_mechanics_markers": comedy,
    }


def annotate_records(records: Iterable[Mapping[str, Any]]) -> list[dict[str, Any]]:
    """Attach fresh annotations without mutating input records."""
    annotated: list[dict[str, Any]] = []
    for record in records:
        text = record.get("text")
        surface = record.get("surface")
        if not isinstance(text, str) or surface not in SURFACES:
            raise CorpusError(f"record {record.get('record_id')} lacks valid text or surface")
        copied = dict(record)
        copied["annotation"] = annotate_text(text, surface)
        annotated.append(copied)
    return annotated


def load_profiles(path: Path) -> dict[str, dict[str, Any]]:
    """Load and validate named authority contracts."""
    value = read_json(path)
    if not isinstance(value, dict) or value.get("schema_version") != "1.0":
        raise CorpusError("profiles file must be a schema_version 1.0 object")
    profiles = value.get("profiles")
    if not isinstance(profiles, list) or not profiles:
        raise CorpusError("profiles file must contain non-empty profiles")
    result: dict[str, dict[str, Any]] = {}
    for profile in profiles:
        if not isinstance(profile, dict):
            raise CorpusError("each profile must be an object")
        profile_id = _require_id(profile.get("profile_id"), "profile.profile_id")
        if profile_id in result:
            raise CorpusError(f"duplicate profile_id: {profile_id}")
        for key in ("primary_authorities", "secondary_authorities", "excluded_voices", "retained_traits"):
            values = profile.get(key)
            if not isinstance(values, list):
                raise CorpusError(f"{profile_id}.{key} must be a list")
            if key in {"primary_authorities", "excluded_voices", "retained_traits"} and not values:
                raise CorpusError(f"{profile_id}.{key} must not be empty")
            if not all(isinstance(item, str) and item for item in values):
                raise CorpusError(f"{profile_id}.{key} must contain strings")
        status = profile.get("evidence_status")
        if status not in {
            "executable-from-repository-source",
            "executable-from-local-protected-study-copy",
            "manifest-only-until-source-acquired",
        }:
            raise CorpusError(f"{profile_id}.evidence_status is invalid")
        allowed = profile.get("allowed_phrases", [])
        if not isinstance(allowed, list) or not all(isinstance(item, str) for item in allowed):
            raise CorpusError(f"{profile_id}.allowed_phrases must be strings")
        result[profile_id] = profile
    return result


def _annotation_is_complete(value: Any) -> bool:
    """Return whether a reused annotation has every downstream-required field."""
    if not isinstance(value, Mapping) or not ANNOTATION_REQUIRED_KEYS.issubset(value):
        return False
    punctuation = value.get("punctuation")
    return isinstance(punctuation, Mapping) and PUNCTUATION_KEYS.issubset(punctuation)


def derive_profiles(
    records: Sequence[Mapping[str, Any]],
    profile_contracts: Mapping[str, Mapping[str, Any]],
    digest: str,
) -> dict[str, Any]:
    """Derive source-text-free statistics for every named authority profile."""
    if not SHA256_RE.fullmatch(digest):
        raise CorpusError("corpus_digest must be a lowercase SHA-256")
    output_profiles: list[dict[str, Any]] = []
    for profile_id, contract in sorted(profile_contracts.items()):
        selected = [record for record in records if record.get("authority_profile") == profile_id]
        annotations: list[Mapping[str, Any]] = []
        for record in selected:
            annotation = record.get("annotation")
            if _annotation_is_complete(annotation):
                annotations.append(annotation)
                continue
            text = record.get("text")
            surface = record.get("surface")
            if not isinstance(text, str) or not isinstance(surface, str) or surface not in SURFACES:
                raise CorpusError(
                    f"record {record.get('record_id')} cannot be re-annotated: invalid text or surface"
                )
            annotations.append(annotate_text(text, surface))

        words = [
            word for record in selected
            for word in tokenize_words(str(record.get("text", "")))
        ]
        function_counts = {
            word: words.count(word)
            for word in sorted(FUNCTION_WORDS.intersection(words))
        }
        total_function = sum(function_counts.values())
        normalized_function = {
            word: round(count / total_function, 5)
            for word, count in function_counts.items()
        } if total_function else {}

        stats: dict[str, Any] | None = None
        if selected:
            stats = {
                "record_count": len(selected),
                "word_count": sum(int(item["word_count"]) for item in annotations),
                "sentence_words_mean": round(mean(float(item["sentence_words_mean"]) for item in annotations), 3),
                "sentence_words_median": round(median(float(item["sentence_words_mean"]) for item in annotations), 3),
                "second_person_record_ratio": round(
                    sum(1 for item in annotations if item["second_person_present"]) / len(annotations), 4,
                ),
                "fragment_record_ratio": round(
                    sum(1 for item in annotations if item["fragment_likely"]) / len(annotations), 4,
                ),
                "punctuation_per_record": {
                    key: round(mean(float(item["punctuation"][key]) for item in annotations), 4)
                    for key in sorted(PUNCTUATION_KEYS)
                },
                "function_word_distribution": normalized_function,
                "source_record_digest": corpus_digest(selected),
            }
        output_profiles.append({
            "profile_id": profile_id,
            "surface": contract.get("surface"),
            "evidence_status": contract["evidence_status"],
            "primary_authorities": contract["primary_authorities"],
            "secondary_authorities": contract["secondary_authorities"],
            "excluded_voices": contract["excluded_voices"],
            "retained_traits": contract["retained_traits"],
            "intentional_departure_policy": contract.get("intentional_departure_policy", []),
            "derived_statistics": stats,
        })
    return {
        "schema_version": "1.0",
        "corpus_digest": digest,
        "profile_count": len(output_profiles),
        "profiles": output_profiles,
        "contains_source_prose": False,
    }
