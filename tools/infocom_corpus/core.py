"""Infocom corpus extraction, rights gates, annotation, and originality checks.

The module uses only Python's standard library so it can run beside the historical
ZIL source tree without adding a dependency toolchain.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from datetime import date
from difflib import SequenceMatcher
from hashlib import sha256
import json
from pathlib import Path
import re
from statistics import mean, median
from typing import Any, Iterable, Iterator, Mapping, Sequence


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
    "DESC",
    "LDESC",
    "FDESC",
    "TEXT",
    "TELL",
    "TELL-CR",
    "PRINT",
    "PRINTI",
    "PRINTB",
    "DPRINT",
}
ENTITY_HEADS = {"ROOM", "OBJECT", "ROUTINE"}
INCLUDE_RE = re.compile(r'<INSERT-FILE\s+"([^"]+)"', re.IGNORECASE)
WORD_RE = re.compile(r"[A-Za-z]+(?:'[A-Za-z]+)?")
SENTENCE_RE = re.compile(r"(?<=[.!?])\s+")
SHA256_RE = re.compile(r"^[0-9a-f]{64}$")
GIT_SHA_RE = re.compile(r"^[0-9a-f]{40}$")
SAFE_ID_RE = re.compile(r"^[a-z0-9][a-z0-9._-]*$")

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


class CorpusError(RuntimeError):
    """Raised for invalid corpus inputs or unsafe rights transitions."""


@dataclass(frozen=True)
class Token:
    kind: str
    value: str
    line: int
    column: int
    offset: int
    end_line: int
    end_offset: int


@dataclass
class Frame:
    delimiter: str
    head: str | None = None
    atoms: list[str] = field(default_factory=list)

    @property
    def name(self) -> str | None:
        return self.atoms[1] if len(self.atoms) > 1 else None


def _sha256_bytes(data: bytes) -> str:
    return sha256(data).hexdigest()


def sha256_file(path: Path) -> str:
    return _sha256_bytes(path.read_bytes())


def stable_json_sha(value: Any) -> str:
    encoded = json.dumps(value, sort_keys=True, separators=(",", ":")).encode("utf-8")
    return _sha256_bytes(encoded)


def read_json(path: Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        raise CorpusError(f"cannot read JSON {path}: {exc}") from exc


def write_json(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def read_jsonl(path: Path) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    try:
        with path.open("r", encoding="utf-8") as handle:
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
    except OSError as exc:
        raise CorpusError(f"cannot read JSONL {path}: {exc}") from exc
    return rows


def write_jsonl(path: Path, rows: Iterable[Mapping[str, Any]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as handle:
        for row in rows:
            handle.write(json.dumps(dict(row), sort_keys=True, ensure_ascii=False) + "\n")


def _require(mapping: Mapping[str, Any], key: str, expected: type, where: str) -> Any:
    value = mapping.get(key)
    if not isinstance(value, expected):
        raise CorpusError(f"{where}.{key} must be {expected.__name__}")
    return value


def _require_id(value: Any, where: str) -> str:
    if not isinstance(value, str) or not SAFE_ID_RE.fullmatch(value):
        raise CorpusError(f"{where} must be a lowercase stable ID")
    return value


def validate_artifact(artifact: Mapping[str, Any]) -> None:
    artifact_id = _require_id(artifact.get("artifact_id"), "artifact.artifact_id")
    _require_id(artifact.get("product_id"), f"{artifact_id}.product_id")
    _require(artifact, "title", str, artifact_id)
    artifact_type = _require(artifact, "artifact_type", str, artifact_id)
    if artifact_type not in ARTIFACT_TYPES:
        raise CorpusError(f"{artifact_id}.artifact_type is unsupported: {artifact_type}")

    edition = _require(artifact, "edition", dict, artifact_id)
    _require(edition, "label", str, f"{artifact_id}.edition")
    certainty = _require(edition, "certainty", str, f"{artifact_id}.edition")
    if certainty not in {"repository-observed", "catalog-confirmed", "family-confirmed", "unresolved"}:
        raise CorpusError(f"{artifact_id}.edition.certainty is invalid")
    language = _require(edition, "language", str, f"{artifact_id}.edition")
    if not language:
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
    if git_blob_sha is not None and (
        not isinstance(git_blob_sha, str) or not GIT_SHA_RE.fullmatch(git_blob_sha)
    ):
        raise CorpusError(f"{artifact_id}.source.git_blob_sha must be a Git SHA or null")

    rights = _require(artifact, "rights", dict, artifact_id)
    rights_class = _require(rights, "class", str, f"{artifact_id}.rights")
    if rights_class not in RIGHTS_CLASSES:
        raise CorpusError(f"{artifact_id}.rights.class must be A-E")
    _require(rights, "basis", str, f"{artifact_id}.rights")
    verification = _require(rights, "verification", str, f"{artifact_id}.rights")
    policy = _require(rights, "repository_text_policy", str, f"{artifact_id}.rights")
    if policy not in REPOSITORY_TEXT_POLICIES:
        raise CorpusError(f"{artifact_id}.rights.repository_text_policy is invalid")
    full_text_allowed = rights.get("full_text_allowed")
    if not isinstance(full_text_allowed, bool):
        raise CorpusError(f"{artifact_id}.rights.full_text_allowed must be boolean")
    if full_text_allowed:
        if rights_class not in FULL_TEXT_CLASSES:
            raise CorpusError(
                f"{artifact_id}: full text cannot be allowed for rights class {rights_class}"
            )
        if policy != "full-text-verified" or verification != "verified-for-this-repository":
            raise CorpusError(
                f"{artifact_id}: full text requires verified-for-this-repository and full-text-verified"
            )
    if repository_path and artifact_type != "game-source" and not full_text_allowed:
        raise CorpusError(
            f"{artifact_id}: protected document cannot declare a repository full-text path"
        )

    processing = _require(artifact, "processing", dict, artifact_id)
    transcription = _require(processing, "transcription_status", str, f"{artifact_id}.processing")
    annotation = _require(processing, "annotation_status", str, f"{artifact_id}.processing")
    if transcription not in TRANSCRIPTION_STATUSES:
        raise CorpusError(f"{artifact_id}.processing.transcription_status is invalid")
    if annotation not in ANNOTATION_STATUSES:
        raise CorpusError(f"{artifact_id}.processing.annotation_status is invalid")
    public_output = _require(processing, "public_output", str, f"{artifact_id}.processing")
    if public_output not in {
        "full-text-and-analysis",
        "statistics-hashes-and-references",
        "metadata-only",
    }:
        raise CorpusError(f"{artifact_id}.processing.public_output is invalid")
    if not full_text_allowed and public_output == "full-text-and-analysis":
        raise CorpusError(f"{artifact_id}: public full text conflicts with rights gate")


def validate_manifest(manifest: Mapping[str, Any]) -> dict[str, Any]:
    if manifest.get("schema_version") != "1.0":
        raise CorpusError("manifest.schema_version must be 1.0")
    corpus_id = _require_id(manifest.get("corpus_id"), "manifest.corpus_id")
    _require(manifest, "title", str, "manifest")
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
    for artifact in manifest.get("artifacts", []):
        if artifact.get("artifact_id") == artifact_id:
            return artifact
    raise CorpusError(f"artifact not found: {artifact_id}")


def rights_allow_text_export(artifact: Mapping[str, Any]) -> bool:
    rights = artifact["rights"]
    return (
        rights["class"] in FULL_TEXT_CLASSES
        and rights["full_text_allowed"] is True
        and rights["verification"] == "verified-for-this-repository"
        and rights["repository_text_policy"] == "full-text-verified"
    )


def ensure_output_policy(output: Path, repo_root: Path, artifact: Mapping[str, Any]) -> None:
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


def resolve_include(repo_root: Path, requested: str) -> Path:
    requested_path = Path(requested)
    candidates: list[Path] = []
    names = [requested_path.name]
    if requested_path.suffix == "":
        names.extend([requested_path.name + ".zil", requested_path.name + ".ZIL"])
    parent = repo_root / requested_path.parent
    for name in names:
        candidate = parent / name
        if candidate.is_file():
            return candidate.resolve()
    lower_names = {name.lower() for name in names}
    if parent.is_dir():
        candidates = [
            path for path in parent.iterdir()
            if path.is_file() and path.name.lower() in lower_names
        ]
    if len(candidates) == 1:
        return candidates[0].resolve()
    if not candidates:
        raise CorpusError(f"cannot resolve ZIL include {requested!r} below {repo_root}")
    raise CorpusError(f"ambiguous ZIL include {requested!r}: {candidates}")


def discover_zil_lineage(repo_root: Path, entrypoint: str) -> list[Path]:
    root = repo_root.resolve()
    first = resolve_include(root, entrypoint)
    ordered: list[Path] = []
    visited: set[Path] = set()

    def visit(path: Path) -> None:
        path = path.resolve()
        if path in visited:
            return
        try:
            path.relative_to(root)
        except ValueError as exc:
            raise CorpusError(f"include escaped repository root: {path}") from exc
        visited.add(path)
        ordered.append(path)
        text = path.read_text(encoding="utf-8", errors="strict")
        for match in INCLUDE_RE.finditer(text):
            visit(resolve_include(root, match.group(1)))

    visit(first)
    return ordered


def lex_zil(text: str) -> Iterator[Token]:
    line = 1
    column = 1
    i = 0
    size = len(text)

    def advance(segment: str) -> tuple[int, int]:
        nonlocal line, column
        newline_count = segment.count("\n")
        if newline_count:
            line += newline_count
            column = len(segment.rsplit("\n", 1)[-1]) + 1
        else:
            column += len(segment)
        return line, column

    while i < size:
        char = text[i]
        if char.isspace():
            advance(char)
            i += 1
            continue
        if char == ";":
            start = i
            while i < size and text[i] != "\n":
                i += 1
            advance(text[start:i])
            continue

        start_line, start_column, start_offset = line, column, i
        if char in "<>()":
            kind = {
                "<": "open-angle",
                ">": "close-angle",
                "(": "open-paren",
                ")": "close-paren",
            }[char]
            advance(char)
            i += 1
            yield Token(kind, char, start_line, start_column, start_offset, line, i)
            continue

        if char == '"' and (i == 0 or text[i - 1] not in {"!", "\\"}):
            i += 1
            advance('"')
            pieces: list[str] = []
            while i < size:
                current = text[i]
                if current == '"' and (i == 0 or text[i - 1] not in {"!", "\\"}):
                    advance('"')
                    i += 1
                    break
                if current in {"!", "\\"} and i + 1 < size and text[i + 1] == '"':
                    pieces.append('"')
                    segment = text[i:i + 2]
                    advance(segment)
                    i += 2
                    continue
                if current == "\\" and i + 1 < size:
                    escape = text[i + 1]
                    mapped = {"n": "\n", "t": "\t", "r": "\r", "\\": "\\"}.get(escape)
                    if mapped is not None:
                        pieces.append(mapped)
                        segment = text[i:i + 2]
                        advance(segment)
                        i += 2
                        continue
                pieces.append(current)
                advance(current)
                i += 1
            else:
                raise CorpusError(f"unterminated ZIL string at line {start_line}")
            yield Token(
                "string",
                "".join(pieces),
                start_line,
                start_column,
                start_offset,
                line,
                i,
            )
            continue

        start = i
        while i < size and not text[i].isspace() and text[i] not in '<>()";':
            i += 1
        value = text[start:i]
        advance(value)
        if value:
            yield Token("atom", value, start_line, start_column, start_offset, line, i)
        else:
            advance(char)
            i += 1


def _nearest_frame(stack: Sequence[Frame], heads: set[str]) -> Frame | None:
    for frame in reversed(stack):
        if frame.head in heads:
            return frame
    return None


def _nearest_entity(stack: Sequence[Frame]) -> Frame | None:
    return _nearest_frame(stack, ENTITY_HEADS)


def _nearest_routine(stack: Sequence[Frame]) -> str | None:
    frame = _nearest_frame(stack, {"ROUTINE"})
    return frame.name.upper() if frame and frame.name else None


def classify_surface(context_head: str, entity: Frame | None, routine: str | None) -> str:
    entity_head = entity.head if entity else None
    if context_head == "DESC":
        if entity_head == "ROOM":
            return "room-title"
        if entity_head == "OBJECT":
            return "object-name"
    if context_head in {"LDESC", "FDESC"}:
        if entity_head == "ROOM":
            return "room-description"
        if entity_head == "OBJECT":
            return "object-description"
    if context_head == "TEXT":
        return "institutional-document"
    if routine:
        upper = routine.upper()
        if any(marker in upper for marker in ("JIGS-UP", "DEAD", "DEATH", "DROWN", "KILL-PLAYER", "FINISH")):
            return "death"
        if any(marker in upper for marker in ("PARSER", "UNKNOWN", "ORPHAN", "DISAMBIG", "CANT-", "CAN'T-")):
            return "parser-refusal"
        if any(marker in upper for marker in ("ACTOR", "TROLL", "THIEF", "ROBOT", "WIZARD")):
            return "actor-dialogue"
    if context_head in {"TELL", "TELL-CR", "PRINT", "PRINTI", "PRINTB", "DPRINT"}:
        return "action-response"
    return "unclassified-player-visible"


def default_authority_profile(surface: str) -> str:
    return {
        "room-title": "zork1-narrator",
        "room-description": "zork1-narrator",
        "object-name": "zork1-object-description",
        "object-description": "zork1-object-description",
        "parser-refusal": "zork1-parser-refusal",
        "death": "zork1-death",
        "action-response": "zork1-action-response",
        "actor-dialogue": "zork1-actor-dialogue",
        "institutional-document": "gue-institutional-document",
    }.get(surface, "zork1-unclassified-player-visible")


def extract_player_visible_strings(
    repo_root: Path,
    entrypoint: str,
    artifact_id: str,
) -> tuple[list[dict[str, Any]], dict[str, Any]]:
    lineage = discover_zil_lineage(repo_root, entrypoint)
    records: list[dict[str, Any]] = []
    source_files: list[dict[str, Any]] = []

    for path in lineage:
        raw_bytes = path.read_bytes()
        text = raw_bytes.decode("utf-8")
        relative = path.relative_to(repo_root.resolve()).as_posix()
        file_sha = _sha256_bytes(raw_bytes)
        source_files.append(
            {
                "path": relative,
                "sha256": file_sha,
                "bytes": len(raw_bytes),
            }
        )
        stack: list[Frame] = []
        for token in lex_zil(text):
            if token.kind in {"open-angle", "open-paren"}:
                stack.append(Frame(delimiter=token.kind))
                continue
            if token.kind in {"close-angle", "close-paren"}:
                expected = "open-angle" if token.kind == "close-angle" else "open-paren"
                if stack and stack[-1].delimiter == expected:
                    stack.pop()
                else:
                    for index in range(len(stack) - 1, -1, -1):
                        if stack[index].delimiter == expected:
                            del stack[index:]
                            break
                continue
            if token.kind == "atom":
                if stack:
                    frame = stack[-1]
                    atom = token.value.strip().upper()
                    if atom:
                        frame.atoms.append(atom)
                        if frame.head is None:
                            frame.head = atom
                continue
            if token.kind != "string":
                continue

            context = _nearest_frame(stack, PLAYER_STRING_HEADS)
            if context is None or context.head is None:
                continue
            entity = _nearest_entity(stack)
            routine = _nearest_routine(stack)
            surface = classify_surface(context.head, entity, routine)
            entity_id = entity.name if entity and entity.name else None
            normalized_text = token.value.replace("\r\n", "\n").replace("\r", "\n")
            if not normalized_text.strip():
                continue
            record_hash = _sha256_bytes(normalized_text.encode("utf-8"))
            record_id = (
                f"{artifact_id}:{relative}:{token.line}:"
                f"{record_hash[:12]}"
            )
            records.append(
                {
                    "schema_version": "1.0",
                    "record_id": record_id,
                    "artifact_id": artifact_id,
                    "authority_profile": default_authority_profile(surface),
                    "surface": surface,
                    "text": normalized_text,
                    "text_sha256": record_hash,
                    "source": {
                        "path": relative,
                        "file_sha256": file_sha,
                        "line_start": token.line,
                        "line_end": token.end_line,
                        "byte_offset_start": token.offset,
                        "byte_offset_end": token.end_offset,
                        "context_head": context.head,
                        "entity_kind": entity.head if entity else None,
                        "entity_id": entity_id,
                        "routine_id": routine,
                    },
                }
            )

    corpus_digest = stable_json_sha(
        [
            {
                "record_id": record["record_id"],
                "text_sha256": record["text_sha256"],
                "source": record["source"],
            }
            for record in records
        ]
    )
    summary = {
        "schema_version": "1.0",
        "artifact_id": artifact_id,
        "entrypoint": entrypoint,
        "source_files": source_files,
        "source_file_count": len(source_files),
        "record_count": len(records),
        "surface_counts": {
            surface: sum(1 for record in records if record["surface"] == surface)
            for surface in sorted({record["surface"] for record in records})
        },
        "authority_profile_counts": {
            profile: sum(1 for record in records if record["authority_profile"] == profile)
            for profile in sorted({record["authority_profile"] for record in records})
        },
        "corpus_digest": corpus_digest,
        "contains_full_text": False,
    }
    return records, summary


def tokenize_words(text: str) -> list[str]:
    return [match.group(0).lower() for match in WORD_RE.finditer(text)]


def annotate_text(text: str, surface: str) -> dict[str, Any]:
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
        channel
        for channel, markers in SENSORY_MARKERS.items()
        if word_set.intersection(markers)
    ]
    stance = [
        label
        for label, markers in STANCE_MARKERS.items()
        if word_set.intersection(markers)
    ]
    parser_behavior: list[str] = []
    if surface == "parser-refusal":
        parser_behavior = [
            label
            for label, markers in PARSER_MARKERS.items()
            if word_set.intersection(markers)
        ] or ["reasonable-but-unsupported-action"]
    comedy = [
        label
        for label, markers in COMEDY_MARKERS.items()
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
    annotated: list[dict[str, Any]] = []
    for record in records:
        text = record.get("text")
        surface = record.get("surface")
        if not isinstance(text, str) or surface not in SURFACES:
            raise CorpusError(f"record {record.get('record_id')} lacks valid text or surface")
        copy = dict(record)
        copy["annotation"] = annotate_text(text, surface)
        annotated.append(copy)
    return annotated


def load_profiles(path: Path) -> dict[str, dict[str, Any]]:
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


def derive_profiles(
    records: Sequence[Mapping[str, Any]],
    profile_contracts: Mapping[str, Mapping[str, Any]],
    corpus_digest: str,
) -> dict[str, Any]:
    output_profiles: list[dict[str, Any]] = []
    for profile_id, contract in sorted(profile_contracts.items()):
        selected = [
            record for record in records
            if record.get("authority_profile") == profile_id
        ]
        annotations = [
            record.get("annotation") or annotate_text(
                str(record.get("text", "")), str(record.get("surface", "unclassified-player-visible"))
            )
            for record in selected
        ]
        words = [
            word
            for record in selected
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
                "word_count": sum(item["word_count"] for item in annotations),
                "sentence_words_mean": round(
                    mean(item["sentence_words_mean"] for item in annotations), 3
                ),
                "sentence_words_median": round(
                    median(item["sentence_words_mean"] for item in annotations), 3
                ),
                "second_person_record_ratio": round(
                    sum(1 for item in annotations if item["second_person_present"]) / len(annotations),
                    4,
                ),
                "fragment_record_ratio": round(
                    sum(1 for item in annotations if item["fragment_likely"]) / len(annotations),
                    4,
                ),
                "punctuation_per_record": {
                    key: round(
                        mean(item["punctuation"][key] for item in annotations), 4
                    )
                    for key in sorted(annotations[0]["punctuation"])
                },
                "function_word_distribution": normalized_function,
                "source_record_digest": stable_json_sha(
                    [
                        {
                            "record_id": record["record_id"],
                            "text_sha256": record["text_sha256"],
                        }
                        for record in selected
                    ]
                ),
            }
        output_profiles.append(
            {
                "profile_id": profile_id,
                "surface": contract.get("surface"),
                "evidence_status": contract["evidence_status"],
                "primary_authorities": contract["primary_authorities"],
                "secondary_authorities": contract["secondary_authorities"],
                "excluded_voices": contract["excluded_voices"],
                "retained_traits": contract["retained_traits"],
                "intentional_departure_policy": contract.get("intentional_departure_policy", []),
                "derived_statistics": stats,
            }
        )
    return {
        "schema_version": "1.0",
        "corpus_digest": corpus_digest,
        "profile_count": len(output_profiles),
        "profiles": output_profiles,
        "contains_source_prose": False,
    }


def _longest_match(candidate: Sequence[str], source: Sequence[str]) -> tuple[int, int, int]:
    match = SequenceMatcher(None, candidate, source, autojunk=False).find_longest_match(
        0, len(candidate), 0, len(source)
    )
    return match.size, match.a, match.b


def _normalized_phrase(text: str) -> tuple[str, ...]:
    return tuple(tokenize_words(text))


def _phrase_allowed(tokens: Sequence[str], allowed: set[tuple[str, ...]]) -> bool:
    phrase = tuple(tokens)
    return phrase in allowed


def check_overlap(
    candidate_text: str,
    records: Sequence[Mapping[str, Any]],
    *,
    max_allowed_tokens: int = 6,
    rare_ngram_tokens: int = 5,
    allowed_phrases: Sequence[str] = (),
) -> dict[str, Any]:
    if max_allowed_tokens < 3:
        raise CorpusError("max_allowed_tokens must be at least 3")
    if rare_ngram_tokens < 3:
        raise CorpusError("rare_ngram_tokens must be at least 3")
    candidate = tokenize_words(candidate_text)
    allowed = {_normalized_phrase(item) for item in allowed_phrases if item.strip()}
    longest: dict[str, Any] | None = None
    corpus_ngram_sources: dict[tuple[str, ...], set[str]] = {}

    for record in records:
        source_text = record.get("text")
        record_id = record.get("record_id")
        if not isinstance(source_text, str) or not isinstance(record_id, str):
            raise CorpusError("overlap corpus records require text and record_id")
        source_tokens = tokenize_words(source_text)
        size, candidate_start, source_start = _longest_match(candidate, source_tokens)
        if size and (longest is None or size > longest["tokens"]):
            matched = candidate[candidate_start:candidate_start + size]
            longest = {
                "tokens": size,
                "candidate_token_start": candidate_start,
                "candidate_token_end": candidate_start + size,
                "candidate_span_sha256": stable_json_sha(matched),
                "source_record_id": record_id,
                "source_token_start": source_start,
                "source_span_sha256": stable_json_sha(
                    source_tokens[source_start:source_start + size]
                ),
                "allowed_exact_phrase": _phrase_allowed(matched, allowed),
            }
        if len(source_tokens) >= rare_ngram_tokens:
            for index in range(len(source_tokens) - rare_ngram_tokens + 1):
                phrase = tuple(source_tokens[index:index + rare_ngram_tokens])
                corpus_ngram_sources.setdefault(phrase, set()).add(record_id)

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
            rare_matches.append(
                {
                    "candidate_token_start": index,
                    "candidate_token_end": index + rare_ngram_tokens,
                    "span_sha256": stable_json_sha(phrase),
                    "source_record_ids": sorted(source_ids),
                    "source_count": len(source_ids),
                }
            )

    longest_tokens = longest["tokens"] if longest else 0
    longest_violation = bool(
        longest
        and longest_tokens > max_allowed_tokens
        and not longest["allowed_exact_phrase"]
    )
    passed = not longest_violation and not rare_matches
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
        "rare_phrase_matches": rare_matches,
        "passed": passed,
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
    profile_id = _require_id(profile.get("profile_id"), "profile.profile_id")
    if not surface_family.strip():
        raise CorpusError("surface_family cannot be empty")
    if not reviewer.strip():
        raise CorpusError("reviewer cannot be empty")
    if not overlap.get("passed"):
        raise CorpusError("cannot issue a passing style receipt for failed overlap validation")
    for key in ("primary_authorities", "excluded_voices", "retained_traits"):
        values = profile.get(key)
        if not isinstance(values, list) or not values:
            raise CorpusError(f"profile {profile_id} lacks {key}")
    return {
        "schema_version": "1.0",
        "receipt_id": (
            f"{surface_family}-{_sha256_bytes(candidate_text.encode('utf-8'))[:12]}"
        ),
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
        "intentional_departures": list(intentional_departures),
        "originality_check": {
            "corpus_digest": corpus_digest,
            "candidate_sha256": overlap["candidate_sha256"],
            "longest_source_overlap_tokens": (
                overlap["longest_overlap"]["tokens"]
                if overlap.get("longest_overlap")
                else 0
            ),
            "rare_phrase_match_count": len(overlap.get("rare_phrase_matches", [])),
            "thresholds": overlap["thresholds"],
            "passed": True,
            "source_text_disclosed": False,
        },
        "reviewed_by": reviewer,
        "reviewed_on": date.today().isoformat(),
    }


def fingerprint_local_artifact(
    path: Path,
    artifact_id: str,
    *,
    page_count: int | None = None,
    page_references: Sequence[str] = (),
) -> dict[str, Any]:
    if not path.is_file():
        raise CorpusError(f"local artifact does not exist: {path}")
    if page_count is not None and page_count < 1:
        raise CorpusError("page_count must be positive")
    return {
        "schema_version": "1.0",
        "artifact_id": artifact_id,
        "source_sha256": sha256_file(path),
        "byte_size": path.stat().st_size,
        "page_count": page_count,
        "page_references": list(page_references),
        "safe_to_commit": True,
        "contains_source_text": False,
    }


def validate_correction_records(
    records: Sequence[Mapping[str, Any]],
    manifest: Mapping[str, Any],
) -> dict[str, Any]:
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
        if not any(location.get(key) is not None for key in ("page", "surface", "block_id", "line")):
            raise CorpusError(f"{where}.location requires page, surface, block_id, or line")
        for key in ("observed_sha256", "corrected_sha256"):
            value = _require(record, key, str, where)
            if not SHA256_RE.fullmatch(value):
                raise CorpusError(f"{where}.{key} must be SHA-256")
        _require(record, "reason", str, where)
        confidence = record.get("confidence")
        if confidence not in {"certain", "probable", "uncertain"}:
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
        "corpus_digest": stable_json_sha(
            [
                {
                    "record_id": row.get("record_id"),
                    "text_sha256": row.get("text_sha256"),
                }
                for row in records
            ]
        ),
        "contains_source_text": False,
    }
