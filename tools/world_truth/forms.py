"""Small lossless-enough ZIL form reader built on the corpus lexer."""

from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path
from typing import Iterator

from tools.infocom_corpus.core import CorpusError, Token, lex_zil


@dataclass
class Atom:
    value: str
    kind: str
    line: int


@dataclass
class Form:
    delimiter: str
    line: int
    items: list[Atom | "Form"] = field(default_factory=list)

    @property
    def head(self) -> str:
        for item in self.items:
            if isinstance(item, Atom):
                return item.value.upper() if item.kind == "atom" else ""
        return ""

    def atoms(self) -> list[str]:
        return [item.value.upper() for item in self.items if isinstance(item, Atom) and item.kind == "atom"]

    def strings(self) -> list[str]:
        return [item.value for item in self.items if isinstance(item, Atom) and item.kind == "string"]

    def children(self) -> list["Form"]:
        return [item for item in self.items if isinstance(item, Form)]


def parse_forms(text: str, path: Path | None = None) -> list[Form]:
    """Parse balanced angle/paren forms; tolerate recovery exactly as legacy source needs."""
    roots: list[Form] = []
    stack: list[Form] = []
    expected = {"close-angle": "angle", "close-paren": "paren"}
    opening = {"open-angle": "angle", "open-paren": "paren"}
    try:
        tokens = lex_zil(text)
        for token in tokens:
            if token.kind in opening:
                form = Form(opening[token.kind], token.line)
                if stack:
                    stack[-1].items.append(form)
                else:
                    roots.append(form)
                stack.append(form)
            elif token.kind in expected:
                wanted = expected[token.kind]
                if stack and stack[-1].delimiter == wanted:
                    stack.pop()
                else:
                    index = next((i for i in range(len(stack) - 1, -1, -1) if stack[i].delimiter == wanted), -1)
                    if index >= 0:
                        del stack[index:]
            elif token.kind in {"atom", "string"} and stack:
                stack[-1].items.append(Atom(token.value, token.kind, token.line))
    except CorpusError as exc:
        label = str(path) if path else "ZIL source"
        raise CorpusError(f"{label}: {exc}") from exc
    return roots


def walk_forms(forms: list[Form]) -> Iterator[Form]:
    for form in forms:
        yield form
        yield from walk_forms(form.children())


def property_form(entity: Form, name: str) -> Form | None:
    target = name.upper()
    return next((child for child in entity.children() if child.delimiter == "paren" and child.head == target), None)


def property_forms(entity: Form, names: set[str]) -> list[Form]:
    targets = {name.upper() for name in names}
    return [child for child in entity.children() if child.delimiter == "paren" and child.head in targets]
