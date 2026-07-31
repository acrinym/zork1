"""ZIL lineage discovery, tokenization, and player-visible extraction."""

from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Iterator, Sequence

from ._base import (
    CorpusError, ENTITY_HEADS, INCLUDE_RE, PLAYER_STRING_HEADS,
    _sha256_bytes, corpus_digest,
)


@dataclass(frozen=True)
class Token:
    """Represent one token and its decoded-character source span."""

    kind: str
    value: str
    line: int
    column: int
    offset: int
    end_line: int
    end_offset: int


@dataclass
class Frame:
    """Track one open ZIL angle or parenthesized form."""

    delimiter: str
    head: str | None = None
    atoms: list[str] = field(default_factory=list)

    @property
    def name(self) -> str | None:
        """Return the second atom, which is the entity or routine name."""
        return self.atoms[1] if len(self.atoms) > 1 else None


def resolve_include(repo_root: Path, requested: str) -> Path:
    """Resolve a historical include case-insensitively and below the repo root."""
    requested_path = Path(requested)
    names = [requested_path.name]
    if requested_path.suffix == "":
        names.extend([requested_path.name + ".zil", requested_path.name + ".ZIL"])
    parent = repo_root / requested_path.parent
    for name in names:
        candidate = parent / name
        if candidate.is_file():
            return candidate.resolve()
    lower_names = {name.lower() for name in names}
    candidates = []
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


def _read_utf8(path: Path, purpose: str) -> str:
    """Read strict UTF-8 and report the failing path through CorpusError."""
    try:
        return path.read_text(encoding="utf-8", errors="strict")
    except UnicodeDecodeError as exc:
        raise CorpusError(f"{purpose} is not valid UTF-8: {path}: {exc}") from exc
    except OSError as exc:
        raise CorpusError(f"cannot read {purpose} {path}: {exc}") from exc


def discover_zil_lineage(repo_root: Path, entrypoint: str) -> list[Path]:
    """Discover the recursive INSERT-FILE lineage in deterministic order."""
    root = repo_root.resolve()
    first = resolve_include(root, entrypoint)
    ordered: list[Path] = []
    visited: set[Path] = set()

    def visit(path: Path) -> None:
        """Visit one lineage file and then its first-seen includes."""
        path = path.resolve()
        if path in visited:
            return
        try:
            path.relative_to(root)
        except ValueError as exc:
            raise CorpusError(f"include escaped repository root: {path}") from exc
        visited.add(path)
        ordered.append(path)
        text = _read_utf8(path, "ZIL source")
        for match in INCLUDE_RE.finditer(text):
            visit(resolve_include(root, match.group(1)))

    visit(first)
    return ordered


def lex_zil(text: str) -> Iterator[Token]:
    """Yield comments-free ZIL tokens while correctly consuming quote escapes."""
    line = 1
    column = 1
    i = 0
    size = len(text)

    def advance(segment: str) -> tuple[int, int]:
        """Advance decoded-character line and column counters."""
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
                "<": "open-angle", ">": "close-angle",
                "(": "open-paren", ")": "close-paren",
            }[char]
            advance(char)
            i += 1
            yield Token(kind, char, start_line, start_column, start_offset, line, i)
            continue

        if char == '"':
            i += 1
            advance('"')
            pieces: list[str] = []
            while i < size:
                current = text[i]
                if current == '"':
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
                "string", "".join(pieces), start_line, start_column,
                start_offset, line, i,
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
    """Return the nearest open frame whose head belongs to heads."""
    for frame in reversed(stack):
        if frame.head in heads:
            return frame
    return None


def _nearest_entity(stack: Sequence[Frame]) -> Frame | None:
    """Return the nearest ROOM, OBJECT, or ROUTINE frame."""
    return _nearest_frame(stack, ENTITY_HEADS)


def _nearest_routine(stack: Sequence[Frame]) -> str | None:
    """Return the nearest routine name in uppercase."""
    frame = _nearest_frame(stack, {"ROUTINE"})
    return frame.name.upper() if frame and frame.name else None


def classify_surface(context_head: str, entity: Frame | None, routine: str | None) -> str:
    """Classify one player-visible string into a named prose surface."""
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
    """Map a prose surface to its default authority contract."""
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


def _utf8_offset_table(text: str) -> list[int]:
    """Map each decoded-character index to its UTF-8 byte offset."""
    offsets = [0]
    total = 0
    for character in text:
        total += len(character.encode("utf-8"))
        offsets.append(total)
    return offsets


def extract_player_visible_strings(
    repo_root: Path,
    entrypoint: str,
    artifact_id: str,
) -> tuple[list[dict[str, Any]], dict[str, Any]]:
    """Extract traceable player-visible strings from one recursive ZIL lineage."""
    root = repo_root.resolve()
    lineage = discover_zil_lineage(root, entrypoint)
    records: list[dict[str, Any]] = []
    source_files: list[dict[str, Any]] = []

    for path in lineage:
        try:
            raw_bytes = path.read_bytes()
        except OSError as exc:
            raise CorpusError(f"cannot read ZIL source {path}: {exc}") from exc
        try:
            text = raw_bytes.decode("utf-8", errors="strict")
        except UnicodeDecodeError as exc:
            raise CorpusError(f"ZIL source is not valid UTF-8: {path}: {exc}") from exc
        byte_offsets = _utf8_offset_table(text)
        relative = path.relative_to(root).as_posix()
        file_sha = _sha256_bytes(raw_bytes)
        source_files.append({"path": relative, "sha256": file_sha, "bytes": len(raw_bytes)})
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
            normalized_text = token.value.replace("\r\n", "\n").replace("\r", "\n")
            if not normalized_text.strip():
                continue
            record_hash = _sha256_bytes(normalized_text.encode("utf-8"))
            record_id = f"{artifact_id}:{relative}:{token.line}:{record_hash[:12]}"
            records.append({
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
                    "byte_offset_start": byte_offsets[token.offset],
                    "byte_offset_end": byte_offsets[token.end_offset],
                    "context_head": context.head,
                    "entity_kind": entity.head if entity else None,
                    "entity_id": entity.name if entity and entity.name else None,
                    "routine_id": routine,
                },
            })

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
        "corpus_digest": corpus_digest(records),
        "contains_full_text": False,
    }
    return records, summary
