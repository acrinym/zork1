"""Truth rules and sparse room/subject/interaction matrix construction."""

from __future__ import annotations

import hashlib
import json
from collections import Counter
from typing import Any

from .config import TruthConfig
from .model import Entity, Finding, Interaction, WorldModel
from .reach import auto_states


FLAG_AFFORDANCES: dict[str, set[str]] = {
    "ACTORBIT": {"EXAMINE", "HELLO", "LISTEN", "ASK", "TELL", "ATTACK"},
    "BURNBIT": {"EXAMINE", "BURN"},
    "CLIMBBIT": {"EXAMINE", "CLIMB"},
    "CONTBIT": {"EXAMINE", "OPEN", "CLOSE", "LOOK"},
    "DOORBIT": {"EXAMINE", "OPEN", "CLOSE", "ENTER"},
    "DRINKBIT": {"EXAMINE", "DRINK"},
    "FOODBIT": {"EXAMINE", "EAT"},
    "LIGHTBIT": {"EXAMINE", "LIGHT", "EXTINGUISH"},
    "FLAMEBIT": {"EXAMINE", "EXTINGUISH"},
    "ONBIT": {"EXAMINE", "EXTINGUISH"},
    "READBIT": {"EXAMINE", "READ"},
    "SURFACEBIT": {"EXAMINE", "LOOK", "PUT"},
    "TOOLBIT": {"EXAMINE"},
    "TAKEBIT": {"EXAMINE", "TAKE"},
    "TRYTAKEBIT": {"EXAMINE", "TAKE"},
    "TOUCHBIT": {"EXAMINE", "TOUCH"},
    "VEHBIT": {"EXAMINE", "BOARD", "DISEMBARK"},
    "WEAPONBIT": {"EXAMINE", "ATTACK"},
    "WEARBIT": {"EXAMINE", "WEAR"},
}

LEXICAL_AFFORDANCES: dict[str, set[str]] = {
    "DOOR": {"EXAMINE", "OPEN", "CLOSE", "ENTER"},
    "GATE": {"EXAMINE", "OPEN", "CLOSE", "ENTER"},
    "WINDOW": {"EXAMINE", "OPEN", "CLOSE", "ENTER"},
    "STAIR": {"EXAMINE", "CLIMB"},
    "STAIRS": {"EXAMINE", "CLIMB"},
    "STAIRWAY": {"EXAMINE", "CLIMB"},
    "LADDER": {"EXAMINE", "CLIMB"},
    "WATER": {"EXAMINE", "DRINK"},
    "FIRE": {"EXAMINE", "EXTINGUISH"},
    "FIREPLACE": {"EXAMINE", "ENTER"},
    "BUTTON": {"EXAMINE", "PUSH"},
    "LEVER": {"EXAMINE", "PULL", "PUSH"},
    "BOOK": {"EXAMINE", "READ"},
    "INSCRIPTION": {"EXAMINE", "READ"},
    "PATH": {"EXAMINE", "ENTER"},
    "PASSAGE": {"EXAMINE", "ENTER"},
    "PASSAGEWAY": {"EXAMINE", "ENTER"},
    "CRAWLWAY": {"EXAMINE", "ENTER"},
}

INTERNAL_OBJECTS = {"GLOBAL-OBJECTS", "LOCAL-GLOBALS", "ROOMS", "PSEUDO-OBJECT", "NOT-HERE-OBJECT", "INTNUM", "IT"}


def _finding(code: str, severity: str, room: str | None, subject: str | None, interaction: str | None, message: str, evidence: dict[str, Any]) -> Finding:
    semantic_keys = ("word", "raw_token", "target", "container", "action", "direction", "state", "other_subject", "actor", "synonyms")
    identity_evidence = {key: evidence[key] for key in semantic_keys if key in evidence}
    canonical = json.dumps({"code": code, "room": room, "subject": subject, "interaction": interaction, "identity": identity_evidence}, sort_keys=True, separators=(",", ":"))
    return Finding(code, severity, room, subject, interaction, message, evidence, hashlib.sha256(canonical.encode()).hexdigest()[:20])


def _room_members(model: WorldModel) -> dict[str, dict[str, str]]:
    by_id = {entity.id: entity for entity in model.entities}
    rooms = {entity.id for entity in model.entities if entity.kind == "room"}
    children: dict[str, set[str]] = {}
    for entity in model.entities:
        if entity.container:
            children.setdefault(entity.container, set()).add(entity.id)
    result: dict[str, dict[str, str]] = {}
    for room in rooms:
        members: dict[str, str] = {
            item: ("initially-hidden" if "INVISIBLE" in by_id[item].flags else "room-global")
            for item in by_id[room].globals if item in by_id
        }
        frontier = [(item, "direct") for item in children.get(room, set())]
        while frontier:
            current, scope = frontier.pop()
            if current in members:
                continue
            current_entity = by_id.get(current)
            if not current_entity:
                continue
            if "INVISIBLE" in current_entity.flags:
                scope = "initially-hidden"
            members[current] = scope
            contents_visible = scope not in {"contained-occluded", "initially-hidden"} and bool({"OPENBIT", "TRANSBIT", "SURFACEBIT"} & set(current_entity.flags))
            child_scope = "contained-visible" if contents_visible else "contained-occluded"
            frontier.extend((child, child_scope) for child in children.get(current, set()))
        result[room] = members
    return result


def _expected_verbs(entity: Entity, handled_verbs: set[str]) -> dict[str, list[str]]:
    bases: dict[str, list[str]] = {}
    for flag in entity.flags:
        for verb in FLAG_AFFORDANCES.get(flag, set()):
            bases.setdefault(verb, []).append(f"flag:{flag}")
    for word in entity.synonyms:
        for verb in LEXICAL_AFFORDANCES.get(word, set()):
            bases.setdefault(verb, []).append(f"noun:{word}")
    if entity.description:
        upper = entity.description.upper()
        for word, verbs in LEXICAL_AFFORDANCES.items():
            if word in upper.split():
                for verb in verbs:
                    bases.setdefault(verb, []).append(f"description:{word}")
    if entity.synonyms or entity.description:
        bases.setdefault("EXAMINE", []).append("described-parser-entity")
    for verb in handled_verbs:
        bases.setdefault(verb, []).append(f"explicit-action:{entity.action}")
    return bases


def _entity_word(entity: Entity | None, fallback: str) -> str:
    return (entity.synonyms[0] if entity and entity.synonyms else fallback).lower()


def _template_has_grammar(model: WorldModel, verb: str, template: str | None, kind: str) -> bool:
    if kind == "actor-command":
        return True
    rules = [rule for rule in model.grammar if rule.verb == verb]
    if template:
        wanted = template.lower().replace("{actor},", "{actor}").split()
        wanted_tail = wanted[1:]
        if kind in {"two-object", "conversation"}:
            return any(rule.indirect_object and rule.template[1:] == wanted_tail for rule in model.grammar)
    return any(rule.indirect_object if kind in {"two-object", "conversation"} else rule.direct_object for rule in rules)


def _ignored(config: TruthConfig, finding: Finding) -> bool:
    word = str(finding.evidence.get("word", "")).lower()
    for ignore in config.ignores:
        if ignore.code != finding.code:
            continue
        if ignore.room and ignore.room != finding.room:
            continue
        if ignore.subject and ignore.subject != finding.subject:
            continue
        if ignore.word and ignore.word != word:
            continue
        return True
    return False


def apply_baseline(findings: list[Finding], fingerprints: set[str]) -> None:
    for finding in findings:
        finding.baseline = finding.fingerprint in fingerprints


def audit_world(model: WorldModel, config: TruthConfig | None = None, baseline: set[str] | None = None) -> WorldModel:
    """Populate findings and expected interaction rows without hiding uncertainty."""
    config = config or TruthConfig()
    by_id = {entity.id: entity for entity in model.entities}
    routines = {routine.id: routine for routine in model.routines}
    grammar_verbs = {rule.verb for rule in model.grammar if rule.verb}
    room_members = _room_members(model)
    findings: list[Finding] = []
    interactions: list[Interaction] = []

    for duplicate in model.duplicate_entities:
        findings.append(_finding(
            "duplicate-entity-id", "warning", None, str(duplicate["id"]), None,
            f"{duplicate['id']} is defined more than once; compiler order selects the later definition.",
            {"previous": duplicate["previous"], "replacement": duplicate["replacement"]},
        ))

    for entity in model.entities:
        if entity.kind == "object" and entity.id not in INTERNAL_OBJECTS and entity.description and not entity.synonyms:
            findings.append(_finding("entity-without-noun", "error", entity.container if entity.container in room_members else None, entity.id, None, f"{entity.id} exists but declares no parser noun.", {"path": entity.location.path, "line": entity.location.line}))
        if entity.id not in INTERNAL_OBJECTS and entity.container and entity.container not in by_id and entity.container not in {"ROOMS", "LOCAL-GLOBALS", "GLOBAL-OBJECTS"}:
            findings.append(_finding("unknown-container", "error", None, entity.id, None, f"{entity.id} is contained by missing {entity.container}.", {"container": entity.container, "path": entity.location.path, "line": entity.location.line}))
        if entity.action and entity.action not in {"0", "FALSE"} and entity.action not in routines:
            findings.append(_finding("unknown-action-routine", "error", entity.id if entity.kind == "room" else None, entity.id, None, f"{entity.id} names missing action routine {entity.action}.", {"action": entity.action, "path": entity.location.path, "line": entity.location.line}))
        if entity.kind == "room":
            for direction, exit_ in entity.exits.items():
                target = exit_.get("target")
                if target and target not in by_id:
                    findings.append(_finding("unknown-exit-target", "error", entity.id, entity.id, direction, f"{entity.id} {direction} points to missing room {target}.", {"target": target, "direction": direction}))

    for rule in model.grammar:
        if rule.action and rule.action not in routines:
            findings.append(_finding("unknown-grammar-action", "error", None, None, rule.verb, f"Grammar verb {rule.verb} names missing routine {rule.action}.", {"action": rule.action, "path": rule.location.path, "line": rule.location.line}))

    for ref in model.prose_references:
        if ref.status == "candidate-unmapped":
            source_subject = None if ref.source_entity == ref.room else ref.source_entity
            findings.append(_finding("described-noun-unmapped", "candidate", ref.room, source_subject, "EXAMINE", f"The prose noun candidate '{ref.phrase}' has no visible parser entity in {ref.room}.", {"word": ref.word, "raw_token": ref.phrase, "match_key": ref.match_key, "part_of_speech": ref.part_of_speech, "source_entity": ref.source_entity, "path": ref.location.path, "line": ref.location.line}))

            adjacent_rooms = {
                str(exit_["target"])
                for exit_ in by_id[ref.room].exits.values()
                if exit_.get("target") in room_members
            }
            adjacent_matches = sorted({
                subject_id
                for adjacent in adjacent_rooms
                for subject_id in room_members[adjacent]
                if ref.match_key in {_normalize_alias(alias) for alias in by_id[subject_id].synonyms}
            })
            if adjacent_matches:
                findings.append(_finding(
                    "described-noun-adjacent-only", "warning", ref.room, source_subject, "EXAMINE",
                    f"'{ref.phrase}' is described in {ref.room}, but its only nearby parser subjects are in adjacent rooms.",
                    {"word": ref.word, "raw_token": ref.phrase, "adjacent_matches": adjacent_matches},
                ))
        elif ref.status == "mapped" and ref.mapped_entities:
            scopes = [room_members.get(ref.room, {}).get(entity_id) for entity_id in ref.mapped_entities]
            if all("INVISIBLE" in by_id[entity_id].flags for entity_id in ref.mapped_entities if entity_id in by_id):
                findings.append(_finding(
                    "described-noun-only-invisible", "warning", ref.room, None, "EXAMINE",
                    f"'{ref.phrase}' is described, but every matching subject begins INVISIBLE.",
                    {"word": ref.word, "raw_token": ref.phrase, "matches": ref.mapped_entities, "scopes": scopes},
                ))

    for room, members in sorted(room_members.items()):
        aliases: dict[str, list[str]] = {}
        for subject_id, visibility in members.items():
            if visibility in {"initially-hidden", "contained-occluded"}:
                continue
            for alias in by_id[subject_id].synonyms:
                aliases.setdefault(alias, []).append(subject_id)
        for alias, subjects in aliases.items():
            unique = sorted(set(subjects))
            if len(unique) > 1:
                findings.append(_finding(
                    "ambiguous-synonym-in-scope", "warning", room, None, None,
                    f"Parser noun {alias} names {len(unique)} simultaneously visible subjects.",
                    {"word": alias.lower(), "synonyms": unique},
                ))

    for room, members in sorted(room_members.items()):
        for subject_id in sorted(members):
            entity = by_id[subject_id]
            visibility = members[subject_id]
            handler = routines.get(entity.action or "")
            handled = set(handler.handled_verbs if handler else [])
            word = _entity_word(entity, entity.id)
            expected = _expected_verbs(entity, handled)
            for verb, basis in sorted(expected.items()):
                if verb in handled:
                    status = "explicit"
                elif verb in grammar_verbs:
                    matching = [rule for rule in model.grammar if rule.verb == verb and any(flag in entity.flags for flag in rule.constraints)]
                    status = "generic-afforded" if matching else "parser-recognized"
                else:
                    status = "expected-missing"
                kind = "conversation" if verb in {"ASK", "TELL"} and "ACTORBIT" in entity.flags else "object"
                interactions.append(Interaction(
                    room=room, subject=entity.id, word=word, verb=verb, kind=kind,
                    status=status, visibility=visibility, basis=sorted(set(basis)),
                ))
                if status == "expected-missing":
                    findings.append(_finding("expected-interaction-unparseable", "warning", room, entity.id, verb, f"{entity.id} implies {verb}, but the grammar has no {verb} route.", {"basis": basis, "word": word}))
                elif status == "parser-recognized" and verb != "EXAMINE":
                    findings.append(_finding("interaction-needs-runtime-proof", "candidate", room, entity.id, verb, f"{entity.id} implies {verb}; the parser accepts it but source analysis found no explicit handler or matching flag contract.", {"basis": basis, "word": word, "action": entity.action}))

    seen_prose: set[tuple[str, str]] = set()
    for ref in model.prose_references:
        if ref.status != "candidate-unmapped":
            continue
        key = (ref.room, ref.word.lower())
        if key in seen_prose:
            continue
        seen_prose.add(key)
        interactions.append(Interaction(
            room=ref.room, subject=f"PROSE:{ref.word.upper()}", word=ref.word.lower(), verb="EXAMINE",
            kind="object", status="described-unmapped", visibility="described",
            basis=["prose-unmapped"],
        ))

    for expectation in config.expectations:
        entity = by_id.get(expectation.subject)
        other = by_id.get(expectation.other_subject or "")
        actor = by_id.get(expectation.actor or "")
        word = _entity_word(entity, expectation.subject)
        handler = routines.get(entity.action or "") if entity else None
        for verb in expectation.verbs:
            grammar_accepts = _template_has_grammar(model, verb, expectation.command_template, expectation.kind)
            status = "explicit" if handler and verb in handler.handled_verbs else ("parser-recognized" if grammar_accepts else "expected-missing")
            visibility = room_members.get(expectation.room, {}).get(expectation.subject, "authored-state")
            interactions.append(Interaction(
                room=expectation.room, subject=expectation.subject, word=word, verb=verb,
                kind=expectation.kind, status=status, visibility=visibility,
                basis=[f"authored:{expectation.rationale}"],
                other_subject=expectation.other_subject,
                other_word=_entity_word(other, expectation.other_subject or "") if expectation.other_subject else None,
                actor=expectation.actor,
                actor_word=_entity_word(actor, expectation.actor or "") if expectation.actor else None,
                command_template=expectation.command_template, state=expectation.state,
            ))
            if not entity:
                findings.append(_finding("authored-subject-missing", "error", expectation.room, expectation.subject, verb, "An authored truth expectation names a missing subject.", {"rationale": expectation.rationale}))
            elif status == "expected-missing":
                findings.append(_finding("authored-interaction-unparseable", "error", expectation.room, expectation.subject, verb, "An authored truth expectation has no parser route.", {"rationale": expectation.rationale, "word": word}))
            if expectation.other_subject and not other:
                findings.append(_finding("authored-other-subject-missing", "error", expectation.room, expectation.subject, verb, "An authored two-subject expectation names a missing other subject.", {"other_subject": expectation.other_subject, "word": word}))
            if expectation.actor and not actor:
                findings.append(_finding("authored-actor-missing", "error", expectation.room, expectation.subject, verb, "An authored actor command names a missing actor.", {"actor": expectation.actor, "word": word}))
            state = next((item for item in config.states if item.id == expectation.state), None)
            if state and state.room != expectation.room:
                code = "pseudo-probe-wrong-room" if entity and entity.kind == "pseudo" else "state-room-mismatch"
                findings.append(_finding(code, "error", expectation.room, expectation.subject, verb, f"State {state.id} ends in {state.room}, not {expectation.room}.", {"state": state.id, "state_room": state.room, "word": word}))

    generic_examine = {response.strip().lower() for routine in model.routines if routine.id == "V-EXAMINE" for response in routine.responses if response.strip()}
    if generic_examine:
        for entity in model.entities:
            handler = routines.get(entity.action or "")
            responses = {response.strip().lower() for response in (handler.responses if handler else []) if response.strip()}
            if handler and "EXAMINE" in handler.handled_verbs and responses and responses.issubset(generic_examine):
                findings.append(_finding(
                    "handler-generic-examine-only", "candidate", entity.container if entity.container in room_members else None, entity.id, "EXAMINE",
                    f"{entity.id}'s EXAMINE handler contains only generic V-EXAMINE boilerplate.",
                    {"action": entity.action, "synonyms": sorted(entity.synonyms)},
                ))

    _, unreachable = auto_states(model, config)
    for room_id in unreachable:
        findings.append(_finding(
            "room-no-unconditional-route", "warning", room_id, None, None,
            f"{room_id} is not reachable from the start room along unconditional TO exits and has no authored state.",
            {"start_room": str(config.policy.get("start_room", "WEST-OF-HOUSE"))},
        ))

    model.interactions = interactions
    model.findings = [finding for finding in findings if not _ignored(config, finding)]
    apply_baseline(model.findings, baseline or set())
    return model


def _normalize_alias(word: str) -> str:
    lower = word.lower()
    if len(lower) > 4 and lower.endswith("ies"):
        return lower[:-3] + "y"
    if lower.endswith("ies"):
        return lower[:-1]
    if len(lower) > 4 and lower.endswith("es") and not lower.endswith("ses"):
        return lower[:-2]
    if len(lower) > 3 and lower.endswith("s") and not lower.endswith("ss"):
        return lower[:-1]
    return lower


def audit_summary(model: WorldModel) -> dict[str, Any]:
    return {
        "rooms": sum(entity.kind == "room" for entity in model.entities),
        "objects": sum(entity.kind == "object" for entity in model.entities),
        "pseudo_environment": sum(entity.kind == "pseudo" for entity in model.entities),
        "actors": sum("ACTORBIT" in entity.flags for entity in model.entities),
        "subjects": sum(entity.kind in {"object", "pseudo"} for entity in model.entities),
        "grammar_rules": len(model.grammar),
        "vocabulary_words": len({word for words in model.vocabulary.values() for word in words}),
        "prose_references": len(model.prose_references),
        "interaction_rows": len(model.interactions),
        "interaction_statuses": dict(sorted(Counter(item.status for item in model.interactions).items())),
        "interaction_kinds": dict(sorted(Counter(item.kind for item in model.interactions).items())),
        "findings": dict(sorted(Counter(item.severity for item in model.findings).items())),
        "new_findings": dict(sorted(Counter(item.severity for item in model.findings if not item.baseline).items())),
        "rooms_without_unconditional_route": sum(item.code == "room-no-unconditional-route" for item in model.findings),
    }
