"""Serializable domain model for a ZIL world and its truth audit."""

from __future__ import annotations

from dataclasses import asdict, dataclass, field
from typing import Any


FORMAT_VERSION = "1.0"


@dataclass(frozen=True)
class Location:
    path: str
    line: int


@dataclass
class GrammarRule:
    words: list[str]
    template: list[str]
    action: str | None
    pre_action: str | None
    direct_object: bool
    indirect_object: bool
    constraints: list[str]
    location: Location

    @property
    def verb(self) -> str:
        return self.words[0] if self.words else ""


@dataclass
class Routine:
    id: str
    handled_verbs: list[str]
    responses: list[str]
    location: Location


@dataclass
class Entity:
    id: str
    kind: str
    container: str | None
    description: str | None
    long_descriptions: list[str]
    synonyms: list[str]
    adjectives: list[str]
    flags: list[str]
    action: str | None
    globals: list[str]
    exits: dict[str, dict[str, Any]]
    location: Location


@dataclass
class ProseReference:
    room: str
    word: str
    match_key: str
    phrase: str
    part_of_speech: str
    mapped_entities: list[str]
    status: str
    source_entity: str
    location: Location


@dataclass
class Finding:
    code: str
    severity: str
    room: str | None
    subject: str | None
    interaction: str | None
    message: str
    evidence: dict[str, Any]
    fingerprint: str = ""
    baseline: bool = False


@dataclass
class Interaction:
    room: str
    subject: str
    word: str
    verb: str
    kind: str
    status: str
    visibility: str
    basis: list[str]
    other_subject: str | None = None
    other_word: str | None = None
    actor: str | None = None
    actor_word: str | None = None
    command_template: str | None = None
    state: str = "default"


@dataclass
class WorldModel:
    source_root: str
    entrypoint: str
    source_files: list[dict[str, Any]]
    entities: list[Entity]
    grammar: list[GrammarRule]
    routines: list[Routine]
    vocabulary: dict[str, list[str]]
    duplicate_entities: list[dict[str, Any]] = field(default_factory=list)
    prose_references: list[ProseReference] = field(default_factory=list)
    interactions: list[Interaction] = field(default_factory=list)
    findings: list[Finding] = field(default_factory=list)
    format_version: str = FORMAT_VERSION

    def to_dict(self) -> dict[str, Any]:
        return asdict(self)
