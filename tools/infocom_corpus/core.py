"""Public compatibility facade for the Infocom Corpus Foundation."""

from ._base import (
    ANNOTATION_STATUSES, ARTIFACT_TYPES, FULL_TEXT_CLASSES, REPOSITORY_TEXT_POLICIES,
    RIGHTS_CLASSES, SURFACES, TRANSCRIPTION_STATUSES, CorpusError, artifact_by_id,
    corpus_digest, ensure_output_policy, read_json, read_jsonl, rights_allow_text_export,
    sha256_file, stable_json_sha, validate_artifact, validate_manifest, write_json,
    write_jsonl,
)
from ._zil import (
    Frame, Token, classify_surface, default_authority_profile, discover_zil_lineage,
    extract_player_visible_strings, lex_zil, resolve_include,
)
from ._profiles import (
    annotate_records, annotate_text, derive_profiles, load_profiles, tokenize_words,
)
from ._originality import (
    build_style_receipt, check_overlap, fingerprint_local_artifact,
    public_summary_from_records, validate_correction_records,
)

__all__ = [
    "ANNOTATION_STATUSES", "ARTIFACT_TYPES", "FULL_TEXT_CLASSES",
    "REPOSITORY_TEXT_POLICIES", "RIGHTS_CLASSES", "SURFACES",
    "TRANSCRIPTION_STATUSES", "CorpusError", "Frame", "Token",
    "annotate_records", "annotate_text", "artifact_by_id", "build_style_receipt",
    "check_overlap", "classify_surface", "corpus_digest",
    "default_authority_profile", "derive_profiles", "discover_zil_lineage",
    "ensure_output_policy", "extract_player_visible_strings",
    "fingerprint_local_artifact", "lex_zil", "load_profiles",
    "public_summary_from_records", "read_json", "read_jsonl", "resolve_include",
    "rights_allow_text_export", "sha256_file", "stable_json_sha", "tokenize_words",
    "validate_artifact", "validate_correction_records", "validate_manifest",
    "write_json", "write_jsonl",
]
