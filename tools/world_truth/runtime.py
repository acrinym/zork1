"""Generate and execute isolated runtime probes against a command-line interpreter."""

from __future__ import annotations

import json
import re
import subprocess
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Any

from .config import State, TruthConfig
from .model import Interaction, WorldModel
from .reach import merged_states

DEFAULT_PROBE_STATUSES = {"explicit", "generic-afforded", "parser-recognized", "described-unmapped"}
PROSE_UNMAPPED_ALLOWED = ["recognized-specific", "not-visible", "unknown-word", "subject-refusal"]


RESPONSE_PATTERNS: list[tuple[str, re.Pattern[str]]] = [
    ("not-visible", re.compile(r"(?:can't|cannot) see (?:any|the)|not here", re.I)),
    ("unknown-word", re.compile(r"(?:don't|do not) know the word|not in (?:my|the) vocabulary", re.I)),
    ("not-understood", re.compile(r"(?:don't|do not) understand|sentence isn't one|parse", re.I)),
    ("generic-refusal", re.compile(r"(?:can't|cannot|won't|unable|nothing happens|not a verb|(?:is|are) boarded|boarded (?:up|shut)|fixed in place|already (?:open|closed))", re.I)),
]


@dataclass
class Probe:
    id: str
    state: str
    room: str
    subject: str
    verb: str
    kind: str
    word: str
    other_subject: str | None
    other_word: str | None
    actor: str | None
    actor_word: str | None
    subject_terms: list[str]
    setup: list[str]
    command: str
    expected_title: str | None
    allowed: list[str]
    basis: list[str]
    required_output: list[str]


@dataclass
class ProbeResult:
    probe: Probe
    response_class: str
    passed: bool
    output: str
    returncode: int


def _prompt_segment(output: str, command_number: int) -> str:
    normalized = output.replace("\r\n", "\n")
    prompt_segments = normalized.split(">")
    return prompt_segments[command_number] if len(prompt_segments) > command_number else normalized


def classify_response(output: str, command: str, subject_terms: list[str] | None = None, command_number: int = 1) -> str:
    normalized = output.replace("\r\n", "\n")
    response = _prompt_segment(normalized, command_number)
    if response == normalized:
        response = normalized.lower().rpartition(command.lower())[2] or normalized
    tail = response.lower()
    for label, pattern in RESPONSE_PATTERNS:
        if label == "generic-refusal":
            continue
        if pattern.search(tail):
            return label
    refusal = next(pattern for label, pattern in RESPONSE_PATTERNS if label == "generic-refusal")
    if refusal.search(tail):
        terms = [term.lower() for term in (subject_terms or []) if len(term) > 2]
        return "subject-refusal" if any(re.search(rf"\b{re.escape(term)}\b", tail) for term in terms) else "generic-refusal"
    if tail.strip():
        return "recognized-specific"
    return "no-response"


def _command_for(interaction: Interaction, model: WorldModel) -> str | None:
    if interaction.command_template:
        replacements = {
            "{object}": interaction.word,
            "{other}": interaction.other_word or "",
            "{actor}": interaction.actor_word or "",
        }
        command = interaction.command_template
        for placeholder, value in replacements.items():
            command = command.replace(placeholder, value)
        return command if "{" not in command and all(command.split()) else None
    if interaction.kind in {"two-object", "conversation"} and not interaction.other_word:
        return None
    if interaction.kind == "actor-command":
        return None
    rules = [
        rule for rule in model.grammar
        if rule.verb == interaction.verb
        and rule.direct_object
        and (rule.indirect_object == (interaction.kind in {"two-object", "conversation"}))
    ]
    if not rules:
        return None
    preferred_word = None
    if interaction.verb == "LOOK":
        preferred_word = "ON" if any("SURFACEBIT" in item for item in interaction.basis) else "IN"
    if preferred_word:
        preferred = [rule for rule in rules if preferred_word in rule.words]
        if preferred:
            rules = preferred
    rule = min(rules, key=lambda item: (len(item.template), item.template))
    return " ".join(
        interaction.word if token == "{object}" else (interaction.other_word or "") if token == "{other}" else token
        for token in rule.template
    )


def _states_for(interaction: Interaction, states: dict[str, State], states_by_room: dict[str, list[State]]) -> list[State]:
    if interaction.state != "default":
        state = states.get(interaction.state)
        return [state] if state and state.room == interaction.room else []
    return [item for item in states_by_room.get(interaction.room, []) if item.light != "dark"]


def _allowed_for(interaction: Interaction, model: WorldModel, config: TruthConfig, authored: dict[tuple[str, str, str, str], list[str]]) -> list[str]:
    key = (interaction.state, interaction.room, interaction.subject, interaction.verb)
    if key in authored:
        return authored[key]
    if interaction.status == "described-unmapped":
        return list(PROSE_UNMAPPED_ALLOWED)
    entity = next((item for item in model.entities if item.id == interaction.subject), None)
    flags = set(entity.flags if entity else [])
    for rule in config.probe_rules:
        if interaction.verb not in rule.verbs:
            continue
        if rule.kinds and interaction.kind not in rule.kinds:
            continue
        if rule.flags_any and not flags.intersection(rule.flags_any):
            continue
        return rule.allowed
    default = config.policy.get("probe_default_allowed", ["recognized-specific"])
    return [str(item) for item in default] if isinstance(default, list) else ["recognized-specific"]


def build_probes(model: WorldModel, config: TruthConfig, statuses: set[str] | None = None) -> list[Probe]:
    """Build probes for every reachable room: authored variants plus unconditional auto-reach."""
    statuses = statuses or set(DEFAULT_PROBE_STATUSES)
    state_list, _unreachable = merged_states(model, config)
    states = {state.id: state for state in state_list}
    states_by_room: dict[str, list[State]] = {}
    for item in state_list:
        states_by_room.setdefault(item.room, []).append(item)
    expected_allowed: dict[tuple[str, str, str, str], list[str]] = {}
    for item in config.expectations:
        for verb in item.verbs:
            expected_allowed[(item.state, item.room, item.subject, verb)] = item.required_response
    probes: list[Probe] = []
    receipt_path = Path(model.source_root) / "STAGING-RECEIPT.json"
    release_marker = None
    if receipt_path.is_file():
        receipt = json.loads(receipt_path.read_text(encoding="utf-8"))
        if isinstance(receipt.get("release"), int):
            release_marker = f"Release {receipt['release']}"
    seen: set[tuple[str, str, str, str]] = set()
    inferred = bool(config.policy.get("probe_inferred_interactions", True))
    for interaction in model.interactions:
        authored_interaction = bool(interaction.basis and interaction.basis[0].startswith("authored:"))
        if not authored_interaction and not inferred:
            continue
        if interaction.visibility in {"contained-occluded", "initially-hidden"} and not authored_interaction:
            continue
        if interaction.status not in statuses and not authored_interaction:
            continue
        command = _command_for(interaction, model)
        if not command:
            continue
        for state in _states_for(interaction, states, states_by_room):
            if interaction.subject in state.hidden:
                continue
            if state.light == "dark" and not authored_interaction:
                continue
            key = (state.id, interaction.room, interaction.subject, interaction.verb)
            if key in seen:
                continue
            seen.add(key)
            probes.append(Probe(
                id=f"{state.id}:{interaction.room}:{interaction.subject}:{interaction.verb}".lower(),
                state=state.id, room=interaction.room, subject=interaction.subject, verb=interaction.verb, kind=interaction.kind,
                word=interaction.word, other_subject=interaction.other_subject, other_word=interaction.other_word,
                actor=interaction.actor, actor_word=interaction.actor_word,
                subject_terms=sorted({interaction.word, *(_subject_terms(model, interaction.subject))}),
                setup=state.setup, command=command, expected_title=state.expected_title,
                allowed=_allowed_for(interaction, model, config, expected_allowed), basis=interaction.basis,
                required_output=[*([release_marker] if release_marker else []), *[str(item) for item in config.policy.get("runtime_required_output", [])]],
            ))
    return probes


def save_probe_plan(path: Path, probes: list[Probe]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps({"format_version": "1.0", "probes": [asdict(item) for item in probes]}, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def load_probe_plan(path: Path) -> list[Probe]:
    data = json.loads(path.read_text(encoding="utf-8"))
    if data.get("format_version") != "1.0" or not isinstance(data.get("probes"), list):
        raise ValueError("invalid probe plan")
    return [Probe(**item) for item in data["probes"]]


def run_probes(probes: list[Probe], interpreter: list[str], timeout: float = 30) -> list[ProbeResult]:
    """Run every probe from a fresh process so one interaction cannot contaminate another."""
    results: list[ProbeResult] = []
    for probe in probes:
        commands = [*probe.setup, probe.command, "quit", "yes"]
        try:
            completed = subprocess.run(interpreter, input="\n".join(commands) + "\n", text=True, capture_output=True, timeout=timeout, check=False)
            output = completed.stdout + completed.stderr
            response_class = classify_response(output, probe.command, probe.subject_terms, len(probe.setup) + 1)
            probe_segment = _prompt_segment(output, len(probe.setup) + 1)
            title_ok = not probe.expected_title or probe.expected_title.lower() in probe_segment.lower()
            required_ok = all(marker.lower() in output.lower() for marker in probe.required_output)
            passed = completed.returncode == 0 and response_class in probe.allowed and title_ok and required_ok
            results.append(ProbeResult(probe, response_class, passed, output, completed.returncode))
        except subprocess.TimeoutExpired as exc:
            stdout = exc.stdout.decode(errors="replace") if isinstance(exc.stdout, bytes) else (exc.stdout or "")
            stderr = exc.stderr.decode(errors="replace") if isinstance(exc.stderr, bytes) else (exc.stderr or "")
            output = stdout + stderr
            results.append(ProbeResult(probe, "timeout", False, output, -1))
    return results


def write_results(path: Path, results: list[ProbeResult], include_transcripts: bool = False) -> None:
    records: list[dict[str, Any]] = []
    for result in results:
        record = {"probe": asdict(result.probe), "response_class": result.response_class, "passed": result.passed, "returncode": result.returncode}
        if include_transcripts:
            record["output"] = result.output
        records.append(record)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps({"format_version": "1.0", "passed": all(item.passed for item in results), "results": records}, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def _subject_terms(model: WorldModel, subject_id: str) -> list[str]:
    entity = next((item for item in model.entities if item.id == subject_id), None)
    if not entity:
        return []
    description_words = re.findall(r"[A-Za-z][A-Za-z'-]*", entity.description or "")
    return [word.lower() for word in [*entity.synonyms, *description_words]]
