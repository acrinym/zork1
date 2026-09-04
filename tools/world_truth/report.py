"""Stable JSON and human-readable Markdown reports."""

from __future__ import annotations

import json
from collections import Counter, defaultdict
from pathlib import Path

from .audit import audit_summary
from .model import WorldModel


FINGERPRINT_VERSION = "semantic-v2"


def write_json(path: Path, model: WorldModel) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(model.to_dict(), indent=2, sort_keys=True) + "\n", encoding="utf-8")


def write_markdown(path: Path, model: WorldModel) -> None:
    summary = audit_summary(model)
    lines = [
        "# World Truth Audit",
        "",
        f"Source: `{model.source_root}/{model.entrypoint}`",
        "",
        "## Coverage",
        "",
        "| Dimension | Count |",
        "|---|---:|",
        f"| Rooms | {summary['rooms']} |",
        f"| Objects / entities | {summary['objects']} |",
        f"| Pseudo / environmental subjects | {summary['pseudo_environment']} |",
        f"| Actors | {summary['actors']} |",
        f"| Grammar rules | {summary['grammar_rules']} |",
        f"| Classified vocabulary | {summary['vocabulary_words']} |",
        f"| Prose references | {summary['prose_references']} |",
        f"| Expected interaction rows | {summary['interaction_rows']} |",
        f"| Rooms without unconditional route | {summary['rooms_without_unconditional_route']} |",
        "",
        "Interaction evidence: " + ", ".join(f"**{key}** {value}" for key, value in summary["interaction_statuses"].items()) + ".",
        "Interaction kinds: " + ", ".join(f"**{key}** {value}" for key, value in summary["interaction_kinds"].items()) + ".",
        "",
    ]
    prose_roles = Counter(item.part_of_speech for item in model.prose_references)
    lines.extend([
        "## English surface",
        "",
        "| Part of speech / lexical role | References |",
        "|---|---:|",
        *[f"| {role} | {count} |" for role, count in sorted(prose_roles.items())],
        "",
        f"Mapped noun references: **{sum(item.status == 'mapped' for item in model.prose_references)}**. Candidate unmapped noun references: **{sum(item.status == 'candidate-unmapped' for item in model.prose_references)}**.",
        "",
        "## World topology",
        "",
        "| Room | Exits | Audited subjects | Interaction rows |",
        "|---|---|---:|---:|",
    ])
    room_subjects: dict[str, set[str]] = defaultdict(set)
    room_interactions: Counter[str] = Counter()
    for interaction in model.interactions:
        room_subjects[interaction.room].add(interaction.subject)
        room_interactions[interaction.room] += 1
    for room in sorted((item for item in model.entities if item.kind == "room"), key=lambda item: item.id):
        exits = ", ".join(
            f"{direction}→{data.get('target') or 'response/routine'}"
            for direction, data in sorted(room.exits.items())
        ) or "—"
        lines.append(f"| `{room.id}` | {exits} | {len(room_subjects[room.id])} | {room_interactions[room.id]} |")
    lines.extend([
        "",
        "## Findings",
        "",
        "Findings are evidence candidates, not automatic design mandates. `candidate` means the source cannot settle the question; runtime or human authorship must.",
        "",
    ])
    grouped: dict[str, list] = defaultdict(list)
    for finding in model.findings:
        grouped[finding.severity].append(finding)
    for severity in ("error", "warning", "candidate", "info"):
        items = grouped.get(severity, [])
        lines.extend([f"### {severity.title()} ({len(items)})", ""])
        if not items:
            lines.extend(["None.", ""])
            continue
        lines.extend(["| Baseline | Code | Room | Subject | Interaction | Evidence |", "|---|---|---|---|---|---|"])
        for item in items:
            evidence = item.message.replace("|", "\\|").replace("\n", " ")
            lines.append(f"| {'known' if item.baseline else 'new'} | `{item.code}` | {item.room or ''} | {item.subject or ''} | {item.interaction or ''} | {evidence} |")
        lines.append("")
    lines.extend(["## Vocabulary", ""])
    for role, words in sorted(model.vocabulary.items()):
        preview = ", ".join(f"`{word.lower()}`" for word in words[:40])
        suffix = f" … (+{len(words) - 40})" if len(words) > 40 else ""
        lines.append(f"- {role}: {len(words)} — {preview}{suffix}")
    lines.append("")
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines), encoding="utf-8")


def baseline_payload(model: WorldModel) -> dict[str, object]:
    return {
        "format_version": "1.0",
        "fingerprint_version": FINGERPRINT_VERSION,
        "source": model.entrypoint,
        "fingerprints": sorted(finding.fingerprint for finding in model.findings),
    }


def load_baseline(path: Path | None) -> set[str]:
    if path is None or not path.exists():
        return set()
    data = json.loads(path.read_text(encoding="utf-8"))
    if data.get("format_version") != "1.0" or data.get("fingerprint_version") != FINGERPRINT_VERSION or not isinstance(data.get("fingerprints"), list):
        raise ValueError("invalid world truth baseline")
    return {str(item) for item in data["fingerprints"]}


def write_baseline(path: Path, model: WorldModel) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(baseline_payload(model), indent=2, sort_keys=True) + "\n", encoding="utf-8")
