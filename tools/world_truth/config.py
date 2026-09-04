"""Project policy and authored truth contracts."""

from __future__ import annotations

import tomllib
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any


@dataclass
class State:
    id: str
    room: str
    setup: list[str]
    expected_title: str | None = None
    light: str = "unspecified"
    inventory: list[str] = field(default_factory=list)
    visible: list[str] = field(default_factory=list)
    hidden: list[str] = field(default_factory=list)
    open_subjects: list[str] = field(default_factory=list)
    closed_subjects: list[str] = field(default_factory=list)


@dataclass
class Expectation:
    room: str
    subject: str
    verbs: list[str]
    rationale: str
    state: str = "default"
    required_response: list[str] = field(default_factory=lambda: ["recognized-specific"])
    kind: str = "object"
    other_subject: str | None = None
    actor: str | None = None
    command_template: str | None = None


@dataclass
class ProbeRule:
    verbs: list[str]
    allowed: list[str]
    flags_any: list[str] = field(default_factory=list)
    kinds: list[str] = field(default_factory=list)


@dataclass
class Ignore:
    code: str
    room: str | None = None
    subject: str | None = None
    word: str | None = None
    rationale: str = ""


@dataclass
class TruthConfig:
    states: list[State] = field(default_factory=list)
    expectations: list[Expectation] = field(default_factory=list)
    ignores: list[Ignore] = field(default_factory=list)
    probe_rules: list[ProbeRule] = field(default_factory=list)
    policy: dict[str, Any] = field(default_factory=dict)


def _strings(value: object, label: str) -> list[str]:
    if not isinstance(value, list) or not all(isinstance(item, str) for item in value):
        raise ValueError(f"{label} must be an array of strings")
    return list(value)


def load_config(path: Path | None) -> TruthConfig:
    if path is None or not path.exists():
        return TruthConfig()
    data = tomllib.loads(path.read_text(encoding="utf-8"))
    if data.get("format_version", 1) != 1:
        raise ValueError("world truth config format_version must be 1")
    policy = dict(data.get("policy", {}))
    policy.setdefault("probe_inferred_interactions", True)
    states = [State(
        id=str(item["id"]), room=str(item["room"]).upper(), setup=_strings(item.get("setup", []), "state.setup"),
        expected_title=str(item["expected_title"]) if item.get("expected_title") else None,
        light=str(item.get("light", "unspecified")),
        inventory=[value.upper() for value in _strings(item.get("inventory", []), "state.inventory")],
        visible=[value.upper() for value in _strings(item.get("visible", []), "state.visible")],
        hidden=[value.upper() for value in _strings(item.get("hidden", []), "state.hidden")],
        open_subjects=[value.upper() for value in _strings(item.get("open", []), "state.open")],
        closed_subjects=[value.upper() for value in _strings(item.get("closed", []), "state.closed")],
    ) for item in data.get("states", [])]
    state_ids = [item.id for item in states]
    if len(state_ids) != len(set(state_ids)):
        raise ValueError("world truth state ids must be unique")
    if any(item.light not in {"lit", "dark", "unspecified"} for item in states):
        raise ValueError("state.light must be lit, dark, or unspecified")
    if any(set(item.visible) & set(item.hidden) for item in states):
        raise ValueError("a state cannot declare the same subject visible and hidden")
    if any(set(item.open_subjects) & set(item.closed_subjects) for item in states):
        raise ValueError("a state cannot declare the same subject open and closed")
    forbidden_prefixes = policy.get("forbidden_setup_prefixes", [])
    if not isinstance(forbidden_prefixes, list) or not all(isinstance(item, str) for item in forbidden_prefixes):
        raise ValueError("policy.forbidden_setup_prefixes must be an array of strings")
    for state in states:
        for command in state.setup:
            verb = command.strip().split(maxsplit=1)[0].lower() if command.strip() else ""
            if any(verb.startswith(prefix.lower()) for prefix in forbidden_prefixes):
                raise ValueError(f"state {state.id} uses forbidden setup verb {verb}")
    expectations = [Expectation(
        room=str(item["room"]).upper(), subject=str(item["subject"]).upper(),
        verbs=[verb.upper() for verb in _strings(item.get("verbs", []), "expectation.verbs")],
        rationale=str(item.get("rationale", "authored expectation")), state=str(item.get("state", "default")),
        required_response=_strings(item.get("required_response", ["recognized-specific"]), "expectation.required_response"),
        kind=str(item.get("kind", "object")),
        other_subject=str(item["other_subject"]).upper() if item.get("other_subject") else None,
        actor=str(item["actor"]).upper() if item.get("actor") else None,
        command_template=str(item["command_template"]).lower() if item.get("command_template") else None,
    ) for item in data.get("expectations", [])]
    if any(not item.verbs for item in expectations):
        raise ValueError("every world truth expectation needs at least one verb")
    allowed_kinds = {"object", "two-object", "conversation", "actor-command"}
    if any(item.kind not in allowed_kinds for item in expectations):
        raise ValueError(f"expectation.kind must be one of {sorted(allowed_kinds)}")
    if any(item.kind in {"two-object", "conversation"} and not item.other_subject for item in expectations):
        raise ValueError("two-object and conversation expectations require other_subject")
    if any(item.kind == "actor-command" and not item.actor for item in expectations):
        raise ValueError("actor-command expectations require actor")
    required_placeholders = {
        "two-object": {"{object}", "{other}"},
        "conversation": {"{object}", "{other}"},
        "actor-command": {"{actor}", "{object}"},
    }
    for item in expectations:
        required = required_placeholders.get(item.kind, {"{object}"})
        if item.command_template and not all(placeholder in item.command_template for placeholder in required):
            raise ValueError(f"{item.kind} command_template requires {sorted(required)}")
    ignores = [Ignore(
        code=str(item["code"]), room=str(item["room"]).upper() if item.get("room") else None,
        subject=str(item["subject"]).upper() if item.get("subject") else None,
        word=str(item["word"]).lower() if item.get("word") else None,
        rationale=str(item.get("rationale", "")),
    ) for item in data.get("ignores", [])]
    probe_rules = [ProbeRule(
        verbs=[value.upper() for value in _strings(item.get("verbs", []), "probe_rule.verbs")],
        allowed=_strings(item.get("allowed", []), "probe_rule.allowed"),
        flags_any=[value.upper() for value in _strings(item.get("flags_any", []), "probe_rule.flags_any")],
        kinds=_strings(item.get("kinds", []), "probe_rule.kinds"),
    ) for item in data.get("probe_rules", [])]
    if any(not item.verbs or not item.allowed for item in probe_rules):
        raise ValueError("every probe_rule needs verbs and allowed response classes")
    response_classes = {"recognized-specific", "recognized-generic", "subject-refusal", "generic-refusal", "not-visible", "unknown-word", "not-understood", "no-response"}
    configured_responses = [value for item in expectations for value in item.required_response] + [value for item in probe_rules for value in item.allowed]
    unknown_responses = sorted(set(configured_responses) - response_classes)
    if unknown_responses:
        raise ValueError(f"unknown probe response classes: {', '.join(unknown_responses)}")
    return TruthConfig(states, expectations, ignores, probe_rules, policy)
