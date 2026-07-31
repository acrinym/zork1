"""Shared rights contracts, safe I/O, hashes, and manifest validation.

The module intentionally uses only Python's standard library. Protected source
text remains local; public outputs contain metadata, hashes, aggregate analysis,
and receipts rather than expressive source prose.
"""

from __future__ import annotations

from hashlib import sha256
import json
from pathlib import Path
import re
from typing import Any, Iterable, Mapping, Sequence


RIGHTS_CLASSES = {"A", "B", "C", "D", "E"}
FULL_TEXT_CLASSES = {"A", "D"}
REPOSITORY_TEXT_POLICIES = {
    "full-text-verified",
    "metadata-and-derived-analysis-only",
    "metadata-only",
    "local-study-only",
}
TRANSCRIPTION_STATUSES = {
    "repository-source",
    "manifest-only",
    "local-unreviewed",
    "local-corrected",
    "repository-text",
}
ANNOTATION_STATUSES = {
    "none",
    "extractable",
    "local-annotated",
    "derived-profile-qualified",
}
ARTIFACT_TYPES = {
    "game-source",
    "manual",
    "reference-card",
    "sample-transcript",
    "package-copy",
    "feelie",
    "hint-booklet",
    "hint-map",
    "collection-documentation",
    "advertisement",
    "readme",
}
SURFACES = {
    "room-title",
    "room-description",
    "object-name",
    "object-description",
    "parser-refusal",
    "death",
    "action-response",
    "actor-dialogue",
    "institutional-document",
    "manual",
    "sample-transcript",
    "hint-question",
    "hint-answer",
    "unclassified-player-visible",
}
PLAYER_STRING_HEADS = {
    "DESC", "LDESC", "FDESC", "TEXT", "TELL", "TELL-CR",
    "PRINT", "PRINTI", "PRINTB", "DPRINT",
}
ENTITY_HEADS = {"ROOM", "OBJECT", "ROUTINE"}
INCLUDE_RE = re.compile(r'<INSERT-FILE\s+"([^"]+)"', re.IGNORECASE)
WORD_RE = re.compile(r"[A-Za-z]+(?:'[A-Za-z]+)?")
SENTENCE_RE = re.compile(r"(?<=[.!?])\s+")
SHA256_RE = re.compile(r"^[0-9a-f]{64}$")
GIT_SHA_RE = re.compile(r"^[0-9a-f]{40}$")
SAFE_ID_RE = re.compile(r"^[a-z0-9][a-z0-9._-]*$")
SAFE_REFERENCE_PART = r"(?:p(?:age)?\.?\s*\d+(?:[-–]\d+)?|line\s+\d+(?:[-–]\d+)?|surface:[a-z0-9._-]+|block:[a-z0-9._-]+)"
SAFE_REFERENCE_RE = re.compile(
    rf"^{SAFE_REFERENCE_PART}(?:\s*(?:,|/)\s*{SAFE_REFERENCE_PART})*$",
    re.IGNORECASE,
)

FUNCTION_WORDS = {
    "a", "an", "and", "are", "as", "at", "be", "because", "been", "but", "by",
    "can", "could", "did", "do", "does", "for", "from", "had", "has", "have",
    "he", "her", "him", "his", "i", "if", "in", "into", "is", "it", "its",
    "may", "might", "must", "no", "not", "of", "on", "or", "our", "she",
    "should", "so", "some", "than", "that", "the", "their", "them", "then",
    "there", "these", "they", "this", "those", "to", "was", "we", "were",
    "what", "when", "where", "which", "who", "will", "with", "would", "you",
    "your",
}
SECOND_PERSON = {"you", "your", "yours", "yourself"}
SENSORY_MARKERS = {
    "visual": {"see", "look", "light", "dark", "bright", "color", "shadow", "glow"},
    "auditory": {"hear", "sound", "noise", "silent", "echo", "voice", "sing"},
    "olfactory": {"smell", "odor", "scent", "stink", "fragrant"},
    "tactile": {"feel", "rough", "smooth", "cold", "warm", "hot", "damp", "wet"},
    "gustatory": {"taste", "bitter", "sweet", "salty", "sour"},
}
STANCE_MARKERS = {
    "ominous-understatement": {"unfortunate", "danger", "dangerous", "dark", "death", "dead", "doom"},
    "dry-judgment": {"obvious", "obviously", "foolish", "ridiculous", "absurd", "pointless"},
    "mock-sympathy": {"sorry", "pity", "regrettable", "unfortunately"},
    "bureaucratic-impersonality": {"hereby", "authorized", "regulation", "pursuant", "official"},
}
PARSER_MARKERS = {
    "unknown-word": {"unknown", "word", "vocabulary", "understand"},
    "missing-noun": {"what", "which"},
    "impossible-action": {"can't", "cannot", "impossible", "unable"},
    "already-done": {"already"},
    "physical-obstruction": {"blocked", "closed", "locked", "too", "heavy"},
    "dangerous-refusal": {"dangerous", "fatal", "kill", "death"},
}
COMEDY_MARKERS = {
    "understatement": {"merely", "slightly", "somewhat", "unfortunate"},
    "over-specificity": {"exactly", "precisely", "specifically"},
    "narrator-impatience": {"again", "still", "already"},
    "player-culpability": {"your", "you"},
    "bureaucratic-absurdity": {"form", "authorized", "official", "regulation"},
}
PUNCTUATION_KEYS = {
    "comma", "semicolon", "colon", "dash", "parenthetical_open",
    "question", "exclamation", "ellipsis",
}
ANNOTATION_REQUIRED_KEYS = {
    "schema_version", "word_count", "sentence_count", "sentence_words_mean",
    "sentence_words_max", "type_token_ratio", "function_word_ratio",
    "second_person_count", "second_person_present", "fragment_likely",
    "punctuation", "sensory_channels", "narrator_stance_markers",
    "parser_behavior", "comedy_mechanics_markers",
}


class CorpusError(RuntimeError):
    """Report invalid corpus input or an unsafe rights transition."""


def _sha256_bytes(data: bytes) -> str:
    """Return a lowercase SHA-256 digest for bytes."""
    return sha256(data).hexdigest()


def sha256_file(path: Path) -> str:
    """Hash a file without decoding or retaining its contents."""
    return _sha256_bytes(path.read_bytes())


def stable_json_sha(value: Any) -> str:
    """Hash deterministic compact JSON for a JSON-compatible value."""
    encoded = json.dumps(value, sort_keys=True, separators=(",", ":")).encode("utf-8")
    return _sha256_bytes(encoded)


def corpus_digest(records: Sequence[Mapping[str, Any]]) -> str:
    """Return the canonical digest shared by extraction, profiles, and receipts."""
    return stable_json_sha([
        {
            "record_id": record.get("record_id"),
            "text_sha256": record.get("text_sha256"),
        }
        for record in records
    ])


def read_json(path: Path) -> Any:
    """Read UTF-8 JSON and normalize parser and decoding errors."""
    try:
        return json.loads(path.read_text(encoding="utf-8", errors="strict"))
    except (OSError, UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise CorpusError(f"cannot read JSON {path}: {exc}") from exc


def write_json(path: Path, value: Any) -> None:
    """Write deterministic, reviewable UTF-8 JSON."""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def read_jsonl(path: Path) -> list[dict[str, Any]]:
    """Read a UTF-8 JSONL file whose rows must be objects."""
    rows: list[dict[str, Any]] = []
    try:
        with path.open("r", encoding="utf-8", errors="strict") as handle:
            for line_number, line in enumerate(handle, 1):
                if not line.strip():
                    continue
                try:
                    value = json.loads(line)
                except json.JSONDecodeError as exc:
                    raise CorpusError(f"{path}:{line_number}: invalid JSON: {exc}") from exc
                if not isinstance(value, dict):
                    raise CorpusError(f"{path}:{line_number}: record must be a JSON object")
                rows.append(value)
    except (OSError, UnicodeDecodeError) as exc:
        raise CorpusError(f"cannot read JSONL {path}: {exc}") from exc
    return rows


def write_jsonl(path: Path, rows: Iterable[Mapping[str, Any]]) -> None:
    """Write object rows as UTF-8 JSONL without ASCII escaping."""
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as handle:
        for row in rows:
            handle.write(json.dumps(dict(row), sort_keys=True, ensure_ascii=False) + "\n")


def _require(mapping: Mapping[str, Any], key: str, expected: type, where: str) -> Any:
    """Read one required key with a concrete runtime type."""
    value = mapping.get(key)
    if not isinstance(value, expected):
        raise CorpusError(f"{where}.{key} must be {expected.__name__}")
    return value


def _require_id(value: Any, where: str) -> str:
    """Validate and return a stable lowercase identifier."""
    if not isinstance(value, str) or not SAFE_ID_RE.fullmatch(value):
        raise CorpusError(f"{where} must be a lowercase stable ID")
    return value


def validate_artifact(artifact: Mapping[str, Any]) -> None:
    """Validate edition metadata, rights gates, and processing policy."""
    artifact_id = _require_id(artifact.get("artifact_id"), "artifact.artifact_id")
    _require_id(artifact.get("product_id"), f"{artifact_id}.product_id")
    title = _require(artifact, "title", str, artifact_id)
    if not title:
        raise CorpusError(f"{artifact_id}.title cannot be empty")
    artifact_type = _require(artifact, "artifact_type", str, artifact_id)
    if artifact_type not in ARTIFACT_TYPES:
        raise CorpusError(f"{artifact_id}.artifact_type is unsupported: {artifact_type}")

    edition = _require(artifact, "edition", dict, artifact_id)
    if not _require(edition, "label", str, f"{artifact_id}.edition"):
        raise CorpusError(f"{artifact_id}.edition.label cannot be empty")
    certainty = _require(edition, "certainty", str, f"{artifact_id}.edition")
    if certainty not in {"repository-observed", "catalog-confirmed", "family-confirmed", "unresolved"}:
        raise CorpusError(f"{artifact_id}.edition.certainty is invalid")
    if not _require(edition, "language", str, f"{artifact_id}.edition"):
        raise CorpusError(f"{artifact_id}.edition.language cannot be empty")

    source = _require(artifact, "source", dict, artifact_id)
    source_kind = _require(source, "kind", str, f"{artifact_id}.source")
    if source_kind not in {"repository", "physical-local", "external-catalog", "permissioned-preservation", "unknown"}:
        raise CorpusError(f"{artifact_id}.source.kind is invalid")
    repository_path = source.get("repository_path")
    local_source_path = source.get("local_source_path")
    if repository_path is not None and not isinstance(repository_path, str):
        raise CorpusError(f"{artifact_id}.source.repository_path must be string or null")
    if local_source_path is not None:
        if not isinstance(local_source_path, str):
            raise CorpusError(f"{artifact_id}.source.local_source_path must be string or null")
        normalized = Path(local_source_path).as_posix()
        if not normalized.startswith(".local/infocom-corpus/"):
            raise CorpusError(
                f"{artifact_id}.source.local_source_path must remain below .local/infocom-corpus/"
            )
    source_sha = source.get("sha256")
    if source_sha is not None and (not isinstance(source_sha, str) or not SHA256_RE.fullmatch(source_sha)):
        raise CorpusError(f"{artifact_id}.source.sha256 must be a lowercase SHA-256 or null")
    git_blob_sha = source.get("git_blob_sha")
    if git_blob_sha is not None and (not isinstance(git_blob_sha, str) or not GIT_SHA_RE.fullmatch(git_blob_sha)):
        raise CorpusError(f"{artifact_id}.source.git_blob_sha must be a Git SHA or null")

    rights = _require(artifact, "rights", dict, artifact_id)
    rights_class = _require(rights, "class", str, f"{artifact_id}.rights")
    if rights_class not in RIGHTS_CLASSES:
        raise CorpusError(f"{artifact_id}.rights.class must be A-E")
    if not _require(rights, "basis", str, f"{artifact_id}.rights"):
        raise CorpusError(f"{artifact_id}.rights.basis cannot be empty")
    verification = _require(rights, "verification", str, f"{artifact_id}.rights")
    policy = _require(rights, "repository_text_policy", str, f"{artifact_id}.rights")
    if policy not in REPOSITORY_TEXT_POLICIES:
        raise CorpusError(f"{artifact_id}.rights.repository_text_policy is invalid")
    full_text_allowed = rights.get("full_text_allowed")
    if not isinstance(full_text_allowed, bool):
        raise CorpusError(f"{artifact_id}.rights.full_text_allowed must be boolean")
    if full_text_allowed and not (
        rights_class in FULL_TEXT_CLASSES
        and verification == "verified-for-this-repository"
        and policy == "full-text-verified"
    ):
        raise CorpusError(
            f"{artifact_id}: full text requires rights class A or D, "
            "verified-for-this-repository, and full-text-verified"
        )
    if repository_path and artifact_type != "game-source" and not full_text_allowed:
        raise CorpusError(f"{artifact_id}: protected document cannot declare a repository full-text path")

    processing = _require(artifact, "processing", dict, artifact_id)
    transcription = _require(processing, "transcription_status", str, f"{artifact_id}.processing")
    annotation = _require(processing, "annotation_status", str, f"{artifact_id}.processing")
    if transcription not in TRANSCRIPTION_STATUSES:
        raise CorpusError(f"{artifact_id}.processing.transcription_status is invalid")
    if annotation not in ANNOTATION_STATUSES:
        raise CorpusError(f"{artifact_id}.processing.annotation_status is invalid")
    public_output = _require(processing, "public_output", str, f"{artifact_id}.processing")
    if public_output not in {
        "full-text-and-analysis", "statistics-hashes-and-references", "metadata-only",
    }:
        raise CorpusError(f"{artifact_id}.processing.public_output is invalid")
    if not full_text_allowed and public_output == "full-text-and-analysis":
        raise CorpusError(f"{artifact_id}: public full text conflicts with rights gate")


def validate_manifest(manifest: Mapping[str, Any]) -> dict[str, Any]:
    """Validate a complete corpus manifest and return its public summary."""
    if manifest.get("schema_version") != "1.0":
        raise CorpusError("manifest.schema_version must be 1.0")
    corpus_id = _require_id(manifest.get("corpus_id"), "manifest.corpus_id")
    if not _require(manifest, "title", str, "manifest"):
        raise CorpusError("manifest.title cannot be empty")
    selected = _require(manifest, "selected_game_source", dict, "manifest")
    selected_id = _require_id(selected.get("artifact_id"), "manifest.selected_game_source.artifact_id")
    entrypoint = _require(selected, "entrypoint", str, "manifest.selected_game_source")
    if Path(entrypoint).is_absolute() or ".." in Path(entrypoint).parts:
        raise CorpusError("selected game source entrypoint must be repository-relative")
    artifacts = _require(manifest, "artifacts", list, "manifest")
    if not artifacts:
        raise CorpusError("manifest.artifacts must not be empty")
    ids: set[str] = set()
    for item in artifacts:
        if not isinstance(item, dict):
            raise CorpusError("each manifest artifact must be an object")
        validate_artifact(item)
        artifact_id = item["artifact_id"]
        if artifact_id in ids:
            raise CorpusError(f"duplicate artifact_id: {artifact_id}")
        ids.add(artifact_id)
    if selected_id not in ids:
        raise CorpusError(f"selected source {selected_id} is not present in artifacts")
    source_artifact = next(item for item in artifacts if item["artifact_id"] == selected_id)
    if source_artifact["artifact_type"] != "game-source":
        raise CorpusError("selected source artifact must have artifact_type game-source")
    if source_artifact["source"].get("repository_path") != entrypoint:
        raise CorpusError("selected source entrypoint must match source artifact repository_path")

    authority_order = _require(manifest, "authority_order", list, "manifest")
    if not all(isinstance(item, str) and item for item in authority_order):
        raise CorpusError("manifest.authority_order must contain non-empty strings")
    if len(authority_order) < 6 or len(set(authority_order)) != len(authority_order):
        raise CorpusError("manifest.authority_order must contain six or more unique tiers")

    return {
        "corpus_id": corpus_id,
        "artifact_count": len(artifacts),
        "rights_counts": {
            key: sum(1 for item in artifacts if item["rights"]["class"] == key)
            for key in sorted(RIGHTS_CLASSES)
        },
        "full_text_artifact_count": sum(
            1 for item in artifacts if item["rights"]["full_text_allowed"]
        ),
        "selected_game_source": selected_id,
        "manifest_sha256": stable_json_sha(manifest),
    }


def artifact_by_id(manifest: Mapping[str, Any], artifact_id: str) -> Mapping[str, Any]:
    """Return one artifact by stable identifier."""
    for artifact in manifest.get("artifacts", []):
        if artifact.get("artifact_id") == artifact_id:
            return artifact
    raise CorpusError(f"artifact not found: {artifact_id}")


def rights_allow_text_export(artifact: Mapping[str, Any]) -> bool:
    """Return whether all three full-text publication gates are satisfied."""
    rights = artifact["rights"]
    return (
        rights["class"] in FULL_TEXT_CLASSES
        and rights["full_text_allowed"] is True
        and rights["verification"] == "verified-for-this-repository"
        and rights["repository_text_policy"] == "full-text-verified"
    )


def ensure_output_policy(output: Path, repo_root: Path, artifact: Mapping[str, Any]) -> None:
    """Reject protected full-text output outside the ignored local corpus root."""
    output_resolved = output.resolve()
    repo_resolved = repo_root.resolve()
    try:
        relative = output_resolved.relative_to(repo_resolved)
    except ValueError:
        return
    if relative.parts[:2] == (".local", "infocom-corpus"):
        return
    if not rights_allow_text_export(artifact):
        raise CorpusError(
            "full extracted text may only be written under .local/infocom-corpus/ "
            "unless the manifest grants verified repository full-text rights"
        )
