"""Extract rooms, objects, grammar, routines, vocabulary, and prose references."""

from __future__ import annotations

import hashlib
import re
from pathlib import Path
from typing import Iterable

from tools.infocom_corpus.core import CorpusError, discover_zil_lineage

from .forms import Atom, Form, parse_forms, property_form, property_forms, walk_forms
from .model import Entity, GrammarRule, Location, ProseReference, Routine, WorldModel


DIRECTIONS = {
    "NORTH", "SOUTH", "EAST", "WEST", "NE", "NW", "SE", "SW", "UP", "DOWN",
    "IN", "OUT", "LAND", "CROSS", "ENTER", "EXIT",
}
PROPERTY_HEADS = {"IN", "DESC", "LDESC", "FDESC", "SYNONYM", "ADJECTIVE", "FLAGS", "ACTION", "GLOBAL"}
WORD_RE = re.compile(r"[A-Za-z][A-Za-z'-]*")
FUNCTION_WORDS = {
    "a", "an", "the", "this", "that", "these", "those", "and", "or", "but", "if", "then",
    "of", "to", "from", "with", "without", "in", "into", "inside", "on", "onto", "under",
    "over", "above", "below", "behind", "beside", "between", "through", "toward", "towards",
    "at", "by", "for", "as", "is", "are", "was", "were", "be", "been", "being", "has", "have",
    "had", "do", "does", "did", "can", "cannot", "could", "would", "should", "will", "may", "might",
    "must", "not", "no", "all", "any", "some", "each", "every", "other", "another", "here", "there",
    "where", "which", "who", "whom", "whose", "what", "when", "why", "how", "you", "your", "yours",
    "it", "its", "they", "their", "them", "he", "his", "him", "she", "her", "we", "our", "i", "my",
    "me", "up", "down", "north", "south", "east", "west", "enough", "very", "only", "still", "already",
}
COMMON_NON_NOUNS = {
    "standing", "facing", "leading", "rising", "running", "lying", "sitting", "open", "closed", "dark",
    "large", "small", "narrow", "wide", "huge", "massive", "old", "new", "white", "black", "red", "blue",
    "green", "yellow", "brown", "wooden", "stone", "rocky", "long", "short", "high", "low", "deep", "little",
}
COMMON_PROSE_VERBS = {
    "occupy", "occupies", "stand", "stands", "face", "faces", "lead", "leads", "rise", "rises",
    "run", "runs", "lie", "lies", "sit", "sits", "wind", "winds", "show", "shows", "mark", "marks",
    "contain", "contains", "cover", "covers", "fill", "fills", "reach", "reaches", "seem", "seems",
    "look", "looks", "appear", "appears", "remain", "remains", "become", "becomes", "deny", "denies",
}
DETERMINERS = {"a", "an", "the", "this", "that", "these", "those", "some", "any", "each", "every", "another"}
COMMON_PREPOSITIONS = {"of", "to", "from", "with", "without", "in", "into", "inside", "on", "onto", "under", "over", "above", "below", "behind", "beside", "between", "through", "toward", "towards", "at", "by", "for", "across"}


def _atoms_after_head(form: Form) -> list[str]:
    atoms = form.atoms()
    return atoms[1:] if atoms else []


def _first_string(form: Form | None) -> str | None:
    if not form:
        return None
    strings = form.strings()
    return strings[0] if strings else None


def _id(form: Form) -> str | None:
    atoms = form.atoms()
    return atoms[1] if len(atoms) > 1 else None


def _exit(form: Form) -> dict[str, object]:
    atoms = _atoms_after_head(form)
    target = None
    if "TO" in atoms:
        index = atoms.index("TO")
        target = atoms[index + 1] if index + 1 < len(atoms) else None
    strings = form.strings()
    return {"target": target, "condition": atoms, "message": strings[0] if strings else None}


def _entity(form: Form, relative: str) -> Entity | None:
    entity_id = _id(form)
    if not entity_id:
        return None
    props = {child.head: child for child in form.children() if child.delimiter == "paren" and child.head != "IN"}
    in_prop = property_form(form, "IN")
    in_atoms = _atoms_after_head(in_prop) if in_prop else []
    action_atoms = _atoms_after_head(props["ACTION"]) if "ACTION" in props else []
    descriptions: list[str] = []
    for prop in property_forms(form, {"LDESC", "FDESC"}):
        descriptions.extend(prop.strings())
    exits = {child.head: _exit(child) for child in form.children() if child.delimiter == "paren" and child.head in DIRECTIONS and child.head != "IN"}
    return Entity(
        id=entity_id,
        kind=form.head.lower(),
        container=in_atoms[0] if in_atoms else None,
        description=_first_string(props.get("DESC")),
        long_descriptions=descriptions,
        synonyms=_atoms_after_head(props["SYNONYM"]) if "SYNONYM" in props else [],
        adjectives=_atoms_after_head(props["ADJECTIVE"]) if "ADJECTIVE" in props else [],
        flags=_atoms_after_head(props["FLAGS"]) if "FLAGS" in props else [],
        action=action_atoms[0] if action_atoms else None,
        globals=_atoms_after_head(props["GLOBAL"]) if "GLOBAL" in props else [],
        exits=exits,
        location=Location(relative, form.line),
    )


def _pseudo_entities(form: Form, room_id: str, relative: str) -> list[Entity]:
    """Promote room PSEUDO vocabulary to first-class environmental subjects."""
    pseudo = property_form(form, "PSEUDO")
    if not pseudo:
        return []
    groups: dict[str, list[str]] = {}
    items = pseudo.items[1:]
    index = 0
    while index + 1 < len(items):
        word, routine = items[index], items[index + 1]
        index += 2
        if not isinstance(word, Atom) or word.kind != "string" or not isinstance(routine, Atom) or routine.kind != "atom":
            continue
        groups.setdefault(routine.value.upper(), []).append(word.value.upper())
    result: list[Entity] = []
    for routine, words in groups.items():
        result.append(Entity(
            id=f"{room_id}::PSEUDO::{routine}", kind="pseudo", container=room_id,
            description=words[0].lower(), long_descriptions=[], synonyms=sorted(set(words)), adjectives=[],
            flags=[], action=routine, globals=[], exits={}, location=Location(relative, pseudo.line),
        ))
    return result


def _syntax(form: Form, relative: str) -> GrammarRule:
    atoms = _atoms_after_head(form)
    eq = atoms.index("=") if "=" in atoms else len(atoms)
    command = atoms[:eq]
    tail = atoms[eq + 1:] if eq < len(atoms) else []
    words = [word for word in command if word != "OBJECT" and not word.startswith("(")]
    object_number = 0
    template: list[str] = []
    for token in command:
        if token == "OBJECT":
            object_number += 1
            template.append("{object}" if object_number == 1 else "{other}")
        else:
            template.append(token.lower())
    nested_atoms = [atom for child in form.children() for atom in child.atoms()]
    return GrammarRule(
        words=words,
        template=template,
        action=tail[0] if tail else None,
        pre_action=tail[1] if len(tail) > 1 else None,
        direct_object=command.count("OBJECT") >= 1,
        indirect_object=command.count("OBJECT") >= 2,
        constraints=sorted({item for item in [*command, *nested_atoms] if item.endswith("BIT") or item in {"HELD", "CARRIED", "HAVE", "MANY", "TAKE", "IN-ROOM", "ON-GROUND"}}),
        location=Location(relative, form.line),
    )


def _routine(form: Form, relative: str) -> Routine | None:
    routine_id = _id(form)
    if not routine_id:
        return None
    verbs: set[str] = set()
    responses: list[str] = []
    for nested in walk_forms(form.children()):
        if nested.head == "VERB?":
            verbs.update(_atoms_after_head(nested))
        if nested.head in {"EQUAL?", "==?", "=?", "MEMQ", "MEMBER?", "INTBL?"}:
            flattened = [
                atom.value.upper()
                for candidate in walk_forms([nested])
                for atom in candidate.items
                if isinstance(atom, Atom) and atom.kind == "atom"
            ]
            if any(atom.lstrip(",.") == "PRSA" for atom in flattened):
                verbs.update(atom.lstrip(",.")[2:] for atom in flattened if atom.lstrip(",.").startswith("V?"))
        if nested.head in {"TELL", "TELL-CR", "PRINT", "PRINTI", "DPRINT"}:
            responses.extend(nested.strings())
    return Routine(routine_id, sorted(verbs), responses, Location(relative, form.line))


def _normalize_word(word: str) -> str:
    lower = word.lower().strip("'-")
    if len(lower) > 4 and lower.endswith("ies"):
        return lower[:-3] + "y"
    if lower.endswith("ies"):
        return lower[:-1]
    if len(lower) > 4 and lower.endswith("es") and not lower.endswith("ses"):
        return lower[:-2]
    if len(lower) > 3 and lower.endswith("s") and not lower.endswith("ss"):
        return lower[:-1]
    return lower


def _accessible_by_room(entities: list[Entity]) -> dict[str, set[str]]:
    rooms = {entity.id for entity in entities if entity.kind == "room"}
    by_id = {entity.id: entity for entity in entities}
    result = {room: set() for room in rooms}
    children: dict[str, list[str]] = {}
    for entity in entities:
        if entity.container:
            children.setdefault(entity.container, []).append(entity.id)
    def add_tree(room: str, parent: str, seen: set[str]) -> None:
        for child in children.get(parent, []):
            if child in seen:
                continue
            seen.add(child)
            result[room].add(child)
            add_tree(room, child, seen)
    for room in rooms:
        add_tree(room, room, set())
        room_entity = by_id[room]
        result[room].update(item for item in room_entity.globals if item in by_id)
    return result


def _prose_references(entities: list[Entity], vocabulary: dict[str, list[str]]) -> list[ProseReference]:
    by_id = {entity.id: entity for entity in entities}
    accessible = _accessible_by_room(entities)
    refs: list[ProseReference] = []
    roles = {role: {word.lower() for word in vocabulary.get(role, [])} for role in vocabulary}
    for room_id, subject_ids in sorted(accessible.items()):
        room = by_id[room_id]
        aliases: dict[str, set[str]] = {}
        for subject_id in subject_ids:
            subject = by_id.get(subject_id)
            if not subject:
                continue
            words = subject.synonyms + [_normalize_word(part) for part in WORD_RE.findall(subject.description or "")]
            for word in words:
                aliases.setdefault(_normalize_word(word), set()).add(subject.id)
        sources = [(room, room.long_descriptions + ([room.description] if room.description else []))]
        sources.extend((by_id[subject_id], by_id[subject_id].long_descriptions) for subject_id in sorted(subject_ids))
        for source, texts in sources:
            for text in texts:
                raw_words = WORD_RE.findall(text)
                normalized_words = [_normalize_word(item) for item in raw_words]
                for index, raw in enumerate(raw_words):
                    word = raw.lower().strip("'-")
                    match_key = _normalize_word(raw)
                    mapped = sorted(aliases.get(match_key, set()))
                    previous = normalized_words[index - 1] if index else ""
                    two_back = normalized_words[index - 2] if index > 1 else ""
                    following = normalized_words[index + 1] if index + 1 < len(normalized_words) else ""
                    if mapped:
                        pos = "noun"
                    elif match_key in roles.get("adjectives", set()) or match_key in COMMON_NON_NOUNS:
                        pos = "adjective"
                    elif match_key in roles.get("verbs", set()) or match_key in COMMON_PROSE_VERBS:
                        pos = "verb"
                    elif match_key in roles.get("prepositions", set()) or match_key in COMMON_PREPOSITIONS:
                        pos = "preposition"
                    elif match_key in roles.get("directions", set()):
                        pos = "direction"
                    elif match_key in roles.get("buzz", set()) or match_key in FUNCTION_WORDS:
                        pos = "determiner" if match_key in DETERMINERS else "function-word"
                    elif match_key.endswith("ly"):
                        pos = "adverb"
                    elif match_key.endswith(("ing", "ed")):
                        pos = "verb-or-adjective"
                    elif previous in DETERMINERS or previous in roles.get("prepositions", set()) or previous in COMMON_PREPOSITIONS or previous in COMMON_NON_NOUNS or two_back in DETERMINERS or (raw.lower().endswith("s") and len(match_key) > 3):
                        pos = "noun-candidate"
                    elif following and word in roles.get("adjectives", set()):
                        pos = "adjective"
                    else:
                        pos = "unclassified-content"
                    status = "mapped" if mapped else ("candidate-unmapped" if pos == "noun-candidate" else "classified-nonreferent")
                    refs.append(ProseReference(
                        room=room_id, word=word, match_key=match_key, phrase=raw, part_of_speech=pos, mapped_entities=mapped,
                        status=status,
                        source_entity=source.id, location=source.location,
                    ))
    unique: dict[tuple[str, str, str], ProseReference] = {}
    for ref in refs:
        unique.setdefault((ref.room, ref.source_entity, ref.word), ref)
    return list(unique.values())


def extract_world(source_root: Path, entrypoint: str = "zork1.zil") -> WorldModel:
    """Extract a deterministic semantic model from an entrypoint's complete include lineage."""
    root = source_root.resolve()
    lineage = discover_zil_lineage(root, entrypoint)
    entities: list[Entity] = []
    grammar: list[GrammarRule] = []
    routines: list[Routine] = []
    aliases: dict[str, set[str]] = {}
    buzz: set[str] = set()
    source_files: list[dict[str, object]] = []
    duplicate_entities: list[dict[str, object]] = []
    entity_indexes: dict[str, int] = {}
    routine_indexes: dict[str, int] = {}
    for path in lineage:
        raw = path.read_bytes()
        relative = path.relative_to(root).as_posix()
        source_files.append({"path": relative, "sha256": hashlib.sha256(raw).hexdigest(), "bytes": len(raw)})
        text = raw.decode("utf-8", errors="strict")
        forms = parse_forms(text, path)
        for form in walk_forms(forms):
            if form.head in {"ROOM", "OBJECT"}:
                entity = _entity(form, relative)
                if entity:
                    if entity.id in entity_indexes:
                        previous = entities[entity_indexes[entity.id]]
                        duplicate_entities.append({
                            "id": entity.id,
                            "kind": entity.kind,
                            "previous": {"path": previous.location.path, "line": previous.location.line},
                            "replacement": {"path": entity.location.path, "line": entity.location.line},
                        })
                        entities[entity_indexes[entity.id]] = entity
                    else:
                        entity_indexes[entity.id] = len(entities)
                        entities.append(entity)
                    if form.head == "ROOM":
                        for pseudo in _pseudo_entities(form, entity.id, relative):
                            if pseudo.id in entity_indexes:
                                entities[entity_indexes[pseudo.id]] = pseudo
                            else:
                                entity_indexes[pseudo.id] = len(entities)
                                entities.append(pseudo)
            elif form.head == "ROUTINE":
                routine = _routine(form, relative)
                if routine:
                    if routine.id in routine_indexes:
                        routines[routine_indexes[routine.id]] = routine
                    else:
                        routine_indexes[routine.id] = len(routines)
                        routines.append(routine)
            elif form.head == "SYNTAX":
                grammar.append(_syntax(form, relative))
            elif form.head == "SYNONYM" and form.delimiter == "angle":
                words = _atoms_after_head(form)
                if words:
                    aliases.setdefault(words[0], set()).update(words[1:])
            elif form.head == "BUZZ":
                buzz.update(_atoms_after_head(form))
    verbs = {rule.verb for rule in grammar if rule.verb}
    for canonical, synonyms in aliases.items():
        if canonical in verbs:
            verbs.update(synonyms)
    noun_words = {word for entity in entities for word in entity.synonyms}
    adjective_words = {word for entity in entities for word in entity.adjectives}
    prepositions = {word for rule in grammar for word in rule.words[1:] if word not in verbs}
    vocabulary = {
        "verbs": sorted(verbs),
        "nouns": sorted(noun_words),
        "adjectives": sorted(adjective_words),
        "prepositions": sorted(prepositions),
        "buzz": sorted(buzz),
        "directions": sorted(DIRECTIONS),
    }
    model = WorldModel(str(root), entrypoint, source_files, entities, grammar, routines, vocabulary, duplicate_entities)
    model.prose_references = _prose_references(entities, vocabulary)
    return model
